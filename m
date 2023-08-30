Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B1AC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F0986549;
	Wed, 30 Aug 2023 20:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="B2Iwi0DR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028E286539; Wed, 30 Aug 2023 16:04:23 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706DB86525
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RbQyT6mPYz9snt;
 Wed, 30 Aug 2023 16:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1693404258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UR+SaJgn7kIcX0bmsc01f0Re73aL7V50RvLtWe7VQ94=;
 b=B2Iwi0DREz+yF2Wo4heAixwIOZgVC+RfqJTD2/anUdU2vIDZaeCqh5kYSIn50syi0S/1BJ
 O88cn+0OMX9p18FHmyvcbHQTMHInmxUkivvRnPua7kPcleO6Sjlrx7+dK6yfgRUusBhTXZ
 AAQKEE8JXB1jQMzPmtR0Nuh/VQxuv1yfMQjaPK28Xf4FhAag5hF0VUT+nYRKFXCabKqJ4y
 wpJSVfki8oaSC/Cz2nK1F7CHrTs7MTkBv4/pglPJnN1TvtTUfizcAbVAj6vJza22iPEvBN
 xYbTcpy61k4khJVjf3NMFXHRs6lGQ7DSpeYsGeQXN5ienbq/yhAjcN33rc4+GQ==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marex@denx.de>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/5] drivers/usb/dwc3: zynqmp: only free reset gpio if we have
 one
Date: Wed, 30 Aug 2023 16:03:31 +0200
Message-ID: <20230830140349.10801-3-lists@steffen.cc>
In-Reply-To: <20230830140349.10801-1-lists@steffen.cc>
References: <20230830140349.10801-1-lists@steffen.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RbQyT6mPYz9snt
X-Mailman-Approved-At: Wed, 30 Aug 2023 20:15:48 +0200
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

This gpio is optional so undonditionally freeing it will crash.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---

 drivers/usb/dwc3/dwc3-generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 7f0af05855..dcc342ed04 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -149,7 +149,9 @@ static int dwc3_generic_remove(struct udevice *dev,
 	    priv->ulpi_reset) {
 		struct gpio_desc *ulpi_reset = priv->ulpi_reset;
 
-		dm_gpio_free(ulpi_reset->dev, ulpi_reset);
+		if (priv->ulpi_reset) {
+			dm_gpio_free(ulpi_reset->dev, ulpi_reset);
+		}
 	}
 
 	dwc3_remove(dwc3);
-- 
2.42.0

