Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E0CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E495387D44;
	Wed,  1 Nov 2023 18:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k5f1/fm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB61487D56; Wed,  1 Nov 2023 18:13:43 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBFD987507
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7788ebea620so479533185a.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698858815; x=1699463615; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zqi4oQ+fI2HNFKzlptsGyxi9hbC2jIZhMA5wcmrHsoQ=;
 b=k5f1/fm0pHs3h+PCBEKoLsH4GU8h1lojNKV3jgeHSwNJjtoTPj2MXJ3pDz+ruqG9it
 6aclnfRD2AkLczlEj2yzUxdAdo/NA+Qq0hxMq7qay5vcU/g5EPhBICCL48AdVUBOCbEe
 r53Xo966ax572yPXIp3JJw/Uwc7bwDdP9tjmuYnvJXtG9DfVUGrWJuWJW5R6qxSSIuLu
 Lr75NUveQ/x90DvRNpeEKYeNC0J+BTaKhfFNsX2Vubxmkvomuwk/PqQPwIIeQ3BaPTSl
 oyCLT0jSVUN+NnyZjSeBvMMEauXX6m0G8ZJVv/ikTkw52XaDac9c5sIv2zIqqtT5P+gy
 Ce8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698858815; x=1699463615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zqi4oQ+fI2HNFKzlptsGyxi9hbC2jIZhMA5wcmrHsoQ=;
 b=IMFSghbqi11HXSbC5LKkBUf67fEefmeDjT5njXtlWDYxh4zEjdSTdA2sGQEGg4iEJ5
 IZ6EpZ/672YilEpmd6U3+GDKKJdc4+2pfy6e9LpdEnMdNEt15gxmerL0nk/Xu2w/6wMv
 Qyj62UWBpFFR9V49dbQRKXCODuORhfmFERi1zmKrhfVNepwBxv0izt0O84UnMOuDspv+
 gb8PFNWYG4D0QeKfQZeb1fxvCT6vsoNy7Me4yiH38d9RKAp1jbfUkPkMuiKBNyenHuTO
 YQr/za7f2+Wg1jJ9o1ap7LQBoZcRV34lMwfzxfA6mbZ82qLVAE70IHj+EuBrekAp2lC/
 shmQ==
X-Gm-Message-State: AOJu0YxwZLk+cWB+C0JH2zPQmI8JG4xC/7Xos6mL2zuw9If0oyPkJM9Q
 /fBsIpIcQamMKZyYWGqLaYo=
X-Google-Smtp-Source: AGHT+IGHTaoPYy1sfNIp6lRmI0gwb4rtmaiCOcvnjY2OuzNdqXRENpd+VDbjAaPGKw6sRY+htU4aqg==
X-Received: by 2002:a05:6214:194f:b0:66d:237d:8f75 with SMTP id
 q15-20020a056214194f00b0066d237d8f75mr20820368qvk.35.1698858815620; 
 Wed, 01 Nov 2023 10:13:35 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 t14-20020a0cea2e000000b00655e428604esm1631933qvp.137.2023.11.01.10.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 10:13:35 -0700 (PDT)
Message-ID: <5d13035b-2f8d-a2cf-5150-99eed7e5bcf5@gmail.com>
Date: Wed, 1 Nov 2023 13:13:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 8/8] cmd: clk: Make soc_clk_dump static
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-9-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-9-ivprusov@sberdevices.ru>
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

On 10/17/23 12:56, Igor Prusov wrote:
> After introducing dump to clk_ops there is no need to override or expose
> this symbol anymore.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/clk.c     | 4 ++--
>   include/clk.h | 2 --
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/cmd/clk.c b/cmd/clk.c
> index 90cc6fa906..f55911db7a 100644
> --- a/cmd/clk.c
> +++ b/cmd/clk.c
> @@ -59,7 +59,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>   	}
>   }
>   
> -int __weak soc_clk_dump(void)
> +static int soc_clk_dump(void)
>   {
>   	struct udevice *dev;
>   	const struct clk_ops *ops;
> @@ -81,7 +81,7 @@ int __weak soc_clk_dump(void)
>   	return 0;
>   }
>   #else
> -int __weak soc_clk_dump(void)
> +static int soc_clk_dump(void)
>   {
>   	puts("Not implemented\n");
>   	return 1;
> diff --git a/include/clk.h b/include/clk.h
> index d91285235f..bf0d9c9d7f 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -674,8 +674,6 @@ static inline bool clk_valid(struct clk *clk)
>   	return clk && !!clk->dev;
>   }
>   
> -int soc_clk_dump(void);
> -
>   #endif
>   
>   #define clk_prepare_enable(clk) clk_enable(clk)

Reviewed-by: Sean Anderson <seanga2@gmail.com>
