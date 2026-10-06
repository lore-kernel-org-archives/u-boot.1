Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78764CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 09:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34D4440536;
	Tue,  6 Oct 2026 09:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d4hTzrpT6EuO; Tue,  6 Oct 2026 09:18:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9A6214054B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791278329;
	b=ElikuFvRAEjctN7joEoYzwpVgr2J0kEsE+W4QMc01WhKtoBZiXb1KndTz/o8WDKFy5CV
	 KVD4bTzt5KqOKozEE+wzm3zfgShkSf5ChQxEuJ/U8J7F4wE/A4WgKnzsF/sBfJCwrRWgM
	 yCVHV1iMEFViyljk9nHK2lVO23Or9BjKa9MEEapx6r8encgDafb7594MPrVsyjfZ5IeAz
	 MwUZPLjCf8yxSfBeNpt5vcLu8+88GtnBV7lBNL0yB3AmZt8rLheCW5iXmhVOPoYRVWVfD
	 hDFpLiKh8aPJK1MNPn4jcImOcXM8HYPhs0G/36AQ1CSgRAyAKbtJfu27OdUcMy2PD8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791278329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ok0vLmye95IGdrcNEiDs8EtvT6iIE3rrn299Rn1LhS4=;
	b=ZEvWzeNyAR41JAYi7hnQTbXMTvvBUZ7x9LbbqR1ARGSgqucrm5xc8W6ba1+kbV/7Sily
	 SnDpihHhaRilDABg2LJ4KamYRbLGll+fxodrrbE+ihs0SM/51A0VrpUw1QWQrKmKhLGET
	 NMdAMamSniDH21JY37A9IYz6PsT/2Ba7FSDZoJdMljkqRyjOV6sXH7qa3nc22IpadnIEH
	 s4kljymowKXuMHheDuubW7TT4NmfyiOXbmhKsmvCOJD1CJRtrHTO+RxbLvP0jN4tfwOxG
	 ZSwwM6Y4AjLiD2KGZkTvl+84h78k0+8VT52fO5o6YdCbdjndlkW3hzKmhoEH8OzPbzA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=fail header.from=nxp.com;
	spf=fail smtp.mailfrom=nxp.com;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791278329;
	bh=Ok0vLmye95IGdrcNEiDs8EtvT6iIE3rrn299Rn1LhS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cnPdqDxuJ0Xz6MMiIzjeDK0GN/0af3xGwlzTjlTIheub/1ilVW58xVF7JtukRCiEx
	 4ivCa1jRgvJDiVYC3saIzRaHi1Y6S0WmHOeNbtgrX9jlxoR11Ap2Ylj5938bIOvMUm
	 FklOu6DMXHLQv4vPD+E9Q2Z3nBsB1VZgNC/7QVH9UGotYDQ4Q8/EygRSr1nwUsWCGy
	 1+yP67bad4b+FRrzZzAC4HIGC9ncyKOPDttjyWGPnDMNbfn9rW6v+qbIePwZJQbpGg
	 TKJrgATijcCQWTsiJjmp7surmzVVQprDy1YgTIXOOJFM18lrCCWnyN8Ng5iv19NqiM
	 4j3A6zgpwP1qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A6214054B;
	Tue,  6 Oct 2026 09:18:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B5AC2E0
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D7EB40508
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Oplz95588s9 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 09:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F401940506
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791278262;
 b=UC1Bdrl9wjDJGJJaszVZ/Dos8ttKfIkXSKrp4czG7onkutFauoRB1/DIRthleBJ3e+93
 8B/brJ2vP8H9ci++iH2Sg+dpf8A4Zez24FNJo1r2QCxXykW4mCTHfdLCu3hZpI5XBc3l8
 qbe+oGKtplhc36J+o4ftEFBjo0++hvhrJr6CufstfUTFZgBj+s58cdxamitXFIv1WuIEE
 ri8Z/fGWlkKSUwq8YZjkws72v6NIF+Alcd+0s7Jxj5lyPvptE8F9ut/kmhjrCIQz0lwv+
 bk3HOFXp/uxSRXSpTk7QJjasg0qUma82/zddoDDqudY6/IDkd4W5LXEZWdzwfgrj+3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791278262;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=Ok0vLmye95IGdrcNEiDs8EtvT6iIE3rrn299Rn1LhS4=;
 b=BUal7reaRB6cR297TwXllViwLeQfkVXYEOmGe2jDvGfeDm31/Rac45NP9VHeJrGQ95hT
 gJ4zJFOat78DY8H/3hhI1lXLiZdgUIsCm8HiQOv6pUqW+jEtstatbEUF7H29R89zTH6zV
 jtvH7XFb7FehR9L9rXsF8QgPhZXropym3jfv8LX1QVLU2ZHSCIwRHNbPZGEQAO2uORCLj
 n3DZytpy6ZkUwq4Rh4eHRLX8g+4LJ9EOwnWvyXN2BIv5rySF60v4suiew0wgzShIi2XYa
 iG9gMhG2cBMrLxR2I34uhVo5v7n7yI8pOSFGE3cGncg/xCuVpODG82Z5A4SXvExsMWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=fail header.from=nxp.com; 
 spf=fail smtp.mailfrom=nxp.com;
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=elena.popa@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=nxp.com
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F401940506
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 09:17:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF210801E5; Tue,  6 Oct 2026 11:17:39 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 745C18404D
 for <u-boot@lists.denx.de>; Tue,  6 Oct 2026 11:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=elena.popa@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B91981A0197;
 Tue,  6 Oct 2026 11:17:35 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B491E1A022F;
 Tue,  6 Oct 2026 11:17:35 +0200 (CEST)
Received: from lsv052348.swis.nl-cdc01.nxp.com
 (lsv052348.swis.nl-cdc01.nxp.com [10.168.26.87])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B2262202A3;
 Tue,  6 Oct 2026 11:17:34 +0200 (CEST)
From: Elena Popa <elena.popa@nxp.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 peng.fan@nxp.com, ilias.apalodimas@linaro.org
Cc: laurentiu.mihalcea@nxp.com, cosmin.stoica@nxp.com,
 Elena Popa <elena.popa@nxp.com>
Subject: [PATCH v2 1/2] board: nxp: add MR-NAVQ95 board support
Date: Tue,  6 Oct 2026 11:17:01 +0200
Message-ID: <20261006091716.487384-2-elena.popa@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006091716.487384-1-elena.popa@nxp.com>
References: <20261006091716.487384-1-elena.popa@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add initial support for the MR-NAVQ95 board. The following peripherals
are supported: Messaging unit for EdgeLock Secure Enclave, messaging
unit for System Manager, uSDHC for SD Card, GPIO, LPUART.

Signed-off-by: Elena Popa <elena.popa@nxp.com>
---
 arch/arm/dts/imx95-navq-u-boot.dtsi |   6 ++
 arch/arm/mach-imx/imx9/Kconfig      |   8 ++
 board/nxp/imx95_navq/Kconfig        |  12 +++
 board/nxp/imx95_navq/MAINTAINERS    |   6 ++
 board/nxp/imx95_navq/Makefile       |  11 ++
 board/nxp/imx95_navq/imx95_navq.c   |  24 +++++
 board/nxp/imx95_navq/imx95_navq.env |  94 +++++++++++++++++
 board/nxp/imx95_navq/spl.c          |  82 +++++++++++++++
 configs/imx95_navq.config           | 154 ++++++++++++++++++++++++++++
 configs/imx95_navq_defconfig        |   1 +
 doc/board/nxp/imx95_navq.rst        | 117 +++++++++++++++++++++
 doc/board/nxp/index.rst             |   1 +
 include/configs/imx95_navq.h        |  22 ++++
 13 files changed, 538 insertions(+)
 create mode 100644 arch/arm/dts/imx95-navq-u-boot.dtsi
 create mode 100644 board/nxp/imx95_navq/Kconfig
 create mode 100644 board/nxp/imx95_navq/MAINTAINERS
 create mode 100644 board/nxp/imx95_navq/Makefile
 create mode 100644 board/nxp/imx95_navq/imx95_navq.c
 create mode 100644 board/nxp/imx95_navq/imx95_navq.env
 create mode 100644 board/nxp/imx95_navq/spl.c
 create mode 100644 configs/imx95_navq.config
 create mode 100644 configs/imx95_navq_defconfig
 create mode 100644 doc/board/nxp/imx95_navq.rst
 create mode 100644 include/configs/imx95_navq.h

diff --git a/arch/arm/dts/imx95-navq-u-boot.dtsi b/arch/arm/dts/imx95-navq-u-boot.dtsi
new file mode 100644
index 00000000000..1c999070731
--- /dev/null
+++ b/arch/arm/dts/imx95-navq-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f95cecb6976..5089f44c247 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -161,6 +161,13 @@ config TARGET_PHYCORE_IMX93
 	select OF_BOARD_FIXUP
 	select OF_BOARD_SETUP
 
+config TARGET_IMX95_NAVQ
+	bool "imx95_navq"
+	select OF_BOARD_FIXUP
+	select IMX95
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+
 config TARGET_IMX95_19X19_EVK
 	bool "imx95_19x19_evk"
 	select OF_BOARD_FIXUP
@@ -232,6 +239,7 @@ source "board/phytec/phycore_imx91_93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
 source "board/nxp/imx94_evk/Kconfig"
 source "board/nxp/imx95_evk/Kconfig"
+source "board/nxp/imx95_navq/Kconfig"
 source "board/nxp/imx95_frdm/Kconfig"
 source "board/toradex/aquila-imx95/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
diff --git a/board/nxp/imx95_navq/Kconfig b/board/nxp/imx95_navq/Kconfig
new file mode 100644
index 00000000000..07f70282f2c
--- /dev/null
+++ b/board/nxp/imx95_navq/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX95_NAVQ
+
+config SYS_BOARD
+	default "imx95_navq"
+
+config SYS_VENDOR
+	default "nxp"
+
+config SYS_CONFIG_NAME
+	default "imx95_navq"
+
+endif
diff --git a/board/nxp/imx95_navq/MAINTAINERS b/board/nxp/imx95_navq/MAINTAINERS
new file mode 100644
index 00000000000..3bc4b7c1348
--- /dev/null
+++ b/board/nxp/imx95_navq/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX95 NAVQ BOARD
+M:	Elena Popa <elena.popa@nxp.com>
+S:	Maintained
+F:	board/nxp/imx95_navq/
+F:	include/configs/imx95_navq.h
+F:	configs/imx95_navq_defconfig
diff --git a/board/nxp/imx95_navq/Makefile b/board/nxp/imx95_navq/Makefile
new file mode 100644
index 00000000000..f0a65a6f032
--- /dev/null
+++ b/board/nxp/imx95_navq/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2026 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx95_navq.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/nxp/imx95_navq/imx95_navq.c b/board/nxp/imx95_navq/imx95_navq.c
new file mode 100644
index 00000000000..524d825e9fa
--- /dev/null
+++ b/board/nxp/imx95_navq/imx95_navq.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include <asm/gpio.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
+int board_fix_fdt(void *fdt)
+{
+	/* Remove nodes based on fuses. */
+	return imx9_uboot_fixup_by_fuse(fdt);
+}
+#endif
diff --git a/board/nxp/imx95_navq/imx95_navq.env b/board/nxp/imx95_navq/imx95_navq.env
new file mode 100644
index 00000000000..1d63a74aefa
--- /dev/null
+++ b/board/nxp/imx95_navq/imx95_navq.env
@@ -0,0 +1,94 @@
+sec_boot=no
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+image=Image
+ip_dyn=yes
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0xC0000000
+kernel_comp_size=0x2000000
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+mmcautodetect=yes
+mmcargs=setenv bootargs console=${console} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
diff --git a/board/nxp/imx95_navq/spl.c b/board/nxp/imx95_navq/spl.c
new file mode 100644
index 00000000000..c8a5b4f9d41
--- /dev/null
+++ b/board/nxp/imx95_navq/spl.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+#include <asm/global_data.h>
+#include <asm/sections.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	puts("Normal Boot\n");
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_imx_qb_save();
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx95_navq.config b/configs/imx95_navq.config
new file mode 100644
index 00000000000..f002fefddd4
--- /dev/null
+++ b/configs/imx95_navq.config
@@ -0,0 +1,154 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_navq"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx95-navq"
+CONFIG_TARGET_IMX95_NAVQ=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-navq.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC_IMX=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
+CONFIG_WDT=y
diff --git a/configs/imx95_navq_defconfig b/configs/imx95_navq_defconfig
new file mode 100644
index 00000000000..803b656da95
--- /dev/null
+++ b/configs/imx95_navq_defconfig
@@ -0,0 +1 @@
+#include <configs/imx95_navq.config>
diff --git a/doc/board/nxp/imx95_navq.rst b/doc/board/nxp/imx95_navq.rst
new file mode 100644
index 00000000000..0f539bbb044
--- /dev/null
+++ b/doc/board/nxp/imx95_navq.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx95_navq
+=======================
+
+U-Boot for the NXP MR-NAVQ95 board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.6-c0b284c.bin
+   $ sh firmware-ele-imx-2.0.6-c0b284c.bin --auto-accept
+   $ cp firmware-ele-imx-2.0.6-c0b284c/mx95b0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.32-1991416.bin
+   $ sh firmware-imx-8.32-1991416.bin --auto-accept
+   $ cp firmware-imx-8.32-1991416/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ mkdir ~/toolchain
+   $ wget -P ~/toolchain https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/15.3.rel1/arm-gnu-toolchain-15.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-15.3.rel1-x86_64-arm-none-eabi.tar.xz -C ~/toolchain
+   $ export TOOLS=~/toolchain
+   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
+   $ cd imx-oei
+   $ make TC_VERSION=15.3.rel1 board=mx95lp5 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/NXP-Robotics/robotics-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ mkdir ~/toolchain
+   $ wget -P ~/toolchain https://gitlab.arm.com/api/v4/projects/tooling%2Fgnu-toolchains-for-arm/packages/generic/gnu-toolchain/15.3.rel1/arm-gnu-toolchain-15.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf ~/toolchain/arm-gnu-toolchain-15.3.rel1-x86_64-arm-none-eabi.tar.xz -C ~/toolchain
+   $ export TOOLS=~/toolchain
+   $ git clone -b robotics-0.7.0 https://github.com/NXP-Robotics/robotics-sm.git
+   $ cd robotics-sm
+   $ make config=mx95navq cfg
+   $ make -j$(nproc) TC_VERSION=1.5.3.rel1 config=mx95navq all
+   $ cp build/mx95navq/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.14
+
+.. code-block:: bash
+
+   $ sudo apt install gcc-aarch64-linux-gnu
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ unset LDFLAGS
+   $ unset AS
+   $ git clone -b lf_v2.14 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ make PLAT=imx95 bl31
+   $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: bash
+
+   $ sudo apt install gcc-aarch64-linux-gnu
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ make imx95_navq_defconfig
+   $ make -j$(nproc)
+
+Copy flash.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX95 boot device to MicroSD card.
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index b11730e1eac..cf97d0089d6 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -21,6 +21,7 @@ NXP Semiconductors
    imx95_frdm
    imx943_evk
    imx95_evk
+   imx95_navq
    imx952_evk
    imxrt1020-evk
    imxrt1050-evk
diff --git a/include/configs/imx95_navq.h b/include/configs/imx95_navq.h
new file mode 100644
index 00000000000..3a10d551662
--- /dev/null
+++ b/include/configs/imx95_navq.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 NXP
+ */
+
+#ifndef __IMX95_NAVQ_H
+#define __IMX95_NAVQ_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR		0x90000000
+#define CFG_SYS_INIT_RAM_SIZE		0x200000
+
+#define CFG_SYS_SDRAM_BASE		0x90000000
+#define PHYS_SDRAM			0x90000000
+
+#define PHYS_SDRAM_SIZE			0x70000000	/* 2GB - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE		0x380000000	/* 14GB (Totally 16GB) */
+
+#endif
-- 
2.43.0

