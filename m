Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51A9C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 867656075D;
	Wed, 26 Aug 2026 13:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRVM1884iKKQ; Wed, 26 Aug 2026 13:42:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751763;
	bh=KfJR8Bx0cc17ByYT8K9YMEZS9Sh8PuicUChYP6/gKfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYMKMIg+lBcwAmA07jyrYqJhVkyhcgdvo5lydAVmrmViTRLadxwT62T68nIIZWDQg
	 wKcKo2fBOAlEvkM+jYKbD3C2sjPKPRYh5fD2kKu5AAvxzFNn/6TNZIaxlVMv5q/icG
	 ge/XSW5cMQbsjLkYZ/2lKayiM9jrkqVSbZH+NpM+vldynaKHUYI1SmZTu9gevg3MUW
	 4jPpC/IJLVRIJ6BCXkzDkx4FVB+04p6XL+fQ/+GFdofILW62aUOix/jcBM/Go4pcRF
	 dgmVxttL/3TywpWPpfFMDBnHkxObzfeXOEVcnia0REp/2+oQ4qLnl8Fx1QN0T6/aR4
	 t61OZspcGlpqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2A276069D;
	Wed, 26 Aug 2026 13:42:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 631F0334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4968480ABB
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aUuKAUZvsOwS for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:35:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=DTewSPl+
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp1.osuosl.org (Postfix) with ESMTPS id D608E80AC7
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751307; bh=KfJR8Bx0cc17ByYT8K9YMEZS9Sh8PuicUChYP6/gKfs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=DTewSPl+K1SLTTiU47jHGPlM4r4X11yDiJL28hQubNP3CWu8Ymz4gaXR3HmTCs72IvuWNhlgLvNjXXm87DcXbtUEAqyvv0GyFhAWYCEq3hXoiaGGcB69042SzC/n6Ea/6cfdhuNIohE2L93PwAIWEsCdT8LlgyMajnVFTr5YGDYYhaJLlORDEJFNQYPTTmfAGcmbCto1a3MLS4RFrfA/T1QGp5HBKyRs1rjE8ndBTkeLfyGtsnV7SG7Qe8C/msilnfPAH9A/lP9/gmPpH4YCclhN/N6ZnQaop1CQszWOA+RtM7BjrDIgE5mxITbvpx20bv1EkV4kKEMQIt+fGZU1ww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751307; bh=5BKRHKMAgvkAjOq9t7SSRmjlZUBCzjaeFWMMHgiAVsf=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=HGV+w9uZt4VLH6TcB5bWGgGKAEN4k91/DphpOl3P9gHpH/SXcwNkVvD7F/WZHC71vcSsdGxKV0qZveAnjsEj4tK38oZjoZpSlpuZE7UBu0XckseQZY+TG8G8LPGvpdgbmSjVjxaTv/WBodnUsM3UljWYeQgnKh5WIhV298+mvaqgVOmjATJb0UAxWizpoNdc0kGXFu+eeh+H9fnxdL9Rc+SyAUadK1foscnQzlAjddQatuRhpDPsAVP2gQFtXtVmfo/KDpRIZNZOESqI2003PV5l7I05sk/yuS0dWNkOClPSSRhihwESlZO4GypSTtL5MgU3QySLmKUzxN3cgtpCVg==
X-YMail-OSG: IXZLstMVM1mqEZsUjiUN8qFi1it.KEB_RaQ0ADK1zI.DQVoKLLWI_QVVzevheju
 OtxrogLV0NT9jmG3kOt5RAQGd9OwkG8OlvnuCetRTnqfrON5nF109YnCs5w8RF1fdZBCaHA1yHDo
 A8K61T64SSGqHjGEhJSWg.LlgiqXUftf6l0eFDr2mg32gzfKXrYlGZiCgfF3cHq2.t6c_N2F1UWD
 YlW3QbAzfbyzaDBXYDEvxELTQ1JQfdtrO_0qC3PZrestUwKGsteQrpxmk.6vF6PrtZ3tDkd3uGTB
 mUzl95vqDMsS2Fq8K6obznDPr08eKtEdmG8mhR6bvjARJzPWn0J8p1_1W5YZei5k2sr35Svsv4A8
 fGRquFacVw3vL5pVgPCzAN89a7DPNjRsgfvfYpL3rqqoWJot6KK.DgP2V6p80ilF59mdNDUkWT6Y
 dQ0hzJZhr4dPvGspcAVDV6Vlf6hKXbHUcmUuHc3Uwx17OlB.qbJKNl4b4G45zDUpr9l18nhFmUe3
 1brPm0V3rXv_EEcKlTrP6D0CC7VHmlRd9oG7wEXBbPvN4ZBdFCvO6of0WynkHAVGUr9G6wX6r0Kp
 TKITkJu.1pG8imj8eMkCebnKyUFWGI1FDrFUp9.isrEd8.TNTh9yacbZAS0XDaRbKr3WEl1h.zzs
 WZ.uVgQgO_3SOv_0S9O2l4XmzvjrWVu_.g9IIzI.tOymcXMtJd3Bsv_6r39Qfug3yxq478ZQtaGw
 L5ndFfbUg6lbe.rWB5Dxe4RX1rIphlbKMxYSd5ir1HRwAuVQaQe8xLu5AfkH79FXqm4mCrHYj1qt
 hGLlhboBCvpnvxZfY_Xm0oeGY0v1vd609pF1yqKf9_RH1zYE6S8grZKuwzhi38L._fnG1E78bVZ3
 b0yDtiPhQm6KmpkN9DoP1jpMUrzbGbFdfsIA8zvKQoMMQ2BlUm5XbWRzUGIcZFdX2Ca7y7KQMT7t
 AoHh3ECkksR2_VIj_KF5ADHsXkcpcRE.ZCJitS3U4WSN1G5Pr6Y_qpGbgM1DI1bQODzqc5sHujW.
 ZQQl9E8ebp_zo2wSmO2tSVqjwu8v0u5FLTsphj0.gt_HxVgV9C8qzsqx9j_OoPInqtawZiaWkxja
 6rcPN7mXBDv5hi7wS8Hqy8rzYMc597sC1Odeom0hh0dg2xlOqn7Qvp9G9Juh_3T6287IkVBbQrIp
 RHXj4lTahztq6BoqI7UdE_L1dCQoFS5vs_yhqJt_vsc8I54C8MMVPsnVKtcSRj6hdh7DYQLD3Zte
 TNylQ4EjHyO8j1cKkHTHPAHxatEi8UxKwShzOSgz08kWGzqHjuhNCZVnBK4R21ZK47ecqwgY6HNS
 AZ0nXTW3hpHOIEiukxfPxWWhYzvBvvNdpuQp9QEwENBgcVK3dJhBuyf.b3ktgXCUDdLG2Jjfn_Rn
 LLA58Jt2xXMtZ5E_4hCjfKX.b3lEXJdFwIeLjNZ5ueQ91QkS0otH3RPqnGTw02WL_3.Hhffw1Q8G
 oRdlzMkedwQNgr5K68BpHy1_eUUGZuhCog_zPmM.f_ASKBC7oZoCCY91YsEnn5BCo_SdKNfggkqx
 Ss6VZhqAfGRZWGuOY9MSGYVywe3RrIoCkXYtE4Mo26fr5TN0XO_yIKeHXnOgvcpMvRbn7yKaiBfa
 khaCjeqHr3MdMX1qStfzbgu.RTHc0s3JHBzaFHjLg3Ah2OVaQP1f5k0PyWSfqiO4HCG37kYe2Mnn
 WuzIiiG0xkww8lzmdUDzuvPtiRBNPUF_TeWKVIXATWZ.lkRN9JbvgpHt.y1Q4pT.UPc3I9ewcLPw
 onfuWuACiVlj1xLapgInZw4vFWh6649QEyE3DCsnhaNsTKYtQWqco.1BBNI8Nw63wgupK7zB6M2J
 Ip3LS9NEsValp_D.GP25uGVWUlCEqaptBn9F4PIrqZTywnh7K4UizfHLUwuZ_seQa8unemzfAziW
 Bew.Hl1sgNzHpx5kS4ZTLaG4efQtQ_dYNhe0OFwNc5hHys1dENmyL4fMpInMA9jn8RaYl6PX7820
 yy8KAWvaT5uJs1QZGz5WGVvQvDmWcjsMOlrYGDKJiLUr_rFAT9s01MuE0w3b1vV55BVu4loyL14f
 28Q--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 5f8ccb31-d3b6-4541-a3fd-f3fb82bcfc8e
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 26 Aug 2026 13:35:07 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:35:05 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 7/9] board: econet: add EN7512 reference board
Date: Wed, 26 Aug 2026 19:04:41 +0530
Message-ID: <a5307eee0a35c449e047f31476ccb174d15b8021.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
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
 configs/en7512_reference_defconfig | 90 ++++++++++++++++++++++++++++++
 doc/board/econet/en7512.rst        | 66 ++++++++++++++++++++++
 include/configs/en7512.h           |  8 +++
 6 files changed, 208 insertions(+)
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
index 00000000..988ef7fd
--- /dev/null
+++ b/configs/en7512_reference_defconfig
@@ -0,0 +1,90 @@
+CONFIG_MIPS=y
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
index 00000000..d534ce4f
--- /dev/null
+++ b/doc/board/econet/en7512.rst
@@ -0,0 +1,66 @@
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
+==============  ============  ===============================
+Offset          Maximum size  Contents
+==============  ============  ===============================
+``0x00000000``  ``0x8000``    TPL and TCBoot image descriptor
+``0x00008000``  ``0x4f70``    Vendor DDR calibration image
+``0x0000ff00``  ``0x100``     Board manufacturing information
+``0x00010000``  ``0x40000``   Legacy-header SPL image
+``0x00050000``  remaining     Legacy ``u-boot.img``
+==============  ============  ===============================
+
+The combined image leaves the manufacturing block (offset ``0x0000ff00``)
+erased. Before replacing a stock bootloader on a real device, back up and
+preserve that block from the original image; it holds board-specific data
+such as the MAC address, model and board GPIO values. Do not flash the
+combined image over a device whose board data has not been backed up.
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

