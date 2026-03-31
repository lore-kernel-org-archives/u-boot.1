Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D4CFF60C8
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 06:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552E083DA7;
	Tue, 31 Mar 2026 08:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BiwDUHYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611A783DA7; Tue, 31 Mar 2026 05:25:39 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9DF480433
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 05:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngotra27101996@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso26420925ad.2
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 20:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774927534; x=1775532334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FCLFtUyqlK9HMbmyFRvcYFZGeZjuEwgIXOcldjl0dQE=;
 b=BiwDUHYO0TmzJWMyr1EFpuYUms0MPSzA8HmvSas41/bQdyneLi+zaCofoUBNWqtIQs
 SBm+2NxdtTe5ZMoV000a9WX+y2m04EUSTselz5dZOy7JyH4NHABTa6HcwKXZHbN4xKhM
 TUlmB3OKdPH6VEkmIT0Q8D3Ob4KKfp4fzFYvlnmccRSty5eNpZN4XUvMYqU9FPZG/jwm
 4UkyY3HlBkfcsO7TR48fejHiw/+xpKG+UEvM+o+uwUgqxaIwgqQMI2EXCTU+sFGBMTeQ
 pIyNpNkDHEzmkTySwT0Tft+Ju3d3KwYZoSfZfNGlREyWasIqOJp7dKUtPx8ACbyc6U+1
 AIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774927534; x=1775532334;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCLFtUyqlK9HMbmyFRvcYFZGeZjuEwgIXOcldjl0dQE=;
 b=s39J0aFxpMklN4cD2i6LwPnXmw1Borjf8AgvBAn3lz70NqIlBzyCfKaPpcpdu5Bqyj
 ISn9+22EP21Kuyg4m+IzP0pWPzSmvhOL9PlCnxqz+KfZjl4EMhW/Ntwq7R8ZY5JyLb7e
 +JrvvQw7vacWlQl/Qq1TqUSYT8yEeJy9QyIqlf3lWlgDfqSi8SHTbUfePQF4pPz9L4gI
 vXCQFnGdETCm9wda28jowWH8Bz2nSv+hjt16LXPHV0vEtiXHxnLm8KBzGyaH3fzy+UMw
 1t9Eo5yysUEWsy4+kBY3qfQ1xId1bBWvaqoIPovMQ2U0vUY4sAn4lOuO/KulNuvWrSZo
 rYIA==
X-Gm-Message-State: AOJu0YwRiD+FVze0RBPldu/cx9Gfoy4ji9/ShxMPOcAKv0BUMyEKqaE9
 tf1EsXqLanCF6aoPjHLspS/HtqGd33pbgbHHd3JvWIcZ+Tp36BqnU8ZFz7Exg6bs
X-Gm-Gg: ATEYQzwRVbJBCdOfiIlz2xX/akma2QLI2Udh56YS9Bg6vcSnA0xMAfpNEpVxjko1aqb
 hR+H87MxuTmzkp0sctbWEjFU0gcCwnufZlmGDZYQ/6q4S4Zqw8AFl7001PmOUCwRHN2g9D1MTHI
 t0ggQppAe9od7VTj+rMZZANAvsvfZFQaIMR9T0Grg6s3odqmCTA7YjoY45SDADswcViwrdR3MCn
 kycHAfKKz9orOqUJccykDwy/wyjiS/R0snpF+lvyMVsM5PcIhx9o0VwdWxKyVGhYKrJEIbf86Xg
 p7oY8fMfShQb8BQvC4bNwhi2A7S8MgeV1ZmFRVpFB3lYyIO2xuIAzX2x1rNFcXey3pJZdwYt4D2
 vXqP+SYcwke0RS7fbF+r0qdRkQ/84Qc20bHJTLj96OLmaey4WS12A6lQODMbRtCtMsZHWuv7G/6
 uJdBcxg1tD5KUg5bQMTQuNk6/NzzLvqDNNLjidoYVGWqfi55JC+Lm3Jf9NPT2ijI1aMmgYxuEsK
 w==
X-Received: by 2002:a17:902:e885:b0:2b0:663f:6b53 with SMTP id
 d9443c01a7336-2b0cdc9b555mr149940405ad.13.1774927534228; 
 Mon, 30 Mar 2026 20:25:34 -0700 (PDT)
Received: from MacBookAir.STASGS.RMIT.EDU.VN ([103.253.89.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24268aa4fsm93715645ad.36.2026.03.30.20.25.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Mar 2026 20:25:33 -0700 (PDT)
From: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
X-Google-Original-From: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] common: cli_hush: fix console_buffer overflow on boot retry
Date: Tue, 31 Mar 2026 10:25:11 +0700
Message-ID: <20260331032525.62304-1-S4210155@student.rmit.edu.au>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 31 Mar 2026 08:02:40 +0200
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

Add const_strcpy() macro to <linux/build_bug.h> that enforces at
compile time that the destination is a char array (not a pointer),
the source is a string literal, and the source fits in the
destination including the NUL terminator. It uses __builtin_strcpy()
so the compiler can optimize the copy.

Fix the console_buffer extern declaration in <console.h> to include
the array size so that sizeof(console_buffer) is valid at call sites.

Replace the unbounded strcpy() in cli_hush.c with const_strcpy() to
catch at compile time any configuration where CONFIG_SYS_CBSIZE is
smaller than the boot retry command string.

Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")
Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
---

Changes in v2:
- Replace strlcpy() + BUILD_BUG_ON approach with a new const_strcpy()
  macro that enforces compile-time safety for string literal copies
- Fix console_buffer extern declaration in <console.h> to include
  array size so sizeof(console_buffer) is valid at call sites
- Address review from Rasmus Villemoes

 common/cli_hush.c         |  3 ++-
 include/console.h         |  3 ++-
 include/linux/build_bug.h | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index 7bd6943d3ed..048577cb40a 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -84,6 +84,7 @@
 #include <cli_hush.h>
 #include <command.h>        /* find_cmd */
 #include <asm/global_data.h>
+#include <linux/build_bug.h>
 #endif
 #ifndef __U_BOOT__
 #include <ctype.h>     /* isalpha, isdigit */
@@ -1029,7 +1030,7 @@ static void get_user_input(struct in_str *i)
 #  ifdef CONFIG_RESET_TO_RETRY
 	  do_reset(NULL, 0, 0, NULL);
 #  elif IS_ENABLED(CONFIG_RETRY_BOOTCMD)
-	strcpy(console_buffer, "run bootcmd\n");
+	const_strcpy(console_buffer, "run bootcmd\n");
 # else
 #	error "This only works with CONFIG_RESET_TO_RETRY or CONFIG_BOOT_RETRY_COMMAND enabled"
 #  endif
diff --git a/include/console.h b/include/console.h
index 8d0d7bb8a4c..97ccf5e5f6a 100644
--- a/include/console.h
+++ b/include/console.h
@@ -10,8 +10,9 @@
 #include <stdbool.h>
 #include <stdio_dev.h>
 #include <linux/errno.h>
+#include <config.h>
 
-extern char console_buffer[];
+extern char console_buffer[CONFIG_SYS_CBSIZE + 1];
 
 /* common/console.c */
 int console_init_f(void);	/* Before relocation; uses the serial  stuff */
diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index 20c2dc7f4bd..d775bf1bf91 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -76,4 +76,27 @@
 #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
 #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
 
+/**
+ * const_strcpy - Copy a string literal to a char array with compile-time checks
+ * @d: destination char array (must be a char array, not a pointer)
+ * @s: source string literal
+ *
+ * Enforces at compile time that:
+ * (a) @d is a char array, not a pointer
+ * (b) @s is a string literal (adjacent string concatenation trick)
+ * (c) @s fits in @d including the NUL terminator
+ *
+ * Uses __builtin_strcpy() so the compiler can optimize the copy into
+ * immediate stores rather than emitting a function call.
+ *
+ * Note: @s is used twice in the macro expansion but this is intentional
+ * and safe: the ("" s "") trick enforces at compile time that @s is a
+ * string literal, and string literals have no side effects.
+ */
+#define const_strcpy(d, s) ({						\
+	BUILD_BUG_ON(__builtin_types_compatible_p(typeof(d), char *));	\
+	BUILD_BUG_ON(sizeof(d) < sizeof("" s ""));			\
+	__builtin_strcpy(d, s);						\
+})
+
 #endif	/* _LINUX_BUILD_BUG_H */
-- 
2.53.0

base-commit: 42571a36b6eac469ee94e305c7e7062306fde423
branch: fix/sys-cbsize-overflow-series
