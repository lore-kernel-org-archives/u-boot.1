Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B36AEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 11:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69AB38704D;
	Mon, 21 Aug 2023 13:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ndJPjocr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEBC687052; Mon, 21 Aug 2023 13:20:22 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C958704C
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 13:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b9bb097c1bso50051671fa.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692616818; x=1693221618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCP5wOyM9pvVm/lXpOeKX0+iFxAGDIv7V6ogZxvzSUo=;
 b=ndJPjocrbQASyRAM4Kh4CVvjDEYMGzemVwHvPLlFHGVKfdBF5vOT8R/BVPp7Bzuo8k
 eA5wnnjX/IfAJP5a0CWEu909wllCgS1nXH8WOgQ2oDPiNVqJXt1+gOTwf/OIoKDeREe6
 ZyB+UIZY0WaDI4mPfnp/SnGOH8yIZ5v9IwDxk7W1VHg7azrlaoqta9E9v5c7tMg/unJl
 NfcWFS1/pqPJttxDuODqfUpdT+CytqPzwXJzcIpsJaZxag8UdcmsGMOS7lvmcG0cSyKY
 67qC+Y+4cL1UyX8LSO0JmWe6OX9ASHbzvmg6iI8GxhYFKxK37fyEXvZY8Z2FYf83lcjO
 Svcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692616818; x=1693221618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCP5wOyM9pvVm/lXpOeKX0+iFxAGDIv7V6ogZxvzSUo=;
 b=BXTD8+bwCu28fUfzHGULO70mpizR23aZQU89qesJjAzcPPdTVNAVwex44ccrrYjf3F
 RsU5Tc7tsvj8UZD0mT4/4fmo7+U5W78ynkHt7v7x4oioU1z1xIGCvatyGBro793PU9CD
 P1N5ozp5nEQzyhG2GvoD9VTUyMqtqBs2+ywguMKaEtYBJQcN0yGTkiyPXAkgnEpSAy7Y
 wWx8VSOHRaE+5IBMW2IFMISrJIWrOPNchuvS5Eg/cEd8D4CdqDG2WISbecSwcai8RfXm
 l2xbRK3p6+03opHb7a8znSJLC9GGE0+qRFNE3aRtghSSQkIYA3+yIzBYnUmQnlRkr/b/
 WqNQ==
X-Gm-Message-State: AOJu0YwLsC824lkNkmwW51dEINzdmFiwiviK3T0kIes6aKlf8e0CprWY
 IkH94kbu6iObSRDw8W3jNf8=
X-Google-Smtp-Source: AGHT+IGlbWRrGFqULHj1MyYbfBFGMshaiG0hmKOy51OhEyzQClflkw9ua0aV2W+Qp9LjHqbJe/iKVw==
X-Received: by 2002:a2e:9591:0:b0:2bc:b448:b8b2 with SMTP id
 w17-20020a2e9591000000b002bcb448b8b2mr2828980ljh.19.1692616817943; 
 Mon, 21 Aug 2023 04:20:17 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 rv6-20020a17090710c600b0099cc3c7ace2sm6461698ejb.140.2023.08.21.04.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 04:20:17 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] usb: host: tegra: implement dts based xcvr setup
Date: Mon, 21 Aug 2023 14:19:53 +0300
Message-Id: <20230821111953.5919-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821111953.5919-1-clamor95@gmail.com>
References: <20230821111953.5919-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some devices (like ASUS TF201) may not use fuse based xcvr setup
which will result in not working USB line. To fix this situation
allow xcvr setup to be performed from device tree values if
nvidia,xcvr-setup-use-fuses is not defined.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/usb/host/ehci-tegra.c | 48 +++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 2cf1625670..a9aee908f3 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -81,6 +81,8 @@ struct fdt_usb {
 	enum periph_id periph_id;/* peripheral id */
 	struct gpio_desc vbus_gpio;	/* GPIO for vbus enable */
 	struct gpio_desc phy_reset_gpio; /* GPIO to reset ULPI phy */
+	bool xcvr_setup_use_fuses; /* Indicates that the value is read from the on-chip fuses */
+	u32 xcvr_setup;	/* Input of XCVR cell, HS driver output control */
 };
 
 /*
@@ -464,10 +466,16 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
 
 		/* Recommended PHY settings for EYE diagram */
 		val = readl(&usbctlr->utmip_xcvr_cfg0);
-		clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
-				0x4 << UTMIP_XCVR_SETUP_SHIFT);
-		clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
-				0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
+
+		if (!config->xcvr_setup_use_fuses) {
+			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
+					config->xcvr_setup <<
+					UTMIP_XCVR_SETUP_SHIFT);
+			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
+					config->xcvr_setup <<
+					UTMIP_XCVR_SETUP_MSB_SHIFT);
+		}
+
 		clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
 				0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
 		writel(val, &usbctlr->utmip_xcvr_cfg0);
@@ -522,7 +530,9 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
 	setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
 
 	clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE);
-	setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
+
+	if (config->xcvr_setup_use_fuses)
+		setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
 
 	/*
 	 * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
@@ -843,6 +853,8 @@ static const struct ehci_ops tegra_ehci_ops = {
 static int ehci_usb_of_to_plat(struct udevice *dev)
 {
 	struct fdt_usb *priv = dev_get_priv(dev);
+	u32 usb_phy_phandle;
+	ofnode usb_phy_node;
 	int ret;
 
 	ret = fdt_decode_usb(dev, priv);
@@ -851,6 +863,32 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 
 	priv->type = dev_get_driver_data(dev);
 
+	ret = ofnode_read_u32(dev_ofnode(dev), "nvidia,phy", &usb_phy_phandle);
+	if (ret) {
+		log_debug("%s: required usb phy node isn't provided\n", __func__);
+		priv->xcvr_setup_use_fuses = true;
+		return 0;
+	}
+
+	usb_phy_node = ofnode_get_by_phandle(usb_phy_phandle);
+	if (!ofnode_valid(usb_phy_node)) {
+		log_err("%s: failed to find usb phy node\n", __func__);
+		return -EINVAL;
+	}
+
+	priv->xcvr_setup_use_fuses = ofnode_read_bool(
+		usb_phy_node, "nvidia,xcvr-setup-use-fuses");
+
+	if (!priv->xcvr_setup_use_fuses) {
+		ret = ofnode_read_u32(usb_phy_node, "nvidia,xcvr-setup",
+				      &priv->xcvr_setup);
+		if (ret)
+			return ret;
+	}
+
+	log_debug("%s: xcvr_setup_use_fuses %d, xcvr_setup %d\n",
+		  __func__, priv->xcvr_setup_use_fuses, priv->xcvr_setup);
+
 	return 0;
 }
 
-- 
2.39.2

