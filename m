Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2EDCED611
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E9588ED1;
	Thu, 10 Oct 2024 02:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VohVooAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0AC588E91; Thu, 10 Oct 2024 02:29:21 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A5D88E3A
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-716a5b9ee6fso202573a34.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728520158; x=1729124958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6w+vCz3Khe4wx7HAE7P/6ArhEY0L3lZFzeAjpvqqlY=;
 b=VohVooACZCfFEQfZ6m+7PcLWP+ViOnx5aFdb1R88FlyHT5FUObo04FyAIae+KFnHiX
 wmR2NnWYGgmCke/qqR+DyNqOH9F8R8oznJBaLAM4ml7PVDQEl6dQccNJJAajgpKySQbV
 bk7X8a4LuN28kXmx40vGNCWsWGc0CRzV5OEug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520158; x=1729124958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6w+vCz3Khe4wx7HAE7P/6ArhEY0L3lZFzeAjpvqqlY=;
 b=kJ8eV5RnocgJ+WXfiyN5eEQPaFRXKNkGgSWa/u5Su2MyjDuIm93yVokCd4mYuWiZ0L
 5ZCuXTnWDmR00/FiR1Z8g2OW3/PLaSPbImEiRr+ikv/p5rexenwrWm5xuydUaT8hokMT
 MvHuuukT6gZGXcGgJiz6cms9o/gNJVZm61rDxxSQQipbHZ3/sHhruEjqHwStKmdB42CE
 XDlwgPy/MExLr5RTTmsy4T10cvUZyhrzpWfbYB8BDoBqjMgCFBfavUhFf/G8JKTijiCJ
 89QF+isXxo2ph6Dsa9bsdMhvR6GmvFAGSICFxa4OsMUMM6Gx9joTJHMwt0EJpS8WAHdt
 VV4g==
X-Gm-Message-State: AOJu0Yx05ZmMj7eFUUJFmH2zVCCu1lCf5/kR4hRVF4GapmrxkLL4JFVO
 z0KF8Q4wsDRXLZMCB/76HUgnOOm58VS+9pUtxd3EtAsUN9aIInQPMuGQZDo1tYuGM5g2/YmYbYz
 YtA==
X-Google-Smtp-Source: AGHT+IFBxT0ZhbXX224fxBwBT9eEICuoIEneAQ149cgvTPzSUleBCGhsahVhe/inqk/wx7IbLchkqg==
X-Received: by 2002:a05:6830:349a:b0:710:f83e:111b with SMTP id
 46e09a7af769-716a41b1085mr3900862a34.8.1728520158451; 
 Wed, 09 Oct 2024 17:29:18 -0700 (PDT)
Received: from chromium.org (c-73-153-3-119.hsd1.co.comcast.net.
 [73.153.3.119]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-717cfed7536sm9073a34.2.2024.10.09.17.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:29:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 2/8] test: Avoid failing skipped tests
Date: Wed,  9 Oct 2024 18:28:59 -0600
Message-ID: <20241010002907.19383-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010002907.19383-1-sjg@chromium.org>
References: <20241010002907.19383-1-sjg@chromium.org>
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
index b3d3e24cdce..b613fc6a4d3 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -486,7 +486,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
 static int ut_run_test_live_flat(struct unit_test_state *uts,
 				 struct unit_test *test)
 {
-	int runs;
+	int runs, ret;
 
 	if ((test->flags & UTF_OTHER_FDT) && !IS_ENABLED(CONFIG_SANDBOX))
 		return skip_test(uts);
@@ -496,8 +496,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
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
 
@@ -521,8 +524,11 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
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
2.43.0

