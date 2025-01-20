Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B83C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FD31809A4;
	Mon, 20 Jan 2025 22:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dg97urfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E085380B9A; Mon, 20 Jan 2025 22:27:32 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3704980909
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844e394395aso144134139f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408448; x=1738013248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6i+qxHDGndvQPEO25ydpr/MH5NOSV4J30RqjgKbXDBE=;
 b=Dg97urfSGYh6bRul3wfPI+Hwhzh8WbLRicr1t0ytuSw7PrAKzonl7kLV+OsUV1Zu0e
 2g1J7tyzO5ntCNtVSBxFkHQQICA4HRtPwvPB66/RcEpyGFivezkYH2mlFs0lpqSQaK4r
 E1CnF+myX1bHKL1Y1N0USUVDu7zEvErLdIwqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408448; x=1738013248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6i+qxHDGndvQPEO25ydpr/MH5NOSV4J30RqjgKbXDBE=;
 b=ULZyYCLx8ImVV6U5pvxM42+SB8W4boOfG+v4bBRfPWgCMAUPPiEEBwFa9UrxD4lMsL
 ZcYdmJ55YJo6hKtVN7ProPCs4s+k0f0eJP8LA3ALN5j8/NGu+m5SEy7uHRPSRc4GkYBZ
 6FUF/OhtrKwHQDKs9Av7nLBA5/12RcF/Salv9jLCnkn3eMsTq+Z0629I0I+Tauu/Fi8v
 L9K3D2gNYs2ryhhf0+D46WfKJ/GplO1nzIsXfLMfJPStrIxzihs63YRnVG9wuLvOk8M0
 0SQ8hVVUlcnDXxRYI0l2rLd6dz3crRqPUYdcsR1Fhu2hviutxvEXDGEsbCkoSWAPifME
 wERQ==
X-Gm-Message-State: AOJu0YxZ+oD05kbc4N8wnzcnHz+J91cXc+59MjjZgCmTZt/vXey+tv/3
 gwgh+EWV3bl0j3NRoar7H4Yb7Z1hi8D2KLM5Uj5/BkSiOZlIfWzN66+Hu7vQoCh8Tq1Qtxbsys0
 =
X-Gm-Gg: ASbGncuJZTPybLzctz7ULbTjf+LHcxQoYh1bKeSOgow1nX1nxyyDtaV77xpR3hhNyVm
 nYmo1K02CTLFDOM5rSsqTnpG/Et9tmcs6yYpdffV2RWoZbz99WXphZS97vH1EBvlaJNh7dnNvQm
 lhZx8Iey7I5IQ2G/BsZWWyYghQY6aaSOb4Miw9cSMJZy6LXdI7GCSk70cXZA0g6Yl1RcLKJ9XR2
 n7E5Kb7w3zILD+fm8nUR5oBcEhAuk/6qY14V9i+Drp9UQOUf0KeVMohU3mIfgVduxnIlOwmqtjH
 pdZEbK0iTq1SPxVvCoqYOsV66Up46vU=
X-Google-Smtp-Source: AGHT+IEGSf22dpdmb4Ruo4YVBOxmuWL4DhUTxs3MOkkG28d11HGRXgfbiDlO2v7ONzaJb2vYDdBLwA==
X-Received: by 2002:a05:6602:751a:b0:83a:bd82:77f with SMTP id
 ca18e2360f4ac-851b623ad8fmr1231982839f.8.1737408448478; 
 Mon, 20 Jan 2025 13:27:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 33/44] test: Drop the function for running upl tests
Date: Mon, 20 Jan 2025 14:25:55 -0700
Message-ID: <20250120212613.516664-34-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

(no changes since v1)

 include/test/suites.h | 1 -
 test/boot/upl.c       | 8 --------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index cd758b8c464..20e6a2a113b 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -35,6 +35,5 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 2c9b8bc8bc0..aa58cdf083b 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -426,11 +426,3 @@ static int upl_test_info_norun(struct unit_test_state *uts)
 	return 0;
 }
 UPL_TEST(upl_test_info_norun, UTF_CONSOLE | UTF_MANUAL);
-
-int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(upl);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(upl);
-
-	return cmd_ut_category("upl", "cmd_upl_", tests, n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index ed6bc3a9a49..efcac626a5b 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -190,7 +190,7 @@ static struct suite suites[] = {
 	SUITE(seama),
 #endif
 #ifdef CONFIG_CMD_UPL
-	SUITE_CMD(upl, do_ut_upl),
+	SUITE(upl),
 #endif
 };
 
-- 
2.43.0

