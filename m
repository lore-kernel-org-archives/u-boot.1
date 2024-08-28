Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9D2C7113C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36C588A7F;
	Thu, 29 Aug 2024 00:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K7lqB7xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF449889D2; Thu, 29 Aug 2024 00:09:00 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26CC5888A3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d4161c398so29981535ab.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882935; x=1725487735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRSX4HjKAoBA5Aid2JROpPfETPHTcWdSlwt4oCpgB20=;
 b=K7lqB7xrzrERWB7XB/KtEcVHZ2N4g0csKVQKfDTzEN9oGUIckgwVbS2C9msgdFkbVS
 ZproSwsh42KC68joxyil5VIw3TstIoUAM9aQdyaBbCFOwDzjYU5OJE3jOx99/sRXakTD
 3cKFH5uV6KTr6/LEfFZ9F6z2sXgVTdvNKiLw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882935; x=1725487735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRSX4HjKAoBA5Aid2JROpPfETPHTcWdSlwt4oCpgB20=;
 b=nlbpVd9w9CjlDzVYvgKno0qD5cmxcVjwW1dnfS+21DGtqwILeiYWBgYgQViJa/QG09
 TpB83JDOHWWNwxFyEt3xD4U/lCof2zzIyN2aMv2GOkXSNZYJ5+E5PdWxCjrxPPaRSJQr
 Z//rrDrp03sDWoT+Bt9se4NyvaFmSWenDSSptM0k5NLZIYx0Xb0gxfb3Zv/+Ts6HslgS
 v5xf+I8cGEtfy2LJEXuYHDhrYmtzuZKHEMwAUtPhY4EaCDjKK4iuWc7s76AYawXCJhGK
 qEsfLdp5cG/2WRLQVMNAvWW+GN87bK9IoyK6jvbkwwuyHnrHbuCMUbgT1w2CUM3h3aNW
 Jn+g==
X-Gm-Message-State: AOJu0YzB9eLr73F0XNo0zL17+m5F/yjXg2BiUBLGPoKWnj0S7wGvPm0V
 pXDM3p7pu5kgdcrIm52o0+sDTasCgFfFW5aVjMsxOtrRkuUm/zOtz7d8MQJ3Q7v3jRY3i6Qx1R4
 =
X-Google-Smtp-Source: AGHT+IHUzQ9lIDNiad+ZXInsjECBdtl2F9xiYC6bQ0/01HLlV8m8NaxKJjlJjOuEbp6nn7emBW1qvA==
X-Received: by 2002:a92:cdaf:0:b0:39d:33ed:cb32 with SMTP id
 e9e14a558f8ab-39f379d485emr11073455ab.28.1724882934808; 
 Wed, 28 Aug 2024 15:08:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 06/20] test: Avoid failing skipped tests
Date: Wed, 28 Aug 2024 16:08:32 -0600
Message-Id: <20240828220846.1205813-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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

(no changes since v4)

Changes in v4:
- Expand the commit message

 test/test-main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index 63e8be0ccd1..0c9dcb21e86 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -448,7 +448,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
 static int ut_run_test_live_flat(struct unit_test_state *uts,
 				 struct unit_test *test)
 {
-	int runs;
+	int runs, ret;
 
 	if ((test->flags & UTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
 		return skip_test(uts);
@@ -458,8 +458,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	if (CONFIG_IS_ENABLED(OF_LIVE)) {
 		if (!(test->flags & UTF_FLAT_TREE)) {
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

