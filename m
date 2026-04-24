Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526EFFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A477584513;
	Sat, 25 Apr 2026 20:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gsJYuSF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5793B8444B; Sat, 25 Apr 2026 19:28:09 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49ED5841D7
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8dbbc6c16b2so1120034585a.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777138086; x=1777742886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wht6B62QlR79uHM9YeyXhJAr3B9J6OIXnCgSFw/EKu4=;
 b=gsJYuSF/2SnxGie9IUheUKwryuUuiwLZXlAnabY5pbHUh8DMkpMm/gDJT+w7+lLh51
 OtvltO3MDsQFEE4P2lgP2Bteck8nx8PJqFVQLid0ptGe1buMUEarPh5OLAXAUKDNzYtz
 BWSCcYvtVS0oDr04djlJwQAobE/UvnYM8xEtTYD9NOGD6aDlkVacN6l+lJwjiH11WTh4
 XZu+O16kuhZ73I/2U2T1aSKs/FfwLggGkMSAb+zQdz2ckavmwZVFViAK1WLEb+/xuI6q
 1qwr/JXaRZFomDHAr0OqKjag13392UWlwi00+SRrFE4J1AKg6XmIPUF1U5o7SstBp2ga
 FVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777138086; x=1777742886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wht6B62QlR79uHM9YeyXhJAr3B9J6OIXnCgSFw/EKu4=;
 b=h78zyKHYEo0J1upXIcz5lp3JKULxnN9oGoqTJtq125Shz6xENEwUo8J9fxRgNKzB2t
 zEROnGhPO4gBmB2U9SNYYhg6xO+YKC1UBORMGI7q3o5Ub/kYcPDKYjxdB4ddOn6iWVtx
 02e4pZDhbOwTglmss6udXjxGSqATJT38dAu3KvufPiTWAQMemkAmeNAqHBuBzHEbp1pM
 KdIOzmBq8qRp4vAacYvcxG1pngrRZBLUMQ7v4kFTYw3ylqJGYXa/KV/xvt1SMENXUIC+
 VfFogovzXG8Jugl/gKYlVwei3CMpW7qIBTdh7BzhyfE5uQjmJofiip2rRL2+sLso7FYj
 6Zfg==
X-Gm-Message-State: AOJu0YyOWfjd6Lz7rpmHfeOkMnL1+E9Dc6rmtrZvSQvmMfBSzdPnsgRt
 5+zydfaHFcfXaCaA9BQLm/lzVS2r9KL8YkeJjwiTiGYcLdeW5lvmIOdi2zBWiGRK
X-Gm-Gg: AeBDiet9mpFgO4Ngvyai9V20napyTey9VE2Z8VqU2gbRh28zRwOXsOgsY4JEnNcqNBN
 7CR3t1O+TstYJx0P33pPalzxQGhGxeSdGMPm2+1i4WTp7WmDMxtTKDARYb/t4dTon6R9s4Yb9VP
 Fu23SSDwfoWFPJ8aewsmmQqNH0MuWl0rRenfL4W08REhhVTRNL6wFckLAP1AD9mPcsBfOWiElqq
 zALVgA3FtZrHEYSybK0Gp5bEnRP8LvphJNKFVxRge5Kcv5JwlNSn7cmw6gUkck9jx2nhYvFCyes
 JUB20vr3Luxf01laYmwiJHy9MKEXLovalq9QKX1NUY5jJnHVkJ9yOlKwf33DHGuFK3YmifJ0pFS
 qm6Soe5al/u4vkLJcUWCMt8N63wvWBeGs7NgtP2EjaoT6aKdgck1x1fcvev8aihIKl+zcKAYHsR
 o3MT9iEAlQjKL459dTKQAfetTaT4l16Q==
X-Received: by 2002:a05:7022:2385:b0:12c:aae:7b43 with SMTP id
 a92af1059eb24-12c73b5af08mr12625887c88.24.1777026249812; 
 Fri, 24 Apr 2026 03:24:09 -0700 (PDT)
Received: from Sun ([107.172.49.54]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12da8b8fbc4sm25474905c88.4.2026.04.24.03.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:24:09 -0700 (PDT)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de,
	vigneshr@ti.com
Cc: takahiro.kuwano@infineon.com,
	Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi-nor: Update XM25QH512C to XM25QH512D
Date: Fri, 24 Apr 2026 18:23:43 +0800
Message-ID: <20260424102343.1087-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

The XM25QH512C has been replaced by XM25QH512D. Both share the same
JEDEC ID (0x204020) and have identical parameters. Update the flash
name to reflect the current part in use.
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..3b8e309e0f2 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -672,7 +672,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QH512D", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
-- 
2.53.0.windows.2

