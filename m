Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8881C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 02:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5587888698;
	Fri, 19 Apr 2024 04:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YejfC3lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3E3885D7; Fri, 19 Apr 2024 04:44:15 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C613B88692
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 04:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-69629b4ae2bso13231766d6.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713494650; x=1714099450; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=977DOjy+/nmLnm/j8vgx0HWOevLZkl5hQczklKkRbfQ=;
 b=YejfC3lbejFZwhk+FVA3+fUPNZogFASMvcJlj5PnCDa/MXN42hwztB5xEz39FfIoCJ
 cAiLanylaggJ8gR526Txkac+DGYJ1RB1yAT8uxVO2jfXGk05rtuTNk69uJK8DzmtlUZF
 XfByGDIQaVEM00kSLkL5LKJezNfVFq/C88mX6f0xVTzCefY9K0L9s8AyHMaR7HSI8PxL
 QPr1wK7g4pniSDY5SWv/VgDikJebWEtjLX9qoDsj57d1tmrFAcOPgU9lDxs5crNZniJY
 adfjwnf/JkZAU7kDLCKg8ixDBnx1MD3kklPkk2zMMwf2xExySPRSYiyuG5gVKuSb3v/u
 9UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713494650; x=1714099450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=977DOjy+/nmLnm/j8vgx0HWOevLZkl5hQczklKkRbfQ=;
 b=VbHYiiZIOSOD3uBzWKyalU+IFXd/dz3rygXhThYmwhaMfTQgaRNMdkoTmwjg9Ey9H7
 d9W44D/qQ67kzIrbjk20pB36bAbAE/Nx9K0jRVuTyqJfVzJJVByV0JCiKdeGdWV2d6uv
 pf+vZVJlrrrpq07bTOcF200R0hj+lu2HFW0I9O0fIqgloWmU0QbObd6jWnpx1iLn5jXw
 09tYZTz302eokPQ85EV5iagTGSueCJhTxOsj2o+Efcqld9upelLMBOf3I7OoBgb9jSu0
 2fOzzdI2hWsJmrLli2T+t4FqJlr8NvBI0l0tB21+CqqBj/nhW7+cr5X7+QeaBgFdyw5S
 GSnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZm069rrZ8ewi5uPILyyIxWDTwL3efMid0hh8vsNZCJIMKI8HCMOSgPKuGmh/o4Iv5K1XzMlcyrU5IhSJe7cK+CS76zQ==
X-Gm-Message-State: AOJu0Yyc7m02ZmRpLDPoUdMFptLF4ks5eOO6fHK3LjjBnj9gEs6gynPw
 GMnvuo/K5kGDBYgyJM6/OqAvV892lwjC1e+E/CB3oXd9srcjGFdo
X-Google-Smtp-Source: AGHT+IEPrjS2narXhDrXYk4p2Lgyy5e8D8VbDoKQzfxZBrU1lfzEw5+qA51aZ0l13c8q2IwO87QdXg==
X-Received: by 2002:a0c:fde3:0:b0:6a0:6249:d99 with SMTP id
 m3-20020a0cfde3000000b006a062490d99mr447723qvu.31.1713494650641; 
 Thu, 18 Apr 2024 19:44:10 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 q2-20020a0c8cc2000000b006a04dacd0e5sm77335qvb.86.2024.04.18.19.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 19:44:10 -0700 (PDT)
Message-ID: <93f82e78-1cf1-623b-56c0-353a84044584@gmail.com>
Date: Thu, 18 Apr 2024 22:44:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/23] clk: rockchip: rk356x: Add CLK_USB3OTGx_REF
 support
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-2-jonas@kwiboo.se>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240413181425.1384357-2-jonas@kwiboo.se>
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
> The CLK_USB3OTGx_REF clocks is used as reference clock for USB3 block.
> 
> Add simple support to get rate of CLK_USB3OTGx_REF clocks to fix
> reference clock period configuration.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: No change
> ---
>   drivers/clk/rockchip/clk_rk3568.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 57ef27dda893..999f48ea4b4e 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -2417,6 +2417,8 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
>   	case BCLK_EMMC:
>   		rate = rk3568_emmc_get_bclk(priv);
>   		break;
> +	case CLK_USB3OTG0_REF:
> +	case CLK_USB3OTG1_REF:
>   	case TCLK_EMMC:
>   		rate = OSC_HZ;
>   		break;
> @@ -2596,6 +2598,8 @@ static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
>   	case BCLK_EMMC:
>   		ret = rk3568_emmc_set_bclk(priv, rate);
>   		break;
> +	case CLK_USB3OTG0_REF:
> +	case CLK_USB3OTG1_REF:
>   	case TCLK_EMMC:
>   		ret = OSC_HZ;
>   		break;

Acked-by: Sean Anderson <seanga2@gmail.com>
