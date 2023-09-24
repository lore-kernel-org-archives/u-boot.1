Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7144FCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E1E086AE6;
	Sun, 24 Sep 2023 22:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QDbZWvk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE12586BA9; Sun, 24 Sep 2023 22:40:39 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E250986B5E
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fa87d8f7aso116396939f.3
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588036; x=1696192836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pp/O8iGGXDi6QTcawvo5vlnpZYgK1dK+YLqJyd6t42E=;
 b=QDbZWvk2fLROAoKjKll7jk1NUpMdclHI35GB0Z5PLPNIC/q4gPqEkKZp49j28TgySs
 G5GDKgYWJYAus22Fi6lYYmdMrOHR4q2CmZGbssdseZC/zetiRjA6okTjGFFfI3K7p2HN
 0h3VY6ruL9P0JpG/iD42/IznAy8na3WQpveOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588036; x=1696192836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pp/O8iGGXDi6QTcawvo5vlnpZYgK1dK+YLqJyd6t42E=;
 b=K4cbnKCT+FDjmtk5SLKDj0BbyBIfsfoyRukYZyTJUbol6koDZEaoHexl9b4SVwPQNv
 BSxjGz+W0Rgv62MQm5+nNt8Ff0TMZsWj6y0ClvfFYZamZHVp/aAgG/l6tYjptLtdMTzQ
 9XnhuJUrMVpB/N+jAuK04ZEYEdUtoqjPS7M+QdqRgWglFcDxt3Ry9u1mFr+ThjAeLnO9
 PEAslSTp239xCC+B6OYi9xMpvsb5JQ4gKRnM6aBsiVcGh8Wzhdm3drhBg1u/g2Oz+oxU
 eqvffZDeiYbOishvUadYWFXRr2SvFfvY4bgF0U8C0lVxj2PE5ziVV4bEk+DDwx3s77c8
 t54Q==
X-Gm-Message-State: AOJu0YynwKV30N6EAnmLI/+acvjV4KMh/0Kkt3PoIB+ChoEfSSznqNWC
 VJ5FZNErwAmzVdT2VyG3XG/sqpXDrc0+si6xurQ=
X-Google-Smtp-Source: AGHT+IHcfE5mUTVvVibPkGWfZbR4xgbZ+JCidXwKglcRXMkARFBz8eMj2h6/nGTDcMdiWRJ0y+oGZQ==
X-Received: by 2002:a5e:cb01:0:b0:798:26fb:ff2 with SMTP id
 p1-20020a5ecb01000000b0079826fb0ff2mr5996359iom.10.1695588036512; 
 Sun, 24 Sep 2023 13:40:36 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 19/25] log: Allow use without CONFIG_CMDLINE
Date: Sun, 24 Sep 2023 14:39:37 -0600
Message-ID: <20230924203953.1829820-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

When CONFIG_SYS_CBSIZE is not used we need an alternative. For logging
it seems that CONFIG_SYS_PBSIZE is a better choice anyway, so update
this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/log.c b/common/log.c
index b2de57fcb3b8..72a4de3274c7 100644
--- a/common/log.c
+++ b/common/log.c
@@ -206,7 +206,7 @@ static bool log_passes_filters(struct log_device *ldev, struct log_rec *rec)
 static int log_dispatch(struct log_rec *rec, const char *fmt, va_list args)
 {
 	struct log_device *ldev;
-	char buf[CONFIG_SYS_CBSIZE];
+	char buf[CONFIG_SYS_PBSIZE];
 
 	/*
 	 * When a log driver writes messages (e.g. via the network stack) this
@@ -268,7 +268,7 @@ int _log(enum log_category_t cat, enum log_level_t level, const char *file,
 		/* display dropped traces with console puts and DEBUG_UART */
 		if (rec.level <= CONFIG_LOG_DEFAULT_LEVEL ||
 		    rec.flags & LOGRECF_FORCE_DEBUG) {
-			char buf[CONFIG_SYS_CBSIZE];
+			char buf[CONFIG_SYS_PBSIZE];
 
 			va_start(args, fmt);
 			vsnprintf(buf, sizeof(buf), fmt, args);
-- 
2.42.0.515.g380fc7ccd1-goog

