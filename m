Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB536C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D95885BC;
	Mon, 10 Jun 2024 15:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="d0wO/PrD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA6688546; Mon, 10 Jun 2024 15:34:15 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6B888551
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026451; x=1720618451;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rPQXGJ0pmEr83JwLtJ2OtR+1MToqh6o3vcAmll6QtSY=;
 b=d0wO/PrDYjXhdNUx5wvukuFOiLS9rz3omVDFDt80haYv1W//RpU/xKkt0SlwXJqa
 vBQ4dwpe6sjOIhWIfqEoKtFWdEfPjWpQOHuJsIs0xki+Lis+N2JW0YlVHSrApunj
 LwCzZZj74aRQm+q3zUzK9VvvntsmAlfORs8/WSHADwY=;
X-AuditID: ac14000a-03251700000021bc-ee-666700d33d50
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 68.7D.08636.3D007666;
 Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:10 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 10/13] configs: phycore_am6xx: Update MTD & SPI configs
Date: Mon, 10 Jun 2024 15:33:49 +0200
Message-ID: <20240610133352.2473414-11-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWyRpKBR/cyQ3qaQe9+ZosPjZvZLKZO2sxu
 8XZvJ7vFu779TBbd79QdWD1eHVjF7nH2zg5Gj/7uFlaPPxffsQawRHHZpKTmZJalFunbJXBl
 nH12mK3gr1jFtaVnGBsYd4t0MXJySAiYSCz73c/WxcjFISSwhEli56WdjBDOY0aJ341PmECq
 2ATUJe5s+MYKYosIBEn0XvrECGIzC3hIbP27ASwuLOAu8X/3YjCbRUBVou31HOYuRg4OXgEr
 iRtNPBDL5CVmXvrODmJzAoV/rNkLVi4kYCmx6NMaFhCbV0BQ4uTMJywQ4+UlmrfOZoawJSQO
 vnjBDFEvL/Hi0nIWmJnTzr1mhrBDJbZ+2c40gVFoFpJRs5CMmoVk1AJG5lWMQrmZydmpRZnZ
 egUZlSWpyXopqZsYQQEvwsC1g7FvjschRiYOxkOMEhzMSiK8QhnJaUK8KYmVValF+fFFpTmp
 xYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoYubevDdynHn124p677/wznzzi48pM
 bfK2bWW24Sj7U77rtVnp74KSxQt9YrQq9/Hzff50pKj543ylpo0G6RY37gR8q6ll9U2eoxen
 8VCccQPfzptKTfsi38Y+6Vtu+HVr3Mqpzws/KW9u3PH8dHC0cE/hyub7k/QjS9cq3Fy22fWB
 2SMOD/FLSizFGYmGWsxFxYkA2ZFB42YCAAA=
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

Enable mtd command and remove SPI NOR flashes we do not
populate on our SoMs.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 4 ++--
 configs/phycore_am62x_r5_defconfig  | 1 -
 configs/phycore_am64x_a53_defconfig | 4 ++--
 configs/phycore_am64x_r5_defconfig  | 1 -
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 5fe2c9d4422..95a48aa246b 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -63,6 +63,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
@@ -106,10 +107,9 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
diff --git a/configs/phycore_am62x_r5_defconfig b/configs/phycore_am62x_r5_defconfig
index 0062a4e3569..12ba4c06d1e 100644
--- a/configs/phycore_am62x_r5_defconfig
+++ b/configs/phycore_am62x_r5_defconfig
@@ -106,7 +106,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
-CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PINCTRL=y
diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index e94d829fd8f..cf04e145372 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -69,6 +69,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_TIME=y
 CONFIG_OF_CONTROL=y
@@ -120,10 +121,9 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
diff --git a/configs/phycore_am64x_r5_defconfig b/configs/phycore_am64x_r5_defconfig
index 15a7e7089e7..a0d78241928 100644
--- a/configs/phycore_am64x_r5_defconfig
+++ b/configs/phycore_am64x_r5_defconfig
@@ -121,7 +121,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 # CONFIG_SPI_FLASH_SMART_HWCAPS is not set
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
-CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_PHY_TI_DP83867=y
-- 
2.34.1

