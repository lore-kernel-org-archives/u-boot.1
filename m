Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C137C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 14:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA0988738;
	Wed, 10 Jul 2024 16:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z3EFy94N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D14288702; Wed, 10 Jul 2024 16:39:04 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61D4D88714
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-36796d2e5a9so4270599f8f.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720622341; x=1721227141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ia3EdFVcMyePdPJ8allmepkCpXdBNxe3/qyB1EGi44A=;
 b=Z3EFy94NMVjZVlmmWHIp4cnIy9B4XbCks4E+MeEDeBHFL3MO0GCtLuTS2emXIbcVKZ
 80Rra/t5jt+g9glp5cCME1sqsNU9EWwLRUcakbKZkrZ5/P/vqsGP/D77M9zRYLCjMXWe
 3sF2spmHv6yWvGuePqk+47wXgTxuZVQc04bi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622341; x=1721227141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ia3EdFVcMyePdPJ8allmepkCpXdBNxe3/qyB1EGi44A=;
 b=DAmOE6RN0/6gLT9DFL2FW9cq6IpR+4TRwilxQFiu6YOZNYGp1GtJdqLTRH5QlGqL5n
 hVNyYemYQ4U8MDvf3/2aIX4SuuZ3jmOxnWlSPePGFLfkQOv3vYm7Ck/PrdY6jzqf0RXh
 xkteX1wOlGyavF89OmYfwIRfPIQ9zkz417ugzuGaN7/1HT1lCKSfQz2rfVH9BF7bC9MZ
 l8taQYhGvF4d5R81PRpoE151iNcr8MUYBxRL3sgqSE0O/nMx3h45WUDQkO7FPjxY260x
 TTSVTuXoohR/mmaDnAz54dIQsafeAC+LErJLIDRuv8f0glR9zfzUkR/x0wFErdh9ujO1
 vGFg==
X-Gm-Message-State: AOJu0Yw0X3AMgpNFa8aSLiEDpRGHXI0Xc25fwzNb0GfjZ7VAbZzawijO
 bp5/SespJLz4TjGmWPl7Bdi8zLWCALroI6VQxYURaHLv9xGDWR3MkISX7aDaWrFjEq8XAYXTUA8
 =
X-Google-Smtp-Source: AGHT+IFsHcyWdT7hygRMAnAv/oJWxs9iExnuu70XrvAd6irhjAHcLqAGcnwaYMjRHKLZdlLtD89A1Q==
X-Received: by 2002:a5d:4d51:0:b0:366:f469:a8d with SMTP id
 ffacd0b85a97d-367cea9206cmr3879072f8f.35.1720622341729; 
 Wed, 10 Jul 2024 07:39:01 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa07dasm5471374f8f.87.2024.07.10.07.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:39:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/4] lib: Convert str_to_list() to use alist
Date: Wed, 10 Jul 2024 15:38:54 +0100
Message-Id: <20240710143854.3905259-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710143854.3905259-1-sjg@chromium.org>
References: <20240710143854.3905259-1-sjg@chromium.org>
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

(no changes since v1)

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

