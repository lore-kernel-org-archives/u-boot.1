Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32D8C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 08:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D323782A39;
	Tue, 10 Jun 2025 10:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="e1A2afuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A84A82B20; Tue, 10 Jun 2025 10:02:37 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A97F782A39
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 10:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad572ba1347so744216766b.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1749542554; x=1750147354;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gHNMBptcDCqIPT73X+qvhYeaF3twF4KIzguGi0qWQ94=;
 b=e1A2afuC7DYJV7/sdiHykQv5FtJY8OP3GR7RDktuNINs2Nxio6pSDgBUTG45HNYYZe
 dRc/8099X+LAlf7kmDNZzrYuucO2pTpgRsEh6O5eYM8vdq5SlEQgQ2iCudiln0FUr2ns
 DiDZ66lsDSvJA4Mq/wjm5h2Oq7YOV2o4VJYR7mGXVQ7tLUhcMm0gIGLYWOxWY2O9gHF6
 BNU9yC82tRqdmrPNvB/L+6axE1zB8vuLYYZdCE2zEnx9NLT3kRKLZwoenlQ5o01dw+TW
 n+/mWrg/D0hEGnYn9YsfbXwQ6OQqecSveiJXQbJOf/cB0W+05IIp+1ytuxoRZelI/GbR
 EQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749542554; x=1750147354;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHNMBptcDCqIPT73X+qvhYeaF3twF4KIzguGi0qWQ94=;
 b=tLuSFbJJFHbVragV7AK7e6BeFO+cmJYCSGxEIz6bSs2uKThyDkuuLbtTNSe46oHT5R
 mghSVylpCgG/dKviws5If6pEbPappKrfs8b8yBklcfa0gDjl9etGZAjXMswjkVY0A32u
 SX0asIMYsbAl8dw0kshwEHFxbip1m/rQaQSkePHSHuvTVMzL7m0H3ngQEax6m1R1gFBa
 6TLm+YURownwcMcfJQ/31lbNG/QmDIZiYZdiYgJpPyf/TB/gm1fd8qUpNdTP3cBUt4xp
 N9Xw3ZXvkJQ+LqKLo/NZPo6EYw7Jk+tWS9mVzXeS/tWnBcq0GcBors0rGZCJiesLy2Mx
 ESmw==
X-Gm-Message-State: AOJu0YxbFbgvEh0ShqmtpQF6EhfD+s0XgCOFKGUebvVCFf75HvgHpjJx
 ateHVne2RF22uLkGomHajuQjd4/osur08y16d74AYxS+Djqqf0luEz+OcJMEzUhYBAE=
X-Gm-Gg: ASbGncvNaSFmkaBoDPT/cl+0ew814Q/wIPGbJIkfti/0/dVMUtczymYbbPA8Oy5tdhh
 sbcvzDeLeGWlKlDP10w8339tMppXpelXnoTB0vkNKktM/j3HPclo5mYDvdoT1J8cv0G6uel6kD0
 D2KtaEiuL92W3Q6AGPjpdPMOs7DWJ5W0kUEwFa+/Y8XGFydPdIDCk+hqV8b3mSKPhWWF2a41PMe
 cRBfyYzESXKJDjU1Yk8KGg1THjLP7LLDAiun1XXU8ZoI6OJXi7vx5LMZixBKvJQpDqN24oMXR9F
 m7PekrIZmWzizmwJbjCvnTgzKh/u/NhilWW8SE99Vv0iWlS411lju/7uoITSGeCoL/Cmc3GHbX6
 PvWDTJ4O2lg==
X-Google-Smtp-Source: AGHT+IGciynLyhpiycvl6QKlPl9TTPW805D2NH5ZP3e9Hslh/QT7OTlqLsICLraqYjLdG919y4B9qQ==
X-Received: by 2002:a17:906:ef0e:b0:adb:1eee:a083 with SMTP id
 a640c23a62f3a-ade1a9c7ba8mr1375703566b.47.1749542554073; 
 Tue, 10 Jun 2025 01:02:34 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade343eeea1sm578233766b.74.2025.06.10.01.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 01:02:33 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 10 Jun 2025 10:02:10 +0200
Subject: [PATCH v3 2/5] usb: onboard-hub: Use devm API do automatically
 free the reset GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-usb_onboard_hub_cypress_hx3-v3-2-53f03dbc3017@thaumatec.com>
References: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
In-Reply-To: <20250610-usb_onboard_hub_cypress_hx3-v3-0-53f03dbc3017@thaumatec.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

The reset GPIO is obtained during driver probing by the function
devm_gpiod_get_optional, which means the GPIO will be automatically
freed when the device is removed. Because of this, explicit call
to free the reset GPIO in hub remove function is not needed.
To support the Managed device resources, the DEVRES config must
be enabled, otherwise the devres functions fall back to non-managed
variants. Set the necessary dependency to DEVRES in Kconfig.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 common/usb_onboard_hub.c | 3 ---
 drivers/usb/Kconfig      | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 7606362a4ee6..c6379192fe8f 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -211,9 +211,6 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret = 0;
 
-	if (hub->reset_gpio)
-		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
-
 	if (hub->vdd) {
 		ret = regulator_set_enable_if_allowed(hub->vdd, false);
 		if (ret)
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 99c6649e4178..daf2240ffd92 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -112,6 +112,7 @@ config USB_KEYBOARD
 config USB_ONBOARD_HUB
 	bool "Onboard USB hub support"
 	depends on DM_USB
+	select DEVRES
 	---help---
 	  Say Y here if you want to support discrete onboard USB hubs that
 	  don't require an additional control bus for initialization, but

-- 
2.43.0

