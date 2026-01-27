Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B02CD35664
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 01:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A22238423D;
	Wed, 28 Jan 2026 02:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ncPYUdLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A7598423C; Wed, 28 Jan 2026 02:02:54 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AFE284238
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 02:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f13sk48hyz9vHc;
 Wed, 28 Jan 2026 02:02:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769562170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLecwfozQ44WPu+waDt6Qcd3QJ+VE27FjVJlsN99lF4=;
 b=ncPYUdLyLSifHuQhHmlxjZY3BWwi7cm4qBoJ3QgDp8SL9zGJ+DpIj8kxg7/Z7N7V7NE+8a
 uFS+X1dcfIpFaT2mWEsvoiCq2FqVoWTZRHkTKee9ZQTnio8Gr3M/cLn0HZlOJfxGS6IPKb
 Kj8/5ikBDVDHb/MTkm9S7q4Gtv9cnc4YSDKajwtj3n0sOe8XMprJd4R3c1/huy0QAsh87g
 ksFHh5jSSvdpka8u7EF0WXEi15wU2h/WRH0/jXuXij3xvhTK7ag5ADIrNIieNohx0+ZhO7
 FW0dgozcprDbwjG8odRLXv2tSTYHY9dkRAyJ99hBL2L3lStHd8vGI73tFiJBpg==
Message-ID: <25d52b97-52f4-4842-9aaa-10c5495a5ec8@mailbox.org>
Date: Tue, 27 Jan 2026 22:15:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 7/7] usb: musb-new: Add compatibles for ti,musb-am33xx
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher
 <hs@nabladev.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
 <20260127-topic-musb-probing-v2026-01-v4-7-ea3201e0f809@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-7-ea3201e0f809@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: skrjo1a6ogzyn63ejsa1zaewdtbnrg3d
X-MBO-RS-ID: f3521796a3e3e99e7be
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

On 1/27/26 12:03 PM, Markus Schneider-Pargmann (TI.com) wrote:

[...]

> +static int ti_musb_host_bind(struct udevice *dev)
> +{
> +	enum usb_dr_mode dr_mode = usb_get_dr_mode(dev_ofnode(dev));
> +
> +	if (dr_mode != USB_DR_MODE_HOST && dr_mode != USB_DR_MODE_OTG)
> +		return -ENODEV;
> +
> +	return 0;
> +}

[...]

>   #if CONFIG_IS_ENABLED(OF_CONTROL)
> +static int ti_musb_peripheral_bind(struct udevice *dev)
> +{
> +	enum usb_dr_mode dr_mode = usb_get_dr_mode(dev_ofnode(dev));
> +
> +	if (dr_mode != USB_DR_MODE_PERIPHERAL)
> +		return -ENODEV;
How do you handle USB_DR_MODE_UNKNOWN , host or peripheral ?
