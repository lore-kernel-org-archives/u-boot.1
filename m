Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15385C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7EC381F7B;
	Fri, 28 Mar 2025 14:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KpTP+F9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DD581DCC; Fri, 28 Mar 2025 14:08:06 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228A582006
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85e1b1f08a5so54690939f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167281; x=1743772081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taw/T3vQje+nDvvJpAXLp1MIi39D4l+Eh26u8xTpNIk=;
 b=KpTP+F9ebYvnoK5omLTarLbC8aRNYaqTLBdIz4qRIDucW00MMfpQI77tOMuCeQnzj6
 MCuBAxltbNN9hxiY/KnHcDwfxOy+W4Eo9BgFEcKVmDpVwcZFYWg4JxYLf80G2gG+CbrT
 uN7acyFKYEjqjUgaihZPivyg6x5tBvgr0PwMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167281; x=1743772081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=taw/T3vQje+nDvvJpAXLp1MIi39D4l+Eh26u8xTpNIk=;
 b=TvtBisopVZD95E7EsXqGuHl1apu+N9HV7LkIszlX7hSWa8m81jegSrG25wdpnduq2y
 afl8ePzwLsqyhl/9pB7vCVfDH9o/FExJMohFU1sMHSgzRezrokt9JUQp/dV8uApRyS3u
 9ShBkwDM17zmibspwNj5R9N+FoL4sFQ/CnrRltnOFtenlsn9O/cvUF+h/XXp7XXFhPtC
 4XrJ7o+NRrwKr9QySk6HK93QfSVj0/GsFxlopfasASzpAHrh1G5lm9vM8xoo4qNenRkK
 w+RFbxybEdhI7VFVADO9jpXEMdhXwzGCGcBdm76kjGobUyhbHIv7xxgmMHSTbx8DIe90
 qXJA==
X-Gm-Message-State: AOJu0YwacSMdK9Zut9vr8xv4RPJbvgwNiGqizxaeIFvIsXGjO/pjGTMR
 GZ9I42mBbxEp2bmfYylsweBqPhaaj7hGxP3RH3JfRBWnbM9lC3MTtqYoX/yJuk4MoiIBW9sQ7cU
 =
X-Gm-Gg: ASbGncsvQ4R1KvMy79ys1EYhEPpzzGIs9hKmOYQnqnRIcyKmXUsd0chKW8ZpkfE/rWA
 wFRrl7vqDVN0609n1sWZORmnkdx2w3z3XJELiLXTKe1rmNiYXe1g5OnmjaCYIXwsFEp75jyQ2Cn
 rB3pwI/7BHZUalOFkoqxCa88wowMKZs48TFJFFVro9yKFAPKERxtumbefigmO6TEv6fb+Udxc01
 VJgatiIbGPChYdavbxlQLx8CxGaq0gy3sGYgktlB+Vgoc8Rtbwf57WQRX8HnTRGZo/eUjUPmbKZ
 vSnTdDwM/+IF07UcrlazuUN/0nzXHTPV4xDIZgC+1VmGz76JCZhcWDw1n6igjDZlhskUEoN5bTB
 Jj/oL4Q==
X-Google-Smtp-Source: AGHT+IFlqUQVCAa6lL/89BzeldLdGqM3W3M0vlFcEahbFNizpftZ/Wnwcm7WgT+fFTbomQ7T/tkQ9g==
X-Received: by 2002:a05:6602:3798:b0:85d:f74b:f8a8 with SMTP id
 ca18e2360f4ac-85e820551afmr872501339f.2.1743167281117; 
 Fri, 28 Mar 2025 06:08:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/56] expo: Adjust how menu items are highlighted
Date: Fri, 28 Mar 2025 07:06:10 -0600
Message-ID: <20250328130713.2612648-24-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

At present when the user moves to a new menu item, the menu code
handles this immediately. This means it is not possible to use an expo
action to effect the same change.

Update this so that EXPOACT_POINT_ITEM is handled in cedit_do_action().

Expand the test to cover this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 8 ++++++++
 boot/cedit.c         | 5 ++++-
 boot/scene_menu.c    | 2 --
 test/boot/expo.c     | 4 ++++
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index e3a27f16daa..d20d0be4734 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -180,6 +180,7 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 {
 	struct bootflow *sel_bflow;
 	struct udevice *dev;
+	struct scene *scn;
 	struct expo *exp;
 	uint sel_id;
 	bool done;
@@ -209,6 +210,9 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 	ret = expo_set_scene_id(exp, MAIN);
 	if (ret)
 		return log_msg_ret("scn", ret);
+	scn = expo_lookup_scene_id(exp, MAIN);
+	if (!scn)
+		return log_msg_ret("scn", -ENOENT);
 
 	if (text_mode)
 		expo_set_text_mode(exp, text_mode);
@@ -224,6 +228,10 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 				sel_id = act.select.id;
 				done = true;
 				break;
+			case EXPOACT_POINT_ITEM:
+				LOGR("bmp", scene_menu_select_item(scn,
+					OBJ_MENU, act.select.id));
+				break;
 			case EXPOACT_QUIT:
 				return -EPIPE;
 			default:
diff --git a/boot/cedit.c b/boot/cedit.c
index 3fde6928f90..eabbf07a8a0 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -150,8 +150,11 @@ int cedit_do_action(struct expo *exp, struct scene *scn,
 {
 	switch (act->type) {
 	case EXPOACT_NONE:
-	case EXPOACT_POINT_ITEM:
 		return -EAGAIN;
+	case EXPOACT_POINT_ITEM:
+		LOGR("cdp", scene_menu_select_item(scn, scn->highlight_id,
+						   act->select.id));
+		break;
 	case EXPOACT_POINT_OBJ:
 		scene_set_highlight_id(scn, act->select.id);
 		cedit_arange(exp, vid_priv, scn->id);
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 48905d3e2b6..df14a6c0409 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -399,8 +399,6 @@ int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
 		break;
 	}
 
-	menu_point_to_item(menu, item->id);
-
 	return 0;
 }
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 616071ead48..b32a4596e85 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -588,6 +588,8 @@ static int expo_render_image(struct unit_test_state *uts)
 	expo_set_scene_id(exp, SCENE1);
 	ut_assertok(expo_render(exp));
 
+	ut_asserteq(0, scn->highlight_id);
+	ut_assertok(scene_arrange(scn));
 	ut_asserteq(0, scn->highlight_id);
 
 	/* move down */
@@ -599,6 +601,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(ITEM2, act.select.id);
 	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, act.select.id));
 	ut_asserteq(ITEM2, scene_menu_get_cur_item(scn, OBJ_MENU));
+	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
 
 	/* make sure only the preview for the second item is shown */
@@ -639,6 +642,7 @@ static int expo_render_image(struct unit_test_state *uts)
 
 	ut_asserteq(EXPOACT_POINT_ITEM, act.type);
 	ut_asserteq(ITEM1, act.select.id);
+	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, act.select.id));
 
 	ut_assertok(expo_render(exp));
 	ut_assert_nextline("U-Boot    :    Boot Menu");
-- 
2.43.0

