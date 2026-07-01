Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44115C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A19A84C17;
	Wed,  1 Jul 2026 13:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XaYRR4ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6164484BBD; Wed,  1 Jul 2026 13:47:20 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA4884C10
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-494027f9299so1452680b6e.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906437; x=1783511237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbbU0cECWD7R6WwwJ5l7OJW/X9IV9fz+ixatD+k1P8c=;
 b=XaYRR4msFXMW9Ctqjrzadn4/9oIPmGeb63wbsGASqmBVeKwWp2CUjrvG8dNpUQXYbp
 OE8UMg9m4ggDmjCuj68gWcD8R7hxQDcn1yitBzz7IT+8BNSl3n9cGg9KqQll6gYDYz34
 04/ZrvtFdNmPDJatjuRhEjUpg3rzZ0WXjQJ8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906437; x=1783511237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NbbU0cECWD7R6WwwJ5l7OJW/X9IV9fz+ixatD+k1P8c=;
 b=jKxzoNACK8NQAGcF4pzrcYK4NXNQhi/r8CZ5QowlGAQJMF0HsbhxcSlav3kVnfwn38
 IPk1WgUzNYiC4FZEV3q45dQgFSyM8wwNYRm4YA8Qbnmn2xFvXF6CNtOm0prPXXYpT4ED
 3Dfr8mkSwXA99Ye3KSoyA1i1DDvyKcgOUqHDwFnHaztVf0M/K42JJflz2PckEvQGZaIK
 unNeZG54bo0tDrAzFFE90c2wzxPyCi9nD+j9h46PQJVnCnsD33eJubQiiFdSAQY91/CG
 YG+ej+yO7sYJ34SFPs6W6dKtUWodHz1j7C4snsIKuiXlyqRp4uB3wjC4duatPaDFWPIc
 4oyQ==
X-Gm-Message-State: AOJu0YytDqvgqKtCAYgmYLVt0MWdALisvYF7KMih7B0p5uoqMossk4CC
 N8zyeDLzYP95bC7tmxhOiRcFtvEhdtf6BGKBAlqHa7BzIAQY6sGhRUi5WbXQQR1P0vDBclbbQXu
 L88Y=
X-Gm-Gg: AfdE7cmqnjjNhJXBlTMqsmMtIQ383+m6YBSkYSQvcCfdG8qqeNzeeINGCLEr81Kn/tl
 A64hl0Qbcx0xnpdsVNPCuIOCpp2l74ja4N1KCykWqvXFMZQiuDG60PpmhxEPBEpye7OWB7gSW/0
 4GPgsIZqKG5XKQWQsyjbYslDn3vxGwUa0IpD39iv1kTOKZ78vZyWldDBeoajooKIqcTbqdWe2Ft
 BJOgHPFwD5/C54wrVupza5X0zy/Z4fOr9ft3UyWm//XLOgT0CUPuXVJN2HLDZAPpdgVDb+Uo5Ir
 JXK02HfCRxR1xKbqOjdukBT6typ4n2LOU24AEm6fQjT9LTEqPjWvup4xYjyDK3NUIWjlJ1K5I+v
 PCEsuBkYJKo0esIcCjFBp3PanBJ7Hy3C7AMqNReqxXUCFu9FQ+1PbrTxqlbk0ZzXy5WwFjmg6J2
 B6hy7aoyA=
X-Received: by 2002:a05:6808:6c96:b0:48f:1165:5172 with SMTP id
 5614622812f47-4960db336afmr771040b6e.10.1782906436869; 
 Wed, 01 Jul 2026 04:47:16 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:47:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 08/14] lib: string: Add strlower()
Date: Wed,  1 Jul 2026 05:42:28 -0600
Message-ID: <20260701114248.1396125-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
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

Add a helper that lower-cases an ASCII string in place. It returns
the input pointer so calls can be chained:

    do_thing(strlower(name));

A new test in test/lib/string.c covers the basic cases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/linux/string.h | 12 ++++++++++++
 lib/string.c           | 10 ++++++++++
 test/lib/string.c      | 27 +++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 850356d7c3f..35bc747300f 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -49,6 +49,18 @@ int strcasecmp(const char *s1, const char *s2);
 #ifndef __HAVE_ARCH_STRNCASECMP
 extern int strncasecmp(const char *s1, const char *s2, __kernel_size_t len);
 #endif
+
+/**
+ * strlower() - Lower-case an ASCII string in place
+ * @s: The string to convert
+ *
+ * Walks @s and replaces each character with its lower-case equivalent.
+ * Returns @s so the call can be chained, e.g. ``foo(strlower(buf))``.
+ *
+ * Return: @s.
+ */
+char *strlower(char *s);
+
 #ifndef __HAVE_ARCH_STRCHR
 extern char * strchr(const char *,int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 37ea8c29561..7ef439f9f35 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -65,6 +65,16 @@ int strcasecmp(const char *s1, const char *s2)
 	return strncasecmp(s1, s2, -1U);
 }
 
+char *strlower(char *s)
+{
+	char *p;
+
+	for (p = s; *p; p++)
+		*p = tolower(*p);
+
+	return s;
+}
+
 char * ___strtok;
 
 #ifndef __HAVE_ARCH_STRCPY
diff --git a/test/lib/string.c b/test/lib/string.c
index db6f28dbfdf..2e21ae5ccb8 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -332,3 +332,30 @@ static int lib_strim(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_strim, 0);
+
+static int lib_strlower(struct unit_test_state *uts)
+{
+	char buf[32];
+	char *p;
+
+	/* Mixed case is fully lowered, returns @s */
+	strcpy(buf, "SHA256");
+	p = strlower(buf);
+	ut_asserteq_ptr(p, buf);
+	ut_asserteq_str("sha256", buf);
+
+	/* Already lower-case is unchanged */
+	strcpy(buf, "abc");
+	ut_asserteq_str("abc", strlower(buf));
+
+	/* Non-letters and digits pass through */
+	strcpy(buf, "Hello, World! 1234");
+	ut_asserteq_str("hello, world! 1234", strlower(buf));
+
+	/* Empty string */
+	strcpy(buf, "");
+	ut_asserteq_str("", strlower(buf));
+
+	return 0;
+}
+LIB_TEST(lib_strlower, 0);
-- 
2.43.0

