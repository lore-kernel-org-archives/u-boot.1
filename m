Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F48FF885C
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 13:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F0484099;
	Sun, 26 Apr 2026 15:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="NZPvjFdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C8183FF5; Sun, 26 Apr 2026 15:57:23 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2B8839D9
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 15:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b150559bso74346825e9.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1777211840; x=1777816640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4VsADveJjOQcTmy5iIfpAgbtyJbbH5WTr7xU4sgdqE4=;
 b=NZPvjFdwm0zPIIpFQBzpMyOHl7NmiqTgz9FTqtv4i+Y1TUu9B6QusBLv6JIzOGabL7
 HvgXIesjEJiV1Un46yUsVGe8Bqx9TwElAUAEPxE8IjXn2RNO7snYzS1g2mBnz6UP5A0z
 rUgYD8HAABDSMztgPrv4kfxJZQsjYtBjET+A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211840; x=1777816640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VsADveJjOQcTmy5iIfpAgbtyJbbH5WTr7xU4sgdqE4=;
 b=Hu2DzymP420PVEFqtnE68quy7pSx57pP7GB+qN6Ol/k5MAHe1w0Ji0pziGWT4sFbRM
 Ifju3/f2Vwfv7d3ZZSxzJjc+0sjgJ6wPJgNWN0nMVZ9K6WJSiA8SyMeZHCrkTdAaH9c1
 FnIC0ybIIjeZDT8EnZLdGJLAo7NvP1hiH0y4TKyTZ+K4HJK+uRdbeKO7Prc7tX66k50k
 4FU5xXfAeIsBct11l3c4G+ccSihxsRZ3cBgkoJHWvWW+ujiD5WtD8zDVyJyRh3BddPO7
 LCFVdiBY5DHzjNemFFcTxRtc1sqJHXW/eAYEViNVcHNgHHlAi4+Z7FArzhiX+ZUA8OjJ
 /1Kw==
X-Gm-Message-State: AOJu0YzVgPUju2Deen6BhVkg6YPaCVSS+0+FUiAfVe3F//xFqps9Mjul
 NOpXI5GiHN0zJzqTZ+T8eukPO5CJZ5yVIdvHK5KbhtMM5mPKxwgxxWc7wOjhSYpdOMUqVdRsHan
 eIObRTNQ=
X-Gm-Gg: AeBDiesbN59kal4TB5pybrr4omMGoAow3kkWtJ69XATGtJSy+xA7mXXZkwLqj781ekS
 fPUm4xYCsU5RMHKgZMDqIB2/AiXQ9vE0zUumIyxRcbGOVQsIX+/k9LYrWZnfl9O+s731EN5J/68
 azVTPzoGNa+U5hJK1lkDLi6ACpjfeL6YSYiKXE1Np8f/PgqRwjhCs8POK/EK/wDMry05hzqJb8q
 VL3+Nt64W2jFMOCy84DDwYAtYOfxgeLQ3ZaxLaXyyJE8pTUY9FMnOCd8iqIiP1wKiqJVHmt44Kn
 WynNMVWY2s+ugNPJ2FoEo4V6hWYNysUKl6bw8kpXWt0NaF5WJAbV/M7ck7K+VDLkq0aWPbed2Qo
 yoi6ASlaZ9C97uWPU5LddQzA7kHqKiXPzgeqVMz0jK7/JGiG5rp30ZU3GswYG1NaSZyTkC95DpW
 zo8Wi5AaJ8jTzPC6VIea9+TtcjucmK5ff0xw88XVxrUum5Cwb2oLg4uMQU1z7XePAjlwpRZJ7wq
 cs3+3SjWRi73VGeQ5O+5+1fFgLTnki6OOcx
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-488fb78ea6fmr572186655e9.29.1777211839753; 
 Sun, 26 Apr 2026 06:57:19 -0700 (PDT)
Received: from P-NTS-Evian.home
 (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr.
 [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a682588f8sm119035785e9.10.2026.04.26.06.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:57:19 -0700 (PDT)
From: Romain Naour <romain.naour@smile.fr>
To: u-boot@lists.denx.de
Cc: nm@ti.com, robertcnelson@gmail.com, Romain Naour <romain.naour@smile.fr>
Subject: [PATCH 1/2] configs/j721e_{beaglebone64,
 evm}_defconfig: reduce fastboot buffer
Date: Sun, 26 Apr 2026 15:57:14 +0200
Message-ID: <20260426135715.1395250-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.52.0
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

Using Snagboot's Snagflash tool to flash the SD card using
fastboot-uboot mode on SK-TDA4VM crash u-boot.

Flashing an image.wic.xz file generated by Yocto doesn't work as
expected:

2026-04-25 16:46:21,134 [INFO] flashed 267296768/267296768 bytes
2026-04-25 16:46:21,162 [INFO] Flashing sparse range 10/13
2026-04-25 16:46:21,163 [INFO] Flashing to MMC device...

On the the chunk is bigger that previous one and doesn't fit in the RAM
memory mapping set by the SoC (TDA4VM)

downloading of 267296768 bytes finished
MMC write: dev # 1, block # 2101440, count 522064 ... 522064 blocks written: OK
switch to partitions #0, OK
mmc1 is current device
Starting download of 486944768 bytes

"Synchronous Abort" handler, esr 0x96000046, far 0x9e800000
Indeed, this memory address (0x9e800000) is "reserved"

"bdinfo" allows to notice that 0x9e800000 address is actually
"reserved":

  memory.count = 0x2
  memory[0]      [0x80000000-0xffffffff], 0x80000000 bytes, flags: none
  memory[1]      [0x880000000-0x8ffffffff], 0x80000000 bytes, flags: none
  reserved.count = 0x4
  reserved[0]    [0x9e800000-0xa8ffffff], 0xa800000 bytes, flags: no-map
  reserved[1]    [0xaa000000-0xabbfffff], 0x1c00000 bytes, flags: no-map
  reserved[2]    [0xfce40b30-0xffffffff], 0x31bf4d0 bytes, flags: no-overwrite
  reserved[3]    [0x8ffff7000-0x8ffffffff], 0x9000 bytes, flags: no-notify, no-overwrite

CONFIG_FASTBOOT_BUF_SIZE was initialy set to 0x2F000000 in the u-boot
configuration for the SK-TDA4VM.

With SYS_LOAD_ADDR set to 0x82000000, the end of the fastboot buffer is
at 0xB1000000 and overlap the reserved region[0] and region[1].

In order to avoid writing the first reserved address (0x9e800000) we
have to reduce CONFIG_FASTBOOT_BUF_SIZE to 0x1c800000.

On this platfrom 0x9e800000 is reserved since it's used for optee
(K3_OPTEE_LOAD_ADDR).

(Issue initially reported on Snagboot)
[1] https://github.com/bootlin/snagboot/issues/90

Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 configs/j721e_beagleboneai64_a72_defconfig | 2 +-
 configs/j721e_evm_a72_defconfig            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index dc76504eb83..abb53687ed6 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -97,7 +97,7 @@ CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
-CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
+CONFIG_FASTBOOT_BUF_SIZE=0x1c800000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index ed94fff0885..dac1c5ec82f 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -104,7 +104,7 @@ CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
-CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
+CONFIG_FASTBOOT_BUF_SIZE=0x1c800000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
-- 
2.52.0

