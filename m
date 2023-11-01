Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB4DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A8287156;
	Wed,  1 Nov 2023 19:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNNK49xX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C92A86FB2; Wed,  1 Nov 2023 19:52:32 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7680087156
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6d261cb07dcso49509a34.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698864746; x=1699469546; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mNOJP10SqAO5K4yOSust5LjFcBbp1LWaNF5syxuSqH4=;
 b=eNNK49xXb80Ck/ZLzhntDHLgSN+LgrXU++ExtHoCCzV8f+aosF/qOhn4m+axLamR1o
 m76snmIZCpY9OqgwKqRSKIakAZVFxEUsrBchy1iTuLEXZXGHfor+Kdk13N/uBWfrfcOU
 wHoy4LfPkjxgxnAf8VnS/wTwCKd6KleHXSNPpZIjTvfirutKHpraeY6pDHrLLeCzgWrW
 d8l7Ca7Qttu/GgxQAalxf+n4nlRs7TD1PK8VC6v4sBEu+jahQW3eARgbP7wNthJL5YGI
 gq/2ZHbS5qmwm+XbvNbc5JDsBG614jc+jPMPFZQQYlmE/j0kYlkLFxUE4Elgc1Jqqtwz
 T4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698864746; x=1699469546;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mNOJP10SqAO5K4yOSust5LjFcBbp1LWaNF5syxuSqH4=;
 b=XkphuHR0Hw2VqRyOXZGSxFkTyPve88J+cgLrZoSRO0MC/wvr2PsT7BrA8BcAmikp8w
 SPGeqpY8Des6w8mgTNQczbohcj4lI3bWhX/ieiufi4X/vYR6RwvAuJWbHHX4lR6vdD8s
 4NM4R0hoShrhd2m09E+Xyb1xTDWCS03zOMoR8nCMvRxXB2PlIl5UGufXyC1e9uTQzoO9
 tk7BAsRJv9aAfrIJKYwUZhV+w65P40SG7tTFNGCPhRLgQeVvO8OAuRhciWD3KDwySJ5D
 DPSf0Ns1vfTRzDkYt+7qHynXNnKhlGCaUW659L4wB2sSl2XlFqxAA/Dfp1GgDMIO4Uvf
 iFWg==
X-Gm-Message-State: AOJu0YwqMOXe67qewDdIXCcJxMtJCgTw+co2VSnmSZb3ngHSkm5rEJ17
 VqgTRxredzQD03Mm2rDH9G4=
X-Google-Smtp-Source: AGHT+IFYTtq7CWL4n7w2tZUlqcxj10Lx/MKy2gf4s0LUhC4vSyINAEXVIIxsXUBzEF5px/Pxj+B+qQ==
X-Received: by 2002:a05:6830:1546:b0:6bd:c8c2:b70f with SMTP id
 l6-20020a056830154600b006bdc8c2b70fmr15711827otp.34.1698864746096; 
 Wed, 01 Nov 2023 11:52:26 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 hf12-20020a05622a608c00b0041991642c62sm1613925qtb.73.2023.11.01.11.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:52:25 -0700 (PDT)
Message-ID: <35cbad91-485e-5d8d-0b37-688813bb3628@gmail.com>
Date: Wed, 1 Nov 2023 14:52:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] clk: use private clk struct in CLK_CCF's
 enable/disable functions
Content-Language: en-US
To: Maksim Kiselev <bigunclemax@gmail.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
References: <20230905221649.3577929-1-bigunclemax@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230905221649.3577929-1-bigunclemax@gmail.com>
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

On 9/5/23 18:16, Maksim Kiselev wrote:
> In clk_enable()/clk_disable() functions, when CCF is activated,
> we must pass a private clk struct to enable()/disable() ops functions.
> Otherwise, the use of a container_of() construction within these ops
> should be banned. Because passing a non-private clk struct to
> container_of() results in an out of range error.

Yeah...

This is a big problem in the CCF code, where `struct clk` in U-Boot is
both `struct clk` from Linux (a "thick" pointer) and `struct clk_core`
(all the clock private data).

> At the moment, clk-mux, clk-fixed-factor, clk-gate and possibly other
> clocks use container_of() in their enable()/disable() functions.
> Therefore, for these functions to work correclty, private clk struct

correctly

> must be passed.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>   drivers/clk/clk-uclass.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index dc3e9d6a26..542ec41cba 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -649,7 +649,7 @@ int clk_enable(struct clk *clk)
>   		}
>   
>   		if (ops->enable) {
> -			ret = ops->enable(clk);
> +			ret = ops->enable(clkp ? clkp : clk);
>   			if (ret) {
>   				printf("Enable %s failed\n", clk->dev->name);
>   				return ret;
> @@ -706,7 +706,7 @@ int clk_disable(struct clk *clk)
>   		}
>   
>   		if (ops->disable) {
> -			ret = ops->disable(clk);
> +			ret = ops->disable(clkp ? clkp : clk);
>   			if (ret)
>   				return ret;
>   		}

Reviewed-by: Sean Anderson <seanga2@gmail.com>
