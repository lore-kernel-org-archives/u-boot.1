Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA06CCD1A5
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 20:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4353E82C84;
	Mon, 20 Oct 2025 22:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kml4kZtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B456F831D5; Mon, 20 Oct 2025 20:36:08 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E05B82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 20:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so3485197f8f.3
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760985366; x=1761590166; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8u2Xz1FcETHkVWOtvlIF8kR66g/wndH3FyAlCQ9UUKs=;
 b=Kml4kZtCZODWwFMifRSTZoou+TGoDLfxRfmIZdEF0M2UaXhrxNW5Uowkn5GJzQLpYb
 ua/N1t1bFzFIm52yLkasNeA6m/Gk6JBuJvdwZd23+tZoP6YIjEApZ2vXrkffqs67JFxz
 18OuXbeZyLwzW+JhGj/baqGt3XjtXRrNamQhXMRPSxvzph2cCpNnk2H1xbeBGURH/CvC
 Xv58JNR8Q7JjxtzVJ2NqcuHXvRDB866hf7XkHYRs0/fHHrZZa2bbVSA4gTjQH+rIeJkE
 DGdkrPTB19a6QAdzhi7F6IHIl0VWNfwBbjnysYO7HDwV6QvPOqv90iJdTmvgsRh6rdr7
 fwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760985366; x=1761590166;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8u2Xz1FcETHkVWOtvlIF8kR66g/wndH3FyAlCQ9UUKs=;
 b=SKBKoTYPcx6aIHtCFTr6AZOPvcxJC4yWAR/c13Iefh6p9RaF4KHKNMd3/yrSwLATvL
 sSmYcyOqiYnOv1xf5UOlOAAQf41h5nywv8O7xVwTLHQewxvgUQsEf5rBegqAwuHni9Mo
 j6AlD+wipwfrUsPrZiCkscaNtDCdaFKGK3BYOroVVK8l/viu3HD0dxmDin5W/FWrz9Wn
 UfZM1uzPgwsqE9dzfDwiPNDvasUbT+08jdou5iBb8XLxn8R+upRARnCHQUd9T0uUsM0m
 N2Hj+EFyv7/U59zICQz+0DNz8Pl2aRIsqwQqnMNNEQTVRFGkAo08PHNWGsU4CaNeLEx4
 8MHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyWU6djjadEISCCBZxA/LZQk5djBwIQdmcsptMUMWed8A+2Qznl/soZFc6FfaKMmeXnmthqcw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3XIglfhLyKnvr13jy9hXMA5skjNCI/wC3Fo5BipTSCn/ZJoQP
 1q9pTD8V2ob1AFRttrbv1CBP18y85WZTToHWdAZ9aSjCFxnKye9CdOZWpfsTVLlO9Zk=
X-Gm-Gg: ASbGncsJFEHvyFWlTxpnvJsnMT4/Vmc1j28FMPI4XDDLK1tiEKVf8Dw7ZoZ3XFhaBSe
 0lcWQC6mtuOGyAsdpzYyJqQZeHdVDUBxN/HXWecWuQ376fSM1dLr1NPkZs+dUv6nN7YvQ4haOJo
 YHrWt/EE/kT/1GQvvfM6NL6Sp07753oFdVr/E5v7MLMMCsSPX+BO8H+J4Z91rFnFf+E2veV/C48
 C3TIalpo+6BJW/LN98yPxENqsk98AGDVWkQLXb6TgcMrdgZETfFfWIcEv/MjY/E4mv8JCY1PH5G
 gtKNpOZL7CNUTdt62t+SJxiVeYE9V+P+Onsq2DB1sc9msk/+zhY76Y4CTvTLjLv5cBp660AixyP
 v2tWPIEe7gU847rkBz6RIzSfPDTPEum6Dw1FiAqNUvkjfWBbHRZfM8yzj0K6NnTMeNiBW8UK7yx
 ifqf0YjsMR
X-Google-Smtp-Source: AGHT+IEQDXLaX22cNzm1GX+0wQjr8myb2jfH0btdESnN9/5eXGAmg5GcKjXnf+6U5G8T8gj0Z1OJig==
X-Received: by 2002:a05:6000:491d:b0:427:548:75ed with SMTP id
 ffacd0b85a97d-427054875f4mr12611071f8f.22.1760985365696; 
 Mon, 20 Oct 2025 11:36:05 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9853sm16529831f8f.33.2025.10.20.11.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 11:36:05 -0700 (PDT)
Message-ID: <7f46828a-94b5-4e63-a18c-ec139484275e@linaro.org>
Date: Mon, 20 Oct 2025 19:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Set address mode in SEMPER flash when SFDP
 is skipped
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 venkatesh.abbarapu@amd.com, Shinsuke.Okada@infineon.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
References: <20251020072528.10279-1-Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251020072528.10279-1-Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 20 Oct 2025 22:02:29 +0200
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

Hi, Takahiro,

On 10/20/25 8:25 AM, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> nor->addr_mode_nbytes is set during SFDP parse. Infineon SEMPER flash
> family relies on that parameter to read and write registers. To support
> use cases of skipping SFDP, set address mode in device specific setup()
> function.
> 
> Tested-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 6f352c5c0e2..e382a518a34 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3794,6 +3794,16 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
>  #ifdef CONFIG_SPI_FLASH_BAR
>  	return -ENOTSUPP; /* Bank Address Register is not supported */
>  #endif
> +
> +	/* Setup address mode here, in case SFDP is skipped. */

Under which conditions is the SFDP skipped?

> +	if (!nor->addr_mode_nbytes) {
> +		ret = set_4byte(nor, nor->info, 1);

why do you need this call? Isn't enough the one done in spi_nor_init()?

Cheers,
ta> +		if (ret)
> +			return ret;
> +
> +		nor->addr_mode_nbytes = 4;
> +	}
> +
>  	/*
>  	 * S25FS256T has multiple sector architecture options, with selection of
>  	 * count and location of 128KB and 64KB sectors. This driver supports
