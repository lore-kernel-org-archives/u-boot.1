Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DF5C47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D260B8772E;
	Fri, 22 Dec 2023 22:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="k0IvszMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 746E8877BC; Fri, 22 Dec 2023 22:03:45 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B820877DC
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d190044c5so21668125e9.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279020; x=1703883820;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRrQ2IkGgDDck5NLWp89AZx6iGV72Wv/tnqJuMkxcQU=;
 b=k0IvszMS4L/LbAQk8gG9BclxuF9cll3Vbz4ygUT545q7nDJfm/WQpFIPK+IvWh5M78
 JjJlVTnoggtu/Vmz1ODv62brXGgH9Z2jhVf00kTgnloWMR8yvPwVwnke1es7JhyXcHij
 wPgz5Un35QyvbrVnjkzUS5Jm7ji9E1IKOdqyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279020; x=1703883820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRrQ2IkGgDDck5NLWp89AZx6iGV72Wv/tnqJuMkxcQU=;
 b=eDJMbnhqIYvE0vuUBdF9+WBcO2aZDwASkfgAt5aO4M9k/ty8RX5TYQSpqV5ywfdIoJ
 7wSZ0Pnr59w2n8NZw2GBKfokJJJDsF90NpdwlvarpwmSf4UUisnq6ILsROkd/RqI/NNh
 roDIWKYtKN+49Ypm9hXTOiTQ8MzEdlVOotdj8uS/3J3ukNrYGKPCIorvO85EgrcZz5m6
 W0ICf9zSbeOLovycpTPt13Q3UzQ4b0feihjmaBg6fMseR21zCHjXERBfSIdIAQhq6Tr0
 qas4uSv6OugDMWLzzG94ArHvtzrSgvDKlVZ3rfowY5eFOm4reW3nFf1yDxr2NipDfMk+
 YUjQ==
X-Gm-Message-State: AOJu0Yyse6q5QYlQaMDNcHUpT8syuyGnTSGaUr90iDQFiVfUVT1GUpwM
 r4XL37WTrCO4gqAxjODCVMaTyjJeu43c6+JB4iZQsmnO4Bg=
X-Google-Smtp-Source: AGHT+IEMicp3Hz2dAvvt4jQ5qf/z3mpMhL7wW6NLSFIP8ZmQe8fhxWOFqJwXObd/dUtfUWAOLsgD5w==
X-Received: by 2002:a05:600c:201:b0:40c:2766:5424 with SMTP id
 1-20020a05600c020100b0040c27665424mr1025167wmi.171.1703279019842; 
 Fri, 22 Dec 2023 13:03:39 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:39 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 20/24] cli: hush_modern: Enable loops
Date: Fri, 22 Dec 2023 22:02:40 +0100
Message-Id: <20231222210244.91830-21-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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

