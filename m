Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC90CC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECA582C90;
	Fri,  2 May 2025 16:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oWBe3A93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F188682C38; Fri,  2 May 2025 16:49:15 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801DE82C44
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-86135af1045so233979639f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197352; x=1746802152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wZHHS1rqbhljvq4dOo+drKl6eDabj2XOMhCp6rFwzU=;
 b=oWBe3A93wcFkpkggzrZ6Wu0NLu1Bm+l18ZE9EfxBafhTeQqO03HrzEJGE+uw08Pj4B
 kxHKqGDdLLHj/Z2DTnMyC2Clcz/nVOFYXQiyJhk9QjuzmXO8/rH3xk7KiiAuwLmXG/Fu
 9WR648K5jTp5BaWjD4UdmRaDzhDOeHZvcT+AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197352; x=1746802152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wZHHS1rqbhljvq4dOo+drKl6eDabj2XOMhCp6rFwzU=;
 b=lmDyvU9KqhzAlrB+3VKyCOeO/Xjs2hqAVKnbo9OxnrM1SNE3hPFeJt2AxW8O00mxxD
 pVbqrH32QL71MVEPpARcgP73jLt3UDnpKVhNzAvWG9lI9lskoDZWB4aSBElisUNAqEhJ
 p0nnO1djPa19U9UhSv7eshtd/FaNgrSGYMA3Ycn3lg1paV7e+r69sL/yCr2NKpNNOUpK
 i4RW9k7K2PYK45kYgZzSR1DzE/yMNzf5+ZJmkge9wMJ7MbTOtYPgwXNkdZmRMlAHljVD
 6+NX5OZgKDami3QdJLdhYdxOOuBYnw8cQo0VbpB7y/d9+HY2f3t8coGsWf5AL4OaL8Cs
 RvSQ==
X-Gm-Message-State: AOJu0YwW1dRc086/c91QsjwVrFNFEJeXE/irAFMj85cfCmmyqL1tESd+
 ZZ/DeFzbnzLkG3Y9NDogfIc44wXRxLWDtIuRbOkmDQzec05PvlGiaoZ4FEcNayo7FpXFmEJAyrM
 =
X-Gm-Gg: ASbGncvF8EK2mScGpuY2Bmf6Dc4WCZBBhXuPzA1huXRWc4jQbxVUMCOmmNncXR20Ff3
 o3VRBHF1Nz8FEXH719UkiuEUd+GGOA4i8LwVCxexc/jo7lLauvu3b6wKf+lAIaM7ujGN4RqpNtm
 C/DVytLRB219U6cJQjqI72PrmABZDs78FPHv5A1yAJnBm1Yp5LrWUKahjNjW9JhG9ADZQJ8TneZ
 5XhgGff/hViMDd5xblBttDiJxmV05w3WvlPHY6SU9Fv4y2fUAVZA8nNfOhJJogaP9CamB26ylPp
 NIN0fW0pm9bXtTRpmjQ+ZsRmRUdov8x8Vyo4oVxnkI+5V9FpMJPiauc39prdaXBuSQuAB389/j8
 Zsg==
X-Google-Smtp-Source: AGHT+IFZ1ukR7OL06Pv2G2GOnmKWHKr7jOYjrICACVU16GbpKqht4iZePS8zJY7LEp48KklBD3eLyA==
X-Received: by 2002:a05:6602:6cc1:b0:85b:3c49:8811 with SMTP id
 ca18e2360f4ac-8669f9bb649mr523682339f.4.1746197351728; 
 Fri, 02 May 2025 07:49:11 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 55/60] expo: Provide a way to position things relative to
 display
Date: Fri,  2 May 2025 08:46:53 -0600
Message-ID: <20250502144718.313633-56-sjg@chromium.org>
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

It is often necessary to centre objects within the display area. Add a
special position value to indicate this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c   | 5 +++++
 include/expo.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/boot/scene.c b/boot/scene.c
index 237f2bccc00..fa8f540bfb0 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -364,6 +364,11 @@ static void handle_alignment(enum scene_obj_align horiz,
 {
 	int width, height;
 
+	if (bbox->x1 == SCENEOB_DISPLAY_MAX)
+		bbox->x1 = xsize ?: 1280;
+	if (bbox->y1 == SCENEOB_DISPLAY_MAX)
+		bbox->y1 = ysize ?: 1024;
+
 	width = bbox->x1 - bbox->x0;
 	height = bbox->y1 - bbox->y0;
 
diff --git a/include/expo.h b/include/expo.h
index 2addddd5012..4dee479e9a0 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -242,6 +242,12 @@ struct scene_obj_dims {
 	int y;
 };
 
+/* special values for dimensions */
+enum {
+	/* width/height of the display */
+	SCENEOB_DISPLAY_MAX	= 0x7f000000,
+};
+
 /**
  * enum scene_obj_halign - Horizontal alignment of objects
  *
-- 
2.43.0

