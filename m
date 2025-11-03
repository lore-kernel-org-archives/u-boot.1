Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BABACCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 14:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C55F83700;
	Mon,  3 Nov 2025 15:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=smile.fr header.i=@smile.fr header.b="t4XEIc3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E40838AE; Mon,  3 Nov 2025 15:35:34 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1B4836D1
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 15:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=romain.naour@smile.fr
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-475dc0ed8aeso30593645e9.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 06:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smile.fr; s=google; t=1762180532; x=1762785332; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fdo03ZfKjzwC5W8VQPS8+2ZAvEHMWFbDL1+aOzPPuok=;
 b=t4XEIc3LD8hEhVDBYN4v1wOmePX21WVosR8iKve3+S+2KLMhlKjeCmAp3RSiHWXo0o
 faEReHDZ8uNgu8Z1bCphxt2yExKUZP9Ohs4GQsMH2Mi4ZxzlyOdQzzPVbiLIyw7Jcx6Q
 1z75RM6npOOf3NbbsS/qgj+89C7Cc1cngPhM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762180532; x=1762785332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fdo03ZfKjzwC5W8VQPS8+2ZAvEHMWFbDL1+aOzPPuok=;
 b=csJFIa33wCNjnl+n9gV6c3dMQd8E53lV5FAqQ/Hel3PpWFisLmqL7AR8WRRENDKsv2
 ewtAZNVZHKzSo7V+RnffwKK2AsYRB7+4NLuxjI7kX9uXRVkiCeD8nU13sJnKy0A0N39U
 pDkZOMqbA8a1QajmyapA8hd8DZRtu7Zm0xTLbQjeGY4YECeyCJj/MhquV7susM9yIHoR
 bIT2riPerhICIhzn5tcwV/E9gOXq3/4vCBMsq8JdntPAmDcKootcJglTQx3tSsEUzJeF
 h1eyahBKM0eS1Q7rYYEhMyxoxFC5swuGAwWoUtNP90qkLU+Rw2IQGy9U5wmYhn0aHma9
 QBMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRQL4QS6wDdb1MvGxcCI6KJC5sHsFeDiWq20xUgZhboGuoPQUztHcB0zvmiNRP9h3o6pcCJlw=@lists.denx.de
X-Gm-Message-State: AOJu0YxEOIVowCf5l68zi8So7NNVHkyLBP6G+fvnlzvsTVUdNF+Nj9Pn
 /J0S+t7WARp12u0NeAUG5iPEBhay9JKTzXsGMyOnfNxXG0kKVmdcCXLvSvY54O0mE7w=
X-Gm-Gg: ASbGnctUVJg5zdk5jQ37OJPhbqN5ZLW1ezFbAX1r6L/orKl5vsCEFp5jjPLgBkanAWc
 4Ic73uZDkbPyaEkVbHQj+UGOJImKZZjfBZpOeUAz56R3F8GvecE4iLeFPR86JyOdAgxFPNG2AlZ
 X5vY/Oza0d3kDDiEW151Nai/fMTjoQen4Ecaqt5wlUm8HdtR704jCKtx2YKpMIZPfupgxU3Ts7G
 Otc5KNT5l2Jiz548wIpHhpZ/sL/iGVTITB5VTvKubpBlZmr5TrhwKT7rNtyU3VBWXNXiku83O1E
 j4ursiXVlCfZcU9E8Lmc9q6wK9ust96yzKQw/87ebIb0yp3xOtrxTWWNG9fPydn8U8KUOSn6M5F
 5XjLNdFFvK1q1NHFjl2yvldMWKBPg7z8ovP3MpTP1JjMW6yqBPdiR3DefBS/jccY0yWqj9xJQEr
 LBCXwR+PG1QGL99IFPpfFGjLvWI09iTzZlR5Efs0P/ALsp+kWYmOdg5ATOwX9xXKOyQ8VX7KVQJ
 gOlxUGyuj7lZqTY6pDU+GMJLZIpG3MFtUGFrRZ4YDs=
X-Google-Smtp-Source: AGHT+IEDriS5Ttye1dye8tjE89JZyWIaq5+PVZhfJ3fkdZpRuQG49IqPAmFcYTwD5pIygLcdax47Pg==
X-Received: by 2002:a05:600c:3e83:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-477308a4e55mr144582695e9.34.1762180531698; 
 Mon, 03 Nov 2025 06:35:31 -0800 (PST)
Received: from ?IPV6:2a01:cb05:94a2:a200:2ad9:827a:59cb:148a?
 (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr.
 [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c9416f82sm15128221f8f.6.2025.11.03.06.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 06:35:31 -0800 (PST)
Message-ID: <92bf5ca4-10a4-40fa-a920-1408779cb181@smile.fr>
Date: Mon, 3 Nov 2025 15:35:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] doc: ti: k3: Add section for DDR configuration
To: Neha Malcom Francis <n-francis@ti.com>, trini@konsulko.com, s-k6@ti.com,
 bb@ti.com
Cc: m-chawdhry@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 gehariprasath@ti.com
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-8-n-francis@ti.com>
Content-Language: en-US
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <20251103071035.674604-8-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello Neha, All,

Le 03/11/2025 à 08:10, Neha Malcom Francis a écrit :
> Add a concise section for DDR configuration pointing to the public tool
> that can be used to generate the configuration DTSI.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Changes since v1:
> - new patch
> 
>  doc/board/ti/k3.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 01fb9411688..de66b830703 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -649,6 +649,17 @@ Refer (:ref:`U-boot ARMV8 build <k3_rst_include_start_build_steps_uboot>`)
>     This will need to be explicitly disabled by changing the boot_targets to
>     disallow fallback during testing.
>  
> +DDR Configuration
> +-----------------
> +
> +The K3 DDRSS driver (drivers/ram/k3-ddrss/k3-ddrss.c) configures the DDR during
> +the R5 SPL stage. The driver utilizes an auto-generated configuration file
> +containing necessary settings for the DDR. It configures the frequency, timing
> +parameters, training algorithms etc. for DDR initialization. The configuration
> +DTSI can be generated using the `Sysconfig tool <https://dev.ti.com/sysconfig>`_
> +and selecting the software product as "DDR Configuration for \*" as well as the
> +required device.

Thanks for promoting the new K3 DDRSS configuration tool (v0.12.00)!
Until recently, I was still using the old spreadsheet (K3 DDRSS v0.10.0) from
outdated application note [1].

The FAQ post [2] is really useful for custom board DDR configuration but
somewhat difficult to find/notice on e2e forum.

Note: The K3 DDRSS sysconfig based tool can even be used offline [3].

[1] https://www.ti.com/lit/an/spracu8b/spracu8b.pdf
[2]
https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1482402/faq-tda4vm-tda4x-dra8x-am68x-am69x-lpddr4-topics
[3]
https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1378443/processor-sdk-j784s4-tda4ah-offline-ddr-configuration-tool---latest-version/5269621

Reviewed-by: Romain Naour <romain.naour@smile.fr>

Best regards,
Romain


> +
>  Saving environment
>  ------------------
>  

