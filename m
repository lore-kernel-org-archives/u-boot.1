Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB89C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE70885D7;
	Sat, 20 Jul 2024 17:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CdQgjMJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C8E885F6; Sat, 20 Jul 2024 17:30:22 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F34885D1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 17:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6ad86f3cc34so16629146d6.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721489419; x=1722094219; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ik3HFmVTikQOenYTvuTv2sUn93Uc+MZMo2x6j31CHgY=;
 b=CdQgjMJrNaTA2jJB4nH0gY3IotPjUXaQvIMt+pGEfPpkWSe/YQGMZA0gjt7QR4kuaT
 24len/TkxkFCRH1Y+ngK0Vu/krYtDN+pU9f43vFe+XmvswLW+MntYX5rGCI1kR+5nJOJ
 V3wNTnHyYDvrgn6wE6zd5fkundUM3zNcjY8Fche5x5gC+fDBKH0vuA7ok3mwc0XuH4Ng
 nC9EyghaZ2IGdu1xahWo0RAmenDacWSyyV1NRdCsuovO0CnK0QCK9sj48mHImJ3xndYd
 QRrKMIRIcL055iriCgPJKYxc+LiP4vfBZjUFJVLjd5h8gBoS+4IbjOhETbEkwIVv7E61
 hp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721489419; x=1722094219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ik3HFmVTikQOenYTvuTv2sUn93Uc+MZMo2x6j31CHgY=;
 b=H33Gl8IwypUR2DSJ51rpxtITjCTL5G/CWLQkZK/hneEi8OOfM6aJO2Fpg9YUtzNZ0t
 m6HBhoq9fzgKM97BgK6hk9rrZXJnaFT6AzRE6bkRwEXDq2bdYIFACNIanaEkcbsUo6fO
 nDLG5jbxhotL2zNdgJVTYeIwSeFowx1ZkulV5+Nx6n1V3UJH9u/RSn4asWz46a3gdbUl
 G5C2y7cS+G0jZ2MkYW/Vb9o5SMrnx3YdbBls0UWHKgWrsZ+GLLepPp/lxmh9JWu+KowM
 UIAeyWT3YYoIgk7HfOY7uzXR6GroTu22M+g8QQ2C86w7rZcqUlCVX4FNeLZMYZaIwk5d
 688g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoZQVZ59YJLyW8cUJvw7z5rMYVogxwXwqUHjY1Dbu39S8igVMOtxol/PDQ1ftrN/6aMO/8ZBnJmRNO8FGop7YA3E0eaw==
X-Gm-Message-State: AOJu0YxNLaNm46QxXVfHuqY5pJ149qQXThIYYM6isqsa3KrrTIsRgovs
 emdupIjE1W2kfWTBNEobxQNAZF7upQ0oqQ6qZ+jUj16sRVpzW2iV
X-Google-Smtp-Source: AGHT+IFdPTEOQqCISL6BXuVtcfFGU3g8m2Yok2gdrlP9CBxagKCFuIoaYLpPIvObfgF7UuP4DoJGAg==
X-Received: by 2002:ad4:5ec8:0:b0:6b5:4573:4ac5 with SMTP id
 6a1803df08f44-6b95a750672mr35231726d6.45.1721489419320; 
 Sat, 20 Jul 2024 08:30:19 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac7bd12dsm18219536d6.27.2024.07.20.08.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 08:30:18 -0700 (PDT)
Message-ID: <424b4660-799c-f4b2-bb22-d1f5c617088d@gmail.com>
Date: Sat, 20 Jul 2024 11:30:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/14] spl: Correct use of CMD_BOOTI and CMD_BOOTZ
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Devarsh Thakkar <devarsht@ti.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-3-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-3-sjg@chromium.org>
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

On 7/20/24 02:16, Simon Glass wrote:
> These should have a CONFIG_ prefix. Add it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 7a0d88076b9 ("Add in the ability to load and boot an uncompr...")
> ---
> 
>   common/spl/spl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 7794ddccade..6f4a8bfb3f4 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -322,7 +322,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   #endif
>   
>   #if CONFIG_IS_ENABLED(OS_BOOT)
> -#if defined(CMD_BOOTI)
> +#if defined(CONFIG_CMD_BOOTI)
>   		ulong start, size;
>   
>   		if (!booti_setup((ulong)header, &start, &size, 0)) {
> @@ -336,7 +336,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   			      spl_image->load_addr, spl_image->size);
>   			return 0;
>   		}
> -#elif defined(CMD_BOOTZ)
> +#elif defined(CONFIG_CMD_BOOTZ)
>   		ulong start, end;
>   
>   		if (!bootz_setup((ulong)header, &start, &end)) {

Reviewed-by: Sean Anderson <seanga2@gmail.com>
