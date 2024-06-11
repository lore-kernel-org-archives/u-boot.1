Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5400CC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F274E887F8;
	Tue, 11 Jun 2024 22:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fQ5gX5pd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE451887B4; Tue, 11 Jun 2024 22:02:39 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BBA0887CA
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-375b27243e5so7426185ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136156; x=1718740956; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUJkuHT8rngSmGrSwhsyZ88bgz7zpFTxpmcB6oq9qLU=;
 b=fQ5gX5pduouCOK3yDnR73y37PrUrguJUcOIaRQiMLRA2USJ328C+rcGlE4Pr7yPVXz
 OTNkEQVeK6xJfPIuHxzKhl/mProTkee4OwEKnIfN/SEQjK7kl+6m5oj5qynu175DfElK
 +oejKs8rku46d6m7zb4Ig3H12iVtOO8zU+YfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136156; x=1718740956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUJkuHT8rngSmGrSwhsyZ88bgz7zpFTxpmcB6oq9qLU=;
 b=uJmjQnFMByoH06osYH+bKXh94MUT4SBrA/+YHwjR6YoSFoGrroStdE760eoRAWuxcD
 2S82a/z+jmUIcbNhyNMzHkNcjDLcE9fvW+TryCc9idNxSk7CsVKe8aj7y8E7fi722Lgc
 sOI1nv3ypgcdV/RaeM85t3BlntQEiyVRjLJSaezOYUxHwCPRbH2Id9fq+6HG2+ndx9AB
 TdQQJ75aPIjrqA8sb/efwQoC30F0yjZBbzEZxQ+CXlhMdq9JwV58B9rjY2eOSyuX0Vfw
 mUfnkpl9i66BDyAV/OQ+XyI6dJcTn6LCr8aj2Gmmo51hjEBgRqR71NsMN1iONAa6V1pa
 7P6w==
X-Gm-Message-State: AOJu0Yweq3fjcUn50geCtDzairTQmssBeO5aJAZckWGx05tvh7zr5WpJ
 5EEKsUaMdMKo69gNPxdGr7dH+fvrDsGDaChgwzUXlDUG5+4z6sumF3puFDpZuDkvaD0WhvlP/BN
 BSg==
X-Google-Smtp-Source: AGHT+IFaPB9WJAlTRkme+efotvjsMqiIGQNbkxbOEbzLclDMENYNoKOPTqERZRT1VtTS8XtaKRGCOg==
X-Received: by 2002:a05:6e02:1385:b0:375:a3d8:97be with SMTP id
 e9e14a558f8ab-375a3d89aa6mr67749775ab.9.1718136155882; 
 Tue, 11 Jun 2024 13:02:35 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 27/42] test: Avoid failing skipped tests
Date: Tue, 11 Jun 2024 14:01:41 -0600
Message-Id: <20240611200156.2245525-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

When a test returns -EAGAIN this should not be considered a failure.
Fix what seems to be a problem case, where the pytests see a failure
when a test has merely been skipped.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/test-main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index 3fa6f6e32ec..cda1a186390 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
 static int ut_run_test_live_flat(struct unit_test_state *uts,
 				 struct unit_test *test)
 {
-	int runs;
+	int runs, ret;
 
 	if ((test->flags & UT_TESTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
 		return skip_test(uts);
@@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	if (CONFIG_IS_ENABLED(OF_LIVE)) {
 		if (!(test->flags & UT_TESTF_FLAT_TREE)) {
 			uts->of_live = true;
-			ut_assertok(ut_run_test(uts, test, test->name));
-			runs++;
+			ret = ut_run_test(uts, test, test->name);
+			if (ret != -EAGAIN) {
+				ut_assertok(ret);
+				runs++;
+			}
 		}
 	}
 
@@ -483,8 +486,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	    (!runs || ut_test_run_on_flattree(test)) &&
 	    !(gd->flags & GD_FLG_FDT_CHANGED)) {
 		uts->of_live = false;
-		ut_assertok(ut_run_test(uts, test, test->name));
-		runs++;
+		ret = ut_run_test(uts, test, test->name);
+		if (ret != -EAGAIN) {
+			ut_assertok(ret);
+			runs++;
+		}
 	}
 
 	return 0;
-- 
2.34.1

