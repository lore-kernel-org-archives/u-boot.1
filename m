Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64639E7C4E5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE31F87604;
	Wed,  4 Oct 2023 18:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RYypCQXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A144386CF1; Wed,  4 Oct 2023 18:43:44 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE6987513
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-533c4d20b33so184834a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437809; x=1697042609;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11Ziq5j8tH6//n8W109RGgZi+yynEIbpG8hLQmj18Xg=;
 b=RYypCQXwhBEip1YVDbYKuMFbvuDQva+Xuyflxcbs48f/+uBcSn+SXtihv2jUMOxI6m
 m+6K4q3fkt6gdipCRweNiXi4UuqxkUuKaNWL42bbYFyG3zHjVbqYk8R90Lp6D0CvbV7y
 OaoFBlkabiZ01NII36DdpaPmpnKco1xtqYNOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437809; x=1697042609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11Ziq5j8tH6//n8W109RGgZi+yynEIbpG8hLQmj18Xg=;
 b=MWKBpui1UlyrgWq45zH5BAXq41989HK+ZssBemULGt8b0bDoTIew4FANE6FcfMNhsO
 qsCHgaQ7XCWqsunB36JAcG2Ar0W7W04CYgXJv/n3QuqDOm0SYm8HJTl6KMasadmYH47L
 1MWBBHKhZhFQlI1g2nSCfk5PYSgwhSp0TLZwR4WTeFRDTVUnrPyK9a+DU08AYycgzLbc
 5D75aFd7MYEI5WGiD0X6lPZHP4uiiGAekXou1fbIHZ7VZRnUm3WZWOt9DeCNZ00ELWd8
 vPGs9b7t/gFQLYX5vVlwRWZpP8hLB6PnSjxcGbztvS17PVu2PjWyuGN/sn8zSn7gFqU0
 2ZVQ==
X-Gm-Message-State: AOJu0YyW7lTt6rDu18j0TuUxNvnz17qdVEPKg76+g0lUpPNvc5qLxaeo
 U/IYvRkUefNWf7IkQiMSA1lYaOdNkNXGeD1ZyEc=
X-Google-Smtp-Source: AGHT+IGA8VxKR6aXSJP4LtMhdDgQPNjRoErLuJge4xrqQBWCU4yEWnbMvSkiABl1vo49SKJxMu/pnA==
X-Received: by 2002:a05:6402:274c:b0:531:14c4:ae30 with SMTP id
 z12-20020a056402274c00b0053114c4ae30mr245282edd.0.1696437809452; 
 Wed, 04 Oct 2023 09:43:29 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:29 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [RFC PATCH v10 20/24] cli: hush_2021: Enable loops
Date: Wed,  4 Oct 2023 19:42:16 +0300
Message-Id: <20231004164220.15738-21-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

Enables the use of for, while and until loops for command line as
well as with run_command().

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/cli_hush_2021.c     |  1 +
 common/cli_hush_upstream.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/cli_hush_2021.c b/common/cli_hush_2021.c
index aba5dcbbcd..0a207d147b 100644
--- a/common/cli_hush_2021.c
+++ b/common/cli_hush_2021.c
@@ -34,6 +34,7 @@
 #define ENABLE_HUSH_INTERACTIVE	1
 #define ENABLE_FEATURE_EDITING	1
 #define ENABLE_HUSH_IF		1
+#define ENABLE_HUSH_LOOPS	1
 /* No MMU in U-Boot */
 #define BB_MMU			0
 #define USE_FOR_NOMMU(...)	__VA_ARGS__
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 9b65dcbde1..23392939e1 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -10349,7 +10349,7 @@ static int run_list(struct pipe *pi)
 #ifndef __U_BOOT__
 	for (; pi; pi = IF_HUSH_LOOPS(rword == RES_DONE ? loop_top : ) pi->next) {
 #else /* __U_BOOT__ */
-	for (; pi; pi = pi->next) {
+	for (; pi; pi = rword == RES_DONE ? loop_top : pi->next) {
 #endif /* __U_BOOT__ */
 		int r;
 		int sv_errexit_depth;
@@ -10451,7 +10451,20 @@ static int run_list(struct pipe *pi)
 			}
 			/* Insert next value from for_lcur */
 			/* note: *for_lcur already has quotes removed, $var expanded, etc */
+#ifndef __U_BOOT__
 			set_local_var(xasprintf("%s=%s", pi->cmds[0].argv[0], *for_lcur++), /*flag:*/ 0);
+#else /* __U_BOOT__ */
+			/* We cannot use xasprintf, so we emulate it. */
+			char *full_var;
+			char *var = pi->cmds[0].argv[0];
+			char *val = *for_lcur++;
+
+			/* + 1 to take into account =. */
+			full_var = xmalloc(strlen(var) + strlen(val) + 1);
+			sprintf(full_var, "%s=%s", var, val);
+
+			set_local_var_2021(full_var, /*flag:*/ 0);
+#endif /* __U_BOOT__ */
 			continue;
 		}
 		if (rword == RES_IN) {
-- 
2.34.1

