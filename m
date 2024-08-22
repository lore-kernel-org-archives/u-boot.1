Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB05C52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 912FB88E3F;
	Thu, 22 Aug 2024 04:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bhbmz5od";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AA3988C93; Thu, 22 Aug 2024 04:56:48 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E5188C8E
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81fda7d7a48so14151139f.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295404; x=1724900204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPAYXwTR/+RNQvA8skinfmsbQzOedu7lEjbCH+vlTao=;
 b=Bhbmz5od0V2Ltync+iwdnWGxrdwfuOam1zEADJE3isrk4zqHMfDBFOtd48NTFhyqER
 3dgDZXly9I7fC48jjFFBuQjVheIdoR1J0TffpzrAw72Qu8oE2Pq8d+EiNAMcvuHjpLbo
 BVVjfg5a4TUR1Ho5tAVAanNGTF8yX46wZ/t2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295404; x=1724900204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPAYXwTR/+RNQvA8skinfmsbQzOedu7lEjbCH+vlTao=;
 b=ECq/avVka8d+MNOR9ZBM803QSqs3u+j3thQvLreAdOt7/I7dee7z2BPnOJDSV508wg
 El1yyJm4LVpwySX0fEhG/etky+lrFAW9ZUd/pOkZ9CYcfbmv1U+9Ij5k1LFSTIGT74/v
 iGCFRWmhZPdAZNnSh/sXiYHSqKcRoSHBIjpmJXSasWlDGHjM328kXGv8U+qKz6ufPN2A
 XGrgPQuSds0u1zf7YGxr93w5uFnoTywXpg62le9a30QloxFTA9vzJsMCcLzofQoVF5hK
 mwHE8nUSTCJJdY4OsLEzjqYjIp813QECWkEi4/edSTEHPVRHvcU/vH7vAQtR5yoFaB4n
 Vmyg==
X-Gm-Message-State: AOJu0Yz6kvggG/DUZ3XQUFuzZW9TsOaPcYVmiPaxCtMe2D4Rr0UiWMbB
 v3SAKocWkfYz2oFP5PSuA2xjypgCJxignBhbcbCPZq95MEXSCB8o3wSnmpB09jKspvlZ5E34H3Y
 =
X-Google-Smtp-Source: AGHT+IFhZNSf0Dv8OcAytCg0A2mYUFXyVa4in10UQAiS2KsY7c/jei4B0viiaA++1JYFSkAYwVuAkg==
X-Received: by 2002:a05:6602:158c:b0:824:d7b5:45e with SMTP id
 ca18e2360f4ac-8252f2fa9b2mr563608339f.3.1724295403967; 
 Wed, 21 Aug 2024 19:56:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 06/19] test: Avoid failing skipped tests
Date: Wed, 21 Aug 2024 20:56:18 -0600
Message-Id: <20240822025631.1838434-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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

We cannot squash the -EAGAIN error in ut_run_test() since the failure
count is incremented by its caller, ut_run_test_live_flat()

The specific example here is on snow, where a test is compiled into the
image but cannot run, so returns -EAGAIN to skip:

    test/py/tests/test_ut.py sssnow # ut bdinfo bdinfo_test_eth
    Test: bdinfo_test_eth: bdinfo.c
    Skipping: Console recording disabled
    test/test-main.c:486, ut_run_test_live_flat(): 0 == ut_run_test(uts,
    test, test->name): Expected 0x0 (0), got 0xfffffff5 (-11)
    Test bdinfo_test_eth failed 1 times
    Skipped: 1, Failures: 1
    snow # F+u-boot-test-reset snow snow

The fix is simply to respect the return code from ut_run_test(), so do
that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Expand the commit message

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

