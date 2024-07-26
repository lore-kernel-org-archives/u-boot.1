Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD836C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FCCB8860B;
	Fri, 26 Jul 2024 16:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IPunNqem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A311885F2; Fri, 26 Jul 2024 16:00:54 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFB5885AE
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f85130660so40782939f.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722002451; x=1722607251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQNZLt+9sGNToxqYshYNk/xJFgja/vnCNvfTZJHxZw4=;
 b=IPunNqemfP3huYPhpOzBh17uAjST1sgj1KjwAk6CCU0EsDknZJCcWLrDGKU2lUF01M
 Q+aoeTxbqMexdnLKkkagVFqBF0snm8Xaj/Hj18eV7z58kLFr4GFBeAuCbTvdYQUFRdeV
 b1Sb+IyoxR6IncqyTo7IaBdVgDH8jEqfi68No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722002451; x=1722607251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQNZLt+9sGNToxqYshYNk/xJFgja/vnCNvfTZJHxZw4=;
 b=KTtH0+JF1S8lK9TP50aJATAkf5wcH7+n2PGoYuYtuFAT7yX0OxnzWjCM9X0dVp2uHS
 b16U8iPOjUNnzXLHSeQPDkExWr/a9tYmOHC+VpdbwCgzxYX3peV7Ogu4OAFlJxsP4n4M
 zW8dTlNLQibo5I4RtWoZKJquTL/F6+BJwhVqXuwogUJwil9QZkAHSJ2OxGCWGcUr5Hdi
 BIFz+2rFOOKvWikaX9gBq5HOOStHDBpN09AMTF4PqEOkTjZa7URxf+zQNZn3XmFDlOM2
 4KCqEz/n57RADHOzd0Q6C4WqAlC3+3FTQtOA4MvoZuvOH1Wsx09bP5ETF2ARJ7lfpVm7
 SqQQ==
X-Gm-Message-State: AOJu0YwOYkWfBIPhEOT6HJ0KaAtE+U6Hcl8si2GDJNwU3diTRlUZMdF8
 XlFcWvaROZQtH64Cilepg5glqXGqdDJxzpHmokpqVgUi5aKot7vVdS9tU1nXXQbNeUn5QfblTbg
 =
X-Google-Smtp-Source: AGHT+IG0/+OnIhbq90PRQthKnOW+4xFQJFw7iDikZbF6plvivcb7Ur2tWiByyldQgbLJToNbF4auXQ==
X-Received: by 2002:a05:6e02:1547:b0:375:bb80:d78e with SMTP id
 e9e14a558f8ab-39a21932a78mr48391655ab.6.1722002450781; 
 Fri, 26 Jul 2024 07:00:50 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7ec25sm14411905ab.6.2024.07.26.07.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:00:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/4] RFC: lib: Convert str_to_list() to use alist
Date: Fri, 26 Jul 2024 08:00:38 -0600
Message-Id: <20240726140038.194946-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726140038.194946-1-sjg@chromium.org>
References: <20240726140038.194946-1-sjg@chromium.org>
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

(no changes since v3)

Changes in v3:
- Update for alist_add() API change

 lib/strto.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/lib/strto.c b/lib/strto.c
index f83ac67c666..277e83b20fd 100644
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
+		alist_add(&alist, str, char *);
+	for (start = str, p = str; *p; p++) {
 		if (*p == ' ') {
-			count++;
 			*p = '\0';
+			start = p + 1;
+			if (*start)
+				alist_add(&alist, start, char *);
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
+	alist_add(&alist, p, char *);
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

