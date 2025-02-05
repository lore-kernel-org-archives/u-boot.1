Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F39C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C5C80821;
	Wed,  5 Feb 2025 22:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RsHm31Oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 078E5807C0; Wed,  5 Feb 2025 18:23:54 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3DA80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21effc750d2so962925ad.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738776230; x=1739381030; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n2YrZkw8cWf09ObJ8dJar+u6rxzHX2mF1YPujMC/XmM=;
 b=RsHm31OqZs9F5Qjy74ZalyixjhPqyCUOxBNX2JmiNGsssf0Tti9NT8ke6OSdC2B5aV
 bzarzrkJ7LrQQEksn5cRtTXkaxrzHb4WnRVE7bI8doy1lfs5jeGz6DZByH/2+9D3GVBh
 Cm/yf3hJpVBLa0H5/VYrW+n0FZVnoN1u47uKP+CGye8HYzOKr/SoaDd+FHnEwkroUJXx
 Tg7bBB8mowZGFoIuU4upGaYZLMTCoRvaifBcxj1HXt6JugnRCId6UhoLfpN/DNPaMVtG
 CiYARq8s8yKzWSYlOmf4trZOw2xFbPHobYfn09L3kCxYF6OHDq0Tf2RfgPa98KEc4BDx
 uwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776230; x=1739381030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n2YrZkw8cWf09ObJ8dJar+u6rxzHX2mF1YPujMC/XmM=;
 b=GwxUGcBDdvR19i7bXfBrud1vy4iBUjwMtANhdbMiUBOnOivCneEsCKWKtum5RSp4cb
 sXRdLMRpJbsrEUi3pH5HHZRrxWLxcMrlQiBxWzClWQgXzhNDXX8U5ytg/++k2043I/UV
 iddYDiRQ1HFTG7oswFmSR1nHsi/WQ4IZ0rdCh0KjhVEGz7yFEgXnuNR2rVq38wk9CxBO
 GvxZFN0uEuvESDUVSnUBKqtWXG1Esrn+CIu7rlESPV6nAOiwcC81Ej073rR78EYSO3+x
 K3pgn832OkQ3A9gA6nNwkWjzBvkqWuz3zP+Qln36p+mhjIcjZ1LLTnQPd4Ogndd6olax
 n/2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJw1KDsTmVmXCLMQWE/AoZgh1QN+Fu8uNE2pqoj6B1E11TCUY5paUeVoKsYmvSdmdfPgbfdD4=@lists.denx.de
X-Gm-Message-State: AOJu0YzVm3h4nG9DOTw8xNZEHh05nJERoYGIvohoDeew5ks2Ew2G1yKB
 mVSmlQcXbK7Xl7SgCMnKUT0y3AxMLeD6vX7Mbo/LOmBghddiPlqWoxpELPMgcMU=
X-Gm-Gg: ASbGncsnhgCK876WkdTCLkO7wdU3fvgBPTy1034RPywilrExZhdrCltPZjbBSfC8QX2
 kHSYkbED55If9dfUer4Fsq2U1QVfQVmJ51dkEDlvQdL3oYMkPi4pt0J7YsvnhZxqt//1f+XRj1F
 irixyj2j88JbmKdjOJ0fuMwWyOggejjoe4zH997YiCiuWDhQv+ZV6sErnheKpVoTq/t3nGib9un
 CqA0O8G3XKdjfniiD3g1e92100A+20f9SEY0Vm5nzx+UUAxrQWXw4tVnFTgTIpH3GwXG9EV51SZ
 g+mhFrO4laWDlJMdFq2GogLPhRz4/pmCHGd/OVBVn5u7nfC/QvzE6bo=
X-Google-Smtp-Source: AGHT+IGLLgXyTSsMvNpTKMqP/Mbkyc8Lj8geqsAgQ0CGI1e2vAG+plFdvFz8YvCXrUEFO60LjnT1Fw==
X-Received: by 2002:a17:903:228a:b0:216:53fa:634f with SMTP id
 d9443c01a7336-21f17ed0eb5mr69200885ad.48.1738776230020; 
 Wed, 05 Feb 2025 09:23:50 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de3306012sm117379955ad.179.2025.02.05.09.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:23:49 -0800 (PST)
Message-ID: <6fbe4223-d478-4e72-b9a0-81aad67a6b43@linaro.org>
Date: Wed, 5 Feb 2025 09:23:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 trini@konsulko.com
Cc: uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250205071714.635518-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:30:56 +0100
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

On 2/4/25 23:16, Ilias Apalodimas wrote:
> @@ -98,18 +101,20 @@ SECTIONS
>   	}
>   #endif
>   
> -	. = ALIGN(8);
> -	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> +	.rodata ALIGN(4096): {
> +	    __start_rodata = .;
> +	    *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> +	    . = ALIGN(4096);
> +	    __end_rodata = .;
> +	}
>   
> -	. = ALIGN(8);
> -	.data : {
> +	.data ALIGN(4096) : {
> +	    __start_data = .;
>   		*(.data*)
> +	    . = ALIGN(4096);
> +	    __end_data = .;
>   	}
>   
> -	. = ALIGN(8);
> -
> -	. = .;
> -
>   	. = ALIGN(8);
>   	__u_boot_list : {
>   		KEEP(*(SORT(__u_boot_list*)));
> @@ -136,10 +141,10 @@ SECTIONS
>   	/*
>   	 * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 == 0
>   	 */
> -	.bss ALIGN(8) : {
> +	.bss ALIGN(4096) : {
>   		__bss_start = .;
>   		*(.bss*)
> -		. = ALIGN(8);
> +		. = ALIGN(4096);
>   		__bss_end = .;
>   	}

You don't need to align .bss because it normally immediately follows .data, and they have 
the same page permissions.

You've got __u_boot_list, .efi_runtime_rel and .rela.dyn in between.  Consider if any of 
that ought to be moved around to become read-only.


r~
