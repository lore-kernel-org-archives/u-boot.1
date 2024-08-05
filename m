Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E8EC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8750888975;
	Mon,  5 Aug 2024 15:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nYs0dNBl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7512888F6; Mon,  5 Aug 2024 14:43:41 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93109888D7
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 14:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b796667348so47169766d6.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722861817; x=1723466617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCEv4QbvIhAYTYl2QKKcipo/TOJRbHhY/FhAtveaZdg=;
 b=nYs0dNBlN+Znm+bV94D5dqxM4sckk8KxPBVDWYg0qD8IjEeA6VS8etPWNZ00opFEDs
 sniZb9JRY5dk7u1LVF3I6BEJxD9+loqdE77Ou163uxrP4WvHSqoEreI5Wte0bfC0wb5Q
 q8RW+CNmL+VY4F3Df8WLWFYLycFv/xdHNgUXmviARQDTxd+5iz3FvjIJcLJTsJDkvoQQ
 1SpLPTr/0l4ufMTsFQHvOCy+r/D3U2bdc9+NwzYgNqy9eNfjOE8z4fZmlIPBGgM9yYip
 wN+QYNf1njYFChyYAvQYyJJZQ9N0VgvO2XPPSli/8JxvUPsSNJoYz/BgxzzlpLAAB4Rp
 n6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722861817; x=1723466617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCEv4QbvIhAYTYl2QKKcipo/TOJRbHhY/FhAtveaZdg=;
 b=CuspFgo2vbZWNG4mSrwMWuHWetyLLOuvCrboYyW2mfvEbMc3uF5HNtwAd8+ErHSvDx
 opeY4BBD+ihPN9xDOb9gdsXTDTuCA8jwPracjVvO4aG/E0d11I9kI/EQOPQUBgC+r88v
 OY+ZyUvQvw/xXxf3drrptZ1cJILKsWYAgBqlWtcSNjfqnY7Fjt/sx/MRMcB6KqweVSf5
 Gragh3XMquBk9wXlKuJrolosMQKDhyyJ6zptlJk6RI5HMk1QcYWxomgDeON8+ZGm/oqe
 4WpxkRjNcnsuo/GxzRUCUBfXlEhLMa7TlQjqU1FXqV+Z354FHP1Z/ygdOoPE7+RgoBM9
 LBkQ==
X-Gm-Message-State: AOJu0Yw3DVLqt4fZDjKGuMgjRfxWBUXsPzfSQIB3RY52W90bMoXdRSM0
 whkmKhLWu5s2dqZwch8xUXsDyg7eRUFJQCCphFn0/JKdH5wVquAZd+tFRA==
X-Google-Smtp-Source: AGHT+IEV8I6LyCGeOX0LQ/1aJMxp+5vyLTlIxBSmQRBfymnrx7i/DYVO5BIJlh4WqaaRNqzRniTvIg==
X-Received: by 2002:a05:6214:33c5:b0:6bb:8b2e:8e7a with SMTP id
 6a1803df08f44-6bb987af505mr194394126d6.24.1722861817347; 
 Mon, 05 Aug 2024 05:43:37 -0700 (PDT)
Received: from p1g2.lan (128-78-204-97.abo.bbox.fr. [128.78.204.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb9c87bb90sm34984796d6.130.2024.08.05.05.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 05:43:37 -0700 (PDT)
From: Gary Bisson <bisson.gary@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH 5/5] imx8ulp_evk: enable binman support
Date: Mon,  5 Aug 2024 14:43:26 +0200
Message-ID: <20240805124326.544310-6-bisson.gary@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805124326.544310-1-bisson.gary@gmail.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Aug 2024 15:54:59 +0200
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

Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
---
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi | 2 ++
 arch/arm/mach-imx/imx8ulp/Kconfig    | 1 +
 configs/imx8ulp_evk_defconfig        | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 608bde3a2a3..f67fe166d31 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2021 NXP
  */
 
+#include "imx8ulp-u-boot.dtsi"
+
 / {
 	mu@27020000 {
 		compatible = "fsl,imx8ulp-mu";
diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ulp/Kconfig
index 49ea25250a3..6ce6039faf9 100644
--- a/arch/arm/mach-imx/imx8ulp/Kconfig
+++ b/arch/arm/mach-imx/imx8ulp/Kconfig
@@ -23,6 +23,7 @@ choice
 
 config TARGET_IMX8ULP_EVK
 	bool "imx8ulp_evk"
+        select BINMAN
 	select IMX8ULP
 	select SUPPORT_SPL
 	select IMX8ULP_DRAM
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index b302df1f351..0f0748b6792 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -8,7 +8,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x400000
-CONFIG_IMX_CONFIG=""
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx8ulp/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8ulp-evk"
 CONFIG_SPL_TEXT_BASE=0x22020000
@@ -38,6 +38,7 @@ CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx8ulp/container.cfg"
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-- 
2.43.0

