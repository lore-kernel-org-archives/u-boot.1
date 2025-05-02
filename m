Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAD5C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3154382A81;
	Fri,  2 May 2025 16:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jaw4EFTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1382D82AF6; Fri,  2 May 2025 16:48:19 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A457E82ACB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8647a81e683so71431639f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197294; x=1746802094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6u+v7x76a//XCR/REWgFFEP+Z61I0Rdzm0M9uXVw9Lg=;
 b=Jaw4EFTrIxiQLP9T8LnFUJDWrBGhrkpZkq4+lMA1kw3hgo06FszmP+wyMBXGUFetBl
 MpLlIbns2oBRextkshYpO0Y3flBlWYtBTPVkZP7bm5L9FTD2jbKXukxc4dAQdQ2Rob9Z
 5XrLLMXUjX3wpJpu2O0QPb9ugeMqzY7Ov3Inw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197294; x=1746802094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6u+v7x76a//XCR/REWgFFEP+Z61I0Rdzm0M9uXVw9Lg=;
 b=ai8gHMnhP0ezmFzDtv0aa8PapnJcqYiBWh2g+qlnKPymUWbRELguGjbLDLS7038Pge
 4HaY8M3v4+AeOSMrhd2mWeg6lMVRWow/PhrzJ6/OXdX68aC6VKqiHjXBpeZXIwdEIpjS
 BHcDySKBxXEq5V/LM8H1nVCk3f/7JXywdQe9nnVWkmXgaryvSW2IRHjG9NDLlrmAdPmP
 FcAwjqlKkcAzr8kVpq8y/yQkfnw9GtKzqJ9Kt2EzYqZTAX3RcxIvmtYL0RjXlerWZit6
 gUUS1pXoMzk8UUlAU2HLxHx3kk+s52062wop6kbJpGI7t1vhSFkMdWJ+78HjAoLG4FgC
 s0qQ==
X-Gm-Message-State: AOJu0YySpDOfpRkgpCPvmEt1rVUyPOgvThzJWxs6Ris+Ytjq76JBNoMo
 aEQA3gMF5XtwAL1BsxVXUL87Yp1yjd23QNuyX2XeLqqWGUGG0ph38CAss5APGtDrbVgTDYqdJIM
 =
X-Gm-Gg: ASbGncuIOxzCQUjjjeNTro8QcBrAUKGzvYOs0GuRMRuWpnCVBjEvtXGNB+Q/SEiPY/D
 3m4UC/QkzuFryJuEZaklmpeOfOI6XyDaZiSmVcJ8ZFZvOOodo92OUmZzof6byFB1Un9ObC06UIQ
 BzLFZiqKKmJMcQ8ge3VJ6DT38Tw8a8RvdWFRO2Ah6uW72Www+aqrm3tXw3grULJOR+NN4uDf4ZS
 sIOFVj4AJjHhsj0FudUWQuS0lz7KR8pxmzFXpWvEcg6pkdkNkwIjLtcrzn/DxHH4oVRztSFATse
 RXmHmQtErrl/72VKh+y6tuXoHOrgYzlkk8K/exohMPDJ7NiNzoLkn1iTNc0fcR7oavWN/VN7YGo
 fdA==
X-Google-Smtp-Source: AGHT+IHSfmmyuK8zOQNv+qAValxj2EF96DHxT3ObcYFLAsouL2CEHXbUs4d6DYdMdolg6G9Frtl4ZQ==
X-Received: by 2002:a05:6602:418c:b0:861:7237:9021 with SMTP id
 ca18e2360f4ac-8669fb07b0amr379214539f.3.1746197293874; 
 Fri, 02 May 2025 07:48:13 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 27/60] expo: Adjust how menu items are highlighted
Date: Fri,  2 May 2025 08:46:25 -0600
Message-ID: <20250502144718.313633-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

 boot/bootflow_menu.c | 10 ++++++++++
 boot/cedit.c         |  9 ++++++++-
 boot/scene_menu.c    |  2 --
 test/boot/expo.c     |  4 ++++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 268c93ae8e3..f9ebc526200 100644
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
@@ -224,6 +228,12 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 				sel_id = act.select.id;
 				done = true;
 				break;
+			case EXPOACT_POINT_ITEM:
+				ret = scene_menu_select_item(scn,
+						OBJ_MENU, act.select.id);
+				if (ret)
+					return log_msg_ret("bmp", ret);
+				break;
 			case EXPOACT_QUIT:
 				return -EPIPE;
 			default:
diff --git a/boot/cedit.c b/boot/cedit.c
index eac851b395a..792ab6d65bd 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -148,10 +148,17 @@ int cedit_prepare(struct expo *exp, struct udevice *vid_dev,
 int cedit_do_action(struct expo *exp, struct scene *scn,
 		    struct video_priv *vid_priv, struct expo_action *act)
 {
+	int ret;
+
 	switch (act->type) {
 	case EXPOACT_NONE:
-	case EXPOACT_POINT_ITEM:
 		return -EAGAIN;
+	case EXPOACT_POINT_ITEM:
+		ret = scene_menu_select_item(scn, scn->highlight_id,
+					     act->select.id);
+		if (ret)
+			return log_msg_ret("cdp", ret);
+		break;
 	case EXPOACT_POINT_OBJ:
 		scene_set_highlight_id(scn, act->select.id);
 		cedit_arange(exp, vid_priv, scn->id);
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 06d7e9fc913..6a2f5b6b93f 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -406,8 +406,6 @@ int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
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

