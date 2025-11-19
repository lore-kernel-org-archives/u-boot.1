Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57615CF3186
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8718483E8E;
	Wed, 19 Nov 2025 10:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fhGLvnSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF2DA83DA6; Wed, 19 Nov 2025 06:14:23 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81F783A8C
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Takahiro.Kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C81860208;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D489C2BCC6;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763529256;
 bh=V4UXa+RM2OzytiMJo6ob0WilJ3Z4xf2LUoWo+rhTnFM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=fhGLvnSvD9ryHdKJb2irtwNDenYImezrqG/S6SABTjBUkEENU8FQ0gq9xiDPXrmoP
 W8ppFoC8TtIedjEloqz8RdU9U51G0a5f0XpjHO1F5xvYCoxFX3zwCXyQKXp0ObD3I/
 4ZRF8b+c8RllwWJtHi3PAWOV5ZRq8tAMSXRnerbmNW0AlDAzXSfZPzD3R/YQl/2Qcn
 UJfSehV1xdSEfNB6Cw5QkPa/WW+LaqCcOPNlDof8hbmbD1TgufO6/Uswa9fd2zm4RQ
 +nS/ssXvDQ0njG9HfMafV9JOn6ucRYrb0F1jQtFqgkyhalGFYGPi3bK4dGH0BxIaEp
 QJjaQGQxGv8dA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D3BBECF2588;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+Takahiro.Kuwano.infineon.com@kernel.org>
Date: Wed, 19 Nov 2025 14:13:05 +0900
Subject: [PATCH 06/11] spi: zynq_qspi: Read two bytes of SR and FSR in
 parallel mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-amd-cleanup-v1-6-c555bd85e6e4@infineon.com>
References: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
In-Reply-To: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
To: u-boot@lists.denx.de, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Vignesh R <vigneshr@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Havish Mutya <havish.mutya@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Daassi Bacem <Bacem.Daassi@infineon.com>, 
 Shinsuke Okada <Shinsuke.Okada@infineon.com>, 
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>, 
 Takahiro Kuwano <tkuw584924@gmail.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763529253; l=2092;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=WjL7JrYA8pMbQNnx2ziFd7r5iasN8w1r6c7vFE5QK50=;
 b=fWtCGx+JijA2nBj/f5CBHr3JMfO2fyWre60j85z1J7AUA/hhml+gDQTcAUaHcIbUP0rYZayGz
 plRw65feVcfBpzgkMbUf5h1F0N30o99vtkY0y+Q+p8zqR9h/9syi44q
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for Takahiro.Kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: Takahiro.Kuwano@infineon.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

In parallel mode, status register value of two chips need to be read
and evaluated. Currenlty spi-nor-core takes care for that by reading
two bytes and performing logical AND of two bytes for read_sr() and
read_fsr(), assuming the controller performs byte interleaving in
parallel mode, but it depends on controller specification.

Controller driver should take care for parallel mode to read status
registers.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/spi/zynq_qspi.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index 67005a3b8df..3d9fc11314f 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -753,6 +753,17 @@ static bool update_stripe(const struct spi_mem_op *op)
 	return true;
 }
 
+static bool zynq_qspi_is_read_status(const struct spi_mem_op *op)
+{
+	switch (op->cmd.opcode) {
+	case SPINOR_OP_RDSR:
+	case SPINOR_OP_RDFSR:
+		return true;
+	}
+
+	return false;
+}
+
 static int zynq_qspi_exec_op(struct spi_slave *slave,
 			     const struct spi_mem_op *op)
 {
@@ -762,6 +773,7 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 	unsigned int flag = 0;
 	const u8 *tx_buf = NULL;
 	u8 *rx_buf = NULL;
+	u8 sr_buf[2];
 
 	if (op->data.nbytes) {
 		if (op->data.dir == SPI_MEM_DATA_IN)
@@ -805,10 +817,20 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 
 	/* 2nd transfer: rx or tx data path */
 	if (tx_buf || rx_buf) {
-		ret = zynq_qspi_xfer(slave->dev, op->data.nbytes * 8, tx_buf,
-				     rx_buf, flag | SPI_XFER_END);
+		op_len = op->data.nbytes;
+
+		if (priv->is_parallel && zynq_qspi_is_read_status(op)) {
+			rx_buf = sr_buf;
+			op_len = 2;
+		}
+
+		ret = zynq_qspi_xfer(slave->dev, op_len * 8, tx_buf, rx_buf,
+				     flag | SPI_XFER_END);
 		if (ret)
 			return ret;
+
+		if (priv->is_parallel && zynq_qspi_is_read_status(op))
+			*(u8 *)op->data.buf.in = sr_buf[0] & sr_buf[1];
 	}
 
 	spi_release_bus(slave);

-- 
2.34.1


