Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A61E67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7912B89080;
	Sun,  3 Nov 2024 00:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="syivnOzE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YgNwXXPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7206C8908D; Sun,  3 Nov 2024 00:58:11 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3681988F50
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XgvnD6XB0z9scH;
 Sun,  3 Nov 2024 00:58:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730591888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+hmoDeqbRhL0xtcz3C1GD8D/d+G26FUR9GW9zoL6j/A=;
 b=syivnOzEs9r4k27GO88FyWlnwHYDB+W/71Gum7Y3mA05aKr/1n2ZWaP3w50uQ5vYldLiuF
 WhqaUQC//S0JulnfQkcK0XZQGDFNMTfh4Hi5oqygunp8LxgyzbdaeXHKM7AQ7aWA4OUs9r
 QRUwkc/k38uh6Qk+fXanceJD52wzikrxs96Y+mslYddieLqWi+YYqoIHskgRg9Gxe/0mwr
 i9zi5J+bjjuc48vtkaj95rU+6vmmHPGglXoHdbX3bGktt5PVJ0RNqaKJcUlnswYAG7VeO7
 VY227ztv/pDY35MHLR8opmBs98B+xb6UhjqfYdDXAjNj3X2sE4dm4PvI8rjmHg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730591887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+hmoDeqbRhL0xtcz3C1GD8D/d+G26FUR9GW9zoL6j/A=;
 b=YgNwXXPnwlPeHxSNUjYXA7iL2Z+T+0yQFtcMzjK3xWsLuxMSqC8uWA3/qoPhpxsaB9Z9xq
 Lic51BWh2oMk8aIstLxfnFaiAE02L4tNLIMV4nJa/Kw4gXxbp9JuQEBkSnzB6J47IS5iJh
 6NSaDNgPfqCnBUylSbktOptWvT2Jx7nz9Opod1VJzWT6vVxC9JBXBoO78xrV+lCJW+QvXC
 WbkvLhJxqKUXorPZSL//UJODUgt2vbPrXklkCZy7E8ZvXp6pyBgB6xglj9ovn+epB2pZBq
 YFrLdx8anMbmWtcOjfVDUTT+8D4LOixP3PtgwIG7GmaBEKNM/t3qDzDIjtrDTQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH] mtd: spi-nor: Fix integer overflow in stacked memories support
Date: Sun,  3 Nov 2024 00:57:31 +0100
Message-ID: <20241102235754.74661-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4jiqhpbhj7fe89opp14f1ftucjj7go98
X-MBO-RS-ID: 2d37b731f866393a7ef
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
adds new SPI bus flags, but also introduces a completely new set of
SPI bus flags in another location. The existing flags field is type
u8, while the new separate flags are BIT(8) and higher. Use of those
new flags triggers integer overflow.

Drop the newly introduced flags which were never used anywhere in the
code. Move the one remaining flag which was used in the correct place
and change it from BIT(8) to BIT(6) so it fits the u8 flags.

Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
Addresses-Coverity-ID: 510804 Extra high-order bits
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: William Zhang <william.zhang@broadcom.com>
---
Maybe we should revert the whole stacked patchset until it is fixed properly ?
---
 drivers/spi/zynq_qspi.c    | 2 +-
 drivers/spi/zynqmp_gqspi.c | 6 +++---
 include/spi.h              | 8 ++------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index 4aad3248d9e..e43dbb40c4a 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -813,7 +813,7 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 
 	priv->is_parallel = false;
 	priv->is_stacked = false;
-	slave->flags &= ~SPI_XFER_MASK;
+	slave->flags &= ~SPI_XFER_LOWER;
 	spi_release_bus(slave);
 
 	return 0;
diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index 1d19b2606c5..4251bf28cd3 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -870,8 +870,8 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	priv->bus = 0;
 
 	if (priv->is_parallel) {
-		if (slave->flags & SPI_XFER_MASK)
-			priv->bus = (slave->flags & SPI_XFER_MASK) >> 8;
+		if (slave->flags & SPI_XFER_LOWER)
+			priv->bus = 1;
 		if (zynqmp_qspi_update_stripe(op))
 			priv->stripe = 1;
 	}
@@ -890,7 +890,7 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	zynqmp_qspi_chipselect(priv, 0);
 
 	priv->is_parallel = false;
-	slave->flags &= ~SPI_XFER_MASK;
+	slave->flags &= ~SPI_XFER_LOWER;
 
 	return ret;
 }
diff --git a/include/spi.h b/include/spi.h
index 3a92d02f215..6944773b596 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -41,12 +41,6 @@
 #define SPI_3BYTE_MODE 0x0
 #define SPI_4BYTE_MODE 0x1
 
-/* SPI transfer flags */
-#define SPI_XFER_STRIPE	(1 << 6)
-#define SPI_XFER_MASK	(3 << 8)
-#define SPI_XFER_LOWER	(1 << 8)
-#define SPI_XFER_UPPER	(2 << 8)
-
 /* Max no. of CS supported per spi device */
 #define SPI_CS_CNT_MAX	2
 
@@ -169,6 +163,8 @@ struct spi_slave {
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
 #define SPI_XFER_U_PAGE		BIT(4)
 #define SPI_XFER_STACKED	BIT(5)
+#define SPI_XFER_LOWER		BIT(6)
+
 	/*
 	 * Flag indicating that the spi-controller has multi chip select
 	 * capability and can assert/de-assert more than one chip select
-- 
2.45.2

