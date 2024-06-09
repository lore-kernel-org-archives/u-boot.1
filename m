Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC13C27C53
	for <u-boot@archiver.kernel.org>; Sun,  9 Jun 2024 21:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8CA883B3;
	Sun,  9 Jun 2024 23:35:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T3A+mfSL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gnytdkxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F7B883C9; Sun,  9 Jun 2024 23:35:16 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89C5883B6
 for <u-boot@lists.denx.de>; Sun,  9 Jun 2024 23:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Vy7Wk3Mtgz9sSs;
 Sun,  9 Jun 2024 23:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tMqgzvSeJxUenLCEA5DJY7KS3RWVfYdQynqKLh66K8E=;
 b=T3A+mfSLSgH14BPOgL6wSKOdLxU7JQEMwQl0bEHIiP3oWH8q8BISgcn9XLZ6GIhzywcW6C
 BBsGKhJAJ6agN7fikuhCTjjEwsZhA6YHpu7z4+hS4SVO13txexrurq+hkAKqCLWDp5aUuh
 B2ChUoUXbgC6lDQpL49jeSUGKhexNAuq+wGggqKy9T06qlz0NNNa8dTfsIv/2a6JlCi+qX
 GaFnETCI8GINM45y8JJEKnFYXwVCkmCI3v2x9vZAcl6pfwTh2x/Jmeti6to/D24/jpvWr7
 Bn8Gw3vdRW9MfDIinjrd+NXsZo0+M82uIvKUr19q3BjG5cLd0dcPWOlLR6DnUg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tMqgzvSeJxUenLCEA5DJY7KS3RWVfYdQynqKLh66K8E=;
 b=gnytdkxKx83nPTtf4CHqmvsj4FCbzKJA2oOYgW5Ghcuqtc6q5ONGBIbTGRqd8becCfplvX
 xXHBUpOTKimjPg2oEu6ZAkNMuU1rF+jl4ibi7wEJTSuZUr96Em+uZDqSD33BpJQvvxT0Xi
 sjzODvH3wy//pg0yWt0N2yFQ00sDWBevyAcAmmPHx8I2CD/5nngErX7jYhRNk6pAHjjK68
 qSC57cvWxoW4/956o5NiEDiPp0Io+mWmPsgIz2b9RrSHQk2hz/T7pECxukEYo8BbMFuQx/
 SYEAQdkPXizany0dZm4q/FQ55YmTWJHfv3FZ+OW8NlIJvrvqDcvsHaJBDsVx4Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] usb: gadget: g_dnl: Drop usb_gadget_controller_number()
Date: Sun,  9 Jun 2024 23:32:14 +0200
Message-ID: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 149e761a91ffa861cf8
X-MBO-RS-META: doxs1s9cxw9t4fznpbaus9qxucfbtdzp
X-Rspamd-Queue-Id: 4Vy7Wk3Mtgz9sSs
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

The bcdDevice field is defined as
|Device release number in binary-coded decimal
in the USB 2.0 specification. We use this field to distinguish the UDCs
from each other. In theory this could be used on the host side to apply
certain quirks if the "special" UDC in combination with this gadget is
used. This hasn't been done as far as I am aware. In practice it would
be better to fix the UDC driver before shipping since a later release
might not need this quirk anymore.

This patch converts this gadget to use the U-Boot version instead of a
random 2 or 3 plus the UDC number. Linux stopped using this functionality
in 2012, remove it from U-Boot as well.

Matching Linux kernel commit:
ed9cbda63d45 ("usb: gadget: remove usb_gadget_controller_number()")

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
 drivers/usb/gadget/g_dnl.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index b5b5f5d8c11..631969b3405 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -17,10 +17,10 @@
 #include <usb_mass_storage.h>
 #include <dfu.h>
 #include <thor.h>
+#include <version.h>
 
 #include <env_callback.h>
 
-#include "gadget_chips.h"
 #include "composite.c"
 
 /*
@@ -199,18 +199,6 @@ void g_dnl_clear_detach(void)
 	g_dnl_detach_request = false;
 }
 
-static int g_dnl_get_bcd_device_number(struct usb_composite_dev *cdev)
-{
-	struct usb_gadget *gadget = cdev->gadget;
-	int gcnum;
-
-	gcnum = usb_gadget_controller_number(gadget);
-	if (gcnum > 0)
-		gcnum += 0x200;
-
-	return g_dnl_get_board_bcd_device_number(gcnum);
-}
-
 /**
  * Update internal serial number variable when the "serial#" env var changes.
  *
@@ -261,7 +249,8 @@ static int g_dnl_bind(struct usb_composite_dev *cdev)
 	if (ret)
 		goto error;
 
-	gcnum = g_dnl_get_bcd_device_number(cdev);
+	gcnum = g_dnl_get_board_bcd_device_number((U_BOOT_VERSION_NUM << 4) |
+						  U_BOOT_VERSION_NUM_PATCH);
 	if (gcnum >= 0)
 		device_desc.bcdDevice = cpu_to_le16(gcnum);
 	else {
-- 
2.43.0

