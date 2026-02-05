Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72491ECD980
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F100683C23;
	Thu,  5 Feb 2026 16:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pst4YjWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D99083BC8; Thu,  5 Feb 2026 16:20:21 +0100 (CET)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DAFF8341A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1248d27f2b9so1130927c88.0
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 07:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770304817; x=1770909617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O3GMl/Pw3ieT8b0h6+VMRoyNlSfdEA5ecwM/a1IxBdU=;
 b=Pst4YjWI41/swowsB0IIHwZRfDteHZCFxIdRQ6BZr8lCP9ymefMT2Acboo4MXy8WGo
 Tm1Yxsik8+FqfDtiNq/brQ+z0KqNYLWSE+NC7WwNQLn8vLF5dT6eDbJwVzBzNxvm8vAw
 jLlQezdBE2tKmdCL8SMlQPtRWl43mgwYHnKmV5vVV2XrMWfeSPoGQwrYYCn+4YS2RqTE
 LYYfZK4yvMELHC9iRHRt4XvD67w/+MormRYtd91OaExzHhjrdOPj/sFZqgT5dTxEQBzf
 xf0OsQUU69mTzXjJyFm7I6Va2cSO/3o2om5hKrNz63XUEqKZ4iXewLdc2sfe9JdBFVGA
 qMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770304817; x=1770909617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3GMl/Pw3ieT8b0h6+VMRoyNlSfdEA5ecwM/a1IxBdU=;
 b=cEdPnxa5ROaz97lVqzzjEMGf7v5aqJv/ZvmA+1Tvn2Le1PIVlDKN1OykiCh6cudpcv
 hsyYXkvDX1os7A8QJYd5J5AhcZw2BePropC+6jy0xQbzmZ1WGDkjk39ZG106paARV8Rv
 JIuSTn3yir2syVIdSj9+UZnOlkDFkhgyxMRJHUU60ArXLT7OQByQ6XfhpGxJDFSK8LRJ
 KsqHUqYtobORsJKEhr29HFSBTkx3NUtnN9o/HoxlabXL0yPGl40Mu4gUx19wCHAngcWT
 K2WdFZwRiT1bmaF739gNJ/r9SVpOQOTkV4OIF35Fm9eSbEsLOB2JxltwbaDAmMlikxrp
 kqqQ==
X-Gm-Message-State: AOJu0YzuLZ1rsCLyi52627qQ91vMOwr8Iuj6uHNpVNhWshH0KT5g40ep
 7JsjqC888fBPKcgTYcP+wxoWx6diTNEOh7exOSbuqayp2U/6mWNDR2IT
X-Gm-Gg: AZuq6aIk3nHfiYOngow7AhaoNOPpycut6r8qDxLtKDmr1tAQhYnwliae7zdgSjwgHW2
 5mzT5pgIcGtMZRTTQAbSk7rNcm1SiiXN61iSYSZgQLGi9RlmGpEH3mZJyKil4ZEGlll0TsVo5gv
 xxN5ut3wLupiF8nW9x4D5TyiHF3UAvDxJk3hZZN3LpDAv7raPqbFtBO1FbfDPa7EcXePxnRp469
 94wIi1ZvFcYa6XtqOwZBz4oXnVuDPDqN4xcWql9z3HFDAOlOE+Br9Z3J8MwIxD03Ftt+5+IJYVU
 KHZEKkehtdM3DNYrc32GNXfVIuRNAvBcvUuMpBo07fQIMUXbcEKRdG8ETjeekUOiYyIHB5X8TJU
 sv4JPq0U4DEkYLUVLeaFMPdZU/oXqRbXOPBE+g3hh3ls66h/zd/erVO2XE9bNHTYMVooYdCI0jW
 JZX22id0/4gmoHFv2OR/vE5lNrIXeMGDW2Kg==
X-Received: by 2002:a05:7022:69aa:b0:11b:a8e3:8468 with SMTP id
 a92af1059eb24-126f47d16e1mr3507020c88.33.1770304816519; 
 Thu, 05 Feb 2026 07:20:16 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([107.172.49.54])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-126f4e107b4sm4837500c88.7.2026.02.05.07.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 07:20:16 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: Anshul Dalal <anshuld@ti.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de,
	Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v3] mtd: spi-nor: ids: Add support for Puyasemi flash chips
Date: Thu,  5 Feb 2026 23:20:02 +0800
Message-Id: <20260205152002.3384-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Feb 2026 16:35:01 +0100
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

Add JEDEC IDs for Puyasemi PY25F512HB, PY25F01GHB, PY25F512LC,
and PY25F01GLC flash parts.

Datasheets:
PY25F512HB:
https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash%20%E8%8A%AF%E7%89%87/PY25F512HB_Datasheet_V1.2.pdf
PY25F01GHB:
https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash/PY25F01GHB_Datasheet_V1.1.pdf
PY25F512LC:
https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash/PY25F512LC_Datasheet_V1.3.pdf
PY25F01GLC:
https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash%20%E8%8A%AF%E7%89%87/PY25F01GLC_Datasheet_V1.0.pdf

Changes in v3:
- Fixed typo in commit message (missing colon).
- Collected Reviewed-by tag from Anshul Dalal.

Changes in v2:
- Rebased on latest master.
- Dropped new CONFIG_SPI_FLASH_PUYASEMI and used existing CONFIG_SPI_FLASH_PUYA
  as suggested by Anshul Dalal.
- Added links to datasheets.

Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index b6a07fa9063..fb8a1972299 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -323,6 +323,18 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO
 	 ("p25q128h", 0x856018, 0, 64 * 1024, 256,
 	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO
+	 ("py25f512hb", 0x85231a, 0, 64 * 1024, 1024,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO
+	 ("py25f01ghb", 0x85231b, 0, 64 * 1024, 2048,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO
+	 ("py25f512lc", 0x85631a, 0, 64 * 1024, 1024,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO
+	 ("py25f01glc", 0x85631b, 0, 64 * 1024, 2048,
+	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 
 #ifdef CONFIG_SPI_FLASH_SILICONKAISER
-- 
2.34.1

