Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251D0CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F184984895;
	Wed, 20 May 2026 01:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ti1AmOzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90DFA8483C; Wed, 20 May 2026 01:32:36 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6731F84874
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-69b692871e0so2139766eaf.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233552; x=1779838352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mj+t4zYgvrfK+Q/4zNf5VTymHd+GwkSeSBDWeZ4Qr8=;
 b=Ti1AmOzXOd9ekZMi9fgOFFfCJ3sYDbO+F7n+xDAB1jP206uYV/YsEtlwkeksyhEaC7
 dIi0F3tPQJONMScsvqmQxcVkMyvuCsaop6Kh9bzjAyQrOA3urlJkLF7YUIIBAG/BA3vA
 BhHBwxMs6oqt9iKIKHm0uIxM9GkTH4LG5HU50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233552; x=1779838352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/mj+t4zYgvrfK+Q/4zNf5VTymHd+GwkSeSBDWeZ4Qr8=;
 b=iGgqqNtlKTuXtNKV9ngTa65ccys+2hKVA2bEDk8bubf8zymrrqrNNFjULc64AAzOzc
 9EE/qKGyH4r+UvhCkiuvlBOiz/nRacWyLZ0Bo7ul0nuZ1V//SUr/mfzRg6IDYLLWrzCV
 3FQfb1NJvZR1BTwVdQkr8pMLjcRsKYYGFPtLgcfgSlXcJU1T7pZAYU+IrkB8mVAZzGWV
 zrKcNfbTdiNMExUoYsMC6EnR5UwtLMiokDc8Qb/62Mn6HmWdArB5GrdPbNkbcfwFu1HJ
 lwNRL4AGJ0NLaEm9jgkQtpyfYBmoZCdQUAheCOZWWw6L7Wu4qx1PNSKWSpI6A/vVQprf
 QEAg==
X-Gm-Message-State: AOJu0YwBTlJ8YvBkXhxInmCb1QUo9ZL3/7AdmwzOblnBDd8BimL4TBOJ
 ERpNTCe76Jeq407bqoMttXxqQg2PwGqvASJrYp00q3UWPbt68SykyZKyEQsxol7Cn3o7cUjZYvq
 Jw4tRrbKe
X-Gm-Gg: Acq92OEakuKZ0pyk5YutQM2sjU/zhrkWz3ZdyABe5zfe9UfB9QTktDWyKOTqDPWeXM7
 FgduUGQfsWZdj049uE0iNM6HDkRDY5HgQfOW3UafOAYV7EfisXdArt5NZEu4J4OXldjIZV0k3Y8
 3DAqMdWw5rkuPWbD+65wsZVK26/ZvJKi7zXG8hLkI/3ocEYNY0SLbuG85YqKCuUFL1YsPzd87uG
 M1kqjfYXIZWvER0TNDfBvDnL94dpVRIy7uVr+BCY6CDI8R8EkbXeg3gzIbFvF5X5W387uYaNobS
 4i9j17ZtsFGtFkmY/iq+b6Ivhkd1V+hlHDIfLOrTmb1RTs/DHi+BjUPTG1g+e9aXKIjxYgfu1+9
 Ef7/VxmfQFuis7/3iTurVCWIFR7iSxmDmVxmtzBsQXi2y4bzPaTdzd6lFkpIjelyBgVmFknYh+j
 cZJNXyK95zSmuHYTA2Xw==
X-Received: by 2002:a05:6820:1606:b0:695:b571:de99 with SMTP id
 006d021491bc7-69c5d3bab5fmr10859937eaf.1.1779233552169; 
 Tue, 19 May 2026 16:32:32 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v2 02/17] cmd: ini: Use strlower() to normalise case
Date: Tue, 19 May 2026 17:31:28 -0600
Message-ID: <20260519233207.2765755-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

ini_handler() lowercases four strings when CONFIG_INI_CASE_INSENSITIVE
is set, each with a hand-rolled loop whose strlen() in the condition
makes it quadratic in the string length.

Replace each loop with strlower() and fold the #ifdef pair into a
runtime IS_ENABLED() check so the body reads linearly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/ini.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/cmd/ini.c b/cmd/ini.c
index 96399017691..cf0a3ce8b3d 100644
--- a/cmd/ini.c
+++ b/cmd/ini.c
@@ -202,22 +202,17 @@ static int ini_parse(char *filestart, size_t filelen,
 static int ini_handler(void *user, char *section, char *name, char *value)
 {
 	char *requested_section = (char *)user;
-#ifdef CONFIG_INI_CASE_INSENSITIVE
-	int i;
 
-	for (i = 0; i < strlen(requested_section); i++)
-		requested_section[i] = tolower(requested_section[i]);
-	for (i = 0; i < strlen(section); i++)
-		section[i] = tolower(section[i]);
-#endif
+	if (IS_ENABLED(CONFIG_INI_CASE_INSENSITIVE)) {
+		strlower(requested_section);
+		strlower(section);
+	}
 
 	if (!strcmp(section, requested_section)) {
-#ifdef CONFIG_INI_CASE_INSENSITIVE
-		for (i = 0; i < strlen(name); i++)
-			name[i] = tolower(name[i]);
-		for (i = 0; i < strlen(value); i++)
-			value[i] = tolower(value[i]);
-#endif
+		if (IS_ENABLED(CONFIG_INI_CASE_INSENSITIVE)) {
+			strlower(name);
+			strlower(value);
+		}
 		env_set(name, value);
 		printf("ini: Imported %s as %s\n", name, value);
 	}
-- 
2.43.0

