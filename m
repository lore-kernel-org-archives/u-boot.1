Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABCCCE8D4D
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E55C8420C;
	Fri, 14 Nov 2025 17:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qVmkdUeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79768420C; Fri, 14 Nov 2025 17:29:51 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE4E983EDF
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from rpi5.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DC7FF408A5; 
 Fri, 14 Nov 2025 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763137779;
 bh=kmfu6tSaJp4mEYeMgbPNTz2vtoOQBqk6vsyGVbyG/0E=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qVmkdUegJlv/hDr/2idb4RNaTqxXIleHr3xZo7rDrYFdYqoZHBXnMj1iCQjhfcEkL
 J8Z/8bH/wIMpYRvN6c4fRCDU38lxe0yIpwE/w+m5u8+h9WyghhANcId1wiQIuv7HYr
 IXLkgEeo4MEXGQoiuvkIwy1IYA8UZy5LCcFTrp54vS8ranylGHUk1Y5uslbd5FU3pn
 /gmuZrKJc9sa08IOe1qFAtaQTqLuUVI1L7LISO6vZk2tsMPBp4ekYc0U/uij5wg8q3
 2w59RFRznekoKpl2q91FVLfTk2fcLpQ2FRzvbW4ApPBMf5rnEyrGhVT0EhHt/R3GAL
 ZCCN3yCI8AMUZFlLv0OUukEwQSPbaDgOYAP2ynl07yw+jg+uebkX5dBCOI82+qyERt
 NogjvXv2CWQ+mtSpih9M7mYKbHG8syVkrSUDq9KojxN/yFltr5J+8w8cPdjWVioqZO
 gT3GgpswPFBoMsTa+CLlq5IrGbVHzT1eoEc9bst5xeZGkCO1m36WC2bru8zrDGExVD
 3gBOTjfH/AWdszmRBMYwJazdvMXpHQSEUonTIbUEmPYCbyWzmzHTNO5iNyq1M+zVSX
 EJJ1zdJfpuq8nFwxOkvyVUm9SBxE1BXBmliKpnEKcYvfp9xU1BydufaZa2yeItp88t
 8aqujhXIdWTw4mgazj1t6fdo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chen-Yu Tsai <wens@csie.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: enable PREBOOT, CMD_ENV_ERASE on Rock Pi 4A
Date: Fri, 14 Nov 2025 17:28:59 +0100
Message-ID: <20251114162859.152980-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Without pre-boot command usb start it is not possible to stop the boot
process via the USB keyboard.

CMD_ERASEENV allows to easily reset the environment to the initial state.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/rock-pi-4-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 219f42bc7d4..6cf80e7fa5e 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -22,6 +22,7 @@ CONFIG_AHCI=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
@@ -31,6 +32,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_ERASEENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
-- 
2.43.0

