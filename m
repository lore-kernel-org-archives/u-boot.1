Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0BAC47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63D98786F;
	Fri, 22 Dec 2023 22:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AnMseErk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6288987842; Fri, 22 Dec 2023 22:03:40 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70E28786F
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c6736d10fso26994965e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279013; x=1703883813;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfEfF+4j1vHHGQGp/+YvsrvFdYNG9E0u1am4/S5TlQw=;
 b=AnMseErkI6ashjtTf/jqkNfiW4aLBIzgjoOI5AoUqn6ClnqYXuwPPaKfwiP1B2Nug8
 xCPiMLyMLmdwX8G8fgb8jHCM5VEBzMkmjo2RLj8dVBaLD8ZP+TcNXOOmv22IlH5Fanze
 Afgri6j5MJeYyQmc4voG63mJMDWUEQtGSCslc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279013; x=1703883813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PfEfF+4j1vHHGQGp/+YvsrvFdYNG9E0u1am4/S5TlQw=;
 b=HBNq5ohMvi3m1bbdlMNA+8Iktem3KoExe2xIUx0XB1tBqWGDd06jVP1C4LQBncVYjE
 BjycdkQxVXg0/RbkaJBXt1bpt9pwAisajeZWx104pTZ4pVQ+us/+8wbmZg/Aw1gIqnGa
 FafFdoGXc8OJL7X+VRYO6HYUehwisatsolUANUX6kjynMMczR56ee4aHrgdRwnvR6HYw
 pBKMif+Zrq2FjN7BDwVLsnLJfbtHrhDTZD56NKFv3BXsgG+YFlIrOSKD2EvsJopqS/Kc
 GQdO168N7avSuaLpq9wEoRkUVEt0jGv3onlfdQ/3iJFhgcpWd8v49eAlvOFFqCxhc/m0
 YbwA==
X-Gm-Message-State: AOJu0YxJYpUyrUR36bZCS2MldQrm+zIOPxrXULRTcxZOmdABbnk8H5ZR
 wKSKZwPgvnMAi+SA8KIqotUKnD/99bKqE5G+M8tY/CDKaVE=
X-Google-Smtp-Source: AGHT+IGuO/57MaFnLgQUcs4J7VF77fB56dMD2chL3EYZmOGq5IBfroHhq6VEUIPPacZL2s7oQTYSqQ==
X-Received: by 2002:a05:600c:1e1b:b0:40c:2ace:5f01 with SMTP id
 ay27-20020a05600c1e1b00b0040c2ace5f01mr1194762wmb.163.1703279013263; 
 Fri, 22 Dec 2023 13:03:33 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:33 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 16/24] test: hush: Fix instructions list tests for modern
 hush
Date: Fri, 22 Dec 2023 22:02:36 +0100
Message-Id: <20231222210244.91830-17-francis.laniel@amarulasolutions.com>
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

