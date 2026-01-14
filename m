Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32F5D31A09
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 03:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE9F180B98;
	Wed, 14 Jan 2026 04:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IG5YiuO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE2D80433; Wed, 14 Jan 2026 02:48:57 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68F10802C1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 02:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-65d0f5fb26aso3785261eaf.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768355334; x=1768960134;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2do9aRHBQr6NwpzJpQRCoKRgskdO6m1aYj9lenogoKw=;
 b=IG5YiuO68rT21eQ145yIZ7HaZnGam1hZEuHoReA5wOs0tVRodfV7wOSPvWLdOV/E9u
 ijqU7ZGsvXMpmxyXmTWC9TL1qgaWzSNiU6N6qFOvMHUjYipHxZvh24mRZIvo1ZXaXMlJ
 8EuvDunxRQF87fEisiAH3cKM9piUZfSh4l5kM679m1zjK3xXxBU+5QCEw3D8Nor+9whf
 n5UTFuA5QuLqIvySvj77wzUWWTxjPa1a2rpBGbywIbEY7PMKbL3JpSI+/wU5gNAhs/Pg
 ImgLX2/N1omZogILxW/ID7aFZZAafWA3wi8AsfMzRaeQMPMtALYaWsMzPSBUk8BIWFF1
 fzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768355334; x=1768960134;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2do9aRHBQr6NwpzJpQRCoKRgskdO6m1aYj9lenogoKw=;
 b=weG0chKxocHd9JVX45y7Q4jfCeE7UTW19Jaj06lhC1fYdSjflvs5y9SiUMMRhfLx2B
 Wf6i/03edVnXJO2zt3oT5gdWymPhsU+YAi0nr0ShIvuTw4jPAfMacrAfconMO1x5BMoB
 OPYevprGZQqDAIQaylFBfaR9o9fJ980HQgVxA3S+yx0DIW2sZwbvihFg4kGxDs4d+ps8
 kHSblE8GTfeu22gvJi0DoYvFg3USoM9Bj8pt/MZC65CacWwtQv+NA1yMNFt6yyziOIg7
 N34VAE0wn9g7lxUaGDzQwl2YwY9cE3bBVTEbrI/kuRFzIDECXOzk5Z4l9xPnc/BqpDWU
 Pxcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGBvWDBajMc3tGSUM2sKFbOKUOB7r9vYfShHsB5Z4HQA8rvO+hPPYyxIZjXae5XfTQeS6cMeE=@lists.denx.de
X-Gm-Message-State: AOJu0YzpJ259d67JyFulFu7dlY1HwoIv2uxM7kmewd3RxRpxfZ42vbx1
 KJuQbWqdCDT1kO3N4leU9f/2ZjvYwWfYgkyQ4HlQIS34vL4t8n8Vo8CitvoIxBY+eChw9pV3LAc
 GrFtb
X-Gm-Gg: AY/fxX7V+5QQtUSsuFbKpwRTtbYCFGVHCjJVWXWRxOR/QqNVdVnYCQml3N1Rxosm8PP
 Qa2YmbDy4WpOztSmW302ASY9gEHLpne7F1pUvCT4XROfe81HAeLST+qZJ+SrKe1l/t3E45ORPtO
 vtdKKVRJ2grvITVDizLenXtNBYI4d/btBUetvqvz3Yemv3NOBlrJwepbsZBsC1N9JdcxC4hsXu2
 tN2EwgZiSo8Zspnq6kB7bzUg0hwWpMsVJOQwfXFRYgbQfpvo1kg86idCuycaOXDnguDp21AnW5W
 MPmG/aJMsCee4P21HscHcnTpDo6DtVM21y9BBIXrsEbICwunpAxew3Zry4nD7sfCNpXilavvXSr
 g2gmtQDs8cS9co9yIvUxUCnDjeoBgXQ8/dB00KkFjrkV0nVz+jcE3iOxwxtSnP7GNy4P/Pqnrg1
 uC0k2KYF2/fBVUmos=
X-Received: by 2002:a05:6820:e024:b0:65f:54c7:3c5f with SMTP id
 006d021491bc7-6610063b332mr667595eaf.24.1768355333996; 
 Tue, 13 Jan 2026 17:48:53 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:2f58:e1e3:bd08:f09e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48beb796sm9073599eaf.7.2026.01.13.17.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:48:52 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Jan 2026 19:48:31 -0600
Subject: [PATCH] pinctrl: mediatek: ignored error return from pupd/r1/r0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-pinctrl-mtk-fix-set-bias-v1-v1-1-eacf0e88ec7c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M2wpAQBCA4VfRXJuy1iFeRS4cBhOWdjYpeXeTy
 7++/geEPJNAHT3g6WLhw2mYOIJh6dxMyKM2pElaJMZYPNkNwW+4hxUnvlEoYM+d4GXQZhVRmfe
 VatDD6UnJf2/a9/0AdZnfQm0AAAA=
X-Change-ID: 20260113-pinctrl-mtk-fix-set-bias-v1-349ee75b9202
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Utvak7qHninKopl0uIf+io9KtpFuB636TfvlBpbUcmo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpZvX72vwt/ITQizVqcAQK83uEKYhR2G5G8GxRv
 4tX30+NekCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWb1+xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsGwH/iHzA2ksdep/kU3ugHlG4rxYyGgE80R2JSFLIg6
 qotoTUNS2OCL5+IfU3/412fOgt8PXZ7D9IorgiTZdrvHq9mVyO2Uy8EbqCmA7IuJLPwgOvvHVw8
 tyLqDypR9WzSmSNhUAb/NE6Y/k/CCgrVg2VMPhKo4qtBq0zXlfTrZQgXYx0DsF4PU9Ct8iHUM9q
 Hap27/ub/2kpjLXwA9+PO9jZFZe4EquzsuXj48RbhJfKsGIkZGFh5RascDgWnq0xVwbQSY1f02E
 mYDwbry9VA9JKtYAEmY0q1CbMgs7o93Y9UryTSwT27wzFGDzUlWzNUFF/AOFxDhWiHZDNtcFqot
 uGuI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 14 Jan 2026 04:16:18 +0100
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

Ignore the error return value from mtk_pinconf_bias_set_pupd_r1_r0().
The PUPD/R1/R0 registers only include a small subset of the pins, so
it is normal for this function to return an error for most pins.
Therefore, this error should not be propagated.

This fixes not all pins in a pinmux group being configured in some
cases because the propagated error caused the configuration loop to
exit early.

The rest of the function is refactored to return early on errors to
improve readability.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 0483d532800..ff7cefcc8de 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -364,11 +364,13 @@ int mtk_pinconf_bias_set_v1(struct udevice *dev, u32 pin, bool disable,
 	/* set pupd_r1_r0 if pullen_pullsel succeeded */
 	err = mtk_pinconf_bias_set_pullen_pullsel(dev, pin, disable, pullup,
 						  val);
-	if (!err)
-		return mtk_pinconf_bias_set_pupd_r1_r0(dev, pin, disable,
-						       pullup, val);
+	if (err)
+		return err;
 
-	return err;
+	/* Not all pins have PUPD/R1/R0 registers, so ignore any error here. */
+	mtk_pinconf_bias_set_pupd_r1_r0(dev, pin, disable, pullup, val);
+
+	return 0;
 }
 
 int mtk_pinconf_bias_set_pu_pd(struct udevice *dev, u32 pin, bool disable,

---
base-commit: d503633a36767d756c7de28305cf0de79440cbc0
change-id: 20260113-pinctrl-mtk-fix-set-bias-v1-349ee75b9202

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

