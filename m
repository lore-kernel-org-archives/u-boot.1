Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6E4C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 07:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7935F8834D;
	Thu, 20 Jun 2024 09:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l/phVd9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FCE987F3F; Thu, 20 Jun 2024 09:43:13 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65778813A
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 09:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42172ed3487so4815205e9.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718869388; x=1719474188; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3s6QvRaLgBM9BVS5oof8t32fnskrrrw/ilAd8VvZ3SI=;
 b=l/phVd9TVNwDCvyzEnsnyKbbR96gjujOI9i/huJqz8ZSRquZ2FHHWyAU1OO+8wDxIZ
 HO4kvxuii5brBfojtuGJYTJ+ksyN7slisylz2iCGwiK5KGZXa2S2atIHLHgpFy+ROgeJ
 +//xyz7BjJ/5EgSREWhKe9PbMO9ACV4GuUSIcofII98xvra2WUW/8ieo88dssK/g6GJ9
 oKlQsZ7uWYPhQH+7YDHpAD87pJ5sKJEyzo7zMTZSej9T/5vq90m/R0Shbd+97ZlSDrfZ
 SWq1yNvVdHbTNysHmaTWN28hqr2A5TLYNz3kdQqOVdzg6qQnzMcc6thoKvZqa+/NWwkc
 Iabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718869388; x=1719474188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3s6QvRaLgBM9BVS5oof8t32fnskrrrw/ilAd8VvZ3SI=;
 b=qp8DivrjPQMMk/OsfUfkYh3KSLUdLOkCyNSHOk1oR85MjVlxhpR57H3LwXYx8ghH9c
 3OIlcKa12Kl2CWNTkCV99SsRH4j2ipB9FG/WitGnO/h3hLkj64xDJE78OqknrVU0PdEd
 H4tqlehiz0v5mOFZcLH0yrtvEwB5YmbPoge07PH3E0EzEtC7J3lHH5SKgc8nFX9b7Yw6
 DywSJgGexvFyo1dm+meJ109aiM0LRDIno1YRYabij6GwIL6HwH1o/m6ErQzaUw3aPHU1
 9EgSjMFKSc6WrmJwGt/uNm1zfgPh8xzmpB3DYNQmcDT9CjEmM0ooJqLfbippTwxjHcER
 2DwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUZyFdKt4HiWI+ZvXrHbDC2Hmv+1jqZ0MgxJ50DZFnTdhQ9hc3RJDN6x7IVVBRwhbzBroE9TA6t+/Mqedx8S6q4pRUwg==
X-Gm-Message-State: AOJu0YxfytDMxSq4aumOqbDPRqWRx3M+xKtVhHaf0Ywzu819dtPSjDQz
 LAdVzW4HswVUgsIdSyi3sKJy/y0r4PK2JAs2d/cbhJG0xH7G4Ydq1Q4jjmizSJg=
X-Google-Smtp-Source: AGHT+IFy7tEBd0BNmmZyDb0au8TWFby4pc1AKz2pbecidxkyuhm8PTue9m64CfazxGxwbP2zvqPNqQ==
X-Received: by 2002:a05:600c:21a:b0:424:7bcf:2486 with SMTP id
 5b1f17b1804b1-4247bcf275emr13205085e9.4.1718869388315; 
 Thu, 20 Jun 2024 00:43:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d0b6402sm15506785e9.10.2024.06.20.00.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 00:43:07 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 20 Jun 2024 09:42:51 +0200
Subject: [PATCH v2 2/5] usb: dwc3: meson-gxl: switch to
 generic_phy_set_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-u-boot-usb-gxl-phy-set-mode-v2-2-b81c027bc02c@linaro.org>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
In-Reply-To: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GTrmp7WLhG6oe7Z7C9Uhs4G6Xkk3KHyHVOiiQerYuI0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc92G0/IZjZzjkdX/z7K2yMmOecfZgFnq1gjztS6f
 FRdL47KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnPdhgAKCRB33NvayMhJ0R3+EA
 ClSEndbXm5rHM4EtWNSP2BlvSa6wWxqlCA8EykuPr7CfUhBMNeYZg1juvpnQhwzz0jo7ybKZ7Cchq0
 V5T+Vw775CvMZTvIZpAF/y8TOI4vvZN+iBiOvaYiRrd2DQHN/ZFSs4tXbX9Id2Gd/6wxndXGv7Cy0m
 5fnNcHNaFdXqn6Qq0dopmz9ctkcip0BVvrXrLHLS9XfJd6GIIfbMBusnDPgnN9AjR0dHwBKkqXxqgp
 XnX/a8POCU0RhDG9X6PcO09xa6k3HukUJ4ae1jKaYrvQuGl8/zewpJaempmwL7v4uQknh54CXUPpI4
 UrgZbRoTgSw7OS2VbZ4mnRbES0tGRVPs1RfeclYK4iLwVCmUzw7pufq5JB58UxCwYR3Z2b4en3fnyh
 V4abYxiYco/bdilnAdH8E7HspC87weXOpoknt13eDnRyJ431PVGy8iUl4l8DklZq3NEHwS1JU8jhZo
 ugnQ80GXXXSAlcR175OwdxgZ9ifJE7TqnIqYCrGIKUX3MyaLMsOS4C6sV4mZrhPXFR9yehH+Ngfe+j
 Zn0bHpDaiib9/wXHjs4HSSCxouxa7eTixYRohJtWSYMx9qJol27HwtySSPDdkGen4ZrSH2ZYBKB2Qk
 F/Gx+5okayF7X2dkbal4Bmkbu4jx87VvjEPRtJchuXRUd+4V2rlO29fpN3Mg==
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

Use the PHY set_mode call instead of calling directly in the
PHY shared function.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/dwc3/dwc3-meson-gxl.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-gxl.c b/drivers/usb/dwc3/dwc3-meson-gxl.c
index 3e693c5ff3..290ac03a37 100644
--- a/drivers/usb/dwc3/dwc3-meson-gxl.c
+++ b/drivers/usb/dwc3/dwc3-meson-gxl.c
@@ -158,9 +158,9 @@ static int dwc3_meson_gxl_usb2_init(struct dwc3_meson_gxl *priv)
 		if (!priv->phys[i].dev)
 			continue;
 
-		phy_meson_gxl_usb2_set_mode(&priv->phys[i],
-				(i == USB2_OTG_PHY) ? USB_DR_MODE_PERIPHERAL
-						    : USB_DR_MODE_HOST);
+		generic_phy_set_mode(&priv->phys[i],
+				(i == USB2_OTG_PHY) ? PHY_MODE_USB_DEVICE
+						    : PHY_MODE_USB_HOST, 0);
 	}
 
 	return 0;
@@ -224,7 +224,9 @@ int dwc3_meson_gxl_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 #endif
 	priv->otg_phy_mode = mode;
 
-	phy_meson_gxl_usb2_set_mode(&priv->phys[USB2_OTG_PHY], mode);
+	generic_phy_set_mode(&priv->phys[USB2_OTG_PHY],
+			     mode == USB_DR_MODE_PERIPHERAL ? PHY_MODE_USB_DEVICE
+							    : PHY_MODE_USB_HOST, 0);
 
 	dwc3_meson_gxl_usb2_set_mode(priv, mode);
 
@@ -361,8 +363,9 @@ static int dwc3_meson_gxl_probe(struct udevice *dev)
 	}
 
 	if (priv->phys[USB2_OTG_PHY].dev)
-		phy_meson_gxl_usb2_set_mode(&priv->phys[USB2_OTG_PHY],
-					    priv->otg_phy_mode);
+		generic_phy_set_mode(&priv->phys[USB2_OTG_PHY],
+			priv->otg_phy_mode == USB_DR_MODE_PERIPHERAL ? PHY_MODE_USB_DEVICE
+								     : PHY_MODE_USB_HOST, 0);
 
 	dwc3_meson_gxl_usb2_set_mode(priv, priv->otg_phy_mode);
 

-- 
2.34.1

