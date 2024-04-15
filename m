Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF22BC00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F9B87E75;
	Mon, 15 Apr 2024 13:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AsCzgIHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EBB187E83; Mon, 15 Apr 2024 13:21:33 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A2287D5F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2da888330b2so11896751fa.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713180090; x=1713784890; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lFI2Na6vdbhrKhJmFntUZaXICOxX4E89wP1g8WhhIXY=;
 b=AsCzgIHrjjOE9cHbfqkcUzFQBBcvGO4fYwocPa+C2qWjZUzsly4NrBjfiGymTkBbhF
 +Ik1VOjiLhzvMuVNCel7e18EuDIOepPyy4ddLj4VtOX3ylCP/Y/HbJKkCWEwVr+Yvogf
 AlsBL6l9HuxR3baVcNnZb1ylBHUeDBk9kO5QeccbWLqOZ9rCba+LHqET7MF7Et433i98
 YJzmUAwrRavgTdjOdm7aL8UYsTDEUKl47luoZIZO+hOTu8N0DmN2ASKg+lavomeaPeXt
 uRwEpV0KSkGQMgjE7S0jXEfC1k5MX6bpkzA9vXieFlI5MihQkrxRueJoKUzuAM38dB1J
 20wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713180090; x=1713784890;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lFI2Na6vdbhrKhJmFntUZaXICOxX4E89wP1g8WhhIXY=;
 b=Piuv+PixISD1LIOCxCyl5VBEGvmd8+Mk3tF9K/Zh7WEFEBJDPgbHwJ5fqpCXldRfRK
 zx1sVBGZbOIK2o+HD7YRLPc69Acvmks+ZlmxyH0uHjlD2PoP4YVkP4BtWNiuN+Mr+GO5
 9su4sUxk7WD2Wg3h8cY3t52g80f0z9o+jBk5RisBYriNkUfdSDV+CroymsfY2B584dqi
 GzK2fDA9E2yeSMxeh0XCJmuwwjFnkXFNounaqCQqKcPzySr5+/vRu7Y4VpTACZ9BWK89
 ydvHBsv9/jNp1KwCBZu5DwQRi7fxwHHm80f+n2dkduZ/hSt/xrFt6ZxjAfdN7z3DpWPN
 or7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVauBp7h00H6O+U8w7oOdUaKrOaboRXmDZqemczgzZnxbXcHm1OQxVYHF3P9cQ4VKcIFbx9pRPNLvwNYOkD6ZuCvgIYAA==
X-Gm-Message-State: AOJu0YzJUNGbIbMH6uzArUo69vVoJa9WGPUpiheYdquuqfCA/qjmv12r
 XdPadyYKob5TZw9cwWAtqXCCkjgmlWpw0Hp7NWRroZCGGFMxAgwbHGm0HBD0O/Y=
X-Google-Smtp-Source: AGHT+IHGo4It66dPc7ef72AqL3a3uhifWmEI9gg9RvUnFdAynuoN59iYMdwua/ziBHuqGyTG2zP5ag==
X-Received: by 2002:a2e:8e88:0:b0:2d8:6ca7:2165 with SMTP id
 z8-20020a2e8e88000000b002d86ca72165mr7216547ljk.46.1713180090255; 
 Mon, 15 Apr 2024 04:21:30 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 fj8-20020a05600c0c8800b0041869d21f42sm2585286wmb.41.2024.04.15.04.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 04:21:29 -0700 (PDT)
Message-ID: <7c40379e-6a59-493e-922f-3690ff0edd8e@linaro.org>
Date: Mon, 15 Apr 2024 12:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] serial: allow selecting MSM debug UART with
 ARCH_IPQ40XX
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, sjg@chromium.org,
 bmeng.cn@gmail.com, marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de
References: <20240415105028.432404-1-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240415105028.432404-1-robert.marko@sartura.hr>
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

Hi Robert,

Happy to see someone working on those IPQ platforms. If it makes sense
to then I'd be happy to adopt them under ARCH_SNAPDRAGON at some point?
I'm not hugely familiar with the usecase here (but eager to learn more!).

On 15/04/2024 11:49, Robert Marko wrote:
> Currently, DEBUG_UART_MSM depends on ARCH_SNAPDRAGON only, but IPQ40XX
> devices also use the same UART HW so they can also use the debug UART.
> 
> So, allow selecting DEBUG_UART_MSM when using ARCH_IPQ40XX as well.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 8b19e2684e..1fe4607598 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -321,7 +321,7 @@ config DEBUG_UART_S5P
>  
>  config DEBUG_UART_MSM
>  	bool "Qualcomm QUP UART debug"
> -	depends on ARCH_SNAPDRAGON
> +	depends on ARCH_SNAPDRAGON || ARCH_IPQ40XX
>  	help
>  	  Select this to enable a debug UART using the serial_msm driver. You
>  	  will need to provide parameters to make this work. The driver will

-- 
// Caleb (they/them)
