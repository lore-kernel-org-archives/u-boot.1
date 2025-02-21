Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74821C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 07:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D79A78056B;
	Fri, 21 Feb 2025 08:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T8DSoWVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFA48801DE; Fri, 21 Feb 2025 08:05:29 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54ACE806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=blemouzy.ml@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so1607962f8f.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 23:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740121526; x=1740726326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wL3CH8Q2UjC03cub1oMD8tC7jrFAtO3rOo/AUFCR5VY=;
 b=T8DSoWVDPl3Prum+catW9j6SHUR0dSOWHMmcxX3zh0WpT/sb0bwwTB372mltCf5Qce
 inmauVp+TVgHuB6pO4X2EkU3byQwXbJtFaszfhcCMQnyPMbqxPkjEzIjANl7f0ATYT0t
 v1dXPdhoKuLJAF6xHqTBSecM6PsT9pRYpax6IiJN02qR7Pv5W01Hpyf1y6pV+JIy437E
 nfck3bApBKLraJQdJiwe5ZhG4OLSTJmPpTI0IizCr0oBglI/oFOumYqjKrdANh5bG1wA
 Dm082vsQjqv9BVAAVwZ9OKef8d+oQGQ+ElWiMivytUNfCUED7Iefe4gcJefPAuVk1E8x
 sqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740121526; x=1740726326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wL3CH8Q2UjC03cub1oMD8tC7jrFAtO3rOo/AUFCR5VY=;
 b=mrXQ+BNShNrjhzsQQ+LcQmqfY3GeX1eRFoarrh/W+MnSYrGyFm4Lfsd0+A2bTyJzJk
 6VNRxh0oZ95eBxq5TvFQPxZOXBUvMafQhoiQ9kbEZD8mBjFSlcxkAnPZlbVVdxBPLLY6
 euaiMU1SEkKf6G0uemn8PtNbrXS/qCGLjH/1c6f+Vqlbw7I68+r4WuO6vn0gLrjNWoDu
 xRmL0D8mu9V38gEBHSol0daq7rkb1IgOhSoGz6AmKM2rcVx2ng3ipTAHunlGrdYN3Mpd
 Z/R5S3tdMUdzy/gWdcH+vMhxDkjfQEeTsjyyzeMQslDanDTI1aZ8u0lRHZ2O0b4ve2bk
 GCug==
X-Gm-Message-State: AOJu0YyTzhk/eO3ZL3xI5Ns9gKLhDMSQjphaafN2/OtmALJHvnX3GVbe
 VJ541RXKCO70ONkILqxCS+PW5lAlWwoRQ+JH/2Ik4Typn5UBtytfB6GEFw==
X-Gm-Gg: ASbGnctWRXLDDELjm/juy6d2pXbVhOxa7gh4JFLG8m2CvLncX4QGS/x3KqZYftDL+kN
 1U5n/DZniRerzcRaK51gRwBBAs5vxMSsDy3Pk+libDdiFa9flS6wVaKp8m+UsQkKOCSz9w8k5Qg
 SKddff1G5HkDzmGqsyZYLaQariSQyXFcctXU2dousXOgLYcsRqr+2L9IzPrkmQ0w2WrCnIqYybJ
 GvQg1CKfBIpvc00vxuOSqoVm83Kcn+8jGcdHS3yd6IDdvt6t7Q2D9ElvPMlOsI0kSElNnVc/ET5
 HmkrgFT1DSO9/9s7nRp7PYgstqq1DJ2X6cDbTSHCIg==
X-Google-Smtp-Source: AGHT+IG772ZDMENTvcj0cCcQjbR45r8+8+JimZ8Et9ONGaQ/jlCN06eHtZIRvFiLU1wU8Tb9eEQv8Q==
X-Received: by 2002:a5d:6d07:0:b0:38d:dc57:855d with SMTP id
 ffacd0b85a97d-38f6f0b0129mr1989923f8f.35.1740121525537; 
 Thu, 20 Feb 2025 23:05:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:10a:44e0:c50e:bba4:9d0a:48d5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f64b0f565sm3780254f8f.51.2025.02.20.23.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 23:05:24 -0800 (PST)
From: blemouzy.ml@gmail.com
X-Google-Original-From: blemouzy@centralp.fr
To: u-boot@lists.denx.de
Cc: gaurav.jain@nxp.com, trini@konsulko.com,
 Benjamin Lemouzy <blemouzy@centralp.fr>
Subject: [PATCH] crypto: fsl_hash: fix flush dcache alignment in caam_hash()
Date: Fri, 21 Feb 2025 08:05:01 +0100
Message-ID: <20250221070501.19472-1-blemouzy@centralp.fr>
X-Mailer: git-send-email 2.43.0
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

From: Benjamin Lemouzy <blemouzy@centralp.fr>

Loading a FIT kernel image with hash hardware acceleration enabled
(CONFIG_SHA_HW_ACCEL=y) displays the following CACHE warning:

    [...]
    Trying 'kernel-1' kernel subimage
    [...]
    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
range [16000128, 1673fae8]
    [...]
    Trying 'ramdisk-1' ramdisk subimage
    [...]
    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
range [1676d6d4, 1737a5d4]
    [...]
    Trying 'fdt-imx6q-xxx.dtb' fdt subimage
    [...]
    Verifying Hash Integrity ... sha256CACHE: Misaligned operation at
range [1673fbdc, 1674b0dc]
    [...]

This patch fixes it.

Tested on:
- i.MX 6 custom board
- LS1021A custom board

Signed-off-by: Benjamin Lemouzy <blemouzy@centralp.fr>
---
 drivers/crypto/fsl/fsl_hash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/fsl/fsl_hash.c b/drivers/crypto/fsl/fsl_hash.c
index 79b32e2627..b721c86609 100644
--- a/drivers/crypto/fsl/fsl_hash.c
+++ b/drivers/crypto/fsl/fsl_hash.c
@@ -183,6 +183,7 @@ int caam_hash(const unsigned char *pbuf, unsigned int buf_len,
 {
 	int ret = 0;
 	uint32_t *desc;
+	unsigned long pbuf_aligned;
 	unsigned int size;
 
 	desc = malloc_cache_aligned(sizeof(int) * MAX_CAAM_DESCSIZE);
@@ -191,8 +192,9 @@ int caam_hash(const unsigned char *pbuf, unsigned int buf_len,
 		return -ENOMEM;
 	}
 
-	size = ALIGN(buf_len, ARCH_DMA_MINALIGN);
-	flush_dcache_range((unsigned long)pbuf, (unsigned long)pbuf + size);
+	pbuf_aligned = ALIGN_DOWN((unsigned long)pbuf, ARCH_DMA_MINALIGN);
+	size = ALIGN(buf_len + ((unsigned long)pbuf - pbuf_aligned), ARCH_DMA_MINALIGN);
+	flush_dcache_range(pbuf_aligned, pbuf_aligned + size);
 
 	inline_cnstr_jobdesc_hash(desc, pbuf, buf_len, pout,
 				  driver_hash[algo].alg_type,
-- 
2.43.0

