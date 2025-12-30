Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5F9EE0203
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 21:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B952483FC5;
	Tue, 30 Dec 2025 22:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="J/zHAZG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B27D83FAD; Tue, 30 Dec 2025 22:02:13 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4236283FBC
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 22:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432777da980so2226246f8f.0
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 13:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1767128531; x=1767733331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xtL+7zaciuFAjTo3sDeCiDUdz4eJk++j31qBPnLNCY=;
 b=J/zHAZG01lQfySH2XbAIjYNnabXkvZ0MPrf6xv4OqjKgFMiI7XLdTN+/IGVAyMBjH+
 Aen8K2+OOZL/isbzpzSWw4vda59inY1b6OmWYsQU8htQewLemZWSH0zMOj95q6V8m2nU
 PY2Q5zlnx5DUrNiLCsi4EE8IEf3jTyv5ELBvILQ+Gc6IfaQr+cgNq+31CFcSciNlefna
 s01luZYBTsTSGTtN1j2XcReHCWSiFD07MMVe7vPd2PmURguCKyfzimKO2H2oYeES0KsT
 YTuRLhLx6EDwV/vcntfbIeO8wK0aa8UwyDtw46DYk2KHExvJ2TA0ivH9cLgv6j+32pEE
 c99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128531; x=1767733331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3xtL+7zaciuFAjTo3sDeCiDUdz4eJk++j31qBPnLNCY=;
 b=qYr+yZJCR8Ak4d6V+winh469AUfUTlbGTdqVU9/OxXz0nvHl5i8EPJQU8O0F22P8rk
 zfuMsOnVfXNqTY8uZz/K57aUoF1/k8nqWc+WPc2gjZLHKpkssoySf2xHiYx2ttl94aBv
 vWhbQeX5ai5ZoeT4mBy1jsV43lAhm0tYoOdm2eB/hKJ+5sfb2nrPJznfdRd0HWpOGLA/
 aauL0L0HfSdZrGLhBad4LQHxdnFKRROMhKzsEWfdVFGnxOFUhjhc8LIobHA4HdZHS7G5
 5jpzH9HE1ul8VX1Vi3KkzlAPgtytv29jK13LQ7EWwhJ2A+lCQKMzhDZEjN48ayl/vBOP
 HfAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkiff8T15/PX3Xmn5hXRHkf4eJ6G74I95E+C3IEZL7vPZW30UFR/Z67nKwxru09ihmLC3AUN8=@lists.denx.de
X-Gm-Message-State: AOJu0YwkF38T5o2Fv2Nde/RESsvb8A3Nw2VwceHN0ZSLUXzq56PRAMO8
 1vn44ih4QgdSSAm/dedWLuPhEgJD0cP1TQ+nHbO3ZfwTrhb70Q2s08s31diZYvL7518=
X-Gm-Gg: AY/fxX4eRvVl7Q17GGRD1NX34s7JYebeBIscsP3F1ZuLj+X7UEs6+cYSK4oidsXXh6i
 5tCDXdTEEcaMB9866xCiPkU92lmiPM7DS0B8OSLl/JMUiL8Ksr5aWDCr8vocBf+q827qTBlpYU8
 gqBy/eSj1NpZ55HOW78b6T/rP/E6XeyzXdH4xo++BHvzGnsmeHI48ng15H27dYmhQOQHliQVEAC
 MMItfbWygW0BkeGBXnmrckT+e3r0xEj7jUS41uhODhERvbwcnVmK8WanVpxq2wBHvhSqNiTDFaP
 /zKB6llu4Yb6udTjRzuowLECYnDVALyLiWmXGnlOMLVpFH0TD7qcZ2XKOUX1JmVGQavE244aI5/
 w12zWmsaxtDoVEt7ABCFPbdo19WrYrWcUrGipDye46fBbwiUaEU4grb5tBZup/wyKBOU7Eabj0S
 Po63+yZCrPUKnvYHVnjZgIAI3UdoIJUR1NiErMugrYWyydAZPaVss7oUf/LAq7QtS7RaMN7ufGt
 M53cvzH17QRcaCvr6KhNMHlOXH1
X-Google-Smtp-Source: AGHT+IHEDs0mjrikOevdunJNYz/jZCW0pMLv7dRnoVhG4/sf8AHF/1mQ4TeVDmlKpJ0Z2kaH6tEALQ==
X-Received: by 2002:a5d:5f49:0:b0:42b:3dfb:644c with SMTP id
 ffacd0b85a97d-4324e4c157fmr42345828f8f.10.1767128530660; 
 Tue, 30 Dec 2025 13:02:10 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm55194994f8f.26.2025.12.30.13.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 13:02:10 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: eugen.hristev@linaro.org, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/4] serial: atmel-usart: include arch specific headers only
 for AT91
Date: Tue, 30 Dec 2025 22:01:38 +0100
Message-ID: <20251230210201.496403-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210201.496403-1-robert.marko@sartura.hr>
References: <20251230210201.496403-1-robert.marko@sartura.hr>
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
 drivers/serial/atmel_usart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
index d6c3d4cbcc8..4c992d14c3c 100644
--- a/drivers/serial/atmel_usart.c
+++ b/drivers/serial/atmel_usart.c
@@ -20,8 +20,10 @@
 #if CONFIG_IS_ENABLED(DM_SERIAL)
 #include <dm/platform_data/atmel_serial.h>
 #endif
+#if CONFIG_IS_ENABLED(ARCH_AT91)
 #include <asm/arch/clk.h>
 #include <asm/arch/hardware.h>
+#endif
 
 #include "atmel_usart.h"
 
-- 
2.52.0

