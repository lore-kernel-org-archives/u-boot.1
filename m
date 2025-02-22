Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA42C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E364A80FF2;
	Sat, 22 Feb 2025 21:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uqI29dew";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IhCudmmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C402E80F3F; Sat, 22 Feb 2025 21:36:21 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A972480FD6
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Z0f0g3G4Lz9sp8;
 Sat, 22 Feb 2025 21:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM79rKHlXIeTzwjOkBWYs4i8KeRVMVjNprivokhJhgU=;
 b=uqI29dewXSFFSmSJvsHrcboV10tpNEkQLrT5vAKcoesesME8sU9TrBFawmz/+lmW9sLsOE
 2xGBUVAu/NFi0Hz/YNF+FRHYS8H0Qh5gwZ9waXChVpPHZvGLwfjLaNvSoJe03IAPvudjr6
 qBFMQSnQsyHOfdom4mWHEBxvj/DLK/Ysx9lkEYf934w3N+C3e+6CX0VAvFFqTgTtjvZptc
 MWf0Jn2W84u95k6FoY+JBFDBuoXBsMrQ818e3u9PR2OkfNDxnZpQTHG0PZdJgumHHXaflO
 c1DOktQSLY67ndr42BmEDb1ZvRH1+azZ7L1Ztxa3Bb5JQS1x1KdwucJ8t1Ud9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM79rKHlXIeTzwjOkBWYs4i8KeRVMVjNprivokhJhgU=;
 b=IhCudmmYG4/DVK02P5Gq/+6kwUthV6s9YOlTwBlwWt4IJ9cExrN5LDWa+SS8fVM0KwMoZP
 4tJ8j27V9mV1JRIKappUMPqn+NgHHoL6bCn2b+3zEgz9YsS1woixxQqQDTSRJOFyiLNhHL
 w0axa8Zc8Id57N1awhdqdprHOENy34h4XNQN5JG3dSqrICHJXFxahUUt6NxeCD/aHy4F7G
 2A0gV/SqxMwe4gRa1kSq2rx2tZWOmrLRQpmJ/B/Qd4h0PJKj8kAw85LPov6X+YYiDT17aO
 IC6JiOE0nVkYJZMwmzbAha8w/hJcLkCiAwtbJDmU+Hrju2Q10xXCnygcaJEQbQ==
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
Subject: [PATCH v3 11/23] net: designware: Extract bbmiiphy initialization
 into dedicated function
Date: Sat, 22 Feb 2025 21:33:21 +0100
Message-ID: <20250222203511.195437-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ac0aeb53b5e9be431a8
X-MBO-RS-META: 5pjznjhonbfrt64beb1wo5bt4sjysk7z
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

Pull the bbmiiphy initialization code from designware_eth_probe() into
dedicated function, dw_bb_mdio_init(), just like all the other MDIO
initialization functions.

Keep check for "snps,bitbang-mii" in the designware_eth_probe(), so the
driver can initialize this MDIO only in case the property is present,
and initialize regular DW MDIO in case it is not present.

The dw_bb_mdio_init() allocates its own MDIO instance, because thus far
code gated behind "snps,bitbang-mii" did depend on allocation of MDIO bus
by the other two MDIO bus options and then rewrote the newly allocated
MDIO bus callbacks, which is wrong, instead allocate proper MDIO bus with
the correct callbacks outright.

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
 drivers/net/designware.c | 95 ++++++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index de697060d28..c88b8df28ed 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -303,6 +303,50 @@ struct bb_miiphy_bus bb_miiphy_buses[] = {
 };
 
 int bb_miiphy_buses_num = ARRAY_SIZE(bb_miiphy_buses);
+
+static int dw_bb_mdio_init(const char *name, struct udevice *dev)
+{
+	struct dw_eth_dev *dwpriv = dev_get_priv(dev);
+	struct mii_dev *bus = mdio_alloc();
+	int ret;
+
+	if (!bus) {
+		printf("Failed to allocate MDIO bus\n");
+		return -ENOMEM;
+	}
+
+	debug("\n%s: use bitbang mii..\n", dev->name);
+	ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
+				   &dwpriv->mdc_gpio,
+				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (ret) {
+		debug("no mdc-gpio\n");
+		return ret;
+	}
+	ret = gpio_request_by_name(dev, "snps,mdio-gpio", 0,
+				   &dwpriv->mdio_gpio,
+				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (ret) {
+		debug("no mdio-gpio\n");
+		return ret;
+	}
+	dwpriv->bb_delay = dev_read_u32_default(dev, "snps,bitbang-delay", 1);
+
+	dwpriv->bus = bus;
+	dwpriv->dev = dev;
+
+	bb_miiphy_buses[0].priv = dwpriv;
+	snprintf(bus->name, sizeof(bus->name), "%s", name);
+	strlcpy(bb_miiphy_buses[0].name, bus->name, MDIO_NAME_LEN);
+	bus->read = bb_miiphy_read;
+	bus->write = bb_miiphy_write;
+#if CONFIG_IS_ENABLED(DM_GPIO)
+	bus->reset = dw_mdio_reset;
+#endif
+	bus->priv = dwpriv;
+
+	return mdio_register(bus);
+}
 #endif
 
 static void tx_descs_init(struct dw_eth_dev *priv)
@@ -801,6 +845,7 @@ int designware_eth_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct dw_eth_dev *priv = dev_get_priv(dev);
+	bool __maybe_unused bbmiiphy = false;
 	phys_addr_t iobase = pdata->iobase;
 	void *ioaddr;
 	int ret, err;
@@ -891,44 +936,30 @@ int designware_eth_probe(struct udevice *dev)
 	priv->interface = pdata->phy_interface;
 	priv->max_speed = pdata->max_speed;
 
-#if IS_ENABLED(CONFIG_DM_MDIO)
-	ret = dw_dm_mdio_init(dev->name, dev);
-#else
-	ret = dw_mdio_init(dev->name, dev);
-#endif
-	if (ret) {
-		err = ret;
-		goto mdio_err;
-	}
-	priv->bus = miiphy_get_dev_by_name(dev->name);
-	priv->dev = dev;
-
 #if IS_ENABLED(CONFIG_BITBANGMII) && IS_ENABLED(CONFIG_DM_GPIO)
-	if (dev_read_bool(dev, "snps,bitbang-mii")) {
-		debug("\n%s: use bitbang mii..\n", dev->name);
-		ret = gpio_request_by_name(dev, "snps,mdc-gpio", 0,
-					   &priv->mdc_gpio, GPIOD_IS_OUT
-					   | GPIOD_IS_OUT_ACTIVE);
+	bbmiiphy = dev_read_bool(dev, "snps,bitbang-mii");
+	if (bbmiiphy) {
+		ret = dw_bb_mdio_init(dev->name, dev);
 		if (ret) {
-			debug("no mdc-gpio\n");
-			return ret;
+			err = ret;
+			goto mdio_err;
 		}
-		ret = gpio_request_by_name(dev, "snps,mdio-gpio", 0,
-					   &priv->mdio_gpio, GPIOD_IS_OUT
-					   | GPIOD_IS_OUT_ACTIVE);
+	} else
+#endif
+	{
+#if IS_ENABLED(CONFIG_DM_MDIO)
+		ret = dw_dm_mdio_init(dev->name, dev);
+#else
+		ret = dw_mdio_init(dev->name, dev);
+#endif
 		if (ret) {
-			debug("no mdio-gpio\n");
-			return ret;
+			err = ret;
+			goto mdio_err;
 		}
-		priv->bb_delay = dev_read_u32_default(dev, "snps,bitbang-delay", 1);
-
-		bb_miiphy_buses[0].priv = priv;
-		strlcpy(bb_miiphy_buses[0].name, priv->bus->name,
-			MDIO_NAME_LEN);
-		priv->bus->read = bb_miiphy_read;
-		priv->bus->write = bb_miiphy_write;
+		priv->bus = miiphy_get_dev_by_name(dev->name);
+		priv->dev = dev;
 	}
-#endif
+
 	ret = dw_phy_init(priv, dev);
 	debug("%s, ret=%d\n", __func__, ret);
 	if (!ret)
-- 
2.47.2

