Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A043CCAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 07:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AD683045;
	Tue, 30 Sep 2025 09:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tyI0W0jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514F283045; Tue, 30 Sep 2025 09:51:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52166828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 45E6F60400;
 Tue, 30 Sep 2025 07:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A139CC113D0;
 Tue, 30 Sep 2025 07:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759218706;
 bh=W+qWld5jtS0+S9ob7OLzsm3K6emCRLyMheT4QJNYt2A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=tyI0W0jdcrQzdMzxUMYPv7Dzsc8Yegt2HmhAb+jI+vRSY5sgVYB3E+UL1GliOc3J7
 eetqGHWOS3n6ZGcmYmvXE3mUZaeFWn+r0uhIAgG+01SdCghy5vE0HskQxbBpvuifDs
 wctSIg+nxgzjY9YJG8sooN0rIoO3sdmwdLEm9+TROgqhwZQKsu32IqVbb7phznD6I4
 Fi3OiCylhQQeKYa4B8MWq8AXIgOEHayflxLhhoZVBcXgQz4MOC4vPCzDUVGN9nJ9kv
 4Qlnx16WfE7eYbCOWjoNrnw1ZSGrSOf5lf1mqOzQh6iiHgrhha4XX/r7D3Kzp/VWeT
 IU18fYmA+8+iA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, u-boot@lists.denx.de, Andrew Goodbody
 <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] usb: dwc2: Add missing null check
In-Reply-To: <20250929-usb_dwc2-v1-1-863133dcbcde@linaro.org>
References: <20250929-usb_dwc2-v1-1-863133dcbcde@linaro.org>
Date: Tue, 30 Sep 2025 09:51:43 +0200
Message-ID: <87qzvoidio.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Andrew,

Thank you for the patch.

On Mon, Sep 29, 2025 at 17:40, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> Add in the missing null check for dev->driver that is present at other
> points in the function before it is dereferenced.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> index fca052b4556a7d2ae4fe516e39820611d7082e2f..5a7f50ebaa5579f67ea5dc9491d0d1f4d4b81ea1 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c
> @@ -526,7 +526,7 @@ static int dwc2_udc_irq(int irq, void *_dev)
>  		if (gotgint & GOTGINT_SES_END_DET) {
>  			debug_cond(DEBUG_ISR, "\t\tSession End Detected\n");
>  			/* Let gadget detect disconnected state */
> -			if (dev->driver->disconnect) {
> +			if (dev->driver && dev->driver->disconnect) {
>  				spin_unlock_irqrestore(&dev->lock, flags);
>  				dev->driver->disconnect(&dev->gadget);
>  				spin_lock_irqsave(&dev->lock, flags);
>
> ---
> base-commit: 9710d98e8942151fc0c62d54100d9d27e8263d04
> change-id: 20250929-usb_dwc2-924d0d26df62
>
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
