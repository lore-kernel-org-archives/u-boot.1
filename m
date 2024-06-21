Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFC6C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C3B88633;
	Fri, 21 Jun 2024 21:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JAPao/Ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78BE3885F2; Fri, 21 Jun 2024 21:52:34 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561BF8860A
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7ebe508fa34so122841339f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999551; x=1719604351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOtaUyztkVMZyLL+JdveXN1qKv0Wgnd/AW8GpO0yH1o=;
 b=JAPao/Ec7xjdswgxSevT6sU1rykmaOz4jf3JMXPsCPuTFbY74l8ZmfD2e/TwLZaQoT
 COBq0fBh0mhfr6N5AFvanJHm191ZfgchblmEParOhYiF0QvBYxGPv7v5STLmIsgEtxmq
 1n68VoL8blcVJU9Yx2yq7ZUFX/03PPFsq2raA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999551; x=1719604351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOtaUyztkVMZyLL+JdveXN1qKv0Wgnd/AW8GpO0yH1o=;
 b=gSHNAWyvZz+H88jJivzgVUwPx81IzoR50miNNjVrEU/fbNEjGLqEpR6xQac4NQvzpR
 Yij8JarBFzG9VdZk3VLSxPN2RvrMwpuQYfvGsJoIu65kJ4i2rpfjSUPhY1A+fQCHb9g8
 3yzXytnyK1uSbz6C69iWvSmpc9tlb/YlUMPJflxkAji8rCwC6rRK0xqKxIwtk0TEPikv
 EpqsziTyEzB7JcT9ckpJbm8HtoNWLNYlE2ow0fVnZYSifnsuzvj2+AkILyUxNmUaZ/6c
 NAVo/GpXlOjuw47fd9iXviPRt7IdWuzAJl+IWdp9sSL7ToUSltdOd9sXUcBmYjvYUTAv
 W0YQ==
X-Gm-Message-State: AOJu0YzR12ePR6AuH4h8Wr5TfdA5BiUg3ytG9/v40N4KbFcCWMdGDkaq
 v0pw/+MJKIIodn8MnNG/GeSmRRJDCCqpfUQsKWzetFP6VBXk/LKcjjt5XTPGzM7MmB6ek29pa89
 fDw==
X-Google-Smtp-Source: AGHT+IFJlgucYZDZg0iAU3dcsO2aVfQBlej6YRH/i/saJ+B648gYT3R4wxzDhF9VAOVb95sVByypGA==
X-Received: by 2002:a05:6602:158b:b0:7e1:8a93:48ef with SMTP id
 ca18e2360f4ac-7f13ee8ac9dmr1127785239f.21.1718999551011; 
 Fri, 21 Jun 2024 12:52:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 27/43] test: Avoid failing skipped tests
Date: Fri, 21 Jun 2024 13:51:48 -0600
Message-Id: <20240621195204.2675252-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

(no changes since v1)

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

