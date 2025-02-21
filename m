Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB00C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C632380EC0;
	Fri, 21 Feb 2025 18:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740157712;
	bh=Mp3PAOLmQMqVtWzPssduVOOuys9zkw1xSfOdyXF6cr0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cug7VML80fo1AqljBl11U/lFfg9uUkDysQksRFZ3TnJNe4de12Pvc13x4wXG1qGg1
	 +RJ0qZ3LUrmyRnPgSyAQmR7dF6usjXXSgkBWUO2U5msT8wEbrR5aHDIqOtmOBYrkwR
	 W26irENqM+JBTioVEVHXeTp+tykNVSPDaBxBPCjJG2NUU5OtMH+EQgoJM5mOnhU1tj
	 AJPLTSRPgYdEkEV1i5uHC1njD+UTo9qCHLR2NwYNtCk/zOGHFZnBKQa33M1vX0zfae
	 ggap2wUN1DRGzXuAMuetrDHEIrdo2iybvkXE2JR93pckKAReeMyEgTfC3EOHsJlp3s
	 DnymDIMFMBAdA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AFF80F56; Fri, 21 Feb 2025 18:08:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F48806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CUT5zwdB"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 251F510382D37; Fri, 21 Feb 2025 18:08:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740157709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Mp3PAOLmQMqVtWzPssduVOOuys9zkw1xSfOdyXF6cr0=;
 b=CUT5zwdBpxRfwOakS6MJCgb73pMY81TS7udkpShXol6bZJpmpQFtC8Wh8e3TV/YvArqdoB
 LQh9pu4Iqy+YYBTVA7eEZMKs0ptPG5azdzmeIU03nuXmTlnUb07I0BwomZsLrMMPGB97cj
 c87B1ARkvr93fxKfEqpxYbSnLSEjMAt3dfAYeZVQpdlw73+YZXSwuh4STpR3QTv3EOyp3i
 7AhUAOC0xvZMN+Nkhjfn5qQ6vFVyyZcNWj1Ma4akFY4Pkv9ssJBhCSthLuTX6FBPW/pdLH
 qSgI7fRWO228Ly1Z+NDgDWNzlkoCwbTU9m/Rmpdo/ONGEtLKJL+jmXPzGp405Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD duplication on DH
 i.MX8MP DHCOM
Date: Fri, 21 Feb 2025 18:08:01 +0100
Message-ID: <20250221170818.184853-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
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

Deduplicate the config files again, move CONFIG_BOOTCOUNT_ALTBOOTCMD
into common imx8mp_dhsom.config .

Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 configs/imx8mp_dhcom_drc02_defconfig   | 1 -
 configs/imx8mp_dhcom_pdk2_defconfig    | 1 -
 configs/imx8mp_dhcom_pdk3_defconfig    | 1 -
 configs/imx8mp_dhcom_picoitx_defconfig | 1 -
 configs/imx8mp_dhsom.config            | 1 +
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/configs/imx8mp_dhcom_drc02_defconfig b/configs/imx8mp_dhcom_drc02_defconfig
index dccf5ffc1e6..c43839cecf5 100644
--- a/configs/imx8mp_dhcom_drc02_defconfig
+++ b/configs/imx8mp_dhcom_drc02_defconfig
@@ -5,4 +5,3 @@ CONFIG_ARCH_IMX8M=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-drc02"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-drc02.dtb"
 CONFIG_PREBOOT=""
-CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index 4f50806573b..aae2e210f44 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -7,4 +7,3 @@ CONFIG_DEFAULT_FDT_FILE="freescale/imx8mp-dhcom-pdk2.dtb"
 CONFIG_PREBOOT=""
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS=y
-CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index d505ddfd09d..f40bf269d97 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -14,4 +14,3 @@ CONFIG_PCIE_DW_IMX=y
 CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
-CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
diff --git a/configs/imx8mp_dhcom_picoitx_defconfig b/configs/imx8mp_dhcom_picoitx_defconfig
index d98ca9e434f..99cd5f279dc 100644
--- a/configs/imx8mp_dhcom_picoitx_defconfig
+++ b/configs/imx8mp_dhcom_picoitx_defconfig
@@ -5,4 +5,3 @@ CONFIG_ARCH_IMX8M=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-picoitx"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-picoitx.dtb"
 CONFIG_PREBOOT=""
-CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
diff --git a/configs/imx8mp_dhsom.config b/configs/imx8mp_dhsom.config
index 416143178c8..7adbb9a84de 100644
--- a/configs/imx8mp_dhsom.config
+++ b/configs/imx8mp_dhsom.config
@@ -70,6 +70,7 @@ CONFIG_NXP_FSPI=y
 CONFIG_SF_DEFAULT_SPEED=50000000
 # CONFIG_SPI_FLASH_UNLOCK_ALL is not set
 
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C40000
 
-- 
2.47.2

