Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E2DCA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B110B868B8;
	Fri,  1 Sep 2023 11:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561821;
	bh=VkL0ab5jC6yf8hC311P+7a3oBCHZZxGZn+a/0lBh1Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x4xPe3yCftXxdOTGfjZ9Dx1m71Byjxs62LGFovMdRylScOws5Vunr1JUuydx+gZEF
	 zxOA1cLo/D/JXi2XeEYc6qlf/u4XAflRdv6PVI42AjxnnTBFAyrjERFjQCdZiqQZuH
	 z4sVgFtVo9cDHdSzWOZCo+pERmW1zUJoiHceZ8cEk0osyXBdCbJIxI5mmMmmPKKDzW
	 SRYqoqVk+MLnxZpcfn7g84zHm8ykFme3YsikkbwrRzSDOHSbVMSvD1aPmyNJWm4QV3
	 gbuECDNLG+bXMWrvuwvbtmplwfzgYFCNjqfDkiC+4+DPcyxJpC1pNvWHmkER6Tu4FV
	 X4+zd0gfdd/jQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5187886852;
 Fri,  1 Sep 2023 11:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561819;
 bh=VkL0ab5jC6yf8hC311P+7a3oBCHZZxGZn+a/0lBh1Lw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=y5Ta73kYq78xmv5H0KFxxGghv2XFzRHViasgYw/CLiGueNQRaaj/fpiX5Wdd9Quz1
 QJoRfWsUurLWwdtr0Ik+t+xP76OVLyn4XDfBjQSDBdNcFK8+encclMbBF9TC7xzLyU
 6P0gXXJzmLafF2Of42iJc2axBfHfmjjAiGHIdN0NtHQkLRlkZ7bmxqLm3XsWPmR/o/
 UCBcKUk0DiDzpmZ1IbE0kaSxoOKkFm5sPnK8WAVfLvYGC2yaEs7YMtVeXN32KoDstJ
 AQtYepqXYVokoUaSUxYeIA6AMOoyt2eWy+O+DYnA25CE30FwOSQFkNoBDc1KuB6cOV
 pVO6LfSUvJMIQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Stefan Roese <sr@denx.de>,
 kernel@puri.sm
Subject: [PATCH v2 02/17] usb: sandbox: Add DM_USB_GADGET support
Date: Fri,  1 Sep 2023 11:49:48 +0200
Message-Id: <20230901095003.352930-2-marex@denx.de>
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

Remove local usb_gadget_register_driver()/usb_gadget_unregister_driver()
implementation which is implemented in udc-core.c instead if DM_USB_GADGET
is enabled. Add no-op dm_usb_gadget_handle_interrupts() implementation.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
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
V2: Add RB from Mattijs, Simon
---
 drivers/usb/host/usb-sandbox.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbox.c
index d1103dcb2e9..582f72d00c1 100644
--- a/drivers/usb/host/usb-sandbox.c
+++ b/drivers/usb/host/usb-sandbox.c
@@ -124,6 +124,12 @@ static int sandbox_submit_int(struct udevice *bus, struct usb_device *udev,
 	return ret;
 }
 
+#if CONFIG_IS_ENABLED(DM_USB_GADGET)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+{
+	return 0;
+}
+#else
 int usb_gadget_handle_interrupts(int index)
 {
 	return 0;
@@ -144,6 +150,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 
 	return 0;
 }
+#endif
 
 static int sandbox_alloc_device(struct udevice *dev, struct usb_device *udev)
 {
-- 
2.40.1

