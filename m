Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16C3C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24DFA82A33;
	Mon,  5 May 2025 17:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fIa/t79E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E6E82982; Mon,  5 May 2025 17:44:06 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34AD48291D
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso528706a12.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459839; x=1747064639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc54sRBpbOWCR5KCpMdz9edXaCrDcq7MDOhHERY2nj8=;
 b=fIa/t79EdykLC5SOBp2NYNFNm2nQUs80B7P65nwbuhZopIVCxHEzVz6zMDy0NsM1mH
 HAhNPp/a2tWs5oH5DNbqWPk1qyw8OgDH/S0deiJFUczdmz6czKgPRkjJPMcbBA/UN4LQ
 U3OT1QPCi3l6AXzUW8tLGAPXk4+IoKZaB+T98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459839; x=1747064639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc54sRBpbOWCR5KCpMdz9edXaCrDcq7MDOhHERY2nj8=;
 b=LjpjaZB67YvkMduKlHel+rzTPrLzVq3MDHDgRPJ0IaVo4JZcyT+tCvRP0GwjsFqfO6
 +2Wn+ekgKK/Eq9rjwCO0RMa6yEtGN+N+MolfQn5B5JFqPWQ0iXy2sWETpaMv0dpXHYzB
 X/gGtzWIa6mtXPbWex7UHykGpen7yIQnVV3Hh3tSaD3S1rcBx/9nfSvVmNybuoKdPr3v
 CDlDLSBblxGVp75Ms//qlk62bANC3d9oxyI2UVQdLKZ1O9qQhUWsREQZvHTbHsiMqrIS
 8Wb4cCF/x/E+FqxBKAkJ+pcEVlLGqe/eVk3k7zWPC4lL7oB2uVoVW7LEuIm2X/GolHP5
 aBNQ==
X-Gm-Message-State: AOJu0YytrqBoMUx51a+4QbhALIUjPPXJvSMHlgRG2IVz1VFj1brjgmPQ
 XIJWG7LLtOlCJRvbhYvrBEPWeQOqzIbESiZx/VfQ91CZJyC9qWpwOl75mw+TBD8WQuSeZ3rjGgh
 MS+yiaYk=
X-Gm-Gg: ASbGncvnyKXShRXBbDvgweBAdviJ3dteOTGBYWDFx4BgcN/32+aedZ7IsZyEPrTzBy4
 jgEMXKHraNhkv7lb4h+f9fyXdVhq1dWKPK/MRwkfYYmmXRzmE4Kbn+Px0eh0Yk9lkDme8kv9j+Z
 7ybeiGfYA7epjB4nOpbLkma2pKcAnTVV5zuFIWCnpUMeTKs6w86y/IJQIcsIv5nbXmk2m5DFqKt
 xotP986b8nDjZPNJOLfQKo244O77UdTWRYHlm0xDCl8T77Uk6ytd5G7X8lmos8GsHa0kalzWqVS
 g5eJuL2Yrl6qJYoN7rgTeogMXF4Nmm9mV8Nk
X-Google-Smtp-Source: AGHT+IGpDVFIQPx6JRoL3OEeoXdOAGkFcSm6vPeIvnfAdehMBWaDI4S6AhdBvAHAGgR4rj+6kBVYAA==
X-Received: by 2002:a05:6402:5254:b0:5fb:3a35:b8bd with SMTP id
 4fb4d7f45d1cf-5fb3a35ba6emr1303064a12.20.1746459838684; 
 Mon, 05 May 2025 08:43:58 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:43:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/19] expo: Drop the extra parameter to scene_calc_dims()
Date: Mon,  5 May 2025 17:42:43 +0200
Message-ID: <20250505154308.2911248-6-sjg@chromium.org>
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

We always call this with false first, then true. Drop the parameter and
handle this within the function itself.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo.c           |  9 +----
 boot/scene.c          | 93 ++++++++++++++++++++++++-------------------
 boot/scene_internal.h |  3 +-
 3 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index d09cc1861da..64d3febacdb 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -150,14 +150,7 @@ int expo_calc_dims(struct expo *exp)
 		return log_msg_ret("dim", -ENOTSUPP);
 
 	list_for_each_entry(scn, &exp->scene_head, sibling) {
-		/*
-		 * Do the menus last so that all the menus' text objects
-		 * are dimensioned
-		 */
-		ret = scene_calc_dims(scn, false);
-		if (ret)
-			return log_msg_ret("scn", ret);
-		ret = scene_calc_dims(scn, true);
+		ret = scene_calc_dims(scn);
 		if (ret)
 			return log_msg_ret("scn", ret);
 	}
diff --git a/boot/scene.c b/boot/scene.c
index 2ca82236300..2ea8e30ad83 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -1003,56 +1003,69 @@ int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox bbox[])
 	return 0;
 }
 
-int scene_calc_dims(struct scene *scn, bool do_menus)
+int scene_calc_dims(struct scene *scn)
 {
 	struct scene_obj *obj;
-	int ret;
+	int ret, i;
 
-	list_for_each_entry(obj, &scn->obj_head, sibling) {
-		switch (obj->type) {
-		case SCENEOBJT_NONE:
-		case SCENEOBJT_TEXT:
-		case SCENEOBJT_BOX:
-		case SCENEOBJT_TEXTEDIT:
-		case SCENEOBJT_IMAGE: {
-			int width;
-
-			if (!do_menus) {
-				ret = scene_obj_get_hw(scn, obj->id, &width);
-				if (ret < 0)
-					return log_msg_ret("get", ret);
-				obj->dims.x = width;
-				obj->dims.y = ret;
-				if (!(obj->flags & SCENEOF_SIZE_VALID)) {
-					obj->bbox.x1 = obj->bbox.x0 + width;
-					obj->bbox.y1 = obj->bbox.y0 + ret;
-					obj->flags |= SCENEOF_SIZE_VALID;
+	/*
+	 * Do the menus last so that all the menus' text objects
+	 * are dimensioned. Many objects are referenced by a menu and the size
+	 * and position is set by the menu
+	 */
+	for (i = 0; i < 2; i++) {
+		bool do_menus = i;
+
+		list_for_each_entry(obj, &scn->obj_head, sibling) {
+			switch (obj->type) {
+			case SCENEOBJT_NONE:
+			case SCENEOBJT_TEXT:
+			case SCENEOBJT_BOX:
+			case SCENEOBJT_TEXTEDIT:
+			case SCENEOBJT_IMAGE: {
+				int width;
+
+				if (!do_menus) {
+					ret = scene_obj_get_hw(scn, obj->id,
+							       &width);
+					if (ret < 0)
+						return log_msg_ret("get", ret);
+					obj->dims.x = width;
+					obj->dims.y = ret;
+					if (!(obj->flags & SCENEOF_SIZE_VALID)) {
+						obj->bbox.x1 = obj->bbox.x0 +
+							width;
+						obj->bbox.y1 = obj->bbox.y0 +
+							ret;
+						obj->flags |=
+							SCENEOF_SIZE_VALID;
+					}
 				}
+				break;
 			}
-			break;
-		}
-		case SCENEOBJT_MENU: {
-			struct scene_obj_menu *menu;
+			case SCENEOBJT_MENU: {
+				struct scene_obj_menu *menu;
 
-			if (do_menus) {
-				menu = (struct scene_obj_menu *)obj;
+				if (do_menus) {
+					menu = (struct scene_obj_menu *)obj;
 
-				ret = scene_menu_calc_dims(menu);
-				if (ret)
-					return log_msg_ret("men", ret);
+					ret = scene_menu_calc_dims(menu);
+					if (ret)
+						return log_msg_ret("men", ret);
+				}
+				break;
 			}
-			break;
-		}
-		case SCENEOBJT_TEXTLINE: {
-			struct scene_obj_textline *tline;
+			case SCENEOBJT_TEXTLINE: {
+				struct scene_obj_textline *tline;
 
-			tline = (struct scene_obj_textline *)obj;
-			ret = scene_textline_calc_dims(tline);
-			if (ret)
-				return log_msg_ret("men", ret);
+				tline = (struct scene_obj_textline *)obj;
+				ret = scene_textline_calc_dims(tline);
+				if (ret)
+					return log_msg_ret("men", ret);
 
-			break;
-		}
+				break;
+			}
+			}
 		}
 	}
 
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 95927472875..04218b4b911 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -117,10 +117,9 @@ int scene_obj_flag_clrset(struct scene *scn, uint id, uint clr, uint set);
  * Updates the width and height of all objects based on their contents
  *
  * @scn: Scene to update
- * @do_menus: true to calculate only menus, false to calculate everything else
  * Returns 0 if OK, -ENOTSUPP if there is no graphical console
  */
-int scene_calc_dims(struct scene *scn, bool do_menus);
+int scene_calc_dims(struct scene *scn);
 
 /**
  * scene_menu_arrange() - Set the position of things in the menu
-- 
2.43.0

