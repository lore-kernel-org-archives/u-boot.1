Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A1AC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1146688711;
	Tue, 11 Jun 2024 20:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BrxSZEvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7788588703; Tue, 11 Jun 2024 20:51:03 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B4F886DA
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7ebc67365e3so28899439f.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131860; x=1718736660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSAuAzeKDu8+sZ8kys1m9gw2T6EAisPAxeUAY4kejUU=;
 b=BrxSZEvHuIQBHDda6XIiJM2f1/qQx5h/euyLzpnZyvkygCtRmrT8cfz3qrN2nylZd3
 gI6TVbJIfwEX2cUL/8AiERuMTAIuejfjjwMUTv+PzNU4KZXPJeavqUMnWZwzyTId5TTX
 Wc2aebE4EkWskWwjzrCn57vSQpmpkh7r8qvyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131860; x=1718736660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSAuAzeKDu8+sZ8kys1m9gw2T6EAisPAxeUAY4kejUU=;
 b=BB18KkveAoDS1jzDINRcAfOsq32tY5s3pwhKXqCMdKmLylM+pfDo18cw3HLl0H9QAc
 eCk1VatYvf/jJ3uRy07uQXCs2b0Srkct5dABoekMl8g0SiXrI3K2yemK6aJhbg5JHCgW
 OgseoIo9asqrlfkT2raMX7cIJJe6GNWzH8QN4J0oZXzY4rUnwySURh587eMGzfnvpVKO
 sPLyNei0z0fIEArV8ySaIpndj+l6IxYVsLP7raCAHdQyGJTpVccw29BbdxYoEmbYCXzs
 xXZemjT/e0Rl1MkzkTJ2FR9G9KokNz9F9DOkvhQxDMyvg9O9dABnSzzknbYxjCVL2wcU
 T47Q==
X-Gm-Message-State: AOJu0YwwLBMCkDlSKAcD5zhrt+SoFtgnN9cYbDsZSokD3fAY8dwjMgn+
 j7Bc9JPUAc8hPQX/SdIMR3EKcFk2/u+wxI7fWKR+GA+0MBdUXohEuaR1FnY+D3pbqEWm1beK2uf
 BaQ==
X-Google-Smtp-Source: AGHT+IGUES8uDWVVUOBiRbpWNSIsXgAlsykro8CZSZf3sJTlspCvReHHZUTdk+xZIzDQWY6rN3SNIA==
X-Received: by 2002:a05:6602:14cb:b0:7eb:7e0c:d186 with SMTP id
 ca18e2360f4ac-7eb7e0cd48bmr816264239f.16.1718131859830; 
 Tue, 11 Jun 2024 11:50:59 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-37594285ca5sm19645715ab.42.2024.06.11.11.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 11:50:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] lib: Convert str_to_list() to use alist
Date: Tue, 11 Jun 2024 12:50:51 -0600
Message-Id: <20240611185051.2223452-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611185051.2223452-1-sjg@chromium.org>
References: <20240611185051.2223452-1-sjg@chromium.org>
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

Use this new data structure in the utility function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/strto.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/lib/strto.c b/lib/strto.c
index f83ac67c666..f059408755a 100644
--- a/lib/strto.c
+++ b/lib/strto.c
@@ -9,6 +9,7 @@
  * Wirzenius wrote this portably, Torvalds fucked it up :-)
  */
 
+#include <alist.h>
 #include <errno.h>
 #include <malloc.h>
 #include <vsprintf.h>
@@ -226,37 +227,39 @@ void str_to_upper(const char *in, char *out, size_t len)
 
 const char **str_to_list(const char *instr)
 {
-	const char **ptr;
-	char *str, *p;
-	int count, i;
+	struct alist alist;
+	char *str, *p, *start;
 
 	/* don't allocate if the string is empty */
 	str = *instr ? strdup(instr) : (char *)instr;
 	if (!str)
 		return NULL;
 
-	/* count the number of space-separated strings */
-	for (count = 0, p = str; *p; p++) {
+	alist_init_struct(&alist, char *);
+
+	if (*str)
+		alist_add(&alist, &str, char *);
+	for (start = str, p = str; *p; p++) {
 		if (*p == ' ') {
-			count++;
 			*p = '\0';
+			start = p + 1;
+			if (*start)
+				alist_add(&alist, &start, char *);
 		}
 	}
-	if (p != str && p[-1])
-		count++;
 
-	/* allocate the pointer array, allowing for a NULL terminator */
-	ptr = calloc(count + 1, sizeof(char *));
-	if (!ptr) {
-		if (*str)
+	/* terminate list */
+	p = NULL;
+	alist_add(&alist, &p, char *);
+	if (alist_err(&alist)) {
+		alist_uninit(&alist);
+
+		if (*instr)
 			free(str);
 		return NULL;
 	}
 
-	for (i = 0, p = str; i < count; p += strlen(p) + 1, i++)
-		ptr[i] = p;
-
-	return ptr;
+	return alist_uninit_move(&alist, NULL, const char *);
 }
 
 void str_free_list(const char **ptr)
-- 
2.34.1

