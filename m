Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6E1C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0983788A29;
	Sun, 11 Aug 2024 16:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EmizTIgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1A288A39; Sun, 11 Aug 2024 16:52:44 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537F5889E3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81f861f369aso140333239f.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387961; x=1723992761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YVDV66ck5Lp+AyOKOisHSkjBVWjbF4qL0kXYC8tP5A=;
 b=EmizTIgOWKh/nTujX1DZ4vKe7ndaN+NYS+WeKYpQXo0uHlHq/b1jaJGdSlc6acXU8G
 gLRI0Xzaf3Q192kInso4tTVZtff3yM2Lyo81fqn6GAeBdWeHRULLzesWAbEEj7MbkVro
 qcvjAu3i8otx20ler2TwgTSJJ0CFdAfx63+uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387961; x=1723992761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5YVDV66ck5Lp+AyOKOisHSkjBVWjbF4qL0kXYC8tP5A=;
 b=btcLl/dpcKcVc4A6ecoQERvRwDOA4rmzlrfKXJamv1ORCJGuFFY3A6+bcs1UNP+rd4
 czzQkssHiSr+Ftsmg+1JlnADrvsQtPr9nU+H7JaaRR38h18T0/4jmwjelBeWmHofxWX+
 Rb3bJNKV4/ZQTOeE0WC+mxOt32cCfrDd0FwPOmaChqTX8RdqFvNm3MOGIoJjpRxzurIA
 LdK5UxxCBIbQwzdsot7DjG3P6NzyTN0u7fN3I8idUJh5YktFR4L3K3nVsV0yV2ZGFyxA
 h54SerA/p1s+upgXeBD67wDFEgOnCmKYaL3whc6wIk1qInSVKkKsf12tDG6i6q8Q1A1V
 Kyyw==
X-Gm-Message-State: AOJu0Yyiy5SmobSE4Z3HIT74Nh1n22DwXiLy1dxRx7bM2PyBZi/R7jRp
 brvUo+UIwLSUgbjKZA3YAUbuzWYe7R4Z8f1NMiDHff7vgS0mVTKy9ANabUzzPuZkqgjnhLWwnPM
 =
X-Google-Smtp-Source: AGHT+IHOkOKcP4pONsEZ30/dLoe3yh1ZRMrLVgOUyKcBrLcMlYMUFTmt1GVRBEfeD/7wombSFPeOIw==
X-Received: by 2002:a05:6e02:1c05:b0:398:a9b3:d6b1 with SMTP id
 e9e14a558f8ab-39bd8c50832mr66421705ab.12.1723387960878; 
 Sun, 11 Aug 2024 07:52:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 12/40] test: mbr: Adjust test to drop 0x
Date: Sun, 11 Aug 2024 08:51:41 -0600
Message-Id: <20240811145209.4191404-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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
index 4c884af10c7..1a35ba3351c 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -268,19 +268,19 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
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
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -289,7 +289,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertok(ut_check_console_end(uts));
 	/*
@@ -300,23 +300,23 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -325,7 +325,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertok(ut_check_console_end(uts));
 	/*
@@ -336,23 +336,23 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -361,7 +361,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertok(ut_check_console_end(uts));
 	/*
@@ -372,23 +372,23 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -397,7 +397,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
-	ut_assertok(run_commandf("read mmc 6:0 0x%lx 0x%lx 1", ra, ebr_blk));
+	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
 	ut_assertok(ut_check_console_end(uts));
 	/*
@@ -408,23 +408,23 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -441,10 +441,10 @@ static int mbr_test_run(struct unit_test_state *uts)
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
@@ -455,10 +455,10 @@ static int mbr_test_run(struct unit_test_state *uts)
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

