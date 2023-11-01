Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC6C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBBD48757D;
	Wed,  1 Nov 2023 19:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETa2ypCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C366E87524; Wed,  1 Nov 2023 19:19:33 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D758757D
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b2ea7cc821so83131b6e.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698862769; x=1699467569; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JxkQkZ/OVvikXq5CZhpTznQe7u8zzTMG1HW2DU3JrIc=;
 b=ETa2ypCmVCGudp0j8aWzyzNTCcZhzH1HlvObSIcpe9rpuidKQlkWZgIhAs7CmIWWi3
 ZP5U5OFpUsOptBfx3fRtXfqMYGDfjEZMG6qQbzqubOwFBNECfgkOpfQJjVHp/OGFWuOi
 QNG0VugY9BlO9iSKDe1G14v3yXwUikMbdNQJUqBRtLDRCTu9s2JI+kX5ZTuyTz/PFjSx
 SreBWGneo7dFsPcdb5XV6seMoxrZbO2qIIKLd0DsW0EAlxU1skQt44J63MTq3MJD1/FZ
 UYzsrOdBQi83hA+vvyuPV53PsGDCIqNTmVehsqJ85hOiywf7BeqfV+kuoerNJUmJEeVB
 nRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698862769; x=1699467569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JxkQkZ/OVvikXq5CZhpTznQe7u8zzTMG1HW2DU3JrIc=;
 b=dgIL3NQHiOH4wJPZTdQhot7VjJnUDplGSx2odZ+kLXj56A9+YjdAvNgaJQsDBMOn3Q
 7wLITFwLou1LsvjUU+aeTNR5Xc6rV1ZPIVgVik40Nubbk84xuSzWaAx/g2dvCW14jLLG
 PHx6rDQQuRNCdK5fCy58BMKB4k5vDsl7VZNbsQOa8D7WjX8YT1r/1rUw6KC8bQxLWQfz
 wSBWFG8H7KKRkYItabmH7QYgibdHvsOkOr6WDibTNp6zjwBLpPgfW0nAW0Ys8LPWA7qY
 gSd/YjNU6HiJ3hPE3TaXBrwrk+4seKw5VQpz2xzN7R1mZHOfII4LEhinTTMD0teVANJv
 yRDQ==
X-Gm-Message-State: AOJu0Ywa0Z8IX3JLwdCRuEZXdqTxj2/TB5P+R2wdZLRwIIJ1aZJ4cPdf
 pT0d7Ul0d+xV+GDtHUXXcKo=
X-Google-Smtp-Source: AGHT+IHh0m4p8h/WjiKXn+EalOxQt6fOa7rcNT5NQgOiC9+1OCZ2CiLjfYEdgBmYrC4N1kQVvQdWjg==
X-Received: by 2002:a05:6808:f89:b0:3b2:e9ae:5d4f with SMTP id
 o9-20020a0568080f8900b003b2e9ae5d4fmr19941173oiw.24.1698862769137; 
 Wed, 01 Nov 2023 11:19:29 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 m22-20020a05620a24d600b00767d572d651sm1645829qkn.87.2023.11.01.11.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:19:28 -0700 (PDT)
Message-ID: <f996c4ea-81c6-815e-cab1-2d0b09b22135@gmail.com>
Date: Wed, 1 Nov 2023 14:19:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 5/5] clk: ccf: call clock provided ops directly for
 endisable()
Content-Language: en-US
To: forbidden405@outlook.com, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-5-49ec18f820bf@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230818-clk-fix-v1-5-49ec18f820bf@outlook.com>
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

On 8/17/23 13:04, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> Calling into CCF framework will cause a clock being enabled twice
> instead of once (clk->enable_count becomes 2 rather than 1), thus making
> it hard to disable (needs to call clk_disable() twice).
> Fix that by calling clock provided ops directly.

Can you describe this scenario more? From what I can tell, clk_enable doesn't
increment enable_count for CCF clocks.

--Sean

> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   drivers/clk/clk.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a38daaac0c..00d082c46f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -14,6 +14,7 @@
>   #include <dm/uclass.h>
>   #include <dm/lists.h>
>   #include <dm/device-internal.h>
> +#include <linux/clk-provider.h>
>   
>   int clk_register(struct clk *clk, const char *drv_name,
>   		 const char *name, const char *parent_name)
> @@ -115,11 +116,20 @@ int ccf_clk_set_parent(struct clk *clk, struct clk *parent)
>   static int ccf_clk_endisable(struct clk *clk, bool enable)
>   {
>   	struct clk *c;
> +	const struct clk_ops *ops;
>   	int err = clk_get_by_id(clk->id, &c);
>   
>   	if (err)
>   		return err;
> -	return enable ? clk_enable(c) : clk_disable(c);
> +	else
> +		ops = clk_dev_ops(c->dev);
> +
> +	if (enable && ops->enable)
> +		return ops->enable(c);
> +	else if (!enable && ops->disable)
> +		return ops->disable(c);
> +
> +	return -ENOSYS;
>   }
>   
>   int ccf_clk_enable(struct clk *clk)
> 

