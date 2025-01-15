Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325BDC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:37:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0008880A29;
	Wed, 15 Jan 2025 14:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MaVcChhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E1D9809D4; Wed, 15 Jan 2025 14:32:17 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C6280ADC
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3ce34c6872aso47259415ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947933; x=1737552733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oy35b+CaiJ0OFlImJFJkWfo4M5/8TRvRkkJ0nO5J16w=;
 b=MaVcChheFe0tZTZctTgVNI+BVNp0g+1NIxtJ+j6JULNJSH6mZIaa0JJEfmAf/fuhkZ
 S6Xd4vut6U+HbG+HANjnj8b2W0cFvlaUarBhluJe0kNjzbusEkMPNhw2e27cNycUp+ER
 kGT9JaHsm9pml0P03bqQKAS784iZamPoXiZeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947933; x=1737552733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oy35b+CaiJ0OFlImJFJkWfo4M5/8TRvRkkJ0nO5J16w=;
 b=lPXTTxCEXUwLG892QQkBpMjGTrPWsKtVxlg7aUALlEg5Oox3ezeYnfL4QN9eJTOphd
 KwdnkPV3ElG7Zb3V5z38BYfGsdjFUBrkch6ZG6wzA6zztcflpddUhh+t+OLzkGBnDOV5
 9HhAPo7HNz6EuISY5ht49jxQN975JRkx7J7ZMJrU9I/ZZGsy/qyo/dDXxoic2dgjnvNz
 FyuB4i4hC9anXCBNA6x1vd1IC9zcxb8WyaBc7CbdTh4SQtERjDoE1ps1brNGyDIHZzYL
 lt2pEdLXAsiBq7UK1cV8zFJ/I5S0ijQPOINnJnUVHbvY0lcGVM9Ammd0VH1FJ7vCQm6t
 YzMQ==
X-Gm-Message-State: AOJu0YyQSHLVXNVcFfcJZ89sZPne0uhvg0SBwugizhvWOHV4y+dC7tyO
 ShsFgK3vEa94f9nai2S7Uf5Qh0Y7NxDITVX4mz6ayMJbeow+4lQkEK1d9l3CDUIga0tqNrwc6jw
 =
X-Gm-Gg: ASbGncteBAZY47yDW/aQjtlvEzA5zuzONtVdqxamTPRy1XlpTD6b2xroptFFYLpHRdh
 gnGMIXYMbiwRXKOV/D4ZwrvBlevpqYDxDKD5HiSfwayWEMYQ/+sENLjzdXuIdVpeJwQNu0tUKg9
 QGJ7vZc0fadKqSSS2f0HSKot9SMpcAzP2csvRxPYVrvL89jNOV4j88utkcZQQtI3gc+J64WZto4
 ETxenPuRiKLEoaGFUr5LiJCfOKh0KaTjjCAYLveKZWsS0oFihr5/ycqqDgitWpZXGdP1LLTNnCK
 Llyp4UwXDjatHQ3Vqw==
X-Google-Smtp-Source: AGHT+IHs1orLBK256bmwf1qbcddOPExxItDelzddo2G4DC8c0bC7dO9UD6rzuYhZvz9Zc5IYRmeO0g==
X-Received: by 2002:a05:6e02:1a86:b0:3a7:1a65:2fbd with SMTP id
 e9e14a558f8ab-3ce3a8bb194mr224343405ab.17.1736947933029; 
 Wed, 15 Jan 2025 05:32:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 31/43] test: Drop the function for running pci_mps tests
Date: Wed, 15 Jan 2025 06:31:01 -0700
Message-Id: <20250115133114.590375-32-sjg@chromium.org>
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

 include/test/suites.h |  2 --
 test/cmd/pci_mps.c    | 10 ----------
 test/cmd_ut.c         |  2 +-
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index f6b33da5a28..49c18ebf456 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -35,8 +35,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
 int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index 2595ea103ff..8b3ea4a6134 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -28,13 +28,3 @@ static int test_pci_mps_safe(struct unit_test_state *uts)
 	return 0;
 }
 PCI_MPS_TEST(test_pci_mps_safe, UTF_CONSOLE);
-
-int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char * const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(pci_mps);
-	const int n = UNIT_TEST_SUITE_COUNT(pci_mps);
-
-	return cmd_ut_category("pci_mps", "pci_mps_test_", tests, n,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0a6284e4962..7caf41da096 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -182,7 +182,7 @@ static struct suite suites[] = {
 	SUITE(loadm),
 #endif
 #ifdef CONFIG_CMD_PCI_MPS
-	SUITE_CMD(pci_mps, do_ut_pci_mps),
+	SUITE(pci_mps),
 #endif
 #ifdef CONFIG_CMD_SEAMA
 	SUITE_CMD(seama, do_ut_seama),
-- 
2.34.1

