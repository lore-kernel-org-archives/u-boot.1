Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FADCF3186
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E0E783E28;
	Wed, 19 Nov 2025 10:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rdH8cLh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D9783E1B; Wed, 19 Nov 2025 06:14:22 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CDA83D07
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Takahiro.Kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 76EBC600CB;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB440C2BCB6;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763529256;
 bh=TwoUXyv5sTKtC+tvi+SSSapmpePMlvda/86Ku7+66xc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=rdH8cLh3GpBB+s27AKbVxMBTa0s6UjT0r+6uf0tnq3GxXn26MUPhH7SZ980miaIYZ
 iENYm8s+Jz/xbBZ+SfoPYXv1ZqphBC1Ok2tnQYFE0RK3Gppkr1L7uqXGMMCEDi+KXJ
 27QqCjxkUPLeb/EaIOiICvdZgLxiaeg0D9+W5BaTsS2N9P3C2LTYrmwC1Z5EAOj2Ig
 7bBf7IfdBK8uTDLEAT29giFppUpHP13MjMENMHaqK73ohkm0cBgwVCX6s6E2lNGiHM
 hk9y9ilx8mE/pqNBIp156PFIaok8OJm00vM/MAqws3VeCN+0RjQ2CZZx7tYFcBUVZf
 vgDwgo50DkG+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B117ECF2585;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+Takahiro.Kuwano.infineon.com@kernel.org>
Date: Wed, 19 Nov 2025 14:13:03 +0900
Subject: [PATCH 04/11] spi: zynq-qspi: Set priv->is_parallel/stacked in
 child_pre_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-amd-cleanup-v1-4-c555bd85e6e4@infineon.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763529253; l=2137;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=AcN4YC1gFntwwrYIL2/OY5TYR2qJN2dBFjKE+vFyyx0=;
 b=nSdcPv6/MpckFvlZTkjPkJBwlkyU7yYrRYW1ZnCZhRlSqXRJadKKQZjPKonn3TYI9Ee6Bovf+
 o9AbmzDl+XEAmz1vmT+AnyJOLJnRchHj0Qz5upv6n4wFwqgoI8jLSi5
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

priv->is_paralle/stacked should be set at probe instead of at every
exec_op(). It can be set in child_pre_probe() by checking the existence
of parallel/stacked-memories property.

Also remove QSPI_SELECT_LOWER/UPPER_CS flags. They are problematic as
they overwrite SPI_XFER_BEGIN/END defined in spi.h.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/spi/zynq_qspi.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index e43dbb40c4a..a2d6d80d04e 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -46,9 +46,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define ZYNQ_QSPI_TXD_00_11_OFFSET	0x88	/* Transmit 3-byte inst */
 #define ZYNQ_QSPI_FR_QOUT_CODE		0x6B    /* read instruction code */
 
-#define QSPI_SELECT_LOWER_CS            BIT(0)
-#define QSPI_SELECT_UPPER_CS            BIT(1)
-
 /*
  * QSPI Linear Configuration Register
  *
@@ -205,6 +202,15 @@ static int zynq_qspi_child_pre_probe(struct udevice *bus)
 	priv->max_hz = slave->max_hz;
 	slave->multi_cs_cap = true;
 
+	/*
+	 * The properties have values that represent flash sizes but we just
+	 * need to know the existence of the property here.
+	 */
+	priv->is_parallel = ofnode_read_bool(dev_ofnode(bus),
+					     "parallel-memories");
+	priv->is_stacked = ofnode_read_bool(dev_ofnode(bus),
+					    "stacked-memories");
+
 	return 0;
 }
 
@@ -757,12 +763,6 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 	const u8 *tx_buf = NULL;
 	u8 *rx_buf = NULL;
 
-	if ((slave->flags & QSPI_SELECT_LOWER_CS) &&
-	    (slave->flags & QSPI_SELECT_UPPER_CS))
-		priv->is_parallel = true;
-	if (slave->flags & SPI_XFER_STACKED)
-		priv->is_stacked = true;
-
 	if (op->data.nbytes) {
 		if (op->data.dir == SPI_MEM_DATA_IN)
 			rx_buf = op->data.buf.in;
@@ -811,8 +811,6 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 			return ret;
 	}
 
-	priv->is_parallel = false;
-	priv->is_stacked = false;
 	slave->flags &= ~SPI_XFER_LOWER;
 	spi_release_bus(slave);
 

-- 
2.34.1


