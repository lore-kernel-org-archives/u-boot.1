Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B420CC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 10:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1ADC878F4;
	Mon, 22 Jan 2024 11:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="nqwqSWjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E73E58793F; Mon, 22 Jan 2024 11:52:46 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE64B878E5
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 11:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202401221052431808a315b472fca8ef for <u-boot@lists.denx.de>;
 Mon, 22 Jan 2024 11:52:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fYxdB6k5CwnFUWr/txVt0KG4W/dKGZtnB+cB7P4cJHM=;
 b=nqwqSWjyzM7Qbe9WbSzcVdJlXlmBL9sQ3tGnxvWsdeWZ0+faiMpZ1RJBDpRyCGtS6r+KpC
 wBzXZ8041cnOTAEuIDDuj9z95b5g9/TbWWRajR788/NVSmrIzK31E4ksyrGh1ifGi9/WrJu0
 KSvPR3ZgjcB6gYaWP5txpceIiDHb0=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de,
	alexander.sverdlin@siemens.com
Cc: trini@konsulko.com,
	Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH v5 3/7] siemens draco: i2c: use driver model for u-boot
Date: Mon, 22 Jan 2024 11:52:33 +0100
Message-Id: <20240122105237.939823-4-enrico.leto@siemens.com>
In-Reply-To: <20240122105237.939823-1-enrico.leto@siemens.com>
References: <20240122105237.939823-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
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

Add support for driver model where EEPROM data are read in draco board.

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 configs/draco-etamin_defconfig   | 4 +++-
 configs/draco-rastaban_defconfig | 4 +++-
 configs/draco-thuban_defconfig   | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index a89494f9083..ec9331e625a 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -86,8 +86,10 @@ CONFIG_CLK=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+# CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 # CONFIG_SPL_DM_MMC is not set
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index f4a9b860bf0..03fbe494901 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -84,8 +84,10 @@ CONFIG_CLK=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+# CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index cf2c46b3d20..fcc9b0380f4 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -84,8 +84,10 @@ CONFIG_CLK=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
+# CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
-- 
2.30.2

