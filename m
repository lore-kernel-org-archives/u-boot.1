Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6723FCA0EC8
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 00:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48541889C9;
	Fri, 30 Aug 2024 02:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dzCi+4N1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DBB889B4; Fri, 30 Aug 2024 02:06:03 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7C088D11
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7c1324be8easo1579758a12.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724976358; x=1725581158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zVujsTQzFBAInlLDyg1E/CKiCjquGFZzmPRIfs0R0oc=;
 b=dzCi+4N1TAEQuMxBpOEKpC1K+LgwjuE2S6ONuXPZC0+aeY7OEQYGT+/4wqcKmFULZE
 82A3FX/0iVYVzgGwUawnC4ID8i/6Zdpolc+pnToThbWzGifkOMpXUjiTyDEpfDsqGh/w
 TAn4bPBlc0KNguDBL4p5Z63T5nOMiuJ/LyJpegJ3EhHwe3QoGSPEdjP6PuSNG+u7jQ7N
 Bk9/k/+keDVkqi/w+HTpFHbl6GMoJ93/537bev3x+t7BJnRQGI/712kgjtKIUHT2EGN5
 N3+QXOKH0O3au/F7l8hT46CAHlCFdigkiYzLMmatqD2wbNtLk9jN2nTeq1mCmuvvRZ/0
 vSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724976358; x=1725581158;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zVujsTQzFBAInlLDyg1E/CKiCjquGFZzmPRIfs0R0oc=;
 b=O1pTTAF+DqcOi+vMBbyPn2uEQi2cEzkBw/emS7tKccq7LLFyuES6e3pGR7JQwcup1k
 Meev44K7bhq3pP2TGGK7QKaeNhUd7bKBlBK6R/qwjIEw3fMO+RK9isOeoqkcYKC+FAbh
 avO0RSN6+bH1jN/cWneJhlnjxwUrEGjEMcOsFomzah9/PhcfyVC4lWFjuL77jIYUibt4
 ZskYbgX3vMv5YNgKdj0m0NG4LgyOTa3Ka6bWNqtm+Kq5GBBxqwrLVDQbteB4tFbaRIsZ
 fVC9klQBNCiVwPPzqOtjS2slQofN9fRCMnlHx2CWafXDsAdTqQzHdRfb71KVpvm1qxaP
 U+Yw==
X-Gm-Message-State: AOJu0YzhtEeBaViZGl1N8bJPaP9NOSUKEHrBjXhH1NLQ1d2dntadrfar
 PG62jCPx+Czcg9wDmL8mFV/sZvyVmjuzJf40uptUnQf1Xk0khFa2iywotw==
X-Google-Smtp-Source: AGHT+IHEqlw5NV7PY+8qx/pOTL/2/C73hB2s63SCv3iiNwIKQPU5gcMA3Du1I1otjORjV7L9g2d/Kg==
X-Received: by 2002:a17:90a:a88e:b0:2c9:36bf:ba6f with SMTP id
 98e67ed59e1d1-2d86ad2c9d0mr840105a91.3.1724976357726; 
 Thu, 29 Aug 2024 17:05:57 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d844617379sm4833406a91.29.2024.08.29.17.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 17:05:57 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tejas.arvind.bhumkar@amd.com, prasad.kummari@amd.com,
 tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon 2Gb parts
Date: Fri, 30 Aug 2024 09:05:37 +0900
Message-Id: <20240830000537.18862-1-Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

S25HS02GT, S25HL02GT, and S28HS02GT are dual-die package parts and do
not support chip erase.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 88709a52b3..457965dad1 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -369,7 +369,7 @@ const struct flash_info spi_nor_ids[] = {
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
 	{ INFO6("s25hl02gt",  0x342a1c, 0x0f0090, 256 * 1024, 1024,
-		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 	{ INFO6("s25hs512t",  0x342b1a, 0x0f0390, 256 * 1024, 256,
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
@@ -377,7 +377,7 @@ const struct flash_info spi_nor_ids[] = {
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
 	{ INFO6("s25hs02gt",  0x342b1c, 0x0f0090, 256 * 1024, 1024,
-		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 	{ INFO6("s25fs256t",  0x342b19, 0x0f0890, 128 * 1024, 256,
 		SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #ifdef CONFIG_SPI_FLASH_S28HX_T
@@ -385,7 +385,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
-	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
 #endif
 #endif
 #ifdef CONFIG_SPI_FLASH_SST		/* SST */
-- 
2.34.1

