Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E073C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 12:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB4F280B9F;
	Sun,  9 Feb 2025 13:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IuWNfrUL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fFoBp0j4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3308B80AE5; Sun,  9 Feb 2025 13:04:55 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16DCA80944
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 13:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YrRGX5Syzz9tDb;
 Sun,  9 Feb 2025 13:04:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2GhXPUAs1aT6lczmjOyD8og9LVHX3xCgtm/55Ek7wck=;
 b=IuWNfrULImtWnVS28pNRP85wUTF66+q5n9z/XoLhrVmbdTlJojxGXcMboSt8k+MY5reDK6
 H9+OxcWU993JMD4A/VAOlCcnllXN2JbRgfO6NCgQ4eUCJG+OBmqXUkPuhj6XiVkojJ/AR/
 jcztX0S/GRJGPIi34ozb2eIbe+RcQdlODCYdg/1LxDyEY3rUqECu5bw2vYwiu+wp3osdGP
 +WE23MOm7AlXrZbdvdauLWWQSmd9QJihV36NqssQO1CaSVTOmkBaN6hQ9BdRn2fqNKDjTD
 YOk/S8BFifZGG5QpJkBDtEaa9OWguDRGn9WIZdPMSYnjWht9EFDVCemUOlBl8g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1739102690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2GhXPUAs1aT6lczmjOyD8og9LVHX3xCgtm/55Ek7wck=;
 b=fFoBp0j4reYyJRax6vJdI4mSuNa9yG8IVmUtfWzJIEq+bMKD3qN36l8WopjBsYVsBYTiXQ
 We1dHFN9MIZnVTT16LVnPKUaJeME44ctcD5BBSpXfpumlzt5ce+wsVcRl1wvtulI4FZnY7
 dfYucHvm4mwHYGq3qQrnz2VSGaQJ0xYXM8IqBhcNauD4WTlQsZUZMGwhnkF8nfMygJiqC5
 MmJnpBKEXA0OxsDYmM89dhcis70nA5lVJrSp4Z+mIuPeRJZsCpxRECnm8j+YRqKZ6EsiCB
 T7HvnzqZc4yre1Q/i89v1GF1rEtE7UCsbDaF8nIL+FzVNiENshYowHMTNNw6xA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/24] net: designware: Reorder bb_miiphy functions
Date: Sun,  9 Feb 2025 13:01:33 +0100
Message-ID: <20250209120403.5321-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
References: <20250209120403.5321-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 69a537fb28d88131f9f
X-MBO-RS-META: 5zfe4uc4z888iuiytjwm1a8raotcfbgb
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

Move the bb_miiphy functions before MDIO registration. This is a
preparatory patch, the functions will be referenced around the MDIO
registration in the follow up patches. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: New patch
---
 drivers/net/designware.c | 158 +++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 79 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 90ce3ebc80c..d6a5f5cc71c 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -223,6 +223,85 @@ static int dw_dm_mdio_init(const char *name, void *priv)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
+static int dw_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
+{
+	struct dw_eth_dev *priv = bus->priv;
+	struct gpio_desc *desc = &priv->mdio_gpio;
+
+	desc->flags = 0;
+	dm_gpio_set_dir_flags(&priv->mdio_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+
+	return 0;
+}
+
+static int dw_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+{
+	struct dw_eth_dev *priv = bus->priv;
+	struct gpio_desc *desc = &priv->mdio_gpio;
+
+	desc->flags = 0;
+	dm_gpio_set_dir_flags(&priv->mdio_gpio, GPIOD_IS_IN);
+
+	return 0;
+}
+
+static int dw_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	if (v)
+		dm_gpio_set_value(&priv->mdio_gpio, 1);
+	else
+		dm_gpio_set_value(&priv->mdio_gpio, 0);
+
+	return 0;
+}
+
+static int dw_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	*v = dm_gpio_get_value(&priv->mdio_gpio);
+
+	return 0;
+}
+
+static int dw_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	if (v)
+		dm_gpio_set_value(&priv->mdc_gpio, 1);
+	else
+		dm_gpio_set_value(&priv->mdc_gpio, 0);
+
+	return 0;
+}
+
+static int dw_eth_bb_delay(struct bb_miiphy_bus *bus)
+{
+	struct dw_eth_dev *priv = bus->priv;
+
+	udelay(priv->bb_delay);
+	return 0;
+}
+
+struct bb_miiphy_bus bb_miiphy_buses[] = {
+	{
+		.name		= BB_MII_DEVNAME,
+		.mdio_active	= dw_eth_bb_mdio_active,
+		.mdio_tristate	= dw_eth_bb_mdio_tristate,
+		.set_mdio	= dw_eth_bb_set_mdio,
+		.get_mdio	= dw_eth_bb_get_mdio,
+		.set_mdc	= dw_eth_bb_set_mdc,
+		.delay		= dw_eth_bb_delay,
+	}
+};
+
+int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
+#endif
+
 static void tx_descs_init(struct dw_eth_dev *priv)
 {
 	struct eth_dma_regs *dma_p = priv->dma_regs_p;
@@ -927,82 +1006,3 @@ static struct pci_device_id supported[] = {
 };
 
 U_BOOT_PCI_DEVICE(eth_designware, supported);
-
-#if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
-static int dw_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
-{
-	struct dw_eth_dev *priv = bus->priv;
-	struct gpio_desc *desc = &priv->mdio_gpio;
-
-	desc->flags = 0;
-	dm_gpio_set_dir_flags(&priv->mdio_gpio, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-
-	return 0;
-}
-
-static int dw_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
-{
-	struct dw_eth_dev *priv = bus->priv;
-	struct gpio_desc *desc = &priv->mdio_gpio;
-
-	desc->flags = 0;
-	dm_gpio_set_dir_flags(&priv->mdio_gpio, GPIOD_IS_IN);
-
-	return 0;
-}
-
-static int dw_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
-{
-	struct dw_eth_dev *priv = bus->priv;
-
-	if (v)
-		dm_gpio_set_value(&priv->mdio_gpio, 1);
-	else
-		dm_gpio_set_value(&priv->mdio_gpio, 0);
-
-	return 0;
-}
-
-static int dw_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
-{
-	struct dw_eth_dev *priv = bus->priv;
-
-	*v = dm_gpio_get_value(&priv->mdio_gpio);
-
-	return 0;
-}
-
-static int dw_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
-{
-	struct dw_eth_dev *priv = bus->priv;
-
-	if (v)
-		dm_gpio_set_value(&priv->mdc_gpio, 1);
-	else
-		dm_gpio_set_value(&priv->mdc_gpio, 0);
-
-	return 0;
-}
-
-static int dw_eth_bb_delay(struct bb_miiphy_bus *bus)
-{
-	struct dw_eth_dev *priv = bus->priv;
-
-	udelay(priv->bb_delay);
-	return 0;
-}
-
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.name		= BB_MII_DEVNAME,
-		.mdio_active	= dw_eth_bb_mdio_active,
-		.mdio_tristate	= dw_eth_bb_mdio_tristate,
-		.set_mdio	= dw_eth_bb_set_mdio,
-		.get_mdio	= dw_eth_bb_get_mdio,
-		.set_mdc	= dw_eth_bb_set_mdc,
-		.delay		= dw_eth_bb_delay,
-	}
-};
-
-int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
-#endif
-- 
2.47.2

