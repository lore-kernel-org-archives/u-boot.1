Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF11D216A3
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1148C8837D;
	Tue, 15 Oct 2024 15:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WOSHjAai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8099B88599; Tue, 15 Oct 2024 15:33:16 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC3988387
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-835453714cfso236998039f.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728999193; x=1729603993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTs2m2LEazCFjC2w7S6gxla0LXiHmR8Mb54eXUs9Km8=;
 b=WOSHjAaikQOnsSrkqijR1TJq445MH9njU8V0WiCJRoX7xAGj1hbvCZkhSpk9au6ikX
 LTPObwJpkOee6LPGe87o+nzlxDHLVbSfkha9kWn6zZXPlAHt1OG9exM4t1HkvkCML2e0
 DVUWHr3Sdoz+Y9JlXDJwivTANTce5F3yNqrTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999193; x=1729603993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTs2m2LEazCFjC2w7S6gxla0LXiHmR8Mb54eXUs9Km8=;
 b=k3N9tAf3fcna/ukFiPhQCfawfYZn2JqI39FqBDHwvNQZRiTlphfhA8cYyQDk5Nszib
 AYD8mI5fZH6ABf/6Kvr1taQuuPFkpugK3rdEHHy/VNRRutNxjX6fqA0xC32VOuaxTc3L
 OpA/P7uiNRICf0Gd5CdNckvnacTAY1pNTHSKBkj9WPWydl2wPR6zNyxkcSCGqt2g5bE3
 5h4VqgwGYQHZBuPvIjKADHak3hawY9nIhKJMA05BsY+h/th/6DVUbHIFWmo3zuQH7iww
 oshG8JA7/K8jlT5g8l8wtM01M7C4OBq1o1AX/L57/Nct0hhSzy4QTpnHngr+JswzIdSV
 Jclg==
X-Gm-Message-State: AOJu0Yx5oY4k814i6nA3BD3G8STUnPUCqug4xr5uC+DdTLYKmTAwBtnH
 fneAK0bg2y2Kd8FPEyY38aqLp49gj8PAEtX+kZGMxF7wvcUovSRBPCj9l75EWOQFu+p6nWp3O+B
 jBw==
X-Google-Smtp-Source: AGHT+IHWB0bnxlmV9pLlMnZ5oiSw2lOOpGPC9Pr5pvNyEh5ZNzQ2iZbg0o73WY2Tk2G+3ifWMwiuPw==
X-Received: by 2002:a05:6602:3c8:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-83a942f964dmr73143339f.0.1728999192868; 
 Tue, 15 Oct 2024 06:33:12 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83a8b28bed6sm29794939f.8.2024.10.15.06.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:33:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v3 4/7] global_data: Add some more accessors
Date: Tue, 15 Oct 2024 07:33:01 -0600
Message-Id: <20241015133304.2874735-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015133304.2874735-1-sjg@chromium.org>
References: <20241015133304.2874735-1-sjg@chromium.org>
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
2.34.1

