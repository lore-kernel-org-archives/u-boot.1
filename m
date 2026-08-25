Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC55C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7E7F60744;
	Tue, 25 Aug 2026 22:50:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eokm4fmELPff; Tue, 25 Aug 2026 22:50:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698234;
	bh=2xKeVUc9RK6fd8powY0TC80r9dZJ3LUHSefYjZ38peA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fvh6cn2317Uzj8gTmCdNLhszngBEyt0XPHVJdrmRpBfhWXHQI7k0HVqaE6226Ap2I
	 q2aoh9zxI5S5YIczVr++GzfYTbf1EAgiCYc870c8r/e54NSyMbPd9Nqi3/67W2KHY/
	 fKqeWBw7vRAG50PeMKNDJ1O+Bs2/YGWTCZzi3a2eppRc0ppylWWcUJfFzJN+pHWa80
	 VgUUYuaYb25JRN3UpaCMz50cfUvOfJ5d1raL0PUDuaURd9W2BE3ROcBcCcFRA1WblK
	 lN9D+WIemRfu63Cs6VcNjOoefxx+BCBDOZEO0500Mnd0pvu/oUv6mba9fTMQwgVGIE
	 UPfYNOTbBt6ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0CFA60771;
	Tue, 25 Aug 2026 22:50:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 450CA3C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2BE8C80B48
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X0XKjLtG0Ee1 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=UR9jWHBs
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp1.osuosl.org (Postfix) with ESMTPS id 72BEC80AC5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697857; bh=2xKeVUc9RK6fd8powY0TC80r9dZJ3LUHSefYjZ38peA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=UR9jWHBsW7tHYnWj8Lor7sksjQ0iwZDQWaVPLjsj4HQBUaq3wL4P8aHRDcr6iMYqWTp39xNt1qq27MW+uF5Fc80kz9rgC4WS9NGuMLuekbmu/7EgHS/rj6DS1JmE4N86MOO+/Z8nvDzn/W1fYFyH6fVb65LwQutfQaT1Ey28hljcC3ttvbOQg0ociMS1lMUOiJvkmu1VIleOXoW5a+0L6BgvLmxM+tzdtjJbPyMNyakYQHNmI9TqOKlEXBeqMpyFtETeQX4iyFtv6nfziFGz5Pdq7Ul7VOcdyAHwn2DNK0kZkT/VsXoVoBSFojbptVJg+VPAeDr4r4U1jZEe6M7QOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697857; bh=O6fycwLQeuVL7iz1ndAJwjpDfJhZkdaNdwVH0D5CJ/q=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=QfLutRklKzvAYsnT80TZY4MjOAMwLJjdktxin+ji85PUePSWltsm6DS/8xJ4YeSI9ioy7L3D/xuqNDYLFRtsGZOZJ/9bmrM4DUzA+BawpiudwUVib+nu6w9AednIwxAQydRscElJcX7nhXoe5Lpw/t5r/RzS8F4pclpDHtOrwhShmSARiyhKhYhp4e1613a9ch3oFYYX6tUSo65SWcA2a8zLTA9H426/U++ULsI2aoIX+SbcdhjbVCMHeu1ivLLWt5lAX/RVOGMcKVNOK7HC/6A9rDJ+mnTl0OX0CKIxj+B86nejOgQdkaQOTEsaCarNXuwc+aO5Xnid+SEYi/fgpg==
X-YMail-OSG: ChOdX9AVM1nrVKnCJ8lsNTfDC6SVUD7UlNDcDoRB.jpiSiB9XB61qREpPOq75fE
 bFhTVXCm91lofsg2BbVGPQYF8JJjtyCWLZ1aG2X3LAIHExF2JHB0Dp86UO6n2pSOW3Qyw6WTH4.0
 fjsF7nXrsgLWRtnpaZI6pJ2D93ipsg8oM21_Onqy6DR11hUjrovYuLEWwT7.fmYXlnW_rh2WyYCB
 q1rXAjS8dRRSlfgw5hlUkndIt7AHAbhdD1vriZeDyras7urpGLAAOmUdcI088qvxFVYpDpcMqEIh
 p1Od0g1fZCLRDwZYBRconJlPE3N8PDAz2iX5_OXf7fi4Yt8fVnRZr3d9MeZMGm0qG14NvdrPAykS
 rshIjZIKPTv4qeITudmUf_UiPmUYqCsNRda1oZAVKIvVJGO4Ywg0.0IG_4FtJ7pRjX_2UPzjnAh5
 TmS4s873gDVcSZesnvpod3bsxpmvBGR1jJbmGOwL8_qXq65Np75nGo3eiRjEya6JaRx.v1OMg.0U
 NfgqZowVPEHyydAoOhFzK46iAYBK7msMBo0OA6sekTNPaBjEckVXkaPi2HKSIhLIi77.H_dVpJzd
 YOjeY9cg.ixI8QBCk9Lqmt7C.ivDP5AAcqVIS02fS4B1yWKVtyjYLi5ozFWjFJRL.7FIsUV7Pz0D
 I_4_B2bBeDzT8uty05KhY6Egqww77gYDJ..wqe_PR95jH_1SK9rjhSe.A0EREzsRSv_1jg4guAG1
 PVGKiWiEVeLhs4IQYoXGqCQQdIdcmdBRgIL82WtiiEjjULpeLPOuhJbHXQHT5FJjQCNlE8PmY27q
 fSTOEi7eUgCjbitmjK5fcj.ohcLN6qpw5w925siOW0WdaFGBf.a.C7XEvk0VW8X1T5GKmI.tVNlR
 SBhNmhmk8Ra6PTMLK2TwuwamyyXnvbnQD3QBLyZ_Mc2FrCkGXX63gLy5tajvcQll0TDjwU5IJ2vI
 VUFpEynfhMPeprQB2qa2NRRNufYhryApCZrn37hHaaJGv.6a4NHWnCnBECG5PYT5QRDayPSvzRd6
 yRanATPNfDSGMRQuNkoUMft0L.pXCElVgjxL0.5n6NCXJv5v6pWFUumBpWe6DFsbnz6Y.lHwbxbq
 Qksx39Py4bIB.vqxOhrusYOmn1WK2zmHEg.qhOkNAlvUbiAj05EWB_92N3OlEJbuGrezAnF79W9B
 TtE4yqxcrsS9gpTNzKVLhkcXrcRznSVvR1_ApR5JFoWzRw4WobBkLOsjr0JS03FJGDCl0op7H3xE
 PXXhJTz2NDoHTKZ6xbpQXboJuWOcla5T42uIWBTdoD9QmOHN.YpL4Un9_TYliMBeqvSYMKnYu_p2
 Jrmw_Q9BOsgZzEhXp1VjRhytiZmmEitENd5zEBbu_Ug7bpcrVQxYxhAu.BV5zN4JxlO7AUP9SXU9
 1yh3YEzll2WuJIyqxDHEgwHaFRuFFKbttmf_4OCjllqiUPX4Npwwyu7FcORi8oLSQSPR15qbcvdS
 3iRkXYPu_qqq3_42vhB_i5TT5vHI4c0jD17bLGLAKw79jEbIPUEsbJu2ZBGczAryB4LGRBerMTXO
 55o3Ha_47kM1MIxUAxEy0wNBf3E7Ufuwwtn8jLKTPLXVxG2aPry7XcgeVlPTDc15qQQ4aYiRyBtD
 r5MsddQuAvS6OL1k_Rhm76E39tF6Hgu1EnS8m4RF8psQl9XSh5q7p0tx16sA71DnNgXxzKkqIB3C
 TppaQ.NdLaJqYOIm4JkR.Vx.GSYk6ebxQ6DtYOr89wpJKWWTqEU3Jpr0RqvLXHW2Zq1sdU1gcpRR
 QVQ958x7Ut0TrcqDioJMPiUX3.0_r4H0tV626DyzJzJx1_6C.3jGKvWYWjTJIFsVUIC_iMIgjhtC
 KSdCHlRAm3OBiNxe2WVdz.4k8Cmd5BVmhLp594b7xs950nnwXGcwmaA0IfTBH1PzkrwgS1IJ8132
 KSwgXJ5C6rNVWRfTMMhS0aAc6lfWCbTznegGK25tZeaLxmXxe1_EYwxsNgw.tvu5URBJ_BvLKM.k
 uXj4QfDG2QOUbqIwWlMTtCpGu53rGARcEcsFZKqK3eYaMKeKhA0ssOjSy_NZnHWsB2i9UG.Xn9GR
 gWo1.DQ--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: b5b49d07-0d25-4617-9178-8f2fe7dd6eaa
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 25 Aug 2026 22:44:17 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:44:15 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 10/12] board: econet: add EN7512 reference board
Date: Wed, 26 Aug 2026 04:12:05 +0530
Message-ID: <20260825224330.713151-11-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
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

Add the EcoNet EN7512 reference board: board glue, defconfig, board
header and documentation.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 board/econet/en7512/MAINTAINERS    |  8 +++
 board/econet/en7512/Makefile       |  2 +
 board/econet/en7512/board.c        | 34 +++++++++++
 configs/en7512_reference_defconfig | 93 ++++++++++++++++++++++++++++++
 doc/board/econet/en7512.rst        | 70 ++++++++++++++++++++++
 drivers/usb/host/Kconfig           |  2 +-
 include/configs/en7512.h           |  8 +++
 7 files changed, 216 insertions(+), 1 deletion(-)
 create mode 100644 board/econet/en7512/MAINTAINERS
 create mode 100644 board/econet/en7512/Makefile
 create mode 100644 board/econet/en7512/board.c
 create mode 100644 configs/en7512_reference_defconfig
 create mode 100644 doc/board/econet/en7512.rst
 create mode 100644 include/configs/en7512.h

diff --git a/board/econet/en7512/MAINTAINERS b/board/econet/en7512/MAINTAINERS
new file mode 100644
index 00000000..0c1b931a
--- /dev/null
+++ b/board/econet/en7512/MAINTAINERS
@@ -0,0 +1,8 @@
+ECONET EN7512 REFERENCE BOARD
+M:	AK Sharma <maskachoska@yahoo.com>
+S:	Maintained
+F:	arch/mips/dts/econet,en7512*
+F:	board/econet/en7512/
+F:	configs/en7512_reference_defconfig
+F:	doc/board/econet/en7512.rst
+F:	include/configs/en7512.h
diff --git a/board/econet/en7512/Makefile b/board/econet/en7512/Makefile
new file mode 100644
index 00000000..bcca1a9f
--- /dev/null
+++ b/board/econet/en7512/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+obj-y += board.o
diff --git a/board/econet/en7512/board.c b/board/econet/en7512/board.c
new file mode 100644
index 00000000..c20597e8
--- /dev/null
+++ b/board/econet/en7512/board.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <init.h>
+#include <linux/errno.h>
+#include <stdio.h>
+
+extern U_BOOT_DRIVER(airoha_eth);
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_AIROHA_ETH))
+		return 0;
+
+	/*
+	 * The EN751221 Ethernet parent is intentionally not probed while the
+	 * driver model is being initialized. Probe it after the console is
+	 * usable and just before initr_net() enumerates UCLASS_ETH devices.
+	 */
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(airoha_eth), &dev);
+	if (ret && ret != -ENODEV)
+		printf("EN751221 Ethernet probe failed: %d\n", ret);
+
+	return 0;
+}
diff --git a/configs/en7512_reference_defconfig b/configs/en7512_reference_defconfig
new file mode 100644
index 00000000..ebf5dbf0
--- /dev/null
+++ b/configs/en7512_reference_defconfig
@@ -0,0 +1,93 @@
+CONFIG_MIPS=y
+CONFIG_SYS_BIG_ENDIAN=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="econet,en7512-reference"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_SERIAL=y
+CONFIG_TPL_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SPL_BSS_START_ADDR=0x80080000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_SPL=y
+CONFIG_ARCH_EN75XX=y
+CONFIG_BUILD_TARGET="u-boot.bin"
+CONFIG_BOARD_EN7512_REFERENCE=y
+CONFIG_SYS_MIPS_TIMER_FREQ=150000000
+CONFIG_MIPS_CACHE_SETUP=y
+CONFIG_MIPS_CACHE_DISABLE=y
+CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
+CONFIG_MIPS_BOOT_FDT=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_DEFAULT_FDT_FILE="en751221_ref"
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_DISPLAY_CPUINFO=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_TPL=y
+# CONFIG_TPL_FRAMEWORK is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIN2MAC=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MTD=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_LOG=y
+CONFIG_CMD_UBI=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_UBI_PART="ubi"
+CONFIG_ENV_UBI_VOLUME="ubootenv"
+CONFIG_ENV_UBI_VOLUME_REDUND="ubootenv2"
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_LED=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_UBI_BLOCK=y
+CONFIG_DM_MDIO=y
+CONFIG_AIROHA_ETH=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_RAM=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+# CONFIG_UBIFS_SILENCE_MSG is not set
+# CONFIG_BINMAN_FDT is not set
+CONFIG_SHA512=y
diff --git a/doc/board/econet/en7512.rst b/doc/board/econet/en7512.rst
new file mode 100644
index 00000000..379ae0cb
--- /dev/null
+++ b/doc/board/econet/en7512.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+EN7512/EN7521 reference board
+=============================
+
+This target provides the initial U-Boot port for the MIPS-based EcoNet/Airoha
+EN7512 and EN7521 SoCs. It replaces the proprietary multi-stage TCBoot flow
+with U-Boot TPL, SPL and U-Boot proper stages.
+
+Boot flow
+---------
+
+The boot ROM starts the TPL from the uncached flash window at ``0xbfc00000``.
+The TPL enables the Front-End SRAM, initializes the serial port and reads the
+DDR calibration image and SPL through the early SFC reader. After DDR
+initialization, SPL loads ``u-boot.img`` into DRAM.
+
+The generated ``u-boot-en7512.bin`` has the following fixed layout:
+
+==================  ===========  ========================================
+Offset              Maximum size Contents
+==================  ===========  ========================================
+``0x00000000``      ``0x8000``   TPL and TCBoot image descriptor
+``0x00008000``      ``0x4f70``   Vendor DDR calibration image
+``0x0000ff00``      ``0x100``    Board manufacturing information
+``0x00010000``      ``0x40000``  Legacy-header SPL image
+``0x00050000``      remaining    Legacy ``u-boot.img``
+==================  ===========  ========================================
+
+The combined image leaves the manufacturing block erased. Before replacing a
+stock bootloader, preserve the board-specific block from the original image::
+
+    tools/en7512_image.py --image u-boot-en7512.bin \
+        --stock tcboot-stock.bin --output u-boot-en7512-board.bin
+
+The block contains data such as the MAC address, model and board GPIO values.
+Do not flash the unmerged combined image over a device whose board data has not
+been backed up.
+
+Build
+-----
+
+Use a big-endian MIPS cross compiler::
+
+    make en7512_reference_defconfig
+    make CROSS_COMPILE=mips-linux-gnu-
+
+The flashable combined image is ``u-boot-en7512.bin``.
+
+Current limitations
+-------------------
+
+* DDR initialization temporarily uses the original vendor calibration image,
+  linked for execution at ``0x9fa32800``. Its source code was not included in
+  the SDK and it must eventually be replaced by a native driver.
+* The SFC implementation used by TPL and SPL is read-only. U-Boot proper uses
+  the Airoha EN7523 SPI-MEM driver with the EN751221 double chip-select quirk.
+  Flash erase/write must not be used until the board's BBT/BMT layout has been
+  verified.
+* Ethernet provides a polling-only U-Boot path through EN751221 QDMA0, GDM1
+  and the integrated MT7530. It deliberately preserves switch/PHY reset state
+  during chainloading. Cold-boot PHY initialization and multi-port control
+  still need board-specific validation.
+* U-Boot proper has been chainloaded and validated on physical hardware. The
+  complete BootROM -> TPL -> SPL -> U-Boot cold-boot path remains untested.
+
+TPL reports early failures with one character followed by a newline:
+``I`` for SFC initialization, ``F`` for DDR image reading, ``H`` for an
+invalid SPL header, ``S`` for SPL loading and ``L`` for a load address that
+cannot be reached through KSEG0/KSEG1.
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d75883e2..fbd6690a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -54,7 +54,7 @@ config USB_XHCI_EXYNOS
 
 config USB_XHCI_MTK
 	bool "Support for MediaTek on-chip xHCI USB controller"
-	depends on ARCH_MEDIATEK || SOC_MT7621
+	depends on ARCH_MEDIATEK || SOC_MT7621 || ARCH_EN75XX
 	help
 	  Enables support for the on-chip xHCI controller on MediaTek SoCs.
 
diff --git a/include/configs/en7512.h b/include/configs/en7512.h
new file mode 100644
index 00000000..93e1c485
--- /dev/null
+++ b/include/configs/en7512.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __CONFIG_EN7512_H
+#define __CONFIG_EN7512_H
+
+#define CFG_SYS_SDRAM_BASE	0x80000000
+#define CFG_SYS_INIT_SP_OFFSET	0x00800000
+
+#endif
-- 
2.53.0

