Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A42AC83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 09:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B5083807;
	Tue, 22 Jul 2025 11:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="2SNLoq/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033EC837F6; Tue, 22 Jul 2025 11:56:01 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FAD833C6
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae3b336e936so986787666b.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1753178159; x=1753782959;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mZ8zXJW/sF5iBYDv2Boo0hauosVzpWIez4H7z7+W78Y=;
 b=2SNLoq/+ISvU82TeFSLmMTHR3myDuIVdztYI2bF4bM4Dbl1sMmx/Zg1Ep09mMsIWLe
 e3fw/WosbXf+Zlsp1SwFnG9kziLddhMDTlcO/uNjIf89V4TA2BltHfaZxok0ieDbFbmw
 wXqdShSDwCVKjqvUWXbcnyR3hVNwacYdbuWu07/51Rh8/aNTS+k47stJ4F9m+4J5BSl5
 FEEudpX4vduh6cQYQc0OimLrSFIFgVCjtgZYIL+Uw1jHDvKmTcHfiWnGRYIGjNkHjtBo
 iaDq/rRfhk+I8Q8c9iOCwtrzdQ/UFZC778sLJ2s4+Ky+J9o6zopkpluiGeBAMV6LTfg7
 pGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753178159; x=1753782959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZ8zXJW/sF5iBYDv2Boo0hauosVzpWIez4H7z7+W78Y=;
 b=vnvvXeISwVwepp9fUFnhpqRw9xOedW3i+5jyPI2t7Hh6l0/2kbkU5NY9AO63fkxeac
 OdPSTPdU2HLHJd7+cI14UmmSIz70zWhBOlKBopBAJ4WXt70wsatDAdR8hQLkZv7z4f2E
 qg9n8YwTadSXbB2+098X8WJ2ioxHhhML6F6Hu5vNBuWtxkdToYyRCCet2DLTMXXWz8Cs
 8PnYr2tlu7+pnLFBV0zRuGrQnKjb37m8WAVo7Ak7HUVeiAygkGlDOyNZou7XOc6QDdpP
 iIyKiq+8tpINNcp9ToaZsH3m0kkGemrzynbNWUxIYIKFwm6rWdnFaKqWYtM8M7CRhXeg
 7tPg==
X-Gm-Message-State: AOJu0YwH0LkiL9FsaIktiZOiW8ZP4vdbEipRHmcpZg3SRcLDZ6hm/bhP
 rWPUYaSZEjscFFm4Ooxhqkxe6aulk/IQJrzOCoQ3XbWjwg8WcLKbX7n0wv0gKYRnNpUYXX+ThAf
 xnifb
X-Gm-Gg: ASbGncsAv8qxYNj1u0EJGqiaSRD3/N2gWsr/O/1Fot7H++9f5NvuoSuM41PHLk0flUy
 KQhGb0+yuN33IkVtEo+fiQjP5cv7smag9wdCEZPwKKCRbQCnYocw7/uGFd+OgUvI5o63ejkhI7r
 h/HNdmWdXmC7hIWH1Ky8fFkf/4Zfl4mPkJqVOh5i3+UJv7kQITFCXposYluPLnakQE3K5zvfXi1
 qvtIas+OPPVNLjWfHquofrfcZMIrtCmrGyZR7fuUgyWVRJHw01z10wLsC9TcnykXHf51WvSmTm1
 yvAY5BuaS0oJpLt7iM48yAXSoqsqqBDflACQVssdgWVKGL8rfZIaqfe+vJuVm+WFmwwpqd/O0oy
 hA3VV7ctCn/PoVvNhp2+eNiy8o0VJcWaCWg==
X-Google-Smtp-Source: AGHT+IEObGTlvATxJagV75HUKmPgPht+LZ8QAn9sPKK1/4YW4m3MpSOs/08Ei/XEQUtU3Nla0jyf2Q==
X-Received: by 2002:a17:907:c1b:b0:ae0:d97d:7fa0 with SMTP id
 a640c23a62f3a-ae9ce0d2f37mr2453422466b.38.1753178159075; 
 Tue, 22 Jul 2025 02:55:59 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6c79c279sm834754866b.28.2025.07.22.02.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 02:55:58 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Tue, 22 Jul 2025 11:55:34 +0200
Subject: [PATCH v4 2/5] usb: onboard-hub: Use devm API do automatically
 free the reset GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-usb_onboard_hub_cypress_hx3-v4-2-91c3ee958c0e@thaumatec.com>
References: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
In-Reply-To: <20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com>
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
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

