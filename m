Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AD4E77372
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 12:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB228705F;
	Sat, 30 Sep 2023 14:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HG9qr3J/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709D986FD3; Sat, 30 Sep 2023 14:02:20 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C9B87018
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 14:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 274ED440A5; 
 Sat, 30 Sep 2023 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696075336;
 bh=IqehM34qZcm5ziRYe+BMfu8DC1bOE/61/9isOldaehU=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=HG9qr3J/SO4ukVbxpRYI5NxQfVFmCEUVLfrAHYFpJQLbt6sGjm9of4irVzPAUaz7M
 ovl9GNqEI65kSiQcVTKwvHgiaw3TSBF++WJnqDANRjJgXL7nU/O8qQZoATX9OOZl27
 TYxZiPujRJbHeltMn23eS2PMSZmq5d/4cH8fAn3aMrkEefB83K/J8zUo8A1+fqmWy4
 tKj+lCJZ9tS8YH54PRbt+BfrVLQE4b9h7BAL/a2uCWT2OL/wMsuOws2GxDp+JBRWHq
 t9rzQ7yuu9c1WOiMeVzxzrxPwm6XhzlhM1NBfZmWhEtunKijLURqtauU0YoZ6oIrvN
 WpU3GEhMfbvtg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/6] cmd: move mac command
Date: Sat, 30 Sep 2023 14:01:42 +0200
Message-Id: <20230930120147.59482-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
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

Board specific implementations of the 'mac' command differ concerning the
supported sub-commands.

Move the Freescale specific mac command definition to the board code.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/freescale/common/sys_eeprom.c | 22 +++++++++++++++++++
 cmd/Makefile                        |  1 -
 cmd/mac.c                           | 33 -----------------------------
 3 files changed, 22 insertions(+), 34 deletions(-)
 delete mode 100644 cmd/mac.c

diff --git a/board/freescale/common/sys_eeprom.c b/board/freescale/common/sys_eeprom.c
index 431f8caeb0..d4a00fe920 100644
--- a/board/freescale/common/sys_eeprom.c
+++ b/board/freescale/common/sys_eeprom.c
@@ -623,3 +623,25 @@ unsigned int get_cpu_board_revision(void)
 	return MPC85XX_CPU_BOARD_REV(be.major, be.minor);
 }
 #endif
+
+U_BOOT_CMD(
+	mac, 3, 1,  do_mac,
+	"display and program the system ID and MAC addresses in EEPROM",
+	"[read|save|id|num|errata|date|ports|port_number]\n"
+	"mac read\n"
+	"    - read EEPROM content into memory data structure\n"
+	"mac save\n"
+	"    - save memory data structure to the EEPROM\n"
+	"mac id\n"
+	"    - program system id per hard coded value\n"
+	"mac num string\n"
+	"    - program system serial number to value string\n"
+	"mac errata string\n"
+	"    - program errata data to value string\n"
+	"mac date YYMMDDhhmmss\n"
+	"    - program date to string value YYMMDDhhmmss\n"
+	"mac ports N\n"
+	"    - program the number of network ports to integer N\n"
+	"mac X string\n"
+	"    - program MAC addr for port X [X=0,1..] to colon separated string"
+);
diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c3..d515d241e6 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -107,7 +107,6 @@ obj-$(CONFIG_CMD_LICENSE) += license.o
 obj-y += load.o
 obj-$(CONFIG_CMD_LOG) += log.o
 obj-$(CONFIG_CMD_LSBLK) += lsblk.o
-obj-$(CONFIG_ID_EEPROM) += mac.o
 obj-$(CONFIG_CMD_MD5SUM) += md5sum.o
 obj-$(CONFIG_CMD_MEMORY) += mem.o
 obj-$(CONFIG_CMD_IO) += io.o
diff --git a/cmd/mac.c b/cmd/mac.c
deleted file mode 100644
index a39e1168a5..0000000000
--- a/cmd/mac.c
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2006 Freescale Semiconductor
- * York Sun (yorksun@freescale.com)
- */
-
-#include <common.h>
-#include <command.h>
-
-extern int do_mac(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
-
-U_BOOT_CMD(
-	mac, 3, 1,  do_mac,
-	"display and program the system ID and MAC addresses in EEPROM",
-	"[read|save|id|num|errata|date|ports|port_number]\n"
-	"mac read\n"
-	"    - read EEPROM content into memory data structure\n"
-	"mac save\n"
-	"    - save memory data structure to the EEPROM\n"
-	"mac id\n"
-	"    - program system id per hard coded value\n"
-	"mac num string\n"
-	"    - program system serial number to value string\n"
-	"mac errata string\n"
-	"    - program errata data to value string\n"
-	"mac date YYMMDDhhmmss\n"
-	"    - program date to string value YYMMDDhhmmss\n"
-	"mac ports N\n"
-	"    - program the number of network ports to integer N\n"
-	"mac X string\n"
-	"    - program MAC addr for port X [X=0,1..] to colon separated string"
-);
-- 
2.40.1

