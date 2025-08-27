Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDE1CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 10:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EC583145;
	Wed, 27 Aug 2025 12:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xa3WrR+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96C67831B4; Wed, 27 Aug 2025 12:59:41 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D4198304F
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 12:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b49db86cac4so2405947a12.3
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756292377; x=1756897177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ru+PrtmiA4yGrzJpeoOCpvMfafnskQCXBnkZfBQzKsA=;
 b=Xa3WrR+6AA4xRSZCKl3Ocmz3V+Umfgi8G80ob2c+pcWwpai6FGkir8x0IBksqWZhYh
 ERQpI/WUBAHC3EcRQVfifAHY4LmbPm0lRxyQq03ZWqLLbd2OaMhVa0ghrCON+MH3f6CU
 nRVaOnNMorLH2YPNQeiPCExnwwBaJ55/dk2biFSt9IgT6Mrfs2Sz/qfvOnrFouNkOzHr
 m4M6HgyulRhKc8QOM7WvvaGAOKotJT41mDX6DXWKOf+GThG+ARzL9uAN+FqGBFd2xBSB
 2ArWI98KONAI8BmpbnEr+fOXE0rIo1GLTP99ZIUi5hIZDt5qCOf6xne6hLBK1fHCWb38
 hQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756292377; x=1756897177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ru+PrtmiA4yGrzJpeoOCpvMfafnskQCXBnkZfBQzKsA=;
 b=BfMeThkhNIfcft/p5m4ULsDJEGSQ3I5Ju6xlWwuPFY1r+gDLR9440TsaqaaCppMNE7
 rRUNr8TfYp/8mPYWh+7RgxB0hY8xDhzwn7yfsgwgpj2s+CQs1paUW/EsnFUWnVAEnpyd
 tTmw24RijLNxv2EE6e/FTx68q65czyRTbV14jk46Rj2xu7YkWOgpfkEWeqiEKj8++ghJ
 9zlOJJbQrgyhFyF9FMZkT/95uCOIVdK42Nj/HyJtbpHWdtb6iASVhPnkotkm/VzGmiHX
 x09+AwVKOXg3HLLkr5ffj1he9M61hJUg3I3xoCA2fdYBc0zna5AuMnaP13ZHIZpRzsUP
 f8CQ==
X-Gm-Message-State: AOJu0YzkeZZWHEwj/a0/x4YKYjtqoGAFe/fKxYAnsSmxN0E5SDWm7RM+
 nWZrH0cfr0IbtuPcuS5+3FQJas8A8/VPMpqZCFVEDsRfgtE7IcLMIv1hwo/5+7ENJE8=
X-Gm-Gg: ASbGncvZtbXfq4Pwt2Vh7U9yHscOo+QdnDY+fPuFxaks+ggcqr25NVJx0Ht4fzVWx7n
 dpWYio8rLVaq8qpumVpArLdBb6wfJGtbnFByM5TcK3FYfBNaO7uFQRtOe3ZXWI8zSXexQKvy2XJ
 NmIfJfVFUqVvywCptFp7P+s8iapec05/vQyb3JhobmdytKBe+ZO2H4UWwz1ysQQuVPLzpX5z7x1
 Py6+OOFaBbi/VwcB43yy1nECrLrUhhMYaWezS8M0sgfBQuwFfQLKn71JdqRIp0s5wdqzPOjw9w0
 l00iTl1WCJgpCyIni6GpT7YJxWT9aGpzpZCSxGokKmT5ZpgFT7uok5c1VTElpwIOqsQSoRfykur
 qUWBMvbPAfrF5IsZIyMVE0RIbZd42QeMHmaR9hwtEHniXI1ec2vT5V+KJdvPhvZxAiRB6
X-Google-Smtp-Source: AGHT+IGS1fan/bbNgaXx7roOdebaGYj07l24w16AveTIMdm541JpQCe5P4IWZEoBUzjKk6LroWLanQ==
X-Received: by 2002:a17:902:e78c:b0:248:a18e:200a with SMTP id
 d9443c01a7336-248a19d6483mr14943095ad.10.1756292377015; 
 Wed, 27 Aug 2025 03:59:37 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([121.225.131.60])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2486fdc0ec8sm38835835ad.145.2025.08.27.03.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 03:59:36 -0700 (PDT)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 trini@konsulko.com, Takahiro.Kuwano@infineon.com,
 marek.vasut+renesas@mailbox.org, pratyush@kernel.org,
 Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] spi-nor: add support for XM25QH01D
Date: Wed, 27 Aug 2025 18:58:54 +0800
Message-Id: <20250827105854.10746-1-ssunkkan@gmail.com>
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

Add support for the XMC XM25QH01D SPI NOR flash.

This device has 1Gbit (128MB) capacity, with 64KB sectors and
supports 4KB erase, dual and quad read modes, and 4-byte opcodes.
Datasheet link: https://www.xmcwh.com/uploads/958/XM25QH01D_Ver1.0.pdf

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 0383175beb5..330ab77ee5d 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -603,6 +603,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XTX
 	/* XTX Technology Limited */
-- 
2.34.1

