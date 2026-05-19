Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235EECD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15594848CE;
	Wed, 20 May 2026 01:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gA+TCqFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873F9848B3; Wed, 20 May 2026 01:32:41 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EE18483C
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-682fce74c06so2633675eaf.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233557; x=1779838357; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZxjikXwa6mrQ4x1d/1Mipplv7G1pmAdMYExhNJwtKA=;
 b=gA+TCqFSim7OtMTlpQDEjr5IDRLe/aWGM/wEeba9y9o6Y87aFjpK+YhqbdBqYk5VAS
 S/s2UKPi5+NhJ7qEpaAz079WYo6u0vbeMOtQitjnlDt4veEkCTf5maZIEAdTtkWnAk+k
 gEj6rqCFLxAyp6eKiGcnYsxhR9uBkVLCtgXY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233557; x=1779838357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IZxjikXwa6mrQ4x1d/1Mipplv7G1pmAdMYExhNJwtKA=;
 b=po0i7Fvgx+xBVCvCPJgDu7i7tmEWoHWiqthfmD1JwMrj5BBJeU5QydSg2gsD9NC0/b
 5mJTCiqwzKxwrJPzMS8vOK1Y2pRGsJFpHnImFxZPgEu7W4QEmd9qQCqOK6BTdlNJMfC8
 nXXUX75YzM/91c/ZOFV9W4/88amERTxtnw96KB7fAhdRt4pwkOUlhzpoE36GraueVUQe
 jRYSMrxbWKkS2azj+XU18k/7z2xpivmZWczyXT+bq0v1ur+TzwUAAfDl8wwaUhoPm+LX
 nLoqwa4QCy0kOGGhs8DNaWs6g1lekDyjeJ0KILS56NJNOrxbVlO2QX2HtpPoHyijKJuF
 2wgw==
X-Gm-Message-State: AOJu0YwQ+3deFa6KzZ22pmS2arqWNN3xxo3NdnXtA2fqAobu6h4sPfFA
 v4ulF2KVDEpum4D5Li98/5q1xv5qoHqSyjE92r1xHbLna8PQaeodRenrxTIPmEVupTx33kXfEZ3
 xsWWuTJ6t
X-Gm-Gg: Acq92OGAD/IodPr+kEY/XrUdrXm4CJfeSc/to3QthFZy5pCzoJZAATvtXRPFSbLkWLh
 kMeJ6J1h+0ElL9yLTQI0AMsaTVxtahC/QgibepPpS5yrRMUtTYM1W50ehSPws9rlqSN+qpcqLw5
 T1Gxcb+s7cigQfOj6dJLacVuTluYK6GRBF5BrRC4rrw0eVwYPs4QxX/zSb81HMF0ekEkKmX8keg
 G3wmZfo9VsP+PsOaH+zbzxbHYsXFEZ9/Djv7HRlNOcq5N5IpHxhjtJE+lAqBnHsxEmsN3ZrZDWV
 olZopYd+QqYppnyxHDTlbYBVp6acccGZpT0HF0FeqzGgYumAVoJnl6bMFtWUcO0kUzvYq6u01XU
 2ghqDPdLUu1fAYh7T2ors+EZLGU3qb/KNyKm8JLBNBn0PsB4mItMtp4iTg3bNtquksKBaU4cj1K
 M/YUBLHjFO4bTQm9k7JZq4ZKFUUse7
X-Received: by 2002:a05:6820:174b:b0:696:29cd:bf4b with SMTP id
 006d021491bc7-69c94b454admr14848081eaf.51.1779233556922; 
 Tue, 19 May 2026 16:32:36 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Subject: [RFC PATCH v2 04/17] boot: pxe_utils: Use strlower() in get_string()
Date: Tue, 19 May 2026 17:31:30 -0600
Message-ID: <20260519233207.2765755-5-sjg@chromium.org>
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

The copy loop hand-rolls a per-character branch on the 'lower' flag.
Split it into a straight memcpy() followed by an optional strlower()
so the common path is a single copy and the lowercase case is obvious.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 419ab1f1b0e..098ee9bbbfe 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -950,7 +950,7 @@ enum lex_state {
 static char *get_string(char **p, struct token *t, char delim, int lower)
 {
 	char *b, *e;
-	size_t len, i;
+	size_t len;
 
 	/*
 	 * b and e both start at the beginning of the input stream.
@@ -976,14 +976,10 @@ static char *get_string(char **p, struct token *t, char delim, int lower)
 	if (!t->val)
 		return NULL;
 
-	for (i = 0; i < len; i++, b++) {
-		if (lower)
-			t->val[i] = tolower(*b);
-		else
-			t->val[i] = *b;
-	}
-
+	memcpy(t->val, b, len);
 	t->val[len] = '\0';
+	if (lower)
+		strlower(t->val);
 
 	/* Update *p so the caller knows where to continue scanning */
 	*p = e;
-- 
2.43.0

