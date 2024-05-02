Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678DFC04FFE
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 20:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBA388361;
	Thu,  2 May 2024 22:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eOVtxOSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD491882AE; Thu,  2 May 2024 22:08:14 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9DDA88387
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 22:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-36c73792655so4003925ab.0
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714680491; x=1715285291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xBIHA8ayrtultAWCditDBASNwJJ5ZupdnCKPluL0OOU=;
 b=eOVtxOSZ5yc5v9e24h0qSd5x3O8oYM4cBxUHgfaFEVMnUu8pospSj9GYTfOibOAe5g
 +baLyTTtv1+c/50UK0EFBe/PH3a2yJeb+JEp2VeRUx1NqgpaEpSfBAZmg9HBdaaaL2e2
 rvWkU+MDVFi9g2RJKKdyMVGMiXVEWVAo0fDdIX3KfuxI/jbG02c0gIivwohdGh2OHwWp
 W4jawKT/ZFQbiZ+KU35PYurwjDs7cUhyoMDS9oWWDoTpB9S+53EgvpkI7IOJbdJ55ObU
 p7dcfFljHWyWh4iRU/BKh2ymEG2xeGkVoUnc6ks9c1t9oPIybxpRKSn3Rjgve9c/OpYu
 LL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714680491; x=1715285291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBIHA8ayrtultAWCditDBASNwJJ5ZupdnCKPluL0OOU=;
 b=VnYHIk3XdSEyOxGOuAJNCvsvpgKNRru3oMhB78wE+0aZcAVOpD/ikZFcoifGDjSkSm
 GthsD5QJkYgwnzS9Sttykqbo1khsjQ6aGRfI2Nd7qKQ+cZ4C0s3HoIeBuyN4gDnHoKV3
 DLFU9E/rxUvDtA2/eqcUnlRzXuSIvyxsZHjwWYJ1zDFJU/CMfxXIOw4f+orBYsAN57OZ
 CImBz5UYa4Wl3gfR7UIJ45NNBGF5Oo9yGMlSZy2E2OL74tgF7gfObUbbwll0o+6XRPqJ
 xg1Sqm322t+5kp4YIl2v/7K4OVoXkDf/jKx1Zc/YX3oUcOfs8jK18OJNJCXSQkSataoA
 /tsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYmlGvybdOUC29oVzHXodiIkSCzJLnvgPs/yww/jOXr/O9VlR3cCw0uJa+H/Xpw7npqF1MR0jv6tuwCiYJhHuZYoj8Jg==
X-Gm-Message-State: AOJu0YzCok/b2bb6eXhCsybl+hBHo8H1lSzmRPt8ADODlofdrQhSsoMH
 zhUFFVYDaKz7a674EO2b8LDagVKT/GsO/1TgFvmWHlLyzTR+v+ibI5/j+Vcr
X-Google-Smtp-Source: AGHT+IHJhdUCVvbiQUtYlnmVNkqcOD07ipaniYY8dMR5t5oYF9ENfkJLd3A0fjBWDFiLoSB4vkkP7g==
X-Received: by 2002:a05:6e02:1385:b0:36c:5146:4484 with SMTP id
 d5-20020a056e02138500b0036c51464484mr1067654ilo.3.1714680491377; 
 Thu, 02 May 2024 13:08:11 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:2ea3:3964:d762:b6e6])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a056e02180c00b0036c4e289f8dsm349869ilv.79.2024.05.02.13.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 13:08:10 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Joshua Riek <jjriek@verizon.net>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>, Florian Klink <flokli@flokli.de>
Subject: [PATCH v3] configs: rk3588-turing-rk1: disable SPI flash by default
Date: Thu,  2 May 2024 14:07:29 -0600
Message-ID: <20240502200729.77955-1-CFSworks@gmail.com>
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

Changes v2->v3:
- Rebased onto latest master for clean apply

---
 configs/turing-rk1-rk3588_defconfig | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 038b14769e..39ef05477a 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -3,17 +3,12 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_SYS_HAS_NONCACHED_MEMORY=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
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
@@ -29,8 +24,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -64,11 +57,7 @@ CONFIG_MMC_DW_ROCKCHIP=y
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
@@ -84,7 +73,6 @@ CONFIG_SPL_RAM=y
 CONFIG_SCSI=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
-CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.43.2

