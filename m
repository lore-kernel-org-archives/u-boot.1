Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0474C531C9
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 13:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7498E80CD8;
	Sun, 26 Jul 2026 13:12:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XiZEo_krNuhG; Sun, 26 Jul 2026 13:12:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 754E280CD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785071545;
	bh=UJy9wyxW55m+X3Kpo4H/Hn3mDQAh86qH6DSw0T4NY9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tefhJcYpkmJ1hkFR/p9ezjj35ONhlZzm6JpwCMoICXsN2If3O44/pznejzo5MJDW2
	 Wwn23keUHAvoltbN/qn8fSFLZGnWN/qfhUlVlLNFmLZfyr7DjgcTQXW18R0Vg8kt31
	 1Ens+Tyr78ZLIf2f2HQGfxlQ1SSh5/U8V644k4dKV87v4WONKHb5M3A8EJbCIpEuG5
	 gI+P2su1EWUYxEv5YWwWodW5v9F0MW0CHcasAXwyju2wcFaICVYY8EvJHFAXmj0k5x
	 6D6nEng1JtLxpBRg89wNyVWYhhNHZlEty/hDltFCEam+I8N+YMDkWKeGDbzztoEnUR
	 eJGbHmKK/axEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 754E280CD3;
	Sun, 26 Jul 2026 13:12:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 856253B1
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C0A26062D
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G98amFyisqWr for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 11:57:26 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=bhargavdas100@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9ACBD60631
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9ACBD60631
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ACBD60631
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854A5844F6; Sun, 26 Jul 2026 13:57:23 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE188005D
 for <u-boot@lists.denx.de>; Sun, 26 Jul 2026 13:57:20 +0200 (CEST)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso1973603a91.2
 for <u-boot@lists.denx.de>; Sun, 26 Jul 2026 04:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785067039; x=1785671839;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UJy9wyxW55m+X3Kpo4H/Hn3mDQAh86qH6DSw0T4NY9g=;
 b=c+jZ7/YJjbs2NPkhJzks59FHmVGihARlx3TKf9e8JDQXau9xITnBW+LzJedWE4ISIT
 VPWnEc7TGqRareMBluNZoYYquNOfAc3i/DWyJjcDXyV4pJMuoJoFC9vLde8DUO1Y6/+C
 hCUJBvYzMxpyBZo3BcN3ngmwluFSUUiT6/jIIq7G9Z4FgrMc2Jh++L8oTVCTQKpvPhZG
 kOLoHcpSAyK9zk5e0/Zp7EWzrEJhG9QXIEgMgmEj7yOVzo13Xc4Pzh3gpB6tFyNs0HTo
 fA4sZqQxMlGzHg+/v8Aoqu6FAtLfTz2G6un6dEJX6zYdJZ6zzi7SD5Dn0kllAq5QXYkR
 aavA==
X-Gm-Message-State: AOJu0Yxp4iLOkHJtt9C1ZuVEVO1Uf1Kg0er+b6Z7B4cryG228xOvSQpk
 loFZTIG4E5/++qEusQV+6DAa/gTCGpJmwURCu+IX6jB7urGQ522hH1ZaKa+dKfge
X-Gm-Gg: AR+sD13eozUcZbzwkx5f2ZJ9Kz9bNCwFDvhFHzuzWA9guzqg09TWQkmU3DHsraVvpIs
 9IhqpHb8guTS+ftOukKeWn2ie6Ac7cjj0M4izTbgL6C9UgdEKukhj5Dz1DGyjF2G89eGT+8mCpP
 OD0j062v6J9oFPM4rO4e5s3UtDh5mydyPmXgHFL3bU/tkP5l/WhB/rSiAVtEZfKOS4qEY6xFS8R
 /53vrGX6udcCd3C2J4HzhkRkX1gb7IdzsZNUs1inwMrH0Lh1SLr2bZUPHy/nKOj7MiQm7rsj3vv
 LStJtbKcHUDDpW5RQwoVJfWj2V85Nqvb+AnYz/dey02Y1U84RfKFQSXVEsO+cyXTeJoF5ytGp7e
 xtkGYmjec1YsucSN1LzjsR8j1f3MGA1V5WSRxqfWTWv4zLOOCXHiHlZPmPBytPi8dxsmP8U2c0f
 EEhlfFMi9n3zU3bhvGs84=
X-Received: by 2002:a05:6a21:6005:b0:3c3:8c91:5da0 with SMTP id
 adf61e73a8af0-3c67d9b397fmr4912808637.15.1785067038586; 
 Sun, 26 Jul 2026 04:57:18 -0700 (PDT)
Received: from bhargav-Legion-Y540.. ([49.207.202.251])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a67f3sm20811168eec.29.2026.07.26.04.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 04:57:17 -0700 (PDT)
From: Bhargav Das <bhargavdas100@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	sjg@chromium.org,
	bhargavdas100@gmail.com
Subject: [RFC PATCH 1/3] arm: Add RP2350 architecture support
Date: Sun, 26 Jul 2026 17:26:46 +0530
Message-ID: <20260726115702.15397-2-bhargavdas100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260726115702.15397-1-bhargavdas100@gmail.com>
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 26 Jul 2026 13:12:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785067039; x=1785671839; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UJy9wyxW55m+X3Kpo4H/Hn3mDQAh86qH6DSw0T4NY9g=;
 b=MlGSrs2OaSAW5sleHPGpx49wp+FkiH9sgYeQ4Qsjb5rXLTR4vxM5X0xJtS6KWuH8iz
 /U/pS7lor1zy71ftkr4JvggNhwNhuaAfX8q0WJpTn7Tq/5nE5oBnVwvvw0hh2qVqPTvC
 T9moRZCCzZCLK83+YhuGySiYwvjPs541BGV83DZHa1PTlffdIqNXIHzDJw1fOCIhz2Lt
 Na8ZbHrDZBFvbvxkpGzLFdS903zcUTLnPKE1QoCPTS+DHnXvWebbWeZyd+vquCwGQl/9
 I7p+W+xFx/GlvLIrA89NM7lY1CihcRGIKc9tI2E8UQ63ZL1SgZAzKFdXTv8lMc2JS2gI
 2HWQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MlGSrs2O
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bhargavdas100@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MlGSrs2O"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add initial U-Boot architecture support for the RP2350 SoC.

RP2350 specs:
- CPU: Dual-core Arm Cortex-M33 or dual-core RISC-V Hazard3 @ 150MHz.
- Memory: 520 KB on-chip SRAM, 4 MB on-board QSPI flash.

Only Arm core support is added here.

The architecture is added under arch/arm/mach-rp2xxx/.

This patch implements early SoC bring-up:
  - XOSC (12MHz crystal) startup
  - PLL_SYS configuration to 150MHz
  - CLK_REF/CLK_SYS/CLK_PERI clock switching
  - UART1 early console init (115200 8N1)

Cortex-M33 is an Armv8-M core, but U-Boot does not yet have a CPU_V8M
architecture variant. CPU_V7M's startup and exception handling are close
enough to Armv8-M Baseline/Mainline that the existing CPU_V7M code path
is reused for RP2350 in this series.

Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
---
 arch/arm/Kconfig                          |   7 +
 arch/arm/Makefile                         |   2 +
 arch/arm/include/asm/arch-rp2xxx/rp2350.h | 307 ++++++++++++++++++++++
 arch/arm/mach-rp2xxx/Kconfig              |  58 ++++
 arch/arm/mach-rp2xxx/Makefile             |   4 +
 arch/arm/mach-rp2xxx/image_def.S          |  23 ++
 arch/arm/mach-rp2xxx/rp2350.c             | 261 ++++++++++++++++++
 arch/arm/mach-rp2xxx/u-boot.lds           |  94 +++++++
 8 files changed, 756 insertions(+)
 create mode 100644 arch/arm/include/asm/arch-rp2xxx/rp2350.h
 create mode 100644 arch/arm/mach-rp2xxx/Kconfig
 create mode 100644 arch/arm/mach-rp2xxx/Makefile
 create mode 100644 arch/arm/mach-rp2xxx/image_def.S
 create mode 100644 arch/arm/mach-rp2xxx/rp2350.c
 create mode 100644 arch/arm/mach-rp2xxx/u-boot.lds

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cd6a454fd60..ff97923d6f2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2018,6 +2018,10 @@ config ARCH_STM32
 	select DM_SERIAL
 	imply CMD_DM
 
+config ARCH_RP2XXX
+	bool "Raspberry Pi RP2xxx SoCs"
+	select CPU_V7M
+
 config ARCH_STI
 	bool "Support STMicroelectronics SoCs"
 	select CPU_V7A
@@ -2272,6 +2276,9 @@ config SYS_KWD_CONFIG
 	  Path within the source directory to the kwbimage.cfg file to use
 	  when packaging the U-Boot image for use.
 
+
+source "arch/arm/mach-rp2xxx/Kconfig"
+
 source "arch/arm/mach-airoha/Kconfig"
 
 source "arch/arm/mach-apple/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b36b0742580..26d5c847185 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -99,6 +99,8 @@ machine-$(CONFIG_ARCH_ZYNQMP_R5)	+= zynqmp-r5
 
 machine-$(CONFIG_MACH_IMX)		+= imx
 
+machine-$(CONFIG_ARCH_RP2XXX) += rp2xxx
+
 machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
 
 PLATFORM_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs))
diff --git a/arch/arm/include/asm/arch-rp2xxx/rp2350.h b/arch/arm/include/asm/arch-rp2xxx/rp2350.h
new file mode 100644
index 00000000000..046c6cd02c8
--- /dev/null
+++ b/arch/arm/include/asm/arch-rp2xxx/rp2350.h
@@ -0,0 +1,307 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _MACH_RP2350_H_
+#define _MACH_RP2350_H_
+
+/*
+ * RP2350 Memory Map from RP2350 Datasheet. Datasheet sections are
+ * mentioned against the respective ranges.
+ *
+ * 0x00000000 - 0x00007fff  Boot ROM (32KB), sec 3.8.2.2
+ * 0x10000000 - 0x11FFFFFF  XIP QSPI interface range (up to 32MB), sec 2.2.2.
+ * 0x20000000 - 0x20081FFF  SRAM (520KB), sec 4.2.
+ * 0x40000000               APB Peripherals base, sec 2.2.4.
+ * 0x50000000               AHB Peripherals base, sec 2.2.5.
+ * 0xD0000000               Core-local peripherals (SIO) base, sec 2.2.6.
+ * 0xE0000000               Cortex-M33 Private Peripheral Bus, sec 2.2.7.
+ */
+
+/* Flash XIP base - U-Boot should start from here */
+#define RP2350_FLASH_XIP_BASE           0x10000000
+#define RP2350_FLASH_XIP_SIZE           (32 * 1024 * 1024)  /* 32MB, override in board files */
+
+/* SRAM - 520KB across 10 banks */
+#define RP2350_SRAM_BASE                0x20000000
+#define RP2350_SRAM_SIZE                (520 * 1024) /* 520KB */
+
+#define RP2350_SRAM_TOP                 (RP2350_SRAM_BASE + RP2350_SRAM_SIZE)
+
+/*
+ * APB Peripheral Base Addresses
+ */
+#define RP2350_APB_BASE				0x40000000
+#define RP2350_SYSINFO_BASE			0x40000000
+#define RP2350_SYSCFG_BASE			0x40008000
+#define RP2350_CLOCKS_BASE			0x40010000
+#define RP2350_PSM_BASE				0x40018000
+#define RP2350_RESETS_BASE			0x40020000
+#define RP2350_IO_BANK0_BASE			0x40028000
+#define RP2350_IO_QSPI_BASE			0x40030000
+#define RP2350_PADS_BANK0_BASE			0x40038000
+#define RP2350_PADS_QSPI_BASE			0x40040000
+#define RP2350_XOSC_BASE			0x40048000
+#define RP2350_PLL_SYS_BASE			0x40050000
+#define RP2350_PLL_USB_BASE			0x40058000
+#define RP2350_ACCESSCTRL_BASE			0x40060000
+#define RP2350_BUSCTRL_BASE			0x40068000
+#define RP2350_UART0_BASE			0x40070000
+#define RP2350_UART1_BASE			0x40078000
+#define RP2350_SPI0_BASE			0x40080000
+#define RP2350_SPI1_BASE			0x40088000
+#define RP2350_I2C0_BASE			0x40090000
+#define RP2350_I2C1_BASE			0x40098000
+#define RP2350_ADC_BASE				0x400a0000
+#define RP2350_PWM_BASE				0x400a8000
+#define RP2350_TIMER0_BASE			0x400b0000
+#define RP2350_TIMER1_BASE			0x400b8000
+#define RP2350_HSTX_CTRL_BASE			0x400c0000
+#define RP2350_XIP_CTRL_BASE			0x400c8000
+#define RP2350_XIP_QMI_BASE			0x400d0000
+#define RP2350_WATCHDOG_BASE			0x400d8000
+#define RP2350_BOOTRAM_BASE			0x400e0000
+#define RP2350_ROSC_BASE			0x400e8000
+#define RP2350_TRNG_BASE			0x400f0000
+#define RP2350_SHA256_BASE			0x400f8000
+#define RP2350_POWMAN_BASE			0x40100000
+#define RP2350_TICKS_BASE			0x40108000
+#define RP2350_OTP_BASE				0x40120000
+#define RP2350_OTP_DATA_BASE			0x40130000
+#define RP2350_OTP_DATA_RAW_BASE		0x40134000
+#define RP2350_OTP_DATA_GUARDED_BASE		0x40138000
+#define RP2350_OTP_DATA_RAW_GUARDED_BASE	0x4013c000
+#define RP2350_CORESIGHT_PERIPH_BASE		0x40140000
+#define RP2350_CORESIGHT_ROMTABLE_BASE		0x40140000
+#define RP2350_CORESIGHT_AHB_AP_CORE0_BASE	0x40142000
+#define RP2350_CORESIGHT_AHB_AP_CORE1_BASE	0x40144000
+#define RP2350_CORESIGHT_TIMESTAMP_GEN_BASE	0x40146000
+#define RP2350_CORESIGHT_ATB_FUNNEL_BASE	0x40147000
+#define RP2350_CORESIGHT_TPIU_BASE		0x40148000
+#define RP2350_CORESIGHT_CTI_BASE		0x40149000
+#define RP2350_CORESIGHT_APB_AP_RISCV_BASE	0x4014a000
+#define RP2350_GLITCH_DETECTOR_BASE		0x40158000
+#define RP2350_TBMAN_BASE			0x40160000
+
+/*
+ * AHB Peripheral Base Addresses
+ */
+#define RP2350_AHB_BASE			0x50000000
+#define RP2350_DMA_BASE			0x50000000
+#define RP2350_USBCTRL_BASE		0x50100000
+#define RP2350_USBCTRL_DPRAM_BASE	0x50100000
+#define RP2350_USBCTRL_REGS_BASE	0x50110000
+#define RP2350_PIO0_BASE		0x50200000
+#define RP2350_PIO1_BASE		0x50300000
+#define RP2350_PIO2_BASE		0x50400000
+#define RP2350_XIP_AUX_BASE		0x50500000
+#define RP2350_HSTX_FIFO_BASE		0x50600000
+#define RP2350_CORESIGHT_TRACE_BASE	0x50700000
+
+/* SIO (Core-local peripherals) Base Address */
+#define RP2350_SIO_BASE			0xd0000000
+#define RP2350_SIO_NONSEC_BASE		0xd0020000
+
+/* One universal macro to handle every single block and offset */
+#define RP2350_REG(base, offset)        ((base) + (offset))
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/*
+ * RESETS peripheral register map
+ * Used to hold peripherals in reset and release them
+ */
+struct rp2350_resets_regs {
+	u32 reset;              /* 0x00 - Reset control */
+	u32 wdsel;              /* 0x04 - Watchdog select */
+	u32 reset_done;         /* 0x08 - Reset done status */
+};
+
+#define RP2350_RESETS           ((struct rp2350_resets_regs *)RP2350_RESETS_BASE)
+
+/* Reset bits for peripherals we care about */
+#define RESETS_RESET_UART0      BIT(26)
+#define RESETS_RESET_UART1      BIT(27)
+#define RESETS_RESET_PLL_SYS    BIT(14)
+#define RESETS_RESET_PLL_USB    BIT(15)
+
+/*
+ * XOSC (Crystal Oscillator) register map
+ * RP2350 uses a 12MHz crystal
+ */
+struct rp2350_xosc_regs {
+	u32 ctrl;               /* 0x00 - Crystal oscillator control */
+	u32 status;             /* 0x04 - Crystal oscillator status */
+	u32 dormant;            /* 0x08 - Dormant control */
+	u32 startup;            /* 0x0C - Startup delay */
+	u32 count;              /* 0x10 - Counter */
+};
+
+#define RP2350_XOSC             ((struct rp2350_xosc_regs *)RP2350_XOSC_BASE)
+
+#define XOSC_CTRL_ENABLE                0xFAB000  /* Magic enable value, disable is 0xD1E */
+#define XOSC_CTRL_FREQ_RANGE_1_15MHZ    0xAA0
+#define XOSC_STATUS_STABLE              BIT(31)
+#define XOSC_STARTUP_DELAY              47  /* ~1ms at 12MHz, ref sec 8.2.4. */
+
+/*
+ * PLL register map
+ * Both PLL_SYS and PLL_USB use same layout
+ */
+struct rp2350_pll_regs {
+	u32 cs;                 /* 0x00 - Control and status */
+	u32 pwr;                /* 0x04 - Power control */
+	u32 fbdiv_int;          /* 0x08 - Feedback divisor integer */
+	u32 prim;               /* 0x0C - Post divisors */
+};
+
+#define RP2350_PLL_SYS          ((struct rp2350_pll_regs *)RP2350_PLL_SYS_BASE)
+#define RP2350_PLL_USB          ((struct rp2350_pll_regs *)RP2350_PLL_USB_BASE)
+
+/* PLL CS register bits */
+#define PLL_CS_LOCK             BIT(31)
+#define PLL_CS_BYPASS           BIT(8)
+#define PLL_CS_REFDIV_SHIFT     0
+#define PLL_CS_REFDIV_MASK      0x3F
+
+/* PLL PWR register bits */
+#define PLL_PWR_PD              BIT(0)   /* Main power down */
+#define PLL_PWR_DSMPD           BIT(2)   /* DSM power down */
+#define PLL_PWR_POSTDIVPD       BIT(3)   /* Post divider power down */
+#define PLL_PWR_VCOPD           BIT(5)   /* VCO power down */
+
+/* PLL PRIM register */
+#define PLL_PRIM_POSTDIV1_SHIFT 16
+#define PLL_PRIM_POSTDIV2_SHIFT 12
+
+/*
+ * CLOCKS register map (simplified - just what we need)
+ */
+struct rp2350_clocks_regs {
+	/* CLK_GPOUT0..3, CLK_REF, CLK_SYS, CLK_PERI, CLK_HSTX,
+	 * CLK_USB, CLK_ADC - each has CTRL, DIV, SELECTED
+	 * We only define what we need for basic init
+	 * ADD if others are required
+	 */
+	u32 clk_gpout0_ctrl;       /* 0x00 */
+	u32 clk_gpout0_div;        /* 0x04 */
+	u32 clk_gpout0_selected;   /* 0x08 */
+	u32 clk_gpout1_ctrl;       /* 0x0C */
+	u32 clk_gpout1_div;        /* 0x10 */
+	u32 clk_gpout1_selected;   /* 0x14 */
+	u32 clk_gpout2_ctrl;      /* 0x18 */
+	u32 clk_gpout2_div;	  /* 0x1C */
+	u32 clk_gpout2_selected;  /* 0x20 */
+};
+
+/* Clock source selections */
+#define CLK_REF_SRC_XOSC        0x2
+#define CLK_SYS_SRC_PLL_SYS     0x0
+#define CLK_PERI_SRC_CLK_SYS    0x0
+
+/*
+ * UART register map (PL011 compatible)
+ * This is standard ARM PL011 - same as used in many ARM SoCs
+ */
+struct rp2350_uart_regs {
+	u32 dr;                 /* 0x00 - Data register */
+	u32 rsr;                /* 0x04 - Receive status / error clear */
+	u32 reserved0[4];
+	u32 fr;                 /* 0x18 - Flag register */
+	u32 reserved1;
+	u32 ilpr;               /* 0x20 - IrDA low-power counter */
+	u32 ibrd;               /* 0x24 - Integer baud rate divisor */
+	u32 fbrd;               /* 0x28 - Fractional baud rate divisor */
+	u32 lcr_h;              /* 0x2C - Line control */
+	u32 cr;                 /* 0x30 - Control */
+	u32 ifls;               /* 0x34 - Interrupt FIFO level select */
+	u32 imsc;               /* 0x38 - Interrupt mask set/clear */
+	u32 ris;                /* 0x3C - Raw interrupt status */
+	u32 mis;                /* 0x40 - Masked interrupt status */
+	u32 icr;                /* 0x44 - Interrupt clear */
+	u32 dmacr;              /* 0x48 - DMA control */
+};
+
+#define RP2350_UART0            ((struct rp2350_uart_regs *)RP2350_UART0_BASE)
+#define RP2350_UART1            ((struct rp2350_uart_regs *)RP2350_UART1_BASE)
+
+/* UART Flag register bits */
+#define UART_FR_TXFF            BIT(5)   /* TX FIFO full */
+#define UART_FR_RXFE            BIT(4)   /* RX FIFO empty */
+#define UART_FR_BUSY            BIT(3)   /* UART busy */
+#define UART_FR_TXFE            BIT(7)   /* TX FIFO empty */
+
+/* UART Line Control bits */
+#define UART_LCR_H_WLEN_8       (0x3 << 5)  /* 8 bit word length */
+#define UART_LCR_H_FEN          BIT(4)      /* FIFO enable */
+
+/* UART Control bits */
+#define UART_CR_UARTEN          BIT(0)   /* UART enable */
+#define UART_CR_TXE             BIT(8)   /* TX enable */
+#define UART_CR_RXE             BIT(9)   /* RX enable */
+
+#define RP2350_IO_BANK0_GPIO_CTRL(n)    RP2350_REG(RP2350_IO_BANK0_BASE,  0x04 + (n) * 0x08)
+#define RP2350_PADS_BANK0_GPIO(n)       RP2350_REG(RP2350_PADS_BANK0_BASE, 0x04 + (n) * 0x04)
+
+/* GPIO function selections */
+#define RP2350_GPIO_FUNC_UART		2
+#define RP2350_PAD_IE			BIT(6)
+#define RP2350_PAD_OD			BIT(7)
+#define RP2350_PAD_ISO			BIT(8)
+#define RESETS_RESET_IO_BANK0		BIT(6)
+#define RESETS_RESET_PADS_BANK0		BIT(9)
+
+/* Peripheral pointer, selected at compile time */
+#if CONFIG_RP2350_EARLY_UART_PORT == 0
+# define RP2350_EARLY_UART   RP2350_UART0
+# define RESETS_RESET_EARLY_UART    RESETS_RESET_UART0
+#elif CONFIG_RP2350_EARLY_UART_PORT == 1
+# define RP2350_EARLY_UART   RP2350_UART1
+# define RESETS_RESET_EARLY_UART    RESETS_RESET_UART1
+#else
+# error "CONFIG_RP2350_EARLY_UART_PORT must be 0 or 1"
+#endif
+
+/*
+ * System clock frequency after PLL init
+ * RP2350 default: 12MHz XOSC -> PLL -> 150MHz system clock
+ *
+ * PLL config for 150MHz:
+ * Same as SDK
+ *   REFDIV=1, FBDIV=125, POSTDIV1=5, POSTDIV2=2
+ *   VCO = 12MHz * 125 = 1500MHz
+ *   SYS = 1500MHz / 5 / 2 = 150MHz
+ */
+#define RP2350_XOSC_HZ          12000000
+#define RP2350_SYS_CLK_HZ       150000000
+#define RP2350_PERI_CLK_HZ      RP2350_SYS_CLK_HZ
+
+/* UART baud rate calculation
+ * BAUDDIV = CLK / (16 * BAUD)
+ * After PLL init CLK_PERI sources from clk_sys which is PLL (150MHz):
+ *  BAUDDIV = 150000000 / (16 * 115200) = 81.3802
+ *  IBRD = 81, FBRD = round(0.3802 * 64) = 24
+ */
+#define RP2350_UART_IBRD_115200         81
+#define RP2350_UART_FBRD_115200         24
+
+/*
+ * Atomic register access
+ * RP2350 (like RP2040) provides atomic set/clear/xor aliases
+ * for all peripheral registers via address offsets
+ */
+#define RP2350_ATOMIC_XOR_OFFSET        0x1000
+#define RP2350_ATOMIC_SET_OFFSET        0x2000
+#define RP2350_ATOMIC_CLR_OFFSET        0x3000
+
+#define rp2350_reg_set(addr, val) \
+	writel(val, (void *)((unsigned long)(addr) + RP2350_ATOMIC_SET_OFFSET))
+#define rp2350_reg_clr(addr, val) \
+	writel(val, (void *)((unsigned long)(addr) + RP2350_ATOMIC_CLR_OFFSET))
+
+void rp2350_soc_init(void);
+void rp2350_uart_early_init(void);
+
+#endif /* ! __ASSEMBLY__ */
+
+#endif /* _MACH_RP2350_H_ */
diff --git a/arch/arm/mach-rp2xxx/Kconfig b/arch/arm/mach-rp2xxx/Kconfig
new file mode 100644
index 00000000000..c914cf7a521
--- /dev/null
+++ b/arch/arm/mach-rp2xxx/Kconfig
@@ -0,0 +1,58 @@
+if ARCH_RP2XXX
+
+config RP2350
+	bool "RP2350 SoC"
+	help
+	  Raspberry Pi RP2350 SoC.
+	  Dual-core ARM Cortex-M33 with TrustZone,
+	  520KB SRAM, supports up to 16MB XIP QSPI flash.
+
+if RP2350
+
+config RP2350_EARLY_UART
+	bool "Enable early UART init for RP2350"
+	default y
+	help
+	  Initialises a UART very early in boot (before driver model) for
+	  low-level debug output.  The peripheral clocks, pad control, and
+	  GPIO mux are configured here from fixed compile-time settings.
+
+if RP2350_EARLY_UART
+
+config RP2350_EARLY_UART_PORT
+	int "Early UART port number (0 or 1)"
+	range 0 1
+	default 1
+	help
+	  Select which UART peripheral to use for early debug output.
+	    0 = UART0  (default; TX=GPIO0, RX=GPIO1)
+	    1 = UART1  (TX=GPIO4, RX=GPIO5)
+
+config RP2350_EARLY_UART_TX_GPIO
+	int "Early UART TX GPIO number"
+	default 0 if RP2350_EARLY_UART_PORT = 0
+	default 4 if RP2350_EARLY_UART_PORT = 1
+	help
+	  GPIO pin for UART TX.  Must match the UART port chosen above and
+	  must be a pin that the RP2350 can route that UART function to.
+	  Overrideable for non-standard board layouts.
+
+config RP2350_EARLY_UART_RX_GPIO
+	int "Early UART RX GPIO number"
+	default 1 if RP2350_EARLY_UART_PORT = 0
+	default 5 if RP2350_EARLY_UART_PORT = 1
+	help
+	  GPIO pin for UART RX.  Must match the UART port chosen above.
+
+endif # RP2350_EARLY_UART
+
+config TARGET_RPI_PICO2
+	bool "Raspberry Pi Pico 2"
+	help
+	  Raspberry Pi Pico 2 board based on RP2350 SoC.
+
+source "board/raspberrypi/pico2/Kconfig"
+
+endif # RP2350
+
+endif # ARCH_RP2XXX
diff --git a/arch/arm/mach-rp2xxx/Makefile b/arch/arm/mach-rp2xxx/Makefile
new file mode 100644
index 00000000000..7da1928d6bb
--- /dev/null
+++ b/arch/arm/mach-rp2xxx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	+= rp2350.o
+obj-y   += image_def.o
diff --git a/arch/arm/mach-rp2xxx/image_def.S b/arch/arm/mach-rp2xxx/image_def.S
new file mode 100644
index 00000000000..7854d94f6ea
--- /dev/null
+++ b/arch/arm/mach-rp2xxx/image_def.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* RP2350 PICOBIN metadata block - placed after the stored vector table */
+
+	.section .image_def, "a"
+	.align 4
+	.global rp2350_image_def
+
+rp2350_image_def:
+	.word 0xffffded3	/* PICOBIN_BLOCK_MARKER_START */
+
+	/* IMAGE_TYPE: EXE | Secure | Arm | RP2350. */
+	.byte 0x42
+	.byte 0x01
+	.hword 0x1021
+
+rp2350_image_def_end_items:
+	.byte 0xff		/* PICOBIN_BLOCK_ITEM_2BS_LAST */
+	.hword (rp2350_image_def_end - rp2350_image_def - 16) / 4
+	.byte 0x00
+
+	.word 0x00000000	/* Relative pointer to next block: self-loop */
+	.word 0xab123579	/* PICOBIN_BLOCK_MARKER_END */
+rp2350_image_def_end:
diff --git a/arch/arm/mach-rp2xxx/rp2350.c b/arch/arm/mach-rp2xxx/rp2350.c
new file mode 100644
index 00000000000..73b45df6866
--- /dev/null
+++ b/arch/arm/mach-rp2xxx/rp2350.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <init.h>
+#include <hang.h>
+#include <asm/io.h>
+#include <asm/armv7_mpu.h>
+#include <asm/arch/rp2350.h>
+
+#define RP2350_RESET_WAIT_LOOPS		1000000U
+
+static void rp2350_wait_reset_done(u32 mask)
+{
+	unsigned int loops = RP2350_RESET_WAIT_LOOPS;
+
+	while (loops--) {
+		if ((readl(&RP2350_RESETS->reset_done) & mask) == mask)
+			return;
+	}
+	/* something is very wrong */
+	hang();
+}
+
+/*
+ * arch_cpu_init() - Called very early, before relocation
+ *
+ * On Cortex-M33 there is no MMU. We configure the MPU instead
+ * to set up memory attributes for flash (XIP) and SRAM regions.
+ *
+ * MPU region map:
+ *   Region 0: XIP Flash  0x10000000 - executable, read-only, cacheable
+ *   Region 1: SRAM       0x20000000 - read/write, cacheable
+ *   Region 2: Peripherals 0x40000000 - read/write, device (non-cacheable)
+ */
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Raspberry Pi RP2350\n");
+	return 0;
+}
+
+int arch_cpu_init(void)
+{
+	int i;
+	struct mpu_region_config rp2350_mpu_config[] = {
+		/*
+		 * Cover ROM + Flash + SRAM (0x00000000 - 0x1FFFFFFF)
+		 * cacheable, executable
+		 */
+		{ 0x00000000, REGION_0, XN_DIS, PRIV_RW_USR_RW,
+		  O_I_WB_RD_WR_ALLOC, REGION_512MB },
+
+		/*
+		 * APB + AHB Peripherals (0x40000000 - 0x5FFFFFFF)
+		 * strongly ordered, no execute
+		 */
+		{ 0x40000000, REGION_1, XN_EN, PRIV_RW_USR_RW,
+		  STRONG_ORDER, REGION_512MB },
+	};
+
+	disable_mpu();
+
+	for (i = 0; i < ARRAY_SIZE(rp2350_mpu_config); i++)
+		mpu_config(&rp2350_mpu_config[i]);
+
+	enable_mpu();
+
+	return 0;
+}
+
+/*
+ * rp2350_xosc_init() - Start the 12MHz crystal oscillator
+ *
+ * The XOSC must be stable before we can configure the PLLs.
+ * RP2350 uses a 12MHz crystal on XIN/XOUT pins.
+ */
+static void rp2350_xosc_init(void)
+{
+	struct rp2350_xosc_regs *xosc = RP2350_XOSC;
+
+	/* Set frequency range (1-15MHz) and startup delay (~1ms) */
+	writel(XOSC_CTRL_FREQ_RANGE_1_15MHZ, &xosc->ctrl);
+	writel(XOSC_STARTUP_DELAY, &xosc->startup);
+
+	/* Enable the oscillator */
+	writel(XOSC_CTRL_FREQ_RANGE_1_15MHZ | XOSC_CTRL_ENABLE, &xosc->ctrl);
+
+	/* Wait for XOSC to become stable */
+	while (!(readl(&xosc->status) & XOSC_STATUS_STABLE))
+		;
+}
+
+/*
+ * rp2350_pll_init() - Configure PLL_SYS for 150MHz
+ *
+ * Target: 150MHz system clock
+ * XOSC = 12MHz
+ * VCO  = 12MHz * 125 = 1500MHz  (FBDIV=125, REFDIV=1)
+ * SYS  = 1500MHz / 5 / 2 = 150MHz (POSTDIV1=5, POSTDIV2=2)
+ */
+static void rp2350_pll_sys_init(void)
+{
+	struct rp2350_pll_regs *pll = RP2350_PLL_SYS;
+	struct rp2350_resets_regs *resets = RP2350_RESETS;
+
+	/* Reset PLL */
+	rp2350_reg_set(&resets->reset, RESETS_RESET_PLL_SYS);
+	rp2350_reg_clr(&resets->reset, RESETS_RESET_PLL_SYS);
+	rp2350_wait_reset_done(RESETS_RESET_PLL_SYS);
+
+	/* Configure: REFDIV=1 */
+	writel(1, &pll->cs);
+
+	/* Power up VCO and set feedback divisor */
+	writel(0, &pll->pwr);          /* Power everything on */
+	writel(PLL_PWR_POSTDIVPD | PLL_PWR_DSMPD, &pll->pwr); /* Keep post dividers and DSM powered down for now, only VCO on */
+
+	writel(125, &pll->fbdiv_int);  /* VCO = 12 * 125 = 1500MHz */
+
+	/* Wait for VCO lock */
+	while (!(readl(&pll->cs) & PLL_CS_LOCK))
+		;
+
+	/* Set post dividers: POSTDIV1=5, POSTDIV2=2 -> 150MHz */
+	writel((5 << PLL_PRIM_POSTDIV1_SHIFT) | (2 << PLL_PRIM_POSTDIV2_SHIFT),
+	       &pll->prim);
+
+	/* Power up post dividers except DSM */
+	writel(PLL_PWR_DSMPD, &pll->pwr);
+}
+
+/*
+ * rp2350_clocks_init() - Switch system clock to PLL_SYS (150MHz)
+ *
+ * After PLL is locked:
+ *   1. Switch CLK_REF to XOSC
+ *   2. Switch CLK_SYS to PLL_SYS
+ *   3. Enable CLK_PERI from CLK_SYS (for UART etc)
+ */
+static void rp2350_clocks_init(void)
+{
+	/*
+	 * Clock register layout
+	 *
+	 * CLK_REF  CTRL @ 0x40010030
+	 * CLK_SYS  CTRL @ 0x4001003C
+	 * CLK_PERI CTRL @ 0x40010048
+	 */
+	void *clk_base = (void *)RP2350_CLOCKS_BASE;
+
+	/*
+	 * CLK_REF → XOSC (src=2)
+	 */
+	clrsetbits_le32(clk_base + 0x30, 0x3, CLK_REF_SRC_XOSC);
+	while (!(readl(clk_base + 0x38) & BIT(CLK_REF_SRC_XOSC)))
+		;
+
+	/*
+	 * CLK_SYS → PLL_SYS
+	 */
+
+	/* set AUXSRC = PLL_SYS (0), leave SRC unchanged */
+	clrsetbits_le32(clk_base + 0x3C, (0x7 << 5), (0x0 << 5));
+
+	/* switch glitchless mux to aux */
+	clrsetbits_le32(clk_base + 0x3C, 0x3, 0x1);
+
+	/* Wait for CLK_SYS to settle on new source */
+	while (!(readl(clk_base + 0x44) & BIT(1)))
+		;
+
+	/*
+	 * CLK_PERI → CLK_SYS (150MHz)
+	 * CTRL @ +0x48
+	 *   bit  11    = ENABLE
+	 *   bits [7:5] = AUXSRC: 0 = clk_sys
+	 */
+	writel(BIT(11) | (0 << 5), clk_base + 0x48);
+}
+
+/*
+ * rp2350_uart_early_init() - Minimal UART init for early console
+ *
+ * Called before driver model is up. Sets up UART1 at 115200 8N1.
+ * GPIO pins for UART1: TX=GPIO4, RX=GPIO5
+ * Clock source: CLK_SYS == CLK_PERI == 150MHz
+ */
+void rp2350_uart_early_init(void)
+{
+	struct rp2350_uart_regs *uart = RP2350_EARLY_UART;
+	struct rp2350_resets_regs *resets = RP2350_RESETS;
+	u32 pad;
+	unsigned int tx = CONFIG_RP2350_EARLY_UART_TX_GPIO;
+	unsigned int rx = CONFIG_RP2350_EARLY_UART_RX_GPIO;
+
+	/* Ensure IO_BANK0/PADS_BANK0 and UART1 are all out of reset. */
+	rp2350_reg_clr(&resets->reset,
+		       RESETS_RESET_IO_BANK0 |
+		       RESETS_RESET_PADS_BANK0);
+
+	rp2350_wait_reset_done(RESETS_RESET_IO_BANK0 |
+			       RESETS_RESET_PADS_BANK0);
+
+	/*
+	 * Match SDK gpio_set_function() behavior for UART pins.
+	 */
+	pad = readl((void *)RP2350_PADS_BANK0_GPIO(tx));
+	pad &= ~(RP2350_PAD_OD | RP2350_PAD_ISO);
+	pad |= RP2350_PAD_IE;
+	writel(pad, (void *)RP2350_PADS_BANK0_GPIO(tx));
+
+	pad = readl((void *)RP2350_PADS_BANK0_GPIO(rx));
+	pad &= ~(RP2350_PAD_OD | RP2350_PAD_ISO);
+	pad |= RP2350_PAD_IE;
+	writel(pad, (void *)RP2350_PADS_BANK0_GPIO(rx));
+
+	writel(RP2350_GPIO_FUNC_UART, (void *)RP2350_IO_BANK0_GPIO_CTRL(tx));
+	writel(RP2350_GPIO_FUNC_UART, (void *)RP2350_IO_BANK0_GPIO_CTRL(rx));
+
+	/* Release UART from reset */
+	rp2350_reg_set(&resets->reset, RESETS_RESET_EARLY_UART);
+	rp2350_reg_clr(&resets->reset, RESETS_RESET_EARLY_UART);
+	rp2350_wait_reset_done(RESETS_RESET_EARLY_UART);
+
+	/* Disable UART before configuration */
+	writel(0, &uart->cr);
+
+	/* Set baud rate: 115200 at 150MHz CLK_SYS/CLK_PERI
+	 * BAUDDIV = 150000000 / (16 * 115200) = 81.3802
+	 * IBRD = 81, FBRD = round(0.3802 * 64) = 24
+	 */
+	writel(RP2350_UART_IBRD_115200, &uart->ibrd);
+	writel(RP2350_UART_FBRD_115200, &uart->fbrd);
+
+	/* 8N1, FIFO enabled */
+	writel(UART_LCR_H_WLEN_8 | UART_LCR_H_FEN, &uart->lcr_h);
+
+	/* Enable UART, TX, RX */
+	writel(UART_CR_UARTEN | UART_CR_TXE | UART_CR_RXE, &uart->cr);
+}
+
+/*
+ * rp2350_soc_init() - Full SoC initialization sequence
+ *
+ * Called from board_init_f() early path.
+ * Order matters:
+ *   1. XOSC  - stable reference clock
+ *   2. PLL   - multiply up to 150MHz
+ *   3. Clocks - switch system to PLL
+ *   4. UART  - console ready
+ */
+void rp2350_soc_init(void)
+{
+	/* Start XOSC (12MHz crystal) for a stable, precise clock */
+	rp2350_xosc_init();
+	/* Setup PLL */
+	rp2350_pll_sys_init();
+	/* Setup clocks to use PLL and set 150MHz for clk_sys/clk_peri */
+	rp2350_clocks_init();
+	/* Now init UART - it will source clk_peri from clk_sys */
+	rp2350_uart_early_init();
+}
diff --git a/arch/arm/mach-rp2xxx/u-boot.lds b/arch/arm/mach-rp2xxx/u-boot.lds
new file mode 100644
index 00000000000..200c37d6a13
--- /dev/null
+++ b/arch/arm/mach-rp2xxx/u-boot.lds
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * RP2350 U-Boot linker script
+ *
+ * Based on arch/arm/cpu/u-boot.lds
+ * Modified to include RP2350 IMAGE_DEF block after vector table
+ */
+
+OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
+OUTPUT_ARCH(arm)
+ENTRY(_start)
+SECTIONS
+{
+	. = 0x00000000;
+
+	. = ALIGN(4);
+	__image_copy_start = ADDR(.text);
+	.text :
+	{
+		*(.vectors)                /* Cortex-M33 vector table at image start */
+		KEEP(*(.image_def))         /* RP2350 IMAGE_DEF block loop */
+		arch/arm/cpu/armv7m/start.o (.text*)
+	}
+
+	.efi_runtime : {
+		__efi_runtime_start = .;
+		*(.text.efi_runtime*)
+		*(.rodata.efi_runtime*)
+		*(.data.efi_runtime*)
+		__efi_runtime_stop = .;
+	}
+
+	.text_rest :
+	{
+		*(.text*)
+	}
+
+	. = ALIGN(4);
+	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
+
+	. = ALIGN(4);
+	.data : {
+		*(.data*)
+	}
+
+	. = ALIGN(4);
+	. = .;
+	. = ALIGN(4);
+
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
+	}
+
+	.efi_runtime_rel : {
+		__efi_runtime_rel_start = .;
+		*(.rel*.efi_runtime)
+		*(.rel*.efi_runtime.*)
+		__efi_runtime_rel_stop = .;
+	}
+
+	. = ALIGN(8);
+	__image_copy_end = .;
+
+	.rel.dyn ALIGN(8) : {
+		__rel_dyn_start = .;
+		*(.rel*)
+		__rel_dyn_end = .;
+		. = ALIGN(8);
+	}
+
+	_end = .;
+	_image_binary_end = .;
+
+	.bss ADDR(.rel.dyn) (OVERLAY): {
+		__bss_start = .;
+		*(.bss*)
+		. = ALIGN(4);
+		__bss_end = .;
+	}
+
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynbss) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu.hash) }
+	/DISCARD/ : { *(.gnu*) }
+	/DISCARD/ : { *(.ARM.exidx*) }
+	/DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
+}
+
+ASSERT(_image_binary_end % 8 == 0, \
+       "_image_binary_end must be 8-byte aligned for device tree");
-- 
2.43.0

