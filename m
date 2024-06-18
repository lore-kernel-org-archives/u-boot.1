Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13875C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 07:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3918B88538;
	Tue, 18 Jun 2024 09:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YGxDsr+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F4A88431; Tue, 18 Jun 2024 09:55:37 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500A38851E
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-421bb51d81aso39044015e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718697335; x=1719302135; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RTli4tgWHlPQpIu9XQZ3uNdUE/50JrdH1m+AlYJrngI=;
 b=YGxDsr+h+Q6k65UFHST2RMp3Y5V2a1aI4vA1PabpfuaOgzMxpKIU6eWnMjZiJW2Kkf
 WUXN31kZFehVXwHm5V1DFG28PmrON+2ysODpnf9rJP4wHGIBPtZMkqcUCDbN4Xax4MQO
 LIYH8rejgfHuWpLaA1MQXPGtc74CrJUusNFv8mP/aebwE9EoJgqkfq0aQf3Vn6XyC4wp
 qZh8pBalEDzBf8Ru1cH7mqCnnImZRrecP0ayBruKkIA8x/xtULxVXlQft/ebTMBuA7Mb
 poI3CbGdqKYGR+IOL6eveGzyWo5TTYuCGaKrTEsvL1gQ7uxkxuAr5kV6xnM6zZG4A7Ez
 xnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718697335; x=1719302135;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTli4tgWHlPQpIu9XQZ3uNdUE/50JrdH1m+AlYJrngI=;
 b=DLFCy2P+zOgCA90VyhhFamCRcKfbobizqgYiotwQsj65hmYNUpXHFJAw5BCJ15dW7H
 7WLFD5IFlDg/KMTQyiXett/F04c/6RxwlW2a7XHUpOkTk45MVrhXf63TFftPqOoNvN0t
 /YkuneDsJr+HJPBMkS2g3Yr6Q2WruTms/MQH2bLeb2tjBb7AHPjkxlppasuz0L+FSTHU
 aHMnxM55sQa2bIhVqVvZAWSLHpokdcuQj/vysHu9Ezt0nB9T52OaKkYD/8cY4/VPHiwD
 M3ZLGzGzcn/ciJN0BmydpnvmcCy8rVFqaSK0ptrawlrFuvqWVUG1+x86VIcvql+6rQTe
 igBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUwU+y5f0P90pkF+AxGkImPLPavFNch2r+YTaDzoIMMPS4J3WkY0BXB7XwEfnBrM0859KWarJaXiQLcxZ3AAWEb/hP0Q==
X-Gm-Message-State: AOJu0Yy8hzNK1J0KtxX8TVwBs0BZ3FnC2XhxNJ+s5Xt1V6rjv28mFseV
 Fo1RKhCvkTgsAfm1NyfHLfHtg8w1TIzGxTrtRJpMXndEkqhb8R01gU61fOEQq9UUNUYJOjvdgEL
 eEBw=
X-Google-Smtp-Source: AGHT+IGgqUG7sP8eLlYehvCK2UFjvdy2yFdExOWAWaCfWihj+2/4ZTMOcaZyEEwA9G6aPHlCx9ySPw==
X-Received: by 2002:a05:600c:4213:b0:421:8188:d394 with SMTP id
 5b1f17b1804b1-42304827504mr96861035e9.12.1718697334722; 
 Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750934a4sm13523173f8f.10.2024.06.18.00.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 00:55:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 18 Jun 2024 09:55:29 +0200
Subject: [PATCH 5/5] usb: dwc3: meson-g12a: drop usb.h and make
 dwc3_meson_g12a_force_mode static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-u-boot-usb-gxl-phy-set-mode-v1-5-6b41efa46e35@linaro.org>
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
In-Reply-To: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PPsS7D8TEBBrAwE0wIAH2nzaqsk2E8ByOhmeHE8CZe0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmcT1xcC3qXrhLwUmGIga3U/hl9c9wRXnwaefc1Gv3
 uhiBmLSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnE9cQAKCRB33NvayMhJ0aLAD/
 9Fpl0hd9IOOyEtmNP8iTqTKddD3QniFiZsTNQt+83sj+OZgAZfb21yaiydD357FC5Dd+Sr7TrWyChC
 mG3bQG/Nn4quioVjmmAANjV6pTv4yRavTt8UhXxLCB8WsKFqIy2D+BR7+lT4amYOc/fiYsvppBcN/L
 pYQUk/roMFEEuHC5aEDuai9icGOPxXxEcfhRUcu0UpiLWlpLbaT2GcYGz/rPEV6dP6SYFZAZpcojTX
 QTUhaAC/Ew4L/ENGaqeVhK7W4JISrrd4rK07C5pJicfxYLGnhGRCsz4GzDh3DD6GApgghgGhDgWUxz
 0/MIrtqqTXbyXQimKuLKIPiJn6frbNIYoTlCANJ9fvEi2tadBMQI4tTbH+X1sSgJQiLRYoJ1aXTN2q
 y1Pi4eps694P2DFWLNA/GwPaHJ57rldoj5s1vmT+53lamXXea9H3OR6ucXDnQjID8nNxylYeUbqaZt
 CtAAq1HDdF4+yMWpkUDL0YGBKEHAQlwZD9fouQiOmifEAm/B6w1AFMRWJZhRWd+rA4TQdMRNXEQpsv
 iRRq9Cugnnibtr22jNacJuOR/J4qqZyhrD+4zZErWgeCx5oHdsM8pd2cA7l6fJhFJAzES5NCfGxiuD
 Mg/w+rmSpTa2uJtooHjDs4axd/oKnFFpqmUFVkuh6yh3IZ7L6t/4dWF1PzVw==
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

Drop this useless usb.h and now make dwc3_meson_g12a_force_mode
static since only used in the dwc3-meson-g12a.c file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/include/asm/arch-meson/usb.h | 12 ------------
 drivers/usb/dwc3/dwc3-meson-g12a.c    |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-meson/usb.h b/arch/arm/include/asm/arch-meson/usb.h
deleted file mode 100644
index b794b5ce77..0000000000
--- a/arch/arm/include/asm/arch-meson/usb.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2019 BayLibre, SAS
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#ifndef __MESON_USB_H__
-#define __MESON_USB_H__
-
-int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode);
-
-#endif /* __MESON_USB_H__ */
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 21e4f637bb..41d15996e5 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -270,7 +270,7 @@ static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
 	return 0;
 }
 
-int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
+static int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 {
 	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
 

-- 
2.34.1

