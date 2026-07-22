Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB52CC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 19:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F41F40A82;
	Wed, 22 Jul 2026 19:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_PiDwzQ_pmL; Wed, 22 Jul 2026 19:46:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12E9D409DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784749615;
	bh=Uf4NkqNiCoDXc63LZlyWowzJCeyOD6QkfJ7l8ejpyJM=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=JBu5UnDqXlJKVKCc36ZXCAbiwbITbpaED+iiPrDHbvlZeSzhK+UqvXiA4sdkiFxiI
	 inWQZVvSzUwPA+czwOZoaFoCpU8H2SsjB/oPJjnZQZdsZkTHK+F+1Ta6GIT0XKf5yE
	 peOS5qC/iKxM0WtzaJxITJaFfNJyQzxmIZ2jh20ZC2+xLHOWXv8RYU0nZNxOp+zhvN
	 uJ0TqY12ciaZw+oxhCU/FBal0je6+inzz8U8o7ZVrY1moumCxFbtBANS+03oCW6Dc5
	 v6vEZ0+5vpIoPmtPoSx07cbVL7tPUZL27c1mObi1kkr5UEsjggB590kixkfBWUP12e
	 P4dIwNxNlJTjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12E9D409DE;
	Wed, 22 Jul 2026 19:46:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E75339E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7034940289
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UozceXan1fhC for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 19:46:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D51A64019E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D51A64019E
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D51A64019E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:46:52 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so2857372a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784749612; x=1785354412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uf4NkqNiCoDXc63LZlyWowzJCeyOD6QkfJ7l8ejpyJM=;
 b=NJ4H251GjRNDHJyDbbjekcNCgXxbN+B/ANAipJkQ4CrhXg7LPShpVixwhFhw4AtI0M
 6HBGj++iy2ilMTx7Mtx8Jgk4BVD8/siQxLnUFDvEIlYt8Z3WJSTS3sC8IVnVe07gqKPz
 qANJ9CM9z1NT5siL3vIMz8uZLBoI0Sqq5gmdq24fKdE2jrFIDzH90J1u22M5s6jySHAk
 w5BazeSvaWnb97h/4BeFnipnvbZTn9h3fZ5HsguH02KgxDGwmjgaeK54qQ13gD0GbKzD
 ayFnmw3A3aWCot3Re1k0Lg1waf1DxOin6Y78A/pZ5TgPnGvrlsgY2Nas4O/WAVziW5V4
 Ondg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5YpbfNzhmNd0xFyNc5JreAeYlNru25fflO9tkKglhVFk6/cm90/t7n1v1CJPjsik8XQstqxU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwgHDXeMqOdZ/7YhP6Cu6UAheqMGu3Tw0h38czvpf8xRiF/R9Qt
 DWPsJaoq6oCrnSd/aLT5AZYBY9ZGDbTCZbRgEqTxuZcnRVe05efc/pdvJMeRIg==
X-Gm-Gg: AR+sD112WiLq0QPoceWvcIGO15epZhyeo6LKEjxguupDx54+ETd7aYfKk7DNAcclb+i
 C4toY8b/9EJXOW4kM6+peXe4FAIQYrJCFbaecf35n/3HXHmaBKAdmhnf09nwoZKbFQXOHl9nQzj
 qTqywsP/PB1iBYVkMlGK/pUXzgJJuAWXuGa4Yd/izEFXsTWU8Bcuvl42uFFNg2eEEsLgD/FrQjR
 LjXiXCE3wDU/pa4t7rr6wjGXFnzxKq2stMkXuDJXEuaIjkGrlAC+6TdL2zOcTzmUNff67zkGjES
 2VGdDs+uqkgtxyJ639Dd4WfDeSV7kxIEzQ3SldgRZ01hsfGU+szJyA9ycBBJKQ+l06laeIZ1QJl
 VrjW54fByrWJuOBUAiWho45OqvIbK1QLYtLTcoYWIl6gPLJ/6BfvPe3Ref5pn06rb4jy9r87C3l
 fGYm8h0sVXVrREY8YLKDIwQJQEb5frypc/WMyLARYLqL7Vc5E=
X-Received: by 2002:a17:90b:1d44:b0:38d:dfd1:7a8 with SMTP id
 98e67ed59e1d1-38ec63e1ed7mr137159a91.2.1784749612071; 
 Wed, 22 Jul 2026 12:46:52 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:3a9b:51ad:2c34:1075])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130f42bbsm9287280c88.14.2026.07.22.12.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 12:46:51 -0700 (PDT)
To: u-boot@0leil.net
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v4 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
Date: Wed, 22 Jul 2026 16:46:35 -0300
Message-ID: <20260722194638.1285159-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784749612; x=1785354412;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uf4NkqNiCoDXc63LZlyWowzJCeyOD6QkfJ7l8ejpyJM=;
 b=o+82WkQwxisP0AnacSwGqz8ugk/wfdpz9cw51Z4TJR1pIIFS77Zg7p/OqI2CWepPdB
 +/+LN+kYzElQe3HsSoMaH7yEUqKCDxgD9jnJW8g/itO1l1EghwzM6zWD7BFns2ED2QtB
 S6FzkTEVZoo0QK4NVf2fS7kMNCwE6P6DUKuyil5/r2y78xQr7wSK0N8gCb+5t/bf7T+g
 4vOx62EYt+zEOQn5nSXcKm5lm17Oe49ogn3/niQWGMiLLr5fyO333yiP8ZsZQS5U1+gK
 dTblSqtpmFePcHQYj/tOKovQdk2hsRID6wqimyBT8nyiXLIvdHs/tdJwf0grxqHPPHNm
 wVBg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=o+82WkQw
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.

This is a 128Mbit device using 64KiB sectors and supporting 4KiB
erase, dual read and quad read, matching the other XM25QH128 variants.

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v3:
- None.

 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87c..90aa1025176c 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -673,6 +673,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("XM25QH128C", 0x204018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-- 
2.43.0

