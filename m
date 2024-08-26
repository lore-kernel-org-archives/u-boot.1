Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135C4C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C59F88A2E;
	Mon, 26 Aug 2024 16:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rt8gkioJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ldaSf3h/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77AA388A35; Mon, 26 Aug 2024 16:39:13 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2601889CA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Wstbd3dl7z9tGd;
 Mon, 26 Aug 2024 16:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6l32CzCcohl/AjapZmTTzfi3AGDv+ytANtm9V98xLJ4=;
 b=rt8gkioJrg30d3R+K1e4KaIxERPdWfBU/yuSPlkhyFWbsVc7a5Hdvg0p1Z9G1SuxFmHCrN
 St806iNo80YhGHqbAywzdlFwDxnEqhDqf2IuvZe+25Apm70sYXqn5jghuMn68ec/Zu0avj
 05ZsCr3+wjUh1kpUl+8YTAGxIO5O1Afcq405hnMebT0lwhgIgw9S2tBx36Foaq6S5ppRBH
 WlaExhf0n/hR5d8KEj+OW5nHoPThzjD/PtACBPfOf6i8cRICGM5luwmQbT3pIzdnIJ12ck
 uotQV2WFj9Qa9mIkeZ38qJQDML/Drl2jpCa8dQ5WQyUqXQz2Ei+PDUoxM+7RyA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6l32CzCcohl/AjapZmTTzfi3AGDv+ytANtm9V98xLJ4=;
 b=ldaSf3h/HitI0vaSYZUX2fiptKSuf+NSSweRJQWfbvZ1wHWQWGoTr7eJhFtuwEXqTkbONJ
 2J1foLURGCFwfu1mBFFNHsJ1XMMpWuaKBAYLwNZjfRa66DcKQxuOe684r6ti6tiSV9hGOD
 8tNK+64YY5pgbXAWayQ+3PBuOpA/OnQxOIdujbhT8TiA7CXSNU9wdg23eDPDG9w/E82dys
 vus+lz0ykIQZWyhQNOINI6AuwGkZCO9KoIG7/IDODpoSdrRvWD6VYXYjYSXLGYszEQn8LC
 BeTUTsHJyhxAQLhQJbKulNWIyAsODE6cfyOnLCDrgPqjPOB9UsUdI1nN7aTTLg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Zixun LI <admin@hifiphile.com>
Subject: [PATCH 1/6] usb: gadget: Inline usb_add_gadget_udc_release
Date: Mon, 26 Aug 2024 16:38:36 +0200
Message-ID: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9e5d068632f00877ab8
X-MBO-RS-META: acjnpotd1xd9k1knxygscs83stq81juo
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

The release parameter of usb_add_gadget_udc_release() is never used.
The function is never called from anywhere except from a wrapper in
udc-core.c . Inline the function into the wrapper.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/udc/udc-core.c | 20 ++------------------
 include/linux/usb/gadget.h        |  2 --
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 6bb419ae2ab..37c0ee43c52 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -166,16 +166,14 @@ static void usb_udc_release(struct device *dev)
 }
 
 /**
- * usb_add_gadget_udc_release - adds a new gadget to the udc class driver list
+ * usb_add_gadget_udc - adds a new gadget to the udc class driver list
  * @parent: the parent device to this udc. Usually the controller driver's
  * device.
  * @gadget: the gadget to be added to the list.
- * @release: a gadget release function.
  *
  * Returns zero on success, negative errno otherwise.
  */
-int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
-		void (*release)(struct device *dev))
+int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
 {
 	struct usb_udc		*udc;
 	int			ret = -ENOMEM;
@@ -205,20 +203,6 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 err1:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(usb_add_gadget_udc_release);
-
-/**
- * usb_add_gadget_udc - adds a new gadget to the udc class driver list
- * @parent: the parent device to this udc. Usually the controller
- * driver's device.
- * @gadget: the gadget to be added to the list
- *
- * Returns zero on success, negative errno otherwise.
- */
-int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget)
-{
-	return usb_add_gadget_udc_release(parent, gadget, NULL);
-}
 EXPORT_SYMBOL_GPL(usb_add_gadget_udc);
 
 static void usb_gadget_remove_driver(struct usb_udc *udc)
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c7927df15aa..d62fba0ca02 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -890,8 +890,6 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver);
  */
 int usb_gadget_unregister_driver(struct usb_gadget_driver *driver);
 
-int usb_add_gadget_udc_release(struct device *parent,
-		struct usb_gadget *gadget, void (*release)(struct device *dev));
 int usb_add_gadget_udc(struct device *parent, struct usb_gadget *gadget);
 void usb_del_gadget_udc(struct usb_gadget *gadget);
 /*-------------------------------------------------------------------------*/
-- 
2.45.2

