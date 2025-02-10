Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F7CC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 01:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A93880548;
	Mon, 10 Feb 2025 02:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739151218;
	bh=WOJ7xW+QPNopnoExbXEMVQoomaCIQ1SCrYOkZiDddwE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qtpib4sQTG/CC/w3mBGqlUF3YeZixBMPYtlO7ui2/HWSXRvu7xREcKCxh5wr2VLTN
	 Y0QFJB4+heoPNJ39r36wYZ6HehKXafc+YwECzTvpbG1QbLa8U+8ujra9qxQ34n1Am8
	 vWfZ+4vljLU6P+oGRPxh98iDyqUQf+DJaJHN/PI2UYHc5JNQcMSNGw2Vz7iSdteDJY
	 BvEYh8poMXht8vz6u8gCtCxYGNEHyDSd086wuUekVaTw/CRkp68273KbizqMwFT7ps
	 hW4hGEdUD03MqQ8cA8sXhzgzXdfSyFQhcGeKk2TKMKfy+FkoBhJqZf3JkuwfVCZpsE
	 lzS3HhAV0uHiQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439CD807FE; Mon, 10 Feb 2025 02:33:37 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 106FD803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 02:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Fxg53b5p"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C613010382C23; Mon, 10 Feb 2025 02:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739151213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WOJ7xW+QPNopnoExbXEMVQoomaCIQ1SCrYOkZiDddwE=;
 b=Fxg53b5phda4+2VnF9hYLZPwSX+BvNEVBCyI4FprBejCz7uodP194UcJBqrNXsWDiEyVzE
 NDgigBr9m6VXDBfheTUqZ1v9K33U2dmWie0p3JlSdNPVIzgoxiYBI39PpwQrFslE9j1RYI
 IugbASOhQaWQTG3oUAfVe11CZ2RO9XTjiT4z+8fDwZwqlto318EnKZ6orbBlkgU+ya6Wx1
 45Mh47HplH1FyE/+8XBD+cZgW36vj/3gV9b04zgYDBGfqGGTggzucEe7Vrer6v2Qwrk+qU
 cjg847BM5+IOWas6SPLlWWJDYIRpcgxjcFCAFqFAR5el2QtlYX4Uuf8XrjPq/w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Add support for environment in eMMC on
 STM32MP13xx DHCOR SoM
Date: Mon, 10 Feb 2025 02:32:29 +0100
Message-ID: <20250210013322.350477-1-marex@denx.de>
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

Enable support for environment in eMMC on STM32MP13xx DHCOR SoM,
in addition to existing support for environment in SPI NOR. The
environment size is the same, except in case the environment is
placed in eMMC, it is stored at the end of eMMC BOOT partitions
in the last 32 sectors of each eMMC HW BOOT partition.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi | 2 ++
 configs/stm32mp13_dhcor_defconfig          | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi b/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
index 9233f315ebc..3acf5138940 100644
--- a/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi
@@ -14,6 +14,8 @@
 	config {
 		dh,ddr3-coding-gpios = <&gpiod 5 0>, <&gpiod 9 0>;
 		dh,som-coding-gpios = <&gpioa 13 0>, <&gpioi 1 0>;
+		u-boot,mmc-env-offset = <0x3fc000>;
+		u-boot,mmc-env-offset-redundant = <0x3fc000>;
 	};
 };
 
diff --git a/configs/stm32mp13_dhcor_defconfig b/configs/stm32mp13_dhcor_defconfig
index ff948b904be..2da9287ea7b 100644
--- a/configs/stm32mp13_dhcor_defconfig
+++ b/configs/stm32mp13_dhcor_defconfig
@@ -28,10 +28,14 @@ CONFIG_CMD_RNG=y
 CONFIG_CMD_LOG=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_MMC_USE_DT=y
 CONFIG_ENV_SPI_MAX_HZ=50000000
 CONFIG_CLK_SCMI=y
 CONFIG_SET_DFU_ALT_INFO=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SYS_MMC_ENV_DEV=0
+CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_PHY_REALTEK=y
 CONFIG_DM_REGULATOR_SCMI=y
 CONFIG_RESET_SCMI=y
-- 
2.47.2

