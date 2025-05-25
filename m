Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31814C54FB3
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 13:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5736082B6B;
	Sun, 25 May 2025 15:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUd/AMEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C2E82BA7; Sun, 25 May 2025 15:44:34 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFE582B7E
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 15:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so17371175e9.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748180672; x=1748785472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2w/9m3XS83JTE59sPoFxU3gTHYGvP+1GxXGg2yVf8k4=;
 b=JUd/AMECpiYqEwZDrwfGW4UX/dk/eP+YciPlK8Pvm7G/ePjF6HHVle/eDd03qwYnSi
 N7TK0AVQbSmoRbRG9c8Ux6/ZgBXGw5Tidj/U2etUP3BlsEI2+bd6P+fM8SGSq+TXFFTj
 WFN/WNnO2OtvmiSLbIinaJXgG3wTnDbxqLr8ifb9BY0s9yClEsUQi4DsSpntUyPn2NGc
 gPhrVyB0HOR4WUlDMjE5ZhHkrw3JLhGJKk3HG+GEL5McCMyJOqUDn0r6H944Hkyc6Ije
 birSMm/mDg84oNZ73T0TMgIFT7cqP9coKNNiA/fetx5tDGfAAhpZ43VQ9LHfX2+ZHvar
 vhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748180672; x=1748785472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2w/9m3XS83JTE59sPoFxU3gTHYGvP+1GxXGg2yVf8k4=;
 b=kX/13BG3nS3kvrUSWPOPRP4TaK0FLzwFRSKmJno0z9N1stT8iBNHmH9gwMcZdRq86X
 gtHYPbrj68qZ1+Oz9/5CY6ER8bYZPpf3x06ZHa/5xr/TCQlbF/bBLa+TLKf5KXBarksH
 UMSYG+/52BaOm16c3Fjt75o+f1vTljBB42PGzdJgVOFGy0igqJr1jwFEzEKP0gz+xZEh
 Tmndm7rMb8iOLKPxyXm1pGxOURhnT2d5yRglB+t1vyKQdL1PhXUWqsgnStW7qKndag+g
 GM7WhpUUVHpQisFwu4y64U5BQtTHGIKq9Fin+IuV4yUsOReFOkT9zh8sTrNtBmpsf+B9
 UlWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmwtGLFc26F5koEdWQZp/jTJrMR0nN399jYDO5gPD1sKRaB/m+JNzZirvxtr9BMYcbht7jyWc=@lists.denx.de
X-Gm-Message-State: AOJu0YxKjHGdqoFimP7Cw9c/obVa3DiIZeW88/T+/mrKGDprfal/ZbyZ
 YxDNb+vewN485TnxE3qLRZR3lSZ0bLaJTzZ18nR4GgEBF+Ikl4cZIv7VOcFvUg==
X-Gm-Gg: ASbGnctFZTQjf+HqoOy6II3SA6QFOdoSWGcn/nIyHWiO0/XFomr53nXdGluFCKmnjIB
 L+SItYwn/lwUyxRloOGDcTwBmb/HSVZ6LWkrcipnFS3/RNd9M9paN60wJRKStMNrwuxZfQbuslz
 WESn7cXhMh+6RfYVMWvt6ABIec6g0wvZUadEwKxYgeJ+klxXgh7816BZ7C17F7qe4IyD1lvf7HX
 5Iu5EGzTBdBarBN42MTsR0I3FJpxmI0uyM4K9+nqRMdPpHMRIa5ZHDRyp59rheAdi0s3dPwzsk/
 Tuk57AVL5XhMysqMXnpAviHuV3S8sG9FL4l+nVoxR7KpkzIqQejTdrxjIfgV2zydbLkr/CJxD3z
 RzxEkH7cuWNL30QKurpEL
X-Google-Smtp-Source: AGHT+IHQNMyY3Ep2vkjS53b+CZjDk2do3L/PM7RQHe9pFQq1BSCr6hPWxkoOFC16vGBY6b1iHOHvRw==
X-Received: by 2002:a05:600c:314b:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-44c932f93c5mr48021595e9.26.1748180671562; 
 Sun, 25 May 2025 06:44:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a4d15523a9sm2974282f8f.72.2025.05.25.06.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 06:44:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v2] cmd: bootmenu: permit to select bootmenu entry with a
 shortcut
Date: Sun, 25 May 2025 15:43:58 +0200
Message-ID: <20250525134407.3760-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Permit to select a bootmenu entry with a key shortcut. This is
especially useful in production or testing scenario to automate flashing
procedure or testing procedure.

The boot entry are changed to append the shortcut key to it.

Example:
      1. Run default boot command.
      2. Boot system via TFTP.
      3. Boot production system from NAND.
      4. Boot recovery system from NAND.
      5. Load production system via TFTP then write to NAND.
      6. Load recovery system via TFTP then write to NAND.
      7. Load BL31+U-Boot FIP via TFTP then write to NAND.
      8. Load BL2 preloader via TFTP then write to NAND.
      9. Reboot.
      a. Reset all settings to factory defaults.
      0. Exit

0 is always reserved for Exit to console.
On pressing the keyboard key 2, the bootmenu entry 2 is selected and
executed.

Up to 34 key shortcut (0 excluded as reserved) are supported from 1-9
and a-z.
If a shortcut key not present in the bootmenu list is pressed, it is
simply ignored and eventually the autoboot is interrupted.

Capital A-Z are converted to lower a-z and the related option is
selected.

Suggested-by: Weijie Gao <weijie.gao@mediatek.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Fix spelling mistake
- Fix case with '0'

 cmd/bootmenu.c | 41 ++++++++++++++++++++++++++++++++++++++---
 common/menu.c  | 44 ++++++++++++++++++++++++++++++++++++++++++--
 include/cli.h  |  2 ++
 include/menu.h |  3 +++
 4 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index a5c979079f4..d3108778c6f 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -114,6 +114,14 @@ static char *bootmenu_choice_entry(void *data)
 				++menu->active;
 			/* no menu key selected, regenerate menu */
 			return NULL;
+		case BKEY_SHORTCUT:
+			/* invalid shortcut, regenerate menu */
+			if (cch->shortcut_key >= menu->count - 1)
+				return NULL;
+			/* shortcut_key value for Exit is is -1 */
+			menu->active = cch->shortcut_key < 0 ? menu->count - 1 :
+							       cch->shortcut_key;
+			fallthrough;
 		case BKEY_SELECT:
 			iter = menu->first;
 			for (i = 0; i < menu->active; ++i)
@@ -161,6 +169,21 @@ static void bootmenu_destroy(struct bootmenu_data *menu)
 	free(menu);
 }
 
+static char bootmenu_entry_shortcut_key(int index)
+{
+	switch (index) {
+	/* 1-9 shortcut key (0 reserved) */
+	case 0 ... 8:
+		return '1' + index;
+	/* a-z shortcut key  */
+	case 9 ... 34:
+		return 'a' + index - 9;
+	/* We support shortcut for up to 34 options (0 reserved) */
+	default:
+		return -ENOENT;
+	}
+}
+
 /**
  * prepare_bootmenu_entry() - generate the bootmenu_xx entries
  *
@@ -184,6 +207,8 @@ static int prepare_bootmenu_entry(struct bootmenu_data *menu,
 	struct bootmenu_entry *iter = *current;
 
 	while ((option = bootmenu_getoption(i))) {
+		char shortcut_key;
+		int len;
 
 		/* bootmenu_[num] format is "[title]=[commands]" */
 		sep = strchr(option, '=');
@@ -196,12 +221,22 @@ static int prepare_bootmenu_entry(struct bootmenu_data *menu,
 		if (!entry)
 			return -ENOMEM;
 
-		entry->title = strndup(option, sep - option);
+		/* Add shotcut key option: %c. %s\0 */
+		len = sep - option + 4;
+
+		entry->title = malloc(len);
 		if (!entry->title) {
 			free(entry);
 			return -ENOMEM;
 		}
 
+		shortcut_key = bootmenu_entry_shortcut_key(i);
+		/* Use emtpy space if entry doesn't support shortcut key */
+		snprintf(entry->title, len, "%c%c %s",
+			 shortcut_key > 0 ? shortcut_key : ' ',
+			 shortcut_key > 0 ? '.' : ' ',
+			 option);
+
 		entry->command = strdup(sep + 1);
 		if (!entry->command) {
 			free(entry->title);
@@ -388,9 +423,9 @@ static struct bootmenu_data *bootmenu_create(int uefi, int delay)
 
 		/* Add Quit entry if exiting bootmenu is disabled */
 		if (!IS_ENABLED(CONFIG_BOOTMENU_DISABLE_UBOOT_CONSOLE))
-			entry->title = strdup("Exit");
+			entry->title = strdup("0. Exit");
 		else
-			entry->title = strdup("Quit");
+			entry->title = strdup("0. Quit");
 
 		if (!entry->title) {
 			free(entry);
diff --git a/common/menu.c b/common/menu.c
index 5a2126aa01a..ae5afa14766 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -8,6 +8,7 @@
 #include <cli.h>
 #include <malloc.h>
 #include <errno.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <linux/list.h>
 #include <watchdog.h>
@@ -436,6 +437,29 @@ int menu_destroy(struct menu *m)
 	return 1;
 }
 
+static int bootmenu_conv_shortcut_key(struct bootmenu_data *menu, int ichar)
+{
+	int shortcut_key;
+
+	ichar = tolower(ichar);
+	switch (ichar) {
+	/* a-z for bootmenu entry > 9 */
+	case 'a' ... 'z':
+		shortcut_key = ichar - 'a' + 9;
+		break;
+	/* 1-9 for bootmenu entry <= 9 */
+	case '1' ... '9':
+		shortcut_key = ichar - '1';
+		break;
+	/* Reserve 0 for last option (aka Exit) */
+	case '0':
+	default:
+		return -1;
+	}
+
+	return shortcut_key;
+}
+
 enum bootmenu_key bootmenu_autoboot_loop(struct bootmenu_data *menu,
 					 struct cli_ch_state *cch)
 {
@@ -443,12 +467,12 @@ enum bootmenu_key bootmenu_autoboot_loop(struct bootmenu_data *menu,
 	int i, c;
 
 	while (menu->delay > 0) {
+		int ichar;
+
 		if (ansi)
 			printf(ANSI_CURSOR_POSITION, menu->count + 5, 3);
 		printf("Hit any key to stop autoboot: %d ", menu->delay);
 		for (i = 0; i < 100; ++i) {
-			int ichar;
-
 			if (!tstc()) {
 				schedule();
 				mdelay(10);
@@ -470,6 +494,11 @@ enum bootmenu_key bootmenu_autoboot_loop(struct bootmenu_data *menu,
 			case 0x3: /* ^C */
 				key = BKEY_QUIT;
 				break;
+			case 'A' ... 'Z':
+			case 'a' ... 'z':
+			case '0' ... '9':
+				key = BKEY_SHORTCUT;
+				break;
 			default:
 				key = BKEY_NONE;
 				break;
@@ -477,6 +506,9 @@ enum bootmenu_key bootmenu_autoboot_loop(struct bootmenu_data *menu,
 			break;
 		}
 
+		if (key == BKEY_SHORTCUT)
+			cch->shortcut_key = bootmenu_conv_shortcut_key(menu, ichar);
+
 		if (menu->delay < 0)
 			break;
 
@@ -524,6 +556,11 @@ enum bootmenu_key bootmenu_conv_key(int ichar)
 	case ' ':
 		key = BKEY_SPACE;
 		break;
+	case 'A' ... 'Z':
+	case 'a' ... 'z':
+	case '0' ... '9':
+		key = BKEY_SHORTCUT;
+		break;
 	default:
 		key = BKEY_NONE;
 		break;
@@ -554,5 +591,8 @@ enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
 
 	key = bootmenu_conv_key(c);
 
+	if (key == BKEY_SHORTCUT)
+		cch->shortcut_key = bootmenu_conv_shortcut_key(menu, c);
+
 	return key;
 }
diff --git a/include/cli.h b/include/cli.h
index e183d561369..453e88fa96d 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -17,12 +17,14 @@
  * @esc_save: Escape characters collected so far
  * @emit_upto: Next index to emit from esc_save
  * @emitting: true if emitting from esc_save
+ * @shortcut_key: Selected shortcut option index
  */
 struct cli_ch_state {
 	int esc_len;
 	char esc_save[8];
 	int emit_upto;
 	bool emitting;
+	int shortcut_key;
 };
 
 /**
diff --git a/include/menu.h b/include/menu.h
index 6cede89b950..54ff3b2e17a 100644
--- a/include/menu.h
+++ b/include/menu.h
@@ -54,6 +54,9 @@ enum bootmenu_key {
 	BKEY_QUIT,
 	BKEY_SAVE,
 
+	/* shortcut key to select menu option directly */
+	BKEY_SHORTCUT,
+
 	/* 'extra' keys, which are used by menus but not cedit */
 	BKEY_PLUS,
 	BKEY_MINUS,
-- 
2.48.1

