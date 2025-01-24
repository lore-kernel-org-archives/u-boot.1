Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA3AC0218C
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 03:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5DD80780;
	Fri, 24 Jan 2025 04:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Ag09yNs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A0E807B4; Fri, 24 Jan 2025 04:39:25 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0180E8076E
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 04:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c655b43cda0411efbd192953cf12861f-20250124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=thY4OWLTsuCSSZ82PrdpKr1T3mQL3+sGW9SPNYAzn4k=; 
 b=Ag09yNs8iXwIAToPqyiFmov0Bw5yw4YMwtAmewlkoQ4GhLwiM5953HGFasmhsH/ynmDUgiZfZ3PAb3CkboAt9PApZpUaWo3+uP1vn/TC4jEBKFyoPCAq0kWD6zWldSm8WulqIl4o3e0enHcOCzlmHreOgoZ0ravd8tUyqmtT3ck=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:ae59a80c-2d42-4c6f-b5ce-e49253ee9fa5, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:52849e3d-da39-4471-8a46-23da908abe46,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c655b43cda0411efbd192953cf12861f-20250124
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1144236747; Fri, 24 Jan 2025 11:39:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 24 Jan 2025 11:39:10 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 24 Jan 2025 11:39:09 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>
Subject: [PATCH] pinctrl: mediatek: update mt7981 pinctrl driver based on
 upstream kernel
Date: Fri, 24 Jan 2025 11:39:02 +0800
Message-ID: <20250124033902.187796-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

Update mt7981 pinctrl driver based on upstream kernel

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 51 ++++++++++++++++++++---
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index d1c8afd9252..6b9769067b0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -569,6 +569,11 @@ static const struct mtk_pin_desc mt7981_pins[] = {
 	MT7981_TYPE1_PIN(56, "WF_HB10"),
 };
 
+/* List all groups consisting of these pins dedicated to the enablement of
+ * certain hardware block and the corresponding mode for all of the pins.
+ * The hardware probably has multiple combinations of these pinouts.
+ */
+
 /* WA_AICE */
 static const int mt7981_wa_aice1_pins[] = { 0, 1, };
 static const int mt7981_wa_aice1_funcs[] = { 2, 2, };
@@ -632,6 +637,9 @@ static const int mt7981_wo0_jtag_1_funcs[] = { 5, 5, 5, 5, 5, };
 static const int mt7981_uart2_0_pins[] = { 4, 5, 6, 7, };
 static const int mt7981_uart2_0_funcs[] = { 3, 3, 3, 3, };
 
+static const int mt7981_uart2_0_tx_rx_pins[] = { 4, 5, };
+static const int mt7981_uart2_0_tx_rx_funcs[] = { 3, 3, };
+
 /* GBE_LED0 */
 static const int mt7981_gbe_led0_pins[] = { 8, };
 static const int mt7981_gbe_led0_funcs[] = { 3, };
@@ -718,6 +726,17 @@ static const int mt7981_drv_vbus_pins[] = { 14, };
 static const int mt7981_drv_vbus_funcs[] = { 1, };
 
 /* EMMC */
+static const int mt7981_emmc_reset_pins[] = { 15, };
+static const int mt7981_emmc_reset_funcs[] = { 2, };
+
+static const int mt7981_emmc_4_pins[] = { 16, 17, 18, 19, 24, 25, };
+static const int mt7981_emmc_4_funcs[] = { 2, 2, 2, 2, 2, 2, };
+
+static const int mt7981_emmc_8_pins[] = {
+	16, 17, 18, 19, 20, 21, 22, 23, 24, 25, };
+static const int mt7981_emmc_8_funcs[] = {
+	2, 2, 2, 2, 2, 2, 2, 2, 2, 2, };
+
 static const int mt7981_emmc_45_pins[] = {
 	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, };
 static const int mt7981_emmc_45_funcs[] = {
@@ -754,6 +773,12 @@ static const int mt7981_uart1_0_funcs[] = { 4, 4, 4, 4, };
 static const int mt7981_uart1_1_pins[] = { 26, 27, 28, 29, };
 static const int mt7981_uart1_1_funcs[] = { 2, 2, 2, 2, };
 
+static const int mt7981_uart1_2_pins[] = { 9, 10, };
+static const int mt7981_uart1_2_funcs[] = { 2, 2, };
+
+static const int mt7981_uart1_3_pins[] = { 26, 27, };
+static const int mt7981_uart1_3_funcs[] = { 2, 2, };
+
 /* UART2 */
 static const int mt7981_uart2_1_pins[] = { 22, 23, 24, 25, };
 static const int mt7981_uart2_1_funcs[] = { 3, 3, 3, 3, };
@@ -832,6 +857,8 @@ static const struct mtk_group_desc mt7981_groups[] = {
 	PINCTRL_PIN_GROUP("wo0_jtag_0", mt7981_wo0_jtag_0),
 	/* @GPIO(4,7) WM_JTAG(3) */
 	PINCTRL_PIN_GROUP("uart2_0", mt7981_uart2_0),
+	/* @GPIO(4,5) WM_JTAG(4) */
+	PINCTRL_PIN_GROUP("uart2_0_tx_rx", mt7981_uart2_0_tx_rx),
 	/* @GPIO(8) GBE_LED0(3) */
 	PINCTRL_PIN_GROUP("gbe_led0", mt7981_gbe_led0),
 	/* @GPIO(4,6) PTA_EXT(4) */
@@ -844,7 +871,7 @@ static const struct mtk_group_desc mt7981_groups[] = {
 	PINCTRL_PIN_GROUP("spi1_0", mt7981_spi1_0),
 	/* @GPIO(6,7) I2C(5) */
 	PINCTRL_PIN_GROUP("i2c0_0", mt7981_i2c0_0),
-	/* @GPIO(8): DFD_NTRST(6) */
+	/* @GPIO(0,1,4,5): DFD_NTRST(6) */
 	PINCTRL_PIN_GROUP("dfd_ntrst", mt7981_dfd_ntrst),
 	/* @GPIO(9,10): WM_AICE(2) */
 	PINCTRL_PIN_GROUP("wm_aice1", mt7981_wm_aice1),
@@ -870,6 +897,12 @@ static const struct mtk_group_desc mt7981_groups[] = {
 	PINCTRL_PIN_GROUP("udi", mt7981_udi),
 	/* @GPIO(14) DRV_VBUS(1) */
 	PINCTRL_PIN_GROUP("drv_vbus", mt7981_drv_vbus),
+	/* @GPIO(15): EMMC_RSTB(2) */
+	PINCTRL_PIN_GROUP("emmc_reset", mt7981_emmc_reset),
+	/* @GPIO(16,17,18,19,24,25): EMMC_DATx, EMMC_CLK, EMMC_CMD */
+	PINCTRL_PIN_GROUP("emmc_4", mt7981_emmc_4),
+	/* @GPIO(16,17,18,19,20,21,22,23,24,25): EMMC_DATx, EMMC_CLK, EMMC_CMD */
+	PINCTRL_PIN_GROUP("emmc_8", mt7981_emmc_8),
 	/* @GPIO(15,25): EMMC(2) */
 	PINCTRL_PIN_GROUP("emmc_45", mt7981_emmc_45),
 	/* @GPIO(16,21): SNFI(3) */
@@ -888,8 +921,12 @@ static const struct mtk_group_desc mt7981_groups[] = {
 	PINCTRL_PIN_GROUP("uart1_0", mt7981_uart1_0),
 	/* @GPIO(26,29): UART1(2) */
 	PINCTRL_PIN_GROUP("uart1_1", mt7981_uart1_1),
+	/* @GPIO(9,10): UART1(2) */
+	PINCTRL_PIN_GROUP("uart1_2", mt7981_uart1_2),
+	/* @GPIO(26,27): UART1(2) */
+	PINCTRL_PIN_GROUP("uart1_3", mt7981_uart1_3),
 	/* @GPIO(22,25): UART2(3) */
-	PINCTRL_PIN_GROUP("uart2_0", mt7981_uart2_1),
+	PINCTRL_PIN_GROUP("uart2_1", mt7981_uart2_1),
 	/* @GPIO(22,24) PTA_EXT(4) */
 	PINCTRL_PIN_GROUP("pta_ext_1", mt7981_pta_ext_1),
 	/* @GPIO(20,21): WM_UART(4) */
@@ -964,9 +1001,10 @@ static const struct mtk_io_type_desc mt7981_io_type_desc[] = {
  */
 static const char *const mt7981_wa_aice_groups[] = { "wa_aice1", "wa_aice2",
 	"wm_aice1_1", "wa_aice3", "wm_aice1_2", };
-static const char *const mt7981_uart_groups[] = { "wm_uart_0", "uart2_0",
-	"net_wo0_uart_txd_0", "net_wo0_uart_txd_1", "net_wo0_uart_txd_2",
-	"uart1_0", "uart1_1", "uart2_0", "wm_aurt_1", "wm_aurt_2", "uart0", };
+static const char *const mt7981_uart_groups[] = { "net_wo0_uart_txd_0",
+	"net_wo0_uart_txd_1", "net_wo0_uart_txd_2", "uart0", "uart1_0",
+	"uart1_1", "uart1_2", "uart1_3", "uart2_0", "uart2_0_tx_rx", "uart2_1",
+	"wm_uart_0", "wm_aurt_1", "wm_aurt_2", };
 static const char *const mt7981_dfd_groups[] = { "dfd", "dfd_ntrst", };
 static const char *const mt7981_wdt_groups[] = { "watchdog", "watchdog1", };
 static const char *const mt7981_pcie_groups[] = { "pcie_pereset", "pcie_clk",
@@ -986,7 +1024,8 @@ static const char *const mt7981_i2c_groups[] = { "i2c0_0", "i2c0_1",
 static const char *const mt7981_pcm_groups[] = { "pcm", };
 static const char *const mt7981_udi_groups[] = { "udi", };
 static const char *const mt7981_usb_groups[] = { "drv_vbus", };
-static const char *const mt7981_flash_groups[] = { "emmc_45", "snfi", };
+static const char *const mt7981_flash_groups[] = { "emmc_reset", "emmc_4",
+	"emmc_8", "emmc_45", "snfi", };
 static const char *const mt7981_ethernet_groups[] = { "smi_mdc_mdio",
 	"gbe_ext_mdc_mdio", "wf0_mode1", "wf0_mode3", "mt7531_int", };
 static const char *const mt7981_ant_groups[] = { "ant_sel", };
-- 
2.34.1

