Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599FBE65D0B
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6553C896FE;
	Fri, 22 Nov 2024 01:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NTySI31E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982DA896F0; Fri, 22 Nov 2024 01:31:20 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119C789773
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20e576dbc42so16735255ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235476; x=1732840276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaLrSavaYl8x4K2vRZDnFlgZRxNOHePekr2C2LqT7Mg=;
 b=NTySI31EHMOqGSchSyy4RyV7hbhKFPxiuT6S5Ln3jutQDvI4VXISi39g9q8vJa6bim
 yJaGz6vpfuWuGCwhrp8ayJkmKsuiaanIvLgpfGDa42pnxDc5l0XPw9BXqQZSNlU4++5c
 C74J8gSjEHWWjxMzhTLeqo5RxWlevX7kYUmv0SIoNtCtWS7HDGGDS1eMenBR+X02ZTb+
 Bix9mjoeEpTIK7I2k4FpvqfUVF9YubL0S2A2nttYZnX/2B5rO5A/ctfrb45P/22IguDk
 hWZP1kbE0f0Vl7tELjcVdkupbutrecAJwtMwonE3LLEjDjaHuHHcbbnW1uKBsz6bxjxn
 3pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235476; x=1732840276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaLrSavaYl8x4K2vRZDnFlgZRxNOHePekr2C2LqT7Mg=;
 b=u5dzpNonXyA8e7HppYgyIdyS2a/k5tLEn/GJ/vLlJK3hM++fXMGO2if7b8ridPOwZr
 dvRzWde0z1zHOHDejdidlK4uTtfJQHdhdqT34VypdDriqnPLCOaOSM9bacYYaD+Itz/e
 9sujI8IGDdTkPAQwdCnwLYyuBuZp97i4zt4Ande59hsW0e5i+ZF/knl6DV6fHKLMiAN2
 WV/TgtL/VCUu5Un7YzUZA3JyYjvd24tmPfyokYhhmjIR7+ARUSmx7QN52oAGeJwgBTkV
 S+/34OABjxFCyUMqJjvLCqejX1T89I9QoXgK3U7Pizs91/Z/LITvChfPRyVOocDbtGNC
 5wXQ==
X-Gm-Message-State: AOJu0Yx/73UNZ3iyPJvJYq8bIYgfpcvVYPzlvZqyoB5xGHTNBM3doJON
 1G8VysjQFGPvPg6RFvbJQ+VWOxW3xF7/KvFSrBU6FySmRxH4qhTD0md+SnJQ
X-Gm-Gg: ASbGncvuatXWv9L4c8Hmn5tGUjNqyhPeKRmgtJBMkfejI1nqx6VEQlxRAIsk84mfjPp
 eapvVnP57Qx7/vAhI/Ip55D+nC0cteS9FYjwMOi42sOVsA8op09JQcG3cA3amz4U7yEHDC/jBbz
 i9Dvh+788MMRT6iZoCdL+iCZLJIxXd7wxmTM/MAAMrRH5XjgXsWHWBVBXbXhgHBFYj0dsdYCyO9
 biyTWa4hnzyMhcbpNGX5nv9omsTKjZ7B1lGaNWjL4lMmETyA2WasKNL/Ko0uVqA
X-Google-Smtp-Source: AGHT+IHo7jEN0llAyJNQHI4j1b8xOmKM214RGFxFzkYpCrrK+pO/RS2JN9Gjm/QC3q8TgmVtWhrSVw==
X-Received: by 2002:a17:902:d4c6:b0:20e:a2f7:8ab9 with SMTP id
 d9443c01a7336-2129f6ac33amr12140485ad.27.1732235476506; 
 Thu, 21 Nov 2024 16:31:16 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:db1b:7332:ce96:46a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc225d5sm4181075ad.258.2024.11.21.16.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 16:31:16 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/7] arm: mvebu: x240: Switch to standard boot
Date: Fri, 22 Nov 2024 13:30:16 +1300
Message-ID: <20241122003058.270163-3-judge.packham@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122003058.270163-1-judge.packham@gmail.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
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

Use standard boot instead of the distro boot scripts. Regenerate the
board defconfig now that some options are selected automatically.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---

 arch/arm/mach-mvebu/Kconfig | 1 +
 configs/x240_defconfig      | 6 ------
 include/configs/x240.h      | 9 ++-------
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index b422bb09e023..adb816982f87 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -224,6 +224,7 @@ config TARGET_X250
 config TARGET_X240
 	bool "Support Allied Telesis x240"
 	select ALLEYCAT_5
+	imply BOOTSTD_DEFAULTS
 
 config TARGET_DB_XC3_24G4XG
 	bool "Support DB-XC3-24G4XG"
diff --git a/configs/x240_defconfig b/configs/x240_defconfig
index f930d28de2dd..4fca1096e740 100644
--- a/configs/x240_defconfig
+++ b/configs/x240_defconfig
@@ -27,14 +27,9 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_EXT4=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_CLK=y
@@ -74,7 +69,6 @@ CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_STORAGE=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_ASIX88179=y
diff --git a/include/configs/x240.h b/include/configs/x240.h
index bc66e4e3c8e6..05241f33d74f 100644
--- a/include/configs/x240.h
+++ b/include/configs/x240.h
@@ -12,18 +12,13 @@
 #define CFG_SYS_SDRAM_BASE   0x200000000
 
 /* Default Env vars */
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(USB, usb, 0) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
+#define BOOT_TARGETS "usb dhcp"
 
 #define CFG_EXTRA_ENV_SETTINGS   \
-	BOOTENV \
 	"kernel_addr_r=0x202000000\0" \
 	"fdt_addr_r=0x201000000\0"    \
 	"ramdisk_addr_r=0x206000000\0"    \
+	"boot_targets=" BOOT_TARGETS "\0" \
 	"fdtfile=marvell/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0"
 
 /*
-- 
2.47.0

