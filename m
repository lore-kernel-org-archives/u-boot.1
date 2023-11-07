Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6FEC4167D
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A3C87261;
	Tue,  7 Nov 2023 22:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pv+37cnc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D519A876BA; Tue,  7 Nov 2023 22:42:30 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DED8787694
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso38728915e9.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393337; x=1699998137;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mn9irTLZeIp1ybS5hwFfjYiPVkcNPqEC5RGf5JtixrI=;
 b=pv+37cncTdjU836SHwNuZL0+JAgzH+UB6gxxrMvNbJEVK76vtcTe8mczgjyRS6Mx0Y
 HYMrz4pTgOWUubsN1N16by0YSX+lLzSwUcOIMdCywYGad6YWtM+so8AOtMhfqTBSQYMD
 SkIq0Vm88wLhFQU9EeAcftd4kg41Ips75aPOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393337; x=1699998137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mn9irTLZeIp1ybS5hwFfjYiPVkcNPqEC5RGf5JtixrI=;
 b=g6jXLDpsw6gACueA9+g7lq3o2t8Bqg6BiGB99h3BnIKAMcLfVBWwvHD2LqNwdjk0Lx
 ILrfQkdCeRCbD6qTe71CoRSTJEjVACZsOvGi/4SukJEJ1vpp5xcxGZhYb33HO75NhA48
 QDwx+N2InkPi6GvvisF6bMet1IN/Qup7ZNLmkufaeDn4pZifslUYVa1JJFQVTKqfRZxH
 mAib71ZDxAWj8L8JBpKoW/ybe8t0ZQ2ecQoN4W5OLpKJegk6DxBTn52q4uZRD7s5fDrl
 CMlGKw8hG1UwQBKTWNg0H563A+yZN2dxJLifuCHUvTG0prBPr8M9ZOX+3OWuZE2Gw5z+
 l0mg==
X-Gm-Message-State: AOJu0Yxy5XQQ4V66RwmnIU0KdOA5NA1Xm2MRKaXMnnxFnCxXWY5X8tjM
 OF1lhbaiJO6q8i+KV91DQgaMMHX36iNAJ2mEAcc=
X-Google-Smtp-Source: AGHT+IEU4+kWPOFwkG79GxHBlfgmL2KNq60O/W9/a2fvkm7UeVm48kQZpmLytOllXtraraqtQYhEhw==
X-Received: by 2002:a05:600c:a44:b0:408:492a:8f3 with SMTP id
 c4-20020a05600c0a4400b00408492a08f3mr238388wmq.5.1699393336763; 
 Tue, 07 Nov 2023 13:42:16 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:16 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 16/24] test: hush: Fix instructions list tests for hush
 2021
Date: Tue,  7 Nov 2023 23:41:13 +0200
Message-Id: <20231107214121.132079-17-francis.laniel@amarulasolutions.com>
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

Modifies the expected result for hush 2021.
Indeed, there were bugs in actual U-Boot hush which were fixed in upstream
Busybox.
As hush 2021 is based on upstream Busybox, these bugs no longer exist.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 test/hush/list.c | 69 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/test/hush/list.c b/test/hush/list.c
index 052cf2783c..6f8f10f15e 100644
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
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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

