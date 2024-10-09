Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5ACCF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C9688FF1;
	Wed,  9 Oct 2024 03:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZUsAmY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086CA8900A; Wed,  9 Oct 2024 03:50:37 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E924888FCB
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8353fd2cacbso10011239f.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438633; x=1729043433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NXzyor/U8W9uTlkyQ2f5dk1zxVjYFA3QVD1GayELms8=;
 b=gZUsAmY/xfRHPqubOCXjm4tdv274ymHcdHipELZaqyP5Es8qeUEn4zmaJL4o9iaLax
 Q59s4YmzFrac3dXzrMmgUGRP0pHlcp1wv1me9GLySmzI2t+DGezacFegll5hYnZfFJTZ
 gwAUGfmyaocXe2jOgpAGhr0omx7iTkvSIyKUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438633; x=1729043433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXzyor/U8W9uTlkyQ2f5dk1zxVjYFA3QVD1GayELms8=;
 b=MQ+iKGB2kxAtIyFlwj+wF3shF62F9q1wPXQwUPckDcECkBbQwTO7FhpqsI5KrgmduH
 1FRuqJTkKPy/OJhf4POGtJNrqfYtvisyKLHjdR756AZ9v/Lmlr9E/4aFC3cH7GzzMb+F
 3sMeufSyiE5t5Jx0V9ECQ3k5owxHQ1Ks6Vr64UAs0zOe0VS9sSM9r5jA81RL6Y49V92Y
 9U/3zMQSSDLxxQS+o8NiUYOOlhp695cee1V2SSQbbYYwYTXzyd2xRY+yEKGXKnK2bEIs
 Nw4fGAATduFhx2WPzpV0cKxLs7/rseuaPdaSWX6+hEM5O6K5i5AI4xr29GskjC5wntYG
 P/MA==
X-Gm-Message-State: AOJu0YzLR+ls+EskCc6AuOnLF5w9sSTcibHT/BELhTDX6P2mrToL7A5F
 FodDQXvXTZ37gcr1NW65E4gHBRFGbv+pIgIZCBVgROJ+nP0KmP5eBmwqaRaEjZdQSMblEilM6Rp
 0zg==
X-Google-Smtp-Source: AGHT+IGlnWJLoSzkSR+F2mftFBmkU8OKbfNgtRxRVyeE8736C4q9VnspxjXVWtv0Lr1fZjhFOqjoPg==
X-Received: by 2002:a05:6e02:178d:b0:3a3:9337:4ce2 with SMTP id
 e9e14a558f8ab-3a397cda124mr7448475ab.2.1728438633575; 
 Tue, 08 Oct 2024 18:50:33 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a868967sm20677585ab.67.2024.10.08.18.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 18:50:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 4/6] global_data: Add some more accessors
Date: Tue,  8 Oct 2024 19:50:16 -0600
Message-ID: <20241009015020.25817-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009015020.25817-1-sjg@chromium.org>
References: <20241009015020.25817-1-sjg@chromium.org>
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

Add accessors for bloblist, bootstage, trace and video to avoid needing
more #ifdefs in the C code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index d6c15e2c406..fcf9fa27117 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -544,6 +544,36 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #define gd_set_upl(val)
 #endif
 
+#if CONFIG_IS_ENABLED(BLOBLIST)
+#define gd_bloblist()		gd->bloblist
+#else
+#define gd_bloblist()		NULL
+#endif
+
+#if CONFIG_IS_ENABLED(BOOTSTAGE)
+#define gd_bootstage()		gd->bootstage
+#else
+#define gd_bootstage()		NULL
+#endif
+
+#if CONFIG_IS_ENABLED(TRACE)
+#define gd_trace_buff()		gd->trace_buff
+#define gd_trace_size()		CONFIG_TRACE_BUFFER_SIZE
+#else
+#define gd_trace_buff()		NULL
+#define gd_trace_size()		0
+#endif
+
+#if CONFIG_IS_ENABLED(VIDEO)
+#define gd_video_top()		gd->video_top
+#define gd_video_bottom()	gd->video_bottom
+#define gd_video_size()		(gd->video_top - gd->video_bottom)
+#else
+#define gd_video_top()		0
+#define gd_video_bottom()	0
+#define gd_video_size()		0
+#endif
+
 /**
  * enum gd_flags - global data flags
  *
-- 
2.43.0

