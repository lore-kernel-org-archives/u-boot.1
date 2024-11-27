Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7E6D609A8
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 07:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C24589CA5;
	Wed, 27 Nov 2024 08:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lZw7tzH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8DE489CE4; Wed, 27 Nov 2024 08:07:01 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30FC889794
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 08:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6AF2F41027; 
 Wed, 27 Nov 2024 07:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732691209;
 bh=BzY46QElH3RgvuRD7AJW/YQPS8JZgAXL6QoFwmBPxYE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lZw7tzH8RuIMbVgGdflmVNUSYGEttWt87reTcev1c2KJq/G4EUt+iqQ3mIih6fSVr
 KnQ3mPOr/zen5fg3EhYOANI+FW4BLH6JUp1dUsrel8LRP78kZS8+hzxaqT0ykE2CAL
 D1BUfD3hOM3lQI1kbk2HQr0+S7qeqPd1LJ3RGB+W5shbM2LWs+pU6K+os9Iw8da239
 pSVlJo/3xI6VrcW9ZpAXFiUQPEs9t8AEBgwXnYwEeR3T4vPxiRu60BumZ0JzJiHKvD
 ugg2pAExl3y9GTKV9fX4mKVMlETvpoTBQxIT0NrMZDEuY//bIay/7WvIoOCS7ijF7z
 fcHkABB0oPfMQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot options
Date: Wed, 27 Nov 2024 08:06:30 +0100
Message-ID: <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
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

The bootmenu command can display

* menu entries defined by environment variables
* menu entries defined by UEFI boot options

Not in all cases showing the UEFI boot options is desired.
Provide a new parameter '-e' to select the display of UEFI boot options.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 cmd/bootmenu.c             | 39 +++++++++++++++++++++++++++++---------
 doc/usage/cmd/bootmenu.rst | 13 ++++++++++---
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index ffa63a4628d..90f4f3d583c 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -330,7 +330,13 @@ static int prepare_uefi_bootorder_entry(struct bootmenu_data *menu,
 }
 #endif
 
-static struct bootmenu_data *bootmenu_create(int delay)
+/**
+ * bootmenu_create() - create boot menu entries
+ *
+ * @uefi:	consider UEFI boot options
+ * @delay:	autostart delay in seconds
+ */
+static struct bootmenu_data *bootmenu_create(int uefi, int delay)
 {
 	int ret;
 	unsigned short int i = 0;
@@ -357,7 +363,7 @@ static struct bootmenu_data *bootmenu_create(int delay)
 		goto cleanup;
 
 #if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) && (IS_ENABLED(CONFIG_CMD_EFICONFIG))
-	if (i < MAX_COUNT - 1) {
+	if (uefi && i < MAX_COUNT - 1) {
 		efi_status_t efi_ret;
 
 		/*
@@ -481,7 +487,13 @@ static void handle_uefi_bootnext(void)
 		run_command("bootefi bootmgr", 0);
 }
 
-static enum bootmenu_ret bootmenu_show(int delay)
+/**
+ * bootmenu_show - display boot menu
+ *
+ * @uefi:	generated entries for UEFI boot options
+ * @delay:	autoboot delay in seconds
+ */
+static enum bootmenu_ret bootmenu_show(int uefi, int delay)
 {
 	int cmd_ret;
 	int init = 0;
@@ -495,7 +507,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
 	efi_status_t efi_ret = EFI_SUCCESS;
 	char *option, *sep;
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR))
+	if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) && uefi)
 		handle_uefi_bootnext();
 
 	/* If delay is 0 do not create menu, just run first entry */
@@ -514,7 +526,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
 		return (cmd_ret == CMD_RET_SUCCESS ? BOOTMENU_RET_SUCCESS : BOOTMENU_RET_FAIL);
 	}
 
-	bootmenu = bootmenu_create(delay);
+	bootmenu = bootmenu_create(uefi, delay);
 	if (!bootmenu)
 		return BOOTMENU_RET_FAIL;
 
@@ -609,7 +621,7 @@ int menu_show(int bootdelay)
 	int ret;
 
 	while (1) {
-		ret = bootmenu_show(bootdelay);
+		ret = bootmenu_show(1, bootdelay);
 		bootdelay = -1;
 		if (ret == BOOTMENU_RET_UPDATED)
 			continue;
@@ -635,11 +647,19 @@ int do_bootmenu(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char *delay_str = NULL;
 	int delay = 10;
+	int uefi = 0;
 
 #if defined(CONFIG_BOOTDELAY) && (CONFIG_BOOTDELAY >= 0)
 	delay = CONFIG_BOOTDELAY;
 #endif
 
+	if (argc >= 2) {
+		if (!strcmp("-e", argv[1])) {
+			uefi = 1;
+			--argc;
+			++argv;
+		}
+	}
 	if (argc >= 2)
 		delay_str = argv[1];
 
@@ -649,13 +669,14 @@ int do_bootmenu(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (delay_str)
 		delay = (int)simple_strtol(delay_str, NULL, 10);
 
-	bootmenu_show(delay);
+	bootmenu_show(uefi, delay);
 	return 0;
 }
 
 U_BOOT_CMD(
 	bootmenu, 2, 1, do_bootmenu,
 	"ANSI terminal bootmenu",
-	"[delay]\n"
-	"    - show ANSI terminal bootmenu with autoboot delay"
+	"[-e] [delay]\n"
+	"-e    - show UEFI entries\n"
+	"delay - show ANSI terminal bootmenu with autoboot delay"
 );
diff --git a/doc/usage/cmd/bootmenu.rst b/doc/usage/cmd/bootmenu.rst
index 294cc02b17a..cd5597bc646 100644
--- a/doc/usage/cmd/bootmenu.rst
+++ b/doc/usage/cmd/bootmenu.rst
@@ -11,7 +11,7 @@ Synopsis
 --------
 ::
 
-    bootmenu [delay]
+    bootmenu [-e] [delay]
 
 Description
 -----------
@@ -28,6 +28,14 @@ The "bootmenu" command interprets ANSI escape sequences, so
 an ANSI terminal is required for proper menu rendering and item
 selection.
 
+-e
+    show menu entries based on UEFI boot options
+
+delay
+    is the autoboot delay in seconds, after which the first
+    menu entry will be selected automatically
+
+
 The assembling of the menu is done via a set of environment variables
 "bootmenu_<num>" and "bootmenu_delay", i.e.::
 
@@ -35,8 +43,7 @@ The assembling of the menu is done via a set of environment variables
     bootmenu_<num>="<title>=<commands>"
 
 <delay>
-    is the autoboot delay in seconds, after which the first
-    menu entry will be selected automatically
+    autostart delay in seconds
 
 <num>
     is the boot menu entry number, starting from zero
-- 
2.45.2

