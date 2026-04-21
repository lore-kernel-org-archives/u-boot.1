Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD3EF8FA83
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B12839D5;
	Tue, 21 Apr 2026 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U1WBv4m0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A2E83BC8; Tue, 21 Apr 2026 16:12:04 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C0B83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488d2079582so50063095e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776780721; x=1777385521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YWCOHMxxNhU+2vgxppk+0kpXkwXjTnkxI6EBfbV5sEQ=;
 b=U1WBv4m0bUM0OOYoVT5NxNj2+fChXNZEe6laIJIxj9ytgN5Up86boVE/IO+N+YFFMP
 aKp65+wt6GrETrPUkSRxuqujfejBkgAATH7pCLTXZrz3t8ueDfJL+TtcNX2Hn5eicWPH
 mZZkTAMA1ER6I6iDjO4Npe7fau99CL9dD3y8/01fl+AtSRS7xBn83ti7RizfSBTAXqs5
 WsvURBqxFuoSvpgbFgdaBTHTEsKx+lI6g3tejZcWcBxyl3ysDcOWR0OrCh/e/N5Edhq7
 8wnj0t32pBsULN5F08urr/5xhWpN7yuIbBTUbpiIvvX6iNmgG/DGvoZ/g6aT6bNy+6CT
 1X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776780721; x=1777385521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWCOHMxxNhU+2vgxppk+0kpXkwXjTnkxI6EBfbV5sEQ=;
 b=d8maERh4sgoxCSqdgxz9IghXuhyoIg5pizaZLSDhxQ3iv89nvW37JTT8vzG9nmaEnv
 HKyHiDIjDPRjwnbm4Ni/lVX37HlMjYndrmc5TNoc7zRxO69vfhNmuAysAbWFt/tIjGe9
 kjgFRJrA5uD5po+K+we9SHbHXwibf5UVw8aAucb78XaBfSuqmOobRnL7ZSSbsAjrR0GM
 qgyD5vHtLeSAHAzoFK2tt/Rue4DAj/Bg5edQ/gzXc7s/Qi4n7Z0aKLPs/E6lPRrya7ZJ
 7AIzPfXXCgnLFzBAiZegARhm6ivrq/5yVJuAULZY+hhZk7vlgQRIrxXh83W6Chqo8l5u
 KwIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zrhtY578LqvuYNf3F0i9stDkm87YjYaRerliJLrN9ZHu5keZ9uq2ZUR286fJ45A8QSwvropM=@lists.denx.de
X-Gm-Message-State: AOJu0YzOO+x60isjd1x3XQWhF3U9M7OoX2NbeOv+rzsn20W+5bqSO4et
 nRvpXMn6HssOKSb3T0qRMzN4MZTu8a6eDlofLFkMkdlPmMt1uN2yDwsRT64szQ==
X-Gm-Gg: AeBDiesNlc/Gt7kSqdX1Ohr66Jc87t4b645cFX9/dVgJdvg9kaHe5cUCaQOpyHE7V6F
 imffKgBqddXJGgeqtNJxiSZXUTtlIl6nVYiYSjCgSc07ev1lpK7TPYk8ucyOVHhpYo1gL6k6T69
 w0ZfKV+EpjbNrHAhNYFJwnItOzQnd54gvm1bmBTvexPxLEd5LBSrbuPQyHq1FLlpmz+HBjA4p4g
 W/dnajua7NGEFxmi0Lsp5JQgc6K/mdsMDkfinC2szRxVtnmcFeb2EZaovAaZrJLqJ/fOVEVz8KR
 eXZAmvrOxn9FNZQfg3CF329Hs5e7RZ/ZJQesEn7CL+zu1ozSZQUsLtWYOqAvSwStuja/osQEkTx
 /rvgfmCDqhBh7X3J2Cf9s1YZlDyiXNQXQ0Oeck2y5Sl2mVSfcvb88LA6xgdM2ugxpHcH9HDfnBu
 Uy0cMXCXP5Oun8UkDx3kb2j8qolBhC+LqJR6112JTZxZ5yfxcChEYzUZSdSoQur7YOjYW8He/E6
 Iy0Dm7bBy3xHe0flEiTQQL8BdIcBk5ln5EJ5NpTrDN16abxvCTqSJPVDoxwNN1iaEmPsZw7SJSD
 PfYTWhnrjsNZEl4w1D7/EnU97PJdtTdId9YfDhaz3rF1zNF3IkUSKUOtwz5O6iQ9sQmd+luavZK
 7XlmuK+M/mXgEVnJoXA46pHsifegxxf0D
X-Received: by 2002:a05:600c:c177:b0:488:a82f:bba9 with SMTP id
 5b1f17b1804b1-488fb7804f3mr247744255e9.22.1776780720393; 
 Tue, 21 Apr 2026 07:12:00 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm181160215e9.2.2026.04.21.07.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 07:11:59 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] rpi_arm64: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS
Date: Tue, 21 Apr 2026 15:11:38 +0100
Message-ID: <20260421141156.359690-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Enable LWIP and HTTPS on the Raspberry Pi arm64 platform to be able to
use it in the boot process.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 configs/rpi_arm64_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 69e8e72c5d7..90048a418f6 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -11,6 +11,7 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_PCI=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_HTTP_BOOT=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_FDT_SIMPLEFB=y
@@ -26,11 +27,13 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
+CONFIG_WGET_HTTPS=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_TFTP_TSIZE=y
+CONFIG_NET_LWIP=y
 CONFIG_DM_DMA=y
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
@@ -64,4 +67,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_BCM2835=y
 CONFIG_CONSOLE_SCROLL_LINES=10
 CONFIG_PHYS_TO_BUS=y
+CONFIG_MBEDTLS_LIB=y
 # CONFIG_HEXDUMP is not set
-- 
2.53.0

