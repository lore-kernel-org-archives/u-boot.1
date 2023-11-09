Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EE8C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 16:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D37C8729D;
	Thu,  9 Nov 2023 17:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYLMZMue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B078743A; Thu,  9 Nov 2023 17:25:20 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29FFE8729D
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 17:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso1110276b3a.3
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 08:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699547114; x=1700151914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SwiD+dT2AY6oir3NrJ8XGmeyWByb9bIyg6navP73io=;
 b=LYLMZMuecJEG6S10HNEgz3UeVTobI3XK4gBpstwz4SHH3a3WpoUESd04gJFEia2f4T
 2ZXGwK4d6ZD+aAWERP/gHVXyEaqFQqBpSX7C1hKi5kDqbg/U18hS9N5v+qCuDW1j/ayy
 22T8IBcji/T5DcA7ftLeOr5b/4aS0pkXtJs2LhPLgrR/bZdv8QYIKKVr2wFoPSR++moN
 Aq4LspNBq513y4ZVx/01VTf/iyk28Bhdjde7WWWf5O9zVXSn8JX7EywATQNedRnsYJxX
 e0GRwar0GC/xiEWCOWdS0Cl2/TGcr+lDiSr9Z0D1YggxCycsIGZ4g9OwwO0xx3eMrUCd
 r84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699547114; x=1700151914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SwiD+dT2AY6oir3NrJ8XGmeyWByb9bIyg6navP73io=;
 b=dKB8LtAHKg+cXv4iYmVS5sHslyPoobFFUUyRUVhJJmLc8g08nxsI4yMvdxBuulMjpk
 iK0mZRN4wZQSseiV/0FXtBEvb4Y855wHQKA46oanWd4jvwy173L5wNm/AkHGcP93Lp4f
 taKe+HSA6erWBHQwcUNi7vPvo4RJPFitwqTOMfdeecHfLB1TlUDcPS4TXMvdKKK5QLCa
 r+2b36nERdZuqIUosUA17aiQYzBtUf9zlZf8hA7iYH3B/g8YdEUaexCj0ohSE6+p2dBr
 yCK7VcQpydkJCuXqcZF2R/JE3EA7Wk4u+voj8Cc/Gcw6odDnEg/UbYfBe1PbdzN0VrA7
 h6Iw==
X-Gm-Message-State: AOJu0YyEePdBfhDk0NkvTdr0QBuec518xjOfy20/GC149rPO9bCwZDpf
 YGdhyTXteS2n7svJJzB0WlBUGoaD8conDA==
X-Google-Smtp-Source: AGHT+IHJkJtvrmClBtQrIzeJX00lCzy2x6KWrfAp1Q67FKFC0jO81eMwWpeGPepIeco4QXJ78GwObg==
X-Received: by 2002:a05:6a00:2d8e:b0:690:ce36:8b00 with SMTP id
 fb14-20020a056a002d8e00b00690ce368b00mr5516221pfb.2.1699547114362; 
 Thu, 09 Nov 2023 08:25:14 -0800 (PST)
Received: from debianfranco.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056a0015ce00b006c345e192cfsm10908304pfu.119.2023.11.09.08.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 08:25:14 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
X-Google-Original-From: Hiago De Franco <hiago.franco@toradex.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: u-boot@lists.denx.de,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH 1/2] apalis/colibri imx6/imx6ull/imx7: defconfig: Enable
 fastboot support
Date: Thu,  9 Nov 2023 13:24:00 -0300
Message-ID: <20231109162401.38941-2-hiago.franco@toradex.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109162401.38941-1-hiago.franco@toradex.com>
References: <20231109162401.38941-1-hiago.franco@toradex.com>
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

Add fastboot support for Apalis iMX6, Colibri iMX6, Colibri iMX6ULL and
Colibri iMX7 boards. Remove CONFIG_FASTBOOT_BUF_SIZE from
colibri_imx7_emmc_defconfig to get the default value of 0x7000000 instead
of 0x10000000, to make it consistent with the other boards.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 configs/apalis_imx6_defconfig          | 3 +++
 configs/colibri-imx6ull-emmc_defconfig | 3 +++
 configs/colibri-imx6ull_defconfig      | 3 +++
 configs/colibri_imx6_defconfig         | 3 +++
 configs/colibri_imx7_defconfig         | 3 +++
 configs/colibri_imx7_emmc_defconfig    | 4 ++--
 6 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index aa9cf77960..570ade5119 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -87,6 +87,9 @@ CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x14420000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index 2fead59f5f..20cba723ee 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -64,6 +64,9 @@ CONFIG_SERVERIP="192.168.10.1"
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x81100000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index 5164374c67..d904621f5e 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -75,6 +75,9 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x81100000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 51f3eeca75..cd68264eca 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -85,6 +85,9 @@ CONFIG_SERVERIP="192.168.10.1"
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x14420000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index eba2b41c84..e24a606bc4 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -72,6 +72,9 @@ CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_DFU_NAND=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x81100000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index 49a51e9272..687dbb5e3e 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -62,9 +62,9 @@ CONFIG_SERVERIP="192.168.10.1"
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x82000000
-CONFIG_FASTBOOT_BUF_SIZE=0x10000000
+CONFIG_FASTBOOT_BUF_ADDR=0x81100000
 CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_DM_I2C=y
-- 
2.42.0

