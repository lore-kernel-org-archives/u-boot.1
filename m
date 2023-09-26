Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DD0E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ED3586D92;
	Tue, 26 Sep 2023 16:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BAAFIQ+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB70D86DB8; Tue, 26 Sep 2023 16:15:36 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF5486DB3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79fe8986355so7362739f.2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737726; x=1696342526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssy0jUFvmu5+yh6VvKGTwGLodOO/J3W1in21MxGDhzU=;
 b=BAAFIQ+vOskiEiBG8dHYQAuHfINthmja9t0RiJvrnNfYRUOJAPqgSPD/qmcoIHMRbJ
 aMgyesnyBBvbGp4yxGk2dszupybuEEHg3mKCtNB1Cn+QoiCDEPq+lymtHvT8U4T/Sn2D
 7jUd8s90qMHDN6becWehmiAQgHGAa3N56bar8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737726; x=1696342526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssy0jUFvmu5+yh6VvKGTwGLodOO/J3W1in21MxGDhzU=;
 b=ZqlLyfehvYjXRoozvnvvF6YVqb2PdoDtY+DOYwM06FC8bfVHtQGFYe/G9tX6MSYmL0
 wJApUafup+rpxGV36iAz8SIlsjSpdcivEOXiQ5c8wwwCJ+tOB9R96j2lTDwYQSWZUNmR
 s7ThnAsalH7qTVYg7gODalhFePvDHc7OwEr73sNUX80eaTTaW0koC7YaviWrshXqvR6e
 ji9YHcrdtYcCzwKXBgTdyqE+zRnwQUVZ2Le3VvD680iKLa4jZCGD0VAtkuEq0nHjs8BA
 yFtgpL4CIOGisQ31QrBqKTZmnnRu4tUDEL7axlxUsZTHQajRDAXcUQcoNUiM4lliLugy
 ETqg==
X-Gm-Message-State: AOJu0YztEQpT7G1H5+HuLD1HdgdBubYPC/c+wRNz4fu2+oz8dqMiBM/I
 8cqabwg1wVkR59I01uaeo4f1K/Vc2694gWiJwKU=
X-Google-Smtp-Source: AGHT+IEb97QP1DKQ5vh93yU/q5nyma2SkkqXTLZ5vWKuRxsTPoxjMLrIAuXWAxcrDlRHtLpv1PnmwQ==
X-Received: by 2002:a05:6602:130b:b0:787:1472:3181 with SMTP id
 h11-20020a056602130b00b0078714723181mr10897838iov.3.1695737726510; 
 Tue, 26 Sep 2023 07:15:26 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 04/44] spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
Date: Tue, 26 Sep 2023 08:14:18 -0600
Message-ID: <20230926141514.2101787-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

Use IF_ENABLED_INT() to avoid needing to use the preprocessor.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Improve readability by moving the size part to the header file

 common/spl/spl.c           | 8 ++++----
 include/system-constants.h | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 657886dfe5b0..5cc86288145b 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -754,10 +754,10 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 
 	spl_set_bd();
 
-#if defined(CONFIG_SPL_SYS_MALLOC)
-	mem_malloc_init(SPL_SYS_MALLOC_START, CONFIG_SPL_SYS_MALLOC_SIZE);
-	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
-#endif
+	if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
+		mem_malloc_init(SPL_SYS_MALLOC_START, SPL_SYS_MALLOC_SIZE);
+		gd->flags |= GD_FLG_FULL_MALLOC_INIT;
+	}
 	if (!(gd->flags & GD_FLG_SPL_INIT)) {
 		if (spl_init())
 			hang();
diff --git a/include/system-constants.h b/include/system-constants.h
index f0a191be590e..dca6a86b01f5 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -24,9 +24,14 @@
  */
 #ifdef CONFIG_SPL_HAS_CUSTOM_MALLOC_START
 #define SPL_SYS_MALLOC_START		CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR
-#else
+#elif defined(CONFIG_SPL_BSS_START_ADDR)
 #define SPL_SYS_MALLOC_START		(CONFIG_SPL_BSS_START_ADDR + \
 					 CONFIG_SPL_BSS_MAX_SIZE)
+#else
+/* feature not enabled: this value avoids compiler errors but is not used */
+#define SPL_SYS_MALLOC_START	0
 #endif
+#define SPL_SYS_MALLOC_SIZE	\
+	IF_ENABLED_INT(CONFIG_SPL_SYS_MALLOC, CONFIG_SPL_SYS_MALLOC_SIZE)
 
 #endif
-- 
2.42.0.515.g380fc7ccd1-goog

