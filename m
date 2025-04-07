Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EEAC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:00:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC4082FB4;
	Mon,  7 Apr 2025 19:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yJBScEeo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F18782F7E; Mon,  7 Apr 2025 19:00:02 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDAFE82F42
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 18:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso7227571a12.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045199; x=1744649999; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4m0fcKjAJeZV5eTwQT4Q8EPg1n94y3zGJ/x7bF0qLEY=;
 b=yJBScEeo1uvUvrRTx1LnryIyYgTT/jJ+wCvbXLC1ForZ9P9k00pB5Qd1CfvfdrYnaT
 6RnQNF7SEMUOz+jhkwaRUSbexKe2mqEcTey+dg61ALNHcubVa+qVb/wvtYN5XJY1mu7j
 gTaAd7rCSLella30pvVP9jh0vsHN0c9Sn1XG7/GxffD1ZHKAwZRGkb3zbMJNqi3KvzFC
 TglHCrLE6R1APAZtEdabTgBVyWtOpnHwZpkGfX1uTsP7XxOwvdLR6tJW+RdZqNm5xFXY
 K9GU65IYBVd8ZLAzfHA5G32e6edDNw286Fqx2pWwArvPQxNeZ4YcBML2Z5L4ihZtwqsJ
 8UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045199; x=1744649999;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4m0fcKjAJeZV5eTwQT4Q8EPg1n94y3zGJ/x7bF0qLEY=;
 b=SBKmKqj+I+4jlGLNn23zZtcbCSjnk3xXFAqBnQgLqhBlWA0qZpZ0BKN07o+0dO8Mp2
 RQ08Yxu9Ge54Lr01UDe8xPOPgddL9Zy7Bv5CN92GrlRyq0Xo9jwPgpsPpOSVanE+1qVL
 VVXTZiHB5wSWj0ZwaU3degWBexBSs3IDq1NgfT27NeKtfQDPpAw8z8Ps0FOe+/36DJn7
 b/17YbhauG122H8ERM5rbazmgnq3rkg6B8UILBipxlTU7deedYepKaEvbfRqfb5Q3/Vt
 RD6KtDP2tN+WAI8JvCLLj4kzGr8zifO/bXNz2op8HjKH/D63QGSc2EAy6M4seMjb2Csu
 A/cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXppBNsIw/Vmadn8qDqXvwhLbpuMD+9hUdpqJoHagp8/C7PE+AL8sAyWiNSNQz1rVsC2lcFlDk=@lists.denx.de
X-Gm-Message-State: AOJu0YziQrF9ZTaM2ZmMED10VMTtVpWBLoHOiR5isTbSMi6YmVNLPRWH
 S7mcEa631kkmAJ9LQ0Xi7Qd+gd8tzQ/HGZH62UiftvlTj7Ys74JxmqdRSINJkLmvTLaT1EnLC0l
 n
X-Gm-Gg: ASbGnctN1qBsosigaPan/XSHmHU2GrTmgqJ80pLYhxGV5PhSSXrHnESnIRp7tbLjkjD
 rvllrQoWKA1t0jnS61hdmjSv/j4A6N1Y/atI0P0EMPpLx9kg3NRTlaIhVUCLpZCTP3KJWHnL+PV
 LBWpdqOvLhOp74lg1aH9DsFwL3Z2SyOBg6dLOB2Zjli3XfasDoN3eAK3eD7KcttAnoqKU0bl+ka
 1ZbbEhlm6fxob3H02U6paJmHDR0VOgEal7NgNFDbqqW2iQuFja5sNFry89Ufpfkc17p/AYaVhIs
 N3tD5cgtJXA0LQdE0lkhGPvxPCb2cm3vv2Ju1PqIu3CY2nhVYcBw7KJ130zBSkvv930L
X-Google-Smtp-Source: AGHT+IH89AaIPJ16s9yE/MwrwvGb2pnrfNbe00utr0dCxYrIkWGdNYw770sLg7AqYdIpo+EYi7Yn8A==
X-Received: by 2002:a17:907:f1c1:b0:ac7:edfb:5210 with SMTP id
 a640c23a62f3a-ac7edfb536dmr778509066b.20.1744045199034; 
 Mon, 07 Apr 2025 09:59:59 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.09.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 09:59:58 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:25 +0200
Subject: [PATCH 04/13] board: dragonboard410c: Drop UNSTUFF_BITS() macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-4-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

This was originally taken from Linux, but at this point it's an inline
function upstream and no longer a macro. Given that we just want to extract
the serial number from the MMC CID, let's just inline that specifically.
This is also the style used in the MMC core code within U-Boot.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index c33529d31869b17c7a30ec83af1199d01db472f5..61d68e7f0c6bed16861e6ceaefd2c7dc94807d65 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -22,21 +22,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
-#define UNSTUFF_BITS(resp, start, size) \
-	({ \
-		const int __size = size; \
-		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
-		const int __off = 3 - ((start) / 32); \
-		const int __shft = (start) & 31; \
-		u32 __res; \
-					\
-		__res = resp[__off] >> __shft; \
-		if (__size + __shft > 32) \
-			__res |= resp[__off - 1] << ((32 - __shft) % 32); \
-		__res & __mask;	\
-	})
-
 static u32 msm_board_serial(void)
 {
 	struct mmc *mmc_dev;
@@ -48,7 +33,8 @@ static u32 msm_board_serial(void)
 	if (mmc_init(mmc_dev))
 		return 0;
 
-	return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
+	/* MMC serial number */
+	return mmc_dev->cid[2] << 16 | mmc_dev->cid[3] >> 16;
 }
 
 static void msm_generate_mac_addr(u8 *mac)

-- 
2.47.2

