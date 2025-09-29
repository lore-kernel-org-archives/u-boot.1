Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B1ECAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 23:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A6BA8350A;
	Tue, 30 Sep 2025 01:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rVjwfx1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A9883071; Tue, 30 Sep 2025 01:09:32 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0229783071
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 01:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cbH2J73YKz9tRN;
 Tue, 30 Sep 2025 01:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759187369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIMBPXbMhidsiMXNgvPc4Wgjc94FdDs4E/2fy3xPF/Q=;
 b=rVjwfx1k0/8H2g3VNPwRhWpWxpKCQN6W6D0RtuKsIob7wNoexb/khm2ZnA19meBhSOyu1B
 TZ7t2BZuEsqqnLVcKI75tz1/QJyxTXBNk8u97r9/zJW+YgYrU4LQSvgaYrMP5sumnlGuUX
 mV/2u6t145EFl1WRyvEHv+AaHnnoXXWmGgtEIKilCZBqXziVBYbA72qq7aD3wKBwYdbKS9
 g3msx7oiY3ovZfibtz+lO2Y4NOstXRzoeS9Kdgp/sghRsML7yHAdOKDAbeq1+HNNbZQflx
 K4sz3/8jtLt0tIJiWzUa830D/3bhg7Y7ei+wiXJmVJMmL7l0J6GGAK9RojlsYQ==
Message-ID: <c78d957b-0406-4d38-a97a-6f661575825c@mailbox.org>
Date: Tue, 30 Sep 2025 01:05:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc2: Add missing null check
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
References: <20250929-usb_dwc2-v1-1-863133dcbcde@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250929-usb_dwc2-v1-1-863133dcbcde@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 60f225b6f745c6c2674
X-MBO-RS-META: sbg91ffanq6h9oarf4sefcubi8o74h6e
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

On 9/29/25 6:40 PM, Andrew Goodbody wrote:
> Add in the missing null check for dev->driver that is present at other
> points in the function before it is dereferenced.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> index fca052b4556a7d2ae4fe516e39820611d7082e2f..5a7f50ebaa5579f67ea5dc9491d0d1f4d4b81ea1 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> @@ -526,7 +526,7 @@ static int dwc2_udc_irq(int irq, void *_dev)
>   		if (gotgint & GOTGINT_SES_END_DET) {
>   			debug_cond(DEBUG_ISR, "\t\tSession End Detected\n");
>   			/* Let gadget detect disconnected state */
> -			if (dev->driver->disconnect) {
> +			if (dev->driver && dev->driver->disconnect) {

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
