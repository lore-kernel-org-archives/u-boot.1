Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F20C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8110D82131;
	Wed, 19 Mar 2025 15:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kSJlLBtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC95282040; Wed, 19 Mar 2025 15:56:26 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394B08214D
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so5907196f8f.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396183; x=1743000983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwvwypD+9e+fz6ya7wNZg+HBcg1u5y+04IxQ31ApPYI=;
 b=kSJlLBtE2jJulkBErqZergVYGTkE/3yo47B1BNFE/XZYBfO/3QV3FjduccrjSVuhCs
 6sXPzcoYV+UryAY963VtnJNc/gB7lJTwA9ddJ/FFy5n8mNNysPZMme4ULyzZC9GCv6lz
 PU1xkE2eQdC7Cd1IALAevIuwyw7voN7E5ewv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396183; x=1743000983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwvwypD+9e+fz6ya7wNZg+HBcg1u5y+04IxQ31ApPYI=;
 b=lg/K+KvD2w1EnzVjVNloVvE12CNzI+Hy4C/O7YxwS1H4V2qZ3fH68SXQiqTS4q3X6A
 F04l37e2f0SFDe4fppduY31hcxHrMfJabH1S/yqZCoOQgvI0nwjM2PuUqsOi6O8Y8B+4
 EzjLy5SMBKuMrBkw+Iqw71+enOSpMztd0MDRi0Ues3LRAG/nltdYWQJ+IwWrO3+wiLWv
 wk23qXXOCeHuQ1wigjGMVKY57KjGAryBErQh2XX22xKiG5XPCeoZdRiQaScdffuBO/ZK
 CZVh8d9cDL/mRsAWJ6bevdNgNKHZw+HGRkTYS/pFa37edSPlHtprr/SKQj1eCBfWFlUF
 HsYw==
X-Gm-Message-State: AOJu0YxaNOVNxqh6DlQqgNvghys9igSeJKJSXssLHJ8Kh+DCHDv4+dCp
 iMkff7/GfGz+ZzkH7ss4N1aKQr1sr2u2DQYTdQk5OMUFx3k4qibLLVRGRLoQlxIkLgR3PgIrAoc
 =
X-Gm-Gg: ASbGncumq+CHI2vBM2QSKbpZ5mhtLdsVOSWQH8vFRWPDE3866qJtgRYsJTit7UuXOWx
 mrGFcWoURBzIJGi/mtyYyQfleJTI8KEyaVCg7oC6ipgTORsEVsaxcKiwgBknz+/4PrBoN4o5PfV
 h7YAlFT86hnncTQnNNkgHT1Kx+GLpR9iLvcHUnOFugzoITey4I56jHwR5FroNqI7V/JRV/57eOp
 wbjAwvkolCQjg28Lvrqo0jnhFOIHEhcqN2+9uCy1SRFD5obWkFQjpaHvxUaqqb4rT7321mr4qLQ
 ipEsQyRS3sGPGSfwxzEwktuTpupX278EmY3FZCO/mA==
X-Google-Smtp-Source: AGHT+IEU9DmThSrMeOeEvxvlKMNHHVAzcUR85/RU19bLfleVFfwLp06xF6zYYOM6zK6DQZ53J2E8jA==
X-Received: by 2002:a5d:47aa:0:b0:391:158f:3d59 with SMTP id
 ffacd0b85a97d-399739c23afmr3748028f8f.15.1742396183009; 
 Wed, 19 Mar 2025 07:56:23 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 30/52] expo: Line up all menu objects
Date: Wed, 19 Mar 2025 15:54:35 +0100
Message-ID: <20250319145512.2391122-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

At present labels are lined up vertically. Do the same with keys and
descriptions, since it looks nicer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_menu.c | 22 ++++++++++++++--------
 test/boot/expo.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 6d945cfa62d..8aa77924b33 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -182,14 +182,20 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 
 	scene_menu_calc_bbox(menu, bbox);
 
-	/* Make all labels the same size */
-	cur = &bbox[SCENEBB_label];
-	if (cur->valid) {
-		list_for_each_entry(item, &menu->item_head, sibling) {
-			scene_obj_set_size(menu->obj.scene, item->label_id,
-					   cur->x1 - cur->x0,
-					   cur->y1 - cur->y0);
-		}
+	/* Make all field types the same width */
+	list_for_each_entry(item, &menu->item_head, sibling) {
+		cur = &bbox[SCENEBB_label];
+		if (cur->valid)
+			scene_obj_set_width(menu->obj.scene, item->label_id,
+					    cur->x1 - cur->x0);
+		cur = &bbox[SCENEBB_key];
+		if (cur->valid)
+			scene_obj_set_width(menu->obj.scene, item->key_id,
+					    cur->x1 - cur->x0);
+		cur = &bbox[SCENEBB_desc];
+		if (cur->valid)
+			scene_obj_set_width(menu->obj.scene, item->desc_id,
+					    cur->x1 - cur->x0);
 	}
 
 	cur = &bbox[SCENEBB_all];
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 2a430d3d482..70db33d48b1 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -576,6 +576,36 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(50 + 29, obj->bbox.x1);
 	ut_asserteq(454 + 18, obj->bbox.y1);
 
+	/* same for the key */
+	obj = scene_obj_find(scn, ITEM1_KEY, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_asserteq(280, obj->bbox.x0);
+	ut_asserteq(436, obj->bbox.y0);
+	ut_asserteq(280 + 9, obj->bbox.x1);
+	ut_asserteq(436 + 18, obj->bbox.y1);
+
+	obj = scene_obj_find(scn, ITEM2_KEY, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_asserteq(280, obj->bbox.x0);
+	ut_asserteq(454, obj->bbox.y0);
+	ut_asserteq(280 + 9, obj->bbox.x1);
+	ut_asserteq(454 + 18, obj->bbox.y1);
+
+	/* and the description */
+	obj = scene_obj_find(scn, ITEM1_DESC, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_asserteq(330, obj->bbox.x0);
+	ut_asserteq(436, obj->bbox.y0);
+	ut_asserteq(330 + 89, obj->bbox.x1);
+	ut_asserteq(436 + 18, obj->bbox.y1);
+
+	obj = scene_obj_find(scn, ITEM2_DESC, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_asserteq(330, obj->bbox.x0);
+	ut_asserteq(454, obj->bbox.y0);
+	ut_asserteq(330 + 89, obj->bbox.x1);
+	ut_asserteq(454 + 18, obj->bbox.y1);
+
 	/* check dimensions of menu */
 	obj = scene_obj_find(scn, OBJ_MENU, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-- 
2.43.0

