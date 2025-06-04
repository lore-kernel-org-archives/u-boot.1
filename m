Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4A6C5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 08:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97BD82B07;
	Wed,  4 Jun 2025 10:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HeEkDTz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504AA82BD9; Wed,  4 Jun 2025 10:20:20 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B518481FEE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 10:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id C4A6AA4FD5F;
 Wed,  4 Jun 2025 08:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12C1C4CEE7;
 Wed,  4 Jun 2025 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749025216;
 bh=1noa4RNjqcJ+T4WV+VKTN7pirZ//syCJi21iHztyeVg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HeEkDTz16sjcN7N54QQcl9OBS/cshyppjnTUz2VW4BqDjGlMkptQC4K36N6qPLSMZ
 3QdXPvcSOz5uGBgHgbfrdLkhla+1od/0jvbjxddA4zAuUvhFm32GtgzMrTAk4eyedQ
 iH8AqOWwEuZ5TpGoX9W/n/75Aacm50IWbuYIDOWjbCgjyjFb8I8LHW0RNazS7k/RFs
 88FeXucF3+5tpo+kCjqUr0h1g8qKjfdPVcLt0zrLTOJaoEDmbWQhKTkcq781mvI1oM
 FBa0qf6BrSXT+Bf/mg4QUDegtwaw8Z7W22q7sSMIpt6BLWMt5WMHWnCGs/dSxB1RsA
 IilrpGoBq3CiQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom
 Rini <trini@konsulko.com>, Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
Subject: Re: [PATCH] usb: gadget: atmel: reliably generate disconnect by
 disabling controller instead of toggling PULLD_DIS
In-Reply-To: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
References: <20250602-pullup-v1-1-edcde5a050dd@hifiphile.com>
Date: Wed, 04 Jun 2025 10:20:13 +0200
Message-ID: <87iklbuddu.fsf@kernel.org>
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

Hi Zixun,

Thank you for the patch.

On Mon, Jun 02, 2025 at 17:45, Zixun LI <admin@hifiphile.com> wrote:

I'm surprised that checkpatch.pl does not catch this, but the subject
(title) is too long (it should be less than 70 chars):
https://docs.u-boot.org/en/latest/develop/sending_patches.html#commit-message-conventions

> Contrary to the datasheet, setting both DETACH and PULLD_DIS bits to 1
> does not always drive the DP and DM lines to high-impedance. This
> prevents the host from reliably detecting a USB disconnect and subsequent
> reconnect.
>
> The symptom is that the first gadget command (e.g., dhcp) succeeds, while
> subsequent commands (e.g., nfs) fail.
>
> Disabling and re-enabling the controller entirely, instead of toggling the
> PULLD_DIS bit, reliably generates a disconnect event.
>
> The Linux driver works correctly because gadget_disconnect/gadget_connect
> are always followed by gadget_udc_start/gadget_udc_stop. In U-Boot
> pullup() is used solely.
>
> This behavior has been observed on the SAM9X60-Curiosity and
> AT91SAM9G25-EK boards and has been reported to Microchip.

I'm not against this, but the driver supports multiple gadget
families according to the compatible.

I'm wondering if this issue is reproduced on other atmel
boards that are supported in U-Boot.

Eugen, have you noticed the above limitation on a different
board family that you maintain?

If this issue is chip specific, I think we should test for compatible in
usba_udc_pullup() to only use USBA_ENABLE/USBA_DISABLE for this
particular compatible (microchip,sam9x60-udc).

>
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/usb/gadget/atmel_usba_udc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index f9326f0a7e7d913bcf201ba3e4aeca9a099e7be7..a38e70957402fb3ade3de611d73e29b990d00703 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -521,16 +521,11 @@ usba_udc_set_selfpowered(struct usb_gadget *gadget, int is_selfpowered)
>  static int usba_udc_pullup(struct usb_gadget *gadget, int is_on)
>  {
>  	struct usba_udc *udc = to_usba_udc(gadget);
> -	u32 ctrl;
> -
> -	ctrl = usba_readl(udc, CTRL);
>  
>  	if (is_on)
> -		ctrl &= ~USBA_DETACH;
> +		usba_writel(udc, CTRL, USBA_ENABLE_MASK);

Could we add a comment in the function as well? Something similar to
what's in the commit message:

/* Some chips don't reliably drive DP/DM lines to high impedance when
 * using the DETACH/PULLD_DIS bits.
 * To ensure a reliable disconnect, power cycle the controller instead
 */

Feel free to rephrase your preference.

>  	else
> -		ctrl |= USBA_DETACH;
> -
> -	usba_writel(udc, CTRL, ctrl);
> +		usba_writel(udc, CTRL, USBA_DISABLE_MASK);
>  
>  	return 0;
>  }
>
> ---
> base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
> change-id: 20250602-pullup-83c5540db5cd
>
> Best regards,
> -- 
> Zixun LI <admin@hifiphile.com>
