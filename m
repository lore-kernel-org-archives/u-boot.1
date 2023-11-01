Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D1FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B25876CD;
	Wed,  1 Nov 2023 18:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z5lXit2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACE3876C7; Wed,  1 Nov 2023 18:50:50 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4112876E9
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d122e0c85so539856d6.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698861045; x=1699465845; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3zA9wmkFx/+mUTKdbHlCmOg1SscGatzRStMoL6jVS+c=;
 b=Z5lXit2PPeFsOtjHx5UyDfdVA7hCcAY4pbMtPxC0aDm3OptibNXBhlcXCO/YG8khUb
 4nU8OOE2ViwCqv3OOzpbD7ymerxmf4+54oGQwcZcCMWE5fzAwcytu6X5LV7M2aWEpf3g
 nvHdm7RBO9RxLKIKRHyoS/HnNHBqzEW5L4cDcVdQs0SovphWgWtBioS3lLQgoqokHSun
 q7TL1vS34Sd4gPJ6BG1vSiwag0G+FsRiflyIh7FWQ00RadkJ5cNE7E+/vDSSt7eL2Hs0
 ocNY6KM+h7v6dpVbti2Qw4vSQVnb0f7VdBzhIh01POK7PRap+kttzEdZQrRUt0WAtUfE
 gCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698861045; x=1699465845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3zA9wmkFx/+mUTKdbHlCmOg1SscGatzRStMoL6jVS+c=;
 b=dMbjU2j0+yngzDngBWIPlkbryJqcFwiKRpCKKieAtmiBMMSBwamUtEDL2hPo33lbU0
 s/9ROhj5m+w6tDiEQQCG4IiYxp0WT9WVqOYjrXWCdNb/8SztWmOjULUvz8lxfB74CVnU
 GMknvpbBwhWyN51DwwqwhalY/S9RApS1552OwFW5uOhWZVDr2bNF1+EzLkKo3nvC33Ci
 Ya1VAoHKn53USYBwkMQBsoZHHxrQH4eNeRTKkBF9giU/tdLamZM29SKqAGGGqlX7NhTy
 93800GkGYhPeFlHynQ3ROeSRLEJT2T+JsJOwp4LabneaGPQYfAFlzt05KSuExmBRWPQz
 AH1w==
X-Gm-Message-State: AOJu0Yxtw3qQ8HDapIBQtDNAgziHS8almEYnyHOK2RBPX+w8GCOyIpMO
 KOZwbfocScKANR8ysPcBOSw=
X-Google-Smtp-Source: AGHT+IGaM56vqC9C/vro1tTlHr3d9UIWfMfX5rxlJazRUFCVdjBqMnMYYLSPVjDI2HnXgFxgujNFVw==
X-Received: by 2002:a05:6214:cae:b0:65a:f5e3:5ac0 with SMTP id
 s14-20020a0562140cae00b0065af5e35ac0mr18273356qvs.51.1698861045420; 
 Wed, 01 Nov 2023 10:50:45 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 on11-20020a056214448b00b0065d89f4d537sm1675373qvb.45.2023.11.01.10.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 10:50:45 -0700 (PDT)
Message-ID: <36a30ab5-652c-80d4-5e33-c0be3cde113b@gmail.com>
Date: Wed, 1 Nov 2023 13:50:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 1/5] clk: export clk_register_mux_table()
Content-Language: en-US
To: forbidden405@outlook.com, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
 <20230818-clk-fix-v1-1-49ec18f820bf@outlook.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230818-clk-fix-v1-1-49ec18f820bf@outlook.com>
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
> It's already implemented in clk-mux.c, export it in the header file.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>   include/linux/clk-provider.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index b8acacd49e..801404480b 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -247,6 +247,12 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
>   		void __iomem *reg, u8 shift, u8 width,
>   		u8 clk_mux_flags);
>   
> +struct clk *clk_register_mux_table(struct device *dev, const char *name,
> +				   const char * const *parent_names, u8 num_parents,
> +				   unsigned long flags,
> +				   void __iomem *reg, u8 shift, u32 mask,
> +				   u8 clk_mux_flags, u32 *table);
> +
>   struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
>   				    ulong rate);
>   
> 

Why do you want to export this? None of your other patches use it.

--Sean
