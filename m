Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D23C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 14:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70FA8870E;
	Wed, 10 Jul 2024 16:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XUruOlyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E170F8871E; Wed, 10 Jul 2024 16:49:40 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02788870D
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so21407375e9.1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720622977; x=1721227777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiorbJr5W30iyqHwCPgZi6RbEbcE4DwrMZBLGDyP3qw=;
 b=XUruOlyxndoEBd8hQr2aBsUsr4+VDGGkF3MtaOSjK5pIdqnxxKOfHmDUYKG0k2fj0i
 vKMhTn/iz1zvnKW4qxN3VXdhEdOneRNMYMBRNWwg4BzAOUbAjOQX3+VQPhbAVSZPOxUX
 PnAjNlrFyqJXfJYSUmvi4TIp2136oehI80vzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622977; x=1721227777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LiorbJr5W30iyqHwCPgZi6RbEbcE4DwrMZBLGDyP3qw=;
 b=j5mPkG+zXBb278hC3v1iXst/lHZmsJTudulGtXC3oTdJQVM7+2y7t533Hp117Vriiv
 VF/PqhuuhiQ2tcMMH4TGWtmKzeVW2TcrwMWTD1hQxRDsLO0LHbVgDz211PqL9Vipt+fW
 BJwQGi1saCzW8UoTbtHm4XBKKCFuaxVXABadpwM3LDVg4yIMZE/Q+h4Ru4CH7hgn/yMw
 zlarpzv85FJGUiI9Uak6AfUZfnuUR5xLmqaPpaUEG9vM7fqu3yqXigMzhOsvdKaZsLHo
 jaoVYuzy3bKwvEjM8ZM9WFOruk4W8Vt3Ty2C/+QJ/KluqZ4buLpjRaDzXoJx0/XTFdua
 i4Pg==
X-Gm-Message-State: AOJu0YxrzNkxt5suE3i9PgvrsqX8pNxlQ6EnEPQc3pNPwMC3lPKvLAUj
 qtoRA6N1iKlI29sMQJqmo87PQ6dBlm0ARKBn+Si8d+fOJ/Ty/hoTOx7xBl7/rRNGZoWDv89VUV4
 =
X-Google-Smtp-Source: AGHT+IGLe32ePE0PIfjxj0bDttrvA1NwSTVJqTd0I8oUi6bzQzL0Xqm4LGb7I/2KFXTiSyOgpB3eFA==
X-Received: by 2002:a05:600c:5748:b0:426:597c:7d58 with SMTP id
 5b1f17b1804b1-426708fabf5mr35349135e9.39.1720622977142; 
 Wed, 10 Jul 2024 07:49:37 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426615876bbsm171534355e9.6.2024.07.10.07.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:49:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/4] lib: Handle a special case with str_to_list()
Date: Wed, 10 Jul 2024 15:49:25 +0100
Message-Id: <20240710144927.3940789-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710144927.3940789-1-sjg@chromium.org>
References: <20240710144927.3940789-1-sjg@chromium.org>
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

The current implementation can return an extra result at the end when
the string ends with a space. Fix this by adding a special case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/strto.c   | 4 +++-
 test/str_ut.c | 4 +---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/strto.c b/lib/strto.c
index 5157332d6c1..f83ac67c666 100644
--- a/lib/strto.c
+++ b/lib/strto.c
@@ -236,12 +236,14 @@ const char **str_to_list(const char *instr)
 		return NULL;
 
 	/* count the number of space-separated strings */
-	for (count = *str != '\0', p = str; *p; p++) {
+	for (count = 0, p = str; *p; p++) {
 		if (*p == ' ') {
 			count++;
 			*p = '\0';
 		}
 	}
+	if (p != str && p[-1])
+		count++;
 
 	/* allocate the pointer array, allowing for a NULL terminator */
 	ptr = calloc(count + 1, sizeof(char *));
diff --git a/test/str_ut.c b/test/str_ut.c
index 389779859a3..96e048975d8 100644
--- a/test/str_ut.c
+++ b/test/str_ut.c
@@ -342,9 +342,7 @@ static int test_str_to_list(struct unit_test_state *uts)
 	ut_asserteq_str("space", ptr[3]);
 	ut_assertnonnull(ptr[4]);
 	ut_asserteq_str("", ptr[4]);
-	ut_assertnonnull(ptr[5]);
-	ut_asserteq_str("", ptr[5]);
-	ut_assertnull(ptr[6]);
+	ut_assertnull(ptr[5]);
 	str_free_list(ptr);
 	ut_assertok(ut_check_delta(start));
 
-- 
2.34.1

