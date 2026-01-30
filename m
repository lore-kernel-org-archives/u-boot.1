Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA41DD73E87
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 00:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76CF384144;
	Fri, 30 Jan 2026 01:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yTUlWOHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6AEA84171; Fri, 30 Jan 2026 01:29:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 061FE84158
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769732991; bh=hYfmeJ0V0CcCkJWgjDxZqWPVj1qfYgWuoCSc7XxN8h0=;
 b=yTUlWOHCQUUA3wNYTMpIN6f5r0UKZ+ufjSYNWdjQjtufX1a3zQyoeBVR0++yqmxpU/eO/9KFp
 vLtyNigsx9ESnjwe8KCmm3rrFY3VeVnHtgUgjp+iPwqXUz24tjrSJRBBGkxnM1Iy8bvEBCdczal
 wkDz+X7CgljP2eYz4b7JfPMqL3P5tX2H4i+RBrN2wQLZUApoF5uJGoKG5jf60Z1hBKRdEinSQA6
 zErSpzNupyKbLUtrfXoeiJ1kYkApCuoTFmp54NBNZqoIuJ5cbJ7PdJy2TcPMedwDYAzyDYFHQm7
 M1tOguOp9R3qT763+/aOL+4EuAyDI7q2FnX5wD3KHXxA==
X-Forward-Email-ID: 697bfb7d5af568bba11df3ff
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/6] usb: eth: asix88179: Use a fixed URB buffer size of 16 KiB
Date: Fri, 30 Jan 2026 00:29:27 +0000
Message-ID: <20260130002941.2336252-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130002941.2336252-1-jonas@kwiboo.se>
References: <20260130002941.2336252-1-jonas@kwiboo.se>
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

The commit 05278af8b3df ("eth: asix88179: packet drop when receiving
large fragmented packets") adjusted the URB buffer size to allow large
fragmented packets. However, this change result in use of a large URB
buffer size for slow speed connections, e.g. 10/100M use 26 KiB.

Using a ASIX AX88179B USB 3.0 or ASIX AX88772E USB 2.0 Ethernet adapter
on a Rockchip RK3528 with a DWC2 USB controller this large URB buffer
size result in invalid rx_hdr and result in unusable Ethernet.

The data read back from AX_RX_BULKIN_QCTRL after being configured also
does not match the values in the AX88179_BULKIN_SIZE array.

Change to use a fixed URB buffer size of 16 KiB to fix use of Ethernet,
anything larger seem to result in unusable Ethernet. With the 16 KiB URB
buffer size use of TFTP_BLOCKSIZE=15360 seem to work okay.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Please note that the vendor driver 3.5.0 seems to use a different
BULKIN_SIZE array for the AX88179A/88772D variants, see [1].

[1] https://github.com/mmoya/asix-usb-nic-linux-driver/blob/main/ax88179a_772d.c#L24-L30
---
 drivers/usb/eth/asix88179.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/eth/asix88179.c b/drivers/usb/eth/asix88179.c
index 8915ef1fdc36..6da509175480 100644
--- a/drivers/usb/eth/asix88179.c
+++ b/drivers/usb/eth/asix88179.c
@@ -173,7 +173,7 @@
 #define USB_BULK_SEND_TIMEOUT 5000
 #define USB_BULK_RECV_TIMEOUT 5000
 
-#define AX_RX_URB_SIZE 1024 * 0x1a
+#define AX_RX_URB_SIZE 16384
 #define BLK_FRAME_SIZE 0x200
 #define PHY_CONNECT_TIMEOUT 5000
 #define PHY_RESET_TIMEOUT 500
@@ -206,7 +206,6 @@ struct asix_private {
 	uint8_t *pkt_data;
 	uint32_t *pkt_hdr;
 	int flags;
-	int rx_urb_size;
 	int maxpacketsize;
 };
 
@@ -333,8 +332,6 @@ static int asix_basic_reset(struct ueth_data *dev,
 	memcpy(tmp, &AX88179_BULKIN_SIZE[0], 5);
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
 
-	dev_priv->rx_urb_size = 1024 * 20;
-
 	/* Water Level configuration */
 	*tmp = 0x34;
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_PAUSE_WATERLVL_LOW, 1, 1, tmp);
@@ -476,7 +473,6 @@ static int asix_init_common(struct ueth_data *dev,
 	/* RX bulk configuration */
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_RX_BULKIN_QCTRL, 5, 5, tmp);
 
-	dev_priv->rx_urb_size = (1024 * (tmp[3] + 2));
 	if (*tmp16 & GMII_PHY_PHYSR_FULL)
 		mode |= AX_MEDIUM_FULL_DUPLEX;
 	asix_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
@@ -574,7 +570,7 @@ int ax88179_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 			if (!(flags & ETH_RECV_CHECK_DEVICE))
 				return -EAGAIN;
 
-			ret = usb_ether_receive(ueth, priv->rx_urb_size);
+			ret = usb_ether_receive(ueth, AX_RX_URB_SIZE);
 			if (ret < 0)
 				return ret;
 
-- 
2.52.0

