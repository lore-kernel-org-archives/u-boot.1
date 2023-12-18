Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B4FC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 09:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D85F87DDF;
	Mon, 18 Dec 2023 10:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="O18Clulz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7249787DC5; Mon, 18 Dec 2023 10:00:14 +0100 (CET)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 792D187C82
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20231218090009794cf81b8967cc75d4 for <u-boot@lists.denx.de>;
 Mon, 18 Dec 2023 10:00:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OM8ASD0YeFdXScCtkpLRVgkFNHbCz9dvMyNjNd4ulA8=;
 b=O18Clulzd+Mg6uH0e6GV6QmKF248CL2nwRefEv4AzbKITg0R/O5q2yLBsA1c6BEhBu9klt
 OOtO9hEVuJhe0Ap7vjaWBaXe9BTrw8e04kK/DmyWTEYkTkAf7qc258yfqb0qQEsIjFe6iWpv
 3wI2Lb+xQsiWr658OrPsG6+t7Ycpo=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 3/6] siemens draco: i2c: use driver model for u-boot
Date: Mon, 18 Dec 2023 09:59:12 +0100
Message-Id: <20231218085915.3739975-4-enrico.leto@siemens.com>
In-Reply-To: <20231218085915.3739975-1-enrico.leto@siemens.com>
References: <20231218085915.3739975-1-enrico.leto@siemens.com>
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
index ef7c7c1a549..9e25a7048e8 100644
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
index b293ed5ef70..1a7cf8257b9 100644
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
index 6c03732d4a9..3c7facfbacd 100644
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

