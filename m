Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DB2C25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 22:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A518587506;
	Thu, 26 Oct 2023 00:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UjeQLTEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D8B8799B; Thu, 26 Oct 2023 00:38:55 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E19F87506
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 00:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a86b6391e9so1955517b3.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698273531; x=1698878331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rNZSzQEjdvepkthap+fxYqcIRcnU8uZrsBsI3+/eLIY=;
 b=UjeQLTEYm0TuKpiZ6NY/D3TDv52wuOZa6a6FapNtkzuJfyaPr05jaDg8UGyybUmZ3Y
 oIRRkyQu0RXF2LHLIVTBnNFR3De3YbMEJOav+b0O0S5MZGeooYvg+lO2wJPpSnTHzoqi
 gOuS45aEWUXFi53InEBcA7l5iFl36HAdAvWSwHsLfD1ho+abc4bjSIvPCByoePByiJUO
 IgHz2mtWh71GYP0NxyI4Zr7PyIb58kWLosNGG6Up98O2rs4aDIKkjpnlYBhGRFMkMzG3
 lF3ZBGBFP3pjWN9XzAGotJJiFCCFVcMYGTyg2JmV6/GAk3UUpyhgj0tD214LqkHKnccS
 asdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698273531; x=1698878331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rNZSzQEjdvepkthap+fxYqcIRcnU8uZrsBsI3+/eLIY=;
 b=KfR3x8iAZKcSh0S+1/MbkxU6mRtif0RzGArD0iacQaDPRaX1H9ZXwb/5Ks59IbO+MI
 K8MzGpqMSYWXS78J8LPl8EmuRJWNsKGqbwpMztvqkqR0mJ+dmGGUOUH7ERnUnASiUf2R
 z2c2Ilf0qGjtiXIKXe6Df3lwsXyfzk06fgj5w7dPRyjkJTlO6n9HLz9mRXY67uiMd8aa
 98sOY4idWIo46e3rJjLD5gVmrzTKWwwxBXVgKLL8iPGPfPdoAE8nKXpME0XLMq2cE+08
 QzabepO6gYpQVL7NVYavFafiCmT+hMdXQ0dWSoQZgDTcDYPym+WYpa46BbYuOvYJqw9y
 3wnw==
X-Gm-Message-State: AOJu0Yxst3jO2y7PDFMd0lsXShNUyEhG2TGjLjiu3UdqpiI9RmZ/pK6q
 bbDhkNRbDPQlhXneJ3UksPgTfg7NC+E=
X-Google-Smtp-Source: AGHT+IHZIt72nyrho5qo7pKBe7jKFgAlhWrWVhB9u7uifCEDAkMiOv9esGdp1yqncjzN5FMujzTbbw==
X-Received: by 2002:a81:4e16:0:b0:5a7:bf2b:dc27 with SMTP id
 c22-20020a814e16000000b005a7bf2bdc27mr17115136ywb.14.1698273531528; 
 Wed, 25 Oct 2023 15:38:51 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 p142-20020a0de694000000b005a7fa3ccb32sm5409323ywe.35.2023.10.25.15.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 15:38:50 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
	Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH] arm: kirkwood: Enable bootstd for Zyxel NSA310S board
Date: Wed, 25 Oct 2023 15:38:37 -0700
Message-Id: <20231025223838.31639-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Enable bootstd for Zyxel NSA310S board, and remove distroboot.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/nsa310s_defconfig |  3 ++-
 include/configs/nsa310s.h | 17 ++---------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/configs/nsa310s_defconfig b/configs/nsa310s_defconfig
index ff4895622c..038ef42e9d 100644
--- a/configs/nsa310s_defconfig
+++ b/configs/nsa310s_defconfig
@@ -19,7 +19,8 @@ CONFIG_DEBUG_UART_CLOCK=166666667
 CONFIG_IDENT_STRING="\nZyXEL NSA310S/320S 1/2-Bay Power Media Server"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_DEBUG_UART=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/include/configs/nsa310s.h b/include/configs/nsa310s.h
index fa029a176b..8c4d03553d 100644
--- a/include/configs/nsa310s.h
+++ b/include/configs/nsa310s.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2015, 2021-2022 Tony Dinh <mibodhi@gmail.com>
+ * Copyright (C) 2015, 2021-2023 Tony Dinh <mibodhi@gmail.com>
  * Copyright (C) 2015
  * Gerald Kerma <dreagle@doukki.net>
  * Luka Perkov <luka.perkov@sartura.hr>
@@ -15,14 +15,6 @@
  */
 #include "mv-common.h"
 
-/* Include the common distro boot environment */
-#ifndef CONFIG_SPL_BUILD
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(USB, usb, 0) \
-	func(SATA, sata, 0) \
-	func(DHCP, dhcp, na)
-
 #define KERNEL_ADDR_R	__stringify(0x800000)
 #define FDT_ADDR_R	__stringify(0x2c00000)
 #define RAMDISK_ADDR_R	__stringify(0x01100000)
@@ -34,16 +26,11 @@
 	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
 	"scriptaddr=" SCRIPT_ADDR_R "\0"
 
-#include <config_distro_bootcmd.h>
-
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=console=ttyS0,115200\0" \
 	"kernel=/boot/zImage\0" \
 	"fdt=/boot/nsa310s.dtb\0" \
 	"bootargs_root=ubi.mtd=3 root=ubi0:rootfs rootfstype=ubifs rw\0" \
-	LOAD_ADDRESS_ENV_SETTINGS \
-	BOOTENV
-
-#endif /* CONFIG_SPL_BUILD */
+	LOAD_ADDRESS_ENV_SETTINGS
 
 #endif /* _CONFIG_NSA310S_H */
-- 
2.39.2

