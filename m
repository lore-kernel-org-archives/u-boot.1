Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38464C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB88380C5A;
	Wed, 15 Jan 2025 14:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLZWj2W1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D0480BAD; Wed, 15 Jan 2025 14:32:20 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70A780808
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso528051339f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947936; x=1737552736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqHagMtNKlLMLqLwq3GlnxL6JosFtMUhcD2/tVgmF+0=;
 b=QLZWj2W1OhsNYqeApfsiebhU6xKQHmyxTkoF6OiWN6tAOkaBQ9hJq+Oj48dAxq4FGV
 fhtKVlKTeM5WA+DbcJi+0bmnf8qJ2nT5bjBHmc9kXdnP6lOe4GywA8obVuIKx72AruFe
 zZdWijYHNTOpMaItWsmiczyKDgIzUEMKRf5Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947936; x=1737552736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqHagMtNKlLMLqLwq3GlnxL6JosFtMUhcD2/tVgmF+0=;
 b=B54EMn/oYSyrR3URzAyhiR95Jd6fcIcO21oDUIZ2RjV4OwVgFTFJT6OfajxOxEoShx
 xhG2FTmCAC3FzQ2ItBFj4yzOk/V2ahg66lcZn+ZnOZaRryoZVxH4kYjQ+8g1hYNDZnsv
 G2pPDBt3ZcZItVKi5VeOMqvMpEQbyjlqMC0oSKj5wPDeJROGOX1bAKqZ0NIJBFcCsldw
 IR+4hWSQ3QmeGg9iBfi4k3Ijuh79ppzsvP3r6XDRcKfg1sK5VAZfQlH8lqMGUVvWLcw3
 Cu2hYfcCQtXilJbLin2I2wpw0MXfgXKDD10q/gHW8XTA5yyjZsow7mKyz+6eFsmmicH/
 gF1w==
X-Gm-Message-State: AOJu0YxqHycQxVR18zqXubqw1MWE8UAoVyTCaY3RO49wvcrPUIyBTsWZ
 nPW/ZvGSTIv2CgTqwfWaC2aMMHGD5xSt2TXnmcLMxY62kthzmPEyCqgyeMWim7fZvGE7DOn/Xjg
 =
X-Gm-Gg: ASbGncspfHvYqh+7jra16+zqMs+qNzC22Sk+hDkpWhlMF03JR+1D8aqR0JDcpd4Mb7w
 TrS5fwgZh9rU/IIpbtK0jqgoSMwHapB8/M5Vqg3IJrN5O0NJeOT2pOG3SlM87lVTh8n3AlIog85
 4YX8yL0bEtd3LOX3YqY/QtXSqlZ5vsDkkVPryqZyr6PQqQRLOXVUAz6b/WbRcLuUIVWO3tcNbH8
 fu2Eci1AB7XKxIsv6v0lPUR9jAHPG4L5UDtcd3V/ceQhATM3bTXZ3WVXVg6kdVdOot2egeTmb4x
 U+lz6ZfC7nALAzXSzw==
X-Google-Smtp-Source: AGHT+IH0dTeKoJ4lA2dlMCPetllQJO71Brn07T9/qwBIOMfyLETEjPIvG16wAsQ7vh0VDtAj6qlznw==
X-Received: by 2002:a05:6602:b90:b0:849:a2bb:ffde with SMTP id
 ca18e2360f4ac-84ce00766a7mr3309974339f.4.1736947936198; 
 Wed, 15 Jan 2025 05:32:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 33/43] test: Drop the function for running upl tests
Date: Wed, 15 Jan 2025 06:31:03 -0700
Message-Id: <20250115133114.590375-34-sjg@chromium.org>
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
index c6b7ccdedbd..0d055119ce3 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -188,7 +188,7 @@ static struct suite suites[] = {
 	SUITE(seama),
 #endif
 #ifdef CONFIG_CMD_UPL
-	SUITE_CMD(upl, do_ut_upl),
+	SUITE(upl),
 #endif
 };
 
-- 
2.34.1

