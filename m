Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E6CEE01F6
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 21:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E0A83FAF;
	Tue, 30 Dec 2025 22:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="h5vTNECn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7947683FC0; Tue, 30 Dec 2025 22:02:11 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F8DA83FA4
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 22:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso82567795e9.0
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 13:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1767128529; x=1767733329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I/+VHts8cXn3PAzdXGW0BHBgRVOSDRN8eT3+lGKniNY=;
 b=h5vTNECnsVeC6rBFYoYRzTdOrAgWy2PslKZgUmoSkqAMB3BUPcw9Rp+5hUzPBqg07Z
 pKdv45E05qgDlEZfUFvPFBD4Ke/hEIKkrmERz2vPkCmamZGO0dNOI8uuYQD0hONXMZ0e
 dJpnGl5+SE4GZYCbeguwcY+Z49yiTjSweghX45pg5pZntFhP+8dyoqJcqfBvK+j5+Wsq
 YG8rLiX5VA4tirKyYQTr6MRMTiLbjZkvHDHIE3n+0EjEZ8XYI3IJ9mUKRfnckeON/NQ7
 i9RGCqzdvLaLoas3/J3UQchHlcsYaRHxOxMg+qes86RwtBbF7o0gdLneTJgsy3u3dWq4
 Mq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128529; x=1767733329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/+VHts8cXn3PAzdXGW0BHBgRVOSDRN8eT3+lGKniNY=;
 b=ndE5mtppzYfbhZZgu613XjnTHN5u1u3A4V2WVd0TBsYs85DaPLQc2IF4G4JmFde5WH
 kTuHkNEhGhlTkJzlbNmv1+y2GhIo7CqZMi9z1/D0UXPHdELlIOhZzt/iurwZEiGZnwXz
 24gbqUKaGwbh5vcoNxwEPV1SigsiBQRt//Vz6mWrnEzCzibCfFDpE6XZvsUMhdujdp8q
 oDGEAghJSnOCGLTK9qa4E0BOlt+7e8/MenrB6gDYCXs4nBfSPZlXHNGMvSJiuelxH1IR
 J38kjVpZNLn7eOI/ZA6MN/931iXC6OHOnrqlVliL6abYWOhHWh9K7zHXjDmHP6W+tfBT
 OlYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSArBHwSPUQIpugmZP74cRTf6ORmxGb9V7ZIqJAhDb5JaF3xJYWkIHDENc3he1D7nL9MXajPs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy3wpAChAzXAh3Iw0Ceccpw2wU9U9ZOHYV7CnkbruvRfOmt76K
 mwe7+0wRcBA8E6YGL2XqfniDh33+QQSk+MsKd8OGeQXsE8T5kRpE8gerePVQ8MUkhutjjVD75mo
 zM3UrEUI=
X-Gm-Gg: AY/fxX54xnKlhPSbqf3oqGkzDOPzuBuoJGhjSyI7PxU47NqX65IO/NWTX6BpWvj+qE/
 U3q7qdvm5CSeJhigNQ3b9UEVPWxvJW/MZmjTLMJcoByiBDlwh4HETf0bFKRvnnBXE4saNcDNaKk
 QgteT9SQcTqhslWEVMX7/wcbDa4CnbX1LjLITl4TV7PPPZ80gm+Ngn/n8IKs6906FxERxEsJW9u
 Ky1fpOO6bL47p85xXKUrlV4wWm4Pu4miw4uyJcZynG9SLUmJ2HQpSwcpfuAfdSWBQccw8oQ0+Uw
 vsQxo7Pdcnw/CbVclGyfDttwK9NoMmwqoHYb/A+CiXA+era41cHTkU8wPuBhAX5ccGBIcCcGDmi
 3qGA848oz8z6avWkW5ck96uQBaMpSjQQ2mGjNSbNG9YvnkL5Jm0CjkDjAW9jFpXx0Qnb6Ro4Ph+
 j9QD5ypzURqCG/J1ol7qkbuTMnSj+axWkGR4qHUX3PWA5zxQQGDUFh7F2C2TC1jE7WaY1wLEvll
 N+OiyDw2GsGyHgVSUbrpyIgp+BVgAmIzqQjnic=
X-Google-Smtp-Source: AGHT+IGTQiYkapsLRzFKADqUqt4Ov7ilg2/b+2GRupERtp2b7NuiVrFmL8eYqFU4IVpaqYHKTCLSGA==
X-Received: by 2002:a7b:ca4a:0:b0:477:75b4:d2d1 with SMTP id
 5b1f17b1804b1-47be29f3835mr325101335e9.15.1767128528752; 
 Tue, 30 Dec 2025 13:02:08 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm55194994f8f.26.2025.12.30.13.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 13:02:08 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: eugen.hristev@linaro.org, trini@konsulko.com, sjg@chromium.org,
 hs@nabladev.com, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/4] arm: at91: move atmel_serial.h to include/dm/platform_data
Date: Tue, 30 Dec 2025 22:01:36 +0100
Message-ID: <20251230210201.496403-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
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

Move the arch specific atmel_serial.h header from AT91 to the generic
include/dm/platform_data.

This will be used for support on Microchip LAN969x.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 board/bluewater/gurnard/gurnard.c                               | 2 +-
 board/siemens/corvus/board.c                                    | 2 +-
 board/siemens/smartweb/smartweb.c                               | 2 +-
 board/siemens/taurus/taurus.c                                   | 2 +-
 drivers/serial/atmel_usart.c                                    | 2 +-
 .../include/mach => include/dm/platform_data}/atmel_serial.h    | 0
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename {arch/arm/mach-at91/include/mach => include/dm/platform_data}/atmel_serial.h (100%)

diff --git a/board/bluewater/gurnard/gurnard.c b/board/bluewater/gurnard/gurnard.c
index 3275803226a..71db6409721 100644
--- a/board/bluewater/gurnard/gurnard.c
+++ b/board/bluewater/gurnard/gurnard.c
@@ -29,7 +29,7 @@
 #include <asm/arch/at91_rstc.h>
 #include <asm/arch/at91_rtc.h>
 #include <asm/arch/at91_sck.h>
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/gpio.h>
 #include <dm/uclass-internal.h>
diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index a8714e055d7..7a70a7dfc8b 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -20,7 +20,7 @@
 #include <asm/arch/at91sam9_smc.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/at91_rstc.h>
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #include <asm/arch/gpio.h>
 #include <asm/gpio.h>
 #include <asm/arch/clk.h>
diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
index 6fa3ca573ae..ce16aad3b98 100644
--- a/board/siemens/smartweb/smartweb.c
+++ b/board/siemens/smartweb/smartweb.c
@@ -25,7 +25,7 @@
 #include <asm/arch/at91sam9260_matrix.h>
 #include <asm/arch/at91sam9_smc.h>
 #include <asm/arch/at91_common.h>
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #include <asm/arch/at91_spi.h>
 #include <spi.h>
 #include <asm/arch/clk.h>
diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
index 252b0787124..690c00046fa 100644
--- a/board/siemens/taurus/taurus.c
+++ b/board/siemens/taurus/taurus.c
@@ -24,7 +24,7 @@
 #include <asm/arch/at91_rstc.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/at91sam9_sdramc.h>
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #include <asm/arch/clk.h>
 #include <asm/gpio.h>
 #include <linux/mtd/rawnand.h>
diff --git a/drivers/serial/atmel_usart.c b/drivers/serial/atmel_usart.c
index 0b35582aaa4..d6c3d4cbcc8 100644
--- a/drivers/serial/atmel_usart.c
+++ b/drivers/serial/atmel_usart.c
@@ -18,7 +18,7 @@
 
 #include <asm/io.h>
 #if CONFIG_IS_ENABLED(DM_SERIAL)
-#include <asm/arch/atmel_serial.h>
+#include <dm/platform_data/atmel_serial.h>
 #endif
 #include <asm/arch/clk.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-at91/include/mach/atmel_serial.h b/include/dm/platform_data/atmel_serial.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/atmel_serial.h
rename to include/dm/platform_data/atmel_serial.h
-- 
2.52.0

