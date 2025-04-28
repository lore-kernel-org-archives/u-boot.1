Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE3BC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386848219D;
	Mon, 28 Apr 2025 19:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a993d07B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A3182A53; Mon, 28 Apr 2025 15:58:05 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61AC082A31
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso30498715e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745848683; x=1746453483; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VH9WWmyHQK/rJhk+Gq9InhS42Ghml7LTlUroEhk88S0=;
 b=a993d07BUV/VxWZCfo0epmt8dxcq4GrcDYy8MwQRke5XlfvC3QFRzds0WoUJ7TRejY
 +7TQ1U/628A+FxAM1eF6axrjLmsdb/k9w0Xl2QZmvmKCyPSDX5MtiiTNc5kJl2Lgg3EV
 lHRr3qb68BnIrq/h8JGuiqV78zzjAsSuVPD37Zzy2C7UTSkRj62x5xFtTLGg1hj7vqBB
 Hkf/p86fc16IrECvinCwGnkED3Mu6awhD69GhqJRszqhxXGf+sGRyYgpyd0Fz9TwQ9Ec
 9NgOdWLnaAy5FkWelajD64g1ODP3oF3SkAvX/LEzBkShUbmVju3XQaNDVmisN/BqWkwU
 qUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745848683; x=1746453483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VH9WWmyHQK/rJhk+Gq9InhS42Ghml7LTlUroEhk88S0=;
 b=Q/BgaBkcFRUdJFbxOcPjEf4wJJ3V3HzTa+wkX6Zd1fMIX5YLv/cCJFIgdYtjee9UfX
 vWC5kvqCnYBKYxy8MTPuL0wmkolrj6+ssXZvoJSJoEmD9yrAcuZvgEvPyh3CoAZpbR96
 5dodsGsnLA6UZ74pWRYGwkwrxYwoTy8mMKQQj/KE/Cr1l4scfoSmeenOWx+UArksNPLm
 LF9X8Zbaw+ua0XEhmRl62fEM9SFVrZaHh9r249Qu9NHPmPANa7CXBFfjwO5RSrYhuEHi
 MSj/x3SuaolRgKFM6LvunpJQowoLv9Jd+KQeyGGVMsikgzzBm+IauYHB0KcFq5HCYSVr
 st5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx0pgYN3fpdGpFl1TWaTxHa9CypdPSCUGteYpE3AS2ZH4pVPhzEfLiA5JFw7JBWawGcBj3Hkk=@lists.denx.de
X-Gm-Message-State: AOJu0YwbnZf3jOL3ZBI5nfTvxzD9Cf6N6nTPp1/wtVusU1QT8FibHyyy
 Zf7AVsp6s1JFefjaEY6cuwUd7muzDkC6LP/pgcplk91iacZVIsOp4o0A034xw9U=
X-Gm-Gg: ASbGnctGFVLFvs2vrL7YqtnqvDxyD4kAPS02cl6z1xoYJXwZcCeawsxm0jEBBW6b0IG
 kykHhmOWA7/4g2ETWG+22rwSEvpslZ0iVzyHHAjqy/FQfR7E/TORG6D26m0t+z5lCKsSd3TL2Wc
 VsDXnxEbOVNzGWK9GsC7Y3JU4rEBeMRTgWvQY9FUXA4oL2XUtAMkr7oPP4Tg5DN+HjcQJtKdLaM
 qU52sw6O9WdbNJm/RsMsGygxcPciXhaJ5wh/shskz00nWAW6WJXmLLmyMyLsYxNvR+WSv5hYD/h
 CbOB+P3GLGU8l/+IPDeUoOWQ+bR/jl6Y4QcDwEswFL+Xjvr9FHnIS4rfZw3LgkF4TX1qKg4=
X-Google-Smtp-Source: AGHT+IFP6h+mgeslI1Ijmg6p98FL4sxQZcvM+nZqH2F7BwqcpPBQqOO6/x+OQTyNzB14VTveVRaOLg==
X-Received: by 2002:a05:600c:45d0:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-4409c4de02dmr132758955e9.11.1745848682877; 
 Mon, 28 Apr 2025 06:58:02 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac26dsm158188895e9.21.2025.04.28.06.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 06:58:02 -0700 (PDT)
Message-ID: <f39969d8-b1ab-4972-aaaa-8d790d2d2e32@linaro.org>
Date: Mon, 28 Apr 2025 15:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] mach-snapdragon: Do not define reset_cpu() if
 SYSRESET is enabled
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 sjg@chromium.org, ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 me@samcday.com, marex@denx.de, robert.marko@sartura.hr,
 seashell11234455@gmail.com, ycliang@andestech.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250410120208.4142087-2-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:31 +0200
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

Hi Varadarajan,

Please rebase on U-Boot master.

On 4/10/25 14:02, Varadarajan Narayanan wrote:
> If CONFIG_SYSRESET is enabled, the reset_cpu() function defined in
> arch/arm/mach-snapdragon/board.c conflicts with the definition of
> reset_cpu() in drivers/sysreset/sysreset-uclass.c resulting in duplicate
> symbol error while compiling. So, do not include it if CONFIG_SYSRESET
> is enabled.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   arch/arm/mach-snapdragon/board.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ef936aab75..2254e0b55a1 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -187,10 +187,12 @@ int board_fdt_blob_setup(void **fdtp)
>   	return ret;
>   }
>   
> +#if !IS_ENABLED(CONFIG_SYSRESET)
>   void reset_cpu(void)
>   {
>   	psci_system_reset();
>   }
> +#endif
>   
>   /*
>    * Some Qualcomm boards require GPIO configuration when switching USB modes.

-- 
Casey (she/they)

