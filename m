Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEA9C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8991988C59;
	Mon,  2 Sep 2024 00:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rd+FV+oQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF9CE88CEB; Mon,  2 Sep 2024 00:27:16 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C158788CB8
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-82a24dec9cbso92139439f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229632; x=1725834432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUZ6VM/ePyGl4Q6YPvi71CfUOB8kallLY3IPqCW8UBc=;
 b=Rd+FV+oQDTye8V5ruASnYMjFqm3pwlj/lHkxOi/xlza4z8zKeIcf0/muHbd8aX3TtX
 56tbKOtdD9AR2m7RmjEFCDQ5PL3YJcVcWxHro0p4AB900ZbOkZzJz0Mt1rx7yG7EYbt6
 bHEvt6Mi9TdmGKEQ3X/NCfId18KfTuez6QCQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229632; x=1725834432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vUZ6VM/ePyGl4Q6YPvi71CfUOB8kallLY3IPqCW8UBc=;
 b=eHWJQno3WyAbW6VtEIUUKBk71C6g4jwXU8C4wBUXRjpZfdTXeO25iAbwhD5I/JhNSE
 IXOq46s6M/QCIJ3c9zqOWj3E+AO3sWbHpnYWmFappdzHp7zBVagFZiT4g1DvwBOK7oa3
 ou9kohSGzXzypCjR/IilZINU2/K/QZjQJVRK0gIRysQiCp3qke33paDOlc+v5n1xLY+f
 a277acGW5tDrxkyTCTnUj6nh4UczE+8/F6HPdM1PwSoehk/aVJZBkTBEH36vNbLugBaC
 WKHy+hIAY2WpeAaLqQenpQBChqOyqMBmEYp+4Wq+4H/EU7a9c01cthVr61IOx/RtH9SK
 R7iw==
X-Gm-Message-State: AOJu0Yyi+HvkwmhpaX715II40XaUTWDcyTMN+jjqlySFcA2+7rlNePQ7
 gJQ2XbGwvETYA6kPN97qd20Vap1/wzeoc6p22sQn1E9dRNJeSEDXoJsVBs6v1nScpGqU1kBEgVc
 =
X-Google-Smtp-Source: AGHT+IE/uQDiQ0T+c2sOXkbaMi/B0xh/tLHR480Hg4Vsp41r7fi5BT/jg8IRw/gQxCBeNXDA0lpcBQ==
X-Received: by 2002:a05:6602:611a:b0:7fa:244c:bfe6 with SMTP id
 ca18e2360f4ac-82a13ec8d9amr828205039f.8.1725229632251; 
 Sun, 01 Sep 2024 15:27:12 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 21/23] test: mbr: Use a constant for the block size
Date: Sun,  1 Sep 2024 16:26:32 -0600
Message-Id: <20240901222634.460873-22-sjg@chromium.org>
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

It isn't that important to factor out constants in tests, but in this
case we have 0x200 and 512 used. The commands don't use the constant
as they use a block count ('1'). It doesn't create more code to use a
constant, so create one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- use SZ_512 instead of 0x200

 test/cmd/mbr.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index e750875ea43..e67e777c995 100644
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
@@ -268,7 +272,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 
 	/* Make sure mmc6 is 12+ MiB in size */
 	ut_assertok(run_commandf("mmc read %lx %lx 1", ra,
-				 (ulong)0xbffe00 / 0x200));
+				 (ulong)0xbffe00 / BLKSZ));
 
 	/* Test one MBR partition */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
@@ -276,11 +280,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
 	ut_assert_nextlinen("MMC read: dev # 6");
@@ -289,7 +293,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -312,11 +316,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
 	ut_assert_nextline("MBR: write success!");
@@ -324,7 +328,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -347,11 +351,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
 	ut_assert_nextline("MBR: write success!");
@@ -359,7 +363,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -382,11 +386,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertok(run_commandf("mbr write mmc 6"));
 	ut_assert_nextline("MBR: write success!");
@@ -394,7 +398,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: verify success!");
 	memset(rbuf, 0, sizeof(rbuf));
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
-	ut_assertok(memcmp(ebr_wbuf, rbuf, 512));
+	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assert_console_end();
 	/*
 	000001b0  00 00 00 00 00 00 00 00  78 56 34 12 00 00 80 05  |........xV4.....|
@@ -417,11 +421,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assertf(0 == run_commandf("mbr write mmc 6"), "Invalid partitions string: %s\n", mbr_parts_buf);
 	ut_assert_nextline("MBR: write success!");
-- 
2.34.1

