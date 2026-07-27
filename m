Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E7AC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 13:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5553580E06;
	Mon, 27 Jul 2026 13:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoXXIm76ig7e; Mon, 27 Jul 2026 13:07:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C77580DEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785157647;
	bh=cGMTuW9ZXkOJSoRGidRT4d+db9Lidug3CeDSs3xzZmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0hnZxnUG4x8wKikBpsvRpSnz7WsZja3B+45+YFEPLe4AastHfm/UQRTie2XDriy8G
	 QRI92qqBYFZwhcC2G8JnRXPNUcucOfBR4DznWR4X4htfmclvWE49fWGfuN/wU8uCFy
	 l/kSSPsE5gk50pnp9arQ07yTBaoBqgAG2AULUZkIrKXu76snmR4z7vwcohHOLh1OfW
	 /BLBZJt+Hh6I3ktzMXEPWIQfouPJLBiVvDqGVjRH74eLxpRIvQi0P6uPMeNyqUEftn
	 nPcJxJ+tvDnIk11bV2w3nSRr+n7VFX/flaCQQEiFw7lNfx34m2uJemJyCyb/oNDKZI
	 BtMbCINzlshIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C77580DEC;
	Mon, 27 Jul 2026 13:07:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B28FE194
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A43EC80C64
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id argP1uGYmVSj for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 13:07:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B2CC580BA2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2CC580BA2
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2CC580BA2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:07:25 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f7854678bso893270f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 06:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785157643; x=1785762443;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cGMTuW9ZXkOJSoRGidRT4d+db9Lidug3CeDSs3xzZmY=;
 b=VJZppmW04ejwcCZKu9GrJdVnSu1n71YiuRveOHdgqaT7pNYapIQ1L6AI4QvRsX+gfb
 Krl7clFCvn8q4fD+J0l0whMIpA0eh17UcZ6mfamsYF+JSSJYqN/uDoM6mhtM35v+cXn1
 WSdTDYOllNk9p6a9ZBj1QtqA0o834ZIpLVXLOg3VeIzKVv2c1PFqDVJvUq5LS0s5tlqS
 X7sWlXB5uQD+Xr728UgJ6M0lqZj2w/b5FzYbO6GNcFvPmtAeu9q++CyQF1vG/RUuEBIj
 5S+0Nkn6FLCZ+MDM51eKf9Z+0hQgmztcwBO3eSaBKncapin50/aepSWyx6oK76IRq8fb
 GDIw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9KCMGzUoLC9NoNg8gtAnsgxGJgwzHqd90+BO4a58LyXYUPavVtX1aLguJQQV6txaDJQ3nuyM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx/lL/jxRAMTXxLoa1YiiRFIc3I3WFZiztkGK2a0jJNzCNMf+C7
 Q4UGBXxNNHa9jkwI1BBuek1s6xGR9XR/qWYb2LaVHmLX+Bq6rVmiaQwi3h7sRhtcWsk=
X-Gm-Gg: AR+sD13TCvTO0Rxcxi3/js9Yq12T+feBCRycGwIv7ZrpGManlnK7Z74eOPoOkdk6ph7
 uSd7PYga1FD9i5l8OHMb12+00TUyM4HVdrIgpnWK1fO5x/CXzk94ledg46TlnYIvCyUKEZ3Jj2g
 AyeroZeNf+dbW4U/Gc5Id+zXBwG8+or7qzxlKyIQ0bv2bQeF7KG/TTEE+QyAlwnhV0rd7EYYKmt
 Q5UpXc0QXmCvybuATXZpPBTNkGsLIvQY9BvG82PSICNtIpvpR+3O3K+e7+mFDfrJcJsHLU7iiYW
 Vj62pJ4+L+cnb9oS1kWbBQOshSZqcXcxctDkmUqVp9y8m/ZLiqtZq3HoSHlk6s0OjugjTM+sCyo
 Cx+wsCdEAsdJhV9yD0Jtil+vYyKrRZooCQ3oz+IBaldQp+NwTrQXGoWBhxGp7ULhPbS4YFUFCZ/
 lreEwZyuTIp/XlVQLuwz77Mx7osHTaFPUGpoE+gTSdxg==
X-Received: by 2002:a05:6000:186f:b0:47f:90a4:ff40 with SMTP id
 ffacd0b85a97d-47f9febcb3dmr9714838f8f.42.1785157643390; 
 Mon, 27 Jul 2026 06:07:23 -0700 (PDT)
Received: from [192.168.1.37] (p549d460b.dip0.t-ipconnect.de. [84.157.70.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6e9a2sm50807346f8f.35.2026.07.27.06.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 06:07:22 -0700 (PDT)
Message-ID: <ca75a8c3-5054-4f4a-8b4f-a4fe40dbb8c9@linaro.org>
Date: Mon, 27 Jul 2026 15:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] mach-snapdragon: spl: Setup malloc
Content-Language: en-US
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>, Anshul Dalal <anshuld@ti.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>, Jens Reidel
 <adrian@mainlining.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
 <20260722-spl-v8-v8-6-cbfa79e85a9d@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260722-spl-v8-v8-6-cbfa79e85a9d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785157643; x=1785762443;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cGMTuW9ZXkOJSoRGidRT4d+db9Lidug3CeDSs3xzZmY=;
 b=g/5IuyniEhWFHdw1QWZbcxdGM5Vk4ADN7MVW7fMTo0WEcljREF25cMZe/6GJiMadt5
 seUUVYHvCR0g0Ow84I50rgbtGfsKyf1z51lFnmZBAgsQs7P9Ar16KdASgYBR8rreAxZ+
 PXBQM/kcN5OduUlbEC9h9XELJB0FE90GT2q6ax5RxIds1KOQHr4OCfENX/jdKuCAN4pf
 Gc+0Rq5NeBwkRSG+eH8ijfDNrU0t10pmVel8k/4vLCUuIjwmcUk5GziCTA/UrD+bapfK
 UIyFkU2WCgessN/rbLfGxMIcqOA8m8LXTktu37/2XSulEtPR3tf6hKyh9m/w1G4cuBNI
 zF8g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=g/5Iuyni
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 22/07/2026 09:41, Varadarajan Narayanan wrote:
> Setup the malloc base and limit for the SPL to be able to use the memory
> allocation APIs.

no caller? No explanation of when/why/where this will be used?

> 
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/board_spl.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
> index c5e86458616..25b1779391a 100644
> --- a/arch/arm/mach-snapdragon/board_spl.c
> +++ b/arch/arm/mach-snapdragon/board_spl.c
> @@ -238,3 +238,18 @@ unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
>  	return 0;
>  }
>  #endif /* CONFIG_IS_ENABLED(MMC) */
> +
> +void qcom_spl_malloc_init_f(void)
> +{
> +	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
> +		return;
> +	/*
> +	 * Set up by crt0.S
> +	 */
> +	assert(gd->malloc_base);
> +	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
> +	gd->malloc_ptr = 0;
> +
> +	mem_malloc_init(gd->malloc_base, gd->malloc_limit);
> +	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
> +}
> 

-- 
// Casey (she/her)

