Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162EE10BA424
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 07:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B6183FD3;
	Sat, 28 Mar 2026 08:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CBurOtro";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3375083CD3; Sat, 28 Mar 2026 07:02:12 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0438F8394E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 07:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ngotra27101996@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so938680a12.0
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 23:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774677728; x=1775282528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NcRcN5ldVDZZAn32xO/pNyQnAy8qUflkMh6hUEqageI=;
 b=CBurOtroECVLCHv38sNxF2mH5cCCqO0LDCX9KZbWp0rh9e7M0pb4VtPfBPxJnfexZ8
 Vfyu+lbGbjUe5X0ZgkEGw37WvhNmgHTdlPLuqiAa0SbZhP+UGGrbgaTZKN0sH/ovLrYA
 wWCXsOTsTphmIXXoCQU935q4W+dPubGDp0UJd4cvyEY1pi10CrDk81k8I4lp4vJKzgLg
 LcAFbhREN/Srm7Man331UmzWK6yyagbv0UGySW6RG6xubogEBnDG39rgPujtxZeoT+ok
 LWhNrzrNFoR0ImBXx77WeZpi4vjUjQueG4H4czy9j4vRKF7KSGf0JoZ2ISByRvsN1us5
 Julg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774677728; x=1775282528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NcRcN5ldVDZZAn32xO/pNyQnAy8qUflkMh6hUEqageI=;
 b=EXDnTnAx5vDcwksH8BKG/eknUwHsfIu6xgUGfdOliJAUWbcDAER56pnB6egi/ecaO8
 bT5/vtcKgJJWgpd2Y2rX07NyPyy6HCxDb15GFeJL1pWVEQ6A6dl98hnq2ZR9+tw1NhIS
 w+iXXsGYgo7f53nU7UVTKtUK63Fis7OjfjLhdVLGrFZz0hF2FfBFQqkRg/g5YDD8ZGup
 rIy6+nd4XqeQsqzQtA+s3lN+ZBo9R6dIdYv8buR8WaubETGXS1HvVZYOMEqNqjqzKV4M
 +ZeYya6ZhqqpbRYbg2XSLBBonzWHsmrYoif92CPjP6a5Gl4n8i8Nabf+VAKv/hJOtJmp
 RZww==
X-Gm-Message-State: AOJu0YwgDM7wTyrxdlMqNBDgpE8nKgKSOm/Y7Cat1xMKgMyXVPhOUS5y
 p0DmtxKdJc3gGa+0TJHtQnBvBjO4DhZquLdXOYhHKyM7mPemYKD/mtnCTa7WDsSf
X-Gm-Gg: ATEYQzxjCZCzBendjYjZcnhcWlnY8wCUqYr+6kbL4tfzhR9VMCHHcFdGqJDLDbPgV4d
 kE9IE2ZVM9Ac1c4HMtWljSVchRHztkUpzXFJJI31STCbx23UufN4lAQwVtai3jDK4pHhB8EHxu+
 JtvJySPifIfPHGtpGJ8TwThTJCzY1SXgmTNRxtuoIqtmQsnbQoXaMQHptyZ/fnnXSJD3IfiJmtf
 3haK759Py+g6iOQi/wqZsGelNoGVzGAiFWhqMUdxPYK3ck045W9TabQHb+S1jhCd20AXdIOMokN
 Up6mPp244Ko3J43fB+KCUg+9L61nRag1BG6vmdq0qtFuet5P5Kv50CrqJSxqwAaXS75cpZAW+rZ
 gJDCe3mDA9n1ZCOinQFaiksI6H/sO+Y4DbPIHXqF0dt5hM2AsGh8c3Fn1SW1CHbTmnxVxTJv/tp
 J1tcFFE2dxWNI5JPndQhW1Lv3zIKALDZMmtV04HEMLpMT7vGy/6DP/dlSehZvVIR8=
X-Received: by 2002:a05:6a20:9143:b0:398:7830:8a40 with SMTP id
 adf61e73a8af0-39c8794f94dmr6127548637.23.1774677728166; 
 Fri, 27 Mar 2026 23:02:08 -0700 (PDT)
Received: from localhost.localdomain ([171.244.188.41])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76916d26dbsm902635a12.13.2026.03.27.23.02.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Mar 2026 23:02:07 -0700 (PDT)
From: Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
X-Google-Original-From: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>,
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] common: cli_hush: fix console_buffer overflow on boot
 retry
Date: Sat, 28 Mar 2026 13:01:33 +0700
Message-ID: <20260328060139.63221-3-S4210155@student.rmit.edu.au>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328060139.63221-1-S4210155@student.rmit.edu.au>
References: <20260328060139.63221-1-S4210155@student.rmit.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Mar 2026 08:05:42 +0100
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

Replace strcpy() with strlcpy() when injecting the boot retry
command into console_buffer. Add a BUILD_BUG_ON() to catch at
compile time any configuration where CONFIG_SYS_CBSIZE is smaller
than the retry command string, and use a named constant for the
command so that the size check stays in sync if the string is
ever changed.

Fixes: 657e19f8f2dd ("cli_hush: support running bootcmd on boot retry")
Signed-off-by: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>
To: u-boot@lists.denx.de
---

 common/cli_hush.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index 7bd6943d3ed..6141c2959df 100644
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
@@ -1029,7 +1030,10 @@ static void get_user_input(struct in_str *i)
 #  ifdef CONFIG_RESET_TO_RETRY
 	  do_reset(NULL, 0, 0, NULL);
 #  elif IS_ENABLED(CONFIG_RETRY_BOOTCMD)
-	strcpy(console_buffer, "run bootcmd\n");
+	static const char retry_cmd[] = "run bootcmd\n";
+
+	BUILD_BUG_ON(sizeof(retry_cmd) - 1 > CONFIG_SYS_CBSIZE);
+	strlcpy(console_buffer, retry_cmd, sizeof(console_buffer));
 # else
 #	error "This only works with CONFIG_RESET_TO_RETRY or CONFIG_BOOT_RETRY_COMMAND enabled"
 #  endif
-- 
2.53.0

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: fix/sys-cbsize-overflow-series
