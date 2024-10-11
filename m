Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01ABD0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE9C8940E;
	Fri, 11 Oct 2024 23:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mgHOq6lN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401E1893DE; Fri, 11 Oct 2024 23:40:44 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E37893DA
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a3bd664ebaso497305ab.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728682841; x=1729287641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxL9UB0M4AHLMw+W9M04lCEBiKILByvygojnYHpOrGc=;
 b=mgHOq6lNm3UVFawIc1XK+jUsLauaIG1L0VWu3vHTIhVV70RQa944HRaeJACxFTZFCc
 aNp4oUj/gGkErTTdDgBKFsNwynd/q3WillRGVkn4e2Yt9pc/77Qdx4cA8XXKqstNJewm
 eNN7ZsjuZjm0ZgXeXMLF8WuVdQ4oiX5rad75g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728682841; x=1729287641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxL9UB0M4AHLMw+W9M04lCEBiKILByvygojnYHpOrGc=;
 b=qzcYH+WlFfMGjOJ7ZqZar7kekCEv9CdVY87u2o7BWyMIrWkS0hvMEJzesuGIo4bJzi
 FOIpx+47lcb6Pxh4PsKR5NZO4+wR7/bwJ6Wwe2xh8lLw3VY6OtKULzZyCpDcJFTDEeJh
 M3TyodIV+vBKiOiN/TcR6LM8lClnAef+tI73I4gveIGoslxakT4iLTWv+G01nt9VsNPa
 YofSTSXNLHXM6SFs2Zh2RTRydV6WDHnQOcFdAsEqFYI4ejkQ9rXOHHOMXCFdMhogLbKo
 3RFXLWKcmizoF1I0p3XJjoobW9gkS0H7t2IiEEi6n5m1UxGWCJi9WJS07QfmifGkWSEp
 FqRw==
X-Gm-Message-State: AOJu0YwaEy0lDm9R+PJKDz/rWG8fhbF6jAxHfB191tKar9dk4mMhhZxs
 sArDyO30vvwTDYCuzG4ChyT40IxOsufGwgRqM3WKFL/JpF9Fx0MDfEju5+RFAGJBkLHOglfdDqr
 5XA==
X-Google-Smtp-Source: AGHT+IH5oG1rGQTfaQnYnfGV+tkM22PHlLtU5qJIO0o4ltbISuckGfYdu6PkxJQezm5v5jrPGVmsSw==
X-Received: by 2002:a05:6e02:1c4b:b0:3a3:b3f4:af4c with SMTP id
 e9e14a558f8ab-3a3b5ffd784mr28168345ab.25.1728682840701; 
 Fri, 11 Oct 2024 14:40:40 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a3afdae0f1sm8830475ab.11.2024.10.11.14.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:40:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/7] global_data: Add some more accessors
Date: Fri, 11 Oct 2024 15:40:28 -0600
Message-Id: <20241011214032.760072-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011214032.760072-1-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
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

(no changes since v1)

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
2.34.1

