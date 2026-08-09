Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2ABC5AC67
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF9A76069C;
	Sun,  9 Aug 2026 01:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vv9mNsvFNAKG; Sun,  9 Aug 2026 01:43:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B66DB6069E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239794;
	bh=ypveIqR3vn6UHBe3gZcefG1gt+Q94gdB99Qi8wrAwJE=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AqzH/6H1V11tS3g/b8aBmU7jxEEgf4DSEWRJHmGScpscewxgI+t01EGeFNY0EmXDU
	 z8F+T9xHypQ0hhfkwpSpNCCQmxI7AwmuRDqdaLVpJ9Zus/98z1YUHb9aB8rfc4Ws0j
	 byic81p6Khh2m3erCdtjLDQc1WILFhYtsVrqc7QQ0erhGTsMTgaYEjszvgD7Tqoimn
	 M1m2kASfpV7i/oR/juMljf6trJgdHcfA5YsujZ6NP1i4AMHrPVO7J6U4wKAQjqkLpi
	 MbD/Ekw1AG9pkwz/y9Tpc+zEigaH3gaTIDyD/4kJK8EjXSsRxW3hUcyiuiVFx7F3AU
	 B1LA0TOacWCmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B66DB6069E;
	Sun,  9 Aug 2026 01:43:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 585AC2B6
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AF1B6069E
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJGexkWXT255 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:43:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 045C36060C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 045C36060C
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 045C36060C
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:43:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hHgd90vNTzKnZd;
 Sun, 09 Aug 2026 03:43:09 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: renesas: r8a779g3: Switch to distro boot command
 on Retronix R-Car V4H Sparrow Hawk
Date: Sun,  9 Aug 2026 03:41:42 +0200
Message-ID: <20260809014258.447774-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809014258.447774-1-marek.vasut+renesas@mailbox.org>
References: <20260809014258.447774-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 02b295c42c81b3d069c
X-MBO-RS-META: eyh67y1t6zyrb719i6y3fmz4wwt8opkg
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypveIqR3vn6UHBe3gZcefG1gt+Q94gdB99Qi8wrAwJE=;
 b=s7seN0aOPoNGQ2GQSMmq/9OractR6RdJWidY2bOBWPLWlcKjfvtMOwsvriglxhYGmhcevO
 j9+2y6T3r1ocFv4ddLo4roNNl28rr0PCRkd+cMIUd0U4FtGP25uiZBOwlqo2XelDb2zBO5
 K5rpYcZIrre6O+xFNP6A35GtzlWI51RKETRKyRseQqi4LwuSxH6IRFaEoSPpWB1X06ZNMq
 s1aNZ4+7Dr+YFFVFZOzSQSVMZ4ECSGKFwd4XkQMUAsRQzeu5LYpwSSlUiqrbwvIp/G9WsD
 C05gOwVCHdc9NOU2Nxq1EN/kz9vSnrfXbufm59ZzNBg2WlrQvDvSDSc0sHVkOw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypveIqR3vn6UHBe3gZcefG1gt+Q94gdB99Qi8wrAwJE=;
 b=lU0wPIBef2ZfSsGJyAalCYkjXtad9EI7ub0jR/5OYTkLKONMQDReYJBC3mCuEyb4CSO/0r
 nUvtM6T4tzv1NIKooI8bOggSZ4yJoscVwtP98MznbXEMcZmypTRsJTeCIuQeMHFiZnt9Ru
 dsfa+DneTON594EV5euk+u8UzoIRiOe2ZamCbvf0O0m1ZwlUL8zpr8VB1i8XwGzQ+bbumm
 I+bMzx3F/+0YDwzs42b7Qqzp/awzHyQvynVLW21Rftd+832FpLLpLEM0gApX3mme+fLg2b
 czrooqGFxpywqSM/qQtRWbDl5QNRPR20/S4r1irqcQzSEKzSaAJrygJPzFTUnQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=s7seN0aO; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=lU0wPIBe
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Switch Retronix R-Car V4H Sparrow Hawk to distro boot command to obtain
generic distro boot capability. The boot scripts now search each of the
SD, NVMe, USB boot devices for either a fitImage with embedded script,
regular boot script, or extlinux.conf, and boot the first one found.
This allows for standardized boot of the device, similar to other such
devices.

There are slight customizations to the distro boot commands, specifically
the PCIe controller is started before USB controller, because the USB
controller is attached to the PCIe controller. Furthermore, USB ethernet
boot is not enabled.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/r8a779g3_sparrowhawk_defconfig |  2 +-
 include/configs/sparrowhawk.h          | 70 +++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index e39d14df806..a36ed3ffa3a 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -19,7 +19,7 @@ CONFIG_SYS_BARGSIZE=2048
 CONFIG_SYS_CBSIZE=2048
 CONFIG_BAUDRATE=921600
 CONFIG_BINMAN=y
-CONFIG_BOOTCOMMAND="tftp ${loadaddr} fitImage && bootm ${loadaddr}"
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_DEFAULT_FDT_FILE="r8a779g3-sparrow-hawk.dtb"
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_GPIO_HOG=y
diff --git a/include/configs/sparrowhawk.h b/include/configs/sparrowhawk.h
index e6e18bc97b0..a4309953433 100644
--- a/include/configs/sparrowhawk.h
+++ b/include/configs/sparrowhawk.h
@@ -11,6 +11,35 @@
 
 #include "rcar-gen4-common.h"
 
+#define BOOT_TARGET_DEVICES(func)	\
+	func(MMC, mmc, 0)		\
+	func(NVME, nvme, 0)		\
+	func(USB, usb, 0)		\
+	func(DHCP, dhcp, na)
+
+#include <config_distro_bootcmd.h>
+
+/*
+ * Support for USB-ethernet and PCIe-ethernet is disabled, do not
+ * initialize either and directly boot via native ethernet only.
+ */
+#undef BOOTENV_RUN_NET_USB_START
+#define BOOTENV_RUN_NET_USB_START
+#undef BOOTENV_SHARED_USB
+#define BOOTENV_SHARED_USB						\
+	"usb_boot="							\
+		"run boot_pci_enum ; usb start ; "			\
+		BOOTENV_SHARED_BLKDEV_BODY(usb)
+#undef BOOTENV_DEV_DHCP
+#define BOOTENV_DEV_DHCP(devtypeu, devtypel, instance)			\
+	"bootcmd_dhcp="							\
+		"devtype=" #devtypel "; "				\
+		"if dhcp ${scriptaddr} ${boot_script_dhcp}; then "	\
+			"source ${scriptaddr}; "			\
+		"fi;"							\
+		BOOTENV_EFI_RUN_DHCP					\
+		"\0"
+
 /* Environment setting */
 #undef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS						\
@@ -62,6 +91,45 @@
 	"update_loader_from_usb="					\
 		"pci enum && usb start && "				\
 		"env set renesas_update_loader_iface usb && "		\
-		"run update_loader_from_blk01\0"
+		"run update_loader_from_blk01\0"			\
+	\
+	BOOTENV								\
+	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"		\
+	"scan_dev_for_scripts="						\
+		"if test -e ${devtype} ${devnum}:${distro_bootpart} "	\
+				"${prefix}fitImage; then "		\
+			"echo Found fitImage ${prefix}fitImage ; "	\
+			"if test ${devtype} = \"mmc\" ; then "		\
+				"env set bootargs \"${bootargs} "	\
+					"root=/dev/mmcblk0p1\" ; "	\
+			"elif test ${devtype} = \"nvme\" ; then "	\
+				"env set bootargs \"${bootargs} "	\
+					"root=/dev/nvme0n1p1\" ; "	\
+			"elif test ${devtype} = \"usb\" ; then "	\
+				"env set bootargs \"${bootargs} "	\
+					"root=/dev/sda1\" ; "		\
+			"else "						\
+				"part uuid ${devtype} "			\
+					"${devnum}:${distro_bootpart} "	\
+					"uuid ; "			\
+				"env set bootargs \"${bootargs} "	\
+					"root=PARTUUID=${uuid}\" ; "	\
+			"fi ; "						\
+			"env set bootargs \"${bootargs} rw rootwait\" ; " \
+			"load ${devtype} ${devnum}:${distro_bootpart} "	\
+				"${scriptaddr} ${prefix}fitImage && "	\
+			"source ${scriptaddr}:script ; "		\
+			"echo fitImage script FAILED: continuing...; "	\
+		"fi; "							\
+		"for script in ${boot_scripts}; do "			\
+			"if test -e ${devtype} "			\
+					"${devnum}:${distro_bootpart} "	\
+					"${prefix}${script}; then "	\
+				"echo Found U-Boot script "		\
+					"${prefix}${script}; "		\
+				"run boot_a_script; "			\
+				"echo SCRIPT FAILED: continuing...; "	\
+			"fi; "						\
+		"done\0"
 
 #endif /* __SPARROWHAWK_H */
-- 
2.53.0

