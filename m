Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF9DEE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:27:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA9987081;
	Sat, 19 Aug 2023 16:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455088;
	bh=BSKOq5DBgn5EMiNfsgl9uIXfiT2Hb7+EVJQM1uNUswk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xOLR4FftNR9m18tAsaAyfaf0hD6VVLtGBncgHlblrz95Z6VniYJ3SD8z2BL1rOR5Z
	 IRVQBJH35sLVJMSd8H6E6QNkvdzWLpvBRU5yJ7U/sS/NxqqBGZq9dUvl4CSlUgU6zs
	 8v5uUgnucdCmmkY/QA5uRWM/g4VwYVDJxaD/JCCriFaDVWbQic1qw48M5JohlUrp0+
	 /2fg437dxEXDrVcSEIFLF1T4In5bCpFdeH3lhamkN39bWnZLZ2SDIA++cSsviYj4lz
	 cp7gQ+sD2INiovDNoS61m/bH3QjmndHVrwte+WDkp4W8y9CPWs6ywn7teouN21PR/n
	 uKN345DS7xBrQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9EB0486FC6;
 Sat, 19 Aug 2023 16:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455086;
 bh=BSKOq5DBgn5EMiNfsgl9uIXfiT2Hb7+EVJQM1uNUswk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uTfZhIVWBNO2MtyFjPTMr0X2eCuVclA3dKrJZ90J9/bdO8H6LSJKTcfaKSNFEPfDZ
 i7XTQXEcSLD9SJjnPjmqbVOa489bfJdgnYKjc0mW6L5TZomT0vdE2UIE9xHY3rVQSm
 o82kI/wSspM9JnTsRLT2KIZUO2yZ7iv7whNZ25qG/R4PrijJLuUwrEqUKO7SzeiFpr
 QYOxQ+1gNK7Rx2v5UNZpKji469GzcNGWwABu3APpSQp8rfq/34sUOeiAlmM2NJ4z6T
 ormJ+GGPrYgif9fwtY54zf4iWyceHjpCHipbES2wJQGE+Vbe1HQF82dZ9FipW9wl7m
 +iNgc1R3l7ukw==
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
Subject: [PATCH 15/17] usb: gadget: ether: Use plain udevice for UDC
 controller interaction
Date: Sat, 19 Aug 2023 16:24:05 +0200
Message-Id: <20230819142407.49632-15-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
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
 drivers/usb/gadget/ether.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index 5ff06d3814b..cb1317fd9f3 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -137,6 +137,7 @@ struct eth_dev {
 struct ether_priv {
 	struct eth_dev ethdev;
 	struct udevice *netdev;
+	struct udevice *udcdev;
 	struct usb_gadget_driver eth_driver;
 };
 
@@ -1895,7 +1896,7 @@ static int eth_stop(struct eth_dev *dev)
 		/* Wait until host receives OID_GEN_MEDIA_CONNECT_STATUS */
 		ts = get_timer(0);
 		while (get_timer(ts) < timeout)
-			usb_gadget_handle_interrupts(0);
+			dm_usb_gadget_handle_interrupts(priv->udcdev);
 #endif
 
 		rndis_uninit(dev->rndis_config);
@@ -2300,7 +2301,7 @@ static int usb_eth_start(struct udevice *udev)
 			pr_err("The remote end did not respond in time.");
 			goto fail;
 		}
-		usb_gadget_handle_interrupts(0);
+		dm_usb_gadget_handle_interrupts(priv->udcdev);
 	}
 
 	packet_received = 0;
@@ -2370,7 +2371,7 @@ static int usb_eth_send(struct udevice *udev, void *packet, int length)
 			printf("timeout sending packets to usb ethernet\n");
 			return -1;
 		}
-		usb_gadget_handle_interrupts(0);
+		dm_usb_gadget_handle_interrupts(priv->udcdev);
 	}
 	free(rndis_pkt);
 
@@ -2406,7 +2407,7 @@ static void usb_eth_stop(struct udevice *udev)
 
 	/* Clear pending interrupt */
 	if (dev->network_started) {
-		usb_gadget_handle_interrupts(0);
+		dm_usb_gadget_handle_interrupts(priv->udcdev);
 		dev->network_started = 0;
 	}
 }
@@ -2416,7 +2417,7 @@ static int usb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 	struct ether_priv *priv = dev_get_priv(dev);
 	struct eth_dev *ethdev = &priv->ethdev;
 
-	usb_gadget_handle_interrupts(0);
+	dm_usb_gadget_handle_interrupts(priv->udcdev);
 
 	if (packet_received) {
 		if (ethdev->rx_req) {
@@ -2452,6 +2453,7 @@ static const struct eth_ops usb_eth_ops = {
 
 int usb_ether_init(void)
 {
+	struct ether_priv *priv;
 	struct udevice *usb_dev;
 	int ret;
 
@@ -2467,7 +2469,8 @@ int usb_ether_init(void)
 		return ret;
 	}
 
-	return usb_gadget_initialize(0);
+	priv = dev_get_priv(usb_dev);
+	return udc_device_get_by_index(0, &priv->udcdev);
 }
 
 static int usb_eth_probe(struct udevice *dev)
@@ -2478,6 +2481,9 @@ static int usb_eth_probe(struct udevice *dev)
 	priv->netdev = dev;
 	l_priv = priv;
 
+	if (!priv->udcdev)
+		priv->udcdev = dev->parent;
+
 	get_ether_addr(CONFIG_USBNET_DEV_ADDR, pdata->enetaddr);
 	eth_env_set_enetaddr("usbnet_devaddr", pdata->enetaddr);
 
@@ -2528,7 +2534,9 @@ static int usb_eth_remove(struct udevice *dev)
 
 static int usb_eth_unbind(struct udevice *dev)
 {
-	usb_gadget_release(0);
+	struct ether_priv *priv = dev_get_priv(dev);
+
+	udc_device_put(priv->udcdev);
 
 	return 0;
 }
-- 
2.40.1

