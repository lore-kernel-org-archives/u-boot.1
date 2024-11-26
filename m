Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C620D5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 04:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DF389C21;
	Tue, 26 Nov 2024 05:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=realtek.com header.i=@realtek.com header.b="utQVzvIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445F2893F9; Tue, 26 Nov 2024 03:45:55 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3320D88E0F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 03:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=realtek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hau@realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AQ2jlZ53324515,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
 t=1732589148; bh=Rk2j7ktO85KbcDBpa6AD6RoO6C0IkbPcOxygBUAODe8=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 b=utQVzvIPcV3uCUUtfZ96x091QYJJlRtb84zkK2yzYNg6qvdi5+addJ+T2TL/HiJY/
 IW2b9a0g5Le+1ExTNWPOc9Z5WJ78PCXh77Ph7g92kT4tE5Nye2yzVPK+dmyaQY6Des
 cLU+/09GMt4IuQJ2Xu7qIUfNOCjKr9+05C6bT5zMS5p0fDK7yC35z8qtBNt47CmGgF
 qYg1iu1kf55LyyQyQLOepgQefiZKIc2a+TqUsznYWd1S/XbwdF8JgVfYo43wJnb/h3
 gZ4kYV+xYQm3/4QTR+Q3H88BCYXNVdkN+VT7oqooDnUFWcOHuywE/edNrwSi7YgRHD
 N9B3tDI5oG7Qw==
Received: from RSEXH36502.realsil.com.cn (rsn1.realsil.com.cn[172.29.17.3])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AQ2jlZ53324515
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:45:48 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RSEXH36502.realsil.com.cn (172.29.17.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Nov 2024 10:45:48 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Nov 2024 10:25:46 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 26 Nov 2024 10:25:46 +0800
From: ChunHao Lin <hau@realtek.com>
To: <u-boot@lists.denx.de>
CC: ChunHao Lin <hau@realtek.com>
Subject: [PATCH 4/5] usb: eth: r8152: Use variable to store descritpor size
Date: Tue, 26 Nov 2024 10:25:14 +0800
Message-ID: <20241126022515.4043-5-hau@realtek.com>
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

Use variable to store tx/rx descriptor size to prevent the call
to sizeof().

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/usb/eth/r8152.c | 20 ++++++++++++--------
 drivers/usb/eth/r8152.h |  3 +++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/eth/r8152.c b/drivers/usb/eth/r8152.c
index 8ddfb402d8..e12753b720 100644
--- a/drivers/usb/eth/r8152.c
+++ b/drivers/usb/eth/r8152.c
@@ -663,7 +663,7 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 static void r8153_set_rx_early_size(struct r8152 *tp)
 {
 	u32 ocp_data = (RTL8152_AGG_BUF_SZ - RTL8153_RMS -
-			sizeof(struct rx_desc));
+			tp->rx_desc_size);
 
 	switch (tp->version) {
 	case RTL_VER_03:
@@ -2217,6 +2217,10 @@ static void r8152b_get_version(struct r8152 *tp)
 		}
 	}
 
+	/* set descriptor size */
+	tp->rx_desc_size = sizeof(struct rx_desc);
+	tp->tx_desc_size = sizeof(struct tx_desc);
+
 	if (tp->version == RTL_VER_UNKNOWN)
 		debug("r8152 Unknown tcr version 0x%04x\n", tcr);
 }
@@ -2663,7 +2667,7 @@ static int r8152_send_common(struct ueth_data *ueth, void *packet, int length)
 	int err;
 	int actual_len;
 	ALLOC_CACHE_ALIGN_BUFFER(uint8_t, msg,
-				 PKTSIZE + sizeof(struct tx_desc));
+				 PKTSIZE + tp->tx_desc_size);
 	struct tx_desc *tx_desc = (struct tx_desc *)msg;
 
 	debug("** %s(), len %d\n", __func__, length);
@@ -2673,13 +2677,13 @@ static int r8152_send_common(struct ueth_data *ueth, void *packet, int length)
 	tx_desc->opts2 = cpu_to_le32(opts2);
 	tx_desc->opts1 = cpu_to_le32(opts1);
 
-	memcpy(msg + sizeof(struct tx_desc), (void *)packet, length);
+	memcpy(msg + tp->tx_desc_size, (void *)packet, length);
 
 	err = usb_bulk_msg(udev, usb_sndbulkpipe(udev, ueth->ep_out),
-			   (void *)msg, length + sizeof(struct tx_desc),
+			   (void *)msg, length + tp->tx_desc_size,
 			   &actual_len, USB_BULK_SEND_TIMEOUT);
 	debug("Tx: len = %zu, actual = %u, err = %d\n",
-	      length + sizeof(struct tx_desc), actual_len, err);
+	      length + tp->tx_desc_size, actual_len, err);
 
 	return err;
 }
@@ -2735,12 +2739,12 @@ int r8152_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	packet_len = le32_to_cpu(rx_desc->opts1) & RX_LEN_MASK;
 	packet_len -= CRC_SIZE;
 
-	if (packet_len > len - (sizeof(struct rx_desc) + CRC_SIZE)) {
+	if (packet_len > len - (tp->rx_desc_size + CRC_SIZE)) {
 		debug("Rx: too large packet: %d\n", packet_len);
 		goto err;
 	}
 
-	*packetp = ptr + sizeof(struct rx_desc);
+	*packetp = ptr + tp->rx_desc_size;
 	return packet_len;
 
 err:
@@ -2752,7 +2756,7 @@ static int r8152_free_pkt(struct udevice *dev, uchar *packet, int packet_len)
 {
 	struct r8152 *tp = dev_get_priv(dev);
 
-	packet_len += sizeof(struct rx_desc) + CRC_SIZE;
+	packet_len += tp->rx_desc_size + CRC_SIZE;
 	packet_len = ALIGN(packet_len, 8);
 	usb_ether_advance_rxbuf(&tp->ueth, packet_len);
 
diff --git a/drivers/usb/eth/r8152.h b/drivers/usb/eth/r8152.h
index 055ec5e385..3ced02a3b1 100644
--- a/drivers/usb/eth/r8152.h
+++ b/drivers/usb/eth/r8152.h
@@ -794,6 +794,9 @@ struct r8152 {
 
 	u8 version;
 
+	u8 rx_desc_size;
+	u8 tx_desc_size;
+
 	struct ueth_data ueth;
 };
 
-- 
2.43.0

