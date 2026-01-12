Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C43AC9EC8B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC1F0803F5;
	Mon, 12 Jan 2026 14:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="veMbVszN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C88783979; Mon, 12 Jan 2026 14:13:10 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011D183979
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so3214936f8f.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1768223587; x=1768828387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHmGeDhtgSsWQjF2tY03NReG/8knoMidNuPnyly6Zcw=;
 b=veMbVszNWgv+AC9B1bbDeT2JHPq562KNoAIoL8dpFTxyjbJQ6CD36HsxjmwMCO4gUP
 zxw372FW8IQOMkep8R2Lgoe632oy14LeC+tE9lPOowp6HPesSboTFjVPR2A2+J39U9rs
 mo8Ld8F/6u4ND1VjBDgLmUCnALTpzs20C/mwgS5AJ+e7lobEGLc+8Y36KJCo0nHXdaNa
 Co06lGDmmiu+LRkCHrKsDX0STixqM9gQ2ROYockLZQImSgU60ozwin46daAoLLZhdeAn
 zTZVSUujkzD7EPTR3KlJMh5obBhoE5DLm4rhZCJQTXxHp8DjWHTGVb74J+7n7J48woJV
 /g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768223587; x=1768828387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MHmGeDhtgSsWQjF2tY03NReG/8knoMidNuPnyly6Zcw=;
 b=w+Q7rWqBX1yVE6Z5T+g8IpUfCFqQOR+P99M96AoIZZZM+1cEyl2O7gFbjQq9YFWDtd
 KedGYFyPZaLuBHrb+4i+Ks8rgywLsUaK8h0dc0CBU+ur/JFJm+64G3wi41AaRFUc7Zjl
 4E23VsnBDesCqmt9EwPk2SmSZ7FVMLaPMJ6QPu92+4QklufTL8x8MN79veabQEPJXbKg
 iIokmwHwwMrTwPv832tDvoIIhwizg1aiowjMq6tRJiA8oDW3MgwKhxkr3hTdfvZWJcSc
 idD8YwUxStxyP3kznXj/eU86GUg7lnufnQ0OiI3aujuVpN9TJcsPS/ExN3XJP4GV3Xel
 zy8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOqFPPTFHr7V6tq4YNbjZNWQhgJdWrQpMRyYWtYHutK9zKvc33Dm0UfC3s3OEcO9nC/NyWEs4=@lists.denx.de
X-Gm-Message-State: AOJu0YyNPuICMQ7kjeKbyk4eZ+0rcZfvVocmdYyZTQUa+iVMiN5cson6
 V85FqiFTdGhrGKHbkjXAVfS3DSq/YgtzDLbe7mqvRbjDPWBIxHwnReWjq5FpcaRyQfU=
X-Gm-Gg: AY/fxX5di3LWWf8C7p1cfluE4iMW2XPkkpwAxEds4+AWXptlGn46XdgqY7KOjuWjaqa
 dts1Fa4eEt0Xo4nwAz0CetPSFyCrF1RHl4YkenWndbIFiJDUmV5hpbZnc80v72ncLbwZvsNPX0f
 sIBJGAxmlwl1HsAHPOrcj+tJ9jWKkikGmvBCRhLn3I5/LIRFGTwFB+z9DM2WCSuLgywb+hRXqsU
 wlEHHzQQ703NzLdSUD+J8hd7dYkA7P0EOzX7+Rg03zCwiTSL+lUHSZ/dd53jBSQ3P7P2rVtP1Uk
 2wzaK8RoR6kgRFrswRG/EjYoOdzEe75jh2Dx6n3RxUerNsRe0ZIzmJvHS7ZggcQl9a6a08ViAiS
 rFGZTNWO2QG/dMz0IPXVW9xGMKhQE/zYbmDp6H4wRE9UbIHsfiekubH9BLl/SvUzIUMfpTyqxVr
 rKw9f1KSjBWy/ZEgJh8gfoYJiXaZjuHNeJUuwUbnr7gPWxIE7K0BXkh4esHSUCNOl1YMMz8tF9G
 ahHHc4A
X-Google-Smtp-Source: AGHT+IGgzY9CHjxtqoodD+CQtCj+3dEYZ41ABaDZRtcrPNZEoGSXxrpeX+SER3OkgOSuQGV5JY9YUw==
X-Received: by 2002:a5d:588e:0:b0:431:b1e:7ff9 with SMTP id
 ffacd0b85a97d-432c37742d0mr18664063f8f.59.1768223587410; 
 Mon, 12 Jan 2026 05:13:07 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm39635162f8f.22.2026.01.12.05.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:13:07 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: eugen.hristev@linaro.org, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/4] serial: atmel-usart: include arch specific headers
 only for AT91
Date: Mon, 12 Jan 2026 14:12:41 +0100
Message-ID: <20260112131258.182173-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112131258.182173-1-robert.marko@sartura.hr>
References: <20260112131258.182173-1-robert.marko@sartura.hr>
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

Microchip LAN969x will not include any arch specific clk.h nor hardware.h,
so in order to support it only include <asm/arch/clk.h> and
<asm/arch/hardware.h> when AT91 is selected.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Use IS_ENABLED instead of CONFIG_IS_ENABLED when checking for
CONFIG_ARCH_AT91 as there is no SPL equivelant and CONFIG_IS_ENABLED
evaluates as CONFIG_ARCH_AT91 is not set thus not including the required
platform specific clock header.

 drivers/serial/atmel_usart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
index d6c3d4cbcc8..fb1c76fea8d 100644
--- a/drivers/serial/atmel_usart.c
+++ b/drivers/serial/atmel_usart.c
@@ -20,8 +20,10 @@
 #if CONFIG_IS_ENABLED(DM_SERIAL)
 #include <dm/platform_data/atmel_serial.h>
 #endif
+#if IS_ENABLED(CONFIG_ARCH_AT91)
 #include <asm/arch/clk.h>
 #include <asm/arch/hardware.h>
+#endif
 
 #include "atmel_usart.h"
 
-- 
2.52.0

