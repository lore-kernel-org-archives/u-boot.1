Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32036C27C53
	for <u-boot@archiver.kernel.org>; Sun,  9 Jun 2024 21:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41BC1883FB;
	Sun,  9 Jun 2024 23:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HqRBwxrD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hJ/PlLLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FA988415; Sun,  9 Jun 2024 23:35:21 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069B7883BA
 for <u-boot@lists.denx.de>; Sun,  9 Jun 2024 23:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Vy7Wq6nMJz9slg;
 Sun,  9 Jun 2024 23:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLz/FHpOzws0sEoP+fG5vNKsvMnl1Pwo+/6tWTvY4x8=;
 b=HqRBwxrDKyfxWF/88qqoeuzxXiwNERRo1JixoA8n+6T3VnPI9OSJ8sAqOfiBSSmweIY1I5
 EmNx3Wj+aQFEE44xj4csDRb9dCVwNchTWnYoOoAEGRa3oAilHlkkpwla2PnHzSQfpshsCO
 50z+oPGwqdbyflsCbsZ4AzvsscmDX86fyvpJG58236Idx+zcq+08vpskS3N8FXGI0jwH7W
 iBUJbhNh00YnbpCBsfF6bbz5VpaHl9q2AOLFTSStwe+98wQY7eno85OTIHuRWZM8wtITUN
 Jw7/NfrPVMk6YTUy4815rBLuHZRhhnfZWDKH2i2+xf06Bfy+L8u0tw9HbbLvAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717968918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLz/FHpOzws0sEoP+fG5vNKsvMnl1Pwo+/6tWTvY4x8=;
 b=hJ/PlLLVIJ0Qjji9pXuoOTEhWy5O3ey19FVKL+vC6rpGDm/Kj4DK4kbmHdBC29m/SeSk1G
 U2pQeIqkMcuWyg3aUljoVvP2EG3aMt4MkICn7C711mEaJ6obEg2ncWogDL+Ajesah+e9Yy
 eQ5z8N3n3hqMSVB4LJBtv0ZXu6NL1OBNKTmqvRVHPfnrxoP8r4qE6G0uhj2Ativ21WzNw1
 +L0g9+Hggz4wpm4XN3u+GFL1mlElO8iUVFO0FhxwbTOqqxJvDfgrSqOEBgZD2BmCMxVVd9
 DP/+cVvjZ4XZUQrTxMzYIGYtPvhBmNfJxrQzQ8jSpUaJDuJprYx2LE7icAacrg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] usb: gadget: Add full ep_matches() check past .match_ep()
 callback
Date: Sun,  9 Jun 2024 23:32:18 +0200
Message-ID: <20240609213449.194762-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 38660324d358da9397b
X-MBO-RS-META: q7s1ymf3jjpkniqn5yzzjdz5qu48hzw8
X-Rspamd-Queue-Id: 4Vy7Wq6nMJz9slg
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

If .match_ep() callback returns non-NULL endpoint, immediately check
its usability and if the returned endpoint is usable, stop search and
return the endpoint. Otherwise, continue with best effort search for
usable endpoint.

Currently the code would attempt the best effort search in any case,
which may find another unexpected endpoint. It is likely that the
intention of the original code was to stop the search early.

Fixes: 77dcbdf3c1ce ("usb: gadget: Add match_ep() op to usb_gadget_ops")
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
 drivers/usb/gadget/epautoconf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 09950ceeaed..66599ce8efa 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -247,8 +247,11 @@ struct usb_ep *usb_ep_autoconfig(
 			return ep;
 	}
 
-	if (gadget->ops->match_ep)
+	if (gadget->ops->match_ep) {
 		ep = gadget->ops->match_ep(gadget, desc, NULL);
+		if (ep && ep_matches(gadget, ep, desc))
+			return ep;
+	}
 
 	/* Second, look at endpoints until an unclaimed one looks usable */
 	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
-- 
2.43.0

