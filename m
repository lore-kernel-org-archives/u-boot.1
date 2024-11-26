Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD9DD5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 04:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA2D389C10;
	Tue, 26 Nov 2024 05:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.b="VKSW/vPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED3E89C15; Tue, 26 Nov 2024 03:25:47 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12DA08942F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 03:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hau@realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AQ2PgmjE286962,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
 t=1732587942; bh=k4QitMyrXTHNbobPjY7N9/DLnu5ovbnFx9zfeMNXqVo=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=VKSW/vPfbWLf+tClqLoByN1sBM4uqK3Zqs14PP+QuSKhYmWKkiaahBPDz4+PWE7/W
 D9iRlNRh277YuBncd7JTP8u0Px76rFFHsOzJ59Ejd/wUl1rBx2vjMYduhwdSnTXKeK
 2YnfUaeAkZxTUVyAI/8QxD59cOJhqJnLZ1WKWJg6VPJweRkNm1mT45D7oYFVveG0TN
 ukZ69WpEJbiSYIspBZgRmAzYpldbbP1PQuHjluOnfRCSUAJYoaJiZzO+5J1PI4Vm4Q
 e2trmTSZH8VDyXer2pfikfaC0+d5mf6+oO+AmLTic8biuL0ZieyJcn7nuXpqAMbO+s
 HS1t4VPAv6kDw==
Received: from RSEXH36502.realsil.com.cn (ms1.realsil.com.cn[172.29.17.3])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AQ2PgmjE286962
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:25:42 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RSEXH36502.realsil.com.cn (172.29.17.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Nov 2024 10:25:42 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 26 Nov 2024 10:25:41 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 26 Nov 2024 10:25:41 +0800
From: ChunHao Lin <hau@realtek.com>
To: <u-boot@lists.denx.de>
CC: ChunHao Lin <hau@realtek.com>
Subject: [PATCH 3/5] usb: eth: r8152: Add support for rtl8153c
Date: Tue, 26 Nov 2024 10:25:13 +0800
Message-ID: <20241126022515.4043-4-hau@realtek.com>
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

This is used to support rtl8153c.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/usb/eth/r8152.c    |  66 +++++++++-
 drivers/usb/eth/r8152.h    |  13 +-
 drivers/usb/eth/r8152_fw.c | 263 +++++++++++++++++++++++++++++++++++++
 3 files changed, 335 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/eth/r8152.c b/drivers/usb/eth/r8152.c
index c767b78291..8ddfb402d8 100644
--- a/drivers/usb/eth/r8152.c
+++ b/drivers/usb/eth/r8152.c
@@ -40,6 +40,7 @@ static const struct r8152_version r8152_versions[] = {
 	{ 0x7030, RTL_VER_11, 1, 1},
 	{ 0x7400, RTL_VER_12, 1, 1},
 	{ 0x7410, RTL_VER_13, 1, 1},
+	{ 0x6400, RTL_VER_14, 1, 0},
 	{ 0x7420, RTL_VER_15, 1, 1},
 };
 
@@ -632,6 +633,7 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 
 	case RTL_VER_08:
 	case RTL_VER_09:
+	case RTL_VER_14:
 		/* The RTL8153B uses USB_RX_EXTRA_AGGR_TMR for rx timeout
 		 * primarily. For USB_RX_EARLY_TIMEOUT, we fix it to 1264ns.
 		 */
@@ -679,6 +681,7 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 	case RTL_VER_11:
 	case RTL_VER_12:
 	case RTL_VER_13:
+	case RTL_VER_14:
 	case RTL_VER_15:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
@@ -696,6 +699,18 @@ static int rtl8153_enable(struct r8152 *tp)
 	r8153_set_rx_early_timeout(tp);
 	r8153_set_rx_early_size(tp);
 
+	switch (tp->version) {
+	case RTL_VER_14:
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_TASK,
+				  FC_PATCH_TASK);
+		mdelay(2);
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK,
+				  FC_PATCH_TASK);
+		break;
+	default:
+		break;
+	}
+
 	return rtl_enable(tp);
 }
 
@@ -774,6 +789,7 @@ static void rtl_rx_vlan_en(struct r8152 *tp, bool enable)
 	case RTL_VER_07:
 	case RTL_VER_08:
 	case RTL_VER_09:
+	case RTL_VER_14:
 		if (enable)
 			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR,
 					  CPCR_RX_VLAN);
@@ -950,6 +966,7 @@ static void r8153_teredo_off(struct r8152 *tp)
 	case RTL_VER_11:
 	case RTL_VER_12:
 	case RTL_VER_13:
+	case RTL_VER_14:
 	case RTL_VER_15:
 	default:
 		/* The bit 0 ~ 7 are relative with teredo settings. They are
@@ -1277,7 +1294,10 @@ static void r8153b_hw_phy_cfg(struct r8152 *tp)
 	/* U1/U2/L1 idle timer. 500 us */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
-	r8153b_firmware(tp);
+	if (tp->version == RTL_VER_14)
+		r8153c_firmware(tp);
+	else
+		r8153b_firmware(tp);
 
 	data = sram_read(tp, SRAM_GREEN_CFG);
 	data |= R_TUNE_EN;
@@ -1846,11 +1866,21 @@ static void r8153_first_init(struct r8152 *tp)
 	rtl8152_nic_reset(tp);
 
 	/* rx share fifo credit full threshold */
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL0, RXFIFO_THR1_NORMAL);
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL1, RXFIFO_THR2_NORMAL);
-	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL2, RXFIFO_THR3_NORMAL);
-	/* TX share fifo free credit full threshold */
-	ocp_write_dword(tp, MCU_TYPE_PLA, PLA_TXFIFO_CTRL, TXFIFO_THR_NORMAL2);
+	if (tp->version == RTL_VER_14) {
+		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL0, 0x02);
+		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_RXFIFO_FULL, 0x08);
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL1, RXFIFO_THR2_NORMAL);
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL2, RXFIFO_THR3_NORMAL);
+		/* TX share fifo free credit full threshold */
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_CTRL, 512 / 64);
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_TXFIFO_FULL, 2048 / 8);
+	} else {
+		ocp_write_dword(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL0, RXFIFO_THR1_NORMAL);
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL1, RXFIFO_THR2_NORMAL);
+		ocp_write_word(tp, MCU_TYPE_PLA, PLA_RXFIFO_CTRL2, RXFIFO_THR3_NORMAL);
+		/* TX share fifo free credit full threshold */
+		ocp_write_dword(tp, MCU_TYPE_PLA, PLA_TXFIFO_CTRL, TXFIFO_THR_NORMAL2);
+	}
 
 	/* rx aggregation */
 	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
@@ -2140,6 +2170,15 @@ static void rtl8153b_down(struct r8152 *tp)
 	r8153_enter_oob(tp);
 }
 
+static void rtl8153c_up(struct r8152 *tp)
+{
+	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_CONFIG);
+	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG34, BIT(8));
+	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CRWECR, CRWECR_NORAML);
+
+	rtl8153b_up(tp);
+}
+
 static void rtl8156_up(struct r8152 *tp)
 {
 	r8156_exit_oob(tp);
@@ -2373,6 +2412,13 @@ static void r8153b_init(struct r8152 *tp)
 	r8152b_enable_fc(tp);
 }
 
+static void r8153c_init(struct r8152 *tp)
+{
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2, BIT(7));
+
+	r8153b_init(tp);
+}
+
 static void r8156_init(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -2562,6 +2608,14 @@ static int rtl_ops_init(struct r8152 *tp)
 		ops->down		= rtl8156_down;
 		break;
 
+	case RTL_VER_14:
+		ops->init		= r8153c_init;
+		ops->enable		= rtl8153_enable;
+		ops->disable		= rtl8153_disable;
+		ops->up			= rtl8153c_up;
+		ops->down		= rtl8153b_down;
+		break;
+
 	default:
 		ret = -ENODEV;
 		printf("r8152 Unknown Device\n");
diff --git a/drivers/usb/eth/r8152.h b/drivers/usb/eth/r8152.h
index 46ae698191..055ec5e385 100644
--- a/drivers/usb/eth/r8152.h
+++ b/drivers/usb/eth/r8152.h
@@ -79,6 +79,15 @@
 #define PLA_BP_6		0xfc34
 #define PLA_BP_7		0xfc36
 #define PLA_BP_EN		0xfc38
+#define PLA_BP_8		0xfc38		/* RTL8153C */
+#define PLA_BP_9		0xfc3a
+#define PLA_BP_10		0xfc3c
+#define PLA_BP_11		0xfc3e
+#define PLA_BP_12		0xfc40
+#define PLA_BP_13		0xfc42
+#define PLA_BP_14		0xfc44
+#define PLA_BP_15		0xfc46
+#define PLA_BP2_EN		0xfc48
 
 #define USB_USB2PHY		0xb41e
 #define USB_SSPHYLINK2		0xb428
@@ -95,6 +104,7 @@
 #define USB_FW_USB_VER		0xcfd7
 #define USB_LPM_CONFIG		0xcfd8
 #define USB_ECM_OPTION		0xcfee
+#define USB_MISC_2		0xcfff
 #define USB_ECM_OP		0xd26b
 #define USB_GPHY_CTRL		0xd284
 #define USB_SPEED_OPTION	0xd32a
@@ -744,7 +754,7 @@ enum rtl_version {
 	RTL_VER_11,
 	RTL_VER_12,
 	RTL_VER_13,
-	//RTL_VER_14,
+	RTL_VER_14,
 	RTL_VER_15,
 
 	RTL_VER_MAX
@@ -829,6 +839,7 @@ void rtl_reset_ocp_base(struct r8152 *tp);
 void r8152b_firmware(struct r8152 *tp);
 void r8153_firmware(struct r8152 *tp);
 void r8153b_firmware(struct r8152 *tp);
+void r8153c_firmware(struct r8152 *tp);
 void r8156_ram_code(struct r8152 *tp, bool power_cut);
 
 void r8156_patch_code(struct r8152 *tp);
diff --git a/drivers/usb/eth/r8152_fw.c b/drivers/usb/eth/r8152_fw.c
index 5f347ed3e0..2c1099b7da 100644
--- a/drivers/usb/eth/r8152_fw.c
+++ b/drivers/usb/eth/r8152_fw.c
@@ -880,6 +880,7 @@ static void rtl_clear_bp(struct r8152 *tp, u16 type)
 	case RTL_VER_07:
 		bp_num = 8;
 		break;
+	case RTL_VER_14:
 	default:
 		ocp_write_word(tp, type, USB_BP2_EN, 0);
 		bp_num = 16;
@@ -1316,6 +1317,268 @@ void r8153b_firmware(struct r8152 *tp)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_FIX_EN1, ocp_data);
 }
 
+void r8153c_firmware(struct r8152 *tp)
+{
+	if (tp->version == RTL_VER_14) {
+		static u8 usb_patch3_a[] = {
+			0x10, 0xe0, 0x79, 0xe0,
+			0x97, 0xe0, 0x99, 0xe0,
+			0xa0, 0xe0, 0xa2, 0xe0,
+			0xc3, 0xe0, 0xe9, 0xe0,
+			0xeb, 0xe0, 0xed, 0xe0,
+			0xef, 0xe0, 0xf1, 0xe0,
+			0xf3, 0xe0, 0xf5, 0xe0,
+			0xf7, 0xe0, 0xf9, 0xe0,
+			0x01, 0xb4, 0x03, 0xb4,
+			0x04, 0xb4, 0x05, 0xb4,
+			0x07, 0xb4, 0x64, 0xc6,
+			0xc0, 0x60, 0x82, 0x48,
+			0xc0, 0x88, 0x5f, 0xc7,
+			0x58, 0xc6, 0xe4, 0x9e,
+			0x0f, 0x1e, 0xe6, 0x8e,
+			0xe6, 0x76, 0xef, 0x49,
+			0xfe, 0xf1, 0xe2, 0x73,
+			0xe0, 0x74, 0xb8, 0x22,
+			0xd8, 0x26, 0xb8, 0x25,
+			0x48, 0x23, 0x68, 0x27,
+			0x48, 0x26, 0x04, 0xb4,
+			0x05, 0xb4, 0x06, 0xb4,
+			0x47, 0xc6, 0xe2, 0x23,
+			0xfe, 0x39, 0x00, 0x1c,
+			0x00, 0x1d, 0x00, 0x13,
+			0x0c, 0xf0, 0xb0, 0x49,
+			0x04, 0xf1, 0x01, 0x05,
+			0xb1, 0x25, 0xfa, 0xe7,
+			0xb8, 0x33, 0x35, 0x43,
+			0x26, 0x31, 0x01, 0x05,
+			0xb1, 0x25, 0xf4, 0xe7,
+			0x06, 0xb0, 0x05, 0xb0,
+			0xae, 0x41, 0x25, 0x31,
+			0x32, 0xc5, 0x6c, 0x41,
+			0x04, 0xb0, 0x05, 0xb4,
+			0x32, 0xc7, 0x2b, 0xc6,
+			0x04, 0x06, 0xe4, 0x9e,
+			0x0f, 0x1e, 0xe6, 0x8e,
+			0xe6, 0x76, 0xef, 0x49,
+			0xfe, 0xf1, 0xe0, 0x76,
+			0xe8, 0x25, 0xe8, 0x23,
+			0xf8, 0x27, 0x20, 0xc5,
+			0x6f, 0x41, 0xb3, 0x20,
+			0x4b, 0x30, 0x4c, 0x41,
+			0x4d, 0x30, 0x1b, 0xc6,
+			0x4e, 0x41, 0x91, 0x21,
+			0xd9, 0x30, 0x05, 0xb0,
+			0x52, 0x22, 0xa3, 0x31,
+			0x13, 0xc7, 0xb7, 0x31,
+			0x13, 0xc7, 0x77, 0x41,
+			0x12, 0xc3, 0xde, 0x30,
+			0x60, 0x65, 0x10, 0xc7,
+			0xe0, 0x8d, 0xe2, 0x9e,
+			0x07, 0xb0, 0x05, 0xb0,
+			0x04, 0xb0, 0x03, 0xb0,
+			0x01, 0xb0, 0x02, 0xc0,
+			0x00, 0xb8, 0xd6, 0x20,
+			0x00, 0xc0, 0x41, 0x00,
+			0xff, 0x00, 0x7f, 0x00,
+			0x00, 0xe6, 0x7a, 0xd3,
+			0x08, 0xdc, 0xe8, 0xd4,
+			0x04, 0xb4, 0x05, 0xb4,
+			0x06, 0xb4, 0x1b, 0xc0,
+			0x00, 0x75, 0xd8, 0x49,
+			0x0d, 0xf0, 0x14, 0xc0,
+			0x14, 0xc5, 0x00, 0x1e,
+			0x08, 0x9e, 0x0c, 0x9d,
+			0x11, 0xc6, 0x0a, 0x9e,
+			0x8f, 0x1c, 0x0e, 0x8c,
+			0x0e, 0x74, 0xcf, 0x49,
+			0xfe, 0xf1, 0x07, 0xc1,
+			0x06, 0xb0, 0x05, 0xb0,
+			0x04, 0xb0, 0x02, 0xc0,
+			0x00, 0xb8, 0xdc, 0x5c,
+			0xe0, 0xcb, 0x00, 0xdc,
+			0x24, 0xe4, 0x80, 0x02,
+			0x34, 0xd3, 0x02, 0xc2,
+			0x00, 0xba, 0x42, 0x08,
+			0x40, 0x60, 0x80, 0x48,
+			0x81, 0x48, 0x82, 0x48,
+			0x40, 0x88, 0x02, 0xc2,
+			0x00, 0xba, 0xf0, 0x1b,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x20, 0x24, 0x1c, 0xc6,
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
+			0x64, 0x09, 0x18, 0xb4,
+			0x4a, 0xb4, 0xe0, 0xcc,
+			0x80, 0xd4, 0x08, 0xdc,
+			0x10, 0xe8, 0xfc, 0xc6,
+			0xc0, 0x67, 0xf0, 0x49,
+			0x1d, 0xf0, 0xf0, 0x48,
+			0xc0, 0x8f, 0xc2, 0x77,
+			0xf7, 0xc1, 0xf7, 0xc6,
+			0x24, 0x9e, 0x22, 0x9f,
+			0x8c, 0x1e, 0x26, 0x8e,
+			0x26, 0x76, 0xef, 0x49,
+			0xfe, 0xf1, 0xfb, 0x49,
+			0x05, 0xf0, 0x11, 0xc6,
+			0xc0, 0x61, 0x10, 0x48,
+			0xc0, 0x89, 0x0e, 0xc6,
+			0xc0, 0x71, 0x18, 0x48,
+			0xc0, 0x99, 0x0b, 0xc1,
+			0xcc, 0x99, 0x0a, 0xc6,
+			0xc0, 0x61, 0x11, 0x48,
+			0xc0, 0x89, 0x02, 0xc6,
+			0x00, 0xbe, 0x46, 0x50,
+			0x6c, 0xb4, 0x34, 0xd3,
+			0x4b, 0x80, 0xe8, 0xd4,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x3a, 0x4e, 0x02, 0xc0,
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
+			0x00, 0x00, 0x00, 0x00 };
+		static u8 pla_patch3_a[] = {
+			0x10, 0xe0, 0x12, 0xe0,
+			0x15, 0xe0, 0x1a, 0xe0,
+			0x25, 0xe0, 0x31, 0xe0,
+			0x33, 0xe0, 0x35, 0xe0,
+			0x37, 0xe0, 0x39, 0xe0,
+			0x3b, 0xe0, 0x3d, 0xe0,
+			0x3f, 0xe0, 0x41, 0xe0,
+			0x43, 0xe0, 0x45, 0xe0,
+			0x02, 0xc6, 0x00, 0xbe,
+			0xec, 0x2c, 0x94, 0x49,
+			0x02, 0xc6, 0x00, 0xbe,
+			0xae, 0x2b, 0x05, 0xc0,
+			0x00, 0x72, 0x02, 0xc6,
+			0x00, 0xbe, 0xd6, 0x2b,
+			0x20, 0xe8, 0x08, 0xc3,
+			0x60, 0x65, 0xd0, 0x49,
+			0x06, 0xf1, 0xe0, 0x75,
+			0x02, 0xc3, 0x00, 0xbb,
+			0x3e, 0x08, 0xb4, 0xd3,
+			0x02, 0xc3, 0x00, 0xbb,
+			0x5e, 0x08, 0x6c, 0x74,
+			0xc4, 0x75, 0xe5, 0x41,
+			0xc2, 0x49, 0x05, 0xf0,
+			0x07, 0xc6, 0x01, 0x1c,
+			0xc0, 0x8c, 0xc1, 0x8c,
+			0x02, 0xc4, 0x00, 0xbc,
+			0x16, 0x02, 0x99, 0xd3,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x3a, 0x4e, 0x02, 0xc0,
+			0x00, 0xb8, 0x3a, 0x4e,
+			0x02, 0xc0, 0x00, 0xb8,
+			0x3a, 0x4e, 0x02, 0xc0,
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
+			0x00, 0x00, 0x00, 0x00 };
+		u8 new_ver;
+
+		rtl_fw_ver_erase(tp);
+
+		new_ver = 2;
+		if (rtl_check_fw_ver_ok(tp, USB_FW_PLA_VER, new_ver)) {
+			rtl_clear_bp(tp, MCU_TYPE_PLA);
+
+			generic_ocp_write(tp, 0xf800, 0xff,
+					  sizeof(pla_patch3_a), pla_patch3_a,
+					  MCU_TYPE_PLA);
+
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_BA, 0x8000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_0, 0x2be6);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_1, 0x2bac);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_2, 0x2bd4);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_3, 0x083c);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_4, 0x0214);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_5, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_6, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_7, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_8, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_9, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_10, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_11, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_12, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_13, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_14, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP_15, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_PLA, PLA_BP2_EN, 0x001f);
+
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_PLA_VER,
+				       new_ver);
+		}
+
+		new_ver = 5;
+		if (rtl_check_fw_ver_ok(tp, USB_FW_USB_VER, new_ver)) {
+			rtl_clear_bp(tp, MCU_TYPE_USB);
+
+			/* enable fc timer and set timer to 1 second. */
+			ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
+				       CTRL_TIMER_EN | (1000 / 8));
+
+			generic_ocp_write(tp, 0xe600, 0xff,
+					  sizeof(usb_patch3_a), usb_patch3_a,
+					  MCU_TYPE_USB);
+
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_BA, 0xa000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_0, 0x20ce);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_1, 0x5cda);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_2, 0x0834);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_3, 0x1bec);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_4, 0x241e);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_5, 0x0962);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_6, 0x4f54);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_7, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_8, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_9, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_10, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_11, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_12, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_13, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_14, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP_15, 0x0000);
+			ocp_write_word(tp, MCU_TYPE_USB, USB_BP2_EN, 0x007f);
+
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USB_VER,
+				       new_ver);
+		}
+
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
+				  FLOW_CTRL_PATCH_2);
+
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+	}
+
+	rtl_reset_ocp_base(tp);
+}
+
 static int rtl_ram_code_speed_up(struct r8152 *tp, bool wait)
 {
 	u16 fw_version, code_ver;
-- 
2.43.0

