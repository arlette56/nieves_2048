class ResultadoFusion {
  final List<int?> fila;
  final int puntosGanados;
  ResultadoFusion(this.fila, this.puntosGanados);
}

class ResultadoMovimiento {
  final List<int?> fila;
  final int puntosGanados;
  final bool seMovio;
  ResultadoMovimiento(this.fila, this.puntosGanados, this.seMovio);
}

class Motor2048 {
  static List<int?> compactarFila(List<int?> fila) {
    final valores = fila.where((v) => v != null).toList();
    while (valores.length < fila.length) {
      valores.add(null);
    }
    return valores;
  }

  static ResultadoFusion fusionarFila(List<int?> filaCompactada) {
    final resultado = List<int?>.from(filaCompactada);
    var puntos = 0;
    
    for (var i = 0; i < resultado.length - 1; i++) {
      if (resultado[i] != null && resultado[i] == resultado[i + 1]) {
        resultado[i] = resultado[i]! * 2;
        puntos += resultado[i]!;
        resultado[i + 1] = null;
      }
    }
    return ResultadoFusion(resultado, puntos);
  }

  static ResultadoMovimiento moverFilaIzquierda(List<int?> filaOriginal) {
    // 1. Compactar
    final compactada = compactarFila(filaOriginal);
    // 2. Fusionar
    final fusion = fusionarFila(compactada);
    // 3. Compactar de nuevo por los huecos generados tras la fusión
    final filaFinal = compactarFila(fusion.fila);
    
    // 4. Determinar si hubo algún cambio respecto a la fila original
    var seMovio = false;
    for (var i = 0; i < filaOriginal.length; i++) {
      if (filaOriginal[i] != filaFinal[i]) seMovio = true;
    }
    
    return ResultadoMovimiento(filaFinal, fusion.puntosGanados, seMovio);
  }
}