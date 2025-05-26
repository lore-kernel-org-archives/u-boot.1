Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4FCC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0ED382EA9;
	Mon, 26 May 2025 16:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="TxsmurkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C863382F6D; Mon, 26 May 2025 16:24:50 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C155182EA2
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-60477f1a044so1818725a12.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1748269487; x=1748874287;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OkLPAbVSJkGJ4x3cspMW0lUapeRHvIvu5y262lJB3K4=;
 b=TxsmurkMaLxEouIcLRFl5sy+qgq2IKQPOen7RHSinNuw3b5QzVfNushHLIS+l4/c2I
 9T1qy0I2uVgcgZj3/phUqRfBFq6nWG/HSj9/a/k4xQQjrgmCWrsTIWERaIMsdbjIT4v4
 hhg99eJzsHZhPxKSZZP65Df5BZMpvx5UXZjGAoKh2gYoOaRpiZQSjMenWFGMHYLV1DVi
 6k68+SIWtySdevqns9BVuDi+BD4dsq7653TLltYHkf5fSI2kiL4+0+tIJ7VgPtJdIcAW
 DPutxvRQ9fj9e1UBDyH7gVWA+PZQtCiUhj83VeMUo1PZo7yD5y2cIljB3fGGRn1KWnez
 TeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269487; x=1748874287;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkLPAbVSJkGJ4x3cspMW0lUapeRHvIvu5y262lJB3K4=;
 b=dFYcACGwIPmkEnEagZR1LbqzaCttLmGnxfKd6DlsTLmrdBU1OvqaUSh8wtp/PRM/70
 cvNtlJqITLTWSO0EGg7ac8BBPI86kuos5I32gPLxiNh6waQLdAAUL/VUlEcpZrxxouYY
 58wJICAHFzi61AGGxvbf8uNZ8DhyF+9WJmKS/JF73s7qjgSxZAwdqi8jMjBsM+oILkrz
 VQQACFfEtuAdLXZXXnKGt6VT+G/UwssYfAHMP8HqVXxYPzOHg8zVpiUynN7FHDiUqvvN
 R0U5X7D8Ml4f2In9cH4A11Wj1vcaFDVuLoOETfr9JPj6/5e5spFTpQQq27qOMn2Dfb/V
 rbLw==
X-Gm-Message-State: AOJu0YxzXbUI1wKYDjKvHDP0EF0lNkwzLnbAbRs2KN9xFSm/50eu2F1F
 K2NxTgKHde3Yf0SY1+/46yZ/14skfwhxnclbK0iiSJmKoNeOlUEXz0qv7kGqSpDjwI2/cnEjSVz
 P2A0K4e4=
X-Gm-Gg: ASbGncs7gLaBblozqveZfrmwMCu3rYdIxskDvLPdSyHp5LPXvj9lclEC+7ZW83xcouf
 EBXtOIAhuzWwLVQq+v3JDAywNgVreJ3PUHHX1h1uJpn83eet/YlrTW3YOVTBpE+N3HdDCGzbRpz
 8wIhVeD+n5iXzBvf567gE2r6rAFIpkF4kQEJf1fFRHq2Fd4A8Hj2AKj43n78gTU3B3j4gMj0Nki
 IFmu2a2L1P6lDuqM+v7GMP08sw3a1YB9RWPbVs0mZYAjtQbkJ5/5mHE2mGBuCANlANwwOFH6n5J
 9SBf+Qs21IDWxUBVeHTnpzLBO1Ax6TTdY9GvC8FHiZBWr1gpJj4achCIjDorfLdN8jgkIEfkNC0
 =
X-Google-Smtp-Source: AGHT+IHGwrOzou9l8fOkA2SpdPzenmAvhRU+6Y+LMzDF8wCpUdAwx4w3C4Jm3W2YsI//H9P9UHzX6w==
X-Received: by 2002:a05:6402:26c3:b0:5fe:e3a7:a8bb with SMTP id
 4fb4d7f45d1cf-602da407a83mr6991313a12.25.1748269486998; 
 Mon, 26 May 2025 07:24:46 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6045c6d25dcsm2926950a12.8.2025.05.26.07.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:24:46 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Mon, 26 May 2025 16:24:21 +0200
Subject: [PATCH v2 2/5] usb: onboard-hub: Use devm API do automatically
 free the reset GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-usb_onboard_hub_cypress_hx3-v2-2-f382415da84f@thaumatec.com>
References: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
In-Reply-To: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
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
index 3dfeb0cb5a59..286f90b22c24 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -211,9 +211,6 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
-	if (hub->reset_gpio)
-		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
-
 	ret = regulator_set_enable_if_allowed(hub->vdd, false);
 	if (ret)
 		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
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

