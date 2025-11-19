Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AC3CF34C4
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C81283F62;
	Wed, 19 Nov 2025 15:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LOVDQFkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA35983F69; Wed, 19 Nov 2025 15:55:19 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 144738004F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e0e4601faeso2882769fac.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564116; x=1764168916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=i2MnOc2SRIk2rEgGYHiMgBiD7QMTNXTUu/4yTrPVt0Y=;
 b=LOVDQFkda4ee8NPqShNwViI/jYc86L0IwTbwa7qLE4j8x3MBUKX9i/suckdnmzu/1f
 n7e61neGJHK+M+hTSMRyPdVZHwmQfvEXmr7LHob5R3YAXz71b3qUsa06q+DrXdr0Igxu
 JnMqFgZwpCcnjkMgVWCypj60dcO1MzxMcUxGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564116; x=1764168916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i2MnOc2SRIk2rEgGYHiMgBiD7QMTNXTUu/4yTrPVt0Y=;
 b=XOhn9+BpSxi1o3qovRJMOSKQqgyDRYsmIrGeslsl7km6cllcx+HWG5fSFcNlhBBjG6
 WDiT7eOs3okTaR6sk2ELrM8hQ2ud1jCT4FECJ8GxIHrMxSYQryG5h8MtTH6HdIQx5Yoe
 dXf1w/O4HTz2WPfJJGMLeJrFHL6yGI9X8albDx8RH0e/unDrx24KgLrl93Is3JGfmRg+
 U9Lqv2PK+22IVv9znZLwtBd+uCXJVP+bHaZsW64UbtBYaXm18fvQqun90Q9ZTpC3H+kP
 fTxQcZQfqWK80UxE0ATj4pAVng1NdzPD7hGxDebhoc5D/574STSxALN8bg5L+d5ZfQgD
 fKhg==
X-Gm-Message-State: AOJu0Yy7oNkUwebRa546mmv5zWTyk+V9p8V8rCnclx0kUnyrCZVpDcD8
 YTBWcBm+y2rYA3G8CefojCnc+/s7fVZCEstg08mR8ohJDZlsXRrdhGZ9MItVRpyWQ9LbJROr/Rg
 1X8x36J1uEA==
X-Gm-Gg: ASbGncvH/qek46XyvWBhNxtOPw1lFi5wzRJpSZC2Te+kWPt7XZ4xPaGWvAZM57+4fpq
 qs1H92Z8oUVex0HqYAbBogh/S9qjXu+6AHWdWD6L3eHqgDePWA4Bt1WzqdUSMyLP9PtZKqsa3pg
 1MZ4TTEjqYfSYmCqpLjr0m/V4ZAdaLRG9DEt22RUZTIISBmoC+bwcOXwESI4xJPTsJJtBxtAWlb
 Cmv2889tHq+Z6p8Ybm1QyTKobav1sOpxa6N8LmlvB6pHy9p8rXrH243ApoUY+Eq9xd0OqwsAZxt
 FkeXPg+rkX77kUEsD7GQupDnnTFCG0csjBbR74RUjccM63O3Hij3CgIIylHXe1frnzak/nM2HfB
 CIpovCVQ+mX2ZWkluOdhUiD/t/m/saKxON3/yRgrLUtbGqgxaJWOZfBvOjhlysf0GLhdr2NwOFY
 bmkinhTdTgTUxHij5F3f6q5xumV8kwbrGrh1e/aYabFMePQrQ5RpYb
X-Google-Smtp-Source: AGHT+IFx12/9KgFaq3MCC23NuO0WC+d6qW4zKM15+MYA6wAER+fg7nGCQxDDJdp3KbNye9NMdZsGww==
X-Received: by 2002:a05:6870:2387:b0:3d4:6fba:31ff with SMTP id
 586e51a60fabf-3e868ea62bfmr9094910fac.1.1763564115766; 
 Wed, 19 Nov 2025 06:55:15 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e85226391csm8256007fac.11.2025.11.19.06.55.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] arm: Remove remainder of zc5xxx board code
Date: Wed, 19 Nov 2025 08:55:14 -0600
Message-ID: <20251119145514.843117-1-trini@konsulko.com>
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

When these platforms were removed the common config header file was
missed. Remove that now.

Fixes: a0cacddcafe5 ("arm: Remove zc5202 and zc5601 boards")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/configs/el6x_common.h | 58 -----------------------------------
 1 file changed, 58 deletions(-)
 delete mode 100644 include/configs/el6x_common.h

diff --git a/include/configs/el6x_common.h b/include/configs/el6x_common.h
deleted file mode 100644
index 78af42d04504..000000000000
--- a/include/configs/el6x_common.h
+++ /dev/null
@@ -1,58 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) Stefano Babic <sbabic@denx.de>
- *
- * Configuration settings for the E+L i.MX6Q DO82 board.
- */
-
-#ifndef __EL6Q_COMMON_CONFIG_H
-#define __EL6Q_COMMON_CONFIG_H
-
-#include <linux/stringify.h>
-
-#include "mx6_common.h"
-
-/* MMC Configs */
-#define CFG_SYS_FSL_ESDHC_ADDR	0
-#define CFG_SYS_FSL_USDHC_NUM	2
-
-/* PMIC */
-#define CFG_POWER_PFUZE100_I2C_ADDR	0x08
-
-/* Commands */
-
-#define CFG_MXC_UART_BASE	UART2_BASE
-
-#define CFG_EXTRA_ENV_SETTINGS                                               \
-	"board=EL6Q\0"								\
-	"cma_size="__stringify(EL6Q_CMA_SIZE)"\0"                               \
-	"chp_size="__stringify(EL6Q_COHERENT_POOL_SIZE)"\0"                     \
-	"console=" CONSOLE_DEV "\0"					\
-	"fdtfile=undefined\0" \
-	"fdt_high=0xffffffff\0" \
-	"fdt_addr_r=0x18000000\0" \
-	"fdt_addr=0x18000000\0" \
-	"findfdt=setenv fdtfile " CONFIG_DEFAULT_FDT_FILE "\0"                  \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"pxefile_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	BOOTENV
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 0) \
-	func(MMC, mmc, 1) \
-	func(PXE, PXE, na) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-/* Physical Memory Map */
-#define PHYS_SDRAM                     MMDC0_ARB_BASE_ADDR
-
-#define CFG_SYS_SDRAM_BASE          PHYS_SDRAM
-#define CFG_SYS_INIT_RAM_ADDR       IRAM_BASE_ADDR
-#define CFG_SYS_INIT_RAM_SIZE       IRAM_SIZE
-
-/* environment organization */
-
-#endif                         /* __EL6Q_COMMON_CONFIG_H */
-- 
2.43.0

