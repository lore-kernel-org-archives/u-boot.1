Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2669C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 10:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 056BE803DF;
	Thu,  5 Jun 2025 12:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oa10ppjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 020168091A; Thu,  5 Jun 2025 12:52:55 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01BE80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 12:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5308b451df0so292070e0c.2
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749120771; x=1749725571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TWyJGmfDeEWDNYkYFttOSYtg5wPExn/uinGZCyj1QAY=;
 b=Oa10ppjQMEPlA1ghZ4loNe0OH7NvvJLxDDjopfBGvhIMOfVE62Hm8iTLV93KeGit5X
 OKsGHZ+rowVg0Vte1Wp8AvLZVwYOyzm9rpyt8kkEqLWOMxHYnCoD8K+oouqtb66+XQ21
 /zXIv85QnRBXcx1kne/SyNMs87htd/3QDN94YWIDtoOBs0Hb77QDvv2wyXnYzvZIdJV7
 bQ5EgSJ0+MHJ34XZ32ryJAFAx4IPhHswu91U0m2O2ZOWlv8Ca86aOBiZ76XY657Vocee
 pumf/KBtzx6BWG3Qe32Osv0yRHnI6gZjcQ1I6TSC32GZsz9DfwfG3Wl8Jpk9yfxKnQWb
 uPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749120771; x=1749725571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TWyJGmfDeEWDNYkYFttOSYtg5wPExn/uinGZCyj1QAY=;
 b=FD1EoyAQ+tOiOWQ+4e4jS7lblP5NTmgQngzP5tWXQHM7fNTCBb5ikg5v9sLyq2pFIM
 900zNu5Priute9MB7zppi/hsb4nVKGFszATfvSdQwq5p7QJdd4VAiz/d7ajwyFTcy6g1
 GMVKKngxsx3pW22fsZ4+p/0wYo/Uof7aWGgW0gDiElwYFvp2yVUl45SG3gcVtMk92a+g
 M5BiDL6gAs+YszgJgckFdsT8P55yQOU8l5WkQf0apSg756vEKfkzCJVd3CUvnZZGVb95
 iMT1JbiCfF1ZcygMkGkTGigLfH3nSgY55unGA1qa9KtY5ucZ5DtRE2u8yE08G1wN6rPY
 Kgcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0GxRmfXkZrUhS5B7iWLy4ovuQBlKf46+qNSkLG4aZhoAHX5nJTescGqu6aUe1skyAzpCD3U0=@lists.denx.de
X-Gm-Message-State: AOJu0Yza0Hop9xcLx5AgrW7ky1SHVSkWdUkG1HqUehc1QIUpVH8hyUyU
 032hxTKAiBf2sEUflEFGGuUJD8C+y7lbkP4f5renkYZX+4MI+pobqKKs
X-Gm-Gg: ASbGncsrg8B+3eAQOLI2s/EMsftt2D2yCVxguqEJHBCPKPdpDzvmi+erheH3gqFewDd
 +Mn3kLRXRhW78DTw2cVSUr8J4XulIJ3fe2dJLkZ20Dv7Q6O2SdJWKL0xlznAgQMaK4fbyHRbVpj
 XB37+gsVu2/wVulSb4QJAJjmAqv2GkRIgTcyZ5WXNP4Ii2hSL7bCkBGMYyWEuBlN49L+D06ADQf
 cLXHBPjPLobt/hJ/BxJp1FVPdEOQdrouXUEfX07xVnKUm2qARa5pt7g7jqYz4Woby+vMK5ZWaHf
 o5/Ym6CjodHiHtfaBO1209h7UFIA9HCoWGcA0FLXKd62Prl8bHPHE8/OeF7Cb6vgkQ==
X-Google-Smtp-Source: AGHT+IFqPekcfnYBssQT9IjvprZeIXPK1ItOyKacfnLHUbvmOo/1vvWOETSiXY7a6Fio39Jc/Z0pgg==
X-Received: by 2002:a05:6122:218d:b0:530:6e61:d1e1 with SMTP id
 71dfb90a1353d-530c72fadb1mr5544741e0c.4.1749120771501; 
 Thu, 05 Jun 2025 03:52:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:baec:483f:66c6:eee8])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53074aaf305sm12229859e0c.4.2025.06.05.03.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 03:52:51 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: gaurav.jain@nxp.com
Cc: trini@konsulko.com, olaf.baehring@draeger.com, peng.fan@nxp.com,
 tharvey@gateworks.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Revert "caam: Fix CAAM error on startup"
Date: Thu,  5 Jun 2025 07:52:44 -0300
Message-Id: <20250605105244.619858-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This reverts commit 159b6f0e119962ce5da645f548cefe9196c8778e.

Since commit 159b6f0e1199 ("caam: Fix CAAM error on startup") the following
regression was reported by Tim Harvey:

"I've found that this patch causes a regression on an imx8mm board
(imx8mm_venice_defconfig) where the first call to caam_rng_read fails
here in jr_dequeue but if you call it again it works. With some
debugging added:
SEC0:  RNG instantiated
...
Hit any key to stop autoboot:  0
u-boot=> rng list
RNG #0 - caam-rng
u-boot=> rng 0 10
caam_rng_read caam-rng len=16
run_descriptor_jr_idx idx=0
Error in SEC deq: -1
caam_rng_read_one run_descriptor_jr failed: -1
caam_rng_read caam-rng caam_rng_read_one failed: -5
Reading RNG failed
u-boot=> rng 0 10
caam_rng_read caam-rng len=16
run_descriptor_jr_idx idx=0
00000000: ad 2e ad c0 2a 12 27 c4 65 82 66 19 be ef f6 07  ....*.'.e.f.....

If I revert your patch caam_rng_read works initially and on subsequent
calls."

" I ran into this when I was testing
lwIP HTTPS as it causes anything that uses dm_rng to fail the first
time (such as HTTPS)."

Revert it for now to avoid the regression.

Reported-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/crypto/fsl/jr.c | 25 +++++++++++--------------
 drivers/crypto/fsl/jr.h |  4 ++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 1d95d2bff278..8f7a821ebf3d 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -217,6 +217,13 @@ static int jr_enqueue(uint32_t *desc_addr,
 
 	jr->head = (head + 1) & (jr->size - 1);
 
+	/* Invalidate output ring */
+	start = (unsigned long)jr->output_ring &
+					~(ARCH_DMA_MINALIGN - 1);
+	end = ALIGN((unsigned long)jr->output_ring + jr->op_size,
+		    ARCH_DMA_MINALIGN);
+	invalidate_dcache_range(start, end);
+
 	sec_out32(&regs->irja, 1);
 
 	return 0;
@@ -236,7 +243,6 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 #else
 	uint32_t *addr;
 #endif
-	unsigned long start, end;
 
 	while (sec_in32(&regs->orsf) && CIRC_CNT(jr->head, jr->tail,
 						 jr->size)) {
@@ -244,11 +250,6 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 		found = 0;
 
 		caam_dma_addr_t op_desc;
-
-		/* Invalidate output ring */
-		start = (unsigned long)jr->output_ring & ~(ARCH_DMA_MINALIGN - 1);
-		end = ALIGN((unsigned long)jr->output_ring + jr->op_size, ARCH_DMA_MINALIGN);
-		invalidate_dcache_range(start, end);
 	#ifdef CONFIG_CAAM_64BIT
 		/* Read the 64 bit Descriptor address from Output Ring.
 		 * The 32 bit hign and low part of the address will
@@ -282,13 +283,8 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 		}
 
 		/* Error condition if match not found */
-		if (!found) {
-			int slots_full = sec_in32(&regs->orsf);
-
-			jr->tail = (jr->tail + slots_full) & (jr->size - 1);
-			sec_out32(&regs->orjr, slots_full);
+		if (!found)
 			return -1;
-		}
 
 		jr->info[idx].op_done = 1;
 		callback = (void *)jr->info[idx].callback;
@@ -300,14 +296,14 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 		 */
 		if (idx == tail)
 			do {
-				jr->info[tail].op_done = 0;
 				tail = (tail + 1) & (jr->size - 1);
 			} while (jr->info[tail].op_done);
 
 		jr->tail = tail;
-
+		jr->read_idx = (jr->read_idx + 1) & (jr->size - 1);
 
 		sec_out32(&regs->orjr, 1);
+		jr->info[idx].op_done = 0;
 
 		callback(status, arg);
 	}
@@ -382,6 +378,7 @@ static int jr_sw_cleanup(uint8_t sec_idx, struct caam_regs *caam)
 
 	jr->head = 0;
 	jr->tail = 0;
+	jr->read_idx = 0;
 	jr->write_idx = 0;
 	memset(jr->info, 0, sizeof(jr->info));
 	memset(jr->input_ring, 0, jr->size * sizeof(caam_dma_addr_t));
diff --git a/drivers/crypto/fsl/jr.h b/drivers/crypto/fsl/jr.h
index 8d5ca03e5015..b136cd8d05a9 100644
--- a/drivers/crypto/fsl/jr.h
+++ b/drivers/crypto/fsl/jr.h
@@ -83,6 +83,10 @@ struct jobring {
 	 * in-order job completion
 	 */
 	int tail;
+	/* Read index of the output ring. It may not match with tail in case
+	 * of out of order completetion
+	 */
+	int read_idx;
 	/* Write index to input ring. Would be always equal to head */
 	int write_idx;
 	/* Size of the rings. */
-- 
2.34.1

