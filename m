Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221FEC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40E5826B2;
	Mon,  5 May 2025 17:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GkMnM5dz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD4E82977; Mon,  5 May 2025 17:44:10 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB4E801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f4d28d9fd8so6274587a12.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459843; x=1747064643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9jzcVCZAgy5t624VGtmfRfJTl7ZjF4wiRp1sJvhcMI=;
 b=GkMnM5dz9IHuZgrtUFpi906RBNkeHv+R5EqsNCrF8uTB4k8S2XvqnyGnPIyYxCoUCp
 YM8z9ItL0UF5T3AyAMg3wpy0I5SxWq/k0nsXDMZ4JSoI+nlTFSiSLoMnfLjEcsp1Y3Et
 jC4EipwJMN2xyJqmEw6rmL79dCbT2IcHlLrjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459843; x=1747064643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j9jzcVCZAgy5t624VGtmfRfJTl7ZjF4wiRp1sJvhcMI=;
 b=O8LBio2X0lL/FCXnf8RFzCd4BxJbjnrvnwf6pWu2RWbtHjqzoj0caYyBJ00UTKieU5
 GuEac8+nQX3Z48usMtY6Io8GDTtJl7bfRd/PVLy+3D90zapJ6z4N+5mpl211SuDCQn/I
 rOMI0wb4Ii7s24NoJQFfGwSRuqqmaehlxnUMV14Gg/7UReKhZkaFHTEUhi0HFiVgFi/k
 E3sZdwL0dCnkM36vU+a3iIPoXvXq3e+g2Iizk1AVhyPrFP6Pxy0fHGnvlDMialYhze40
 hkp/WEN4ILcnZhIKnEkg/nDiYlYCB8+TFvgbWVLsEvEhxBZ55PDs01ODYC6Q5UX2RuP5
 P5tQ==
X-Gm-Message-State: AOJu0Yw+kPiTjkN2i1l3ILjYG/WCSMZ6UDb53hMUSGNgNbA7Lj+tLdg0
 ZwCQ8RwtBPO/XCfMJEhw3koxEKW5ocHok5CL6JtnmAGQo/FSGRfEb2v11PIp0w81zGMtI18khnW
 xVUzQ4ys=
X-Gm-Gg: ASbGncvtJjVutKUWfX55zPiEp4/zMGAnXAUN9bU/QSnFKEkU6pWVTU8oJdbne2xDeO6
 BVmdOOf68D+KYdbTAUKymKpSyUsd+1VwXflLBqv1zQrPJTf/l2DeKCBMYSx9yqmo8g7xkn4UI96
 6o6BTBL+wZd53tNAxEBIZa8kXRSk1nZouU91DhgqH9+ijOhlcybOahBNGpbaKm4YpKwYfn8E8Yv
 7PYe1iG/z7ZoZYYCpSTuG9EZComjop9t5Xxwy2pQgJ3Y4x4o9iAG3FL8AwXl/irH5h/fjlRh0Db
 U8ylyBpJtcBa1NSN2QuGua3VVj+/ZZ+FOg/w
X-Google-Smtp-Source: AGHT+IEwUpShQ23Ia4GZRu2oSOqzALkYa05o0K+Tj3oGmM7D4V7BmmoXCkjcNpMPPelOBi/0QVlXaw==
X-Received: by 2002:a05:6402:2755:b0:5e5:b53:fd49 with SMTP id
 4fb4d7f45d1cf-5fab056f0bcmr6935507a12.3.1746459843401; 
 Mon, 05 May 2025 08:44:03 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/19] expo: Record the pointer position in the menu item
Date: Mon,  5 May 2025 17:42:46 +0200
Message-ID: <20250505154308.2911248-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

Rather than drawing the poointer with a hard-coded position elsewhere in
the code, add a field to hold this value.

Move the check for the pointer position up so that the ordering of the
tests matches the order that the fields are dealt with in
scene_menu_arrange()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_menu.c | 7 ++++++-
 include/expo.h    | 2 ++
 test/boot/expo.c  | 6 +++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 8db6a2b2f4d..3f988657e00 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -102,7 +102,8 @@ static int update_pointers(struct scene_obj_menu *menu, uint id, bool point)
 		label = scene_obj_find(scn, item->label_id, SCENEOBJT_NONE);
 
 		ret = scene_obj_set_pos(scn, menu->pointer_id,
-					menu->obj.bbox.x0 + 200, label->bbox.y0);
+					menu->obj.bbox.x0 + menu->pointer_xofs,
+					label->bbox.y0);
 		if (ret < 0)
 			return log_msg_ret("ptr", ret);
 	}
@@ -293,6 +294,10 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 		scene_obj_set_hide(scn, item->label_id,
 				   stack && !open && !selected);
 
+		/* space for the pointer */
+		if (menu->pointer_id)
+			menu->pointer_xofs = 200;
+
 		if (item->key_id) {
 			ret = scene_obj_set_pos(scn, item->key_id, x + 230, y);
 			if (ret < 0)
diff --git a/include/expo.h b/include/expo.h
index 0b25a9d8b41..4a07a72cf7e 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -395,6 +395,7 @@ struct scene_obj_txt {
  * @title_id: ID of the title text, or 0 if none
  * @cur_item_id: ID of the current menu item, or 0 if none
  * @pointer_id: ID of the object pointing to the current selection
+ * @pointer_xofs: x position of pointer relative to the left side of the menu
  * @item_head: List of items in the menu
  */
 struct scene_obj_menu {
@@ -402,6 +403,7 @@ struct scene_obj_menu {
 	uint title_id;
 	uint cur_item_id;
 	uint pointer_id;
+	int pointer_xofs;
 	struct list_head item_head;
 };
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 135e177cbbd..bf18199caab 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -421,12 +421,12 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(menu->obj.bbox.x0, name1->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, name1->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x0 + 230, key1->obj.bbox.x0);
-	ut_asserteq(menu->obj.bbox.y0 + 32, key1->obj.bbox.y0);
-
 	ut_asserteq(menu->obj.bbox.x0 + 200, ptr->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, ptr->obj.bbox.y0);
 
+	ut_asserteq(menu->obj.bbox.x0 + 230, key1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.y0 + 32, key1->obj.bbox.y0);
+
 	ut_asserteq(menu->obj.bbox.x0 + 280, desc1->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, desc1->obj.bbox.y0);
 
-- 
2.43.0

