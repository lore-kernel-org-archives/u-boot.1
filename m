Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C42C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A446F88E31;
	Wed, 21 Aug 2024 18:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JuFlyNm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1664488E0E; Wed, 21 Aug 2024 18:19:48 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C9488E12
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70942ebcc29so4690962a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257184; x=1724861984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HU5C7LW9WPP7cRcw1w2kOE4Zybh8O+6F1PGi99Gy5co=;
 b=JuFlyNm+3qlx7XklJF5c/ef71JuHDQJiPDytG6IwuQBXlgrJY+tGYPdtIn5AlTjkUE
 EgSXOXpxNRm0s3OGm3GSuZ3ftFha2tbqV7jbT2xBGwM8U1mnFr/YcZ+SNOz+4xPx4ql+
 r7stVz42FdcK1CIQuESZpjjmGm4HaRVjGUEWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257184; x=1724861984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HU5C7LW9WPP7cRcw1w2kOE4Zybh8O+6F1PGi99Gy5co=;
 b=ndl7N1qrIAevKuayK2cn5pTTJLqsG7e0beyjHo+yxOoj/00mgepewcmgJJ0u812Qy1
 EVlCBe3geCpQk9psMtvN7cGvGdXjE5t96pXvYPgr05QEoGBvCkukfCgkiwbypdwKBsvv
 nC44Qd+CU8l65tYghNngpTJSiFS2NzGQ5/MOCAleRgaF2cnTwN1BTSQPsgEZ9gmHUD0Y
 +MJLaV/plIAHimVfxD0ZvLDRKvQfua9fM6nA6vpolAQgzg6tBNsspir74iVT6XkdEwJq
 UPrejK57NIe26egZSA901GyCn7xOI70Ti1DuX8sMJE+nAYdZQiSEh8YcPywqYS4A/l14
 zRnQ==
X-Gm-Message-State: AOJu0Yygl/yELJLf/0/I6eQgNtMIKbOHtaiQnGHD82E5LBSS84EE4bdc
 P0R2xeIUyDEmMLe4g+csEhbNIcmCBBkZZDsAHu6rcvTPguH9n05kJhgnBGPSGaH3cP5Bga6pLwM
 =
X-Google-Smtp-Source: AGHT+IGyJZtkX+U3s60qyEUyS/1K1XVT6gNsg0Q5FvQ+UOi2ly52l+6VphcahwH3hoDWsKzB38rwKA==
X-Received: by 2002:a05:6830:448a:b0:709:2721:ad44 with SMTP id
 46e09a7af769-70df87095bdmr2583641a34.12.1724257184666; 
 Wed, 21 Aug 2024 09:19:44 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 10/35] video: Avoid setting global_data fb_base in video
 setup
Date: Wed, 21 Aug 2024 10:19:02 -0600
Message-Id: <20240821161927.695717-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This field is not used, so don't set it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/video-uclass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index ef780a6730c..41bb7647fda 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -145,7 +145,6 @@ int video_reserve(ulong *addrp)
 		*addrp -= CONFIG_VAL(VIDEO_PCI_DEFAULT_FB_SIZE);
 
 	gd->video_bottom = *addrp;
-	gd->fb_base = *addrp;
 	debug("Video frame buffers from %lx to %lx\n", gd->video_bottom,
 	      gd->video_top);
 
-- 
2.34.1

