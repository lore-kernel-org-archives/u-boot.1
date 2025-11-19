Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2135CF3186
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B737183DEB;
	Wed, 19 Nov 2025 10:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c5fxZZXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC79883E1B; Wed, 19 Nov 2025 06:14:20 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960448397D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Takahiro.Kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F02860204;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9E78C2BCB9;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763529256;
 bh=XYFmKqeclqPGK+Xa6mds5/8L7YIsCTJ2olGKvzXrWcE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=c5fxZZXxR6IjmslMuFkbggtcSqiqwwX/WGnCUd1iJf9vDjnCtRLixDpete9MfDniv
 1QPNnI27IGS35zCaVYVFOK6+srguhUMi071Bn1lE6wkteE71vnMxbDIoGt3rsOCm2K
 wc53eBRIyDdzq0I0rnVVhZQWmcaLarolambMRh9T1tLNOMJxqHTs0p1lZH+UX2azws
 LSPIoatkqKLEkKtPuknXWYFyHDIUUVYaHuNBiZK+05SO14kiyledN7iBb4F4qzQeqs
 YRvppFtU0SpB7B9y6lr6arXZZnfuXu8wi1mNN2x6S85OB5LbrTsidTPBWuSCfMbK6E
 rLn6hIh0lVsSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9E669CF256C;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+Takahiro.Kuwano.infineon.com@kernel.org>
Date: Wed, 19 Nov 2025 14:13:02 +0900
Subject: [PATCH 03/11] spi: zynqmp_gqspi: Read two bytes of SR and FSR in
 parallel mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-amd-cleanup-v1-3-c555bd85e6e4@infineon.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763529253; l=1977;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=dYJks90c0thR9+NvaZ3228TFTgjm4+W+446C0lC1WQE=;
 b=K/am5HAxodhVQKF+wDdFBFTsmz6j3rzmtkQUq4wF9UHn0o1g3xNDbzUvuwK2BtVznM3Ced1hY
 wD18qCIFYrnAAdBbQGJyTpUBqFj3IAfQGvnDS216yx7k63c/LucG90A
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
 drivers/spi/zynqmp_gqspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index 143b957516b..c6cd706574e 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -867,11 +867,23 @@ static bool zynqmp_qspi_update_stripe(const struct spi_mem_op *op)
 	}
 }
 
+static bool zynqmp_qspi_is_read_status(const struct spi_mem_op *op)
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
 static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 			       const struct spi_mem_op *op)
 {
 	struct zynqmp_qspi_priv *priv = dev_get_priv(slave->dev->parent);
 	int ret = 0;
+	u8 sr_buf[2];
 
 	priv->op = op;
 	priv->tx_buf = op->data.buf.out;
@@ -891,6 +903,10 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 			priv->bus = 1;
 		if (zynqmp_qspi_update_stripe(op))
 			priv->stripe = 1;
+		if (zynqmp_qspi_is_read_status(op)) {
+			priv->rx_buf = sr_buf;
+			priv->len = 2;
+		}
 	}
 
 	zynqmp_qspi_chipselect(priv, 1);
@@ -904,6 +920,9 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	else if (op->data.dir == SPI_MEM_DATA_OUT)
 		ret = zynqmp_qspi_genfifo_fill_tx(priv);
 
+	if (priv->is_parallel && zynqmp_qspi_is_read_status(op))
+		*(u8 *)op->data.buf.in = sr_buf[0] & sr_buf[1];
+
 	zynqmp_qspi_chipselect(priv, 0);
 
 	return ret;

-- 
2.34.1


