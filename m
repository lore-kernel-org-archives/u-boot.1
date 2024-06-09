Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9941C27C55
	for <u-boot@archiver.kernel.org>; Sun,  9 Jun 2024 21:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11FA0883E0;
	Sun,  9 Jun 2024 23:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tM52zrzC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VHiNmQDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36AE8883C9; Sun,  9 Jun 2024 23:35:18 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3317B87C7F
 for <u-boot@lists.denx.de>; Sun,  9 Jun 2024 23:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vy7Wl6cg2z9sTl;
 Sun,  9 Jun 2024 23:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xSVONT16PwA+a/CpLj5ZUXm7aFId6SulpytgZltXm8=;
 b=tM52zrzCDl46rKXRfCH2ZosaQZMOARdCKGONUyHGFzBJRF/IirI5epoRRxj47iijw7tvgZ
 1e9A7IzGBhebT2a+X3M80Tl+5PfEwiiceIEBGD5yGOZMeGN+Lf2ufzodE9yfPFsF0AlLER
 /TPZMRJdU90XyXKPN8uqw6dETUE622r/gM7y6Nlm9tqHnhnkNQIOWIySrnhkM2h9bHUZv8
 LPAqlt/zq4wf2B+gWoR23zueNNMm4fwr0iQInKIZIw65+4zC9OMxGIADL5fmC0roseYQ3m
 fisiWrAK0symquUZfzHf1V92yYQe6a3A3GC0Q0AAc62uGEb+hqLWlNjGv8gRXg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xSVONT16PwA+a/CpLj5ZUXm7aFId6SulpytgZltXm8=;
 b=VHiNmQDR6uxSA9Z3AkqUToDsiSJTF5uvWfbv0fiFRVgtkf3mwh5/nfiz0wlV4Azi9AWknt
 wgtAdBntbVvO2TxRnpe6bzx9/a3stQKGBvTdDipzMTCNKsLs40man8sZ8AGUQJqE8CqNLL
 FUMNRWLqgOd/cJu9OhLfD0L6CSkKXiJHdulKTvIooAc95KEqPyCfWxGvQoPzoUoAizoSEr
 bb3x9r/O1uwGY5EfkM9Mz4HSz8j2eiz2ygZE/ZmXD2A4C5Y18z3hHQFvt4XNQQYZiDuh3L
 uU1kgXQUhqS72HxzjxJ/hPczbEFX4Zb3k2TKW2jiCDY6DDqEulUt8R054l2KiQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] usb: gadget: ether: Drop usb_gadget_controller_number()
Date: Sun,  9 Jun 2024 23:32:15 +0200
Message-ID: <20240609213449.194762-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 737371ff3f782e486fe
X-MBO-RS-META: oh4rhjj1fxum78kbwd5uqr91uue6wc3e
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
 drivers/usb/gadget/ether.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index b8b29d399b1..e76464e121b 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -22,8 +22,8 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <linux/ctype.h>
+#include <version.h>
 
-#include "gadget_chips.h"
 #include "rndis.h"
 
 #include <dm.h>
@@ -1998,19 +1998,8 @@ static int eth_bind(struct usb_gadget *gadget)
 		rndis = 0;
 	}
 
-	gcnum = usb_gadget_controller_number(gadget);
-	if (gcnum >= 0)
-		device_desc.bcdDevice = cpu_to_le16(0x0300 + gcnum);
-	else {
-		/*
-		 * can't assume CDC works.  don't want to default to
-		 * anything less functional on CDC-capable hardware,
-		 * so we fail in this case.
-		 */
-		pr_err("controller '%s' not recognized",
-			gadget->name);
-		return -ENODEV;
-	}
+	gcnum = (U_BOOT_VERSION_NUM << 4) | U_BOOT_VERSION_NUM_PATCH;
+	device_desc.bcdDevice = cpu_to_le16(gcnum);
 
 	/*
 	 * If there's an RNDIS configuration, that's what Windows wants to
-- 
2.43.0

