Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99F2C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AFEC87C41;
	Fri, 15 Dec 2023 18:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7BJ7KPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779B287C40; Fri, 15 Dec 2023 18:07:26 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B3A87C30
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4260bbc84c5so6052081cf.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702660042; x=1703264842; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t6G4AKjywHYv0511apryJv0mUn1myWphTzsru9LumgA=;
 b=f7BJ7KPIBkf27irnoKTjU7A2Sf0ifuNto/Q/NOebPG6pm3NpCidm/ByxDieaY09eNj
 WHNZY4GdSQ05EufhqhxyetgCYVcbJkS42cNQAZM/+p3ynKTLpL0A/0akGheFegyToPLU
 vf4gc06Yk6aMohNfAJ/WGcVTl6rmHMYGgdzjnJccKFtWdjUsxJFqoA6Lcn7ooeKetdze
 TUAsLLxjeFoa5KjzPVkOxAyjpmPfp4jI5puDAKJlOm4ri/kfu9FR+WPimCl4PNLfZ0X1
 JlqOK4DWfbBnf25q0EYsRt7zb+PQUiTbwH4FZRQ4VWPke52ZcteH5N5+tXC9lGyOCeLV
 jLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702660042; x=1703264842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6G4AKjywHYv0511apryJv0mUn1myWphTzsru9LumgA=;
 b=aAXOrrTJBd/JFd7DnGNaoN6c4lK4Vs3RZbiORgFaK3yt05z/+05PrzCNJESyHGb54n
 /D0u0V9zeRD81woHIImF5IxnhTnYFni1AcDuZfq1RIoymUlYDKPyioKIGTuibEpe2txZ
 gBPzHw099t6KSKuUt34hVw6YEYMvqiis6p/YhotdwBzDeG9T2trvh8Kl++JD6jDxBsL5
 J8PpmBF2tFX4+qR0aRsmRpa5zNKpuj16pAp6NfQmjEAxjzIJpKxL0NkZb4eL6Uf/Y01j
 70ZILYSQ3EkL4011/PrfJFQgToc2XZ8GUjadkd7tJ5n82x+Rl0Q4RsibPSVUA/dYnHat
 HQXA==
X-Gm-Message-State: AOJu0YyWZYff8XDYtIIUyr7ykNCwjMe/8i3Wli5YjvP8qXBXYHaR1MY0
 Kzz/DPQbvL5G2Y1tmfX1DrGDXdujy9E=
X-Google-Smtp-Source: AGHT+IGyXH/QOIt4IwbVdo8IV/qZh55YIP592bXnBr7v2XxXFz7SdG+vFinyt4rw53pfzqO06ZJwvQ==
X-Received: by 2002:ac8:7d03:0:b0:423:9556:526d with SMTP id
 g3-20020ac87d03000000b004239556526dmr16552069qtb.44.1702660042100; 
 Fri, 15 Dec 2023 09:07:22 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 hh12-20020a05622a618c00b00425f0ab0393sm2301143qtb.17.2023.12.15.09.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 09:07:21 -0800 (PST)
Message-ID: <66c7ccfc-9078-5b43-9f53-ded648d50598@gmail.com>
Date: Fri, 15 Dec 2023 12:07:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] clk: get correct ops for clk_enable() and
 clk_disable()
Content-Language: en-US
To: forbidden405@outlook.com, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20231111-enable_count-v2-0-20e3728600b5@outlook.com>
 <20231111-enable_count-v2-2-20e3728600b5@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231111-enable_count-v2-2-20e3728600b5@outlook.com>
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

On 11/18/23 17:10, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> assign clk_dev_ops(clkp->dev) to ops to ensure correct clk operations
> are called on clocks.
> 
> This fixes the incorrect enable_count issue as described in [1].
> 
> [1]: https://lore.kernel.org/all/SEZPR06MB695927A6DEEEF8489A06897396A7A@SEZPR06MB6959.apcprd06.prod.outlook.com/
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   drivers/clk/clk-uclass.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 3b5e3f9c86..3e9d68feb3 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -640,6 +640,7 @@ int clk_enable(struct clk *clk)
>   	if (CONFIG_IS_ENABLED(CLK_CCF)) {
>   		/* Take id 0 as a non-valid clk, such as dummy */
>   		if (clk->id && !clk_get_by_id(clk->id, &clkp)) {
> +			ops = clk_dev_ops(clkp->dev);
>   			if (clkp->enable_count) {
>   				clkp->enable_count++;
>   				return 0;
> @@ -699,6 +700,7 @@ int clk_disable(struct clk *clk)
>   
>   	if (CONFIG_IS_ENABLED(CLK_CCF)) {
>   		if (clk->id && !clk_get_by_id(clk->id, &clkp)) {
> +			ops = clk_dev_ops(clkp->dev);
>   			if (clkp->flags & CLK_IS_CRITICAL)
>   				return 0;
>   
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
