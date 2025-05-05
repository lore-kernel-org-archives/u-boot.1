Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11F9C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7535F82A56;
	Mon,  5 May 2025 17:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gcuX2aKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F012C82A56; Mon,  5 May 2025 17:44:18 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D818A829CD
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso6960889a12.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459854; x=1747064654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEqOBn4iaho8zMImhusdoDhAOCwEZnAfRGBvVZ7rQ1Y=;
 b=gcuX2aKcuSqcaM61Mwx+XlzDqU707Eo0Q05Q5yk0xEVIDwI8Z7N9J6F+fg1IzlMO1t
 KJDQGolNJGq77+kQvUp75YFl95Sgm7ssZSAoEIUaFTMH0KMvTBLHYmcbqK09h0rWxBUv
 eaklN6t/1eghbUhSlseCI1l/aKI1gCGWHCA7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459854; x=1747064654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEqOBn4iaho8zMImhusdoDhAOCwEZnAfRGBvVZ7rQ1Y=;
 b=JB0Z5h2OoDPU3SJkRtTc+Mr2rbtq+DZH9aD2N5zBOLqZ2+CNoLcP2EXWjzSPdfLaU2
 TqU1e2Axtg4dAb32PyZXblosrYBiIP7SjjyxQ9J0WaPmWkdZwnsSefZ9ccAy1S/W+kkw
 Fkr5fPzVIry+oEfge+U0uagyayTWB29mkOz3C46jkOst094K+GAjmz9fL2vwYz4AMJ75
 SpUEDPq/crqn8TXYmZCn8LhYPYPsL5WRxjcV+hxA2fjmnGnjRdC9z76237iIjScIIe1c
 6f0L7u31vEfM8xmuzngxtwWULojfAzNluRlzO3/9NclIjDplXY+Tog/tbSwyGCNrOLV2
 by3w==
X-Gm-Message-State: AOJu0YyBtOVfRLhFIkIPm1xuYtXn8DUkq4+9Uz2RN5m7ub+3rwHXiIpI
 JRqPFy1CwNi1aSA3GJvdPA3MGMuM+K/yzQ86zLWHBIE/JDViOiua/hH/z/q2bJlCxVmF2i4/LMA
 kRQz9mKE=
X-Gm-Gg: ASbGncvsDkxWl/0e+JsGfhLx2wiMlbwCvzpE2ChvsPh7xWtKvilvNvxMUYhIKLJEyS5
 23GXAM3W+XE+jXXgN4jHNVqpiekPjwabPq4U2gu6iUhAGQW/wIuaKdlKxtSXtZoWWQ9o9I1L7Yb
 OzeIt2+TtNyHglNEStTyBhCxMPVbRgtJ4jmv/FhoJepa/gmIu5zMLoUa8WA7mlcS1mBXQoMsEPT
 jWKcgqcqtgFfAxvreuPjT1i5mZJNITYYUjGY/LbC62dDPLL8WbXB1OUeVXPSPhKRAyMbEsMOjcw
 oIm8V9BYQOHr2MO6u7QM4QPMonLxwpo9EB/h
X-Google-Smtp-Source: AGHT+IHbSuD5EqhQAesNZwjE7dDH+ou5+awpnaBCcFIsjE6Dip2uTQuPY1oCHAZuTa7IFdR9I4a1WA==
X-Received: by 2002:a05:6402:42c8:b0:5f4:b0ab:9df4 with SMTP id
 4fb4d7f45d1cf-5faa7f8e7femr8024116a12.19.1746459854615; 
 Mon, 05 May 2025 08:44:14 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/19] expo: Allow the menu pointer to be wider
Date: Mon,  5 May 2025 17:42:53 +0200
Message-ID: <20250505154308.2911248-16-sjg@chromium.org>
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

Rather than hard-coding the distance between the labels and the key,
measure the width of the pointer to determine the space needed.

Tweak a few tests according. It isn't possible to get the same result
when the font-size differs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_menu.c | 17 ++++++++++++++---
 test/boot/expo.c  |  4 ++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 094489e2a40..b33e0a7d3b4 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -222,7 +222,7 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 		       struct scene_obj_menu *menu)
 {
 	const bool open = menu->obj.flags & SCENEOF_OPEN;
-	struct scene_obj_dims dims[SCENEBB_count];
+	struct scene_obj_dims dims[SCENEBB_count], pointer_dims;
 	struct expo *exp = scn->expo;
 	const bool stack = exp->popup;
 	const struct expo_theme *theme = &exp->theme;
@@ -231,6 +231,7 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	int startx, x, y;
 	int ret;
 
+	memset(&pointer_dims, '\0', sizeof(pointer_dims));
 	menu->obj.dims.x = 0;
 	menu->obj.dims.y = 0;
 
@@ -256,6 +257,16 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 			y += ret * 2;
 	}
 
+	if (menu->pointer_id) {
+		const struct scene_obj *obj;
+
+		obj = scene_obj_find(scn, menu->pointer_id, SCENEOBJT_NONE);
+		if (!obj)
+			return log_msg_ret("obj", -ENOENT);
+
+		pointer_dims = obj->dims;
+	}
+
 	/*
 	 * Currently everything is hard-coded to particular columns so this
 	 * won't work on small displays and looks strange if the font size is
@@ -295,9 +306,9 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 		x += 200;
 
 		/* space for the pointer */
-		if (menu->pointer_id) {
+		if (pointer_dims.x) {
 			menu->pointer_xofs = x - startx;
-			x += 30;
+			x += 12 + pointer_dims.x + 9;
 		}
 
 		if (item->key_id) {
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 0289350df9c..b05e57b4f5a 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -424,10 +424,10 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(menu->obj.bbox.x0 + 200, ptr->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, ptr->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x0 + 230, key1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.x0 + 229, key1->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, key1->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x0 + 280, desc1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.x0 + 279, desc1->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, desc1->obj.bbox.y0);
 
 	ut_asserteq(-4, prev1->obj.bbox.x0);
-- 
2.43.0

