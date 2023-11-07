Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06242C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B9687696;
	Tue,  7 Nov 2023 22:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lSpt5EHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B92D98761D; Tue,  7 Nov 2023 22:42:34 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215638765C
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so688235e9.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393340; x=1699998140;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11Ziq5j8tH6//n8W109RGgZi+yynEIbpG8hLQmj18Xg=;
 b=lSpt5EHOLe8DN/vNAVEPGEOwvMM+3pQe6cUQLJLjaFWtiWlF2pwVtpxKYtrUMx0N4s
 E95hInaGvAoossP7a0CxCpz174Ra5OqvX9XNNVGlg4Q2czIGy9zjVQfQZZ0h5Rg4ybrl
 Ky5WS60jpZK4VYsfQM0cdk0/DhoYlWhV36q7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393340; x=1699998140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11Ziq5j8tH6//n8W109RGgZi+yynEIbpG8hLQmj18Xg=;
 b=Miy/8KU839dWES0sKsVAQ1HmRQi7WClC18W1o1NLJ0TOI9hKSMIFW487Q1cQyQgQyz
 syvhOMykXcipOOnY8mlD2itXTHwhGxWuHrMP78XpHm3yssxqsVZOAKRo4gWuWSq6WRXC
 raU68r28XNb8RUlJSFFgjyD9Ns280ptBKIcBnySjrfOXcJikVvGwsOIuKDUu0DT2EKfz
 1ZFiQEoIKz9CQrk1Lg8WhkxeOLJzF+XMeJrg8UsnCtK4FQWCQC57wGso8a7ivZoGzWyy
 gHVfmBDEVQ7D00M4xg5yrPYJ5uuF3GHJaRzrDxo1KYggw6956TJwzkgTh+SCh5ecWKHK
 +D9w==
X-Gm-Message-State: AOJu0YxbgJuDj/bJk7oDYHpH0g+iIVnECJGDZjALblrj7BQ/NjUvWhxI
 QgIzL86jvEsYUrAvDMpp0VMUzPf3Hx/Dks8CDSk=
X-Google-Smtp-Source: AGHT+IHkBk+P3sYAc6CSrhzHFY0xpQXVASYHsTAx9OijSlLZEoOUR4bAMrmppP4EZppb8E2n/LkgPg==
X-Received: by 2002:a5d:404d:0:b0:32f:76a0:a99b with SMTP id
 w13-20020a5d404d000000b0032f76a0a99bmr16472wrp.19.1699393340718; 
 Tue, 07 Nov 2023 13:42:20 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:20 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 20/24] cli: hush_2021: Enable loops
Date: Tue,  7 Nov 2023 23:41:17 +0200
Message-Id: <20231107214121.132079-21-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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

