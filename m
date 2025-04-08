Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6385FC369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 12:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5BC682F50;
	Tue,  8 Apr 2025 14:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LJD3SmNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A7783281; Tue,  8 Apr 2025 14:26:56 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B588082EFC
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 14:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so3201676f8f.1
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744115214; x=1744720014; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hyasi1/SZtYcMqzbNvuUcCHqdzte6koaJQdbMTF6ADM=;
 b=LJD3SmNGYv+33/nSVDWOXwXR/pIKiMwN+j6n94nCNPd153B9TlHgNbkazNn9z+poit
 2lj+bEllEWAOYxrekUEBkH5DfqukG8wtvluqP0dm177nKpV2giPSv4FuDGTw5n+K9vlx
 ww9b4lrP7j++9KwzSgVhO5YTCYnQxh5A2OVMWQ4pyUjUfU9nrlPfQQNLVujA9HnMiBNn
 eLNLSpMJCQR13JztoeXynpOmiyH7jHlCDnzs7g+9x3HEHWLPCFW9DrJJX5VHqb8T72AI
 BXe1zlKgLJDancFw0QUIY/qGzSyVX40syMF6oTaYL4oH4aaJN+LBh6rK8iw4Dstq3pHc
 FpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744115214; x=1744720014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyasi1/SZtYcMqzbNvuUcCHqdzte6koaJQdbMTF6ADM=;
 b=r/4m/3YcxP9D2wvZWt7U0+3HrrEUyLa8K3pwQae6/wuWctf54O8keYniqm1bP7r7ZD
 rM3nlBllpJvJT7m/gIYY24FgHTQ9p47MEAKswhFPwJm3E/cw5FlF8i/0Y4s0yoENhYm2
 T9kTbo3PKmhSWsSlml5FpmCKX1WksrNpLh7TgV/0Vx5oqRa4MVeSwt8onYd96xTkQQDL
 Xicly/JkSmr5lwBNB80OGmdD8xqej9RgvdNVwGAY68MjKcCiTILLi5ABXdMTPHe+GYGs
 FdHBh/34//5EGqJzNGwvXulTWcPchIhKz6CHYI0+gKMKMyak3h2r3P4Z2asr3BMo8Xwl
 e/uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/cnFGX0DwstRRlwpiw6sHQIX5DxsVxmp/P8psjZrVWXoy+9IjeZ3aK2oUD5YnWWfPxJfs+r0=@lists.denx.de
X-Gm-Message-State: AOJu0Yymc454dE6ibmhLOTFlKECeEF1mg0Pgo2aqlk3YVyUHcdscQaLi
 pptIyeZOPU1inpoli4MEds0Zjl/Dls0mX5BGExeyByAUnQqYE7VMpg4Eelb5FAU=
X-Gm-Gg: ASbGncuuJnDE+OOlXl+h+AbiSpV98MvAkI7XZ44+DM/YA9neFgjlq+OrT1gDaKQ4Y7z
 2v9FMF8Sv/8iJplwbVtxLbdAD5En0f6CtByB/APUppoC824dlNukIoNRMtFwuogEZtHClVHhhRn
 OjJQxjJ2KxZ5046e4MyEClr/IN7YclX3XP6mIqYxE9FqgpSFt7de6C1y179k71BGbKqCF3RFGYL
 tu5BRfGhjLEgclGMkQ18+o4voG7ECMIk+Jfssai+1A4jSl65UPCErka8L+836/nLfb4A99JneXW
 lQSQfT9Ebynxl6SToIVr6Zi56ewSiJHXwRPDuetTuJzpa5bQtdZ2NmxrwVPPZNFDYuTTIRIO
X-Google-Smtp-Source: AGHT+IEc2nDKLpFSZhwWgTs2tndnRhLNRA7Day7NwskVoMK/PrdYAsq/8OJPEsB+F2FlYAN8Nm38xg==
X-Received: by 2002:a05:6000:440d:b0:399:7f44:5c74 with SMTP id
 ffacd0b85a97d-39d6fd06920mr7751286f8f.55.1744115214159; 
 Tue, 08 Apr 2025 05:26:54 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1662feesm161113535e9.12.2025.04.08.05.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 05:26:53 -0700 (PDT)
Message-ID: <1eb6a7b7-1e87-41e6-90bb-79b4c2cbec6a@linaro.org>
Date: Tue, 8 Apr 2025 14:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: Add CONFIG_SKIP_RELOCATE
To: Jesse Taube <mr.bossman075@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Richard Weinberger <richard@nod.at>
References: <20250402003738.1241719-1-Mr.Bossman075@gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250402003738.1241719-1-Mr.Bossman075@gmail.com>
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



On 4/2/25 02:37, Jesse Taube wrote:
> Add a check for CONFIG_SKIP_RELOCATE in reserve_uboot to skip the
> relocation of the U-Boot image.
> CONFIG_SKIP_RELOCATE skips relocation of U-Boot to the end of RAM
> allowing for systems that have extremely limited ram to run U-Boot.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>> ---
>   Kconfig          | 7 +++++++
>   common/board_f.c | 7 +++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 6379a454166..f518768615f 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -443,6 +443,13 @@ config TOOLS_DEBUG
>   	  it is possible to set breakpoints on particular lines, single-step
>   	  debug through the source code, etc.
>   
> +config SKIP_RELOCATE
> +	bool "Skips relocation of U-Boot to end of RAM"
> +	default n
> +	help
> +	  Skips relocation of U-Boot allowing for systems that have extremely
> +	  limited ram to run U-Boot.
> +
>   endif # EXPERT
>   
>   config PHYS_64BIT
> diff --git a/common/board_f.c b/common/board_f.c
> index 99616fdac80..d51696b8eda 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -476,6 +476,13 @@ static int reserve_trace(void)
>   
>   static int reserve_uboot(void)
>   {
> +	/*
> +	 * This should be the first place GD_FLG_SKIP_RELOC is read from.
> +	 * Set GD_FLG_SKIP_RELOC flag if CONFIG_SKIP_RELOCATE is enabled.
> +	 */
> +	if (CONFIG_IS_ENABLED(SKIP_RELOCATE))
> +		gd->flags |= GD_FLG_SKIP_RELOC;
> +
>   	if (!(gd->flags & GD_FLG_SKIP_RELOC)) {
>   		/*
>   		 * reserve memory for U-Boot code, data & bss

-- 
Caleb (they/them)

