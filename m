Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57571C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9279582A7B;
	Mon,  5 May 2025 17:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QqGy605A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8CA7828A2; Mon,  5 May 2025 17:44:12 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A648295C
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5bc066283so6794116a12.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459850; x=1747064650; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5sqKu8JZLcJFOYv87QuQnDaTnMjUYcmOlUomk49gjg=;
 b=QqGy605AK1+W/A8bpjQZI3PnnPxf31eahjecriLC+hcTHBj8ozWts4Tb65mI4eSWiI
 LJLvfIcdxNCyJMcjHKQT5cbxWVlJcNCblVaXyskwBg+7ejUC2irvHKFlzZ2Vc+Hu375N
 6PVaRRUpBjvKrmamYbpMTGR/UQbZ+F12noogg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459850; x=1747064650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5sqKu8JZLcJFOYv87QuQnDaTnMjUYcmOlUomk49gjg=;
 b=Mlf+tPDrt9d6WKClOppjVYEgWpyPklKfbCTx9Z8J7YxBPys4iGhmpJYAdvKjnCyH4o
 TfAcArEEu4+sbH5I3TMVS4t/BN7dDjN5gPTSyo7p5Y3RyP1YvNHqgGT9EGMFOH70xhl3
 vp7Ehy1yB0j/PBejGFyCwxepsSdh7D5iBy2zqCxMITk9ZMX5gxsa9QZuzeWLwzT90KJS
 9KJ0Srn6DbJvHuhmp2PcfyH6C0ffPqvnG75be/dfAzvAIqV/rIoV7Y6WwvsxfkL+n7eu
 8s4Zxrq4PsAAIky8JGLFhkrJV8zLqbVHcSaZ+Khc96n9iwN+uZOQli4/pvg+rVBSFYpY
 6efA==
X-Gm-Message-State: AOJu0YwKBApwojzeyISPOV44GWPH/2eKLC+tRIuH3/6YMDjzhjXKlcGj
 S8IKnSgdarVlTE7JUGCUcx9Uai9gzrir7ZxqbKqqme6krGQEwAzZKu07nhcn34UExLwnhCg5Kej
 OqSt2Z1Q=
X-Gm-Gg: ASbGncugIY02ueRpEHerfzEuljki41IWj+OajP5flEBfcMIX4EhQHCmHZ6VyPcLex+Y
 4WQlJSbvPMdCDxENsV/Wux6+F+mFTy013QGhfnCW2/4vAvE+oK0m1Ii6tpRvrm11BJDHpjkgBv/
 G4fTPgDYb+bTnucqetFqMmk73J+fXtp4Mu+4EFCca/oL5S4fruTPvLGGzAunLRW8sKX5RLuWwY/
 VqGuMV6kdMm+4aq+GX6vs2ZaIzDussmIwJO61x7Qajmnc+pldTU9/+ix3a+M1/VbQ4p3ZTva9Ue
 0JUpsuITkaEAU9TReH/4BigC7c69vjI4V+Yd
X-Google-Smtp-Source: AGHT+IHCJcdG1Uf9gz/v8vMC2MLzQbx+uTKcukT1e3sunZRE1nP/eWioaKbNOL+TveOwYl+VQIh7rw==
X-Received: by 2002:a05:6402:847:b0:5fa:82c9:7a50 with SMTP id
 4fb4d7f45d1cf-5fab05c26b6mr5817615a12.21.1746459849921; 
 Mon, 05 May 2025 08:44:09 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/19] expo: Check dimensions before arranging a scene
Date: Mon,  5 May 2025 17:42:50 +0200
Message-ID: <20250505154308.2911248-13-sjg@chromium.org>
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

It is possible that positions, styling or even text have changed since
the scene was initially arranged, so recalculate the dimensions of all
objects before arranging the scene.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c     | 39 +++++++++++++++++++++++++++++++--------
 test/boot/expo.c |  1 -
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 9c1eae3d52b..0d8599f955c 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -737,6 +737,31 @@ int scene_calc_arrange(struct scene *scn, struct expo_arrange_info *arr)
 	return 0;
 }
 
+/**
+ * scene_set_default_bbox() - Set a default for each object's size
+ *
+ * If there is not already a size, use the dims property to set one
+ */
+static int scene_set_default_bbox(struct scene *scn)
+{
+	struct scene_obj *obj;
+
+	list_for_each_entry(obj, &scn->obj_head, sibling) {
+		switch (obj->type) {
+		case SCENEOBJT_IMAGE:
+		case SCENEOBJT_TEXT:
+			if (!(obj->flags & SCENEOF_SIZE_VALID)) {
+				scene_obj_set_size(scn, obj->id, obj->dims.x,
+						   obj->dims.y);
+			}
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int scene_arrange(struct scene *scn)
 {
 	struct expo_arrange_info arr;
@@ -753,6 +778,12 @@ int scene_arrange(struct scene *scn)
 		ysize = priv->ysize;
 	}
 
+	ret = scene_calc_dims(scn);
+	if (ret)
+		return log_msg_ret("scd", ret);
+	ret = scene_set_default_bbox(scn);
+	if (ret)
+		return log_msg_ret("sce", ret);
 	ret = scene_calc_arrange(scn, &arr);
 	if (ret < 0)
 		return log_msg_ret("arr", ret);
@@ -1032,14 +1063,6 @@ int scene_calc_dims(struct scene *scn)
 						return log_msg_ret("get", ret);
 					obj->dims.x = width;
 					obj->dims.y = ret;
-					if (!(obj->flags & SCENEOF_SIZE_VALID)) {
-						obj->bbox.x1 = obj->bbox.x0 +
-							width;
-						obj->bbox.y1 = obj->bbox.y0 +
-							ret;
-						obj->flags |=
-							SCENEOF_SIZE_VALID;
-					}
 				}
 				break;
 			}
diff --git a/test/boot/expo.c b/test/boot/expo.c
index bf18199caab..0289350df9c 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -588,7 +588,6 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* render without a scene */
 	ut_asserteq(-ECHILD, expo_render(exp));
 
-	ut_assertok(expo_calc_dims(exp));
 	ut_assertok(scene_arrange(scn));
 
 	/* check dimensions of text */
-- 
2.43.0

