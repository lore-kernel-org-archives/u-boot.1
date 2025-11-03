Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB645CCFA05
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 11:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B06836D1;
	Mon,  3 Nov 2025 12:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gQ+Vmvzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7AA83700; Mon,  3 Nov 2025 12:12:57 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57708331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 12:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7abe8442103so293560b3a.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 03:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762168373; x=1762773173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/grtle4d455Ev2dtwpKFCyXvdA5Bp6GUX3dNRu3FZtQ=;
 b=gQ+VmvzfgeT8Fxc8Y0KqT9/3OL/rBye7q5Hqoz2l+p7q2nXFge6uVX7zgU1yBnirwe
 hw/Uwr2vy1sfjhUrRTL7T8EymP4ugOLP95se7mgNaeLX8rWPpZY3ajlyblDb+hwbPp0n
 iYkKu71IN8Sjv8z9vjtMbFQzGhMV2DNpDqj4/txdfjlu5LSQxDf6PZAsLenmHr43wrE6
 m2S7Bhfro36LClL2R3IC0Eta1zcX/4WMLgkEgsN27OwWPAiZHcjzgndSCp72FGfrd9pq
 a7BnGrK+TBpndB0/UFf6wl7ezEBwpUmYSi9HaI79vpPv3ImUN862o6LzgoH6vJeQDJk2
 u3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762168373; x=1762773173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/grtle4d455Ev2dtwpKFCyXvdA5Bp6GUX3dNRu3FZtQ=;
 b=QjHWJeN+DhwqD93F4ztSc7WQuc9UXqoGPreyjcbSJZmbaw4gHnz2ZRXipHnlyPGiIx
 U9cxqxVKvN4AstmVKeO5bHkub1XHbL7VfzN6TBux4qw+EEr8NS6EnMy+d+jgF9q/jpIh
 chV1Tqk18nAao7lcwn6SzSJpc1R23vl48QJro7fqhTnFMP27F38ayqQk/1fmX3eh2fSR
 jpncvUhPNmIIUiPXvCaIFmDJZu9S58DKfsRAM1ODTOGXEVVLgAPeMdmYyEnOcoYmcRRM
 LhMGT02xEYQLEwPV8obsVcNctwzBNS/owYydaIpzDQupckwvIqR2mvoG09qK18NuRjbD
 aDbw==
X-Gm-Message-State: AOJu0YyaICKB0mvZ35IjDw5S4Lt2rXBF4CY4c2UcCrrK33+/3Pjf9tDM
 Kwp8cpGyKnCIs8w6Gd0ErkAiVfsCDTvA7MiKyY0y3mq0fB5XQkXI4R7a
X-Gm-Gg: ASbGncuWG/scNx3yv8FLl1oOs5WAjPFn3htz3ZIwakf/bcwhUpSHBGJOteIxJOeAtzz
 iTOVMHVVjCW/0LoNVrYIJxfRe1pNtLkEtHGAdzQLLVM2xqAQfoKrBgysTYFTJOwSLkQBOEuzXlR
 ZeuC1bvnsgvnD/AMZRfJhMMH+eDLOiWxSAs35Ver9EZmtNl9qm8iFzw8fOUEG33T98xJWr7obR8
 6KYKSUFl4rOlK5NRQdYfSGcLE9ldqmWsaSUm//AZGrxNlIirfFow+sFdKsR6TuQQXdlbpT+KIpG
 vQHwRkruFg3R3J6sxh+M1ymGgw5AF56OiZwY7jUjc8PmPo4kJA1n/vwWIhwPHJXt/WT3wTt5Nw7
 qJRFVM+MEz0y0ITbDOJfTJLL+HtKKm5wv8axSc7xh+zOUQEmg0pEbbJ7jBxI0DO7nvifgh5TBwf
 Rcmin28551yXFs9cKIew6LSTsmL/s7xKnwGLBW0qdy8dg48N3GY8jMfQrYWodXJbZT1NPvV3wpC
 7Fj1p8XGqFTYJpq2DQC8w==
X-Google-Smtp-Source: AGHT+IH/uRq0UyFp47CmZBattYyVpqGD2BapUNJKW+CbJUmbKSBLloWNB5taI1Pc3sqJZSuLY9tAOQ==
X-Received: by 2002:a05:6a20:734b:b0:262:c083:bb41 with SMTP id
 adf61e73a8af0-348c9f671b8mr14458784637.3.1762168373197; 
 Mon, 03 Nov 2025 03:12:53 -0800 (PST)
Received: from sun-virtual-machine.localdomain
 (ec2-52-193-56-41.ap-northeast-1.compute.amazonaws.com. [52.193.56.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a9bad978c4sm6140155b3a.13.2025.11.03.03.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 03:12:52 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: marek.vasut@mailbox.org
Cc: u-boot@lists.denx.de, tudor.ambarus@linaro.org, trini@konsulko.com,
 jagan@amarulasolutions.com, vigneshr@ti.com, Takahiro.Kuwano@infineon.com,
 pratyush@kernel.org, Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v2] spi-nor: add support for XM25QH01D
Date: Mon,  3 Nov 2025 19:12:25 +0800
Message-Id: <20251103111225.3161-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <05d93ac3-b79b-4503-8745-7442033b7b2a@mailbox.org>
References: <05d93ac3-b79b-4503-8745-7442033b7b2a@mailbox.org>
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

Add support for the XMC XM25QH01D SPI NOR flash.

This device has 1Gbit (128MB) capacity, with 64KB sectors and
supports 4KB erase, dual and quad read modes, and 4-byte opcodes.
Datasheet link: https://www.xmcwh.com/uploads/958/XM25QH01D_Ver1.0.pdf

Changes in v2:
- Keep the list sorted of XMC

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 0383175beb5..03596d38e6e 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -595,13 +595,14 @@ const struct flash_info spi_nor_ids[] = {
 #endif
 #ifdef CONFIG_SPI_FLASH_XMC
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
+	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XTX
-- 
2.34.1

