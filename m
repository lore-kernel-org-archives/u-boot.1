Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC849C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3148687684;
	Fri,  8 Dec 2023 23:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YO3eMjA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB3A876E7; Fri,  8 Dec 2023 23:31:23 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDD187686
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c09f4bea8so27381675e9.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074678; x=1702679478;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfEfF+4j1vHHGQGp/+YvsrvFdYNG9E0u1am4/S5TlQw=;
 b=YO3eMjA0xbzqKSBhNLJshvF+4bSrGhwYZR+rcGVwMDMqSbxQVGPf8brQR4F9iTtLzK
 yY7ZQ4ccDD9WHREIEPBugy6i6Te9xJENrt7UZ10EK4PLRH27j062eB0/ZgDKP9HIZ5uz
 mGYfSLFZr4MF32vAxH7X1DXbRMqnruNcwFabg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074678; x=1702679478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfEfF+4j1vHHGQGp/+YvsrvFdYNG9E0u1am4/S5TlQw=;
 b=qQ5TZ1QHlbS/uLDVJOubMz7DVtbKVZ5Hvt4Oxqv5sEqQhs6gnAzUoqsG7VokHvqVrv
 2VDgNl9esGsnCAReRjstxKLl7G8EgxSNWPeHS3ZMfZhwg72/zRijpM+TEy8Gkxl/al+8
 lidOpob/Pj/N2THuKxa+XFbw66x76R0PZEWwj1DMUnow/MZXlLrK7/6r+p1VCYlZdulL
 IKqrljYJwJ3ZbmHkPbVBrIVk/7MNR90Zrx6bMiB1LYRe/DvcWc7sjEBCvMVi1c5vkhla
 PwO3gl6OzEHZBz+BXDLlo4dh4i0mwXHk3ajRflZL9NiZUdGY/268kGB197SymVKZOb5I
 fhaQ==
X-Gm-Message-State: AOJu0YyibR5JERLdNDgQknfFq4zv0MHyNskgWuS0TU8+IU1K2/7kpkF/
 7s6dPC/R/5RVH3Z9OnAp4ncUEuMiqaj5HX3MZ31EIA==
X-Google-Smtp-Source: AGHT+IG7nOMvrRq4LS2VCV0XdQxMc0pKRO/r42PKdn1gJGUum68lVm6QfwCReQacDpw2RfFJtCkgcQ==
X-Received: by 2002:a05:600c:1d87:b0:40c:2b86:8363 with SMTP id
 p7-20020a05600c1d8700b0040c2b868363mr332323wms.170.1702074678656; 
 Fri, 08 Dec 2023 14:31:18 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:18 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 16/24] test: hush: Fix instructions list tests for modern
 hush
Date: Fri,  8 Dec 2023 23:30:17 +0100
Message-Id: <20231208223025.55076-17-francis.laniel@amarulasolutions.com>
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

Modifies the expected result for modern hush.
Indeed, there were bugs in actual U-Boot hush which were fixed in upstream
Busybox.
As modern hush is based on upstream Busybox, these bugs no longer exist.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 test/hush/list.c | 69 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/test/hush/list.c b/test/hush/list.c
index 052cf2783c..73ae36e88f 100644
--- a/test/hush/list.c
+++ b/test/hush/list.c
@@ -9,6 +9,7 @@
 #include <env_attr.h>
 #include <test/hush.h>
 #include <test/ut.h>
+#include <asm/global_data.h>
 
 static int hush_test_semicolon(struct unit_test_state *uts)
 {
@@ -46,12 +47,43 @@ static int hush_test_or(struct unit_test_state *uts)
 }
 HUSH_TEST(hush_test_or, 0);
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static int hush_test_and_or(struct unit_test_state *uts)
 {
 	/* A && B || C truth table. */
 	ut_asserteq(1, run_command("false && false || false", 0));
-	ut_asserteq(1, run_command("false && false || true", 0));
-	ut_asserteq(1, run_command("false && true || true", 0));
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_asserteq(1, run_command("false && false || true", 0));
+	} else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 *
+		 * Indeed, the following expression can be seen like this:
+		 * (false && false) || true
+		 * So, (false && false) returns 1, the second false is not
+		 * executed, and true is executed because of ||.
+		 */
+		ut_assertok(run_command("false && false || true", 0));
+	}
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_asserteq(1, run_command("false && true || true", 0));
+	} else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 *
+		 * Indeed, the following expression can be seen like this:
+		 * (false && true) || true
+		 * So, (false && true) returns 1, the true is not executed, and
+		 * true is executed because of ||.
+		 */
+		ut_assertok(run_command("false && true || true", 0));
+	}
+
 	ut_asserteq(1, run_command("false && true || false", 0));
 	ut_assertok(run_command("true && true || false", 0));
 	ut_asserteq(1, run_command("true && false || false", 0));
@@ -69,8 +101,37 @@ static int hush_test_or_and(struct unit_test_state *uts)
 	ut_asserteq(1, run_command("false || false && true", 0));
 	ut_assertok(run_command("false || true && true", 0));
 	ut_asserteq(1, run_command("false || true && false", 0));
-	ut_assertok(run_command("true || true && false", 0));
-	ut_assertok(run_command("true || false && false", 0));
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_assertok(run_command("true || true && false", 0));
+	} else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 *
+		 * Indeed, the following expression can be seen like this:
+		 * (true || true) && false
+		 * So, (true || true) returns 0, the second true is not
+		 * executed, and then false is executed because of &&.
+		 */
+		ut_asserteq(1, run_command("true || true && false", 0));
+	}
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_assertok(run_command("true || false && false", 0));
+	} else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 *
+		 * Indeed, the following expression can be seen like this:
+		 * (true || false) && false
+		 * So, (true || false) returns 0, the false is not executed, and
+		 * then false is executed because of &&.
+		 */
+		ut_asserteq(1, run_command("true || false && false", 0));
+	}
+
 	ut_assertok(run_command("true || false && true", 0));
 	ut_assertok(run_command("true || true && true", 0));
 
-- 
2.34.1

