Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468AAC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F35C8081A;
	Mon, 20 Jan 2025 22:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="inCMYLY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112A180771; Mon, 20 Jan 2025 22:54:24 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF33807C4
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a8146a8ddaso12736755ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410059; x=1738014859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqfAeNEw1wcOybaRwG+McSp4Rj9oXkbsB/fC3wgbr0I=;
 b=inCMYLY8hEeOWB5RBjCIw5cXRx07Qz/XnDuqXAVNURC5Ue7mP7Jzf9/hhQBpfEtIDy
 pjhCuqm3ngwFCDafeB6+bbpJgixsBG7e5S+10gRpAjTjvt19oacUUE8OVtIpPLaNAPOf
 yemGMebz0Zf1LgnGsdN9dp12EvLPg+/T0KS/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410059; x=1738014859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SqfAeNEw1wcOybaRwG+McSp4Rj9oXkbsB/fC3wgbr0I=;
 b=mDQ4f3CdgQCo8IP3vb1HfF8vjzZ49q9VTeMz/VR2US7HQno8FXvCLqccR7Rx47vtHS
 K2INpuMZ3M9GiXFNk7psdyd7D3FlNgHYSv5rfllGnU0Hsoct2phO00I6sshAHYo3HQuI
 ajK0gTf68gAz7b1gQfj3BXChTh87SKxJYDqgWLTLAemBpTbolJj1ELoXFZ5kHMiCAZ9U
 KUCqZVQfbHQcSqVlhoQOrzpbvSg103nXqXYWGCec2IV6q4fKjRXCyRghZeSeU65no8H2
 GmR95qxj+pfB4fLi7ujQgYDhYjdQD5NDM+OUO3/wPEN7byV3dO5S80f/IEDbFpW1upp0
 aRqg==
X-Gm-Message-State: AOJu0Yx2NFPfbWKxLy01zcdXsQ8S5zR1ByZ9TRxS3iBZLZK2X1Td5UNC
 mBs+n4Tz3xnb+xaJC8hcaBBPafoCwKiYxgp2UTnezUEuanYM4hWzkXT4dQteOoqXVmKq2MgOtgU
 =
X-Gm-Gg: ASbGncuumc/w6t7xySK5GjuORdPvAZDTgjVRQAZLtK24gjtz9zHuvwvFkoakNHRzWMM
 Fxw81CZYR5p1Qen13J3fiTz2wtrf9cIoVmGFWPRs1wnnkXdjzRkc5MWNZyERwU0ZE48Xnd56Y1A
 b/Wqk3OptCh7IbYswI8Pv+5nJjTfccpU5tq5Qr4cifJcPDv7KRP10QXgRkIka/lfWT3gSRMrTEK
 dIvcnjdSKV9ZTBOqQdi10fVCDS3wFky6zCFqQdJN/imT2bdo25dbYZ6eekJNu90ygoEO2NJMa5F
 ef8621t4uguATIrba55vvMoILPqQGd0=
X-Google-Smtp-Source: AGHT+IHEtvaJ545wgqZgaTxCWqBtpBmrAUELRx+qdmhJNqnG4MRF6iNk517r92k2LLEa4A+ID+x8rA==
X-Received: by 2002:a05:6e02:20e7:b0:3ce:7fc3:9f76 with SMTP id
 e9e14a558f8ab-3cf743eae5amr108538305ab.6.1737410059489; 
 Mon, 20 Jan 2025 13:54:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/28] test: Drop the function for running bootstd tests
Date: Mon, 20 Jan 2025 14:53:17 -0700
Message-ID: <20250120215340.617194-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

 include/test/suites.h      |  2 --
 test/boot/bootstd_common.c | 10 ----------
 test/cmd_ut.c              |  4 +---
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 78f5cdb4bdf..692633dcaa4 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -34,8 +34,6 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 		    const char *prefix, struct unit_test *tests, int n_ents,
 		    int argc, char *const argv[]);
 
-int do_ut_bootstd(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
-		  int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
index e28cae7f374..6a84810983c 100644
--- a/test/boot/bootstd_common.c
+++ b/test/boot/bootstd_common.c
@@ -100,13 +100,3 @@ void bootstd_reset_usb(void)
 {
 	usb_started = false;
 }
-
-int do_ut_bootstd(struct unit_test_state *uts, struct cmd_tbl *cmdtp, int flag,
-		  int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(bootstd);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(bootstd);
-
-	return cmd_ut_category(uts, "bootstd", "bootstd_",
-			       tests, n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index c4a42ee2e20..1885c78be41 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -125,9 +125,7 @@ static struct suite suites[] = {
 	SUITE(bdinfo, "bdinfo (board info) command"),
 	SUITE(bloblist, "bloblist implementation"),
 	SUITE(bootm, "bootm command"),
-#ifdef CONFIG_UT_BOOTSTD
-	SUITE_CMD(bootstd, do_ut_bootstd, "standard boot implementation"),
-#endif
+	SUITE(bootstd, "standard boot implementation"),
 	SUITE(cmd, "various commands"),
 	SUITE(common, "tests for common/ directory"),
 	SUITE(dm, "driver model"),
-- 
2.43.0

