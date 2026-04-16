Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF6DF8A16B
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 12:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642ED8425F;
	Thu, 16 Apr 2026 14:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="w0Cr5fL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5248407E; Thu, 16 Apr 2026 14:14:48 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B93958420C
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1776341683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GN0YY1zIk2xCe+Q1XOi1pIyXW75GgcaevTodl0LLZx8=;
 b=w0Cr5fL4tPPsBwtf+R8wFhfCs+bwfhwEXimO0bAKg4D3lookVki4Wjvs8rFbSRtiIri/Uc
 n0rmP+1ADUq+IzZANp5eDByqL7AYtccY9bRRlhKdtiFP1EA9U0cOlt3+xWm6UxUeM6NGfb
 Byyg7mkh7/sOvqO3bV9c+pN0mGZTrpg=
Received: from archlinux (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 5e7d0b2c
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 16 Apr 2026 12:14:43 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, u-boot@lists.denx.de, sjg@chromium.org,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 5/9] configs: stmark2: add support for mmc
Date: Thu, 16 Apr 2026 14:14:27 +0200
Message-ID: <20260416121431.20852-5-angelo@kernel-space.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416121431.20852-1-angelo@kernel-space.org>
References: <20260416121431.20852-1-angelo@kernel-space.org>
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

Add support for mmc.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 configs/stmark2_defconfig | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/configs/stmark2_defconfig b/configs/stmark2_defconfig
index ae1fa34df2a..763cbac158d 100644
--- a/configs/stmark2_defconfig
+++ b/configs/stmark2_defconfig
@@ -3,19 +3,19 @@ CONFIG_TEXT_BASE=0x47E00000
 CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SF_DEFAULT_SPEED=50000000
 CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x40000
+CONFIG_ENV_OFFSET=0x80000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DEFAULT_DEVICE_TREE="stmark2"
-CONFIG_SYS_MONITOR_LEN=262144
-CONFIG_SYS_LOAD_ADDR=0x40010000
+CONFIG_SYS_MONITOR_LEN=327680
+CONFIG_SYS_LOAD_ADDR=0x42000000
 CONFIG_TARGET_STMARK2=y
 CONFIG_SYS_BARGSIZE=256
 CONFIG_SYS_MONITOR_BASE=0x47E00400
 CONFIG_TIMESTAMP=y
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 rw rootfstype=ramfs rdinit=/bin/init devtmpfs.mount=1"
+CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 rw rootfstype=ramfs rdinit=/sbin/init devtmpfs.mount=1"
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="sf probe 0:1 50000000; sf read ${loadaddr} 0x100000 ${kern_size}; bootm ${loadaddr}"
+CONFIG_BOOTCOMMAND="run boot_sd; bootm ${loadaddr} ${loadaddr_ramfs}"
 CONFIG_SYS_PBSIZE=283
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_SYS_MALLOC_BOOTPARAMS=y
@@ -34,6 +34,12 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi-flash.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=spi-flash.0:1m(u-boot),7m(kernel),-(rootfs)"
+CONFIG_CMD_MMC=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_DOS_PARTITION=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_CS=1
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -43,6 +49,8 @@ CONFIG_NO_NET=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_FSL=y
 CONFIG_MTD=y
+CONFIG_MMC=y
+CONFIG_FSL_ESDHC_IMX=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MTD=y
-- 
2.53.0

