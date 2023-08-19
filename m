Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B1DEE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F0287074;
	Sat, 19 Aug 2023 16:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455087;
	bh=IsnzqR5YcwYGD+u9aCSHFrZTin+x7d0KRmzfwNjpXxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W+11Iyo7k2zvSF1z3/I5g3DNCUXzfYVu21iBhtfpnJ+ZXLllGP9oIRhtGrnpzY96P
	 Z7xzYMEtrBPYRHwwJqjmFPQ1O1HA4eLaBZF67gl5FW8Vnv0619/piLO0XeXC97E++k
	 HTtDu58TlnSilJwlaDPX6sBfxbn+hpUzcDcQGYy+c33BGvFHo5X54XzwfXVG8ZbWiQ
	 TMkJnLGU/+zbiyWCKUr2PkqhvHVcqwK/4TRhysxwXyGFwIIfucZkSB4D19BGHbjrgR
	 sZNGX+MyWNB4KZpw0Dmg4YAf2x30oS9Y1u4BkkBZUzdyezxqbP8T7Mk6P1QxO7BPu0
	 XfRRedr22ItdQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B889987051;
 Sat, 19 Aug 2023 16:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455084;
 bh=IsnzqR5YcwYGD+u9aCSHFrZTin+x7d0KRmzfwNjpXxA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kGsrNSb4N5sBNxvjkOpicvOV6ScxkjbAU+UCYI6rgU3lg5AnmO5gzlvoWbaomBpt5
 lfpsEdGxBrPWTWPrAuakOYXnKNmTteqKn6ICemoKwx2GtKUDYJiqlwY4Woous8fVBx
 0J/hhbwvD2rlbwol+q4ZLJqS9mCxrnfJQiwA8ZNCH6AXzl9WQHAg3eGrrBFsCgqkiY
 azjV7V/YX/gmI5lhOHFMz9b4/J7ITuZuu9+zLQrYfHbNKwe1fD57onVqa95pXUWZ5n
 CxE8XeJ1Epi63E5BGTkKcw0kD7crQYofxEbv8+E7muxPa11Xzkg2x3Zhjvl6++xmCw
 E+eaLW1Uuz9Yg==
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
Subject: [PATCH 12/17] sdp: Use plain udevice for UDC controller interaction
Date: Sat, 19 Aug 2023 16:24:02 +0200
Message-Id: <20230819142407.49632-12-marex@denx.de>
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
index f6b99c1af5a..83585cf82d3 100644
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
 		goto err_detach;
@@ -39,11 +42,11 @@ static int spl_sdp_load_image(struct spl_image_info *spl_image,
 	 * or it loads a FIT image and returns it to be handled by the SPL
 	 * code.
 	 */
-	ret = spl_sdp_handle(controller_index, spl_image, bootdev);
+	ret = spl_sdp_handle(udc, spl_image, bootdev);
 	debug("SDP ended\n");
 
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

