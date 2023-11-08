Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9E8C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:41:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D7C87701;
	Wed,  8 Nov 2023 01:41:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hat4h3fw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BBC87701; Wed,  8 Nov 2023 01:40:58 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47983876FE
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2802e5ae23bso5909834a91.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 16:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699404052; x=1700008852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIqc+LtJR8XSFza8jLL4TdU2jq6br49gv+0zSST3qgw=;
 b=hat4h3fwhrD3tfaP/a+qyH/7Eeb2lh2rTV4oaiplVkOoETmac4Dxpuf0N3/YR/T/C/
 QrMYFMweUxIRC0+7ToRJ0lYUqd7YDrGRe43S6xgyKgPKlI+a9eek4MCjXD4djMjvLRPW
 4nPtrbYOWG9RLNB//TM1gNJT6qeztQjzfPVVtHvdCJPv09Lfs4sfwTZ4O62DZPBb26Cr
 uSvFMBkkDM8+p+46A2iUUHKi2cg4ZorDS9wi1ndkIQ81qW2sle6FRqDykmQmQwlv9YOj
 cWlXMWBLRGKmK+4IKN4qslSYtmVRDJl9C3XaDmQt8gFxA1aM+EoeF/lfBKSh4itzooYN
 EwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699404052; x=1700008852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIqc+LtJR8XSFza8jLL4TdU2jq6br49gv+0zSST3qgw=;
 b=PnVTbfAZH6c0W9Bqv2uSbs05NZ5vmmpAwPY9qOmz8hhWPoh3q+W1ubOJGw0bYU65nu
 An5E5zkcVMeIqF8c92VIJjEIxSqbuRTAsEshvn13bRlBTrx/nB8e7nIQ50/fgKyKS4HZ
 1zycP7wF0EAkpqRM0x4C6JjiJx84ZWX00wqv6jzGinqvm1Wfa/r3JTV65j44OGKlVT9D
 7vYJLE+0329Izh0yPxa3TyWw36aaRKvpbtsL5wrrD7ML6e0iOVegcOq9INJW2x/XaTFX
 NL0q0/TRBCyM5zRlwuL277l1EIoM6SPNwXoHJWWpA98n3/flGcmmS/w24x6jYVfjznfX
 LrBw==
X-Gm-Message-State: AOJu0YwSqleZYiszO3yaXjnzkq7Wxo1SMOOOvPBx4GSFlrHWGoK6JbX6
 Q+TvUWgyyWFd9ekqeVnjGpo=
X-Google-Smtp-Source: AGHT+IEBPQSSYr/35CBkeAUqTWIlFqgUHtlbj1DMHZdAERpAZjEDLin2I3IjcATnqRmp6WK7eD/8Sw==
X-Received: by 2002:a17:90b:1bd0:b0:281:858:a086 with SMTP id
 oa16-20020a17090b1bd000b002810858a086mr384753pjb.6.1699404052076; 
 Tue, 07 Nov 2023 16:40:52 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.132.54])
 by smtp.gmail.com with ESMTPSA id
 mv21-20020a17090b199500b0028066f3c373sm384284pjb.17.2023.11.07.16.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 16:40:51 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com--compose, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/4] configs: arbel: Enable full functions
Date: Wed,  8 Nov 2023 08:40:26 +0800
Message-Id: <20231108004027.281383-4-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108004027.281383-1-JJLIU0@nuvoton.com>
References: <20231108004027.281383-1-JJLIU0@nuvoton.com>
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

Enable more functions/commands for arbel evb.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 configs/arbel_evb_defconfig | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 6cfb5a7d32..dddfa298c9 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -4,6 +4,8 @@ CONFIG_TEXT_BASE=0x06208000
 CONFIG_SYS_MALLOC_LEN=0x240000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x06208000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_ENV_SECT_SIZE=0x1000
@@ -19,10 +21,12 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run common_bootargs; run romboot"
+CONFIG_LAST_STAGE_INIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="U-Boot>"
 CONFIG_SYS_MAXARGS=32
 CONFIG_SYS_BOOTM_LEN=0x1400000
+CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -31,14 +35,17 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_UUID=y
+CONFIG_CMD_AES=y
 CONFIG_CMD_HASH=y
 CONFIG_CMD_TPM=y
+CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -49,6 +56,7 @@ CONFIG_NPCM_AES=y
 CONFIG_NPCM_SHA=y
 CONFIG_NPCM_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_NPCM=y
 # CONFIG_INPUT is not set
 CONFIG_MISC=y
 CONFIG_NPCM_HOST=y
@@ -56,9 +64,12 @@ CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_NPCM=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_GOOGLE=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_BITBANGMII=y
+CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_BROADCOM=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
@@ -87,11 +98,15 @@ CONFIG_TPM2_FTPM_TEE=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_NPCM=y
-CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_OHCI_NPCM=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Nuvoton"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0416
+CONFIG_USB_GADGET_PRODUCT_NUM=0xffff
+CONFIG_CI_UDC=y
+CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_LIB_HW_RAND=y
 CONFIG_TPM=y
 CONFIG_SHA_HW_ACCEL=y
-- 
2.25.1

