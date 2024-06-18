Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0C7C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 08:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB831884D0;
	Tue, 18 Jun 2024 09:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZIazTc+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD63E8852C; Tue, 18 Jun 2024 09:55:35 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206218850A
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4217d808034so45835125e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718697332; x=1719302132; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3s6QvRaLgBM9BVS5oof8t32fnskrrrw/ilAd8VvZ3SI=;
 b=ZIazTc+m1La1vTEEav22TxKcFIQNBi97P/lVDlfjqyqS78YrQjB2NiSE0T4jk1vTM8
 FzF0fXrmWj81Bxowh2GCezNBLfABJn/5tkWS03XoHwLvbC6CWWOjKc/UJiyyFL2b/Mmn
 x7nCNdccNNPXNZogMTR5+7gOYhoHyINLtPiL+MHnA0GQOiPS7rFl2PDvTz7Zojh1ptp4
 0O/aZoHjFlZfbolpLroWJnk1AyRKZ1OFr+QngUhsgaz1MWTQcQFOpk/pc26KrOlO3oBE
 e0TlS2QlUvBjOkbvXPcFb9ic65E4g/GvZVT5vb7RB/omMJAWdSHz6/fWKGfeMBh3vKC7
 EGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718697332; x=1719302132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3s6QvRaLgBM9BVS5oof8t32fnskrrrw/ilAd8VvZ3SI=;
 b=MBr79o6oPtFcqE4t64rPr4fxB1vz2K3Kz2YmZnT0Z3+1Wk8Yb+DWapJ20faaczV2Qr
 CorpNClpuo/WMgSC4RziRWz71Bi98eHgw8ft1dSFxCKJzzUzwrHPVCAWE4iFK703YTDk
 5wMptkhSz7yLuOdv7yrYjCF++cb7RI8Q6GjDicSQTT8V21raM+UNIKHa7e9KMXTQQjOu
 +uUMKZ13S/WTJvLBv3gstpteuvRX0HQ5lvS4pWCTajS5AVQvdLoirK814xylShUJnWp6
 xcBB1CgwzeSmThCoVYReFbVKpGZofGYeuo6XxjWTGMpBrX3ckxScofleCSBvIdaz7CR6
 qCpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6wRxpeck5usN3kz0iLdxrTs+PMyOM6xWc24bkMtvLTkMFwabpuPzqc6QRAzqTE0m6AStAc0wDT2ZQ0sKH2woh3zkNHQ==
X-Gm-Message-State: AOJu0Yw3KSGMVoc6EA1znGme+JcWzqiQf/jpxJetrZmh5ebjYvYV+1M+
 3f6ZGr2MKt78y4zPTeeDQHubPrxBXOd8I5j/MGw1Yo4XJ9GlE1WEhvU+KzSo0eE=
X-Google-Smtp-Source: AGHT+IF21/QwqJhDtBK6s3EZUuS0nASQ5cPr1bnnMK4d5vu6wDEmxcfzs83bkBeNLVAUxGHOUVBEEg==
X-Received: by 2002:a5d:4c4f:0:b0:360:70c6:fe5b with SMTP id
 ffacd0b85a97d-3607a7e511amr8112704f8f.67.1718697332469; 
 Tue, 18 Jun 2024 00:55:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:55:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:26 +0200
Subject: [PATCH 2/5] usb: dwc3: meson-gxl: switch to generic_phy_set_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-2-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GTrmp7WLhG6oe7Z7C9Uhs4G6Xkk3KHyHVOiiQerYuI0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1wap7LKjJwO8nC/puvhnQVgeA++lPwp7d7lP30
 sZ90iB+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cAAKCRB33NvayMhJ0az+EA
 CTCJHwU+nk9Qy1PElASIeUQmoQRXKQZIQjb6D6Lu19mFPdLRfe8GacxchRTQQRQagC9kQu8iBJp97M
 lxm3kS0LQh1bQA24iIZMh2yglve9SGmuJKSKtFVol3/cNAESEVuxhB4/CBtb+l+9vNBi4cvqG5Py/f
 3vgO181AUxBG5pGr9QaYzTQmIyqWVbO1vRANH/iWt6aPRpSllrjO3xdlx6ZVOT84t+9e30CMGh1Pmn
 KF4vURjXs3ZjZE4WQF/pIVH7NrbLNwCsr13zz4vg1ijs2hDTNId1nzq6ZZ2udHHXYXxqUuTjtdnpHf
 /K5KxdiXEs5xrnBchL08hfIaKG4SVmSU0tZVV/nUTnQelSRz7GWJ4Hps66z8PnY4vzH9v+kUy/Ccxx
 anlyv1zbXHHlJJJxMhI8bNmhtUUTzVbEGKrSqw5RfywY2kaPr8dhES+FckzP8/YXS8pmW/hirzH945
 LOmEAyxmQ9fWRxOyh06TL84fqDAtRh59s2kclaxkFv1MPm29EdQ6yOb4wY4Ym25fV5j3m6jNa5L9TC
 lkI7kmm/x3Dfqvf4KvvpO/mc5uraTpnCzJBOqZhQuGFynaa/4Hvjbt0M3ojBh74B3Pu+RYkRGy1IxM
 /rNhU1UV4z0G0QOBHmA9o406bR2KvzHnaFPvTpfL7VkEnYOFcqc7mI5EDETw==
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

