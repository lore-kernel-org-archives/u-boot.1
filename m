Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8333EC49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD4388CC0;
	Sat,  3 Aug 2024 18:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701717;
	bh=YRwAJ6GTsFhcKCCcvo18xDOdXWiWDI4mzjNRsALZCKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eXfN9RTHWUiL67ksPLnDFtfK26gt19kOf4jQGHLVlNwsVNNEsnYchcpkTsk/DK2im
	 qV2qS/PDI7Jx7UdnpnteJAEzr0n4swx2gA4KB8NmJwNwgiASzLGR7kdxMw5X3ANv15
	 j0VITSrzqYwAgOkrF5Q3gW1oFZ0XAqJx27VMxQGqAM/Q81YWP/Lkma0m0uNsvihAQI
	 KTqD9sL5JswwsmYVMeiVoi5nDXqCJOLY67ABWkPSgPsSgPP+QoOKhRPd+md3YNvOHq
	 WGBNSCPP/KmfnZdkGHP652TfeYelP/vzhGLAVBacwATj3M0Pddt14fM6YwfGnQBYhY
	 Kcuq6yetgYmoQ==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AC87288C8C;
 Sat,  3 Aug 2024 18:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701714;
 bh=YRwAJ6GTsFhcKCCcvo18xDOdXWiWDI4mzjNRsALZCKI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UP2sRJ5sn2PJAUrQdsHRYH+9ttDlejGjWmiV2Vkj/hdINWceJ8Fi3zhcUvGHHWXrN
 bfeRsikkPGnRhJRUsfX56uhOGq1IbnNakxd02npA8RryYkoOZ8vyHKi1bHWJagrwDd
 QvqrP7q6cSuqBBz25qzJs9oQylAADa1HqHiHhBYHat1JH131dMvWsnNfXXqNqg9fFk
 EkVK00VZLwy1T2BNH12JiwQpGmaa3PsRgSKFZlOaP+ibGHoRjQeon3LCMRluSp0Vl/
 crwwkDr0uXyjWHZCJJIpbhAa5o8jqFHTmzLtCsRevlRkKh3jrJzEvAD2nYG3X9EjH3
 XslhPABOZjXHA==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Nikita Kiryanov <nikita@compulab.co.il>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/11] board: cm-t43: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:05 +0200
Message-Id: <20240803161513.486062-3-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
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

Conversion to DM_I2C is mandatory, enable DM_I2C
to disable board removal warning.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Cc: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tom Rini <trini@konsulko.com>
---
 board/compulab/cm_t43/cm_t43.c | 2 --
 configs/cm_t43_defconfig       | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/compulab/cm_t43/cm_t43.c b/board/compulab/cm_t43/cm_t43.c
index 181581926c..983991ea46 100644
--- a/board/compulab/cm_t43/cm_t43.c
+++ b/board/compulab/cm_t43/cm_t43.c
@@ -48,8 +48,6 @@ int board_init(void)
 	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
 	gpmc_init();
 	set_i2c_pin_mux();
-	i2c_init(CONFIG_SYS_I2C_SPEED, CONFIG_SYS_I2C_SLAVE);
-	i2c_probe(TPS65218_CHIP_PM);
 
 	return 0;
 }
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index 32f126a517..1c9ae335e9 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -38,6 +38,7 @@ CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x480
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
+# CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_MTD=y
 # CONFIG_SPL_NAND_SUPPORT is not set
 CONFIG_SPL_NAND_DRIVERS=y
@@ -72,7 +73,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_HSMMC2_8BIT=y
-- 
2.25.1

