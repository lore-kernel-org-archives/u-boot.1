Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB09C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3FE188535;
	Tue, 18 Jun 2024 09:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kFP0019z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D960E88519; Tue, 18 Jun 2024 09:55:37 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160C188431
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f1c567ae4so4058109f8f.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718697333; x=1719302133; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X/iQ5rHKQ6Qq2bKKIszSJByGXybAQV0e6TYGSJ5WwuU=;
 b=kFP0019zOTf3hb4k4ApC11Ood5jicfdLZrWRt83VRT/fOkAsW92qbW74TQI+LFYs+0
 TA3AwvqQb5W+JrowvZ6fySg8epz4NyqaehLB/d6IAuQ3AnWGEQHCDDPT2oVSlcBtvX+0
 MFmnbIntZpnBXJdXeFtTIPZZAvrmVy8OLjNfsT2qrCwh9YjouI6LbtZ6WM4EF2PGBc8d
 ZchLXLT78F9+iRjgp+6GlSRd4RxJqE6Kj59YqXc8Ex9pT+OfZI3gm1z9q3CCc0+TTDC0
 B6smDGYcSJOZ1WCrBnc6OmGivsRgYRpuymSiwmainQE7UU7M6KXE5Q83TJxoh3LUZszH
 RykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718697333; x=1719302133;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/iQ5rHKQ6Qq2bKKIszSJByGXybAQV0e6TYGSJ5WwuU=;
 b=tInCwwk3AwhlGk2myIKUUNhYplIUp4OQNsTcpmlTaghHUtUk7aWiIRRLjlmyvGLxRY
 vS8h0ioR35+SvKSWIrVjc0hRkmDC2uNTBGPrFl862ejjHuBV1ofMJjxg+B9JzOpWTC9z
 wqAmefzmEe1NE237ZKnQAixZ5LJ7Qw/+iFk2z5UXyDNLQqEVhS4+Q3PzpLhMaZqrJU0c
 GaBmpZawaBXbP0/S2cRzaHHg/nr/B8CQ+0Iy0HkGSb7jdMDpmgOC/ioir8BFGS2cANv9
 R/s4df72O5QMWCwVoyJKzvf3Wa8BpBOZTeWyZO1WCOc+qWbHSe7536ArSccnuJebZwNO
 MSKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrrhTHBaOwhm8dkbipzIklNeSFF3FgNiiY5uwzsGVcC/43pBkxD2Q0nXRS3euhP4nruC0IhjqW1U4jsxHarqeLO3roSg==
X-Gm-Message-State: AOJu0YwHmEBjiJVX4eV++Cyg0qCY0mvT/ngggZn5drZtzErbMuXHmPOo
 lX6ilOfHhZYHUCjOGs7nU8LN14DIKS3aG8hHMgLdhnyX6I1gAJ+LR4O2V04XpRQ=
X-Google-Smtp-Source: AGHT+IFrFLoDUurw4xX1qIzO8jwkltBWyS76brXrifjeuGyIj9Xnh/P08PXQKPnS2iSQ5Xu+63F5aA==
X-Received: by 2002:adf:f646:0:b0:35f:209e:21be with SMTP id
 ffacd0b85a97d-3607a747550mr7428576f8f.1.1718697333266; 
 Tue, 18 Jun 2024 00:55:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:55:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:27 +0200
Subject: [PATCH 3/5] phy: meson-gxl-usb2: remove
 phy_meson_gxl_usb2_set_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3hRKRk6rCcuBEMaskR4Fabd3ekP9rmERjxPgzCepr+I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1xv5HZWG6Uy+enJg8x+wOL8NpmfHTDt57dm+04
 CUtvl/+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cQAKCRB33NvayMhJ0d/+D/
 oCzgBETPsi7H7UNs7Sinscau3l3wA8BQSamxQluuUKfiqnkdulcIQgVZIGMGe3eWjwjxzKk+Sh4DoT
 V4luk4LGpZeU06342w6pssgExOfBHm6BZwo9F6+L6JYZWi4se7hUkXRou3AnDbhV8EOos4CnPn75L4
 PZqYpGjZhILK8URoiWd8YsvwLAVYJfbMV7cGV3/qjg3a40XoxXxowwCs9HxdMKjq4CkAWqs65FGszN
 iPiHDmjIUsijBzGf+BxICg8iXutYcjOEef9BiGPJLfSnA5Wy/4+cpfiioFj3Ay65MzzUcM2wxeszxE
 GAAzlqiJLhRfHAtoZGWiEFYgVaRacMz/RJn8/f5/qKtnUuYhkuybJ0uVTH9dNvNvsyGYVZQI0cS937
 bAk5Q0eY6ZfNxrSe/WH68tv31EHt4o1sb+ZK4ZFMRmp82buc3+UgTAxqpwJTO5mE2wK9s24ZnmpC1o
 Zis+ZfpjJY7ke40yvoMMpbRMdqb52m6gKHD+yY1ANIC91CzYdFTWDqonImZ6bu4j7QcbrP4qSdS9n0
 cwj2GIObCARPkGxwHJbSKfZjDGx145nmuvryy/Jf56xcs0tU8gmASzisQ+5X3rSVZDpJk4mYJ33go1
 65kR3lhxSavrhg3SHeu4tIooWH6gEsLNDi4xJIsXs97bNkmDH3RB+92JLxhg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Remove the public phy_meson_gxl_usb2_set_mode and move
the implementation in the the set_mode callback.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb-gx.h |  3 ---
 drivers/phy/meson-gxl-usb2.c             | 45 ++++++++++----------------------
 2 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb-gx.h b/arch/arm/include/asm/arch-meson/usb-gx.h
index 61f1809df9..966d401730 100644
--- a/arch/arm/include/asm/arch-meson/usb-gx.h
+++ b/arch/arm/include/asm/arch-meson/usb-gx.h
@@ -9,9 +9,6 @@
 #include <generic-phy.h>
 #include <linux/usb/otg.h>
 
-/* TOFIX add set_mode to struct phy_ops */
-void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode);
-
 int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode);
 
 #endif
diff --git a/drivers/phy/meson-gxl-usb2.c b/drivers/phy/meson-gxl-usb2.c
index e051e66224..140e936b47 100644
--- a/drivers/phy/meson-gxl-usb2.c
+++ b/drivers/phy/meson-gxl-usb2.c
@@ -19,8 +19,6 @@
 #include <linux/printk.h>
 #include <linux/usb/otg.h>
 
-#include <asm/arch/usb-gx.h>
-
 #include <linux/bitops.h>
 #include <linux/compat.h>
 
@@ -121,54 +119,39 @@ static void phy_meson_gxl_usb2_reset(struct phy_meson_gxl_usb2_priv *priv)
 	udelay(RESET_COMPLETE_TIME);
 }
 
-void phy_meson_gxl_usb2_set_mode(struct phy *phy, enum usb_dr_mode mode)
+static int phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct udevice *dev = phy->dev;
 	struct phy_meson_gxl_usb2_priv *priv = dev_get_priv(dev);
 	uint val;
 
+	if (submode)
+		return -EOPNOTSUPP;
+
 	regmap_read(priv->regmap, U2P_R0, &val);
 
 	switch (mode) {
-	case USB_DR_MODE_UNKNOWN:
-	case USB_DR_MODE_HOST:
-	case USB_DR_MODE_OTG:
-		val |= U2P_R0_DM_PULLDOWN;
-		val |= U2P_R0_DP_PULLDOWN;
-		val &= ~U2P_R0_ID_PULLUP;
-		break;
-
-	case USB_DR_MODE_PERIPHERAL:
+	case PHY_MODE_USB_DEVICE:
 		val &= ~U2P_R0_DM_PULLDOWN;
 		val &= ~U2P_R0_DP_PULLDOWN;
 		val |= U2P_R0_ID_PULLUP;
 		break;
-	}
-
-	regmap_write(priv->regmap, U2P_R0, val);
-
-	phy_meson_gxl_usb2_reset(priv);
-}
-
-static int _phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode, int submode)
-{
-	if (submode)
-		return -EOPNOTSUPP;
-
-	switch (mode) {
-	case PHY_MODE_USB_DEVICE:
-		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_PERIPHERAL);
-		break;
 
 	case PHY_MODE_USB_HOST:
 	case PHY_MODE_USB_OTG:
-		phy_meson_gxl_usb2_set_mode(phy, USB_DR_MODE_HOST);
+		val |= U2P_R0_DM_PULLDOWN;
+		val |= U2P_R0_DP_PULLDOWN;
+		val &= ~U2P_R0_ID_PULLUP;
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
+	regmap_write(priv->regmap, U2P_R0, val);
+
+	phy_meson_gxl_usb2_reset(priv);
+
 	return 0;
 }
 
@@ -183,7 +166,7 @@ static int phy_meson_gxl_usb2_power_on(struct phy *phy)
 	val &= ~U2P_R0_POWER_ON_RESET;
 	regmap_write(priv->regmap, U2P_R0, val);
 
-	_phy_meson_gxl_usb2_set_mode(phy, PHY_MODE_USB_HOST, 0);
+	phy_meson_gxl_usb2_set_mode(phy, PHY_MODE_USB_HOST, 0);
 
 	return 0;
 }
@@ -205,7 +188,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
 struct phy_ops meson_gxl_usb2_phy_ops = {
 	.power_on = phy_meson_gxl_usb2_power_on,
 	.power_off = phy_meson_gxl_usb2_power_off,
-	.set_mode = _phy_meson_gxl_usb2_set_mode,
+	.set_mode = phy_meson_gxl_usb2_set_mode,
 };
 
 int meson_gxl_usb2_phy_probe(struct udevice *dev)

-- 
2.34.1

