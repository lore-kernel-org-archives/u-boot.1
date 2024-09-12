Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505E2EE57C7
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF3888E3D;
	Thu, 12 Sep 2024 08:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jFS9j02X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C226E88DC4; Thu, 12 Sep 2024 08:07:02 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44FF488AA4
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374b9c74aa9so47946f8f.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121220; x=1726726020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Pn2omNi1cMEFIl2a9TXeGer6hCN5yCnmBSuk6rVdTg=;
 b=jFS9j02Xp3ACNPbIQ5C3Y1cMiKIbAzn/Zqh3QxXWcljFLY6sHbJBm6hpShC2MpwixU
 3zwhhrXlvpqB6GjvKA44sG2HR1BM0iS+u8fMYBzBZJcYixbHUUqmU1HPcSZWRrmHZ5zc
 4UfhzQ+2nf1hmCmqm4MX9pD6PdGnNHs5LWThqauuMJvwU/J9g0wnxf1PZxCVJLyYMXfZ
 oCQFh8IQ2f+QcB+qH4bJjqA8ByZ2ieDc7X4F2P8QvQ15pfvpQICnas8LLPKEYZgKKNow
 FtNGz4jeyK6j0b25Zdxv/3s5ihiKjQmR7MzMcZeVbEHxuS9RJ3uyPcXTivNqqNJ2RxTh
 Egjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121220; x=1726726020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Pn2omNi1cMEFIl2a9TXeGer6hCN5yCnmBSuk6rVdTg=;
 b=pJFRSTS4oyOYcBrkaEHtBytDW/MuWW5PYTfZFqdKyH7TCVeXffq7/9Fm6jZOI6mPm0
 p01X2OL+zwe5uVcLUYOpv8OPKCQiuoC+dlFVLw1UMQNZLhhy3SG5P0GMUURGF4a0PxiZ
 mk7WMmmTWKFMB+4SXtEfb4RqcVQMUzydC3OwXqrDZjJIDWjWEmYsGrPTLqNsmz9iDimz
 Lr/LrFKaMkxv8Mak6NaBsC2zP2JeMNE6hcOXs7zLHOF1bb6i3DKHWeWo5rUlGcw7Nrbl
 uMHD0XVMQ6+7hY6J3pIBuiVWaQs9RVlLYHvN2A9LeOELQHfR2/70d45gJ3C2+3dWzFOG
 xxIQ==
X-Gm-Message-State: AOJu0YxHAmuh9G4ar5mzLP95SEzAgKEb1MIYxqQliclQOKugbkFJwZ8f
 yF8X4KkI7ajGlr61+0IUTz9bGyHIcKBREekkc0NOXewqNuapRx8Jg4gfGQ==
X-Google-Smtp-Source: AGHT+IGLfLiMGp+cPuKhLX2CMOgCzD1Zt+bBTluoNSHruCv1qEQOINOSSKtS5TC9WJGdsqjKuifkbA==
X-Received: by 2002:a5d:588b:0:b0:374:c578:e169 with SMTP id
 ffacd0b85a97d-378c2d0538bmr466684f8f.6.1726121219661; 
 Wed, 11 Sep 2024 23:06:59 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:59 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 9/9] ARM: socfpga: make AA1 use si5338 clock gen
Date: Thu, 12 Sep 2024 06:06:49 +0000
Message-Id: <20240912060649.190-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912060649.190-1-l.rubusch@gmail.com>
References: <20240912060649.190-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 08:13:00 +0200
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

Apply usage of the si5338 clock generator in Enclustra's AA1 SoM as it
has such a chip.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 board/enclustra/mercury_aa1/mercury_aa1.c       | 7 +++++++
 configs/socfpga_enclustra_mercury_aa1_defconfig | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/board/enclustra/mercury_aa1/mercury_aa1.c b/board/enclustra/mercury_aa1/mercury_aa1.c
index c53ae128f0..30a2bf6ea7 100644
--- a/board/enclustra/mercury_aa1/mercury_aa1.c
+++ b/board/enclustra/mercury_aa1/mercury_aa1.c
@@ -10,6 +10,7 @@
 #include <dm/uclass.h>
 #include <asm-generic/gpio.h>
 #include <asm/io.h>
+#include <dm.h>
 
 #include "../common/enclustra_mac.h"
 
@@ -31,6 +32,12 @@ static int altera_current_storage = ALTERA_NONE;
 
 int board_late_init(void)
 {
+	struct udevice *si5338;
+
+	if (IS_ENABLED(CONFIG_CLK_SKYWORKS_SI5338))
+		uclass_get_device_by_driver(UCLASS_CLK, DM_DRIVER_GET(si5338_clkgen),
+					    &si5338);
+
 	return enclustra_setup_mac_address();
 }
 
diff --git a/configs/socfpga_enclustra_mercury_aa1_defconfig b/configs/socfpga_enclustra_mercury_aa1_defconfig
index 58c718864b..a4b48da207 100644
--- a/configs/socfpga_enclustra_mercury_aa1_defconfig
+++ b/configs/socfpga_enclustra_mercury_aa1_defconfig
@@ -38,6 +38,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x15000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_FPGA=y
+CONFIG_SPL_I2C=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
 CONFIG_CMD_ASKENV=y
@@ -58,6 +59,7 @@ CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_CLK_SKYWORKS_SI5338=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_SYS_I2C_DW=y
 CONFIG_MISC=y
-- 
2.25.1

