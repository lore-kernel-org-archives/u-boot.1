Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B26C10F1A
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 02:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86E738846E;
	Wed,  8 May 2024 04:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715133766;
	bh=GW4Qpap7sGTAWhbjvTbzOFp6gvFFb1mw3j8LAdpCbzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xgnQ/XPAN3uVMFjxyl9QTMvRdWO5m9XG/edi+elrfYVwQYXZCE+sGZ4/zSfiffKUw
	 2rpu5O/ufrLaJF0hAxXA6TASjjEOJlOjw1s2O9NdvjB2bGW9x4ev7ZeeAkpMO6a80l
	 M+YE7AT0eMKsof39JApQFQA2krdyoI58nbs1zC4QunVFp05jbc7WVt2SeGq9FmDCgY
	 BysIg5DacSNcxH/oxYYWoCuW9Agy2oB5ZxvnxJAfUzw7knMBoTV9/BpWLM9o9Z8Qme
	 0s/IVF0G672yXh9AqGT8+bUzVlvWhlQgChzCPbMy03+B0M3gtSKYioySf/30pP5mu2
	 fFwzCTYEUTmVQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EFD1388436;
 Wed,  8 May 2024 04:02:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715133765;
 bh=GW4Qpap7sGTAWhbjvTbzOFp6gvFFb1mw3j8LAdpCbzc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H8o1qbT7bh45NKxeOJiMPjV302XgJ1pR3HueCuXveH9S3plQ6IZN5ZRJmxDWEQoSE
 SjLKvWT0vYmEcI3Jq2U5NLndzArX/k8VBD4lkW6n0S+0F1ilEBkNXlkNV9UpXWAL8H
 RJaivOGkmj7NMX36YE98QBI8kEdallKcHIo9qkAthdqdfghohPAn62AYr8e1+HKqNL
 W7Yg43PNX3R83gDu5K7SoQzjNSZ2xZNtyFNue5OWX1EW+88mqZjYoP6CqwZ5sSJAUk
 sRqbi952H1T6fVXwgnXkIdP5OGYZjfdg/cbqtgIAvHRcWu4P2iaeTocAUscyBy8H2t
 6XC66FYSZYHJg==
Message-ID: <31c00a3c-c757-4cc4-9c05-363f1cbae746@denx.de>
Date: Wed, 8 May 2024 03:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/7] usb: cdns: starfive: Add cdns USB driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
References: <20240504150358.19600-1-minda.chen@starfivetech.com>
 <20240504150358.19600-5-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240504150358.19600-5-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/4/24 5:03 PM, Minda Chen wrote:

[...]

> +static void cdns_mode_init(struct cdns_starfive *data, enum usb_dr_mode mode)
> +{
> +	regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +			   USB_MISC_CFG_MASK,
> +			   USB_SUSPENDM_BYPS | USB_PLL_EN | USB_REFCLK_MODE);
> +
> +	switch (mode) {
> +	case USB_DR_MODE_HOST:
> +		regmap_update_bits(data->stg_syscon,
> +				   data->stg_usb_mode,
> +				   USB_STRAP_MASK,
> +				   USB_STRAP_HOST);
> +		regmap_update_bits(data->stg_syscon,
> +				   data->stg_usb_mode,
> +				   USB_SUSPENDM_MASK,
> +				   USB_SUSPENDM_HOST);

Can you deduplicate thse regmap_update_bits at the end of this function 
? Set a variable to USB_STRAP_HOST and another to USB_SUSPENDM_HOST 
here, set the same variables to USB_STRAP_DEVICE/0 below, and then call 
regmap_update_bits() with these variables at the end of this function once.

> +		break;
> +
> +	case USB_DR_MODE_PERIPHERAL:
> +		regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +				   USB_STRAP_MASK, USB_STRAP_DEVICE);
> +		regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
> +				   USB_SUSPENDM_MASK, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +}

[...]
