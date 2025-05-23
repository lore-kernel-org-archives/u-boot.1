Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C59C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4F583276;
	Fri, 23 May 2025 15:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bo3HIH5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1002D83236; Fri, 23 May 2025 15:07:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7CD383108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442d146a1aaso90594405e9.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005668; x=1748610468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7z3GiAcig6AEAXgxodGEGOP7oXtQwHKeIIS3C8aWSc=;
 b=Bo3HIH5IrrV0gFWGQWAgn/WaflUilYcRnwLH9bfrW3pTq+qOVu3ykbJEuXMML1z9zm
 QztY+qNCaI8DikzGoteYAPgFWC+Mla2j13t6hISbEBBJRKKKJs/pEqbJnCTfIxI/Pr8w
 gpQl3Ko9qQA8OvXEU5o+hwd3LmquJPKUURQaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005668; x=1748610468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7z3GiAcig6AEAXgxodGEGOP7oXtQwHKeIIS3C8aWSc=;
 b=KbFLkPU/0srXLwj4E1zdLZkSHwIHAKjD2zfv3MsXU3uf4eV6SF2wF1SXwcCeqU34Rg
 D3YAIBYF394vKB8CEEGZfC0Tpj03h6rO39uFx44LoATLcOhFlk/Pm+Kor/SiUJwMf+mC
 YH+vnIyAE3mouCt+qUHLN2IK4yiyXo7t30oHoVYOguWZV8rGu+4zYNHDlNqo6TP0gk9I
 Gp4cMxOwz2DXUp8/xGBD+KiDTl8SCoxHHR2VuEWpaQKj2Fjpx4C9/8nlyj92Nq9bjUlU
 pLIm9AwdKiolTPH44Pr+fFqpSrV/l+rNqQHEkaoxDCMTQi9U6pfRYzo/R59MFkx35etI
 ahQg==
X-Gm-Message-State: AOJu0YwwInllMdSlHtvN7f3nO2tDPhT1P8btrigiIhkVUm21z4ZVvom9
 yYUA1715ZGxq2TnvXYUcLWxNihPKxhs8n09f78F7oDxPTf045qIpDezoAcsoBuJN8Y5UtikWz91
 NKLZzcxx3
X-Gm-Gg: ASbGncsNiTyOISTLAUBlKZhP/1p+rHEnB82mIy8hP7jX14syf2hPlgKxWe/kjxU3E+i
 R2Dxy01STeBIPbaZxUym4fW8+VE3qTxvA0Qp4knqhDtWp4ObNP9WVWh4m7p9+vFpHSo+ct9rYcq
 //oW9zl4FT4l2+XYwSAUdssVvrHeAjgPlig6CWP9x9BOTanfNpTM1Xsa0O4UAeRjggTdqzDBbsm
 V+JEPpLILWlaorDvIGYqv2PFVGj6Na30VbAC3ACwJbhOTeETSsYdWRHIBSdIGyBaTRkgtg5a8Ck
 W7mK0TxOW+mrnh3e3/6qevZmAbWXxxr7CFTjv2Mg/0RbG8jKaYdzo8rQ6Xc9L9N5RfFwQ7Y=
X-Google-Smtp-Source: AGHT+IEui58qICWI8Pa4p2fudnaCazJkEPhswj1938dYne7yU5ZhogkBUIfo0lR4cYrOWp7WOKO9Hw==
X-Received: by 2002:a5d:60cd:0:b0:3a4:c7b3:2b0c with SMTP id
 ffacd0b85a97d-3a4c7b32c31mr391360f8f.55.1748005667598; 
 Fri, 23 May 2025 06:07:47 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 05/10] efi: Rename CONFIG_EFI to CONFIG_EFI_CLIENT
Date: Fri, 23 May 2025 14:06:40 +0100
Message-ID: <20250523130651.1329593-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

 arch/arm/include/asm/global_data.h  |  2 +-
 arch/x86/Kconfig                    |  6 +++---
 arch/x86/cpu/Makefile               |  2 +-
 arch/x86/cpu/efi/Kconfig            |  2 +-
 arch/x86/cpu/x86_64/Makefile        |  2 +-
 cmd/Makefile                        |  2 +-
 cmd/part_find.c                     | 10 +++++-----
 configs/efi-arm_app64_defconfig     |  2 +-
 configs/efi-x86_app32_defconfig     |  2 +-
 configs/efi-x86_app64_defconfig     |  2 +-
 configs/efi-x86_payload32_defconfig |  2 +-
 configs/efi-x86_payload64_defconfig |  2 +-
 doc/develop/uefi/u-boot_on_efi.rst  |  6 +++---
 drivers/block/Kconfig               |  2 +-
 include/init.h                      |  2 +-
 lib/Kconfig                         |  2 +-
 lib/Makefile                        |  2 +-
 lib/efi_client/Kconfig              |  4 ++--
 lib/uuid.c                          |  4 ++--
 19 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index ba12da6204e..16466adc5c8 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -108,7 +108,7 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
-#ifdef CONFIG_EFI
+#ifdef CONFIG_EFI_CLIENT
 	ulong table;	/* holds the table address from previous EFI firmware */
 #endif
 };
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e81d419b2e1..990e13673c7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -367,7 +367,7 @@ config USE_HOB
 
 config HAVE_FSP
 	bool "Add an Firmware Support Package binary"
-	depends on !EFI
+	depends on !EFI_CLIENT
 	select USE_HOB
 	select HAS_ROM
 	help
@@ -515,7 +515,7 @@ config FSP_BROKEN_HOB
 
 config ENABLE_MRC_CACHE
 	bool "Enable MRC cache"
-	depends on !EFI && !SYS_COREBOOT
+	depends on !EFI_CLIENT && !SYS_COREBOOT
 	help
 	  Enable this feature to cause MRC data to be cached in NV storage
 	  to be used for speeding up boot time on future reboots and/or
@@ -754,7 +754,7 @@ config HAVE_P2SB
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
index 2874232224e..651c5af081f 100644
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
 obj-$(CONFIG_CMD_EFI_GET_ENV) += efigetenv.o
diff --git a/cmd/part_find.c b/cmd/part_find.c
index 8c071d3c374..c39fce21e40 100644
--- a/cmd/part_find.c
+++ b/cmd/part_find.c
@@ -10,7 +10,7 @@
 #include <dm.h>
 #include <env.h>
 #include <part.h>
-#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
+#if defined(CONFIG_EFI_CLIENT) || defined(CONFIG_EFI_APP)
 #include <efi.h>
 #include <efi_api.h>
 
@@ -51,7 +51,7 @@ static bool partition_is_on_device(const struct efi_device_path *device,
 
 static int part_find(int argc, char *const argv[])
 {
-#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
+#if defined(CONFIG_EFI_CLIENT) || defined(CONFIG_EFI_APP)
 	efi_guid_t efi_devpath_guid = EFI_DEVICE_PATH_PROTOCOL_GUID;
 	struct efi_device_path *loaded_image_path = NULL;
 	struct efi_boot_services *boot = efi_get_boot();
@@ -70,7 +70,7 @@ static int part_find(int argc, char *const argv[])
 	if (argc != 2)
 		return CMD_RET_USAGE;
 
-#if defined(CONFIG_EFI) || defined (CONFIG_EFI_APP)
+#if defined(CONFIG_EFI_CLIENT) || defined(CONFIG_EFI_APP)
 	part_self = !strncmp(argv[1], "self", 6);
 	if (part_self) {
 		ret = boot->handle_protocol(priv->loaded_image->device_handle,
@@ -95,7 +95,7 @@ static int part_find(int argc, char *const argv[])
 			if (udev->driver != entry)
 				continue;
 			desc = dev_get_uclass_plat(udev);
-#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
+#if defined(CONFIG_EFI_CLIENT) || defined(CONFIG_EFI_APP)
 			if (part_self) {
 				if (desc->if_type == IF_TYPE_EFI_MEDIA) {
 					struct efi_media_plat *plat =
@@ -131,7 +131,7 @@ static int part_find(int argc, char *const argv[])
 						return CMD_RET_SUCCESS;
 					}
 				}
-#if defined(CONFIG_EFI) || defined(CONFIG_EFI_APP)
+#if defined(CONFIG_EFI_CLIENT) || defined(CONFIG_EFI_APP)
 			}
 #endif
 		}
diff --git a/configs/efi-arm_app64_defconfig b/configs/efi-arm_app64_defconfig
index 0199fb16467..f2ed6069d74 100644
--- a/configs/efi-arm_app64_defconfig
+++ b/configs/efi-arm_app64_defconfig
@@ -8,7 +8,7 @@ CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_DEBUG_UART=y
 CONFIG_TARGET_EFI_ARM_APP64=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_EFI_APP_64BIT=y
 CONFIG_FIT=y
 # CONFIG_BOOTSTD is not set
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index c9346da7d47..79c4d920b9d 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -7,7 +7,7 @@ CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_ARCH_EFI_X86=y
 CONFIG_TARGET_EFI_X86_APP32=y
 CONFIG_DEBUG_UART=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_FIT=y
 # CONFIG_BOOTSTD is not set
 CONFIG_SHOW_BOOT_PROGRESS=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 5bc1e9e5cd9..6f369328db1 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -8,7 +8,7 @@ CONFIG_X86_RUN_64BIT=y
 CONFIG_ARCH_EFI_X86=y
 CONFIG_TARGET_EFI_X86_APP64=y
 CONFIG_DEBUG_UART=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_EFI_APP_64BIT=y
 CONFIG_FIT=y
 # CONFIG_BOOTSTD is not set
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 65e562e1bc8..cf827fefd45 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -5,7 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_ARCH_EFI_X86=y
 CONFIG_TARGET_EFI_X86_PAYLOAD=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_EFI_STUB=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index 4f341f43ed9..bdf61e204a3 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -5,7 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
 CONFIG_PRE_CON_BUF_ADDR=0x100000
 CONFIG_ARCH_EFI_X86=y
 CONFIG_TARGET_EFI_X86_PAYLOAD=y
-CONFIG_EFI=y
+CONFIG_EFI_CLIENT=y
 CONFIG_EFI_STUB=y
 CONFIG_EFI_STUB_64BIT=y
 CONFIG_FIT=y
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index ba3b3f501f1..a687eb3d691 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -46,7 +46,7 @@ First choose a board that has EFI support and obtain an EFI implementation
 for that board. It will be either 32-bit or 64-bit. Alternatively, you can
 opt for using QEMU [1] and the OVMF [2], as detailed below.
 
-To build U-Boot as an EFI application, enable CONFIG_EFI and CONFIG_EFI_APP.
+To build U-Boot as an EFI application, enable CONFIG_EFI_CLIENT and CONFIG_EFI_APP.
 The efi-x86_app32 and efi-x86_app64 configs are set up for this. Just build
 U-Boot as normal, e.g.::
 
@@ -54,7 +54,7 @@ U-Boot as normal, e.g.::
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
index cc75bad02b8..adf13f2a243 100644
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
index f2d0470aec2..7413e18d834 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1072,7 +1072,7 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
 menu "System tables"
-	depends on (!EFI && !SYS_COREBOOT) || (ARM && EFI_LOADER)
+	depends on (!EFI_CLIENT && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
 config BLOBLIST_TABLES
 	bool "Put tables in a bloblist"
diff --git a/lib/Makefile b/lib/Makefile
index 95f11903d57..429347f97a2 100644
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
index 18b73965469..b6446179b67 100644
--- a/lib/efi_client/Kconfig
+++ b/lib/efi_client/Kconfig
@@ -1,7 +1,7 @@
 menu "U-Boot as UEFI application"
 	depends on X86 || ARM
 
-config EFI
+config EFI_CLIENT
 	bool "Support running U-Boot from EFI"
 	depends on X86 || ARM
 	imply X86_TSC_READ_BASE
@@ -13,7 +13,7 @@ config EFI
 
 choice
 	prompt "Select EFI mode to use"
-	depends on EFI
+	depends on EFI_CLIENT
 
 config EFI_APP
 	bool "Support running as an EFI application"
diff --git a/lib/uuid.c b/lib/uuid.c
index 75658778044..00d7b9a7e18 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -82,7 +82,7 @@ static const struct {
 	{"cros-fw",	PARTITION_CROS_FIRMWARE},
 	{"cros-rsrv",	PARTITION_CROS_RESERVED},
 #endif
-#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
+#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_CLIENT)
 	{
 		"Device Path",
 		EFI_DEVICE_PATH_PROTOCOL_GUID,
@@ -269,7 +269,7 @@ static const struct {
 		EFI_CERT_TYPE_PKCS7_GUID,
 	},
 #endif
-#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI)
+#if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_CLIENT)
 	{ "EFI_LZMA_COMPRESSED", EFI_LZMA_COMPRESSED },
 	{ "EFI_DXE_SERVICES", EFI_DXE_SERVICES },
 	{ "EFI_HOB_LIST", EFI_HOB_LIST },
-- 
2.43.0

