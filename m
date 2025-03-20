Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA22C36002
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 09:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1AA810F2;
	Thu, 20 Mar 2025 10:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rgIqIlNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E9981101; Thu, 20 Mar 2025 10:47:09 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5CB809D4
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 10:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so387143f8f.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742464026; x=1743068826;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3Y2jjwyTsqgN6SOZyxRUpwXHB0DczGBquKsfKwfk78=;
 b=rgIqIlNqL1gU3phjSoDG550m3GOeQKzIeC44KBLBn8dm8gO1YulKfxHXiEKuyi9OnA
 WgGHTO/XNxNFCrRyJg0K/eNtXjTDBhiv1li8ezPZjXtIhwZh6Q83OvE+N2+Q6Ll1K9Lx
 2Ir9G/PJ4Zyru0kYr4Dw3OXqmgeW61caVRVFwB7QUb8W1mbm8UClYHCxuiaQ1OwMUPjB
 dNuuZIAmFR5AmZ21+qGsS+oLkOr3D5lGFuTKaO0CK69jasxCJaAsVPjHolrRtf4iZ4zK
 5xMIZtI4BFJBmwWZEDbjV5viszJJJgGC5+gpSsJPJhoxVwAZAxN4iMHoct80rdDaTuER
 gzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742464026; x=1743068826;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3Y2jjwyTsqgN6SOZyxRUpwXHB0DczGBquKsfKwfk78=;
 b=PsihYKpYlU8YDU9Bi4tyxN4vpmczQq+VGoHUffbpqQe/0avaV1cwvTdy8N4umuQLYL
 FQMoj/Hey7faOOwa6bBXzgLFsgeY7rR9gmC/zOt3olQ48qGIP53NuXDm818OVn/fatuL
 gyz6FuePkxmH3NRmmx20cxgPZqD5mzK0WwEXju00BHTDpet7lEVqwT1+807UMEGKWPJO
 0WwHkxm1JXkjOPgu6KRVczGDpV9EgsgGbwMiDHgmeHEX8qG4U37bBbkNKms88kdeweW0
 WNhHNJ/R9TFVbpBb1xhJgwLfNM2R7tPibQ9opYyJTqyOkQFsokEkTpWuJ/SSnWhg8im/
 b23A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIRWZCBVq042AIH1VODZnagGjIorwCk3ZL4oVkopR2g37JM5c7GgcHbI6sOZD0OznQHIZsMN0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3kOSOfLYaGdtPNkatftY+IHPdkV/Cju/WhAZDkxqkjyM5I+OM
 ZfmLdsUxHsjCD4gPUxquM8zi/O3FZxF45SnNT1xM3iaB2U+TPAbJDv+oWKLBqbQ=
X-Gm-Gg: ASbGncsaCoqCj3ISc7V/T94w/j2Juna8eL94W590x/bnJDP6MFmlEoFb14O7pkV+xhC
 2UI3RNQ/tc4FZg8twUSo1SIu2tlwX1cpBFndZh0XnWCM+Ok/dLoLf2HmjQIKKp4clUmMyzSzxCz
 BlhsM5r6y00yMm1NYP/dbwD6GFIDPlhoeOxEu8eNHQHD0n8vgRMiy50vYlECuKe+O5MvpGs9JIQ
 /ql8beelMezJwH+e429e0CSC5krqMr9rTct3VwmFQ40DbSYjaqYK36kzPQgXRGRqu013opJ2FoQ
 rLWLxMBSUDNQQn/PC32n4RpY2z4ziOCCr3Y356+6fCxBHS5N
X-Google-Smtp-Source: AGHT+IEvKpLniv4dRxOeZm00WNVR7dGLKmClOKwfzmTbdHf+I+2FF3MuddVV4iBjVAwyUcrZW1RWEQ==
X-Received: by 2002:a05:6000:1787:b0:390:de33:b0ef with SMTP id
 ffacd0b85a97d-399739d3dbcmr4326523f8f.30.1742464025984; 
 Thu, 20 Mar 2025 02:47:05 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm23079812f8f.82.2025.03.20.02.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 02:47:05 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
In-Reply-To: <20250319220805.219001-1-marex@denx.de>
References: <20250319220805.219001-1-marex@denx.de>
Date: Thu, 20 Mar 2025 10:47:02 +0100
Message-ID: <87a59gdofd.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On mer., mars 19, 2025 at 23:07, Marek Vasut <marex@denx.de> wrote:

> The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
> it crashes. This is a result of the previous hard-coded EP setup in
> drivers/usb/gadget/epautoconf.c which did special-case EP allocation
> for SPL builds, and which was since converted to this callback, but
> without the special-case EP allocation in SPL part.
>
> This reinstates the SPL part in an isolated manner, only for NXP iMX
> SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.
>
> Fixes: 1918b8010c32 ("usb: dwc3: gadget: Convert epautoconf workaround to match_ep callback")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: This should go into master as a bugfix.
> ---
>  drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Good catch. I'll submit this to u-boot-dfu (for master)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index e5a383407a2..477ecd02098 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1631,8 +1631,25 @@ usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
>  		return dwc3_find_ep(gadget, "ep1in");
>  	if (usb_endpoint_is_bulk_out(desc))
>  		return dwc3_find_ep(gadget, "ep2out");
> -	if (usb_endpoint_is_int_in(desc))
> +	if (usb_endpoint_is_int_in(desc)) {
> +		/*
> +		 * Special workaround for NXP UUU tool in SPL.
> +		 *
> +		 * The tool excepts the interrupt-in endpoint to be ep1in,
> +		 * otherwise it crashes. This is a result of the previous
> +		 * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
> +		 * which did special-case EP allocation for SPL builds,
> +		 * and which was since converted to this callback, but
> +		 * without the special-case EP allocation in SPL part.
> +		 *
> +		 * This reinstates the SPL part in an isolated manner,
> +		 * only for NXP iMX SoCs, only for SPL builds, and only
> +		 * for the ep1in interrupt-in endpoint.
> +		 */
> +		if (IS_ENABLED(CONFIG_MACH_IMX) && IS_ENABLED(CONFIG_XPL_BUILD))
> +			return dwc3_find_ep(gadget, "ep1in");
>  		return dwc3_find_ep(gadget, "ep3in");
> +	}
>  
>  	return NULL;
>  }
> -- 
> 2.47.2
