Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C58AC3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 14:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B4488717;
	Wed, 10 Jul 2024 16:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eYAVL5dj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EBF8871E; Wed, 10 Jul 2024 16:49:41 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A2088702
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 16:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4272738eb9eso9791385e9.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720622979; x=1721227779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnmVql2snz7A3M6LEzy18u3sVXZDrk2gWVcAemcwmuE=;
 b=eYAVL5djqorvrNL6fbYhDW254g5bxzy4dvghy/ctorbeOwrKHZ3ju2U4mkHIKm6zgp
 TWMB2xFDhKBvLawrNuFZxwOowVdk6viOw4XpK41bH6SsWSPP+JLbzKHUc3f8+E435+od
 xwZEpTv8H6EFkq7bQOXJNlBvWgaRSoD197zCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622979; x=1721227779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnmVql2snz7A3M6LEzy18u3sVXZDrk2gWVcAemcwmuE=;
 b=XphbuYhVnILWu3c1V8i0Oeqs99Lbb+8h9kUp7MfCc6dsm8/t7Lv09wuRzYYrK707rw
 2O6jvesiGBeNCAruBf+TjjcBOKpXkNMjaTr8+F6iM84fUXJZX8lO+infOY89JOBqMKbA
 pXS2gSJz7NdHNq1MejSlQSBdL4FS8TmQayAmglILIOt7Nwdjcyu37hRT4vGs5NxyTKvm
 vA4SRAHqgjKT5kGy1M35YoUcEu5eBamrCPjmlr/4dyYukYDXIjb5L617AUxOT00PyT4s
 a0UcDSKBwedsH2GyFobs6zfReCAwjNdmwOSI67btXTGDm4khlYvgn86O2Y5fnWDbtUYK
 5yOQ==
X-Gm-Message-State: AOJu0YzFw112971sTAtBlS5Vrcq4tEa2tFFnfQWoKCdWM5Wm5TbEnNEO
 TKnEUnTat2Dx0j/lQg4O9Wn9i3uZxNMf+NEEIWGpZ0rCkRKOQYs8C0uxUioIHNhK/uZVX5KkLSw
 =
X-Google-Smtp-Source: AGHT+IHUUNqou+DJlnAYdYc6lPlXMx8gJJuXhF30QF+PfepXFDOAyV3kS31Rqaz9uRpWyGoO6NUiww==
X-Received: by 2002:a05:600c:4253:b0:426:6353:4b7c with SMTP id
 5b1f17b1804b1-426705ce98cmr43552485e9.8.1720622979269; 
 Wed, 10 Jul 2024 07:49:39 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426615876bbsm171534355e9.6.2024.07.10.07.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 07:49:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/4] lib: Convert str_to_list() to use alist
Date: Wed, 10 Jul 2024 15:49:27 +0100
Message-Id: <20240710144927.3940789-5-sjg@chromium.org>
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

Use this new data structure in the utility function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

