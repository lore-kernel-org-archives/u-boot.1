Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC0EE9D831
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 03:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBAD83936;
	Mon,  6 Apr 2026 05:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d8a6kqI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB0283E36; Mon,  6 Apr 2026 04:31:15 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 881EC8352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 04:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngotra27101996@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so3248275a91.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 19:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775442670; x=1776047470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G7Jkx3XBhDlCbzTBjfR/ATBSo9c1w0FbxqMEFfgSEVY=;
 b=d8a6kqI/uxp81saLdMT52GnlRjLXGoArhMziRnunr7bs9EDff5ZFb9toAd4dzbOo05
 jZTT6PTEXimrWOhuHZHrZgJmdq09pSZ3saZYxRp87bapyP0+hY7h7YnabjAW4l9Fj7yG
 lyTSnKiwxPgHt06cMR33mW9txwArqlY4ZkHl7Zf8uZfEeIUBuJ75LDiJGOh5Bdyrfs4n
 tS+NX1JLdeDSgFoleKAsPaGyyV91GPQ9ozCGTCad1kMqzHzd0QhdttdFn86ebItxE6Lh
 FHlxmVYxeLN771ZWFtbqDbwm7JrY+rsH2aWrPJiyzRaZwvT8tW7LAajFUCVXfr8zqEvr
 irfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775442670; x=1776047470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7Jkx3XBhDlCbzTBjfR/ATBSo9c1w0FbxqMEFfgSEVY=;
 b=CoUFRC5IUEN0A4kXqc9ojFghjEpdJIwms8VRVZrstM/J0L9lCsqIDisPQr0ISDlhVI
 QZkqwmCWC+ZZi92ZU5sF/pR/iO6ORvQBHwzjBE5yNZtE8D4BLpsZiCCquFkJlGr6l9u2
 LO82dEOmwaN5uUlVVpNM/smY7+XiPw4d0bpp3+M+YUv4KAc9D5/Yey0jHORTe5w+lMVx
 mk/zH8Nc07rzEuO+c1Qz3vuczJf7ceS7al6rhIHQrsPSY4HgLcLd9L+BVaroL3aUPi5x
 +pJUIPSZtV9i4KrxiFf+XOIDAagLALWUxmjWOrdMd5OL8M6WVjVQvHO7hrEbT3p+oTXp
 hScQ==
X-Gm-Message-State: AOJu0YxSBu0Ae2VV2okXix0TVhevVfNzyQKE9L0TjhpcqGAG13g92pLY
 4qUDxYpuKO0ZlBCQBYo034Xkbn9Z5ouldUg615weMe9+lLvypE/zkCNQ7wa9V+us
X-Gm-Gg: AeBDiesDFLyAeqytIsTz2jPOS6YSIQITDZrO7knSlYs/nH1b1/4iGcbnojZzvnoovPR
 aWFd7+lJyz5agaAuSZ+3N98+SzVz7ecc99v/Dcz8J4BfWCC7mpK4k7R550zFa6vOCs/oBtvazQH
 sJzLzul3K59Ihz1CBTWeqfL/aoWompBNBHH+P8vFrV8VDLVSGjjRYUBgk0lpy9vN2foS+FKdd+q
 3KUDQJtFIo/u3xAnAjgL4lgtC0gYKIKsQbrh7T0wdM+TwF0UF9KZcHAPeWL2PNSBSNux20nnW/Z
 LV0JHz/aBCC6f4CcDOPs4sQjKtbPd8icCq3GBN1mYu6nYs03b0LE4LP3ZQft/YQTxsxnSgRmRLH
 mm17PBdcDClC2brW6g76M/ZoRjMPohHYNH5CZ5v016yKadY0u50gAw6buouOnXgJzkdxV1n1paa
 +mDi2xaqRnlfC0qx0KSViIZh+MNnGxBBcpIuUqI6u3hDqxNwOtFVpaJLBdYfCnbBLTisyA8dThM
 Q==
X-Received: by 2002:a17:90b:2e07:b0:35d:a05f:c7eb with SMTP id
 98e67ed59e1d1-35de68f9e47mr9535062a91.22.1775442670485; 
 Sun, 05 Apr 2026 19:31:10 -0700 (PDT)
Received: from MacBookAir.STASGS.RMIT.EDU.VN ([103.253.89.32])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dd35f7229sm12887670a91.7.2026.04.05.19.31.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 19:31:10 -0700 (PDT)
From: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
X-Google-Original-From: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] common: cli_hush: fix console_buffer overflow on boot retry
Date: Mon,  6 Apr 2026 09:30:27 +0700
Message-ID: <20260406023100.95279-1-S4210155@student.rmit.edu.au>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 05:44:44 +0200
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

Add const_strcpy() macro to linux/build_bug.h that enforces at
compile time that the destination is a writable char array (not char *
or const char *), the source is a string literal, and the source fits
in the destination including the NUL terminator.

Fix the console_buffer extern declaration in console.h to include the
array size so sizeof(console_buffer) is valid at call sites.

Replace unbounded strcpy() in cli_hush.c with const_strcpy().

Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")

Changes in v3:
- Reject const char * destinations in const_strcpy() (Simon Glass)

Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
Made-with: Cursor
---

 common/cli_hush.c         |  3 ++-
 include/console.h         |  3 ++-
 include/linux/build_bug.h | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

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
index 20c2dc7f4bd..93f9e50a1c6 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -76,4 +76,28 @@
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
+	BUILD_BUG_ON(__builtin_types_compatible_p(typeof(d), const char *));	\
+	BUILD_BUG_ON(sizeof(d) < sizeof("" s ""));			\
+	__builtin_strcpy(d, s);						\
+})
+
 #endif	/* _LINUX_BUILD_BUG_H */
-- 
2.53.0

base-commit: 47e064f13171f15817aa1b22b04e309964b15c2c
branch: cli-hush-patman-dryrun
