Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51134CD68E8
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 09:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7196486DD3;
	Tue, 10 Oct 2023 11:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CMC9QkKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B8286DA2; Tue, 10 Oct 2023 11:03:24 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A2686DC3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 11:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EECBE0003;
 Tue, 10 Oct 2023 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696928589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8rGg+QF8fMKGbqnCwSYIRNR/kmfhz0BLitM8btU438=;
 b=CMC9QkKgsMzmhFa/1uP9Xk9/XgAdgUtJ7X33uySI/nyvEkQxCrLx+YvKhhW2x7WNGGY70I
 yXjyhV+npTZlP2q8vlgD7y6TBxrIY0jCS0xo365Y6wG6d99QWtX9wYltDYfcfWGbEvTGgL
 WPXU/sBiG5PMoDx0AX46ZJGS/MzdZ5cw3Mqv5Xy0RAoAGHXDN2XN53mLlpUR4tOR37tsSR
 gF5dTohGqpEsv6edmvXLvj+A9qyfXNxxnResiLYFQTNHUNE8RVI+8jutkD2+SYkCmsoWCj
 MJKjZQNrLPtf5OzRIkOoR/yhFkvpymeagUxu/DfwUnQ+31/VR62VP00Aa3jx6g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marek.vasut@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 3/3] usb: udc: Try to clarify an error message
Date: Tue, 10 Oct 2023 11:03:04 +0200
Message-Id: <20231010090304.49335-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010090304.49335-1-miquel.raynal@bootlin.com>
References: <20231010090304.49335-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

At some point when trying to use USB gadgets, two situations may arise
and lead to a failure. Either the UDC (USB Device Controller) is not
available at all (not described or not probed) or the UDC is already in
use. For instance, as the USB Ethernet gadget remains bound to the UDC,
the use of any other USB gadget (fastboot, dfu, etc) *after* will always
fail with the "couldn't find an available UDC" error.

Let's give a more helpful message by making a difference between the two
cases. Let's also hint people who would get this error and grep it into
the sources a better explanation of what's wrong with their workflow.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

While doing this I really wanted to add "much more" error comments but I
faced another reality: often the messages are there but use
pr_err/log_err which is actually silenced by default with LOGLEVEL=3, so
I consider this unnecessary, as decreasing the loglevel will make these
messages appear. I would have expected errors to be displayed, but I
understand it makes the binaries even bigger.
---
 drivers/usb/gadget/udc/udc-core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 7f73926cb3e..8405b03462e 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -323,6 +323,7 @@ err1:
 int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 {
 	struct usb_udc		*udc = NULL;
+	unsigned int		udc_count = 0;
 	int			ret;
 
 	if (!driver || !driver->bind || !driver->setup)
@@ -330,12 +331,22 @@ int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
 
 	mutex_lock(&udc_lock);
 	list_for_each_entry(udc, &udc_list, list) {
+		udc_count++;
+
 		/* For now we take the first one */
 		if (!udc->driver)
 			goto found;
 	}
 
-	printf("couldn't find an available UDC\n");
+	if (!udc_count)
+		printf("No UDC available in the system\n");
+	else
+		/* When this happens, users should 'unbind <class> <index>'
+		 * using the output of 'dm tree' and looking at the line right
+		 * after the USB peripheral/device controller.
+		 */
+		printf("All UDCs in use (%d available), use the unbind command\n",
+		       udc_count);
 	mutex_unlock(&udc_lock);
 	return -ENODEV;
 found:
-- 
2.34.1

