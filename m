Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681EDEE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C107D8706E;
	Sat, 19 Aug 2023 16:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455086;
	bh=toXAni7z+MBIdkIGepFT0t8/LozlFvQShp007FJdWXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YI48deW3FJMvdujvqz3xiRtLMDJ/hapsvmr41ltRiBS7JUvsy1ezTNWX5I1xxKC5X
	 XZ2C5a/u5Ue31ids8Xq7O52VCMlHVvaaYAZWeyY3+hfjqBnF6bVEcNdTfZ5RCIJtQr
	 fxA+T5FmQJJBIi0/ApMcKigdtC3SwqF+CMdgRSnFJwsby7fXOqvUKuOaigDIWgumnI
	 FMHHhDqi5KuuR1DCQMtzj+lsYfEghvBM/CuqpOLOaRf/O5+KaaFNRttRZg/rc5bMG+
	 4eA2yrBWmn3ITPR+ZTTlruTReUJYhFLw7JN2qnDV2BXURySqPX8g7dfSo7IaK57nNo
	 DvVQBC1DGuMuw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7828286FDF;
 Sat, 19 Aug 2023 16:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455083;
 bh=toXAni7z+MBIdkIGepFT0t8/LozlFvQShp007FJdWXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TK6GFRuWKe0s679UpSdlZZJQeFiNoguYvOj9NZdu8Np+9YLRRURP5bu/1Bx5aR0ob
 M+ofOnRvioKefNfG88+LddrFo/MOlWb9Q9/PmpdVyjcLdkg98hbVvrXGVYstl6bf+h
 Sertrq4zqcNDrIdGFhsCtpbu7GGHhD66CQgYhahIVX9ikcO5Qo/nJZ9xwddZxaB3zZ
 I2MJl8tAQawEcQ+lzrUImEzhxBeQkGv6HYx/VUqg2T2Szr7caOapkSEjq/iunTTCL/
 PllNM+l5KYbHJRWJYRk4bkM1vwI7ppVuKaSESHTr6c/ckmltmMsRa7f0LK/GjidKKb
 yD1eNQfdPX34Q==
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
Subject: [PATCH 10/17] dfu: Use plain udevice for UDC controller interaction
Date: Sat, 19 Aug 2023 16:24:00 +0200
Message-Id: <20230819142407.49632-10-marex@denx.de>
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
 common/dfu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/common/dfu.c b/common/dfu.c
index 32fba84da16..45206b9e225 100644
--- a/common/dfu.c
+++ b/common/dfu.c
@@ -23,11 +23,12 @@
 int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
 {
 	bool dfu_reset = false;
+	struct udevice *udc;
 	int ret, i = 0;
 
-	ret = usb_gadget_initialize(usbctrl_index);
+	ret = udc_device_get_by_index(usbctrl_index, &udc);
 	if (ret) {
-		pr_err("usb_gadget_initialize failed\n");
+		pr_err("udc_device_get_by_index failed\n");
 		return CMD_RET_FAILURE;
 	}
 	g_dnl_clear_detach();
@@ -55,7 +56,7 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
 			}
 
 			/*
-			 * This extra number of usb_gadget_handle_interrupts()
+			 * This extra number of dm_usb_gadget_handle_interrupts()
 			 * calls is necessary to assure correct transmission
 			 * completion with dfu-util
 			 */
@@ -68,7 +69,7 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
 
 		if (dfu_get_defer_flush()) {
 			/*
-			 * Call to usb_gadget_handle_interrupts() is necessary
+			 * Call to dm_usb_gadget_handle_interrupts() is necessary
 			 * to act on ZLP OUT transaction from HOST PC after
 			 * transmitting the whole file.
 			 *
@@ -77,7 +78,7 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
 			 * 5 seconds). In such situation the dfu-util program
 			 * exits with error message.
 			 */
-			usb_gadget_handle_interrupts(usbctrl_index);
+			dm_usb_gadget_handle_interrupts(udc);
 			ret = dfu_flush(dfu_get_defer_flush(), NULL, 0, 0);
 			dfu_set_defer_flush(NULL);
 			if (ret) {
@@ -103,12 +104,12 @@ int run_usb_dnl_gadget(int usbctrl_index, char *usb_dnl_gadget)
 			goto exit;
 
 		schedule();
-		usb_gadget_handle_interrupts(usbctrl_index);
+		dm_usb_gadget_handle_interrupts(udc);
 	}
 exit:
 	g_dnl_unregister();
 err_detach:
-	usb_gadget_release(usbctrl_index);
+	udc_device_put(udc);
 
 	if (dfu_reset)
 		do_reset(NULL, 0, 0, NULL);
-- 
2.40.1

