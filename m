Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32882C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 08:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4AB3871DE;
	Tue, 14 Nov 2023 09:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OkwtOQZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46224871A0; Tue, 14 Nov 2023 09:52:22 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331D987243
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 09:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b6ce6fac81so2308128b6e.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699951938; x=1700556738; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eu3vTnjC4w52ZOymYuf+NV5PPXRgDYxdfMnZXHpvsTU=;
 b=OkwtOQZcabdUEBzaB32adbvgyoLUuSQ/UNANeyo8Xa4Q+udN9D0f+c8Kkd87A1vwiy
 5IyW4r0UK+cxLBtUqsFE0orqa119a1vy/Yeqd+vB7ns6YFHeWC9+iyEwv0pwc3fm55u9
 PjTEf7xJvoQPMLU8U+Cx8Lr3ALF1c9UM9NyOA3NTOYVLwjO3pj9Ulm8TbtqHnyQKJXzR
 ha0bIGkBySuztOYrEf27NO+pT/FGOoCeOCZwzFuXnuh0yCmnkQn/jprUAcsns6x01A/o
 yEiXdHMpQ1/0xUaqWmzoUdlk4Or7Al7kmBVq6WgVYlVIo9W7fi83DDQiYMp5JUeTbqE6
 J5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699951938; x=1700556738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eu3vTnjC4w52ZOymYuf+NV5PPXRgDYxdfMnZXHpvsTU=;
 b=h51cKTOhrmk3F/3jx6NJICemp2U/aEHf3w3dwawQ9fbE5q+kT9nP6VgE+ukx28FymA
 QehZS169RgsiOQLIFY+GwDFtNHvfjLN1TWC/X6otho7rHtE9QfogBeEe1hg7B1BKXnal
 y26onCJb6/kqvK2rjr2Uh2dRklbUoEU+4btJxQx3Na9hoHl4kpYN9nyB8k/E/tdiwn6X
 Gv50+p+lR+zdxCgn/xgkHYgDHOTQW5xOQq+1vq6Jrw8FgZKTwAKBaO/3ntJEEBQsB0c2
 RlrXmGGaCKbhhs97N38lbtmWq5QcSGZeWCQ/dlzUppE9sPVn9G4hXtc5F4tj1CjMDhW0
 t/zA==
X-Gm-Message-State: AOJu0Yyf3BxruWBb//aH9jkyDzA3SjdFdUisHE/+P91O0rjyd4/cNwUs
 vol79dfTrDrywVUOG1tRB1w=
X-Google-Smtp-Source: AGHT+IGP0IIPIWsDG3NtGzZxI/e/k39xU3YKPH4KjhcN1+TzWSK582Q+KHmnAVv4+vN9GvuS2+tTZw==
X-Received: by 2002:a05:6870:4709:b0:1ea:1510:d8e0 with SMTP id
 b9-20020a056870470900b001ea1510d8e0mr10864044oaq.36.1699951938546; 
 Tue, 14 Nov 2023 00:52:18 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.145.22])
 by smtp.gmail.com with ESMTPSA id
 fh23-20020a056a00391700b006be0bd6a4d8sm778696pfb.36.2023.11.14.00.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 00:52:18 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/4] configs: arbel: Enable full functions
Date: Tue, 14 Nov 2023 16:51:57 +0800
Message-Id: <20231114085159.3739887-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
References: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
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
Changes for v2:
   --- no change
---
 configs/arbel_evb_defconfig | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 6cfb5a7d32..e2714d1e1a 100644
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
@@ -31,6 +35,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -39,6 +44,7 @@ CONFIG_CMD_RNG=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_HASH=y
 CONFIG_CMD_TPM=y
+CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -49,6 +55,7 @@ CONFIG_NPCM_AES=y
 CONFIG_NPCM_SHA=y
 CONFIG_NPCM_GPIO=y
 CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_NPCM=y
 # CONFIG_INPUT is not set
 CONFIG_MISC=y
 CONFIG_NPCM_HOST=y
@@ -87,12 +94,17 @@ CONFIG_TPM2_FTPM_TEE=y
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
 # CONFIG_EFI_LOADER is not set
+CONFIG_SYS_SKIP_UART_INIT=y
-- 
2.25.1

