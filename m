Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22BFE6BF0B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 13:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3068184312;
	Fri, 30 Jan 2026 14:28:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lr6PUF/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8483842F4; Fri, 30 Jan 2026 12:01:57 +0100 (CET)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2BB8420D
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 12:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-11f36012fb2so2485713c88.1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769770913; x=1770375713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LyWPslvKG/pJaYDDfMiyxn9gBQeEJ93s59DVrVXzv5w=;
 b=Lr6PUF/T9LEgP0Vd+w7amlw11icKRR5z+ySMQo8wnT8FligA4Y2dms5L+smRoX3FvT
 kC9UpJ++hVR9zBtSKnz/xI5l7HkumtgDzJfaq9ITbemhnsdLsfiWjPv3qtu60lilczDL
 FL9PIlQXgP7XP9YX2rxxjfef52AeFqlQysGHBxMD1uvLv0SGkn6SCcsxq0zFqJwSeflv
 On0LUkoyU38BiJk78Nv9FleFN0jtx+lSSfVYwq2ykmypuRCDxCdSiNkZGTUg/y0LbXMi
 Xwov1bGcgMzCvggH3ZMjEVTZQDmir4s47WuQ/8loPszC039GeD03OC0nXU4hoLdi8x/x
 AVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769770913; x=1770375713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyWPslvKG/pJaYDDfMiyxn9gBQeEJ93s59DVrVXzv5w=;
 b=CpLae1dZFoNDqN/nGxSLvRESRgzw+VD6apnBJ0yluo/km+Fm67JifrcgunaXVGF9pG
 0AWzUTEZIcFJkdHbjRuXa5pHAiKeqrIXxZKmpdbUYIGyxw/MjjNyrgcYy8kNpQjudsxm
 EcYh6efXMSebD6rvqufzlEzRiYD9wSeZ4Ir6yJaioxQbGF+5p7hH+JnRrAWKp/67OJ54
 S/etrl9i1EHdI2XVPWRyHN8ZUklbix41ZpzxVza1Odgyxf5XyS7WBkz1ORerbBMu0BM7
 RUAnZsDC7v8/3/wbs1ycENjboIKNSZtKwKkQln2BEGMSSyZbmhBx5TUkyeNI3FuLK3bl
 LtxQ==
X-Gm-Message-State: AOJu0Yygie9YsgzkaJsuzJHEQcBJIKT4rgZhsqpOY8Cll5HoY9MES9hZ
 xDEbOULPQyxZDLcqBU6sNzxtAUs7Zsx4jHm7/5hzWwHTDZgBAkL57Sou
X-Gm-Gg: AZuq6aJ6nfKLFLaCdWBWFX5wcN3L4Cp2se3NExUqd9QEW0xTLEQKovMxLmkfotH8rbX
 hwh+6mGBcFIyUPxpa48ZSvYK0Yg2KFAq/Xy6GmXcobETHKqHKuK84IqdLbzwbx3rKY+OUODXUhR
 3kHOz7gKcGB/nYobWA5j+n4Ednj262W9fsSe5oFKOX+dm0bTvalN91x4dTw+UkUVul/8dLxygzN
 Kv3rPZsnS5zWmaMNJGNT84egg7X6Lfm8EROp+1a2V6M5mMAEW9wX4t1nikJsninPOjVjQFWClu1
 nHIkT4DNbos4iMaTS8glvuUGDZED70sZ9npeKn9KaN/KSYuKK4ZZn6WIOk2UfNxBHFAN31qtYtg
 8JpS7/A92p/U3Cl443JmVsFBVWq8ndYM5l3v5DudfuretzhWTVDnBEUHG1kt9plwHqTPl1XJVhD
 0JfPm7HPb2Rba154HxZ+UwL9JvlmNePpKNbIYDH3cxPrhY
X-Received: by 2002:a05:7022:628b:b0:11b:923d:7753 with SMTP id
 a92af1059eb24-125c0f7e618mr1270857c88.3.1769770913370; 
 Fri, 30 Jan 2026 03:01:53 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([107.172.49.54])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a9de948esm10620407c88.9.2026.01.30.03.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 03:01:52 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de,
	Ssunk <ssunkkan@gmail.com>
Subject: [PATCH] mtd: spi-nor: ids: Add support for Puyasemi flash chips
Date: Fri, 30 Jan 2026 19:01:32 +0800
Message-Id: <20260130110132.8018-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Jan 2026 14:28:16 +0100
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

This patch adds JEDEC IDs for Puyasemi PY25F512HB, PY25F01GHB,
PY25F512LC, and PY25F01GLC flash parts.

site: https://www.puyasemi.com

Signed-off-by: Ssunk <ssunkkan@gmail.com>
---
 drivers/mtd/spi/Kconfig       |  6 ++++++
 drivers/mtd/spi/spi-nor-ids.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index a9617c6c58..c223862a46 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -217,6 +217,12 @@ config SPI_FLASH_XTX
 	  Add support for various XTX (XTX Technology Limited)
 	  SPI flash chips (XT25xxx).
 
+config SPI_FLASH_PUYASEMI
+	bool "PUYASEMI SPI flash support"
+	help
+	  Add support for various PUYASEMI (Puya Semiconductor (Shanghai) Co., Ltd.)
+	  SPI flash chips (py25xxx)
+
 endif
 
 config SPI_FLASH_USE_4K_SECTORS
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4b7b358eac..2e479ab8a1 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -624,6 +624,17 @@ const struct flash_info spi_nor_ids[] = {
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("xt25w01g", 0x0b651B, 0, 64 * 1024, 2048,
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+#endif
+#ifdef CONFIG_SPI_FLASH_PUYASEMI
+	/* Puya Semiconductor (Shanghai) Co., Ltd */
+	{ INFO("py25f512hb", 0x85231a, 0, 64 * 1024, 1024,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("py25f01ghb", 0x85231b, 0, 64 * 1024, 2048,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("py25f512lc", 0x85631a, 0, 64 * 1024, 1024,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("py25f01glc", 0x85631b, 0, 64 * 1024, 2048,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 	{ },
 };
-- 
2.34.1

