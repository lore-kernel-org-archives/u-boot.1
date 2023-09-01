Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B32CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A078286886;
	Fri,  1 Sep 2023 11:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561831;
	bh=A+0SsOmMPhJpJpxYyJVyJeEYRMYfuwtGmJ8qptGYt/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jww2Obd7AzWWmaPtyV2xs8ktuq4pfpwlQpRbUuwVsSz2DqtOh+C9kIuhM+ySpd3Dy
	 q1tqAnkqG9Qs/IJORNUL6Qnx90Gp6GwkE9idDoD3CsnY7QyUfgHp4anoMLBlwnvLD2
	 1BoltTd0OwfXd815qKZ/ouMKuh4+2HiiQdBXEzjzpaGWfdaO8eHhbwVNGP6Ae8vjmK
	 UQ+q6q83j0UyZmj43Bib1P/Q64RaO/P6AnQbnbxeDucPi3UxmjqPn3t5zh/WlZiT4O
	 snZqmvABhI7LRA7pxH2CaNfkoo2TcFbcB9noL6rFhI5b4Es4mCfpYZf1Y1LYUkuICy
	 R3lkxfo+Bp0Qw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 225A486926;
 Fri,  1 Sep 2023 11:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561828;
 bh=A+0SsOmMPhJpJpxYyJVyJeEYRMYfuwtGmJ8qptGYt/Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xlo4evsromTvUzIzpmAzOsyKgCGgFPKmS1S8alOCx/Hsc0QgdYpnsC1IykRSZoH/V
 4Xtp/of2Fi9uV9SlcvHdVDTP2PqIk2vw0Kv8ao+RNDH61wWhl/FzT9Pr1A9ZTO1L1D
 Q67EvqP7cuGvj7ocwGCYPXHPSMBBRbLfG/uQJgFbwZm/tgI/uUeDX8nv6Zy+gaOurN
 kIoxFmHObTnamrmWed1tajxcs9m7U6N/IAtlpR3mTTR5nvTLNTgavS6E6o/FVJBJaq
 K+5XEyP7JO8Em9d1DEw4gc78zHryTeFGvCqY5cq0LqTDVt04AEwaxi8QHrOj0adCh9
 fHcXapwbcTuSw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH v2 16/17] dm: usb: udc: Drop legacy udevice handler functions
Date: Fri,  1 Sep 2023 11:50:02 +0200
Message-Id: <20230901095003.352930-16-marex@denx.de>
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

Remove legacy functions limited by the dev_array array,
those are no longer used anywhere, all the code uses
plain udevice based access now.

The usb_gadget_handle_interrupts() is doing udevice look up
until all call sites use dm_usb_gadget_handle_interrupts().

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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
V2: Add RB from Mattijs
---
 drivers/usb/gadget/udc/udc-uclass.c | 44 ++++-------------------------
 include/linux/usb/gadget.h          | 17 -----------
 2 files changed, 6 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index b4271b4be9f..7f54a3b00cb 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -12,9 +12,6 @@
 #include <linux/usb/gadget.h>
 
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
-#define MAX_UDC_DEVICES 4
-static struct udevice *dev_array[MAX_UDC_DEVICES];
-
 int udc_device_get_by_index(int index, struct udevice **udev)
 {
 	struct udevice *dev = NULL;
@@ -45,45 +42,16 @@ int udc_device_put(struct udevice *udev)
 #endif
 }
 
-int usb_gadget_initialize(int index)
-{
-	int ret;
-	struct udevice *dev = NULL;
-
-	if (index < 0 || index >= ARRAY_SIZE(dev_array))
-		return -EINVAL;
-	if (dev_array[index])
-		return 0;
-	ret = udc_device_get_by_index(index, &dev);
-	if (!dev || ret) {
-		pr_err("No USB device found\n");
-		return -ENODEV;
-	}
-	dev_array[index] = dev;
-	return 0;
-}
-
-int usb_gadget_release(int index)
+int usb_gadget_handle_interrupts(int index)
 {
-#if CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)
+	struct udevice *udc;
 	int ret;
-	if (index < 0 || index >= ARRAY_SIZE(dev_array))
-		return -EINVAL;
 
-	ret = device_remove(dev_array[index]);
-	if (!ret)
-		dev_array[index] = NULL;
-	return ret;
-#else
-	return -ENOSYS;
-#endif
-}
+	ret = udc_device_get_by_index(index, &udc);
+	if (ret)
+		return ret;
 
-int usb_gadget_handle_interrupts(int index)
-{
-	if (index < 0 || index >= ARRAY_SIZE(dev_array))
-		return -EINVAL;
-	return dm_usb_gadget_handle_interrupts(dev_array[index]);
+	return dm_usb_gadget_handle_interrupts(udc);
 }
 #else
 /* Backwards hardware compatibility -- switch to DM_USB_GADGET */
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 5e9a6513d5b..54875d2716e 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1023,21 +1023,4 @@ int udc_device_get_by_index(int index, struct udevice **udev);
  */
 int udc_device_put(struct udevice *udev);
 
-#if CONFIG_IS_ENABLED(DM_USB_GADGET)
-int usb_gadget_initialize(int index);
-int usb_gadget_release(int index);
-int dm_usb_gadget_handle_interrupts(struct udevice *dev);
-#else
-#include <usb.h>
-static inline int usb_gadget_initialize(int index)
-{
-	return board_usb_init(index, USB_INIT_DEVICE);
-}
-
-static inline int usb_gadget_release(int index)
-{
-	return board_usb_cleanup(index, USB_INIT_DEVICE);
-}
-#endif
-
 #endif	/* __LINUX_USB_GADGET_H */
-- 
2.40.1

