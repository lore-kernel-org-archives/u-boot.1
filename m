Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F4EC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0058885BF;
	Sun, 23 Jun 2024 22:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TWhB5xZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E5B3885A4; Sun, 23 Jun 2024 22:32:27 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543138857D
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3762eadd807so10497605ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174744; x=1719779544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOtaUyztkVMZyLL+JdveXN1qKv0Wgnd/AW8GpO0yH1o=;
 b=TWhB5xZUL6mE6jeBQU1QDE0c/5evo4wdWfvYpS78Yu5HU34A8huTg0Yub9AzYGuMnz
 lTWMJvvAkhE2jZFEfHblqOvhLP2Bn5XS+NMnkFJepm+8dU+JLiT1bSNQvMymqGtsXpaV
 NroE8AetKni2CyuhlgNwgqsP1vJEwaNXqtrvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174744; x=1719779544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOtaUyztkVMZyLL+JdveXN1qKv0Wgnd/AW8GpO0yH1o=;
 b=HUqzPgsL20D0EeWqDgYOeb4MpATLA+e+xwxXafkZib3cK620jjPvS22vTbXhZSjCuD
 KTF2d+cgiCm9ZBouwDSodkvwRuXMga5w9kCBwn3EVmUyyNYhrksXVtKDG2RCrTTb4hxs
 ai9Oiu31iLBJxjQn5AzcVF7XkUXSLVWZ8NP83T7DJ4J4dV2UTV2aHVX8KJOxbfDxwk6B
 Wz8X8TbWwKOU8Yt7MIM5NdormWM0uq/ZswxcevOnmhwKiId1zQAps6putmN11qeBwz9N
 eAJ1Po8F6zpbRtxITgZ5CAUcyQL0nNPr69gxe7Qctwn4UkGIsSMZImHHItkajk4P26oB
 NVOw==
X-Gm-Message-State: AOJu0YyrH5Ls3eeAH322C9G0wNkGRm8hZWBjNW8Dobz/VPvQHue9aW3z
 PbIoYoZ3JTF/0ehvYMP1oOmO0T+WghPInq+DloJzCsntutXDE0Zulim6VekFxtd3A6SArb8PD/v
 dNg==
X-Google-Smtp-Source: AGHT+IHBqu0XkvXUdMp038PUhrwgZDLIwfWuEuFr0buZeAvzZHjDXmNHwT3t6/XT9iPks99ciOjP/A==
X-Received: by 2002:a05:6e02:1708:b0:375:8a71:4cc1 with SMTP id
 e9e14a558f8ab-3763f6adda0mr40261035ab.32.1719174743918; 
 Sun, 23 Jun 2024 13:32:23 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 06/19] test: Avoid failing skipped tests
Date: Sun, 23 Jun 2024 14:32:00 -0600
Message-Id: <20240623203213.1571666-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203213.1571666-1-sjg@chromium.org>
References: <20240623203213.1571666-1-sjg@chromium.org>
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

