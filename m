Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DBBD2AB0E
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 09:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DB389138;
	Tue, 29 Oct 2024 10:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="no/hkgTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F59F89169; Tue, 29 Oct 2024 10:47:34 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA7FE8914D
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 10:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: cdfc9d4a95da11efb88477ffae1fc7a5-20241029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=SnzhggY9G4JLEKLAEEAsWpDGMudAOpyQbSQpSM9LB4g=; 
 b=no/hkgTyjIWoeB0jEIv2WTWU2oPkt0RuU/K64ufyBSdBLxXqWEW5IkrvCV/JEuBHeqZyuBj0ujdDkaYLkWQlFrdMrUSp9xhkAz3b8d8vVkMS/cRDHTdqJUc9aO6LkUiP1xf2PH5syq7Fwcz2LFWw0Ph5rfvTqkFQWj8yrd79ac8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:80733eb8-a5eb-4c2c-b013-61ac38ae79d3, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:16245d48-ca13-40ea-8070-fa012edab362,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cdfc9d4a95da11efb88477ffae1fc7a5-20241029
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 716569030; Tue, 29 Oct 2024 17:47:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Oct 2024 17:47:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Oct 2024 17:47:24 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, Daniel
 Golle <daniel@makrotopia.org>, John Crispin <john@phrozen.org>, Simon Glass
 <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH v2 3/3] bootmenu: add reprint check
Date: Tue, 29 Oct 2024 17:47:22 +0800
Message-ID: <bcc2bfd8917197707929bd1aa86d8012a7675a66.1730194901.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
References: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Record the last active menu item and check if it equals to the
current selected item before reprint.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 cmd/bootmenu.c | 16 +++++++++++++++-
 include/menu.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
index c99605f3398..ffa63a4628d 100644
--- a/cmd/bootmenu.c
+++ b/cmd/bootmenu.c
@@ -103,11 +103,13 @@ static char *bootmenu_choice_entry(void *data)
 
 		switch (key) {
 		case BKEY_UP:
+			menu->last_active = menu->active;
 			if (menu->active > 0)
 				--menu->active;
 			/* no menu key selected, regenerate menu */
 			return NULL;
 		case BKEY_DOWN:
+			menu->last_active = menu->active;
 			if (menu->active < menu->count - 1)
 				++menu->active;
 			/* no menu key selected, regenerate menu */
@@ -133,6 +135,17 @@ static char *bootmenu_choice_entry(void *data)
 	return NULL;
 }
 
+static bool bootmenu_need_reprint(void *data)
+{
+	struct bootmenu_data *menu = data;
+	bool need_reprint;
+
+	need_reprint = menu->last_active != menu->active;
+	menu->last_active = menu->active;
+
+	return need_reprint;
+}
+
 static void bootmenu_destroy(struct bootmenu_data *menu)
 {
 	struct bootmenu_entry *iter = menu->first;
@@ -332,6 +345,7 @@ static struct bootmenu_data *bootmenu_create(int delay)
 
 	menu->delay = delay;
 	menu->active = 0;
+	menu->last_active = -1;
 	menu->first = NULL;
 
 	default_str = env_get("bootmenu_default");
@@ -506,7 +520,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
 
 	menu = menu_create(NULL, bootmenu->delay, 1, menu_display_statusline,
 			   bootmenu_print_entry, bootmenu_choice_entry,
-			   NULL, bootmenu);
+			   bootmenu_need_reprint, bootmenu);
 	if (!menu) {
 		bootmenu_destroy(bootmenu);
 		return BOOTMENU_RET_FAIL;
diff --git a/include/menu.h b/include/menu.h
index 79643af272b..6cede89b950 100644
--- a/include/menu.h
+++ b/include/menu.h
@@ -40,6 +40,7 @@ int menu_show(int bootdelay);
 struct bootmenu_data {
 	int delay;			/* delay for autoboot */
 	int active;			/* active menu entry */
+	int last_active;		/* last active menu entry */
 	int count;			/* total count of menu entries */
 	struct bootmenu_entry *first;	/* first menu entry */
 };
-- 
2.45.2

