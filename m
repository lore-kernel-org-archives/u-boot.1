Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAA2E9D3E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 710EA838FA;
	Wed,  4 Feb 2026 15:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bxKIa/Kz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E8A8063E; Wed,  4 Feb 2026 15:00:48 +0100 (CET)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08CD80086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so9759192eec.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 06:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770213642; x=1770818442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dpgbb+mA0qtiyo9Zo22hNkjJEaCPYB/A8nkGq5yCTFk=;
 b=bxKIa/KzTc0z93B5u76bCsJcUARnT80Fff5PwZRsTSyxnRFe1YeBoMy2k/pYnlgRTk
 iUewYDTAPZ6pYiwF1ohAGgoQfJ6uq/8yGVaSOmYtTPJlujk/fVd9lnwQVL+NqeHfik2D
 poaErZOa8pI1bHRnTLaiL3oIZUCT3LWmGfCIL1v06DGAm22tUWbzito20fAjEEp1yJ1b
 T2iGSAwPYfor20Jeo+3J1MwtyjBhZnFfPm3dUQVx8CXMOiWNtjxy0ldRZQhrTF6hJo2s
 ApTb1xp/RaaQTjEcSZXtTa+gwM8VAGX3X7cQ8DMgdFnKKH+9G5OAhEUQFQGpotNkAvYw
 c/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770213642; x=1770818442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dpgbb+mA0qtiyo9Zo22hNkjJEaCPYB/A8nkGq5yCTFk=;
 b=s4A0fp6YaJ4h1XcLkh4/dXCoLLRPYAqYYO3/MA9+Pogpx5RS1lIb1Y1a6FziSEZLNH
 yDKszv3wiMbAqkcJSX3823mAVKsbaSXtqGOQthJ1ZTDdR3/+tAWF2naoK950qpT9g93a
 eVaNFXvtgdBxqJAznu30fxwsPux3JIelIJtGzOlPDi/bHNcrTMLIO5ca+KDpLbRmbZrb
 QysEBWAffHs9Hi9OADxag2mTHsbogmSx1Kgtwqe1N6lS+vgXPnZWP0gRcd3QDd+zh2fH
 MLCeTu0Fq9rMC6HBBAkiv5coz68/N04qoiwinw9X9ODo+Sr700uvDYauc9hEHDqG5jeP
 0knw==
X-Gm-Message-State: AOJu0Yw4qDAP1pgokfhzJIxH2v8pYC5CP7wLUcmYXwWOy/Pl9l7E+qAb
 eiS3jawkmkhX4/DeEMm02NieBljl5fY7yAikw8xeRwqzhIBcla4Hbgl74tbRLHDKFCo=
X-Gm-Gg: AZuq6aKs/Z7kOtROe1m5+5a6oujQckSzDMPJ7xAnxlq8WDB+0XNidgacVjFXOy2jSCp
 hzouVaMMoI1KjEVSSdLhYSVxK5b7llL14TYHRu415Xrc0my5ntDBdPmH7VhSid9E+wKM2EhX8oY
 qzZc9OIFDgil9u1ItFbEy5iYetqetAVg//SLYgGD+KGNy+x7BON2s8Ll4g/62rA5RoxmYRsasjL
 rHdldPsv9QnKbIZCXwzQnvAZWW+0pBMnlMYSez7jvEejyo8FLDD1a5eWMhuhQcG6ip6pIDxYRnM
 VRa5CIYQ3y1ZkMIHS9Q/YrmWs7ZDE/vKdCKT/HF0FI+7Yo2kTSYpV656sQmf8nd6m93c6uIJ3s8
 5bgbwStFUKUoYu4mbrWx9yFVaWVKQ99I1JpS3Oj7NLmb3dT82Wviz+wzHOwKFrmLVqjw3WFnydN
 m9o3oQyP9MlvcHr/JdkIgGD+XWjBBWfX0EKA==
X-Received: by 2002:a05:7301:38af:b0:2b7:ee1e:761a with SMTP id
 5a478bee46e88-2b832a6f07bmr1203193eec.41.1770213641622; 
 Wed, 04 Feb 2026 06:00:41 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([107.172.49.54])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-126f503ea14sm2112707c88.16.2026.02.04.06.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 06:00:41 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: Anshul Dalal <anshuld@ti.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de,
	Ssunk <ssunkkan@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: ids: Add support for Puyasemi flash chips
Date: Wed,  4 Feb 2026 22:00:20 +0800
Message-Id: <20260204140020.5769-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 15:36:24 +0100
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
PY25F01GLC
https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash%20%E8%8A%AF%E7%89%87/PY25F01GLC_Datasheet_V1.0.pdf

Changes in v2:
- Rebased on latest master.
- Dropped new CONFIG_SPI_FLASH_PUYASEMI and used existing CONFIG_SPI_FLASH_PUYA
  as suggested by Anshul Dalal.
- Added links to datasheets.

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

