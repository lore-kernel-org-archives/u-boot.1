Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62E2C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 22:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC7F82BD6;
	Sun, 25 May 2025 00:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TdfU+ORL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967FD82CD2; Sun, 25 May 2025 00:13:54 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A1A82AC4
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 00:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a367ec7840so765278f8f.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748124832; x=1748729632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ia7G/soHyr/fzI1ExQMDO/+JzV+OkeKCYNMpxELU8o8=;
 b=TdfU+ORLus+wAL3BUvsiWcRMtEWm8VRVV/ynGS8y8QxI5AUx4MbjUxqbOO7QjB794y
 tgk2Tkbyv5byeR6zwoZK9UtShr95lVNylvjcQoScS10dYoWTeux82O2dWIZsMqoMDMv+
 rSki6TdAWidorYZ3P9rRKFpyup0SmyUEI0Nt2ahzQjhwu/VZaRjQDYVjtU9B6CmGNieV
 kBPpx22tPPtjQj0vn4xVc+GntTc5VMoEIoYzfMNR/kO/9yTtwsU1LDZqEy5Fv9pRdeBA
 ngNk4Wl7OLcn+F02M2MQzs2Gk030y/TD42sEq+7QIiJ0qa6dYEWc2BTZGGihJzD6ML5Y
 J63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748124832; x=1748729632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ia7G/soHyr/fzI1ExQMDO/+JzV+OkeKCYNMpxELU8o8=;
 b=jdAIInZzYfOl6oIZdBy2VmGz5MtqP/MfgBNJyE7i0OBO+C81+Cm87LexzJdwmRyqCs
 FJElua1ChEn1+ogrUKy7Ccnp7UyG3QTZEQwI2fDHxHnP+CPF6CdnB/+kbxBB55L8ivXm
 symRS9vRpVhBpBmdMqdRKa+re4M/4Q4HehgKcm+SHEqQYWL/He07HH8HDPhBW04Ph9cZ
 h3pQkTHbpdc5UHMiXjoXVzl+NypdumKX03PRu21chvnQH6iTBgrQ+SA1UyeYJKw5wG94
 v68b8KkPTmWgL+Gsx/7k/5zJ6odhbDmdSh/7So4zzSU7TDiX8OR9eBl7Vo64bfad41Ct
 PhfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX4wVBXETjhN3yFQ1lUT7wc2M7ZFks83+WslDUxdsSRiUUhffp9Pbr3HFSHNV3qC+RDaM1Wn0=@lists.denx.de
X-Gm-Message-State: AOJu0YxhJPboZZBnWZESSfRqxrpWjF4qYyp5qAz/GZsPGMG//XavMOk7
 ROWHycHb68ChUn5jNGB8DPLbUjz4NjP1Nsn2HsKKnHdPgi2AMSB25soc
X-Gm-Gg: ASbGncuGR4YgoOIKSudG1M1aSf95lBMPu0rc9kGhWxKsUvWPvO2co3uTnvhx2oep0j/
 lvnuDXcNY0j/U0ncLC6ClzUrcNxSMOvdTiaj07BG44IP+KEetPtIrUVWpAzAfGai2/948In07Br
 mU0on2vfgrJLjf66aL5eBoJxyc3yIh8WuYokLjTyTjoYd/ShbVL8gnLW3ruvp7ESZnGVCqQzfml
 c8UT5sAVElkkJovHtQniZJcGwGGC3XgsV+nJSrf5dyi/Swns92Z+S5MM7nXi5k/0Y4RpU/7S9rA
 vjKeMDuOw53itu7ahAnoMbawPZNW5/+HBSrAwCGZdbQRimkb3tswo2LkITZeqznZE2iA5eieEea
 GDTw3/Y/ut27J38VCJup4HxRpdNSiYLA=
X-Google-Smtp-Source: AGHT+IGhkeSBgdKwyPu3a2pxAhsZkLtvqmcIVVnmWR21n4hw6JjFhvXa59N3b6LD2SJKj2vHakxKXg==
X-Received: by 2002:a05:6000:1ac6:b0:3a3:4bb4:7357 with SMTP id
 ffacd0b85a97d-3a4cb4b8e7fmr3226979f8f.37.1748124831615; 
 Sat, 24 May 2025 15:13:51 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-447f78aeb7fsm184738965e9.26.2025.05.24.15.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 15:13:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] cmd: bootmenu: permit to select bootmenu entry with a shortcut
Date: Sun, 25 May 2025 00:12:52 +0200
Message-ID: <20250524221313.10249-1-ansuelsmth@gmail.com>
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
especially useful in production or testing scenario to aitomate flashing
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
 cmd/bootmenu.c | 39 ++++++++++++++++++++++++++++++++++++---
 common/menu.c  | 44 ++++++++++++++++++++++++++++++++++++++++++--
 include/cli.h  |  2 ++
 include/menu.h |  3 +++
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index a5c979079f4..d060cda0ea6 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -114,6 +114,12 @@ static char *bootmenu_choice_entry(void *data)
 				++menu->active;
 			/* no menu key selected, regenerate menu */
 			return NULL;
+		case BKEY_SHORTCUT:
+			/* invalid shortcut, regenerate menu */
+			if (cch->shortcut_key >= menu->count - 1)
+				return NULL;
+			menu->active = cch->shortcut_key;
+			fallthrough;
 		case BKEY_SELECT:
 			iter = menu->first;
 			for (i = 0; i < menu->active; ++i)
@@ -161,6 +167,21 @@ static void bootmenu_destroy(struct bootmenu_data *menu)
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
@@ -184,6 +205,8 @@ static int prepare_bootmenu_entry(struct bootmenu_data *menu,
 	struct bootmenu_entry *iter = *current;
 
 	while ((option = bootmenu_getoption(i))) {
+		char shortcut_key;
+		int len;
 
 		/* bootmenu_[num] format is "[title]=[commands]" */
 		sep = strchr(option, '=');
@@ -196,12 +219,22 @@ static int prepare_bootmenu_entry(struct bootmenu_data *menu,
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
@@ -388,9 +421,9 @@ static struct bootmenu_data *bootmenu_create(int uefi, int delay)
 
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
index 5a2126aa01a..b78c2208b8b 100644
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
+	/* Reserve 0 for last option (aka Console) */
+	case '0':
+	default:
+		return menu->count - 1;
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

