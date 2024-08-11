Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE75C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1141B88B2A;
	Sun, 11 Aug 2024 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dwUQaFOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE15688AC0; Sun, 11 Aug 2024 16:52:52 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C0BC88A4B
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39b32f258c8so15336105ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387969; x=1723992769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vcNh4A/0Y2cDSZmNL1fx6L/Fv+ZKklzesoZR46WLOc=;
 b=dwUQaFOV7FGVvS/8GG6tEnseNB65r00B4CIQYMcgwrD2qZurzTxtPEQamZH4MRvlhs
 H+NWmevGpyfbxkzRDfsbINMtobvzLRV3a36Mu5PwrJN6L6C+9cCUb1w3qfT283pyhaYo
 R/mTuzKO7/bUm1rWFx1pE4Wl+lhnOpwTSOw2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387969; x=1723992769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vcNh4A/0Y2cDSZmNL1fx6L/Fv+ZKklzesoZR46WLOc=;
 b=Kjs7++Z1xqJPdSjI4KmDnp9gRMTtb9W5hXuv0X1BP/3Hzuns7mKaMjF1pb1T0U1Q7u
 IOClKTZkk5NeRwUCBmyF5emj4szt9kYIJ42GxvOhNPx/51j/NfiZHfNmHBIeDbP+cU13
 +BWUroFjxQ4Bgmg40+m9Iw+kcLI6ILZOVJKA0sCqwiji6A6YqejNuSNgyoSuL5rfMgf+
 W2Qeauabk2hvx6NjWqnuFGsHyo8qFuopywS8C/lUAnujGbOLkD3do3uzBp38D9VQkvZ4
 rudWe/C6SX1Olg3uuIrG2BU2OMME5tZbgUQ7ey4Ohn6YXmxrlGTcvUehVBqjQT85Dn+x
 VhPA==
X-Gm-Message-State: AOJu0YysrZ47j7pLY9ijf71PkMiAWjymbCIyQoQ2vmcY4hzOo7nFr8bM
 qTlfBMRQSk5kfx/lZqK0Uwl/yNHqm5ASfonQV66YNzYmwZ45cSuQ2YjbcONLFADE426sgsOP6WQ
 =
X-Google-Smtp-Source: AGHT+IHelvCfJe2Zhr9CtLja0TzUd4sQVtie4NzdnYDtFakHKEouX8eDRny2KO3O7flW9SRa3blKPA==
X-Received: by 2002:a05:6e02:1c05:b0:398:a9b3:d6b1 with SMTP id
 e9e14a558f8ab-39bd8c50832mr66423365ab.12.1723387968929; 
 Sun, 11 Aug 2024 07:52:48 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 23/40] test: mbr: Use RAM for the buffers
Date: Sun, 11 Aug 2024 08:51:52 -0600
Message-Id: <20240811145209.4191404-24-sjg@chromium.org>
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

The normal approach with sandbox is to use a fixed memory address in the
RAM, to avoid needing to create a map for transient local variables.

Update this test to use this approach.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 52 ++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index e2a7cc35500..ec19cf3793c 100644
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
@@ -279,11 +281,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
@@ -292,7 +294,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
@@ -303,7 +305,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p1[i],
@@ -315,11 +317,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
@@ -328,7 +330,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
@@ -339,7 +341,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p2[i],
@@ -351,11 +353,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
@@ -364,7 +366,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
@@ -375,7 +377,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 00  |...f%..P........|
 	000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p3[i],
@@ -387,11 +389,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
@@ -400,7 +402,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_nextline("MBR: write success!");
 	ut_assertok(run_commandf("mbr verify mmc 6"));
 	ut_assert_nextline("MBR: verify success!");
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx %lx 1", ra, ebr_blk));
 	ut_assertok(memcmp(ebr_wbuf, rbuf, BLKSZ));
 	ut_assertok(ut_check_console_end(uts));
@@ -411,7 +413,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 66  |...f%..P.......f|
 	000001f0  26 01 0e 87 06 01 00 58  00 00 00 08 00 00 55 aa  |&......X......U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p4[i],
@@ -423,11 +425,11 @@ static int mbr_test_run(struct unit_test_state *uts)
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
 	ut_assertok(console_record_reset_enable());
@@ -444,7 +446,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	000001e0  06 01 0e 66 25 01 00 50  00 00 00 08 00 00 00 66  |...f%..P.......f|
 	000001f0  26 01 05 a7 26 01 00 58  00 00 00 10 00 00 55 aa  |&...&..X......U.|
 	*/
-	memset(rbuf, 0, sizeof(rbuf));
+	memset(rbuf, '\0', BLKSZ);
 	ut_assertok(run_commandf("read mmc 6:0 %lx 0 1", ra));
 	for (unsigned i = 0; i < mbr_cmp_size; i++) {
 		ut_assertf(rbuf[mbr_cmp_start + i] == mbr_parts_ref_p5[i],
@@ -458,7 +460,7 @@ static int mbr_test_run(struct unit_test_state *uts)
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

