Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4281EC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 02:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1FC885FA;
	Fri, 19 Apr 2024 04:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MNgIHl5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D19DF886A0; Fri, 19 Apr 2024 04:44:13 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02FD9885D7
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4376157292fso7674031cf.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713494649; x=1714099449; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EbZeQ0GBbtNqJHtgc8pBVSAt8Q9eMAnsstIRtZshLBg=;
 b=MNgIHl5tQbOL4/B6DomVZ4xx5u6GDKpE9MajY7sJUKLnrOBE/uAVPxUm7DGAF/iGNw
 z8DlRJLD9I2Ef7lFkwKpnwAAYTFWjdghuy4mNo3zIDtm7vmj8sRDCr7XAeSBv280lw8A
 1mcwwTd6GThzEzsW6PfgOBItkUU7okXSVS10WXG5B4BUhABgtO9jXe0VCxGF6ZvTbXu0
 jAiKJLwfObzdJEBY1pcqG6jIqOihsrhjaWPBrJRsUdATUYQsIoTiXuqIh1szBfOst3BA
 UHAkEAr+FbViQRY5CQoH0uPEFseLVRzpXFsU/6NLyUIAFiJNKu2Mv7tHYDZPdgAU+4+p
 QH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713494649; x=1714099449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EbZeQ0GBbtNqJHtgc8pBVSAt8Q9eMAnsstIRtZshLBg=;
 b=Tds0sYNEVsVZdxvdi5KR3FqCX7C3UfZ2idz5Oz4mfIRCI6J1Mdug8cgMtIXUGihFWe
 jFhLhfrrXGmld3jPW6De2C55Rr9v/0riZm9EsCwCZyQKklpVjEWmgbo+vlfLhk641UzE
 AKMJCI8myEPCcY6GPsUeuofHQBWGhWywOvDD5uYszCsoh4Pwqsh3k2gktvNxF+mNcJkU
 L0cY8v8RVXGNy0TegEAIQ2IKyEbzEEidhEwSx0ViMfaRwANY+G4ok6QV9InVzqZLSDHt
 sphNnl+8G0OJwWkJ4gOVtrEZKu150mRYIySLfmr821kLHmmaxZ+0cIgznll3P+a3N8DR
 dyrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdJj/GqebfAr6jUQEU+VCuU5vDxe/CjkNuGIWA5Xri1YOSMkY4L6cpUWXmgvkBK9kKn4tcaeqebv8+XFhkaPHUHdIC8g==
X-Gm-Message-State: AOJu0YywnI/2rlEvzADh+ZzGJMdeQId5Dvah2divlj0BEAlyb0H6wLru
 pPkcuBp0N7wWghsNos2prceEG7NgzCOtnwwTbqUlo4UcT6++OGnj
X-Google-Smtp-Source: AGHT+IFtwUba/ofpylgGX7bCgzDRilRStS3MN0FQ3P2modi5AR4J4KGopZYBpa/9fJa9uIFJZCjadw==
X-Received: by 2002:a05:622a:4c:b0:437:9f6c:8b97 with SMTP id
 y12-20020a05622a004c00b004379f6c8b97mr1086346qtw.41.1713494648719; 
 Thu, 18 Apr 2024 19:44:08 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d13-20020ac8544d000000b00436ea30b72dsm1221715qtq.35.2024.04.18.19.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 19:44:08 -0700 (PDT)
Message-ID: <161b0b93-eae1-e5e5-0105-b108011a4a66@gmail.com>
Date: Thu, 18 Apr 2024 22:44:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/23] clk: rockchip: rk3588: Add REF_CLK_USB3OTGx
 support
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-3-jonas@kwiboo.se>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240413181425.1384357-3-jonas@kwiboo.se>
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

On 4/13/24 14:13, Jonas Karlman wrote:
> The REF_CLK_USB3OTGx clocks is used as reference clock for USB3 block.
> 
> Add simple support to get rate of REF_CLK_USB3OTGx clocks to fix
> reference clock period configuration.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
> v2: Collect r-b tag
> ---
>   drivers/clk/rockchip/clk_rk3588.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index 8f33843179b0..4c611a390499 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -1569,6 +1569,9 @@ static ulong rk3588_clk_get_rate(struct clk *clk)
>   	case DCLK_DECOM:
>   		rate = rk3588_mmc_get_clk(priv, clk->id);
>   		break;
> +	case REF_CLK_USB3OTG0:
> +	case REF_CLK_USB3OTG1:
> +	case REF_CLK_USB3OTG2:
>   	case TMCLK_EMMC:
>   	case TCLK_WDT0:
>   		rate = OSC_HZ;
> @@ -1734,6 +1737,9 @@ static ulong rk3588_clk_set_rate(struct clk *clk, ulong rate)
>   	case DCLK_DECOM:
>   		ret = rk3588_mmc_set_clk(priv, clk->id, rate);
>   		break;
> +	case REF_CLK_USB3OTG0:
> +	case REF_CLK_USB3OTG1:
> +	case REF_CLK_USB3OTG2:
>   	case TMCLK_EMMC:
>   	case TCLK_WDT0:
>   		ret = OSC_HZ;

Acked-by: Sean Anderson <seanga2@gmail.com>
