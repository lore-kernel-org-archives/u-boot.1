Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B984E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F7F2871B8;
	Mon,  2 Oct 2023 03:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PMabYD2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C201B8711F; Mon,  2 Oct 2023 03:15:10 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4522087123
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3527428a402so4677825ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209261; x=1696814061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7zu/R1W/piuTjegNs52oaR1zSI3cr7HDrMKcJ7Qqw4=;
 b=PMabYD2c9lroAiXl5Lgu3ejDnUVM3/yLpO5lQtwa4uteHM/lChc4mAALtMWd7N6jEn
 gUjLtHcC+YnUPatWyLb/KFvY4/2Pk+jYyZKDZJTPlp9y+y7g6ereNgr6CilC51iK7aEG
 8nwB00O1i344MUmkV/CKrBgm6guFY0n5LC2oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209261; x=1696814061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7zu/R1W/piuTjegNs52oaR1zSI3cr7HDrMKcJ7Qqw4=;
 b=Cyw7o6Yz4an2lu+vnBDCJF8Q61SmdqPD67bymiMlyy5uBX1ckFz2QxCaAL4g21X+wI
 mrwoQCwZQmh2dXvOf9wHTYFSl6Cd+sg0WFJ51cUZImNyiTBZGdEZGMIg7XDyA9xFoVBr
 9GKw/ayjnGuKjkB5qNtT1AWN0pkKQO5ZHIOVtSH2YM0qUdAf13670rNC4X9VJGBQrbew
 MY5IWZcnnlXf/CY5jnEOcru+Srx9DUpgslTBs4y7vIMdRnXNEzmbT6Hxs2U4vFakNrRo
 k7w0+tJy0cMfjRPJg+liEHU+Hotaet/QROHgw7D6ebkUHgQ4QuhJ9dvBZ9CTtFjTL3Yc
 d2MQ==
X-Gm-Message-State: AOJu0YwFdgbKAVPBPwZ/OD6gGrk42XqjfGNcgCbuxCIUwZfWbQzhkW2X
 tvnBbqXBz9tsaJYYjblCLjxJRA7viY67jLqT5Bo=
X-Google-Smtp-Source: AGHT+IHEhp98BjOsOGmaXzfxPDpT6u5LoXFkRMZcORHUa9BFX3zvILxI0Ot2hETTFCKxIKWRYPhjDA==
X-Received: by 2002:a05:6e02:13c7:b0:34b:ae9b:d039 with SMTP id
 v7-20020a056e0213c700b0034bae9bd039mr10107164ilj.18.1696209260764; 
 Sun, 01 Oct 2023 18:14:20 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 33/36] expo: Plumb in textline to cedit
Date: Sun,  1 Oct 2023 19:13:37 -0600
Message-ID: <20231002011349.461284-34-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Support textlines in the configuration editor.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Correct variable declaration in switch() to make clang happy

 boot/cedit.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 407793aaddd4..8c654dba6dc3 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -81,6 +81,12 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 			scene_menu_arrange(scn, (struct scene_obj_menu *)obj);
 			y += 50;
 			break;
+		case SCENEOBJT_TEXTLINE:
+			scene_obj_set_pos(scn, obj->id, 50, y);
+			scene_textline_arrange(scn,
+					(struct scene_obj_textline *)obj);
+			y += 50;
+			break;
 		}
 	}
 
@@ -295,17 +301,27 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 {
 	struct cedit_iter_priv *priv = vpriv;
 	struct abuf *buf = priv->buf;
+	int ret;
 
 	switch (obj->type) {
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
 		break;
+	case SCENEOBJT_TEXTLINE: {
+		const struct scene_obj_textline *tline;
+
+		tline = (struct scene_obj_textline *)obj;
+		ret = write_dt_string(buf, obj->name, abuf_data(&tline->buf));
+		if (ret)
+			return log_msg_ret("wr2", ret);
+		break;
+	}
 	case SCENEOBJT_MENU: {
 		const struct scene_obj_menu *menu;
 		const char *str;
 		char name[80];
-		int ret, i;
+		int i;
 
 		/* write the ID of the current item */
 		menu = (struct scene_obj_menu *)obj;
@@ -394,6 +410,19 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
 		break;
+	case SCENEOBJT_TEXTLINE: {
+		const struct scene_obj_textline *tline;
+		const char *val;
+		int len;
+
+		tline = (struct scene_obj_textline *)obj;
+
+		val = ofnode_read_prop(node, obj->name, &len);
+		if (len >= tline->max_chars)
+			return log_msg_ret("str", -ENOSPC);
+		strcpy(abuf_data(&tline->buf), val);
+		break;
+	}
 	case SCENEOBJT_MENU: {
 		struct scene_obj_menu *menu;
 		uint val;
@@ -472,6 +501,20 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
 		if (ret)
 			return log_msg_ret("st2", ret);
 		break;
+	case SCENEOBJT_TEXTLINE: {
+		const struct scene_obj_textline *tline;
+
+		tline = (struct scene_obj_textline *)obj;
+		str = abuf_data(&tline->buf);
+		ret = env_set(var, str);
+		if (ret)
+			return log_msg_ret("set", ret);
+
+		if (priv->verbose)
+			printf("%s=%s\n", var, str);
+
+		break;
+	}
 	}
 
 	return 0;
@@ -521,6 +564,21 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 		 */
 		menu->cur_item_id = val;
 		break;
+	case SCENEOBJT_TEXTLINE: {
+		const struct scene_obj_textline *tline;
+		const char *value;
+
+		tline = (struct scene_obj_textline *)obj;
+		value = env_get(var);
+		if (value && strlen(value) >= tline->max_chars)
+			return log_msg_ret("str", -ENOSPC);
+		if (!value)
+			value = "";
+		if (priv->verbose)
+			printf("%s=%s\n", var, value);
+		strcpy(abuf_data(&tline->buf), value);
+		break;
+	}
 	}
 
 	return 0;
-- 
2.42.0.582.g8ccd20d70d-goog

