Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5686BC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BDC980944;
	Wed, 15 Jan 2025 14:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XRaRYgai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAB080843; Wed, 15 Jan 2025 14:31:53 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462B4807F9
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844e1eb50e2so233582339f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947909; x=1737552709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mOiLyyok6OgLT1MVTeJc9myvZFtoQrDD2FF/xVPWP0=;
 b=XRaRYgaihLvNhlrspY5ccfaj/eI8fkwwXXJnaOVBqe4i4FMN+zHmRv5zTbw9i9V4qD
 bLe2Pc3AF7sxS9g0UBwATZoGIHapA2YMsbUfUF323Mlpl7gsjVnf9iYDFYpqzMR4+ozY
 yFVo3LNPPy44EZcpLPiWI1fNkCKAinJSSFqvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947909; x=1737552709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mOiLyyok6OgLT1MVTeJc9myvZFtoQrDD2FF/xVPWP0=;
 b=hD9BAcq3QI3sOBBsDzF6UFMQyC0AHS7Kxf/Fl6HBt9Lu5qJuG1y8cD5ppW3Rn4ZwHf
 sHH9fNvb4eVeDGbDOtmGHcCtuJlXcf5CzsfFKo7/H0ejl9ENd0nEi4mg/Bxqas2YBLQe
 zj41RN6vhQBVAl0EgYM6PFMOYbNpim6BZ5eGUvkUefWncU0iWA3rN7cV0DwmoIpGlA6n
 t8drvP05feJgawul0SyykYp+ovYt1F5SAq/8kV26y6X8NKK2wAxwAFIOUPcek0pvJmIh
 9oljL6BDFKg/RdZwiYqwtdzy8BgAi7Ney4PtqFxOLU0NUIONUJle3mtj7XmToyp/rS5M
 Z2SQ==
X-Gm-Message-State: AOJu0YxGijulDqQ8i0oG8pYkjn6MfLZutBfsJOuz0wuTiyiWHjfZ8iNk
 rBhWt9qm9mOgJlwE3V8IMeYnyQqkRsH49Ts3hNEDpfmW6WhiZIBs67S12cmjn0YG4AnVBwmF6b0
 =
X-Gm-Gg: ASbGncvQtBtrVsiytIAoLW7GRVo2oxJIDocTyOvezfr+dAZ217SiguTqMthKmUeaVna
 /V1JtevdOZLK8Yq51KxohyRnQQV9lOpPOlBKke2c9NoYjwNAV/hH1VOFm8pYZ/h7bmTnhX19sWD
 k/j1bKFY+6KuDuBhxzuim/F3cnRYNpyTxFH1sDkBUagVt1rzCt2vv+kWQpO3maxj6Ouc4TUTac+
 zYrVVH4Ig3fOqHhqhxMjDX0SvXjRFG3Cqpid8rNTWibljc22l7QZBzf2AzeaDLLJluVmz2c1RFf
 zB1Fap+4le7D3kxRKA==
X-Google-Smtp-Source: AGHT+IHZI0QZ6a/a1BGykB92dCqoeibnSOySQM2VzvWox7TNS6QueDFovwsxYPlG302JrcVYQxTACg==
X-Received: by 2002:a05:6602:4010:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-84ce0048b10mr2612703039f.1.1736947909413; 
 Wed, 15 Jan 2025 05:31:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/43] test: Drop the function for running exit tests
Date: Wed, 15 Jan 2025 06:30:47 -0700
Message-Id: <20250115133114.590375-18-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h | 1 -
 test/cmd/exit.c       | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index b78436fe2b2..70b9af1fd05 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -37,7 +37,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
-int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index d1eacdc36c2..71c37edcdf6 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -110,12 +110,3 @@ static int cmd_exit_test(struct unit_test_state *uts)
 	return 0;
 }
 EXIT_TEST(cmd_exit_test, UTF_CONSOLE);
-
-int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(exit);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(exit);
-
-	return cmd_ut_category("exit", "exit_test_", tests, n_ents,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index a34998605cc..88a32129f0a 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -138,7 +138,7 @@ static struct suite suites[] = {
 #if defined(CONFIG_UT_ENV)
 	SUITE(env),
 #endif
-	SUITE_CMD(exit, do_ut_exit),
+	SUITE(exit),
 #ifdef CONFIG_CMD_FDT
 	SUITE_CMD(fdt, do_ut_fdt),
 #endif
-- 
2.34.1

