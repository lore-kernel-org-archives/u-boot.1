Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF70C52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 18:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BC988418;
	Sat, 17 Aug 2024 20:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SfpB9Mlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E638845A; Sat, 17 Aug 2024 20:18:43 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06D188395
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 20:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4928b5531caso1066428137.3
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 11:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723918720; x=1724523520; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=heOC2fz/9vBzIG23WJpn9eqhnOoQg0NIR50oRGwucMM=;
 b=SfpB9MlwypPp1Nr07oeic96DjeKNc2lcKil2LQcxSeSuHYjIyrNHlt1zydOQ//VTpn
 gvxVPxem4jCbGr1k3uxe9RxVpXkpJXbP+ccF7j9FNKGiRrI9utkF3YA5BHoA708cD9Zi
 rmdBHm09V1SOyd0pmocC8AsvNNymdNPUx7TN0LJLOhaJwoWYBRLicoMRCWwzcAp0boZH
 U+FUW/WXZzj66xErnPHsHICcgWknGRSz7T1DJBaDrCDpC60GHMYo1aQZkq+CwMF2ezbp
 H3aNPgybHEpUxO8G0Vd5JeE0ai/hOab4ZPkDe6z1oB1iDPL+ITEOKrxauv2dOCBE1IgO
 gu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723918720; x=1724523520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=heOC2fz/9vBzIG23WJpn9eqhnOoQg0NIR50oRGwucMM=;
 b=udZunrODm4+ZePCwdSpSfQb8MB+aYOuuIUxW55ry07nI0RALCqlZRuzJFBUbjvMxAx
 qR72lqOcmit9+lh7OQDqc2bSSP93fSWpChsBVrHyAa1CLGpLes5c647qJML/HPWYxovk
 XNnLTGzmTqDGtx7vNbUMGrEY4UtG/cR9PfD444Dx0mgbSyQdvbIajzYoGRCyMHUAI8/H
 gbsd3S5Ya3YeCtSfwzkuVMDiMbU38dOlQSM2GjZJ2z1yDmLYw32j28kLCAtUbt0mlizW
 Z+ISqzQ5LSzH+/fdDLUbOa8bBXrRRmsKY/zhWpTI1E7jq6Uq4C9qUTCQaTCpIsOFgvHX
 kG/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrXO+z1pZKvwHTf1cWFDpwcL7On5YTHXPGrj4a/2yylMoPEP8hVpLu9zLUMDwRnTyo6l0CYLI+YS3P/Q/3Af25zr+70Q==
X-Gm-Message-State: AOJu0Yxdu+qEphVCSD7f2ai6mQgSLnHu8R2fMBi3/QSN8b0uKgLBTvNR
 MU4cHfUBVosl62V25fCmLwaVpLqNL3MmFxwDojKwZTMAz1v0j/It
X-Google-Smtp-Source: AGHT+IGnthjqeRuGR2pBCfJXgRrG5jks+7hGw5hIw31vab57xmEjPVNm2mw3CEYdxO/ZSl5RxbyWMQ==
X-Received: by 2002:a05:6102:3912:b0:492:aa42:e0ce with SMTP id
 ada2fe7eead31-4977997cd15mr9057556137.20.1723918719713; 
 Sat, 17 Aug 2024 11:18:39 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff109f9asm287610985a.119.2024.08.17.11.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Aug 2024 11:18:39 -0700 (PDT)
Message-ID: <10d27df8-d581-0ac0-9b50-50114c7baa20@gmail.com>
Date: Sat, 17 Aug 2024 14:18:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spl: fix error handling of spl_fit_read
Content-Language: en-US
To: mailinglist1@johanneskirchmair.de, u-boot@lists.denx.de
Cc: trini@konsulko.com, Johannes Kirchmair <johannes.kirchmair@skidata.com>
References: <20240816073332.279025-1-mailinglist1@johanneskirchmair.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240816073332.279025-1-mailinglist1@johanneskirchmair.de>
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

On 8/16/24 03:33, mailinglist1@johanneskirchmair.de wrote:
> From: Johannes Kirchmair <johannes.kirchmair@skidata.com>
> 
> Returning negative values from spl_fit_read leads to u-boot crashing.
> The return value of spl_fit_read is compared with an unsigned value.
> Returning negative values leads to the check not detecting the error.
> Not detecting the error leads to crashing.
> 
> Returning zero in case of an reading error is fine. It indicates that
> nothing was red.
> 
> Signed-off-by: Johannes Kirchmair <johannes.kirchmair@skidata.com>
> ---
>   common/spl/spl_fat.c | 2 +-
>   include/spl_load.h   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index bd8aab253a..345bc55149 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -53,7 +53,7 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
>   
>   	ret = fat_read_file(filename, buf, file_offset, size, &actread);
>   	if (ret)
> -		return ret;
> +		return 0;
>   
>   	return actread;
>   }
> diff --git a/include/spl_load.h b/include/spl_load.h
> index 1c2b296c0a..b411d9daa1 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -17,8 +17,8 @@ static inline int _spl_load(struct spl_image_info *spl_image,
>   {
>   	struct legacy_img_hdr *header =
>   		spl_get_load_buffer(-sizeof(*header), sizeof(*header));
> -	ulong base_offset, image_offset, overhead;
> -	int read, ret;
> +	ulong base_offset, image_offset, overhead, read;
> +	int ret;
>   
>   	read = info->read(info, offset, ALIGN(sizeof(*header),
>   					      spl_get_bl_len(info)), header);

Does [1] fix your problem?

--Sean

[1] https://lore.kernel.org/u-boot/20240731130913.487121-1-fventuri@comcast.net/
