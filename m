Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14223CA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F98288C3E;
	Mon,  2 Sep 2024 00:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OzM80M7d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0606388C3A; Mon,  2 Sep 2024 00:27:04 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2D58690D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-82a0c156a79so163545639f.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229620; x=1725834420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6nUj2iJ6D91yt+CC80GYZ3gGPF/plohiQkmH+z5P9o=;
 b=OzM80M7dF2hbDu6PCM0+wOlaRMLPG5xubDK/bInUa/bxrXVA9cpkYbxO3WFGIycKyt
 ToT9ZrF5ckr1eesuW//VJbvAzodnODg9qnbWUdL5tdf4TARuVh9WigdTpTl9sBN2Ty/M
 F2+obvKxDlzY5tOXDapqduhFGTCc3v/MgG8us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229620; x=1725834420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6nUj2iJ6D91yt+CC80GYZ3gGPF/plohiQkmH+z5P9o=;
 b=hXxyhIn0sLigpiwYW7+RLWNfnFIWeJGz20T95ss1HWkWammBYj7KrJpr2wkxD/1eBY
 QsOa0cwM5YiBJrdDzlTGxdpYrDzbTe8P3s+CiJd40ns1kWUhKUIn/BW3t1+HwFxuqWTG
 GszaXBC75MpeHOTCWOSaYln6TD8RQlWda0iZ0aoXlGFMo0DEgspv3xYQO7Vk6xX9ykGy
 POO+JYR2JcsiZ2oH3UWjQSDuXyEVCv9WUpN9+7rqsaV+6T8vRP7aptiS0OPrB5u2wxc6
 4zjrl6P/f/Qae7P/Hc56aIPut6nDh94uw2jm94k4eyOPnVmGS0bABc4oG9+y5czKRk+q
 V6nA==
X-Gm-Message-State: AOJu0YxQx43W4rV9HUMMDATGtmB2/mU/MkMGR7SXNw4mRl6fkzc54owr
 uXSXsaL6fv6m6/5uRw0NuMfKkdtf95LKdTuge5ZpSjym4C625ENywE/sSzWaysVQiqRqWAHQGlM
 =
X-Google-Smtp-Source: AGHT+IEcKAEuewWmvVhb+WZ9spjWLjPfU4iwWM6hwjCPgpuFCtcWn0ptDowVtllfyI8qC6hayACpCA==
X-Received: by 2002:a05:6602:6c08:b0:82a:2a6b:b2aa with SMTP id
 ca18e2360f4ac-82a2a6bb352mr891061039f.14.1725229619721; 
 Sun, 01 Sep 2024 15:26:59 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 11/23] test: mbr: Adjust test to drop 0x
Date: Sun,  1 Sep 2024 16:26:22 -0600
Message-Id: <20240901222634.460873-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

U-Boot commands typically don't need 0x to specify hex, since they use
hex by default. Adding 0x in this test is confusing since it suggests
that it is necessary. Drop it from the file.

Also use the %#x construct to get the 0x when needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 74 +++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 98a745df6bc..c38199740a3 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -267,19 +267,19 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* Make sure mmc6 is 12+ MiB in size */
-	ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra,
+	ut_assertok(run_commandf("mmc read %lx %lx 1", ra,
 				 (ulong)0xbffe00 / 0x200));
 
 	/* Test one MBR partition */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 1));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0 1", mbr_wa));
+	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
+	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
@@ -288,7 +288,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assert_console_end();
 	/*
@@ -299,23 +299,23 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p1[i],
-			"1P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
+			"1P MBR+0x%04X: expected %#02X, actual: %#02X\n",
 			mbr_cmp_start + i, mbr_parts_ref_p1[i], rbuf[mbr_cmp_start + i]);
 	}
 
 	/* Test two MBR partitions */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 2));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0 1", mbr_wa));
+	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
+	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
@@ -323,7 +323,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assert_console_end();
 	/*
@@ -334,23 +334,23 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p2[i],
-			"2P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
+			"2P MBR+0x%04X: expected %#02X, actual: %#02X\n",
 			mbr_cmp_start + i, mbr_parts_ref_p2[i], rbuf[mbr_cmp_start + i]);
 	}
 
 	/* Test three MBR partitions */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 3));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0 1", mbr_wa));
+	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
+	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
@@ -358,7 +358,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assert_console_end();
 	/*
@@ -369,23 +369,23 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p3[i],
-			"3P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
+			"3P MBR+0x%04X: expected %#02X, actual: %#02X\n",
 			mbr_cmp_start + i, mbr_parts_ref_p3[i], rbuf[mbr_cmp_start + i]);
 	}
 
 	/* Test four MBR partitions */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 4));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0 1", mbr_wa));
+	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
+	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
@@ -393,7 +393,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assert_console_end();
 	/*
@@ -404,23 +404,23 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001f0  26 01 0e 87 06 01 00 58  00 00 00 08 00 00 55 aa  |&......X......U.|
 	*/
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p4[i],
-			"4P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
+			"4P MBR+0x%04X: expected %#02X, actual: %#02X\n",
 			mbr_cmp_start + i, mbr_parts_ref_p4[i], rbuf[mbr_cmp_start + i]);
 	}
 
 	/* Test five MBR partitions */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 5));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0 1", mbr_wa));
+	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
-	ut_assertok(run_commandf("write mmc 6:0 0x%lx 0x%lx 1", ebr_wa, ebr_blk));
+	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertf(0 == run_commandf("mbr write mmc 6"), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -436,10 +436,10 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001f0  26 01 05 a7 26 01 00 58  00 00 00 10 00 00 55 aa  |&...&..X......U.|
 	*/
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0 1", ra));
+	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p5[i],
-			"5P MBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
+			"5P MBR+0x%04X: expected %#02X, actual: %#02X\n",
 			mbr_cmp_start + i, mbr_parts_ref_p5[i], rbuf[mbr_cmp_start + i]);
 	}
 	/*
@@ -450,10 +450,10 @@ static int mbr_test_run(struct unit_test_state *uts)
 	00b001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	for (unsigned i = 0; i < ebr_cmp_size; i++) {
 		ut_assertf(rbuf[ebr_cmp_start + i] == ebr_parts_ref_p5[i],
-			"5P EBR+0x%04X: expected 0x%02X, actual: 0x%02X\n",
+			"5P EBR+0x%04X: expected %#02X, actual: %#02X\n",
 			ebr_cmp_start + i, ebr_parts_ref_p5[i], rbuf[ebr_cmp_start + i]);
 	}
 
-- 
2.34.1

