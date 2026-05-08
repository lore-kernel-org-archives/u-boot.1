Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36612CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 04:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BCB84C50;
	Fri,  8 May 2026 06:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="kI+5UjJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F56F84BCF; Fri,  8 May 2026 02:35:04 +0200 (CEST)
Received: from mxd-2-a03.seznam.cz (mxd-2-a03.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a03])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B25184B92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 02:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-5f4d8d5f6f-w7th8
 (smtpc-mxd-5f4d8d5f6f-w7th8 [2a02:598:64:8a00::1000:a03])
 id 2fcd087374c35c1a2e64c42d; Fri, 08 May 2026 02:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1778200461; bh=89G6a08g/KQ095Ev9fhu9IDEotMZLwhHP0smb6J1lpA=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=kI+5UjJvKil9d4s8EgTIhFL5Dr72tBVb8yxCll7pi1vTQJBcjyB2nDq48aJaJSLCD
 JKn2WajhNaHawAKfFKJz4TSra6fUMvUuOZL3fwKoZKtyqz3bbS+beeuQzG93C3zC9a
 /2e5CBOoeBXh3VvgWpRfr29nEccvyt0HdCHUd1F5jCnRAHGHdKKId1Uyc6jAokM1M7
 aNiid0Mm4kOjSmrMZOfRhGywbuittyF3pHlV6TYMeH3BHM5naORtsSIc9f00RcnN+z
 5xU/+z1Qjf88kOhUNIs/nsFtGiVwwSrm7SxPe9j8kJScesTVi21Qb9EmTk07P2tPUQ
 o1tA9hnRIQyIg==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-xddnz (szn-email-smtpd/2.0.72) with ESMTPA
 id d7b35406-9d61-47da-9ef2-355786c99368;
 Fri, 08 May 2026 02:33:41 +0200
From: michael.srba@seznam.cz
Date: Fri, 08 May 2026 02:33:32 +0200
Subject: [PATCH v6 10/11] qualcomm: add defconfig, env and docs for SPL on
 sdm845
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-qcom_spl-v6-10-aaac1ab17b50@seznam.cz>
References: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
In-Reply-To: <20260508-qcom_spl-v6-0-aaac1ab17b50@seznam.cz>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Fri, 08 May 2026 06:08:16 +0200
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

From: Michael Srba <Michael.Srba@seznam.cz>

The defconfig should in principle be board-agnostic. Environment
simply contains a dfu env specifying where to load u-boot proper
(TEXT_BASE - 64).

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 MAINTAINERS                   |   1 +
 board/qualcomm/sdm845_spl.env |   2 +
 configs/sdm845_spl_defconfig  | 137 ++++++++++++++++++++++++++++++++++++++++++
 doc/board/qualcomm/index.rst  |   1 +
 doc/board/qualcomm/spl.rst    |  91 ++++++++++++++++++++++++++++
 5 files changed, 232 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dcc7243124..be830658cfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -681,6 +681,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
 F:	configs/qcm6490_defconfig
 F:	configs/qcs9100_defconfig
+F:	configs/sdm845_spl_defconfig
 F:	drivers/*/*/pm8???-*
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
diff --git a/board/qualcomm/sdm845_spl.env b/board/qualcomm/sdm845_spl.env
new file mode 100644
index 00000000000..2396d003b0c
--- /dev/null
+++ b/board/qualcomm/sdm845_spl.env
@@ -0,0 +1,2 @@
+# U-Boot proper text base - 64
+dfu_alt_info_ram=uboot.bin ram 0x1487FFC0 0x180000
diff --git a/configs/sdm845_spl_defconfig b/configs/sdm845_spl_defconfig
new file mode 100644
index 00000000000..2db63876266
--- /dev/null
+++ b/configs/sdm845_spl_defconfig
@@ -0,0 +1,137 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=19200000
+CONFIG_POSITION_INDEPENDENT=y
+# CONFIG_INIT_SP_RELATIVE is not set
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x14880000
+CONFIG_SYS_MALLOC_LEN=0x20000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x146bffff
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x146bffff
+CONFIG_SPL_TEXT_BASE=0x1483f000
+CONFIG_SPL_BSS_START_ADDR=0x14680000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
+CONFIG_BOOT0_SDM845_WORKAROUND=y
+CONFIG_SPL=y
+CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_SKIP_RELOCATE=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_CONSOLE_RECORD=y
+CONFIG_CONSOLE_RECORD_OUT_SIZE=0xA000
+CONFIG_CONSOLE_RECORD_OUT_SIZE_F=0xA000
+CONFIG_LOGLEVEL=9
+CONFIG_SYS_STDIO_DEREGISTER=y
+CONFIG_LOG_MAX_LEVEL=9
+CONFIG_SPL_LOG=y
+CONFIG_SPL_LOG_MAX_LEVEL=9
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x7ffc0
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_REMAKE_ELF_LDSCRIPT="arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds"
+CONFIG_SPL_DMA=y
+CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_BOOTM_NETBSD=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_UFS=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_LOG=y
+CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/sdm845_spl.env"
+CONFIG_NET_RANDOM_ETHADDR=y
+# CONFIG_OFNODE_MULTI_TREE is not set
+CONFIG_BUTTON_QCOM_PMIC=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_STUB=y
+CONFIG_SPL_CLK_STUB=y
+CONFIG_CLK_QCOM_SDM845=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SCSI=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_DMA=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdeadbeef
+CONFIG_MSM_GPIO=y
+CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_QUP=y
+CONFIG_I2C_MUX=y
+CONFIG_IOMMU=y
+CONFIG_QCOM_HYP_SMMU=y
+CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY=y
+CONFIG_SPL_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
+CONFIG_PHY_QCOM_SNPS_EUSB2=y
+CONFIG_PHY_QCOM_USB_HS_28NM=y
+CONFIG_PHY_QCOM_USB_SS=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_APQ8016=y
+CONFIG_PINCTRL_QCOM_APQ8096=y
+CONFIG_PINCTRL_QCOM_QCM2290=y
+CONFIG_PINCTRL_QCOM_QCS404=y
+CONFIG_PINCTRL_QCOM_SDM845=y
+CONFIG_PINCTRL_QCOM_SM6115=y
+CONFIG_PINCTRL_QCOM_SM8250=y
+CONFIG_PINCTRL_QCOM_SM8550=y
+CONFIG_PINCTRL_QCOM_SM8650=y
+CONFIG_PINCTRL_QCOM_X1E80100=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_QCOM=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_QCOM_RPMH=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_MSM=y
+CONFIG_SCSI=y
+CONFIG_MSM_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_RPMH=y
+CONFIG_SPMI_MSM=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_SYSRESET_QCOM_PSHOLD=y
+CONFIG_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xb4a4
+CONFIG_USB_ETHER=y
+CONFIG_USB_ETH_CDC=y
+CONFIG_SPL_DFU=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_UFS=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_CIRCBUF=y
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 3238a68e859..65e3e222f68 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -14,3 +14,4 @@ Qualcomm
    iq8
    phones
    rdp
+   spl
diff --git a/doc/board/qualcomm/spl.rst b/doc/board/qualcomm/spl.rst
new file mode 100644
index 00000000000..0cf18c70e4a
--- /dev/null
+++ b/doc/board/qualcomm/spl.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Michael Srba <Michael.Srba@seznam.cz>
+
+===================================
+Booting U-Boot SPL on Qualcomm SoCs
+===================================
+
+Overview
+--------
+The boot process on sdm845 (and some other Qualcomm SoCs) starts with the bootrom
+of the Application Processor, which executes XBL_SEC, which jumps to "OEM" code
+in EL1. Production devices are typically "fused", with a hash of the OEM's signing
+key burnt into one of the "QFUSE" banks on the SoC making it impossible to run
+custom bootloader code. As a result U-Boot SPL is only supported on unfused
+("secureboot off") devices. XBL_SEC is always signed by Qualcomm, and the fuses
+to disable turning off signature verification for it are always burnt at the
+factory, so replacing XBL_SEC is impossible without using JTAG. Of course JTAG
+is typically disabled on devices that have secure boot enabled, or at minimum
+greatly neutered.
+
+U-Boot SPL for Qualcomm platforms uses a custom linker script (per SoC) to build a bootable ELF.
+For sdm845 (and some other platforms) this has two sections, u-boot code and an embedded
+xbl_sec elf (signed by Qualcomm). To boot on an unfused SoC, the elf additionally
+needs to have hash sections added, which can be accomplished with qtestsign.
+
+Currently, sdm845 is supported. You need a device with secure boot disabled
+(or with secure boot enabled if you enabled it yourself and have the private key,
+though for full security you'd also want to disable JTAG which will remove your ability
+to mess with the control flow in the bootrom (immutable) and in XBL_SEC (signed)).
+
+Building
+--------
+First, obtain an xbl_sec that includes the EL3 privilege escalation feature
+and place it at .output/xbl_sec.elf. You can extract it from an xbl elf.
+If you're unable to find one, you can also use JTAG/SWD to break at the SMC
+entry and use gdb to jump to the u-boot entry point in EL3.
+
+To build a bootable image, you need to use a defconfig specific to your SoC.
+This is because the ELF has to specify where in the address space to put u-boot SPL,
+and this may differ per SoC. There may be other SoC-dependent build time choices,
+though in principle those could be made at runtime.
+
+First run ``make sdm845_spl_defconfig``::
+
+	make CROSS_COMPILE=aarch64-suse-linux- O=.output DEVICE_TREE=qcom/sdm845-shift-axolotl sdm845_spl_defconfig
+
+Then compile u-boot and specify the dts for your board (technically nothing about the resulting
+SPL image should be board-specific, but there are no non-board-specific device trees in Linux)::
+
+	make CROSS_COMPILE=aarch64-suse-linux- O=.output DEVICE_TREE=qcom/sdm845-shift-axolotl
+
+Finally, use ``qtestsign`` to add the hash segments required by PBL::
+
+	qtestsign -v 5 -o .output/spl/u-boot-spl_signed.elf prog .output/spl/u-boot-spl.elf
+
+Running
+-------
+Currently, U-Boot SPL for Qualcomm platforms expects to be booted via EDL::
+
+	edl.py --loader=$PWD/.output/spl/u-boot-spl_signed.elf
+
+SPL will then launch the DFU gadget and wait for you to upload u-boot proper::
+
+	dfu-util -RD .output/u-boot.img
+
+u-boot proper will then likely crash, since SPL currently doesn't init DRAM on Qualcomm platforms
+and u-boot proper currently doesn't support running from SRAM. The latter should be an easy fix.
+
+Notes on memory map
+-------------------
+| There are various banks of SRAM on a Qualcomm SoC that we can use prior to DRAM init.
+| For example:
+| msm8916 - 512K L2-as-TCM (at ``0x08000000``), 16K OCIMEM (at ``0x08600000``)
+| msm8998 - 1M L2-as-TCM (at ``0x14000000``), 256K OCIMEM (at ``0x14680000``)
+| sdm845 - 1.5M BOOT_IMEM (at ``0x14800000``), 256K OCIMEM (at ``0x14680000``)
+
+There's also RPM code/data RAM and hexagon TCMs, but unless we want to boot dram-less Linux
+we can probably safely ignore those. On msm8916 they may come in handy though.
+
+sdm845 can also have 8M LLCC-as-TCM in theory, but this appears to be broken.
+L2-as-TCM is no longer present.
+
+Since a limited amount of not necessarily continuous SRAM is available, we need to manually
+specify where .text, .bss, the malloc pool and the stack go. The Kconfig contains reasonable
+defaults per SoC.
+
+On sdm845, we by default put U-Boot SPL in BOOT_IMEM, with .bss, malloc pool and the stack
+filling OCIMEM. We can also fit U-Boot proper in BOOT_IMEM, for dram-less DFU or peek/poke
+with a shell. To that end, we set ``CONFIG_TEXT_BASE`` at 512K into BOOT_IMEM, and set
+``CONFIG_SPL_MAX_SIZE`` to 512K - 64. We also configure dfu to load U-Boot proper
+to ``CONFIG_TEXT_BASE`` - 64. (64 bytes is the size of u-boot legacy header)

-- 
2.53.0

