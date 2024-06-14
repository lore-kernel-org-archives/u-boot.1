Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FA5C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E4988986;
	Fri, 14 Jun 2024 02:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="w8WiJeJi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j0Pnq3aR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F9D8898D; Fri, 14 Jun 2024 02:53:54 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CEC588986
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W0gl275kVz9srV;
 Fri, 14 Jun 2024 02:53:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOEuURXysTTfVpOu57GNPz3XmimVXmUMD+NjWA/RRXs=;
 b=w8WiJeJiTpRaLL9AMGO/BIZwjqKOh+SHggset2DmKWB45+Ru/B1AxEN1xdo9y4jVloTs04
 nWHPmMTeCBMYeGbSS7tjr7oghE/U+DkxpckxHioSYQi7nmVyZIiIcM0DleTLWmJs5VrjJ8
 FcPhQDWUHSV5GHxx3JrGd8OfjGGPG3hMSAf7PYOxJViMyFHk73I+yasU1Ib2vVcryOCRJ/
 PlXJMNx29t1Ev8jSuRXVR0uhDRNwoLXjmP8ikf6SVq9Pn3V0UvNGzAPFaU1ZrdDjyslwAf
 EHmQlx8mw8Xijtgx67rxIDDAz5VS4Ji1BKsD8qLXO8uuNS7pAzWser8SEiBIkA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOEuURXysTTfVpOu57GNPz3XmimVXmUMD+NjWA/RRXs=;
 b=j0Pnq3aRoxnM0wXxR0RCr7nPKvkvkKSbhJdxNBLBkO9ANo6TW3NGbQkVFbU6bvJha9moEJ
 vSDM8CaHWkRpXY1gz7liB9+ZVW7/lr8XVhaDWYqluwx2BiEB7Eu2l4N9FsCFHGgi2ePoVZ
 /fdzZdYWmMWe/33i9WKn7pCM1QqUX9XtDP0C3XBzJzlFYaiwZJgDSZMrGbo3d31K2795Db
 3P2ot/YRJGPzncSTWGbP9rQ6/plX/kpZIuYiqaXsaF4OvVaF5RS6/neXuFSfoi8R8piE4U
 s7qlwySJ1D5HpqWMilUm4tmx3aOsgv4kszQ1f/XwOT827YbBnVDl/yjKQl1AYw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/11] usb: gadget: Mark dm_usb_gadget_handle_interrupts as
 non-weak for DM_USB_GADGET
Date: Fri, 14 Jun 2024 02:51:26 +0200
Message-ID: <20240614005309.34433-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b4197wmqcbe5daudzxtjzfdcy73qqjya
X-MBO-RS-ID: f13c0df56a04d2ccd44
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

The dm_usb_gadget_handle_interrupts() is not implemented by any USB
gadget controller drivers which do enable DM_USB_GADGET anymore. Set
the symbol as non-weak.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/usb/gadget/udc/udc-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-uclass.c b/drivers/usb/gadget/udc/udc-uclass.c
index 2320039fe3b..fbe62bbce47 100644
--- a/drivers/usb/gadget/udc/udc-uclass.c
+++ b/drivers/usb/gadget/udc/udc-uclass.c
@@ -18,7 +18,7 @@ usb_gadget_generic_dev_ops(struct udevice *dev)
 	return (const struct usb_gadget_generic_ops *)dev->driver->ops;
 }
 
-__weak int dm_usb_gadget_handle_interrupts(struct udevice *dev)
+int dm_usb_gadget_handle_interrupts(struct udevice *dev)
 {
 	const struct usb_gadget_generic_ops *ops;
 
-- 
2.43.0

