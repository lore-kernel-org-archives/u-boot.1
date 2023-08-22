Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7002EE49A6
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 01:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B4C871C3;
	Tue, 22 Aug 2023 03:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qjJwQe3a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lNBgtJQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DED486997; Tue, 22 Aug 2023 03:48:15 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F46871D1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 03:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RVC0r3LS2z9sTs;
 Tue, 22 Aug 2023 03:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692668892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WKzv2UcP2/NK74W4c0TT3CYpIbV2JFvsTIdj7lNgSn4=;
 b=qjJwQe3aePGmaU85B3nyQ9EKjFC0yyURuuog9YK2hbzMSphO5g3X7kNxa3Rw1cLUCwNwwi
 6Pta0G/XJHRJ4OBy0/LRpApJekhrcch2flxcmm4YaLBmRwipqwJ/etFGKzN0DVPZMjQJU+
 u6BvgNyZynb2+MTny7XS0QalfEaHMi/3CKvGLk3WzWJl9zWX6yE6Lz5+D/jRRCetKeEuHD
 Q65ydaXIofENEWaPtYl7bbOsIw8BGrRTG0k3dD+Kyo+0YzZ6MMYZwnPbWA7uWsrKlLfszP
 c4+y9YXD1b1J1REHR0yCp6MAS3Tvl0sP4V2I2qIHuHPkLskGU/1AsKBtP2lzFg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692668890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WKzv2UcP2/NK74W4c0TT3CYpIbV2JFvsTIdj7lNgSn4=;
 b=lNBgtJQo+kwxxjnQtWlI0t6/hqzkV+hYDBbTi9HQ6bucWwiTfk6vijnk0f0iAi93y1LykZ
 ZkUlOACawF0eOgk14ajk5eF6uJucMn3oRC0t9V1Q60F2A5QvqXSnHcruw0vZtEoiOXS2X6
 cHJRAw3tBNUz2flWsRK9TZB35WEPkCzqCQn+UyVsetHirrDMiEw+/qJmezsommRqUywYtm
 y5kGINUIKGfF7Ef1gxAWDDE1hJ4zS0KHIRC1pKOIHyKY4luhWl46cnJJLjutxTwLFPuRjE
 +6cPUlmpYVASD6CN63QtnZN0x18PnvEmvBKqEbfdSEP9L5+qjECLnFF5kr9MWg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH] ARM: renesas: Enable UFS on R8A779F0 S4 Spider
Date: Tue, 22 Aug 2023 03:47:56 +0200
Message-Id: <20230822014756.138165-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cf06d56668afef116f1
X-MBO-RS-META: iyzme7art5pn7nxro69gmfzrkik9in11
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

Enable UFS controller driver and matching UFS and SCSI commands. The
former is used to initialize the device, the later is used to perform
low level access to the SCSI interface of the UFS device.

Enable R8A779F0 S4 Spider specific dependencies, the PCA953x driver
and GPIO clock gate driver. This setup is used to toggle 38.4 MHz
clock for the UFS controller.

Enable support for 48bit LBA in block layer to address disks larger
than 512*2^32 ~= 144 PiB. Enable use of 64bit LBA variables in the
rest of U-Boot, instead of the default 32bit ones.

Increase FAT cluster size to 128k as that is what is used by the
filesystem that is populated on the UFS device.

Use 'ufs init && scsi scan' to start the UFS device from U-Boot prompt.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Faiz Abbas <faiz_abbas@ti.com>
---
 configs/r8a779f0_spider_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
index 0edacc4d569..f250d1a13c1 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -31,7 +31,9 @@ CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_UFS=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -46,9 +48,13 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
 CONFIG_CLK=y
+CONFIG_CLK_GPIO=y
 CONFIG_CLK_RENESAS=y
 CONFIG_RCAR_GPIO=y
+CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_RCAR_I2C=y
 CONFIG_MMC_IO_VOLTAGE=y
@@ -67,8 +73,13 @@ CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SCSI=y
+CONFIG_DM_SCSI=y
 CONFIG_BAUDRATE=1843200
 CONFIG_SCIF_CONSOLE=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_RENESAS_RPC_SPI=y
+CONFIG_UFS=y
+CONFIG_UFS_RENESAS=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=131072
-- 
2.40.1

