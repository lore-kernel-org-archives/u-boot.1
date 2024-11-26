Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA57D5A6E3
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 04:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DE1F88EEA;
	Tue, 26 Nov 2024 05:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.b="m4Bx7ssf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E709589C13; Tue, 26 Nov 2024 03:25:52 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD6A89BF2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 03:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hau@realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AQ2PdSbA286959,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
 t=1732587940; bh=7ar+OALv2aM+w1D6mrkeqMMUQV3zCq5Tciz08HTheuU=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=m4Bx7ssfBwo/EVeTnes0TngtLXkk0W/T+C9USfwMGSHYN9fVfKovXi/YptQe1NkYp
 whxGrXXfZauDHhKAAXrk9+isMl5p0SV1uCFQhu7eSy68VrGoUS4ImbPh4yJrJcVb1/
 UMR/Sg84h2W5UufZSf5hdRto1Dbdrba6A/yAhCLTHOhUua0tWb6ysw6u8tFQH03t+Y
 +hwhSB0LZ75k1C84HBB1kP9Cp0f0h8x6JbPy3sSnqgFS6n477MyHccWX1gaqOEq+s+
 6C6cU7qPwqCZpt7pSFsQhrxW5JSf9xIYQ1suXWMOtChsUCV8BaasdJ/PZ8wPkJQuWC
 zF+8bMnxsdU4w==
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AQ2PdSbA286959
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:25:40 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RSEXMBS01.realsil.com.cn (172.29.17.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Nov 2024 10:25:39 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 26 Nov 2024 10:25:38 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 26 Nov 2024 10:25:38 +0800
From: ChunHao Lin <hau@realtek.com>
To: <u-boot@lists.denx.de>
CC: ChunHao Lin <hau@realtek.com>
Subject: [PATCH 2/5] usb: eth: r8152: Add support for rtl8156 and rtl8156b
Date: Tue, 26 Nov 2024 10:25:12 +0800
Message-ID: <20241126022515.4043-3-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126022515.4043-1-hau@realtek.com>
References: <20241126022515.4043-1-hau@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 26 Nov 2024 05:50:13 +0100
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

This is used to support rtl8156 and rtl8156b.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/usb/eth/r8152.c    | 1168 ++++++-
 drivers/usb/eth/r8152.h    |  160 +-
 drivers/usb/eth/r8152_fw.c | 6335 +++++++++++++++++++++++++++++++++++-
 3 files changed, 7591 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/eth/r8152.c b/drivers/usb/eth/r8152.c
index 294f7d776e..c767b78291 100644
--- a/drivers/usb/eth/r8152.c
+++ b/drivers/usb/eth/r8152.c
@@ -14,25 +14,33 @@
 #include <linux/delay.h>
 #include <linux/mii.h>
 #include <linux/bitops.h>
+#include <linux/mdio.h>
 #include "usb_ether.h"
 #include "r8152.h"
 
 struct r8152_version {
 	unsigned short tcr;
 	unsigned short version;
-	bool           gmii;
+	bool           supports_gmii;
+	bool           supports_xgmii;
 };
 
 static const struct r8152_version r8152_versions[] = {
-	{ 0x4c00, RTL_VER_01, 0 },
-	{ 0x4c10, RTL_VER_02, 0 },
-	{ 0x5c00, RTL_VER_03, 1 },
-	{ 0x5c10, RTL_VER_04, 1 },
-	{ 0x5c20, RTL_VER_05, 1 },
-	{ 0x5c30, RTL_VER_06, 1 },
-	{ 0x4800, RTL_VER_07, 0 },
-	{ 0x6000, RTL_VER_08, 1 },
-	{ 0x6010, RTL_VER_09, 1 },
+	{ 0x4c00, RTL_VER_01, 0, 0},
+	{ 0x4c10, RTL_VER_02, 0, 0},
+	{ 0x5c00, RTL_VER_03, 1, 0},
+	{ 0x5c10, RTL_VER_04, 1, 0},
+	{ 0x5c20, RTL_VER_05, 1, 0},
+	{ 0x5c30, RTL_VER_06, 1, 0},
+	{ 0x4800, RTL_VER_07, 0, 0},
+	{ 0x6000, RTL_VER_08, 1, 0},
+	{ 0x6010, RTL_VER_09, 1, 0},
+	{ 0x7010, RTL_TEST_01, 1, 1},
+	{ 0x7020, RTL_VER_10, 1, 1},
+	{ 0x7030, RTL_VER_11, 1, 1},
+	{ 0x7400, RTL_VER_12, 1, 1},
+	{ 0x7410, RTL_VER_13, 1, 1},
+	{ 0x7420, RTL_VER_15, 1, 1},
 };
 
 static
@@ -296,7 +304,7 @@ void sram_write(struct r8152 *tp, u16 addr, u16 data)
 	ocp_reg_write(tp, OCP_SRAM_DATA, data);
 }
 
-static u16 sram_read(struct r8152 *tp, u16 addr)
+u16 sram_read(struct r8152 *tp, u16 addr)
 {
 	ocp_reg_write(tp, OCP_SRAM_ADDR, addr);
 	return ocp_reg_read(tp, OCP_SRAM_DATA);
@@ -481,17 +489,51 @@ static void rtl8152_wait_fifo_empty(struct r8152 *tp)
 
 static void rtl8152_nic_reset(struct r8152 *tp)
 {
-	int ret;
-	u32 ocp_data;
+	int i;
 
-	ocp_data = ocp_read_dword(tp, MCU_TYPE_PLA, BIST_CTRL);
-	ocp_data |= BIST_CTRL_SW_RESET;
-	ocp_write_dword(tp, MCU_TYPE_PLA, BIST_CTRL, ocp_data);
+	switch (tp->version) {
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
+		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, PLA_CR_TE);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_BMU_RESET,
+				  BMU_RESET_EP_IN);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+				  CDC_ECM_EN);
+		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, PLA_CR_RE);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_BMU_RESET,
+				  BMU_RESET_EP_IN);
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+				  CDC_ECM_EN);
+		break;
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
+	case RTL_VER_08:
+	case RTL_VER_09:
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, PLA_CR_RST);
+		for (i = 0; i < 1000; i++) {
+			u32 ocp_data;
+
+			ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR);
+			if (!(ocp_data & PLA_CR_RST))
+				break;
+			mdelay(1);
+		}
+		break;
+	default:
+		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR,
+				  PLA_CR_RE | PLA_CR_TE);
+		break;
 
-	ret = r8152_wait_for_bit(tp, 0, MCU_TYPE_PLA, BIST_CTRL,
-				 BIST_CTRL_SW_RESET, 0, R8152_WAIT_TIMEOUT);
-	if (ret)
-		debug("Timeout waiting for NIC reset\n");
+	}
 }
 
 static u8 rtl8152_get_speed(struct r8152 *tp)
@@ -543,20 +585,21 @@ static inline void r8153b_rx_agg_chg_indicate(struct r8152 *tp)
 
 static int rtl_enable(struct r8152 *tp)
 {
-	u32 ocp_data;
-
 	r8152b_reset_packet_filter(tp);
 
-	ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR);
-	ocp_data |= PLA_CR_RE | PLA_CR_TE;
-	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_CR, PLA_CR_RE | PLA_CR_TE);
 
 	switch (tp->version) {
-	case RTL_VER_08:
-	case RTL_VER_09:
-		r8153b_rx_agg_chg_indicate(tp);
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
 		break;
 	default:
+		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	}
 
@@ -598,6 +641,17 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 			       ocp_data);
 		break;
 
+	case RTL_VER_10:
+	case RTL_VER_11:
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_TIMEOUT,
+			       640 / 8);
+		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
+			       ocp_data);
+		break;
+
 	default:
 		debug("** %s Invalid Device\n", __func__);
 		break;
@@ -620,6 +674,12 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 
 	case RTL_VER_08:
 	case RTL_VER_09:
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
 		break;
@@ -639,6 +699,39 @@ static int rtl8153_enable(struct r8152 *tp)
 	return rtl_enable(tp);
 }
 
+static u32 fc_pause_on_auto(struct r8152 *tp)
+{
+	return (2048 + 6 * 1024);
+}
+
+static u32 fc_pause_off_auto(struct r8152 *tp)
+{
+	return (2048 + 14 * 1024);
+}
+
+static void r8156_fc_parameter(struct r8152 *tp)
+{
+	u32 pause_on = fc_pause_on_auto(tp);
+	u32 pause_off = fc_pause_off_auto(tp);
+
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, pause_on / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, pause_off / 16);
+}
+
+static int rtl8156_enable(struct r8152 *tp)
+{
+	r8156_fc_parameter(tp);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+			  IDLE_SPDWN_EN);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+	mdelay(2);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+
+	return rtl8153_enable(tp);
+}
+
 static void rtl_disable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -671,14 +764,68 @@ static void r8152_power_cut_en(struct r8152 *tp, bool enable)
 
 static void rtl_rx_vlan_en(struct r8152 *tp, bool enable)
 {
-	u32 ocp_data;
+	switch (tp->version) {
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
+	case RTL_VER_08:
+	case RTL_VER_09:
+		if (enable)
+			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR,
+					  CPCR_RX_VLAN);
+		else
+			ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_CPCR,
+					  CPCR_RX_VLAN);
+		break;
+
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+	default:
+		if (enable)
+			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_RCR1,
+					  OUTER_VLAN | INNER_VLAN);
+		else
+			ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR1,
+					  OUTER_VLAN | INNER_VLAN);
+		break;
+	}
+}
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_CPCR);
+static void r8153_mac_clk_speed_down(struct r8152 *tp, bool enable)
+{
+	/* MAC clock speed down */
 	if (enable)
-		ocp_data |= CPCR_RX_VLAN;
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2,
+				  MAC_CLK_SPDWN_EN);
 	else
-		ocp_data &= ~CPCR_RX_VLAN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_CPCR, ocp_data);
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2,
+				  MAC_CLK_SPDWN_EN);
+}
+
+static void r8156_mac_clk_spd(struct r8152 *tp, bool enable)
+{
+	/* MAC clock speed down */
+	if (enable) {
+		/* aldps_spdwn_ratio, tp10_spdwn_ratio */
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL,
+			       0x0403);
+
+		/* eee_spdwn_ratio */
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2,
+				    EEE_SPDWN_RATIO_MASK,
+				    MAC_CLK_SPDWN_EN | 0x03);
+	} else {
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2,
+				  MAC_CLK_SPDWN_EN);
+	}
 }
 
 static void r8153_u1u2en(struct r8152 *tp, bool enable)
@@ -718,6 +865,43 @@ static void r8153_u2p3en(struct r8152 *tp, bool enable)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U2P3_CTRL, ocp_data);
 }
 
+bool r8156b_flash_used(struct r8152 *tp)
+{
+	u32 ocp_data;
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_GPHY_CTRL);
+	if (!(ocp_data & GPHY_FLASH))
+		return false;
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL);
+	if (!(ocp_data & BYPASS_FLASH))
+		return true;
+	else
+		return false;
+}
+
+static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
+{
+	u16 data;
+	int i;
+
+	for (i = 0; i < 500; i++) {
+		data = ocp_reg_read(tp, OCP_PHY_STATUS);
+		data &= PHY_STAT_MASK;
+		if (desired) {
+			if (data == desired)
+				break;
+		} else if (data == PHY_STAT_LAN_ON || data == PHY_STAT_PWRDN ||
+			   data == PHY_STAT_EXT_INIT) {
+			break;
+		}
+
+		mdelay(20);
+	}
+
+	return data;
+}
+
 static void r8153_power_cut_en(struct r8152 *tp, bool enable)
 {
 	u32 ocp_data;
@@ -734,6 +918,52 @@ static void r8153_power_cut_en(struct r8152 *tp, bool enable)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MISC_0, ocp_data);
 }
 
+static void r8153b_power_cut_en(struct r8152 *tp, bool enable)
+{
+	if (enable)
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  PWR_EN | PHASE2_EN);
+	else
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  PWR_EN);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
+}
+
+static void r8153_teredo_off(struct r8152 *tp)
+{
+	switch (tp->version) {
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_TEREDO_CFG,
+				  TEREDO_SEL | TEREDO_RS_EVENT_MASK |
+				  OOB_TEREDO_EN);
+		break;
+
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+	default:
+		/* The bit 0 ~ 7 are relative with teredo settings. They are
+		 * W1C (write 1 to clear), so set all 1 to disable it.
+		 */
+		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_TEREDO_CFG, 0xff);
+		break;
+	}
+
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_WDT6_CTRL, WDT6_SET_MODE);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_REALWOW_TIMER, 0);
+	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_TEREDO_TIMER, 0);
+}
+
 static void rtl_reset_bmu(struct r8152 *tp)
 {
 	u8 ocp_data;
@@ -745,6 +975,41 @@ static void rtl_reset_bmu(struct r8152 *tp)
 	ocp_write_byte(tp, MCU_TYPE_USB, USB_BMU_RESET, ocp_data);
 }
 
+void rtl_reset_ocp_base(struct r8152 *tp)
+{
+	tp->ocp_base = -1;
+}
+
+static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
+{
+	u16 check;
+	int i;
+
+	if (request) {
+		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
+		check = 0;
+	} else {
+		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
+		check = PATCH_READY;
+	}
+
+	for (i = 0; wait && i < 5000; i++) {
+		u16 data;
+
+		mdelay(1);
+		data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
+		if ((data & PATCH_READY) ^ check)
+			break;
+	}
+
+	if (request && wait && i == 5000) {
+		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 static int r8152_read_mac(struct r8152 *tp, unsigned char *macaddr)
 {
 	int ret;
@@ -790,6 +1055,22 @@ static void r8152b_hw_phy_cfg(struct r8152 *tp)
 	r8152b_firmware(tp);
 }
 
+static void r8156b_wait_loading_flash(struct r8152 *tp)
+{
+	if (r8156b_flash_used(tp)) {
+		int i;
+
+		for (i = 0; i < 100; i++) {
+			u32 ocp_data;
+
+			ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL);
+			if (ocp_data & GPHY_PATCH_DONE)
+				break;
+			mdelay(2);
+		}
+	}
+}
+
 static void rtl8152_reinit_ll(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -903,6 +1184,16 @@ static void r8152b_enter_oob(struct r8152 *tp)
 	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
 }
 
+static void r8153b_mcu_spdown_en(struct r8152 *tp, bool enable)
+{
+	if (enable)
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+				  PLA_MCU_SPDWN_EN);
+	else
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
+				  PLA_MCU_SPDWN_EN);
+}
+
 static void r8153_hw_phy_cfg(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -962,6 +1253,16 @@ static u32 r8152_efuse_read(struct r8152 *tp, u8 addr)
 	return ocp_data;
 }
 
+static void r8153_disable_aldps(struct r8152 *tp)
+{
+	u16 data;
+
+	data = ocp_reg_read(tp, OCP_POWER_CFG);
+	data &= ~EN_ALDPS;
+	ocp_reg_write(tp, OCP_POWER_CFG, data);
+	mdelay(20);
+}
+
 static void r8153b_hw_phy_cfg(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -1015,6 +1316,498 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 	ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR, ocp_data);
 }
 
+static void r8156_hw_phy_cfg(struct r8152 *tp)
+{
+	u32 ocp_data;
+	u16 data;
+
+	r8156_patch_code(tp);
+
+	data = r8152_mdio_read(tp, MII_BMCR);
+	if (data & BMCR_PDOWN) {
+		data &= ~BMCR_PDOWN;
+		r8152_mdio_write(tp, MII_BMCR, data);
+	}
+
+	/* U1/U2/L1 idle timer. 500 us */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
+
+	data = r8153_phy_status(tp, 0);
+	switch (data) {
+	case PHY_STAT_EXT_INIT:
+		r8156_ram_code(tp, true);
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		break;
+	case PHY_STAT_LAN_ON:
+	case PHY_STAT_PWRDN:
+	default:
+		r8156_ram_code(tp, false);
+		break;
+	}
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR);
+	ocp_data &= ~PFM_PWM_SWITCH;
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_PHY_PWR, ocp_data);
+
+	switch (tp->version) {
+	case RTL_VER_10:
+		ocp_reg_w0w1(tp, 0xad40, 0x3ff, BIT(7) | BIT(2));
+
+		ocp_reg_set_bits(tp, 0xad4e, BIT(4));
+		ocp_reg_w0w1(tp, 0xad16, 0x3ff, 0x6);
+		ocp_reg_w0w1(tp, 0xad32, 0x3f, 6);
+		ocp_reg_clr_bits(tp, 0xac08, BIT(12) | BIT(8));
+		ocp_reg_w0w1(tp, 0xac8a, BIT(15), BIT(12) | BIT(13) | BIT(14));
+		ocp_reg_set_bits(tp, 0xad18, BIT(10));
+		ocp_reg_set_bits(tp, 0xad1a, 0x3ff);
+		ocp_reg_set_bits(tp, 0xad1c, 0x3ff);
+
+		sram_write_w0w1(tp, 0x80ea, 0xff00, 0xc400);
+		sram_write_w0w1(tp, 0x80eb, 0x0700, 0x0300);
+		sram_write_w0w1(tp, 0x80f8, 0xff00, 0x1c00);
+		sram_write_w0w1(tp, 0x80f1, 0xff00, 0x3000);
+
+		sram_write_w0w1(tp, 0x80fe, 0xff00, 0xa500);
+		sram_write_w0w1(tp, 0x8102, 0xff00, 0x5000);
+		sram_write_w0w1(tp, 0x8015, 0xff00, 0x3300);
+		sram_write_w0w1(tp, 0x8100, 0xff00, 0x7000);
+		sram_write_w0w1(tp, 0x8014, 0xff00, 0xf000);
+		sram_write_w0w1(tp, 0x8016, 0xff00, 0x6500);
+		sram_write_w0w1(tp, 0x80dc, 0xff00, 0xed00);
+		sram_set_bits(tp, 0x80df, BIT(8));
+		sram_clr_bits(tp, 0x80e1, BIT(8));
+
+		ocp_reg_w0w1(tp, 0xbf06, 0x003f, 0x0038);
+
+		sram_write(tp, 0x819f, 0xddb6);
+
+		ocp_reg_write(tp, 0xbc34, 0x5555);
+		ocp_reg_w0w1(tp, 0xbf0a, 0x0e00, 0x0a00);
+
+		ocp_reg_clr_bits(tp, 0xbd2c, BIT(13));
+		break;
+	case RTL_VER_11:
+		/* 2.5G INRX */
+		ocp_reg_set_bits(tp, 0xad16, 0x3ff);
+		ocp_reg_w0w1(tp, 0xad32, 0x3f, 6);
+		ocp_reg_clr_bits(tp, 0xac08, BIT(12) | BIT(8));
+		ocp_reg_w0w1(tp, 0xacc0, 0x3, BIT(1));
+		ocp_reg_w0w1(tp, 0xad40, 0xe7, BIT(6) | BIT(2));
+		ocp_reg_clr_bits(tp, 0xac14, BIT(7));
+		ocp_reg_clr_bits(tp, 0xac80, BIT(8) | BIT(9));
+		ocp_reg_w0w1(tp, 0xac5e, 0x7, BIT(1));
+		ocp_reg_write(tp, 0xad4c, 0x00a8);
+		ocp_reg_write(tp, 0xac5c, 0x01ff);
+		ocp_reg_w0w1(tp, 0xac8a, 0xf0, BIT(4) | BIT(5));
+		ocp_reg_write(tp, 0xb87c, 0x8157);
+		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0500);
+		ocp_reg_write(tp, 0xb87c, 0x8159);
+		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0700);
+
+		/* AAGC */
+		ocp_reg_write(tp, 0xb87c, 0x80a2);
+		ocp_reg_write(tp, 0xb87e, 0x0153);
+		ocp_reg_write(tp, 0xb87c, 0x809c);
+		ocp_reg_write(tp, 0xb87e, 0x0153);
+
+		/* EEE parameter */
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_EEE_TXTWSYS_2P5G, 0x0056);
+
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_USB_CFG,
+				  EN_XG_LIP | EN_G_LIP);
+
+		sram_write(tp, 0x8257, 0x020f); /*  XG PLL */
+		sram_write(tp, 0x80ea, 0x7843); /* GIGA Master */
+
+		if (rtl_phy_patch_request(tp, true, true))
+			return;
+
+		/* Advance EEE */
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4,
+				  EEE_SPDWN_EN);
+
+		ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000,
+			     EN_10M_CLKDIV);
+
+		ocp_reg_clr_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
+
+		ocp_reg_write(tp, OCP_SYSCLK_CFG, 0);
+		ocp_reg_write(tp, OCP_SYSCLK_CFG, sysclk_div_expo(5));
+
+		rtl_phy_patch_request(tp, false, true);
+
+		/* enable ADC Ibias Cal */
+		ocp_reg_set_bits(tp, 0xd068, BIT(13));
+
+		/* enable Thermal Sensor */
+		sram_clr_bits(tp, 0x81a2, BIT(8));
+		ocp_reg_w0w1(tp, 0xb54c, 0xff00, 0xdb00);
+
+		/* Nway 2.5G Lite */
+		ocp_reg_clr_bits(tp, 0xa454, BIT(0));
+
+		/* CS DSP solution */
+		ocp_reg_set_bits(tp, OCP_10GBT_CTRL, RTL_ADV2_5G_F_R);
+		ocp_reg_clr_bits(tp, 0xad4e, BIT(4));
+		ocp_reg_clr_bits(tp, 0xa86a, BIT(0));
+
+		/* MDI SWAP */
+		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_UPS_CFG);
+		data = ocp_reg_read(tp, 0xd068);
+		if ((ocp_data & MID_REVERSE) && (data & BIT(1))) {
+			u16 swap_a, swap_b;
+
+			data = ocp_reg_read(tp, 0xd068);
+			data &= ~0x1f;
+			data |= 0x1; /* p0 */
+			ocp_reg_write(tp, 0xd068, data);
+			swap_a = ocp_reg_read(tp, 0xd06a);
+			data &= ~0x18;
+			data |= 0x18; /* p3 */
+			ocp_reg_write(tp, 0xd068, data);
+			swap_b = ocp_reg_read(tp, 0xd06a);
+			data &= ~0x18; /* p0 */
+			ocp_reg_write(tp, 0xd068, data);
+			ocp_reg_write(tp, 0xd06a,
+				      (swap_a & ~0x7ff) | (swap_b & 0x7ff));
+			data |= 0x18; /* p3 */
+			ocp_reg_write(tp, 0xd068, data);
+			ocp_reg_write(tp, 0xd06a,
+				      (swap_b & ~0x7ff) | (swap_a & 0x7ff));
+			data &= ~0x18;
+			data |= 0x08; /* p1 */
+			ocp_reg_write(tp, 0xd068, data);
+			swap_a = ocp_reg_read(tp, 0xd06a);
+			data &= ~0x18;
+			data |= 0x10; /* p2 */
+			ocp_reg_write(tp, 0xd068, data);
+			swap_b = ocp_reg_read(tp, 0xd06a);
+			data &= ~0x18;
+			data |= 0x08; /* p1 */
+			ocp_reg_write(tp, 0xd068, data);
+			ocp_reg_write(tp, 0xd06a,
+				      (swap_a & ~0x7ff) | (swap_b & 0x7ff));
+			data &= ~0x18;
+			data |= 0x10; /* p2 */
+			ocp_reg_write(tp, 0xd068, data);
+			ocp_reg_write(tp, 0xd06a,
+				      (swap_b & ~0x7ff) | (swap_a & 0x7ff));
+			swap_a = ocp_reg_read(tp, 0xbd5a);
+			swap_b = ocp_reg_read(tp, 0xbd5c);
+			ocp_reg_write(tp, 0xbd5a, (swap_a & ~0x1f1f) |
+				      ((swap_b & 0x1f) << 8) |
+				      ((swap_b >> 8) & 0x1f));
+			ocp_reg_write(tp, 0xbd5c, (swap_b & ~0x1f1f) |
+				      ((swap_a & 0x1f) << 8) |
+				      ((swap_a >> 8) & 0x1f));
+			swap_a = ocp_reg_read(tp, 0xbc18);
+			swap_b = ocp_reg_read(tp, 0xbc1a);
+			ocp_reg_write(tp, 0xbc18, (swap_a & ~0x1f1f) |
+				      ((swap_b & 0x1f) << 8) |
+				      ((swap_b >> 8) & 0x1f));
+			ocp_reg_write(tp, 0xbc1a, (swap_b & ~0x1f1f) |
+				      ((swap_a & 0x1f) << 8) |
+				      ((swap_a >> 8) & 0x1f));
+		}
+
+		/* Notify the MAC when the speed is changed to force mode. */
+		ocp_reg_set_bits(tp, OCP_INTR_EN, INTR_SPEED_FORCE);
+		break;
+	default:
+		break;
+	}
+
+	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
+	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0));
+}
+
+static void r8156b_hw_phy_cfg(struct r8152 *tp)
+{
+	u16 data;
+
+	r8156_patch_code(tp);
+
+	switch (tp->version) {
+	case RTL_VER_12:
+		ocp_reg_write(tp, 0xbf86, 0x9000);
+		ocp_reg_set_bits(tp, 0xc402, BIT(10));
+		ocp_reg_clr_bits(tp, 0xc402, BIT(10));
+		ocp_reg_write(tp, 0xbd86, 0x1010);
+		ocp_reg_write(tp, 0xbd88, 0x1010);
+		ocp_reg_w0w1(tp, 0xbd4e, BIT(10) | BIT(11), BIT(11));
+		ocp_reg_w0w1(tp, 0xbf46, 0xf00, 0x700);
+		break;
+	case RTL_VER_13:
+	case RTL_VER_15:
+		r8156b_wait_loading_flash(tp);
+		break;
+	default:
+		break;
+	}
+
+	ocp_word_test_and_clr_bits(tp, MCU_TYPE_USB, USB_MISC_0, PCUT_STATUS);
+
+	data = r8153_phy_status(tp, 0);
+	switch (data) {
+	case PHY_STAT_EXT_INIT:
+		r8156_ram_code(tp, true);
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		break;
+	case PHY_STAT_LAN_ON:
+	case PHY_STAT_PWRDN:
+	default:
+		r8156_ram_code(tp, false);
+		break;
+	}
+
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
+
+	/* disable ALDPS before updating the PHY parameters */
+	r8153_disable_aldps(tp);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PHY_PWR, PFM_PWM_SWITCH);
+
+	switch (tp->version) {
+	case RTL_VER_12:
+		ocp_reg_set_bits(tp, 0xbc08, BIT(3) | BIT(2));
+
+		sram_write_w0w1(tp, 0x8fff, 0xff00, 0x0400);
+
+		ocp_reg_set_bits(tp, 0xacda, 0xff00);
+		ocp_reg_set_bits(tp, 0xacde, 0xf000);
+		ocp_reg_write(tp, 0xac8c, 0x0ffc);
+		ocp_reg_write(tp, 0xac46, 0xb7b4);
+		ocp_reg_write(tp, 0xac50, 0x0fbc);
+		ocp_reg_write(tp, 0xac3c, 0x9240);
+		ocp_reg_write(tp, 0xac4e, 0x0db4);
+		ocp_reg_write(tp, 0xacc6, 0x0707);
+		ocp_reg_write(tp, 0xacc8, 0xa0d3);
+		ocp_reg_write(tp, 0xad08, 0x0007);
+
+		ocp_reg_write(tp, 0xb87c, 0x8560);
+		ocp_reg_write(tp, 0xb87e, 0x19cc);
+		ocp_reg_write(tp, 0xb87c, 0x8562);
+		ocp_reg_write(tp, 0xb87e, 0x19cc);
+		ocp_reg_write(tp, 0xb87c, 0x8564);
+		ocp_reg_write(tp, 0xb87e, 0x19cc);
+		ocp_reg_write(tp, 0xb87c, 0x8566);
+		ocp_reg_write(tp, 0xb87e, 0x147d);
+		ocp_reg_write(tp, 0xb87c, 0x8568);
+		ocp_reg_write(tp, 0xb87e, 0x147d);
+		ocp_reg_write(tp, 0xb87c, 0x856a);
+		ocp_reg_write(tp, 0xb87e, 0x147d);
+		ocp_reg_write(tp, 0xb87c, 0x8ffe);
+		ocp_reg_write(tp, 0xb87e, 0x0907);
+		ocp_reg_write(tp, 0xb87c, 0x80d6);
+		ocp_reg_write(tp, 0xb87e, 0x2801);
+		ocp_reg_write(tp, 0xb87c, 0x80f2);
+		ocp_reg_write(tp, 0xb87e, 0x2801);
+		ocp_reg_write(tp, 0xb87c, 0x80f4);
+		ocp_reg_write(tp, 0xb87e, 0x6077);
+		ocp_reg_write(tp, 0xb506, 0x01e7);
+
+		ocp_reg_write(tp, 0xb87c, 0x8013);
+		ocp_reg_write(tp, 0xb87e, 0x0700);
+		ocp_reg_write(tp, 0xb87c, 0x8fb9);
+		ocp_reg_write(tp, 0xb87e, 0x2801);
+		ocp_reg_write(tp, 0xb87c, 0x8fba);
+		ocp_reg_write(tp, 0xb87e, 0x0100);
+		ocp_reg_write(tp, 0xb87c, 0x8fbc);
+		ocp_reg_write(tp, 0xb87e, 0x1900);
+		ocp_reg_write(tp, 0xb87c, 0x8fbe);
+		ocp_reg_write(tp, 0xb87e, 0xe100);
+		ocp_reg_write(tp, 0xb87c, 0x8fc0);
+		ocp_reg_write(tp, 0xb87e, 0x0800);
+		ocp_reg_write(tp, 0xb87c, 0x8fc2);
+		ocp_reg_write(tp, 0xb87e, 0xe500);
+		ocp_reg_write(tp, 0xb87c, 0x8fc4);
+		ocp_reg_write(tp, 0xb87e, 0x0f00);
+		ocp_reg_write(tp, 0xb87c, 0x8fc6);
+		ocp_reg_write(tp, 0xb87e, 0xf100);
+		ocp_reg_write(tp, 0xb87c, 0x8fc8);
+		ocp_reg_write(tp, 0xb87e, 0x0400);
+		ocp_reg_write(tp, 0xb87c, 0x8fca);
+		ocp_reg_write(tp, 0xb87e, 0xf300);
+		ocp_reg_write(tp, 0xb87c, 0x8fcc);
+		ocp_reg_write(tp, 0xb87e, 0xfd00);
+		ocp_reg_write(tp, 0xb87c, 0x8fce);
+		ocp_reg_write(tp, 0xb87e, 0xff00);
+		ocp_reg_write(tp, 0xb87c, 0x8fd0);
+		ocp_reg_write(tp, 0xb87e, 0xfb00);
+		ocp_reg_write(tp, 0xb87c, 0x8fd2);
+		ocp_reg_write(tp, 0xb87e, 0x0100);
+		ocp_reg_write(tp, 0xb87c, 0x8fd4);
+		ocp_reg_write(tp, 0xb87e, 0xf400);
+		ocp_reg_write(tp, 0xb87c, 0x8fd6);
+		ocp_reg_write(tp, 0xb87e, 0xff00);
+		ocp_reg_write(tp, 0xb87c, 0x8fd8);
+		ocp_reg_write(tp, 0xb87e, 0xf600);
+
+		ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_USB_CFG,
+				  EN_XG_LIP | EN_G_LIP);
+		ocp_reg_write(tp, 0xb87c, 0x813d);
+		ocp_reg_write(tp, 0xb87e, 0x390e);
+		ocp_reg_write(tp, 0xb87c, 0x814f);
+		ocp_reg_write(tp, 0xb87e, 0x790e);
+		ocp_reg_write(tp, 0xb87c, 0x80b0);
+		ocp_reg_write(tp, 0xb87e, 0x0f31);
+		ocp_reg_set_bits(tp, 0xbf4c, BIT(1));
+		ocp_reg_set_bits(tp, 0xbcca, BIT(9) | BIT(8));
+		ocp_reg_write(tp, 0xb87c, 0x8141);
+		ocp_reg_write(tp, 0xb87e, 0x320e);
+		ocp_reg_write(tp, 0xb87c, 0x8153);
+		ocp_reg_write(tp, 0xb87e, 0x720e);
+		ocp_reg_write(tp, 0xb87c, 0x8529);
+		ocp_reg_write(tp, 0xb87e, 0x050e);
+		ocp_reg_clr_bits(tp, OCP_EEE_CFG, CTAP_SHORT_EN);
+
+		sram_write(tp, 0x816c, 0xc4a0);
+		sram_write(tp, 0x8170, 0xc4a0);
+		sram_write(tp, 0x8174, 0x04a0);
+		sram_write(tp, 0x8178, 0x04a0);
+		sram_write(tp, 0x817c, 0x0719);
+		sram_write(tp, 0x8ff4, 0x0400);
+		sram_write(tp, 0x8ff1, 0x0404);
+
+		ocp_reg_write(tp, 0xbf4a, 0x001b);
+		ocp_reg_write(tp, 0xb87c, 0x8033);
+		ocp_reg_write(tp, 0xb87e, 0x7c13);
+		ocp_reg_write(tp, 0xb87c, 0x8037);
+		ocp_reg_write(tp, 0xb87e, 0x7c13);
+		ocp_reg_write(tp, 0xb87c, 0x803b);
+		ocp_reg_write(tp, 0xb87e, 0xfc32);
+		ocp_reg_write(tp, 0xb87c, 0x803f);
+		ocp_reg_write(tp, 0xb87e, 0x7c13);
+		ocp_reg_write(tp, 0xb87c, 0x8043);
+		ocp_reg_write(tp, 0xb87e, 0x7c13);
+		ocp_reg_write(tp, 0xb87c, 0x8047);
+		ocp_reg_write(tp, 0xb87e, 0x7c13);
+
+		ocp_reg_write(tp, 0xb87c, 0x8145);
+		ocp_reg_write(tp, 0xb87e, 0x370e);
+		ocp_reg_write(tp, 0xb87c, 0x8157);
+		ocp_reg_write(tp, 0xb87e, 0x770e);
+		ocp_reg_write(tp, 0xb87c, 0x8169);
+		ocp_reg_write(tp, 0xb87e, 0x0d0a);
+		ocp_reg_write(tp, 0xb87c, 0x817b);
+		ocp_reg_write(tp, 0xb87e, 0x1d0a);
+
+		sram_write_w0w1(tp, 0x8217, 0xff00, 0x5000);
+		sram_write_w0w1(tp, 0x821a, 0xff00, 0x5000);
+		sram_write(tp, 0x80da, 0x0403);
+		sram_write_w0w1(tp, 0x80dc, 0xff00, 0x1000);
+		sram_write(tp, 0x80b3, 0x0384);
+		sram_write(tp, 0x80b7, 0x2007);
+		sram_write_w0w1(tp, 0x80ba, 0xff00, 0x6c00);
+		sram_write(tp, 0x80b5, 0xf009);
+		sram_write_w0w1(tp, 0x80bd, 0xff00, 0x9f00);
+		sram_write(tp, 0x80c7, 0xf083);
+		sram_write(tp, 0x80dd, 0x03f0);
+		sram_write_w0w1(tp, 0x80df, 0xff00, 0x1000);
+		sram_write(tp, 0x80cb, 0x2007);
+		sram_write_w0w1(tp, 0x80ce, 0xff00, 0x6c00);
+		sram_write(tp, 0x80c9, 0x8009);
+		sram_write_w0w1(tp, 0x80d1, 0xff00, 0x8000);
+		sram_write(tp, 0x80a3, 0x200a);
+		sram_write(tp, 0x80a5, 0xf0ad);
+		sram_write(tp, 0x809f, 0x6073);
+		sram_write(tp, 0x80a1, 0x000b);
+		sram_write_w0w1(tp, 0x80a9, 0xff00, 0xc000);
+
+		if (rtl_phy_patch_request(tp, true, true))
+			return;
+
+		ocp_reg_clr_bits(tp, 0xb896, BIT(0));
+		ocp_reg_clr_bits(tp, 0xb892, 0xff00);
+		ocp_reg_write(tp, 0xb88e, 0xc23e);
+		ocp_reg_write(tp, 0xb890, 0x0000);
+		ocp_reg_write(tp, 0xb88e, 0xc240);
+		ocp_reg_write(tp, 0xb890, 0x0103);
+		ocp_reg_write(tp, 0xb88e, 0xc242);
+		ocp_reg_write(tp, 0xb890, 0x0507);
+		ocp_reg_write(tp, 0xb88e, 0xc244);
+		ocp_reg_write(tp, 0xb890, 0x090b);
+		ocp_reg_write(tp, 0xb88e, 0xc246);
+		ocp_reg_write(tp, 0xb890, 0x0c0e);
+		ocp_reg_write(tp, 0xb88e, 0xc248);
+		ocp_reg_write(tp, 0xb890, 0x1012);
+		ocp_reg_write(tp, 0xb88e, 0xc24a);
+		ocp_reg_write(tp, 0xb890, 0x1416);
+		ocp_reg_set_bits(tp, 0xb896, BIT(0));
+
+		rtl_phy_patch_request(tp, false, true);
+
+		ocp_reg_set_bits(tp, 0xa86a, BIT(0));
+		ocp_reg_set_bits(tp, 0xa6f0, BIT(0));
+
+		ocp_reg_write(tp, 0xbfa0, 0xd70d);
+		ocp_reg_write(tp, 0xbfa2, 0x4100);
+		ocp_reg_write(tp, 0xbfa4, 0xe868);
+		ocp_reg_write(tp, 0xbfa6, 0xdc59);
+		ocp_reg_write(tp, 0xb54c, 0x3c18);
+		ocp_reg_clr_bits(tp, 0xbfa4, BIT(5));
+		sram_set_bits(tp, 0x817d, BIT(12));
+		break;
+	case RTL_VER_13:
+		/* 2.5G INRX */
+		ocp_reg_w0w1(tp, 0xac46, 0x00f0, 0x0090);
+		ocp_reg_w0w1(tp, 0xad30, 0x0003, 0x0001);
+		fallthrough;
+	case RTL_VER_15:
+		/* EEE parameter */
+		ocp_reg_write(tp, 0xb87c, 0x80f5);
+		ocp_reg_write(tp, 0xb87e, 0x760e);
+		ocp_reg_write(tp, 0xb87c, 0x8107);
+		ocp_reg_write(tp, 0xb87e, 0x360e);
+		ocp_reg_write(tp, 0xb87c, 0x8551);
+		ocp_reg_w0w1(tp, 0xb87e, 0xff00, 0x0800);
+
+		/* ADC_PGA parameter */
+		ocp_reg_w0w1(tp, 0xbf00, 0xe000, 0xa000);
+		ocp_reg_w0w1(tp, 0xbf46, 0x0f00, 0x0300);
+
+		/* Green Table-PGA, 1G full viterbi */
+		sram_write(tp, 0x8044, 0x2417);
+		sram_write(tp, 0x804a, 0x2417);
+		sram_write(tp, 0x8050, 0x2417);
+		sram_write(tp, 0x8056, 0x2417);
+		sram_write(tp, 0x805c, 0x2417);
+		sram_write(tp, 0x8062, 0x2417);
+		sram_write(tp, 0x8068, 0x2417);
+		sram_write(tp, 0x806e, 0x2417);
+		sram_write(tp, 0x8074, 0x2417);
+		sram_write(tp, 0x807a, 0x2417);
+
+		/* Nway DACONB parameter */
+		ocp_reg_w0w1(tp, 0xa4ca, 0x6000, 0x0040);
+
+		/* XG PLL */
+		ocp_reg_w0w1(tp, 0xbf84, 0xe000, 0xa000);
+		break;
+	default:
+		break;
+	}
+
+	/* Notify the MAC when the speed is changed to force mode. */
+	ocp_reg_set_bits(tp, OCP_INTR_EN, INTR_SPEED_FORCE);
+
+	if (rtl_phy_patch_request(tp, true, true))
+		return;
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4, EEE_SPDWN_EN);
+
+	ocp_reg_w0w1(tp, OCP_DOWN_SPEED, EN_EEE_100 | EN_EEE_1000,
+		     EN_10M_CLKDIV);
+
+	ocp_reg_clr_bits(tp, OCP_POWER_CFG, EEE_CLKDIV_EN);
+
+	rtl_phy_patch_request(tp, false, true);
+
+	ocp_reg_clr_bits(tp, 0xa428, BIT(9));
+	ocp_reg_clr_bits(tp, 0xa5ea, BIT(0));
+}
+
 static void r8153_first_init(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -1103,14 +1896,79 @@ static void r8153_enter_oob(struct r8152 *tp)
 	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RCR, ocp_data);
 }
 
-static void r8153_disable_aldps(struct r8152 *tp)
+static void r8156_exit_oob(struct r8152 *tp)
 {
-	u16 data;
+	rxdy_gated_en(tp, true);
+	r8153_teredo_off(tp);
 
-	data = ocp_reg_read(tp, OCP_POWER_CFG);
-	data &= ~EN_ALDPS;
-	ocp_reg_write(tp, OCP_POWER_CFG, data);
-	mdelay(20);
+	ocp_dword_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, RCR_ACPT_ALL);
+
+	r8153_hw_phy_cfg(tp);
+
+	rtl8152_nic_reset(tp);
+	rtl_reset_bmu(tp);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
+
+	rtl_rx_vlan_en(tp, false);
+
+	switch (tp->version) {
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_BMU_CONFIG,
+				  ACT_ODMA);
+		break;
+	default:
+		break;
+	}
+
+	/* share FIFO settings */
+	ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, RXFIFO_FULL_MASK,
+		      0x08);
+
+	/* TX share fifo free credit full threshold */
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_CTRL, 512 / 64);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_FULL, 2048 / 8);
+
+	r8153b_mcu_spdown_en(tp, false);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
+			RG_PWRDN_EN | ALL_SPEED_OFF);
+
+	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
+}
+
+static void r8156_enter_oob(struct r8152 *tp)
+{
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL, NOW_IS_OOB);
+
+	/* RX FIFO settings for OOB */
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, 64 / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, 1024 / 16);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, 4096 / 16);
+
+	rtl_disable(tp);
+	rtl_reset_bmu(tp);
+
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_BDC_CR, ALDPS_PROXY_MODE);
+
+	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_OOB_CTRL,
+			NOW_IS_OOB | DIS_MCU_CLROOB);
+
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_SFF_STS_7, MCU_BORW_EN);
+
+	rtl_rx_vlan_en(tp, false);
+
+	rxdy_gated_en(tp, false);
+
+	ocp_dword_set_bits(tp, MCU_TYPE_PLA, PLA_RCR,
+			   RCR_APM | RCR_AM | RCR_AB);
 }
 
 static void rtl8153_disable(struct r8152 *tp)
@@ -1120,9 +1978,34 @@ static void rtl8153_disable(struct r8152 *tp)
 	rtl_reset_bmu(tp);
 }
 
+static void rtl8156_disable(struct r8152 *tp)
+{
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_FULL, 0);
+	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RX_FIFO_EMPTY, 0);
+
+	rtl8153_disable(tp);
+}
+
+static u16 rtl8152_get_support_speed(struct r8152 *tp)
+{
+	switch (tp->version) {
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
+	case RTL_VER_12:
+	case RTL_VER_13:
+		return SPEED_2500;
+	default:
+		if (tp->supports_gmii)
+			return SPEED_1000;
+		else
+			return SPEED_100;
+	}
+}
+
 static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u16 speed, u8 duplex)
 {
-	u16 bmcr, anar, gbcr;
+	u16 bmcr, anar, gbcr, gbcr2;
 
 	anar = r8152_mdio_read(tp, MII_ADVERTISE);
 	anar &= ~(ADVERTISE_10HALF | ADVERTISE_10FULL |
@@ -1134,6 +2017,14 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u16 speed, u8 duplex)
 		gbcr = 0;
 	}
 
+	if (tp->supports_xgmii) {
+		gbcr2 = ocp_reg_read(tp, OCP_10GBT_CTRL);
+		gbcr2 &= ~(MDIO_AN_10GBT_CTRL_ADV2_5G |
+			   MDIO_AN_10GBT_CTRL_ADV5G);
+	} else {
+		gbcr2 = 0;
+	}
+
 	if (autoneg == AUTONEG_DISABLE) {
 		if (speed == SPEED_10) {
 			bmcr = 0;
@@ -1141,7 +2032,8 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u16 speed, u8 duplex)
 		} else if (speed == SPEED_100) {
 			bmcr = BMCR_SPEED100;
 			anar |= ADVERTISE_100HALF | ADVERTISE_100FULL;
-		} else if (speed == SPEED_1000 && tp->supports_gmii) {
+		} else if (speed == SPEED_1000 &&
+			   rtl8152_get_support_speed(tp) >= SPEED_1000) {
 			bmcr = BMCR_SPEED1000;
 			gbcr |= ADVERTISE_1000FULL | ADVERTISE_1000HALF;
 		} else {
@@ -1164,7 +2056,8 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u16 speed, u8 duplex)
 				anar |= ADVERTISE_10HALF;
 				anar |= ADVERTISE_100HALF;
 			}
-		} else if (speed == SPEED_1000 && tp->supports_gmii) {
+		} else if (speed == SPEED_1000 &&
+			   rtl8152_get_support_speed(tp) >= SPEED_1000) {
 			if (duplex == DUPLEX_FULL) {
 				anar |= ADVERTISE_10HALF | ADVERTISE_10FULL;
 				anar |= ADVERTISE_100HALF | ADVERTISE_100FULL;
@@ -1174,6 +2067,18 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u16 speed, u8 duplex)
 				anar |= ADVERTISE_100HALF;
 				gbcr |= ADVERTISE_1000HALF;
 			}
+		} else if (speed == SPEED_2500 &&
+			   rtl8152_get_support_speed(tp) >= SPEED_2500) {
+			if (duplex == DUPLEX_FULL) {
+				anar |= ADVERTISE_10HALF | ADVERTISE_10FULL;
+				anar |= ADVERTISE_100HALF | ADVERTISE_100FULL;
+				gbcr |= ADVERTISE_1000FULL | ADVERTISE_1000HALF;
+				gbcr2|= MDIO_AN_10GBT_CTRL_ADV2_5G;
+			} else {
+				anar |= ADVERTISE_10HALF;
+				anar |= ADVERTISE_100HALF;
+				gbcr |= ADVERTISE_1000HALF;
+			}
 		} else {
 			return -EINVAL;
 		}
@@ -1184,6 +2089,9 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u16 speed, u8 duplex)
 	if (tp->supports_gmii)
 		r8152_mdio_write(tp, MII_CTRL1000, gbcr);
 
+	if (tp->supports_xgmii)
+		ocp_reg_write(tp, OCP_10GBT_CTRL, gbcr2);
+
 	r8152_mdio_write(tp, MII_ADVERTISE, anar);
 	r8152_mdio_write(tp, MII_BMCR, bmcr);
 
@@ -1232,6 +2140,25 @@ static void rtl8153b_down(struct r8152 *tp)
 	r8153_enter_oob(tp);
 }
 
+static void rtl8156_up(struct r8152 *tp)
+{
+	r8156_exit_oob(tp);
+}
+
+static void rtl8156_down(struct r8152 *tp)
+{
+	r8156_enter_oob(tp);
+}
+
+static void r8156_mdio_force_mode(struct r8152 *tp)
+{
+	/* Select force mode through 0xa5b4 bit 15
+	 * 0: MDIO force mode
+	 * 1: MMD force mode
+	 */
+	ocp_reg_clr_bits(tp, 0xa5b4, BIT(15));
+}
+
 static void r8152b_get_version(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -1245,7 +2172,8 @@ static void r8152b_get_version(struct r8152 *tp)
 		if (tcr == r8152_versions[i].tcr) {
 			/* Found a supported version */
 			tp->version = r8152_versions[i].version;
-			tp->supports_gmii = r8152_versions[i].gmii;
+			tp->supports_gmii = r8152_versions[i].supports_gmii;
+			tp->supports_xgmii = r8152_versions[i].supports_xgmii;
 			break;
 		}
 	}
@@ -1422,13 +2350,9 @@ static void r8153b_init(struct r8152 *tp)
 	r8153_power_cut_en(tp, false);
 
 	/* MAC clock speed down */
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2);
-	ocp_data |= MAC_CLK_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL2, ocp_data);
+	r8153_mac_clk_speed_down(tp, false);
 
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
-	ocp_data &= ~PLA_MCU_SPDWN_EN;
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
+	r8153b_mcu_spdown_en(tp, false);
 
 	if (tp->version == RTL_VER_09) {
 		/* Disable Test IO for 32QFN */
@@ -1439,7 +2363,7 @@ static void r8153b_init(struct r8152 *tp)
 		}
 	}
 
-	/* rx aggregation */
+	/* enable rx aggregation */
 	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
 	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
 	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
@@ -1449,6 +2373,126 @@ static void r8153b_init(struct r8152 *tp)
 	r8152b_enable_fc(tp);
 }
 
+static void r8156_init(struct r8152 *tp)
+{
+	u32 ocp_data;
+	int i;
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
+	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION, BYPASS_MAC_RESET);
+
+	r8153_disable_aldps(tp);
+	r8153b_u1u2en(tp, false);
+
+	r8152_wait_for_bit(tp, 0, MCU_TYPE_PLA, PLA_BOOT_CTRL,
+			   AUTOLOAD_DONE, 1, R8152_WAIT_TIMEOUT);
+
+	for (i = 0; i < R8152_WAIT_TIMEOUT; i++) {
+		ocp_data = ocp_reg_read(tp, OCP_PHY_STATUS) & PHY_STAT_MASK;
+		if (ocp_data == PHY_STAT_LAN_ON || ocp_data == PHY_STAT_PWRDN)
+			break;
+
+		mdelay(1);
+	}
+
+	r8153_u2p3en(tp, false);
+
+	/* MSC timer = 0xfff * 8ms = 32760 ms */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
+
+	r8153b_power_cut_en(tp, false);
+
+	/* MAC clock speed down */
+	r8156_mac_clk_spd(tp, false);
+
+	r8153b_mcu_spdown_en(tp, false);
+
+	/* enable rx aggregation */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_ZERO_EN);
+
+	rtl_tally_reset(tp);
+	r8156_hw_phy_cfg(tp);
+	r8152b_enable_fc(tp);
+}
+
+static void r8156b_init(struct r8152 *tp)
+{
+	u32 ocp_data;
+	u16 data;
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_ECM_OP, EN_ALL_SPEED);
+	ocp_write_word(tp, MCU_TYPE_USB, USB_SPEED_OPTION, 0);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_ECM_OPTION,
+			  BYPASS_MAC_RESET);
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, RX_DETECT8);
+
+	r8153_disable_aldps(tp);
+	r8153b_u1u2en(tp, false);
+
+	switch (tp->version) {
+	case RTL_VER_13:
+	case RTL_VER_15:
+		r8156b_wait_loading_flash(tp);
+		break;
+	default:
+		break;
+	}
+
+	r8152_wait_for_bit(tp, 0, MCU_TYPE_PLA, PLA_BOOT_CTRL,
+			   AUTOLOAD_DONE, 1, R8152_WAIT_TIMEOUT);
+
+	data = r8153_phy_status(tp, 0);
+	if (data == PHY_STAT_EXT_INIT) {
+		ocp_reg_clr_bits(tp, 0xa468, BIT(3) | BIT(1));
+		ocp_reg_clr_bits(tp, 0xa466, BIT(0));
+	}
+
+	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
+
+	r8153_phy_status(tp, PHY_STAT_LAN_ON);
+
+	r8153_u2p3en(tp, false);
+
+	/* MSC timer = 0xfff * 8ms = 32760 ms */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
+
+	r8153b_power_cut_en(tp, false);
+
+	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
+
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
+
+	/* enable fc timer and set timer to 600 ms. */
+	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
+		       CTRL_TIMER_EN | (600 / 8));
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL);
+	if (!(ocp_data & DACK_DET_EN))
+		ocp_word_w0w1(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP,
+			      FLOW_CTRL_PATCH_2);
+	else
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
+				  AUTO_SPEEDUP);
+
+	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+
+	r8156_mac_clk_spd(tp, false);
+
+	r8153b_mcu_spdown_en(tp, false);
+
+	/* rx aggregation */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			RX_AGG_DISABLE | RX_ZERO_EN);
+
+	r8156_mdio_force_mode(tp);
+
+	rtl_tally_reset(tp);
+	r8156b_hw_phy_cfg(tp);
+	r8152b_enable_fc(tp);
+}
+
 static void rtl8152_unload(struct r8152 *tp)
 {
 	if (tp->version != RTL_VER_01)
@@ -1498,6 +2542,26 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->down		= rtl8153b_down;
 		break;
 
+	case RTL_TEST_01:
+	case RTL_VER_10:
+	case RTL_VER_11:
+		ops->init		= r8156_init;
+		ops->enable		= rtl8156_enable;
+		ops->disable		= rtl8156_disable;
+		ops->up			= rtl8156_up;
+		ops->down		= rtl8156_down;
+		break;
+
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+		ops->init		= r8156b_init;
+		ops->enable		= rtl8156_enable;
+		ops->disable		= rtl8156_disable;
+		ops->up			= rtl8156_up;
+		ops->down		= rtl8156_down;
+		break;
+
 	default:
 		ret = -ENODEV;
 		printf("r8152 Unknown Device\n");
@@ -1690,7 +2754,7 @@ static int r8152_eth_probe(struct udevice *dev)
 	tp->rtl_ops.up(tp);
 
 	rtl8152_set_speed(tp, AUTONEG_ENABLE,
-			  tp->supports_gmii ? SPEED_1000 : SPEED_100,
+			  rtl8152_get_support_speed(tp),
 			  DUPLEX_FULL);
 
 	return usb_ether_register(dev, ueth, RTL8152_AGG_BUF_SZ);
@@ -1720,6 +2784,8 @@ static const struct usb_device_id r8152_eth_id_table[] = {
 	{ USB_DEVICE(0x0bda, 0x8050) },
 	{ USB_DEVICE(0x0bda, 0x8152) },
 	{ USB_DEVICE(0x0bda, 0x8153) },
+	{ USB_DEVICE(0x0bda, 0x8155) },
+	{ USB_DEVICE(0x0bda, 0x8156) },
 
 	/* Samsung */
 	{ USB_DEVICE(0x04e8, 0xa101) },
diff --git a/drivers/usb/eth/r8152.h b/drivers/usb/eth/r8152.h
index 7b128b1934..46ae698191 100644
--- a/drivers/usb/eth/r8152.h
+++ b/drivers/usb/eth/r8152.h
@@ -12,10 +12,14 @@
 
 #define PLA_IDR			0xc000
 #define PLA_RCR			0xc010
+#define PLA_RCR1		0xc012
 #define PLA_RMS			0xc016
 #define PLA_RXFIFO_CTRL0	0xc0a0
+#define PLA_RXFIFO_FULL		0xc0a2
 #define PLA_RXFIFO_CTRL1	0xc0a4
+#define PLA_RX_FIFO_FULL	0xc0a6
 #define PLA_RXFIFO_CTRL2	0xc0a8
+#define PLA_RX_FIFO_EMPTY	0xc0aa
 #define PLA_DMY_REG0		0xc0b0
 #define PLA_FMC			0xc0b4
 #define PLA_CFG_WOL		0xc0b6
@@ -26,6 +30,8 @@
 #define PLA_TEREDO_TIMER	0xd2cc
 #define PLA_REALWOW_TIMER	0xd2e8
 #define PLA_EXTRA_STATUS	0xd398
+#define PLA_GPHY_CTRL		0xd3ae
+#define PLA_POL_GPIO_CTRL	0xdc6a
 #define PLA_EFUSE_DATA		0xdd00
 #define PLA_EFUSE_CMD		0xdd02
 #define PLA_LEDSEL		0xdd90
@@ -34,6 +40,7 @@
 #define PLA_BOOT_CTRL		0xe004
 #define PLA_GPHY_INTR_IMR	0xe022
 #define PLA_EEE_CR		0xe040
+#define PLA_EEE_TXTWSYS_2P5G	0xe058
 #define PLA_EEEP_CR		0xe080
 #define PLA_MAC_PWR_CTRL	0xe0c0
 #define PLA_MAC_PWR_CTRL2	0xe0ca
@@ -44,6 +51,7 @@
 #define PLA_TCR1		0xe612
 #define PLA_MTPS		0xe615
 #define PLA_TXFIFO_CTRL		0xe618
+#define PLA_TXFIFO_FULL		0xe61a
 #define PLA_RSTTALLY		0xe800
 #define BIST_CTRL		0xe810
 #define PLA_CR			0xe813
@@ -60,6 +68,7 @@
 #define PLA_TALLYCNT		0xe890
 #define PLA_SFF_STS_7		0xe8de
 #define PLA_PHYSTATUS		0xe908
+#define PLA_USB_CFG		0xe952
 #define PLA_BP_BA		0xfc26
 #define PLA_BP_0		0xfc28
 #define PLA_BP_1		0xfc2a
@@ -79,9 +88,19 @@
 #define USB_DEV_STAT		0xb808
 #define USB_CONNECT_TIMER	0xcbf8
 #define USB_MSC_TIMER		0xcbfc
+#define USB_OUTER_FW_VER	0xcd54
 #define USB_BURST_SIZE		0xcfc0
 #define USB_FW_FIX_EN1		0xcfcc
+#define USB_FW_PLA_VER		0xcfd6
+#define USB_FW_USB_VER		0xcfd7
 #define USB_LPM_CONFIG		0xcfd8
+#define USB_ECM_OPTION		0xcfee
+#define USB_ECM_OP		0xd26b
+#define USB_GPHY_CTRL		0xd284
+#define USB_SPEED_OPTION	0xd32a
+#define USB_FW_CTRL		0xd334	/* RTL8153B */
+#define USB_FC_TIMER		0xd340
+#define USB_OUTSIDE_FW_VER	0xd3cc
 #define USB_USB_CTRL		0xd406
 #define USB_PHY_CTRL		0xd408
 #define USB_TX_AGG		0xd40a
@@ -93,10 +112,13 @@
 #define USB_RX_EXTRA_AGGR_TMR	0xd432	/* RTL8153B */
 #define USB_TX_DMA		0xd434
 #define USB_UPT_RXDMA_OWN	0xd437
+#define USB_UPHY3_MDCMDIO	0xd480
 #define USB_TOLERANCE		0xd490
 #define USB_LPM_CTRL		0xd41a
 #define USB_BMU_RESET		0xd4b0
+#define USB_BMU_CONFIG		0xd4b4
 #define USB_U1U2_TIMER		0xd4da
+#define USB_FW_TASK		0xd4e8	/* RTL8153B */
 #define USB_UPS_CTRL		0xd800
 #define USB_POWER_CUT		0xd80a
 #define USB_MISC_0		0xd81a
@@ -105,7 +127,23 @@
 #define USB_WDT11_CTRL		0xe43c
 #define USB_BP_BA		PLA_BP_BA
 #define USB_BP(n)		(0xfc28 + 2 * (n))
+#define USB_BP_0		PLA_BP_0
+#define USB_BP_1		PLA_BP_1
+#define USB_BP_2		PLA_BP_2
+#define USB_BP_3		PLA_BP_3
+#define USB_BP_4		PLA_BP_4
+#define USB_BP_5		PLA_BP_5
+#define USB_BP_6		PLA_BP_6
+#define USB_BP_7		PLA_BP_7
 #define USB_BP_EN		PLA_BP_EN	/* RTL8153A */
+#define USB_BP_8		0xfc38		/* RTL8153B */
+#define USB_BP_9		0xfc3a
+#define USB_BP_10		0xfc3c
+#define USB_BP_11		0xfc3e
+#define USB_BP_12		0xfc40
+#define USB_BP_13		0xfc42
+#define USB_BP_14		0xfc44
+#define USB_BP_15		0xfc46
 #define USB_BP2_EN		0xfc48
 
 /* OCP Registers */
@@ -117,6 +155,7 @@
 #define OCP_EEE_AR		0xa41a
 #define OCP_EEE_DATA		0xa41c
 #define OCP_PHY_STATUS		0xa420
+#define OCP_INTR_EN		0xa424
 #define OCP_NCTL_CFG		0xa42c
 #define OCP_POWER_CFG		0xa430
 #define OCP_EEE_CFG		0xa432
@@ -126,16 +165,24 @@
 #define OCP_EEE_ABLE		0xa5c4
 #define OCP_EEE_ADV		0xa5d0
 #define OCP_EEE_LPABLE		0xa5d2
+#define OCP_10GBT_CTRL		0xa5d4
+#define OCP_EEE_ADV2		0xa6d4
 #define OCP_PHY_STATE		0xa708		/* nway state for 8153 */
+#define OCP_PHY_PATCH_STAT	0xb800
+#define OCP_PHY_PATCH_CMD	0xb820
+#define OCP_PHY_LOCK		0xb82e
 #define OCP_ADC_IOFFSET		0xbcfc
 #define OCP_ADC_CFG		0xbc06
+#define OCP_SYSCLK_CFG		0xc416
 
 /* SRAM Register */
 #define SRAM_GREEN_CFG		0x8011
 #define SRAM_LPF_CFG		0x8012
+#define SRAM_GPHY_FW_VER	0x801e
 #define SRAM_10M_AMP1		0x8080
 #define SRAM_10M_AMP2		0x8082
 #define SRAM_IMPEDANCE		0x8084
+#define SRAM_PHY_LOCK		0xb82e
 
 /* PLA_RCR */
 #define RCR_AAP			0x00000001
@@ -143,11 +190,19 @@
 #define RCR_AM			0x00000004
 #define RCR_AB			0x00000008
 #define RCR_ACPT_ALL		(RCR_AAP | RCR_APM | RCR_AM | RCR_AB)
+#define SLOT_EN			BIT(11)
+
+/* PLA_RCR1 */
+#define OUTER_VLAN		BIT(7)
+#define INNER_VLAN		BIT(6)
 
 /* PLA_RXFIFO_CTRL0 */
 #define RXFIFO_THR1_NORMAL	0x00080002
 #define RXFIFO_THR1_OOB		0x01800003
 
+/* PLA_RXFIFO_FULL */
+#define RXFIFO_FULL_MASK	0xfff
+
 /* PLA_RXFIFO_CTRL1 */
 #define RXFIFO_THR2_FULL	0x00000060
 #define RXFIFO_THR2_HIGH	0x00000038
@@ -195,9 +250,6 @@
 #define PLA_CR_RE		0x08
 #define PLA_CR_TE		0x04
 
-/* PLA_BIST_CTRL */
-#define BIST_CTRL_SW_RESET (0x10 << 24)
-
 /* PLA_CRWECR */
 #define CRWECR_NORAML		0x00
 #define CRWECR_CONFIG		0xc0
@@ -223,6 +275,7 @@
 #define MCU_BORW_EN		0x4000
 
 /* PLA_CPCR */
+#define FLOW_CTRL_EN		BIT(0)
 #define CPCR_RX_VLAN		0x0040
 
 /* PLA_CFG_WOL */
@@ -245,6 +298,10 @@
 #define LINK_ON_WAKE_EN		0x0010
 #define LINK_OFF_WAKE_EN	0x0008
 
+/* PLA_USB_CFG */
+#define EN_XG_LIP		BIT(1)
+#define EN_G_LIP		BIT(2)
+
 /* PLA_CONFIG5 */
 #define BWF_EN			0x0040
 #define MWF_EN			0x0020
@@ -267,6 +324,7 @@
 /* PLA_MAC_PWR_CTRL2 */
 #define EEE_SPDWN_RATIO		0x8007
 #define MAC_CLK_SPDWN_EN	BIT(15)
+#define EEE_SPDWN_RATIO_MASK	0xff
 
 /* PLA_MAC_PWR_CTRL3 */
 #define PLA_MCU_SPDWN_EN	BIT(14)
@@ -279,6 +337,7 @@
 #define PWRSAVE_SPDWN_EN	0x1000
 #define RXDV_SPDWN_EN		0x0800
 #define TX10MIDLE_EN		0x0100
+#define IDLE_SPDWN_EN		BIT(6)
 #define TP100_SPDWN_EN		0x0020
 #define TP500_SPDWN_EN		0x0010
 #define TP1000_SPDWN_EN		0x0008
@@ -303,6 +362,13 @@
 /* PLA_EXTRA_STATUS */
 #define U3P3_CHECK_EN		BIT(7)
 
+/* PLA_GPHY_CTRL */
+#define GPHY_FLASH		BIT(1)
+
+/* PLA_POL_GPIO_CTRL */
+#define DACK_DET_EN		BIT(15)
+#define POL_GPHY_PATCH		BIT(4)
+
 /* USB_USB2PHY */
 #define USB2PHY_SUSPEND		0x0001
 #define USB2PHY_L1		0x0002
@@ -347,22 +413,53 @@
 #define BMU_RESET_EP_IN		0x01
 #define BMU_RESET_EP_OUT	0x02
 
+/* USB_BMU_CONFIG */
+#define ACT_ODMA		BIT(1)
+
 /* USB_UPT_RXDMA_OWN */
 #define OWN_UPDATE		BIT(0)
 #define OWN_CLEAR		BIT(1)
 
+/* USB_FW_TASK */
+#define FC_PATCH_TASK		BIT(1)
+
 /* USB_UPS_CTRL */
 #define POWER_CUT		0x0100
 
 /* USB_PM_CTRL_STATUS */
 #define RESUME_INDICATE		0x0001
 
+/* USB_ECM_OPTION */
+#define BYPASS_MAC_RESET	BIT(5)
+
+/* USB_ECM_OP */
+#define	EN_ALL_SPEED		BIT(0)
+
+/* USB_GPHY_CTRL */
+#define GPHY_PATCH_DONE		BIT(2)
+#define BYPASS_FLASH		BIT(5)
+#define BACKUP_RESTRORE		BIT(6)
+
+/* USB_SPEED_OPTION */
+#define RG_PWRDN_EN		BIT(8)
+#define ALL_SPEED_OFF		BIT(9)
+
+/* USB_FW_CTRL */
+#define FLOW_CTRL_PATCH_OPT	BIT(1)
+#define AUTO_SPEEDUP		BIT(3)
+#define FLOW_CTRL_PATCH_2	BIT(8)
+
+/* USB_FC_TIMER */
+#define CTRL_TIMER_EN		BIT(15)
+
 /* USB_USB_CTRL */
+#define CDC_ECM_EN		BIT(3)
 #define RX_AGG_DISABLE		0x0010
 #define RX_ZERO_EN		0x0080
 
 /* USB_U2P3_CTRL */
 #define U2P3_ENABLE		0x0001
+#define RX_DETECT8		BIT(3)
 
 /* USB_POWER_CUT */
 #define PWR_EN			0x0001
@@ -395,6 +492,7 @@
 
 /* USB_UPS_CFG */
 #define SAW_CNT_1MS_MASK	0x0fff
+#define MID_REVERSE		BIT(5)	/* RTL8156A */
 
 /* OCP_ALDPS_CONFIG */
 #define ENPWRSAVE		0x8000
@@ -404,9 +502,13 @@
 
 /* OCP_PHY_STATUS */
 #define PHY_STAT_MASK		0x0007
+#define PHY_STAT_EXT_INIT	2
 #define PHY_STAT_LAN_ON		3
 #define PHY_STAT_PWRDN		5
 
+/* OCP_INTR_EN */
+#define INTR_SPEED_FORCE	BIT(3)
+
 /* OCP_NCTL_CFG */
 #define PGA_RETURN_EN		BIT(1)
 
@@ -451,17 +553,37 @@
 #define EEE10_EN		0x0010
 
 /* OCP_DOWN_SPEED */
+#define EN_EEE_CMODE		BIT(14)
+#define EN_EEE_1000		BIT(13)
+#define EN_EEE_100		BIT(12)
+#define EN_10M_CLKDIV		BIT(11)
 #define EN_10M_BGOFF		0x0080
 
+/* OCP_10GBT_CTRL */
+#define RTL_ADV2_5G_F_R		BIT(5)	/* Advertise 2.5GBASE-T fast-retrain */
+
 /* OCP_PHY_STATE */
 #define TXDIS_STATE		0x01
 #define ABD_STATE		0x02
 
+/* OCP_PHY_PATCH_STAT */
+#define PATCH_READY		BIT(6)
+
+/* OCP_PHY_PATCH_CMD */
+#define PATCH_REQUEST		BIT(4)
+
+/* OCP_PHY_LOCK */
+#define PATCH_LOCK		BIT(0)
+
 /* OCP_ADC_CFG */
 #define CKADSEL_L		0x0100
 #define ADC_EN			0x0080
 #define EN_EMI_L		0x0040
 
+/* OCP_SYSCLK_CFG */
+#define sysclk_div_expo(x)	(min(x, 5) << 8)
+#define clk_div_expo(x)		(min(x, 5) << 4)
+
 /* SRAM_GREEN_CFG */
 #define GREEN_ETH_EN		BIT(15)
 #define R_TUNE_EN		BIT(11)
@@ -478,6 +600,9 @@
 /* SRAM_IMPEDANCE */
 #define RX_DRIVING_MASK		0x6000
 
+/* SRAM_PHY_LOCK */
+#define PHY_PATCH_LOCK		0x0001
+
 #define RTL8152_MAX_TX		4
 #define RTL8152_MAX_RX		10
 #define INTBUFSIZE		2
@@ -513,6 +638,7 @@
 #define SPEED_10                10
 #define SPEED_100               100
 #define SPEED_1000              1000
+#define SPEED_2500              2500
 
 #define SPEED_UNKNOWN           -1
 
@@ -612,10 +738,25 @@ enum rtl_version {
 	RTL_VER_07,
 	RTL_VER_08,
 	RTL_VER_09,
+
+	RTL_TEST_01,
+	RTL_VER_10,
+	RTL_VER_11,
+	RTL_VER_12,
+	RTL_VER_13,
+	//RTL_VER_14,
+	RTL_VER_15,
+
 	RTL_VER_MAX
 };
 
 enum rtl_register_content {
+	_5000bps	= BIT(12),
+	_2500bps	= BIT(10),
+	_1250bps	= BIT(9),
+	_500bps		= BIT(8),
+	_tx_flow	= BIT(6),
+	_rx_flow	= BIT(5),
 	_1000bps	= 0x10,
 	_100bps		= 0x08,
 	_10bps		= 0x04,
@@ -627,6 +768,7 @@ struct r8152 {
 	struct usb_device *udev;
 	struct usb_interface *intf;
 	bool supports_gmii;
+	bool supports_xgmii;
 
 	struct rtl_ops {
 		void (*init)(struct r8152 *);
@@ -671,11 +813,23 @@ u16 ocp_reg_read(struct r8152 *tp, u16 addr);
 void ocp_reg_write(struct r8152 *tp, u16 addr, u16 data);
 
 void sram_write(struct r8152 *tp, u16 addr, u16 data);
+u16 sram_read(struct r8152 *tp, u16 addr);
+
+void ocp_word_set_bits(struct r8152 *tp, u16 type, u16 index, u16 set);
+void ocp_reg_clr_bits(struct r8152 *tp, u16 addr, u16 clear);
+void ocp_reg_set_bits(struct r8152 *tp, u16 addr, u16 set);
 
 int r8152_wait_for_bit(struct r8152 *tp, bool ocp_reg, u16 type, u16 index,
 		       const u32 mask, bool set, unsigned int timeout);
 
+bool r8156b_flash_used(struct r8152 *tp);
+
+void rtl_reset_ocp_base(struct r8152 *tp);
+
 void r8152b_firmware(struct r8152 *tp);
 void r8153_firmware(struct r8152 *tp);
 void r8153b_firmware(struct r8152 *tp);
+void r8156_ram_code(struct r8152 *tp, bool power_cut);
+
+void r8156_patch_code(struct r8152 *tp);
 #endif
diff --git a/drivers/usb/eth/r8152_fw.c b/drivers/usb/eth/r8152_fw.c
index 3159f30106..5f347ed3e0 100644
--- a/drivers/usb/eth/r8152_fw.c
+++ b/drivers/usb/eth/r8152_fw.c
@@ -5,6 +5,7 @@
   */
 #include <dm.h>
 #include <errno.h>
+#include <linux/bug.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include "usb_ether.h"
@@ -851,37 +852,44 @@ static u16 r8153b_pla_patch_b_bp[] = {
 
 static void rtl_clear_bp(struct r8152 *tp, u16 type)
 {
-	u8 zeros[16] = {0};
+	u16 bp[16] = {0};
+	u16 bp_num;
 
 	switch (tp->version) {
-	case RTL_VER_01:
-	case RTL_VER_02:
-	case RTL_VER_07:
-		break;
+	case RTL_VER_08:
+	case RTL_VER_09:
+	case RTL_VER_10:
+	case RTL_VER_11:
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+		if (type == MCU_TYPE_USB) {
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP2_EN, 0);
+			bp_num = 16;
+			break;
+		}
+		fallthrough;
 	case RTL_VER_03:
 	case RTL_VER_04:
 	case RTL_VER_05:
 	case RTL_VER_06:
 		ocp_write_byte(tp, type, PLA_BP_EN, 0);
+		fallthrough;
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_07:
+		bp_num = 8;
 		break;
-	case RTL_VER_08:
-	case RTL_VER_09:
 	default:
-		if (type == MCU_TYPE_USB) {
-			ocp_write_byte(tp, MCU_TYPE_USB, USB_BP2_EN, 0);
-
-			generic_ocp_write(tp, USB_BP(8), 0xff, sizeof(zeros),
-					  zeros, type);
-		} else {
-			ocp_write_byte(tp, MCU_TYPE_PLA, PLA_BP_EN, 0);
-		}
+		ocp_write_word(tp, type, USB_BP2_EN, 0);
+		bp_num = 16;
 		break;
 	}
 
-	generic_ocp_write(tp, USB_BP(0), 0xff, sizeof(zeros), zeros, type);
-
-	mdelay(6);
+	generic_ocp_write(tp, PLA_BP_0, BYTE_EN_DWORD, bp_num << 1, bp, type);
 
+	/* wait 3 ms to make sure the firmware is stopped */
+	mdelay(3);
 	ocp_write_word(tp, type, PLA_BP_BA, 0);
 }
 
@@ -950,6 +958,122 @@ static void r8153_wdt1_end(struct r8152 *tp)
 	}
 }
 
+static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
+{
+	u16 check;
+	int i;
+
+	if (request) {
+		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
+		check = 0;
+	} else {
+		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
+		check = PATCH_READY;
+	}
+
+	for (i = 0; wait && i < 5000; i++) {
+		u16 data;
+
+		mdelay(1);
+		data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
+		if ((data & PATCH_READY) ^ check)
+			break;
+	}
+
+	if (request && wait && i == 5000) {
+		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, PATCH_REQUEST);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+static void rtl_patch_key_set(struct r8152 *tp, u16 key_addr, u16 patch_key)
+{
+	if (patch_key && key_addr) {
+		sram_write(tp, key_addr, patch_key);
+		sram_write(tp, SRAM_PHY_LOCK, PHY_PATCH_LOCK);
+	} else if (key_addr) {
+		sram_write(tp, 0x0000, 0x0000);
+
+		ocp_reg_clr_bits(tp, OCP_PHY_LOCK, PATCH_LOCK);
+
+		sram_write(tp, key_addr, 0x0000);
+	} else {
+		WARN_ON_ONCE(1);
+	}
+}
+
+static int
+rtl_pre_ram_code(struct r8152 *tp, u16 key_addr, u16 patch_key, bool wait)
+{
+	if (rtl_phy_patch_request(tp, true, wait))
+		return -ETIME;
+
+	rtl_patch_key_set(tp, key_addr, patch_key);
+
+	return 0;
+}
+
+static int rtl_post_ram_code(struct r8152 *tp, u16 key_addr, bool wait)
+{
+	rtl_patch_key_set(tp, key_addr, 0);
+
+	rtl_phy_patch_request(tp, false, wait);
+
+	return 0;
+}
+
+static void rtl_fw_ver_erase(struct r8152 *tp)
+{
+	u16 outer_ver;
+	u32 ocp_data;
+
+	switch (tp->version) {
+	case RTL_VER_01:
+	case RTL_VER_02:
+	case RTL_VER_03:
+	case RTL_VER_04:
+	case RTL_VER_05:
+	case RTL_VER_06:
+	case RTL_VER_07:
+	case RTL_VER_08:
+	case RTL_VER_09:
+	case RTL_TEST_01:
+		return;
+	case RTL_VER_10:
+	case RTL_VER_11:
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+		outer_ver = USB_OUTSIDE_FW_VER;
+		break;
+	default:
+		outer_ver = USB_OUTER_FW_VER;
+		break;
+	}
+
+	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, outer_ver);
+	if (ocp_data) {
+		ocp_write_word(tp, MCU_TYPE_USB, outer_ver, 0);
+		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_PLA_VER, 0);
+	}
+}
+
+static bool rtl_check_fw_ver_ok(struct r8152 *tp, u16 index, u8 new_ver)
+{
+	u32 ocp_data;
+
+	if (!index)
+		return true;
+
+	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, index);
+	if (new_ver > ocp_data)
+		return true;
+	else
+		return false;
+}
+
 void r8152b_firmware(struct r8152 *tp)
 {
 	int i;
@@ -1191,3 +1315,6178 @@ void r8153b_firmware(struct r8152 *tp)
 	ocp_data |= FW_IP_RESET_EN;
 	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN1, ocp_data);
 }
+
+static int rtl_ram_code_speed_up(struct r8152 *tp, bool wait)
+{
+	u16 fw_version, code_ver;
+	u32 len = 0, ocp_data;
+	u8 *data = NULL;
+	int ret = 0;
+
+	rtl_reset_ocp_base(tp);
+
+	if (tp->version == RTL_VER_13 || tp->version == RTL_VER_15) {
+		static u8 ram13[] = {
+			0x6c, 0xe8, 0x00, 0xa0,
+			0x36, 0xb4, 0x24, 0x80,
+			0x38, 0xb4, 0x01, 0x37,
+			0x36, 0xb4, 0x2e, 0xb8,
+			0x38, 0xb4, 0x01, 0x00,
+			0x6c, 0xe8, 0x00, 0xb0,
+			0x20, 0xb8, 0x90, 0x00,
+			0x6c, 0xe8, 0x00, 0xa0,
+			0x36, 0xb4, 0x16, 0xa0,
+			0x38, 0xb4, 0x00, 0x00,
+			0x36, 0xb4, 0x12, 0xa0,
+			0x38, 0xb4, 0x00, 0x00,
+			0x36, 0xb4, 0x14, 0xa0,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x10, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x1a, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x3f, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x45, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x67, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x6d, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x71, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0xb1, 0x80,
+			0x38, 0xb4, 0x93, 0xd0,
+			0x38, 0xb4, 0xc4, 0xd1,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x5c, 0x13,
+			0x38, 0xb4, 0x04, 0xd7,
+			0x38, 0xb4, 0xbc, 0x5f,
+			0x38, 0xb4, 0x04, 0xd5,
+			0x38, 0xb4, 0xf1, 0xc9,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0xc9, 0x0f,
+			0x38, 0xb4, 0x50, 0xbb,
+			0x38, 0xb4, 0x05, 0xd5,
+			0x38, 0xb4, 0x02, 0xa2,
+			0x38, 0xb4, 0x04, 0xd5,
+			0x38, 0xb4, 0x0f, 0x8c,
+			0x38, 0xb4, 0x00, 0xd5,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x19, 0x15,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x5c, 0x13,
+			0x38, 0xb4, 0x5e, 0xd7,
+			0x38, 0xb4, 0xae, 0x5f,
+			0x38, 0xb4, 0x50, 0x9b,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x5c, 0x13,
+			0x38, 0xb4, 0x5e, 0xd7,
+			0x38, 0xb4, 0xae, 0x7f,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x5c, 0x13,
+			0x38, 0xb4, 0x07, 0xd7,
+			0x38, 0xb4, 0xa7, 0x40,
+			0x38, 0xb4, 0x19, 0xd7,
+			0x38, 0xb4, 0x71, 0x40,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x57, 0x15,
+			0x38, 0xb4, 0x19, 0xd7,
+			0x38, 0xb4, 0x70, 0x2f,
+			0x38, 0xb4, 0x3b, 0x80,
+			0x38, 0xb4, 0x73, 0x2f,
+			0x38, 0xb4, 0x6a, 0x15,
+			0x38, 0xb4, 0x70, 0x5e,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x5d, 0x15,
+			0x38, 0xb4, 0x05, 0xd5,
+			0x38, 0xb4, 0x02, 0xa2,
+			0x38, 0xb4, 0x00, 0xd5,
+			0x38, 0xb4, 0xed, 0xff,
+			0x38, 0xb4, 0x09, 0xd7,
+			0x38, 0xb4, 0x54, 0x40,
+			0x38, 0xb4, 0x88, 0xa7,
+			0x38, 0xb4, 0x0b, 0xd7,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2a, 0x17,
+			0x38, 0xb4, 0xc1, 0xc0,
+			0x38, 0xb4, 0xc0, 0xc0,
+			0x38, 0xb4, 0x5a, 0xd0,
+			0x38, 0xb4, 0xba, 0xd1,
+			0x38, 0xb4, 0x01, 0xd7,
+			0x38, 0xb4, 0x29, 0x25,
+			0x38, 0xb4, 0x2a, 0x02,
+			0x38, 0xb4, 0xa7, 0xd0,
+			0x38, 0xb4, 0xb9, 0xd1,
+			0x38, 0xb4, 0x08, 0xa2,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x0e, 0x08,
+			0x38, 0xb4, 0x01, 0xd7,
+			0x38, 0xb4, 0x8b, 0x40,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x65, 0x0a,
+			0x38, 0xb4, 0x03, 0xf0,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x6b, 0x0a,
+			0x38, 0xb4, 0x01, 0xd7,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x20, 0x09,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x15, 0x09,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x09, 0x09,
+			0x38, 0xb4, 0x8f, 0x22,
+			0x38, 0xb4, 0x4e, 0x80,
+			0x38, 0xb4, 0x01, 0x98,
+			0x38, 0xb4, 0x1e, 0xd7,
+			0x38, 0xb4, 0x61, 0x5d,
+			0x38, 0xb4, 0x01, 0xd7,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2a, 0x02,
+			0x38, 0xb4, 0x05, 0x20,
+			0x38, 0xb4, 0x1a, 0x09,
+			0x38, 0xb4, 0xd9, 0x3b,
+			0x38, 0xb4, 0x19, 0x09,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x16, 0x09,
+			0x38, 0xb4, 0x90, 0xd0,
+			0x38, 0xb4, 0xc9, 0xd1,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x64, 0x10,
+			0x38, 0xb4, 0x96, 0xd0,
+			0x38, 0xb4, 0xa9, 0xd1,
+			0x38, 0xb4, 0x03, 0xd5,
+			0x38, 0xb4, 0x04, 0xa1,
+			0x38, 0xb4, 0x07, 0x0c,
+			0x38, 0xb4, 0x02, 0x09,
+			0x38, 0xb4, 0x00, 0xd5,
+			0x38, 0xb4, 0x10, 0xbc,
+			0x38, 0xb4, 0x01, 0xd5,
+			0x38, 0xb4, 0x01, 0xce,
+			0x38, 0xb4, 0x01, 0xa2,
+			0x38, 0xb4, 0x01, 0x82,
+			0x38, 0xb4, 0x00, 0xce,
+			0x38, 0xb4, 0x00, 0xd5,
+			0x38, 0xb4, 0x84, 0xc4,
+			0x38, 0xb4, 0x03, 0xd5,
+			0x38, 0xb4, 0x02, 0xcc,
+			0x38, 0xb4, 0x0d, 0xcd,
+			0x38, 0xb4, 0x01, 0xaf,
+			0x38, 0xb4, 0x00, 0xd5,
+			0x38, 0xb4, 0x03, 0xd7,
+			0x38, 0xb4, 0x71, 0x43,
+			0x38, 0xb4, 0x08, 0xbd,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x5c, 0x13,
+			0x38, 0xb4, 0x5e, 0xd7,
+			0x38, 0xb4, 0xb3, 0x5f,
+			0x38, 0xb4, 0x03, 0xd5,
+			0x38, 0xb4, 0xf5, 0xd0,
+			0x38, 0xb4, 0xc6, 0xd1,
+			0x38, 0xb4, 0xf0, 0x0c,
+			0x38, 0xb4, 0x50, 0x0e,
+			0x38, 0xb4, 0x04, 0xd7,
+			0x38, 0xb4, 0x1c, 0x40,
+			0x38, 0xb4, 0xf5, 0xd0,
+			0x38, 0xb4, 0xc6, 0xd1,
+			0x38, 0xb4, 0xf0, 0x0c,
+			0x38, 0xb4, 0xa0, 0x0e,
+			0x38, 0xb4, 0x1c, 0x40,
+			0x38, 0xb4, 0x7b, 0xd0,
+			0x38, 0xb4, 0xc5, 0xd1,
+			0x38, 0xb4, 0xf0, 0x8e,
+			0x38, 0xb4, 0x1c, 0x40,
+			0x38, 0xb4, 0x08, 0x9d,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x5c, 0x13,
+			0x38, 0xb4, 0x5e, 0xd7,
+			0x38, 0xb4, 0xb3, 0x7f,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x5c, 0x13,
+			0x38, 0xb4, 0x5e, 0xd7,
+			0x38, 0xb4, 0xad, 0x5f,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0xc5, 0x14,
+			0x38, 0xb4, 0x03, 0xd7,
+			0x38, 0xb4, 0x81, 0x31,
+			0x38, 0xb4, 0xaf, 0x80,
+			0x38, 0xb4, 0xad, 0x60,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x5c, 0x13,
+			0x38, 0xb4, 0x03, 0xd7,
+			0x38, 0xb4, 0xba, 0x5f,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0xc7, 0x0c,
+			0x38, 0xb4, 0x02, 0xa8,
+			0x38, 0xb4, 0x01, 0xa3,
+			0x38, 0xb4, 0x01, 0xa8,
+			0x38, 0xb4, 0x04, 0xc0,
+			0x38, 0xb4, 0x10, 0xd7,
+			0x38, 0xb4, 0x00, 0x40,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x79, 0x1e,
+			0x36, 0xb4, 0x26, 0xa0,
+			0x38, 0xb4, 0x78, 0x1e,
+			0x36, 0xb4, 0x24, 0xa0,
+			0x38, 0xb4, 0x93, 0x0c,
+			0x36, 0xb4, 0x22, 0xa0,
+			0x38, 0xb4, 0x62, 0x10,
+			0x36, 0xb4, 0x20, 0xa0,
+			0x38, 0xb4, 0x15, 0x09,
+			0x36, 0xb4, 0x06, 0xa0,
+			0x38, 0xb4, 0x0a, 0x02,
+			0x36, 0xb4, 0x04, 0xa0,
+			0x38, 0xb4, 0x26, 0x17,
+			0x36, 0xb4, 0x02, 0xa0,
+			0x38, 0xb4, 0x42, 0x15,
+			0x36, 0xb4, 0x00, 0xa0,
+			0x38, 0xb4, 0xc7, 0x0f,
+			0x36, 0xb4, 0x08, 0xa0,
+			0x38, 0xb4, 0x00, 0xff,
+			0x6c, 0xe8, 0x00, 0xa0,
+			0x36, 0xb4, 0x16, 0xa0,
+			0x38, 0xb4, 0x10, 0x00,
+			0x36, 0xb4, 0x12, 0xa0,
+			0x38, 0xb4, 0x00, 0x00,
+			0x36, 0xb4, 0x14, 0xa0,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x10, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x1d, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2c, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2c, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2c, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2c, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2c, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2c, 0x80,
+			0x38, 0xb4, 0x00, 0xd7,
+			0x38, 0xb4, 0x90, 0x60,
+			0x38, 0xb4, 0xd1, 0x60,
+			0x38, 0xb4, 0x5c, 0xc9,
+			0x38, 0xb4, 0x07, 0xf0,
+			0x38, 0xb4, 0xb1, 0x60,
+			0x38, 0xb4, 0x5a, 0xc9,
+			0x38, 0xb4, 0x04, 0xf0,
+			0x38, 0xb4, 0x56, 0xc9,
+			0x38, 0xb4, 0x02, 0xf0,
+			0x38, 0xb4, 0x4e, 0xc9,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0xcd, 0x00,
+			0x38, 0xb4, 0x00, 0xd7,
+			0x38, 0xb4, 0x90, 0x60,
+			0x38, 0xb4, 0xd1, 0x60,
+			0x38, 0xb4, 0x5c, 0xc9,
+			0x38, 0xb4, 0x07, 0xf0,
+			0x38, 0xb4, 0xb1, 0x60,
+			0x38, 0xb4, 0x5a, 0xc9,
+			0x38, 0xb4, 0x04, 0xf0,
+			0x38, 0xb4, 0x56, 0xc9,
+			0x38, 0xb4, 0x02, 0xf0,
+			0x38, 0xb4, 0x4e, 0xc9,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x2a, 0x02,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x32, 0x01,
+			0x36, 0xb4, 0x8e, 0xa0,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x8c, 0xa0,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x8a, 0xa0,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x88, 0xa0,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x86, 0xa0,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x84, 0xa0,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x82, 0xa0,
+			0x38, 0xb4, 0x2f, 0x01,
+			0x36, 0xb4, 0x80, 0xa0,
+			0x38, 0xb4, 0xcc, 0x00,
+			0x36, 0xb4, 0x90, 0xa0,
+			0x38, 0xb4, 0x03, 0x01,
+			0x6c, 0xe8, 0x00, 0xa0,
+			0x36, 0xb4, 0x16, 0xa0,
+			0x38, 0xb4, 0x20, 0x00,
+			0x36, 0xb4, 0x12, 0xa0,
+			0x38, 0xb4, 0x00, 0x00,
+			0x36, 0xb4, 0x14, 0xa0,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x10, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x20, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2a, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x35, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x3c, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x3c, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x3c, 0x80,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x3c, 0x80,
+			0x38, 0xb4, 0x07, 0xd1,
+			0x38, 0xb4, 0x42, 0xd0,
+			0x38, 0xb4, 0x04, 0xa4,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0xdf, 0x09,
+			0x38, 0xb4, 0x00, 0xd7,
+			0x38, 0xb4, 0xb4, 0x5f,
+			0x38, 0xb4, 0x80, 0x82,
+			0x38, 0xb4, 0x00, 0xd7,
+			0x38, 0xb4, 0x65, 0x60,
+			0x38, 0xb4, 0x25, 0xd1,
+			0x38, 0xb4, 0x02, 0xf0,
+			0x38, 0xb4, 0x2b, 0xd1,
+			0x38, 0xb4, 0x40, 0xd0,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x7f, 0x07,
+			0x38, 0xb4, 0xf0, 0x0c,
+			0x38, 0xb4, 0x50, 0x0c,
+			0x38, 0xb4, 0x04, 0xd1,
+			0x38, 0xb4, 0x40, 0xd0,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0xa8, 0x0a,
+			0x38, 0xb4, 0x00, 0xd7,
+			0x38, 0xb4, 0xb4, 0x5f,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x2e, 0x0a,
+			0x38, 0xb4, 0x9b, 0xcb,
+			0x38, 0xb4, 0x10, 0xd1,
+			0x38, 0xb4, 0x40, 0xd0,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0x7b, 0x0b,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0xdf, 0x09,
+			0x38, 0xb4, 0x00, 0xd7,
+			0x38, 0xb4, 0xb4, 0x5f,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x1b, 0x08,
+			0x38, 0xb4, 0x00, 0x10,
+			0x38, 0xb4, 0xdf, 0x09,
+			0x38, 0xb4, 0x04, 0xd7,
+			0x38, 0xb4, 0xb8, 0x7f,
+			0x38, 0xb4, 0x18, 0xa7,
+			0x38, 0xb4, 0x00, 0x18,
+			0x38, 0xb4, 0x4e, 0x07,
+			0x36, 0xb4, 0x0e, 0xa1,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x0c, 0xa1,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x0a, 0xa1,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x08, 0xa1,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x06, 0xa1,
+			0x38, 0xb4, 0x4d, 0x07,
+			0x36, 0xb4, 0x04, 0xa1,
+			0x38, 0xb4, 0x18, 0x08,
+			0x36, 0xb4, 0x02, 0xa1,
+			0x38, 0xb4, 0x2c, 0x0a,
+			0x36, 0xb4, 0x00, 0xa1,
+			0x38, 0xb4, 0x7e, 0x07,
+			0x36, 0xb4, 0x10, 0xa1,
+			0x38, 0xb4, 0x0f, 0x00,
+			0x6c, 0xe8, 0x00, 0xa0,
+			0x36, 0xb4, 0x7c, 0xb8,
+			0x38, 0xb4, 0x25, 0x86,
+			0x36, 0xb4, 0x7e, 0xb8,
+			0x38, 0xb4, 0x86, 0xaf,
+			0x38, 0xb4, 0xaf, 0x3d,
+			0x38, 0xb4, 0x89, 0x86,
+			0x38, 0xb4, 0x88, 0xaf,
+			0x38, 0xb4, 0xaf, 0x69,
+			0x38, 0xb4, 0x87, 0x88,
+			0x38, 0xb4, 0x88, 0xaf,
+			0x38, 0xb4, 0xaf, 0x9c,
+			0x38, 0xb4, 0x9c, 0x88,
+			0x38, 0xb4, 0x88, 0xaf,
+			0x38, 0xb4, 0xaf, 0x9c,
+			0x38, 0xb4, 0x9c, 0x88,
+			0x38, 0xb4, 0x86, 0xbf,
+			0x38, 0xb4, 0xd7, 0x49,
+			0x38, 0xb4, 0x40, 0x00,
+			0x38, 0xb4, 0x77, 0x02,
+			0x38, 0xb4, 0xaf, 0x7d,
+			0x38, 0xb4, 0x27, 0x27,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x05, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x08, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0xf3, 0x71,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0xf6, 0x71,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x29, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x2c, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x17, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x1a, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x1d, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x11, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x20, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x14, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x2f, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x23, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x32, 0x72,
+			0x38, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x26, 0x72,
+			0x38, 0xb4, 0xf9, 0xf8,
+			0x38, 0xb4, 0xe0, 0xfa,
+			0x38, 0xb4, 0xb3, 0x85,
+			0x38, 0xb4, 0x02, 0x38,
+			0x38, 0xb4, 0x27, 0xad,
+			0x38, 0xb4, 0xae, 0x02,
+			0x38, 0xb4, 0xaf, 0x03,
+			0x38, 0xb4, 0x30, 0x88,
+			0x38, 0xb4, 0x66, 0x1f,
+			0x38, 0xb4, 0x65, 0xef,
+			0x38, 0xb4, 0xc2, 0xbf,
+			0x38, 0xb4, 0x1a, 0x1f,
+			0x38, 0xb4, 0xf7, 0x96,
+			0x38, 0xb4, 0xee, 0x05,
+			0x38, 0xb4, 0xd2, 0xff,
+			0x38, 0xb4, 0xda, 0x00,
+			0x38, 0xb4, 0x05, 0xf6,
+			0x38, 0xb4, 0xc2, 0xbf,
+			0x38, 0xb4, 0x1a, 0x2f,
+			0x38, 0xb4, 0xf7, 0x96,
+			0x38, 0xb4, 0xee, 0x05,
+			0x38, 0xb4, 0xd2, 0xff,
+			0x38, 0xb4, 0xdb, 0x00,
+			0x38, 0xb4, 0x05, 0xf6,
+			0x38, 0xb4, 0x02, 0xef,
+			0x38, 0xb4, 0x11, 0x1f,
+			0x38, 0xb4, 0x42, 0x0d,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x42,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x02, 0xef,
+			0x38, 0xb4, 0x03, 0x1b,
+			0x38, 0xb4, 0x11, 0x1f,
+			0x38, 0xb4, 0x42, 0x0d,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x45,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x02, 0xef,
+			0x38, 0xb4, 0x03, 0x1a,
+			0x38, 0xb4, 0x11, 0x1f,
+			0x38, 0xb4, 0x42, 0x0d,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x48,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0xc2, 0xbf,
+			0x38, 0xb4, 0x1a, 0x3f,
+			0x38, 0xb4, 0xf7, 0x96,
+			0x38, 0xb4, 0xee, 0x05,
+			0x38, 0xb4, 0xd2, 0xff,
+			0x38, 0xb4, 0xda, 0x00,
+			0x38, 0xb4, 0x05, 0xf6,
+			0x38, 0xb4, 0xc2, 0xbf,
+			0x38, 0xb4, 0x1a, 0x4f,
+			0x38, 0xb4, 0xf7, 0x96,
+			0x38, 0xb4, 0xee, 0x05,
+			0x38, 0xb4, 0xd2, 0xff,
+			0x38, 0xb4, 0xdb, 0x00,
+			0x38, 0xb4, 0x05, 0xf6,
+			0x38, 0xb4, 0x02, 0xef,
+			0x38, 0xb4, 0x11, 0x1f,
+			0x38, 0xb4, 0x42, 0x0d,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x4b,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x02, 0xef,
+			0x38, 0xb4, 0x03, 0x1b,
+			0x38, 0xb4, 0x11, 0x1f,
+			0x38, 0xb4, 0x42, 0x0d,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x4e,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x02, 0xef,
+			0x38, 0xb4, 0x03, 0x1a,
+			0x38, 0xb4, 0x11, 0x1f,
+			0x38, 0xb4, 0x42, 0x0d,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x51,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x56, 0xef,
+			0x38, 0xb4, 0x20, 0xd0,
+			0x38, 0xb4, 0x11, 0x1f,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x54,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x57,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x5a,
+			0xff, 0xff, 0xff, 0xff,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xef, 0xa0,
+			0x38, 0xb4, 0x48, 0x03,
+			0x38, 0xb4, 0x28, 0x0a,
+			0x38, 0xb4, 0xef, 0x05,
+			0x38, 0xb4, 0x1b, 0x20,
+			0x38, 0xb4, 0xad, 0x01,
+			0x38, 0xb4, 0x35, 0x27,
+			0x38, 0xb4, 0x44, 0x1f,
+			0x38, 0xb4, 0x85, 0xe0,
+			0x38, 0xb4, 0xe1, 0x88,
+			0x38, 0xb4, 0x89, 0x85,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x5d,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x85, 0xe0,
+			0x38, 0xb4, 0xe1, 0x8e,
+			0x38, 0xb4, 0x8f, 0x85,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x60,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x85, 0xe0,
+			0x38, 0xb4, 0xe1, 0x94,
+			0x38, 0xb4, 0x95, 0x85,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x63,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x85, 0xe0,
+			0x38, 0xb4, 0xe1, 0x9a,
+			0x38, 0xb4, 0x9b, 0x85,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x66,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x88, 0xaf,
+			0x38, 0xb4, 0xbf, 0x3c,
+			0x38, 0xb4, 0x3f, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xad, 0x9c,
+			0x38, 0xb4, 0x35, 0x28,
+			0x38, 0xb4, 0x44, 0x1f,
+			0x38, 0xb4, 0x8f, 0xe0,
+			0x38, 0xb4, 0xe1, 0xf8,
+			0x38, 0xb4, 0xf9, 0x8f,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x5d,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x8f, 0xe0,
+			0x38, 0xb4, 0xe1, 0xfa,
+			0x38, 0xb4, 0xfb, 0x8f,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x60,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x8f, 0xe0,
+			0x38, 0xb4, 0xe1, 0xfc,
+			0x38, 0xb4, 0xfd, 0x8f,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x63,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x8f, 0xe0,
+			0x38, 0xb4, 0xe1, 0xfe,
+			0x38, 0xb4, 0xff, 0x8f,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x66,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x88, 0xaf,
+			0x38, 0xb4, 0xe1, 0x3c,
+			0x38, 0xb4, 0xa1, 0x85,
+			0x38, 0xb4, 0x21, 0x1b,
+			0x38, 0xb4, 0x37, 0xad,
+			0x38, 0xb4, 0x1f, 0x34,
+			0x38, 0xb4, 0xe0, 0x44,
+			0x38, 0xb4, 0x8a, 0x85,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xbf, 0x8b,
+			0x38, 0xb4, 0x5d, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xe0, 0x7d,
+			0x38, 0xb4, 0x90, 0x85,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xbf, 0x91,
+			0x38, 0xb4, 0x60, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xe0, 0x7d,
+			0x38, 0xb4, 0x96, 0x85,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xbf, 0x97,
+			0x38, 0xb4, 0x63, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xe0, 0x7d,
+			0x38, 0xb4, 0x9c, 0x85,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xbf, 0x9d,
+			0x38, 0xb4, 0x66, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xae, 0x7d,
+			0x38, 0xb4, 0x1f, 0x40,
+			0x38, 0xb4, 0xe0, 0x44,
+			0x38, 0xb4, 0x8c, 0x85,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xbf, 0x8d,
+			0x38, 0xb4, 0x5d, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xe0, 0x7d,
+			0x38, 0xb4, 0x92, 0x85,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xbf, 0x93,
+			0x38, 0xb4, 0x60, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xe0, 0x7d,
+			0x38, 0xb4, 0x98, 0x85,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xbf, 0x99,
+			0x38, 0xb4, 0x63, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xe0, 0x7d,
+			0x38, 0xb4, 0x9e, 0x85,
+			0x38, 0xb4, 0x85, 0xe1,
+			0x38, 0xb4, 0xbf, 0x9f,
+			0x38, 0xb4, 0x66, 0x88,
+			0x38, 0xb4, 0x6e, 0x02,
+			0x38, 0xb4, 0xae, 0x7d,
+			0x38, 0xb4, 0xe1, 0x0c,
+			0x38, 0xb4, 0xb3, 0x85,
+			0x38, 0xb4, 0x04, 0x39,
+			0x38, 0xb4, 0x2f, 0xac,
+			0x38, 0xb4, 0xee, 0x04,
+			0x38, 0xb4, 0xb3, 0x85,
+			0x38, 0xb4, 0xaf, 0x00,
+			0x38, 0xb4, 0xd9, 0x39,
+			0x38, 0xb4, 0xac, 0x22,
+			0x38, 0xb4, 0xf0, 0xea,
+			0x38, 0xb4, 0xf6, 0xac,
+			0x38, 0xb4, 0xac, 0xf0,
+			0x38, 0xb4, 0xf0, 0xfa,
+			0x38, 0xb4, 0xf8, 0xac,
+			0x38, 0xb4, 0xac, 0xf0,
+			0x38, 0xb4, 0xf0, 0xfc,
+			0x38, 0xb4, 0x00, 0xad,
+			0x38, 0xb4, 0xac, 0xf0,
+			0x38, 0xb4, 0xf0, 0xfe,
+			0x38, 0xb4, 0xf0, 0xac,
+			0x38, 0xb4, 0xac, 0xf0,
+			0x38, 0xb4, 0xf0, 0xf4,
+			0x38, 0xb4, 0xf2, 0xac,
+			0x38, 0xb4, 0xac, 0xf0,
+			0x38, 0xb4, 0xf0, 0xb0,
+			0x38, 0xb4, 0xae, 0xac,
+			0x38, 0xb4, 0xac, 0xf0,
+			0x38, 0xb4, 0xf0, 0xac,
+			0x38, 0xb4, 0xaa, 0xac,
+			0x38, 0xb4, 0x00, 0xa1,
+			0x38, 0xb4, 0xe1, 0x0c,
+			0x38, 0xb4, 0xf7, 0x8f,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x84,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x26, 0xaf,
+			0x38, 0xb4, 0xe1, 0xe9,
+			0x38, 0xb4, 0xf6, 0x8f,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x84,
+			0x38, 0xb4, 0x7d, 0x6e,
+			0x38, 0xb4, 0x26, 0xaf,
+			0x38, 0xb4, 0x20, 0xf5,
+			0x38, 0xb4, 0x86, 0xac,
+			0x38, 0xb4, 0x88, 0xbf,
+			0x38, 0xb4, 0x02, 0x3f,
+			0x38, 0xb4, 0x9c, 0x6e,
+			0x38, 0xb4, 0x28, 0xad,
+			0x38, 0xb4, 0xaf, 0x03,
+			0x38, 0xb4, 0x24, 0x33,
+			0x38, 0xb4, 0x38, 0xad,
+			0x38, 0xb4, 0xaf, 0x03,
+			0x38, 0xb4, 0xe6, 0x32,
+			0x38, 0xb4, 0x32, 0xaf,
+			0x38, 0xb4, 0x00, 0xfb,
+			0x36, 0xb4, 0x7c, 0xb8,
+			0x38, 0xb4, 0xf6, 0x8f,
+			0x36, 0xb4, 0x7e, 0xb8,
+			0x38, 0xb4, 0x05, 0x07,
+			0x36, 0xb4, 0x7c, 0xb8,
+			0x38, 0xb4, 0xf8, 0x8f,
+			0x36, 0xb4, 0x7e, 0xb8,
+			0x38, 0xb4, 0xcc, 0x19,
+			0x36, 0xb4, 0x7c, 0xb8,
+			0x38, 0xb4, 0xfa, 0x8f,
+			0x36, 0xb4, 0x7e, 0xb8,
+			0x38, 0xb4, 0xe3, 0x28,
+			0x36, 0xb4, 0x7c, 0xb8,
+			0x38, 0xb4, 0xfc, 0x8f,
+			0x36, 0xb4, 0x7e, 0xb8,
+			0x38, 0xb4, 0x47, 0x10,
+			0x36, 0xb4, 0x7c, 0xb8,
+			0x38, 0xb4, 0xfe, 0x8f,
+			0x36, 0xb4, 0x7e, 0xb8,
+			0x38, 0xb4, 0x45, 0x0a,
+			0x36, 0xb4, 0x5e, 0xb8,
+			0x38, 0xb4, 0x1e, 0x27,
+			0x36, 0xb4, 0x60, 0xb8,
+			0x38, 0xb4, 0x46, 0x38,
+			0x36, 0xb4, 0x62, 0xb8,
+			0x38, 0xb4, 0xe6, 0x26,
+			0x36, 0xb4, 0x64, 0xb8,
+			0x38, 0xb4, 0xe3, 0x32,
+			0x36, 0xb4, 0x86, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x88, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x8a, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x8c, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x38, 0xb8,
+			0x38, 0xb4, 0x0f, 0x00,
+			0x6c, 0xe8, 0x00, 0xb0,
+			0x20, 0xb8, 0x10, 0x00,
+			0x6c, 0xe8, 0x00, 0xa0,
+			0x36, 0xb4, 0x6e, 0x84,
+			0x38, 0xb4, 0x84, 0xaf,
+			0x38, 0xb4, 0xaf, 0x86,
+			0x38, 0xb4, 0x90, 0x86,
+			0x38, 0xb4, 0x86, 0xaf,
+			0x38, 0xb4, 0xaf, 0xa4,
+			0x38, 0xb4, 0xa4, 0x86,
+			0x38, 0xb4, 0x86, 0xaf,
+			0x38, 0xb4, 0xaf, 0xa4,
+			0x38, 0xb4, 0xa4, 0x86,
+			0x38, 0xb4, 0x86, 0xaf,
+			0x38, 0xb4, 0xaf, 0xa4,
+			0x38, 0xb4, 0xa4, 0x86,
+			0x38, 0xb4, 0x82, 0xee,
+			0x38, 0xb4, 0x00, 0x5f,
+			0x38, 0xb4, 0x84, 0x02,
+			0x38, 0xb4, 0xaf, 0x90,
+			0x38, 0xb4, 0x41, 0x04,
+			0x38, 0xb4, 0xe0, 0xf8,
+			0x38, 0xb4, 0xf3, 0x8f,
+			0x38, 0xb4, 0x00, 0xa0,
+			0x38, 0xb4, 0x02, 0x05,
+			0x38, 0xb4, 0xa4, 0x84,
+			0x38, 0xb4, 0x06, 0xae,
+			0x38, 0xb4, 0x01, 0xa0,
+			0x38, 0xb4, 0x02, 0x03,
+			0x38, 0xb4, 0xc8, 0x84,
+			0x38, 0xb4, 0x04, 0xfc,
+			0x38, 0xb4, 0xf9, 0xf8,
+			0x38, 0xb4, 0x59, 0xef,
+			0x38, 0xb4, 0x80, 0xe0,
+			0x38, 0xb4, 0xad, 0x15,
+			0x38, 0xb4, 0x02, 0x27,
+			0x38, 0xb4, 0x03, 0xae,
+			0x38, 0xb4, 0x84, 0xaf,
+			0x38, 0xb4, 0xbf, 0xc3,
+			0x38, 0xb4, 0xca, 0x53,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xad, 0xc8,
+			0x38, 0xb4, 0x07, 0x28,
+			0x38, 0xb4, 0x85, 0x02,
+			0x38, 0xb4, 0xee, 0x2c,
+			0x38, 0xb4, 0xf3, 0x8f,
+			0x38, 0xb4, 0xef, 0x01,
+			0x38, 0xb4, 0xfd, 0x95,
+			0x38, 0xb4, 0x04, 0xfc,
+			0x38, 0xb4, 0xf9, 0xf8,
+			0x38, 0xb4, 0xef, 0xfa,
+			0x38, 0xb4, 0xbf, 0x69,
+			0x38, 0xb4, 0xca, 0x53,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xac, 0xc8,
+			0x38, 0xb4, 0x22, 0x28,
+			0x38, 0xb4, 0x80, 0xd4,
+			0x38, 0xb4, 0xbf, 0x00,
+			0x38, 0xb4, 0x84, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xbf, 0xa9,
+			0x38, 0xb4, 0x87, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xbf, 0xa9,
+			0x38, 0xb4, 0x8a, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xbf, 0xa9,
+			0x38, 0xb4, 0x8d, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xee, 0xa9,
+			0x38, 0xb4, 0xf3, 0x8f,
+			0x38, 0xb4, 0xaf, 0x00,
+			0x38, 0xb4, 0x26, 0x85,
+			0x38, 0xb4, 0x8f, 0xe0,
+			0x38, 0xb4, 0xe1, 0xf4,
+			0x38, 0xb4, 0xf5, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe2,
+			0x38, 0xb4, 0xe3, 0xf6,
+			0x38, 0xb4, 0xf7, 0x8f,
+			0x38, 0xb4, 0x45, 0x1b,
+			0x38, 0xb4, 0x27, 0xac,
+			0x38, 0xb4, 0xee, 0x0e,
+			0x38, 0xb4, 0xf4, 0x8f,
+			0x38, 0xb4, 0xee, 0x00,
+			0x38, 0xb4, 0xf5, 0x8f,
+			0x38, 0xb4, 0x02, 0x00,
+			0x38, 0xb4, 0x2c, 0x85,
+			0x38, 0xb4, 0x85, 0xaf,
+			0x38, 0xb4, 0xe0, 0x26,
+			0x38, 0xb4, 0xf4, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe1,
+			0x38, 0xb4, 0x2c, 0xf5,
+			0x38, 0xb4, 0x01, 0x00,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xf4,
+			0x38, 0xb4, 0xf5, 0x8f,
+			0x38, 0xb4, 0x96, 0xef,
+			0x38, 0xb4, 0xfd, 0xfe,
+			0x38, 0xb4, 0x04, 0xfc,
+			0x38, 0xb4, 0xf9, 0xf8,
+			0x38, 0xb4, 0x59, 0xef,
+			0x38, 0xb4, 0x53, 0xbf,
+			0x38, 0xb4, 0x02, 0x22,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8b, 0xa1,
+			0x38, 0xb4, 0xae, 0x02,
+			0x38, 0xb4, 0xaf, 0x03,
+			0x38, 0xb4, 0xda, 0x85,
+			0x38, 0xb4, 0x57, 0xbf,
+			0x38, 0xb4, 0x02, 0x72,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xf8,
+			0x38, 0xb4, 0xf9, 0x8f,
+			0x38, 0xb4, 0x57, 0xbf,
+			0x38, 0xb4, 0x02, 0x75,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xfa,
+			0x38, 0xb4, 0xfb, 0x8f,
+			0x38, 0xb4, 0x57, 0xbf,
+			0x38, 0xb4, 0x02, 0x78,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xfc,
+			0x38, 0xb4, 0xfd, 0x8f,
+			0x38, 0xb4, 0x57, 0xbf,
+			0x38, 0xb4, 0x02, 0x7b,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xfe,
+			0x38, 0xb4, 0xff, 0x8f,
+			0x38, 0xb4, 0x57, 0xbf,
+			0x38, 0xb4, 0x02, 0x6c,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x02, 0xa1,
+			0x38, 0xb4, 0xee, 0x13,
+			0x38, 0xb4, 0xfc, 0x8f,
+			0x38, 0xb4, 0xee, 0x80,
+			0x38, 0xb4, 0xfd, 0x8f,
+			0x38, 0xb4, 0xee, 0x00,
+			0x38, 0xb4, 0xfe, 0x8f,
+			0x38, 0xb4, 0xee, 0x80,
+			0x38, 0xb4, 0xff, 0x8f,
+			0x38, 0xb4, 0xaf, 0x00,
+			0x38, 0xb4, 0x99, 0x85,
+			0x38, 0xb4, 0x01, 0xa1,
+			0x38, 0xb4, 0xbf, 0x0c,
+			0x38, 0xb4, 0x4c, 0x53,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xa1, 0xc8,
+			0x38, 0xb4, 0x03, 0x03,
+			0x38, 0xb4, 0x85, 0xaf,
+			0x38, 0xb4, 0xbf, 0x77,
+			0x38, 0xb4, 0x22, 0x53,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xa1, 0xc8,
+			0x38, 0xb4, 0x02, 0x8b,
+			0x38, 0xb4, 0x03, 0xae,
+			0x38, 0xb4, 0x86, 0xaf,
+			0x38, 0xb4, 0xe0, 0x64,
+			0x38, 0xb4, 0xf8, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe1,
+			0x38, 0xb4, 0xbf, 0xf9,
+			0x38, 0xb4, 0x84, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xe0, 0xa9,
+			0x38, 0xb4, 0xfa, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe1,
+			0x38, 0xb4, 0xbf, 0xfb,
+			0x38, 0xb4, 0x87, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xe0, 0xa9,
+			0x38, 0xb4, 0xfc, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe1,
+			0x38, 0xb4, 0xbf, 0xfd,
+			0x38, 0xb4, 0x8a, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xe0, 0xa9,
+			0x38, 0xb4, 0xfe, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe1,
+			0x38, 0xb4, 0xbf, 0xff,
+			0x38, 0xb4, 0x8d, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xaf, 0xa9,
+			0x38, 0xb4, 0x7f, 0x86,
+			0x38, 0xb4, 0x53, 0xbf,
+			0x38, 0xb4, 0x02, 0x22,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x44, 0xa1,
+			0x38, 0xb4, 0xbf, 0x3c,
+			0x38, 0xb4, 0x7b, 0x54,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xe4, 0xc8,
+			0x38, 0xb4, 0xf8, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe5,
+			0x38, 0xb4, 0xbf, 0xf9,
+			0x38, 0xb4, 0x7e, 0x54,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xe4, 0xc8,
+			0x38, 0xb4, 0xfa, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe5,
+			0x38, 0xb4, 0xbf, 0xfb,
+			0x38, 0xb4, 0x81, 0x54,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xe4, 0xc8,
+			0x38, 0xb4, 0xfc, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe5,
+			0x38, 0xb4, 0xbf, 0xfd,
+			0x38, 0xb4, 0x84, 0x54,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xe4, 0xc8,
+			0x38, 0xb4, 0xfe, 0x8f,
+			0x38, 0xb4, 0x8f, 0xe5,
+			0x38, 0xb4, 0xbf, 0xff,
+			0x38, 0xb4, 0x22, 0x53,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xa1, 0xc8,
+			0x38, 0xb4, 0x48, 0x44,
+			0x38, 0xb4, 0x85, 0xaf,
+			0x38, 0xb4, 0xbf, 0xa7,
+			0x38, 0xb4, 0x22, 0x53,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xa1, 0xc8,
+			0x38, 0xb4, 0x3c, 0x31,
+			0x38, 0xb4, 0x54, 0xbf,
+			0x38, 0xb4, 0x02, 0x7b,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xf8,
+			0x38, 0xb4, 0xf9, 0x8f,
+			0x38, 0xb4, 0x54, 0xbf,
+			0x38, 0xb4, 0x02, 0x7e,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xfa,
+			0x38, 0xb4, 0xfb, 0x8f,
+			0x38, 0xb4, 0x54, 0xbf,
+			0x38, 0xb4, 0x02, 0x81,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xfc,
+			0x38, 0xb4, 0xfd, 0x8f,
+			0x38, 0xb4, 0x54, 0xbf,
+			0x38, 0xb4, 0x02, 0x84,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x8f, 0xe4,
+			0x38, 0xb4, 0xe5, 0xfe,
+			0x38, 0xb4, 0xff, 0x8f,
+			0x38, 0xb4, 0x53, 0xbf,
+			0x38, 0xb4, 0x02, 0x22,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x31, 0xa1,
+			0x38, 0xb4, 0xaf, 0x03,
+			0x38, 0xb4, 0xa7, 0x85,
+			0x38, 0xb4, 0x80, 0xd4,
+			0x38, 0xb4, 0xbf, 0x00,
+			0x38, 0xb4, 0x84, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xbf, 0xa9,
+			0x38, 0xb4, 0x87, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xbf, 0xa9,
+			0x38, 0xb4, 0x8a, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xbf, 0xa9,
+			0x38, 0xb4, 0x8d, 0x86,
+			0x38, 0xb4, 0x52, 0x02,
+			0x38, 0xb4, 0xef, 0xa9,
+			0x38, 0xb4, 0xfd, 0x95,
+			0x38, 0xb4, 0x04, 0xfc,
+			0x38, 0xb4, 0xd1, 0xf0,
+			0x38, 0xb4, 0xf0, 0x2a,
+			0x38, 0xb4, 0x2c, 0xd1,
+			0x38, 0xb4, 0xd1, 0xf0,
+			0x38, 0xb4, 0xf0, 0x44,
+			0x38, 0xb4, 0x46, 0xd1,
+			0x38, 0xb4, 0x86, 0xbf,
+			0x38, 0xb4, 0x02, 0xa1,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x86, 0xbf,
+			0x38, 0xb4, 0x02, 0xa1,
+			0x38, 0xb4, 0xc8, 0x52,
+			0x38, 0xb4, 0x01, 0xd1,
+			0x38, 0xb4, 0x06, 0xaf,
+			0x38, 0xb4, 0x70, 0xa5,
+			0x38, 0xb4, 0x42, 0xce,
+			0x36, 0xb4, 0x18, 0xb8,
+			0x38, 0xb4, 0x3d, 0x04,
+			0x36, 0xb4, 0x1a, 0xb8,
+			0x38, 0xb4, 0xa3, 0x06,
+			0x36, 0xb4, 0x1c, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x1e, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x50, 0xb8,
+			0xff, 0xff, 0xff, 0xff,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x52, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x78, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x84, 0xb8,
+			0x38, 0xb4, 0xff, 0xff,
+			0x36, 0xb4, 0x32, 0xb8,
+			0x38, 0xb4, 0x03, 0x00,
+			0x36, 0xb4, 0x00, 0x00,
+			0x38, 0xb4, 0x00, 0x00,
+			0x36, 0xb4, 0x2e, 0xb8,
+			0x38, 0xb4, 0x00, 0x00,
+			0x36, 0xb4, 0x24, 0x80,
+			0x38, 0xb4, 0x00, 0x00,
+			0x36, 0xb4, 0x1e, 0x80,
+			0x38, 0xb4, 0x21, 0x00,
+			0x6c, 0xe8, 0x00, 0xb0,
+			0x20, 0xb8, 0x00, 0x00,
+			0xff, 0xff, 0xff, 0xff};
+
+		code_ver = 0x0021;
+		fw_version = sram_read(tp, SRAM_GPHY_FW_VER);
+		if (fw_version < code_ver) {
+			data = ram13;
+			len = sizeof(ram13);
+
+			if (r8156b_flash_used(tp)) {
+				ocp_word_set_bits(tp, MCU_TYPE_USB,
+						  USB_GPHY_CTRL,
+						  BYPASS_FLASH);
+			}
+		}
+	}
+
+	if (!data)
+		return 0;
+
+	ret = rtl_phy_patch_request(tp, true, wait);
+	if (ret < 0)
+		goto out;
+
+	while (len) {
+		u32 size;
+		int i;
+
+		if (len < 2048)
+			size = len;
+		else
+			size = 2048;
+
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_GPHY_CTRL,
+				  GPHY_PATCH_DONE | BACKUP_RESTRORE);
+
+		ret = generic_ocp_write(tp, 0x9A00, 0xff, size, data,
+					MCU_TYPE_USB);
+		if (ret < 0)
+			goto out;
+
+		data += size;
+		len -= size;
+
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL,
+				  POL_GPHY_PATCH);
+
+		for (i = 0; i < 1000; i++) {
+			ocp_data = ocp_read_word(tp, MCU_TYPE_PLA,
+						 PLA_POL_GPIO_CTRL);
+			if (!(ocp_data & POL_GPHY_PATCH))
+				break;
+		}
+
+		if (i == 1000) {
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+	}
+
+	rtl_reset_ocp_base(tp);
+
+	ret = rtl_phy_patch_request(tp, false, wait);
+	if (ret < 0)
+		goto out;
+
+	fw_version = sram_read(tp, SRAM_GPHY_FW_VER);
+
+out:
+	rtl_reset_ocp_base(tp);
+
+	return ret;
+}
+
+void r8156_ram_code(struct r8152 *tp, bool power_cut)
+{
+	rtl_reset_ocp_base(tp);
+
+	if (tp->version == RTL_VER_10) {
+		rtl_pre_ram_code(tp, 0x8024, 0x8600, !power_cut);
+
+		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, BIT(7));
+
+		/* nc0_patch_180504_usb */
+		sram_write(tp, 0xA016, 0x0000);
+		sram_write(tp, 0xA012, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xA014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8013);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8021);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x802f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x803d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8042);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8051);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8051);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa088);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a50);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8008);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1a3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x401a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd707);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40c2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60a6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a6c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8080);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd019);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1a2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x401a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd707);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40c4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60a6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a84);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8970);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c07);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0901);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcf09);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd705);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xceff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf0a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1213);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8401);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8580);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1253);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd064);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd181);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4018);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc50f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd706);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2c59);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x804d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc60f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc605);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x10fd);
+		sram_write(tp, 0xA026, 0xffff);
+		sram_write(tp, 0xA024, 0xffff);
+		sram_write(tp, 0xA022, 0x10f4);
+		sram_write(tp, 0xA020, 0x1252);
+		sram_write(tp, 0xA006, 0x1206);
+		sram_write(tp, 0xA004, 0x0a78);
+		sram_write(tp, 0xA002, 0x0a60);
+		sram_write(tp, 0xA000, 0x0a4f);
+		sram_write(tp, 0xA008, 0x3f00);
+
+		/* nc1_patch_180423_cml_usb */
+		sram_write(tp, 0xA016, 0x0010);
+		sram_write(tp, 0xA012, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xA014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8066);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x807c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8089);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x808e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80b2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80c2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x62db);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x655c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd73e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60e9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x614a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x61ab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0505);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0509);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x653c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd73e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60e9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x614a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x61ab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0506);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x050a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd73e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60e9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x614a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x61ab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0505);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0506);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x050c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd73e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60e9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x614a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x61ab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0509);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x050a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x050c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0508);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd73e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60e9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x614a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x61ab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0321);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0321);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0321);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0508);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0321);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0346);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8208);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x609d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa50f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x001a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x001a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x607d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00ab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00ab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60fd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa50f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x017b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a05);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x017b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60fd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa50f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x01e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a05);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x01e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60fd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa50f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0231);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a05);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0231);
+		sram_write(tp, 0xA08E, 0xffff);
+		sram_write(tp, 0xA08C, 0x0221);
+		sram_write(tp, 0xA08A, 0x01ce);
+		sram_write(tp, 0xA088, 0x0169);
+		sram_write(tp, 0xA086, 0x00a6);
+		sram_write(tp, 0xA084, 0x000d);
+		sram_write(tp, 0xA082, 0x0308);
+		sram_write(tp, 0xA080, 0x029f);
+		sram_write(tp, 0xA090, 0x007f);
+
+		/* nc2_patch_180508_usb */
+		sram_write(tp, 0xA016, 0x0020);
+		sram_write(tp, 0xA012, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xA014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8017);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x801b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8029);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8054);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x805a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8064);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80a7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9430);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9480);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb408);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd120);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd057);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x064b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb80);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9906);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0567);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb94);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8406);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8dff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07e4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa840);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0773);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb91);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4063);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd139);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd140);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07dc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa610);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa2a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4045);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x405d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0742);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07ec);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f74);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0742);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fb6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8610);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07dc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x064b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07c0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0481);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x94bc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x870c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa280);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8220);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x078e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb92);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa840);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4063);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd140);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd150);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd703);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6121);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x61a2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6223);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf02f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d10);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf00f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d20);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d30);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf005);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d40);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07e4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa610);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa008);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4046);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x405d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0742);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07f7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f74);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0742);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fb5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07e4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3ad4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0537);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8610);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8840);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x064b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa70c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x890c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8840);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x064b);
+		sram_write(tp, 0xA10E, 0x0642);
+		sram_write(tp, 0xA10C, 0x0686);
+		sram_write(tp, 0xA10A, 0x0788);
+		sram_write(tp, 0xA108, 0x047b);
+		sram_write(tp, 0xA106, 0x065c);
+		sram_write(tp, 0xA104, 0x0769);
+		sram_write(tp, 0xA102, 0x0565);
+		sram_write(tp, 0xA100, 0x06f9);
+		sram_write(tp, 0xA110, 0x00ff);
+
+		/* uc2_patch_180507_usb */
+		sram_write(tp, 0xb87c, 0x8530);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xb87e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3caf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8593);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9caf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85a5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5afb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfb0c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x020d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x021b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x10bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86d7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86da);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbe0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x83fc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b10);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xda02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xdd02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5afb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfd0c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x020d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x021b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x10bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86dd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbe0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x83fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b10);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf2f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2cac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0286);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x65af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x212b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x022c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86b6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf21);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cd1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x870d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8719);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8716);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x871f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x871c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8728);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8725);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8707);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x281c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd100);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2202);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2b02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae1a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd101);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2202);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2b02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd101);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3a02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4c02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd100);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2e02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4602);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ab7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf35);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7ff8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfaef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x69bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86e3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86fb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86e6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86e9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86ec);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x025a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0262);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7cbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86f2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0262);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7cbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86f5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0262);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7cbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86f8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0262);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7cef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x96fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfc04);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf8fa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef69);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6273);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf202);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6273);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6273);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf802);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6273);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef96);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfefc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0420);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb540);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x53b5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4086);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb540);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb9b5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40c8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb03a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc8b0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbac8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb13a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc8b1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xba77);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd26);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffbd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2677);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd28);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffbd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2840);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd26);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc8bd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2640);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd28);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc8bd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x28bb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa430);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x98b0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1eba);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb01e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xdcb0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1e98);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb09e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbab0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9edc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb09e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x98b1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1eba);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb11e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xdcb1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1e98);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb19e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbab1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9edc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb19e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x11b0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1e22);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb01e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x33b0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1e11);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb09e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x22b0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9e33);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb09e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x11b1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1e22);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb11e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x33b1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1e11);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb19e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x22b1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9e33);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb19e);
+		sram_write(tp, 0xb85e, 0x2f71);
+		sram_write(tp, 0xb860, 0x20d9);
+		sram_write(tp, 0xb862, 0x2109);
+		sram_write(tp, 0xb864, 0x34e7);
+		sram_write(tp, 0xb878, 0x000f);
+
+		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, BIT(7));
+
+		rtl_post_ram_code(tp, 0x8024, !power_cut);
+	} else if (tp->version == RTL_VER_11) {
+		rtl_pre_ram_code(tp, 0x8024, 0x8601, !power_cut);
+
+		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, BIT(7));
+
+		/* nc_patch */
+		sram_write(tp, 0xA016, 0x0000);
+		sram_write(tp, 0xA012, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xA014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x808b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x808f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8093);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8097);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x809d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80aa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd718);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x607b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40da);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf00e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x42da);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf01e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd718);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x615b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1456);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14bc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd718);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f2e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf01c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1456);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14bc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd718);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f2e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf024);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1456);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14bc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd718);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f2e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf02c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1456);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14bc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd718);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f2e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf034);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd719);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4118);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac11);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa410);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4779);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf034);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd719);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4118);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac22);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa420);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4559);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf023);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd719);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4118);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac44);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa440);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4339);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf012);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd719);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4118);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa480);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xce00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4119);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1456);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd718);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc48f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x141b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x121a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd0b4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1bb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0898);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd0b4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1bb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a0e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd064);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd18a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0b7e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x401c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa804);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8804);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x053b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd500);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0648);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc520);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa201);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x252d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1646);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4006);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1646);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0308);
+		sram_write(tp, 0xA026, 0x0307);
+		sram_write(tp, 0xA024, 0x1645);
+		sram_write(tp, 0xA022, 0x0647);
+		sram_write(tp, 0xA020, 0x053a);
+		sram_write(tp, 0xA006, 0x0b7c);
+		sram_write(tp, 0xA004, 0x0a0c);
+		sram_write(tp, 0xA002, 0x0896);
+		sram_write(tp, 0xA000, 0x11a1);
+		sram_write(tp, 0xA008, 0xff00);
+
+		/* nc1_patch */
+		sram_write(tp, 0xA016, 0x0010);
+		sram_write(tp, 0xA012, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xA014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8015);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x801a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x801a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x801a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x801a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x801a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x801a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02d7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00ed);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0509);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc100);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x008f);
+		sram_write(tp, 0xA08E, 0xffff);
+		sram_write(tp, 0xA08C, 0xffff);
+		sram_write(tp, 0xA08A, 0xffff);
+		sram_write(tp, 0xA088, 0xffff);
+		sram_write(tp, 0xA086, 0xffff);
+		sram_write(tp, 0xA084, 0xffff);
+		sram_write(tp, 0xA082, 0x008d);
+		sram_write(tp, 0xA080, 0x00eb);
+		sram_write(tp, 0xA090, 0x0103);
+
+		/* nc2_patch */
+		sram_write(tp, 0xA016, 0x0020);
+		sram_write(tp, 0xA012, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xA014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8018);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8024);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8051);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8055);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8072);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80dc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfffd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfffd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa70c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x890c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8840);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa380);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x066e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb91);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4063);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd139);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd140);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa610);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa2a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8280);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x405d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0743);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f74);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0743);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fb6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8610);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x066e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd158);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03d4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x94bc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x870c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8380);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd10d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07c4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa280);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa220);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd130);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07c4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbb80);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1c4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd074);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x604b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa90c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0556);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb92);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4063);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd116);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd119);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd703);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6241);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x63e2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6583);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf054);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x611e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40da);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d10);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf02f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d50);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf02a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x611e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40da);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d20);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf021);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d60);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf01c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x611e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40da);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d30);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf013);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d70);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf00e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x611e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40da);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d40);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf005);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d80);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07e8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa610);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x405d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5ff4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa008);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4046);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0743);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07fb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd703);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f6f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f2d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f0c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07e8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa740);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0743);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fb5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3ad4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0556);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8610);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x066e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1f5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd049);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x01ec);
+		sram_write(tp, 0xA10E, 0x01ea);
+		sram_write(tp, 0xA10C, 0x06a9);
+		sram_write(tp, 0xA10A, 0x078a);
+		sram_write(tp, 0xA108, 0x03d2);
+		sram_write(tp, 0xA106, 0x067f);
+		sram_write(tp, 0xA104, 0x0665);
+		sram_write(tp, 0xA102, 0x0000);
+		sram_write(tp, 0xA100, 0x0000);
+		sram_write(tp, 0xA110, 0x00fc);
+
+		/* uc2 */
+		sram_write(tp, 0xb87c, 0x8530);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xb87e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3caf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8545);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x45af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8545);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xee82);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf900);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0103);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7f8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe0a6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa601);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x58f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa080);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x37a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae16);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa185);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x11a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae0c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa188);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x07a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae1c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe0b4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x62e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb463);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6901);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe4b4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x62e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb463);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe0b4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x62e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb463);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6901);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe4b4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x62e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb463);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfc04);
+		sram_write(tp, 0xb85e, 0x03b3);
+		sram_write(tp, 0xb860, 0xffff);
+		sram_write(tp, 0xb862, 0xffff);
+		sram_write(tp, 0xb864, 0xffff);
+		sram_write(tp, 0xb878, 0x0001);
+
+		/* data_ram_patch_v02_usb */
+		sram_write(tp, 0xb892, 0x0000);
+		sram_write(tp, 0xb88e, 0xc089);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xb890);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6050);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f6e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e6e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e6e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e12);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1214);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1516);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x171b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b1c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2021);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2224);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2424);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2424);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2424);
+		sram_write(tp, 0xb88e, 0xc018);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xb890);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0af2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d4a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0f26);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x118d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14f3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x175a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x19c0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1c26);
+
+		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, BIT(7));
+
+		rtl_post_ram_code(tp, 0x8024, !power_cut);
+
+		/* 100M MLT-3 Tx interpolator coefficient */
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0x81b3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0043);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00a7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00d6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00ec);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00f6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00fb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00fd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00ff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00bb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0058);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0029);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0013);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0009);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+	} else if (tp->version == RTL_VER_12) {
+		rtl_pre_ram_code(tp, 0x8024, 0x3700, !power_cut);
+
+		ocp_reg_set_bits(tp, OCP_PHY_PATCH_CMD, BIT(7));
+
+		/* nc_patch */
+		sram_write(tp, 0xA016, 0x0000);
+		sram_write(tp, 0xA012, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xA014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8025);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x803a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8044);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x808d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x808d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x808d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd712);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4077);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4159);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6099);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f44);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a14);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9201);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b1a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2425);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a14);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3ce5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1afb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd712);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4077);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4159);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60b9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2421);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1c17);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a14);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1c2c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2425);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a14);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3ce5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1c0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1c13);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6072);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8401);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa401);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x146e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0b77);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd703);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x665d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x653e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x641f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x62c4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6185);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6066);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x165a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc101);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1945);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fa6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x807d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1945);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2569);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8058);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x807d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc104);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1945);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fa4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x807d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc120);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1945);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd703);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x807d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc140);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1945);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd703);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fbe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x807d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1945);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd703);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fbd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc100);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6018);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x165a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x14f6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1e3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1356);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd705);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fbe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1559);
+		sram_write(tp, 0xA026, 0xffff);
+		sram_write(tp, 0xA024, 0xffff);
+		sram_write(tp, 0xA022, 0xffff);
+		sram_write(tp, 0xA020, 0x1557);
+		sram_write(tp, 0xA006, 0x1677);
+		sram_write(tp, 0xA004, 0x0b75);
+		sram_write(tp, 0xA002, 0x1c17);
+		sram_write(tp, 0xA000, 0x1b04);
+		sram_write(tp, 0xA008, 0x1f00);
+
+		/* nc1_patch */
+
+		/* nc2_patch */
+		sram_write(tp, 0xA016, 0x0020);
+		sram_write(tp, 0xA012, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xA014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8010);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x817f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82ab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x83f8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8454);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8459);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8465);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb11);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa50c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8310);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4076);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0903);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a4d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb12);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f84);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60f3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd413);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd410);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb13);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa108);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8108);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa910);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa780);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd14a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd048);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6255);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f74);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6326);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f07);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffe2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fab);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xba08);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9a08);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6535);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd40d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb14);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa780);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd14a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd048);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6206);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f47);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8064);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd40e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6073);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4216);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd120);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb21);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f9f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd196);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb22);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a6d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa640);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8910);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0f14);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb23);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8fc0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf40);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cc0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0f80);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xafc0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5dee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb24);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8f1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f6e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa111);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa215);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa401);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8640);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0b43);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0b86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb26);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f82);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8111);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8205);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb27);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa104);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8104);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa120);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd193);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd046);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb28);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb804);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f82);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9804);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb29);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb820);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f65);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9820);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb2a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd13d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8149);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa220);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8151);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f51);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb2f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f63);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd411);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd409);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb808);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fa3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9808);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0433);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb15);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa508);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a4d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f9f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd115);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd413);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb16);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a6d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa640);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd17a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0f14);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb17);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8fc0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf40);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cc0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0f80);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xafc0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a25);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x61ce);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5db4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb18);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8640);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0b43);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffd6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8f1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa131);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa2d5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa407);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa720);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8310);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa308);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8308);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb19);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8640);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9503);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0b43);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0b86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb1a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f82);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8111);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82c5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb804);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f82);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9804);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb1b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb820);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f65);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9820);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb1c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb1d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa220);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1f5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd049);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8221);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f51);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb808);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fa3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9808);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb2b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb2c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f84);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd14a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd048);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa780);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb2d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f94);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6208);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f27);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffe9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb2e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa406);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa220);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3444);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x827d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f51);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb2f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f63);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd411);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd409);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8406);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb808);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fa3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9808);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0433);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb30);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8380);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb31);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9308);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb204);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb301);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9204);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb32);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd408);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd141);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd043);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ccc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4c81);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x609e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa108);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8108);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa203);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8120);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8a0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa111);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8204);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa140);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8140);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd17a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa204);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8101);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8201);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa104);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8104);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa120);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa0f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd193);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd047);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd13d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf024);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8204);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa280);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8406);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4121);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60f3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8204);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa280);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb33);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa710);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb820);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd71f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f65);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9820);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb34);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6853);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8284);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb35);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd407);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8204);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa280);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4215);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1c3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd043);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8304);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4109);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf01e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb36);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd412);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6309);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x42c7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8280);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd14a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd048);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a7d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcc55);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa2a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6041);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd13d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f71);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb38);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8224);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa288);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x800a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6041);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd415);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a37);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd13d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd04a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb39);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa2a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6041);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd17a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd047);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fb4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0560);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa111);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd3f5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd219);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c31);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa215);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd30e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd21a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c31);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x63e9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f65);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f36);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c35);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8004);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c35);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8001);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4098);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9401);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd103);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb401);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c27);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa108);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c35);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8108);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8110);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8294);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa202);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0bdb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd39c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd210);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c31);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd39c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd210);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c31);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5fa5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c31);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x29b5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x840e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd708);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f4a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1014);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c31);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd709);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7fa4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x901f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c23);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb43);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa508);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3699);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x844a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa2a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2109);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05ea);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05ea);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcb90);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0ca0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x06db);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd1ff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd052);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa508);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8718);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa00a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa190);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa2a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa404);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c50);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x09ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a5e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd704);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2e70);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x06da);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f55);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa90c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0645);
+		sram_write(tp, 0xA10E, 0x0644);
+		sram_write(tp, 0xA10C, 0x09e9);
+		sram_write(tp, 0xA10A, 0x06da);
+		sram_write(tp, 0xA108, 0x05e1);
+		sram_write(tp, 0xA106, 0x0be4);
+		sram_write(tp, 0xA104, 0x0435);
+		sram_write(tp, 0xA102, 0x0141);
+		sram_write(tp, 0xA100, 0x026d);
+		sram_write(tp, 0xA110, 0x00ff);
+
+		/* uc2 */
+		sram_write(tp, 0xb87c, 0x85fe);
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0xb87e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x16af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8699);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe5af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x86f9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7aaf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x883a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x58af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b6c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd48b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7c02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8644);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2c00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x503c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffd6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac27);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x18e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x82fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad28);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cd4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b84);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0286);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x442c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x003c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac27);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x06ee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8299);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x01ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x04ee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8299);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x23dc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf9fa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcefa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x79fb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc4bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b76);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6dac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2804);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd203);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd201);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbdd8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x19d9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef94);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6d78);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x648a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbdd8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x19d9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef94);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6d78);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x72cd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac50);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x643a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x019f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe4ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4678);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd0ff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x97ff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfec6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfefd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x041f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x771f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x221c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x450d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x481f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7f04);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a94);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae08);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a94);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac7f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03d7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0100);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef46);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1c45);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef69);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef57);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef74);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0272);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe8a7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d1a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x941b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x979e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x072d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0100);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a64);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef76);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef97);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d98);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd400);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xff1d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x941a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x89cf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a75);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf74);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf9bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b79);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6da1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0005);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa0ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf26);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9aac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x284d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe08f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x10c0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe08f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfe10);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b08);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x04c8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf40);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67c8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8c02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc4bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6def);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x74e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x830c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad20);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x74ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xccef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x971b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x76ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae13);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef69);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef30);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b32);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc4ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x46e4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ffb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe58f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfce7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ffd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xcc10);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x11ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb8d1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf40);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4fbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ec4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8f02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c6d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef74);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe083);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0cad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2003);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0274);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaccc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef97);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b76);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad5f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x04ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x69ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3111);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaed1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0287);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x80af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2293);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf8f9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfafb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef59);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe080);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x13ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x252f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2802);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c6d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef64);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f44);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb91b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x64ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f1d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd688);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2bd7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x882e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0274);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x73ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5008);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x737c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0287);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd0bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x882b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0273);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x73e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x824c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf621);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe482);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4cbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8834);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0273);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7cef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x95ff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfefd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfc04);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf8f9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfafb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef79);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x737c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f22);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac32);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x31ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x12bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8822);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ed6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8fba);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f33);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac3c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1eef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x13bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8837);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4eef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x96d8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x19d9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1616);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x13ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xdf12);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaecc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7373);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef97);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfffe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfdfc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0466);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x88f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac8a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x92ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbadd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac6c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xeeac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6cff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x99ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0030);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd4c3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0000);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00b4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xecee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8298);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1412);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf8bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b5d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6d58);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8fb8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2901);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe58f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb8a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0049);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef47);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe483);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8303);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbfc2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f1a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x95f7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05ee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffd2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00d8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf605);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f11);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef60);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c6d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf728);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf628);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c64);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef46);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0289);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf89);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x96a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0149);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef47);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe483);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x04e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8305);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbfc2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f1a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x95f7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05ee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffd2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00d8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf605);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f11);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef60);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c6d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf729);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf629);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c64);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef46);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0289);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf89);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x96a0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0249);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef47);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe483);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x06e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8307);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbfc2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5f1a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x95f7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05ee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffd2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00d8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf605);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f11);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef60);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c6d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf72a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf62a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0c64);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef46);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6602);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0289);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x9902);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3920);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf89);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x96ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x47e4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8308);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe583);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x09bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc25f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a95);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf705);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xeeff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd200);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd8f6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x051f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x11ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x60bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b30);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ebf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b33);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6df7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2bbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b33);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ef6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2bbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b33);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4e0c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x64ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x46bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b69);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4e02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8999);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0239);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x20af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8996);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf39);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1ef8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf9fa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe08f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb838);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x201f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x66ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x65bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc21f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a96);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf705);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xeeff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd200);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xdaf6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc22f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a96);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf705);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xeeff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd200);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xdbf6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x021f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x110d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x42bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b3c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4eef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x021b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x031f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x110d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x42bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b36);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4eef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x021a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x031f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x110d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x42bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b39);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ebf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc23f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a96);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf705);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xeeff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd200);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xdaf6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc24f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a96);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf705);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xeeff);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd200);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xdbf6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x05ef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x021f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x110d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x42bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b45);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4eef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x021b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x031f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x110d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x42bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b3f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4eef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x021a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x031f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x110d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x42bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b42);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4eef);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x56d0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x201f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x11bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ebf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ebf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b4b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ee1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8578);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef03);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x480a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2805);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xef20);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1b01);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad27);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3f1f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x44e0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8560);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe185);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x61bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b51);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ee0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8566);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe185);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b54);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ee0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x856c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe185);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6dbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b57);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ee0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8572);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe185);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x73bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b5a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x026c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4ee1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8fb8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5900);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf728);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe58f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb8af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8b2c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe185);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x791b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x21ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x373e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f44);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x62e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8563);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x68e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8569);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6ee1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x856f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x74e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8575);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5a02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb859);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00f7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x28e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8fb8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae4a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1f44);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x64e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8565);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6ae1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x856b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x70e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8571);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe085);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x76e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8577);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5a02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6c4e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb859);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00f7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x28e5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8fb8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae0c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb839);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x04ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2f04);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xee8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfefd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfc04);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8efc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac8c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfaf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xacf8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf6f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfef0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xacfc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf4f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xacf2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xacb0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaef0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xacac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaaf0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xacee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0b0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x24f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb0a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0b1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x24f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb1a4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xee8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd400);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3976);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x66ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xeabb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa430);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e50);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e53);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e56);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e59);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e5c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e5f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e62);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6e65);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd9ac);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x70f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac6a);
+		sram_write(tp, 0xb85e, 0x23b7);
+		sram_write(tp, 0xb860, 0x74db);
+		sram_write(tp, 0xb862, 0x268c);
+		sram_write(tp, 0xb864, 0x3FE5);
+		sram_write(tp, 0xb886, 0x2250);
+		sram_write(tp, 0xb888, 0x140e);
+		sram_write(tp, 0xb88a, 0x3696);
+		sram_write(tp, 0xb88c, 0x3973);
+		sram_write(tp, 0xb838, 0x00ff);
+
+		ocp_reg_clr_bits(tp, OCP_PHY_PATCH_CMD, BIT(7));
+
+		/* uc */
+		ocp_reg_write(tp, OCP_SRAM_ADDR, 0x8464);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf84);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7caf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8485);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x13af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x851e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb9af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8684);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf87);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x01af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8701);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xac38);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x38bb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf38);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4618);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0a02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54b7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54c0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd400);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0fbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8507);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8504);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6759);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3008);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54c0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae06);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0d02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54b7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa183);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x15a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae10);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x59f0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa180);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x16bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8501);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x381b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae0b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xffbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x84fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x17bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x84fe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0254);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x84fb);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0254);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb7ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x09a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x5006);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf84);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfb02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54c0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf04);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4700);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad34);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfdad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0670);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae14);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf0a6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00b8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd32);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x30bd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x30aa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd2c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xccbd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2ca1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x0705);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xec80);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf40);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf7af);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x40f5);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd101);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54c0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd10f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6abf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xddbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85b0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xddbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85b3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xddbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85b6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ffa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xddd1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85aa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4802);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4d6a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbdd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfcdd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfddd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb602);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfedd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54b7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54b7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf3c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x2066);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb800);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb8bd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x30ee);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd2c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb8bd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7040);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc8bd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8640);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbd88);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xc8bd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8802);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1929);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa202);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x03a2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x032e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd10f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf7bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf9bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85b3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ffa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb602);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae2c);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd100);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ffc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfdbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85b3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ffe);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb602);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7e02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa100);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x02ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x25a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x041d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf1bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8675);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff2);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7802);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf3bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x867b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48ae);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x29a1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x070b);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xae24);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8102);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad28);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1be1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff4);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7502);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xe18f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xf5bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8678);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x48e1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf86);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x7b02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf09);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8420);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbc32);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x20bc);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x3e76);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbc08);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfda6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x1a00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb64e);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd101);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa402);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54c0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xd10f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaa02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f48);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024d);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x6abf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85ad);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xddbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85b0);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff8);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xddbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85b3);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ff9);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xddbf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85b6);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x67bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8ffa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xddd1);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x00bf);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x85aa);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x024f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4802);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4d6a);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xad02);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfbdd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb002);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfcdd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb302);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfddd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xb602);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x4f67);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf8f);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xfedd);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xbf85);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xa702);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x54b7);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0xaf00);
+		ocp_reg_write(tp, OCP_SRAM_DATA, 0x8800);
+		sram_write(tp, 0xb818, 0x38b8);
+		sram_write(tp, 0xb81a, 0x0444);
+		sram_write(tp, 0xb81c, 0x40ee);
+		sram_write(tp, 0xb81e, 0x3C1A);
+		sram_write(tp, 0xb850, 0x0981);
+		sram_write(tp, 0xb852, 0x0085);
+		sram_write(tp, 0xb878, 0xffff);
+		sram_write(tp, 0xb884, 0xffff);
+		sram_write(tp, 0xb832, 0x003f);
+
+		rtl_post_ram_code(tp, 0x8024, !power_cut);
+	} else {
+		rtl_ram_code_speed_up(tp, !power_cut);
+	}
+
+	rtl_reset_ocp_base(tp);
+}
+
+void r8156_patch_code(struct r8152 *tp)
+{
+	if (tp->version == RTL_VER_11) {
+		static u8 usb_patch3_b[] = {
+			0x10, 0xe0, 0x12, 0xe0,
+			0x33, 0xe0, 0x7d, 0xe0,
+			0x92, 0xe0, 0xae, 0xe0,
+			0xce, 0xe0, 0x23, 0xe1,
+			0x3f, 0xe1, 0x58, 0xe1,
+			0x84, 0xe1, 0xca, 0xe1,
+			0xd9, 0xe1, 0xeb, 0xe1,
+			0x02, 0xe2, 0xe0, 0xe2,
+			0x02, 0xc0, 0x00, 0xb8,
+			0xf0, 0x4b, 0x1c, 0xc6,
+			0xc0, 0x61, 0x04, 0x11,
+			0x15, 0xf1, 0x19, 0xc6,
+			0xc0, 0x61, 0x9c, 0x20,
+			0x9c, 0x24, 0x09, 0x11,
+			0x0f, 0xf1, 0x14, 0xc6,
+			0x01, 0x19, 0xc0, 0x89,
+			0x13, 0xc1, 0x13, 0xc6,
+			0x24, 0x9e, 0x00, 0x1e,
+			0x26, 0x8e, 0x26, 0x76,
+			0xef, 0x49, 0xfe, 0xf1,
+			0x22, 0x76, 0x08, 0xc1,
+			0x22, 0x9e, 0x07, 0xc6,
+			0x02, 0xc1, 0x00, 0xb9,
+			0x9e, 0x09, 0x18, 0xb4,
+			0x4a, 0xb4, 0x90, 0xcc,
+			0x80, 0xd4, 0x08, 0xdc,
+			0x10, 0xe8, 0x28, 0xe8,
+			0x23, 0xc7, 0x21, 0xc2,
+			0xec, 0x9a, 0x00, 0x19,
+			0xee, 0x89, 0xee, 0x71,
+			0x9f, 0x49, 0xfe, 0xf1,
+			0xea, 0x71, 0x9f, 0x49,
+			0x14, 0xf0, 0x1a, 0xc2,
+			0xec, 0x9a, 0x00, 0x19,
+			0xe8, 0x99, 0x81, 0x19,
+			0xee, 0x89, 0xee, 0x71,
+			0x9f, 0x49, 0xfe, 0xf1,
+			0x12, 0xc2, 0xec, 0x9a,
+			0x00, 0x19, 0x98, 0x20,
+			0xe8, 0x99, 0x82, 0x19,
+			0xee, 0x89, 0xee, 0x71,
+			0x9f, 0x49, 0xfe, 0xf1,
+			0x06, 0xc3, 0x02, 0xc2,
+			0x00, 0xba, 0x3e, 0x29,
+			0x4c, 0xe8, 0x00, 0xdc,
+			0x00, 0xd4, 0x24, 0xe4,
+			0x04, 0xe4, 0x00, 0xb4,
+			0x04, 0xb4, 0x05, 0xb4,
+			0x06, 0xb4, 0x51, 0xc0,
+			0x00, 0x75, 0xd9, 0x49,
+			0x17, 0xf0, 0x30, 0xc0,
+			0xf6, 0xc5, 0x00, 0x1e,
+			0x68, 0x23, 0x08, 0x9e,
+			0x0c, 0x9d, 0x82, 0x1c,
+			0x0e, 0x8c, 0x0e, 0x74,
+			0xcf, 0x49, 0xfe, 0xf1,
+			0x25, 0xc0, 0xeb, 0xc5,
+			0x11, 0x1e, 0x68, 0x23,
+			0x08, 0x9e, 0x0c, 0x9d,
+			0x82, 0x1c, 0x0e, 0x8c,
+			0x0e, 0x74, 0xcf, 0x49,
+			0xfe, 0xf1, 0x06, 0xb0,
+			0x05, 0xb0, 0x04, 0xb0,
+			0x00, 0xb0, 0x80, 0xff,
+			0x32, 0xc0, 0x00, 0x75,
+			0xd8, 0x49, 0x0d, 0xf0,
+			0x11, 0xc0, 0xd6, 0xc5,
+			0x00, 0x1e, 0x08, 0x9e,
+			0x73, 0xc6, 0x0a, 0x9e,
+			0x0c, 0x9d, 0x8f, 0x1c,
+			0x0e, 0x8c, 0x0e, 0x74,
+			0xcf, 0x49, 0xfe, 0xf1,
+			0x04, 0xc0, 0x02, 0xc1,
+			0x00, 0xb9, 0x00, 0x1d,
+			0x20, 0xd4, 0x00, 0xdc,
+			0xc7, 0xef, 0x1b, 0xc0,
+			0x00, 0x75, 0xd8, 0x48,
+			0x00, 0x9d, 0xbe, 0xc7,
+			0x15, 0xc2, 0xec, 0x9a,
+			0x00, 0x19, 0xe8, 0x9a,
+			0x81, 0x19, 0xee, 0x89,
+			0xee, 0x71, 0x9f, 0x49,
+			0xfe, 0xf1, 0x2e, 0xc1,
+			0xec, 0x99, 0x81, 0x19,
+			0xee, 0x89, 0xee, 0x71,
+			0x9f, 0x49, 0xfe, 0xf1,
+			0x04, 0xc3, 0x02, 0xc2,
+			0x00, 0xba, 0x3a, 0x27,
+			0xc0, 0xd4, 0x24, 0xe4,
+			0x34, 0xd3, 0xc0, 0x88,
+			0x1e, 0xc6, 0xc0, 0x70,
+			0x8f, 0x49, 0x0e, 0xf0,
+			0x8f, 0x48, 0x3f, 0xc6,
+			0xca, 0x98, 0x11, 0x18,
+			0xc8, 0x98, 0x16, 0xc0,
+			0xcc, 0x98, 0x8f, 0x18,
+			0xce, 0x88, 0xce, 0x70,
+			0x8f, 0x49, 0xfe, 0xf1,
+			0x0b, 0xe0, 0x33, 0xc6,
+			0x00, 0x18, 0xc8, 0x98,
+			0x0b, 0xc0, 0xcc, 0x98,
+			0x81, 0x18, 0xce, 0x88,
+			0xce, 0x70, 0x8f, 0x49,
+			0xfe, 0xf1, 0x02, 0xc0,
+			0x00, 0xb8, 0xbc, 0x21,
+			0x40, 0xd3, 0x20, 0xe4,
+			0x29, 0xc0, 0x01, 0x66,
+			0x05, 0x16, 0x3e, 0xf0,
+			0x25, 0x16, 0x40, 0xf0,
+			0x09, 0x16, 0x23, 0xf0,
+			0x16, 0xe0, 0x1a, 0xc2,
+			0x40, 0x76, 0xe1, 0x48,
+			0x40, 0x9e, 0x17, 0xc2,
+			0x00, 0x1e, 0x48, 0x9e,
+			0xef, 0xc6, 0x4c, 0x9e,
+			0x81, 0x1e, 0x4e, 0x8e,
+			0x4e, 0x76, 0xef, 0x49,
+			0xfe, 0xf1, 0x0b, 0xc6,
+			0x4c, 0x9e, 0x81, 0x1e,
+			0x4e, 0x8e, 0x4e, 0x76,
+			0xef, 0x49, 0xfe, 0xf1,
+			0x90, 0x49, 0x02, 0xc7,
+			0x00, 0xbf, 0x64, 0x39,
+			0x24, 0xe4, 0x34, 0xd3,
+			0x00, 0xdc, 0x00, 0xdc,
+			0x24, 0xe4, 0x80, 0x02,
+			0x34, 0xd3, 0x80, 0xc3,
+			0xf9, 0xc2, 0x40, 0x76,
+			0xe1, 0x48, 0x40, 0x9e,
+			0xf6, 0xc2, 0x00, 0x1e,
+			0x48, 0x9e, 0xce, 0xc6,
+			0x4c, 0x9e, 0x81, 0x1e,
+			0x4e, 0x8e, 0x4e, 0x76,
+			0xef, 0x49, 0xfe, 0xf1,
+			0xea, 0xc6, 0x4c, 0x9e,
+			0x81, 0x1e, 0x4e, 0x8e,
+			0x4e, 0x76, 0xef, 0x49,
+			0xfe, 0xf1, 0xdf, 0xe7,
+			0x40, 0xd4, 0xff, 0xc2,
+			0x4c, 0x73, 0xbf, 0x49,
+			0xc5, 0xf0, 0xe3, 0xc6,
+			0xc0, 0x75, 0xd1, 0x49,
+			0xd6, 0xf0, 0xdc, 0xc0,
+			0xdc, 0xc6, 0x0c, 0x9e,
+			0x00, 0x1e, 0x08, 0x9e,
+			0xd9, 0xc6, 0x0a, 0x9e,
+			0x8f, 0x1e, 0x0e, 0x8e,
+			0x0e, 0x76, 0xef, 0x49,
+			0xfe, 0xf1, 0xc9, 0xe7,
+			0x1a, 0xc6, 0xc0, 0x67,
+			0xf0, 0x49, 0x13, 0xf0,
+			0xf0, 0x48, 0xc0, 0x8f,
+			0xc2, 0x77, 0x14, 0xc1,
+			0x14, 0xc6, 0x24, 0x9e,
+			0x22, 0x9f, 0x8c, 0x1e,
+			0x26, 0x8e, 0x26, 0x76,
+			0xef, 0x49, 0xfe, 0xf1,
+			0xfb, 0x49, 0x05, 0xf0,
+			0x07, 0xc6, 0xc0, 0x61,
+			0x10, 0x48, 0xc0, 0x89,
+			0x02, 0xc6, 0x00, 0xbe,
+			0x96, 0x52, 0x6c, 0xb4,
+			0x90, 0xcc, 0x08, 0xdc,
+			0x10, 0xe8, 0x16, 0xef,
+			0x18, 0xc0, 0x00, 0x72,
+			0xa8, 0x49, 0x0d, 0xf0,
+			0x11, 0xc0, 0x11, 0xc2,
+			0x00, 0x19, 0x08, 0x99,
+			0x0c, 0x9a, 0x0e, 0xc1,
+			0x0a, 0x99, 0x8f, 0x1b,
+			0x0e, 0x8b, 0x0e, 0x73,
+			0xbf, 0x49, 0xfe, 0xf1,
+			0x04, 0xc0, 0x02, 0xc2,
+			0x00, 0xba, 0x64, 0x62,
+			0x02, 0xcf, 0x00, 0xdc,
+			0x24, 0xe4, 0x80, 0x02,
+			0x34, 0xd3, 0x2c, 0xc3,
+			0x60, 0x70, 0x80, 0x49,
+			0xfd, 0xf0, 0x27, 0xc3,
+			0x66, 0x60, 0x80, 0x48,
+			0x02, 0x48, 0x66, 0x88,
+			0x00, 0x48, 0x82, 0x48,
+			0x66, 0x88, 0x1b, 0xc3,
+			0x60, 0x70, 0x17, 0xc4,
+			0x88, 0x98, 0x14, 0xc0,
+			0x8c, 0x98, 0x83, 0x18,
+			0x8e, 0x88, 0x8e, 0x70,
+			0x8f, 0x49, 0xfe, 0xf1,
+			0x62, 0x70, 0x8a, 0x98,
+			0x0d, 0xc0, 0x8c, 0x98,
+			0x84, 0x18, 0x8e, 0x88,
+			0x8e, 0x70, 0x8f, 0x49,
+			0xfe, 0xf1, 0x08, 0xc3,
+			0x02, 0xc4, 0x00, 0xbc,
+			0x68, 0x0f, 0x6c, 0xe9,
+			0x00, 0xdc, 0x50, 0xe8,
+			0x30, 0xc1, 0x36, 0xd3,
+			0x80, 0x10, 0x00, 0x00,
+			0x80, 0xd4, 0x26, 0xd8,
+			0x44, 0xc2, 0x4a, 0x41,
+			0x94, 0x20, 0x42, 0xc0,
+			0x16, 0x00, 0x00, 0x73,
+			0x40, 0xc4, 0x5c, 0x41,
+			0x8b, 0x41, 0x0b, 0x18,
+			0x38, 0xc6, 0xc0, 0x88,
+			0xc1, 0x99, 0x21, 0xe8,
+			0x35, 0xc0, 0x00, 0x73,
+			0xbd, 0x48, 0x0d, 0x18,
+			0x30, 0xc6, 0xc0, 0x88,
+			0xc1, 0x9b, 0x19, 0xe8,
+			0x2d, 0xc0, 0x02, 0x73,
+			0x35, 0x48, 0x0e, 0x18,
+			0x28, 0xc6, 0xc0, 0x88,
+			0xc1, 0x9b, 0x11, 0xe8,
+			0xdf, 0xc3, 0xdd, 0xc6,
+			0x01, 0x03, 0x1e, 0x40,
+			0xfe, 0xf1, 0x20, 0xc0,
+			0x02, 0x73, 0xb5, 0x48,
+			0x0e, 0x18, 0x1b, 0xc6,
+			0xc0, 0x88, 0xc1, 0x9b,
+			0x04, 0xe8, 0x02, 0xc6,
+			0x00, 0xbe, 0xb6, 0x10,
+			0x00, 0xb4, 0x01, 0xb4,
+			0x02, 0xb4, 0x03, 0xb4,
+			0x10, 0xc3, 0x0e, 0xc2,
+			0x61, 0x71, 0x40, 0x99,
+			0x60, 0x60, 0x0e, 0x48,
+			0x42, 0x98, 0x42, 0x70,
+			0x8e, 0x49, 0xfe, 0xf1,
+			0x03, 0xb0, 0x02, 0xb0,
+			0x01, 0xb0, 0x00, 0xb0,
+			0x80, 0xff, 0xc0, 0xd4,
+			0x8f, 0xcb, 0xaa, 0xc7,
+			0x1e, 0x00, 0x90, 0xc7,
+			0x1f, 0xfe, 0x0a, 0x10,
+			0x0c, 0xf0, 0x0b, 0x10,
+			0x0a, 0xf0, 0x0d, 0x10,
+			0x08, 0xf0, 0x0e, 0x10,
+			0x06, 0xf0, 0x24, 0x10,
+			0x04, 0xf0, 0x02, 0xc7,
+			0x00, 0xbf, 0x58, 0x11,
+			0x02, 0xc7, 0x00, 0xbf,
+			0x62, 0x11, 0xec, 0xc0,
+			0x02, 0x75, 0xd5, 0x48,
+			0x0e, 0x18, 0xe7, 0xc6,
+			0xc0, 0x88, 0xc1, 0x9d,
+			0xd0, 0xef, 0xe4, 0xc0,
+			0x02, 0x75, 0x55, 0x48,
+			0x0e, 0x18, 0xdf, 0xc6,
+			0xc0, 0x88, 0xc1, 0x9d,
+			0xc8, 0xef, 0x02, 0xc7,
+			0x00, 0xbf, 0x8e, 0x11,
+			0x16, 0xc0, 0xbb, 0x21,
+			0xb9, 0x25, 0x00, 0x71,
+			0x13, 0xc2, 0x4a, 0x41,
+			0x8b, 0x41, 0x24, 0x18,
+			0xd0, 0xc6, 0xc0, 0x88,
+			0xc1, 0x99, 0xb9, 0xef,
+			0x0a, 0xc0, 0x08, 0x71,
+			0x28, 0x18, 0xc9, 0xc6,
+			0xc0, 0x88, 0xc1, 0x99,
+			0xb2, 0xef, 0x02, 0xc0,
+			0x00, 0xb8, 0x3c, 0x11,
+			0xd8, 0xc7, 0x83, 0xff,
+			0x01, 0xb4, 0x02, 0xb4,
+			0x03, 0xb4, 0x04, 0xb4,
+			0x05, 0xb4, 0x44, 0xc4,
+			0x45, 0xc0, 0x48, 0xc1,
+			0x81, 0x1b, 0xce, 0xe8,
+			0x46, 0xc0, 0x44, 0xc2,
+			0x84, 0x1b, 0xca, 0xe8,
+			0x59, 0xc0, 0x00, 0x1b,
+			0xc7, 0xe8, 0x80, 0x65,
+			0xdb, 0x22, 0xdd, 0x26,
+			0x03, 0x15, 0x12, 0xf1,
+			0x4e, 0xc0, 0x37, 0xc1,
+			0x81, 0x1b, 0xbe, 0xe8,
+			0x4b, 0xc0, 0x32, 0xc1,
+			0x88, 0x1b, 0xba, 0xe8,
+			0x48, 0xc0, 0x49, 0xc1,
+			0x81, 0x1b, 0xb6, 0xe8,
+			0x04, 0x00, 0x46, 0xc1,
+			0x46, 0xc2, 0x8f, 0x1b,
+			0xb1, 0xe8, 0x25, 0xc0,
+			0x29, 0xc1, 0x2b, 0xc2,
+			0x8f, 0x1b, 0xac, 0xe8,
+			0x04, 0x00, 0x3e, 0xc1,
+			0x27, 0xc2, 0xa8, 0xe8,
+			0x04, 0x00, 0x2b, 0xc1,
+			0x2b, 0xc2, 0xa4, 0xe8,
+			0x04, 0x00, 0x29, 0xc1,
+			0x2b, 0xc2, 0xa0, 0xe8,
+			0x04, 0x00, 0x26, 0xc1,
+			0x26, 0xc2, 0x9c, 0xe8,
+			0x04, 0x00, 0x24, 0xc1,
+			0x21, 0xc2, 0x98, 0xe8,
+			0x04, 0x00, 0x21, 0xc1,
+			0x1f, 0xc2, 0x94, 0xe8,
+			0x04, 0x00, 0x1a, 0xc1,
+			0x1d, 0xc2, 0x90, 0xe8,
+			0x3d, 0xe0, 0x08, 0xdc,
+			0x3c, 0xe8, 0x14, 0xe8,
+			0x00, 0xf8, 0x00, 0x40,
+			0x00, 0x00, 0x01, 0x00,
+			0x9a, 0xd3, 0x04, 0xe0,
+			0x02, 0xe0, 0x0b, 0xe0,
+			0x0c, 0xe0, 0x25, 0xe0,
+			0xef, 0x1f, 0xa8, 0x8f,
+			0x02, 0xc7, 0x00, 0xbf,
+			0x76, 0x15, 0x66, 0x15,
+			0xa0, 0x49, 0x05, 0xf1,
+			0xa4, 0x49, 0x00, 0xbe,
+			0xca, 0x1a, 0x02, 0xc6,
+			0xe0, 0x1a, 0xce, 0x13,
+			0x80, 0xe0, 0xcb, 0xe0,
+			0xe0, 0xe8, 0x28, 0xdc,
+			0x13, 0x00, 0x08, 0x11,
+			0x42, 0x80, 0x0e, 0xe0,
+			0x06, 0xb4, 0x84, 0x76,
+			0x31, 0x40, 0x82, 0x71,
+			0x0c, 0xe8, 0x81, 0x24,
+			0x1f, 0x48, 0x84, 0x99,
+			0x08, 0xe8, 0x80, 0x49,
+			0x03, 0xf1, 0x80, 0x71,
+			0x80, 0xff, 0x85, 0x61,
+			0x96, 0x24, 0xfd, 0xf1,
+			0x06, 0xb0, 0x00, 0x11,
+			0x6c, 0x0f, 0x34, 0x1c,
+			0x28, 0xfc, 0x38, 0xfc,
+			0x0f, 0x00, 0xc8, 0x1a,
+			0xbe, 0x13, 0x04, 0x00,
+			0xe6, 0xc1, 0xea, 0xc2,
+			0x4f, 0xe8, 0x04, 0x00,
+			0xe3, 0xc1, 0xe3, 0xc2,
+			0x4b, 0xe8, 0x04, 0x00,
+			0xe8, 0xc1, 0xe0, 0xc2,
+			0x47, 0xe8, 0x04, 0x00,
+			0xc1, 0xc1, 0xdd, 0xc2,
+			0x43, 0xe8, 0x04, 0x00,
+			0xdb, 0xc1, 0xdb, 0xc2,
+			0x3f, 0xe8, 0x04, 0x00,
+			0xd9, 0xc1, 0xd9, 0xc2,
+			0x3b, 0xe8, 0x04, 0x00,
+			0xd7, 0xc1, 0xd7, 0xc2,
+			0x37, 0xe8, 0x04, 0x00,
+			0xd5, 0xc1, 0xaf, 0xc2,
+			0x33, 0xe8, 0x04, 0x00,
+			0xc9, 0xc1, 0xd5, 0xc2,
+			0x2f, 0xe8, 0x04, 0x00,
+			0xce, 0xc1, 0xce, 0xc2,
+			0x2b, 0xe8, 0x04, 0x00,
+			0xcc, 0xc1, 0xce, 0xc2,
+			0x27, 0xe8, 0x04, 0x00,
+			0xc9, 0xc1, 0xc5, 0xc2,
+			0x23, 0xe8, 0x04, 0x00,
+			0xa0, 0xc1, 0xa0, 0xc2,
+			0x1f, 0xe8, 0x04, 0x00,
+			0x9e, 0xc1, 0x9e, 0xc2,
+			0x1b, 0xe8, 0x04, 0x00,
+			0x9c, 0xc1, 0x83, 0x1b,
+			0x17, 0xe8, 0xbf, 0xc0,
+			0xc1, 0xc1, 0xc1, 0xc2,
+			0x8f, 0x1b, 0x12, 0xe8,
+			0x04, 0x00, 0xb8, 0xc1,
+			0x93, 0xc2, 0x8f, 0x1b,
+			0x0d, 0xe8, 0xb6, 0xc0,
+			0xb6, 0xc1, 0x81, 0x1b,
+			0x09, 0xe8, 0x05, 0xb0,
+			0x04, 0xb0, 0x03, 0xb0,
+			0x02, 0xb0, 0x01, 0xb0,
+			0x60, 0x70, 0xa9, 0xc3,
+			0x00, 0xbb, 0x84, 0x98,
+			0x80, 0x99, 0x82, 0x9a,
+			0x86, 0x8b, 0x86, 0x75,
+			0xdf, 0x49, 0xfe, 0xf1,
+			0x80, 0xff, 0x3b, 0xc0,
+			0x3b, 0xc1, 0x00, 0x70,
+			0x08, 0x40, 0x34, 0xf1,
+			0x38, 0xc0, 0x38, 0xc1,
+			0x0c, 0x99, 0x00, 0x19,
+			0x0e, 0x89, 0x0e, 0x71,
+			0x9f, 0x49, 0xfe, 0xf1,
+			0x0a, 0x71, 0x9a, 0x48,
+			0x0a, 0x99, 0x8f, 0x19,
+			0x0e, 0x89, 0x0e, 0x71,
+			0x9f, 0x49, 0xfe, 0xf1,
+			0x2a, 0xc0, 0x00, 0x71,
+			0x90, 0x48, 0x00, 0x99,
+			0x27, 0xc0, 0x00, 0x71,
+			0x13, 0x48, 0x00, 0x99,
+			0x20, 0xc0, 0x20, 0xc1,
+			0x0c, 0x99, 0x00, 0x19,
+			0x0e, 0x89, 0x0e, 0x71,
+			0x9f, 0x49, 0xfe, 0xf1,
+			0x0a, 0x71, 0x9b, 0x48,
+			0x0a, 0x99, 0x8f, 0x19,
+			0x0e, 0x89, 0x0e, 0x71,
+			0x9f, 0x49, 0xfe, 0xf1,
+			0x12, 0xc0, 0x00, 0x71,
+			0x10, 0x48, 0x00, 0x99,
+			0x0f, 0xc0, 0x00, 0x71,
+			0x93, 0x48, 0x00, 0x99,
+			0x06, 0xc0, 0x00, 0x19,
+			0x00, 0x99, 0x09, 0xc7,
+			0x09, 0xc5, 0x00, 0xbd,
+			0x80, 0xd2, 0x86, 0x64,
+			0x00, 0xdc, 0x10, 0xe8,
+			0xb0, 0xd4, 0x06, 0xd4,
+			0xc0, 0xd4, 0x72, 0x14};
+		static u8 pla_patch11[] = {
+			0x05, 0xe0, 0x0a, 0xe0,
+			0x38, 0xe0, 0x3a, 0xe0,
+			0x57, 0xe0, 0x05, 0xc2,
+			0x40, 0x76, 0x02, 0xc4,
+			0x00, 0xbc, 0xd6, 0x0b,
+			0x1e, 0xfc, 0x29, 0xc5,
+			0xa0, 0x77, 0x2b, 0xc4,
+			0xa0, 0x9c, 0x26, 0xc5,
+			0xa0, 0x64, 0x01, 0x14,
+			0x0b, 0xf0, 0x02, 0x14,
+			0x09, 0xf0, 0x01, 0x07,
+			0xf1, 0x49, 0x06, 0xf0,
+			0x21, 0xc7, 0xe0, 0x8e,
+			0x11, 0x1e, 0xe0, 0x8e,
+			0x14, 0xe0, 0x17, 0xc5,
+			0x00, 0x1f, 0xa0, 0x9f,
+			0x13, 0xc5, 0xa0, 0x77,
+			0xa0, 0x74, 0x46, 0x48,
+			0x47, 0x48, 0xa0, 0x9c,
+			0x11, 0xc5, 0xa0, 0x74,
+			0x44, 0x48, 0x43, 0x48,
+			0xa0, 0x9c, 0x08, 0xc5,
+			0xa0, 0x9f, 0x02, 0xc5,
+			0x00, 0xbd, 0xea, 0x03,
+			0x02, 0xc5, 0x00, 0xbd,
+			0xf6, 0x03, 0x1c, 0xe8,
+			0xaa, 0xd3, 0x08, 0xb7,
+			0x6c, 0xe8, 0x20, 0xe8,
+			0x00, 0xa0, 0x38, 0xe4,
+			0x02, 0xc5, 0x00, 0xbd,
+			0xcc, 0x06, 0xd4, 0x49,
+			0x17, 0xf0, 0x19, 0xc5,
+			0xa4, 0x64, 0xc1, 0x49,
+			0x07, 0xf1, 0x16, 0xc5,
+			0xa0, 0x64, 0xc7, 0x48,
+			0x46, 0x48, 0xa0, 0x8c,
+			0x06, 0xe0, 0x10, 0xc5,
+			0xa0, 0x64, 0x47, 0x48,
+			0xc6, 0x48, 0xa0, 0x8c,
+			0x0c, 0xc7, 0xe0, 0x8e,
+			0x11, 0x1e, 0xe0, 0x8e,
+			0x02, 0xc7, 0x00, 0xbf,
+			0x88, 0x04, 0x02, 0xc7,
+			0x00, 0xbf, 0xbe, 0x03,
+			0x5c, 0xdc, 0xf0, 0xd3,
+			0x20, 0xe4, 0xd2, 0x49,
+			0x08, 0xf1, 0xd3, 0x49,
+			0x55, 0xf1, 0xd4, 0x49,
+			0x1e, 0xf1, 0xd5, 0x49,
+			0x45, 0xf1, 0x4d, 0xe0,
+			0x5a, 0xc7, 0xe0, 0x72,
+			0xa0, 0x49, 0x05, 0xf0,
+			0x54, 0xc7, 0xe0, 0x72,
+			0xaf, 0x49, 0x0e, 0xf1,
+			0x53, 0xc7, 0xff, 0x1a,
+			0xe0, 0x9a, 0x51, 0xc2,
+			0xe4, 0x9a, 0x50, 0xc2,
+			0xe6, 0x9a, 0x01, 0x1a,
+			0xe0, 0x9a, 0x4d, 0xc2,
+			0xe4, 0x9a, 0x4a, 0xc2,
+			0xe6, 0x9a, 0x44, 0xc7,
+			0xe5, 0x8e, 0x00, 0x1d,
+			0xe5, 0x8d, 0x30, 0xe0,
+			0x38, 0xc7, 0xe0, 0x75,
+			0xda, 0x49, 0x1f, 0xf0,
+			0x35, 0xc7, 0xe0, 0x75,
+			0xdc, 0x49, 0x1b, 0xf1,
+			0x32, 0xc7, 0xe0, 0x75,
+			0xd5, 0x49, 0x17, 0xf0,
+			0x39, 0xc7, 0xe0, 0x75,
+			0xd8, 0x48, 0xd9, 0x48,
+			0xda, 0x48, 0xdb, 0x48,
+			0xe0, 0x9d, 0x2a, 0xc7,
+			0xe0, 0x75, 0xdb, 0x49,
+			0x03, 0xf1, 0xde, 0x49,
+			0x0d, 0xf0, 0x22, 0xc7,
+			0xe4, 0x75, 0xd0, 0x49,
+			0x09, 0xf1, 0x1f, 0xc5,
+			0xe6, 0x9d, 0x11, 0x1d,
+			0xe4, 0x8d, 0x04, 0xe0,
+			0x19, 0xc7, 0x00, 0x1d,
+			0xe4, 0x8d, 0xe0, 0x8e,
+			0x11, 0x1d, 0xe0, 0x8d,
+			0x07, 0xe0, 0x0f, 0xc7,
+			0xe0, 0x75, 0xda, 0x48,
+			0xe0, 0x9d, 0x0e, 0xc7,
+			0xe4, 0x8e, 0x02, 0xc4,
+			0x00, 0xbc, 0xd6, 0x03,
+			0x02, 0xc4, 0x00, 0xbc,
+			0xc2, 0x03, 0x02, 0xc4,
+			0x00, 0xbc, 0x5a, 0x04,
+			0x12, 0xe8, 0x4e, 0xe8,
+			0x08, 0xe9, 0x20, 0xe4,
+			0x80, 0x02, 0x9a, 0xc0,
+			0x4e, 0xe8, 0x00, 0xe4,
+			0x10, 0xe0, 0xe0, 0xe8,
+			0x80, 0x11, 0x02, 0x80,
+			0x30, 0x10, 0xb4, 0xc0};
+		u8 new_ver;
+
+		rtl_fw_ver_erase(tp);
+
+		new_ver = 7;
+		if (rtl_check_fw_ver_ok(tp, USB_FW_USB_VER, new_ver)) {
+			rtl_clear_bp(tp, MCU_TYPE_USB);
+
+			generic_ocp_write(tp, 0xe600, 0xff,
+					  sizeof(usb_patch3_b), usb_patch3_b,
+					  MCU_TYPE_USB);
+
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_BA, 0xa000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_0, 0x39d4);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_1, 0x099c);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_2, 0x293c);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_3, 0x1cfe);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_4, 0x2738);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_5, 0x21ba);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_6, 0x3962);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_7, 0x51ba);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_8, 0x6262);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_9, 0x0f66);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_10, 0x1098);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_11, 0x1148);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_12, 0x116c);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_13, 0x10e0);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_14, 0x0f6a);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_15, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP2_EN, 0x7fff);
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USB_VER,
+				       new_ver);
+		}
+
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_FIX_EN1,
+				  FW_IP_RESET_EN);
+
+		ocp_write_dword(tp, MCU_TYPE_USB, USB_UPHY3_MDCMDIO, 0x4026840e);
+		ocp_write_dword(tp, MCU_TYPE_USB, USB_UPHY3_MDCMDIO, 0x4001acc9);
+
+		new_ver = 6;
+		if (rtl_check_fw_ver_ok(tp, USB_FW_PLA_VER, new_ver)) {
+			rtl_clear_bp(tp, MCU_TYPE_PLA);
+
+			generic_ocp_write(tp, 0xf800, 0xff, sizeof(pla_patch11),
+					  pla_patch11, MCU_TYPE_PLA);
+
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_BA, 0x8000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_0, 0x0bc2);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_1, 0x03e0);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_2, 0x06b8);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_3, 0x03ba);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_4, 0x03b2);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_5, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_6, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_7, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_EN, 0x0017);
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_PLA_VER,
+				       new_ver);
+		}
+	} else if (tp->version == RTL_VER_12) {
+		static u8 usb_patch4_a[] = {
+			0x10, 0xe0, 0x38, 0xe0,
+			0x4e, 0xe0, 0x8b, 0xe0,
+			0xc1, 0xe0, 0xcd, 0xe0,
+			0xd5, 0xe0, 0xed, 0xe0,
+			0xf9, 0xe0, 0xfb, 0xe0,
+			0xfd, 0xe0, 0xff, 0xe0,
+			0x01, 0xe1, 0x03, 0xe1,
+			0x05, 0xe1, 0x07, 0xe1,
+			0x22, 0xc2, 0x4a, 0x41,
+			0x91, 0x20, 0x20, 0xc0,
+			0x16, 0x00, 0x00, 0x73,
+			0x1e, 0xc4, 0x5c, 0x41,
+			0x8b, 0x41, 0x1a, 0xc0,
+			0x1a, 0x00, 0x00, 0x73,
+			0xbd, 0x48, 0x0d, 0x18,
+			0x17, 0xc6, 0xc0, 0x88,
+			0xc1, 0x9b, 0x15, 0xe8,
+			0x0b, 0x18, 0x12, 0xc6,
+			0xc0, 0x88, 0xc1, 0x99,
+			0x10, 0xe8, 0x0c, 0xc0,
+			0x1c, 0x00, 0x00, 0x73,
+			0x0e, 0x18, 0x0a, 0xc6,
+			0xc0, 0x88, 0xc1, 0x9b,
+			0x08, 0xe8, 0x02, 0xc6,
+			0x00, 0xbe, 0x10, 0x12,
+			0xf0, 0x00, 0x90, 0xc7,
+			0x1f, 0xfe, 0x8f, 0xcb,
+			0x02, 0xc6, 0x00, 0xbe,
+			0x66, 0x3f, 0x11, 0x21,
+			0x2b, 0x25, 0x13, 0xc4,
+			0xa2, 0x41, 0x80, 0x63,
+			0xf5, 0xc0, 0x48, 0x00,
+			0xbb, 0x21, 0xb9, 0x25,
+			0x00, 0x71, 0x0c, 0xc2,
+			0x4a, 0x41, 0x8b, 0x41,
+			0x24, 0x18, 0xee, 0xc6,
+			0xc0, 0x88, 0xc1, 0x99,
+			0xec, 0xef, 0x02, 0xc6,
+			0x00, 0xbe, 0x8a, 0x12,
+			0xa0, 0xf9, 0x83, 0xff,
+			0xd4, 0x18, 0x20, 0x88,
+			0x36, 0xe8, 0x22, 0x60,
+			0x85, 0x48, 0x06, 0x48,
+			0x21, 0x88, 0xf4, 0x18,
+			0x20, 0x88, 0x32, 0xe8,
+			0x2d, 0xc3, 0xc0, 0x18,
+			0x20, 0x88, 0x2b, 0xe8,
+			0x22, 0x60, 0x60, 0x88,
+			0xc1, 0x18, 0x20, 0x88,
+			0x26, 0xe8, 0x22, 0x60,
+			0x61, 0x88, 0xc2, 0x18,
+			0x20, 0x88, 0x21, 0xe8,
+			0x22, 0x60, 0x62, 0x88,
+			0xc3, 0x18, 0x20, 0x88,
+			0x1c, 0xe8, 0x22, 0x60,
+			0x63, 0x88, 0xc4, 0x18,
+			0x20, 0x88, 0x17, 0xe8,
+			0x22, 0x60, 0x64, 0x88,
+			0xc5, 0x18, 0x20, 0x88,
+			0x12, 0xe8, 0x22, 0x60,
+			0x65, 0x88, 0xc6, 0x18,
+			0x20, 0x88, 0x0d, 0xe8,
+			0x22, 0x60, 0x66, 0x88,
+			0xc7, 0x18, 0x20, 0x88,
+			0x08, 0xe8, 0x22, 0x60,
+			0x67, 0x88, 0xd4, 0x18,
+			0x02, 0xc5, 0x00, 0xbd,
+			0xc2, 0x35, 0xc0, 0xd3,
+			0x02, 0xc5, 0x00, 0xbd,
+			0xb2, 0x3e, 0x02, 0xc5,
+			0x00, 0xbd, 0x08, 0x3f,
+			0xd4, 0x18, 0xc0, 0x88,
+			0xf8, 0xef, 0xc2, 0x60,
+			0x85, 0x48, 0x06, 0x48,
+			0xc1, 0x88, 0xf4, 0x18,
+			0xc0, 0x88, 0xf4, 0xef,
+			0xef, 0xc3, 0x60, 0x60,
+			0xc1, 0x88, 0xe0, 0x18,
+			0xc0, 0x88, 0xee, 0xef,
+			0x61, 0x60, 0xc1, 0x88,
+			0xe1, 0x18, 0xc0, 0x88,
+			0xe9, 0xef, 0x62, 0x60,
+			0xc1, 0x88, 0xe2, 0x18,
+			0xc0, 0x88, 0xe4, 0xef,
+			0x63, 0x60, 0xc1, 0x88,
+			0xe3, 0x18, 0xc0, 0x88,
+			0xdf, 0xef, 0x64, 0x60,
+			0xc1, 0x88, 0xe4, 0x18,
+			0xc0, 0x88, 0xda, 0xef,
+			0x65, 0x60, 0xc1, 0x88,
+			0xe5, 0x18, 0xc0, 0x88,
+			0xd5, 0xef, 0x66, 0x60,
+			0xc1, 0x88, 0xe6, 0x18,
+			0xc0, 0x88, 0xd0, 0xef,
+			0x67, 0x60, 0xc1, 0x88,
+			0xe7, 0x18, 0xc0, 0x88,
+			0xcb, 0xef, 0xd4, 0x18,
+			0x02, 0xc2, 0x00, 0xba,
+			0x3a, 0x15, 0x0b, 0xc6,
+			0xc7, 0x65, 0xd0, 0x49,
+			0x05, 0xf1, 0x08, 0xc0,
+			0x02, 0xc6, 0x00, 0xbe,
+			0x50, 0x2f, 0x02, 0xc7,
+			0x00, 0xbf, 0x56, 0x2f,
+			0x20, 0xd4, 0x00, 0xd4,
+			0x08, 0xc3, 0x60, 0x60,
+			0x03, 0x48, 0x60, 0x88,
+			0x00, 0x1b, 0x02, 0xc6,
+			0x00, 0xbe, 0xda, 0x2c,
+			0x60, 0xb4, 0x17, 0xc1,
+			0x17, 0xc2, 0x4c, 0x99,
+			0x00, 0x19, 0x4e, 0x89,
+			0x4f, 0x61, 0x97, 0x49,
+			0xfe, 0xf1, 0x48, 0x61,
+			0x01, 0xb4, 0x16, 0x48,
+			0x17, 0x48, 0x48, 0x89,
+			0x0a, 0xc1, 0x4c, 0x99,
+			0x81, 0x19, 0x4e, 0x89,
+			0x4f, 0x61, 0x97, 0x49,
+			0xfe, 0xf1, 0x02, 0xc0,
+			0x00, 0xb8, 0x32, 0x7c,
+			0x1c, 0xe8, 0x00, 0xdc,
+			0x01, 0xb0, 0xfe, 0xc2,
+			0x48, 0x89, 0xfb, 0xc1,
+			0x4c, 0x99, 0x81, 0x19,
+			0x4e, 0x89, 0x4f, 0x61,
+			0x97, 0x49, 0xfe, 0xf1,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x96, 0x7c, 0x02, 0xc0,
+			0x00, 0xb8, 0x00, 0x00,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x00, 0x00, 0x02, 0xc0,
+			0x00, 0xb8, 0x00, 0x00,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x00, 0x00, 0x02, 0xc0,
+			0x00, 0xb8, 0x00, 0x00,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x00, 0x00, 0x02, 0xc0,
+			0x00, 0xb8, 0x00, 0x00,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x00, 0x00, 0x00, 0x00};
+		static u8 pla_patch4_a[] = {
+			0x08, 0xe0, 0x0c, 0xe0,
+			0x10, 0xe0, 0x3e, 0xe0,
+			0x40, 0xe0, 0x42, 0xe0,
+			0x44, 0xe0, 0x46, 0xe0,
+			0x03, 0xb4, 0x02, 0xb4,
+			0x02, 0xc7, 0x00, 0xbf,
+			0xb4, 0x03, 0x02, 0xb0,
+			0x03, 0xb0, 0x02, 0xc6,
+			0x00, 0xbe, 0x8c, 0x05,
+			0xaf, 0x49, 0x17, 0xf1,
+			0x20, 0xc6, 0x00, 0x1a,
+			0x23, 0xe8, 0x21, 0xc6,
+			0xc0, 0x61, 0x91, 0x49,
+			0x0c, 0xf0, 0x95, 0x49,
+			0x0a, 0xf1, 0x14, 0x48,
+			0x16, 0xc6, 0x81, 0x1a,
+			0x19, 0xe8, 0x14, 0xc6,
+			0xc0, 0x62, 0x24, 0x48,
+			0xc0, 0x8a, 0x0c, 0xe0,
+			0x10, 0xc6, 0xc0, 0x62,
+			0xa5, 0x49, 0x08, 0xf1,
+			0x0d, 0xc6, 0xc0, 0x62,
+			0xa0, 0x48, 0xc0, 0x8a,
+			0xc2, 0x62, 0xa3, 0x48,
+			0xc2, 0x8a, 0x02, 0xc6,
+			0x00, 0xbe, 0xd2, 0x16,
+			0x84, 0xd2, 0x6a, 0xdc,
+			0x90, 0xd3, 0x66, 0xb4,
+			0x08, 0xea, 0xff, 0xc0,
+			0x04, 0x9e, 0x00, 0x99,
+			0x06, 0x8a, 0x06, 0x72,
+			0xaf, 0x49, 0xfe, 0xf1,
+			0x80, 0xff, 0x02, 0xc6,
+			0x00, 0xbe, 0x00, 0x00,
+			0x02, 0xc6, 0x00, 0xbe,
+			0x00, 0x00, 0x02, 0xc6,
+			0x00, 0xbe, 0x00, 0x00,
+			0x02, 0xc6, 0x00, 0xbe,
+			0x00, 0x00, 0x02, 0xc6,
+			0x00, 0xbe, 0x00, 0x00};
+		u8 new_ver;
+
+		rtl_fw_ver_erase(tp);
+
+		new_ver = 2;
+		if (rtl_check_fw_ver_ok(tp, USB_FW_USB_VER, new_ver)) {
+			rtl_clear_bp(tp, MCU_TYPE_USB);
+
+			generic_ocp_write(tp, 0xe600, 0xff,
+					  sizeof(usb_patch4_a), usb_patch4_a,
+					  MCU_TYPE_USB);
+
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_BA, 0xc000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_0, 0x11e2);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_1, 0x1268);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_2, 0x35c0);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_3, 0x1538);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_4, 0x2f4e);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_5, 0x2cd8);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_6, 0x7c26);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_7, 0x7c90);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_8, 0x0000);
+//			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_9, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_10, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_11, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_12, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_13, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_14, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_15, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP2_EN, 0x00df);
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USB_VER,
+				       new_ver);
+		}
+
+		new_ver = 2;
+		if (rtl_check_fw_ver_ok(tp, USB_FW_PLA_VER, new_ver)) {
+			rtl_clear_bp(tp, MCU_TYPE_PLA);
+
+			generic_ocp_write(tp, 0xf800, 0xff,
+					  sizeof(pla_patch4_a), pla_patch4_a,
+					  MCU_TYPE_PLA);
+
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_BA, 0x8000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_0, 0x03b2);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_1, 0x058a);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_2, 0x16c0);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_3, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_4, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_5, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_6, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_7, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_EN, 0x0007);
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_PLA_VER,
+				       new_ver);
+		}
+	} else if (tp->version == RTL_VER_13 || tp->version == RTL_VER_15) {
+		static u8 usb_patch_13[] = {
+			0x10, 0xe0, 0x25, 0xe0,
+			0x29, 0xe0, 0x2d, 0xe0,
+			0x52, 0xe0, 0xff, 0xe0,
+			0x02, 0xe1, 0x06, 0xe1,
+			0x16, 0xe1, 0x18, 0xe1,
+			0x48, 0xe1, 0x72, 0xe1,
+			0x80, 0xe1, 0x8f, 0xe1,
+			0x96, 0xe1, 0x98, 0xe1,
+			0x13, 0xc3, 0x60, 0x70,
+			0x8b, 0x49, 0x0d, 0xf1,
+			0x10, 0xc3, 0x60, 0x60,
+			0x85, 0x49, 0x09, 0xf1,
+			0x40, 0x03, 0x64, 0x60,
+			0x82, 0x49, 0x05, 0xf1,
+			0x09, 0xc3, 0x60, 0x60,
+			0x80, 0x48, 0x60, 0x88,
+			0x02, 0xc0, 0x00, 0xb8,
+			0xde, 0x0f, 0xca, 0xcf,
+			0x00, 0xd8, 0x1e, 0xb4,
+			0x04, 0xc3, 0x02, 0xc0,
+			0x00, 0xb8, 0x62, 0x36,
+			0xce, 0xd3, 0x04, 0xc3,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x7a, 0x14, 0xce, 0xd3,
+			0x00, 0xb4, 0x01, 0xb4,
+			0x02, 0xb4, 0x03, 0xb4,
+			0x1f, 0xc1, 0x02, 0x1b,
+			0x2c, 0x8b, 0x0c, 0x62,
+			0xa7, 0x49, 0x0a, 0xf1,
+			0x00, 0x1b, 0x08, 0x72,
+			0x13, 0x40, 0x04, 0xf1,
+			0x0a, 0x72, 0x13, 0x40,
+			0x03, 0xf0, 0x01, 0x1b,
+			0x2c, 0x8b, 0x12, 0xc0,
+			0x01, 0x1a, 0x08, 0x8a,
+			0x0a, 0x8a, 0x0d, 0xc0,
+			0x12, 0x71, 0x19, 0x48,
+			0x1a, 0x48, 0x12, 0x99,
+			0x03, 0xb0, 0x02, 0xb0,
+			0x01, 0xb0, 0x00, 0xb0,
+			0x02, 0xc0, 0x00, 0xb8,
+			0xb0, 0x77, 0x20, 0xc3,
+			0x18, 0xb4, 0x80, 0xcb,
+			0x00, 0xb4, 0x01, 0xb4,
+			0x02, 0xb4, 0x03, 0xb4,
+			0x07, 0xb4, 0x23, 0xc0,
+			0x24, 0xc1, 0x08, 0x1a,
+			0x2a, 0x8a, 0x24, 0x01,
+			0x0d, 0x1a, 0x20, 0x9a,
+			0x24, 0x09, 0x00, 0x1a,
+			0x22, 0x9a, 0x04, 0x72,
+			0x06, 0x73, 0x18, 0xc7,
+			0xe4, 0x9a, 0xe6, 0x9b,
+			0x17, 0xc2, 0x17, 0xc3,
+			0xe0, 0x9a, 0xe2, 0x9b,
+			0x80, 0x1b, 0x32, 0x8b,
+			0x00, 0x1a, 0x24, 0x9f,
+			0x26, 0x9a, 0x01, 0x1a,
+			0x28, 0x8a, 0x0f, 0xe8,
+			0x07, 0xb0, 0x03, 0xb0,
+			0x02, 0xb0, 0x01, 0xb0,
+			0x00, 0xb0, 0x02, 0xc6,
+			0x00, 0xbe, 0xe6, 0x60,
+			0x00, 0xc3, 0x20, 0xc3,
+			0x80, 0xcb, 0x55, 0x53,
+			0x42, 0x53, 0x80, 0xcb,
+			0x03, 0xb4, 0x06, 0xb4,
+			0x07, 0xb4, 0xfc, 0xc7,
+			0x79, 0xc7, 0xe0, 0x73,
+			0xba, 0x49, 0x0d, 0xf0,
+			0xf7, 0xc6, 0x24, 0x06,
+			0xc0, 0x77, 0xfa, 0x25,
+			0x76, 0x23, 0x66, 0x27,
+			0x70, 0xc7, 0xe1, 0x9e,
+			0x00, 0x16, 0x10, 0xf0,
+			0x01, 0x03, 0x0e, 0xe0,
+			0xb9, 0x49, 0x10, 0xf0,
+			0xe9, 0xc6, 0x24, 0x06,
+			0xc0, 0x77, 0xf9, 0x25,
+			0x77, 0x23, 0x67, 0x27,
+			0x62, 0xc7, 0xe1, 0x9e,
+			0x00, 0x16, 0x02, 0xf0,
+			0x01, 0x03, 0x5e, 0xc7,
+			0xe0, 0x8b, 0x12, 0xe8,
+			0x0d, 0xe0, 0xda, 0xc6,
+			0x24, 0x06, 0xc0, 0x77,
+			0xf6, 0x25, 0x7a, 0x23,
+			0x6a, 0x27, 0x53, 0xc7,
+			0xe1, 0x9e, 0x00, 0x16,
+			0xf3, 0xf0, 0x01, 0x03,
+			0xf1, 0xe7, 0x07, 0xb0,
+			0x06, 0xb0, 0x03, 0xb0,
+			0x80, 0xff, 0x03, 0xb4,
+			0x06, 0xb4, 0x07, 0xb4,
+			0xc7, 0xc6, 0xc4, 0x77,
+			0x40, 0xc3, 0x7c, 0x9f,
+			0x41, 0xc6, 0xc0, 0x73,
+			0xba, 0x49, 0x05, 0xf1,
+			0x00, 0x13, 0x05, 0xf1,
+			0x39, 0xc3, 0x04, 0xe0,
+			0x38, 0xc3, 0x02, 0xe0,
+			0x40, 0x1b, 0xb8, 0xc6,
+			0xfb, 0x31, 0xc4, 0x9f,
+			0x35, 0xc6, 0xc0, 0x67,
+			0x01, 0x17, 0x07, 0xfc,
+			0x30, 0xc6, 0xc1, 0x77,
+			0x01, 0x1b, 0xc0, 0x8b,
+			0x00, 0x17, 0x0c, 0xf1,
+			0x29, 0xc6, 0xc0, 0x73,
+			0xba, 0x49, 0x05, 0xf1,
+			0xb9, 0x49, 0x05, 0xf0,
+			0x21, 0xc7, 0x04, 0xe0,
+			0x20, 0xc7, 0x02, 0xe0,
+			0x40, 0x1f, 0x1a, 0xc6,
+			0x7e, 0x41, 0x1d, 0xc6,
+			0xc0, 0x63, 0xbb, 0x21,
+			0xbb, 0x41, 0x15, 0xc3,
+			0x66, 0x9f, 0x18, 0xc6,
+			0xc0, 0x67, 0xf9, 0x3b,
+			0xc0, 0x8f, 0x01, 0x17,
+			0x03, 0xfd, 0x00, 0x1f,
+			0x02, 0xe0, 0x01, 0x1f,
+			0x0e, 0xc6, 0xc0, 0x8f,
+			0x08, 0xc3, 0x04, 0x1e,
+			0x60, 0x8e, 0x07, 0xb0,
+			0x06, 0xb0, 0x03, 0xb0,
+			0x80, 0xff, 0xff, 0x07,
+			0x40, 0xd4, 0x00, 0x02,
+			0x00, 0x04, 0x80, 0xb9,
+			0xfd, 0xcb, 0xa2, 0xcb,
+			0xe8, 0x74, 0x02, 0xc5,
+			0x00, 0xbd, 0x96, 0x6d,
+			0x04, 0xc4, 0x02, 0xc3,
+			0x00, 0xbb, 0x50, 0x28,
+			0x7f, 0x00, 0x00, 0x1e,
+			0x00, 0x11, 0x0c, 0xf0,
+			0x90, 0x49, 0x04, 0xf1,
+			0x01, 0x06, 0x91, 0x24,
+			0xfa, 0xe7, 0x28, 0x32,
+			0x06, 0x43, 0xf8, 0x31,
+			0x01, 0x06, 0x91, 0x24,
+			0xf4, 0xe7, 0x02, 0xc0,
+			0x00, 0xb8, 0x0e, 0x28,
+			0x02, 0xc7, 0x00, 0xbf,
+			0x48, 0x31, 0x57, 0xc6,
+			0xc0, 0x71, 0x9f, 0x49,
+			0x08, 0xf0, 0x52, 0xc6,
+			0x00, 0x19, 0x98, 0x20,
+			0xc0, 0x99, 0xc2, 0x99,
+			0xc4, 0x99, 0xc6, 0x99,
+			0x20, 0xc6, 0xc0, 0x61,
+			0x04, 0x11, 0x05, 0xf0,
+			0x1e, 0xc6, 0x02, 0x19,
+			0xc0, 0x89, 0x15, 0xe0,
+			0x19, 0xc6, 0xc0, 0x61,
+			0x9c, 0x20, 0x9c, 0x24,
+			0x09, 0x11, 0xf7, 0xf1,
+			0x14, 0xc6, 0x01, 0x19,
+			0xc0, 0x89, 0x13, 0xc1,
+			0x13, 0xc6, 0x24, 0x9e,
+			0x00, 0x1e, 0x26, 0x8e,
+			0x26, 0x76, 0xef, 0x49,
+			0xfe, 0xf1, 0x22, 0x76,
+			0x08, 0xc1, 0x22, 0x9e,
+			0x07, 0xc6, 0x02, 0xc1,
+			0x00, 0xb9, 0xae, 0x09,
+			0x18, 0xb4, 0x4a, 0xb4,
+			0xe0, 0xcc, 0x80, 0xd4,
+			0x08, 0xdc, 0x10, 0xe8,
+			0xfc, 0xc6, 0xc0, 0x67,
+			0xf0, 0x49, 0x1e, 0xf0,
+			0xf0, 0x48, 0xc0, 0x8f,
+			0xc2, 0x77, 0xf7, 0xc1,
+			0xf7, 0xc6, 0x24, 0x9e,
+			0x22, 0x9f, 0x8c, 0x1e,
+			0x26, 0x8e, 0x26, 0x76,
+			0xef, 0x49, 0xfe, 0xf1,
+			0xfb, 0x49, 0x10, 0xf0,
+			0x12, 0xc6, 0xc0, 0x61,
+			0x10, 0x48, 0xc0, 0x89,
+			0x11, 0xc6, 0x11, 0xc1,
+			0xc0, 0x99, 0x10, 0xc6,
+			0xc0, 0x71, 0x18, 0x48,
+			0xc0, 0x99, 0x0d, 0xc6,
+			0xc0, 0x71, 0x11, 0x48,
+			0xc0, 0x99, 0x02, 0xc6,
+			0x00, 0xbe, 0x06, 0x5f,
+			0x6c, 0xb4, 0xf8, 0xc6,
+			0xca, 0xd3, 0x40, 0xd3,
+			0x4b, 0x80, 0x34, 0xd3,
+			0xe8, 0xd4, 0xfb, 0xc2,
+			0x40, 0x71, 0x9f, 0x49,
+			0x08, 0xf0, 0xf6, 0xc2,
+			0x00, 0x19, 0x98, 0x20,
+			0x40, 0x99, 0x42, 0x99,
+			0x44, 0x99, 0x46, 0x99,
+			0x13, 0xc2, 0x02, 0xc1,
+			0x00, 0xb9, 0x04, 0x5a,
+			0xec, 0xc1, 0x20, 0x72,
+			0xaf, 0x49, 0x08, 0xf0,
+			0xe7, 0xc1, 0x00, 0x1a,
+			0x28, 0x21, 0x20, 0x9a,
+			0x22, 0x9a, 0x24, 0x9a,
+			0x26, 0x9a, 0x04, 0xc1,
+			0x02, 0xc2, 0x00, 0xba,
+			0xc2, 0x5b, 0xca, 0xcf,
+			0x40, 0x71, 0x90, 0x48,
+			0x91, 0x48, 0x92, 0x48,
+			0x40, 0x99, 0x02, 0xc0,
+			0x00, 0xb8, 0x8e, 0x20,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x00, 0x00, 0x02, 0xc0,
+			0x00, 0xb8, 0x00, 0x00};
+		static u8 pla_patch_13[] = {
+			0x10, 0xe0, 0x1c, 0xe0,
+			0x20, 0xe0, 0x3a, 0xe0,
+			0xd0, 0xe0, 0xdc, 0xe0,
+			0x58, 0xe1, 0x09, 0xe0,
+			0x08, 0xe0, 0x07, 0xe0,
+			0x06, 0xe0, 0x05, 0xe0,
+			0x04, 0xe0, 0x03, 0xe0,
+			0x02, 0xe0, 0x01, 0xe0,
+			0x0c, 0xc4, 0x04, 0x40,
+			0x05, 0xf0, 0x8c, 0x26,
+			0x0b, 0x15, 0x02, 0xf0,
+			0x03, 0xe0, 0x00, 0x9a,
+			0x01, 0xe0, 0x02, 0xc4,
+			0x00, 0xbc, 0x36, 0x37,
+			0x6c, 0xe8, 0x3a, 0x73,
+			0xbb, 0x49, 0x02, 0xc6,
+			0x00, 0xbe, 0xde, 0x27,
+			0x3a, 0x73, 0xb5, 0x21,
+			0xbc, 0x25, 0x04, 0x13,
+			0x11, 0xf1, 0x12, 0x1b,
+			0x2a, 0x1d, 0x68, 0x31,
+			0xda, 0x3a, 0xab, 0x31,
+			0x00, 0x1a, 0xc0, 0x9a,
+			0x00, 0x13, 0xfb, 0xf1,
+			0x20, 0x76, 0x6e, 0x23,
+			0x6f, 0x27, 0x3c, 0x1a,
+			0xa1, 0x22, 0xb5, 0x41,
+			0xe2, 0x9e, 0xe4, 0x76,
+			0x6f, 0x48, 0xe4, 0x9e,
+			0x02, 0xc6, 0x00, 0xbe,
+			0x62, 0x2a, 0x87, 0x49,
+			0x62, 0xf0, 0x03, 0x1b,
+			0x58, 0x41, 0x33, 0xf0,
+			0x20, 0x73, 0x0b, 0xc5,
+			0xa4, 0x74, 0xc0, 0x49,
+			0x1b, 0xf1, 0x08, 0xc4,
+			0x14, 0x40, 0x07, 0xf1,
+			0x01, 0x1c, 0xa6, 0x9c,
+			0xa0, 0x9b, 0x27, 0xe0,
+			0xb8, 0xd3, 0x6c, 0xe8,
+			0x2c, 0x26, 0x0b, 0x14,
+			0x0f, 0xf1, 0x70, 0xc4,
+			0xa6, 0x73, 0xb0, 0x49,
+			0x08, 0xf0, 0xb0, 0x48,
+			0xa6, 0x9b, 0xa0, 0x73,
+			0x80, 0x9b, 0x20, 0x73,
+			0x40, 0x83, 0x17, 0xe0,
+			0x20, 0x73, 0x40, 0x83,
+			0x14, 0xe0, 0x70, 0xc4,
+			0x22, 0x40, 0x0a, 0xf1,
+			0x38, 0x22, 0x48, 0x26,
+			0xe8, 0x14, 0x06, 0xfb,
+			0x6b, 0xc4, 0x80, 0x74,
+			0xca, 0x49, 0x02, 0xf1,
+			0xbe, 0x48, 0x40, 0x83,
+			0x56, 0xc4, 0x22, 0x40,
+			0x57, 0xf0, 0x54, 0xc4,
+			0x22, 0x40, 0x57, 0xf0,
+			0x0c, 0x1b, 0x58, 0x41,
+			0x57, 0xf0, 0x02, 0x24,
+			0x03, 0x1b, 0x58, 0x41,
+			0x53, 0xf0, 0x47, 0xc5,
+			0xa4, 0x74, 0xc0, 0x49,
+			0x0e, 0xf1, 0x2c, 0x26,
+			0x0b, 0x14, 0x0b, 0xf1,
+			0x41, 0xc4, 0x80, 0x73,
+			0xa2, 0x9b, 0xa0, 0x73,
+			0x80, 0x9b, 0x22, 0x73,
+			0x42, 0x83, 0xa2, 0x73,
+			0x80, 0x9b, 0x42, 0xe0,
+			0x22, 0x73, 0x45, 0xc4,
+			0x22, 0x40, 0x0a, 0xf1,
+			0x39, 0x22, 0x4e, 0x26,
+			0x03, 0x14, 0x06, 0xf1,
+			0x3f, 0xc4, 0x80, 0x74,
+			0xca, 0x49, 0x02, 0xf1,
+			0xbe, 0x48, 0x42, 0x83,
+			0x2a, 0xc4, 0x22, 0x40,
+			0x31, 0xf1, 0x29, 0xc4,
+			0x82, 0x83, 0x2e, 0xe0,
+			0x22, 0xc5, 0xa4, 0x74,
+			0xc0, 0x49, 0x12, 0xf1,
+			0x2c, 0x26, 0x0b, 0x14,
+			0x0f, 0xf1, 0x1b, 0xc5,
+			0x1b, 0xc4, 0xa6, 0x73,
+			0xb0, 0x49, 0x05, 0xf0,
+			0xb0, 0x48, 0xa6, 0x9b,
+			0xa0, 0x73, 0x80, 0x9b,
+			0x40, 0x73, 0x20, 0x9b,
+			0x42, 0x73, 0x22, 0x9b,
+			0x19, 0xe0, 0x86, 0x49,
+			0x03, 0xf0, 0x84, 0x49,
+			0x03, 0xf0, 0x40, 0x73,
+			0x20, 0x9b, 0x86, 0x49,
+			0x03, 0xf0, 0x85, 0x49,
+			0x0f, 0xf0, 0x42, 0x73,
+			0x22, 0x9b, 0x0c, 0xe0,
+			0xb8, 0xd3, 0x6c, 0xe8,
+			0x00, 0xc0, 0x04, 0xc0,
+			0x82, 0xcc, 0xff, 0xc4,
+			0x80, 0x83, 0xab, 0xe7,
+			0xfc, 0xc4, 0x84, 0x83,
+			0xa8, 0xe7, 0x02, 0xc5,
+			0x00, 0xbd, 0x66, 0x0a,
+			0x00, 0xea, 0x04, 0xdd,
+			0x02, 0xdd, 0x5a, 0xe8,
+			0x04, 0xe8, 0x02, 0xc1,
+			0x00, 0xb9, 0xac, 0x35,
+			0x08, 0xc1, 0x20, 0x70,
+			0x87, 0x48, 0x20, 0x98,
+			0x36, 0x70, 0x80, 0x48,
+			0x36, 0x98, 0x80, 0xff,
+			0xd4, 0xb5, 0x04, 0x10,
+			0x07, 0xf1, 0x64, 0xc1,
+			0x32, 0x70, 0x89, 0x48,
+			0x32, 0x98, 0xf1, 0xef,
+			0x18, 0xe0, 0x05, 0x10,
+			0x07, 0xf1, 0x5c, 0xc1,
+			0x32, 0x70, 0x89, 0x48,
+			0x32, 0x98, 0x5f, 0xe8,
+			0x10, 0xe0, 0x06, 0x10,
+			0x07, 0xf1, 0x54, 0xc1,
+			0x32, 0x70, 0x09, 0x48,
+			0x32, 0x98, 0x57, 0xe8,
+			0x08, 0xe0, 0x07, 0x10,
+			0x0d, 0xf1, 0x4c, 0xc1,
+			0x32, 0x70, 0x09, 0x48,
+			0x32, 0x98, 0x57, 0xe8,
+			0x47, 0xc1, 0x28, 0x70,
+			0x05, 0x48, 0x06, 0x48,
+			0x07, 0x48, 0x08, 0x48,
+			0x28, 0x98, 0xa4, 0x49,
+			0x07, 0xf0, 0x40, 0xc1,
+			0x20, 0x70, 0x00, 0x48,
+			0x01, 0x48, 0x20, 0x98,
+			0x05, 0xe0, 0x3a, 0xc1,
+			0x20, 0x70, 0x81, 0x48,
+			0x20, 0x98, 0xa5, 0x49,
+			0x07, 0xf0, 0x34, 0xc1,
+			0x40, 0x01, 0x20, 0x60,
+			0x01, 0x48, 0x20, 0x88,
+			0x06, 0xe0, 0x2e, 0xc1,
+			0x40, 0x01, 0x20, 0x60,
+			0x81, 0x48, 0x20, 0x88,
+			0xa6, 0x49, 0x06, 0xf0,
+			0x26, 0xc1, 0x30, 0x70,
+			0x02, 0x48, 0x30, 0x98,
+			0x05, 0xe0, 0x21, 0xc1,
+			0x30, 0x70, 0x82, 0x48,
+			0x30, 0x98, 0xa7, 0x49,
+			0x07, 0xf0, 0x1a, 0xc1,
+			0x28, 0x70, 0x0a, 0x48,
+			0x0b, 0x48, 0x28, 0x98,
+			0x06, 0xe0, 0x14, 0xc1,
+			0x28, 0x70, 0x8a, 0x48,
+			0x8b, 0x48, 0x28, 0x98,
+			0x12, 0xc1, 0x12, 0xc2,
+			0x24, 0x9a, 0x0c, 0xc1,
+			0x10, 0xc2, 0x20, 0x9a,
+			0x0c, 0xc1, 0x24, 0x9b,
+			0x0d, 0xc2, 0x40, 0x73,
+			0x3f, 0x48, 0x40, 0x9b,
+			0x02, 0xc1, 0x00, 0xb9,
+			0xc6, 0x36, 0x00, 0xb4,
+			0x20, 0xb4, 0x40, 0xe0,
+			0x68, 0xe8, 0x00, 0xa0,
+			0x00, 0x12, 0x58, 0xe8,
+			0x92, 0xc1, 0x20, 0x70,
+			0x87, 0x48, 0x20, 0x98,
+			0x36, 0x70, 0x00, 0x48,
+			0x36, 0x98, 0x80, 0xff,
+			0x8a, 0xc1, 0x20, 0x70,
+			0x07, 0x48, 0x20, 0x98,
+			0x36, 0x70, 0x00, 0x48,
+			0x36, 0x98, 0x80, 0xff,
+			0xa9, 0xe7, 0x02, 0xc1,
+			0x00, 0xb9, 0xc6, 0x36};
+		u8 new_ver;
+
+		rtl_fw_ver_erase(tp);
+
+		new_ver = 6;
+		if (rtl_check_fw_ver_ok(tp, USB_FW_USB_VER, new_ver)) {
+			rtl_clear_bp(tp, MCU_TYPE_USB);
+
+			generic_ocp_write(tp, 0xe600, 0xff,
+					  sizeof(usb_patch_13), usb_patch_13,
+					  MCU_TYPE_USB);
+
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_BA, 0xc000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_0, 0x0fba);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_1, 0x3660);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_2, 0x1478);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_3, 0x77ae);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_4, 0x60e0);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_5, 0x6d94);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_6, 0x284e);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_7, 0x27f6);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_8, 0x3140);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_9, 0x09ac);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_10, 0x5e2a);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_11, 0x5a02);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_12, 0x5bc0);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_13, 0x208a);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_14, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_15, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP2_EN, 0x3fff);
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USB_VER,
+				       new_ver);
+		}
+
+		new_ver = 8;
+		if (rtl_check_fw_ver_ok(tp, USB_FW_PLA_VER, new_ver)) {
+			rtl_clear_bp(tp, MCU_TYPE_PLA);
+
+			generic_ocp_write(tp, 0xf800, 0xff,
+					  sizeof(pla_patch_13), pla_patch_13,
+					  MCU_TYPE_PLA);
+
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_BA, 0x8000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_0, 0x374e);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_1, 0x27dc);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_2, 0x2a5c);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_3, 0x09d0);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_4, 0x359e);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_5, 0x35b6);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_6, 0x35b4);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_7, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_EN, 0x007f);
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_PLA_VER,
+				       new_ver);
+		}
+	}
+
+	rtl_reset_ocp_base(tp);
+}
-- 
2.43.0

