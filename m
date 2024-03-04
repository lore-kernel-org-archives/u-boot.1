Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B37AC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 13:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078D187FA9;
	Mon,  4 Mar 2024 14:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vl/+NQkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BA787FAC; Mon,  4 Mar 2024 14:44:19 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49FD287F7F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 14:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 73A253FB67
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709559856;
 bh=jRSuFFici0AWRC5nfKQOginY98F3EsumEUWzEwzwLdo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=vl/+NQkE2jKM6cnL80RWb4Llz/aTDnduQbJAd94TzEp6xGdrJd4TpKOgkoHCt+cIq
 MR4BDUTdXAlqrSYrgfDSJjp7ztxtkQ/LU07ogj55n6al3lnuDDmmiSfWbD2oZwY3wv
 GxRULUDC1pxvwf18BsRRtuuUQi1kOTijRFD8ubiz/RbmWkjH/tiy5DCgOlzb4MFFbf
 rNGec8jyQWCj5HkKRtnba98VQgEqMjHmKZEzTlBt5pxi9jAIBHTpkDuLE2nIUmVM4Y
 W3XYlacKD0E8R9/GBRWnFVos5GrN6mDInAuCcH5CY3LuGpxKYruJq9b7XktCJWyy2u
 1Nuomy33y3+Jg==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a26f2da3c7bso382628566b.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 05:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709559856; x=1710164656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jRSuFFici0AWRC5nfKQOginY98F3EsumEUWzEwzwLdo=;
 b=MLXXEYHZFfjGstFYQbHRVRpep5Rx+mGZ/BUmtOZy9TfqLtJSJz9zcCi+d5n9VfPghD
 4XyO0eT+ikXqQrq2aWSSt1Rv9ugTmInY5C17zbpTLY7n+HeNS1lnUXK/B7e6YdyYTHNm
 2JGbiV2IlucsSE7W9hdi7e+0KsgMFYUp05r4QKD0Cftn3Sbx+svZLhuizMSKrhcSPfFq
 qMsg5h8yMOX0qchKYdZYOlGrlhngPjfNSrvGRe2FPk8rxBASACD17n/fyKKZRZN02QRD
 RAV0wISevTB2sQBNmibBtoCsFz5PXumYjYs51mCOFkD5kEcC0U3S35+z6zB6pcSYrWjo
 MLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVurB6wV5aU/smJs/7zPqgrk9ME7IolrMlIMi0qVxZvs2jXi2RIH2aAPnB2XIxIOYjWLIlfyEcxP0TJfbObe56euk0M8Q==
X-Gm-Message-State: AOJu0YxBQj8BW6OJHiL7aOSLm1qAlVyR45mq3MfjyugXCe3GvEDQyCGe
 ep1ArWxE9WKIdhJ0WZt2NKDj/MGZ/mzIVzsYEGM3WZl1EiWrwgc8/KlNTvgOZvuLszdaF7JAKgL
 56QKy0K+SU7UGyqZtytK2zWNTYHKLtCQmCQbuX4q55JFjCEeU+opTYKBgrwUMqf7e51M=
X-Received: by 2002:a17:906:4e88:b0:a45:5451:f967 with SMTP id
 v8-20020a1709064e8800b00a455451f967mr1579862eju.20.1709559855983; 
 Mon, 04 Mar 2024 05:44:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBDBqhF6CXAYJB0lF6j92jzJopcfo2K+9dqr3tKGs4ImoqYvjDlMXFQE7KS1Fk3aPYR3fwTg==
X-Received: by 2002:a17:906:4e88:b0:a45:5451:f967 with SMTP id
 v8-20020a1709064e8800b00a455451f967mr1579838eju.20.1709559855614; 
 Mon, 04 Mar 2024 05:44:15 -0800 (PST)
Received: from ?IPV6:2a00:20:9:393f:5c78:8942:8004:2f13?
 ([2a00:20:9:393f:5c78:8942:8004:2f13])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a1709067f0c00b00a4495c51f4esm3634671ejr.39.2024.03.04.05.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 05:44:15 -0800 (PST)
Message-ID: <6907b26a-9eb2-4ffd-8337-50ee96155c05@canonical.com>
Date: Mon, 4 Mar 2024 14:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: Enable CONFIG_64BIT for static analysis
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Bin Meng <bmeng@tinylab.org>, Linus Walleij <linus.walleij@linaro.org>,
 Fabio Estevam <festevam@denx.de>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <6a7328b8-eb22-4ad6-a1d6-eaecd2f8a067@moroto.mountain>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <6a7328b8-eb22-4ad6-a1d6-eaecd2f8a067@moroto.mountain>
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

On 04.03.24 08:04, Dan Carpenter wrote:
> In the Makefile there is a line that says this:
> 
>      # the checker needs the correct machine size
>      CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)
> 
> Set CONFIG_64BIT for ARM64 so that we pass -m64 to the static checkers
> instead of -m32.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: split the patch into two patches
> 
>   arch/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fde85dc0d537..76d6a8cc6886 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -6,6 +6,7 @@ config SYS_ARCH
>   
>   config ARM64
>   	bool
> +	select 64BIT

How about other 64bit architectures (sandbox64, x86_64)?

Best regards

Heinrich

>   	select PHYS_64BIT
>   	select SYS_CACHE_SHIFT_6
>   	imply SPL_SEPARATE_BSS

