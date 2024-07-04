Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BBBC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 15:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B42438889D;
	Thu,  4 Jul 2024 17:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vYAaJVHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8722888F0; Thu,  4 Jul 2024 17:02:25 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D728889D
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 17:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a724598cfe3so73034566b.1
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720105343; x=1720710143; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhSHZF5RagnmatuVZPtfJ/F0BdNyPCtqFO85wEnxU0k=;
 b=vYAaJVHmr0fIi24qcJFU6PtsYF+psMrbgrR7myJ14Sq0eZzujxgq5f45sRv9iHqUsR
 3upmRcyt2yN6U/s6LNfPOmB6mWr76kYhzp8H+7UD37NFXi1ATo6/zX7aN/l4otMbgWLH
 wrHhHdXC011Viy7H+TFd7Hmp7PCm5JhM+u4xowgRG1Zm9sXzqEgK9MN8Nn3fB0fSC1gT
 K4FYdKV56wap5bt+rkjR7yrQvwNITjoXm+D7rdjFGjN8K76KU4obqZ/egLHxBnyGi03l
 NFx/nernm6lnn1lMIRSzJ3R4GmC051+c+aiESI6KpFEJSzU2J3pv1ZUp3CR9VBCfFv7P
 Qp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720105343; x=1720710143;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GhSHZF5RagnmatuVZPtfJ/F0BdNyPCtqFO85wEnxU0k=;
 b=Efkvb1okdhRLEr81d7VKBV30DOJoqSL2dlFgA7s7HRSthR9YgxxK3FyDKZ+JwN+ttl
 JgFQz1z67PKw9j7K5SeKpYS7Uu7U+yVn/LNXwj1tEykPWoUMg1jjccy1DXvWMHVcz89j
 FVqxcEeaEdn26KicwrCjPJXNF+0Il5PBHAE5inoYfaGDVlLPQHy2g23Y60Wd1FWTYavL
 5hY3/f2tHvB3QrYpjtOiCl6bj5jyrWhpax2hogi3IijMIzuKXAwQszab5k4InFeqlLgs
 VWnBwmNluMVe6Yd/jacTBceQz9j5EasPVSlJRYZxZ0k2ptA7oVyH7/pDdZVDW6CoDTGB
 aiKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVaBsj5tVHdDKgj8gdF33YYPj97fRF7YiyNdk7/FmVXExQzUWZLG+tUAoVMnRJm5auP+Cbk3ybF/DIpxNURLrmS5FVCQ==
X-Gm-Message-State: AOJu0Yz1c3En7ntJma0JFbL1y6Z6pz6OR37HeqaLaBh5b6Djlm9AH7iN
 Y/rsVqR8jZCP5hCP88S1px0/kz4KqbYkKSZ7rMuMle8L0RNvg9vA6x6r8k0SxfE=
X-Google-Smtp-Source: AGHT+IHEhlkKwzRY22ul+18MDr6oYvIM6ou+l8d6VyAY7NOXeu9Hys3XH0uYqGeR57imOM67xBj4zA==
X-Received: by 2002:a17:907:7f1f:b0:a72:42df:cd27 with SMTP id
 a640c23a62f3a-a77ba72baf7mr147942966b.71.1720105343151; 
 Thu, 04 Jul 2024 08:02:23 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c54d96f3sm10646166b.189.2024.07.04.08.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 08:02:22 -0700 (PDT)
Message-ID: <99e94938-492a-434a-844b-00f979abdf95@linaro.org>
Date: Thu, 4 Jul 2024 17:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] sandbox: Increase cyclic CPU-time limit
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>, Stefan Roese <sr@denx.de>,
 Ying Sun <sunying@nj.iscas.ac.cn>
References: <20240704074859.2956745-1-sjg@chromium.org>
 <20240704074859.2956745-5-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240704074859.2956745-5-sjg@chromium.org>
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

Hi Simon,

On 04/07/2024 09:48, Simon Glass wrote:
> Now that sandbox is using cyclic for video, it trips the 1us time
> limit. Updating the sandbox display often takes 20ms or more.
> 
> Increase the limit to 100ms to avoid a warning.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   common/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index 87b0ec3ea8f..83c81edac20 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -636,6 +636,7 @@ config SPL_CYCLIC
>   
>   config CYCLIC_MAX_CPU_TIME_US
>   	int "Sets the max allowed time for a cyclic function in us"
> +	default 100000 if SANDBOX  # sandbox video is quite slow

Won't this be the case for other boards as well? Maybe it would make 
sense to bump this unconditionally or adjust the cyclic API so users 
could provide a hint about how long they'll take to run.

Isn't 100ms a bit excessive just to flush a buffer?
>   	default 5000
>   	help
>   	  The max allowed time for a cyclic function in us. If a functions

-- 
// Caleb (they/them)
