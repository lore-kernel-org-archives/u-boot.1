Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF10CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6378B831D3;
	Mon, 25 Aug 2025 15:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="MVVU443b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A3BE83189; Mon, 25 Aug 2025 15:55:47 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B302682DA1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DC471C994B; Mon, 25 Aug 2025 15:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130145; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=AG1HBctgbI4JMWsPk43E850ScgDjcqGXwk3W4HymdWE=;
 b=MVVU443b13OJeN7N53NVNnjXFT3YkLddVsQTLpjiVeiwt2XShqarPGph6kxMZiRQdk3mGW
 L/maAgQNzeN/3b7b/Pb1EuQKDuamnlyjFBDK9HFU6RksSeSo1B4utPTM6vShrZxAmJQD31
 TWnEPy7cHZ4Dxn9F4O3dPsPEht01UT8E2o2NN5w7IpNSYDW2TNoa14/tS8I1Vz6CvahC3R
 okh4N5h4uoOthBHVqxxcoTuJ5JC4VsCx8/2spO3MprhF+ZlHwOv2bbOs518mRtnTknbrtU
 gW0lgD6XvAB1MvZxNWbqhAfNO0Ruj/8BW1OCmz+Z8v3TRq/0u4pYsBUbZNb8Dg==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Oualid Derouiche <oualid.derouiche@kontron.de>,
 Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 06/11] imx: kontron-sl-mx6ul: Enable redundant environment
Date: Mon, 25 Aug 2025 15:54:30 +0200
Message-ID: <20250825135504.193004-7-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Oualid Derouiche <oualid.derouiche@kontron.de>

This aligns the MTD partitions on the SPI NOR with the kernel
devicetree and enables the redundant environment.

Signed-off-by: Oualid Derouiche <oualid.derouiche@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 1831f99db46..a5ee4d67c00 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -7,9 +7,9 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=10000000
-CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0xF0000
-CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_MX6UL=y
 CONFIG_TARGET_KONTRON_MX6UL=y
 CONFIG_DM_GPIO=y
@@ -19,6 +19,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
 CONFIG_SF_DEFAULT_BUS=1
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0xF8000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_MEMTEST_START=0x80000000
@@ -56,7 +57,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FS_UUID=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nor0=spi1.0,spi-nand0=spi4.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=spi1.0:128k(spl),832k(u-boot),64k(env);spi4.0:-(UBI)"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=spi1.0:960k(u-boot),32k(env),32k(env_redundant);spi4.0:-(UBI)"
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
@@ -64,6 +65,7 @@ CONFIG_OF_LIST="imx6ul-kontron-bl imx6ull-kontron-bl"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth0"
 CONFIG_USE_HOSTNAME=y
-- 
2.50.1

