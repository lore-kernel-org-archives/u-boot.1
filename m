Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1B2C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B5A82064;
	Wed, 19 Mar 2025 15:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="md/FgUHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6849582040; Wed, 19 Mar 2025 15:56:06 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86709820EA
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so47181485e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396162; x=1743000962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GIJXJp3RON1Z6EuwEuAEzpnT4koNfk0xMCWD8eJwwIc=;
 b=md/FgUHDNpWViWrw52sRp97bTT8nxDbOPDY18QcpqZ5a+nHlaqfhYfB/Y+/7njiQf1
 MbGW2i8+rFTZoAhnBhWizaKS70GoLISnzBMJEwMj+ESyaAzBQc+6oUsfGDpMHpgTJg9N
 EPNi5eQGwBx3KgnBnh+d8unEkQIMweCuF7iOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396162; x=1743000962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GIJXJp3RON1Z6EuwEuAEzpnT4koNfk0xMCWD8eJwwIc=;
 b=vFURV4egSGCK/3JqADBL1bysuYW04L708xpoNbIyycGTsIVIKwCLXkC5d+Ly43Y+3P
 oZxxCgVld+a+OWvSc1MWbTU1pG4vycFMDFE7DOLL+L4lfDmOaNvhhQF27P87uQlIJeVz
 kpf4/ilrWnBadPZHYaK/hswH3lrV26CHS6mX8hbKWax1YYdk8HpxQDjQ7MnxNcBu2uSX
 qip2TwCWOkaSu8VRc2r0l0NHnAsIOxVZrxwLTi7mlRAJPoWkiSjL5SRcYtlXS5LXFQoH
 Jmjy2ESIOglLF/DT0fQcca9/E5BajiukaF2bPyarfXY+t8/oAPTvFpsMi85dXaRn6xMd
 jA9Q==
X-Gm-Message-State: AOJu0YwC40ONfGfFQlasGd4QO07KVdiY63mhbOaaxEPIcK0Dc23gXUZo
 7i/MgV8dI2HUJ/MywDTD8/UT1o7FZDvq2IU2gfRylPkJhjLWCJ8jm9B+esDaIFEsyE6MtFqUexA
 =
X-Gm-Gg: ASbGncuyUuI/ic9ITkaPihYhwpEZym0LPwH7TjIIUlwvu9O6l3ZP4uvecFjYbxzdg/B
 K6FZhaMAQepPbtfEihVdL/Ct8l5W/759vaWioejktnegyxkJzshO6ewiul42roop1SLtVYSzKrp
 Lh4ue12T94HcJIAbcxUjpd6fgMv/UCPnujvgO5rErdnigSoh5expHr4ICXOrReqJltd1suqIPN9
 IEq3uAEN8V5an8JI4n06KOAnquIm5G5/lR8ut3U9/foGsJKNAX0mi8roZ1yo4H3xKOcD+oLjXpF
 GiXgOTsJwnHMBqlLHxxRPIv1OWah8QPRWgUwGhLYkesLHcoCm180
X-Google-Smtp-Source: AGHT+IG8oMlAavx4wH1O1u5me9TNV1HXX3kBBpYbtAeeSXU46NnFs9OyfHQhdz8rAvkK83lqHUJgNA==
X-Received: by 2002:a05:600c:a55:b0:43c:eacc:9d8c with SMTP id
 5b1f17b1804b1-43d437ff47fmr25421255e9.24.1742396161947; 
 Wed, 19 Mar 2025 07:56:01 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/52] expo: Test some cedit actions
Date: Wed, 19 Mar 2025 15:54:23 +0100
Message-ID: <20250319145512.2391122-19-sjg@chromium.org>
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

Refactor the action-processing code into a new cedit_do_action()
function so we can call it from a test. Check moving to a new field and
opening the menu, to ensure that rendering is correct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c      | 75 ++++++++++++++++++++++++++---------------------
 include/cedit.h   | 13 ++++++++
 test/boot/cedit.c | 16 ++++++++++
 3 files changed, 71 insertions(+), 33 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 3703538e5dc..bcbbe69fe33 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -149,6 +149,47 @@ int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
 	return scene_id;
 }
 
+int cedit_do_action(struct expo *exp, struct scene *scn,
+		    struct video_priv *vid_priv, struct expo_action *act)
+{
+	switch (act->type) {
+	case EXPOACT_NONE:
+	case EXPOACT_POINT_ITEM:
+		return -EAGAIN;
+	case EXPOACT_POINT_OBJ:
+		scene_set_highlight_id(scn, act->select.id);
+		cedit_arange(exp, vid_priv, scn->id);
+		break;
+	case EXPOACT_OPEN:
+		scene_set_open(scn, act->select.id, true);
+		cedit_arange(exp, vid_priv, scn->id);
+		switch (scn->highlight_id) {
+		case EXPOID_SAVE:
+			exp->done = true;
+			exp->save = true;
+			break;
+		case EXPOID_DISCARD:
+			exp->done = true;
+			break;
+		}
+		break;
+	case EXPOACT_CLOSE:
+		scene_set_open(scn, act->select.id, false);
+		cedit_arange(exp, vid_priv, scn->id);
+		break;
+	case EXPOACT_SELECT:
+		scene_set_open(scn, scn->highlight_id, false);
+		cedit_arange(exp, vid_priv, scn->id);
+		break;
+	case EXPOACT_QUIT:
+		log_debug("quitting\n");
+		exp->done = true;
+		break;
+	}
+
+	return 0;
+}
+
 int cedit_run(struct expo *exp)
 {
 	struct video_priv *vid_priv;
@@ -168,39 +209,7 @@ int cedit_run(struct expo *exp)
 
 		ret = expo_poll(exp, &act);
 		if (!ret) {
-			switch (act.type) {
-			case EXPOACT_POINT_OBJ:
-				scene_set_highlight_id(scn, act.select.id);
-				cedit_arange(exp, vid_priv, scene_id);
-				break;
-			case EXPOACT_OPEN:
-				scene_set_open(scn, act.select.id, true);
-				cedit_arange(exp, vid_priv, scene_id);
-				switch (scn->highlight_id) {
-				case EXPOID_SAVE:
-					exp->done = true;
-					exp->save = true;
-					break;
-				case EXPOID_DISCARD:
-					exp->done = true;
-					break;
-				}
-				break;
-			case EXPOACT_CLOSE:
-				scene_set_open(scn, act.select.id, false);
-				cedit_arange(exp, vid_priv, scene_id);
-				break;
-			case EXPOACT_SELECT:
-				scene_set_open(scn, scn->highlight_id, false);
-				cedit_arange(exp, vid_priv, scene_id);
-				break;
-			case EXPOACT_QUIT:
-				log_debug("quitting\n");
-				exp->done = true;
-				break;
-			default:
-				break;
-			}
+			cedit_do_action(exp, scn, vid_priv, &act);
 		} else if (ret != -EAGAIN) {
 			LOGR("cep", ret);
 		}
diff --git a/include/cedit.h b/include/cedit.h
index 856509f0c7f..a9305ceebcb 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -13,6 +13,7 @@
 
 struct abuf;
 struct expo;
+struct expo_action;
 struct scene;
 struct udevice;
 struct video_priv;
@@ -62,6 +63,18 @@ int cedit_run(struct expo *exp);
 int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
 		  struct scene **scnp);
 
+/**
+ * cedit_do_action() - Process an action on a cedit
+ *
+ * @exp: Expo to use
+ * @scn: Current scene
+ * @vid_priv: Private data for the video device
+ * @act: Action to process
+ * Return: 0 on success, -EAGAIN if there was no action taken
+ */
+int cedit_do_action(struct expo *exp, struct scene *scn,
+		    struct video_priv *vid_priv, struct expo_action *act);
+
 /**
  * cedit_write_settings() - Write settings in FDT format
  *
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index df191a09f89..9fab8750b40 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -228,6 +228,7 @@ static int cedit_render(struct unit_test_state *uts)
 {
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
+	struct expo_action act;
 	struct udevice *dev;
 	struct scene *scn;
 	struct expo *exp;
@@ -240,6 +241,21 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_assertok(expo_render(exp));
 	ut_asserteq(4929, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
+
+	/* move to the second field */
+	act.type = EXPOACT_POINT_OBJ;
+	act.select.id = ID_POWER_LOSS;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4986, video_compress_fb(uts, dev, false));
+
+	/* open the menu */
+	act.type = EXPOACT_OPEN;
+	act.select.id = ID_POWER_LOSS;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5393, video_compress_fb(uts, dev, false));
+
 	expo_destroy(exp);
 	cur_exp = NULL;
 
-- 
2.43.0

