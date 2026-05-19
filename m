Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9215CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88138487F;
	Wed, 20 May 2026 01:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DdPgyhrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F5938487F; Wed, 20 May 2026 01:32:32 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157D084707
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-69d5730c579so306587eaf.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233549; x=1779838349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAWy4x3L7iVhOfpo3qlb/RzGnztLZNVn08IC/AWyY+E=;
 b=DdPgyhrhOtF7BwBXkhRqZgsU8Bxo3oMkATdMjJNM7eg73LGZORDyCKwDYQDiLg3gZL
 YwBRnrXkEgHXnj9t15rqPynRVsab77S520bEq0kCpdm1RFcOUmh/UoYJrU0rMpWw0xl4
 wS6VPqa+ElQUQzsCQMxcyFbbfcq5fmWIq3Edc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233549; x=1779838349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pAWy4x3L7iVhOfpo3qlb/RzGnztLZNVn08IC/AWyY+E=;
 b=cuuw6UxyzqDyM845n9dhq0GcVMrRVr4XRMefvvqWwN4SWDQ6Ato9LIaCTqbS3Gp9VT
 mzXJiJNDqZ+xSv1y73JkRotFcMzaWPAoBG3q8FlJmVB9Erculrg0xxQbzGTwGkoNnd79
 1MbtgIZK1TH3kdxs+npEz2WI/q370uCH/u6ZEUYM9Wu9nrsv36mcVIfqvFryV5Oa9XJ/
 JL2gZ5FlNzFwy79oZJ8zJ234ZbMwGroBmj3ozx1ymRTa7Wedgk05MvIXy0yDApR+iESv
 6sC8tALgfCsnPOdNAvMBisTr2E7GOgYy/KwAhPZgVqI6FJPln/ZheYDB+jelaQyaVma9
 YY1g==
X-Gm-Message-State: AOJu0YwOGdQIN/R/VUs5yx9hN+Ks/6XptPJQV9OSOMrdu9k8GhdApC6g
 H7uj1e0cueWvrCMtE90PjlzCwrggqd5CYRoM+ck4tIvjWA+VOsEIvL5xUT1i5iFrgtpauf1enRM
 rPYsrwQJy
X-Gm-Gg: Acq92OH7t09BpeuySZiR8xX5K4ZSxr3nBhkOa1hjyEpRLnOMWHQmUFE0yGdAeD6X93P
 UkfFZOXTurYKcCdYixCg6bCtjKBFgw/2sP41znQV4c3B6qoluMS0XqC6T9YwDgEIBvMuIru/qkM
 K3CY0byxw/MHpw6Bw8jM6pXyn1j+N5bGEQno/xHR0+SVaz44tAspdgR7mlRkse4tN7TwogQOWPW
 MjZCBuH5dgy3Mge1mNmLqQbjSTA6zkqnE9d4cGvv5ZbMfNKzCRx9Fd3w8BZGBC+qFcpQw1QBUkZ
 ggl2pb3Yr8rVvAcOAzybnaj3rhNaKA2A1xmlE23qTLmixZGKt/QuybTM9yRJkW/wAaQqDoAA04O
 ZtlX5oUxv8alPrKgfGnQhgucyrJMtlXsM4G3rprUy5+y+vhzWBFY3I5arzmQQ9raDmCi7wE3scI
 5tf0QoGO1qh006xDd/Lg==
X-Received: by 2002:a05:6820:c2cd:10b0:69d:5188:a2cc with SMTP id
 006d021491bc7-69d5188ab87mr1710589eaf.48.1779233548817; 
 Tue, 19 May 2026 16:32:28 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Subject: [RFC PATCH v2 01/17] lib: string: Add strlower()
Date: Tue, 19 May 2026 17:31:27 -0600
Message-ID: <20260519233207.2765755-2-sjg@chromium.org>
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
index a8a6cf4af50..15efe0ff5dd 100644
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
index 302efe048b0..8464366dac9 100644
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
index f56c2e4c946..598be1101a1 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -298,3 +298,30 @@ static int lib_strim(struct unit_test_state *uts)
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

