Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721FBC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC2E784C2F;
	Wed,  1 Jul 2026 19:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIFJqk/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A67084AE9; Wed,  1 Jul 2026 19:58:24 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B81D84C4D
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c96d2bebca3so429479a12.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782928701; x=1783533501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoLIH7a3k8zBYyq0Oftvv6LLVntnOGIaFxj5+tPAwN0=;
 b=PIFJqk/qCNKl4CWR4fI1MWaWSJcrdvd7cPJGr4a9tfdzu94n9pWhuM6GUEvzeicNUX
 LZYkVQ6PpNv/0qCbZV0imzJ9U5XRi9M50KlB6Ax8InGh0vjzo3ibot5AJ6pA4iB4QLCM
 GGEuV6fHMph4x9frwpuYN+o+kgKibl1tvQwa881b1NeCFAqiQg9mc+PLJU7J3l1ngaJ+
 Gxq1KlLj5MLPkoLNLQJUWO6ZxuZZxUue//xkXUEEIaFKghZ3W373iVHfFK/+dZ3eHOuY
 vBPpHaa3F/gP/mJ9YMhw4xZMP+FXtR5vWqpWinfYSCoV0QwD25Ra5dzmetJjT1BCyMam
 7URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928701; x=1783533501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RoLIH7a3k8zBYyq0Oftvv6LLVntnOGIaFxj5+tPAwN0=;
 b=oow6o6XqVhizz4Opd9xYiDkekG2W7MC4ac/IW8oJF3YZWrSSQ439Upxf4fge1oygaV
 CAEdMlguukMIlXbYCWqSiFYlgUa7ihhcPPPKS76/7jSxetFEWqGqYcAGO6Lrf5QCekPM
 vbZiBcpHdUzSO2LB3ecm7SpI4A3gLKXIBNfYXHf5EqwFkuB/nKbxbGO5EsSbDO74kmcp
 cQjoGJcc7KgVrCYUttMFghAtLFKaLWh2cPxrhdALrMa83KfVMOz06yZK/6RVwgcjgHJX
 lb9eZvAxfoTvLPdBaR1rx6RGMdRm8CtuCAHGqGLaKUXAqdnwW5YFVaM/aOPQ8e94icPi
 TD4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gRu/jieJ4n141JLEWGADKVeGs4v5c9UCfQGeiBCcyPR8glS8KO15cg0RX/gGscY99jCBIX+I=@lists.denx.de
X-Gm-Message-State: AOJu0YzMtdtuNU2ewzwxigfW9PfXNp0cAkOgzZOGytYwjEIKIY5wcEXW
 alJq84xX2pZBht8CviUnp4ZiZYbR5aSZKxjDpGbhOmoZ615AI15r6AEJmp86tQ==
X-Gm-Gg: AfdE7ckeN794Cvqe6XYnq6ylb79aklUZDOLpb8Url0V6zvPQ/JbCMWC30iuQsjKaRGf
 dcizIRs4CdPb72gGxHbgEWFomkC+OPe75Yg+g9TcXhMQuFKH2blO+vwFuwPp47O3pvim0PY2Rrk
 Boze8poO5wmVHxwHwnhgkXEm9vgj5ieGyGT1TCrVZh0z3XNpzpeBPNYMubjjScRGsU5QSZ/V9Dy
 RD+1bil6ULDyPE1Twsm+/Je640xVhuwjx7NSovsAWKr6gF5vVQfg2zuaWFnpGvLEKp6W6ZxXmHq
 NdqaMIV0EehiuLDQlIsYT0EdBKK7sCLRWJxKJxqwmruYdifTKnIF+cS2inakOf95QCQTEBLpZOQ
 qXNxESkilgDXCGSkkVQox/i2fcHTjFkGKyTim1cJt/FGMfWWNJy1OSF4gAZUdWCfjOC2IwYcLKY
 MHHF81tJoINqbaE5qvp+8L2TpSeOZGpJq3AFo3+FX2Hi24uibjqMOzt4VR7n/GCHat0dH+cw==
X-Received: by 2002:a05:6a21:514:b0:3bf:b960:6fc4 with SMTP id
 adf61e73a8af0-3bfed4701b4mr2856184637.30.1782928700573; 
 Wed, 01 Jul 2026 10:58:20 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:5116:3bae:12e8:a7c9:dab9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm63078eec.27.2026.07.01.10.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:58:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 3/5] mtd: spi-nor-ids: Add XMC XM25QH128C
Date: Wed,  1 Jul 2026 14:57:58 -0300
Message-ID: <20260701175800.40141-3-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701175800.40141-1-festevam@gmail.com>
References: <20260701175800.40141-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Add the JEDEC ID for the XMC XM25QH128C SPI NOR flash.

This is a 128Mbit device using 64KiB sectors and supporting 4KiB
erase, dual read and quad read, matching the other XM25QH128 variants.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- None.

 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aab..18d61ddd2e33 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -669,6 +669,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("XM25QH128C", 0x204018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-- 
2.43.0

