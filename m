Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC10C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92B8800C1;
	Tue,  6 May 2025 09:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jhl7JvjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E87980F03; Tue,  6 May 2025 09:14:24 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6E180050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-acb615228a4so1214464966b.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746515661; x=1747120461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yQub9IRBy7IJcxG4jBncNcobXccc+/smeJ5HytdjS8Q=;
 b=Jhl7JvjAIQc5NO6wzVqppz2k2+MOtDTf9OQkjc4AVNsSoFnCrKN3/BJ/vES5l+nsZb
 tcMnE/vvbhGhVYNe3gfcI8sFR3vBQdfaF/+1RBRM6d/WHD4zFGYqYFGli1KHOuKrYKx2
 WIm5BczW7afN7Vmhs0eYNlujd/NHYQFYk5bQLa20LWUyoRR5QqetSn8nWdgJaVcupAaQ
 9LbIk3zkuwQ/GmYyYs/CoWyoNSxV+5O5XfmPZahjxA5XSuyiflFtzkp2nSkz07gtkDMn
 u1SziLWGDO+rgv9qr3MnY2ZKE4+FBd0VA5Qfq4IjiSN3ArBgz+y0cyoLOM3aTLGNx+ox
 Hvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746515661; x=1747120461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQub9IRBy7IJcxG4jBncNcobXccc+/smeJ5HytdjS8Q=;
 b=kpv9oJCQ85eMlProuq2Y7pZ25DFI5vLoBV/4xLNV9QPIOKl1U32oLUJX5vt04QNMMT
 jWrCa9iANTrouZh6Akwgo5BNI8X36eMLyuA0qUwdgT/HIN/iY5NflAMClUSJo33S6+Zo
 o6aGKi/Q6Suz/qeGoiY9AzBZqVgh0CvcJgsfZFpWxpX/IOtP9cG1QR1pHs9rkd4mTKrz
 6CO/b9byLlv4OaKKVn8wWN2aJzL1eTu17BSEcsRxNXD8kcY2NyDF48cJBdJIRzFh6jBb
 WKT0erdk+iqb0CfX0R9hWQ10V3p00KYwCmCL3jFvGr2pZ4yDC75kblS/cWjiJIYlJVWx
 5doQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAn8bozKLtIAzHcFYsCV+ZQNntenwmYppVqBUXIPr8RcbEBIIm/j84E6rPvgqwJsj9A/7eODo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzt1uaEr7mrUYkJVvPoS7fin9SBKAQikBcIGyQZBovmy/FmMSE+
 0HdhFZxG/KinTN7FrwH0nsLQJ2cW2eXsgvpFrMgFcTwgGKkWaY9fyD9owLWd
X-Gm-Gg: ASbGncupCmAK8pr+6Uanf6EhACTG5wcFmCIZyfn3A5HXY/5M5S0uYNQvsmfvNMUlwpN
 4CzGuSyEPgRPVeEK7g/Ruq8OI3VlHtsTpizKtGkmgv/m+Ke5f5ykuEGvEAGuruJ25UN8ynhmCuq
 VIL4OuSFIiEHcMabXbP9PAqTw7eufZZ/HYOSBLCpwXmK8Yv1EZZfOOHwNH9GFGtyDrEqKsUg8+0
 NiaT3gROMezM6g9lqob2chRxieTNNP+1lhZrqsfGPrPLqZ+ii0C2JWubYItr+jhIfapbd5kJXbb
 pDGZu1VIj8ie38VinaN5JDFPExSAVetAOjJImwE0F1kOVkVWuEH04j2wWiAqkE2GJR/bgFye/pM
 6HMQor1ypKaAIc0DivQMWS1GfC5XJo/uGcj8rRhUN9p0Lv0yrdZNhK1Aj8Pc1xDyVx8U=
X-Google-Smtp-Source: AGHT+IEjTg3OgmdXuqXJDNkSSFD5YGynhzBClqse78QnygFxmno6gdWWjw5sTkYxS9lNqCbwt6kQGA==
X-Received: by 2002:a17:906:ccc7:b0:ad1:d304:e2b8 with SMTP id
 a640c23a62f3a-ad1d304e2eemr168022166b.26.1746515661224; 
 Tue, 06 May 2025 00:14:21 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189146991sm649562066b.14.2025.05.06.00.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 00:14:20 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v1] configs: verdin-am62: Drop unused or redundant config
 options
Date: Tue,  6 May 2025 09:08:59 +0200
Message-ID: <20250506070907.1267279-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Several Kconfig options are enabled but unused or unnecessary for our
use case. These include features such as SPL FAT support, YMODEM, and
USB keyboard. Some R5-specific configurations are not used at all,
as U-Boot proper is not executed on that core.

Cleaning them up helps reduce build size and simplifies maintenance.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/verdin-am62_a53_defconfig | 7 -------
 configs/verdin-am62_r5_defconfig  | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index 4bdcb4b6c461..c299c9fe4ad6 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -1,5 +1,4 @@
 CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
@@ -28,8 +27,6 @@ CONFIG_SYS_BOOTM_LEN=0x40000000
 CONFIG_SYS_LOAD_ADDR=0x88200000
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
-CONFIG_SPL_FS_FAT=y
-CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0xB0000000
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
@@ -53,13 +50,11 @@ CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_THERMAL=y
-CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_PROMPT="Verdin AM62 # "
 CONFIG_CMD_ADTIMG=y
 CONFIG_CMD_ASKENV=y
@@ -192,8 +187,6 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_SPL_USB_DWC3_GENERIC=y
 CONFIG_SPL_USB_DWC3_AM62=y
 CONFIG_USB_DWC3_AM62=y
-CONFIG_USB_KEYBOARD=y
-CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index f9580e697ff0..6d662f2febf2 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -47,14 +47,8 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_YMODEM_SUPPORT=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_MMC=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_TIME=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
-- 
2.43.0

