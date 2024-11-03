Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6E7E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AED188F50;
	Sun,  3 Nov 2024 01:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H56n7f4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90858908F; Sun,  3 Nov 2024 01:30:07 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BA988AAC
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2110a622d76so22653425ad.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730593803; x=1731198603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cxs9CvHA67qnbSJ+RVjAHysx1cn5wr2i8qZEopG9XHE=;
 b=H56n7f4qxxWlurv2F3j6i8H7rVIHG0r/LHSYBXMZackEqghaYq39cqAF1x8gzuPV24
 kop+ENGNl6ibyhEihEWQJ6pV6WU6jdDgD3u4aeiEc5twFWsI8l3JdkDrFmuBg03eZE6A
 nVeXZrXRBg1HC9f9+jwlWDUKTwWU+3Wh+SLc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730593803; x=1731198603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cxs9CvHA67qnbSJ+RVjAHysx1cn5wr2i8qZEopG9XHE=;
 b=mU3sG7q8IfovQqtktlmekMsk5Ss6rPn860ZnhIMlOkwZ357XPTtyuGmouxs82Jr/5V
 2HZEayAjtnvFL42N0Z/OJsZhpCJM6MTIpGNOrYwHnlqPTGis7Wan00EsgaVykMVTa5O7
 pikAJlSK3uTyOE7VF3XGIkgwD03M4bZ/brcPkci/kb1UBBs99j0JDo+c8zgZSvAVAVAs
 UnkTHfBfeqnAbDG1JvFkmxBFWBeqNc/yyo0TVwUWNFiIe70jf1HXuwR5cxcm4oWrgvkh
 exy9mcKnwcKpx8VozoMB2LrZiHEs5sWhNycsb1E5gVpFsq1YH8wAYpfL27EU1FIQsokq
 PWpQ==
X-Gm-Message-State: AOJu0YxQTL0BKqmwmfHA/SE+/tTxE9dSOCzMUxx9URiWHarbhyvt9bNb
 Zh+HHwXx1+czSrKTGCjXYtRGLefBEQkFMBvfipjtMILq41WZ/ij2Cl+8UTSqjHYwKaLDs5+4uyY
 Ewg==
X-Google-Smtp-Source: AGHT+IHeJwHRztHUcF+Awpm/rCSttbBvVFftOMXmOcPI7MCc5bGgn+i0KnNkfGYkZa/nOwq6de3woA==
X-Received: by 2002:a17:903:2442:b0:20c:5cdd:a9e with SMTP id
 d9443c01a7336-210c6c02482mr347699605ad.28.1730593802815; 
 Sat, 02 Nov 2024 17:30:02 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056edc65sm39133335ad.10.2024.11.02.17.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:30:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v4 3/9] board_f: Rename reserve_stack_aligned()
Date: Sat,  2 Nov 2024 18:28:20 -0600
Message-ID: <20241103002828.624931-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103002828.624931-1-sjg@chromium.org>
References: <20241103002828.624931-1-sjg@chromium.org>
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

Most of the calls to this function have nothing to do with the stack.
Rename the function to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 677e37d93c0..3532ffec46f 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -492,7 +492,7 @@ static int reserve_uboot(void)
  * ref = x86_64 ABI: https://reviews.llvm.org/D30049: 16 bytes
  *     = ARMv8 Instruction Set Overview: quad word, 16 bytes
  */
-static unsigned long reserve_stack_aligned(size_t size)
+static unsigned long reserve_aligned(size_t size)
 {
 	return ALIGN_DOWN(gd->start_addr_sp - size, 16);
 }
@@ -522,7 +522,7 @@ static int reserve_noncached(void)
 /* reserve memory for malloc() area */
 static int reserve_malloc(void)
 {
-	gd->start_addr_sp = reserve_stack_aligned(TOTAL_MALLOC_LEN);
+	gd->start_addr_sp = reserve_aligned(TOTAL_MALLOC_LEN);
 	debug("Reserving %dk for malloc() at: %08lx\n",
 	      TOTAL_MALLOC_LEN >> 10, gd->start_addr_sp);
 #ifdef CONFIG_SYS_NONCACHED_MEMORY
@@ -536,7 +536,7 @@ static int reserve_malloc(void)
 static int reserve_board(void)
 {
 	if (!gd->bd) {
-		gd->start_addr_sp = reserve_stack_aligned(sizeof(struct bd_info));
+		gd->start_addr_sp = reserve_aligned(sizeof(struct bd_info));
 		gd->bd = (struct bd_info *)map_sysmem(gd->start_addr_sp,
 						      sizeof(struct bd_info));
 		memset(gd->bd, '\0', sizeof(struct bd_info));
@@ -548,7 +548,7 @@ static int reserve_board(void)
 
 static int reserve_global_data(void)
 {
-	gd->start_addr_sp = reserve_stack_aligned(sizeof(gd_t));
+	gd->start_addr_sp = reserve_aligned(sizeof(gd_t));
 	gd->new_gd = (gd_t *)map_sysmem(gd->start_addr_sp, sizeof(gd_t));
 	debug("Reserving %zu Bytes for Global Data at: %08lx\n",
 	      sizeof(gd_t), gd->start_addr_sp);
@@ -567,7 +567,7 @@ static int reserve_fdt(void)
 			gd->boardf->fdt_size =
 				ALIGN(fdt_totalsize(gd->fdt_blob), 32);
 
-			gd->start_addr_sp = reserve_stack_aligned(
+			gd->start_addr_sp = reserve_aligned(
 				gd->boardf->fdt_size);
 			gd->boardf->new_fdt = map_sysmem(gd->start_addr_sp,
 							 gd->boardf->fdt_size);
@@ -584,7 +584,7 @@ static int reserve_bootstage(void)
 #ifdef CONFIG_BOOTSTAGE
 	int size = bootstage_get_size(true);
 
-	gd->start_addr_sp = reserve_stack_aligned(size);
+	gd->start_addr_sp = reserve_aligned(size);
 	gd->boardf->new_bootstage = map_sysmem(gd->start_addr_sp, size);
 	debug("Reserving %#x Bytes for bootstage at: %08lx\n", size,
 	      gd->start_addr_sp);
@@ -601,7 +601,7 @@ __weak int arch_reserve_stacks(void)
 static int reserve_stacks(void)
 {
 	/* make stack pointer 16-byte aligned */
-	gd->start_addr_sp = reserve_stack_aligned(0);
+	gd->start_addr_sp = reserve_aligned(0);
 
 	/*
 	 * let the architecture-specific code tailor gd->start_addr_sp and
-- 
2.43.0

