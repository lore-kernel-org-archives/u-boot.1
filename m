Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D39CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9727C84C95;
	Fri,  8 May 2026 13:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Mo56pQAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C9A84C19; Fri,  8 May 2026 13:53:32 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A7F84C78
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/LkHNyWN4FrAMszgn2MzAQRLcPoBrmrFlx0MIgH+xgs=; b=Mo56pQAqfw/rio/V3yZyTIrk1N
 qm4I4Vn3Oe6LQwoP9A/ny0zpKJGErlztBA1prgBrkJyMFOZXtMg0xikj5aPUOip6YlsF+YjKAmZ/B
 cT34gdY9AvR2MxNki+2x8g9sqffrdz4NB8NmeqoH7MjmdScpFXViCSiew9szVH0zNsrxwUgxxuPKz
 0GKSQZ50mKQB3YYDfbaRfv0EL9nxpUE7GQWDPS2yXqkEkY+I31TmHX8oJjWcgHx7N2mtZvaDW3LWV
 mlFkgBNG102bveSfUAGfLZBA2mMDEK2ncijGmS0f9mgoim/ZKbcO/jD1rxm1VunWQPJGPJS41kC4R
 QXSgZI5g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJlm-000DVj-2R; Fri, 08 May 2026 13:53:26 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJlm-000PER-13; Fri, 08 May 2026 13:53:26 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@ew.tq-group.com, u-boot@lists.denx.de,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 1/5] arm: mx6: module_fuse: update node path for Linux 6.13
Date: Fri,  8 May 2026 13:53:06 +0200
Message-ID: <20260508115315.252623-2-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
References: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
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

From: Peng Fan <peng.fan@nxp.com>

Update node path for 5.10 Kernel.
 - aips-bus renamed to bus
 - gpmi-nand renamed to nand-controller

cherry picked from https://github.com/nxp-imx/uboot-imx,
tag lf-6.12.3-1.0.0,
commit feb8178e97d4 ("LF-2637 mx6: fuse: update node path")

add changes node path for Linux 6.13

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/mach-imx/mx6/module_fuse.c | 97 +++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm/mach-imx/mx6/module_fuse.c b/arch/arm/mach-imx/mx6/module_fuse.c
index 8b23d48a854..2ad9499ef46 100644
--- a/arch/arm/mach-imx/mx6/module_fuse.c
+++ b/arch/arm/mach-imx/mx6/module_fuse.c
@@ -12,6 +12,54 @@
 
 static struct fuse_entry_desc mx6_fuse_descs[] = {
 #if defined(CONFIG_MX6ULL)
+	{MODULE_TSC, "/soc/bus@2000000/touchscreen@2040000", 0x430, 22},
+	{MODULE_TSC, "/soc/bus@2000000/tsc@2040000", 0x430, 22},
+	{MODULE_ADC2, "/soc/bus@2100000/adc@219c000", 0x430, 23},
+	{MODULE_EPDC, "/soc/bus@2200000/epdc@228c000", 0x430, 24},
+	{MODULE_ESAI, "/soc/bus@2000000/spba-bus@2000000/esai@2024000", 0x430, 25},
+	{MODULE_FLEXCAN1, "/soc/bus@2000000/can@2090000", 0x430, 26},
+	{MODULE_FLEXCAN2, "/soc/bus@2000000/can@2094000", 0x430, 27},
+	{MODULE_SPDIF, "/soc/bus@2000000/spba-bus@2000000/spdif@2004000", 0x440, 2},
+	{MODULE_EIM, "/soc/bus@2100000/memory-controller@21b8000", 0x440, 3},
+	{MODULE_EIM, "/soc/bus@2100000/weim@21b8000", 0x440, 3},
+	{MODULE_SD1, "/soc/bus@2100000/mmc@2190000", 0x440, 4},
+	{MODULE_SD1, "/soc/bus@2100000/usdhc@2190000", 0x440, 4},
+	{MODULE_SD2, "/soc/bus@2100000/mmc@2194000", 0x440, 5},
+	{MODULE_SD2, "/soc/bus@2100000/usdhc@2194000", 0x440, 5},
+	{MODULE_QSPI1, "/soc/bus@2100000/spi@21e0000", 0x440, 6},
+	{MODULE_QSPI1, "/soc/bus@2100000/qspi@21e0000", 0x440, 6},
+	{MODULE_GPMI, "/soc/nand-controller@1806000", 0x440, 7},
+	{MODULE_APBHDMA, "/soc/dma-controller@1804000", 0x440, 7},
+	{MODULE_APBHDMA, "/soc/dma-apbh@1804000", 0x440, 7},
+	{MODULE_LCDIF, "/soc/bus@2100000/lcdif@21c8000", 0x440, 8},
+	{MODULE_PXP, "/soc/bus@2100000/pxp@21cc000", 0x440, 9},
+	{MODULE_CSI, "/soc/bus@2100000/csi@21c4000", 0x440, 10},
+	{MODULE_ADC1, "/soc/bus@2100000/adc@2198000", 0x440, 11},
+	{MODULE_ENET1, "/soc/bus@2100000/ethernet@2188000", 0x440, 12},
+	{MODULE_ENET2, "/soc/bus@2000000/ethernet@20b4000", 0x440, 13},
+	{MODULE_DCP, "/soc/bus@2200000/dcp@2280000", 0x440, 14},
+	{MODULE_USB_OTG2, "/soc/bus@2100000/usb@2184200", 0x440, 15},
+	{MODULE_SAI2, "/soc/bus@2000000/spba-bus@2000000/sai@202c000", 0x440, 24},
+	{MODULE_SAI3, "/soc/bus@2000000/spba-bus@2000000/sai@2030000", 0x440, 24},
+	{MODULE_DCP_CRYPTO, "/soc/bus@2200000/dcp@2280000", 0x440, 25},
+	{MODULE_UART5, "/soc/bus@2100000/serial@21f4000", 0x440, 26},
+	{MODULE_UART6, "/soc/bus@2100000/serial@21fc000", 0x440, 26},
+	{MODULE_UART7, "/soc/bus@2000000/spba-bus@2000000/serial@2018000", 0x440, 26},
+	{MODULE_UART8, "/soc/bus@2200000/serial@2288000", 0x440, 26},
+	{MODULE_PWM5, "/soc/bus@2000000/pwm@20f0000", 0x440, 27},
+	{MODULE_PWM6, "/soc/bus@2000000/pwm@20f4000", 0x440, 27},
+	{MODULE_PWM7, "/soc/bus@2000000/pwm@20f8000", 0x440, 27},
+	{MODULE_PWM8, "/soc/bus@2000000/pwm@20fc000", 0x440, 27},
+	{MODULE_ECSPI3, "/soc/bus@2000000/spba-bus@2000000/spi@2010000", 0x440, 28},
+	{MODULE_ECSPI3, "/soc/bus@2000000/spba-bus@2000000/ecspi@2010000", 0x440, 28},
+	{MODULE_ECSPI4, "/soc/bus@2000000/spba-bus@2000000/spi@2014000", 0x440, 28},
+	{MODULE_ECSPI4, "/soc/bus@2000000/spba-bus@2000000/ecspi@2014000", 0x440, 28},
+	{MODULE_I2C3, "/soc/bus@2100000/i2c@21a8000", 0x440, 29},
+	{MODULE_I2C4, "/soc/bus@2100000/i2c@21f8000", 0x440, 29},
+	{MODULE_GPT2, "/soc/bus@2000000/timer@20e8000", 0x440, 30},
+	{MODULE_GPT2, "/soc/bus@2000000/gpt@20e8000", 0x440, 30},
+	{MODULE_EPIT2, "/soc/bus@2000000/epit@20d4000", 0x440, 31},
+
 	{MODULE_TSC, "/soc/aips-bus@2000000/tsc@2040000", 0x430, 22},
 	{MODULE_ADC2, "/soc/aips-bus@2100000/adc@219c000", 0x430, 23},
 	{MODULE_EPDC, "/soc/aips-bus@2200000/epdc@228c000", 0x430, 24},
@@ -90,6 +138,55 @@ static struct fuse_entry_desc mx6_fuse_descs[] = {
 	{MODULE_GPT2, "/soc/aips-bus@02000000/gpt@020e8000", 0x440, 30},
 	{MODULE_EPIT2, "/soc/aips-bus@02000000/epit@020d4000", 0x440, 31},
 #elif defined(CONFIG_MX6UL)
+	{MODULE_TSC, "/soc/bus@2000000/touchscreen@2040000", 0x430, 22},
+	{MODULE_TSC, "/soc/bus@2000000/tsc@2040000", 0x430, 22},
+	{MODULE_ADC2, "/soc/bus@2100000/adc@219c000", 0x430, 23},
+	{MODULE_SIM1, "/soc/bus@2100000/sim@218c000", 0x430, 24},
+	{MODULE_SIM2, "/soc/bus@2100000/sim@21b4000", 0x430, 25},
+	{MODULE_FLEXCAN1, "/soc/bus@2000000/can@2090000", 0x430, 26},
+	{MODULE_FLEXCAN2, "/soc/bus@2000000/can@2094000", 0x430, 27},
+	{MODULE_SPDIF, "/soc/bus@2000000/spba-bus@2000000/spdif@2004000", 0x440, 2},
+	{MODULE_EIM, "/soc/bus@2100000/memory-controller@21b8000", 0x440, 3},
+	{MODULE_EIM, "/soc/bus@2100000/weim@21b8000", 0x440, 3},
+	{MODULE_SD1, "/soc/bus@2100000/mmc@2190000", 0x440, 4},
+	{MODULE_SD1, "/soc/bus@2100000/usdhc@2190000", 0x440, 4},
+	{MODULE_SD2, "/soc/bus@2100000/mmc@2194000", 0x440, 5},
+	{MODULE_SD2, "/soc/bus@2100000/usdhc@2194000", 0x440, 5},
+	{MODULE_QSPI1, "/soc/bus@2100000/spi@21e0000", 0x440, 6},
+	{MODULE_QSPI1, "/soc/bus@2100000/qspi@21e0000", 0x440, 6},
+	{MODULE_GPMI, "/soc/nand-controller@1806000", 0x440, 7},
+	{MODULE_APBHDMA, "/soc/dma-controller@1804000", 0x440, 7},
+	{MODULE_APBHDMA, "/soc/dma-apbh@1804000", 0x440, 7},
+	{MODULE_LCDIF, "/soc/bus@2100000/lcdif@21c8000", 0x440, 8},
+	{MODULE_PXP, "/soc/bus@2100000/pxp@21cc000", 0x440, 9},
+	{MODULE_CSI, "/soc/bus@2100000/csi@21c4000", 0x440, 10},
+	{MODULE_ADC1, "/soc/bus@2100000/adc@2198000", 0x440, 11},
+	{MODULE_ENET1, "/soc/bus@2100000/ethernet@2188000", 0x440, 12},
+	{MODULE_ENET2, "/soc/bus@2000000/ethernet@20b4000", 0x440, 13},
+	{MODULE_CAAM, "/soc/bus@2100000/crypto@2140000", 0x440, 14},
+	{MODULE_CAAM, "/soc/bus@2100000/caam@2140000", 0x440, 14},
+	{MODULE_USB_OTG2, "/soc/bus@2100000/usb@2184200", 0x440, 15},
+	{MODULE_SAI2, "/soc/bus@2000000/spba-bus@2000000/sai@202c000", 0x440, 24},
+	{MODULE_SAI3, "/soc/bus@2000000/spba-bus@2000000/sai@2030000", 0x440, 24},
+	{MODULE_BEE, "/soc/bus@2000000/bee@2044000", 0x440, 25},
+	{MODULE_UART5, "/soc/bus@2100000/serial@21f4000", 0x440, 26},
+	{MODULE_UART6, "/soc/bus@2100000/serial@21fc000", 0x440, 26},
+	{MODULE_UART7, "/soc/bus@2000000/spba-bus@2000000/serial@2018000", 0x440, 26},
+	{MODULE_UART8, "/soc/bus@2000000/spba-bus@2000000/serial@2024000", 0x440, 26},
+	{MODULE_PWM5, "/soc/bus@2000000/pwm@20f0000", 0x440, 27},
+	{MODULE_PWM6, "/soc/bus@2000000/pwm@20f4000", 0x440, 27},
+	{MODULE_PWM7, "/soc/bus@2000000/pwm@20f8000", 0x440, 27},
+	{MODULE_PWM8, "/soc/bus@2000000/pwm@20fc000", 0x440, 27},
+	{MODULE_ECSPI3, "/soc/bus@2000000/spba-bus@2000000/spi@2010000", 0x440, 28},
+	{MODULE_ECSPI3, "/soc/bus@2000000/spba-bus@2000000/ecspi@2010000", 0x440, 28},
+	{MODULE_ECSPI4, "/soc/bus@2000000/spba-bus@2000000/spi@2014000", 0x440, 28},
+	{MODULE_ECSPI4, "/soc/bus@2000000/spba-bus@2000000/ecspi@2014000", 0x440, 28},
+	{MODULE_I2C3, "/soc/bus@2100000/i2c@21a8000", 0x440, 29},
+	{MODULE_I2C4, "/soc/bus@2100000/i2c@21f8000", 0x440, 29},
+	{MODULE_GPT2, "/soc/bus@2000000/timer@20e8000", 0x440, 30},
+	{MODULE_GPT2, "/soc/bus@2000000/gpt@20e8000", 0x440, 30},
+	{MODULE_EPIT2, "/soc/bus@2000000/epit@20d4000", 0x440, 31},
+
 	{MODULE_TSC, "/soc/aips-bus@2000000/tsc@2040000", 0x430, 22},
 	{MODULE_ADC2, "/soc/aips-bus@2100000/adc@219c000", 0x430, 23},
 	{MODULE_SIM1, "/soc/aips-bus@2100000/sim@218c000", 0x430, 24},
-- 
2.43.0

