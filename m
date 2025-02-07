Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6240BC02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3504180756;
	Fri,  7 Feb 2025 19:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QS1Apzml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38A480834; Fri,  7 Feb 2025 19:31:38 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3293C80756
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-854a68f5afcso57269839f.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953093; x=1739557893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erGpbP4MsYorFUpdILqY5yeeC6ER9OUaPT7Jp2fINio=;
 b=QS1ApzmlxFVNXISKNL0Ly0U8u3AOY4gvDKOFmfpkEhG3807YTp6WZN5DJcaGv41zzH
 H2OSnnbNIN88/mydj5MLIhzzCs28khi1SYaUwRxqGTrr3IBvaOnA/Q/Qhnbs66AoUcwp
 e+f9Y9i43JMg3O/njRNXt5R/bxRL55etnNABs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953093; x=1739557893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erGpbP4MsYorFUpdILqY5yeeC6ER9OUaPT7Jp2fINio=;
 b=EIy46fk/1IPWK1/hdFK8baHV5h4R/cZnLpNXD0tINCioeTGcCyo9QKA2NS/ROm7z6w
 KSo9BMJr8NpNJ8ysIpigTxniZyhX57aAz5TZGdCdSqoILCECTxKkTiSSSu1uK52ZZp7n
 2vHAxE+y58oeST6ao9di+6tsX6XvJ0cPpAnVpWXpmMFWlmybA7jWqbUwjCvw53Ch/qIc
 Ew1LQC2pcx523F7nv6pPcaut8j63SRWra2f6H3aUtLQ3WwOCAU3Eij/lGPYchOjfoJyv
 5wXd9rYtvDVhL/E7LkiHlRNO0nw1E2B+v2TJLfhJsF90U8k0dGJT+XimPyrphjKBd3yn
 wF7g==
X-Gm-Message-State: AOJu0YwH2NjwRmwkFzY0rPo8ZwmEHXjDII2zD4TAMlW8v3W5GKDaAgUA
 kUOUmExiRpkpKtQCz6DiJhzMYwkWAaS/Xxffuzgprs8SZsL2gCOr0U+lIsotY0HzlU+/C3u5Sf8
 =
X-Gm-Gg: ASbGncswv+YxzcTYfeIIUTTCCPeANAKy482p+pxev3+ammuMvW5avpzD06Nju/BG9ju
 HEVIgxIMpBnrp4ZsKtwmROxhQY0nxf7a3D2sdsnGmeYj/4KOS/kmDJfuI7LMMRNIs/oKtrIPL/N
 0fMY2V4OuVErR/tAZ8GmGLR5H2CpJi7IJLGtHn4pa+2LT/8miIKatkuqFwFprqAFRY9LNwu5/SM
 AuysXevTYIbLkpIJUxhA8NqFMEn1tigSRibFWv5fKn6CkdSHK3R3NDCBwHQNCYejH/Piku0Vbqu
 RMk3SLJHvT1QX0qlkw3XQEiJ1V3bU95W7kKNHz5nZYczFc3l1JQp
X-Google-Smtp-Source: AGHT+IG1nknAbtIwdn4w97t275wFmry/E8A1n6TzlyPLZ7RqrYEkdlsTmbxQcr9oT2P15KUDTQDNTg==
X-Received: by 2002:a05:6602:3886:b0:84f:41d3:51f4 with SMTP id
 ca18e2360f4ac-854fd896098mr491595139f.6.1738953093078; 
 Fri, 07 Feb 2025 10:31:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 03/29] test: Add up the number of tests manually
Date: Fri,  7 Feb 2025 11:30:34 -0700
Message-ID: <20250207183121.117663-4-sjg@chromium.org>
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

All tests should belong to a suite, but if there is a suite we don't
know about (e.g. not added to cmd_ut.c) then the totals will not add up.
Add a check for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd_ut.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index fbfdaaae0b5..cc30c517c51 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -233,11 +233,11 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	flags = cmd_arg1(argc, argv);
 	if (flags && !strcmp("-s", flags)) {
-		int i;
+		int i, total;
 
 		puts("\nTests  Suite         Purpose");
 		puts("\n-----  ------------  -------------------------\n");
-		for (i = 0; i < ARRAY_SIZE(suites); i++) {
+		for (i = 0, total = 0; i < ARRAY_SIZE(suites); i++) {
 			struct suite *ste = &suites[i];
 			long n_ent = ste->end - ste->start;
 
@@ -248,7 +248,13 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			else  /* suite is not present */
 				continue;
 			printf("  %-13.13s %s\n", ste->name, ste->help);
+			total += n_ent;
 		}
+		puts("-----  ------------  -------------------------\n");
+		printf("%5d  %-13.13s\n", total, "Total");
+
+		if (UNIT_TEST_ALL_COUNT() != total)
+			puts("Error: Suite test-count does not match total\n");
 	}
 
 	return 0;
-- 
2.43.0

