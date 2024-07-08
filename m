Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5644BC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 619BB88780;
	Mon,  8 Jul 2024 14:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iqil3xjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A008869E; Mon,  8 Jul 2024 09:52:39 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06839886B3
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 09:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-kochidanadu@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4687qLVl002515;
 Mon, 8 Jul 2024 02:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720425141;
 bh=CsebzAqkOsgibd1/gPdKa2Hd4DUv5ChspT92weyteRY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iqil3xjBL+AkCLDEFUsdmQL8G0J+T6w/Z/N6EPdNR7CcOT0U93cmR0NHem3HaO8D1
 Px6TjjaV3ViUGHIxsnAHUtCXmOlHojhmH46XV8m83Xw6YRzxedMlbdzUnEQNYbGNfF
 LG4z8YZ6R7IGbAfJKoMdAAcfKHL2riQnZIsROgIM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4687qL3Q041432
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jul 2024 02:52:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 02:52:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 02:52:20 -0500
Received: from localhost (scaria-hp-zbook-15-g5.dhcp.ti.com [172.24.31.134])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4687qJbD116056;
 Mon, 8 Jul 2024 02:52:20 -0500
From: Scaria Kochidanadu <s-kochidanadu@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <mkorpershoek@baylibre.com>,
 <abdellatif.elkhlifi@arm.com>, <sumit.garg@linaro.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <semen.protsenko@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <nathan.morrison@timesys.com>, <s-kochidanadu@ti.com>,
 <devarsht@ti.com>, <j-luthra@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <nm@ti.com>, <khasim@ti.com>, <rogerq@kernel.org>,
 <francesco.dolcini@toradex.com>, <afd@ti.com>, <jan.kiszka@siemens.com>
Subject: [PATCH 5/6] configs: am62x_evm_a53_defconfig: Enable sound and I2C
 commands
Date: Mon, 8 Jul 2024 13:22:06 +0530
Message-ID: <20240708075207.37207-6-s-kochidanadu@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708075207.37207-1-s-kochidanadu@ti.com>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 08 Jul 2024 14:24:51 +0200
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

Add the tlv320aic3106 codec and sound driver in the defconfig, and
enable the sound commands in Uboot. Also enable the I2C communication
for transfer to and from the codec.

Signed-off-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
---
 configs/am62x_evm_a53_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 6c708dcb05..858946d7fc 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -51,8 +51,10 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_SOUND=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
@@ -71,6 +73,8 @@ CONFIG_CLK_TI_SCI=y
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -100,6 +104,11 @@ CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
 CONFIG_DM_SERIAL=y
+CONFIG_SOUND=y
+CONFIG_I2S=y
+CONFIG_SOUND_RT5677=y
+CONFIG_I2S_TI=y
+CONFIG_SOUND_TLV320AIC3106=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_DEVICE_TI_K3=y
 CONFIG_SOC_TI=y
-- 
2.34.1

