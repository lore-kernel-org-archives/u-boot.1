Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA389EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 15:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC1187010;
	Sat, 19 Aug 2023 17:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YU9ZVNNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365AC87021; Sat, 19 Aug 2023 17:06:45 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD6218700F
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 17:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-986d8332f50so246774366b.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692457600; x=1693062400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wIddiDM2AOT5MOeJty7W0ckvMcFgmyg9wTZOlqb5Sc=;
 b=YU9ZVNNCtluKqyaYpZTwnL/Vqhb+nunWfd/mhu8ZKNRd0NdnpYnMHhqyf0bYbxII85
 ZrQ9zlGDhO7pA5HxWkADhopMovDQkGUUwXSsVXzB5yKiZ5TL933e04VF4qOWMrdFe7ry
 H6hxrQv/6mpaRUoYKhZGbFs29r/5rFNP4bzRd1nXH53UmFQ5HGk+M8yI904pevJdGwuy
 VjDqoxC0RfcX0sESXJly2BIXM8AT6E2mMw+wF+5CYbCT9G/VyksO38yzlQ+afTY2CoLk
 6LBpm2CHhlthG6TLj5aGjQCN6r2g06cQV2SZ6FRyR+dMDu28cG6tUoiXY7lign0h5Jix
 7zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692457600; x=1693062400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wIddiDM2AOT5MOeJty7W0ckvMcFgmyg9wTZOlqb5Sc=;
 b=LrlJW0YyxL8TbYcPzJugncMYxJTpmvs1fVp8CmhOPcoINZLieXYbW7ynkSuDuP4ZQy
 ooKmL2cnbbpEcxt5XPkGzC+CGx6LvEMmw0ipE7actsmFcIoC2eZzc+jv604xqrLHgJxP
 xJdCmQFSzJRuDkIG+ovpdngynkXgY9w51o3HEp3kFpZHgncfljpxMxfTqdqsoseISV5a
 6Od54DJAZ4LYKeqYAtdrx+ddQeDzYIqcjjtiys1Id0EWr4qSZ8RFeOR4jaoDgK4DKsB7
 TafELq+IOFXlZebn6s8m0j7T/WU1VO3LE2kAo6514nmVYT0qMYW7wHpplCGN88lmk3XF
 G6JQ==
X-Gm-Message-State: AOJu0YyMH7/WUJOAiGB2EmXKJniYxXfidYGyVXxnp+xPXaGBEj5B2UCJ
 UGwklDn17IRdRJwtrCRjlrcA7qIhPMzyow==
X-Google-Smtp-Source: AGHT+IFtDTLE55mS+VgAt7vywVDj0DwfYgE84Qbb8H6e6GEqKaHOrardr3axbkD+0ySZB1CbNp039w==
X-Received: by 2002:a17:906:2099:b0:99b:64d0:f6c8 with SMTP id
 25-20020a170906209900b0099b64d0f6c8mr1937987ejq.50.1692457599986; 
 Sat, 19 Aug 2023 08:06:39 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 l20-20020a17090615d400b009930308425csm2856873ejd.31.2023.08.19.08.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 08:06:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] usb: host: tegra: implement dts based xcvr setup
Date: Sat, 19 Aug 2023 18:06:19 +0300
Message-Id: <20230819150619.76455-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819150619.76455-1-clamor95@gmail.com>
References: <20230819150619.76455-1-clamor95@gmail.com>
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

Some devices (like ASUS TF201) may not have fuse based xcvr setup
which will result in not working USB line. To fix this situation
allow xcvr setup to be performed from device tree values if
nvidia,xcvr-setup-use-fuses is not defined.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # ASUS TF201
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/usb/host/ehci-tegra.c | 53 +++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 2cf1625670..f24baf8f0c 100644
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
@@ -464,10 +466,21 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
 
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
+		} else {
+			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MASK,
+					0x4 << UTMIP_XCVR_SETUP_SHIFT);
+			clrsetbits_le32(&val, UTMIP_XCVR_SETUP_MSB_MASK,
+					0x3 << UTMIP_XCVR_SETUP_MSB_SHIFT);
+		}
+
 		clrsetbits_le32(&val, UTMIP_XCVR_HSSLEW_MSB_MASK,
 				0x8 << UTMIP_XCVR_HSSLEW_MSB_SHIFT);
 		writel(val, &usbctlr->utmip_xcvr_cfg0);
@@ -522,7 +535,9 @@ static int init_utmi_usb_controller(struct fdt_usb *config,
 	setbits_le32(&usbctlr->utmip_bat_chrg_cfg0, UTMIP_PD_CHRG);
 
 	clrbits_le32(&usbctlr->utmip_xcvr_cfg0, UTMIP_XCVR_LSBIAS_SE);
-	setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
+
+	if (config->xcvr_setup_use_fuses)
+		setbits_le32(&usbctlr->utmip_spare_cfg0, FUSE_SETUP_SEL);
 
 	/*
 	 * Configure the UTMIP_IDLE_WAIT and UTMIP_ELASTIC_LIMIT
@@ -843,6 +858,8 @@ static const struct ehci_ops tegra_ehci_ops = {
 static int ehci_usb_of_to_plat(struct udevice *dev)
 {
 	struct fdt_usb *priv = dev_get_priv(dev);
+	u32 usb_phy_phandle;
+	ofnode usb_phy_node;
 	int ret;
 
 	ret = fdt_decode_usb(dev, priv);
@@ -851,6 +868,32 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 
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

