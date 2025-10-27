Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3C9CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 391E383990;
	Mon, 27 Oct 2025 17:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hkVEcIEr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lBaAaseV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9868F83923; Mon, 27 Oct 2025 17:47:25 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F8883990
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwKDW0QfRz9tfF;
 Mon, 27 Oct 2025 17:47:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekcM3IfBwGAnbPWPCswBGU4pdFyXp0H2qEID2z2rYNI=;
 b=hkVEcIEr2ojKYHoHJNoZbYHeF46TZa/WMh60QxZhxMkO5pa5aR8xe7djunAWTS19Z984Mv
 NUxsief6m+ZMR+Oo+qY7oT65Nwo3wRT2/RhsNbay5A920L2EvyRF7zXl1If8VO0HX2VOtt
 ymJOZNc2BcJMn6kb38IAZk6TAQvK0W7kizq9qdbBPRE8+4ig7IBiijTwZ0oIWeTGfIbY6Z
 0zgvY/kWSkiUhSe3bzfjZw0BLy/DqdzTJtz7c9YC1VqXuarz9PnF1yE7oFFgMkaUuGh2Zt
 8DQibJlo73Vpao0XXg5iZmIz8yNC+i0qoqSHBZOY+Osz4YcQCgcVQoGKEzWDGg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lBaAaseV;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekcM3IfBwGAnbPWPCswBGU4pdFyXp0H2qEID2z2rYNI=;
 b=lBaAaseVsc/3mwvD78Y9g7MqosaWnpacZewKTK9YqAAYvO8C23N7MmebehcKk00vB/SwM4
 ARkG/EOFyVVF8tPDwBptDTV/SGdxQ2nzLr7V8f/R4oljWHjqFS58d0Lmf5OmniEOuL6WC+
 HAKY7oi7L+2Xi1plBZoqlyba9CBeEzMqSZ+0CSzDx1AYcWD6adVp0/KunID9k/4d19cEWD
 +/BmO1boV7o4kAu25D5JGrxV70BkUkDc7znDxfyi5zg62LM0fGIJ4W+q1VQQpLtJk3KI1A
 wqj+ckhFC9F4k6ezagHuZRbo2LsFMg14J4doFALdUU/MgMkNfXThlAgyRaaqjQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Phong Hoang <phong.hoang.wz@renesas.com>,
 Thanh Quan <thanh.quan.xn@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/12] net: rswitch: Add Renesas R-Car X5H Ethernet Switch3
 support
Date: Mon, 27 Oct 2025 17:45:42 +0100
Message-ID: <20251027164643.12443-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 76z4dwi1mdh851ujmfxtcjhitf475d74
X-MBO-RS-ID: bbd03aafe0e112cb70f
X-Rspamd-Queue-Id: 4cwKDW0QfRz9tfF
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

Add support for the Renesas Ethernet Switch3 (RSW3) controller,
present in R-Car Gen5 SoCs such as R-Car X5H (R8A78000). The
hardware offset differences are handled via driver match data.

The driver newly detects whether the switch prot is connected
to xPCS or not, and if so, turns on MIOC bit 3. This is new on
R-Car X5H. GWCKSC register is also programmed only on X5H. The
rest of the operation is identical to RSwitch2.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Tam Nguyen <tam.nguyen.xa@renesas.com>
Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
Signed-off-by: Thanh Quan <thanh.quan.xn@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/Kconfig   |  5 +++--
 drivers/net/rswitch.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c9b35b5a2ff..24b5da2b407 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -842,11 +842,12 @@ config GMAC_ROCKCHIP
 
 config RENESAS_ETHER_SWITCH
 	bool "Renesas Ethernet Switch support"
-	depends on DM_ETH && R8A779F0
+	depends on DM_ETH && (R8A779F0 || R8A78000)
 	select PHYLIB
 	help
 	  This driver implements support for the Renesas Ethernet Switch
-	  which is available on R-Car S4 SoC (r8a779f0).
+	  which is available on R-Car S4 SoC (R8A779F0) and newer version
+	  on R-Car X5H SoC (R8A78000).
 
 config RENESAS_RAVB
 	bool "Renesas Ethernet AVB MAC"
diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 54ecb95344f..801c22bbdc7 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Driver for Renesas Ethernet RSwitch2 (Ethernet-TSN).
+ * Driver for Renesas Ethernet RSwitch2 and RSwitch3 (Ethernet-TSN).
  *
- * Copyright (C) 2021 Renesas Electronics Corporation
+ * Copyright (C) 2021-2025 Renesas Electronics Corporation
  *
  * Based on the Renesas Ethernet AVB driver.
  */
@@ -47,6 +47,7 @@
 #define GWMS			0x0004
 #define GWMTIRM			0x0100
 #define GWVCC			0x0130
+#define GWCKSC			0x013c
 #define GWTTFC			0x0138
 #define GWDCBAC0		0x0194
 #define GWDCBAC1		0x0198
@@ -65,6 +66,7 @@
 /* List of RMAC registers (RMAC) */
 #define MPSM			0x1000
 #define MPIC			0x1004
+#define MIOC			0x1010
 #define MRMAC0			0x1084
 #define MRMAC1			0x1088
 #define MRAFC			0x108c
@@ -78,6 +80,9 @@
 #define MMIS0			0x1210
 #define MMIS1			0x1220
 
+/* MIOC */
+#define MIOC_BIT3_SET		BIT(3)
+
 /* COMA */
 #define RRC_RR			BIT(0)
 #define RCEC_RCE		BIT(16)
@@ -180,6 +185,7 @@ enum rswitch_gwca_mode {
 #define GWDCC(i)		(GWDCCR + (i) * 0x04)
 #define	GWDCC_DQT		BIT(11)
 #define GWDCC_BALR		BIT(24)
+#define GWCKSC_USMFSPE		BIT(31)
 
 struct rswitch_etha_io {
 	int			index;
@@ -192,6 +198,7 @@ struct rswitch_etha {
 	struct phy_device	*phydev;
 	struct mii_dev		*bus;
 	unsigned char		*enetaddr;
+	bool			xpcs;
 };
 
 struct rswitch_gwca {
@@ -282,6 +289,7 @@ struct rswitch_drv_data {
 	u8			fwpbfcsdc_offset;
 	u8			cabpirm_offset;
 	int			ports;
+	bool			is_rsw3;
 };
 
 static inline void rswitch_flush_dcache(u32 addr, u32 len)
@@ -764,6 +772,10 @@ static int rswitch_gwca_init(struct rswitch_port_priv *priv)
 	writel(GWDCC_DQT | GWDCC_BALR, gwca->addr + GWDCC(RSWITCH_TX_CHAIN_INDEX));
 	writel(GWDCC_BALR, gwca->addr + GWDCC(RSWITCH_RX_CHAIN_INDEX));
 
+	/* Enable Under Switch Minimum Frame Size Padding */
+	if (priv->drv_data->is_rsw3)
+		writel(GWCKSC_USMFSPE, gwca->addr + GWCKSC);
+
 	ret = rswitch_gwca_change_mode(priv, GWMC_OPC_DISABLE);
 	if (ret)
 		return ret;
@@ -813,6 +825,13 @@ static int rswitch_etha_init(struct rswitch_port_priv *priv)
 
 	rswitch_rmac_init(etha);
 
+	if (etha->xpcs) {
+		if (etha_serdes->index >= 5 && etha_serdes->index <= 7)
+			writel(MIOC_BIT3_SET, etha_serdes->addr + MIOC);
+		else
+			printf("RSW: Invalid port %d\n", etha_serdes->index);
+	}
+
 	ret = rswitch_etha_change_mode(priv, etha_serdes, EAMC_OPC_OPERATION);
 	if (ret)
 		return ret;
@@ -1037,6 +1056,11 @@ static int rswitch_port_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (priv->drv_data->is_rsw3) {
+		etha->xpcs = device_is_compatible(priv->serdes.dev,
+						  "renesas,r8a78000-ether-pcs");
+	}
+
 	etha->enetaddr = pdata->enetaddr;
 
 	etha->mii.index = dev_read_u32_default(dev, "reg", 0);
@@ -1207,8 +1231,22 @@ static const struct rswitch_drv_data r8a779f0_drv_data = {
 	.cabpirm_offset	= 0x0,
 };
 
+static const struct rswitch_drv_data r8a78000_drv_data = {
+	.ports		= 13,
+	.coma_offset	= 0x1c000,
+	.etha_offset	= 0x1d000,
+	.gwca_offset	= 0x37000,
+	.mpid_mdc_clk	= 0x060c0000,
+	.etha_incr	= 0x20,
+	.gwdcbac_offset	= 0x50,
+	.fwpbfcsdc_offset = 0xfc,
+	.cabpirm_offset	= 0x20,
+	.is_rsw3	= true,
+};
+
 static const struct udevice_id rswitch_ids[] = {
 	{ .compatible = "renesas,r8a779f0-ether-switch", .data = (ulong)&r8a779f0_drv_data },
+	{ .compatible = "renesas,r8a78000-ether-switch3", .data = (ulong)&r8a78000_drv_data },
 	{ }
 };
 
-- 
2.51.0

