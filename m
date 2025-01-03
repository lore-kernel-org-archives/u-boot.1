Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7AFE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 23:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6CB80447;
	Sat,  4 Jan 2025 00:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mTp+wstH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61C880433; Sat,  4 Jan 2025 00:21:37 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1AA380079
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 00:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 99F0F3F1CC
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 23:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735946495;
 bh=kiYR2AkHo6CNqLRihS0TYZUcViYQ+NCEsVgdoAldnTU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mTp+wstHWRMzhdUZRYBLARJE0/rfraTT3ji38B3yyUAZOz0VEuRoybKsxrWpnXa3A
 z28qXW5Ny45GptDCn/dX+22xVREJ6Sy1XPBI9Z9AkWxKsa87l2cmQTJrAtXucVWvL1
 e+7IQy5npbGDfJJE4xvDdvaqRKed9nTTe591r/skcQksrVUwIcaex6unjnlZyeJ/pI
 voGH2dhmQsb2HpQWYU1RxaDTkTMWospRbsxiD5994OJjM9E6Cb9eWKGf+8RfS95iHH
 uKfxkc6S6G7gpttYqf3hArU00WspiDl1FZdqLxRtJTxa8KcMnHY/zSVdgcuL/q4WRq
 tJuw3DpcjCong==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso67147345e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 15:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946495; x=1736551295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiYR2AkHo6CNqLRihS0TYZUcViYQ+NCEsVgdoAldnTU=;
 b=ezntHp96xaPAU66Y59+yIEJC1j+W5PNnBH0B9gUAUDCSqGKXemrKcCVr5K1Kq0/8Md
 g3hnpF0RcJJwhKljCBaE2dWhBEux3WI9R7x96TG9Fdx607aMIpzwsf8A3mz5PMg+1rzf
 HLmLQzXxV4gx6zseqVEEtFjEbWXR9zMMpc8yDtAPgnBgslmtp5bNQYfYmR0on2FsJhcK
 yB6uLQlVxq0VSRse4vxmCi1dW3qv3e7ugFiL2PPFtIsLCtbAzVJhU9NpNEjbU0C3Vrm1
 XB1PrqDx1pxzRk+yPbStAiHkzKwNBoYmGPD+AR0+dXhkokIl0+XKXZKY40WJCe/z3ehb
 Km5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlPC8O/S4KKbz7v/xNB8WC2QfrbQAqTJroFdmRJ2F2BHi6qZI0czYhnp57YeV8GZYN73VUyDA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4lHCZ9iTsYWxSYKt9I6iZ9ay56xwGEtscIC89jenNR2Aw+2/A
 +hYnW0FkcYlGnmgvfC60XrU3Jc07naL73xVS3o2v9EmyQZD27CtvEK9F4ZaAffw54nTd1pXkxhQ
 EnywwCKUR7UgBkS30/9PlWv1/xraCIiBz2pPf1VzlFD1k8sxCNumATDSJ4S1x/SnOooc=
X-Gm-Gg: ASbGncuiaUiwdBBLSmC3QY+5rkOodKmILu6GARn5JhOsibZbH3EL1X/dO6DvPw+KnxX
 EswqsIxyOVYHVVlx0RQIYgKWZlSTQh9gGnx+VThC9li1RdpHRnxI8A01bUHGWqtLkRNrcXj1DDo
 KDnKDrdKxaDNwLDPPUkM+8albSoMk/OIclFdUL5yKG5TnVoMWLFrUIUpNU5vOzW5RogGlkWVhJF
 1uqs2OcY1/zapB/dAhVCaSzcEPyQKPRNfQB4QhAUbBPpSp0e44I+nFacBv+iZDU5f34FQFvPtgV
 8oUDVQ==
X-Received: by 2002:a05:600c:474d:b0:434:f623:9ff3 with SMTP id
 5b1f17b1804b1-4366864616amr469730625e9.15.1735946495178; 
 Fri, 03 Jan 2025 15:21:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMEZR1VLGjpFJ6SU2/4ie3CoCyrjlQBL3u2nn6bmbRcoEOnPJtEYXxYAP/E/erbTJU1mruNA==
X-Received: by 2002:a05:600c:474d:b0:434:f623:9ff3 with SMTP id
 5b1f17b1804b1-4366864616amr469730485e9.15.1735946494846; 
 Fri, 03 Jan 2025 15:21:34 -0800 (PST)
Received: from workstation5.. ([2a02:3035:6e0:45ea:405b:a98b:b831:787a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b214sm536283125e9.28.2025.01.03.15.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 15:21:33 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] test: unit tests for strstr() and strnstr()
Date: Sat,  4 Jan 2025 00:21:17 +0100
Message-ID: <20250103232118.711135-3-heinrich.schuchardt@canonical.com>
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

Add unit tests for the library functions.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/string.c      |  2 +-
 test/lib/string.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index d5a486fb89d..66aae583940 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -16,8 +16,8 @@
  */
 
 #include <config.h>
+#include <limits.h>
 #include <malloc.h>
-#include <stdint.h>
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
diff --git a/test/lib/string.c b/test/lib/string.c
index 8d22f3fd68f..31391a387b9 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -11,6 +11,7 @@
 
 #include <command.h>
 #include <log.h>
+#include <string.h>
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -221,3 +222,42 @@ static int lib_memdup(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_memdup, 0);
+
+/** lib_strnstr() - unit test for strnstr() */
+static int lib_strnstr(struct unit_test_state *uts)
+{
+	const char *s1 = "Itsy Bitsy Teenie Weenie";
+	const char *s2 = "eenie";
+	const char *s3 = "eery";
+
+	ut_asserteq_ptr(&s1[12], strnstr(s1, s2, SIZE_MAX));
+	ut_asserteq_ptr(&s1[12], strnstr(s1, s2, 17));
+	ut_assertnull(strnstr(s1, s2, 16));
+	ut_assertnull(strnstr(s1, s2, 0));
+	ut_asserteq_ptr(&s1[13], strnstr(&s1[3], &s2[1], SIZE_MAX));
+	ut_asserteq_ptr(&s1[13], strnstr(&s1[3], &s2[1], 14));
+	ut_assertnull(strnstr(&s1[3], &s2[1], 13));
+	ut_assertnull(strnstr(&s1[3], &s2[1], 0));
+	ut_assertnull(strnstr(s1, s3, SIZE_MAX));
+	ut_assertnull(strnstr(s1, s3, 0));
+
+	return 0;
+}
+LIB_TEST(lib_strnstr, 0);
+
+/** lib_strstr() - unit test for strstr() */
+static int lib_strstr(struct unit_test_state *uts)
+{
+	const char *s1 = "Itsy Bitsy Teenie Weenie";
+	const char *s2 = "eenie";
+	const char *s3 = "easy";
+
+	ut_asserteq_ptr(&s1[12], strstr(s1, s2));
+	ut_asserteq_ptr(&s1[13], strstr(&s1[3], &s2[1]));
+	ut_assertnull(strstr(s1, s3));
+	ut_asserteq_ptr(&s1[2], strstr(s1, &s3[2]));
+	ut_asserteq_ptr(&s1[8], strstr(&s1[5], &s3[2]));
+
+	return 0;
+}
+LIB_TEST(lib_strstr, 0);
-- 
2.47.1

