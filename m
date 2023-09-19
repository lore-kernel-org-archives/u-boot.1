Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4100DCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C2286C5D;
	Tue, 19 Sep 2023 20:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fs7WKNLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A0786C4C; Tue, 19 Sep 2023 20:09:56 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB6586C2B
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7928dc54896so228481939f.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146993; x=1695751793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOJ5w1KzOEDzj72DiNSd15Oyfe6f6W5yadLAiBSFMHU=;
 b=Fs7WKNLO3cgT+Oj48T8iV3X8ODMPGQpoKiY5sCSEousIfNAPn9yBN4WriDuhb8Gb8x
 UH2DHvC2FRuF0/3K7JCMCOLNc36EZzPQvLgskFEdF3eHU2iTOQ68E1aIaM415tf2jOcJ
 yu8OLsapN++sra1j9m4Eun+xRmHqSGR1TsPg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146993; x=1695751793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOJ5w1KzOEDzj72DiNSd15Oyfe6f6W5yadLAiBSFMHU=;
 b=Ml0k6XAIBFBm6n2/55SRydjzoZfqE/roUZwFSuT9hs3WVdCa9NbtHltPbEAO2pPFe1
 aAnaR4HY/KXwEiZoaky+eV7jdJ1LqWtoVoznnCPNpiOJ0kL9ue/VmZBdUtSOh14c3yza
 qGlc53zJziGJMa5SoZNkCIETjRAxaX8qe/nex+n1PDeack6V5Ydd2Rw126FNW2vDhmof
 5qshKol9HVdfJ3CPBs5fYco0LkpZM/bDhScaHG9NVQ8bZM0AbVmxUjJ5UCFaQ2wf9qEz
 zSAsMA9rhI30kpdfDYcwaRxRKMdTAFE7Oo7fQhB29po2qyWlQHtdEcKJty5LTvK4ySTJ
 qNvA==
X-Gm-Message-State: AOJu0Yz2Iz8ouOj88X37Pt6qJxJAyC/SKxX2Tu1gZG259ZlyWCucyk84
 ztjztr1mhKjJe+wgW6u3u1uhkpezmEBIBirEjwg=
X-Google-Smtp-Source: AGHT+IEPTPrGSdWUxnkbBaktoitNT4QSiEywiTJWDavsfPV3rSSYDb3+z696YSenNiuTrJco/h48Bg==
X-Received: by 2002:a05:6e02:1aa5:b0:34c:e7a3:894 with SMTP id
 l5-20020a056e021aa500b0034ce7a30894mr688886ilv.16.1695146993561; 
 Tue, 19 Sep 2023 11:09:53 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 33/36] expo: Plumb in textline to cedit
Date: Tue, 19 Sep 2023 12:09:03 -0600
Message-ID: <20230919180918.2904313-34-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

 boot/cedit.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 407793aaddd..f2387170127 100644
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
 
@@ -295,6 +301,7 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 {
 	struct cedit_iter_priv *priv = vpriv;
 	struct abuf *buf = priv->buf;
+	int ret;
 
 	switch (obj->type) {
 	case SCENEOBJT_NONE:
@@ -305,7 +312,7 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 		const struct scene_obj_menu *menu;
 		const char *str;
 		char name[80];
-		int ret, i;
+		int i;
 
 		/* write the ID of the current item */
 		menu = (struct scene_obj_menu *)obj;
@@ -335,6 +342,15 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 
 		break;
 	}
+	case SCENEOBJT_TEXTLINE: {
+		const struct scene_obj_textline *tline;
+
+		tline = (struct scene_obj_textline *)obj;
+		ret = write_dt_string(buf, obj->name, abuf_data(&tline->buf));
+		if (ret)
+			return log_msg_ret("wr2", ret);
+		break;
+	}
 	}
 
 	return 0;
@@ -405,6 +421,19 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
 
 		break;
 	}
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
 	}
 
 	return 0;
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
@@ -521,6 +564,19 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 		 */
 		menu->cur_item_id = val;
 		break;
+	case SCENEOBJT_TEXTLINE: {
+		const struct scene_obj_textline *tline;
+		const char *value;
+
+		tline = (struct scene_obj_textline *)obj;
+		value = env_get(var);
+		if (strlen(value) >= tline->max_chars)
+			return log_msg_ret("str", -ENOSPC);
+		if (priv->verbose)
+			printf("%s=%s\n", var, value);
+		strcpy(abuf_data(&tline->buf), value);
+		break;
+	}
 	}
 
 	return 0;
-- 
2.42.0.459.ge4e396fd5e-goog

