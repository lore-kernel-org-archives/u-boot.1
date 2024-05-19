Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63925C25B78
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 15:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67593882D4;
	Sun, 19 May 2024 17:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aau8K9Az";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA197882D7; Sun, 19 May 2024 17:08:10 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53594882C4
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 17:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1eb24e3a2d9so60792575ad.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716131286; x=1716736086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzgYrvF2o2PobO/GbQ+h2g5c+eS/FXRqmwe8ZqTc0xU=;
 b=aau8K9AzKDz1F4Nfs2bCLtSCGl+TP8dNONd896JQ6+MK0uK/0iCuUfobYHP3AESpbS
 A1hQ5KOcyb7ZJ6ay/8u7EZlrfaEXtKy/UqwQHAZzZMOMGb+AxQIMFQj5GmaTsq/FeFIu
 BEDrWVmVnW7wTvqCTtt/DctfZHYYE1mZ1Cou/8FUNCxoN74/5ZIi7w3dAWVVD/WDgYrQ
 H/GQAJFP2w8JN5j/9w4++K2VS3+tY58xodpgS2xrpCPaALF3v3fNoNeabws1wxiyGunm
 43hN07XAwbpWxz02FX9qnlIP3HCHKqBwiqV1zVoxvzTAVzaF1XGt66eKgYyi6MdzIZrK
 XWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716131286; x=1716736086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XzgYrvF2o2PobO/GbQ+h2g5c+eS/FXRqmwe8ZqTc0xU=;
 b=IW5bn448Mxndlf3hqpPXrP0wu0VmJUodrZ2Gnrh4H3QM5BoSn0Sk53r3mZcp0Iizr0
 zgv4RVGiu5LXlljEAdJILHTxNdDa5DQ8zlBlojQ5C6CUpBNVI9+JAGHbMzukx63n6X8m
 WLuktKe6MMrSK7MTZCRRx/ERvO/Lh3O+ii98KHOHGK6rjuI1ZX6flXxzLGxH5uVnkFzZ
 oDwSFvJbIBqZpta47apLgQea7rKoNO1NHrb2qyk4BZr3lGNVCUIqZu+0a81QX2xQFAVs
 J4+KFXAfNkLY61O4fUEm4b2tG9LqCcVlQ1JMPj3hnnBOfVHoY34id20GrF1G2FmbbkKg
 o3vA==
X-Gm-Message-State: AOJu0YyC6HotzuiqWjsiWTCnF01VbDtiJvuqDyKtJ6pYUiMKtGUD12LF
 h2ditzsSWd/2+QxbXke/GhUpfXQisArNTV35MbYqsEb3yDSofaw99mPC7ffp6gM=
X-Google-Smtp-Source: AGHT+IHGzu8dNVFFuSme79nnFZpR57yX9KgFK0t1uDjdN2AikblRSPFHCnRCfAvuRciiJZdaRP7BHg==
X-Received: by 2002:a05:6a00:ccc:b0:6ea:f351:1df9 with SMTP id
 d2e1a72fcca58-6f4e03485a5mr42614353b3a.23.1716131286027; 
 Sun, 19 May 2024 08:08:06 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2b3493asm17692711b3a.191.2024.05.19.08.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 08:08:05 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] configs: milkv_duo: Enable clock controller
Date: Sun, 19 May 2024 23:07:09 +0800
Message-ID: <20240519150736.13203-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240519150736.13203-1-seashell11234455@gmail.com>
References: <20240519150736.13203-1-seashell11234455@gmail.com>
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

Add configs to enable clock controller for Sophgo Milk-V Duo board

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 configs/milkv_duo_defconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 0cb2922de4..1186763a73 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -1,6 +1,6 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x820000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
@@ -26,17 +26,18 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_SOPHGO_CV1800B=y
 CONFIG_MMC=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_CV1800B=y
-CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI=y
 CONFIG_CV1800B_SPIF=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
-- 
2.41.0

