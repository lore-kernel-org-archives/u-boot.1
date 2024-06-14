Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2EFC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 00:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7347A88992;
	Fri, 14 Jun 2024 02:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LE1nmwfr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DbPSo6Rj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F6F88997; Fri, 14 Jun 2024 02:53:51 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70EDA8897F
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 02:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W0gl12cnkz9smd;
 Fri, 14 Jun 2024 02:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vr3XvHyVLRKJQ+iGak//fAuA8jBfda83muvP15JYeSs=;
 b=LE1nmwfr4K9XXezqMMJcD6juZHLw800uI20Vdwwzx52oFTCI4CTWsfd0TKBi/naQTzduWV
 0OtlpU7pvrZU3nf63SzoU7FrrkXe9QXY9Xb+wTGof5BcWb9nRFixkhiBIIYB6FNvxuwZwU
 yvqkEbywA6lMcc3DxM2xuP5DOitQsdEf5qE9RokIBpMblC10SClNrxLzZ2IQpb1dOUQxE1
 4CRfeCX19OJqxwYYKJNku2JTzfHEY6kKKNfZhMHIxGq65WNE2avmsYKW6D4fetaMnKWpMf
 4+JpKbDyDQ6QS4VblFgNCiZCUP0xgC8bMOYAX2dwC9W3D2JO1WYIylR6dBYPRQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718326427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vr3XvHyVLRKJQ+iGak//fAuA8jBfda83muvP15JYeSs=;
 b=DbPSo6RjnIZOxWIDHsZrV1Y6ElPdsuiOXCMLg1442mEtUX2Fj7qphl9BJ3l6nBJXSaGLZu
 7VEcdBfCgRRC1i7okaFAPQGrggl9fMQi55unLr9BWSbC1s1pqZd87nssF0VpNzv+f4+LZO
 CdrdgJ9AmyY2/uS1w+31yvkqgVX6AIDzcwKog3M6DDxeJW3DQVlncb858twuW/ImGc32kK
 TM33pY2TWXA23V96vCM31tBoqYXtxMr3HcvBaChuNioam+MWnTZVjShxx8aHiXvQz7woY3
 MErC+sozJXVjreFQRJSE4wMPzGxzx9A1yF+ee+S1TM6KxBpZ4xX1JhZ+1w8OOA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/11] usb: gadget: sandbox: Drop
 dm_usb_gadget_handle_interrupts()
Date: Fri, 14 Jun 2024 02:51:25 +0200
Message-ID: <20240614005309.34433-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
References: <20240614005309.34433-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8doczhfs7d9djrp9ocottp9shrpi8czt
X-MBO-RS-ID: ee1d6540f7212a6a6b2
X-Rspamd-Queue-Id: 4W0gl12cnkz9smd
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

Drop dm_usb_gadget_handle_interrupts() in favor of empty default
implementation of the same in drivers/usb/gadget/udc/udc-uclass.c .

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
 drivers/usb/host/usb-sandbox.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/host/usb-sandbox.c b/drivers/usb/host/usb-sandbox.c
index e26f0b292ed..f687fe2c430 100644
--- a/drivers/usb/host/usb-sandbox.c
+++ b/drivers/usb/host/usb-sandbox.c
@@ -123,12 +123,7 @@ static int sandbox_submit_int(struct udevice *bus, struct usb_device *udev,
 	return ret;
 }
 
-#if CONFIG_IS_ENABLED(DM_USB_GADGET)
-int dm_usb_gadget_handle_interrupts(struct udevice *dev)
-{
-	return 0;
-}
-#else
+#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
 int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 {
 	struct sandbox_udc *dev = this_controller;
-- 
2.43.0

