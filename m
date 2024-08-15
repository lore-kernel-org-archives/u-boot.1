Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CCEC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A89AC88B3C;
	Thu, 15 Aug 2024 22:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HbefEIf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD43288AFC; Thu, 15 Aug 2024 22:26:07 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636A388AF2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-396e2d21812so5377295ab.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753559; x=1724358359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hv5CQZtvqIcRAzXF4f4WtoI+4p46tzX/HHM7gwIf1Y8=;
 b=HbefEIf1f9sSpegpKQ3OPybCigva+ci/eydopg4MO5/5qGM5wLZbL1C71zhIrshFBp
 ZtDW/L05tpUQb1IrFIsMROIamCOATY4GfCN/fAfhI0QDYVu8+8asOnGX03lv3G0uSWfk
 NsH+QkDU6Z7aIZ/4RCg9DbVUviZQliVxo7XAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753559; x=1724358359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hv5CQZtvqIcRAzXF4f4WtoI+4p46tzX/HHM7gwIf1Y8=;
 b=YiPN7UBx7op2buh9TxGcKmC753rIV5Uy58dqYqvJM7PKaFA1/EYjyrRf9P7dv8SSZd
 DNoinVbX3EzffeNPqAauXWYoCPRt99LqeaWL+vCz57modPnrX4g/DlElXesI3nPpK+fX
 5Ce+v6zu4af89p+4GqR8FTVn2PDEzndJI3pX7hVHCuxOaI6oN3ku5jmpubno9H7mZ5zW
 Dp0T3s8rfsfODp+o2k3EngNdw/hTjUCQctnrhp4dOrReGLe3FMuohCKKzu8Xi6EdZtp0
 R63rkbjGKTId6/SW7m2kJm8suSAWlN8gC5tPSpVl47KFnpVXL+7ndN3vuOu0JqceOI4R
 K+WA==
X-Gm-Message-State: AOJu0YyLwIkqpeWdDegZGtMmElVsAj7lzIbmmUPWz7BMNFtnQo3Xh7Qo
 JYnCxS1OO3bBHoBDYAjVuCgpcL8XBcKd7F60F3JFXbM2EiUgLJxew8ieC8JfoJQXWV9T84Z47gA
 SVw==
X-Google-Smtp-Source: AGHT+IFLBlQ3Z2TJ/1sxgUquPTamukTRdbgUKP5oI3btCOvozPPd/+kpDxmFGY5RiQ5wx5/t/FlEnQ==
X-Received: by 2002:a05:6e02:18cc:b0:374:9c67:1df6 with SMTP id
 e9e14a558f8ab-39d26d64816mr13346235ab.22.1723753559326; 
 Thu, 15 Aug 2024 13:25:59 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 22/24] test: mbr: Use a constant for the block size
Date: Thu, 15 Aug 2024 14:25:33 -0600
Message-Id: <20240815202535.767869-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

Changes in v3:
- use SZ_512 instead of 0x200

 test/cmd/mbr.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 8a4d61b2928..e2a7cc35500 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -14,10 +14,14 @@
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/sizes.h>
 #include <test/suites.h>
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
+
+#define BLKSZ	SZ_512	/* block size */
+
 /*
  * Requirements for running test manually:
  * mmc6.img - File size needs to be at least 12 MiB
@@ -228,7 +232,7 @@ static unsigned build_mbr_parts(char *buf, size_t buf_size, unsigned num_parts)
 static int mbr_test_run(struct unit_test_state *uts)
 {
 	struct blk_desc *mmc_dev_desc;
-	unsigned char mbr_wbuf[512], ebr_wbuf[512], rbuf[512];
+	unsigned char mbr_wbuf[BLKSZ], ebr_wbuf[BLKSZ], rbuf[BLKSZ];
 	char mbr_parts_buf[256];
 	ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
 	struct udevice *dev;
@@ -257,7 +261,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	mbr_wa = map_to_sysmem(mbr_wbuf);
 	ebr_wa = map_to_sysmem(ebr_wbuf);
 	ra = map_to_sysmem(rbuf);
-	ebr_blk = (ulong)0xb00000 / 0x200;
+	ebr_blk = (ulong)0xb00000 / BLKSZ;
 
 	/* Make sure mmc6 exists */
 	ut_asserteq(6, blk_get_device_by_str("mmc", "6", &mmc_dev_desc));
@@ -269,7 +273,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 
 	/* Make sure mmc6 is 12+ MiB in size */
 	ut_assertok(run_commandf("mmc read %lx %lx 1", ra,
-				 (ulong)0xbffe00 / 0x200));
+				 (ulong)0xbffe00 / BLKSZ));
 
 	/* Test one MBR partition */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
@@ -277,11 +281,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
@@ -290,7 +294,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -313,11 +317,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
@@ -326,7 +330,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -349,11 +353,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
@@ -362,7 +366,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -385,11 +389,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
@@ -398,7 +402,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -421,11 +425,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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

