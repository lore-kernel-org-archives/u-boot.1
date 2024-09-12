Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE8DEE645D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 08:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1F388F0C;
	Thu, 12 Sep 2024 10:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="caxPmHRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8484C88F0C; Thu, 12 Sep 2024 10:01:48 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE9288EDE
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-718e6299191so352579b3a.2
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726128102; x=1726732902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdzPCxma7CS0sXKnaQTsi0Ww83UXiiZ6ZZszdsfJd8k=;
 b=caxPmHRkoceOeWun0f021rj4sdRZStMueeNXY4p+Odm/UPpnhwppvLx32mYzSUmWpk
 EAEUJMvrlJwM2hZyQ8kObb8Z6MQm53uDZXjT2x7mB4PnsOh9O9ugJT21xdJXZMqgGDHV
 oQjS2LW7BR3Wwy+c1DO0+ylu4zpLxZ5yOfh/aD7SY+pvVqgR0ahP7EayDZVc5qvlNJTb
 aKi1X8QCUU73gj56a5Ng1nuHJmxOrzrIoMm2/B3Rdek9wwfJm9InTt0kw7eyiANMPTIx
 iGp06diEPttQrsmuT9CoeQoWWY7G7aewxTtZ8/nZM9JZ6gYsxBSknBY+Uvs8T7D9ko84
 vZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726128102; x=1726732902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdzPCxma7CS0sXKnaQTsi0Ww83UXiiZ6ZZszdsfJd8k=;
 b=fNxB989PhaF8OboBtLrG1byIq6VU0BxJ8vkdf2eoq9Mo7WOgdmuBWdWhsipp5oHBNB
 0eHWDakE8zHjfp4uvjGG1X642GyQIdnLdnE7mdsTrORvejeUmfmZYoSRgn9JPPlCLnp7
 xX36lpBjO7/B+Y222GGz4vzVyAW8whUwZ3BidJjrX/t4FMn6GdJJUXMLIBv62t9eBSI+
 D+16+j5N7mPpKo1iP9gOqJyR5Blumqh/PgpYs4e5lCBj40wsiutAbB6ng5RoisI09422
 mwMsZNgjoVmhvTb776GZFtX/lQ+ls2qoKgdl2fSST5ON6lTZT/gy1camjwqonOaafYBU
 I9XA==
X-Gm-Message-State: AOJu0YxDjH+pP2wvJGhautSxqKFTCz2/vmQMY8P9lk7GrDTBWgXJd/Kv
 a5y8OdzM/o/kCjj6t1r1GfvKfbxRzEQl01TTpb3/QUMA80h9Hat9hTh+Vw==
X-Google-Smtp-Source: AGHT+IEK3p8JOZ67jZR4ZEcjMFSrP/AR/AFbJfZ5WoVEKSgBk0oOTzbdmWwmsllP+ydIz2AdykKwPw==
X-Received: by 2002:a05:6a00:17a5:b0:717:9897:1405 with SMTP id
 d2e1a72fcca58-719261cb78dmr3103934b3a.17.1726128101413; 
 Thu, 12 Sep 2024 01:01:41 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090ad8bfsm4241790b3a.145.2024.09.12.01.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:01:41 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, prasad.kummari@amd.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 1/2] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon
 s25hl02Gt and s25hs02gt
Date: Thu, 12 Sep 2024 17:01:29 +0900
Message-Id: <20de53f96a1497ef15943e82477d24bd0f43fb87.1726127619.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726127619.git.Takahiro.Kuwano@infineon.com>
References: <cover.1726127619.git.Takahiro.Kuwano@infineon.com>
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

S25HL02GT and S25HS02GT are dual-die package parts and do not support
chip erase.

Fixes: c95a914aed7 ("mtd: spi-nor-ids: Add Cypress s25hl-t/s25hs-t")
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 9693c179b7..3270ebb533 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -372,7 +372,7 @@ const struct flash_info spi_nor_ids[] = {
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
 	{ INFO6("s25hl02gt",  0x342a1c, 0x0f0090, 256 * 1024, 1024,
-		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 	{ INFO6("s25hs512t",  0x342b1a, 0x0f0390, 256 * 1024, 256,
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
@@ -380,7 +380,7 @@ const struct flash_info spi_nor_ids[] = {
 		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES |
 		USE_CLSR) },
 	{ INFO6("s25hs02gt",  0x342b1c, 0x0f0090, 256 * 1024, 1024,
-		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+		SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | NO_CHIP_ERASE) },
 	{ INFO6("s25fs256t",  0x342b19, 0x0f0890, 128 * 1024, 256,
 		SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #ifdef CONFIG_SPI_FLASH_S28HX_T
-- 
2.34.1

