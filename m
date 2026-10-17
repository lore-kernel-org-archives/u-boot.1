Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C117CCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54AD9813FC;
	Sat, 17 Oct 2026 13:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uxes5fuGTn4n; Sat, 17 Oct 2026 13:01:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6EC5381493
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242113;
	b=d8KrTIyatFljlWuHaPV0RoTqGjBg/xU90UBLEbKIUrLhDqNowOU6YPv8rdRK+ELRCPh0
	 bxAqJPylrUdHEEEcJbJuRZNSyhZrhfBphLOVL0VKD6+lyCrbX2Z14VNNqW8xNXeeiuaIX
	 F6uXrxS1tF9UpU1Ts+xU/VHVCgSvdKn+WQtG8Nz7Ds3s3OHXktZtZoCvZD0gSNbR8c3Pb
	 PgS+KZAsQDpu4D7c9wmP+dRCeJcVYhOGmXAmRRRCCbGbABlW2RHuwbkrhuxQSNkkyq3mB
	 XIu2y5MeAa1LBfBVgzp7wYI86tGKSfq5yFQBkJnjqaEQeH6EvXwKLVlPDOqxtZpsuFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=VW8UHBP/YfPshnpK/QwpvYZHvotkxd9gQlF2ISiow44=;
	b=mK0Dn/N5oxZtdLP2GsJjDh3M57PBBJLywQhp81BuVQUxxy2D1IIkITBkbzTahKdGlBqE
	 mlkUxEOg6fHT0PN/woei6DJuMLrGPD1gH69j6BDSsQUX/ygommzCWojCydyprNaUvrC4k
	 Cpvcedg8sRmKvzTeGwsoPAwX6uqm9xj5Wiq48X1q+HsmmTs634awRFhM5s8As14oBsKgB
	 SrZ05Ci+r3XRNj4xc5zWnu1vCnt+UaF7QQ+e/udqI1I8klBcRrSk1wbyL78QG/7OsywJS
	 HCSI+ZxC0E4noYsfFseja6UZsEF8CRSLPRq7xZvdHEUOoNkQd3GAGiwFf/zfGPR4qAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tKevEc1w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242113;
	bh=VW8UHBP/YfPshnpK/QwpvYZHvotkxd9gQlF2ISiow44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Li78To66SI1zgrC9fymR/uOSqlvu9OlhQkapFln08NH1VT8b3F15ZwS9urnPpG4et
	 zYTtKmo2cs4xAIANsByjq7x9wzdcit2AVl3O6pa3p+aN6dT5BhVs8Qes95nuj2p899
	 2dC6EbLzhzrwxm6gwwyE6X2nWskcmtDCzhfWVBw2CZyIr5KqNe0dGWH8WAqVtZy3du
	 XI6W0lqnAz91EnoQf3wYJ052htjInkvCqhXYESerIYtF66rME8oRn1kSun0zuBZDpR
	 340H0STFeox5m2z5/tBqfut2rVc5SU+UTgY6nYt7/9m7BK1iwtHIzjp4s0m45HIp3b
	 Sm6NLQ7WVru5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EC5381493;
	Sat, 17 Oct 2026 13:01:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FE84151A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7215D81496
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-3JrmGG5REA for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 92B4281499
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=a5gjl4SH9fxvyu/VRtwer9xBBmev5ZAbnakWZNYC0s1XSInWPBezzM7Uw4J9rmjyXwIn
 yBJYcvJEJI4n3JflgD5WqL4zrhZtlw2sXLOd+Xbk6RvOz+N643Fg1nM18ZES8LTxW1Xcr
 Z5VeIjZZxMH6icuOFxXWSOzW5W9Q5hwoUbiYgqzc5HNA85HEyOAm9h4pGWAhwFUmbz+dQ
 lNNtURewmpWONHt0Wn2Ds6hdgyy5MphKC28ZoFtlPvZzbZHfHNz+ezSlo9IfEQXMUR/2j
 2RW4xyzvKLBEUyy33an9TMUNSZpTAIZ6hB78Wy0gOioppYSQ5/xA9B0Y+86pMD7iEHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=VW8UHBP/YfPshnpK/QwpvYZHvotkxd9gQlF2ISiow44=;
 b=klkX5sAp6qrfAVD+UtRU+xNZdKKg7j0IeVFd4cdndHku7HY3+eXFOep75OITgF5n6Jpw
 yXhI7hxt5FhrzCptCgIfErfxcwx5u9mGZhfTr/K797JWXkE+1ZA/qlBaS0TMJImiL6N2c
 o2CSWMK22CKC77xVUvw1pBf5hCRW+1Sau8Xa4PbnPh1uPZCmd1cVgliO5GVhd/1bu1ot0
 R0SZL4FpVZgieU0xCrdhduUR0sLyyMX+onloe0IT8Zpjr9Y16UyjKNstNc0X8o4gQu0Re
 0LI9K18MTnlZbwq95rsK6Zylkpk1iPEhtZovmJKg2ZqCYXm7wiaOObUMB/sy0U1I3tw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tKevEc1w; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tKevEc1w
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92B4281499
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 979E060A9D;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BFCFC2BCFC;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=A5fRKS1QRLqasjnFrfNDxECuIDSpq66HNh9XM8XJg2U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tKevEc1wq8FGkd7gEjx4E12WCsQKQRiE3LtFOuiupdvn89Sx9+hyr3K4nRHh1CCdU
 egOuDlg4q2Ghb/wZkkTjqJ0fk74ahV9tVOTGO02hDZ9laeLel4d+koHMJAiH4xbBAn
 05k/V1YOuoYptMakMlcZEJrTJCQirxeSRk4zfzVimBcG+jsXNGsdtfCs5Ya69jNyuR
 b7S4YAPnTHl2Loj4hKDHVPnPXJcpWSvlb0/a4y1MSA/DCneS26kKsWRYi9N6FmWaIJ
 K4fG85/FEOSD48/9zb/x3x2SM0afjqJdU9yojHY4tubwddLFHCF6aMTmdBhSMDovpB
 ijbvQJLUrZ14g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F9CCF2CC;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:20 +0200
Subject: [PATCH 04/14] expo: Allow menus to wrap around
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-4-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=4945;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=aFSwbOJj+Rnn0fSwerqsVz5zwUFs6TBz4jMuEhr+ojU=;
 b=eiQxeRYYI4T1tcP71XgfpN3GJDf5nUr7OMdv8W0MNXJTxfFJptaiB1rK1Pckk1LZTrrlaK4jU
 Xl5djhYrEouD0NxZxeLiHDA93KsDRnRSSjIWWTeODjUmBihn44vZNs+
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

Add scene_menu_set_wrap() so that pressing down on the last selectable
item moves to the first and up on the first moves to the last.

Move the search for the next item into a helper which also skips
section headers.

This is off by default so existing menus behave as before.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/scene_menu.c    | 53 +++++++++++++++++++++++++++++++++++++++-------------
 doc/develop/expo.rst |  3 +++
 include/expo.h       | 14 ++++++++++++++
 3 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 77d25f34da3..8ec2155e75c 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -379,6 +379,29 @@ static struct scene_menitem *scene_menu_find_key(struct scene *scn,
 	return NULL;
 }
 
+static struct scene_menitem *menu_step(const struct scene_obj_menu *menu,
+				       const struct scene_menitem *cur, bool down)
+{
+	const struct list_head *head = &menu->item_head;
+	const struct list_head *pos = &cur->sibling;
+
+	for (;;) {
+		struct scene_menitem *item;
+
+		pos = down ? pos->next : pos->prev;
+		if (pos == head) {
+			if (!menu->wrap)
+				return NULL;
+			pos = down ? head->next : head->prev;
+		}
+		item = list_entry(pos, struct scene_menitem, sibling);
+		if (item == cur)
+			return NULL;
+		if (!(item->flags & SCENEMIF_HEADER))
+			return item;
+	}
+}
+
 int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
 			struct expo_action *event)
 {
@@ -403,28 +426,19 @@ int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
 
 	switch (key) {
 	case BKEY_UP:
-		while (item != list_first_entry(&menu->item_head,
-						struct scene_menitem, sibling)) {
-			item = list_entry(item->sibling.prev,
-					  struct scene_menitem, sibling);
-			if (item->flags & SCENEMIF_HEADER)
-				continue;
+		item = menu_step(menu, cur, false);
+		if (item) {
 			event->type = EXPOACT_POINT_ITEM;
 			event->select.id = item->id;
 			log_debug("up to item %d\n", event->select.id);
-			break;
 		}
 		break;
 	case BKEY_DOWN:
-		while (!list_is_last(&item->sibling, &menu->item_head)) {
-			item = list_entry(item->sibling.next,
-					  struct scene_menitem, sibling);
-			if (item->flags & SCENEMIF_HEADER)
-				continue;
+		item = menu_step(menu, cur, true);
+		if (item) {
 			event->type = EXPOACT_POINT_ITEM;
 			event->select.id = item->id;
 			log_debug("down to item %d\n", event->select.id);
-			break;
 		}
 		break;
 	case BKEY_SELECT:
@@ -635,3 +649,16 @@ int scene_menu_render_deps(struct scene *scn, struct scene_obj_menu *menu)
 
 	return 0;
 }
+
+int scene_menu_set_wrap(struct scene *scn, uint id, bool wrap)
+{
+	struct scene_obj_menu *menu;
+
+	menu = scene_obj_find(scn, id, SCENEOBJT_MENU);
+	if (!menu)
+		return log_msg_ret("menu", -ENOENT);
+
+	menu->wrap = wrap;
+
+	return 0;
+}
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index 9c33284c9aa..40adc049d02 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -67,6 +67,9 @@ A menu item flagged `SCENEMIF_HEADER` is a section header. It is laid out and
 shown like any other item, however, it is never highlighted or selected so the
 user can only move between the items around it.
 
+By default the highlight stops at the first and last selectable item. Call
+`scene_menu_set_wrap()` to make up/down wrap around instead.
+
 A `textline object` contains a label and an editable string.
 
 A `box object` is a rectangle with a given line width. It is not filled.
diff --git a/include/expo.h b/include/expo.h
index ac7644d8392..fe20c68750e 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -396,6 +396,7 @@ struct scene_obj_txt {
  * @title_id: ID of the title text, or 0 if none
  * @cur_item_id: ID of the current menu item, or 0 if none
  * @pointer_id: ID of the object pointing to the current selection
+ * @wrap: true to move from the last item to the first, and back, on up/down
  * @item_head: List of items in the menu
  */
 struct scene_obj_menu {
@@ -403,6 +404,7 @@ struct scene_obj_menu {
 	uint title_id;
 	uint cur_item_id;
 	uint pointer_id;
+	bool wrap;
 	struct list_head item_head;
 };
 
@@ -943,6 +945,18 @@ int scene_menu_select_item(struct scene *scn, uint id, uint sel_id);
  */
 int scene_menu_get_cur_item(struct scene *scn, uint id);
 
+/**
+ * scene_menu_set_wrap() - set whether up/down wrap around the ends of a menu
+ *
+ * By default the highlight stops at the first and last selectable item.
+ *
+ * @scn: Scene to update
+ * @id: ID of menu object to update
+ * @wrap: true to wrap around
+ * Return: 0 if OK, -ENOENT if @id is not a menu
+ */
+int scene_menu_set_wrap(struct scene *scn, uint id, bool wrap);
+
 /**
  * scene_obj_get_hw() - Get width and height of an object in a scene
  *

-- 
2.55.0


