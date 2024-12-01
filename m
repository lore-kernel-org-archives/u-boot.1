Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27CCD49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD77896F4;
	Sun,  1 Dec 2024 16:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iEPpafX+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 972C588D51; Sun,  1 Dec 2024 16:28:32 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B9089287
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a7dcbdf1cdso17220415ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066908; x=1733671708; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cxs9CvHA67qnbSJ+RVjAHysx1cn5wr2i8qZEopG9XHE=;
 b=iEPpafX+lhMIbWla83tRU6Jz9qvTkDiTK5w1fMqJ4oz7O0XI/T/vr0il+yUktbEdEb
 x1fUmVrqVsxwP6wrCg4HLUvFI2FgZW67sJEks2iwpzhnKmSxLgvSmHSBW7RPY8fXJ+H5
 8otPOChrd7cGAsZceME0gswhi4L3r7Q4QErJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066908; x=1733671708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cxs9CvHA67qnbSJ+RVjAHysx1cn5wr2i8qZEopG9XHE=;
 b=wBLfzlhx0owj0XIg+2J6zAWbhgZ9uhFJGkoDX5G5Coy8Sga9GiCfSyITqRBlaH1EB3
 JSdQ+wXbIupK8QQJI3qqpaKsLtLBfWKRTx1JxNa6En8DFaIHRUywDW20St1WSU3+aQPL
 gqdsOnu0nA3N33zCB8IlqYrpW/bb1ou3zvTt54Rl/t4o9kUMTc1wa69NaLGvzByAtkZ9
 cJYWpwDKG9Bdn+GnCqWY+xUKjaPBKE/Ywn4mqo1PReCJJraS24EllQ13IEVMx+myYXBD
 PJiZO5Hvv95xNjpvWU1NEgD/j60+1k+HpQG7/RPwSzfrAwU/731X7FkUYdQdt/KBdkkG
 4g6A==
X-Gm-Message-State: AOJu0Yy18yjvYPtnz1TIN4hperfwIWQYiOfCujpyzmHLzRX6+GNF4v7X
 MnonkpAQBcE6Yl0ZaQ/mPGFTOIpmglLLPS85EPuhPDNLt0fbzMFn7YtInbAKD5U2jQuHJOSIsxs
 =
X-Gm-Gg: ASbGncveWbiMEvpa0pPegaZcyRMSYxARJx/lkOj4ODAzu4D0fyi9Z7ai6zPMBs8IWyW
 x3Bkzp0l5Fmk4DX0V85sPd+9iLXAN6fsNZhs1oT1YWPmUxqN18yn8iNIX1lDggjb6cqmMGa22p3
 3skDRUUmsxMnvYLyTHZCTBoUzj2Mnp7V81JYANsTCCzGNN0R/82VH7NTwSudMMq/wA9xGqOEf58
 KoGJtNzW36rejiXK7UTGvjOdC5Axzm1hZSR4rWxPyAm
X-Google-Smtp-Source: AGHT+IFzTMGzR9nucDipcQaSOm2QVlHz8P1RrQOQ/pSX/gBg9XMfZEuxn8I8s239IVzOePhrzeAl/A==
X-Received: by 2002:a05:6e02:2164:b0:3a7:6e72:fbb3 with SMTP id
 e9e14a558f8ab-3a7c5525433mr174592805ab.4.1733066907917; 
 Sun, 01 Dec 2024 07:28:27 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v5 4/9] board_f: Rename reserve_stack_aligned()
Date: Sun,  1 Dec 2024 08:28:06 -0700
Message-ID: <20241201152815.1668093-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
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

