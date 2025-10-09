Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780F6CCD187
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 09:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D818448F;
	Thu,  9 Oct 2025 11:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Eh3rkHYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 383AA84497; Thu,  9 Oct 2025 11:48:34 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F37048447E
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 11:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so7663695e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760003311; x=1760608111; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HFZ6NQPR9ohq4smQ1H6LMQIhaRZmzpvpJNp9b11M69k=;
 b=Eh3rkHYGUu38yVwWEAity+05fODfsX/iLUbOftFDHdyr3CQ1aHhXhmMg7dBcN/Bayc
 ywexZ+Mr8O/j0z96zB3Fk3A8G7TbqzpK/qUhm+Njq8EpEl5s+ii6JuebnjMahgJ0xckB
 o/0tsVYAwWTiWjWlGOWe3+on7QdjxxUXodfXOaHbsvKFg5hhl3XO7TKpTy/c7CElvgwG
 H7Qh4JroD8nO8kZMvzvtHX9N6PqDlyWg7H/H6xjAYxNx631QN87+BlSexPRXmRc/Vydg
 Oe1OmsUfgD22rCrvmsvKx/EhYnVSWLf6CbnvbSHC0nBN8kn5vaNgE711FCbHGlbl/9GW
 qBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760003311; x=1760608111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFZ6NQPR9ohq4smQ1H6LMQIhaRZmzpvpJNp9b11M69k=;
 b=XGXtyEjnExdZlwFkRYE69e5/jZxVCGaFCF23A9NcQ1p5J9/OclRA00+Wox88GI44aL
 /SPepqFP4IXdwn9GEY3kCpZjMU5Z99n4tpjLcy0EzRmriGLzmjP8q8vmr7IL7Amfbb/z
 RRRrO4QF0rtcYwj+OLwHttWZfnn4F6nVH2hH7I87+XKKKfib5QnCIs3ANqKkPauTUfac
 ZmB7C4nnQer4nLuMJEo3hhlLQCnRmUsbZra7Uof2YshNk8u6oARCm8tANnuIavaiUoVO
 cIKLHAzBH0zTgAXCohUEoxVz9XgTH7rtx0rhOdv1Q5CMzckzkXGDQbYpwnv/vMEBKT0m
 s+hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXauoCVtVlRIv/fYOqbKXdeykoorG0Y4e2HcjrztiL9jPIugl8WXU91hS7R08XpW1HMnS7sQ2c=@lists.denx.de
X-Gm-Message-State: AOJu0YzkRJnm4gWm5/6TxlsBepTMosvNcL1zp/sI7u7szR2eRY1knpLT
 obWXdNsRotKcIge0MRcpiiou7p+V0atPQSaxm7cQk9nJKQqyheREC/7MQNRvwQihsFo=
X-Gm-Gg: ASbGncsmz2mCX2ntzkEkjPcAAzVmjSUXC6/YB9OpD1nNbznsFihv9P39fRfJei5yxx9
 pG0IepWGr8MefPAJJCBgnZXgeGl217Ed9l9C1PBPD0+OcDjaiuLhUQL4TpavvJbBaebj5bBnaqP
 gxzSYf/33mnK2FuEjAf/LmVuj3FWhwOh2Bp+TFo7msUXFA+rbJ2yn5Vucz649pW+5kZH1WI075p
 sgVjYvT66JHY3mHwXj+3VgVGCBKjZwGZLngPlBu5yb3KUJX+tbsYzrTp//sMcSGSU95Q+iWMomP
 MU0Gv4jY8GV9c23QjBApPQ25ktYY0ZeJp28OIXPMrSY5o//ypNOwZCo7hXzFbjvYrhjsCOiBCjZ
 Onpda1P+gJBwelJ5b2CYViilzPSdH8zbAjwMQ5kv5i4fdCHamlHrMpu7eTCD8rppTeJ+SLFEsga
 Rys3E=
X-Google-Smtp-Source: AGHT+IE99wlAOKHR23AhIhfltoE9nL1Br2iPr+1HEQHtnCXi1bsn6hvhykE9ruSbEOmUBI0rkGQdLg==
X-Received: by 2002:a05:600c:83ce:b0:46e:394b:49b7 with SMTP id
 5b1f17b1804b1-46fa9b16597mr42198285e9.37.1760003311412; 
 Thu, 09 Oct 2025 02:48:31 -0700 (PDT)
Received: from [192.168.0.36] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d6269asm76530035e9.15.2025.10.09.02.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 02:48:30 -0700 (PDT)
Message-ID: <e4db9bab-9de2-4810-ab19-7654be60dae5@linaro.org>
Date: Thu, 9 Oct 2025 12:48:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nand: atmel: Rework ATMEL_EBI and DM_NAND_ATMEL
 interaction
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250926153136.3680867-1-trini@konsulko.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250926153136.3680867-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
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



On 9/26/25 18:31, Tom Rini wrote:
> The way that the NAND driver under DM_NAND_ATMEL is probed is by the
> dummy memory driver controlled by ATMEL_EBI. Rather than require that
> for NAND to work both be enabled, make NAND select ATMEL_EBI and do not
> prompt for ATMEL_EBI as it only triggers the probe for NAND.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Eugen Hristev <eugen.hristev@linaro.org>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/memory/Kconfig       | 2 +-
>  drivers/mtd/nand/raw/Kconfig | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index eaee739c6aab..591d9d9c6569 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -14,7 +14,7 @@ config MEMORY
>  	  For now this uclass has no methods yet.
>  
>  config ATMEL_EBI
> -	bool "Support for Atmel EBI"
> +	bool
>  	help
>  	  Driver for Atmel EBI controller. This is a dummy
>  	  driver. Doesn't provide an access to EBI controller. Select
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index aa4bb2a0595c..f083113486ed 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -50,6 +50,7 @@ config SYS_NAND_NO_SUBPAGE_WRITE
>  config DM_NAND_ATMEL
>  	bool "Support Atmel NAND controller with DM support"
>  	depends on ARCH_AT91

Which branch is this patch based on ?
I have a conflict because this line ^^ is missing in master ("depends on
ARCH_AT91")
Is there another patch for that ?

> +	select ATMEL_EBI
>  	select SYS_NAND_SELF_INIT
>  	imply SYS_NAND_USE_FLASH_BBT
>  	help

