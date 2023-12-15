Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A15DC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807E787C30;
	Fri, 15 Dec 2023 18:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U638j9vn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3437587BB0; Fri, 15 Dec 2023 18:03:21 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F09387C2D
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4260bbc84c5so6019131cf.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702659797; x=1703264597; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Wqk+bhtTkbOIufo8dVIIT/qVdDgB4EUoBInJF9+RYo=;
 b=U638j9vnvQxCXOjKFegn5qp6qv+1mkQ9bkvkoLXgOMFVeT7+GwK5F2lM38QFm+LYGq
 p5vli3sbCrTYnGbNDvkZbTLgF4ceK9FoO19VTQZZ0AGUqVlYkZBQzboAqBC9NyjF+Ueq
 umXKcQjVyyq++2K9dyA03BnVNmAHgTjkkdxP5RrtiUH813e12PcqBEAqRrxEjibPdmJ9
 V0xM2fssM+w/AKkI1YcLilPPg8zfkeP82TTD6LI6qgbqcm8sEiHJmiY4TC7/qQxaDIb2
 I2+Nd2Vyt8wb2I+9X/z85tActK6gr/cGzE0YBZawLaGe8B36s5Fvlq0Y+kDmZlusVK0V
 zouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702659797; x=1703264597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Wqk+bhtTkbOIufo8dVIIT/qVdDgB4EUoBInJF9+RYo=;
 b=pbcHPa/RQnNI/3/GoRqPrIQXvPSlFHnGnD0e63O4b5icAogyEChP88sm+XehuJfIFt
 7K/eTFxC17IHvnSWUNr2kbhiiZpftYJmbeMbuZi7D6uk+33Q8hv8OGY6753FezW15P6X
 gwf/c2tcj1fyUJ6oml6cEWr4psvpBKuGKUyySfROydASOINl3W81P9iH9xax9KvefMr9
 i5FyBDFmk2Xcpp5TLjbHs4WuFtll1dO6VA7reG3ztR10Kuc1tbfbhN1I+llTurSRDhUr
 oFDd27bZxLESpxlsdklycStlFL7y2vmTuAWM+91axEa4eGZ3pkqCMujuspCZjTk5GAHq
 elWA==
X-Gm-Message-State: AOJu0Yz5x0O9aDMTT23wcO2YUlu4FmnOqJ412YFj8sivfKYU7NQTOHi/
 ycJsC1IzfuRK8NmXM87Tvqhyb5ROHK8=
X-Google-Smtp-Source: AGHT+IEPAw/K5Zgxvk9qdi/LYXq5ddG7hYa94Q2ObOm2DTcnbDiyfma+/MOMRX7+fWYhr6WMaKSc4Q==
X-Received: by 2002:a0c:ecce:0:b0:67e:fffa:b73d with SMTP id
 o14-20020a0cecce000000b0067efffab73dmr3754477qvq.120.1702659797147; 
 Fri, 15 Dec 2023 09:03:17 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 l3-20020a056214028300b0067f14aeaf46sm920541qvv.25.2023.12.15.09.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 09:03:16 -0800 (PST)
Message-ID: <64e1bd9d-d462-77ce-1d02-ecb50e34b091@gmail.com>
Date: Fri, 15 Dec 2023 12:03:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] clk: Check that composite clock's div has set_rate()
Content-Language: en-US
To: Igor Prusov <ivprusov@salutedevices.com>, u-boot@lists.denx.de
Cc: kernel@salutedevices.com, prusovigor@gmail.com,
 Lukasz Majewski <lukma@denx.de>
References: <20231205232334.2931-1-ivprusov@salutedevices.com>
 <20231205232334.2931-2-ivprusov@salutedevices.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231205232334.2931-2-ivprusov@salutedevices.com>
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

On 12/5/23 18:23, Igor Prusov wrote:
> It's possible for composite clocks to have a divider that does not
> implement set_rate() operation. For example, sandbox_clk_composite()
> registers composite clock with a divider that only has get_rate().
> Currently clk_composite_set_rate() only checks thate rate_ops are
> present, so for sandbox it will cause NULL dereference during
> clk_set_rate().
> 
> This patch adds rate_ops->set_rate check tp clk_composite_set_rate().
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
> 
>   drivers/clk/clk-composite.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 6eb2b8133a..d2e5a1ae40 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -66,7 +66,7 @@ static ulong clk_composite_set_rate(struct clk *clk, unsigned long rate)
>   	const struct clk_ops *rate_ops = composite->rate_ops;
>   	struct clk *clk_rate = composite->rate;
>   
> -	if (rate && rate_ops)
> +	if (rate && rate_ops && rate_ops->set_rate)
>   		return rate_ops->set_rate(clk_rate, rate);
>   	else
>   		return clk_get_rate(clk);

Reviewed-by: Sean Anderson <seanga2@gmail.com>
