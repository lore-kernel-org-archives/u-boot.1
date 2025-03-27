Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8C7C3600C
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 17:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3F08070C;
	Thu, 27 Mar 2025 18:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F44C80ECC; Thu, 27 Mar 2025 18:57:48 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A264806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 18:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from hay.lan. (unknown
 [IPv6:2605:59c0:20f3:a400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id CB7C4B4C0CE5;
 Thu, 27 Mar 2025 18:57:43 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>,
	u-boot@lists.denx.de
Subject: [PATCH v1] board: starfive: Remove compatible boards Milk-V Mars CM
 and Mars CM Lite
Date: Thu, 27 Mar 2025 10:55:08 -0700
Message-ID: <20250327175550.529248-1-e@freeshell.de>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove leftover code from Milk-V Mars CM and Mars CM Lite boards that do
not exist in upstream Linux Kernel devicetree-rebasing. These will be re-
introduced when submitted upstream for a future U-Boot release. Users of
these boards should use the previous stable release of U-Boot until then.

Signed-off-by: E Shattow <e@freeshell.de>
---
 board/starfive/visionfive2/Kconfig            |   9 -
 board/starfive/visionfive2/spl.c              |   8 -
 .../visionfive2/starfive_visionfive2.c        |  11 +-
 .../visionfive2/visionfive2-i2c-eeprom.c      |   3 -
 doc/board/starfive/index.rst                  |   1 -
 doc/board/starfive/milk-v_mars_cm.rst         | 193 ------------------
 6 files changed, 1 insertion(+), 224 deletions(-)
 delete mode 100644 doc/board/starfive/milk-v_mars_cm.rst

diff --git a/board/starfive/visionfive2/Kconfig b/board/starfive/visionfive2/Kconfig
index d7e8a7a7d78..2186a939646 100644
--- a/board/starfive/visionfive2/Kconfig
+++ b/board/starfive/visionfive2/Kconfig
@@ -50,13 +50,4 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply PHY_LIB
 	imply PHY_MSCC
 
-config STARFIVE_NO_EMMC
-	bool "Report eMMC size as zero"
-	help
-	  The serial number string in the EEPROM is meant to report the
-	  size of onboard eMMC. Unfortunately some Milk-V Mars CM Lite
-	  modules without eMMC show a non-zero size here.
-
-	  Set to 'Y' if you have a Mars CM Lite module.
-
 endif
diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 22afd76c6b9..f41bd6d603f 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -130,14 +130,6 @@ int board_fit_config_name_match(const char *name)
 	} else if (!strncmp(product_id, "MARS", 4) &&
 		   !strcmp(name, "jh7110-milkv-mars")) {
 		return 0;
-	} else if (!strncmp(product_id, "MARC", 4)) {
-		if (!get_mmc_size_from_eeprom()) {
-			if (!strcmp(name, "jh7110-milkv-mars-cm-lite"))
-				return 0;
-		} else {
-			if (!strcmp(name, "jh7110-milkv-mars-cm"))
-				return 0;
-		}
 	} else if (!strncmp(product_id, "STAR64", 6) &&
 		   !strcmp(name, "jh7110-pine64-star64")) {
 		return 0;
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 3940d45b13f..b8cd509bc89 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -19,10 +19,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
 #define FDTFILE_MILK_V_MARS \
 	"starfive/jh7110-milkv-mars.dtb"
-#define FDTFILE_MILK_V_MARS_CM \
-	"starfive/jh7110-milkv-mars-cm.dtb"
-#define FDTFILE_MILK_V_MARS_CM_LITE \
-	"starfive/jh7110-milkv-mars-cm-lite.dtb"
 #define FDTFILE_VISIONFIVE2_1_2A \
 	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
 #define FDTFILE_VISIONFIVE2_1_3B \
@@ -67,12 +63,7 @@ static void set_fdtfile(void)
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARC", 4)) {
-		if (get_mmc_size_from_eeprom())
-			fdtfile = FDTFILE_MILK_V_MARS_CM;
-		else
-			fdtfile = FDTFILE_MILK_V_MARS_CM_LITE;
-	} else if (!strncmp(product_id, "MARS", 4)) {
+	if (!strncmp(product_id, "MARS", 4)) {
 		fdtfile = FDTFILE_MILK_V_MARS;
 	} else if (!strncmp(product_id, "VF7110", 6)) {
 		version = get_pcb_revision_from_eeprom();
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 838f41e41bd..010e386e64d 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -573,9 +573,6 @@ u32 get_mmc_size_from_eeprom(void)
 {
 	u32 size;
 
-	if (IS_ENABLED(CONFIG_STARFIVE_NO_EMMC))
-		return 0;
-
 	if (read_eeprom())
 		return 0;
 
diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 72ab6ddfbf6..2cba1b6dc56 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -7,6 +7,5 @@ StarFive
    :maxdepth: 1
 
    milk-v_mars
-   milk-v_mars_cm
    pine64_star64
    visionfive2
diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/milk-v_mars_cm.rst
deleted file mode 100644
index 52d4e5e9098..00000000000
--- a/doc/board/starfive/milk-v_mars_cm.rst
+++ /dev/null
@@ -1,193 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-
-Milk-V Mars CM
-==============
-
-U-Boot for the Milk-V Mars CM uses the same U-Boot binaries as the VisionFive 2
-board. In U-Boot SPL the actual board is detected and the device-tree patched
-accordingly.
-
-The Milk-V Mars CM Lite comes without eMMC and needs a different pin muxing
-than the Milk-V Mars CM. The availability and size of the eMMC shows up in the
-serial number displayed by the *mac* command, e.g.
-MARC-V10-2340-D002E016-00000304. The number after the E is the MMC size. U-Boot
-takes a value of E000 as an indicator for the Lite version. Unfortunately the
-vendor has not set this value correctly on some Lite boards.
-
-Please, use CONFIG_STARFIVE_NO_EMMC=y if EEPROM data indicates eMMC is present
-on the Milk-V Mars CM Lite. Otherwise you will not be able to read from the
-SD-card.
-
-The serial number can be corrected using the *mac* command:
-
-.. code-block::
-
-    mac read_eeprom
-    mac product_id MARC-V10-2340-D002E000-00000304
-    mac write_eeprom
-
-.. note::
-
-   The *mac initialize* command overwrites the vendor string and the MAC
-   addresses. This is why it is avoided here.
-
-By default the EEPROM is write protected. The write protection may be overcome
-by connecting the "GND" and "EN" test pads on top of the module.
-
-Building
-~~~~~~~~
-
-1. Add the RISC-V toolchain to your PATH.
-2. Setup ARCH & cross compilation environment variable:
-
-.. code-block:: none
-
-   export CROSS_COMPILE=<riscv64 toolchain prefix>
-
-The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
-is responsible for the switch to S-Mode. It is a prerequisite to build U-Boot.
-Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended to use
-a current release.
-
-.. code-block:: console
-
-	git clone https://github.com/riscv/opensbi.git
-	cd opensbi
-	make PLATFORM=generic FW_TEXT_START=0x40000000
-
-(*FW_TEXT_START* is not needed anymore after OpenSBI patch d4d2582eef7a
-"firmware: remove FW_TEXT_START" which should appear in OpenSBI 1.5.)
-
-Now build the U-Boot SPL and U-Boot proper.
-
-.. code-block:: console
-
-	cd <U-Boot-dir>
-	make starfive_visionfive2_defconfig
-	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
-
-This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
-as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
-
-Device-tree selection
-~~~~~~~~~~~~~~~~~~~~~
-
-Depending on the board version U-Boot sets variable $fdtfile to either
-starfive/jh7110-milkv-mars-cm.dtb (with eMMC storage) or
-starfive/jh7110-milkv-mars-cm-lite.dtb (without eMMC storage).
-
-To overrule this selection the variable can be set manually and saved in the
-environment
-
-::
-
-    env set fdtfile my_device-tree.dtb
-    env save
-
-or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
-provide a default value.
-
-The variable *$fdtfile* is used in the boot process to automatically load
-a device-tree provided by the operating system. For details of the boot
-process refer to the :doc:`/develop/bootstd/index`
-description.
-
-Boot source selection
-~~~~~~~~~~~~~~~~~~~~~
-
-The low speed connector nRPIBOOT line is used to switch the boot source.
-
-* If nRPIBOOT is connected to ground, the board boots from UART.
-* If nRPIBOOT is not connected, the board boots from SPI flash.
-
-Compute module boards typically have a switch or jumper for this line.
-
-Flashing a new U-Boot version
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main U-Boot is
-in file u-boot.itb.
-
-Assuming your new U-Boot version is on partition 1 of an SD-card you could
-install it to the SPI flash with:
-
-::
-
-    sf probe
-    load mmc 0:1 $kernel_addr_r u-boot-spl.bin.normal.out
-    sf update $kernel_addr_r 0 $filesize
-    load mmc 0:1 $kernel_addr_r u-boot.itb
-    sf update $kernel_addr_r 0x100000 $filesize
-
-For loading the files from a TFTP server refer to the dhcp and tftpboot
-commands.
-
-After updating U-Boot you may want to reboot and reset the environment to the
-default.
-
-::
-
-    env default -f -a
-    env save
-
-Booting from UART
-~~~~~~~~~~~~~~~~~
-
-For booting via UART U-Boot must be built with CONFIG_SPL_YMODEM_SUPPORT=y.
-
-With nRPIBOOT connected to ground for UART boot, power the board and upload
-u-boot-spl.bin.normal.out via XMODEM. Then upload u-boot.itb via YMODEM.
-
-The XMODEM implementation in the boot ROM is not fully specification compliant.
-It sends too many NAKs in a row. Tio is a terminal emulation that tolerates
-these faults.
-
-::
-
-    $ tio -b 115200 --databits 8 --flow none --stopbits 1 /dev/ttyUSB0
-    [08:14:54.700] tio v2.7
-    [08:14:54.700] Press ctrl-t q to quit
-    [08:14:54.701] Connected
-
-    (C)StarFive
-    CCC
-    (C)StarFive
-    CCCCCCCC
-
-Press *ctrl-t x* to initiate XMODEM-1K transfer.
-
-::
-
-    [08:15:14.778] Send file with XMODEM
-    [08:15:22.459] Sending file 'u-boot-spl.bin.normal.out'
-    [08:15:22.459] Press any key to abort transfer
-    ........................................................................
-    .......................................................................|
-    [08:15:22.459] Done
-
-    U-Boot SPL 2024.07-rc1-00075-gd6a4ab20097 (Apr 25 2024 - 16:32:10 +0200)
-    DDR version: dc2e84f0.
-    Trying to boot from UART
-    CC
-
-Press *ctrl-t y* to initiate YMODEM transfer.
-
-::
-
-    [08:15:50.331] Send file with YMODEM
-    [08:15:53.540] Sending file 'u-boot.itb'
-    [08:15:53.540] Press any key to abort transfer
-    ........................................................................
-    …
-    ...............|
-    [08:15:53.540] Done
-    Loaded 1040599 bytes
-
-
-    U-Boot 2024.07-rc1-00075-gd6a4ab20097 (Apr 25 2024 - 16:32:10 +0200)
-
-Booting from SPI flash
-~~~~~~~~~~~~~~~~~~~~~~
-
-With nRPIBOOT disconnected from ground for SPI boot, power up the board. You
-should see the U-Boot prompt on the serial console.

base-commit: 3f9e0349c3e8afe45d5bdb2328a16512cfbc2ef1
-- 
2.49.0

