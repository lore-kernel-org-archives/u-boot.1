Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D551CEE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3C88707F;
	Sat, 19 Aug 2023 16:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455087;
	bh=8tny4OKQq2G233Tqbj74W1LXizQk7m9tycIkSz99aQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pwqGfA3CG8mItbnLh2cZCQB3y2WObd+9WymrXjetNyLg14a6SwJ5YByKYHWtkDNC9
	 LNoND74AYl5cgPtxqoZjEkTo2VvWdITCN4cGiIregmRxvUTON/JQJcT0ZgQiWBIM0N
	 jU8pa9N742WpHDsrAJtTQsaQ9s8jF6quHqGXe86LnZ9kVF41IK3PwgQFubt/GYsSlW
	 OjVuL2lCsOTJ82Lfa4oCF2zC8tfBWzHGwpY8g+tmmV4J2NWu1ppWWzv8nlb4yTdZQw
	 l1Y6wPtgAW/b93kuYqadDjEi2gB3krhvrW5Dwo0EyKcXSxESRtb/+cWk0nZednwG5h
	 q0XSvzxUw3jEQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 05E2287067;
 Sat, 19 Aug 2023 16:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455085;
 bh=8tny4OKQq2G233Tqbj74W1LXizQk7m9tycIkSz99aQw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ki4F82wPTCuMY/09tcZm6VY5FXWyJSJIuHu7q5FBsEOOCt7ytpvWGRnRExrwYC3gh
 rfc21t3qjwRZHQwaAo06jUONBdmchx3Mx02yH9zD3KTQ5Rg4J+Ks598sqgig6lmFXP
 yauC/ii2OGFt7lNbIS3q2ML5oBnjxZLJJftdChoQWLSCVg6iW6xmQjRGvAp3IrZD7z
 kqBBD0XHGElIaf1ZtDRAUaBB1Psd5BD/3PzbxB1GaZ/6ZaR8CXRl93V8oNd+wrAIh0
 VQdCYbeYuKBU1L1P/G/ZBKHnZaZNhF0Ur+QuOnNNxhabhZVzpgzHYG3GLToadYrOOG
 Z27gfshwoD/NA==
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
Subject: [PATCH 14/17] usb: gadget: acm: Use plain udevice for UDC controller
 interaction
Date: Sat, 19 Aug 2023 16:24:04 +0200
Message-Id: <20230819142407.49632-14-marex@denx.de>
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
 drivers/usb/gadget/f_acm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index b2ddd1ada8b..de42e0189e8 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -51,7 +51,7 @@ struct f_acm {
 #define ACM_CTRL_RTS	BIT(1)	/* unused with full duplex */
 #define ACM_CTRL_DTR	BIT(0)	/* host is ready for data r/w */
 
-	int controller_index;
+	struct udevice *udc;
 };
 
 static struct f_acm *default_acm_function;
@@ -489,7 +489,7 @@ static void __acm_tx(struct f_acm *f_acm)
 	int len, ret;
 
 	do {
-		usb_gadget_handle_interrupts(f_acm->controller_index);
+		dm_usb_gadget_handle_interrupts(f_acm->udc);
 
 		if (!(f_acm->handshake_bits & ACM_CTRL_DTR))
 			break;
@@ -520,7 +520,7 @@ static bool acm_connected(struct stdio_dev *dev)
 	struct f_acm *f_acm = stdio_to_acm(dev);
 
 	/* give a chance to process udc irq */
-	usb_gadget_handle_interrupts(f_acm->controller_index);
+	dm_usb_gadget_handle_interrupts(f_acm->udc);
 
 	return f_acm->connected;
 }
@@ -543,7 +543,10 @@ static int acm_add(struct usb_configuration *c)
 	f_acm->usb_function.descriptors = acm_fs_function;
 	f_acm->usb_function.hs_descriptors = acm_hs_function;
 	f_acm->usb_function.setup = acm_setup;
-	f_acm->controller_index = 0;
+
+	status = udc_device_get_by_index(0, &f_acm->udc);
+	if (status)
+		return status;
 
 	status = usb_add_function(c, &f_acm->usb_function);
 	if (status) {
@@ -567,7 +570,7 @@ static int acm_stdio_tstc(struct stdio_dev *dev)
 {
 	struct f_acm *f_acm = stdio_to_acm(dev);
 
-	usb_gadget_handle_interrupts(f_acm->controller_index);
+	dm_usb_gadget_handle_interrupts(f_acm->udc);
 
 	return (f_acm->rx_buf.size > 0);
 }
-- 
2.40.1

