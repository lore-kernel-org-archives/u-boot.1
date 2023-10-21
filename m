Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F01C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 05:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7090087596;
	Sat, 21 Oct 2023 07:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cXKhw1a4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0180C87596; Sat, 21 Oct 2023 07:58:05 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611C38755C
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 07:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40859c464daso1105885e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697867878; x=1698472678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DohAdnCPE7Dl8CS2BqMvYC3xrE3yx8UxdqmJ2PLDETI=;
 b=cXKhw1a4snxBtyqD9O9CAvEP/H0Y9rUqarwmDBTg4fNJm3Z6WHhmqeW9CwtMrf3u+e
 eGfMm0g/MiJgww3NzXPxTKdUpGfpR69GvsB66ZNraxJ3nW27KAt5Lc61zE/v7mqwizQE
 Vk7uAdqxMZaahQYCn0SankgqK/yWDxz28B93B6j7wwZiD0DPM6yQAvU410cCLUs27oLp
 IbuXAEuC7OaKotGaElyq94vMYUHozTj/g3AHESupFc3a4Z5rbEQ+azf6uu3xqBTR7MDi
 6OsK1mY0hGBxdOR00vYyHFTrHpJFohnWP/QcgIYR0DU+mqD1qQidj1MjPIvGVruBrN7I
 HTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697867878; x=1698472678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DohAdnCPE7Dl8CS2BqMvYC3xrE3yx8UxdqmJ2PLDETI=;
 b=e0C7VnysQ06hHiDz3R9H2qI5VwfzChioHYlrhLVQXKD7urlhbBK3Y5ccL/+K0IyVdd
 6wDqbPfx+MaoIuTaZ8YJiPETNOaWQxEZa7NYvJ6n/NStrBfxJKvbchqhNDvtoPjaxmE4
 XP/5kqJfxKqtC+T7prQOiG1+gzdowAiJMA2bQkhgWfclNZEsSX/kuAQwf024y0B1ZVWS
 btzWtd5jePAAScjB/EuVmMJNe/DBZcLhiBeRgVb9lM4VFEFnuFRuytgoFkQBtZM2AQzP
 i98suCTuklFqKfh5aTLsq3N8nJlCcIAQb7RUDS1PJzQfeVnFL4xlfxxpVxCSNGLjt6qq
 disQ==
X-Gm-Message-State: AOJu0YzINVecMOV9A6B/mGOtT2rKtTbSnk37/K68OSTa7ldLikAUks21
 5Lxnc9MLHSC0Bepw6Nguky0=
X-Google-Smtp-Source: AGHT+IGNXrYh15KtEafcEan635sgeuPrtA+YrmWrZFdgBxTMugRZsSTVqWFs0BOBhu9s3j27fbaDOw==
X-Received: by 2002:adf:e644:0:b0:32d:9755:374b with SMTP id
 b4-20020adfe644000000b0032d9755374bmr3309414wrn.30.1697867877575; 
 Fri, 20 Oct 2023 22:57:57 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 v3-20020adff683000000b0032d9523de65sm3005915wrp.48.2023.10.20.22.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:57:57 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/4] sunxi: DRAM: H6: use proper MMIO accessors in
 mctl_set_addrmap()
Date: Sat, 21 Oct 2023 07:57:56 +0200
Message-ID: <3255032.aeNJFYEL58@archlinux>
In-Reply-To: <20231021011025.568-5-andre.przywara@arm.com>
References: <20231021011025.568-1-andre.przywara@arm.com>
 <20231021011025.568-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Saturday, October 21, 2023 3:10:25 AM CEST Andre Przywara wrote:
> For accessing MMIO registers, we must not rely on the compiler to
> realise every access to a struct which we made point to some MMIO base
> address. From a compiler's point of view, those writes could be
> considered pointless, since no code consumes them later on: the compiler
> would actually be free to optimise them away.
> 
> So we need at least the "volatile" attribute in the pointer declaration,
> but a better fix is of course to use the proper MMIO accessors (writel),
> as we do everywhere else.
> Since MMIO writes are already ordered within themselves (courtesy of the
> "device nGnRnE" memory attribures), and we don't do any DMA operation
> which would requrire synchronising with normal memory accesses, we can
> use the cheaper writel_relaxed() accessor, which have the additional
> advantange of saving one instruction, for each call.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Great catch! I wonder if this ever caused any issue.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm/mach-sunxi/dram_sun50i_h6.c | 69 ++++++++++++++++------------
>  1 file changed, 39 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> b/arch/arm/mach-sunxi/dram_sun50i_h6.c index 8e959f4c600..89e855c1a7d
> 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> @@ -192,77 +192,86 @@ static void mctl_set_addrmap(const struct dram_config
> *config)
> 
>  	/* Ranks */
>  	if (ranks == 2)
> -		mctl_ctl->addrmap[0] = rows + cols - 3;
> +		writel_relaxed(rows + cols - 3, &mctl_ctl->addrmap[0]);
>  	else
> -		mctl_ctl->addrmap[0] = 0x1F;
> +		writel_relaxed(0x1f, &mctl_ctl->addrmap[0]);
> 
>  	/* Banks, hardcoded to 8 banks now */
> -	mctl_ctl->addrmap[1] = (cols - 2) | (cols - 2) << 8 | (cols - 2) 
<< 16;
> +	writel_relaxed((cols - 2) | (cols - 2) << 8 | (cols - 2) << 16,
> +		       &mctl_ctl->addrmap[1]);
> 
>  	/* Columns */
> -	mctl_ctl->addrmap[2] = 0;
> +	writel_relaxed(0, &mctl_ctl->addrmap[2]);
>  	switch (cols) {
>  	case 7:
> -		mctl_ctl->addrmap[3] = 0x1F1F1F00;
> -		mctl_ctl->addrmap[4] = 0x1F1F;
> +		writel_relaxed(0x1f1f1f00, &mctl_ctl->addrmap[3]);
> +		writel_relaxed(0x1f1f, &mctl_ctl->addrmap[4]);
>  		break;
>  	case 8:
> -		mctl_ctl->addrmap[3] = 0x1F1F0000;
> -		mctl_ctl->addrmap[4] = 0x1F1F;
> +		writel_relaxed(0x1f1f0000, &mctl_ctl->addrmap[3]);
> +		writel_relaxed(0x1f1f, &mctl_ctl->addrmap[4]);
>  		break;
>  	case 9:
> -		mctl_ctl->addrmap[3] = 0x1F000000;
> -		mctl_ctl->addrmap[4] = 0x1F1F;
> +		writel_relaxed(0x1f000000, &mctl_ctl->addrmap[3]);
> +		writel_relaxed(0x1f1f, &mctl_ctl->addrmap[4]);
>  		break;
>  	case 10:
> -		mctl_ctl->addrmap[3] = 0;
> -		mctl_ctl->addrmap[4] = 0x1F1F;
> +		writel_relaxed(0, &mctl_ctl->addrmap[3]);
> +		writel_relaxed(0x1f1f, &mctl_ctl->addrmap[4]);
>  		break;
>  	case 11:
> -		mctl_ctl->addrmap[3] = 0;
> -		mctl_ctl->addrmap[4] = 0x1F00;
> +		writel_relaxed(0, &mctl_ctl->addrmap[3]);
> +		writel_relaxed(0x1f00, &mctl_ctl->addrmap[4]);
>  		break;
>  	case 12:
> -		mctl_ctl->addrmap[3] = 0;
> -		mctl_ctl->addrmap[4] = 0;
> +		writel_relaxed(0, &mctl_ctl->addrmap[3]);
> +		writel_relaxed(0, &mctl_ctl->addrmap[4]);
>  		break;
>  	default:
>  		panic("Unsupported DRAM configuration: column number 
invalid\n");
>  	}
> 
>  	/* Rows */
> -	mctl_ctl->addrmap[5] = (cols - 3) | ((cols - 3) << 8) | ((cols - 
3) << 16)
> | ((cols - 3) << 24); +	writel_relaxed((cols - 3) | ((cols - 3) << 8) |
> ((cols - 3) << 16) | ((cols - 3) << 24), +		       &mctl_ctl-
>addrmap[5]);
>  	switch (rows) {
>  	case 13:
> -		mctl_ctl->addrmap[6] = (cols - 3) | 0x0F0F0F00;
> -		mctl_ctl->addrmap[7] = 0x0F0F;
> +		writel_relaxed((cols - 3) | 0x0f0f0f00, &mctl_ctl-
>addrmap[6]);
> +		writel_relaxed(0x0f0f, &mctl_ctl->addrmap[7]);
>  		break;
>  	case 14:
> -		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | 
0x0F0F0000;
> -		mctl_ctl->addrmap[7] = 0x0F0F;
> +		writel_relaxed((cols - 3) | ((cols - 3) << 8) | 
0x0f0f0000,
> +			       &mctl_ctl->addrmap[6]);
> +		writel_relaxed(0x0f0f, &mctl_ctl->addrmap[7]);
>  		break;
>  	case 15:
> -		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | 
((cols - 3) <<
> 16) | 0x0F000000; -		mctl_ctl->addrmap[7] = 0x0F0F;
> +		writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 
3) << 16) |
> 0x0f000000, +				&mctl_ctl-
>addrmap[6]);
> +		writel_relaxed(0x0f0f, &mctl_ctl->addrmap[7]);
>  		break;
>  	case 16:
> -		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | 
((cols - 3) <<
> 16) | ((cols - 3) << 24); -		mctl_ctl->addrmap[7] = 0x0F0F;
> +		writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 
3) << 16) |
> ((cols - 3) << 24), +			       &mctl_ctl-
>addrmap[6]);
> +		writel_relaxed(0x0f0f, &mctl_ctl->addrmap[7]);
>  		break;
>  	case 17:
> -		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | 
((cols - 3) <<
> 16) | ((cols - 3) << 24); -		mctl_ctl->addrmap[7] = (cols - 3) | 
0x0F00;
> +		writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 
3) << 16) |
> ((cols - 3) << 24), +			       &mctl_ctl-
>addrmap[6]);
> +		writel_relaxed((cols - 3) | 0x0f00, &mctl_ctl-
>addrmap[7]);
>  		break;
>  	case 18:
> -		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | 
((cols - 3) <<
> 16) | ((cols - 3) << 24); -		mctl_ctl->addrmap[7] = (cols - 3) | 
((cols -
> 3) << 8);
> +		writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 
3) << 16) |
> ((cols - 3) << 24), +			       &mctl_ctl-
>addrmap[6]);
> +		writel_relaxed((cols - 3) | ((cols - 3) << 8),
> +			       &mctl_ctl->addrmap[7]);
>  		break;
>  	default:
>  		panic("Unsupported DRAM configuration: row number 
invalid\n");
>  	}
> 
>  	/* Bank groups, DDR4 only */
> -	mctl_ctl->addrmap[8] = 0x3F3F;
> +	writel_relaxed(0x3f3f, &mctl_ctl->addrmap[8]);
> +	dsb();
>  }
> 
>  static void mctl_com_init(const struct dram_para *para,




