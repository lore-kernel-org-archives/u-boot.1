Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C0C35FF1
	for <u-boot@archiver.kernel.org>; Sun, 16 Mar 2025 13:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E0E88198F;
	Sun, 16 Mar 2025 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mpDR8KJb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nuyL150u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD5681A02; Sun, 16 Mar 2025 14:54:51 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241F88141E
 for <u-boot@lists.denx.de>; Sun, 16 Mar 2025 14:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZG03D66dgz9sjR;
 Sun, 16 Mar 2025 14:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzub3QcOc4fEVRMhpcavCyOkpsbBHQNifaZoKFnrM1g=;
 b=mpDR8KJbM2FhZCPfZMsrD0DeRCALfMKFxLWZsZIcJpAUx+4p0wZXu1qk0qSC5yifb8xwkf
 4OJJL656T21LN92E3P1xSz9GMSz0IdfprOPdi7oUtTcexKgxLmJkEXnPCWyP8K5yyj43jM
 sXNXYeTFK6etXiAZo432+hRXljWg0rgaR9OFh2qPeLi216aJdxq4E2vG87aMso6bM6va0L
 OKqyFl8ZNu+QwCAAq4ymKn8w1YQ9cAcKRTPlSEoTFy4E4cvkGaNm1rStDffBKM6iBy3Ef1
 N0hBQaPRS+6QERv6GIqZ6S0ggZvv8OLaNf+lBQDBzDfjzEhu83RjAQeKeHoMMw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742133286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzub3QcOc4fEVRMhpcavCyOkpsbBHQNifaZoKFnrM1g=;
 b=nuyL150uG0xUPVgTSnkaEFhEQt7UdhOiTAcVobll/960jI7W0VNCKOgmBI3tFMbViGYRDK
 O7W5XtBH44MzqCktbf7CzJFBXvjMmOyWLrpVIEG1cv+pze6hyljS6DRri7hxbTv0bzb1EE
 FubIiLYaGXtLe04NqaIBKJgY0qIkYat7yX/urHvvqs8DIwDOaYZF2N4WXWLGHDs85ssirP
 Z5FYATT44tr8EfaiLTuhF4+wMzhxSsQ3Or0wRFlSP5y9SNsx+t12CMLr7aYToKZkVHgNFo
 MwwUEHVlr7QEOZI5ufka0R0gPcfBpJjVwIkJsjoZaIrwxMXiaqPpKpAGkYKwsQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/7] ram: renesas: dbsc5: Add V4H-3/V4H-5/V4H-7 OTP based
 detection
Date: Sun, 16 Mar 2025 14:51:43 +0100
Message-ID: <20250316135417.7909-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
References: <20250316135417.7909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d5a68b3de09e0276615
X-MBO-RS-META: jg5nwn7arofeoqk75b1ux8cjygyj53x5
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

Add auto-detection and handling of Renesas R-Car V4H-3 and V4H-5
in addition to V4H-7 SoC variants based on OTP fuse programming.
The V4H-3 and V4H-5 variants have reduced DRAM frequency options.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dbsc5.c |  3 +-
 drivers/ram/renesas/dbsc5/dbsc5.h |  1 +
 drivers/ram/renesas/dbsc5/dram.c  | 48 ++++++++++++++++++++-----------
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dbsc5.c b/drivers/ram/renesas/dbsc5/dbsc5.c
index d24b7c5c30a..4cbc6aeda43 100644
--- a/drivers/ram/renesas/dbsc5/dbsc5.c
+++ b/drivers/ram/renesas/dbsc5/dbsc5.c
@@ -59,7 +59,8 @@ int renesas_dbsc5_bind(struct udevice *dev)
 
 struct renesas_dbsc5_data r8a779g0_dbsc5_data = {
 	.clock_node = "renesas,r8a779g0-cpg-mssr",
-	.reset_node = "renesas,r8a779g0-rst"
+	.reset_node = "renesas,r8a779g0-rst",
+	.otp_node = "renesas,r8a779g0-otp",
 };
 
 static const struct udevice_id renesas_dbsc5_ids[] = {
diff --git a/drivers/ram/renesas/dbsc5/dbsc5.h b/drivers/ram/renesas/dbsc5/dbsc5.h
index c410eb0c5ed..bf22fcb8c11 100644
--- a/drivers/ram/renesas/dbsc5/dbsc5.h
+++ b/drivers/ram/renesas/dbsc5/dbsc5.h
@@ -23,6 +23,7 @@
 struct renesas_dbsc5_data {
 	const char		*clock_node;
 	const char		*reset_node;
+	const char		*otp_node;
 };
 
 #endif /* __DRIVERS_RAM_RENESAS_DBSC5_DBSC5_H__ */
diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index 1b70faff7f7..c5c57858aac 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -4364,16 +4364,20 @@ static int renesas_dbsc5_dram_probe(struct udevice *dev)
 {
 #define RST_MODEMR0			0x0
 #define RST_MODEMR1			0x4
+#define OTP_MONITOR17			0x1144
 	struct renesas_dbsc5_data *data = (struct renesas_dbsc5_data *)dev_get_driver_data(dev);
 	ofnode cnode = ofnode_by_compatible(ofnode_null(), data->clock_node);
 	ofnode rnode = ofnode_by_compatible(ofnode_null(), data->reset_node);
+	ofnode onode = ofnode_by_compatible(ofnode_null(), data->otp_node);
 	struct renesas_dbsc5_dram_priv *priv = dev_get_priv(dev);
 	void __iomem *regs_dbsc_a = priv->regs + DBSC5_DBSC_A_OFFSET;
 	void __iomem *regs_dbsc_d = priv->regs + DBSC5_DBSC_D_OFFSET;
 	phys_addr_t rregs = ofnode_get_addr(rnode);
 	const u32 modemr0 = readl(rregs + RST_MODEMR0);
 	const u32 modemr1 = readl(rregs + RST_MODEMR1);
-	u32 breg, reg, md, sscg;
+	phys_addr_t oregs = ofnode_get_addr(onode);
+	const u32 otpmon17 = readl(oregs + OTP_MONITOR17);
+	u32 breg, reg, md, sscg, product;
 	u32 ch, cs;
 
 	/* Get board data */
@@ -4428,29 +4432,41 @@ static int renesas_dbsc5_dram_probe(struct udevice *dev)
 
 	/* Decode DDR operating frequency from MD[37:36,19,17] pins */
 	md = ((modemr0 & BIT(19)) >> 18) | ((modemr0 & BIT(17)) >> 17);
+	product = otpmon17 & 0xff;
 	sscg = (modemr1 >> 4) & 0x03;
 	if (sscg == 2) {
 		printf("MD[37:36] setting 0x%x not supported!", sscg);
 		hang();
 	}
 
-	if (md == 0) {
-		if (sscg == 0) {
-			priv->ddr_mbps = 6400;
-			priv->ddr_mbpsdiv = 1;
-		} else {
-			priv->ddr_mbps = 19000;
-			priv->ddr_mbpsdiv = 3;
-		}
-	} else if (md == 1) {
-		priv->ddr_mbps = 6000;
-		priv->ddr_mbpsdiv = 1;
-	} else if (md == 2) {
-		priv->ddr_mbps = 5500;
-		priv->ddr_mbpsdiv = 1;
-	} else if (md == 3) {
+	if (product == 0x2) {			/* V4H-3 */
 		priv->ddr_mbps = 4800;
 		priv->ddr_mbpsdiv = 1;
+	} else if (product == 0x1) {		/* V4H-5 */
+		if (md == 3)
+			priv->ddr_mbps = 4800;
+		else
+			priv->ddr_mbps = 5000;
+		priv->ddr_mbpsdiv = 1;
+	} else {				/* V4H-7 */
+		if (md == 0) {
+			if (sscg == 0) {
+				priv->ddr_mbps = 6400;
+				priv->ddr_mbpsdiv = 1;
+			} else {
+				priv->ddr_mbps = 19000;
+				priv->ddr_mbpsdiv = 3;
+			}
+		} else if (md == 1) {
+			priv->ddr_mbps = 6000;
+			priv->ddr_mbpsdiv = 1;
+		} else if (md == 2) {
+			priv->ddr_mbps = 5500;
+			priv->ddr_mbpsdiv = 1;
+		} else if (md == 3) {
+			priv->ddr_mbps = 4800;
+			priv->ddr_mbpsdiv = 1;
+		}
 	}
 
 	priv->ddr_mul = CLK_DIV(priv->ddr_mbps, priv->ddr_mbpsdiv * 2,
-- 
2.47.2

