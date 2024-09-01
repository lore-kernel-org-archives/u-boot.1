Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D632DCA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2AAC88C9F;
	Mon,  2 Sep 2024 00:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fw8+f7Z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C132088C9F; Mon,  2 Sep 2024 00:27:17 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B66688CE7
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-82a29c11e53so134634639f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229633; x=1725834433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1V+taZo0Uks9Z4TEnOMP3OFRpPdmryau6Gw23ekvQE=;
 b=Fw8+f7Z+LT6hTfn6ZE5ySp20HKmlJ7QBrcFJ5+cOfDeffYVC4NL7yuLXxq9WFvyAZQ
 AwFQ/Alp7K4fZ6JyR3pehl9JtTuirYbXJGf8NAtkieUt9uhGIEbqqrVIsUunk/oaHuRT
 qKmSVcPRLsxHvsHArXoBpO+kWLTnmQ3xZ0R0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229633; x=1725834433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1V+taZo0Uks9Z4TEnOMP3OFRpPdmryau6Gw23ekvQE=;
 b=FquWFnpdxBjv+lcrCRUQVUDbgCUL1W8486SyWesEqcxAaNuw4sWqBgHXm10LKUHWBm
 UjBscEGgoqP0T/MJ0r6CW+NzSYMRt1KqBT7E9dS3IHUOCJXLrCUw3djL5XFPCPlMeDfn
 c8+zd6yMaDchf+TUDCPE1qUrxvfABk1ZH10NUCuZSdyPYSoKPQztphEv4DI69Mqmp52g
 Q/dtUuLP9um13/S6xmOYKbIo7iEDQ3g/wKmkT976zv3JpnsmJQlWYgZ8zkZvn49Xdgja
 xCoQYOmUgq5T+hryJZ7RfDLSHqFVPjt0MiMFr8skXCHALNuO4uxFIKW7Oi6ST6Td41NA
 FLFA==
X-Gm-Message-State: AOJu0YxifuQ/PSiL5jcO3g85BpgnVpPrc0Sw5nPHpX504n+cxpaju+Jo
 Jm0r70ZVHO1jkOw8dlJlkVVj+Hpe2E0pr582lEDNVYBbnotyM/JD6gHCPaL0PV6XGMMAN8VKjb8
 =
X-Google-Smtp-Source: AGHT+IGIfA/gzRCUWH1bou0UZ35CMtV2XgXG8Y284va+kn1R6jij/f9lvVkMK8qnUWGMHjvSKmH/tw==
X-Received: by 2002:a05:6602:2c0f:b0:7f6:8303:ba80 with SMTP id
 ca18e2360f4ac-82a3755338amr663430039f.11.1725229633453; 
 Sun, 01 Sep 2024 15:27:13 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 22/23] test: mbr: Use RAM for the buffers
Date: Sun,  1 Sep 2024 16:26:33 -0600
Message-Id: <20240901222634.460873-23-sjg@chromium.org>
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

The normal approach with sandbox is to use a fixed memory address in the
RAM, to avoid needing to create a map for transient local variables.

Update this test to use this approach.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 52 ++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index e67e777c995..72799612381 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -232,9 +232,11 @@ static unsigned build_mbr_parts(char *buf, size_t buf_size, unsigned num_parts)
 static int mbr_test_run(struct unit_test_state *uts)
 {
 	struct blk_desc *mmc_dev_desc;
-	unsigned char mbr_wbuf[BLKSZ], ebr_wbuf[BLKSZ], rbuf[BLKSZ];
+	unsigned char *mbr_wbuf, *ebr_wbuf, *rbuf;
 	char mbr_parts_buf[256];
-	ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
+	ulong addr = 0x1000;  /* start address for buffers */
+	ulong mbr_wa = addr, ebr_wa = addr + BLKSZ, ra = addr + BLKSZ * 2;
+	ulong ebr_blk, mbr_parts_max;
 	struct udevice *dev;
 	ofnode root, node;
 
@@ -258,9 +260,9 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertf(sizeof(mbr_parts_buf) >= mbr_parts_max, "Buffer avail: %ld; buffer req: %ld\n",
 		sizeof(mbr_parts_buf), mbr_parts_max);
 
-	mbr_wa = map_to_sysmem(mbr_wbuf);
-	ebr_wa = map_to_sysmem(ebr_wbuf);
-	ra = map_to_sysmem(rbuf);
+	mbr_wbuf = map_sysmem(mbr_wa, BLKSZ);
+	ebr_wbuf = map_sysmem(ebr_wa, BLKSZ);
+	rbuf = map_sysmem(ra, BLKSZ);
 	ebr_blk = (ulong)0xb00000 / BLKSZ;
 
 	/* Make sure mmc6 exists */
@@ -278,11 +280,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 1));
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -291,7 +293,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assert_console_end();
@@ -302,7 +304,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p1[i],
@@ -314,11 +316,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 2));
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -326,7 +328,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assert_console_end();
@@ -337,7 +339,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p2[i],
@@ -349,11 +351,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 3));
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -361,7 +363,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assert_console_end();
@@ -372,7 +374,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 00  |...f%..P........|
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p3[i],
@@ -384,11 +386,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 4));
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -396,7 +398,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assert_console_end();
@@ -407,7 +409,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 66  |...f%..P.......f|
 	000001f0  26 01 0e 87 06 01 00 58  00 00 00 08 00 00 55 aa  |&......X......U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p4[i],
@@ -419,11 +421,11 @@ static int mbr_test_run(struct unit_test_state *uts)
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 5));
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	ut_assertok(memcmp(mbr_wbuf, rbuf, BLKSZ));
 	ut_assertok(run_commandf("write mmc 6:0 %lx %lx 1", ebr_wa, ebr_blk));
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertf(0 == run_commandf(mbr_parts_buf), "Invalid partitions string: %s\n", mbr_parts_buf);
@@ -439,7 +441,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 66  |...f%..P.......f|
 	000001f0  26 01 05 a7 26 01 00 58  00 00 00 10 00 00 55 aa  |&...&..X......U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p5[i],
@@ -453,7 +455,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	00b001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 	00b001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	for (unsigned i = 0; i < ebr_cmp_size; i++) {
 		ut_assertf(rbuf[ebr_cmp_start + i] == ebr_parts_ref_p5[i],
-- 
2.34.1

