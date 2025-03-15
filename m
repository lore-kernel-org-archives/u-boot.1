Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51165C282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34DDA8214B;
	Sat, 15 Mar 2025 02:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XqLRuJQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6878214A; Sat, 15 Mar 2025 02:29:33 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480638214D
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c0848d475cso395934985a.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002169; x=1742606969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TFF/3nJTe2cGXVop/PVqQeZJVvOxNkUn4TUunKnoGw=;
 b=XqLRuJQwnBYKrEOVX4CwbYDwm14M6IfN/TIPKkZk0JDVxdiKb8k7G1o9+GalOqAIfn
 pX2fH704s3FWww/tEY85pTg9BGQwayz0dzWe9yFoMwCB3Dy4fST9C+l2+r1dn9b4HtCd
 856EW9husMJ3srjXxsW8oUAnKI0Xp0NkMEYjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002169; x=1742606969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TFF/3nJTe2cGXVop/PVqQeZJVvOxNkUn4TUunKnoGw=;
 b=YchIQ8XxfR3GL3dkYaHVRxtpIhm7IJofHZRkXlVhThQ7gDd1pDfqN6Fjb9xFW5oQmR
 siejnj9a0Cv7SAbj+UIJcqoWuq8KPz8ROQrhKlwYELb60wbepBgw4cFdO0x0ZNUvigAI
 snl5FCCVeRBCT5LCEot1ULY0zyhBpiv/trAQb9pQsizsUT93uo9uaIDz9QWCjs8ATrhv
 XNVq44zKVB1m72ma70JvJmdqWg2XBvSe9+HPdKQwsBu7OvhoTSVoB1CbSzRVhWReLVmw
 iwKYpjlHxrHEF/qXxeIxwblAf1Q3IcD0fwEj0xQy08lYgLXY3VxH9Xe7DW8nJ6CWDcUW
 ACHw==
X-Gm-Message-State: AOJu0YwE5KyehFVPi3nS3+rrM5vzm073Tgir23tx264ChH/b6JCOl0Q1
 yoGeKKWh9xc97+Ppq0kKsPCU2fZXwDZTCAgmJOK13eMwwAs9QS7bdDP+E2I+jLQ0/LLeQeVihkR
 B
X-Gm-Gg: ASbGncsPucs2Lqu8bz6T4UNBee9uUfoTtNqAqOtdk003vYo2QgnhsTlTOOsgt0H6CN0
 W3i153z8OiArryeRxA8Q84LAm3jYUgYCD6n7lmsSvKGycUlo9sCZWCOQRILwdqUC6wWOqxbdF/h
 Z27gXl2UkCxJ0eV8uHI10uUYNGeH/7eFtNKH5DushS8GOw8eJbM/ULagT0pqDSgPl4R/ZawKnnH
 tqzkAnJpa+eP0JVbvCURsNFK6D+5zjzuhRFWqo9+Lvw5aCf5JL8qUa/eKgyKvn/xZ8yhHwd08R7
 IbDDMAyQXACXw+wUtrCwpiTZYbM1d7lDfYreE5iNPeCl702F
X-Google-Smtp-Source: AGHT+IGwG8SHu8OqjGsx/T6txWc/DFUlKOeHb7qaRA1YDPwsciL+lijh/VE6uz2Vapl09/fx7u9nMA==
X-Received: by 2002:a05:620a:4725:b0:7c3:bdce:d1f7 with SMTP id
 af79cd13be357-7c57c928f65mr582647885a.58.1742002169256; 
 Fri, 14 Mar 2025 18:29:29 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d89b16sm322555485a.92.2025.03.14.18.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:29:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uboot-snps-arc@synopsys.com
Subject: [PATCH 2/2] arc: Migrate to SYS_{BIG,LITTLE}_ENDIAN fully
Date: Fri, 14 Mar 2025 19:29:23 -0600
Message-ID: <20250315012923.399465-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315012923.399465-1-trini@konsulko.com>
References: <20250315012923.399465-1-trini@konsulko.com>
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

With the way we now prompt for big or little endian support, the "select
... if ..." portion of the ARC symbol doesn't work as intended. But now
that we do have a globally visible prompt for big or little, switch to
using that fully instead of a custom symbol.

Fixes: cbef295441b4 ("Kconfig: Unify endian support option")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: uboot-snps-arc@synopsys.com
---
 arch/Kconfig                  | 2 --
 arch/arc/Kconfig              | 5 -----
 configs/nsim_700be_defconfig  | 2 +-
 configs/nsim_hs38be_defconfig | 2 +-
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 35b19f9bfdca..e5a003d1ddc4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -82,8 +82,6 @@ config ARC
 	select TIMER
 	select SUPPORT_BIG_ENDIAN
 	select SUPPORT_LITTLE_ENDIAN
-	select SYS_BIG_ENDIAN if CPU_BIG_ENDIAN
-	select SYS_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 
 config ARM
 	bool "ARM architecture"
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index be9774dc2896..ab90aa90e8ae 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -99,11 +99,6 @@ config ARC_MMU_VER
 	default 3 if ARC_MMU_V3
 	default 4 if ARC_MMU_V4
 
-config CPU_BIG_ENDIAN
-	bool "Enable Big Endian Mode"
-	help
-	  Build kernel for Big Endian Mode of ARC CPU
-
 config SYS_ICACHE_OFF
 	bool "Do not enable icache"
 	help
diff --git a/configs/nsim_700be_defconfig b/configs/nsim_700be_defconfig
index 4832195f6b47..f51d17516550 100644
--- a/configs/nsim_700be_defconfig
+++ b/configs/nsim_700be_defconfig
@@ -1,5 +1,4 @@
 CONFIG_ARC=y
-CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_TARGET_NSIM=y
 CONFIG_NSIM_BOARD_CPPFLAGS="-mcpu=arc700 -mlock -mswape"
 CONFIG_TEXT_BASE=0x81000000
@@ -14,6 +13,7 @@ CONFIG_DEBUG_UART_BASE=0xf0000000
 CONFIG_DEBUG_UART_CLOCK=70000000
 CONFIG_SYS_CLK_FREQ=70000000
 CONFIG_DEBUG_UART=y
+CONFIG_SYS_BIG_ENDIAN=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200n8"
diff --git a/configs/nsim_hs38be_defconfig b/configs/nsim_hs38be_defconfig
index 67de123d16bb..3ae76cd140bb 100644
--- a/configs/nsim_hs38be_defconfig
+++ b/configs/nsim_hs38be_defconfig
@@ -1,6 +1,5 @@
 CONFIG_ARC=y
 CONFIG_ISA_ARCV2=y
-CONFIG_CPU_BIG_ENDIAN=y
 CONFIG_TARGET_NSIM=y
 CONFIG_NSIM_BOARD_CPPFLAGS="-mcpu=archs"
 CONFIG_TEXT_BASE=0x81000000
@@ -15,6 +14,7 @@ CONFIG_DEBUG_UART_BASE=0xf0000000
 CONFIG_DEBUG_UART_CLOCK=70000000
 CONFIG_SYS_CLK_FREQ=70000000
 CONFIG_DEBUG_UART=y
+CONFIG_SYS_BIG_ENDIAN=y
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200n8"
-- 
2.43.0

