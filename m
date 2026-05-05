Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD01FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23EBB84913;
	Tue,  5 May 2026 14:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iN50ZiXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07C7D8491D; Tue,  5 May 2026 14:54:24 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A2684910
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso55596185e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777985660; x=1778590460; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3zfJrXol3Fzxu7u7K3+WYmok/jgDj/2/JfGdEJ2rGB8=;
 b=iN50ZiXkCnS88LPYDAwT0TMX+b/mOpu3fI46OAEVh3Z33srPO//VbCsKq0W69yNmGJ
 JdicX/LTncQqWskuBTIqWuWGZhX3A6kd9kaiFawQBjDmefwCffC72riaCBkkpk5gpNUX
 eNGjhsqEE/TrABVbWuEM4mb7aAOSaITvJm1ZxMFwA0iPxknPcsPncZMwlMeFnyWJus2i
 J61A0DlnqP59sZwANqn1Nykgf0D5BAAU32S7fYS4WyUURiPlzUyUc/cnN4IjVutUEc41
 4nMp9zK9lBIxYiGJr+HB0kNthrnyiplWF3xT8dTbf1SExIfGqgsTVkxpm9L895ILYRSY
 QG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777985660; x=1778590460;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3zfJrXol3Fzxu7u7K3+WYmok/jgDj/2/JfGdEJ2rGB8=;
 b=HZkFYeD+insmcwN2dI9kyJyoVmutcGVHWvYPkceMkSEdVhK4oCobB2bOqxL8DSVAek
 FVS4E/OMrG39Iu4CuP2no6asY73v8RmU07waqa0I1DydKlJzbooAqEoSJyyNonwRz33v
 n+Xm/7IeInMGk0+Q9Tc5x/E9WrZ5WHycH1VlPd50LmIMbke9DRl0C7Rfm7CwmojVX4gE
 QrBftLoPnO/I9irnRteZZ5SCsUuywWTfJDqXjQr9LMT2jpcmKJc9G3e46h6FNwEf6pUe
 vyckeYzYJxuw0OcaQb0dJWpfv2ijsCU4/c0zVwuKOaQ3NtNenlD2Qxb8FyO2wqsM5JUF
 aK7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/q1iZ7qAgY8e58WbZl6b2URjsiyVopqv6LOmDrRmGBaowccMTPN4FxdWij6b/rsa8JEXrs3M4=@lists.denx.de
X-Gm-Message-State: AOJu0YzJhA/Ht4xTkCajcS8KRq1GJZhmP8WWe1wce4NI8vMgjUli3jmH
 I/BTAGEtE6Dtuc5S+/i7JwmjWOv+Y2ONWXdxQ/bXMTIUyxQqoRPdewtZh36Q5iWd+EM=
X-Gm-Gg: AeBDievnNB97BIrMs9vcg6iQf4YHam/CJMjjbqDiriiJiJiL6/KpymYOFEajsD25Xs7
 kmyTAutfCAfxxKSOTEuNpGyThYUKp4ctIE/9I2p4apT89O7+8qGbXGBu0jgNVZ/o7YAnZfgrTWr
 AoYoGO1vOa3EHknD0bvH03gHjSwBab2n+7JRHYAn8lM28GiYp9pXRN1VBpwakPy/y86LRjATDMQ
 NOGhn2wj8Q7erc/w+nh4qzJhu281SCRAP0T/pvPWfhRnTGd85NCjV+mFUapdHN+pJf330WoUOXI
 VYq8YK9tmmwRAzPg2DFyiszaZKK5S4t45izq8xp1ZkoeH+Sx+/Po6F0HzenIEclqmX3FxHx62ym
 YHvXzi3SbjgvZp1cCMVVrVwk7DqacYMFoF01FhPeWJFdoIJy87Ut4VS4JLEPW9KfAJ0v5vyjP4J
 byxTs9Q3qfNJKRN0v8Yhhe/zNTd+xKUenkeEhhbZKCF6FGBGlwpiDMjORYicOc8RzUuHrYJq7xL
 gm3
X-Received: by 2002:a05:600c:4e8e:b0:489:6c22:e081 with SMTP id
 5b1f17b1804b1-48a980fc4ffmr234484125e9.0.1777985660446; 
 Tue, 05 May 2026 05:54:20 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d17ff628esm46782375e9.1.2026.05.05.05.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 05:54:19 -0700 (PDT)
Message-ID: <1c09009b-9e83-4213-a05f-bfd5523ea247@linaro.org>
Date: Tue, 5 May 2026 14:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: msm_sdhci: Use max-frequency to get clock rate
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, loic.poulain@oss.qualcomm.com,
 patrice.chotard@foss.st.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260409070620.3655875-1-varadarajan.narayanan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260409070620.3655875-1-varadarajan.narayanan@oss.qualcomm.com>
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



On 09/04/2026 09:06, Varadarajan Narayanan wrote:
> msm_sdc_clk_init() uses clock-frequency to get the clock rate for SDC
> clocks. However, the DT files seem to use max-frequency for the same.
> Since msm_sdc_clk_init() doesn't find clock-frequency in the DT, it sets
> 201500000 as the clock rate and this results in timeout errors on IPQ
> platforms. Hence, try to get max-frequency if clock-frequency is not
> present.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/mmc/msm_sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 66f3cf2de4f..2e6120f18ff 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -71,8 +71,8 @@ static int msm_sdc_clk_init(struct udevice *dev)
>  
>  	var_info = (void *)dev_get_driver_data(dev);
>  
> -	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
> -	if (ret)
> +	if (ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate)) &&
> +	    ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
>  		clk_rate = 201500000;
>  
>  	ret = clk_get_bulk(dev, &prv->clks);

-- 
// Casey (she/her)

