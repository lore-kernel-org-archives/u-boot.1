Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59677D2AB0A
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 09:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD70789177;
	Tue, 29 Oct 2024 10:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="jO17PAXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3353B88D06; Tue, 29 Oct 2024 10:47:33 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53B0889138
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 10:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: cc547ff895da11efb88477ffae1fc7a5-20241029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=M847j8gzQuF+MnBfXhKlTZAQVtgvYTwIdoxIM4ZHeac=; 
 b=jO17PAXrGj5nyGNcVJS4btOGnGtYb/Nenb7EAOAY7yjVdNWQZ3y7DKkTj00fs9pFSf995iSI9grYcWyGtvDTzaZGyIhRAyklMMR0iGHCsZ1CVUP0t4HfGRza11m80HXcMZbADzivQKkVAR/TUzIRb5x7CWpblC/IEREbi60nxFI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:c7fbb975-2aa6-4a19-bb65-dcc1a0dfe42a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:cced3707-7990-429c-b1a0-768435f03014,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cc547ff895da11efb88477ffae1fc7a5-20241029
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 545624625; Tue, 29 Oct 2024 17:47:23 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Oct 2024 17:47:21 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Oct 2024 17:47:20 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, "Daniel
 Golle" <daniel@makrotopia.org>, John Crispin <john@phrozen.org>,
 Simon Glass
 <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Martyn Welch
 <martyn.welch@collabora.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tim
 Harvey" <tharvey@gateworks.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v2 2/3] menu: add support to check if menu needs to be
 reprinted
Date: Tue, 29 Oct 2024 17:47:16 +0800
Message-ID: <7024b1fd05a36d8ce0d9a81697fef2333b85872a.1730194901.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
References: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.849700-8.000000
X-TMASE-MatchedRID: lpk7+cih7u+vFyjvf73NM47Su3QulAZ5MC4zO7d4kaPk3GeNbRoaNi7q
 WYZqSpWH09NQNrxIpFYBtjkcfRMmqRnsS71Oo/HwyeVujmXuYYVG/JUd7BvSQmq//5Ao1w8ujiO
 44HwzSiulV0yJbffB/wHcivCvo9dimllju3jrF/dIRA38P/dwbryfV74eQpk+myiLZetSf8mfop
 0ytGwvXiq2rl3dzGQ1BQgPDXiXPAzEYaUIDxxUBW8FiXRIY0RT3UKZ1Oau+QwPwlASVvWKIsC+k
 sT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.849700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B47D5C36236B710C87F3A748563D881B0A211AEFE2F844C75FF00F2CA59087992000:8
X-MTK: N
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

This patch adds a new callback named need_reprint for menu.
The need_reprint will be called before printing the menu. If the
callback exists and returns FALSE, menu printing will be canceled.

This is very useful if the menu was not changed. It can save time
for serial-based menu to handle more input data.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 boot/pxe_utils.c |  2 +-
 cmd/bootmenu.c   |  2 +-
 cmd/eficonfig.c  |  2 +-
 common/menu.c    | 11 +++++++++++
 include/menu.h   |  1 +
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index d6a4b2cb859..3ae17553c6d 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1474,7 +1474,7 @@ static struct menu *pxe_menu_to_menu(struct pxe_menu *cfg)
 	 * Create a menu and add items for all the labels.
 	 */
 	m = menu_create(cfg->title, DIV_ROUND_UP(cfg->timeout, 10),
-			cfg->prompt, NULL, label_print, NULL, NULL);
+			cfg->prompt, NULL, label_print, NULL, NULL, NULL);
 	if (!m)
 		return NULL;
 
diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index 977a04b7d76..c99605f3398 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -506,7 +506,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
 
 	menu = menu_create(NULL, bootmenu->delay, 1, menu_display_statusline,
 			   bootmenu_print_entry, bootmenu_choice_entry,
-			   bootmenu);
+			   NULL, bootmenu);
 	if (!menu) {
 		bootmenu_destroy(bootmenu);
 		return BOOTMENU_RET_FAIL;
diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index bea09e4ecc7..498653b778d 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -443,7 +443,7 @@ efi_status_t eficonfig_process_common(struct efimenu *efi_menu,
 		efi_menu->menu_desc = menu_desc;
 
 	menu = menu_create(NULL, 0, 1, display_statusline, item_data_print,
-			   item_choice, efi_menu);
+			   item_choice, NULL, efi_menu);
 	if (!menu)
 		return EFI_INVALID_PARAMETER;
 
diff --git a/common/menu.c b/common/menu.c
index 48ab7f0f398..5a2126aa01a 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -43,6 +43,7 @@ struct menu {
 	void (*display_statusline)(struct menu *);
 	void (*item_data_print)(void *);
 	char *(*item_choice)(void *);
+	bool (*need_reprint)(void *);
 	void *item_choice_data;
 	struct list_head items;
 	int item_cnt;
@@ -117,6 +118,11 @@ static inline void *menu_item_destroy(struct menu *m,
  */
 static inline void menu_display(struct menu *m)
 {
+	if (m->need_reprint) {
+		if (!m->need_reprint(m->item_choice_data))
+			return;
+	}
+
 	if (m->title) {
 		puts(m->title);
 		putc('\n');
@@ -362,6 +368,9 @@ int menu_item_add(struct menu *m, char *item_key, void *item_data)
  * item. Returns a key string corresponding to the chosen item or NULL if
  * no item has been selected.
  *
+ * need_reprint - If not NULL, will be called before printing the menu.
+ * Returning FALSE means the menu does not need reprint.
+ *
  * item_choice_data - Will be passed as the argument to the item_choice function
  *
  * Returns a pointer to the menu if successful, or NULL if there is
@@ -371,6 +380,7 @@ struct menu *menu_create(char *title, int timeout, int prompt,
 				void (*display_statusline)(struct menu *),
 				void (*item_data_print)(void *),
 				char *(*item_choice)(void *),
+				bool (*need_reprint)(void *),
 				void *item_choice_data)
 {
 	struct menu *m;
@@ -386,6 +396,7 @@ struct menu *menu_create(char *title, int timeout, int prompt,
 	m->display_statusline = display_statusline;
 	m->item_data_print = item_data_print;
 	m->item_choice = item_choice;
+	m->need_reprint = need_reprint;
 	m->item_choice_data = item_choice_data;
 	m->item_cnt = 0;
 
diff --git a/include/menu.h b/include/menu.h
index 6571c39b143..79643af272b 100644
--- a/include/menu.h
+++ b/include/menu.h
@@ -13,6 +13,7 @@ struct menu *menu_create(char *title, int timeout, int prompt,
 				void (*display_statusline)(struct menu *),
 				void (*item_data_print)(void *),
 				char *(*item_choice)(void *),
+				bool (*need_reprint)(void *),
 				void *item_choice_data);
 int menu_default_set(struct menu *m, char *item_key);
 int menu_get_choice(struct menu *m, void **choice);
-- 
2.45.2

