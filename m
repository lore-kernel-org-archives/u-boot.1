Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185AAC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 07:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 723B98069D;
	Fri, 17 Jan 2025 08:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LOH9NAZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F698806FB; Fri, 17 Jan 2025 08:03:59 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED66C80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d9b6b034easo3616026a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737097436; x=1737702236; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V53o2TQbowLpvXuRbLTk4T64C8D+6/ERfyxJZnwFIC0=;
 b=LOH9NAZF1oiSTMwUdY0OWJhgMd4FTnDAtB3juO9ivjIga2mFETUcDQIykEkfiopQ+O
 ooC4+lhfnqY0jXfYqN7W1UvLmkGOAYgpnKOVgeu5dlN//uLvg3whIz1r3groY724gmOn
 Thl7dMbuxaWlyZb1sfw2n027D/aRc3eyVBco0cHM7EXVdMKG7GaGVvr4csIhKSNYnlup
 dom1NhglyTWlscyrYGn2Avyc3LgPplEt4Jpwn/wXB3a+Eb5utG6lm+yhkkUEaQgS4gEg
 OO8EliCV2M8OeIt9ia+qLQ8CnJ+ciSaV/uSnLakcnI9MbGHmxFcZQhDa87Fzy+8x2YL+
 FFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737097436; x=1737702236;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V53o2TQbowLpvXuRbLTk4T64C8D+6/ERfyxJZnwFIC0=;
 b=DcAPnPY2CaQpGkyOp6dpMyQySIs4cVX2IPb8onjjS+Wyk0mmr0HxMmWeza6FFN+SaP
 ewNSWw7iYM3jRW0eMA1tnlxZqqUn6d2OAfFyyP1UUNdlDz5MOHfzc+JwAlbMjJvsHkms
 vWJ4N+FubP39f90R1rI9brGWR1XoxkjoeNHx0x826pXm/sIo1LfKsJkPHfymLq/w2Eq7
 gbrUkP+mVXnvC4vonDWYo9/cE+aZkKJ3E8lt+jkWUB+hPL72fg9yx3erBlvgOUeoOvVd
 +VZbYhwCzQfDAKlkq71ic2SO75vV8Ww4ukDvvUd2UI/E4rhxI+0hhVUFSj8oNmcHnLrZ
 IDRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIUfAhyiuVbr55md2nfsp3LAPSfpllPngUefQmHv5xhMvFYrBGNK1KheCXz2dB1zlSRWWyFIM=@lists.denx.de
X-Gm-Message-State: AOJu0YwFIqrB8swQ+MXJhf7FaGj8YsrupFrekXsmwSEVaMZnncs+9yQO
 S0OxXgUG/qTw4pHW0S45MHtf8QxF4o2HBIR5iy5TjOVCG8ZpV6LBS9iw8H9W6A7GmRO2UzAiexa
 L
X-Gm-Gg: ASbGncuPTHYal5+MSZNsChNN2dmeb7l7HyTda+YclzrMSir2kqgEJH2GGbqWpchqVlX
 4dM2+S8OhfmzumMq2p8kFrpsHO1gVojiqENB9Yu0qAOBGRXDilcmM4dpzQN9CXJ/d6JDzAeM0Ql
 t0/9BBBG+2A23mm57AEh79E1m6MKX1FVnimMlxO8f7YZZda3qWMhKMjWt2xTsdi/YAYU02Pp7hU
 aPi5bZQfQH+sMgghVI3Mcr6PLnkKNvpf52nOfgBRxsDyi9Z83q6HvZJV0vF2tXgqeF6zNbUZ+ft
 DJfGlkkPLMFyly2+m0zIKyizXM8vUD3yAYlCvxw=
X-Google-Smtp-Source: AGHT+IE+FmbQyUk5oPA7uirDZEWrkDYOD0L41gJTNV0IEZxoB48cRtCRK/NvSOXEv1tK9Xt7ZXybaw==
X-Received: by 2002:a05:6402:5206:b0:5d0:f904:c23d with SMTP id
 4fb4d7f45d1cf-5db7db1d558mr1546259a12.28.1737097436286; 
 Thu, 16 Jan 2025 23:03:56 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm1037247a12.1.2025.01.16.23.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 23:03:54 -0800 (PST)
Message-ID: <f08b4610-b4d7-477a-8eda-709fdb67b5c0@linaro.org>
Date: Fri, 17 Jan 2025 08:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: Fix timeout check
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, ni@konsulko.com,
 mkorpershoek@baylibre.com, neil.armstrong@linaro.org, u-boot@lists.denx.de
References: <20250115062044.3834433-1-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250115062044.3834433-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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



On 15/01/2025 07:20, Varadarajan Narayanan wrote:
> dwc3_core_init loops 'timeout' times to check if the IP block is out
> of reset using 'while (timeout--)'. If there is some issue and
> the block doesn't come out of reset, the loop will run till
> 'timeout' becomes zero and the post decrement operator would set
> timeout to 0xffffffff. Though the IP block is not out reset, the
> subsequent if check 'if !timeout' would fail as timeout is not
> equal to zero and the function proceeds with the initialization.

Nice catch, this is a nasty one.
> 
> Use poll API instead to resolve this.
> 
> Tested-By: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> v2: * Use poll API and remove the timeout variable based loop as
>       suggested by 'Marek Vasut'
>     * Drop 'Reviewed-by: Neil Armstrong' as the patch has taken
>       a very different shape
> ---
>  drivers/usb/dwc3/core.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a35b8c2f64..847fa1f82c 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
> +#include <linux/iopoll.h>
>  #include <linux/ioport.h>
>  #include <dm.h>
>  #include <generic-phy.h>
> @@ -587,7 +588,6 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
>   */
>  static int dwc3_core_init(struct dwc3 *dwc)
>  {
> -	unsigned long		timeout;
>  	u32			hwparams4 = dwc->hwparams.hwparams4;
>  	u32			reg;
>  	int			ret;
> @@ -610,15 +610,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	}
>  
>  	/* issue device SoftReset too */
> -	timeout = 5000;
>  	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> -	while (timeout--) {
> -		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
> -		if (!(reg & DWC3_DCTL_CSFTRST))
> -			break;
> -	};
> -
> -	if (!timeout) {
> +	ret = read_poll_timeout(dwc3_readl, reg,
> +				!(reg & DWC3_DCTL_CSFTRST),
> +				1, 5000, dwc->regs, DWC3_DCTL);
> +	if (ret) {
>  		dev_err(dwc->dev, "Reset Timed Out\n");
>  		ret = -ETIMEDOUT;
>  		goto err0;

-- 
// Caleb (they/them)

