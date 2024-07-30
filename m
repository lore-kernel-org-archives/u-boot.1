Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97116C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5EBC8887E;
	Tue, 30 Jul 2024 16:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mAHNN2l5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F7C788847; Tue, 30 Jul 2024 16:40:07 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8BF88860
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39b0826298cso3100465ab.2
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350402; x=1722955202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgBRgi7uiO3MGEWtwHDVpBMdOuDX2tObYXBYykc5QIw=;
 b=mAHNN2l5Am+cn8cJcmYfIY5dY7SKPNrTbA94Lea6+/a6RcNp2a69uv0+T3YaB2E4Dd
 ujYhmIP3VB5FCx4NwLB83ExLmUIsivDdlE4Wbp5Y6rl39rCWPxjiEr1gXtY/y7ESk/ZM
 t5GIpJU6RibQlweOhGKz9wJTHZ0BVaVI7o2aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350402; x=1722955202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgBRgi7uiO3MGEWtwHDVpBMdOuDX2tObYXBYykc5QIw=;
 b=HV56aiXQ5EZNQ57oyT+L4jbcwGdxxB7xb8rknqHtVcetslpmqoCwiJCJ9tSywYdITx
 XYQTlaLKmNIreAYsRKUkigurOsChqtukCCjvKKvRIMAojDpCNooE477QBol3piLb4uOW
 /CGis3Z+zzA0ROWSjVn5BFR97g4YODdvk5GDb9nHYkRhvHlerXc+UfuQ0n81oRrhntHu
 Ad1iQhWVcqbtPbsHs3w6tD53hlcg6weSSExD49SKx+Pis/K3+epKqcSKN72qk6aJhuDs
 I/tpcCbIMITqG/Vz7KocDxEMkOQEgR4Mnk/A/xMd34DqZ8NFQRZPZXe6yXgZ2hLvdS62
 iTwg==
X-Gm-Message-State: AOJu0Yx3bm9IfBRTI7Tx/aABHmdvNBv7fAZWzcKpEIrtbghnEFs1fCpW
 V0qg8HjnBkuqhhL4rbdZubCNLdI4wIrpgFiQOCIuqPS770Xdhh2AE+Z0fRkHS/EmT/FAHdMWnRk
 =
X-Google-Smtp-Source: AGHT+IG5uea2jkZfRV89Uaak56Aufo7RfdpEqB6R0Nj/5edisKpX9uQpafsGFQG9h8BRj6ww+4GRew==
X-Received: by 2002:a92:cdac:0:b0:39a:1d8d:fc9d with SMTP id
 e9e14a558f8ab-39aec40108fmr125678055ab.22.1722350401798; 
 Tue, 30 Jul 2024 07:40:01 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39af4bb209fsm23369925ab.5.2024.07.30.07.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:40:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 4/4] RFC: lib: Convert str_to_list() to use alist
Date: Tue, 30 Jul 2024 08:39:38 -0600
Message-Id: <20240730143938.3991937-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730143938.3991937-1-sjg@chromium.org>
References: <20240730143938.3991937-1-sjg@chromium.org>
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
index f83ac67c666..3ccdb81d022 100644
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
+		alist_add(&alist, str);
+	for (start = str, p = str; *p; p++) {
 		if (*p == ' ') {
-			count++;
 			*p = '\0';
+			start = p + 1;
+			if (*start)
+				alist_add(&alist, start);
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
+	alist_add(&alist, p);
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

