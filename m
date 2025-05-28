Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CF0C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D50283938;
	Wed, 28 May 2025 18:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="arwqanpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E849883956; Wed, 28 May 2025 18:08:32 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63AC683903
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3da82c6c5d4so37841715ab.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748448508; x=1749053308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8piYSTEbSv+mdRNWf/qNT7tN+2JQjkzWLWAktaU3ZY=;
 b=arwqanpkbPPSEDysh+LXWO6x3UY49X3JeaiyjKGtA5VFgUgHbZ+J0GYvaNAqXyhE0a
 5C4+C94td1NmGt92JNAPHAZXZ2xVYKNwveX4QCROyBL8gkvKg7KJ8M6geOHjuBfGWAdn
 UzlLd/ReSlwe6n8PM7/cLWBf/hwxowJdkgiNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748448508; x=1749053308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8piYSTEbSv+mdRNWf/qNT7tN+2JQjkzWLWAktaU3ZY=;
 b=DVjdbBHUUPaBR84hj+MT9Js86fNoEtZ8hRpy3khLb3sfod3JyqJkpqcpIcH/lh0D8T
 Yu8fkJqfyvc1wwaee6H9Jjinf8wDIkuWIh8s8YBc3bwDzTDWkKETlDpdYVmIAKTMY4ku
 GoSkz+f7UOPhh+QKlrPu+CwHrsvI9Bt+orvKe2NzKLRjRxtkd4Mp7s672A+k7/382SKn
 IylV/HQTjzYw1PyXY54BYoewg9vzcjqXSH6QSsfdh1AD3quFZqpXESy31KdzC3H6uFYy
 guLaCe4DJ77YY2F6fO/bfZ6PxPQu3i9W1387sbQzUH1hInKb5Tk+g4gFD8kcbAms7j+X
 Z0cA==
X-Gm-Message-State: AOJu0Yw7/U7ofSkiAfLG2zuhZzHYUfA1jjVIGX/ytra10TdzAYMhvEG4
 f21rxXsD3RiRtFl2X2X9ak538UyjqwpUJp1qa0js2DEElFU/WHEDSElZMRQUP9iarCUlrT2oxKn
 ZuS5wNRkz
X-Gm-Gg: ASbGncvpXB9lB/gxb6avqtARCKStbGRVIh614Ysb7ry3HcXvXHEeJqwjIrwlvBU2nmt
 ROAjHagPrHhhIAXCtDsMXwUsZrwAz0TcMAV9Sv6610rzzKsG+De786cCAmxqXitqhip9fVINyUI
 7aCRDhu/bZcTWhI0Pa9xPAok9UbCw7d9LrTO6sOMdiTNhh/Hz9UuJiw1kngpm5PXquFBE16gNHm
 +Cj2KHifEeoNMLtf7TqERHcr5OxW0PH4aIOTAbFsf4QqVa/i3DtyZErAfNa3TowZKHwirjcMzua
 qO0ERNTRbR/w8GFpshY6nY0AZZ6G5Z24ZFuB1gG0Q6zfCpi82m4LXo9PN2iKXv9OnmTwTinsLKN
 tSdtR67qFFQAL
X-Google-Smtp-Source: AGHT+IES/otPsj/QM8gzFQo9lNS76TkDHs+cAOAansf2hdPdWGgSfm/ZNbMRLNKXN2I3mlK5HrfjjA==
X-Received: by 2002:a05:6e02:3305:b0:3dc:8b29:30a8 with SMTP id
 e9e14a558f8ab-3dc9b6a9fb3mr184365825ab.2.1748448508418; 
 Wed, 28 May 2025 09:08:28 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd586873sm276277173.90.2025.05.28.09.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 09:08:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 2/4] efi: Rename CONFIG_EFI to CONFIG_EFI_CLIENT
Date: Wed, 28 May 2025 10:03:15 -0600
Message-ID: <20250528160323.1184731-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528160323.1184731-1-sjg@chromium.org>
References: <20250528160323.1184731-1-sjg@chromium.org>
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

The generic name 'EFI' would be more useful for common EFI features. At
present it just refers to the EFI app and stub, which is confusing.

Rename it to EFI_CLIENT

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/Kconfig                    | 6 +++---
 arch/x86/cpu/Makefile               | 2 +-
 arch/x86/cpu/efi/Kconfig            | 2 +-
 arch/x86/cpu/x86_64/Makefile        | 2 +-
 cmd/Makefile                        | 2 +-
 configs/efi-x86_app32_defconfig     | 2 +-
 configs/efi-x86_app64_defconfig     | 2 +-
 configs/efi-x86_payload32_defconfig | 2 +-
 configs/efi-x86_payload64_defconfig | 2 +-
 doc/develop/uefi/u-boot_on_efi.rst  | 6 +++---
 drivers/block/Kconfig               | 2 +-
 include/init.h                      | 2 +-
 lib/Kconfig                         | 2 +-
 lib/Makefile                        | 2 +-
 lib/efi_client/Kconfig              | 4 ++--
 lib/uuid.c                          | 6 +++---
 test/common/print.c                 | 2 +-
 17 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6ca0605466f..5aa134b6bcb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -368,7 +368,7 @@ config USE_HOB
 
 config HAVE_FSP
 	bool "Add an Firmware Support Package binary"
-	depends on !EFI
+	depends on !EFI_CLIENT
 	select USE_HOB
 	select HAS_ROM
 	help
@@ -517,7 +517,7 @@ config FSP_BROKEN_HOB
 
 config ENABLE_MRC_CACHE
 	bool "Enable MRC cache"
-	depends on !EFI && !SYS_COREBOOT
+	depends on !EFI_CLIENT && !SYS_COREBOOT
 	help
 	  Enable this feature to cause MRC data to be cached in NV storage
 	  to be used for speeding up boot time on future reboots and/or
@@ -756,7 +756,7 @@ config HAVE_P2SB
 	  devices.
 
 menu "System tables"
-	depends on !EFI && !SYS_COREBOOT
+	depends on !EFI_CLIENT && !SYS_COREBOOT
 
 config GENERATE_PIRQ_TABLE
 	bool "Generate a PIRQ table"
diff --git a/arch/x86/cpu/Makefile b/arch/x86/cpu/Makefile
index cc55c8fa39c..5150edb833f 100644
--- a/arch/x86/cpu/Makefile
+++ b/arch/x86/cpu/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_INTEL_BRASWELL) += braswell/
 obj-$(CONFIG_INTEL_BROADWELL) += broadwell/
 obj-$(CONFIG_SYS_COREBOOT) += coreboot/
 obj-$(CONFIG_SYS_SLIMBOOTLOADER) += slimbootloader/
-obj-$(CONFIG_EFI) += efi/
+obj-$(CONFIG_EFI_CLIENT) += efi/
 obj-$(CONFIG_QEMU) += qemu/
 obj-$(CONFIG_NORTHBRIDGE_INTEL_IVYBRIDGE) += ivybridge/
 obj-$(CONFIG_INTEL_QUARK) += quark/
diff --git a/arch/x86/cpu/efi/Kconfig b/arch/x86/cpu/efi/Kconfig
index e0975d34d36..f5288013a8a 100644
--- a/arch/x86/cpu/efi/Kconfig
+++ b/arch/x86/cpu/efi/Kconfig
@@ -1,4 +1,4 @@
-if EFI
+if EFI_CLIENT
 
 config SYS_CAR_ADDR
 	hex
diff --git a/arch/x86/cpu/x86_64/Makefile b/arch/x86/cpu/x86_64/Makefile
index e929563b2c1..cb23c071aa3 100644
--- a/arch/x86/cpu/x86_64/Makefile
+++ b/arch/x86/cpu/x86_64/Makefile
@@ -5,6 +5,6 @@
 
 obj-y += cpu.o interrupts.o setjmp.o
 
-ifndef CONFIG_EFI
+ifndef CONFIG_EFI_CLIENT
 obj-y += misc.o
 endif
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8..06b07813bf6 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_CMD_EXTENSION) += extension_board.o
 obj-$(CONFIG_CMD_ECHO) += echo.o
 obj-$(CONFIG_ENV_IS_IN_EEPROM) += eeprom.o
 obj-$(CONFIG_CMD_EEPROM) += eeprom.o
-obj-$(CONFIG_EFI) += efi.o efi_common.o
+obj-$(CONFIG_EFI_CLIENT) += efi.o efi_common.o
 obj-$(CONFIG_CMD_EFIDEBUG) += efidebug.o efi_common.o
 obj-$(CONFIG_CMD_EFICONFIG) += eficonfig.o
 ifdef CONFIG_CMD_EFICONFIG
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index c730945f4f9..5e551b47dcf 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -7,7 +7,7 @@ CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_VENDOR_EFI=y
 CONFIG_TARGET_EFI_APP32=y
 CONFIG_DEBUG_UART=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_FIT=y
 # CONFIG_BOOTSTD is not set
 CONFIG_SHOW_BOOT_PROGRESS=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 1831fb2d5a7..f7af05710af 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -8,7 +8,7 @@ CONFIG_X86_RUN_64BIT=y
 CONFIG_VENDOR_EFI=y
 CONFIG_TARGET_EFI_APP64=y
 CONFIG_DEBUG_UART=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_EFI_APP_64BIT=y
 CONFIG_FIT=y
 # CONFIG_BOOTSTD is not set
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 957fd83e432..e6e40c6a06c 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -5,7 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_VENDOR_EFI=y
 CONFIG_TARGET_EFI_PAYLOAD=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_EFI_STUB=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 71612d7fb19..55276790ee0 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -5,7 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_VENDOR_EFI=y
 CONFIG_TARGET_EFI_PAYLOAD=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_EFI_STUB=y
 CONFIG_EFI_STUB_64BIT=y
 CONFIG_FIT=y
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 42e84c13049..9068894e408 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -45,7 +45,7 @@ First choose a board that has EFI support and obtain an EFI implementation
 for that board. It will be either 32-bit or 64-bit. Alternatively, you can
 opt for using QEMU [1] and the OVMF [2], as detailed below.
 
-To build U-Boot as an EFI application, enable CONFIG_EFI and CONFIG_EFI_APP.
+To build U-Boot as an EFI application, enable CONFIG_EFI_CLIENT and CONFIG_EFI_APP.
 The efi-x86_app32 and efi-x86_app64 configs are set up for this. Just build
 U-Boot as normal, e.g.::
 
@@ -53,7 +53,7 @@ U-Boot as normal, e.g.::
    make
 
 To build U-Boot as an EFI payload (32-bit or 64-bit EFI can be used), enable
-CONFIG_EFI, CONFIG_EFI_STUB, and select either CONFIG_EFI_STUB_32BIT or
+CONFIG_EFI_CLIENT, CONFIG_EFI_STUB, and select either CONFIG_EFI_STUB_32BIT or
 CONFIG_EFI_STUB_64BIT. The efi-x86_payload configs (efi-x86_payload32_defconfig
 and efi-x86_payload32_defconfig) are set up for this. Then build U-Boot as
 normal, e.g.::
@@ -121,7 +121,7 @@ and board_init_r()).
 Since U-Boot limits its memory access to the allocated regions very little
 special code is needed. The CONFIG_EFI_APP option controls a few things
 that need to change so 'git grep CONFIG_EFI_APP' may be instructive.
-The CONFIG_EFI option controls more general EFI adjustments.
+The CONFIG_EFI_CLIENT option controls more general EFI adjustments.
 
 The only available driver is the serial driver. This calls back into EFI
 'boot services' to send and receive characters. Although it is implemented
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 750b0bd2082..c6c148ebd17 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -96,7 +96,7 @@ config TPL_BLOCK_CACHE
 
 config EFI_MEDIA
 	bool "Support EFI media drivers"
-	default y if EFI || SANDBOX
+	default y if EFI_CLIENT || SANDBOX
 	select BLK
 	help
 	  Enable this to support media devices on top of UEFI. This enables
diff --git a/include/init.h b/include/init.h
index 2c10171359c..1e375da4893 100644
--- a/include/init.h
+++ b/include/init.h
@@ -18,7 +18,7 @@
  * In case of the EFI app the UEFI firmware provides the low-level
  * initialisation.
  */
-#ifdef CONFIG_EFI
+#ifdef CONFIG_EFI_CLIENT
 #define ll_boot_init()	false
 #else
 #include <asm/global_data.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index 6a89f797bef..fbc9de90669 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1096,7 +1096,7 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
 menu "System tables"
-	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
+	depends on (!EFI_CLIENT && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
 config BLOBLIST_TABLES
 	bool "Put tables in a bloblist"
diff --git a/lib/Makefile b/lib/Makefile
index 1dd738a7cd1..2643bfc867c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@
 
 ifndef CONFIG_XPL_BUILD
 
-obj-$(CONFIG_EFI) += efi_client/
+obj-$(CONFIG_EFI_CLIENT) += efi_client/
 obj-$(CONFIG_EFI_LOADER) += efi_driver/
 obj-$(CONFIG_EFI_LOADER) += efi_loader/
 obj-$(CONFIG_CMD_BOOTEFI_SELFTEST) += efi_selftest/
diff --git a/lib/efi_client/Kconfig b/lib/efi_client/Kconfig
index 81ed3e66b34..ec413639bfe 100644
--- a/lib/efi_client/Kconfig
+++ b/lib/efi_client/Kconfig
@@ -1,7 +1,7 @@
 menu "U-Boot as UEFI application"
 	depends on X86
 
-config EFI
+config EFI_CLIENT
 	bool "Support running U-Boot from EFI"
 	depends on X86
 	imply X86_TSC_READ_BASE
@@ -13,7 +13,7 @@ config EFI
 
 choice
 	prompt "Select EFI mode to use"
-	depends on X86 && EFI
+	depends on X86 && EFI_CLIENT
 
 config EFI_APP
 	bool "Support running as an EFI application"
diff --git a/lib/uuid.c b/lib/uuid.c
index 6abbcf27b1f..e53da007d81 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -68,7 +68,7 @@ static const struct {
 } list_guid[] = {
 #ifndef USE_HOSTCC
 #if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) || \
-	defined(CONFIG_EFI)
+	defined(CONFIG_EFI_CLIENT)
 	{"EFI System Partition", PARTITION_SYSTEM_GUID},
 #endif
 #ifdef CONFIG_PARTITION_TYPE_GUID
@@ -85,7 +85,7 @@ static const struct {
 	{"cros-fw",	PARTITION_CROS_FIRMWARE},
 	{"cros-rsrv",	PARTITION_CROS_RESERVED},
 #endif
-#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
+#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_CLIENT)
 	{
 		"Device Path",
 		EFI_DEVICE_PATH_PROTOCOL_GUID,
@@ -268,7 +268,7 @@ static const struct {
 		EFI_CERT_TYPE_PKCS7_GUID,
 	},
 #endif
-#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
+#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_CLIENT)
 	{ "EFI_LZMA_COMPRESSED", EFI_LZMA_COMPRESSED },
 	{ "EFI_DXE_SERVICES", EFI_DXE_SERVICES },
 	{ "EFI_HOB_LIST", EFI_HOB_LIST },
diff --git a/test/common/print.c b/test/common/print.c
index c48efc2783f..52a54f08b00 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -46,7 +46,7 @@ static int print_guid(struct unit_test_state *uts)
 	ut_asserteq_str("04030201-0605-0807-090A-0B0C0D0E0F10", str);
 	sprintf(str, "%pUs", guid_esp);
 	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) ||
-	    IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI))
+	    IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI_CLIENT))
 		ut_asserteq_str("EFI System Partition", str);
 	else
 		ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
-- 
2.43.0

base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
branch: efit
