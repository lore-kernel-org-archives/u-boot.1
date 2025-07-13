Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD5AC83F17
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 05:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC6582F03;
	Mon, 14 Jul 2025 07:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VANhoe3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD0C7805D7; Sun, 13 Jul 2025 18:08:40 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF4B680194
 for <u-boot@lists.denx.de>; Sun, 13 Jul 2025 18:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lordrasmus@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a16e5so6901154a12.0
 for <u-boot@lists.denx.de>; Sun, 13 Jul 2025 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752422915; x=1753027715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ixebY2TAqzt4788nqguFNYuFB2DFcAFRpVA2Df3nbPE=;
 b=VANhoe3bb8e/V/W16iTzMw8GeA3ZMU5tqGdsi4M5EdU8cfavoeYStm4D+V074VJMBc
 qjmUg2I9B7kl/MsQNuZAugc2ebLqz69q8UFi9cZceF07g8ETBpRIJouF9LDZa0V1/sDw
 z3A5NkbtpZ7PIm3JQ3JnzK5oFl/ogS5cHN7vUFg7ZIElmCvZ584/p9HHWss195mQtyQs
 CHFjCsBmRytG9avV1IPD2DKxvmu9m9w3OETp27LAZOdR9vvqGYE++xOFoqb5IzXhXRjU
 TIlVtCWXVPrDimMXo8ucs6z5z64Mn4jEllqG5m58ht+okpGdD70USaBhRca7sZAKwTrJ
 Rmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752422915; x=1753027715;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ixebY2TAqzt4788nqguFNYuFB2DFcAFRpVA2Df3nbPE=;
 b=v0vtxJz5vH04tKQbYk8EYpGke6r97o80GFHVb3AsaYfYojZL4RtILY/d9NTp6SmQGw
 qWVXTTja87sg5CvxGYymPDqgMbVZLCYrKkPFCSlZKabtWB4C86JTM9TvBFueomazipgd
 MjtI+y99kQKKgKv/K5QBIcf5YL+XqM5vIOcdZHVGAurKnzutl3SbyWAbolRKi7tn0flz
 +wmh7VTooogoERO4+bPRTETrQOM2d9bduKukrSuCVpl4GDkvEdD5M/EtSHVWM8X1/4s8
 trDawEi1A5Fq9Kzuqq19sE+0g7fAdi5Y7AJwpuehBVsvvRAiIQCixzVhSYBFjSOo/bCH
 sj7g==
X-Gm-Message-State: AOJu0YzRtrhggqP1EE1pebHK5heDwnhXBasLeyOslE6HH+D/sa+uk/4n
 77aZcuGrcW/ajS5SuWQhvXlOX+FJeWct2iWxysgIbXSdKnYw2izU3D5fAd77RBnM
X-Gm-Gg: ASbGncuu16aqZn5y4GSTSjD7xlCudrDjqLM+uBe7l8XpTdSzMQDoCRXakx4XsrXFCO7
 cXp4FtChlCko41LMJj59tORITaW6pt9aNLhoGk1el9a6G9QcdYBGxfUEXBD/XwRDMXNfDlvQW0Z
 RBoilc91uGF/tRJHHUr5ri9XHiiHb86z8tNMFUCiqHvEmwBYrUlvIG0Wj+m2hSl/Ge8M0QuQN3+
 02OacdzAaQzwj3t7v1q67g7RY1UUEoIKfMEpM76uFLxqBk/01hdaatpMQKpaj9nTCl8nIthucGu
 jv0aue8P+jRORERrPPjBRg6SbvUKY/KP4EPxWlH8kxmUQDToDbotHA/pQzpWfYpnvaj2jgi2Fqk
 jnodAzhpJQw8YBxoRSQj0OXz1oiXmpF8hwzQVzJRA3Ru95btD
X-Google-Smtp-Source: AGHT+IEeEH/JR/EYtpMwcRezvx7WbdLInVTuqGoOIDu7ZUn06w1Ny0kQ4idEaYNeYyBfNOJSPEEvAA==
X-Received: by 2002:a05:6402:5255:b0:60e:23d:43b1 with SMTP id
 4fb4d7f45d1cf-611e848f84dmr8962811a12.16.1752422914542; 
 Sun, 13 Jul 2025 09:08:34 -0700 (PDT)
Received: from archlinux (p54b96342.dip0.t-ipconnect.de. [84.185.99.66])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-611c9523a75sm4998030a12.25.2025.07.13.09.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Jul 2025 09:08:34 -0700 (PDT)
From: Ramin Moussavi <lordrasmus@gmail.com>
To: u-boot@lists.denx.de
Cc: Ramin Moussavi <lordrasmus@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>
Subject: [PATCH] arm: atmel_qspi: fix race condition in transfer completion
 check
Date: Sun, 13 Jul 2025 18:08:26 +0200
Message-ID: <20250713160826.108821-1-lordrasmus@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Jul 2025 07:14:33 +0200
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

In atmel_qspi_transfer(), the status register is polled with:

  imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
  return readl_poll_timeout(aq->regs + QSPI_SR, sr,
                            (sr & imr) == imr,
                            ATMEL_QSPI_TIMEOUT);

However, this is racy: QSPI_SR_INSTRE can be set before QSPI_SR_CSR,
and will then be cleared by the read. If that happens, the condition
"(sr & imr) == imr" can never be true, and the function times out.

This race condition is avoided in at91bootstrap by accumulating the
status bits across reads until both bits have been observed:

  /* Poll INSTruction End and Chip Select Rise flags. */
  imr = (QSPI_SR_INSTRE | QSPI_SR_CSR);
  sr = 0;
  do {
    udelay(1);
    sr |= qspi_readl(qspi, QSPI_SR) & imr;
  } while ((--timeout) && (sr != imr));

Update U-Boot's atmel_qspi_transfer() to use the same pattern,
ensuring that both flags are observed even if they are not set
simultaneously.

Signed-off-by: Ramin Seyed-Mousavi <lordrasmus@gmail.com>
---
 drivers/spi/atmel-quadspi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 8aa7a83aef4..fba32876f8f 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -616,6 +616,8 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
 			       const struct spi_mem_op *op, u32 offset)
 {
 	u32 sr, imr;
+	uint32_t val = 0;
+	unsigned long timeout;
 
 	/* Skip to the final steps if there is no data */
 	if (op->data.nbytes) {
@@ -636,8 +638,19 @@ static int atmel_qspi_transfer(struct atmel_qspi *aq,
 
 	/* Poll INSTruction End and Chip Select Rise flags. */
 	imr = QSPI_SR_INSTRE | QSPI_SR_CSR;
-	return readl_poll_timeout(aq->regs + QSPI_SR, sr, (sr & imr) == imr,
-				  ATMEL_QSPI_TIMEOUT);
+
+	timeout = timer_get_us() + ATMEL_QSPI_TIMEOUT;
+	while(1){
+		val |= readl( aq->regs + QSPI_SR ) & imr;
+		if( ( val & imr ) == imr ){
+			return 0;
+		}
+
+		if ( time_after(timer_get_us(), timeout)) {
+			return -ETIMEDOUT;
+		}
+	}
+
 }
 
 static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
-- 
2.50.1

