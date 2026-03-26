Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5A1106F304
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0923D83CF5;
	Thu, 26 Mar 2026 09:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LqeGvP0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B4A81E18; Thu, 26 Mar 2026 09:57:19 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE79383CF5
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 084BF418FC;
 Thu, 26 Mar 2026 08:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C50C116C6;
 Thu, 26 Mar 2026 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774515435;
 bh=f9TTZfHRURdfI9Sdi+Bp8XlFdjIP1ivCmDk0MbYZp+4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=LqeGvP0TgQhHHQKkMorfHBv/suYDFf7abIYOw+1dU4Zuu3Zw11RR4rSUrs/MHED2Z
 araWlfbNPadF+RmGouhl5Mely0lDGyoUldrOTMXBBEXlqaptPndJA3oVk+DQtN90Lu
 cB24W28fWjKUVGWmSxEM/s5wxjw7loPQRhhd0YVVufKhX6+WW1XCbj9XsBzLeB/2/i
 ye8DJlyohHQf0FqpayiDyVIxliLFznToawLFXmv5m7ApY82s1jaEqXB5mSr+eJL1ln
 RHl2NCTOAFLLWG89yXMInjDi9ZEHJEnKGSrbx12xeYPa0jr2JRGkBfHGGwVS/R7Y6V
 LhcTyPXHPNu3Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut
 <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH v2] usb: gadget: Move USB_GADGET_DUALSPEED to be
 slightly more visible
In-Reply-To: <20260323143253.2272167-1-trini@konsulko.com>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <20260323143253.2272167-1-trini@konsulko.com>
Date: Thu, 26 Mar 2026 09:57:13 +0100
Message-ID: <87tsu3ge8m.fsf@kernel.org>
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

Hi Tom,

Thank you for the patch.

On Mon, Mar 23, 2026 at 08:32, Tom Rini <trini@konsulko.com> wrote:

> As exposed by "make randconfig", we have an issue around
> USB_GADGET_DUALSPEED. It is possible to select this symbol (via
> SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency due to
> how this symbol is placed today. Move this to it's own section of the
> file guarded by USB_GADGET || SPL_USB_GADGET.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v2:
> - Implement this move as suggested by Marek instead
>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
> ---
>  drivers/usb/gadget/Kconfig | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index baa2eb61ea33..2f79840df18c 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -179,10 +179,6 @@ config SDP_LOADADDR
>  	hex "Default load address at SDP_WRITE and SDP_JUMP"
>  	default 0x0
>  
> -# Selected by UDC drivers that support high-speed operation.
> -config USB_GADGET_DUALSPEED
> -	bool
> -
>  config USB_GADGET_DOWNLOAD
>  	bool "Enable USB download gadget"
>  	help
> @@ -372,3 +368,11 @@ config SPL_SDP_USB_DEV
>  	  so it can be used in compiled environment.
>  
>  endif # SPL_USB_GADGET
> +
> +if USB_GADGET || SPL_USB_GADGET
> +
> +# Selected by UDC drivers that support high-speed operation.
> +config USB_GADGET_DUALSPEED
> +	bool
> +
> +endif
> -- 
> 2.43.0
