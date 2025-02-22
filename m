Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB35EC021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B246880FD8;
	Sat, 22 Feb 2025 21:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GDy5WHOW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SrLCov8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09F680FBD; Sat, 22 Feb 2025 21:36:12 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A930F800C2
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0f0V3V5wz9sby;
 Sat, 22 Feb 2025 21:36:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRzG1nnPxoHjLhkvIFK0OfdmgaBLpmgjuz/ZKokdBso=;
 b=GDy5WHOWl83tWPjSqtCcV7Aivx06pKZb7ab0k9kzv52adkS+Pcf+FMsZ+sFO2auH6ISeYL
 U9DUQgzW9OPpLUv2TIpv+UjB7d9JNjFRx+gZ1VrSIWpO4Gpcxb2R/fFWtTtZ7n7HMNjG5t
 T7vR5Up3GzBq1E7R6P4OCPLG3D3YLSlKkwjcK3zz1E8H6aEDrIZp5Lxd1Mu1uN/YFVt/Jv
 qPOdy/QDICA3xfLc1DJZ4i6jFIJENugJ3jCbDcHVDDPrt2QlCfwARR/g1KDKBOYCeeDoko
 P/PWXiAxSq2qzvVq0MHHIig7DD57nwI2+EGL3uBmzlOV+vIEiIFbFuG2URMWQw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRzG1nnPxoHjLhkvIFK0OfdmgaBLpmgjuz/ZKokdBso=;
 b=SrLCov8HsEZImIMN74bS+RpcEv4XC8apl0HDAMZ1Xwjwt+k9BJHFKPoxFFcl9LX+VsksfB
 bQd0mtVEB0TweQe3pJRlOXb55TnTmznBMhG3H+BeNL8akwA+4iHVdfviKg0ycite88n09t
 C1WjPNjI+FjCGjbEwkj0UjG1rQR+Q5nU71Lm7pYbBe6JQFOA+altsjhnF0ZTCLd3jTMU/i
 prgq8pmrvIquMbNbJYAPMp3wZe8AomW9u3bBWMukoLM5kSBgw/NdJfU6zL0kbmKgyQ1gKT
 LSHP90UWCmG8I6k79Cr+xfvg6CyMubg+I1wYeW3TMnoe6xdr9GFIgbEM/JdFXg==
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
Subject: [PATCH v3 07/23] net: designware: Reorder bb_miiphy functions
Date: Sat, 22 Feb 2025 21:33:17 +0100
Message-ID: <20250222203511.195437-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bd31zprtbgw71rfocuktmpf1ow7ntnhk
X-MBO-RS-ID: 6f1104bdadd7ed7105c
X-Rspamd-Queue-Id: 4Z0f0V3V5wz9sby
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
V3: No change
---
 drivers/net/designware.c | 158 +++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 79 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index c17b4078d5a..95a459cec2a 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -226,6 +226,85 @@ static int dw_dm_mdio_init(const char *name, void *priv)
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
@@ -967,82 +1046,3 @@ static struct pci_device_id supported[] = {
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

