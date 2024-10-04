Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D807DCFA769
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 11:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC58888B7;
	Fri,  4 Oct 2024 13:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="gVIDnW2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 656AD88936; Fri,  4 Oct 2024 13:00:56 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686C78888F
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 13:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb1758e41so15915215e9.1
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728039653; x=1728644453; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gHqnwYNeMPEGE0vKH2SvoaTdqtiId3i91NmlPjxI9Lc=;
 b=gVIDnW2Ei5RdzC62Vg6MoWWG++ZmrYtWe5m+7Ho9ZGjVRkAJepXhtzhFQJwqUI+/HT
 PwZB0u2giFqcI3Wiuo5Q49Ju/R+O6vYN3mnikROuV8VN+6nbc9iGwRv6sHm7Lr0xmWrD
 qVrkANd3vkQCIE5Y+ll+hvQ7BH0H02YkMJQSKI9BQrAYzt++HqmkFvvo0U9PRwk3px4F
 mLNYY22B+P4dEbJd/02uSSQzgYk1WHcj3qAHUVN15cJEjjD/QjqB4NZL+G7WS9skkqga
 shjtRRIlj+/gFM8yK9T+oNTf1XvDCCJxEpxSKpXM4FNpXpiOeWCBhlGoBxKT4LJAGwKT
 yp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728039653; x=1728644453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gHqnwYNeMPEGE0vKH2SvoaTdqtiId3i91NmlPjxI9Lc=;
 b=mG9RhEpSs8LlPBdum4WUZgmBTJE1Qnr80Y1aWuY+7h/AmqVZcHkzxkAFl94H3xSr1O
 nf5gAJDRKTaeSqSRGj+yuGJaxriYpBAmi/B3e5yv6gH//toPIweWcbYqECnSsm2cYCzq
 fUg0UFoQsi+MU8pHT+WG3qrOIy4rFRMTNT3WFN6QxhjGO3NFx2xZXOw9EyJ0XE7t32dJ
 ydqlgHNsLm+dipbkhCoqR+x0Gmo+ccGurEhjExB7R1XH1Xl+Iy/hFc8NapMoOgiWPTxE
 1VkeKhik0m7ngqTwBrzUlcnXGH2BQ1Uwy8ZugtmyjYNpJxjg/Cb8OSs/BS2eU69BKO0G
 J47w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOGN8JKvAwCLYi6u+rmhAA3q/YzCcWCinPTZaqJ5IDYeS0bUiCc2AtNIPBZOkDuVQxhmtloKk=@lists.denx.de
X-Gm-Message-State: AOJu0YxjdLOcNSQ1mXP2l9vNFr78KjMrk4iSxnLuHkL4gDd7D/K+phob
 YNkogWV7abwdk3zlgwma1MJGICXpebYSuFbNfhyCY24TQomB16oM837vztSRFd6JWgYkwVP+//n
 /soA=
X-Google-Smtp-Source: AGHT+IGC25+6qLpcrsNnBDq/1repV6yeU/t9Vn9qaZpKmtQjNCMabialSRq0OkuIo9MRu5ZMQbUIig==
X-Received: by 2002:a05:600c:3b82:b0:42f:8287:c235 with SMTP id
 5b1f17b1804b1-42f85aa194fmr15451375e9.1.1728039652809; 
 Fri, 04 Oct 2024 04:00:52 -0700 (PDT)
Received: from [192.168.1.144] ([207.188.162.240])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm3057542f8f.8.2024.10.04.04.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 04:00:45 -0700 (PDT)
Message-ID: <b3489099-1b76-4e3f-822e-5d7ae89d49b1@suse.com>
Date: Fri, 4 Oct 2024 13:00:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rpi: Pass CMA through from firmware DT
To: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20241004084124.416695-1-pbrobinson@gmail.com>
Content-Language: en-GB
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20241004084124.416695-1-pbrobinson@gmail.com>
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



On 4/10/24 10:41, Peter Robinson wrote:
> For a lot of usecases, such as display, camera, media
> the Raspberry Pi needs a lot more CMA than distros
> configure as default so we should pass this parameter
> through so things work as expected. Fix a spelling
> mistake while we're at it.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   board/raspberrypi/rpi/rpi.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9f..d4dbd96bc96 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -540,7 +540,7 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>   	if (fdt == fw_fdt)
>   		return;
>   
> -	/* The firmware provides a more precie model; so copy that */
> +	/* The firmware provides a more precise model; so copy that */
>   	copy_property(fdt, fw_fdt, "/", "model");
>   
>   	/* memory reserve as suggested by the firmware */
> @@ -561,6 +561,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>   
>   	/* address of the PHY device as provided by the firmware  */
>   	copy_property(fdt, fw_fdt, "ethernet0/mdio@e14/ethernet-phy@1", "reg");
> +
> +	/* copy the CMA memory setting from the firmware DT to linux */
> +	copy_property(fdt, fw_fdt, "cma", "size");
>   }
>   
>   int ft_board_setup(void *blob, struct bd_info *bd)

