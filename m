Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9075C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4C0380A55;
	Mon, 20 Jan 2025 22:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CbGdfVm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44CE80B9A; Mon, 20 Jan 2025 22:27:33 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932F380763
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3cf880d90bdso6571465ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408450; x=1738013250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xupY9g1wZOhXkqhUwP0/eYcRzi0Yfz1FiOTTjzB619A=;
 b=CbGdfVm59J8FI2U1iz1yVdH+I3e7eatLNMTObElHUIwQMcy09qBQP4qKwBEVAkMOhR
 ZlEVa5InE5CAUa0ljsr9ngiMxYaRqmeMegCJ1VffrMHspHoteGeX3su3jNZEyJ8zfQtI
 zsmqKRDCcHV6hI6J2W+R9ykBJCjOY5jUyS6kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408450; x=1738013250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xupY9g1wZOhXkqhUwP0/eYcRzi0Yfz1FiOTTjzB619A=;
 b=ezqZZ6yRhSVrOnM9/t/HGjSHZnxvF6JZyjuqBv98iFXTEwM+V6GoYf2989mDPIsLtd
 7XXQs+9jgw3RRKsg9NaiWO8QR52KiQ+WBRjGU4Th5LPHRcZIgcP8HbcQlp/GSjVFvzyj
 OpKrwfAa5jPP3TFxc0PsjD5kvbq/zr5ZEb48kOIHl796WDKvOx15J6z2vlljAt5fFlum
 eqVVr6rwrOkfGxRkQPgivxCDm/39vEll+Sm3jBoahLgiSTWlaAOg0qjF/GjFRtkwRAZa
 ZqOoxDJwYqjPoPFyFRPHj2qtDrEYvcSDN94QX4TymGpldGmsCa69QlF2WuPMLNrg2ECG
 UEwQ==
X-Gm-Message-State: AOJu0YyC1llNhZ4MQTtjsHoPjuHd3TpZfC/45/Ln5yK2zAijdx/gat5K
 hVZCtbRfpYpynUwo67gRf88bdTYtpOjFD2/gwD37LsZIBGwNQlotFgCLgyTkmzxS/tAZN0ZDPro
 =
X-Gm-Gg: ASbGnctujYQwPIEqJRaRoJoVAP3pLH0chcmNcgbWhgBvbJoBIizlDAgr7ZqfvFNqtVi
 Ef2+gWELbJJEcfVRQVZQ/gFAp0zLtJ/+rb69UaAYNKfoQjpJ3f/hQTfmrlVoqSDBe5sPkXaEOUc
 epDApodBjkxj+kHU/L8+D/s6mhr96V0LD7NGXOs0/X+X6dXGeluUFQbtpD1WFHhZg8a0Y8AawsG
 C9MTEvvaslyfx7cMAX13HnumRTOVXlMuzjYLbo/CIuAoLrb7tI70+1S6O4KbRGAiO/ygl4D8JYZ
 ms2+daLoKCiFxo/Jn1x3rY6lr5AD2is=
X-Google-Smtp-Source: AGHT+IEoRyiLs8kCJvu/Jv8h2vUfu9bdgAjF/Oj6fW6B96sh+n915cRtPEpQCWCb0nLNxxGyAWl+Cg==
X-Received: by 2002:a05:6e02:748:b0:3ce:7ab4:1afb with SMTP id
 e9e14a558f8ab-3cf743b08d4mr133356645ab.2.1737408449869; 
 Mon, 20 Jan 2025 13:27:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 34/44] test: Drop the info test from the list
Date: Mon, 20 Jan 2025 14:25:56 -0700
Message-ID: <20250120212613.516664-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

The 'info' test is not a real test. With the new suite array we can drop
this and the associated special-case code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd_ut.c               |  4 +---
 test/py/tests/test_suite.py | 13 +++++--------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index efcac626a5b..181cdb43152 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -93,7 +93,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 	NULL, \
 	}
 
-SUITE_DECL(info);
 SUITE_DECL(bdinfo);
 SUITE_DECL(bootstd);
 SUITE_DECL(cmd);
@@ -121,7 +120,6 @@ SUITE_DECL(seama);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
-	SUITE_CMD(info, do_ut_info),
 #ifdef CONFIG_CMD_BDI
 	SUITE(bdinfo),
 #endif
@@ -249,7 +247,7 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 
 		puts("\nTests  Suite\n");
 		puts("-----  -----\n");
-		for (i = 1; i < ARRAY_SIZE(suites); i++) {
+		for (i = 0; i < ARRAY_SIZE(suites); i++) {
 			struct suite *ste = &suites[i];
 			long n_ent = ste->end - ste->start;
 
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index 706c9d9673f..20cdf022536 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -8,7 +8,7 @@ import re
 EXPECTED_SUITES = [
     'addrmap', 'bdinfo', 'bloblist', 'bootm', 'bootstd',
     'cmd', 'common', 'dm', 'env', 'exit',
-    'fdt', 'font', 'hush', 'info', 'lib',
+    'fdt', 'font', 'hush', 'lib',
     'loadm', 'log', 'mbr', 'measurement', 'mem',
     'overlay', 'pci_mps', 'setexpr', 'upl',
     ]
@@ -153,9 +153,8 @@ def test_suite(u_boot_console):
     cons.log.info(f'missing {missing}')
     cons.log.info(f'extra {extra}')
 
-    # Make sure we got a test count for each suite (ignore 'info' since it isn't
-    # a real suite
-    assert suites - exp_test_count.keys() == {'info'}
+    # Make sure we got a test count for each suite
+    assert suites - exp_test_count.keys() == set()
 
     # Run 'ut info' and compare with the log results
     with cons.log.section('Check suite test-counts'):
@@ -174,10 +173,8 @@ def test_suite(u_boot_console):
 
         cons.log.info(str(exp_test_count))
         for suite in EXPECTED_SUITES:
-            # 'info' is not really a suite, just a subcommand of 'ut'
-            if suite != 'info':
-                assert test_count[suite] in ['?', str(exp_test_count[suite])],\
-                    f'suite {suite} expected {exp_test_count[suite]}'
+            assert test_count[suite] in ['?', str(exp_test_count[suite])], \
+                f'suite {suite} expected {exp_test_count[suite]}'
 
         assert suite_count == len(EXPECTED_SUITES)
         assert total_test_count == len(all_tests)
-- 
2.43.0

