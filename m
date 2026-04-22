Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8682AF9EDDB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF2F843A4;
	Wed, 22 Apr 2026 16:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wg+d0Z5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A1C84374; Wed, 22 Apr 2026 16:32:07 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC1F584314
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-50faeb8317bso22150331cf.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868319; x=1777473119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmkjJ8tdrSt9FopBWWFI70C+HtzT1To5aZFAo3zc0Bo=;
 b=Wg+d0Z5d9IXed/0SLPFTfniusIJsf6ofhvMMhZzyWD3ilGPwbJ3S7jdtvim9zAoZp5
 MCxXwqsQ8bKUcVmZn+HZUoKpj4PCEwh9XRQBa7FAXAL82ujFtHi27/akRpsb4YoKuVV6
 XZK566Y9EwgukCiL5d6nGm35CBjKYgElmp1df2rNE1xWpclnpL0bUT7VMtuRqC3vpn6T
 pmOBx/jhWapARYik7DuLp2Ts91my9lbSWD1bdYe49rJg49ypiWQr8Yk0UPzCcYZiteTU
 LfyxjzUayl9Kx4FK1HZZgSVIas1nordPFznSGAajAnBZWdT5cs/R8BYKS2qqY3+VxVxs
 Sdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868319; x=1777473119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TmkjJ8tdrSt9FopBWWFI70C+HtzT1To5aZFAo3zc0Bo=;
 b=WF6MaZj9dOXhmiMDuvBG+Qq5bzBzPgZ/iKrxi63KsO9yZU1PaCq+Hwxf1jYhoH57xH
 mLIaq5b8cD6VD6I4UbUSd8XLTI0auirCorrXNJIWOqS3hIFku4tF4uckT3TBLY20o9GA
 v0WLCsuxalVECTPkGH4QmILjUxYx+M6lIGKzXxUaSExQshwSr69K2raLoWe6AI8WYPP3
 6XtIeKD52BV+WKIf+9ebGxYGa/AaLiptyEX4GQtt5Twsc4/SAXgsO5Qb1ak4024C6Ijf
 4UCdT5hcEDIg957NJagbXwN0e0t5KL084SmU4+SzQGVVSrFqFcUQrdzFFKcqD34VaqbK
 uMMQ==
X-Gm-Message-State: AOJu0YzhPv2i9mPQ/TW3WTQ9HEYk+xOdL2oWW0aDM9IazH010tXTlCsO
 AOE+G8rhQnTbMF0MEXIWa41+CRkwweoc8k+/ehwplnns9A6/JsU5CoUWvw9xv13/NSw=
X-Gm-Gg: AeBDies137qJYneY/3mFoZ2zIg3gpSqOGRNYSDtD9mOuaVGAM4KTSbhX3OAGJ3c42F5
 E+9pBjsejk5mZOdADRypo3ufBu+W1fxWBLvmAgQhBz2e+ydlxaq4tpJdxu5Q01kianTiAk5mRR8
 Uf/HcGyS4BOhtBNJISofBD9yngxked3fexLIBs1C7TBM5Os1cFwkqaXFU1JX6mMzYUgG9aASlCx
 UQZynwNawix3yV8MDc69taEyLnpuxtdm8owKrOf5t+I3F/4FYIb5riOvVx9XMH8ct6JgwFDVxZn
 qc0Zq428lT95D8Z/VUlOzFCkDblCiFRy/hcmK+sy4RjoDCdZiRD+pYR5A3/GGvq33awsFFMFv1/
 c0zDZMRRKl5f6iPyVwreR62zm39+vWq4iIYDlKTfrPRP6ktRVOqu8vXGjg6nH36Ubf0q/8jfwy9
 7A6bHoNwJjJ4RqxDa5VaY+CCiDX8uXPhOloTfhL2+p3SfA884jRyhezRU0ItBqKUxv5EsozJiRJ
 FUZ0++meCEuk0gAxrgWWA==
X-Received: by 2002:a05:622a:1f8f:b0:50d:9c60:fe2a with SMTP id
 d75a77b69052e-50e368209a9mr340791501cf.1.1776868319323; 
 Wed, 22 Apr 2026 07:31:59 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:59 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 11/16] board: k1: enable SPI NOR flash in SPL
Date: Wed, 22 Apr 2026 10:31:07 -0400
Message-Id: <20260422143112.1329478-12-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable SPI NOR flash in SPL stage.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 board/spacemit/k1/spl.c       | 24 +++++++++++++++++++++++-
 configs/spacemit_k1_defconfig | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 5af804f0409..77b6df1371b 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -20,6 +20,7 @@
 #include <spl.h>
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
+#include <spi_flash.h>
 
 #define MUX_MODE4		4
 #define EDGE_NONE		BIT(6)
@@ -309,6 +310,21 @@ void ddr_early_init(void)
 		log_info("DDR isn't invalid\n");
 }
 
+void nor_early_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SPI, 0, &dev);
+	if (ret)
+		panic("Fail to detect spi controller.\n");
+	udelay(10);
+	ret = uclass_get_device(UCLASS_SPI_FLASH, 0, &dev);
+	if (ret)
+		panic("Fail to detect spi nor flash.\n");
+	udelay(10);
+}
+
 void board_init_f(ulong dummy)
 {
 	u8 i2c_buf[I2C_BUF_SIZE];
@@ -335,13 +351,19 @@ void board_init_f(ulong dummy)
 	pmic_init();
 
 	ddr_early_init();
+	nor_early_init();
 }
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_NOR;
+	return BOOT_DEVICE_SPI;
 }
 
 void spl_board_init(void)
 {
 }
+
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+}
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 29a3c71f19e..97b6c8cbbb0 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -14,6 +14,7 @@ CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_STACK=0xc0840000
 CONFIG_SPL_SIZE_LIMIT=0x31000
 CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
 CONFIG_STACK_SIZE=0x100000
 CONFIG_SYS_BOOTM_LEN=0xa000000
@@ -29,7 +30,10 @@ CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
 CONFIG_HUSH_PARSER=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_OFFSET=0x60000
+CONFIG_ENV_SIZE=0x4000
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SPACEMIT_K1=y
 CONFIG_GPIO=y
@@ -65,6 +69,18 @@ CONFIG_DM_PMIC=y
 CONFIG_PMIC_SPACEMIT_P1=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_SPACEMIT_P1=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_FSL_QSPI=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_MEM=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
+CONFIG_CMD_SPI=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_LIB_RATIONAL=y
 CONFIG_SPL_DM_RESET=y
@@ -78,3 +94,9 @@ CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_DM_PMIC=y
 CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_SPI_FLASH_TINY=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
-- 
2.25.1

