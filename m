Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EED9C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA9C8249D;
	Sun, 23 Mar 2025 17:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745734;
	bh=uTWkm6IOk6KutStyZ6oXrqIb3cfRoDFJQu+MdH0RQBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e8tOsSSrQRfegcI9185r5As/PSShpxMOCAxpPt9J3pFmdnnx/Ol1+6L4DyDbck7pN
	 zZjZ+4y4twBIXjWMzYoLzA0hZcEqxDXAOovvVIGeo3W5/S22m6WiudsHRv9g7j/5Pa
	 /NBJpxkqfbPm2Bl+WMAJVJuAzmeKPs5RtF0AvHpM5+EbWsIYcgKdYQjUhwF7adW8U1
	 LjzrTv4ET5wUqOJa5uETB2I0TL8V2NRD5BT5I/Azf0fXCF5sRTZkQKHuL553Os7nEG
	 cSnpL2pXrE913jeOel2/IWbHbOfdAIit7e6uTybv+cRZNxZNa4Bo0N6pOcYiSJMAT+
	 /VZ161M1r8erw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8206820F0; Sun, 23 Mar 2025 17:02:11 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 147C182008
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="d6BfYhM4"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CD0C51029024C; Sun, 23 Mar 2025 17:02:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745728; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=uTWkm6IOk6KutStyZ6oXrqIb3cfRoDFJQu+MdH0RQBQ=;
 b=d6BfYhM4v2frmsLea9Z856DQggk4ETHAIzcnXMwVblEPu1LKtQDsF0mAtDgCl4M4f4Emrj
 Ysv++shHw1MIWwkGRHYuxTpDlmcNLux6ui5UZu6QDzfVxeBciBQfF3suzsv+0MTCIH1Raw
 jaE3BcEgLCAwB3xDq4+okOwQ7UDanXcYlsUxBX1asUXIvhtiE1ALxSY1e1NS66wCwkb2yw
 k/d5lBo4YbOriZ+hCNBOSMQGAQf3p/zgEXf+GpwbH41yqLSILQMJFAV5ZqbZ8bKZBN9Whu
 uD9MJDvD6VIZgGcPABokPd+KciQaTREHUTLlM41JETHkVtfE1iyqfG2RLgyZ7A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 16/24] clk: imx: Convert clock-osc-* back to osc_*
Date: Sun, 23 Mar 2025 16:58:45 +0100
Message-ID: <20250323160107.145749-17-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
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

Convert clock-osc-24m back to osc_24m and clock-osc-32k back to osc_32k.
These are the clock which match clock tables in Linux. This is now
possible because the clock drivers now resolve clock names based on
clock-names DT property in the CCM DT node.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/imx/clk-imx8mm.c | 60 ++++++++++++-------------
 drivers/clk/imx/clk-imx8mn.c | 56 +++++++++++------------
 drivers/clk/imx/clk-imx8mp.c | 86 ++++++++++++++++++------------------
 3 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index c9d6954ac75..07e0f6da33e 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -14,7 +14,7 @@
 
 #include "clk.h"
 
-static const char * const pll_ref_sels[] = { "clock-osc-24m", "dummy", "dummy", "dummy", };
+static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
@@ -23,61 +23,61 @@ static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_se
 
 static const char * const imx8mm_arm_core_sels[] = {"arm_a53_src", "arm_pll_out", };
 
-static const char * const imx8mm_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
+static const char * const imx8mm_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pll2_500m",
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
 
-static const char * const imx8mm_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
+static const char * const imx8mm_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
 					       "audio_pll1_out", "video_pll1_out", };
 
 #ifndef CONFIG_XPL_BUILD
-static const char * const imx8mm_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+static const char * const imx8mm_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll1_out", "sys_pll3_out", };
 
-static const char * const imx8mm_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
+static const char * const imx8mm_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll1_out", "clk_ext4", };
 
-static const char * const imx8mm_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
+static const char * const imx8mm_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
 						      "clk_ext1", "clk_ext2", "clk_ext3",
 						      "clk_ext4", "video_pll1_out", };
 
-static const char * const imx8mm_enet_phy_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
+static const char * const imx8mm_enet_phy_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
 						    "sys_pll2_200m", "sys_pll2_500m", "video_pll1_out",
 						    "audio_pll2_out", };
 #endif
 
-static const char * const imx8mm_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+static const char * const imx8mm_nand_usdhc_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
 						      "sys_pll2_250m", "audio_pll1_out", };
 
-static const char * const imx8mm_usb_bus_sels[] = {"clock-osc-24m", "sys_pll2_500m", "sys_pll1_800m",
+static const char * const imx8mm_usb_bus_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
 						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						   "clk_ext4", "audio_pll2_out", };
 
-static const char * const imx8mm_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mm_usdhc1_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char * const imx8mm_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mm_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char * const imx8mm_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mm_i2c1_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mm_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mm_i2c2_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mm_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mm_i2c3_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mm_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
@@ -98,69 +98,69 @@ static const char * const imx8mm_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m"
 					  "audio_pll2_out", };
 
 #if CONFIG_IS_ENABLED(PCIE_DW_IMX)
-static const char * const imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m",
+static const char * const imx8mm_pcie1_ctrl_sels[] = {"osc_24m", "sys_pll2_250m", "sys_pll2_200m",
 						      "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_500m",
 						      "sys_pll2_333m", "sys_pll3_out", };
 
-static const char * const imx8mm_pcie1_phy_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll2_500m",
+static const char * const imx8mm_pcie1_phy_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll2_500m",
 						     "clk_ext1", "clk_ext2", "clk_ext3",
 						     "clk_ext4", "sys_pll1_400m", };
 
-static const char * const imx8mm_pcie1_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m",
+static const char * const imx8mm_pcie1_aux_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_50m",
 						     "sys_pll3_out", "sys_pll2_100m", "sys_pll1_80m",
 						     "sys_pll1_160m", "sys_pll1_200m", };
 #endif
 
 #ifndef CONFIG_XPL_BUILD
-static const char * const imx8mm_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mm_pwm1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll1_out", };
 
-static const char * const imx8mm_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mm_pwm2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll1_out", };
 
-static const char * const imx8mm_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mm_pwm3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
 						"sys_pll1_80m", "video_pll1_out", };
 
-static const char * const imx8mm_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mm_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
 						"sys_pll1_80m", "video_pll1_out", };
 #endif
 
-static const char * const imx8mm_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m",
+static const char * const imx8mm_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
 						"vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
 						"sys_pll1_80m", "sys_pll2_166m", };
 
-static const char * const imx8mm_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mm_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_clk", "sys_pll1_100m", };
 
 #if CONFIG_IS_ENABLED(NXP_FSPI)
-static const char * const imx8mm_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m",
+static const char * const imx8mm_qspi_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll2_333m",
 						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
 						"sys_pll3_out", "sys_pll1_100m", };
 #endif
 
-static const char * const imx8mm_usb_core_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+static const char * const imx8mm_usb_core_sels[] = {"osc_24m", "sys_pll1_100m", "sys_pll1_40m",
 						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						    "clk_ext3", "audio_pll2_out", };
 
-static const char * const imx8mm_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+static const char * const imx8mm_usb_phy_sels[] = {"osc_24m", "sys_pll1_100m", "sys_pll1_40m",
 						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						   "clk_ext3", "audio_pll2_out", };
 
 #if CONFIG_IS_ENABLED(DM_SPI)
-static const char * const imx8mm_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mm_ecspi1_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mm_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mm_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mm_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mm_ecspi3_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 #endif
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 18621fc1226..5f7530eafc8 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -16,7 +16,7 @@
 
 static u32 share_count_nand;
 
-static const char * const pll_ref_sels[] = { "clock-osc-24m", "dummy", "dummy", "dummy", };
+static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
@@ -25,75 +25,75 @@ static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_se
 
 static const char * const imx8mn_arm_core_sels[] = {"arm_a53_src", "arm_pll_out", };
 
-static const char * const imx8mn_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
+static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pll2_500m",
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
 
-static const char * const imx8mn_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
+static const char * const imx8mn_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
 					       "audio_pll1_out", "video_pll_out", };
 
-static const char * const imx8mn_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+static const char * const imx8mn_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll_out", "sys_pll3_out", };
 
 #ifndef CONFIG_XPL_BUILD
-static const char * const imx8mn_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
+static const char * const imx8mn_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll_out", "clk_ext4", };
 
-static const char * const imx8mn_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
+static const char * const imx8mn_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
 						      "clk_ext1", "clk_ext2", "clk_ext3",
 						      "clk_ext4", "video_pll_out", };
 
-static const char * const imx8mn_enet_phy_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
+static const char * const imx8mn_enet_phy_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
 						    "sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
 						    "video_pll_out", "audio_pll2_out", };
 #endif
 
-static const char * const imx8mn_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+static const char * const imx8mn_nand_usdhc_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
 						      "sys_pll2_250m", "audio_pll1_out", };
 
-static const char * const imx8mn_usb_bus_sels[] = {"clock-osc-24m", "sys_pll2_500m", "sys_pll1_800m",
+static const char * const imx8mn_usb_bus_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
 						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						   "clk_ext4", "audio_pll2_out", };
 
-static const char * const imx8mn_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mn_usdhc1_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char * const imx8mn_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mn_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
 #if CONFIG_IS_ENABLED(DM_SPI)
-static const char * const imx8mn_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mn_ecspi1_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mn_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mn_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mn_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mn_ecspi3_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 #endif
 
-static const char * const imx8mn_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mn_i2c1_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mn_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mn_i2c2_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mn_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mn_i2c3_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mn_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mn_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
@@ -114,44 +114,44 @@ static const char * const imx8mn_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m"
 						 "clk_ext3", "audio_pll2_out", };
 
 #ifndef CONFIG_XPL_BUILD
-static const char * const imx8mn_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mn_pwm1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll_out", };
 
-static const char * const imx8mn_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mn_pwm2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll_out", };
 
-static const char * const imx8mn_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mn_pwm3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
 						"sys_pll1_80m", "video_pll_out", };
 
-static const char * const imx8mn_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mn_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
 						"sys_pll1_80m", "video_pll_out", };
 #endif
 
-static const char * const imx8mn_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m",
+static const char * const imx8mn_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
 						"m7_alt_pll", "sys_pll2_125m", "sys_pll3_out",
 						"sys_pll1_80m", "sys_pll2_166m", };
 
-static const char * const imx8mn_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mn_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_clk", "sys_pll1_100m", };
 
-static const char * const imx8mn_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m",
+static const char * const imx8mn_qspi_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll2_333m",
 						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
 						"sys_pll3_out", "sys_pll1_100m", };
 
-static const char * const imx8mn_nand_sels[] = {"clock-osc-24m", "sys_pll2_500m", "audio_pll1_out",
+static const char * const imx8mn_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out",
 						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
 						"sys_pll2_250m", "video_pll_out", };
 
-static const char * const imx8mn_usb_core_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+static const char * const imx8mn_usb_core_sels[] = {"osc_24m", "sys_pll1_100m", "sys_pll1_40m",
 						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						    "clk_ext3", "audio_pll2_out", };
 
-static const char * const imx8mn_usb_phy_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+static const char * const imx8mn_usb_phy_sels[] = {"osc_24m", "sys_pll1_100m", "sys_pll1_40m",
 						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						   "clk_ext3", "audio_pll2_out", };
 
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 5768504e7c9..7c6b5322427 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -14,7 +14,7 @@
 
 #include "clk.h"
 
-static const char * const pll_ref_sels[] = { "clock-osc-24m", "dummy", "dummy", "dummy", };
+static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
@@ -23,167 +23,167 @@ static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_se
 
 static const char * const imx8mp_arm_core_sels[] = {"arm_a53_src", "arm_pll_out", };
 
-static const char * const imx8mp_a53_sels[] = {"clock-osc-24m", "arm_pll_out", "sys_pll2_500m",
+static const char * const imx8mp_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pll2_500m",
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
 
-static const char * const imx8mp_hsio_axi_sels[] = {"clock-osc-24m", "sys_pll2_500m", "sys_pll1_800m",
+static const char * const imx8mp_hsio_axi_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
 						    "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						    "clk_ext4", "audio_pll2_out", };
 
-static const char * const imx8mp_main_axi_sels[] = {"clock-osc-24m", "sys_pll2_333m", "sys_pll1_800m",
+static const char * const imx8mp_main_axi_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_1000m", "audio_pll1_out",
 						    "video_pll1_out", "sys_pll1_100m",};
 
-static const char * const imx8mp_enet_axi_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+static const char * const imx8mp_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll1_out", "sys_pll3_out", };
 
-static const char * const imx8mp_nand_usdhc_sels[] = {"clock-osc-24m", "sys_pll1_266m", "sys_pll1_800m",
+static const char * const imx8mp_nand_usdhc_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
 						      "sys_pll2_250m", "audio_pll1_out", };
 
-static const char * const imx8mp_noc_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
+static const char * const imx8mp_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
 					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
 					       "video_pll1_out", "audio_pll2_out", };
 
-static const char * const imx8mp_noc_io_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll3_out",
+static const char * const imx8mp_noc_io_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
 						  "video_pll1_out", "audio_pll2_out", };
 
-static const char * const imx8mp_ahb_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_800m",
+static const char * const imx8mp_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
 					       "audio_pll1_out", "video_pll1_out", };
 
-static const char * const imx8mp_dram_alt_sels[] = {"clock-osc-24m", "sys_pll1_800m", "sys_pll1_100m",
+static const char * const imx8mp_dram_alt_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll1_100m",
 						    "sys_pll2_500m", "sys_pll2_1000m", "sys_pll3_out",
 						    "audio_pll1_out", "sys_pll1_266m", };
 
-static const char * const imx8mp_dram_apb_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mp_dram_apb_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						    "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						    "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mp_pcie_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m",
+static const char * const imx8mp_pcie_aux_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_50m",
 						    "sys_pll3_out", "sys_pll2_100m", "sys_pll1_80m",
 						    "sys_pll1_160m", "sys_pll1_200m", };
 
-static const char * const imx8mp_i2c5_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mp_i2c5_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mp_i2c6_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mp_i2c6_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mp_enet_qos_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
+static const char * const imx8mp_enet_qos_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll1_out", "clk_ext4", };
 
-static const char * const imx8mp_enet_qos_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
+static const char * const imx8mp_enet_qos_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
 							  "clk_ext1", "clk_ext2", "clk_ext3",
 							  "clk_ext4", "video_pll1_out", };
 
-static const char * const imx8mp_usdhc1_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mp_usdhc1_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char * const imx8mp_usdhc2_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mp_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char * const imx8mp_i2c1_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mp_i2c1_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mp_i2c2_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mp_i2c2_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mp_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mp_i2c3_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mp_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m",
+static const char * const imx8mp_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
 						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
 						"audio_pll2_out", "sys_pll1_133m", };
 
-static const char * const imx8mp_uart1_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mp_uart1_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext4", "audio_pll2_out", };
 
-static const char * const imx8mp_uart2_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mp_uart2_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext3", "audio_pll2_out", };
 
-static const char * const imx8mp_uart3_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mp_uart3_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext4", "audio_pll2_out", };
 
-static const char * const imx8mp_uart4_sels[] = {"clock-osc-24m", "sys_pll1_80m", "sys_pll2_200m",
+static const char * const imx8mp_uart4_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
 						 "sys_pll2_100m", "sys_pll3_out", "clk_ext2",
 						 "clk_ext3", "audio_pll2_out", };
 
-static const char * const imx8mp_usb_core_ref_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+static const char * const imx8mp_usb_core_ref_sels[] = {"osc_24m", "sys_pll1_100m", "sys_pll1_40m",
 							"sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 							"clk_ext3", "audio_pll2_out", };
 
-static const char * const imx8mp_usb_phy_ref_sels[] = {"clock-osc-24m", "sys_pll1_100m", "sys_pll1_40m",
+static const char * const imx8mp_usb_phy_ref_sels[] = {"osc_24m", "sys_pll1_100m", "sys_pll1_40m",
 						       "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						       "clk_ext3", "audio_pll2_out", };
 
-static const char * const imx8mp_gic_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mp_gic_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 					       "sys_pll2_100m", "sys_pll1_800m",
 					       "sys_pll2_500m", "clk_ext4", "audio_pll2_out" };
 
-static const char * const imx8mp_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mp_pwm1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll1_out", };
 
-static const char * const imx8mp_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mp_pwm2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
 						"sys_pll1_80m", "video_pll1_out", };
 
-static const char * const imx8mp_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mp_pwm3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
 						"sys_pll1_80m", "video_pll1_out", };
 
-static const char * const imx8mp_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
+static const char * const imx8mp_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
 						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
 						"sys_pll1_80m", "video_pll1_out", };
 
-static const char * const imx8mp_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mp_ecspi1_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mp_ecspi2_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mp_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mp_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
+static const char * const imx8mp_ecspi3_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
 						  "sys_pll2_250m", "audio_pll2_out", };
 
-static const char * const imx8mp_wdog_sels[] = {"clock-osc-24m", "sys_pll1_133m", "sys_pll1_160m",
+static const char * const imx8mp_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
 						"vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
 						"sys_pll1_80m", "sys_pll2_166m" };
 
-static const char * const imx8mp_qspi_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll2_333m",
+static const char * const imx8mp_qspi_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll2_333m",
 						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
 						"sys_pll3_out", "sys_pll1_100m", };
 
-static const char * const imx8mp_usdhc3_sels[] = {"clock-osc-24m", "sys_pll1_400m", "sys_pll1_800m",
+static const char * const imx8mp_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
-static const char * const imx8mp_enet_ref_sels[] = {"clock-osc-24m", "sys_pll2_125m", "sys_pll2_50m",
+static const char * const imx8mp_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll1_out", "clk_ext4", };
 
-static const char * const imx8mp_enet_timer_sels[] = {"clock-osc-24m", "sys_pll2_100m", "audio_pll1_out",
+static const char * const imx8mp_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
 						      "clk_ext1", "clk_ext2", "clk_ext3",
 						      "clk_ext4", "video_pll1_out", };
 
-static const char * const imx8mp_enet_phy_ref_sels[] = {"clock-osc-24m", "sys_pll2_50m", "sys_pll2_125m",
+static const char * const imx8mp_enet_phy_ref_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
 							"sys_pll2_200m", "sys_pll2_500m", "audio_pll1_out",
 							"video_pll1_out", "audio_pll2_out", };
 
@@ -347,7 +347,7 @@ static int imx8mp_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MP_CLK_UART3_ROOT, imx_clk_gate4(dev, "uart3_root_clk", "uart3", base + 0x44b0, 0));
 	clk_dm(IMX8MP_CLK_UART4_ROOT, imx_clk_gate4(dev, "uart4_root_clk", "uart4", base + 0x44c0, 0));
 	clk_dm(IMX8MP_CLK_USB_ROOT, imx_clk_gate2(dev, "usb_root_clk", "hsio_axi", base + 0x44d0, 0));
-	clk_dm(IMX8MP_CLK_USB_SUSP, imx_clk_gate2(dev, "usb_suspend_clk", "clock-osc-24m", base + 0x44d0, 0));
+	clk_dm(IMX8MP_CLK_USB_SUSP, imx_clk_gate2(dev, "usb_suspend_clk", "osc_24m", base + 0x44d0, 0));
 	clk_dm(IMX8MP_CLK_USB_PHY_ROOT, imx_clk_gate4(dev, "usb_phy_root_clk", "usb_phy_ref", base + 0x44f0, 0));
 	clk_dm(IMX8MP_CLK_USDHC1_ROOT, imx_clk_gate4(dev, "usdhc1_root_clk", "usdhc1", base + 0x4510, 0));
 	clk_dm(IMX8MP_CLK_USDHC2_ROOT, imx_clk_gate4(dev, "usdhc2_root_clk", "usdhc2", base + 0x4520, 0));
-- 
2.47.2

