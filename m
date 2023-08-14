Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DEAC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96115869A5;
	Tue, 15 Aug 2023 00:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DksBayM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138C0869A5; Tue, 15 Aug 2023 00:41:20 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C813869A0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34978cc9e53so18852355ab.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052876; x=1692657676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTfYjW53VLano6prckfNj3jOWIjpKKIY+xcqYJGle0M=;
 b=DksBayM6lSUp9uxiI6zG/85KqXYmgwhUpzyK3cNrxQZ4PZ5igrk+u9JYHgyIWeQVHQ
 hIvzMT6sGdF/qB4CuIckNySPOgATYzemZaJM6yJNM2Y7b5jeDhnS8so9JRRJDPyu39VU
 bTXuehbTMnGQvHj14gIOmZOFXhWyeGfAKZlXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052876; x=1692657676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTfYjW53VLano6prckfNj3jOWIjpKKIY+xcqYJGle0M=;
 b=C1A1EqIHLvnbamNkoNO8Qt2Zkl01xoWqHfVcYsb7MVIIv1vrRNJvuhu5tYizBJxdWH
 LWKKe5PFSdxwAN4iuxSjB3S/yhq8CpMBoV6xUBoVeF6+8+Pqrb4VB+v79j/GR5dVhWjX
 AB9IesrwAo6sbAE+uFrPbPO6qMn4zfpceGpL9DFs8qqRP9mTLlShSwaCxl09L0g2Qn8K
 /J3GAUFzaO7Mwc6Pa2kSHXqGNDvyzyRuh3LwnAwKy8RoZZ8FIDRj7Y5rHB0FxW5z/Zfk
 0e2BddbxYVChk0cnShr9q3Sle92Va0TFuGKI2LqEdw69PguRsPS/qZ9bKg2D3S3RNdlq
 eb6A==
X-Gm-Message-State: AOJu0YwqN/Ovi7/1dZpxcYIyAKBdOBOLR7oKw9+Vn6Dp7Y2vx3F8SxfH
 4S+YXmPO+HnCYrNv93j0PZHbJHYDvqgfKjCUQCA=
X-Google-Smtp-Source: AGHT+IF2EnPO1ApNU6DU4aLn3IDVZOBhRHHxsU4wBhh/NV3nu5TI8x/zcHPdyIqh7Qi8/r/SAhVO3g==
X-Received: by 2002:a05:6e02:12b1:b0:348:f6cb:e585 with SMTP id
 f17-20020a056e0212b100b00348f6cbe585mr11916076ilr.30.1692052876652; 
 Mon, 14 Aug 2023 15:41:16 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 01/19] expo: Make scene_obj_find() take a const scene
Date: Mon, 14 Aug 2023 16:40:21 -0600
Message-ID: <20230814224047.535491-2-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

This does not change the scene, so mark the pointer const.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 2 +-
 boot/scene_internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index e52333371f9c..b4c36c41702f 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -79,7 +79,7 @@ int scene_obj_count(struct scene *scn)
 	return count;
 }
 
-void *scene_obj_find(struct scene *scn, uint id, enum scene_obj_t type)
+void *scene_obj_find(const struct scene *scn, uint id, enum scene_obj_t type)
 {
 	struct scene_obj *obj;
 
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index fb1ea5533b9a..1620d10a7778 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -38,7 +38,7 @@ uint resolve_id(struct expo *exp, uint id);
  * @type: Type of the object, or SCENEOBJT_NONE to match any type
  * Returns: Object found, or NULL if not found
  */
-void *scene_obj_find(struct scene *scn, uint id, enum scene_obj_t type);
+void *scene_obj_find(const struct scene *scn, uint id, enum scene_obj_t type);
 
 /**
  * scene_obj_find_by_name() - Find an object in a scene by name
-- 
2.41.0.694.ge786442a9b-goog

