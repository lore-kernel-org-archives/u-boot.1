Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDE7C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE45819B1;
	Wed, 19 Mar 2025 13:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PjdSRhoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4CBC81026; Wed, 19 Mar 2025 08:26:05 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A303C81026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223594b3c6dso140608325ad.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742369158; x=1742973958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XDmFi5L62urAXKZ3aTdvX780+9QY/mQISQuhPLm3v5g=;
 b=PjdSRhoIgNBBC+fY9G058tVDBmGXk8wbhQ7Y5bcBo0wcoOtzD542AnzNBd4VQLvC6q
 Fq/pRK/FrAnhJCBHvNLFhbgLS8cG2+g2ABwzt256YMbmpacMmsBSWde//nrc3poic/ax
 flWKzR0CufDiDntl/a/ewTsrFhdPlhTn6ny1TnEKLVyz/PZQOGiaSKVICWijIBhQsYII
 P/6RKd4Mn77RxX2yxt9wWcjoy3sJpqh0d0E//1/J+uLt/gm5elE18yzQtEnuKLtdQhhX
 MzbeVZ9M8tPnC6Efy8HYUMewG8eXA7UtrG3Zik79BQwUbvm0DshzaFQaMzHEV6TBsPm3
 O3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742369158; x=1742973958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XDmFi5L62urAXKZ3aTdvX780+9QY/mQISQuhPLm3v5g=;
 b=dW2ZOqt/TRLKXKj9BYlujlC11GltK5cqwZsMZdw8Vg4/xI7+RlZ+we32wOqJ1EqjHs
 cmSFjSrmqvabCGeDO2A++cJ/O3ZtXWyDV69KgablkFV21ncbQgkIoEiShXGlIIvbKshw
 eEeI2VaL6STkTqED8trZRdgt0R24XCyI46joc8YaFegdpihKtTd4YUUUklf+8VZ9EjUf
 cdhhgJmybophMkf9l7h+vgfDJ4uRdThKNrRdtEkd6RFryPFYIx/EWHxsQPg9ehInaMVx
 Sq3KWXWZJakCXOErgwuuJEFW93TF7use+18QZpU5TDEGNsgfm9uY/Gg0k6oYUjFH2QwG
 nhOA==
X-Gm-Message-State: AOJu0YyFo9MCaf8WFzkDUq/ZUY9uNxdKBT8WaempV0SDc/fyPb0UrBcH
 uyMRN2DHTL8VlsoAwoQekoJjONiK42U+Ko5x9JxlfKjzR1ejptQJ1WHPYhHa
X-Gm-Gg: ASbGnctoZafWcBEUAqOACbP+98EnZBfBg/ZU/I/lUX7Pi64QvscjOfhVq1nykTJU9un
 kV8BXqWRWiTbfKgCMPuC9sJa0VqLVyZn4t+TCTOttx/4pEMUUvXv5vh0JXIB1wzaCPhufKWxGXb
 9TFI8zX9PPsQj/U5Yv/pJvQuZxHD6Z+iuKHKumoixVQYUaTIPsZpGO6FTz3JwjdBvSayaYQFb/H
 EdTlggZUoGgtnLV+Hinrepl8lszxCm2vD5T6A5MTovYb/MmhMfuQ3uL4HKSoPwk6nJ9ZOKKEiVn
 On5J7oJHult9GJwK7nwV65qagNf9woutbh2kld8cP/KJJyT6iIZ6THKVQrvQPrXUJdKVIvCpdGw
 i7MXn5exBmw2KgrfVbg==
X-Google-Smtp-Source: AGHT+IGWnukV51QNuW3XzGy7p9gsGQazHEmkJYYGASyGUiioQW3gTPzN9Vj3pS+oKbdb7ZXTve9eaA==
X-Received: by 2002:a05:6a00:4651:b0:725:96f2:9e63 with SMTP id
 d2e1a72fcca58-7376d6ff5b5mr3163751b3a.24.1742369157843; 
 Wed, 19 Mar 2025 00:25:57 -0700 (PDT)
Received: from aristo-b7flip.. (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371152948fsm11262683b3a.16.2025.03.19.00.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 00:25:57 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, trini@konsulko.com, aristo.chen@canonical.com,
 festevam@denx.de, marex@denx.de, jerome.forissier@linaro.org,
 ilias.apalodimas@linaro.org
Subject: [PATCH] configs: Remove duplicated bootcmd 'mmc dev ${mmcdev}'
Date: Wed, 19 Mar 2025 15:25:20 +0800
Message-Id: <20250319072520.100555-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Mar 2025 13:31:15 +0100
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

The 'mmc dev ${mmcdev}' is defined twice, so remove the duplicated one

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 configs/mx6sxsabreauto_defconfig          | 2 +-
 configs/mx6ul_14x14_evk_defconfig         | 2 +-
 configs/mx6ul_9x9_evk_defconfig           | 2 +-
 configs/mx6ull_14x14_evk_defconfig        | 2 +-
 configs/mx6ull_14x14_evk_plugin_defconfig | 2 +-
 configs/mx6ulz_14x14_evk_defconfig        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/configs/mx6sxsabreauto_defconfig b/configs/mx6sxsabreauto_defconfig
index 870b7a1be10..25b0b11342d 100644
--- a/configs/mx6sxsabreauto_defconfig
+++ b/configs/mx6sxsabreauto_defconfig
@@ -13,7 +13,7 @@ CONFIG_DEFAULT_DEVICE_TREE="imx6sx-sabreauto"
 # CONFIG_CMD_BMODE is not set
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev};mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
+CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
diff --git a/configs/mx6ul_14x14_evk_defconfig b/configs/mx6ul_14x14_evk_defconfig
index f841b21c016..737a079eaa7 100644
--- a/configs/mx6ul_14x14_evk_defconfig
+++ b/configs/mx6ul_14x14_evk_defconfig
@@ -24,7 +24,7 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
+CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/mx6ul_9x9_evk_defconfig b/configs/mx6ul_9x9_evk_defconfig
index 11a18d16f52..964d00a4085 100644
--- a/configs/mx6ul_9x9_evk_defconfig
+++ b/configs/mx6ul_9x9_evk_defconfig
@@ -24,7 +24,7 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
+CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
diff --git a/configs/mx6ull_14x14_evk_defconfig b/configs/mx6ull_14x14_evk_defconfig
index 316f74c278b..369bc0f2e0a 100644
--- a/configs/mx6ull_14x14_evk_defconfig
+++ b/configs/mx6ull_14x14_evk_defconfig
@@ -14,7 +14,7 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
+CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/mx6ull_14x14_evk_plugin_defconfig b/configs/mx6ull_14x14_evk_plugin_defconfig
index 8be5963a433..97d4f9fc65f 100644
--- a/configs/mx6ull_14x14_evk_plugin_defconfig
+++ b/configs/mx6ull_14x14_evk_plugin_defconfig
@@ -15,7 +15,7 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
+CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
 CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/configs/mx6ulz_14x14_evk_defconfig b/configs/mx6ulz_14x14_evk_defconfig
index 2c13dd4dbc3..1a49bc2cf01 100644
--- a/configs/mx6ulz_14x14_evk_defconfig
+++ b/configs/mx6ulz_14x14_evk_defconfig
@@ -14,7 +14,7 @@ CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x88000000
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev};mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
+CONFIG_BOOTCOMMAND="run findfdt;mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_HUSH_PARSER=y
-- 
2.34.1

