Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF51C3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A80888AA;
	Sat, 10 Aug 2024 22:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kCnpQQFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFCA888A0; Sat, 10 Aug 2024 22:52:39 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7CFF88905
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81f8f0197abso153341739f.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323149; x=1723927949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9fCDARGClrtvaV6RYk3aEGgoh5ButGLsr99j0PTG+Y=;
 b=kCnpQQFKQErwP/cnDciDlNAFeExnS2ZDPXDOtme2V272CD7qlFU1aJWV0linWVOvDQ
 iX4T8MyQ657wb3iuD1XGvflMKKbKW6keoWLuMDjylR/j5V8MXHNSqyBRsIEGux/oMX5d
 dP246OSJOySZdhtqm0VTJC2ybh1njzAkGVWt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323149; x=1723927949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9fCDARGClrtvaV6RYk3aEGgoh5ButGLsr99j0PTG+Y=;
 b=MjXY0x1nm9YONz6UYvzNC3Zhy3mdG/3pVZq1spAiYZ87nTqcZnv+PZE84nEOTzN5rz
 U+Mmz3ksQF2ae7QEr5q1IOxkqRmA0w1W+5t9gCa8XZ3epT5NY0p2D8morvQS+c17Z4Vc
 /EAzNi1hlxjYaOs1tyfU6g8X29KffLC5PwU2arq91ueep+dBtPe/x8xyrtN8H1I2GVXm
 RoR1C+8QTTf/mTMhLUxN7NJwW9+pD5AKFBmaH/R3u4h/6rG60/qax2iiVHyU1WTlDDq8
 vWs7FBQB22I6UGINu6eg6xQwhDoN8yZPe3d7DD4T58EPXKWBR+IvlIPKCqaFp9yE6Lsz
 9WSA==
X-Gm-Message-State: AOJu0Yx6AjeEmvB+jZhRs9zoUT+YZuQSgbw67aBh07CUVeNaG2uZMrlJ
 aCacG1+dg8PSW5XS+vyhzxGtOcJdROFvfUu//NPZr6o566MCcMaXlHzrvvC8uQ7Z7xbF0XlTDYA
 =
X-Google-Smtp-Source: AGHT+IHto0wsEYdCtkKUHMA3an5VpwaVmQTJePKlZubBTsjBlP93UU5cuJ5WQ0tfG/KyxhPC4PMSQg==
X-Received: by 2002:a05:6602:6199:b0:804:f2be:ee33 with SMTP id
 ca18e2360f4ac-8225ee680a1mr698422139f.2.1723323149414; 
 Sat, 10 Aug 2024 13:52:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH 10/21] test: bloblist: Use UTF_CONSOLE in tests
Date: Sat, 10 Aug 2024 14:51:54 -0600
Message-Id: <20240810205205.3403177-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Set this flag rather than doing things manually in the test.

Drop the code which is now unnecessary.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/bloblist.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/test/bloblist.c b/test/bloblist.c
index 7c63682908a..fd85c7ab79e 100644
--- a/test/bloblist.c
+++ b/test/bloblist.c
@@ -270,20 +270,15 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
-	console_record_reset_enable();
-	ut_silence_console(uts);
-	console_record_reset();
 	run_command("bloblist info", 0);
 	ut_assert_nextline("base:       %lx", (ulong)map_to_sysmem(hdr));
 	ut_assert_nextline("total size: 400    1 KiB");
 	ut_assert_nextline("used size:  50     80 Bytes");
 	ut_assert_nextline("free:       3b0    944 Bytes");
-	ut_assert_console_end();
-	ut_unsilence_console(uts);
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_cmd_info, 0);
+BLOBLIST_TEST(bloblist_test_cmd_info, UTF_CONSOLE);
 
 /* Test the 'bloblist list' command */
 static int bloblist_test_cmd_list(struct unit_test_state *uts)
@@ -296,21 +291,16 @@ static int bloblist_test_cmd_list(struct unit_test_state *uts)
 	data = bloblist_ensure(TEST_TAG, TEST_SIZE);
 	data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
 
-	console_record_reset_enable();
-	ut_silence_console(uts);
-	console_record_reset();
 	run_command("bloblist list", 0);
 	ut_assert_nextline("Address       Size   Tag Name");
 	ut_assert_nextline("%08lx  %8x  fff000 SPL hand-off",
 			   (ulong)map_to_sysmem(data), TEST_SIZE);
 	ut_assert_nextline("%08lx  %8x   202 Chrome OS vboot context",
 			   (ulong)map_to_sysmem(data2), TEST_SIZE2);
-	ut_assert_console_end();
-	ut_unsilence_console(uts);
 
 	return 0;
 }
-BLOBLIST_TEST(bloblist_test_cmd_list, 0);
+BLOBLIST_TEST(bloblist_test_cmd_list, UTF_CONSOLE);
 
 /* Test alignment of bloblist blobs */
 static int bloblist_test_align(struct unit_test_state *uts)
-- 
2.34.1

