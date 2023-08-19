Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B49EE4993
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F828700B;
	Sat, 19 Aug 2023 16:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455079;
	bh=mYlJO7RpsgXEOpxxR5mz0eznVG1XwKj11/r5Z6dDs4g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UMake4Z3SB1dzIqiXO8eQSaphEOhD5jpFroLLKqFXPN3eU/gVOPlDaFPdykXIDozh
	 /jE+5yhNBaT9HEUfFN/XyfoTMcwAU0Bzn8jZHgza2s4Ewl2e3KXj9HpcvtTZ3DHrJp
	 mhz4DltZYJi2VHz1vwPeYs7evcCzUgnW7PMKescFIkDbDV75T+RP3JiCDZ2Iuq4fW9
	 ctqulj7JSb5hOhgKE2OA/6uinMyu9N6Z6y2eHIdhpTkcoOrSADJ4feArkEVCDoDC5P
	 q5P2LBNj6tJS1Hn9265n5GfvlYi6fU0qJnkejbVqyESdZzmRY5OtI1DbBozQHS8vBb
	 hPcJuNcEA23ow==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9B9E786750;
 Sat, 19 Aug 2023 16:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455077;
 bh=mYlJO7RpsgXEOpxxR5mz0eznVG1XwKj11/r5Z6dDs4g=;
 h=From:To:Cc:Subject:Date:From;
 b=QQOeCrgf53+gngqcNke11msg1BYWxP/vPFeDrDRHkMiXV/NDQK8Mv3rvgfHiVgPJd
 92aKJKM8HiNoE+zWdRShzS3N2pEa0ddsEkZKuFhob1XOWcw83JvgmMeXVBLftGFNm5
 VdszqR5knNkxKsENPBZcIzPLGIYN0dk467TAstI5rXoX29hOtYkohKABqsN8J6mu1q
 uuY/SbRFH/EihecvlmsLTqYkFkJkemAniU503YOme4dmQtQ7iozSIGzIXNaBbZdQho
 r6XRJl/1KR/+M2wM8lqCdf3lBV0aruMpdiNi9SmD+CV0mejKZcC2+vn/WX23Qe1TBb
 daITJAcED3NRw==
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
Subject: [PATCH 01/17] dm: usb: udc: Factor out plain udevice handler functions
Date: Sat, 19 Aug 2023 16:23:51 +0200
Message-Id: <20230819142407.49632-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

Pull the functionality of UDC uclass that operates on plain udevice
and does not use this dev_array array into separate functions and
expose those functions, so that as much code as possible can be
switched over to these functions and the dev_array can be dropped.

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
 drivers/usb/gadget/udc/Makefile     |  2 +-
 drivers/usb/gadget/udc/udc-uclass.c | 57 +++++++++++++++++++++++++----
 include/linux/usb/gadget.h          | 17 +++++++++
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
index 95dbf0c82ee..467c566f6d3 100644
--- a/drivers/usb/gadget/udc/Makefile
+++ b/drivers/usb/gadget/udc/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_USB_DWC3_GADGET)	+= udc-core.o
 endif
 
 obj-$(CONFIG_$(SPL_)DM_USB_GADGET)	+= udc-core.o
-obj-$(CONFIG_$(SPL_)DM) += udc-uclass.o
+obj-y += udc-uclass.o
diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index de8861829c7..b4271b4be9f 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -14,6 +14,37 @@
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
 #define MAX_UDC_DEVICES 4
 static struct udevice *dev_array[MAX_UDC_DEVICES];
+
+int udc_device_get_by_index(int index, struct udevice **udev)
+{
+	struct udevice *dev = NULL;
+	int ret;
+
+	ret = uclass_get_device_by_seq(UCLASS_USB_GADGET_GENERIC, index, &dev);
+	if (!ret && dev) {
+		*udev = dev;
+		return 0;
+	}
+
+	ret = uclass_get_device(UCLASS_USB_GADGET_GENERIC, index, &dev);
+	if (!ret && dev) {
+		*udev = dev;
+		return 0;
+	}
+
+	pr_err("No USB device found\n");
+	return -ENODEV;
+}
+
+int udc_device_put(struct udevice *udev)
+{
+#if CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)
+	return device_remove(udev, DM_REMOVE_NORMAL);
+#else
+	return -ENOSYS;
+#endif
+}
+
 int usb_gadget_initialize(int index)
 {
 	int ret;
@@ -23,13 +54,10 @@ int usb_gadget_initialize(int index)
 		return -EINVAL;
 	if (dev_array[index])
 		return 0;
-	ret = uclass_get_device_by_seq(UCLASS_USB_GADGET_GENERIC, index, &dev);
+	ret = udc_device_get_by_index(index, &dev);
 	if (!dev || ret) {
-		ret = uclass_get_device(UCLASS_USB_GADGET_GENERIC, index, &dev);
-		if (!dev || ret) {
-			pr_err("No USB device found\n");
-			return -ENODEV;
-		}
+		pr_err("No USB device found\n");
+		return -ENODEV;
 	}
 	dev_array[index] = dev;
 	return 0;
@@ -42,7 +70,7 @@ int usb_gadget_release(int index)
 	if (index < 0 || index >= ARRAY_SIZE(dev_array))
 		return -EINVAL;
 
-	ret = device_remove(dev_array[index], DM_REMOVE_NORMAL);
+	ret = device_remove(dev_array[index]);
 	if (!ret)
 		dev_array[index] = NULL;
 	return ret;
@@ -57,10 +85,25 @@ int usb_gadget_handle_interrupts(int index)
 		return -EINVAL;
 	return dm_usb_gadget_handle_interrupts(dev_array[index]);
 }
+#else
+/* Backwards hardware compatibility -- switch to DM_USB_GADGET */
+static int legacy_index;
+int udc_device_get_by_index(int index, struct udevice **udev)
+{
+	legacy_index = index;
+	return board_usb_init(index, USB_INIT_DEVICE);
+}
+
+int udc_device_put(struct udevice *udev)
+{
+	return board_usb_cleanup(legacy_index, USB_INIT_DEVICE);
+}
 #endif
 
+#if CONFIG_IS_ENABLED(DM)
 UCLASS_DRIVER(usb_gadget_generic) = {
 	.id		= UCLASS_USB_GADGET_GENERIC,
 	.name		= "usb",
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 };
+#endif
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 2f694fc25c1..5e9a6513d5b 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1006,6 +1006,23 @@ extern void usb_ep_autoconfig_reset(struct usb_gadget *);
 
 extern int usb_gadget_handle_interrupts(int index);
 
+/**
+ * udc_device_get_by_index() - Get UDC udevice by index
+ * @index: UDC device index
+ * @udev: UDC udevice matching the index (if found)
+ *
+ * Return: 0 if Ok, -ve on error
+ */
+int udc_device_get_by_index(int index, struct udevice **udev);
+
+/**
+ * udc_device_put() - Put UDC udevice
+ * @udev: UDC udevice
+ *
+ * Return: 0 if Ok, -ve on error
+ */
+int udc_device_put(struct udevice *udev);
+
 #if CONFIG_IS_ENABLED(DM_USB_GADGET)
 int usb_gadget_initialize(int index);
 int usb_gadget_release(int index);
-- 
2.40.1

