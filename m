Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327B8F327B4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E1983E36;
	Tue, 21 Apr 2026 09:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XeQO9bAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B73FE83FFA; Tue, 21 Apr 2026 07:35:24 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BB083C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngotra27101996@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82735a41920so1568385b3a.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 22:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749719; x=1777354519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=14sAsstZjrHVPsX3SJQ2nyvEHfaU34skXxYentPztHI=;
 b=XeQO9bAAu+HMQsgP1wW60iCHo0HejG9B7rP7v6tRXCwC/3LBJVOAdS0op5EndkBXkt
 7w/PBY5JrACwZg4DHtpXrUeBuvMDmEhhTKgD1YPDNRDUdpjynFjdMm2wokviMobn0fBH
 xIEY2ZVpf692iLsGiM8yxfz0qoSYYUMpN16p5kJxtYM3pXmUrfHBw5VgFGjkWc1CW+OG
 zLF65gIEJeI84o4HZSltmyWCsb1adIu+FpjeRTRp3IiSK7XonQxCKLSTQq1o9s+2YYzt
 sg+rvWPHZsJ2va55r9obxIsLI9pBAAFbRcD4AJlUpGrNd8gljud9aWFw+GZJeB9emN81
 pXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749719; x=1777354519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14sAsstZjrHVPsX3SJQ2nyvEHfaU34skXxYentPztHI=;
 b=ei42+C+1jg+AEFardvfJfmGu9fEZteb/Igs9FoZcJ8avzwp8yaVGk3VtBi6mQNw6uz
 7sHhaWRkGGMK5Mb38cEpy/vcjHOzAXyENRwUe0a7NQmEQ94PORX3QQBqW/5qWQl0tADe
 KtB0OvBlBYLwKpyeWWsyw/3+q/SGTRdayTrqtip/ny8VKSWacN7e/0s61IqCwVwqW/xH
 8izpegBu6c3LvfwZ1eLXNuarS80ikSRhLgrDqAfUkHHMHEfjR9VNk/c1UfSYh7BvLyNT
 mSpOuX1AjAbb6n3o8UhN/Grp/zYNZY8ibAEMF6lNLN7+brBeHCgPYwZ6doUlb3LbUAAj
 huNQ==
X-Gm-Message-State: AOJu0Yxxc6wgbftJfihIxUUzSnvcFp7DM1Leko3TPHBNXbxOhxh+TKu/
 nPOrxXRtaaKRfcIkqQB1KkhKacH2YcRPtLUUJIkR6BGmiA4KOTkX+k2Dd+9y7yPB
X-Gm-Gg: AeBDieslu3251fMQWPg1NOHRX4WQfpro8eJHL8yz7m54OzQUazr/zjTO8piVREzhebC
 9A4f2GCqmV1KcIl6cjxaP7ai0Pd+UxcxnnaN5szVOdJMJPyZ17a7LcfBmnESny7QLzsrwM6E04x
 YW7CSFjq7Mtg2BSNH7vZU41C8ecv8UpRlsiMCZR8Axrct2kRVbeUDCJyEbiDDg90AgSUubH5qLz
 upH7upLN+nrSJs1ehNtmBtM4GtOQCYwOQ8Fm8FhRkauN1TMT8hqu7VIT/K2elcJWrQ1C4s9LfSO
 Nx+3ABHxae4P23mqC1N7TBepjbhOpfHoR22JInkm6baiSmPjFERWEklULJF7HtVk+C6YQgYpX7C
 ZG7hr8IDezrAPBrU2ewR5K8kd3XoO4xiGcegseF7SM1EBEqdCItZejqdsj0GAtrLvM4VZE2RWkJ
 josNgydngyggikK2muCd6eXjgPhzUAaUiJmug+nxFd6P8YLUlztw5tPW75zVTedmeBk0PcfqXLl
 dclbymEc6E=
X-Received: by 2002:a05:6a00:850b:b0:82f:948f:d1db with SMTP id
 d2e1a72fcca58-82f949f19f4mr9062373b3a.44.1776749719398; 
 Mon, 20 Apr 2026 22:35:19 -0700 (PDT)
Received: from MacBookAir.STASGS.RMIT.EDU.VN ([103.253.89.46])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f94204ac8sm11476773b3a.0.2026.04.20.22.35.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Apr 2026 22:35:19 -0700 (PDT)
From: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
X-Google-Original-From: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH] common: cli_hush: fix console_buffer overflow on boot retry
Date: Tue, 21 Apr 2026 12:35:08 +0700
Message-ID: <20260421053511.84312-1-S4210155@student.rmit.edu.au>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 09:29:26 +0200
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

Changes in v4:
- Rebased on top of current master (as requested by Tom Rini)

Changes in v3:
- Reject const char * destinations in const_strcpy() (Simon Glass)

Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
---

 common/cli_hush.c         |  3 ++-
 include/console.h         |  3 ++-
 include/linux/build_bug.h | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index fe8fe93bd54..d7a584fea3f 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -84,6 +84,7 @@
 #include <cli_hush.h>
 #include <command.h>        /* find_cmd */
 #include <vsprintf.h>
+#include <linux/build_bug.h>
 #endif
 #ifndef __U_BOOT__
 #include <ctype.h>     /* isalpha, isdigit */
@@ -1027,7 +1028,7 @@ static void get_user_input(struct in_str *i)
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

base-commit: e3405917a1806971d9e72a94186b299f05581e1a
branch: cli-hush-patman-dryrun
