Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40492C44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F195180CA2;
	Wed, 22 Jul 2026 07:57:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ga4lSnEZlsYa; Wed, 22 Jul 2026 07:57:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 049E180DCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784707075;
	bh=4nMP2UB+smrsSdA78oRGtJlAiBoHPanibv22wB9uKhg=;
	h=To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=u+IYfln0GMgy20k/W8Rh1WieLYY23y3+Kr7RLR9xeJyY0R+qFKbTkjdGErp3vLSsw
	 6l3jvhK934V54KjNCxKNtzZ6rNNbIFGjB4DMxRv7tc9Fn9xHuCLCoc1lZTfNZblPxD
	 3LiQSz3Hgxh0n1wZ8c6UgXlyLs6xwHdTT3UlWASUOjYcW7wsLfJovMMDWxAnsw4R+8
	 8BY5WPNWQxTja3QdpcyGU6jlbV3qlXk601ctY8UA/w9R9McW0NiEi/KdxBtMTiwsww
	 GvfQIFUF0J8HBywCHa97l+b94Sb2g48VTBQl+ihJdSkBaVH3Y6sfV73iVk+Y3MwZ/u
	 29Fl9kFM8mJ4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 049E180DCD;
	Wed, 22 Jul 2026 07:57:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB62142A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD35360739
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NGwqHT0n954s for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:57:52 +0000 (UTC)
X-Greylist: delayed 398 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 22 Jul 2026 07:57:52 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1967660652
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1967660652
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.75.126.72;
 helo=rtits2.realtek.com.tw; envelope-from=javen_xu@realsil.com.cn;
 receiver=<UNKNOWN> 
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1967660652
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:57:51 +0000 (UTC)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66M7p0Ya93807550,
 This message is accepted by code: ctloc85258
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66M7p0Ya93807550
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Jul 2026 15:51:00 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 15:50:59 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Jul 2026 15:50:59 +0800
To: <trini@konsulko.com>, <joe.hershberger@ni.com>, <rfried.dev@gmail.com>
CC: <u-boot@lists.u-boot-project.org>, <nd@arm.com>, Javen Xu
 <javen_xu@realsil.com.cn>
Subject: [PATCH next v1] net: rtl8169: add support for RTL8126A and RTL8127A
Date: Wed, 22 Jul 2026 15:50:57 +0800
Message-ID: <20260722075058.324-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=realsil.com.cn; s=dkim; t=1784706660;
 bh=4nMP2UB+smrsSdA78oRGtJlAiBoHPanibv22wB9uKhg=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=Cuz6gZVASjam0QaH/aHC143hO1vWkm+r228lduQIAu9fMKDMFUIZfvfo5A45j+v2y
 U2c6RIJK+RNvSHz0Fp4DYh8agfYVnzaNC4gJtxz9M0iix4WsJ6ENnntlqqtJsalc4G
 Hdva33pVZRH1ewE66ajXRz2t25UXf6JF37b7sgRMcGIAoKd/Cok8Aue6Swe17Oc8q7
 0c6lx7zCOI+hint18uyLaHcfBd7q2bM1lk1XyO9xzTnTnYi0q6rCrMJVJ5THJayM38
 55zb6o9afSqj7XJVpQmZQJEzHcAiAPNRGR5iSPNaI2zHkydA4g8WNIEhdMAmPVCkBn
 vv96WFZIiChFA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=realsil.com.cn
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=realsil.com.cn header.i=@realsil.com.cn
 header.a=rsa-sha256 header.s=dkim header.b=Cuz6gZVA
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: javen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: javen <javen_xu@realsil.com.cn>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Javen Xu <javen_xu@realsil.com.cn>

RTL8126A and RTL8127A share most of the register layouts and quirks with
RTL8125 series, but require explicit desc type and CRC-drop setup during
init.

This patch adds PCI IDs and MAC versions. RTL8126A is 0x66 and RTL8127A
is 0x6e. And RTL8127A requires Tx Desc V3 format and an additional RADM
FIFO protection configuration according to vendor driver.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/rtl8169.c | 103 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 9 deletions(-)

diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index 5b093623619..a24cff97801 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -49,6 +49,7 @@
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <pci.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/printk.h>
 
@@ -152,8 +153,24 @@ enum RTL8125_registers {
 	IntrMask_8125 = 0x38,
 	IntrStatus_8125 = 0x3C,
 	TxPoll_8125 = 0x90,
+	RX_DESC_MODE = 0xd8,
+	MACOCP = 0xb0,
+	RADMFIFO_PROTECT = 0x0402,
+	TX_DESC_MODE = 0xeb58,
 };
 
+/* MAC OCP indirect access via the MACOCP register */
+#define RTL8125_OCP_WRITE	0x80000000
+#define RTL8125_OCP_ADDR_SHIFT	16
+#define RX_DESC_CRC_DROP	BIT(0)
+#define RX_DESC_TYPE		BIT(1)
+
+/* TX_DESC_MODE (MAC OCP 0xeb58): TX descriptor format select, bits [1:0] */
+#define TX_DESC_FMT_MASK	GENMASK(1, 0)
+#define TX_DESC_FMT_STD		BIT(0)
+#define TX_DESC_FMT_V3		BIT(1)
+#define RX_PAUSE_SLOT_ON	BIT(11)
+
 enum RTL8169_register_content {
 	/*InterruptStatusBits */
 	SYSErr = 0x8000,
@@ -271,6 +288,8 @@ static struct {
 	{"RTL-8168h/8111h",	0x54, 0xff7e1880,},
 	{"RTL-8125B",		0x64, 0xff7e1880,},
 	{"RTL-8125d",		0x6a, 0xff7e5880,},
+	{"RTL-8126A",		0x66, 0xff7e5880,},
+	{"RTL-8127A",		0x6e, 0xff7e5880,},
 };
 
 enum _DescStatusBit {
@@ -355,6 +374,8 @@ static const unsigned int rtl8169_rx_config =
 
 static struct pci_device_id supported[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8125) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8126) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8127) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8161) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8167) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8168) },
@@ -398,6 +419,33 @@ int mdio_read(int RegAddr)
 	return value;
 }
 
+/* RTL8125/8126/8127 share the same register layout and quirks */
+static bool rtl_is_8125(struct pci_child_plat *pplat)
+{
+	return pplat->device == 0x8125 || pplat->device == 0x8126 ||
+	       pplat->device == 0x8127;
+}
+
+static void rtl_mac_ocp_write(u16 reg_addr, u16 value)
+{
+	u32 data32;
+
+	data32 = (u32)(reg_addr / 2) << RTL8125_OCP_ADDR_SHIFT;
+	data32 += value;
+	data32 |= RTL8125_OCP_WRITE;
+	RTL_W32(MACOCP, data32);
+}
+
+static u16 rtl_mac_ocp_read(u16 reg_addr)
+{
+	u32 data32;
+
+	data32 = (u32)(reg_addr / 2) << RTL8125_OCP_ADDR_SHIFT;
+	RTL_W32(MACOCP, data32);
+
+	return (u16)RTL_R32(MACOCP);
+}
+
 static int rtl8169_init_board(unsigned long dev_iobase, const char *name)
 {
 	int i;
@@ -571,12 +619,15 @@ static int rtl_recv_common(struct udevice *dev, unsigned long dev_iobase,
 		return length;
 
 	} else {
-		u32 IntrStatus = IntrStatus_8169;
+		u32 sts;
 
-		if (pplat->device == 0x8125)
-			IntrStatus = IntrStatus_8125;
-		ushort sts = RTL_R8(IntrStatus);
-		RTL_W8(IntrStatus, sts & ~(TxErr | RxErr | SYSErr));
+		if (rtl_is_8125(pplat)) {
+			sts = RTL_R32(IntrStatus_8125);
+			RTL_W32(IntrStatus_8125, sts & ~(TxErr | RxErr | SYSErr));
+		} else {
+			sts = RTL_R16(IntrStatus_8169);
+			RTL_W16(IntrStatus_8169, sts & ~(TxErr | RxErr | SYSErr));
+		}
 		udelay(100);	/* wait */
 	}
 	tpc->cur_rx = cur_rx;
@@ -636,8 +687,8 @@ static int rtl_send_common(struct udevice *dev, unsigned long dev_iobase,
 				    ((len > ETH_ZLEN) ? len : ETH_ZLEN));
 	}
 	rtl_flush_tx_desc(&tpc->TxDescArray[entry]);
-	if (pplat->device == 0x8125)
-		RTL_W8(TxPoll_8125, 0x1);	/* set polling bit */
+	if (rtl_is_8125(pplat))
+		RTL_W32(TxPoll_8125, 0x1);	/* set polling bit */
 	else
 		RTL_W8(TxPoll_8169, 0x40);	/* set polling bit */
 
@@ -697,6 +748,8 @@ static void rtl8169_set_rx_mode(void)
 
 static void rtl8169_hw_start(struct udevice *dev)
 {
+	u8 version = rtl_chip_info[tpc->chipset].version;
+	u16 tx_desc_mode;
 	u32 i;
 
 #ifdef DEBUG_RTL8169
@@ -719,6 +772,36 @@ static void rtl8169_hw_start(struct udevice *dev)
 
 	RTL_W8(Cfg9346, Cfg9346_Unlock);
 
+	/*
+	 * RTL8125D/8126A/8127A require explicit descriptor-type and CRC-drop setup.
+	 * RTL8125B (0x64) is intentionally excluded to avoid regressing working hardware.
+	 */
+	switch (version) {
+	case 0x6a:
+	case 0x66:
+	case 0x6e:
+		/* Reg 0xD8: Disable CRC drop and force legacy 16-byte RX desc */
+		RTL_W8(RX_DESC_MODE, RTL_R8(RX_DESC_MODE) & ~(RX_DESC_CRC_DROP | RX_DESC_TYPE));
+
+		/* RxConfig 0x44: enable RX pause slot (RTL8125B and later) */
+		RTL_W32(RxConfig, RTL_R32(RxConfig) | RX_PAUSE_SLOT_ON);
+
+		/* MAC OCP 0xEB58: TX descriptor format setup */
+		tx_desc_mode = rtl_mac_ocp_read(TX_DESC_MODE) & ~TX_DESC_FMT_MASK;
+
+		if (version == 0x6e) {
+			/* RTL8127A specific: Tx desc V3 and RADM FIFO protection */
+			rtl_mac_ocp_write(TX_DESC_MODE, tx_desc_mode | TX_DESC_FMT_V3);
+			RTL_W16(RADMFIFO_PROTECT, 0x2001);
+		} else {
+			/* RTL8125D / RTL8126A specific: standard Tx desc */
+			rtl_mac_ocp_write(TX_DESC_MODE, tx_desc_mode | TX_DESC_FMT_STD);
+		}
+		break;
+	default:
+		break;
+	}
+
 	/* RTL-8169sb/8110sb or previous version */
 	if (tpc->chipset <= 5)
 		RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
@@ -860,8 +943,8 @@ static void rtl_halt_common(struct udevice *dev)
 	RTL_W8(ChipCmd, 0x00);
 
 	/* Disable interrupts by clearing the interrupt mask. */
-	if (pplat->device == 0x8125)
-		RTL_W16(IntrMask_8125, 0x0000);
+	if (rtl_is_8125(pplat))
+		RTL_W32(IntrMask_8125, 0x00000000);
 	else
 		RTL_W16(IntrMask_8169, 0x0000);
 
@@ -1052,6 +1135,8 @@ static int rtl8169_eth_probe(struct udevice *dev)
 
 	switch (pplat->device) {
 	case 0x8125:
+	case 0x8126:
+	case 0x8127:
 	case 0x8161:
 	case 0x8168:
 		region = 2;
-- 
2.43.0

