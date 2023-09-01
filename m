Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386A8CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 878F8869B7;
	Fri,  1 Sep 2023 11:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561827;
	bh=Q6PBVnEMKsPP9FdCjx3JEAyc2i3eBAA1vXXQHmwMgrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TmvdElroorKi2xm+8ihNBonBZcIS+bg8bNMGkdqE0co4d3pkTSw83h4xiEH7Exh/A
	 pIfxZSwjPFgXgYSIwmPQ1gmIvOeLGGikZS9V81X1mw0Z5Gd00p8Xqdv+2m9CIxsiTx
	 r6ldxjlaarRfpz2/BqtDviWzim3tqj/ZB/RXCU257bJLh7/839OuUr7uGV5G1KqwIo
	 K2yCNNwRbAf0nUDGYQvJSLyyNrxCS2LzeNiEQHsFWKeC2LjURUNO7thcArMrXtuhMd
	 2goTE2dN67eJzfbWY6sMGjeU3y/a+0OBPcxH8mbbtMC8hsrblN5oaeS/iW/6BXCWdE
	 mapxPuXvEDBpg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 96D8B86983;
 Fri,  1 Sep 2023 11:50:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561826;
 bh=Q6PBVnEMKsPP9FdCjx3JEAyc2i3eBAA1vXXQHmwMgrI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y9pZ84mCjJBs95uitmMxilrPbITvzjx4g8rBtUyDnuiwoPHtqSM6di2wiQt6Z70YB
 ALnfjz4v1Cg5AY4tgl669FW+bpM4a95Up8zzLBGQECJ2/KJjtY3kS3Y4VxJaxJNH/J
 dStMm6ElSIlRc7ruwu3hGRRWrs54X6lFBA52hm1k4XLXQjaQfgx/oaebqw52YVajx9
 54sjmWC8raXQtwEZHgKyipazA12a2TgHNK2syW0xZ1FEYn8Yho/TTwhZKiAzqfKnnX
 nSkPyJ++UB5EtMi/F/AIBIX3RP0+1PZzedHKhn2FOHc8JdSaewP/k6Z8NT9HniFKSL
 hJM2GdlqG7j3g==
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
Subject: [PATCH v2 12/17] sdp: Use plain udevice for UDC controller interaction
Date: Fri,  1 Sep 2023 11:49:58 +0200
Message-Id: <20230901095003.352930-12-marex@denx.de>
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
 cmd/usb_gadget_sdp.c       | 11 +++++++----
 common/spl/spl_sdp.c       | 13 ++++++++-----
 drivers/usb/gadget/f_sdp.c | 10 +++++-----
 include/sdp.h              |  6 +++---
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/cmd/usb_gadget_sdp.c b/cmd/usb_gadget_sdp.c
index 784d1b49768..748aa0a7488 100644
--- a/cmd/usb_gadget_sdp.c
+++ b/cmd/usb_gadget_sdp.c
@@ -15,13 +15,16 @@
 static int do_sdp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	int controller_index;
+	struct udevice *udc;
 	int ret;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
 	controller_index = simple_strtoul(argv[1], NULL, 0);
-	usb_gadget_initialize(controller_index);
+	ret = udc_device_get_by_index(controller_index, &udc);
+	if (ret)
+		return ret;
 
 	g_dnl_clear_detach();
 	ret = g_dnl_register("usb_dnl_sdp");
@@ -30,20 +33,20 @@ static int do_sdp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		goto exit_register;
 	}
 
-	ret = sdp_init(controller_index);
+	ret = sdp_init(udc);
 	if (ret) {
 		pr_err("SDP init failed: %d\n", ret);
 		goto exit;
 	}
 
 	/* This command typically does not return but jumps to an image */
-	sdp_handle(controller_index);
+	sdp_handle(udc);
 	pr_err("SDP ended\n");
 
 exit:
 	g_dnl_unregister();
 exit_register:
-	usb_gadget_release(controller_index);
+	udc_device_put(udc);
 
 	return CMD_RET_FAILURE;
 }
diff --git a/common/spl/spl_sdp.c b/common/spl/spl_sdp.c
index aae886d2e57..5a5ccd0676c 100644
--- a/common/spl/spl_sdp.c
+++ b/common/spl/spl_sdp.c
@@ -14,10 +14,13 @@
 static int spl_sdp_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
-	int ret;
 	const int controller_index = CONFIG_SPL_SDP_USB_DEV;
+	struct udevice *udc;
+	int ret;
 
-	usb_gadget_initialize(controller_index);
+	ret = udc_device_get_by_index(controller_index, &udc);
+	if (ret)
+		return ret;
 
 	board_usb_init(controller_index, USB_INIT_DEVICE);
 
@@ -28,7 +31,7 @@ static int spl_sdp_load_image(struct spl_image_info *spl_image,
 		goto err_detach;
 	}
 
-	ret = sdp_init(controller_index);
+	ret = sdp_init(udc);
 	if (ret) {
 		pr_err("SDP init failed: %d\n", ret);
 		goto err_unregister;
@@ -39,13 +42,13 @@ static int spl_sdp_load_image(struct spl_image_info *spl_image,
 	 * or it loads a FIT image and returns it to be handled by the SPL
 	 * code.
 	 */
-	ret = spl_sdp_handle(controller_index, spl_image, bootdev);
+	ret = spl_sdp_handle(udc, spl_image, bootdev);
 	debug("SDP ended\n");
 
 err_unregister:
 	g_dnl_unregister();
 err_detach:
-	usb_gadget_release(controller_index);
+	udc_device_put(udc);
 	return ret;
 }
 SPL_LOAD_IMAGE_METHOD("USB SDP", 0, BOOT_DEVICE_BOARD, spl_sdp_load_image);
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 4da5a160a09..37f6281abfb 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -702,7 +702,7 @@ static int sdp_bind_config(struct usb_configuration *c)
 	return status;
 }
 
-int sdp_init(int controller_index)
+int sdp_init(struct udevice *udc)
 {
 	printf("SDP: initialize...\n");
 	while (!sdp_func->configuration_done) {
@@ -712,7 +712,7 @@ int sdp_init(int controller_index)
 		}
 
 		schedule();
-		usb_gadget_handle_interrupts(controller_index);
+		dm_usb_gadget_handle_interrupts(udc);
 	}
 
 	return 0;
@@ -911,9 +911,9 @@ static void sdp_handle_out_ep(void)
 }
 
 #ifndef CONFIG_SPL_BUILD
-int sdp_handle(int controller_index)
+int sdp_handle(struct udevice *udc)
 #else
-int spl_sdp_handle(int controller_index, struct spl_image_info *spl_image,
+int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
 		   struct spl_boot_device *bootdev)
 #endif
 {
@@ -929,7 +929,7 @@ int spl_sdp_handle(int controller_index, struct spl_image_info *spl_image,
 			return 0;
 
 		schedule();
-		usb_gadget_handle_interrupts(controller_index);
+		dm_usb_gadget_handle_interrupts(udc);
 
 #ifdef CONFIG_SPL_BUILD
 		flag = sdp_handle_in_ep(spl_image, bootdev);
diff --git a/include/sdp.h b/include/sdp.h
index 6d89baa04ec..5492f9c47d2 100644
--- a/include/sdp.h
+++ b/include/sdp.h
@@ -9,15 +9,15 @@
 #ifndef __SDP_H_
 #define __SDP_H_
 
-int sdp_init(int controller_index);
+int sdp_init(struct udevice *udc);
 
 #ifdef CONFIG_SPL_BUILD
 #include <spl.h>
 
-int spl_sdp_handle(int controller_index, struct spl_image_info *spl_image,
+int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
 		   struct spl_boot_device *bootdev);
 #else
-int sdp_handle(int controller_index);
+int sdp_handle(struct udevice *udc);
 #endif
 
 #endif /* __SDP_H_ */
-- 
2.40.1

