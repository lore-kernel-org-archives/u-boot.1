Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154AC1091910
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 19:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A29283FC5;
	Thu, 19 Mar 2026 20:52:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b6PDD1Te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3369983FDC; Thu, 19 Mar 2026 20:52:12 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3433A83FC5
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 20:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43b4d734678so1345101f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773949930; x=1774554730; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IcKTYIMpvc8LmfNCt9BiuQYkv4CYjvFNIi3JyAZki+w=;
 b=b6PDD1Te0y56JPj4xYNKmXBnXEiZwK2M4ljz97yCACU8oeD7r4FV2+6elRTQ+miHUk
 NigYql2cFSPYWUYm2R1DEF8T7f7bJSUduXKq2E3C+GC4Ia/Oi1dAEbZY83mBETO3Zhld
 ZeDKbzdFW60uy4Ez/aBKnrHwwOUvKrqzlC1I3VmdwBtv32QszQVad1O5QfcSoh7baDFP
 TAOYrZFrv30vDBO8Bf/7bWFuwYdhek7PKm8kBf+LzJmftU5KNeVxQDTY4XS44Xf3TdZN
 I19kCjJvHO/XdH4+OxK6h/pKc1zg1seSunfTCUrMYEdBkSDYEi8HymEY8xvjsOR+OyCI
 dC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773949930; x=1774554730;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IcKTYIMpvc8LmfNCt9BiuQYkv4CYjvFNIi3JyAZki+w=;
 b=bcm9N6jdbPgsc9R5p2g7ewaJqV+TgSyc7xvsTyiklgwJLkl+St2oGIvdug/a4ahi8b
 OF3sG+y2Bqeu13s5zld/L2Xtzh7+qmDGcSCA+6wl+a2kmPXYTOIBHqtZNZ9ncWOCuSeD
 FEWDcp8OjV/nO6xR3Xfiw7kcvuD+MBjIl9Jn8iFbSXKb9evVR0UmUpb7qBvhGRzpg0iA
 9B0sO0WMl8ykOhHPIkFuHAEEfNoQmfsbueTcmZQqG7uVNF+LVjqk5OiTuzZrgceuh41r
 y9FlMp/2tRT+Hn+PgRIuGYJtFsTIrjx+Csb3P7qrwZ4rWqBEMe7Gquj3sMClefh6BsJ3
 ydLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4CxffRul3ji3SmRpa2ylFXhU76WEDmMk7emeilCDbdW9InzJt1AqtRIvPffwmw2r4rnGFS44=@lists.denx.de
X-Gm-Message-State: AOJu0Yxzh+Jk935JyQAiHP9NnhMoauJw1ueYGIJOxT66lo/kE+232o2P
 OhHMAnGAk7c/E0CiYHnz3Ika2LZQMiyus9bBDas0gR+d/eoGRx/iIjGqldTju0/x2W0hw3M6oQi
 5pv/v
X-Gm-Gg: ATEYQzytN7p7+V1ba7tm14lls7HJ8jP/NxfJIf7UFR7L1Bw87s8usLlJXl5V5kJYOyS
 nCBcvZAyffMgXggVV9gt8pz8bYiLx5xFFK9S93zMiZsv+KSFHmaWiy5T3Rfw3fLHAOPD9Kp7xfI
 2RW0VVLeG389R7asuQ05cGam1T6sNdabgArk//uJeGT0vsVV/bjZIjyIKBCzwP+anbSMM9BbdEV
 5OzzkOQLBGQq4Mn/rO0zcveMIVmtvoZyAv27nlbHhJT7AMq6OtA/+mfHCSc+BiVXW2XZtAYzj9A
 r2i+XCdMwLX+K9CaiY2L5aRTU3k0wgHl6yRR1wa2Q49gEMJ1qtKyQhP8BhvzlI+SRXbgI576OTm
 2m5Iv/RVBh2+Uu3lZQ7WVrRZ2BIjYF8ON5TNYjQrZImcSkGqaJXAWGyLQMbZtQutqg034yLlCtH
 hNgZ0hyaGsC7+CCm5X6F6VjNbgw4BheD4jT0ZH4fFPsKPEkE/nogGQVCUHgNd+ZPua
X-Received: by 2002:a05:6000:240b:b0:43a:580:f60d with SMTP id
 ffacd0b85a97d-43b64264bc4mr1112375f8f.35.1773949929515; 
 Thu, 19 Mar 2026 12:52:09 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd39.dip0.t-ipconnect.de. [79.195.221.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c27sm993015f8f.18.2026.03.19.12.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 12:52:08 -0700 (PDT)
Message-ID: <77dab58f-f567-4449-b803-c92175fd1c46@linaro.org>
Date: Thu, 19 Mar 2026 20:52:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] input: Correct dependencies for BUTTON_KEYBOARD
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260317012437.4162554-1-trini@konsulko.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260317012437.4162554-1-trini@konsulko.com>
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



On 17/03/2026 02:24, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for BUTTON_KEYBOARD. This needs to also depend on DM_GPIO, and then
> select BUTTON as well as BUTTON_GPIO, in order to meet all its
> requirements.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/input/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
> index 47ce0ea690fd..5bf122c55051 100644
> --- a/drivers/input/Kconfig
> +++ b/drivers/input/Kconfig
> @@ -48,7 +48,8 @@ config APPLE_SPI_KEYB
>  
>  config BUTTON_KEYBOARD
>  	bool "Buttons as keyboard"
> -	depends on DM_KEYBOARD
> +	depends on DM_KEYBOARD && DM_GPIO
> +	select BUTTON
>  	select BUTTON_GPIO
>  	help
>  	  Enable support for mapping buttons to keycode events. Use linux,code button driver

-- 
// Casey (she/her)

