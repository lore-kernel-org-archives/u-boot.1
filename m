Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F2EF588C1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655C38433B;
	Mon, 20 Apr 2026 14:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ptdx5qIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13E684348; Mon, 20 Apr 2026 14:48:35 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF3C84329
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 14:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=flaviu.nistor@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso1704949f8f.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776689313; x=1777294113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RIKcvWE7sd/sgl3WZdfO4HgLQQv28DZFDQ2oLpbkjwY=;
 b=ptdx5qIRnp2tjrQqWKQkxX/WznQ9rCUSFec3W59QEQxbyLKkY6sQcvNPB8d5R4TIDm
 /ps5Wrnqv2MmewoUdL88m+OBxvx957lde9NGi2BqluPrZXlAOcY6dCVvw/EMKWcuuE8K
 IBsVp0ck0Cct7CJ0pnY9httsbHUt3GV+uqiU1Pcs+tk/IEcGxiwozbhwJaUmxMKqLVJ8
 DRp/bij255RGbjXAIPwguzhkS447mMlbjlNUmbqCFL3JsEe3UnRPblkroe+gH6JBb/Zg
 Jb1PjSHcxqa23qbzzjmyM7Uo1hZSFjgFl7UrCstfu0iG/Wa5Viou76OAj1KaV4Q++DY1
 pGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776689313; x=1777294113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIKcvWE7sd/sgl3WZdfO4HgLQQv28DZFDQ2oLpbkjwY=;
 b=bk0wXUpwdqREiZKifjN1OeJ/8E2YFubjsW6YinXDEK6GuXNta/hzvvxLLXTNlL0c/y
 eEpLhdkQ8KRWq7K6R/+gB9Avk3QmlP7W6+Fo+KjhjVPapaZqjmkaeUMEq3JIysAtEW7L
 biwVC8Wx91Se9hLKYojuFVjwiNjl823MTYMywbknBdsCPNLPlGiL2V+zpU9ZIjWoREKf
 jmOtBALnwdUfFAn6RNqbWJJu35WEXTv+uRmO6Y22ENOveO9Ba7FhaswMO4W6hP7o5PSH
 eJdFBUt0m92hisIhvxMr/Lsr+3XHQNXy7TJ1w2FiKPkyTb8qMV6LUa4gjDvvXbzcXQAa
 a8vw==
X-Gm-Message-State: AOJu0YyNSu15XWh2nclPesWd8eTRmdT61QHBVy6kcxn6V+ZgLXpiYwti
 i3vVAyPBMpf88S16MDyhhZQefMaIBYLYnyfS9jy77KPBcL/Xcj/HgAMOe0eg5OmiMo4=
X-Gm-Gg: AeBDiev5Fdz0j3vvlvDeXYbmIj2Ots/ynLoDrycdj6XZYYuPVIjBxh6DiITsXu/1hXa
 9BDv6FlGc6CKfyF9A9hFs4ZLZUNMUk6JmcO9uVitdNXa0Kon8KNBmRfX/UcGDk4fuhXdB0ZvObb
 GplM9ryIOSlW3MdMcCnTf/dOa9SW9e8BVzkal6Zi9l3cWP2/og/vebgbOpjBBDfMbdEiYfp1b06
 Lrb7LPvA8Q1bU5HEN1pVGGRSRHiTmzTFaGMo5BDMRYiWUmA/WvKA6ttjeEX5LasUfw4LJ5ckZay
 +cq5RlH+Yxjzc3ZIfox9nnyt+C759lmKGdcw6aOrZQ6SV5JPedMaq2dgxsrk8W8P5SoHL4qhLZI
 a7Mo7EeldWGmfkSOuzgbQjc6K5umOf/IztUpeGyajEu9NW3/v1gXgeyXHR35jGI071GzdxMGpSl
 YPGzHe88++ysTF3aTQRxSr9O5Bo4CeBMv5YSu1e3QoxvW09T2hAHZ/PYkMN+Nyn9kUMWkMtLfdD
 M4CfK2zsGG1Ow==
X-Received: by 2002:a05:6000:24ca:b0:43d:c2bc:21b0 with SMTP id
 ffacd0b85a97d-43fe3e0c647mr19633913f8f.46.1776689312816; 
 Mon, 20 Apr 2026 05:48:32 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.249.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc09b1sm29367063f8f.9.2026.04.20.05.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:48:32 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: [PATCH] mtd: spi-nor-ids: Add mt35xl256 and mtd35xu256 chips
Date: Mon, 20 Apr 2026 15:48:26 +0300
Message-ID: <20260420124826.25876-1-flaviu.nistor@gmail.com>
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

Add mt35xl256aba and mtd35xu256aba chips to the
spi-nor id table.
Both chips have a size of 32MB where mt35xu256aba
is the 1.8V version and mt35xl256aba is the 3V
version.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index e7fea375706..791e2677aed 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -371,6 +371,10 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mt25qu02g",   0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ INFO("mt25ql02g",   0x20ba22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE | SPI_NOR_4B_OPCODES) },
 #ifdef CONFIG_SPI_FLASH_MT35XU
+	{ INFO("mt35xl256aba", 0x2c5a19, 0,  128 * 1024,  256,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("mt35xu256aba", 0x2c5b19, 0,  128 * 1024,  256,
+		USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xl512aba", 0x2c5a1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024,
-- 
2.43.0

