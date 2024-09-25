Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D21C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC0488CDA;
	Wed, 25 Sep 2024 14:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A5ewQAGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A273A88D57; Wed, 25 Sep 2024 14:58:22 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8780088D16
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbe0so7764810a12.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269098; x=1727873898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6jWy3gw1UWZcQDEYDMsiSdyrKnfQHXx2Gp+yrXGbrA=;
 b=A5ewQAGGQrETQUSQUTrZqPfH0pKMfvSTBWDR53YNq/JJ2MvZX1V+azCwSSnTxDRs7b
 1+7KRCZLQlwknlne1W22JRJ0WGEKloHC52lfEtL9xUqDJwwQ9NBFGgK5iQQiRxk7ya9T
 d4OanYP9s47ZvhqXJT7O7D3kglMLyj5phoIGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269098; x=1727873898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6jWy3gw1UWZcQDEYDMsiSdyrKnfQHXx2Gp+yrXGbrA=;
 b=mjD2LFxKXL2N58WDpEhnz+wiyKVHKGxLhBFUROCp4LuLNnd5ejKG2yKAkd+rKbjMYV
 7w63n4t88Uf20ltQgrJ0AnL+Yp+B/RlRp1GV35IL4aNTrHyTO4RQV3Ume/coiEmBuRr6
 /AeHSoOzfCo6axqx5+G6fBGRHpL02S/n49lHUdUpbfYIAPQd0L9jaMEwMQsN7psl15sh
 UXaFuu4PsjuMGyBmFsQAA7bCdw/0uK+Qpk0V1TK2Qk0wTu237PNOOmLaSbhbw1MPeR4L
 nH0sVlo7Mvem11AKASeRTwcD9aHmm4ZZZ7IGDYaiWvdwuFcNYHn0J5WrUFWKt7GIXbDC
 /wRg==
X-Gm-Message-State: AOJu0Yy2ARiFVCq5hxp8+vcpfWV9n/iXYZCc3QIGfCPFC60sL1mrk44Y
 mjdtAY0uTFbcD3BW92ld58w7ki0r7+1Bxix/p9gN53Wj2aOiV5qUrznP1Vj7QZxbcfM6rVQhp5v
 sAA==
X-Google-Smtp-Source: AGHT+IE/oky5PEmTti+fWn2MSTLSWOE5mezSoUSCtZ/HqTP8KReuxqQ7gTKo1UW90CvkP2KeX8QoUw==
X-Received: by 2002:a17:907:2d92:b0:a8d:6261:23ff with SMTP id
 a640c23a62f3a-a93a035da14mr232882966b.17.1727269098419; 
 Wed, 25 Sep 2024 05:58:18 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 16/19] arm: Add a new qemu_arm64_tpl board
Date: Wed, 25 Sep 2024 14:55:42 +0200
Message-ID: <20240925125622.197915-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

We want to be able to test the relocating XPL loader. Add a new build
for ARM QEMU which supports booting from TPL into SPL

This builds an image containing TPL, SPL and U-Boot proper. To run it:

   qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
      -bios image.bin

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/qemu-arm64.dts           | 18 ++++++
 arch/arm/mach-qemu/Kconfig            | 20 +++++++
 board/emulation/qemu-arm/Kconfig      |  2 +-
 board/emulation/qemu-arm/MAINTAINERS  |  5 ++
 board/emulation/qemu-arm/Makefile     |  1 +
 board/emulation/qemu-arm/qemu-arm.env |  4 ++
 board/emulation/qemu-arm/xpl.c        | 35 ++++++++++++
 configs/qemu_arm64_tpl_defconfig      | 82 +++++++++++++++++++++++++++
 8 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 board/emulation/qemu-arm/xpl.c
 create mode 100644 configs/qemu_arm64_tpl_defconfig

diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 096b3910728..de943642e76 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -8,4 +8,22 @@
 /dts-v1/;
 
 / {
+#ifdef CONFIG_BINMAN
+	binman {
+		u-boot-tpl {
+		};
+
+		u-boot-spl {
+			symbols-base = <0>;
+			offset = <CONFIG_SPL_TEXT_BASE>;
+		};
+
+		u-boot {
+			offset = <CONFIG_TEXT_BASE>;
+		};
+
+		fdtmap {
+		};
+	};
+#endif
 };
diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
index 186c3582ebf..8ade9028af6 100644
--- a/arch/arm/mach-qemu/Kconfig
+++ b/arch/arm/mach-qemu/Kconfig
@@ -25,6 +25,26 @@ config TARGET_QEMU_ARM_64BIT
 	select ARM64
 	select BOARD_LATE_INIT
 
+config TARGET_QEMU_ARM_64BIT_TPL
+	bool "ARMv8, 64bit, with TPL"
+	select ARM64
+	select BOARD_LATE_INIT
+	select SPL
+	select TPL
+	select SPL_LIBCOMMON_SUPPORT
+	select TPL_LIBCOMMON_SUPPORT
+	select SPL_LIBGENERIC_SUPPORT
+	select TPL_LIBGENERIC_SUPPORT
+	select SPL_OF_CONTROL
+	select TPL_OF_CONTROL
+	select SPL_DM
+	select TPL_DM
+	select BINMAN
+	select SPL_SERIAL
+	select TPL_SERIAL
+	imply SPL_FRAMEWORK_BOARD_INIT_F
+	imply RPL_FRAMEWORK_BOARD_INIT_F
+
 endchoice
 
 endif
diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index e21c135e86f..32c71bb0421 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT
+if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT || TARGET_QEMU_ARM_64BIT_TPL
 
 config TEXT_BASE
 	default 0x00000000
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 5154262f29e..559409c18bb 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -6,3 +6,8 @@ F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	configs/qemu_arm_defconfig
 F:	configs/qemu_arm64_defconfig
+
+QEMU ARM 'VIRT' TPL BOARD
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	configs/qemu_arm64_tpl_defconfig
diff --git a/board/emulation/qemu-arm/Makefile b/board/emulation/qemu-arm/Makefile
index a22d1237ff4..ef40943052c 100644
--- a/board/emulation/qemu-arm/Makefile
+++ b/board/emulation/qemu-arm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-y	+= qemu-arm.o
+obj-$(CONFIG_SPL_BUILD) += xpl.o
diff --git a/board/emulation/qemu-arm/qemu-arm.env b/board/emulation/qemu-arm/qemu-arm.env
index fb4adef281e..0190db82e4e 100644
--- a/board/emulation/qemu-arm/qemu-arm.env
+++ b/board/emulation/qemu-arm/qemu-arm.env
@@ -13,3 +13,7 @@ pxefile_addr_r=0x40300000
 kernel_addr_r=0x40400000
 ramdisk_addr_r=0x44000000
 boot_targets=qfw usb scsi virtio nvme dhcp
+
+#ifdef CONFIG_TARGET_QEMU_ARM_64BIT_TPL
+board_name="qemu-arm64_tpl"
+#endif
diff --git a/board/emulation/qemu-arm/xpl.c b/board/emulation/qemu-arm/xpl.c
new file mode 100644
index 00000000000..ec59e0ff327
--- /dev/null
+++ b/board/emulation/qemu-arm/xpl.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_DEBUG
+#define LOG_CATEGORY	LOGC_BOOT
+
+#include <mapmem.h>
+#include <spl.h>
+
+unsigned int spl_boot_device(void)
+{
+	return BOOT_DEVICE_BOARD;
+}
+
+static int binman_load_image(struct spl_image_info *img,
+			     struct spl_boot_device *bootdev)
+{
+	ulong base = spl_get_image_pos();
+	ulong size = spl_get_image_size();
+
+	log_debug("Booting from address %lx size %lx\n", base, size);
+	img->name = spl_phase_name(spl_next_phase());
+	img->load_addr = base;
+	img->entry_point = base;
+
+	return 0;
+}
+SPL_LOAD_IMAGE_METHOD("binman", 0, BOOT_DEVICE_BOARD, binman_load_image);
+
+void reset_cpu(void)
+{
+}
diff --git a/configs/qemu_arm64_tpl_defconfig b/configs/qemu_arm64_tpl_defconfig
new file mode 100644
index 00000000000..f09e357e5cc
--- /dev/null
+++ b/configs/qemu_arm64_tpl_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_QEMU=y
+CONFIG_TEXT_BASE=0x13000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DEFAULT_DEVICE_TREE="qemu-arm64"
+CONFIG_SPL_TEXT_BASE=0x6000
+CONFIG_TARGET_QEMU_ARM_64BIT_TPL=y
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_DEBUG_UART_BASE=0x9000000
+CONFIG_DEBUG_UART_CLOCK=0
+CONFIG_ARMV8_CRYPTO=y
+CONFIG_SYS_LOAD_ADDR=0x40200000
+CONFIG_ENV_ADDR=0x4000000
+CONFIG_TPL_MAX_SIZE=0x10000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_EFI_HTTP_BOOT=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
+# CONFIG_PRE_CONSOLE_BUFFER is not set
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x10000
+# CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_CMD_SMBIOS=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_TPM=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_DFU_TFTP=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_RAM=y
+# CONFIG_MMC is not set
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_NOR_FLASH=y
+CONFIG_FLASH_SHOW_PROGRESS=0
+CONFIG_CFI_FLASH=y
+CONFIG_CFI_FLASH_USE_WEAK_ACCESSORS=y
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_SYS_FLASH_CFI=y
+CONFIG_SYS_MAX_FLASH_SECT=256
+CONFIG_SYS_MAX_FLASH_BANKS=2
+CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
+CONFIG_E1000=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_PL011=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_TPM2_MMIO=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_PCI=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_SEMIHOSTING=y
+CONFIG_TPM=y
+CONFIG_TPL_LZ4=y
-- 
2.43.0

