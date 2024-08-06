Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2D6C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E96788ADB;
	Tue,  6 Aug 2024 14:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FLsXKMmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDE088A8C; Tue,  6 Aug 2024 14:59:48 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E072888A8B
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39728bbf949so2752105ab.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949178; x=1723553978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoAoBp4vp7p8A7nAVsIW+HrOOxWmu+WSMrqjmrctxos=;
 b=FLsXKMmTld17DandQ3vKHyrYEacCXePIQHebQpnuUWRla0GqvswzcZt05QvmyOSqPk
 YUKxHGzeSeZJE/mheYbY2+bGqRNRn+JRrVX9QXF+iX5vFZktRWyboiPPKRtoTkvPMUM1
 9gzByUBlIkGs7ySeyIs5QjNLnmEoBpPHI3Gvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949178; x=1723553978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoAoBp4vp7p8A7nAVsIW+HrOOxWmu+WSMrqjmrctxos=;
 b=nrxbumuQyjbZCL3YCyLnF96GlnM+Sj1SuOQqcb9aIofvcNk+/n9fr+md64VrkNuobe
 JUZYt/JPOpimTrcAcL4H97O4F1xtnm8qW9o8wKMiiVOME/Ih1Uwc4Vo9kcSUn84KuWhw
 WhC7BOEFCrIot+t9Z/2ToKHl6R5DxpCwUrSVy28IhY5UmheHQueffPwVS+MUiAAirdz0
 syXMpwG93MzsU/Q69U3lAoHDT0Z0t1jtmr4i0pTHQukKh46UjU4Q+U2m8lZdYPBw+PQV
 RFLpaVW8lnAfhjwjEg7X/iCaQhaCMdv07o8jVnttSd3yJQJPytYRqcRYOgwjEirkMH46
 TfAw==
X-Gm-Message-State: AOJu0YzutA4I4YfNobMZgr1l9WshTM8WOWORXGWbQGNd5Jud6m8R/yjt
 u0nn/bpBtFIQguuHBQQar1U9kvm5J5oQ5zOTCyDX4lDJMMDJKWjfE+C80FVxJlGfiESMGGmE4oU
 =
X-Google-Smtp-Source: AGHT+IHKA/UJoWSzeolrbTM8AAQtJkYgqTJqj42FQ1yyxjQ38ACqkrIiLJtiXxaGphs+bKi4c06I8g==
X-Received: by 2002:a05:6e02:58a:b0:39b:3e01:cbd4 with SMTP id
 e9e14a558f8ab-39b3e01cc55mr70520785ab.14.1722949177821; 
 Tue, 06 Aug 2024 05:59:37 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>
Subject: [PATCH v2 22/39] test: mbr: Use a constant for the block size
Date: Tue,  6 Aug 2024 06:58:33 -0600
Message-Id: <20240806125850.2316956-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

It isn't that important to factor out constants in tests, but in this
case we have 0x200 and 512 used. The commands don't use the constant
as they use a block count ('1'). It doesn't create more code to use a
constant, so create one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 8a4d61b2928..bab92c3ba00 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -18,6 +18,9 @@
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
+
+#define BLKSZ	0x200	/* block size */
+
 /*
  * Requirements for running test manually:
  * mmc6.img - File size needs to be at least 12 MiB
@@ -228,7 +231,7 @@ static unsigned build_mbr_parts(char *buf, size_t buf_size, unsigned num_parts)
 static int mbr_test_run(struct unit_test_state *uts)
 {
 	struct blk_desc *mmc_dev_desc;
-	unsigned char mbr_wbuf[512], ebr_wbuf[512], rbuf[512];
+	unsigned char mbr_wbuf[BLKSZ], ebr_wbuf[BLKSZ], rbuf[BLKSZ];
 	char mbr_parts_buf[256];
 	ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
 	struct udevice *dev;
@@ -257,7 +260,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	mbr_wa = map_to_sysmem(mbr_wbuf);
 	ebr_wa = map_to_sysmem(ebr_wbuf);
 	ra = map_to_sysmem(rbuf);
-	ebr_blk = (ulong)0xb00000 / 0x200;
+	ebr_blk = (ulong)0xb00000 / BLKSZ;
 
 	/* Make sure mmc6 exists */
 	ut_asserteq(6, blk_get_device_by_str("mmc", "6", &mmc_dev_desc));
@@ -269,7 +272,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 
 	/* Make sure mmc6 is 12+ MiB in size */
 	ut_assertok(run_commandf("mmc read %lx %lx 1", ra,
-				 (ulong)0xbffe00 / 0x200));
+				 (ulong)0xbffe00 / BLKSZ));
 
 	/* Test one MBR partition */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
@@ -277,11 +280,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
-	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
@@ -290,7 +293,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -313,11 +316,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
-	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
@@ -326,7 +329,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -349,11 +352,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
-	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
@@ -362,7 +365,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -385,11 +388,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
-	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
@@ -398,7 +401,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -421,11 +424,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
-	ut_assertok(memcmp(mbr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(console_record_reset_enable());
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertf(0 == run_commandf("mbr write mmc 6"), "Invalid partitions string: %s\n", mbr_parts_buf);
-- 
2.34.1

