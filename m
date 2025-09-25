Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8B9CAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7CC82A9E;
	Thu, 25 Sep 2025 22:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b1JvVCiV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D2382A9E; Thu, 25 Sep 2025 22:51:29 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2C0982A9E
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-74a61973bedso1333733a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833485; x=1759438285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kur8jfmtanGxUnsHJCW3jQYgArK8s569cdEDJHhsboA=;
 b=b1JvVCiVltDPvxfdk7uBKmqhUhkBk0AJsHAQ9y437QmaJyv7hEYcGUf0GstO/dZYYk
 8KTGoHtx9K0SUcBxogi8ifuALynGd1QvqSUbWtucUy1b71tPX6slK9LVrhjT2OmhyB9C
 l0oWz4HyxdcyA+RxlyUZEoZ/b+7wHfpPEyiQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833485; x=1759438285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kur8jfmtanGxUnsHJCW3jQYgArK8s569cdEDJHhsboA=;
 b=OVnz4bTo/lZfDMHc6HvVaGvajTBqMeh80OA3nqdNb+XIXVDsPaLck2yj5D1r5WCZhD
 WLRKsYUncxh2b39eCA04captz4VwtDK587SWg70XGGDToZtjrhpc/pCqXpPYfFdbGh4r
 Un6PcuhLSqBaPo3VoSZLBkti90KVb5fpXKHGfkpXXnLp1rW1Tr8OmKrY6ZRPcJ3F+LTA
 AqRKIuVf5a3iRMENq7cHRFPgIWoQqs08vsxUpkiwrmXoDTG/V0IIg2jnIx3wgdrHaq60
 WhJMt9xc4bYaIaJypVuXsufL6Whut+d1FpmI+xYXN7gRma2v5PQXnkix20fEtTnltl9u
 zsPQ==
X-Gm-Message-State: AOJu0YyWcNCkHQf+VqmFDn27GFJ79HOAZbmYe01lVVbme2ZNkHGc0Aj6
 MIdLI2LVhBJbRDVuKLTnKDP5bJ3LPOvJGq3LCTNzxEqcY9bhpD62S9fl3DkIlBjPfm0kzHPqsK8
 sVnEM20E=
X-Gm-Gg: ASbGncsJIrAbfR8sfwM5mpShgBfiDBxSafneXbLLWVBjSKLDTUA7ELbzcEilJcdVrwv
 KT+Us7Ag0z0XeMn7KBhZ+SP3YEpJjIBzVFZsg76T7Q633jx6B8/L8bNWiCPCRr+C0pznPQq6xyJ
 HdNWfY9mQ+ZrBco66H80m07t1V+ooQgEuTFA7bdb68M/GeEvY+aI9nNio2OMxxMP7dgoKOtuZnp
 L9z2hv7TrTE1nHegA1vEqjNDgHt+d4SqA/LPEBHVYpnrXpZhTWD+rhDsx9nIRKC99fzLuNV35SM
 5opXxO8XGmO+D63r/cKo6Z553y4i7Tr3i+NBOhbxdZOzYz4zonVjQz2z8h7sIr1I5JhY0+YBzkQ
 QKZhyE71Pl8fsHxqqT72aoHQvDfaMKtbl3PRtbjirZyVfVGrcGJPjUBa6qak=
X-Google-Smtp-Source: AGHT+IEvKZvSBY55G0kTJewkqDtrwECYpxuoVLi1GjqeP4QaZMvhD87NP4OfzNDkJWVMaQ1h/a+Cng==
X-Received: by 2002:a05:6830:448d:b0:746:d8f0:56ab with SMTP id
 46e09a7af769-7a02ade8650mr2691230a34.0.1758833484679; 
 Thu, 25 Sep 2025 13:51:24 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a6aaaddc2asm256150a34.42.2025.09.25.13.51.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:51:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Kconfig: Make further use of testing for !COMPILE_TEST
Date: Thu, 25 Sep 2025 14:51:22 -0600
Message-ID: <20250925205122.3561877-1-trini@konsulko.com>
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

We have a large number of library symbols that should not be prompted
for by the user really but rather selected by the platform (or SoC) as
needed. To start with however, make these depend on !COMPILE_TEST.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Kconfig               | 1 +
 boot/Kconfig          | 2 ++
 cmd/Kconfig           | 5 +++++
 common/Kconfig        | 8 ++++++++
 drivers/Kconfig       | 1 +
 drivers/block/Kconfig | 1 +
 drivers/dfu/Kconfig   | 1 +
 drivers/mtd/Kconfig   | 1 +
 dts/Kconfig           | 3 +++
 lib/Kconfig           | 1 +
 10 files changed, 24 insertions(+)

diff --git a/Kconfig b/Kconfig
index 70125c4e5a6a..b68420022e8a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -720,6 +720,7 @@ config TPL_SYS_MONITOR_BASE
 
 config DYNAMIC_SYS_CLK_FREQ
 	bool "Determine CPU clock frequency at run-time"
+	depends on !COMPILE_TEST
 	help
 	  Implement a get_board_sys_clk function that will determine the CPU
 	  clock frequency at run time, rather than define it statically.
diff --git a/boot/Kconfig b/boot/Kconfig
index dd0473657547..780889023e10 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1852,6 +1852,7 @@ config OF_BOARD_SETUP
 
 config OF_BOARD_SETUP_EXTENDED
 	bool "Set up latest board-specific details in device tree before boot"
+	depends on !COMPILE_TEST
 	imply OF_BOARD_SETUP
 	help
 	  This causes U-Boot to call ft_board_setup_ex() before booting into
@@ -1862,6 +1863,7 @@ config OF_BOARD_SETUP_EXTENDED
 
 config OF_SYSTEM_SETUP
 	bool "Set up system-specific details in device tree before boot"
+	depends on !COMPILE_TEST
 	help
 	  This causes U-Boot to call ft_system_setup() before booting into
 	  the Operating System. This function can set up various
diff --git a/cmd/Kconfig b/cmd/Kconfig
index d4f34f4bc290..3248583b4e85 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1238,6 +1238,7 @@ config CMD_FPGAD
 
 config CMD_FUSE
 	bool "fuse - support for the fuse subssystem"
+	depends on !COMPILE_TEST
 	help
 	  (deprecated - needs conversion to driver model)
 	  This allows reading, sensing, programming or overriding fuses
@@ -1289,6 +1290,7 @@ config CMD_GPT_RENAME
 
 config CMD_IDE
 	bool "ide - Support for IDE drivers"
+	depends on !COMPILE_TEST
 	select IDE
 	help
 	  Provides an 'ide' command which allows accessing the IDE drive,
@@ -1558,6 +1560,7 @@ config CMD_NVME
 config CMD_ONENAND
 	bool "onenand - access to onenand device"
 	depends on MTD
+	depends on !COMPILE_TEST
 	help
 	  OneNAND is a brand of NAND ('Not AND' gate) flash which provides
 	  various useful features. This command allows reading, writing,
@@ -1567,6 +1570,7 @@ config CMD_ONENAND
 config USE_ONENAND_BOARD_INIT
 	bool "Call onenand_board_init() in the onenand command"
 	depends on CMD_ONENAND
+	depends on !COMPILE_TEST
 
 config CMD_OSD
 	bool "osd"
@@ -2879,6 +2883,7 @@ config JFFS2_PART_SIZE
 
 config CMD_MTDPARTS
 	bool "MTD partition support"
+	depends on !COMPILE_TEST
 	depends on MTD
 	select MTD_PARTITIONS
 	help
diff --git a/common/Kconfig b/common/Kconfig
index 66dcc8cde15f..1c340710a33d 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -280,6 +280,7 @@ config SYS_CONSOLE_IS_IN_ENV
 
 config SYS_CONSOLE_OVERWRITE_ROUTINE
 	bool "Allow board control over console overwriting"
+	depends on !COMPILE_TEST
 	help
 	  If this is enabled, and the board-specific function
 	  overwrite_console() returns 1, the stdin, stderr and stdout are
@@ -714,6 +715,7 @@ config ARCH_MISC_INIT
 
 config BOARD_EARLY_INIT_F
 	bool "Call board-specific init before relocation"
+	depends on !COMPILE_TEST
 	help
 	  Some boards need to perform initialisation as soon as possible
 	  after boot. With this option, U-Boot calls board_early_init_f()
@@ -723,6 +725,7 @@ config BOARD_EARLY_INIT_F
 
 config BOARD_EARLY_INIT_R
 	bool "Call board-specific init after relocation"
+	depends on !COMPILE_TEST
 	help
 	  Some boards need to perform initialisation as directly after
 	  relocation. With this option, U-Boot calls board_early_init_r()
@@ -730,6 +733,7 @@ config BOARD_EARLY_INIT_R
 
 config BOARD_INIT
 	bool "Call board-specific init board_init() during init-calls"
+	depends on !COMPILE_TEST
 	default y if ARM || RISCV || SANDBOX
 	help
 	  Some boards need an board_init() function called during the initcall
@@ -737,6 +741,7 @@ config BOARD_INIT
 
 config BOARD_POSTCLK_INIT
 	bool "Call board_postclk_init"
+	depends on !COMPILE_TEST
 	help
 	  Some boards need this to initialize select items, after clocks /
 	  timebase and before env / serial.
@@ -780,6 +785,7 @@ config LAST_STAGE_INIT
 
 config MISC_INIT_R
 	bool "Execute Misc Init"
+	depends on !COMPILE_TEST
 	default y if ARCH_KEYSTONE || ARCH_SUNXI || MPC85xx
 	default y if ARCH_OMAP2PLUS && !AM33XX
 	help
@@ -842,6 +848,7 @@ config SYS_EARLY_PCI_INIT
 
 config RESET_PHY_R
 	bool "Reset ethernet PHY during init"
+	depends on !COMPILE_TEST
 	help
 	  Implement reset_phy() in board code if required to reset the ethernet
 	  PHY.
@@ -952,6 +959,7 @@ config TPL_STACKPROTECTOR
 
 config BOARD_RNG_SEED
 	bool "Provide /chosen/rng-seed property to the linux kernel"
+	depends on !COMPILE_TEST
 	help
 	  Selecting this option requires the board to define a
 	  board_rng_seed() function, which should return a buffer
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 0b0c610e6294..fe35e07b1240 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -162,6 +162,7 @@ source "drivers/xen/Kconfig"
 
 config PHYS_TO_BUS
 	bool "Custom physical to bus address mapping"
+	depends on !COMPILE_TEST
 	help
 	  Some SoCs use a different address map for CPU physical addresses and
 	  peripheral DMA master accesses. If yours does, select this option in
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index c6c148ebd179..185da2b5cfc2 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -137,6 +137,7 @@ endif  # EFI_MEDIA
 
 config IDE
 	bool "Support IDE controllers"
+	depends on !COMPILE_TEST
 	select BLK
 	help
 	  Enables support for IDE (Integrated Drive Electronics) hard drives.
diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index e33b0056d0bb..2cf4289b4486 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -98,6 +98,7 @@ config DFU_SCSI
 
 config SET_DFU_ALT_INFO
 	bool "Dynamic set of DFU alternate information"
+	depends on !COMPILE_TEST
 	help
 	  This option allows to call the function set_dfu_alt_info to
 	  dynamically build dfu_alt_info in board.
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 6e4b23109e94..86752b5926de 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -41,6 +41,7 @@ config MTD_BLOCK
 
 config SYS_MTDPARTS_RUNTIME
 	bool "Allow MTDPARTS to be configured at runtime"
+	depends on !COMPILE_TEST
 	help
 	  This option allows to call the function board_mtdparts_default to
 	  dynamically build the variables mtdids and mtdparts at runtime.
diff --git a/dts/Kconfig b/dts/Kconfig
index 6a5141b56e97..c8bc5232f9b7 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -37,6 +37,7 @@ config OF_REAL
 
 config OF_BOARD_FIXUP
 	bool "Board-specific manipulation of Device Tree"
+	depends on !COMPILE_TEST
 	help
 	  In certain circumstances it is necessary to be able to modify
 	  U-Boot's device tree (e.g. to delete device from it). This option
@@ -87,6 +88,7 @@ config OF_LIVE
 
 config OF_UPSTREAM
 	bool "Enable use of devicetree imported from Linux kernel release"
+	depends on !COMPILE_TEST
 	help
 	  Traditionally, U-Boot platforms used to have their custom devicetree
 	  files or copy devicetree files from Linux kernel which are hard to
@@ -306,6 +308,7 @@ config MULTI_DTB_FIT_USER_DEF_ADDR
 
 config DTB_RESELECT
 	bool "Support swapping dtbs at a later point in boot"
+	depends on !COMPILE_TEST
 	depends on MULTI_DTB_FIT
 	help
 	  It is possible during initial boot you may need to use a generic
diff --git a/lib/Kconfig b/lib/Kconfig
index fbc9de90669a..7e48b179f6d3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1244,6 +1244,7 @@ config SPL_LMB
 config LMB_ARCH_MEM_MAP
 	bool "Add an architecture specific memory map"
 	depends on LMB
+	depends on !COMPILE_TEST
 	default y if FSL_LAYERSCAPE || X86
 	help
 	  Some architectures have special or unique aspects which need
-- 
2.43.0

