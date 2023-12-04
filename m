Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B09C10DC3
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2025B8771E;
	Mon,  4 Dec 2023 01:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EF58KEzT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F369787717; Mon,  4 Dec 2023 01:32:32 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E2678788D
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cdcef787ffso4270198b3a.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649948; x=1702254748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvtEB71OTQpUutXcxq397drTx0pJPp1LSTN7NTXMQLQ=;
 b=EF58KEzTdFg8KkB0m61sdOqes3xffYX8YuVktOVOC1KVm1YobjmJgOwBGRPSJmMqFQ
 LsS92Pcn7m1csT2+qJ6UHTg2csdrLaptwVG05uuFvjsRurXzOX1qHZgG8H7FPcBkMuaj
 To483LZrGlsYQHyhuF1pHugWoCDHnmQPNkxBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649948; x=1702254748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvtEB71OTQpUutXcxq397drTx0pJPp1LSTN7NTXMQLQ=;
 b=OrWe0WTTaCCpchUJlrLDkq4OpB/rLoxYuyzqYnntUM6NqxIbn5v+nRLOoTeiQhJIxW
 eXEu5Wu9pPxPwqiJhSHnP/vOUcKCHo8XKc8BncD/dyEa/liFCA14Oslism7AuiivVlgL
 3b5I5uiKRazgJNFg4uQb8p5Fvc3w9he+VsVEk/jLLSF5Ao2KmjdxGYtShaT+5vmE2Ua3
 u9bs5iHjD07h5Vt/+zoZGqI+91J6sfb1VRmtD7Afya6CdzK9wNPOKMTjzmBhlPX6YBmu
 86Km/fGxTn5W2z1wRVsFSyxfamD2PBniUF4qwU9c1MzzramEXCzEGNYoJATbLN50PGCa
 uZag==
X-Gm-Message-State: AOJu0YwmVIEbCJcFRUfzonOz2bIBJBDp8yylIc1sc8TSZPv5TXww3bXO
 jqfIaRkMEDFrgRcsdR0DI2Pe69j+bfoI9rJCr4YKeQ==
X-Google-Smtp-Source: AGHT+IEE/axHETXJUvAdIZa9Djh1VicCZD9tGTTTei777HschXkmKe4h5DYSAcTjF9G1w0OHll1nyg==
X-Received: by 2002:a05:6a00:c8a:b0:6ce:2732:57a with SMTP id
 a10-20020a056a000c8a00b006ce2732057amr3193754pfv.43.1701649948421; 
 Sun, 03 Dec 2023 16:32:28 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:32:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Eric Nelson <eric@nelint.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 02/14] bootm: Add a Kconfig option for bootm functionality
Date: Sun,  3 Dec 2023 17:31:26 -0700
Message-ID: <20231203173130.2.I826be28024caa3834c47f752d0be1000855dd4fd@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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

Create a separate Kconfig option which enables the bootm logic,
separate from the 'bootm' command. This will eventually allow booting
without CMDLINE enabled.

Update boards which disable CMD_BOOTM to disable BOOTM instead, since
CMD_BOOTM now depends on BOOTM

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig                                     | 12 ++++++++++++
 boot/Makefile                                    |  2 +-
 cmd/Kconfig                                      |  1 +
 configs/colibri_vf_defconfig                     |  2 +-
 configs/iot_devkit_defconfig                     |  2 +-
 configs/mx6memcal_defconfig                      |  2 +-
 configs/tools-only_defconfig                     |  2 +-
 configs/xilinx_versal_mini_defconfig             |  2 +-
 configs/xilinx_versal_mini_emmc0_defconfig       |  2 +-
 configs/xilinx_versal_mini_emmc1_defconfig       |  2 +-
 configs/xilinx_versal_mini_ospi_defconfig        |  2 +-
 configs/xilinx_versal_mini_qspi_defconfig        |  2 +-
 configs/xilinx_versal_net_mini_defconfig         |  2 +-
 configs/xilinx_versal_net_mini_emmc_defconfig    |  2 +-
 configs/xilinx_versal_net_mini_ospi_defconfig    |  2 +-
 configs/xilinx_versal_net_mini_qspi_defconfig    |  2 +-
 configs/xilinx_zynqmp_mini_defconfig             |  2 +-
 configs/xilinx_zynqmp_mini_emmc0_defconfig       |  2 +-
 configs/xilinx_zynqmp_mini_emmc1_defconfig       |  2 +-
 configs/xilinx_zynqmp_mini_nand_defconfig        |  2 +-
 configs/xilinx_zynqmp_mini_nand_single_defconfig |  2 +-
 configs/xilinx_zynqmp_mini_qspi_defconfig        |  2 +-
 configs/zynq_cse_nand_defconfig                  |  2 +-
 configs/zynq_cse_nor_defconfig                   |  2 +-
 configs/zynq_cse_qspi_defconfig                  |  2 +-
 25 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e0098b3f31d7..8b32a51f7e7c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -677,6 +677,18 @@ config BOOTMETH_SCRIPT
 
 endif # BOOTSTD
 
+config BOOTM
+	bool "Support booting an application image from memory"
+	default y
+	help
+	  This is the main boot implementation in U-Boot, supporting a wide
+	  variety of features including FIT and legacy-image boot, kernel and
+	  FDT selection, setting up of the command line for the OS and many
+	  other features.
+
+	  This option should normally be enabled. It is used to implement the
+	  'bootm' command.
+
 config ANDROID_BOOT_IMAGE
 	bool "Android Boot Images"
 	default y if FASTBOOT
diff --git a/boot/Makefile b/boot/Makefile
index de0eafed14b1..a4ea2f9e062f 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -6,7 +6,7 @@
 ifndef CONFIG_SPL_BUILD
 
 obj-$(CONFIG_BOOT_RETRY) += bootretry.o
-obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
+obj-$(CONFIG_BOOTM) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTZ) += bootm.o bootm_os.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o bootm_os.o
 
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 584ffd039686..74e1950e51fc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -219,6 +219,7 @@ config CMD_BOOTD
 
 config CMD_BOOTM
 	bool "bootm"
+	depends on BOOTM
 	default y
 	help
 	  Boot an application image from the memory.
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 8b2324fd5648..48019f0fa0b8 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_MEMTEST_END=0x87c00000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=520192
+# CONFIG_BOOTM is not set
 CONFIG_BOOTDELAY=1
 CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
@@ -33,7 +34,6 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="Colibri VFxx # "
 CONFIG_SYS_PBSIZE=1056
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
diff --git a/configs/iot_devkit_defconfig b/configs/iot_devkit_defconfig
index 55ced6bc3c32..a09f3ed5f77b 100644
--- a/configs/iot_devkit_defconfig
+++ b/configs/iot_devkit_defconfig
@@ -14,12 +14,12 @@ CONFIG_DEFAULT_DEVICE_TREE="iot_devkit"
 CONFIG_SYS_CLK_FREQ=16000000
 CONFIG_SYS_LOAD_ADDR=0x30000000
 CONFIG_LOCALVERSION="-iotdk-1.0"
+# CONFIG_BOOTM is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_SYS_PROMPT="IoTDK# "
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=280
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_XIMG is not set
 # CONFIG_CMD_LOADB is not set
diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
index 6dd64b6da1ba..6da7a0eaf09c 100644
--- a/configs/mx6memcal_defconfig
+++ b/configs/mx6memcal_defconfig
@@ -14,6 +14,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
 CONFIG_SYS_MEMTEST_START=0x10000000
 CONFIG_SYS_MEMTEST_END=0x20000000
+# CONFIG_BOOTM is not set
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_WATCHDOG=y
@@ -21,7 +22,6 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_PBSIZE=528
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_IMI is not set
 # CONFIG_CMD_XIMG is not set
diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index fa1ff4a73f21..fb180f0ebce9 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -12,10 +12,10 @@ CONFIG_FIT_SIGNATURE=y
 # CONFIG_BOOTSTD_FULL is not set
 # CONFIG_BOOTMETH_CROS is not set
 # CONFIG_BOOTMETH_VBE is not set
+# CONFIG_BOOTM is not set
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_EXTENSION is not set
 # CONFIG_CMD_DATE is not set
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index d6d6dc1664a3..6cba3160e389 100644
--- a/configs/xilinx_versal_mini_defconfig
+++ b/configs/xilinx_versal_mini_defconfig
@@ -18,6 +18,7 @@ CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_BOOTM is not set
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
@@ -34,7 +35,6 @@ CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_versal_mini_emmc0_defconfig b/configs/xilinx_versal_mini_emmc0_defconfig
index 858bb35e00ee..117fc500b103 100644
--- a/configs/xilinx_versal_mini_emmc0_defconfig
+++ b/configs/xilinx_versal_mini_emmc0_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="versal-mini-emmc0"
 CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_BOOTM is not set
 # CONFIG_AUTOBOOT is not set
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -31,7 +32,6 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_versal_mini_emmc1_defconfig b/configs/xilinx_versal_mini_emmc1_defconfig
index 2488edea41d4..bb7375d2deda 100644
--- a/configs/xilinx_versal_mini_emmc1_defconfig
+++ b/configs/xilinx_versal_mini_emmc1_defconfig
@@ -15,6 +15,7 @@ CONFIG_DEFAULT_DEVICE_TREE="versal-mini-emmc1"
 CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_BOOTM is not set
 # CONFIG_AUTOBOOT is not set
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -31,7 +32,6 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index 389ca50703e8..e0e8583bef72 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -18,6 +18,7 @@ CONFIG_VERSAL_NO_DDR=y
 CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_BOOTM is not set
 # CONFIG_AUTOBOOT is not set
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -30,7 +31,6 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
index 5724aa3040ff..1b2de4358f32 100644
--- a/configs/xilinx_versal_mini_qspi_defconfig
+++ b/configs/xilinx_versal_mini_qspi_defconfig
@@ -16,6 +16,7 @@ CONFIG_VERSAL_NO_DDR=y
 CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_BOOTM is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_LOGLEVEL=0
@@ -31,7 +32,6 @@ CONFIG_SYS_PROMPT="Versal> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_versal_net_mini_defconfig b/configs/xilinx_versal_net_mini_defconfig
index 3f45630a11f9..77e6e3e3c316 100644
--- a/configs/xilinx_versal_net_mini_defconfig
+++ b/configs/xilinx_versal_net_mini_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_BOOTM is not set
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
@@ -33,7 +34,6 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_versal_net_mini_emmc_defconfig b/configs/xilinx_versal_net_mini_emmc_defconfig
index 1d79eff33173..da03b9fe4a79 100644
--- a/configs/xilinx_versal_net_mini_emmc_defconfig
+++ b/configs/xilinx_versal_net_mini_emmc_defconfig
@@ -25,7 +25,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
+# CONFIG_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_versal_net_mini_ospi_defconfig b/configs/xilinx_versal_net_mini_ospi_defconfig
index 0656b23ae17b..ecd720681944 100644
--- a/configs/xilinx_versal_net_mini_ospi_defconfig
+++ b/configs/xilinx_versal_net_mini_ospi_defconfig
@@ -29,7 +29,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
+# CONFIG_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
index c0e9ba9f76f9..78626f31ccd9 100644
--- a/configs/xilinx_versal_net_mini_qspi_defconfig
+++ b/configs/xilinx_versal_net_mini_qspi_defconfig
@@ -30,7 +30,7 @@ CONFIG_SYS_PROMPT="Versal NET> "
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
+# CONFIG_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
index fc768b613a25..7a0a9d260b62 100644
--- a/configs/xilinx_zynqmp_mini_defconfig
+++ b/configs/xilinx_zynqmp_mini_defconfig
@@ -13,6 +13,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SYS_MEMTEST_START=0x00000000
 CONFIG_SYS_MEMTEST_END=0x00001000
 CONFIG_REMAKE_ELF=y
+# CONFIG_BOOTM is not set
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -27,7 +28,6 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc0_defconfig b/configs/xilinx_zynqmp_mini_emmc0_defconfig
index 72b1ad4660ad..a39a29521481 100644
--- a/configs/xilinx_zynqmp_mini_emmc0_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc0_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 CONFIG_FIT=y
+# CONFIG_BOOTM is not set
 CONFIG_SUPPORT_RAW_INITRD=y
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -38,7 +39,6 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_zynqmp_mini_emmc1_defconfig b/configs/xilinx_zynqmp_mini_emmc1_defconfig
index 310aad445a55..97e640c20226 100644
--- a/configs/xilinx_zynqmp_mini_emmc1_defconfig
+++ b/configs/xilinx_zynqmp_mini_emmc1_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 CONFIG_FIT=y
+# CONFIG_BOOTM is not set
 CONFIG_SUPPORT_RAW_INITRD=y
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -38,7 +39,6 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_defconfig b/configs/xilinx_zynqmp_mini_nand_defconfig
index ce224f80ecc3..4eeaa98a51bb 100644
--- a/configs/xilinx_zynqmp_mini_nand_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_defconfig
@@ -13,6 +13,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 CONFIG_FIT=y
+# CONFIG_BOOTM is not set
 CONFIG_SUPPORT_RAW_INITRD=y
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -28,7 +29,6 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_GO is not set
 # CONFIG_CMD_RUN is not set
diff --git a/configs/xilinx_zynqmp_mini_nand_single_defconfig b/configs/xilinx_zynqmp_mini_nand_single_defconfig
index ce23cb1d01e0..1b6262ab55a6 100644
--- a/configs/xilinx_zynqmp_mini_nand_single_defconfig
+++ b/configs/xilinx_zynqmp_mini_nand_single_defconfig
@@ -13,6 +13,7 @@ CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_REMAKE_ELF=y
 # CONFIG_MP is not set
 CONFIG_FIT=y
+# CONFIG_BOOTM is not set
 CONFIG_SUPPORT_RAW_INITRD=y
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -28,7 +29,6 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_GO is not set
 # CONFIG_CMD_RUN is not set
diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
index b044743474da..6d56c1fae246 100644
--- a/configs/xilinx_zynqmp_mini_qspi_defconfig
+++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
@@ -19,6 +19,7 @@ CONFIG_ZYNQMP_NO_DDR=y
 CONFIG_SYS_LOAD_ADDR=0x8000000
 # CONFIG_EXPERT is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_BOOTM is not set
 # CONFIG_LEGACY_IMAGE_FORMAT is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
@@ -42,7 +43,6 @@ CONFIG_SYS_PBSIZE=1049
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
index 2eb45e1242eb..28e15adc266b 100644
--- a/configs/zynq_cse_nand_defconfig
+++ b/configs/zynq_cse_nand_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_REMAKE_ELF=y
 CONFIG_SYS_CUSTOM_LDSCRIPT=y
 CONFIG_SYS_LDSCRIPT="arch/arm/mach-zynq/u-boot.lds"
+# CONFIG_BOOTM is not set
 # CONFIG_AUTOBOOT is not set
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -43,7 +44,6 @@ CONFIG_SYS_PBSIZE=1047
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
 # CONFIG_CMD_GO is not set
diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
index c5a28f28b9dc..7b2f374d2272 100644
--- a/configs/zynq_cse_nor_defconfig
+++ b/configs/zynq_cse_nor_defconfig
@@ -19,6 +19,7 @@ CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_REMAKE_ELF=y
 CONFIG_SYS_CUSTOM_LDSCRIPT=y
 CONFIG_SYS_LDSCRIPT="arch/arm/mach-zynq/u-boot.lds"
+# CONFIG_BOOTM is not set
 # CONFIG_AUTOBOOT is not set
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
@@ -43,7 +44,6 @@ CONFIG_SYS_PBSIZE=1047
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
 # CONFIG_CMD_GO is not set
diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
index 9a2770af20ef..7c4452d0b5b8 100644
--- a/configs/zynq_cse_qspi_defconfig
+++ b/configs/zynq_cse_qspi_defconfig
@@ -25,6 +25,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_REMAKE_ELF=y
 CONFIG_SYS_CUSTOM_LDSCRIPT=y
 CONFIG_SYS_LDSCRIPT="arch/arm/mach-zynq/u-boot.lds"
+# CONFIG_BOOTM is not set
 # CONFIG_AUTOBOOT is not set
 # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
 CONFIG_USE_PREBOOT=y
@@ -52,7 +53,6 @@ CONFIG_SYS_PBSIZE=1047
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_BOOTD is not set
-# CONFIG_CMD_BOOTM is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_FDT is not set
 # CONFIG_CMD_GO is not set
-- 
2.43.0.rc2.451.g8631bc7472-goog

