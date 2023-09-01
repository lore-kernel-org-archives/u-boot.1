Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FF7CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E4DB869D1;
	Fri,  1 Sep 2023 11:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561829;
	bh=W3W1rXXO4rg5Z2ojfkuLXsMeYDVklxaxEAYxcNNrs24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zn0TJ7evjzhFbrVWgSqlSuR8uzECz7GW5ELYX82AGqm7NKHoFgKxwnI5hNcpX8viv
	 z/oHbHt251vuZ2gVpNT5uAyycTlrikIRSHM3j4c2mijV44Jy5C7T5j0yNbsD/PfP//
	 ndVUqFAGD8FlXZRqYtHGw2NFqDhSPfGBTinbH5X90+k3bHne588wKTRUQMB+LZh/BQ
	 m2bN88NxkcqAP/bl1/17r2iT8ssnhG7VoTktbKtSQyMpY1JJYyW1QYeucdK/WkfV4A
	 2Rvw1cBln/zSRxa7G2k6gD66fIZGeG10AXmIzhmLDXg8k8obQANjqTk1fW58EAFLFH
	 wNaaQJyFwgIJQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7CB78869B1;
 Fri,  1 Sep 2023 11:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561828;
 bh=W3W1rXXO4rg5Z2ojfkuLXsMeYDVklxaxEAYxcNNrs24=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fNsRDJqDz2yHBrGx09w4/1SuLhBTGcqSKLQ1hM7TQ/dCld3kr1LURFlvn+BaZGGRF
 TY012R+bRZxbaWGQRrfC+GMBgejzzdLR8JioirnqsKslWgRGtqTeDtKEswpHdkTGIg
 7NrJGluDY3swjEsLAtck3Xu+EO2Mc99Gozf7txZaROOPJfQrMIIJxTZd1XOuTI65Sj
 khoZGCNQp/okJm+bFkgolWkpWpagFMT+/dr0DnROaHKhYxoRk6Bp0jqtCv3JUtTa6o
 AX0IJ/XmC4nSspwsJkgkmMsZSBpaOBsocGmLF87j7/0Tfl8QCltq2Hu81iMGv96UuG
 2TltAr6TGOSqw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH v2 15/17] usb: gadget: ether: Use plain udevice for UDC
 controller interaction
Date: Fri,  1 Sep 2023 11:50:01 +0200
Message-Id: <20230901095003.352930-15-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230901095003.352930-1-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
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

Convert to plain udevice interaction with UDC controller
device, avoid the use of UDC uclass dev_array .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: kernel@puri.sm
---
V2: Use udev->parent for UDC access
---
 drivers/usb/gadget/ether.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 5ff06d3814b..11b1a6221b3 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -1880,8 +1880,10 @@ static void eth_start(struct eth_dev *dev, gfp_t gfp_flags)
 	}
 }
 
-static int eth_stop(struct eth_dev *dev)
+static int eth_stop(struct udevice *udev)
 {
+	struct ether_priv *priv = dev_get_priv(udev);
+	struct eth_dev *dev = &priv->ethdev;
 #ifdef RNDIS_COMPLETE_SIGNAL_DISCONNECT
 	unsigned long ts;
 	unsigned long timeout = CONFIG_SYS_HZ; /* 1 sec to stop RNDIS */
@@ -1895,7 +1897,7 @@ static int eth_stop(struct eth_dev *dev)
 		/* Wait until host receives OID_GEN_MEDIA_CONNECT_STATUS */
 		ts = get_timer(0);
 		while (get_timer(ts) < timeout)
-			usb_gadget_handle_interrupts(0);
+			dm_usb_gadget_handle_interrupts(udev->parent);
 #endif
 
 		rndis_uninit(dev->rndis_config);
@@ -2300,7 +2302,7 @@ static int usb_eth_start(struct udevice *udev)
 			pr_err("The remote end did not respond in time.");
 			goto fail;
 		}
-		usb_gadget_handle_interrupts(0);
+		dm_usb_gadget_handle_interrupts(udev->parent);
 	}
 
 	packet_received = 0;
@@ -2370,7 +2372,7 @@ static int usb_eth_send(struct udevice *udev, void *packet, int length)
 			printf("timeout sending packets to usb ethernet\n");
 			return -1;
 		}
-		usb_gadget_handle_interrupts(0);
+		dm_usb_gadget_handle_interrupts(udev->parent);
 	}
 	free(rndis_pkt);
 
@@ -2400,13 +2402,13 @@ static void usb_eth_stop(struct udevice *udev)
 	 * 2) 'pullup' callback in your UDC driver can be improved to perform
 	 * this deinitialization.
 	 */
-	eth_stop(dev);
+	eth_stop(udev);
 
 	usb_gadget_disconnect(dev->gadget);
 
 	/* Clear pending interrupt */
 	if (dev->network_started) {
-		usb_gadget_handle_interrupts(0);
+		dm_usb_gadget_handle_interrupts(udev->parent);
 		dev->network_started = 0;
 	}
 }
@@ -2416,7 +2418,7 @@ static int usb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct ether_priv *priv = dev_get_priv(dev);
 	struct eth_dev *ethdev = &priv->ethdev;
 
-	usb_gadget_handle_interrupts(0);
+	dm_usb_gadget_handle_interrupts(dev->parent);
 
 	if (packet_received) {
 		if (ethdev->rx_req) {
@@ -2467,7 +2469,7 @@ int usb_ether_init(void)
 		return ret;
 	}
 
-	return usb_gadget_initialize(0);
+	return 0;
 }
 
 static int usb_eth_probe(struct udevice *dev)
@@ -2528,7 +2530,7 @@ static int usb_eth_remove(struct udevice *dev)
 
 static int usb_eth_unbind(struct udevice *dev)
 {
-	usb_gadget_release(0);
+	udc_device_put(dev->parent);
 
 	return 0;
 }
-- 
2.40.1

