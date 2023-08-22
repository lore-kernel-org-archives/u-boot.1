Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA42EE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 03:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA6487298;
	Tue, 22 Aug 2023 05:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ni585nwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B1887270; Tue, 22 Aug 2023 05:17:26 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D95B786B88
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34c9f8c9876so9122035ab.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692674241; x=1693279041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0U1xRO6N/STAXYZeFd1M3+9aEvXWQIadTHvO+AYK5Y=;
 b=ni585nwbgPfkUSZKmYHLFN2er1vYaEgPm+gLVBUvHhmp4Qb5s5EItjfCt1MjHjCyVR
 W9K6RvEkGUulaWtk2UfjRV6xOcQJRM0WZmxNHCDsnQkeOrgVcLoNgXf26EtM2ipmy53t
 LgMjtQT1eIMOLyh++qa5POtOKHFN6WMNuVwmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692674241; x=1693279041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0U1xRO6N/STAXYZeFd1M3+9aEvXWQIadTHvO+AYK5Y=;
 b=WZ45gqoPB6xerMpVuvpsHuAVX0JmC5uPgUAzGVfC4M7d5jIROQ9kKeOtGcD3ht+F4C
 jK7DHA38w6tmDie2rIHC1aWy0csymEw07yRpOHvWX40qT1NN3ZAtKEcClbgfyVhWzdXD
 BDpTcKpQj8uvyU5SbesF2G3wRtGLZblRltetzFKf93utRfH6c0kd6Q4pqmgZldo609i8
 7Ajk4EQBqpzsqXuLO9l5kEBD6tbk/1fA0V4eYLx9PJ+b0Vz15HRM0FeMyLgjOD1nFthD
 mfdnKE/f0Leg/2dwehYm4w/jr0MZWNaJ18xqWqZZfEIJlwgaRNh/UMyQFdfynLF5vSlN
 A5ZA==
X-Gm-Message-State: AOJu0Yyrn2s44TpE+I+dIteEWDXQdUgPv1MrVqVDoUmD6CfxE6BYrzkT
 3EdY2Fpq57mWzPU7dmt7VOGHhWqfmjFCs3TDoF4=
X-Google-Smtp-Source: AGHT+IEIupsKeqQGp7it6FSyomwWRNgQIN+aSkKb1xUAfiuA3BM4dCSbpALlWQChTLe9l3RI8dsVRQ==
X-Received: by 2002:a05:6e02:2189:b0:349:8fb5:87c4 with SMTP id
 j9-20020a056e02218900b003498fb587c4mr11418765ila.14.1692674241003; 
 Mon, 21 Aug 2023 20:17:21 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 gv14-20020a0566382e4e00b0042b37dda71asm2722735jab.136.2023.08.21.20.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 20:17:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 14/14] event: Use an event to replace last_stage_init()
Date: Mon, 21 Aug 2023 21:17:01 -0600
Message-ID: <20230822031705.1340941-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
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

Add a new event which handles this function. Convert existing use of
the function to use the new event instead.

Make sure that EVENT is enabled by affected boards, by selecting it from
the LAST_STAGE_INIT option. For x86, enable it by default since all boards
need it.

For controlcenterdc, inline the get_tpm() function and make sure the event
is not built in SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/Kconfig                                  |  1 +
 arch/mips/mach-mtmips/cpu.c                   |  6 +++-
 arch/mips/mach-pic32/cpu.c                    |  4 ++-
 arch/x86/cpu/coreboot/coreboot.c              |  7 ++++-
 arch/x86/cpu/cpu.c                            | 10 ++++--
 arch/x86/cpu/efi/payload.c                    |  4 ++-
 arch/x86/cpu/quark/quark.c                    |  4 ++-
 board/CZ.NIC/turris_mox/turris_mox.c          |  4 ++-
 board/Marvell/mvebu_armada-37xx/board.c       |  5 ++-
 board/Marvell/octeon_nic23/board.c            |  4 ++-
 board/Marvell/octeontx2/board.c               |  4 ++-
 board/cortina/presidio-asic/presidio.c        |  4 ++-
 board/emulation/qemu-ppce500/qemu-ppce500.c   |  4 ++-
 board/gdsys/a38x/controlcenterdc.c            | 31 +++++++++----------
 board/gdsys/mpc8308/gazerbeam.c               |  4 ++-
 board/ge/bx50v3/bx50v3.c                      |  4 ++-
 board/keymile/km83xx/km83xx.c                 |  4 ++-
 board/keymile/kmcent2/kmcent2.c               |  3 +-
 .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c |  6 +---
 board/phytium/durian/durian.c                 |  4 ++-
 board/phytium/pomelo/pomelo.c                 |  4 ++-
 common/Kconfig                                |  1 +
 common/board_r.c                              |  9 +-----
 common/event.c                                |  1 +
 configs/bayleybay_defconfig                   |  1 -
 configs/cherryhill_defconfig                  |  1 -
 configs/chromebook_coral_defconfig            |  1 -
 configs/chromebook_link64_defconfig           |  1 -
 configs/chromebook_link_defconfig             |  1 -
 configs/chromebook_samus_defconfig            |  1 -
 configs/chromebook_samus_tpl_defconfig        |  1 -
 configs/chromebox_panther_defconfig           |  1 -
 ...-qeval20-qa3-e3845-internal-uart_defconfig |  1 -
 configs/conga-qeval20-qa3-e3845_defconfig     |  1 -
 configs/coreboot64_defconfig                  |  1 -
 configs/coreboot_defconfig                    |  1 -
 configs/cougarcanyon2_defconfig               |  1 -
 configs/crownbay_defconfig                    |  1 -
 configs/dfi-bt700-q7x-151_defconfig           |  1 -
 configs/edison_defconfig                      |  1 -
 configs/efi-x86_app32_defconfig               |  1 -
 configs/efi-x86_app64_defconfig               |  1 -
 configs/efi-x86_payload32_defconfig           |  1 -
 configs/efi-x86_payload64_defconfig           |  1 -
 configs/galileo_defconfig                     |  1 -
 configs/minnowmax_defconfig                   |  1 -
 configs/qemu-x86_64_defconfig                 |  3 +-
 configs/qemu-x86_defconfig                    |  1 -
 configs/som-db5800-som-6867_defconfig         |  1 -
 ...able-x86-conga-qa3-e3845-pcie-x4_defconfig |  1 -
 .../theadorable-x86-conga-qa3-e3845_defconfig |  1 -
 configs/theadorable-x86-dfi-bt700_defconfig   |  1 -
 include/event.h                               | 12 +++++++
 include/init.h                                |  1 -
 54 files changed, 95 insertions(+), 80 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c9a335922528..90345cbee0d8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -252,6 +252,7 @@ config X86
 	imply DM_SPI
 	imply DM_SPI_FLASH
 	imply DM_USB
+	imply LAST_STAGE_INIT
 	imply VIDEO
 	imply SYSRESET
 	imply SPL_SYSRESET
diff --git a/arch/mips/mach-mtmips/cpu.c b/arch/mips/mach-mtmips/cpu.c
index f1e902273863..e88dab10c76e 100644
--- a/arch/mips/mach-mtmips/cpu.c
+++ b/arch/mips/mach-mtmips/cpu.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <event.h>
 #include <init.h>
 #include <malloc.h>
 #include <asm/addrspace.h>
@@ -21,7 +22,8 @@ int dram_init(void)
 	return 0;
 }
 
-int last_stage_init(void)
+#ifndef CONFIG_SPL_BUILD
+static int last_stage_init(void)
 {
 	void *src, *dst;
 
@@ -46,3 +48,5 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
+#endif
diff --git a/arch/mips/mach-pic32/cpu.c b/arch/mips/mach-pic32/cpu.c
index 785a87b618b6..7ed306e045ea 100644
--- a/arch/mips/mach-pic32/cpu.c
+++ b/arch/mips/mach-pic32/cpu.c
@@ -57,7 +57,7 @@ static ulong clk_get_cpu_rate(void)
 }
 
 /* initialize prefetch module related to cpu_clk */
-static void prefetch_init(void)
+static int prefetch_init(void)
 {
 	struct pic32_reg_atomic *regs;
 	const void __iomem *base;
@@ -93,6 +93,8 @@ static void prefetch_init(void)
 	/* Enable prefetch for all */
 	writel(0x30, &regs->set);
 	iounmap(regs);
+
+	return 0;
 }
 
 /* arch-specific CPU init after DM: flash prefetch */
diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index d7eedbd7436e..835b2c777462 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <cpu_func.h>
+#include <event.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <usb.h>
@@ -74,8 +75,11 @@ static void board_final_init(void)
 	}
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		return 0;
+
 	/* start usb so that usb keyboard can be used as input device */
 	if (IS_ENABLED(CONFIG_USB_KEYBOARD))
 		usb_init();
@@ -84,3 +88,4 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index dddd281e966c..ce55efc454bf 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -26,6 +26,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
+#include <event.h>
 #include <init.h>
 #include <irq.h>
 #include <log.h>
@@ -185,7 +186,8 @@ void show_boot_progress(int val)
 }
 #endif
 
-#if !defined(CONFIG_SYS_COREBOOT) && !defined(CONFIG_EFI_STUB)
+#if !defined(CONFIG_SYS_COREBOOT) && !defined(CONFIG_EFI_STUB) && \
+	!defined(CONFIG_SPL_BUILD)
 /*
  * Implement a weak default function for boards that need to do some final init
  * before the system is ready.
@@ -202,7 +204,7 @@ __weak void board_final_cleanup(void)
 {
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	struct acpi_fadt __maybe_unused *fadt;
 	int ret;
@@ -245,7 +247,9 @@ int last_stage_init(void)
 
 	return 0;
 }
-#endif
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
+
+#endif  /* !SYS_COREBOOT && !EFI_STUB && !SPL_BUILD */
 
 static int x86_init_cpus(void)
 {
diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index d8920effd398..708bfbe7ee48 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -9,6 +9,7 @@
 #include <efi.h>
 #include <efi_api.h>
 #include <errno.h>
+#include <event.h>
 #include <init.h>
 #include <log.h>
 #include <usb.h>
@@ -168,7 +169,7 @@ int reserve_arch(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	/* start usb so that usb keyboard can be used as input device */
 	if (IS_ENABLED(CONFIG_USB_KEYBOARD))
@@ -176,6 +177,7 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
 unsigned int install_e820_map(unsigned int max_entries,
 			      struct e820_entry *entries)
diff --git a/arch/x86/cpu/quark/quark.c b/arch/x86/cpu/quark/quark.c
index 86d90d84ddba..62b83c228cfb 100644
--- a/arch/x86/cpu/quark/quark.c
+++ b/arch/x86/cpu/quark/quark.c
@@ -107,7 +107,7 @@ static void quark_setup_bars(void)
 		       CONFIG_PCIE_ECAM_BASE | MEM_BAR_EN);
 }
 
-static void quark_pcie_early_init(void)
+static int quark_pcie_early_init(void)
 {
 	/*
 	 * Step1: Assert PCIe signal PERST#
@@ -146,6 +146,8 @@ static void quark_pcie_early_init(void)
 	/* Mixer Load Lane 1 */
 	msg_port_io_clrbits(MSG_PORT_PCIE_AFE, PCIE_RXPICTRL0_L1,
 			    (1 << 6) | (1 << 7));
+
+	return 0;
 }
 
 static void quark_usb_early_init(void)
diff --git a/board/CZ.NIC/turris_mox/turris_mox.c b/board/CZ.NIC/turris_mox/turris_mox.c
index a52a032e4d5d..370c2668b081 100644
--- a/board/CZ.NIC/turris_mox/turris_mox.c
+++ b/board/CZ.NIC/turris_mox/turris_mox.c
@@ -15,6 +15,7 @@
 #include <dm.h>
 #include <dm/of_extra.h>
 #include <env.h>
+#include <event.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <led.h>
@@ -667,7 +668,7 @@ err:
 	return NULL;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	struct gpio_desc reset_gpio = {};
 
@@ -712,6 +713,7 @@ handle_reset_btn:
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
 #if defined(CONFIG_OF_BOARD_SETUP)
 
diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 3ab6e8873d84..3fe5319437ea 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -8,6 +8,7 @@
 #include <dm/device-internal.h>
 #include <env.h>
 #include <env_internal.h>
+#include <event.h>
 #include <i2c.h>
 #include <init.h>
 #include <mmc.h>
@@ -301,7 +302,7 @@ static int mii_multi_chip_mode_write(struct udevice *bus, int dev_smi_addr,
 }
 
 /* Bring-up board-specific network stuff */
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	struct udevice *bus;
 	ofnode node;
@@ -356,6 +357,8 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
+
 #endif
 
 #ifdef CONFIG_OF_BOARD_SETUP
diff --git a/board/Marvell/octeon_nic23/board.c b/board/Marvell/octeon_nic23/board.c
index 08b1aa4b6efe..bc9332cb74a3 100644
--- a/board/Marvell/octeon_nic23/board.c
+++ b/board/Marvell/octeon_nic23/board.c
@@ -5,6 +5,7 @@
 
 #include <cyclic.h>
 #include <dm.h>
+#include <event.h>
 #include <ram.h>
 #include <time.h>
 #include <asm/gpio.h>
@@ -364,7 +365,7 @@ int board_late_init(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	struct gpio_desc gpio = {};
 	ofnode node;
@@ -386,3 +387,4 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
diff --git a/board/Marvell/octeontx2/board.c b/board/Marvell/octeontx2/board.c
index e7899f49f0c2..974e9eb82001 100644
--- a/board/Marvell/octeontx2/board.c
+++ b/board/Marvell/octeontx2/board.c
@@ -12,6 +12,7 @@
 #include <asm/global_data.h>
 #include <dm/uclass-internal.h>
 #include <env.h>
+#include <event.h>
 #include <init.h>
 #include <malloc.h>
 #include <net.h>
@@ -213,11 +214,12 @@ void board_acquire_flash_arb(bool acquire)
 	}
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	(void)smc_flsf_fw_booted();
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
 static int do_go_uboot(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
diff --git a/board/cortina/presidio-asic/presidio.c b/board/cortina/presidio-asic/presidio.c
index aae0a5dac066..fdfa3affc3b1 100644
--- a/board/cortina/presidio-asic/presidio.c
+++ b/board/cortina/presidio-asic/presidio.c
@@ -4,6 +4,7 @@
  *
  */
 #include <common.h>
+#include <event.h>
 #include <init.h>
 #include <malloc.h>
 #include <errno.h>
@@ -121,7 +122,7 @@ void reset_cpu(void)
 }
 
 #ifdef CONFIG_LAST_STAGE_INIT
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	u32 val;
 
@@ -134,4 +135,5 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 #endif
diff --git a/board/emulation/qemu-ppce500/qemu-ppce500.c b/board/emulation/qemu-ppce500/qemu-ppce500.c
index a39bcb4fa0c7..7ca8773b17e5 100644
--- a/board/emulation/qemu-ppce500/qemu-ppce500.c
+++ b/board/emulation/qemu-ppce500/qemu-ppce500.c
@@ -9,6 +9,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <env.h>
+#include <event.h>
 #include <init.h>
 #include <log.h>
 #include <net.h>
@@ -184,7 +185,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	void *fdt = get_fdt_virt();
 	int len = 0;
@@ -204,6 +205,7 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
 static uint64_t get_linear_ram_size(void)
 {
diff --git a/board/gdsys/a38x/controlcenterdc.c b/board/gdsys/a38x/controlcenterdc.c
index ccebba72721f..0f620c2d9172 100644
--- a/board/gdsys/a38x/controlcenterdc.c
+++ b/board/gdsys/a38x/controlcenterdc.c
@@ -7,6 +7,7 @@
 #include <common.h>
 #include <command.h>
 #include <dm.h>
+#include <event.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
@@ -35,19 +36,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define DB_GP_88F68XX_GPP_POL_LOW	0x0
 #define DB_GP_88F68XX_GPP_POL_MID	0x0
 
-static int get_tpm(struct udevice **devp)
-{
-	int rc;
-
-	rc = uclass_first_device_err(UCLASS_TPM, devp);
-	if (rc) {
-		printf("Could not find TPM (ret=%d)\n", rc);
-		return CMD_RET_FAILURE;
-	}
-
-	return 0;
-}
-
 /*
  * Define the DDR layout / topology here in the board file. This will
  * be used by the DDR3 init code in the SPL U-Boot version to configure
@@ -284,15 +272,22 @@ int board_fix_fdt(void *rw_fdt_blob)
 	return 0;
 }
 
-int last_stage_init(void)
+#ifndef CONFIG_SPL_BUILD
+static int last_stage_init(void)
 {
 	struct udevice *tpm;
 	int ret;
 
-#ifndef CONFIG_SPL_BUILD
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		return 0;
 	ccdc_eth_init();
-#endif
-	ret = get_tpm(&tpm);
+
+	ret = uclass_first_device_err(UCLASS_TPM, &tpm);
+	if (ret) {
+		printf("Could not find TPM (ret=%d)\n", ret);
+		return ret;
+	}
+
 	if (ret || tpm_init(tpm) || tpm1_startup(tpm, TPM_ST_CLEAR) ||
 	    tpm1_continue_self_test(tpm)) {
 		return 1;
@@ -305,3 +300,5 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
+#endif
diff --git a/board/gdsys/mpc8308/gazerbeam.c b/board/gdsys/mpc8308/gazerbeam.c
index ba88401f13da..cc608c4ac434 100644
--- a/board/gdsys/mpc8308/gazerbeam.c
+++ b/board/gdsys/mpc8308/gazerbeam.c
@@ -9,6 +9,7 @@
 #include <command.h>
 #include <dm.h>
 #include <env.h>
+#include <event.h>
 #include <fdt_support.h>
 #include <fsl_esdhc.h>
 #include <init.h>
@@ -124,7 +125,7 @@ static void display_osd_info(struct udevice *osd,
 	       osd_info->width, osd_info->height);
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	int fpga_hw_rev = 0;
 	int i;
@@ -179,6 +180,7 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
 #if defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/board/ge/bx50v3/bx50v3.c b/board/ge/bx50v3/bx50v3.c
index 4e9d841fe291..2d8951964a85 100644
--- a/board/ge/bx50v3/bx50v3.c
+++ b/board/ge/bx50v3/bx50v3.c
@@ -5,6 +5,7 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
+#include <event.h>
 #include <image.h>
 #include <init.h>
 #include <asm/arch/clock.h>
@@ -531,7 +532,7 @@ static void remove_ethaddr_env_var(int index)
 	env_set(env_var_name, NULL);
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	int i;
 
@@ -544,6 +545,7 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
 int checkboard(void)
 {
diff --git a/board/keymile/km83xx/km83xx.c b/board/keymile/km83xx/km83xx.c
index 8f2d873bc68f..acd13105dd55 100644
--- a/board/keymile/km83xx/km83xx.c
+++ b/board/keymile/km83xx/km83xx.c
@@ -15,6 +15,7 @@
 
 #include <common.h>
 #include <env.h>
+#include <event.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <ioports.h>
@@ -184,7 +185,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 #if defined(CONFIG_TARGET_KMCOGE5NE)
 	/*
@@ -202,6 +203,7 @@ int last_stage_init(void)
 	set_km_env();
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
 static int fixed_sdram(void)
 {
diff --git a/board/keymile/kmcent2/kmcent2.c b/board/keymile/kmcent2/kmcent2.c
index 7e655175c577..572cc7bbdc67 100644
--- a/board/keymile/kmcent2/kmcent2.c
+++ b/board/keymile/kmcent2/kmcent2.c
@@ -261,7 +261,7 @@ int hush_init_var(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	const char *kmem;
 	/* DIP switch support on BFTIC */
@@ -287,6 +287,7 @@ int last_stage_init(void)
 
 	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
 
 void fdt_fixup_fman_mac_addresses(void *blob)
 {
diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
index d7f47959ebd7..21c21aac221f 100644
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
+++ b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
@@ -215,8 +215,4 @@ int hush_init_var(void)
 	return 0;
 }
 
-int last_stage_init(void)
-{
-	set_km_env();
-	return 0;
-}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, set_km_env);
diff --git a/board/phytium/durian/durian.c b/board/phytium/durian/durian.c
index ee484749bcf1..0a4048d4982f 100644
--- a/board/phytium/durian/durian.c
+++ b/board/phytium/durian/durian.c
@@ -8,6 +8,7 @@
 #include <common.h>
 #include <command.h>
 #include <cpu_func.h>
+#include <event.h>
 #include <init.h>
 #include <log.h>
 #include <asm/armv8/mmu.h>
@@ -99,7 +100,7 @@ int __asm_flush_l3_dcache(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	int ret;
 
@@ -113,3 +114,4 @@ int last_stage_init(void)
 	}
 	return ret;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
diff --git a/board/phytium/pomelo/pomelo.c b/board/phytium/pomelo/pomelo.c
index 75d2636bf453..960e491c7687 100644
--- a/board/phytium/pomelo/pomelo.c
+++ b/board/phytium/pomelo/pomelo.c
@@ -7,6 +7,7 @@
 
 #include <stdio.h>
 #include <command.h>
+#include <event.h>
 #include <init.h>
 #include <asm/armv8/mmu.h>
 #include <asm/io.h>
@@ -102,7 +103,7 @@ int __asm_flush_l3_dcache(void)
 	return 0;
 }
 
-int last_stage_init(void)
+static int last_stage_init(void)
 {
 	int ret;
 
@@ -116,3 +117,4 @@ int last_stage_init(void)
 	}
 	return ret;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
diff --git a/common/Kconfig b/common/Kconfig
index 0b09bd68bd13..d916194b9423 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -720,6 +720,7 @@ config SYS_FSL_CLK
 
 config LAST_STAGE_INIT
 	bool "Call board-specific as last setup step"
+	select EVENT
 	help
 	  Some boards need to perform initialisation immediately before control
 	  is passed to the command-line interpreter (e.g. for initializations
diff --git a/common/board_r.c b/common/board_r.c
index 7c1fbc69ed6d..ad9a3cf6336a 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -773,15 +773,8 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_POST
 	initr_post,
 #endif
-#ifdef CONFIG_LAST_STAGE_INIT
 	INIT_FUNC_WATCHDOG_RESET
-	/*
-	 * Some parts can be only initialized if all others (like
-	 * Interrupts) are up and running (i.e. the PC-style ISA
-	 * keyboard).
-	 */
-	last_stage_init,
-#endif
+	INITCALL_EVENT(EVT_LAST_STAGE_INIT),
 #if defined(CFG_PRAM)
 	initr_mem,
 #endif
diff --git a/common/event.c b/common/event.c
index 8a6190888845..4845104b17dc 100644
--- a/common/event.c
+++ b/common/event.c
@@ -36,6 +36,7 @@ const char *const type_name[] = {
 	/* init hooks */
 	"misc_init_f",
 	"fsp_init_r",
+	"last_stage_init",
 
 	/* Fpga load hook */
 	"fpga_load",
diff --git a/configs/bayleybay_defconfig b/configs/bayleybay_defconfig
index a44c9b714be6..573f1b48645a 100644
--- a/configs/bayleybay_defconfig
+++ b/configs/bayleybay_defconfig
@@ -25,7 +25,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/cherryhill_defconfig b/configs/cherryhill_defconfig
index 00799715e8f9..59c3986a2e78 100644
--- a/configs/cherryhill_defconfig
+++ b/configs/cherryhill_defconfig
@@ -18,7 +18,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 152f297c350b..5394396f8fc6 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -40,7 +40,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_BLOBLIST=y
 # CONFIG_TPL_BLOBLIST is not set
 CONFIG_BLOBLIST_ADDR=0x100000
diff --git a/configs/chromebook_link64_defconfig b/configs/chromebook_link64_defconfig
index 558609e13d66..eb8923ceeff7 100644
--- a/configs/chromebook_link64_defconfig
+++ b/configs/chromebook_link64_defconfig
@@ -29,7 +29,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index 96c26f1c3776..4347cad33db1 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -25,7 +25,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/chromebook_samus_defconfig b/configs/chromebook_samus_defconfig
index 4019c169a4c7..3b6a1732c111 100644
--- a/configs/chromebook_samus_defconfig
+++ b/configs/chromebook_samus_defconfig
@@ -25,7 +25,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index 4cfaf4bc5c79..33ada9fe4f93 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -30,7 +30,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0xff7c0000
diff --git a/configs/chromebox_panther_defconfig b/configs/chromebox_panther_defconfig
index f050d066be41..4351a811528b 100644
--- a/configs/chromebox_panther_defconfig
+++ b/configs/chromebox_panther_defconfig
@@ -21,7 +21,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig b/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
index 656d575998c7..1515246086ea 100644
--- a/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
+++ b/configs/conga-qeval20-qa3-e3845-internal-uart_defconfig
@@ -31,7 +31,6 @@ CONFIG_BOOTCOMMAND="load scsi 0:2 03000000 /boot/vmlinuz-${kernel-ver}-generic;l
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/conga-qeval20-qa3-e3845_defconfig b/configs/conga-qeval20-qa3-e3845_defconfig
index 54dc59e8a134..d62fb997c993 100644
--- a/configs/conga-qeval20-qa3-e3845_defconfig
+++ b/configs/conga-qeval20-qa3-e3845_defconfig
@@ -27,7 +27,6 @@ CONFIG_BOOTCOMMAND="load scsi 0:2 03000000 /boot/vmlinuz-${kernel-ver}-generic;l
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 8aadaa68c279..2793e2c0b9d1 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -19,7 +19,6 @@ CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 8e11de663819..f196ed776d0b 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -20,7 +20,6 @@ CONFIG_LOG=y
 CONFIG_LOGF_LINE=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_PCI_INIT_R=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
diff --git a/configs/cougarcanyon2_defconfig b/configs/cougarcanyon2_defconfig
index da5ff5573d05..71c79f5fb8da 100644
--- a/configs/cougarcanyon2_defconfig
+++ b/configs/cougarcanyon2_defconfig
@@ -20,7 +20,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/crownbay_defconfig b/configs/crownbay_defconfig
index 70e1a50a244e..e734c758dac8 100644
--- a/configs/crownbay_defconfig
+++ b/configs/crownbay_defconfig
@@ -21,7 +21,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/dfi-bt700-q7x-151_defconfig b/configs/dfi-bt700-q7x-151_defconfig
index 9313e7fbd121..79f5d74ec597 100644
--- a/configs/dfi-bt700-q7x-151_defconfig
+++ b/configs/dfi-bt700-q7x-151_defconfig
@@ -26,7 +26,6 @@ CONFIG_BOOTCOMMAND="load scsi 0:1 03000000 /boot/vmlinuz-${kernel-ver}-generic;l
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/edison_defconfig b/configs/edison_defconfig
index 8692a8a9995a..f134680e4122 100644
--- a/configs/edison_defconfig
+++ b/configs/edison_defconfig
@@ -13,7 +13,6 @@ CONFIG_TARGET_EDISON=y
 CONFIG_SMP=y
 CONFIG_SYS_MONITOR_BASE=0x01101000
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=128
 CONFIG_SYS_CBSIZE=2048
diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 1bfc01f060d4..dfc315774a50 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -16,7 +16,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 46a1900c704b..e0cfe3ee243a 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -17,7 +17,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
index 4149eea6cf64..15323678e314 100644
--- a/configs/efi-x86_payload32_defconfig
+++ b/configs/efi-x86_payload32_defconfig
@@ -15,7 +15,6 @@ CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_IDE=y
diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
index d41f73cccfc9..80460d336fb1 100644
--- a/configs/efi-x86_payload64_defconfig
+++ b/configs/efi-x86_payload64_defconfig
@@ -15,7 +15,6 @@ CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_IDE=y
diff --git a/configs/galileo_defconfig b/configs/galileo_defconfig
index c6d989ea6ef3..c226ae11a818 100644
--- a/configs/galileo_defconfig
+++ b/configs/galileo_defconfig
@@ -17,7 +17,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/minnowmax_defconfig b/configs/minnowmax_defconfig
index 8347a9dcecf9..80e6a4c12b9e 100644
--- a/configs/minnowmax_defconfig
+++ b/configs/minnowmax_defconfig
@@ -30,7 +30,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index c6f30674a8fc..165f0b512c8b 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -33,7 +33,6 @@ CONFIG_LOG=y
 CONFIG_LOGF_FUNC=y
 CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_PCI_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x10000
@@ -84,11 +83,11 @@ CONFIG_SPL_DM_RTC=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
-CONFIG_SPL_VIDEO=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
 CONFIG_CONSOLE_SCROLL_LINES=5
+CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 24682a5387df..4b2787d4aaef 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -23,7 +23,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_PCI_INIT_R=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/som-db5800-som-6867_defconfig b/configs/som-db5800-som-6867_defconfig
index 4a149133db60..44db48204bd8 100644
--- a/configs/som-db5800-som-6867_defconfig
+++ b/configs/som-db5800-som-6867_defconfig
@@ -27,7 +27,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
index 69499e17f4c9..c5bd0d967366 100644
--- a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
@@ -26,7 +26,6 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/theadorable-x86-conga-qa3-e3845_defconfig b/configs/theadorable-x86-conga-qa3-e3845_defconfig
index e2e64b743494..b3afaf34a02f 100644
--- a/configs/theadorable-x86-conga-qa3-e3845_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845_defconfig
@@ -25,7 +25,6 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/configs/theadorable-x86-dfi-bt700_defconfig b/configs/theadorable-x86-dfi-bt700_defconfig
index 751ae3497ec6..8222697f7471 100644
--- a/configs/theadorable-x86-dfi-bt700_defconfig
+++ b/configs/theadorable-x86-dfi-bt700_defconfig
@@ -24,7 +24,6 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_CPU=y
diff --git a/include/event.h b/include/event.h
index 85269aa317aa..747a9f6c654b 100644
--- a/include/event.h
+++ b/include/event.h
@@ -41,6 +41,18 @@ enum event_t {
 	 */
 	EVT_FSP_INIT_F,
 
+	/*
+	 * Emitted just before jumping to the main loop
+	 *
+	 * Some boards need to perform initialisation immediately before control
+	 * is passed to the command-line interpreter (e.g. for init that depend
+	 * on later phases in the init sequence).
+	 *
+	 * Some parts can be only initialized if all others (like Interrupts)
+	 * are up and running (e.g. the PC-style ISA keyboard).
+	 */
+	EVT_LAST_STAGE_INIT,
+
 	/* Fpga load hook */
 	EVT_FPGA_LOAD,
 
diff --git a/include/init.h b/include/init.h
index 13579db75900..4e7fe26c2004 100644
--- a/include/init.h
+++ b/include/init.h
@@ -270,7 +270,6 @@ void board_init_r(struct global_data *id, ulong dest_addr)
 	__attribute__ ((noreturn));
 
 int cpu_init_r(void);
-int last_stage_init(void);
 int mac_read_from_eeprom(void);
 int set_cpu_clk_info(void);
 int update_flash_size(int flash_size);
-- 
2.42.0.rc1.204.g551eb34607-goog

