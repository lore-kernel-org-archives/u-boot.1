Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C741C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7BD81B5C;
	Thu,  6 Mar 2025 17:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SmrKHT43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437D281CC5; Thu,  6 Mar 2025 17:05:51 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A10881B5C
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d2b6ed8128so6773665ab.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277147; x=1741881947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=SmrKHT43rJ4NrPG4xFHowKWOPIRZnTBIdmPxXDQ3tt/SbHqs/6A0UzHRnR+XSxPCNC
 IGnKofD9YyL9IYHHfrHKSXbetPtWGbK23RP1ustihBtsYiVWsEDk/jtYDfyReT97KBeq
 o7mFKyIN1bE4OCHRlfKSfjjsM40KQZYYb39Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277147; x=1741881947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBw5RnVhttKdF2Qo8bwI9+KLvnZSt3HCKA4Su8eQKxU=;
 b=dGPBAbVRNk7GZrPQDO1dvEetzR/MqARHwyvIJZN6X1M2KfiKtvYRhVcx+gmP2G3WGn
 S00tTtGcE5ajRrHzaRDb95pW5fhxg6jyHs5xa/7iMVs8sx+PR1KZSvDclIA6aW4M+/LJ
 hHe5/z0QGhs4Ym98ADREMBxMs4h+XYbHMhkztGhYKLth8cqfMEpxKolQNavNHVZHqWYD
 RJqNcnG+kmDnMkpIS7hFjrc8AtZtQTMw/LKwe//amSDyYf46CtKooG7DLp+0LeUX9gpq
 /yfv5H6Q5yKqVn7a2630m9qm07CNyN6sas/6/Mufl1WXCz/HVR7glls+JtOuvPx/asP2
 f9HA==
X-Gm-Message-State: AOJu0Yy+Cr8RhMZ0TuIt1b/nm4FsZ72YJRhVzGSggnEZey3sGw0ND18J
 FnZPKQMEhtCYkcACHQujsgAlV6+psyhAARTw9WyD9GzE75rX12WGfFcVJiSKaG7LLcQB7hvmKlY
 =
X-Gm-Gg: ASbGnctb+ZeRw0urxEDM4L52i6t+E5slRMi/8IOGgTJNRLzymu0ADh0Uq6XbmcFvPxN
 /b7NDoGJvzfjW+384UEeBkYw+NmGKF18dF0xBMXSAq3DQANxJ/Wy2xgLlkkhsZIGAvQEybf4xXW
 pe2a9bJM7uNC36GP/OkfdLBQI4Op8Zd/2VvbeUFqu5Lw/PrKNPlrDn3d4moAnHf2bS7krauCM/+
 1wiIlpVxwMB+YEWnLJxignI0Za9GnJb2ADrUNyJfQ4lqa3DyY9CH4UdVUD+TW40phwrnq9V2YF8
 vFXP6u0pXJ1pW5Wbp/1aCuTl/tStjxJBL8hCSl8loQyAE/0uejaGi8JoYz2/RKWrcl65438uzB8
 jcgvLoA==
X-Google-Smtp-Source: AGHT+IHuglgVnFtzfUwfDuVTzdXWjTh0CPnqHoatBlkZzeNQ3VGOrkEnP75Ie1cpdQ24+4tOGWjSXw==
X-Received: by 2002:a05:6e02:4602:b0:3d4:2a80:74fb with SMTP id
 e9e14a558f8ab-3d436aa13abmr45343645ab.3.1741277147086; 
 Thu, 06 Mar 2025 08:05:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 28/47] x86: qemu: Support environment and cat command
Date: Thu,  6 Mar 2025 09:03:55 -0700
Message-ID: <20250306160428.3041057-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

Add support for an environment stored in the first partition of the
disk, which is assumed to hold a FAT filesystem.

Support the 'cat' command as it is useful for looking at extlinux.conf
files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 6 ++++--
 configs/qemu-x86_defconfig    | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 84b7dc8e99f..ae34cc2a6f8 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -41,9 +41,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_CPU=y
-CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_NET=y
 CONFIG_SPL_PCI=y
 CONFIG_SPL_PCH=y
 CONFIG_SPL_RTC=y
@@ -54,6 +52,7 @@ CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_CAT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -61,6 +60,9 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_INTERFACE="virtio"
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index d52afa42955..7afa3827e61 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -34,6 +34,7 @@ CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_CAT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -42,6 +43,9 @@ CONFIG_CMD_BOOTSTAGE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MAC_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_INTERFACE="virtio"
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-- 
2.43.0

