Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C846C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3135A87620;
	Fri,  8 Dec 2023 23:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BNUAuOal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4054C876F9; Fri,  8 Dec 2023 23:31:34 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE5F876D5
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c0a074e71so26083815e9.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074685; x=1702679485;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRrQ2IkGgDDck5NLWp89AZx6iGV72Wv/tnqJuMkxcQU=;
 b=BNUAuOaln/EyAAQUQZlLnaFP9vaGgvIVYUuNvs7oMpoVi++lJtdheYtfIc5Ky9paK+
 NqC2b6bma7Rt45jMjTGMzerAmX4C8ccLaGUZ3DmyLewShW8Tja2VDRIqY4+aqg1V2QD0
 N3aGBS8Qk4YLlCaEUcMVvaV0EnYRgFqUckl84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074685; x=1702679485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRrQ2IkGgDDck5NLWp89AZx6iGV72Wv/tnqJuMkxcQU=;
 b=kiLVH5SQGXPYSXOy2MbbjRHJGETwx25Nmz73/RIvZ2Ft0vuFv2qnZE4WEV8y6JHmMI
 qYJF7LuS+9GHKJWdAAxtZBquopFAW2J1vjSESzAQHiwbQUb3aT2uUtZeubCgo4xZZ4ud
 IcQSOIkI6IKcRZgUk0kfyAQxBDnLTcFl1VjJtJr9y4sV0ozCoWMsbUKUK4RC7xaw8XX9
 kEEqXniv5C7efW1r7XSQ9FsbfosD26RJyHV2qelPjFXp0hMUXQa40MHgvpXcp8LoQQwY
 IOkz67N6XE5LP7iecn+9wFYvLLKeOlfOIh+6OwXmIj1wSJtqKc00YP8RhgunPar9Xj5X
 Li5Q==
X-Gm-Message-State: AOJu0YxbvQaSN3TGIhbxUVwQxhqpQ1LQ9s/X/FOs4BBMrmwa2+b9cL0u
 1jzRGpfl9+3K6hQUPgStqb29un9jZYq3xXFyH7vyyA==
X-Google-Smtp-Source: AGHT+IFuyN+F+i1bGEFeVIqJYsE4hHlfjMJ+lbXA46zfabcV6t8erVfu9Q/hcI3/ScsYK/I1YwPiYg==
X-Received: by 2002:a05:600c:3556:b0:40c:1dd1:29b1 with SMTP id
 i22-20020a05600c355600b0040c1dd129b1mr404001wmq.5.1702074684921; 
 Fri, 08 Dec 2023 14:31:24 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:24 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 20/24] cli: hush_modern: Enable loops
Date: Fri,  8 Dec 2023 23:30:21 +0100
Message-Id: <20231208223025.55076-21-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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
 common/cli_hush_modern.c   |  1 +
 common/cli_hush_upstream.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/cli_hush_modern.c b/common/cli_hush_modern.c
index 6360747f21..fb578c3853 100644
--- a/common/cli_hush_modern.c
+++ b/common/cli_hush_modern.c
@@ -34,6 +34,7 @@
 #define ENABLE_HUSH_INTERACTIVE	1
 #define ENABLE_FEATURE_EDITING	1
 #define ENABLE_HUSH_IF		1
+#define ENABLE_HUSH_LOOPS	1
 /* No MMU in U-Boot */
 #define BB_MMU			0
 #define USE_FOR_NOMMU(...)	__VA_ARGS__
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 06af538a48..748edc9d2f 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -10348,7 +10348,7 @@ static int run_list(struct pipe *pi)
 #ifndef __U_BOOT__
 	for (; pi; pi = IF_HUSH_LOOPS(rword == RES_DONE ? loop_top : ) pi->next) {
 #else /* __U_BOOT__ */
-	for (; pi; pi = pi->next) {
+	for (; pi; pi = rword == RES_DONE ? loop_top : pi->next) {
 #endif /* __U_BOOT__ */
 		int r;
 		int sv_errexit_depth;
@@ -10450,7 +10450,20 @@ static int run_list(struct pipe *pi)
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
+			set_local_var_modern(full_var, /*flag:*/ 0);
+#endif /* __U_BOOT__ */
 			continue;
 		}
 		if (rword == RES_IN) {
-- 
2.34.1

