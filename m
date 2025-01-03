Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EF0E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 23:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AC48803CF;
	Sat,  4 Jan 2025 00:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SdBt6Vtm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D232803CC; Sat,  4 Jan 2025 00:21:35 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D7780079
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 00:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 84DE73FA4F
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735946492;
 bh=9v24PpQELujqCmOL4EkDlViJlL8druuHwBZ5ZzRuhsg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=SdBt6VtmTwZErqq7t/7hKNmUCarkgfz0KPkwn07SLVFCSPQaWBmzutiIG0pVyGAeQ
 G6UczJcVrBSO0lFhQWDOupUikB2cAl3LcwKEnWxCVAWp5PzL/KIpMw74GNYA1UzFRq
 8CrnWq2Q2ex/9lsyLCl/Z7IWIwpXphyIG5RhpP5rpJmdnFhp6OsRB8m3aa2o6YX2W6
 ghXTeNSfVJxRlYuZxbeJ26aeMWkJ+qSP5nkkgkParCPEqvUAVU9GZWHVoQcZvfaWQI
 z/Dq3HVDUxwTx9tKWOFVrusW4mIgFZ0ClCCCCEaONvhCtgiZ3kuWsAy5C6qqfwYgNs
 WozuuttFzsq5w==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso92351425e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 15:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946492; x=1736551292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v24PpQELujqCmOL4EkDlViJlL8druuHwBZ5ZzRuhsg=;
 b=uAvKoJIfMEmwsizCzrC1YC9VwG/M2T3TRTYvUE9SDAPfkJV8Ri1OHCT0zPsWwhIGhG
 mI6sjN7CxWgVgajIuUnIAnmdCeMAV8QGRCefWfnFsIWKk+URmvb384YTNsC029nmh/0C
 wfsuCaxSA2C3POgJ+xzI/g3n87ocuRPvQqlLvjFR0Qw+9NG6jS+hHjiJXx/h4ysNIfZd
 rxyZcXl7UhTzyUqc0Ql3m//WqHblhybPzDOzH/HWDGH0XIRZ8+CNAva6/9QoYW3LOOdS
 4DrDIwVFFnBd0G+SD+Wcd/pGHA4ORf0IXa8v0vKUlpJojlCqAlS4YIlr2569m2n/2B9Y
 eBOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDJNkogJtUZHuZ5194BdUO4vk0QcjS0/lfQihJfAz1C2vpOWfNHtPiDuQEBrmdnRzrq7hbRHk=@lists.denx.de
X-Gm-Message-State: AOJu0YxvRVTt+WYv5JPEP0CpqcjR4I+hAnHr2M9Q0t1OBXYta9nggMdQ
 /Xdob90loqj423EYR+Rgrw0CL3q1NIIcQbrnbMp7oena6QIl6t93MeE1boiLpPKOtXVX1bpoJdr
 QoYNmC01XhdYY5UabSUhccqxowIFjCvQeQ/8v4WFPR5ovhbvDSZ/iYI4s9y2uRGqWIU8=
X-Gm-Gg: ASbGncvXL+Q4Jf0a62WQHS4x8ScSljQVHpFbbIAd+MHWVr+Qa2BusxdrVDY6brR0qnU
 1nokyjhGtzawIGhfG1ZjVzKeV6m1FOheBYGDMRX0KwFWjYgOA9v3kILojsY//IBLDkbuaAJlmqE
 K90+pOniCRmTrJbUd3yMs9msPfAWBdQ815bzuiW5XoTgi3hAsCjiDB9Y0bVgz+A68PYxdbzBOnE
 0a2K963NAigGsyaOkCA+C9cug44YCcPzDv/acmsJb2TwV4KbFgrgCmMyc0JjWDhQq+CgbM/eI4/
 pKF43Q==
X-Received: by 2002:a05:600c:444b:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-436685489aamr428174395e9.5.1735946492114; 
 Fri, 03 Jan 2025 15:21:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6G263NOAXlAQVHis9r7H+wlGIxdvXkKNSXzQlTxCxMENZ28ngaNPJhYbUa5NJ4K5htdXMmg==
X-Received: by 2002:a05:600c:444b:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-436685489aamr428174315e9.5.1735946491789; 
 Fri, 03 Jan 2025 15:21:31 -0800 (PST)
Received: from workstation5.. ([2a02:3035:6e0:45ea:405b:a98b:b831:787a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b214sm536283125e9.28.2025.01.03.15.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 15:21:30 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] lib: implement strnstr()
Date: Sat,  4 Jan 2025 00:21:16 +0100
Message-ID: <20250103232118.711135-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
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

Implement library function strnstr().
Implement strstr() using strnstr().
Sort the includes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/linux/string.h |  3 +++
 lib/string.c           | 49 +++++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 27b2beb9ddb..8a377a8176a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -72,6 +72,9 @@ extern char * strrchr(const char *,int);
 #ifndef __HAVE_ARCH_STRSTR
 extern char * strstr(const char *,const char *);
 #endif
+#ifndef __HAVE_ARCH_STRNSTR
+extern char *strnstr(const char *, const char *, size_t);
+#endif
 #ifndef __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index feae9519f2f..d5a486fb89d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -16,11 +16,12 @@
  */
 
 #include <config.h>
+#include <malloc.h>
+#include <stdint.h>
 #include <linux/compiler.h>
+#include <linux/ctype.h>
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/ctype.h>
-#include <malloc.h>
 
 /**
  * strncasecmp - Case insensitive, length-limited string comparison
@@ -678,30 +679,48 @@ char *memdup(const void *src, size_t len)
 	return p;
 }
 
-#ifndef __HAVE_ARCH_STRSTR
+#ifndef __HAVE_ARCH_STRNSTR
 /**
- * strstr - Find the first substring in a %NUL terminated string
- * @s1: The string to be searched
- * @s2: The string to search for
+ * strnstr() - find the first substring occurrence in a NUL terminated string
+ *
+ * @s1:		string to be searched
+ * @s2:		string to search for
+ * @len:	maximum number of characters in s2 to consider
+ *
+ * Return:	pointer to the first occurrence or NULL
  */
-char * strstr(const char * s1,const char * s2)
+char *strnstr(const char *s1, const char *s2, size_t len)
 {
-	int l1, l2;
+	size_t l1, l2;
 
+	l1 = strnlen(s1, len);
 	l2 = strlen(s2);
-	if (!l2)
-		return (char *) s1;
-	l1 = strlen(s1);
-	while (l1 >= l2) {
-		l1--;
-		if (!memcmp(s1,s2,l2))
+
+	for (; l1 >= l2; --l1, ++s1) {
+		if (!memcmp(s1, s2, l2))
 			return (char *) s1;
-		s1++;
 	}
+
 	return NULL;
 }
 #endif
 
+#ifndef __HAVE_ARCH_STRSTR
+/**
+ * strstr() - find the first substring occurrence in a NUL terminated string
+ *
+ * @s1:		string to be searched
+ * @s2:		string to search for
+ * @len:	maximum number of characters in s2 to consider
+ *
+ * Return:	pointer to the first occurrence or NULL
+ */
+char *strstr(const char *s1, const char *s2)
+{
+	return strnstr(s1, s2, SIZE_MAX);
+}
+#endif
+
 #ifndef __HAVE_ARCH_MEMCHR
 /**
  * memchr - Find a character in an area of memory.
-- 
2.47.1

