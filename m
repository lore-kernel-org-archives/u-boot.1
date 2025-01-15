Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FF7C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F358082D;
	Wed, 15 Jan 2025 14:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RRSZThIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818C080A29; Wed, 15 Jan 2025 14:32:18 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555AA807E1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844ce213af6so226688739f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947934; x=1737552734; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aRqzs9/m6h6pQG31hr8YpALZ0EtpuUz8umNXUkwzkow=;
 b=RRSZThIyw2nedM6PDhu4x7vVhSGYSGD/a/BfJzAxGQrkuZCJTd0UjdDR8sO3CQ+tAi
 euFjCplpOUIjvjYkcl+3m8v4dZvXW+fgPuhCOhwHSnU9P44+xJWqYOPm5n9ybnF5iFxy
 AuEQW+sP2aajAWu5oEcahViMlRr1HF4ut5O3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947934; x=1737552734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aRqzs9/m6h6pQG31hr8YpALZ0EtpuUz8umNXUkwzkow=;
 b=TK746UDOIE8WD1nOa3oGOW0m0yPZKOEIQRfiq0aD+Y1gjCHR30uUB3SgI2w3nu2t0h
 Lc+pl2Ak16EFcZtsfCforiD/Irwmsndxzep3cMbeI/GdKkCNIr60kdhZXYyysjAJ9xJ2
 bemPsMvoEpakReUfsKhfGFjIeBCWaQUzLfsLwCxvRsKNTwN0oOCTreBqC17/PzxGHZbe
 RmCE5VtsY9zCegTbjpBovrvmiLNs+q88ICzdL50/MryURo4fqNeHTRVUWjLAw3nXAzq+
 wgqRrehF5ejRARXNtqzdGLNvv916N0NdsGaeUBIKIiCoVlsYGtnHxMO4/sjdSs3Qwer1
 QQ/Q==
X-Gm-Message-State: AOJu0YwRh1hEfUFDWzeonfUxmDv3P/h+nvrYNZGfpGBgLsOfz08/yVym
 Su7FUIkUT/SrOHicfThBmSEjBTjUGShLJL3UNkkUcPB+CqZ7BS/KQIICvUglgnmu98wKXeAt4Zw
 =
X-Gm-Gg: ASbGncvCrTdlH9Rt5fgowp13KrHBFY7wu1kakzGirbyDEbaydT9E3Rgq5G2dq9e6ZWZ
 7xqPwGEq7jtpeDDnHU/u/e7D/hib4Y0EsGnts10cJyi/8TBcuaANp4FPas0Q5GTBndxYM3WdF83
 0q2mQ/LMi0ZWpJJTjptUzD0uZ4fdIj6Wwr/nxYW6I7OGhVTKKCMsacCzWWPfiLJFgvSNdj5D3Ip
 W5T3Fee1a6XriOhvXVH7h7zg2zaADcHgLfwgcz1d8C35oaf0S/M3eDLsupCqqG7tWNkLi4xMKh9
 s5SbQQ3tGumIRr4+MQ==
X-Google-Smtp-Source: AGHT+IG09yqsGQ4fTTL/2OkVGhg8mJ+mwpl+2eiVP5/Iya1VcesUe317s3m4CpvlD8RzmyMTv26aqw==
X-Received: by 2002:a05:6602:750d:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-84ce0095c70mr2819586539f.6.1736947934469; 
 Wed, 15 Jan 2025 05:32:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Linus Walleij <linus.walleij@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 32/43] test: Drop the function for running seama tests
Date: Wed, 15 Jan 2025 06:31:02 -0700
Message-Id: <20250115133114.590375-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

It is not clear that these actually work, since they are not enabled on
sandbox for some reason.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h | 1 -
 test/cmd/seama.c      | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 49c18ebf456..cd758b8c464 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -35,7 +35,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/cmd/seama.c b/test/cmd/seama.c
index 39590d162ac..1edc3fcac5a 100644
--- a/test/cmd/seama.c
+++ b/test/cmd/seama.c
@@ -56,12 +56,3 @@ static int seama_test_index(struct unit_test_state *uts)
 	return 0;
 }
 SEAMA_TEST(seama_test_index, UTF_CONSOLE);
-
-int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(seama);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(seama);
-
-	return cmd_ut_category("seama", "seama_test_", tests, n_ents, argc,
-			       argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 7caf41da096..c6b7ccdedbd 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -185,7 +185,7 @@ static struct suite suites[] = {
 	SUITE(pci_mps),
 #endif
 #ifdef CONFIG_CMD_SEAMA
-	SUITE_CMD(seama, do_ut_seama),
+	SUITE(seama),
 #endif
 #ifdef CONFIG_CMD_UPL
 	SUITE_CMD(upl, do_ut_upl),
-- 
2.34.1

