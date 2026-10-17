Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE3BCCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B75FE409C0;
	Sat, 17 Oct 2026 13:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbNcVdO_NsnS; Sat, 17 Oct 2026 13:01:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E3BD409E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242105;
	b=TLmfaJyMnm2xoNTtiOCYBdWhU0vrcAG9Qo5/GpknjavsShBFV/SCN9RMLAeMT6XuOygK
	 olRFQpPQiZOfJxRYx/LfJ2GAEsxyrJELp3ocMZ0pNi5zlTX6j3JGlYxw+I0L9YhB9E+xj
	 utqlo2BCq7jUKEkAy8vjigJAhq31xmldf1wvRx/Rck46IISOX++S5BpvmUtgXsxcnfNPZ
	 kreRu+rGzwytDm9MNE+25TELWX/s3yw+bDrJbbT1+V9akfC9O37lIETP4GPdUScQ4FpdB
	 qmmcFaHPf2y/irP+w1KK2aLUzE8c+IxwQkNqenPu9V5ndLE4LQ1k3swXmFep0Hc+q3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=l8TUy2l9onQA47b4xXwnpOGUOwiqVzf6Hb1I9fHmQyU=;
	b=SYz0dNm/ELZ5eERVW+B1shzS2t6xGYe1WPZ6ogWDwy/AsKi6Gd4Cm1fxTn1xk9ChSfEW
	 0SgldomAG5aain/NWP8K/nF3Ezbh8XJMY48Gc9N1Ejjcrj/LHTRKbBffo7FGigHPQqerw
	 DZ7MALDgfve2LMzMLuQCks86VVdbF5tWdnIBHjS7WHxCb7Lt3CroR7I3HatqFQkRu4tBp
	 G2LAvL4atqQn98eWjl+IqjAWQHQQM7za7fZ+ypfCctQ62RL+JmqAj3YhqKYtGfTrOBquZ
	 hc2iX1QkHHSwHWmBZuUuUdcwwWXz70daU35dup3+9v+1SRlX8Hwh95Er2Dlfby2PUfA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242105;
	bh=l8TUy2l9onQA47b4xXwnpOGUOwiqVzf6Hb1I9fHmQyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=LnUcDF10r+V+4mFoJD1C2l52o/TCMwz/kxmcSMuysbm2ejwF/+LsnD3BOeMaUCN6z
	 T95maWfzSGG3PRupGcoDiI3paucDXq6qV7PyxG+dLmXKnps8BdvI3K0zdud2bzGidB
	 gwZ2xxYooBjHbyrTDBILkgrzC9Hb3U2LFAsvARhk4FwK/vtiZTSZKURblpb8PJh4Y3
	 DIEV7k57Ev68Av0UwqWHSA2OVY5PbqU8Xfrc8wObs3hnp3z1FIhfSXXSPh/XKFUr9l
	 dkYnUccfa5bR8O4O/ytzN1LiwW0mX8TxFZZ/PzVhSTs/svjhUl4rj66U9CIFbBNwkZ
	 0z3PBKYt6kPDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E3BD409E6;
	Sat, 17 Oct 2026 13:01:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42E35362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27FAD607E8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9WF_pxYnZfHO for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3AF80605CA
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=f0tT4RS6bQIxeKx6JpFa+VMP5+8B+ntgyCuriAzgRFwqikFyfGVW0PTvaYFmPV6rUA1e
 7RoprXY7cHVniQ3DYS/RugKLEyLrARJRgNTCqKpA0VINjvg9yoIi0xnA3Cippo8bfidmK
 lMOL5T5XnDtrUus7D/UXGBcvZt5SDzSCaHL5HbIs4HLOBlQu9Wpna2Euc26gjK768Mklb
 1OnUyjR7Z251qobx0Z7HNHJnVlyaTFFWJFgXER8qXFwv8zuhzu2XCfFV6yJ8P8uM+8mUQ
 wPEM6sGHaXNkvheZAz7Irj3yiThe7g6IscHGNy4MAN0Fdhq+RbBc62hAmwcKvEB7hGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=l8TUy2l9onQA47b4xXwnpOGUOwiqVzf6Hb1I9fHmQyU=;
 b=Lnkg+c5ZXBXPcfbjV2DStoN4LA5x3mBFYeqxCWsL6E78n7fDeAbheu5ixPVM1/nTvDKQ
 l1V4U40TezqsCTmdNS2nW9dAtzGHiRrhDyNZ2IiCDrOxJxYsejV0WI0Dx6voiMaesvBU+
 PDs6rfxmZPjzxndi75kUc1MSPlBTAy+DxJZxnm/FVE+2EW3AWUn3KDxnVCkPTtkZGNGY2
 6Lr4UFxmSBe5BS7+hH5azmL+Dr4HO4oTTlqoosn8TeuQhyjxwLijmpoM5SdrjHIs74efP
 ODuEOtvl/HoEFgHz9wOhHXrZxnzPnCuchu4Qi1xePsknDviCCZy8wAkzjRmnivGbxFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=J6w2JuH3; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=J6w2JuH3
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3AF80605CA
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BC9943AB9;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A88FC2BCFC;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=9SnKcQeml0ebmL+zoWDttKtsYf0G8EBCXndb2/0v0n0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=J6w2JuH31tkakmrQp0CBBU3qXW5slxN+2B/biLHoI0sSJlyTw5tC2bnw4Xwsua2sv
 cCvud9QGV6cFbW0MOi+oipa0i0r6VEcDwibFkZQfoZMXi2DtFRGK97q5L8urqDk3Bk
 FWdOxsMLNP5q9Wqvp2z4cGPK+B3036f3UIw1pY2YbsTStD3N7mXatUoel6lRUAaYbA
 6FXX8C9eqN53ichz3pzW0cxepnKx/irIS2/m0T0kyCK+lMRAqzBhHwW6X38svGJQmR
 jjZai16Tjxy/n8TKJObru/DOWqej9ejJu+LpIYOnqzVdYhOWTnqcMdkQcCsKpTVEAB
 E5C7or6hIFs3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EEE96CCF2C7;
 Sat, 17 Oct 2026 09:10:26 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:17 +0200
Subject: [PATCH 01/14] expo: Add section headers to menus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-1-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
In-Reply-To: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228224; l=4158;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=hp4TfbV9qOLml3czJGjCQePcM+zDAQKZ4nr9rlvyC3U=;
 b=w3qyqQfwNG4envoYLYIypOLBUDp96jq631ji6+5zYTsGHcm+kVjumQMCnduZaH6YZupY96Ecx
 wvGe1g//O+ZCdsRUAQx3XskBDcBMF5a5zpBbwGfSJpiYhNZk25ha9e/
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add SCENEMIF_HEADER a menu item flag for an item which is laid out and
shown like any other but is never highlighted or selected.

Up/down skip over it the initial selection skips it and
scene_menu_select_item() refuses it.

This lets a menu group its items under titles.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/scene_menu.c    | 21 +++++++++++++++++----
 doc/develop/expo.rst |  4 ++++
 include/expo.h       |  2 ++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 23404172093..77d25f34da3 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -277,7 +277,7 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 			y += height;
 
 		/* select an item if not done already */
-		if (!sel_id)
+		if (!sel_id && !(item->flags & SCENEMIF_HEADER))
 			sel_id = item->id;
 
 		selected = sel_id == item->id;
@@ -361,6 +361,8 @@ static struct scene_menitem *scene_menu_find_key(struct scene *scn,
 	struct scene_menitem *item;
 
 	list_for_each_entry(item, &menu->item_head, sibling) {
+		if (item->flags & SCENEMIF_HEADER)
+			continue;
 		if (item->key_id) {
 			struct scene_obj_txt *txt;
 			const char *str;
@@ -401,22 +403,28 @@ int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
 
 	switch (key) {
 	case BKEY_UP:
-		if (item != list_first_entry(&menu->item_head,
-					     struct scene_menitem, sibling)) {
+		while (item != list_first_entry(&menu->item_head,
+						struct scene_menitem, sibling)) {
 			item = list_entry(item->sibling.prev,
 					  struct scene_menitem, sibling);
+			if (item->flags & SCENEMIF_HEADER)
+				continue;
 			event->type = EXPOACT_POINT_ITEM;
 			event->select.id = item->id;
 			log_debug("up to item %d\n", event->select.id);
+			break;
 		}
 		break;
 	case BKEY_DOWN:
-		if (!list_is_last(&item->sibling, &menu->item_head)) {
+		while (!list_is_last(&item->sibling, &menu->item_head)) {
 			item = list_entry(item->sibling.next,
 					  struct scene_menitem, sibling);
+			if (item->flags & SCENEMIF_HEADER)
+				continue;
 			event->type = EXPOACT_POINT_ITEM;
 			event->select.id = item->id;
 			log_debug("down to item %d\n", event->select.id);
+			break;
 		}
 		break;
 	case BKEY_SELECT:
@@ -529,12 +537,17 @@ int scene_menu_set_pointer(struct scene *scn, uint id, uint pointer_id)
 int scene_menu_select_item(struct scene *scn, uint id, uint cur_item_id)
 {
 	struct scene_obj_menu *menu;
+	const struct scene_menitem *item;
 	int ret;
 
 	menu = scene_obj_find(scn, id, SCENEOBJT_MENU);
 	if (!menu)
 		return log_msg_ret("menu", -ENOENT);
 
+	item = scene_menuitem_find(menu, cur_item_id);
+	if (item && (item->flags & SCENEMIF_HEADER))
+		return log_msg_ret("hdr", -EINVAL);
+
 	ret = menu_point_to_item(menu, cur_item_id);
 	if (ret)
 		return log_msg_ret("msi", ret);
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index b94340e9a8d..9c33284c9aa 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -63,6 +63,10 @@ select the item), label and description. All three are shown in a single line
 within the menu. Items can also have a preview image, which is shown when the
 item is highlighted.
 
+A menu item flagged `SCENEMIF_HEADER` is a section header. It is laid out and
+shown like any other item, however, it is never highlighted or selected so the
+user can only move between the items around it.
+
 A `textline object` contains a label and an editable string.
 
 A `box object` is a rectangle with a given line width. It is not filled.
diff --git a/include/expo.h b/include/expo.h
index 4dee479e9a0..3127b4fd5f2 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -405,9 +405,11 @@ struct scene_obj_menu {
  * enum scene_menuitem_flags_t - flags for menu items
  *
  * @SCENEMIF_GAP_BEFORE: Add a gap before this item
+ * @SCENEMIF_HEADER: Item is a section header (shown but never selectable)
  */
 enum scene_menuitem_flags_t {
 	SCENEMIF_GAP_BEFORE	= 1 << 0,
+	SCENEMIF_HEADER		= 1 << 1,
 };
 
 /**

-- 
2.55.0


