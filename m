Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503C8C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A79820F8;
	Tue,  1 Apr 2025 14:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W3utb5SW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B16A282012; Tue,  1 Apr 2025 12:08:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9E58006D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 650545C1C03;
 Tue,  1 Apr 2025 10:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED82C4CEE5;
 Tue,  1 Apr 2025 10:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743502076;
 bh=6mk5ALCe0N+jeTGuNkRhpeYLEN0IaoG8QrEHiq3C8BI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=W3utb5SWpmwU81tY2qjQBn2cJXbbhY3kuLl3qgmrgBtUIhtgmxStUPtYTV6ZWuqVB
 T4D4SRFbbN2jIYgkqTi4aMGeoLL2zy8IHXRDapyPXzrTO2p+4CYc6BZKf14GcBLGfS
 Cgft7xz2eckd4kcreL1zIUV2sv9cMnaluJmQ22RjeqcsVJqEHChdkVMIzVBRS4rvHq
 iMJ+Z1qHLmPbLJUleyxVimDZ1waEJ+u26LP+sU4n2icSoww3BtL3kaM0xSNBaLMlAR
 ZSa1nYb9qh1/m/r0XDiejgIVooMqayFjQUEPi1Df4O6FpL70EGsowRRrNzFL1XUK0k
 dl+07uXWxD4hQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek
 Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] usb: gadget: atmel: Add SAM9X60 support
In-Reply-To: <20250331162611.1557759-2-admin@hifiphile.com>
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-2-admin@hifiphile.com>
Date: Tue, 01 Apr 2025 12:07:52 +0200
Message-ID: <87y0wknqiv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:32:32 +0200
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

On lun., mars 31, 2025 at 18:26, Zixun LI <admin@hifiphile.com> wrote:

> Compared to SAM9X5 the only difference is the DPRAM memory from the
> USB High Speed Device Port (UDPHS) hardware block was increased,
> so we can reuse the same endpoint data.
>
> Also add compatible "microchip,sam9x60-udc".
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  arch/arm/mach-at91/include/mach/atmel_usba_udc.h | 2 +-
>  drivers/usb/gadget/atmel_usba_udc.c              | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
> index 835b47d91ba..23c71985c90 100644
> --- a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
> +++ b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
> @@ -20,7 +20,7 @@
>  	}
>  
>  #if defined(CONFIG_AT91SAM9G45) || defined(CONFIG_AT91SAM9M10G45) || \
> -	defined(CONFIG_AT91SAM9X5)
> +	defined(CONFIG_AT91SAM9X5) || defined(CONFIG_SAM9X60)
>  static struct usba_ep_data usba_udc_ep[] = {
>  	EP("ep0", 0, 64, 1, 0, 0),
>  	EP("ep1", 1, 1024, 2, 1, 1),
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index a77037a7094..f9326f0a7e7 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -1443,6 +1443,7 @@ static const struct udevice_id usba_udc_ids[] = {
>  	{ .compatible = "atmel,at91sam9rl-udc" },
>  	{ .compatible = "atmel,at91sam9g45-udc" },
>  	{ .compatible = "atmel,sama5d3-udc" },
> +	{ .compatible = "microchip,sam9x60-udc" },
>  	{}
>  };
>  
> -- 
> 2.49.0
