Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A19CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 11:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F64846D3;
	Fri, 12 Jun 2026 13:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EJUjIPyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F05184869; Fri, 12 Jun 2026 13:35:22 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503EB846B0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso7199995e9.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781264120; x=1781868920; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sAPvWKb9pdgARUoE4DvkijAGmBn4WqwgGCeKQ3murmg=;
 b=EJUjIPyAFE9A0FXt9E/8qocSxQii8pDnZ2sDinRS8KG9Nn8OgFVJI3KVTmmqUlBuPi
 R/O5PJm4Wz2kHDvgpANveH+jF38fhLLMqkt8Y3EPvSx+WYtxLyuUXQN4ryBe/YMtstwd
 ebmj9gC/1pOKT15jSWeDnorf+F2tvHf6E0sKQq1eoEene7hRqIQ7pt5d+DMtCfAwoGug
 KmYLvjAiEKEr5c6urRFn9FRwwbf004IrpzQQyzx/j8Oul7wAWl9hQzvTUapLirV1oro+
 dBL2oQoKcBpK8x9x8ET5XLT4cteqCG4sMhjFk9aTbCaImLI2cliuYMu8dyiPUINx91AX
 GUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781264120; x=1781868920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sAPvWKb9pdgARUoE4DvkijAGmBn4WqwgGCeKQ3murmg=;
 b=PsXxL0s9nVtkhUxQvdIZGKhC8PKfrpkTUkwXZDV2CbQGZ3A6cL3pJG3i20uD1d46mT
 voj8VCFdi00X324yIm0Vkr4o4ohZdzWNj/nBLAS9HJQgB1ctvbl7RuaVlUs62MwIxJu9
 thyUWbupMmCMDjpMDislOZdZbznhtu2zbQo0eGFEfum/K3TJnJnU441Z5Lz+Ndnoia1F
 KLvnGiLNbIDpxtPa66xHiyz+CJiLKtBAg99yvcgQYkGMcji8D+WurTKs1usV0lpcw5dx
 2+EOKOhsaZr+OWU5A0mW15uEjFOnplaPHkEqWNYn5/vuqI5D2hoigwfTOlTIn7+rowvs
 mSqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/h1zMXLFvd9v4FByFKNCY2Ot9UcLREhR93TO8Kwv/6/M9zCni8oUN6jCt7ELI6T+RRfTp1uzo=@lists.denx.de
X-Gm-Message-State: AOJu0YwecxjscDnvla7ozc/VGMISBv1o7J9Hjny/WpHmdHbSejB1I+C3
 fXi+x1DL35AGF2ps+cPgMYikMatBQ5gOPEmDrhjYHCD+hkh/NhZ74p03sP0JMqvL400=
X-Gm-Gg: Acq92OHU11U5ZzecCLdwxO/Vd3LwazttyBkyfVa5Avc7qEpKspUyssKzEfueaOVQp1y
 jq6csNZiU5QRp1hs3GPzZTG0WqLhgN/hUO5rDefYL0ArtJRdsyN0A023lcJko+AvsE/V/EOc6hn
 8AfKMxRgDrWlQURC0ug14b7BL5006GYuTduT77p86FPBfgarXYbxGd5xGQyNYB3NpjxS+ZGOBoY
 7r1TxvCead3PAyFY5fr1Bahi4YCDsXcWlPAgVZbfB7P6Gd3HdwsFt4PNwoLjsDEVrRjz05iObaG
 tmT7ojziEKdpx9yvuIAq3ZR6yB/XOy8B7RR8bMS++m95yhGUswcfOfuZZ5EsyJtRezg06VL7zsU
 87+i7RGXe7HAm+Q9QfFw1zbzBjD9j4EAlHwaGSN7C8kXGqs5ZJJP8sllfD/uE5cZmp78jJjQfxm
 4WrVJns5obFoy6pFXV8FOUE4WxTV9hTe4xuV/HD9u6U5gNfHPsqrkcfoyqD+U839A=
X-Received: by 2002:a05:600d:8443:20b0:490:b9c3:6c48 with SMTP id
 5b1f17b1804b1-490ec50ccd2mr21817275e9.29.1781264119603; 
 Fri, 12 Jun 2026 04:35:19 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c9057bsm161945635e9.5.2026.06.12.04.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 04:35:18 -0700 (PDT)
Message-ID: <7d48671d-1100-4c20-a1ef-76fbab25e1d6@linaro.org>
Date: Fri, 12 Jun 2026 13:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260611-fix-ufetch-compile-v1-1-43f2e3239265@baylibre.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260611-fix-ufetch-compile-v1-1-43f2e3239265@baylibre.com>
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

Hi David,

On 11/06/2026 23:59, David Lechner wrote:
> Add some preprocessor guards to avoid a compile error when
> CONFIG_SYS_CONFIG_NAME is not defined.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Thanks for the patch!

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  cmd/ufetch.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> index e7b5d773f5e..ff2d1deb24c 100644
> --- a/cmd/ufetch.c
> +++ b/cmd/ufetch.c
> @@ -60,7 +60,9 @@ enum output_lines {
>  	FIRST,
>  	SECOND,
>  	KERNEL,
> +#ifdef CONFIG_SYS_CONFIG_NAME
>  	SYSINFO,
> +#endif
>  	HOST,
>  	UPTIME,
>  	IP,
> @@ -125,9 +127,11 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>  		case KERNEL:
>  			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
>  			break;
> +#ifdef CONFIG_SYS_CONFIG_NAME
>  		case SYSINFO:
>  			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
>  			break;
> +#endif
>  		case HOST:
>  			model = ofnode_read_string(ofnode_root(), "model");
>  			if (model)
> 
> ---
> base-commit: 53e9c41847c24b422ecd21421204d4e6a0c07d76
> change-id: 20260611-fix-ufetch-compile-ce0e6e86e3e6
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>
> 

-- 
// Casey (she/her)

