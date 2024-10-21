Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF9BD0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DADDE892F9;
	Mon, 21 Oct 2024 10:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dk9t3oNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68BC89320; Mon, 21 Oct 2024 10:19:44 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7730989315
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c94c4ad9d8so5457346a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498782; x=1730103582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AaSsGjrgxnXwIBFf83ObThR5I/JUFRzC8lCR6OepxS4=;
 b=dk9t3oNnQ7+GodlU85Vmvysy+aUiP/dkJHUIPH5FJgehyRbmDRZQopq7RVoepvKPNL
 44IUzUz+kU0UZBkwRMmOtVbv6HmiZWgo2aJA3eK13zhoVA13/BM2FrTKwshw43R6PJv5
 dzD1wVLyGfgUtn0rcsgCFUG7t3EWapfqeexjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498782; x=1730103582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AaSsGjrgxnXwIBFf83ObThR5I/JUFRzC8lCR6OepxS4=;
 b=gmyPv5PhOmFppbqJmikEnHua0Mw97s6OYw7bH3Cb4F+5iKndDchRKecUGtbjam/Wxt
 3rOCY3BFs8oee9z5KI+PHR/J2unX3mH11oOTp70Z55DVjnvW/GfWgNoJUe7anAFrRf//
 cBOVpsEqhFbvbGF7PDA+uB/Vz7w4DFvYJY84A55aU53Y/9HTtV+V943ls4skG1Az/+Mk
 6cdp2m8dC67041R0tYsZJrxoOXmFiVQm+iCY9fdBB0Rs/ZXeuqEI44q2gS15xwzzuFXf
 02gUFdE5TdsPx9kWojeewzcW9KFvgmyohugr/+bnmMIl3HCJe3ck5Y1rSm6udV+XZSXB
 gJwg==
X-Gm-Message-State: AOJu0YyzjzDPg1xeKop3Swy8HGEB6AVe/Tf51yHPK4qhqCcLYJWKPHal
 JN9GTRZuB1HfGEFbRwqeXsrfTUprCsVkYGfqsWcE3Zfbbn2traTsHcnVDHw2bGN2O7pCVKZRhdt
 3Hm4x
X-Google-Smtp-Source: AGHT+IHwxFUkX4N6rwvpK14b+JxY3OQh0VQTNaCgkpPfkQTEE7l76hVIGQIxoKvAOxDTMXVCSGSE+w==
X-Received: by 2002:a17:907:8f08:b0:a9a:6bc2:c0a3 with SMTP id
 a640c23a62f3a-a9a6bc2c0ecmr719975066b.7.1729498780491; 
 Mon, 21 Oct 2024 01:19:40 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v4 3/8] global_data: Add some more accessors
Date: Mon, 21 Oct 2024 10:19:27 +0200
Message-ID: <20241021081934.289473-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
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
index 644a0d77873..9dc0f4308cc 100644
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

