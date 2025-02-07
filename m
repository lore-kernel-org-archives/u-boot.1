Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F1CC02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F02A80BA9;
	Fri,  7 Feb 2025 19:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F1lA9DJS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E923680AE6; Fri,  7 Feb 2025 19:32:13 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12AC80BA8
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so75124739f.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953130; x=1739557930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qFx5V2GV2GuClWba3q91z+f5uIwwFcOIPzLTaTdoeg=;
 b=F1lA9DJSRO4K5H/JT6QiKKoOqnbZ9o5zmd9WvwbSdoH61hy2S5ZUCw6WzTsPOJVocE
 kLFq8yit7sIhMBaVChJLEIkVBz29eSsjDlXcel1iIv2/2UPqiYdqN6X9YorQM92mvmLs
 hFjxjO96pzyUZdUxuo3GoTx7Noxb7VSY3MarI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953130; x=1739557930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qFx5V2GV2GuClWba3q91z+f5uIwwFcOIPzLTaTdoeg=;
 b=V4cUwfo2sxaFg+drEXDdBIREXJxQRqZukr6IEx9kQXkLmP4M/w0UJFrCVhB4qAtAAR
 DFW+2CcKerLdGXO5L8L8obxowRfabuWz9O3riG1g6VCCGhQsp8wceyLPxWtjOBvGlbJE
 LiraDQKie/X0sXcXsOXWuSFYiJlWb7NV+UjYudIaoTMPGjF4ulPds8rQ9A0s0ZelRmXI
 F50ZGpzOJ9Eh5bBzuzdKQ8BAvM/hXNZOaWdcvy9hi7eI5STmjWxMrCMkB/325VmXDPEe
 G3tROn/vASn+qBbt/oJtffdmhgS7y+RDdcazvxQV4YFuDwW2s95IX0y8Oex7yJS8pBc4
 hmyw==
X-Gm-Message-State: AOJu0Yx+bmEjx+aAClRUrM+t1f/igL4eQRqSlzUUlyRkFGR7YM39ZAQR
 MocIKBgsU5tWbja+8s5p5z76GEL5RQbEXzIHCe69NI/Xjau4t1oi9coHfbqGvWR4EN5sy9UnGgY
 =
X-Gm-Gg: ASbGncvQD1AKPVp7N8Tl1EKprrmjdf+BPgZiLTim4PSJ5wGtssNqppHfXBuA0ptfz/Z
 hR49PQSFLZocAcBBEQftN81Re7tLnaanO4Yt1OPOFoGVVoP+h7o21R7toNeZ7mIvVAXEu5mh9Ge
 G/0RZYi1GM/nXKwVEPx20DcUHX9zO76Snq7sFBcFV8Uv23y2aDyJfmw+ijLAWmUxt/MPfh5IF/h
 GrLLDz6hA8QEDfbdvhCs06vPmlBDsH/DNL+WscoyYl6hvi0Hli9b/w3+dV1rX95k4vMvbmTQP7C
 WYBQUXSWf0KAwM3Q4bosCX2rIrr1ZbJSped1xhTtwzJRpI/dJ3j9
X-Google-Smtp-Source: AGHT+IFdK3mgGkmt+VQTXsypPzIxweGrH/LYRQSHoHhLghwG40PVh2lu03beq1HkJmc+PnaUZLoa8w==
X-Received: by 2002:a05:6602:7288:b0:84a:5201:570a with SMTP id
 ca18e2360f4ac-854fe4c0c89mr339175939f.4.1738953129868; 
 Fri, 07 Feb 2025 10:32:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 18/29] test: Drop the function for running bootstd tests
Date: Fri,  7 Feb 2025 11:30:49 -0700
Message-ID: <20250207183121.117663-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

(no changes since v1)

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

