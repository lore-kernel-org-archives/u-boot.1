Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38438EE20B8
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 16:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1E783B85;
	Fri,  6 Feb 2026 17:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RA5nCWcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43B283A64; Fri,  6 Feb 2026 17:37:56 +0100 (CET)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 638E2836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 17:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2b7381d2d95so1149648eec.0
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770395872; x=1771000672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MlagFMG+JN7QPnJ7lsSxjI6eAiPQIpKj3fmcP0t2ev8=;
 b=RA5nCWcIcXXsrI/5f54fRSUiFZbgRnXZ1Q6hvmCiOHDDUvwHxTJbII+A69Vs38QFDK
 T0I8spCqN/zYLHJY/ITFptH9tsLYwVhieTAlZhq4ZK0W2ujnQBVvy9jidJT5aam6UMS9
 EIl16gK9DRmMHC8DRbPjfIlror4Ez3KPt5NXITn46rEy7VHQgHv6x1Nhie0sbtL1VTUM
 tm2rgNYqa3M1s1fTun6tIrhwde3N6bn0bhI8dN8oMhnEnzVTVKBPYFGI511vz1i0dmV8
 VV/zWO554OCeFAXVTTRNM0yzHNIew/OC+BmabJ9XeDbePsOsSrdLsELKo5y6DFBLYCAK
 xebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770395872; x=1771000672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlagFMG+JN7QPnJ7lsSxjI6eAiPQIpKj3fmcP0t2ev8=;
 b=akEHRcalR/KLhqD7EfVOLfuavlU6dtfGVpQsGstngErHcVX3UAjI6F0e+ptWwknFSH
 FnAkLrp9Y0dhB3Z7Ae03Gn3yORz4qjKcrDQ6QrnlIV9ITKSWdFqQAXMTvjuaAJLqHUTD
 AqTf+R6ZYYOus8e4Cp/Jm4o2/heKqt0IRkhNx0dUTxRmi8u1YJQnpBuaLjrXqxMki5F5
 dQtm0d1f/nzTvl4OmC5lEFlsEdnW3w+HriXaRNPDcCn7NauSTtNnAE0RsxLR5jcQAoPT
 6tJ7keheWeFpABJu4XhSDBcPSpvJuEFawNfXA4srjYS8SDpeL8Oaf9wl31Ii8s8sTu9v
 gyeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrRhm2EXfPxu1ksAeXFVl2T5Tmyuv4Sb+LT7drvM//fBx8UYJEWjvgXK6UyVbWgW+BaOxMfOI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8vbdhOz5GcStO8vJjxgypu/QG3S5DxGJNBY4JM+5SVmOEMU0x
 XtWIHDFVZWoeCPHhbSUGkS14Q4sSsyP24XGZdjUaHnJqlKf8pVNoaRwo
X-Gm-Gg: AZuq6aKKZQJs6seBU0Agl5VMr0gbphAV+IqDzNBHBqDlI6HyIUlrkhRM/gUxuqbbNHx
 VN1ZJH6c4Jg8bvO5/Rvjf6nhd1DWFIvqUthKh+6jaQcmF2nsyJeU2wt2Ngu1Ly0coVGVCLZXNuR
 1lgZBfIAhin0aBXa+3K+sxFR0HMWmvodCUBNGQZf4WywaVaQbffRWCcuq7wNTvL3hkIo4srzAAg
 Qvy2TnMYCB3hW5ZP/+6Axi4sUJTqR02SB2FeIGNLagH5vBvSvmAC64Ux9jTF1N/zvJey5O5BBZi
 kygtApOxCy8HnaCLjYfYkAXlWXiUb2vgEHVmy3+Ig8RHnOjd6B7Rm8zhpxCWWXZ61CuMh677du0
 1aD6sNcpAdnzofECaU4uBJ82BchYshT5oUY9TobvMGfNmb+EgzhUijRGdrxSZ9AlsB7gBjPv/k0
 Jux1j1M4nhQ1ULRKS2PWyr
X-Received: by 2002:a05:7300:a284:b0:2b7:e7bb:7959 with SMTP id
 5a478bee46e88-2b855c7ada3mr1189242eec.12.1770395871612; 
 Fri, 06 Feb 2026 08:37:51 -0800 (PST)
Received: from localhost.localdomain ([107.172.49.54])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855ad8d63sm2085831eec.4.2026.02.06.08.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 08:37:51 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: jagan@amarulasolutions.com,
	vigneshr@ti.com
Cc: tudor.ambarus@linaro.org, u-boot@lists.denx.de, Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi: spi-nor-ids: Add support for XMC XM25QH01D
Date: Sat,  7 Feb 2026 00:37:13 +0800
Message-ID: <20260206163713.812-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Feb 2026 17:53:38 +0100
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

Add support for XMC XM25QH01D SPI NOR flash.

Datasheet: https://www.xmcwh.com/uploads/958/XM25QH01D_Ver1.0.pdf

---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index b6a07fa9063..954e5634d81 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -609,6 +609,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XTX
 	/* XTX Technology Limited */
-- 
2.34.1
