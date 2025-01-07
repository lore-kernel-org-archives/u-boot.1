Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B9AE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB32801E8;
	Tue,  7 Jan 2025 10:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z70nlJQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A338036B; Tue,  7 Jan 2025 10:11:25 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F82E801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so11726743f8f.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 01:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736241080; x=1736845880;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QHwX3trJa7jgkS3VQl4Zepy5PXqG2pBYbzaRyaWIxdU=;
 b=z70nlJQP60Wvs94wKngYXdt2+QRd/ln4elbqA1gPQz5U9w8xILDeqEI47K75JlC1WQ
 zvPyfOJSCamUe/BV93qizQ3qIXTIPkLlRSr0KpovvgcMx1OkjpkadwGw9hobxt+7Kv25
 T30ASmv7aQ3MsLHHDoG6s1dHI0M89riz5NnbeZfh3BPXYAVOobCRdggg7M1p5Eflh876
 7ZtrqGV7VRP2rqpue9UHb/MdPoKg+wzpvUvYEvCSyZIV9g1iNbycDQPBQ+PMF6uTDYXH
 agJ/ADZBB0el3R6bJs1Vvvuq+CVEzDubLGImt8uc47BcqK5KOVTJjEPzxFqA0wtDxLKD
 yoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736241080; x=1736845880;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QHwX3trJa7jgkS3VQl4Zepy5PXqG2pBYbzaRyaWIxdU=;
 b=cKSdu7vlGFbLt1HN+j4O86WSrx0gzbm/enGs3AkrUrHFMxpir5zC2uTW+obSkRqYX8
 pyMslNEFqLgf9QTjT3iOCb2scJvb4tCxgVLIDq1kcnDgYBCFgItGo5fQM/I7u/PlQ2WB
 O0qnBWwTnwo0lyj3hakRIZPqM1YxA+6qIUxDI6IFnKKtSOPucNFAYvWGo6HUomgIKir6
 WZfe8jv85pt8WN+SgOzAYqUiT6PYH81q5LaMFCmdoh4tBh83QlNCaEzeoWbPfQrOeNFD
 rVf1xOuCqGHLXxKzj0ISXd1mfpk6VlYvTntSootOI7KOqlHCFeiEg/JyLtQjTjyxnuJb
 xVZw==
X-Gm-Message-State: AOJu0Yx7Jd1jzx9tCvsfh3yL8zZySk1xRd1SonnzPNTVCu1r68dKJUgR
 BJYC+3pdZoX3PGQNzTWYXTjSy/DDyRlWZTMdxIsx43W4vYpIMfrMdUr+x7d0Yi0iZfzBp17MMlJ
 9
X-Gm-Gg: ASbGncvN+QW98hgMi33jM1P53YWjMF+MDdcABiIX/zJ1BJ7+bt4ppUVl0H1iL3KP3dI
 4Tp5PB+kBSJmS+76zvfdiadtZzXhMdnvV7aHl0ZApQPyIfrP3A/qRa2v0QaFq/XOOby68Nu8QeB
 TKmh3/r4TcbwZu39fAwQfKX24orIxiINLAmwoXOuGU0HJZfg7pZvDDcgvTnqTTfWPM1W74gIUKT
 u+lGHTU1z36zyUV6e5GWr2K8toCevFry9U7UfSgc1F2lZtpueF84BtJ8kX/aOA6Pg==
X-Google-Smtp-Source: AGHT+IHKDJWttC3g3S3Cp3K6WdsqoblFGqgM/xPYBlYHWJNERiMLGabcIQWxZnwa2tQhyTEzDgQT0g==
X-Received: by 2002:a5d:598d:0:b0:385:fa3d:1988 with SMTP id
 ffacd0b85a97d-38a221e2f07mr51606449f8f.8.1736241080485; 
 Tue, 07 Jan 2025 01:11:20 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4b0sm592301795e9.35.2025.01.07.01.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:11:20 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com,
 junhui.liu@pigmoral.tech
Subject: Re: [PATCH v3 2/8] usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
In-Reply-To: <20250104-dwc2-dev-v3-2-d4b2bc1996e4@pigmoral.tech>
References: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
 <20250104-dwc2-dev-v3-2-d4b2bc1996e4@pigmoral.tech>
Date: Tue, 07 Jan 2025 10:11:19 +0100
Message-ID: <87v7urc7k8.fsf@baylibre.com>
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

Hi Junhui,

Thank you for the patch.

On sam., janv. 04, 2025 at 11:37, Junhui Liu <junhui.liu@pigmoral.tech> wrote:

> The ULPI_UTMI_SEL bit in the DWC2 driver was set incorrectly. According
> to the datasheet [1], this bit should be set to 0 for UTMI interface and 1
> for ULPI interface. The existing code had this logic reversed,
> causing the interface selection to be incorrect.
>
> This commit corrects the ULPI_UTMI_SEL bit setting to match the
> datasheet's description. Referencing the kernel's code [2] also confirms
> this fix.
>
> [1] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf#page=30
> [2] https://github.com/torvalds/linux/blob/v6.13-rc3/drivers/usb/dwc2/core.c#L1106
>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/host/dwc2.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
> index b6c8b3d5a6bdf375f1adeb106d4832d92307f0db..609de18faa3abc5f4ecb0c23cf3590966bad7992 100644
> --- a/drivers/usb/host/dwc2.c
> +++ b/drivers/usb/host/dwc2.c
> @@ -402,20 +402,22 @@ static void dwc_otg_core_init(struct udevice *dev)
>  	 * soft reset so only program the first time. Do a soft reset
>  	 * immediately after setting phyif.
>  	 */
> -	usbcfg &= ~(DWC2_GUSBCFG_ULPI_UTMI_SEL | DWC2_GUSBCFG_PHYIF);
> -	usbcfg |= DWC2_PHY_TYPE << DWC2_GUSBCFG_ULPI_UTMI_SEL_OFFSET;
> -
> -	if (usbcfg & DWC2_GUSBCFG_ULPI_UTMI_SEL) {	/* ULPI interface */
> +#if (DWC2_PHY_TYPE == DWC2_PHY_TYPE_ULPI)
> +	usbcfg |= DWC2_GUSBCFG_ULPI_UTMI_SEL;
> +	usbcfg &= ~DWC2_GUSBCFG_PHYIF;
>  #ifdef DWC2_PHY_ULPI_DDR
> -		usbcfg |= DWC2_GUSBCFG_DDRSEL;
> +	usbcfg |= DWC2_GUSBCFG_DDRSEL;
>  #else
> -		usbcfg &= ~DWC2_GUSBCFG_DDRSEL;
> -#endif
> -	} else {	/* UTMI+ interface */
> +	usbcfg &= ~DWC2_GUSBCFG_DDRSEL;
> +#endif /* DWC2_PHY_ULPI_DDR */
> +#elif (DWC2_PHY_TYPE == DWC2_PHY_TYPE_UTMI)
> +	usbcfg &= ~DWC2_GUSBCFG_ULPI_UTMI_SEL;
>  #if (DWC2_UTMI_WIDTH == 16)
> -		usbcfg |= DWC2_GUSBCFG_PHYIF;
> -#endif
> -	}
> +	usbcfg |= DWC2_GUSBCFG_PHYIF;
> +#else
> +	usbcfg &= ~DWC2_GUSBCFG_PHYIF;
> +#endif /* DWC2_UTMI_WIDTH */
> +#endif /* DWC2_PHY_TYPE */
>  
>  	writel(usbcfg, &regs->global_regs.gusbcfg);
>  
>
> -- 
> 2.47.1
