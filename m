Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F4CC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297F687B19;
	Fri, 15 Dec 2023 05:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I756MXxJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6AA287B0B; Fri, 15 Dec 2023 05:19:32 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE01A87ACC
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b9e6262fccso215850b6e.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613968; x=1703218768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYvyq8EvgkW+tt2fCm7c+Tn9M2j8sMMITu1m4Ia2WmA=;
 b=I756MXxJ3Y5iCxJr+bKWmpgl17td3YHZBQ7O/SEAEC6yef7gRue89IoeA1q1AevwE2
 jPbUtq1hfKGRBpbgJoUYGWvnhxShzYneOhReevwaCaDHcVbprGijl38TtX0gFOcKcY+W
 Qw2ZZQ1J0ceyAY2CTbb5C0NtLvXpnlkAHdFhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613968; x=1703218768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYvyq8EvgkW+tt2fCm7c+Tn9M2j8sMMITu1m4Ia2WmA=;
 b=FrF+Rpp/6ruV0SYWu0O/+v3/FlndA4zd+qunbQ1k3kz63Y1mxBsvi2yQ/8AfAyDYhy
 hq/sVbBps7CPtcBaDXIkfPSQl8noFfOAWoWJH4izw3aPPe2eDzBLYsg5+m8z3Yztk8SO
 C9n7Eo2pvdLphFzyYOC9wP58CpINgw7OHvZ134BvLyYliN4z4Kv2mzmpsxofntgtQJQI
 gRfcYpTDsGJ3lW5Se2CQ89W2X2j3E6yLH4yqb3kvPSdKa2oVz5qANByw+9mSpuWWZcgk
 Al9gCjhFIQbV2l45n6XwWPll0MLqlBNLKFkHMFm8L0odw3/b31mSktY7q12ax4JEw2+e
 Oh7w==
X-Gm-Message-State: AOJu0YyMzhgBGr+zNlSRn9w/on2mWx5+65Pu1z0FdY6z5pigiF1a5qW5
 50BedWoEO5Tu3pdw2sqZppRyiycvEWLfDKPZGCVgTg==
X-Google-Smtp-Source: AGHT+IEs0O/XPRs+LvMuiw4tiQ/x+VqvA/5+kM2ZY8I5Lr6Su10WcwmSnXTNy+QCpitQ1imkyKzTxA==
X-Received: by 2002:a05:6808:e87:b0:3b8:b063:a1da with SMTP id
 k7-20020a0568080e8700b003b8b063a1damr13189482oil.100.1702613968327; 
 Thu, 14 Dec 2023 20:19:28 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, Eric Nelson <eric@nelint.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v2 02/16] bootm: Add a Kconfig option for bootm functionality
Date: Thu, 14 Dec 2023 21:19:00 -0700
Message-ID: <20231214211906.v2.2.I826be28024caa3834c47f752d0be1000855dd4fd@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

(no changes since v1)

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
index 397e6472c036..2af66a66c1e1 100644
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
index b54d2cefa100..5de482a0d84b 100644
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
 # CONFIG_CMD_BOOTI is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_EXTENSION is not set
diff --git a/configs/xilinx_versal_mini_defconfig b/configs/xilinx_versal_mini_defconfig
index 222da5aaa33b..4844dcef99c7 100644
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
index 1d73790c0e96..335ed4042721 100644
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
index 747f20d319a9..f64920052a94 100644
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
index 96be5b92b903..f91431e9b7bc 100644
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
index 7181b89a6519..7faab7aad42c 100644
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
index 7dac1ec54eb4..317fc8e2e152 100644
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
index fc88eee10af4..31c443236667 100644
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
index 1ba6e0871bf1..86c32e95ffda 100644
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
index c9497bb6c2af..e0c5fcb32897 100644
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
index 694fa1123e9d..c2977d4203e5 100644
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
index f81b772c4cb1..dc14088eef85 100644
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
index 6501ec3a0600..1e9f4cbdb412 100644
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
index bfe93dc965fe..024246349bde 100644
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
index 91f5aa24bd51..1dc3b1054f35 100644
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
index afbf6f6934d6..f568e51cd495 100644
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
index f7b75812b43f..521805cb5214 100644
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
index 2a50f38998b7..7401161a6108 100644
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
index db1fc532d153..e2a579db7291 100644
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
2.43.0.472.g3155946c3a-goog

