Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0F7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9699C88118;
	Mon, 15 Apr 2024 13:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t/8qlDHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B78688132; Mon, 15 Apr 2024 13:22:38 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A5487D5F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41879819915so2076315e9.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713180156; x=1713784956; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hmXKh5B9CrJTr4TUfn8yOq3kZRfgBiiB7KqWBrsg27c=;
 b=t/8qlDHLN7msyJDbqY00EzrdOvI46olqVaLmKHhDQWvrjwV/9HcqGFmf3Rl4hZiVHJ
 YS8sR8F6vi53x3kRM+ojSBAQim0t8p0Y+c56FhQoampyhHg4Ymi2ByL8pcTGphOD0CL3
 1toXOuWOWJAgj2FelWsDchZykOwgbtsnGbX+6B6iknaVhG4Z0aS1hTSOmfCigsvVDe8r
 vAHZ98llj0cR4a4efw1dyy5+h7OSzMJEE+ETJYouRkTDxWrOOIVMbWy4SnBfalcXIwi8
 a62FFRIu0AH4+p3+oJtQVH21ZrYR0dfn6xiUwMkZVSu4Ph6tFiRYF5eX7niJQ1q4clE9
 kbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713180156; x=1713784956;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hmXKh5B9CrJTr4TUfn8yOq3kZRfgBiiB7KqWBrsg27c=;
 b=WwQsuoA7ku7wMpUfRT8MZdkbYLtJ0oHKEYzFqDlLnh4tpl/Nzm1x+fXZvzHtZzOntx
 0IGe5F8xEY36LCMed10BdGlEQL0nLQE6NmI1L1XtgDWBqErZ2LdGUz7UeZ28sPbuyB6r
 VCRIAlIs84btQ1E4epwDqW4H2t7kMkm0ueMbMLqlrYHra2pFwpJBDqUYE8/U5mEUInhZ
 JfVBgCC5ALUWDy/ATdqvWjQHMIsjGjWpWEDtyF36u6+qUzOHp9vT2pXqIViTM8O88B58
 /hG9ZQYwMBKmIPPebOTS5jxiezhz7pkAVIacYylg/hTtGS/+cjN4XzTlcecX5VnLUUc8
 C5lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6/ly7I+M073I6qN03+vz5B2jVk2I3T1p+HIPzOrOyR73CgJa4tgdtsGC7rCsCvWvLSxfFns2xVLYgeN13+6fDIfR4/w==
X-Gm-Message-State: AOJu0YxvTUVjtgMRLOsNaIJVLRaqlvc75IWFUODYV/XpuxJd0V8JEYtM
 MAsQnGZivl83w4quS8oELBjMgkGiegJVSU8KOgHZEvGrldcEQ9XdsW2/PfuIpr8=
X-Google-Smtp-Source: AGHT+IGfMxEYy8ekgH6ov7t33uVkwhUjRiaQhuU6M27xNdaMMQa17+JXwD/BghHKcY3FgZsxqWOFZw==
X-Received: by 2002:a05:600c:46cd:b0:416:9cf8:f901 with SMTP id
 q13-20020a05600c46cd00b004169cf8f901mr6592715wmo.17.1713180155817; 
 Mon, 15 Apr 2024 04:22:35 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 fj8-20020a05600c0c8800b0041869d21f42sm2585286wmb.41.2024.04.15.04.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 04:22:35 -0700 (PDT)
Message-ID: <139955d8-2a09-4f65-8438-1b2aeceb6482@linaro.org>
Date: Mon, 15 Apr 2024 12:22:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] serial: msm_serial: remove .clk_rate from debug UART
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, sjg@chromium.org,
 bmeng.cn@gmail.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
References: <20240415105028.432404-1-robert.marko@sartura.hr>
 <20240415105028.432404-2-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240415105028.432404-2-robert.marko@sartura.hr>
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



On 15/04/2024 11:49, Robert Marko wrote:
> MSM serial in DEBUG UART mode is trying to set .clk_rate, but the
> msm_serial_data structure does not have such property at all, so lets
> remove it as otherwise it will fail compiling.

Well that's embarrasing... Thanks :D
> 
> Fixes: 90023bdfe979 ("serial: msm: add debug UART")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/serial/serial_msm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index ac4280c6c4..8044d38518 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -242,7 +242,6 @@ U_BOOT_DRIVER(serial_msm) = {
>  
>  static struct msm_serial_data init_serial_data = {
>  	.base = CONFIG_VAL(DEBUG_UART_BASE),
> -	.clk_rate = 7372800,
>  };
>  
>  #include <debug_uart.h>

-- 
// Caleb (they/them)
