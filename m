Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A069C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC0A88A4B;
	Mon, 26 Aug 2024 16:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XtGT3lXl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="suHolJsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24829884DB; Mon, 26 Aug 2024 16:39:16 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 436AC889CA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wstbj6fq0z9sbh;
 Mon, 26 Aug 2024 16:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiQCmqr7tSo8RBEBwrpP4KkwmIDMWer024FHcpHysiI=;
 b=XtGT3lXleskQogWjI5G/oxLzZkTdCPGrdkgGXJXPNOHtJL/ayZzMQM6kyWKlR1MH4ABcU4
 LB5i5CbudCSp15jVVJCBI0EzZVYjiL4oa7NbJb94k8vlsX2RpO7MNSh7pz9Qh3Yo592/RB
 VcqUaYT43bCc9zCQ/a+rVQdtwxU7JcLzJ0aEMtbjlLcJFRiAmmjzNXAjORjs1gN1C5T0xK
 VITt4kV2+cfLHxIY8qRhN6OmTdiSG+tui97IHiEF/dFdNeJm335juzINgWvpCB6loOZT/X
 aPWM1Z1mN6Wrz4DVV6mQOX5j2BSc1cW3OG1ZvdXhih7ug1f3yktql5JhmnmL7w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiQCmqr7tSo8RBEBwrpP4KkwmIDMWer024FHcpHysiI=;
 b=suHolJsIXuIlW851X4H4ge5GTrcChdRmBJvAkCsZEl7trVcNafuMLtswRS8Nh/4MHsFMoZ
 K3YpwGmPJc49PRsDvHNsX5jcNTqGsLDW60eMFpB0H0KQxYVxrVM5Unra49KLYRMqiUAJaQ
 6E7fsQE5zlI9cC7EoaRJqZlls1Xh+ZfnMF5k/q1ZgTZC8erDggZctzHepXBUgRtz+0qn95
 GvHS70JcWaNtyXOZDzxudl5/xFw2cmHiSTiwwHjM1T9Ax7Ot7gIZRkzxKpiJS8uoRAdqef
 wqiiL57wMeuBN91XtVXyWqJojU40gzETtck+m0/UaaBrQcRrmZ6te5U4HSfZFg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Zixun LI <admin@hifiphile.com>
Subject: [PATCH 4/6] usb: gadget: Drop dev_to_usb_gadget()
Date: Mon, 26 Aug 2024 16:38:39 +0200
Message-ID: <20240826143851.8020-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ab9ffde7b238487d12b
X-MBO-RS-META: c756sxyjbmyy4esw83u4g1ob7q93h4hw
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

This function is unused, remove it.

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
 include/linux/usb/gadget.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index a2b8520bc99..194025ebd12 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -558,11 +558,6 @@ static inline void *get_gadget_data(struct usb_gadget *gadget)
 	return gadget->driver_data;
 }
 
-static inline struct usb_gadget *dev_to_usb_gadget(struct device *dev)
-{
-	return container_of(dev, struct usb_gadget, dev);
-}
-
 /* iterates the non-control endpoints; 'tmp' is a struct usb_ep pointer */
 #define gadget_for_each_ep(tmp, gadget) \
 	list_for_each_entry(tmp, &(gadget)->ep_list, ep_list)
-- 
2.45.2

