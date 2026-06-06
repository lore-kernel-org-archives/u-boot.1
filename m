Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD21CD8C85
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 01:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 164068063E;
	Sun,  7 Jun 2026 03:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j40OSOju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA478063E; Sun,  7 Jun 2026 03:37:34 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A84580433
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 03:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gXyTk6CPCz9tF2;
 Sun,  7 Jun 2026 03:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780796251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heyjsr6R1Jud60k/p4MUVzPj+6UBBpJKFtCkCGbDaw0=;
 b=j40OSOjuaqnj9AahvD1GyXcIWpBiM2HE+igDw/263abUKG70Zea4CSAy4nxIV+SJxi+oYg
 OmLVdONjty6mNRPcB8QyuNabjAij3ecSqC6aaIsF+lqHNi4J7fniYTXwvFVcCILzgHuKKX
 NXWvgebp/1Ve+zpl74PJVPzbEQJ29DI2SjuQ0QDhMPTAQgkNQ4yFgFgskc+UQlPRBGD47T
 nSC6uqGKzVlIqkhOsN6h8X2TVkvnSRqrCmCwk6YTjmljpm/CcI3EyQTZ3U697r4PpFF6Ca
 O4cdtqBTBDgoa6l9ma97Tk0JLC2GEkt5B5OXl5YJTUx05nKRo2CkhRw6m2GaZw==
Message-ID: <f2049d3a-5611-454a-b930-e651e56da3cd@mailbox.org>
Date: Sat, 6 Jun 2026 21:12:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: gadget: atmel: use calloc() to allocate endpoint
 list
To: Zixun LI <admin@hifiphile.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20260606-udc_malloc-v2-1-1155326b182b@hifiphile.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260606-udc_malloc-v2-1-1155326b182b@hifiphile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 282a84c46a435ed65ac
X-MBO-RS-META: 8ocaca9erb6zcroh9arcamf7dkbtxy43
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

On 6/6/26 10:27 AM, Zixun LI wrote:
> malloc() doesn't zero out memory, leaving ep->ep.enabled uninitiated,
> which could make this flag falsely true.
> 
> In next usb_ep_enable() call since this flag is true, ep->ops->enable()
> will be skipped. Then usb_ep_queue() will fail on uninitialized endpoint.
> 
> Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
> Signed-off-by: Zixun LI <admin@hifiphile.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
