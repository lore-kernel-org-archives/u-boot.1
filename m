Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3B5C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 14:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2094C884DB;
	Mon, 26 Aug 2024 16:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Fw9Ddvsh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LaX9WnO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875D988A74; Mon, 26 Aug 2024 16:39:17 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30E8889FC
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 16:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Wstbl2q58z9t2C;
 Mon, 26 Aug 2024 16:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hmXGMYK4oexR5XOdM3WNL+Q63d4FnlxfexjNRUepq4=;
 b=Fw9DdvshVh7im/KmdnQd8uHyQa7PoimQ94X7VOsLZYP3hPIl0ZACqlkTRZty5bJ4dYbZMz
 yBPi41DH8TNJfltfBMOu9KVym9Rn5r402wEoL5wIW06MpUCM4fzg8qQsq+aLSNpr515UNm
 UGvX+MsRnYMAKRMSLR64sDRvi32HjvR9Lku9/8Fg9u2pGdUgp1vC2R1EjeY37MO1mAZMIV
 ebLpJP+FGNw4pvX7k0TwrwOs9XgjARkAam0CTYOr0cYfwQ/f9m/coPjC07EhvEt2mz8DQH
 EHMevA+trz+8wujZG05wce5Tl56DJ0xUPqlJjI+xsQ2W9Kh5XsLb82csxik5wA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1724683153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hmXGMYK4oexR5XOdM3WNL+Q63d4FnlxfexjNRUepq4=;
 b=LaX9WnO6gM8qXtmx8MJW3v27HG7RBU/wmGf38Dtz0QI0+J+onwDFZTMpUjSkwu4cMgMbSu
 8TKzVme1cuFr1x1mRNQsCQ9xl6qkJ3NK6Upngynbp/Cn7uN3MhM5At6toHUt48SoDwjkgx
 4ysN6EjDocHL3tlvKWnbFPj4hKg0wWJtAMXCnHHtl+pepu4IbXjYJkyBx2PRGWHO8GSHYy
 vs4Vi8z3mq1XCMeYqWDUiUiAuiM2Q/MzWKLk5cYa6mOhDWTl/HOJZCUFs1/WOPAAJuTcWD
 xmxjCLHdPRIOBdcVKA5xra5w0fny/siF1RLd3ObgfgF77qGtmUQ/f6B5xUJQTQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Zixun LI <admin@hifiphile.com>
Subject: [PATCH 5/6] usb: gadget: dwc2: Drop get/set_udc_gadget_private_data()
Date: Mon, 26 Aug 2024 16:38:40 +0200
Message-ID: <20240826143851.8020-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y8sohhaasufw6xcqnyjyfbbj8eismz1p
X-MBO-RS-ID: 7351fc860235064d838
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

Neither get_udc_gadget_private_data() nor set_udc_gadget_private_data()
is ever called anywhere, remove both.

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
 drivers/usb/gadget/dwc2_udc_otg.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 7e9dd6f4268..fbd6c9600fc 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -121,19 +121,6 @@ static void nuke(struct dwc2_ep *ep, int status);
 static int dwc2_udc_set_halt(struct usb_ep *_ep, int value);
 static void dwc2_udc_set_nak(struct dwc2_ep *ep);
 
-void set_udc_gadget_private_data(void *p)
-{
-	debug_cond(DEBUG_SETUP != 0,
-		   "%s: the_controller: 0x%p, p: 0x%p\n", __func__,
-		   the_controller, p);
-	the_controller->gadget.dev.device_data = p;
-}
-
-void *get_udc_gadget_private_data(struct usb_gadget *gadget)
-{
-	return gadget->dev.device_data;
-}
-
 static struct usb_ep_ops dwc2_ep_ops = {
 	.enable = dwc2_ep_enable,
 	.disable = dwc2_ep_disable,
-- 
2.45.2

