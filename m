Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0416C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 20:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF798801F;
	Sat, 13 Apr 2024 22:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NokHklXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41198802E; Sat, 13 Apr 2024 22:56:57 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDEE87FA3
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 22:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-36a15df0f8cso9080715ab.1
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713041814; x=1713646614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=10zmAzqimog384XJL/ydDExQv+kXvLu7ARiGF2EEOI0=;
 b=NokHklXAKG9p82L37qwpc5VEt9MwKOvAKvcke39zF532Qh9VJ5Gz5bwndW+O0xQG6b
 dWfadcWwR6rWTbWPjiH8ZFM2I3QXV/cnQky0wH0Mu2ab9Fcb+7bJdO3oPG3Xxrd/2OZr
 p9cO974MyjMzReErVZzfZlTHkdqj+/yyj47YGOPK097U7AWVa+yodSy3UvmzWuDLmQTO
 D1CrOm1DXRgTAB1R1OMTmnJjbh2F8pX5Awt8RDmjHOvTOBsklqpYe4C/G0nZgrgfdFYX
 PCyUab6fEmyqtWPtu9lBXuwflKqwj9365CEvlAic7TRHg7A3w8huxoWCIKCHBzgwchb2
 owZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713041814; x=1713646614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10zmAzqimog384XJL/ydDExQv+kXvLu7ARiGF2EEOI0=;
 b=azb6PiWVtG7N6nzzUtqPDJP174WYM4IQV/xNC/X02RXLWcoS4t7mjCqvyq97ujMgM2
 0/HIW6cCvJQZM+pJNkGLYQTPhhlMtxX1GJHoButaZf1h+dpAG7oc3pWgtRWL17CpzXX2
 1bZHQfK0YzfwfPnXC7QVe9sLjkpG2eJG1A+mjidVvGZHfWVqZbhMyo3doPbFVue6QjpN
 VA35lIvvQM9jYYkgtw32JccNh15vK0zgd8N2yBZhrPrmE4tL9oHA5O0gL/8fIQQOHF8o
 +wVjp+6nBAQ/5mt0f/5eZqnjLIeC7FIydfp1nw5Mj3O+YN6u1iAld7ewICKqRt+4MtUo
 7qvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4GTT9BWZ99Dgd0o8xAwZLj1cQ3z8f8mDcjogHu7T8vDTlfkXBbApVhJpHu7i/MAzYDufwJnG1bJbR+9C5ha3LB5mWTg==
X-Gm-Message-State: AOJu0YwiEtWBH+DE1ZfXpt9fXBH/NXICd/FdLdvqBiF2IF5CfxonTZgI
 4ofq9asquELzsqCpYWfadxbYPSq32Pts4aFVMjEcwO4fWoxpGko39JYW2Ctz
X-Google-Smtp-Source: AGHT+IF/rgCtyqacuorL8uNC76i5W7jfZFoaqSO9BRk6J6FkhzJ0NKIPFE+csnCvToeu6xZBzhfbsg==
X-Received: by 2002:a05:6e02:1d98:b0:36a:2d86:90d7 with SMTP id
 h24-20020a056e021d9800b0036a2d8690d7mr8059094ila.5.1713041814431; 
 Sat, 13 Apr 2024 13:56:54 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:e858:7d5f:e2dd:57ff])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a056e02160d00b00369ffbc0176sm1764452ilu.73.2024.04.13.13.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Apr 2024 13:56:54 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Joshua Riek <jjriek@verizon.net>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>, Florian Klink <flokli@flokli.de>
Subject: [RESEND PATCH v2] configs: rk3588-turing-rk1: disable SPI flash by
 default
Date: Sat, 13 Apr 2024 14:56:36 -0600
Message-ID: <20240413205636.601625-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.43.2
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

While the Turing RK1 board has a pad on the PCB for SPI flash, it is
not populated at the factory: supporting SPI flash boot is a user
modification, not an out-of-the-box feature. The defconfig for this
board should therefore not be enabling the SPI flash image nor SPI
support in the SPL, as it causes confusion among downstream users as to
whether the SPI image needs to be distributed.

Fixes: 153ac950a599 ("board: rockchip: Add the Turing RK1 SoM")
Suggested-by: Florian Klink <flokli@flokli.de>
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Acked-by: Joshua Riek <jjriek@verizon.net>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

Changes v1->v2 (both requested by Jonas):
- Added back (i.e. made unremoved by patch) CONFIG_USB_GADGET_PRODUCT_NUM value
  previously automatically removed by savedefconfig.
- Also disable SPI/SFC driver entirely until SPI/SFC lands in the DT (if ever).

---
 configs/turing-rk1-rk3588_defconfig | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 07f7b84852..f500b0cf75 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -4,17 +4,12 @@ CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_SF_DEFAULT_MODE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
 CONFIG_ROCKCHIP_RK3588=y
-CONFIG_ROCKCHIP_SPI_IMAGE=y
 CONFIG_SPL_SERIAL=y
 CONFIG_TARGET_TURINGRK1_RK3588=y
 CONFIG_DEBUG_UART_BASE=0xFEBC0000
 CONFIG_DEBUG_UART_CLOCK=24000000
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
@@ -31,8 +26,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -66,11 +59,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_SF_DEFAULT_BUS=5
-CONFIG_SPI_FLASH_SFDP_SUPPORT=y
-CONFIG_SPI_FLASH_MACRONIX=y
-CONFIG_SPI_FLASH_XMC=y
-CONFIG_SPI_FLASH_XTX=y
+# CONFIG_SPI_FLASH is not set
 CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
@@ -87,7 +76,6 @@ CONFIG_SPL_RAM=y
 CONFIG_SCSI=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
-CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.43.2

