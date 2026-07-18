Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77586C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E2380398;
	Sun, 19 Jul 2026 03:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lM3H98Ou";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Kz+Yh5mr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C60583EEF; Sun, 19 Jul 2026 01:46:42 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2BA8005D
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 01:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h2k2L12DDzMlG9;
 Sun, 19 Jul 2026 01:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784418394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4csy4y37TXZAScL554yCeNg62e/SLSddcX8fYKt1d6w=;
 b=lM3H98OuUx8g74Q0DmnouEN0KLSt6ZCwwSBTjlsF3/hM42jYR8CdRB3jTemw8CI8/yvFUG
 ZU4r3afkVaK5BE+z7BTRe2bGKfaLGSCZq/EjUacU5I0XIbFc24AMwYeCAnko20WRB3x7cg
 Q5X7Y5rVm6H9W3KxC3pGdfoufvdDM6UhyUoNWOTCsZqvv7KACZ/Uut1s1HXxvJ2tVSmwvH
 y2Y2fObVmkWw9TqZnrcX4/CD2tlh2N3zxgLmUuap19fftJ7DikVBxXDBwqokpHJOdxCmHx
 N6/U3SVAAGjN6ZQdavJVS6F0qj7DJzKqKwWxNm1X54gI/KeKtjMsfbCBUhL5mg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784418391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4csy4y37TXZAScL554yCeNg62e/SLSddcX8fYKt1d6w=;
 b=Kz+Yh5mrHRVtIE7S7cFcFv4uhi/GF08WeFFXUMAHFeAlP5fdlNHpWCmaM/QKhL/Ftw4IGt
 Lffz0DD75E0L6b2hy/ZUTwh0BeAr2EQAUgEQtawCtD1cocrumclD04PqxXwCePmTZfEyl9
 GbQIvoKkkvP+cUvjcdglaYELKv2xYsiVaujByx23G3iR1xHqMQz4ME1DMcp/ND8lWVSvOK
 BfInwFPDs4b1HotRW17y24iv8AJMQSn4VgiL5oJFlS5hqdv+LnZG50WfBBTcCRu12auHkj
 m4ez9G9EoxDUsahZzdAfvmRfqF4w/q7z1hsMUZQzCvxL0bpRpQDVwILoSkr5oA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Daniel Golle <daniel@makrotopia.org>, Dillon Min <dillon.minfei@gmail.com>,
 E Shattow <e@freeshell.de>, Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@ew.tq-group.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] doc: Switch from setenv to env set
Date: Sun, 19 Jul 2026 01:45:48 +0200
Message-ID: <20260718234617.98664-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fbad399010a87ec25ee
X-MBO-RS-META: e5dzx7o89c6ze96iuxxnaqar7riu96xf
X-Mailman-Approved-At: Sun, 19 Jul 2026 03:27:40 +0200
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

The "env" command is the recommended environment management command,
its "set" subcommand is the equivalent replacement for legacy "setenv"
command. Update the documentation to use the contemporary "env set"
command instead of legacy "setenv" command.

Note that the "setenv" command is unlikely to be removed from U-Boot
in the near future due to it being integral part of the command line
ABI.

Implemented using:
$ sed -i 's@\<setenv\>@env set@g' $(git grep -li '\<setenv\>' doc/) README

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Dillon Min <dillon.minfei@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Hal Feng <hal.feng@starfivetech.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Kamil Lulko <kamil.lulko@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Minda Chen <minda.chen@starfivetech.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@ew.tq-group.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 README                                        | 10 +++----
 doc/README.console                            |  4 +--
 doc/README.fsl-ddr                            | 30 +++++++++----------
 doc/README.iomux                              |  6 ++--
 doc/README.link-local                         |  6 ++--
 doc/README.marvell                            |  8 ++---
 doc/README.odroid                             | 18 +++++------
 doc/README.serial_multi                       | 26 ++++++++--------
 doc/README.srio-pcie-boot-corenet             |  4 +--
 doc/README.update                             |  2 +-
 doc/README.usb                                |  2 +-
 doc/README.video                              |  2 +-
 doc/SPL/README.am335x-network                 |  2 +-
 doc/android/avb2.rst                          |  2 +-
 doc/arch/sandbox/sandbox.rst                  | 24 +++++++--------
 doc/arch/x86/manual_boot.rst                  | 12 ++++----
 doc/board/andestech/ae350.rst                 |  8 ++---
 doc/board/bsh/imx6ulz_bsh_smm_m2.rst          |  4 +--
 doc/board/emulation/qemu-x86.rst              |  2 +-
 doc/board/intel/slimbootloader.rst            |  4 +--
 doc/board/microchip/mpfs_common.rst           | 12 ++++----
 doc/board/nxp/mx6sabreauto.rst                |  2 +-
 doc/board/nxp/mx6sabresd.rst                  |  4 +--
 doc/board/renesas/rcar-gen5-ironhide.rst      |  7 ++---
 doc/board/samsung/e850-96.rst                 | 22 +++++++-------
 doc/board/sifive/unleashed.rst                | 10 +++----
 doc/board/st/stm32mp1.rst                     |  2 +-
 doc/board/starfive/deepcomputing_fml13v01.rst |  2 +-
 doc/board/starfive/milk-v_mars.rst            |  2 +-
 doc/board/starfive/visionfive2.rst            |  2 +-
 doc/board/ti/am65x_evm.rst                    |  6 ++--
 doc/board/ti/dra7xx_evm.rst                   |  2 +-
 doc/board/ti/ks2_evm.rst                      |  6 ++--
 doc/board/tq/tqma6ul.rst                      |  2 +-
 doc/board/xilinx/zynqmp-r5.rst                |  4 +--
 doc/develop/bootstd/overview.rst              |  4 +--
 doc/develop/distro.rst                        |  8 ++---
 doc/develop/uefi/u-boot_on_efi.rst            |  4 +--
 doc/develop/uefi/uefi.rst                     | 12 ++++----
 doc/usage/cmd/bootd.rst                       |  6 ++--
 doc/usage/cmd/bootefi.rst                     |  8 ++---
 doc/usage/cmd/booti.rst                       |  4 +--
 doc/usage/cmd/bootmenu.rst                    |  8 ++---
 doc/usage/cmd/button.rst                      |  2 +-
 doc/usage/cmd/cedit.rst                       |  4 +--
 doc/usage/cmd/coninfo.rst                     |  2 +-
 doc/usage/cmd/echo.rst                        |  2 +-
 doc/usage/cmd/eficonfig.rst                   |  4 +--
 doc/usage/cmd/exit.rst                        |  4 +--
 doc/usage/cmd/extension.rst                   |  4 +--
 doc/usage/cmd/for.rst                         |  4 +--
 doc/usage/cmd/gpt.rst                         | 18 +++++------
 doc/usage/cmd/imxtract.rst                    |  4 +--
 doc/usage/cmd/mbr.rst                         |  2 +-
 doc/usage/cmd/printenv.rst                    |  2 +-
 doc/usage/cmd/saves.rst                       |  2 +-
 doc/usage/cmd/sntp.rst                        |  4 +--
 doc/usage/cmd/tftpput.rst                     |  2 +-
 doc/usage/cmd/wget.rst                        |  2 +-
 doc/usage/cmdline.rst                         |  6 ++--
 doc/usage/dfu.rst                             |  4 +--
 doc/usage/environment.rst                     | 10 +++----
 doc/usage/fdt_overlays.rst                    |  4 +--
 doc/usage/fit/beaglebone_vboot.rst            |  4 +--
 doc/usage/fit/howto.rst                       |  4 +--
 doc/usage/os/plan9.rst                        |  2 +-
 66 files changed, 205 insertions(+), 206 deletions(-)

diff --git a/README b/README
index 472cf37d9cc..5cbc9c152b5 100644
--- a/README
+++ b/README
@@ -401,7 +401,7 @@ The following options need to be configured:
 - USB Device:
 		Define the below if you wish to use the USB console.
 		Once firmware is rebuilt from a serial console issue the
-		command "setenv stdin usbtty; setenv stdout usbtty" and
+		command "env set stdin usbtty; env set stdout usbtty" and
 		attach your USB cable. The Unix command "dmesg" should print
 		it has found a new device. The environment variable usbtty
 		can be set to gserial or cdc_acm to enable your device to
@@ -725,7 +725,7 @@ The following options need to be configured:
 		remaining RAM in a form that can be passed as boot
 		argument to Linux, for instance like that:
 
-			setenv bootargs ... mem=\${mem}
+			env set bootargs ... mem=\${mem}
 			saveenv
 
 		This way you can tell Linux not to use this memory,
@@ -754,7 +754,7 @@ The following options need to be configured:
 		directly type `$name' at the command prompt.
 
 		Global environment variables are those you use
-		setenv/printenv to work with. To run a command stored
+		env set/printenv to work with. To run a command stored
 		in such a variable, you need to use the run command,
 		and you must not use the '$' sign to access them.
 
@@ -1655,13 +1655,13 @@ The "bootm" command is used to boot an application that is stored in
 memory (RAM or Flash). In case of a Linux kernel image, the contents
 of the "bootargs" environment variable is passed to the kernel as
 parameters. You can check and modify this variable using the
-"printenv" and "setenv" commands:
+"printenv" and "env set" commands:
 
 
 	=> printenv bootargs
 	bootargs=root=/dev/ram
 
-	=> setenv bootargs root=/dev/nfs rw nfsroot=10.0.0.2:/LinuxPPC nfsaddrs=10.0.0.99:10.0.0.2
+	=> env set bootargs root=/dev/nfs rw nfsroot=10.0.0.2:/LinuxPPC nfsaddrs=10.0.0.99:10.0.0.2
 
 	=> printenv bootargs
 	bootargs=root=/dev/nfs rw nfsroot=10.0.0.2:/LinuxPPC nfsaddrs=10.0.0.99:10.0.0.2
diff --git a/doc/README.console b/doc/README.console
index 9f5812c89d1..d6a2821ab68 100644
--- a/doc/README.console
+++ b/doc/README.console
@@ -24,8 +24,8 @@ stdout or stderr) to any device you see in that list simply by
 assigning its name to the corresponding environment variable. For
 example:
 
-    setenv stdin serial		<- To use the serial input
-    setenv stdout video		<- To use the video console
+    env set stdin serial		<- To use the serial input
+    env set stdout video		<- To use the video console
 
 Do a simple "saveenv" to save the console settings in the environment
 and get them working on the next startup, too.
diff --git a/doc/README.fsl-ddr b/doc/README.fsl-ddr
index f44bb2aa25d..04b26de4901 100644
--- a/doc/README.fsl-ddr
+++ b/doc/README.fsl-ddr
@@ -61,50 +61,50 @@ The ways to configure the ddr interleaving mode
 	 "hwconfig=fsl_ddr:ctlr_intlv=bank"			\
 	 ......
 
-2. Run U-Boot "setenv" command to configure the memory interleaving mode.
+2. Run U-Boot "env set" command to configure the memory interleaving mode.
    Either numerical or string value is accepted.
 
   # disable memory controller interleaving
-  setenv hwconfig "fsl_ddr:ctlr_intlv=null"
+  env set hwconfig "fsl_ddr:ctlr_intlv=null"
 
   # cacheline interleaving
-  setenv hwconfig "fsl_ddr:ctlr_intlv=cacheline"
+  env set hwconfig "fsl_ddr:ctlr_intlv=cacheline"
 
   # page interleaving
-  setenv hwconfig "fsl_ddr:ctlr_intlv=page"
+  env set hwconfig "fsl_ddr:ctlr_intlv=page"
 
   # bank interleaving
-  setenv hwconfig "fsl_ddr:ctlr_intlv=bank"
+  env set hwconfig "fsl_ddr:ctlr_intlv=bank"
 
   # superbank
-  setenv hwconfig "fsl_ddr:ctlr_intlv=superbank"
+  env set hwconfig "fsl_ddr:ctlr_intlv=superbank"
 
   # 1KB 3-way interleaving
-  setenv hwconfig "fsl_ddr:ctlr_intlv=3way_1KB"
+  env set hwconfig "fsl_ddr:ctlr_intlv=3way_1KB"
 
   # 4KB 3-way interleaving
-  setenv hwconfig "fsl_ddr:ctlr_intlv=3way_4KB"
+  env set hwconfig "fsl_ddr:ctlr_intlv=3way_4KB"
 
   # 8KB 3-way interleaving
-  setenv hwconfig "fsl_ddr:ctlr_intlv=3way_8KB"
+  env set hwconfig "fsl_ddr:ctlr_intlv=3way_8KB"
 
   # disable bank (chip-select) interleaving
-  setenv hwconfig "fsl_ddr:bank_intlv=null"
+  env set hwconfig "fsl_ddr:bank_intlv=null"
 
   # bank(chip-select) interleaving cs0+cs1
-  setenv hwconfig "fsl_ddr:bank_intlv=cs0_cs1"
+  env set hwconfig "fsl_ddr:bank_intlv=cs0_cs1"
 
   # bank(chip-select) interleaving cs2+cs3
-  setenv hwconfig "fsl_ddr:bank_intlv=cs2_cs3"
+  env set hwconfig "fsl_ddr:bank_intlv=cs2_cs3"
 
   # bank(chip-select) interleaving (cs0+cs1) and (cs2+cs3)  (2x2)
-  setenv hwconfig "fsl_ddr:bank_intlv=cs0_cs1_and_cs2_cs3"
+  env set hwconfig "fsl_ddr:bank_intlv=cs0_cs1_and_cs2_cs3"
 
   # bank(chip-select) interleaving (cs0+cs1+cs2+cs3) (4x1)
-  setenv hwconfig "fsl_ddr:bank_intlv=cs0_cs1_cs2_cs3"
+  env set hwconfig "fsl_ddr:bank_intlv=cs0_cs1_cs2_cs3"
 
   # bank(chip-select) interleaving (auto)
-  setenv hwconfig "fsl_ddr:bank_intlv=auto"
+  env set hwconfig "fsl_ddr:bank_intlv=auto"
   This auto mode only select from cs0_cs1_cs2_cs3, cs0_cs1, null dependings
   on DIMMs.
 
diff --git a/doc/README.iomux b/doc/README.iomux
index c428811ce4c..a26171b9749 100644
--- a/doc/README.iomux
+++ b/doc/README.iomux
@@ -16,12 +16,12 @@ configuration file.
 Two new files, common/iomux.c and include/iomux.h, contain the heart
 (iomux_doenv()) of the environment setting implementation.
 
-iomux_doenv() is called in common/cmd_nvedit.c to handle setenv and in
+iomux_doenv() is called in common/cmd_nvedit.c to handle env set and in
 common/console.c in console_init_r() during bootup to initialize
 stdio_devices[].
 
 A user can use a comma-separated list of devices to set stdin, stdout
-and stderr.  For example: "setenv stdin serial,nc".  NOTE: No spaces
+and stderr.  For example: "env set stdin serial,nc".  NOTE: No spaces
 are allowed around the comma(s)!
 
 The length of the list is limited by malloc(), since the array used
@@ -31,7 +31,7 @@ It should be possible to specify any device which console_assign()
 finds acceptable, but the code has only been tested with serial and
 nc.
 
-iomux_doenv() prevents multiple use of the same device, e.g. "setenv
+iomux_doenv() prevents multiple use of the same device, e.g. "env set
 stdin nc,nc,serial" will discard the second nc.  iomux_doenv() is
 not able to modify the environment, however, so that "pri stdin" still
 shows "nc,nc,serial".
diff --git a/doc/README.link-local b/doc/README.link-local
index ec2ef940e4c..53f4db1cb0c 100644
--- a/doc/README.link-local
+++ b/doc/README.link-local
@@ -69,7 +69,7 @@ If both fail or are disabled, static settings are used.
 		"if test \\\"$llfail\\\" -ne 0 -a "			\
 			"\\\"$dhcpfail\\\" -ne 0; "			\
 		"then "							\
-			"setenv ipaddr $sipaddr; "			\
-			"setenv netmask $snetmask; "			\
-			"setenv gatewayip $sgatewayip; "		\
+			"env set ipaddr $sipaddr; "			\
+			"env set netmask $snetmask; "			\
+			"env set gatewayip $sgatewayip; "		\
 		"fi;\0"							\
diff --git a/doc/README.marvell b/doc/README.marvell
index 6fc5ac8a409..ea6a8df7019 100644
--- a/doc/README.marvell
+++ b/doc/README.marvell
@@ -82,10 +82,10 @@ Permanent ethernet MAC address
 	and then set correct permanent ethernet MAC addresses.
 
 		# env default -a
-		# setenv ethaddr XX:XX:XX:XX:XX:XX
-		# setenv eth1addr XX:XX:XX:XX:XX:XX
-		# setenv eth2addr YY:YY:YY:YY:YY:YY
-		# setenv eth3addr ZZ:ZZ:ZZ:ZZ:ZZ:ZZ
+		# env set ethaddr XX:XX:XX:XX:XX:XX
+		# env set eth1addr XX:XX:XX:XX:XX:XX
+		# env set eth2addr YY:YY:YY:YY:YY:YY
+		# env set eth3addr ZZ:ZZ:ZZ:ZZ:ZZ:ZZ
 		# ...
 		# saveenv
 
diff --git a/doc/README.odroid b/doc/README.odroid
index 6eb7e67474d..f0592dd57fc 100644
--- a/doc/README.odroid
+++ b/doc/README.odroid
@@ -168,13 +168,13 @@ NOTE: This section is only for Odroid X2/U3.
 The ethernet can be accessed after starting the USB subsystem in U-Boot.
 The adapter does not come with a preconfigured MAC address, and hence it needs
 to be set before starting USB.
-setenv usbethaddr 02:DE:AD:BE:EF:FF
+env set usbethaddr 02:DE:AD:BE:EF:FF
 
 Note that in this example a locally managed MAC address is chosen. Care should
 be taken to make these MAC addresses unique within the same subnet.
 
 Start the USB subsystem:
-Odroid # setenv usbethaddr 02:DE:AD:BE:EF:FF
+Odroid # env set usbethaddr 02:DE:AD:BE:EF:FF
 Odroid # usb start
 (Re)start USB...
 USB0:   USB EHCI 1.00
@@ -187,10 +187,10 @@ Automatic IP assignment:
 ------------------------
 If the ethernet is connected to a DHCP server (router maybe with DHCP enabled),
 then the below will automatically assign an ip address through DHCP.
-setenv autoload no
+env set autoload no
 dhcp
 
-Odroid # setenv autoload no
+Odroid # env set autoload no
 Odroid # dhcp
 Waiting for Ethernet connection... done.
 BOOTP broadcast 1
@@ -219,7 +219,7 @@ Static IP assignment:
 ---------------------
 In the case where there are no DHCP servers in the network, or you want to
 set the IP address statically, it can be done by:
-Odroid # setenv ipaddr 192.168.1.10
+Odroid # env set ipaddr 192.168.1.10
 Odroid # ping 192.168.1.27
 Waiting for Ethernet connection... done.
 Using sms0 device
@@ -230,9 +230,9 @@ TFTP booting:
 Say there exists a tftp server in the network with address 192.168.1.27 and
 it serves a kernel image (zImage.3.17) and a DTB blob (exynos4412-odroidu3.dtb)
 that needs to be loaded and booted. It can be accomplished as below:
-(Assumes that you have setenv usbethaddr, and have not set autoload to no)
+(Assumes that you have env set usbethaddr, and have not set autoload to no)
 
-Odroid # setenv serverip 192.168.1.27
+Odroid # env set serverip 192.168.1.27
 Odroid # tftpboot 0x40080000 zImage.3.17
 Waiting for Ethernet connection... done.
 Using sms0 device
@@ -258,7 +258,7 @@ done
 Bytes transferred = 46935 (b757 hex)
 Odroid # printenv bootargs
 bootargs=Please use defined boot
-Odroid # setenv bootargs console=ttySAC1,115200n8 root=/dev/mmcblk0p2 rootwait
+Odroid # env set bootargs console=ttySAC1,115200n8 root=/dev/mmcblk0p2 rootwait
 Odroid # bootz 40080000 - 42000000
 Kernel image @ 0x40080000 [ 0x000000 - 0x30bd58 ]
 ## Flattened Device Tree blob at 42000000
@@ -318,7 +318,7 @@ Odroid # load usb 0:2 40080000 /boot/zImage.3.17
 3194200 bytes read in 471 ms (6.5 MiB/s)
 Odroid # load usb 0:2 42000000 /boot/exynos4412-odroidu3.dtb
 46935 bytes read in 233 ms (196.3 KiB/s)
-Odroid # setenv bootargs console=ttySAC1,115200n8 root=/dev/sda2 rootwait
+Odroid # env set bootargs console=ttySAC1,115200n8 root=/dev/sda2 rootwait
 Odroid # bootz 40080000 - 42000000
 Kernel image @ 0x40080000 [ 0x000000 - 0x30bd58 ]
 ## Flattened Device Tree blob at 42000000
diff --git a/doc/README.serial_multi b/doc/README.serial_multi
index 0446fe95937..b82678e1ea3 100644
--- a/doc/README.serial_multi
+++ b/doc/README.serial_multi
@@ -16,15 +16,15 @@ in the works).
 
 *) The console can be switched to SCC by any of the following commands:
 
-	setenv stdout serial_scc
-	setenv stdin serial_scc
-	setenv stderr serial_scc
+	env set stdout serial_scc
+	env set stdin serial_scc
+	env set stderr serial_scc
 
 *) The console can be switched to SMC by any of the following commands:
 
-	setenv stdout serial_smc
-	setenv stdin serial_smc
-	setenv stderr serial_smc
+	env set stdout serial_smc
+	env set stdin serial_smc
+	env set stderr serial_smc
 
 *) If a file descriptor is set to "serial" then the current serial device
 will be used which, in turn, can be switched by above commands.
@@ -32,7 +32,7 @@ will be used which, in turn, can be switched by above commands.
 *) The baudrate is the same for all serial devices. But it can be switched
 just after switching the console:
 
-	setenv sout serial_scc; setenv baudrate 38400
+	env set sout serial_scc; env set baudrate 38400
 
 After that press 'enter' at the SCC console. Note that baudrates <38400
 are not allowed on LWMON with watchdog enabled (see CFG_SYS_BAUDRATE_TABLE in
@@ -44,11 +44,11 @@ PPC4XX Specific
 *) The default console is UART0
 
 *) The console can be switched to UART1 by any of the following commands:
-	setenv stdout serial1
-	setenv stderr serial1
-	setenv stdin serial1
+	env set stdout serial1
+	env set stderr serial1
+	env set stdin serial1
 
 *) The console can be switched to UART0 by any of the following commands:
-	setenv stdout serial0
-	setenv stderr serial0
-	setenv stdin serial0
+	env set stdout serial0
+	env set stderr serial0
+	env set stdin serial0
diff --git a/doc/README.srio-pcie-boot-corenet b/doc/README.srio-pcie-boot-corenet
index 2b1f76b8d02..5625ad1a2bb 100644
--- a/doc/README.srio-pcie-boot-corenet
+++ b/doc/README.srio-pcie-boot-corenet
@@ -54,9 +54,9 @@ The example based on P4080DS platform:
 		   NorFlash.
 		c) Set environment variable "bootmaster" to "SRIO1" or "PCIE1" and save
 		   environment for master.
-					setenv bootmaster SRIO1
+					env set bootmaster SRIO1
 				or
-					setenv bootmaster PCIE1
+					env set bootmaster PCIE1
 					saveenv
 		d) Restart up master and it will boot up normally from its NorFlash.
 		   Then, it will finish necessary configurations for slave's boot from
diff --git a/doc/README.update b/doc/README.update
index f16b2d23af1..d060d3431e6 100644
--- a/doc/README.update
+++ b/doc/README.update
@@ -71,7 +71,7 @@ Example .its files
   '/tftpboot/update_uboot.itb', and set the 'updatefile' variable
   appropriately, for example in the U-Boot prompt:
 
-  setenv updatefile /tftpboot/update_uboot.itb
+  env set updatefile /tftpboot/update_uboot.itb
   saveenv
 
   Now, when the system boots up and the update TFTP server specified in the
diff --git a/doc/README.usb b/doc/README.usb
index 650a6daae0a..2ceb417db58 100644
--- a/doc/README.usb
+++ b/doc/README.usb
@@ -118,7 +118,7 @@ The normal U-Boot commands are used with USB networking, but you must
 start USB first. For example:
 
 usb start
-setenv bootfile /tftpboot/uImage
+env set bootfile /tftpboot/uImage
 bootp
 
 
diff --git a/doc/README.video b/doc/README.video
index ced35bd2db5..93a99f4e8a3 100644
--- a/doc/README.video
+++ b/doc/README.video
@@ -74,7 +74,7 @@ The sunxi U-Boot driver supports the following video-mode options:
 
 For example to always use the hdmi connector, even if no cable is inserted,
 using edid info when available and otherwise initalizing it at 1024x768@60Hz,
-use: "setenv video-mode sunxi:1024x768-24@60,monitor=dvi,hpd=0,edid=1".
+use: "env set video-mode sunxi:1024x768-24@60,monitor=dvi,hpd=0,edid=1".
 
 
 TrueType fonts
diff --git a/doc/SPL/README.am335x-network b/doc/SPL/README.am335x-network
index 9599729d8f9..3344898655e 100644
--- a/doc/SPL/README.am335x-network
+++ b/doc/SPL/README.am335x-network
@@ -19,7 +19,7 @@ comes with support for network booting preconfigured.
  2. Define CONFIG_BOOTCOMMAND for your board to load and run debrick
 script after boot:
 #define CONFIG_BOOTCOMMAND					\
-	"setenv autoload no; "					\
+	"env set autoload no; "					\
 	"bootp; "						\
 	"if tftp 80000000 debrick.scr; then "			\
 		"source 80000000; "				\
diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index 4aca7a5c660..3ad450c080a 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -128,7 +128,7 @@ After flashing U-Boot don't forget to update environment and write new
 partition table::
 
    => env default -f -a
-   => setenv partitions $partitions_android
+   => env set partitions $partitions_android
    => env save
    => gpt write mmc 1 $partitions_android
 
diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 0aad7a57b5e..9ea2e732898 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -277,28 +277,28 @@ operations being tested on the eth0 interface.
    DHCP
    ....
 
-   setenv autoload no
-   setenv ethrotate no
-   setenv ethact eth1
+   env set autoload no
+   env set ethrotate no
+   env set ethact eth1
    dhcp
 
    PING
    ....
 
-   setenv autoload no
-   setenv ethrotate no
-   setenv ethact eth1
+   env set autoload no
+   env set ethrotate no
+   env set ethact eth1
    dhcp
    ping $gatewayip
 
    TFTP
    ....
 
-   setenv autoload no
-   setenv ethrotate no
-   setenv ethact eth1
+   env set autoload no
+   env set ethrotate no
+   env set ethact eth1
    dhcp
-   setenv serverip WWW.XXX.YYY.ZZZ
+   env set serverip WWW.XXX.YYY.ZZZ
    tftpboot u-boot.bin
 
 The bridge also supports (to a lesser extent) the localhost interface, 'lo'.
@@ -322,8 +322,8 @@ operation being tested on the lo interface.
    TFTP
    ....
 
-   setenv ethrotate no
-   setenv ethact eth5
+   env set ethrotate no
+   env set ethact eth5
    tftpboot u-boot.bin
 
 
diff --git a/doc/arch/x86/manual_boot.rst b/doc/arch/x86/manual_boot.rst
index ec069f2c397..87ebda2e3dd 100644
--- a/doc/arch/x86/manual_boot.rst
+++ b/doc/arch/x86/manual_boot.rst
@@ -136,7 +136,7 @@ To boot Ubuntu from U-Boot the steps are as follows:
 
 1. Set up the boot arguments. Use the GUID for the partition you want to boot::
 
-   => setenv bootargs root=/dev/disk/by-partuuid/965c59ee-1822-4326-90d2-b02446050059 ro
+   => env set bootargs root=/dev/disk/by-partuuid/965c59ee-1822-4326-90d2-b02446050059 ro
 
 Here root= tells Linux the location of its root disk. The disk is specified
 by its GUID, using '/dev/disk/by-partuuid/', a Linux path to a 'directory'
@@ -229,7 +229,7 @@ You should also see your boot disk turn up::
 Linux has found the three partitions (sda1-3). Mercifully it doesn't print out
 the GUIDs. In step 1 above we could have used::
 
-   setenv bootargs root=/dev/sda2 ro
+   env set bootargs root=/dev/sda2 ro
 
 instead of the GUID. However if you add another drive to your board the
 numbering may change whereas the GUIDs will not. So if your boot partition
@@ -245,12 +245,12 @@ After a pause you should see a login screen on your display and you are done.
 
 If you want to put this in a script you can use something like this::
 
-   setenv bootargs root=UUID=b2aaf743-0418-4d90-94cc-3e6108d7d968 ro
-   setenv boot zboot 03000000 0 04000000 \${filesize}
-   setenv bootcmd "ext2load scsi 0:2 03000000 /boot/vmlinuz-3.13.0-58-generic; ext2load scsi 0:2 04000000 /boot/initrd.img-3.13.0-58-generic; run boot"
+   env set bootargs root=UUID=b2aaf743-0418-4d90-94cc-3e6108d7d968 ro
+   env set boot zboot 03000000 0 04000000 \${filesize}
+   env set bootcmd "ext2load scsi 0:2 03000000 /boot/vmlinuz-3.13.0-58-generic; ext2load scsi 0:2 04000000 /boot/initrd.img-3.13.0-58-generic; run boot"
    saveenv
 
-The \ is to tell the shell not to evaluate ${filesize} as part of the setenv
+The \ is to tell the shell not to evaluate ${filesize} as part of the env set
 command.
 
 You can also bake this behaviour into your build by hard-coding the
diff --git a/doc/board/andestech/ae350.rst b/doc/board/andestech/ae350.rst
index 99622fd3258..28f05c9d9cd 100644
--- a/doc/board/andestech/ae350.rst
+++ b/doc/board/andestech/ae350.rst
@@ -108,8 +108,8 @@ Messages of U-Boot boot on AE350 board
    riscv32-unknown-linux-gnu-gcc (GCC) 7.2.0
    GNU ld (GNU Binutils) 2.29
 
-   RISC-V # setenv ipaddr 10.0.4.200 ;
-   RISC-V # setenv serverip 10.0.4.97 ;
+   RISC-V # env set ipaddr 10.0.4.200 ;
+   RISC-V # env set serverip 10.0.4.97 ;
    RISC-V # ping 10.0.4.97 ;
    Using mac@e0100000 device
    host 10.0.4.97 is alive
@@ -224,8 +224,8 @@ Boot bbl and riscv-linux via U-Boot on QEMU
    17901268 bytes read in 4642 ms (3.7 MiB/s)
    RISC-V # fatload mmc 0:0 0x2000000 ae350.dtb
    1954 bytes read in 1 ms (1.9 MiB/s)
-   RISC-V # setenv bootm_size 0x2000000
-   RISC-V # setenv fdt_high 0x1f00000
+   RISC-V # env set bootm_size 0x2000000
+   RISC-V # env set fdt_high 0x1f00000
    RISC-V # bootm 0x00600000 - 0x2000000
    ## Booting kernel from Legacy Image at 00600000 ...
       Image Name:
diff --git a/doc/board/bsh/imx6ulz_bsh_smm_m2.rst b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
index 0af41c09d20..6210d6144a2 100644
--- a/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
+++ b/doc/board/bsh/imx6ulz_bsh_smm_m2.rst
@@ -76,9 +76,9 @@ where nand_script.lst contains the following:
    SDPV: jump
    # }
 
-   FB: ucmd setenv fastboot_buffer ${loadaddr}
+   FB: ucmd env set fastboot_buffer ${loadaddr}
    FB: download -f _image
-   FB: ucmd if test ! -n "$fastboot_bytes"; then setenv fastboot_bytes $filesize; else true; fi
+   FB: ucmd if test ! -n "$fastboot_bytes"; then env set fastboot_bytes $filesize; else true; fi
    # Burn image to nandfit partition if needed
    FB: ucmd if env exists nandfit_part; then nand erase.part nandfit; nand write ${fastboot_buffer} nandfit ${fastboot_bytes}; else true; fi;
    FB: ucmd nandbcb init ${fastboot_buffer} nandboot ${fastboot_bytes}
diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
index c604e42990e..cca6a239807 100644
--- a/doc/board/emulation/qemu-x86.rst
+++ b/doc/board/emulation/qemu-x86.rst
@@ -62,7 +62,7 @@ script.
 For example, Debian (stretch) can be booted by creating a script file named
 'boot.txt' with the contents::
 
-   setenv bootargs root=/dev/sda1 ro
+   env set bootargs root=/dev/sda1 ro
    load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} /vmlinuz
    load ${devtype} ${devnum}:${distro_bootpart} ${ramdisk_addr_r} /initrd.img
    zboot ${kernel_addr_r} - ${ramdisk_addr_r} ${filesize}
diff --git a/doc/board/intel/slimbootloader.rst b/doc/board/intel/slimbootloader.rst
index 87d71a55bdc..86eee1a7663 100644
--- a/doc/board/intel/slimbootloader.rst
+++ b/doc/board/intel/slimbootloader.rst
@@ -104,8 +104,8 @@ Download it from http://downloads.yoctoproject.org/releases/yocto/yocto-2.0/mach
 
 3. Update boot environment values on shell::
 
-   => setenv bootfile vmlinuz
-   => setenv bootdev scsi
+   => env set bootfile vmlinuz
+   => env set bootdev scsi
    => boot
 
 Build Instruction for Slim Bootloader for LeafHill (APL) target
diff --git a/doc/board/microchip/mpfs_common.rst b/doc/board/microchip/mpfs_common.rst
index edbaf043966..5d7263d4b8d 100644
--- a/doc/board/microchip/mpfs_common.rst
+++ b/doc/board/microchip/mpfs_common.rst
@@ -78,13 +78,13 @@ load uImage (with initramfs).
 
 .. code-block:: none
 
-   RISC-V # setenv kernel_addr_r 0x80200000
-   RISC-V # setenv fdt_addr_r 0x82200000
+   RISC-V # env set kernel_addr_r 0x80200000
+   RISC-V # env set fdt_addr_r 0x82200000
 
-   RISC-V # setenv ipaddr 192.168.1.5
-   RISC-V # setenv netmask 255.255.255.0
-   RISC-V # setenv serverip 192.168.1.3
-   RISC-V # setenv gateway 192.168.1.1
+   RISC-V # env set ipaddr 192.168.1.5
+   RISC-V # env set netmask 255.255.255.0
+   RISC-V # env set serverip 192.168.1.3
+   RISC-V # env set gateway 192.168.1.1
 
    RISC-V # tftpboot ${kernel_addr_r} uImage
    ethernet@20112000: PHY present at 9
diff --git a/doc/board/nxp/mx6sabreauto.rst b/doc/board/nxp/mx6sabreauto.rst
index fe4cd9d2141..f7477b4040e 100644
--- a/doc/board/nxp/mx6sabreauto.rst
+++ b/doc/board/nxp/mx6sabreauto.rst
@@ -87,7 +87,7 @@ To configure Falcon mode for the first time, on U-Boot do the following commands
 
 - Setup kernel bootargs::
 
-   # setenv bootargs "console=ttymxc3,115200 root=/dev/mmcblk0p1 rootfstype=ext4 rootwait quiet rw"
+   # env set bootargs "console=ttymxc3,115200 root=/dev/mmcblk0p1 rootfstype=ext4 rootwait quiet rw"
 
 - Prepare args::
 
diff --git a/doc/board/nxp/mx6sabresd.rst b/doc/board/nxp/mx6sabresd.rst
index c9869f4a73a..27ddf9073e5 100644
--- a/doc/board/nxp/mx6sabresd.rst
+++ b/doc/board/nxp/mx6sabresd.rst
@@ -103,7 +103,7 @@ To configure Falcon mode for the first time, on U-Boot do the following commands
 
 - Setup the IP server::
 
-   # setenv serverip <server_ip_address>
+   # env set serverip <server_ip_address>
 
 - Download dtb file::
 
@@ -119,7 +119,7 @@ To configure Falcon mode for the first time, on U-Boot do the following commands
 
 - Setup kernel bootargs::
 
-   # setenv bootargs "console=ttymxc0,115200 root=/dev/mmcblk1p1 rootfstype=ext4 rootwait quiet rw"
+   # env set bootargs "console=ttymxc0,115200 root=/dev/mmcblk1p1 rootfstype=ext4 rootwait quiet rw"
 
 - Prepare args::
 
diff --git a/doc/board/renesas/rcar-gen5-ironhide.rst b/doc/board/renesas/rcar-gen5-ironhide.rst
index 0e2ab7e577c..0e775a88f8d 100644
--- a/doc/board/renesas/rcar-gen5-ironhide.rst
+++ b/doc/board/renesas/rcar-gen5-ironhide.rst
@@ -164,9 +164,9 @@ via TFTP in the same manner as the other components are downloaded:
             base 0
 
     rsip_ipl_boot_ca0= /* Start TFA BL31, OPTEE-OS, U-Boot, Linux on Cortex-A720AE core 0 */   \
-            setenv ipaddr 192.168.1.10 &&                                                      \
-            setenv serverip 192.168.1.1 &&                                                     \
-            setenv netmask 255.255.255.0 &&                                                    \
+            env set ipaddr 192.168.1.10 &&                                                     \
+            env set serverip 192.168.1.1 &&                                                    \
+            env set netmask 255.255.255.0 &&                                                   \
                                                                                                \
             tftp ${rsip_ipl_scp_ep} scp.bin &&                                                 \
             tftp ${rsip_ipl_tfa_ep} bl31.bin &&                                                \
@@ -183,7 +183,6 @@ via TFTP in the same manner as the other components are downloaded:
             rproc load 13 ${rsip_ipl_tfa_ep} 4 &&          /* Set up Cortex-A720AE Core 0 */   \
             rproc start 13                                 /* Start Cortex-A720AE Core 0 */
 
-
 .. note::
 
     U-Boot on RSIP environment is not persistent across reboots,
diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index 3174a7daff9..d980f2faf02 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -205,8 +205,8 @@ Use ``$partitions_android`` as current partition definitions:
 
 .. prompt:: bash =>
 
-  setenv partitions_linux $partitions
-  setenv partitions $partitions_android
+  env set partitions_linux $partitions
+  env set partitions $partitions_android
   env save
 
 Format eMMC to have Android partition table:
@@ -586,17 +586,17 @@ First, prepare the ``boot.txt`` file with OS boot instructions, for example:
 
 .. code-block:: bash
 
-  setenv mmcroot     2
-  setenv console     ttySAC0,115200n8
-  setenv kernel_file Image
-  setenv fdtfile     exynos/exynos850-e850-96.dtb
-  setenv loadaddr    0x80000000
-  setenv fdt_addr_r  0x8c000000
+  env set mmcroot     2
+  env set console     ttySAC0,115200n8
+  env set kernel_file Image
+  env set fdtfile     exynos/exynos850-e850-96.dtb
+  env set loadaddr    0x80000000
+  env set fdt_addr_r  0x8c000000
 
   echo Booting Linux from eMMC...
   mmc dev $mmcdev
   mmc rescan
-  setenv bootargs console=$console root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+  env set bootargs console=$console root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
   load mmc $mmcdev:$mmcroot $fdt_addr_r /boot/$fdtfile
   load mmc $mmcdev:$mmcroot $loadaddr /boot/$kernel_file
   booti $loadaddr - $fdt_addr_r
@@ -735,7 +735,7 @@ defined in ``$partitions``, it's enough to only set ``$bootdev`` like this:
 
 .. prompt:: bash =>
 
-  setenv bootdev usb
+  env set bootdev usb
   env save
 
 Another thing to be aware of: in order to perform USB boot the USB PHY kernel
@@ -808,7 +808,7 @@ Follow the instructions below to boot from a USB storage device:
 
    .. prompt:: bash =>
 
-     setenv bootdev usb
+     env set bootdev usb
      env save
 
 6. Erase eMMC partition table to make U-Boot use ESP from USB drive:
diff --git a/doc/board/sifive/unleashed.rst b/doc/board/sifive/unleashed.rst
index ce38b701d78..94554f5c3ae 100644
--- a/doc/board/sifive/unleashed.rst
+++ b/doc/board/sifive/unleashed.rst
@@ -124,10 +124,10 @@ load uImage.
 
 .. code-block:: none
 
-   => setenv ipaddr 10.206.7.133
-   => setenv netmask 255.255.252.0
-   => setenv serverip 10.206.4.143
-   => setenv gateway 10.206.4.1
+   => env set ipaddr 10.206.7.133
+   => env set netmask 255.255.252.0
+   => env set serverip 10.206.4.143
+   => env set gateway 10.206.4.1
 
 If you want to use a flat kernel image such as Image file
 
@@ -256,7 +256,7 @@ as well.
             1000 Bytes/s
    done
    Bytes transferred = 5614 (15ee hex)
-   => setenv bootargs "root=/dev/ram rw console=ttySIF0 ip=dhcp earlycon=sbi"
+   => env set bootargs "root=/dev/ram rw console=ttySIF0 ip=dhcp earlycon=sbi"
    => booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
    ## Loading init Ramdisk from Legacy Image at 88300000 ...
       Image Name:   Linux RootFS
diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
index 8cf71299233..203843a274b 100644
--- a/doc/board/st/stm32mp1.rst
+++ b/doc/board/st/stm32mp1.rst
@@ -572,7 +572,7 @@ Then you update the eMMC with the next U-Boot command :
 a) prepare GPT on eMMC,
    example with 3 partitions, fip, bootfs and roots::
 
-    # setenv emmc_part "name=fip,size=4MiB;name=bootfs,type=linux,bootable,size=64MiB;name=rootfs,type=linux,size=512"
+    # env set emmc_part "name=fip,size=4MiB;name=bootfs,type=linux,bootable,size=64MiB;name=rootfs,type=linux,size=512"
     # gpt write mmc 1 ${emmc_part}
 
 b) copy FSBL, TF-A_ or SPL, on first eMMC boot partition
diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst b/doc/board/starfive/deepcomputing_fml13v01.rst
index 9777f4c6303..51feb06772f 100644
--- a/doc/board/starfive/deepcomputing_fml13v01.rst
+++ b/doc/board/starfive/deepcomputing_fml13v01.rst
@@ -23,7 +23,7 @@ environment
 
 .. code-block:: console
 
-    setenv fdtfile my_device-tree.dtb
+    env set fdtfile my_device-tree.dtb
     env save
 
 Power switch
diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
index 0dbc500b734..bb3fb4a9aee 100644
--- a/doc/board/starfive/milk-v_mars.rst
+++ b/doc/board/starfive/milk-v_mars.rst
@@ -19,7 +19,7 @@ environment
 
 ::
 
-    setenv fdtfile my_device-tree.dtb
+    env set fdtfile my_device-tree.dtb
     env save
 
 or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index c92ea16f91b..f3e6544980b 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -18,7 +18,7 @@ environment
 
 ::
 
-    setenv fdtfile my_device-tree.dtb
+    env set fdtfile my_device-tree.dtb
     env save
 
 or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to provide
diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
index 60b08ceebf0..73ceef2e531 100644
--- a/doc/board/ti/am65x_evm.rst
+++ b/doc/board/ti/am65x_evm.rst
@@ -201,8 +201,8 @@ To boot kernel from eMMC, use the following commands:
 
 .. prompt:: bash =>
 
-  setenv mmcdev 0
-  setenv bootpart 0
+  env set mmcdev 0
+  env set bootpart 0
   boot
 
 OSPI:
@@ -240,7 +240,7 @@ To boot kernel from OSPI, at the U-Boot prompt:
 
 .. prompt:: bash =>
 
-  setenv boot ubi
+  env set boot ubi
   boot
 
 UART:
diff --git a/doc/board/ti/dra7xx_evm.rst b/doc/board/ti/dra7xx_evm.rst
index 8e5d95535fa..9ef94e2ea00 100644
--- a/doc/board/ti/dra7xx_evm.rst
+++ b/doc/board/ti/dra7xx_evm.rst
@@ -73,7 +73,7 @@ set boot0 as the boot device.
 
 .. prompt:: bash =>
 
-   setenv autoload no
+   env set autoload no
    usb start
    dhcp
    mmc dev 1 1
diff --git a/doc/board/ti/ks2_evm.rst b/doc/board/ti/ks2_evm.rst
index 16c2e57d09d..c6e9d969f3c 100644
--- a/doc/board/ti/ks2_evm.rst
+++ b/doc/board/ti/ks2_evm.rst
@@ -198,8 +198,8 @@ instructions:
 
 .. prompt:: bash =>
 
-   setenv addr_uboot 0x87000000
-   setenv filesize <size in hex of u-boot-spi.gph rounded to hex 0x10000>
+   env set addr_uboot 0x87000000
+   env set filesize <size in hex of u-boot-spi.gph rounded to hex 0x10000>
    run burn_uboot_spi
 
 Once U-Boot prompt is available, power off the EVM. Set the SW1 dip switch to
@@ -226,7 +226,7 @@ instructions:
 
 .. prompt:: bash =>
 
-   setenv filesize <size in hex of MLO rounded to hex 0x10000>
+   env set filesize <size in hex of MLO rounded to hex 0x10000>
    run burn_uboot_nand
 
 Once U-Boot prompt is available, Power OFF the EVM. Set the SW1 dip switch to
diff --git a/doc/board/tq/tqma6ul.rst b/doc/board/tq/tqma6ul.rst
index 2b346715642..1928963bf14 100644
--- a/doc/board/tq/tqma6ul.rst
+++ b/doc/board/tq/tqma6ul.rst
@@ -49,7 +49,7 @@ U-Boot generic environment variable ``ethact``.
 
 .. code-block:: bash
 
-    setenv ethact <FEC>
+    env set ethact <FEC>
 
 ***********
 Boot source
diff --git a/doc/board/xilinx/zynqmp-r5.rst b/doc/board/xilinx/zynqmp-r5.rst
index 266d07d1193..d12c1e8774d 100644
--- a/doc/board/xilinx/zynqmp-r5.rst
+++ b/doc/board/xilinx/zynqmp-r5.rst
@@ -95,7 +95,7 @@ visible from the following log::
   ZYNQ GEM: ff0e0000, mdio bus ff0e0000, phyaddr 12, interface rgmii-id
   eth0: ethernet@ff0e0000
   Hit any key to stop autoboot:  0
-  ZynqMP> setenv autoload no
+  ZynqMP> env set autoload no
   ZynqMP> dhcp
   BOOTP broadcast 1
   DHCP client bound to address 192.168.0.167 (8 ms)
@@ -114,7 +114,7 @@ visible from the following log::
   	 376 KiB/s
   done
   Bytes transferred = 2075464 (1fab48 hex)
-  ZynqMP> setenv autostart no
+  ZynqMP> env set autostart no
   ZynqMP> bootelf -p 20000000
   ZynqMP> cpu 4 release 10000000 lockstep
   Using TCM jump trampoline for address 0x10000000
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 397f6db18b4..ec9fafa0fa0 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -152,7 +152,7 @@ boot_targets
 This environment variable can be used to control the list of bootdevs searched
 and their ordering, for example::
 
-   setenv boot_targets "mmc0 mmc1 usb pxe"
+   env set boot_targets "mmc0 mmc1 usb pxe"
 
 Entries may be removed or re-ordered in this list to affect the boot order. If
 the variable is empty, the default ordering is used, based on the priority of
@@ -169,7 +169,7 @@ used by the old distro scripts.
 This environment variable can be used to control the list of bootmeths used and
 their ordering for example::
 
-   setenv bootmeths "extlinux efi"
+   env set bootmeths "extlinux efi"
 
 Entries may be removed or re-ordered in this list to affect the order the
 bootmeths are tried on each bootdev. If the variable is empty, the default
diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 01efce40a29..5e906750119 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -384,22 +384,22 @@ boot_scripts:
 
 scan_dev_for_extlinux:
   If you want to disable extlinux.conf on all disks, set the value to something
-  innocuous, e.g. setenv scan_dev_for_extlinux true.
+  innocuous, e.g. env set scan_dev_for_extlinux true.
 
 scan_dev_for_scripts:
   If you want to disable boot.scr on all disks, set the value to something
-  innocuous, e.g. setenv scan_dev_for_scripts true.
+  innocuous, e.g. env set scan_dev_for_scripts true.
 
 boot_net_usb_start:
   If you want to prevent USB enumeration by distro boot commands which execute
-  network operations, set the value to something innocuous, e.g. setenv
+  network operations, set the value to something innocuous, e.g. env set
   boot_net_usb_start true. This would be useful if you know your Ethernet
   device is not attached to USB, and you wish to increase boot speed by
   avoiding unnecessary actions.
 
 boot_net_pci_enum:
   If you want to prevent PCI enumeration by distro boot commands which execute
-  network operations, set the value to something innocuous, e.g. setenv
+  network operations, set the value to something innocuous, e.g. env set
   boot_net_pci_enum true. This would be useful if you know your Ethernet
   device is not attached to PCI, and you wish to increase boot speed by
   avoiding unnecessary actions.
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 177e887ebd9..883bd2b1451 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -300,9 +300,9 @@ Content of **boot.scr**:
 .. code-block:: bash
 
   ext4load ${devtype} ${devnum}:${distro_bootpart} ${kernel_addr_r} ${prefix}Image
-  setenv kernel_size ${filesize}
+  env set kernel_size ${filesize}
   ext4load ${devtype} ${devnum}:${distro_bootpart} ${ramdisk_addr_r} ${prefix}Initrd
-  setenv initrd_size ${filesize}
+  env set initrd_size ${filesize}
   zboot  ${kernel_addr_r} ${kernel_size} ${ramdisk_addr_r} ${initrd_size}
 
 Extlinux configuration
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 3ca22b572a9..6fd1db6606d 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -170,11 +170,11 @@ Sign an image with one of the keys in "db" on your host
 Now in U-Boot install the keys on your board::
 
     fatload mmc 0:1 <tmpaddr> PK.auth
-    setenv -e -nv -bs -rt -at -i <tmpaddr>:$filesize PK
+    env set -e -nv -bs -rt -at -i <tmpaddr>:$filesize PK
     fatload mmc 0:1 <tmpaddr> KEK.auth
-    setenv -e -nv -bs -rt -at -i <tmpaddr>:$filesize KEK
+    env set -e -nv -bs -rt -at -i <tmpaddr>:$filesize KEK
     fatload mmc 0:1 <tmpaddr> db.auth
-    setenv -e -nv -bs -rt -at -i <tmpaddr>:$filesize db
+    env set -e -nv -bs -rt -at -i <tmpaddr>:$filesize db
 
 Set up boot parameters on your board::
 
@@ -412,7 +412,7 @@ bit in OsIndications variable with
 
 .. code-block:: console
 
-    => setenv -e -nv -bs -rt -v OsIndications =0x0000000000000004
+    => env set -e -nv -bs -rt -v OsIndications =0x0000000000000004
 
 Since U-Boot doesn't currently support SetVariable at runtime, its value
 won't be taken over across the reboot. If this is the case, you can skip
@@ -698,7 +698,7 @@ end up with "host not found".
 
 We need to preset the "httpserverip" environment variable to proceed the wget::
 
-    setenv httpserverip 192.168.1.1
+    env set httpserverip 192.168.1.1
 
 UEFI HTTP(s) Boot using lwIP
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -789,7 +789,7 @@ If the environment variable is set to 'list' a list of all tests is shown.
 
 Below you can find the output of an example session::
 
-    => setenv efi_selftest simple network protocol
+    => env set efi_selftest simple network protocol
     => bootefi selftest
     Testing EFI API implementation
     Selected test: 'simple network protocol'
diff --git a/doc/usage/cmd/bootd.rst b/doc/usage/cmd/bootd.rst
index 619cfb601a0..b76930ed929 100644
--- a/doc/usage/cmd/bootd.rst
+++ b/doc/usage/cmd/bootd.rst
@@ -24,13 +24,13 @@ Example
 
 ::
 
-    => setenv bootcmd 'echo Hello World'
+    => env set bootcmd 'echo Hello World'
     => bootd
     Hello World
-    => setenv bootcmd true
+    => env set bootcmd true
     => bootd; echo $?
     0
-    => setenv bootcmd false
+    => env set bootcmd false
     => bootd; echo $?
     1
 
diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
index 7c5448586b7..8b237fd75fb 100644
--- a/doc/usage/cmd/bootefi.rst
+++ b/doc/usage/cmd/bootefi.rst
@@ -48,7 +48,7 @@ or
 
 ::
 
-    setenv bootargs root=/dev/vda1
+    env set bootargs root=/dev/vda1
     load mmc 0:1 $fdt_addr_r dtb
     load mmc 0:1 $kernel_addr_r vmlinux
     load mmc 0:1 $initrd_addr_r intird
@@ -117,7 +117,7 @@ the *bootefi hello* sub-command. A session might look like
 
 ::
 
-    => setenv bootargs 'Greetings to the world'
+    => env set bootargs 'Greetings to the world'
     => bootefi hello
     Booting /MemoryMapped(0x0,0x10001000,0x1000)
     Hello, world!
@@ -140,7 +140,7 @@ To show a list of the available unit tests the value *list* can be used
 
 ::
 
-    => setenv efi_selftest list
+    => env set efi_selftest list
     => bootefi selftest
 
     Available tests:
@@ -154,7 +154,7 @@ environment variable to match one of the listed identifiers
 
 ::
 
-    => setenv efi_selftest 'block image transfer'
+    => env set efi_selftest 'block image transfer'
     => bootefi selftest
 
 Some of the tests execute the ExitBootServices() UEFI boot service and will not
diff --git a/doc/usage/cmd/booti.rst b/doc/usage/cmd/booti.rst
index 313efb83cc6..c8e847eae22 100644
--- a/doc/usage/cmd/booti.rst
+++ b/doc/usage/cmd/booti.rst
@@ -77,8 +77,8 @@ Here is the boot log for the compressed kernel:
 
 ::
 
-    => setenv kernel_comp_addr_r 0x50000000
-    => setenv kernel_comp_size 0x04000000
+    => env set kernel_comp_addr_r 0x50000000
+    => env set kernel_comp_size 0x04000000
     => load mmc 0:1 $fdt_addr_r dtb-5.10.0-3-arm64
     27530 bytes read in 6 ms (4.4 MiB/s)
     => load mmc 0:1 $kernel_addr_r vmlinuz-5.10.0-3-arm64.gz
diff --git a/doc/usage/cmd/bootmenu.rst b/doc/usage/cmd/bootmenu.rst
index cd5597bc646..e76e6a6cb6c 100644
--- a/doc/usage/cmd/bootmenu.rst
+++ b/doc/usage/cmd/bootmenu.rst
@@ -75,10 +75,10 @@ to the user.
 
 Example environment::
 
-    setenv bootmenu_0 Boot 1. kernel=bootm 0x82000000  # Set first menu entry
-    setenv bootmenu_1 Boot 2. kernel=bootm 0x83000000  # Set second menu entry
-    setenv bootmenu_2 Reset board=reset                # Set third menu entry
-    setenv bootmenu_3 U-Boot boot order=boot           # Set fourth menu entry
+    env set bootmenu_0 Boot 1. kernel=bootm 0x82000000  # Set first menu entry
+    env set bootmenu_1 Boot 2. kernel=bootm 0x83000000  # Set second menu entry
+    env set bootmenu_2 Reset board=reset                # Set third menu entry
+    env set bootmenu_3 U-Boot boot order=boot           # Set fourth menu entry
     bootmenu 20        # Run bootmenu with autoboot delay 20s
 
 
diff --git a/doc/usage/cmd/button.rst b/doc/usage/cmd/button.rst
index 6c6794f31b8..0b58b91e8da 100644
--- a/doc/usage/cmd/button.rst
+++ b/doc/usage/cmd/button.rst
@@ -32,7 +32,7 @@ variable *status1* you would execute the commands
 ::
 
     button button1
-    setenv status1 $?
+    env set status1 $?
 
 A list of all available buttons and their status can be displayed using
 
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index e54ea204b9f..40eb6a2cb54 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -75,8 +75,8 @@ cedit write_env
 Writes the settings to environment variables. For each menu item the selected
 ID and its text string are written, similar to:
 
-   setenv c.<name> <selected_id>
-   setenv c.<name>-str <selected_id's text string>
+   env set c.<name> <selected_id>
+   env set c.<name>-str <selected_id's text string>
 
 The `-v` flag enables verbose mode, where each variable is printed before it is
 set.
diff --git a/doc/usage/cmd/coninfo.rst b/doc/usage/cmd/coninfo.rst
index a66cf90a27b..bbfbebb9dc2 100644
--- a/doc/usage/cmd/coninfo.rst
+++ b/doc/usage/cmd/coninfo.rst
@@ -36,7 +36,7 @@ Example
     |   |-- stderr
     |-- serial (IO)
     |-- usbkbd (I)
-    => setenv stdin pl011@9000000,usbkbd
+    => env set stdin pl011@9000000,usbkbd
     => coninfo
     List of available devices
     |-- pl011@9000000 (IO)
diff --git a/doc/usage/cmd/echo.rst b/doc/usage/cmd/echo.rst
index ebc9ff5f843..b747e4b89ac 100644
--- a/doc/usage/cmd/echo.rst
+++ b/doc/usage/cmd/echo.rst
@@ -38,7 +38,7 @@ Observe how variables included in strings are handled:
 
 ::
 
-    => setenv var X; echo "a)" ${var} 'b)' '${var}' c) ${var}
+    => env set var X; echo "a)" ${var} 'b)' '${var}' c) ${var}
     a) X b) ${var} c) X
     =>
 
diff --git a/doc/usage/cmd/eficonfig.rst b/doc/usage/cmd/eficonfig.rst
index 83a3ebf4f0b..e9fc59a93f0 100644
--- a/doc/usage/cmd/eficonfig.rst
+++ b/doc/usage/cmd/eficonfig.rst
@@ -61,7 +61,7 @@ Auto boot with the UEFI Boot Option
 To do auto boot according to the UEFI BootOrder variable,
 add "bootefi bootmgr" entry as a default or first bootmenu entry::
 
-    CONFIG_PREBOOT="setenv bootmenu_0 UEFI Boot Manager=bootefi bootmgr; setenv bootmenu_1 UEFI Maintenance Menu=eficonfig"
+    CONFIG_PREBOOT="env set bootmenu_0 UEFI Boot Manager=bootefi bootmgr; env set bootmenu_1 UEFI Maintenance Menu=eficonfig"
 
 UEFI Secure Boot Configuration
 ''''''''''''''''''''''''''''''
@@ -84,7 +84,7 @@ If CONFIG_BOOTMENU_DISABLE_UBOOT_CONSOLE is enabled, the user can not enter
 U-Boot console. In this case, the bootmenu can be used to invoke "eficonfig"::
 
     CONFIG_USE_PREBOOT=y
-    CONFIG_PREBOOT="setenv bootmenu_0 UEFI Maintenance Menu=eficonfig"
+    CONFIG_PREBOOT="env set bootmenu_0 UEFI Maintenance Menu=eficonfig"
 
 The only way U-Boot can currently store EFI variables on a tamper
 resistant medium is via OP-TEE. The Kconfig option that enables that is::
diff --git a/doc/usage/cmd/exit.rst b/doc/usage/cmd/exit.rst
index 2f250bf4bde..b41ca35ff17 100644
--- a/doc/usage/cmd/exit.rst
+++ b/doc/usage/cmd/exit.rst
@@ -19,8 +19,8 @@ If scripts are nested, only the innermost script is left.
 
 ::
 
-    => setenv inner 'echo entry inner; exit; echo inner done'
-    => setenv outer 'echo entry outer; run inner; echo outer done'
+    => env set inner 'echo entry inner; exit; echo inner done'
+    => env set outer 'echo entry outer; run inner; echo outer done'
     => run outer
     entry outer
     entry inner
diff --git a/doc/usage/cmd/extension.rst b/doc/usage/cmd/extension.rst
index fbe95aace79..97c48bfd78e 100644
--- a/doc/usage/cmd/extension.rst
+++ b/doc/usage/cmd/extension.rst
@@ -62,8 +62,8 @@ Usage example
 
 ::
 
-    => setenv extension_overlay_addr 0x88080000
-    => setenv extension_overlay_cmd 'load mmc 0:1 ${extension_overlay_addr} /boot/${extension_overlay_name}'
+    => env set extension_overlay_addr 0x88080000
+    => env set extension_overlay_cmd 'load mmc 0:1 ${extension_overlay_addr} /boot/${extension_overlay_name}'
 
 3. Detect the plugged extension board
 
diff --git a/doc/usage/cmd/for.rst b/doc/usage/cmd/for.rst
index 729bd4db43c..3db3410a171 100644
--- a/doc/usage/cmd/for.rst
+++ b/doc/usage/cmd/for.rst
@@ -34,14 +34,14 @@ Example
 
 ::
 
-    => setenv c
+    => env set c
     => for c in 1 2 3; do echo item ${c}; done
     item 1
     item 2
     item 3
     => echo ${c}
     3
-    => setenv c x
+    => env set c x
     => for c in 1 2 3; do echo item ${c}; done
     item x
     item x
diff --git a/doc/usage/cmd/gpt.rst b/doc/usage/cmd/gpt.rst
index 13e8783be9b..70eb9745a52 100644
--- a/doc/usage/cmd/gpt.rst
+++ b/doc/usage/cmd/gpt.rst
@@ -119,10 +119,10 @@ Sets the bootable flag for all partitions in the table. If the partition name
 is in 'partition list' (separated by ','), the bootable flag is set, otherwise
 it is cleared. CONFIG_CMD_GPT_RENAME=y is required.
 
-gpt setenv
+gpt env set
 ~~~~~~~~~~
 
-The 'gpt setenv' command will set a series of environment variables with
+The 'gpt env set' command will set a series of environment variables with
 information about the partition named '<partition name>'. The variables are:
 
 gpt_partition_addr
@@ -179,7 +179,7 @@ Examples
 
 Create 6 partitions on a disk::
 
-    => setenv gpt_parts 'uuid_disk=bec9fc2a-86c1-483d-8a0e-0109732277d7;\
+    => env set gpt_parts 'uuid_disk=bec9fc2a-86c1-483d-8a0e-0109732277d7;\
     name=boot,start=4M,size=128M,bootable,type=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7;\
     name=rootfs,size=3072M,type=0fc63daf-8483-4772-8e79-3d69d8477de4;\
     name=system-data,size=512M,type=0fc63daf-8483-4772-8e79-3d69d8477de4;\
@@ -199,7 +199,7 @@ $gpt_parts::
 
 Get the information about the partition named 'rootfs'::
 
-    => gpt setenv mmc 0 rootfs
+    => gpt env set mmc 0 rootfs
     => echo ${gpt_partition_addr}
     2000
     => echo ${gpt_partition_size}
@@ -231,25 +231,25 @@ Set the bootable flag for the 'boot' partition and clear it for all others::
 
 Swap the order of the 'boot' and 'rootfs' partition table entries::
 
-    => gpt setenv mmc 0 rootfs
+    => gpt env set mmc 0 rootfs
     => echo ${gpt_partition_entry}
     2
-    => gpt setenv mmc 0 boot
+    => gpt env set mmc 0 boot
     => echo ${gpt_partition_entry}
     1
 
     => gpt transpose mmc 0 1 2
 
-    => gpt setenv mmc 0 rootfs
+    => gpt env set mmc 0 rootfs
     => echo ${gpt_partition_entry}
     1
-    => gpt setenv mmc 0 boot
+    => gpt env set mmc 0 boot
     => echo ${gpt_partition_entry}
     2
 
 Other example: a disk with known partition types::
 
-    => setenv gpt_parts 'name=u-boot,size=32M,type=data;\
+    => env set gpt_parts 'name=u-boot,size=32M,type=data;\
     name=env,size=1M,type=u-boot-env;
     name=ESP,size=128M,type=system;
     name=rootfs,size=3072M,type=linux;
diff --git a/doc/usage/cmd/imxtract.rst b/doc/usage/cmd/imxtract.rst
index 1621a4a68b2..c631e328569 100644
--- a/doc/usage/cmd/imxtract.rst
+++ b/doc/usage/cmd/imxtract.rst
@@ -52,7 +52,7 @@ extraction. But correct hashes are still indicated in the output
 
 .. code-block:: console
 
-    => setenv verify no
+    => env set verify no
     => imxtract $loadaddr kernel-1 $kernel_addr_r
     ## Copying 'kernel-1' subimage from FIT image at 40200000 ...
     sha256+ sha512+    Loading part 0 ... OK
@@ -62,7 +62,7 @@ With verify=yes incorrect hashes, signatures, or check sums stop the extraction.
 
 .. code-block:: console
 
-    => setenv verify yes
+    => env set verify yes
     => imxtract $loadaddr kernel-1 $kernel_addr_r
     ## Copying 'kernel-1' subimage from FIT image at 40200000 ...
     sha256 error!
diff --git a/doc/usage/cmd/mbr.rst b/doc/usage/cmd/mbr.rst
index 925a1181055..351959c5097 100644
--- a/doc/usage/cmd/mbr.rst
+++ b/doc/usage/cmd/mbr.rst
@@ -43,7 +43,7 @@ volume'), some of the predefined sizes:
 
 ::
 
-    => setenv mbr_parts 'name=boot,start=4M,size=128M,bootable,id=0x0e;
+    => env set mbr_parts 'name=boot,start=4M,size=128M,bootable,id=0x0e;
         name=rootfs,size=3072M,id=0x83;
         name=system-data,size=512M,id=0x83;
         name=[ext],size=-,id=0x05;
diff --git a/doc/usage/cmd/printenv.rst b/doc/usage/cmd/printenv.rst
index dfdb3624934..08c63d7e885 100644
--- a/doc/usage/cmd/printenv.rst
+++ b/doc/usage/cmd/printenv.rst
@@ -44,7 +44,7 @@ environment variables:
 
 ::
 
-    => setenv .foo bar
+    => env set .foo bar
     => printenv
     arch=sandbox
     baudrate=115200
diff --git a/doc/usage/cmd/saves.rst b/doc/usage/cmd/saves.rst
index d429eeceddf..c4470b61722 100644
--- a/doc/usage/cmd/saves.rst
+++ b/doc/usage/cmd/saves.rst
@@ -72,7 +72,7 @@ the offset used in the *saves* command.
     Really kill this window [y/n]
     $ srec_cat out.srec -offset -1337982976 -Output out.txt -binary 2>/dev/null
     $ cat out.txt
-    setenv autoload no
+    env set autoload no
     dhcp
     load mmc 0:1 $fdt_addr_r dtb
     load mmc 0:1 $kernel_addr_r snp.efi
diff --git a/doc/usage/cmd/sntp.rst b/doc/usage/cmd/sntp.rst
index 433884f18b2..bfbf75464c2 100644
--- a/doc/usage/cmd/sntp.rst
+++ b/doc/usage/cmd/sntp.rst
@@ -43,7 +43,7 @@ Examples
 
 ::
 
-    => setenv ntpserverip 109.190.177.205
+    => env set ntpserverip 109.190.177.205
     => date
     Date: 2025-06-16 (Monday)    Time: 15:19:35
     => date reset
@@ -55,7 +55,7 @@ Examples
     Date: 2025-06-16 Time: 15:19:43
     => date
     Date: 2025-06-16 (Monday)    Time: 15:19:47
-    => setenv timeoffset 7200
+    => env set timeoffset 7200
     => sntp
     Date: 2025-06-16 Time: 17:19:55
     => date
diff --git a/doc/usage/cmd/tftpput.rst b/doc/usage/cmd/tftpput.rst
index bdffa3af463..3704fdc9896 100644
--- a/doc/usage/cmd/tftpput.rst
+++ b/doc/usage/cmd/tftpput.rst
@@ -48,7 +48,7 @@ In the example the following steps are executed:
 
 ::
 
-    => setenv autoload no
+    => env set autoload no
     => dhcp
     BOOTP broadcast 1
     DHCP client bound to address 192.168.1.40 (7 ms)
diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index f661d739a19..e6c33b87431 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -95,7 +95,7 @@ In the example the following steps are executed:
 
 ::
 
-    => setenv autoload no
+    => env set autoload no
     => dhcp
     BOOTP broadcast 1
     *** Unhandled DHCP Option in OFFER/ACK: 23
diff --git a/doc/usage/cmdline.rst b/doc/usage/cmdline.rst
index 79b9baf7bfe..dac6dcccfb7 100644
--- a/doc/usage/cmdline.rst
+++ b/doc/usage/cmdline.rst
@@ -20,11 +20,11 @@ This takes very little code space and offers only basic features:
 - special characters ('$', ';') can be escaped by prefixing with '\',
   for example::
 
-    setenv bootcmd bootm \${address}
+    env set bootcmd bootm \${address}
 
 - You can also escape text by enclosing in single apostrophes, for example::
 
-    setenv addip 'setenv bootargs $bootargs ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname::off'
+    env set addip 'env set bootargs $bootargs ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname::off'
 
 Hush shell
 ----------
@@ -36,7 +36,7 @@ This is similar to Bourne shell, with control structures like:
 - `while` ... `do` ... `done`
 - `until` ... `do` ... `done`
 
-Hush supports environment ("global") variables (through setenv / saveenv
+Hush supports environment ("global") variables (through env set / saveenv
 commands) and local shell variables (through standard shell syntax
 `name=value`); only environment variables can be used with the "run" command
 
diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
index af805514b26..c825cdcbe5c 100644
--- a/doc/usage/dfu.rst
+++ b/doc/usage/dfu.rst
@@ -162,8 +162,8 @@ mmc
     layout and even set a new *dfu_alt_info* for the newly created partitions.
     Such a script would look like::
 
-        setenv dfu_alt_info ...
-        setenv mbr_parts ...
+        env set dfu_alt_info ...
+        env set mbr_parts ...
         mbr write ...
 
     Please note that this means the user will be able to execute any
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 0143f81f2c0..80498853336 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -70,10 +70,10 @@ Example::
         /* U-Boot script for booting */
 
         if [ -z ${tftpserverip} ]; then
-            echo "Use 'setenv tftpserverip a.b.c.d' to set IP address."
+            echo "Use 'env set tftpserverip a.b.c.d' to set IP address."
         fi
 
-        usb start; setenv autoload n; bootp;
+        usb start; env set autoload n; bootp;
         tftpboot ${tftpserverip}:
         bootm
     failed=
@@ -263,7 +263,7 @@ initrd_high
     sure that the initrd image is placed in the first
     12 MB as well - this can be done with::
 
-        setenv initrd_high 00c00000
+        env set initrd_high 00c00000
 
     If you set initrd_high to 0xffffffff (32-bit machines) or
     0xffffffffffffffff (64-bit machines), this is an
@@ -310,9 +310,9 @@ ethact
     controls which interface is currently active.
     For example you can do the following::
 
-    => setenv ethact FEC
+    => env set ethact FEC
     => ping 192.168.0.1 # traffic sent on FEC
-    => setenv ethact SCC
+    => env set ethact SCC
     => ping 10.0.0.1 # traffic sent on SCC
 
 ethrotate
diff --git a/doc/usage/fdt_overlays.rst b/doc/usage/fdt_overlays.rst
index 730cb85b39a..81e9512658a 100644
--- a/doc/usage/fdt_overlays.rst
+++ b/doc/usage/fdt_overlays.rst
@@ -88,8 +88,8 @@ Manually Loading and Applying Overlays
 
 ::
 
-    => setenv fdtaddr 0x87f00000
-    => setenv fdtovaddr 0x87fc0000
+    => env set fdtaddr 0x87f00000
+    => env set fdtovaddr 0x87fc0000
 
 2. Load the base binary device-tree and the binary device-tree overlay.
 
diff --git a/doc/usage/fit/beaglebone_vboot.rst b/doc/usage/fit/beaglebone_vboot.rst
index b15399441ee..c587b8c271d 100644
--- a/doc/usage/fit/beaglebone_vboot.rst
+++ b/doc/usage/fit/beaglebone_vboot.rst
@@ -518,13 +518,13 @@ Here the card is /dev/sde::
 
 Boot the board using the commands below::
 
-    setenv bootargs console=ttyO0,115200n8 quiet root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait
+    env set bootargs console=ttyO0,115200n8 quiet root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait
     ext2load mmc 0:2 82000000 /boot/image.fit
     bootm 82000000
 
 You should then see something like this::
 
-    U-Boot# setenv bootargs console=ttyO0,115200n8 quiet root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait
+    U-Boot# env set bootargs console=ttyO0,115200n8 quiet root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait
     U-Boot# ext2load mmc 0:2 82000000 /boot/image.fit
     7824930 bytes read in 589 ms (12.7 MiB/s)
     U-Boot# bootm 82000000
diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
index 9c8d86e50be..9c5f989bd75 100644
--- a/doc/usage/fit/howto.rst
+++ b/doc/usage/fit/howto.rst
@@ -197,9 +197,9 @@ specific to the new image format).
 [on the target system]::
 
     => print nfsargs
-    nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath}
+    nfsargs=env set bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath}
     => print addip
-    addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:${netdev}:off panic=1
+    addip=env set bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:${netdev}:off panic=1
     => run nfsargs addip
     => tftp 900000 /path/to/tftp/location/kernel.itb
     Using FEC device
diff --git a/doc/usage/os/plan9.rst b/doc/usage/os/plan9.rst
index f91712c0094..27020be65da 100644
--- a/doc/usage/os/plan9.rst
+++ b/doc/usage/os/plan9.rst
@@ -19,4 +19,4 @@ If no command line arguments or bootargs are defined, CONFADDR is left
 uninitialized to permit manual configuration.  For example, PC-style
 configuration could be simulated by issuing a fatload in bootcmd::
 
-  # setenv bootcmd fatload mmc 0 $confaddr plan9.ini; ...; bootm
+  # env set bootcmd fatload mmc 0 $confaddr plan9.ini; ...; bootm
-- 
2.53.0

