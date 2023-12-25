Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBB8C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 22:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108EF8772E;
	Mon, 25 Dec 2023 23:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PjDYH8oT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8802F87735; Mon, 25 Dec 2023 23:49:29 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067E487480
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 23:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f9f6ca479so28503886d6.3
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 14:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703544561; x=1704149361; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8xm0pjB/U/1fjXYqUd6G+8ipnV1pitqicj+o9trXN5o=;
 b=PjDYH8oTbTiIzJYBa3jkm/ueEUhF/YRxLbVGcONWdzdFBFFKoWo5kPVjW1uWAjmG9x
 28Cysfl7vKhqvFxixnhBGFC4w+DYNGuN4SUXMRvwoV4ck7jAVioRwakg90KYn8sriArl
 FalhjNtmY3baETmDpTEIB4bQ3L/et/EOlpou9g0/rlm2oCdjWS4itF0lB0qObQLVTsCt
 x2BX1WIid4GwWW7AXJWCECyT8SKdf/VWHPa0MavDxGwXbYnR7ptlsimffw7mqVoC5fa/
 ewV1pf0TUSCLueX8bh3nys6RH9hYuDc25boELXaD4dat3OA3aNrJbCzfkPqssRfclgey
 A9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703544561; x=1704149361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8xm0pjB/U/1fjXYqUd6G+8ipnV1pitqicj+o9trXN5o=;
 b=jjLX4vLxa2HWCKUiqsfq9QTfaLWAFbkbi+TH5HDtE0OJObFveBG+RV4Sn1zuqIJOF5
 HQvZ82Px4q8EqWMecx5jhKq9PGgDTtvZGgLoR49I5ckMiTKatO3KWdFNXzk92I/fjiHP
 hVQU5SfrpRLJQL/eiC6ygVUCnZ3DckGyY+5R0DIX6MXNC1SFinuxp1a05lUQandKfy6Y
 E3gJPf4Kq9QPEDYH6A4bQ7PCzKEBQPNT1OcmOpFJKtYSAlVuJSCYEygpMbUlkNdkOT4A
 MLSH7wAtgaxpL4WqAvnzvP8XpNmpeYme8N807LJSbBtrGluULSDprlOibfNRgT9LlOBS
 TA+A==
X-Gm-Message-State: AOJu0YwNq92usE9K/+Cbomh5kJDoGZo0vnzEQr5a0fzK62biDJViKDO3
 nCLf55LiEHn70pFJDiyIqR0=
X-Google-Smtp-Source: AGHT+IHY4lmwSUV5Bjw+ZRYzh7ibqWXb6CM5FESAIY96b4ctrof382R8FhKzKYevCpc0ExhdcEj6iw==
X-Received: by 2002:ad4:4d85:0:b0:67f:a104:bbbd with SMTP id
 cv5-20020ad44d85000000b0067fa104bbbdmr8325588qvb.71.1703544561468; 
 Mon, 25 Dec 2023 14:49:21 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 g5-20020ad45105000000b0067f7d131256sm4126002qvp.17.2023.12.25.14.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Dec 2023 14:49:21 -0800 (PST)
Message-ID: <7bbe53d3-3ef7-b9de-472e-cb9c25c6cc06@gmail.com>
Date: Mon, 25 Dec 2023 17:49:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATHv2 8/9] omap3: use device specific naming for mem_init
Content-Language: en-US
To: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-9-maxim.uvarov@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231225153929.8284-9-maxim.uvarov@linaro.org>
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

On 12/25/23 10:39, Maxim Uvarov wrote:
> Use device specific naming for functions so as to not overlap
> with common function names.
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>   arch/arm/include/asm/arch-omap3/mem.h | 2 +-
>   arch/arm/mach-omap2/omap3/board.c     | 2 +-
>   arch/arm/mach-omap2/omap3/emif4.c     | 4 ++--
>   arch/arm/mach-omap2/omap3/sdrc.c      | 6 +++---
>   4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-omap3/mem.h b/arch/arm/include/asm/arch-omap3/mem.h
> index 569779c55e..fce3568eca 100644
> --- a/arch/arm/include/asm/arch-omap3/mem.h
> +++ b/arch/arm/include/asm/arch-omap3/mem.h
> @@ -475,7 +475,7 @@ enum {
>   #ifndef __ASSEMBLY__
>   
>   /* Function prototypes */
> -void mem_init(void);
> +void omap3_mem_init(void);
>   
>   u32 is_mem_sdr(void);
>   u32 mem_ok(u32 cs);
> diff --git a/arch/arm/mach-omap2/omap3/board.c b/arch/arm/mach-omap2/omap3/board.c
> index 8b70251457..c76a95dd5d 100644
> --- a/arch/arm/mach-omap2/omap3/board.c
> +++ b/arch/arm/mach-omap2/omap3/board.c
> @@ -216,7 +216,7 @@ void s_init(void)
>   void board_init_f(ulong dummy)
>   {
>   	early_system_init();
> -	mem_init();
> +	omap3_mem_init();
>   	/*
>   	* Save the boot parameters passed from romcode.
>   	* We cannot delay the saving further than this,
> diff --git a/arch/arm/mach-omap2/omap3/emif4.c b/arch/arm/mach-omap2/omap3/emif4.c
> index 7e5a281922..4fbfb387ab 100644
> --- a/arch/arm/mach-omap2/omap3/emif4.c
> +++ b/arch/arm/mach-omap2/omap3/emif4.c
> @@ -159,10 +159,10 @@ int dram_init_banksize(void)
>   }
>   
>   /*
> - * mem_init() -
> + * omap3_mem_init() -
>    *  - Initialize memory subsystem
>    */
> -void mem_init(void)
> +void omap3_mem_init(void)
>   {
>   	do_emif4_init();
>   }
> diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
> index 5d43e7c9cf..f2a0769b9d 100644
> --- a/arch/arm/mach-omap2/omap3/sdrc.c
> +++ b/arch/arm/mach-omap2/omap3/sdrc.c
> @@ -4,7 +4,7 @@
>    *
>    * This file has been created after exctracting and consolidating
>    * the SDRC related content from mem.c and board.c, also created
> - * generic init function (mem_init).
> + * generic init function (omap3_mem_init).
>    *
>    * Copyright (C) 2004-2010
>    * Texas Instruments Incorporated - https://www.ti.com/
> @@ -232,11 +232,11 @@ int dram_init_banksize(void)
>   }
>   
>   /*
> - * mem_init -
> + * map3_mem_init -

nit: omap3

>    *  - Init the sdrc chip,
>    *  - Selects CS0 and CS1,
>    */
> -void mem_init(void)
> +void omap3_mem_init(void)
>   {
>   	/* only init up first bank here */
>   	do_sdrc_init(CS0, EARLY_INIT);

