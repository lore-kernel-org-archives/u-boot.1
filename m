Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC64C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 11:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B649A82E2D;
	Wed, 21 May 2025 13:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SiuFUP3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B59682E31; Wed, 21 May 2025 13:09:20 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB2182E0A
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 13:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4e15013bdc5so1580525137.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 04:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747825757; x=1748430557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uapniPJlouyC0yomaIpKmn5GB0bwl9Ggt7EFeeLYgRo=;
 b=SiuFUP3v6NP4gx9QBj6DoqWEx+vY4kZES0SK5lF+Bpo8kkru8lUneBP1V6MpE5y4ri
 WgKGZCXQuk4zm7w0b2C9PRsAeSB/06q6bx5C6RimNPqp7brYmoiWZncVStvgv426yiMc
 lgWpZza41w8RxT5TXTn5mCbKDdxW1rSGuVpTN2sXIjbhDmrd01hcegIFWP2aEMrKYLMp
 VPks6v8UfZvwYDCm1jxK9jWNYp2ZWJTHLC3ADEaXQyzxJNNtmR+wTVl0Xr6Q7y6L0eKk
 MJUV3Jra8hgCGif7MKmMG3GZnCYgJ+pAEwh5dOFjyDScdG0Iy/0bfcNmlcRfAVHWxfGP
 9maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747825757; x=1748430557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uapniPJlouyC0yomaIpKmn5GB0bwl9Ggt7EFeeLYgRo=;
 b=Zi6F13ermAJzp72T1IXP7+2uHFfpZC0vZuN07vhduLck5l6RvlUrssReNbHQDByyjN
 ny/nArmPk3YN1+pYtK8OIe8mQAhTZIVEsDejhdN9yQZRzKlH9qMIiF0iGYWve8ANZC+7
 4jJSkCJPB6pL2FTvS5ig2O77nVB47J2BpAGGNgFkQJrMaXseRn/s+K76FghnW3bAGmnr
 VmI6HKKo5Bxen2OWh/aRbp7da85M51c2lKr3cLkYjZydh86jIgVa+hi8E1rjNfu8X37u
 +Vc2f7QizM0HPO6T1WqNqU+YHHODzHNo5MUFxHs3H0O26JxM6ANYmp608xU1jNIe1Btj
 T5/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Qdoj/dIlz1mz+1XRAVWSXdGhZww+kbIOwCdXos9YxvaNhQsGG0Tl1TRYCrevGSkjwHNC/D0=@lists.denx.de
X-Gm-Message-State: AOJu0YzIC77yQ2iDoikERSOOZ0aXq1HzO7cdtY4T7IQHuHImgBKIIQ+L
 qeriGJ/tH3h7kS8wEfeqIH65rIqm9m54xiNSqsQ8So+06/Lrw0eqFT4T
X-Gm-Gg: ASbGncuHHI7XCBa1uthjs9gYbco4ymTWMJ3xJ2LUDV89KCo+8bvwh339s185NV+m7Be
 8ChUc8u9Hz+awO7AjsR0ZVpHMTZOl1v5EIxJuNY+5tJwqOjn5mCUM5dRzaWyXJ6Mn2q2U0p4OxP
 QB/8WEzlT9W4TvoJ2zGT9iuJ9v4ZOaT4CG5eRX8os9vsJsW7ptix9wQ/3HqTcZzmWThkil3nCBI
 xu6Nscg89VKQDsGjbsVLveMfep0eiC6D4TiB8n+ymQZ44qfub7YDtNPJa/guKmRVFTI/uedochk
 rB2H5oW4kpNPLBjwZEqvI4v/JKZEzMbM/es+bs/Pzvf9oSHJtjmxoey+kQb/S/tg7w==
X-Google-Smtp-Source: AGHT+IFVWDoPXo2sVqHreKhbxtlHaRcaAjD/hlwmjXgLaS16Vy8QMc+RIs1gueNIQi5YcKnZfNkavw==
X-Received: by 2002:a05:6102:3ca1:b0:4c1:91da:dac1 with SMTP id
 ada2fe7eead31-4dfa6b45cd7mr21133941137.6.1747825756562; 
 Wed, 21 May 2025 04:09:16 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fa17:cb12:a4b3:acd4])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87bec121baasm8890946241.8.2025.05.21.04.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 04:09:16 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: gaurav.jain@nxp.com
Cc: trini@konsulko.com, peng.fan@nxp.com, olaf.baehring@draeger.com,
 u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] caam: Fix CAAM error on startup
Date: Wed, 21 May 2025 08:09:08 -0300
Message-Id: <20250521110908.1665170-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Olaf Baehring <olaf.baehring@draeger.com>

In rare cases U-Boot returns an error message when intantiating the RNG
of the CAAM device:
“SEC0:  RNG4 SH0 instantiation failed with error 0xffffffff”
This  means, that even when the CAAM device reports a finished
descriptor, none is found in the output ring.
This might be caused by a missing cache invalidation before
reading the memory of the output ring
This patch moves the cache invalidation of the output ring from start of
the job to immediately after the notification from hardware where the
output ring will be read.

Signed-off-by: Olaf Baehring <olaf.baehring@draeger.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/crypto/fsl/jr.c | 25 ++++++++++++++-----------
 drivers/crypto/fsl/jr.h |  4 ----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 8f7a821ebf3d..1d95d2bff278 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -217,13 +217,6 @@ static int jr_enqueue(uint32_t *desc_addr,
 
 	jr->head = (head + 1) & (jr->size - 1);
 
-	/* Invalidate output ring */
-	start = (unsigned long)jr->output_ring &
-					~(ARCH_DMA_MINALIGN - 1);
-	end = ALIGN((unsigned long)jr->output_ring + jr->op_size,
-		    ARCH_DMA_MINALIGN);
-	invalidate_dcache_range(start, end);
-
 	sec_out32(&regs->irja, 1);
 
 	return 0;
@@ -243,6 +236,7 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 #else
 	uint32_t *addr;
 #endif
+	unsigned long start, end;
 
 	while (sec_in32(&regs->orsf) && CIRC_CNT(jr->head, jr->tail,
 						 jr->size)) {
@@ -250,6 +244,11 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 		found = 0;
 
 		caam_dma_addr_t op_desc;
+
+		/* Invalidate output ring */
+		start = (unsigned long)jr->output_ring & ~(ARCH_DMA_MINALIGN - 1);
+		end = ALIGN((unsigned long)jr->output_ring + jr->op_size, ARCH_DMA_MINALIGN);
+		invalidate_dcache_range(start, end);
 	#ifdef CONFIG_CAAM_64BIT
 		/* Read the 64 bit Descriptor address from Output Ring.
 		 * The 32 bit hign and low part of the address will
@@ -283,8 +282,13 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 		}
 
 		/* Error condition if match not found */
-		if (!found)
+		if (!found) {
+			int slots_full = sec_in32(&regs->orsf);
+
+			jr->tail = (jr->tail + slots_full) & (jr->size - 1);
+			sec_out32(&regs->orjr, slots_full);
 			return -1;
+		}
 
 		jr->info[idx].op_done = 1;
 		callback = (void *)jr->info[idx].callback;
@@ -296,14 +300,14 @@ static int jr_dequeue(int sec_idx, struct caam_regs *caam)
 		 */
 		if (idx == tail)
 			do {
+				jr->info[tail].op_done = 0;
 				tail = (tail + 1) & (jr->size - 1);
 			} while (jr->info[tail].op_done);
 
 		jr->tail = tail;
-		jr->read_idx = (jr->read_idx + 1) & (jr->size - 1);
+
 
 		sec_out32(&regs->orjr, 1);
-		jr->info[idx].op_done = 0;
 
 		callback(status, arg);
 	}
@@ -378,7 +382,6 @@ static int jr_sw_cleanup(uint8_t sec_idx, struct caam_regs *caam)
 
 	jr->head = 0;
 	jr->tail = 0;
-	jr->read_idx = 0;
 	jr->write_idx = 0;
 	memset(jr->info, 0, sizeof(jr->info));
 	memset(jr->input_ring, 0, jr->size * sizeof(caam_dma_addr_t));
diff --git a/drivers/crypto/fsl/jr.h b/drivers/crypto/fsl/jr.h
index b136cd8d05a9..8d5ca03e5015 100644
--- a/drivers/crypto/fsl/jr.h
+++ b/drivers/crypto/fsl/jr.h
@@ -83,10 +83,6 @@ struct jobring {
 	 * in-order job completion
 	 */
 	int tail;
-	/* Read index of the output ring. It may not match with tail in case
-	 * of out of order completetion
-	 */
-	int read_idx;
 	/* Write index to input ring. Would be always equal to head */
 	int write_idx;
 	/* Size of the rings. */
-- 
2.34.1

