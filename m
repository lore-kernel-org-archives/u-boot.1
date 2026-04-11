Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770DEF364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E442842E6;
	Sat, 11 Apr 2026 09:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="qxiTZ2EH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ABD984118; Sat, 11 Apr 2026 02:04:26 +0200 (CEST)
Received: from mxd-1-a04.seznam.cz (mxd-1-a04.seznam.cz
 [IPv6:2a02:598:128:8a00::1000:a04])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2E18419E
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 02:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-4tx79
 (smtpc-mxd-7644845457-4tx79 [2a02:598:128:8a00::1000:a04])
 id 59a6e5e302a8b18a580f29bd; Sat, 11 Apr 2026 02:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775865837; bh=81PdEylbDZE8ULbzdC9pqkjfVn7b/pfb1vvoxlCQIeo=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=qxiTZ2EHYkpSXL0zKYEHjEpva1LTMMsHO0UuC1tZE145VZQOfVJj28VgP/NUP2/zu
 8WCKEzA+P0hDnIAN+1YiDJcGIGoNpucy1o8LixP0dF67Avk33hz1XmSCCLfHEo4Uts
 uj210fYViimo4pYymdw78sDBZO+1PAN4eW6wWZUVTroSnFJW0XrUqjgzI89YMkrkEU
 CmRcp1VJTbzYu/+hvNfDGJZO8JREXqomJ0ihiLRbkZQXw3M0bIFvU8+eADdJ0YcLOa
 V2y60m7k8Mqii0x9HDGXSB08zwSv9xH4Lc/MRCV1c1awooTK8xsg7fmZmt1yM1dT0/
 G5f7NjqA9+1vA==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-6597cc8696-xddnz (szn-email-smtpd/2.0.72) with ESMTPA
 id 531d4ff7-07e6-4f4a-81c1-9dcb0991e9f5;
 Sat, 11 Apr 2026 02:03:02 +0200
From: michael.srba@seznam.cz
Date: Sat, 11 Apr 2026 02:00:11 +0200
Subject: [PATCH v2 06/10] mach-snapdragon: Kconfig: changes / additions to
 support SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-qcom_spl-v2-6-9609557cf562@seznam.cz>
References: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
In-Reply-To: <20260411-qcom_spl-v2-0-9609557cf562@seznam.cz>
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
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

An SoC to target has to be selected, e.g. SPL_TARGET_SDM845.
This will select reasonable defaults and enable per-SoC linker
script (if required).

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
 arch/arm/Kconfig                 | 31 +++++++++++++++++++++++++++-
 arch/arm/mach-snapdragon/Kconfig | 44 ++++++++++++++++++++++++++++++++++------
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 03416c55265..8490e336516 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1138,9 +1138,38 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI
+	select SYSRESET_PSCI if !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
+	select SUPPORT_SPL
+	select ARMV8_SPL_EXCEPTION_VECTORS if SPL
+	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
+	select SPL_DM if SPL
+	select SPL_DM_GPIO if SPL
+	select SPL_DM_PMIC if SPL
+	select SPL_DM_USB_GADGET if SPL
+	select SPL_ENV_SUPPORT if SPL
+	select SPL_GPIO if SPL
+	select SPL_HAS_BSS_LINKER_SECTION if SPL
+	select SPL_LIBCOMMON_SUPPORT if SPL
+	select SPL_LIBDISK_SUPPORT if SPL
+	select SPL_LIBGENERIC_SUPPORT if SPL
+	select SPL_MMC if SPL
+	select SPL_OF_REAL if SPL
+	select SPL_OF_CONTROL if SPL
+	select SPL_PINCONF if SPL
+	select SPL_PINCTRL if SPL
+	select SPL_PINCTRL_FULL if SPL
+	select SPL_PINCTRL_GENERIC if SPL
+	select SPL_PINCONF_RECURSIVE if SPL
+	select SPL_PINMUX if SPL
+	select SPL_SPRINTF if SPL
+	select SPL_STRTO if SPL
+	select SPL_USB_GADGET if SPL
+	imply DM_EVENT if USB_DWC3_GENERIC || SPL_USB_DWC3_GENERIC
+	imply SPL_EVENT if SPL_USB_DWC3_GENERIC
+	imply OF_LIVE if USB_DWC3_GENERIC
+	imply SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
 	imply OF_UPSTREAM
 	imply CMD_DM
 	imply DM_USB_GADGET
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fce..74d687ceee2 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -11,18 +11,12 @@ config SYS_VENDOR
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
 	  will be used as the custom board directory.
 
-config SYS_MALLOC_LEN
-	default 0x10000000
-
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
 config SPL_SYS_MALLOC_F
 	default y
 
-config SPL_SYS_MALLOC_F_LEN
-	default 0x2000
-
 config SYS_MALLOC_LEN
 	default 0x800000
 
@@ -45,4 +39,42 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config SPL_SHARES_INIT_SP_ADDR
+	default n
+
+config SPL_HAVE_INIT_STACK
+	default y
+
+# SPL targets
+
+config SPL_TARGET_SDM845
+	bool "Set reasonable default values for running SPL in SRAM on sdm845 devices"
+
+# config options selected based on target
+
+config SPL_REMAKE_ELF_LDSCRIPT
+	default "arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds" if SPL_TARGET_SDM845
+
+# Modern Qualcomm platforms have two sets of SRAM memory easily available to us,
+# BOOT_IMEM and OCIMEM. See doc/board/qualcomm/spl.rst for more info.
+
+config SPL_BSS_START_ADDR
+	default 0x14680000 if SPL_TARGET_SDM845 # start of OCIMEM
+
+config SPL_BSS_MAX_SIZE
+	default 0x2000 if SPL_TARGET_SDM845 # leaves 0x1e000 for the stack in worst case
+
+# this starts at the end of .bss
+config SPL_SYS_MALLOC_F_LEN
+	default 0x20000 if SPL_TARGET_SDM845 # arbitrarily half of OCIMEM size
+
+config SPL_STACK
+	default 0x146bffff if SPL_TARGET_SDM845 # end of OCIMEM
+
+config SPL_TEXT_BASE
+	default 0x1483f000 if SPL_TARGET_SDM845 # start of largest continuous block of BOOT_IMEM in BROM whitelist
+
+config SPL_MAX_SIZE
+	default 0xc1000 if SPL_TARGET_SDM845 # size of largest continuous block of BOOT_IMEM in BROM whitelist
+
 endif

-- 
2.53.0

