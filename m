Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D7DCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8D586903;
	Fri,  1 Sep 2023 11:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561826;
	bh=vMyDYOjmh9dZ7WLC09lFygfR9NGI7OX9aiRSbE2MZgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LTV5dpNVV26FRbf9Z1Nnw6lOSgTTnu/8zl/TUfkmRMFE6Mc/fzKOIFdDoXK5ty1bW
	 ayfVNkDpv74OOKbZEYmdjgr9WfIVsnDw5ryAL1VW3bSvaMWJWK4aJZ7b4jxUC+Ru19
	 M40XBozSBaO6skix+MRUp2HXuDVEJhlSRV5VmR7G0P3y+fSToqDmTtwAqvrLRPK85M
	 eI7FDIr1fEyE4sIIjVKY1Q+mo/GTCY9humd6fbdZPuILLVNNqB6VfYn3Si/++0glDI
	 b+qKrarRTFzEk/4iJQoKbNT8nKuEiIraCl0ay77YGzcSDUoZgvNaG6hjCh2GFWvZ6q
	 3KxIRxGPcNj5A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 558F486951;
 Fri,  1 Sep 2023 11:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561824;
 bh=vMyDYOjmh9dZ7WLC09lFygfR9NGI7OX9aiRSbE2MZgg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SwwDtz88kyLnFYw52bIK4opJxR3uAIqr+Pv8rBFk6dKDhwKrwRZGGGdUaMQ4lQy5B
 WLJe+OhQj+KY7fF7nRJkg3O3R9fbQ44tHqNEY02fb13lHXzpaXKhguwfwrNKcyBuVY
 w2zvXeScQSOXsL27eNFsE54LopXzWzEoG6d0p3O+Oeo1cStRpxwGtt8O2BhSki4Ju3
 MPvmY7T0kl6N8I3aouMdWE/JjOtr//Oq/PaHytDkyWX38Qm4dOGIRnTK/xK5IxJ5lg
 MZIB5ufEUA9Iyi1K1TGb/oCmJv9reXpdnIpxHGAgnevADEg42JYnhYuYVLuoOvmhsm
 +46glWYoD1XoA==
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
Subject: [PATCH v2 10/17] dfu: Use plain udevice for UDC controller interaction
Date: Fri,  1 Sep 2023 11:49:56 +0200
Message-Id: <20230901095003.352930-10-marex@denx.de>
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

