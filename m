Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1535CC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 812F287B2A;
	Mon, 18 Mar 2024 16:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RH8r1HeX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RrjuOxGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C1887E89; Mon, 18 Mar 2024 16:00:20 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E37B87CB1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TyyhJ6CNJz9scF;
 Mon, 18 Mar 2024 16:00:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TbmShIy9IgqjpQFli6p2T1NbKC9JgN0vInPo7hHO3MI=;
 b=RH8r1HeXq31grwMx6mxOppVZvzepXCe/Znk5sxAkJFIfbVkLi4ci15cr/BbNDWr7Yf5z3B
 itbpy8lYEl3sw2pXBizCUwDmpdVFnHCZhAmq3kR3W0zq9l0/oC5l3BrD/+zqnwPKj5ZeDB
 V/Uxrd4YJgTRUh9Yik/ZkwZvvJAeo2n1DLyLIKJpK9TsUWUeLRCZchynyOhg2uKohcJs2t
 9mY41Rq7pufxHBY59hoUq8uLoGewWNBa0fUaJixUhIeU9UpJ8kNsI96WZDc0eMzgmqrIBj
 HnKJUtPfSGgVSg5q9BR7NHieq37/RjN/s4Vqrp4MhBtoy6W2HHoj2UWJ7guH4A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TbmShIy9IgqjpQFli6p2T1NbKC9JgN0vInPo7hHO3MI=;
 b=RrjuOxGTRz8WWhWEgNdlB6wpjmKo+pXhpiNVJAhfg1zOLb5R8hW/T3REwGaMy7yAsm4WfV
 PiniiX31FUGxQeL0NuO7KOgIn8yHx4ZLtXC81umeNc7AO26aLNlxUi6oFx6YcR1FNSxcNT
 2iyhPDii00z9wDsFP3KOcRyWO2OHxEZxg4/0b+IRT4Njw1w+INiON8JE7A9MF+JwNG9qQn
 R7GbujPXA4rZD1iQyFWpvjchhB6BMc4gppnNqb3v8W556rKbEm1/qE8wKDe9EcrpxIqbP2
 51bbJL+81PDgx+tcxy9M+MSuoh6SACfTcTweBNMc4d0BUG7quFM5LhlmflA6sw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] ARM: dts: renesas: Replace R8A77950 with R8A77951
Date: Mon, 18 Mar 2024 15:59:37 +0100
Message-ID: <20240318145958.8099-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7wz64j6uz47xdm6w6dcb8kyaona7mimg
X-MBO-RS-ID: 82fd494eb1c305ec099
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

R-Car R8A77950 H3 ES1.* was only available to an internal development
group and needed a lot of quirks and workarounds. Public users only
have R-Car R8A77950 H3 ES2 and newer. Switch existing systems to use
R8A77951 device trees.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/dts/Makefile                                     | 4 ++--
 ...ator-x-u-boot.dtsi => r8a77951-salvator-x-u-boot.dtsi} | 2 +-
 .../dts/{r8a77950-u-boot.dtsi => r8a77951-u-boot.dtsi}    | 6 ------
 ...8a77950-ulcb-u-boot.dtsi => r8a77951-ulcb-u-boot.dtsi} | 2 +-
 board/renesas/salvator-x/salvator-x.c                     | 2 +-
 board/renesas/ulcb/ulcb.c                                 | 2 +-
 configs/rcar3_salvator-x_defconfig                        | 8 ++++----
 configs/rcar3_ulcb_defconfig                              | 8 ++++----
 8 files changed, 14 insertions(+), 20 deletions(-)
 rename arch/arm/dts/{r8a77950-salvator-x-u-boot.dtsi => r8a77951-salvator-x-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77950-u-boot.dtsi => r8a77951-u-boot.dtsi} (93%)
 rename arch/arm/dts/{r8a77950-ulcb-u-boot.dtsi => r8a77951-ulcb-u-boot.dtsi} (96%)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b6da94ab04b..a26cca88973 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1157,8 +1157,8 @@ dtb-$(CONFIG_RCAR_GEN3) += \
 	r8a774b1-hihope-rzg2n.dtb \
 	r8a774c0-ek874.dtb \
 	r8a774e1-hihope-rzg2h.dtb \
-	r8a77950-ulcb.dtb \
-	r8a77950-salvator-x.dtb \
+	r8a77951-ulcb.dtb \
+	r8a77951-salvator-x.dtb \
 	r8a77960-ulcb.dtb \
 	r8a77960-salvator-x.dtb \
 	r8a77965-ulcb.dtb \
diff --git a/arch/arm/dts/r8a77950-salvator-x-u-boot.dtsi b/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
similarity index 96%
rename from arch/arm/dts/r8a77950-salvator-x-u-boot.dtsi
rename to arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
index 23f12543746..744f4aaaad9 100644
--- a/arch/arm/dts/r8a77950-salvator-x-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-salvator-x-u-boot.dtsi
@@ -5,7 +5,7 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77950-u-boot.dtsi"
+#include "r8a77951-u-boot.dtsi"
 
 / {
 	sysinfo {
diff --git a/arch/arm/dts/r8a77950-u-boot.dtsi b/arch/arm/dts/r8a77951-u-boot.dtsi
similarity index 93%
rename from arch/arm/dts/r8a77950-u-boot.dtsi
rename to arch/arm/dts/r8a77951-u-boot.dtsi
index 92907ea09bf..4cbec591479 100644
--- a/arch/arm/dts/r8a77950-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-u-boot.dtsi
@@ -30,7 +30,6 @@
 /delete-node/ &can1;
 /delete-node/ &canfd;
 /delete-node/ &csi20;
-/delete-node/ &csi21;
 /delete-node/ &csi40;
 /delete-node/ &csi41;
 /delete-node/ &drif00;
@@ -44,16 +43,13 @@
 /delete-node/ &du;
 /delete-node/ &fcpf0;
 /delete-node/ &fcpf1;
-/delete-node/ &fcpf2;
 /delete-node/ &fcpvb0;
 /delete-node/ &fcpvb1;
 /delete-node/ &fcpvd0;
 /delete-node/ &fcpvd1;
 /delete-node/ &fcpvd2;
-/delete-node/ &fcpvd3;
 /delete-node/ &fcpvi0;
 /delete-node/ &fcpvi1;
-/delete-node/ &fcpvi2;
 /delete-node/ &hdmi0;
 /delete-node/ &hdmi1;
 /delete-node/ &lvds0;
@@ -72,10 +68,8 @@
 /delete-node/ &vspd0;
 /delete-node/ &vspd1;
 /delete-node/ &vspd2;
-/delete-node/ &vspd3;
 /delete-node/ &vspi0;
 /delete-node/ &vspi1;
-/delete-node/ &vspi2;
 
 / {
 	/delete-node/ cvbs-in;
diff --git a/arch/arm/dts/r8a77950-ulcb-u-boot.dtsi b/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
similarity index 96%
rename from arch/arm/dts/r8a77950-ulcb-u-boot.dtsi
rename to arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
index c65c2e6406d..305c4861520 100644
--- a/arch/arm/dts/r8a77950-ulcb-u-boot.dtsi
+++ b/arch/arm/dts/r8a77951-ulcb-u-boot.dtsi
@@ -5,7 +5,7 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77950-u-boot.dtsi"
+#include "r8a77951-u-boot.dtsi"
 
 / {
 	cpld {
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index afb3b63582b..2c8860bcee4 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -79,7 +79,7 @@ int board_fit_config_name_match(const char *name)
 	u32 cpu_type = renesas_get_cpu_type();
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A7795) &&
-	    !strcmp(name, "r8a77950-salvator-x"))
+	    !strcmp(name, "r8a77951-salvator-x"))
 		return 0;
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A7796) &&
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index cda6976602d..64f01b123cb 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -70,7 +70,7 @@ int board_fit_config_name_match(const char *name)
 	u32 cpu_type = renesas_get_cpu_type();
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A7795) &&
-	    !strcmp(name, "r8a77950-ulcb"))
+	    !strcmp(name, "r8a77951-ulcb"))
 		return 0;
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A7796) &&
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index c76cbec76d4..22d649296e1 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -6,7 +6,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77950-salvator-x"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77951-salvator-x"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_SALVATOR_X=y
@@ -21,8 +21,8 @@ CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77950-salvator-x.dtb; booti 0x48080000 - 0x48000000"
-CONFIG_DEFAULT_FDT_FILE="r8a77950-salvator-x.dtb"
+CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77951-salvator-x.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_DEFAULT_FDT_FILE="r8a77951-salvator-x.dtb"
 CONFIG_SYS_PBSIZE=2068
 CONFIG_SYS_MALLOC_BOOTPARAMS=y
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -48,7 +48,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a77950-salvator-x r8a77960-salvator-x r8a77965-salvator-x"
+CONFIG_OF_LIST="r8a77951-salvator-x r8a77960-salvator-x r8a77965-salvator-x"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index 701dfcb7a0e..8349f070ba4 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77950-ulcb"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77951-ulcb"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_ULCB=y
@@ -20,8 +20,8 @@ CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77950-ulcb.dtb; booti 0x48080000 - 0x48000000"
-CONFIG_DEFAULT_FDT_FILE="r8a77950-ulcb.dtb"
+CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77951-ulcb.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_DEFAULT_FDT_FILE="r8a77951-ulcb.dtb"
 CONFIG_SYS_PBSIZE=2068
 CONFIG_SYS_MALLOC_BOOTPARAMS=y
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a77950-ulcb r8a77960-ulcb r8a77965-ulcb"
+CONFIG_OF_LIST="r8a77951-ulcb r8a77960-ulcb r8a77965-ulcb"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
-- 
2.43.0

