Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9BCC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 15:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9858B86F65;
	Sat,  4 Nov 2023 16:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gY4OE5jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E78586E42; Sat,  4 Nov 2023 16:19:31 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5784186F65
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 16:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-778a20df8c3so199619685a.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699111165; x=1699715965; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WjgEVUuZlPBUmsLlMTFn4SyoO43H3z3M3f/MEGNixZM=;
 b=gY4OE5jzJOgVOFe9+oozpjef1DQ93NZ6+ytHdcGxrIbhnBxKcsrvWDMurdU4YLq7Cg
 I0Swzs2/X0G1im3i+7vpQKAyDw5Dthv1Z3QQCm0sfRxPF293QASbm84r8r9piJNJk8Qw
 LID6tmPFXgNdn2ru//XLuayxQxXH2RjFFFpAstMBHbFRYLlnB+fl/x5scVcAl06kWLGW
 L3QKeYCwhKlXrQKronYdjbHhm6RmH4fo7rrlra9PvWHNzVmk9UaArLxolvbc8RDV7egr
 9rKAb9DcuJkRZno2zLCFqCCUBns9osi75Qc6BKg6UgkUQxQbq2jEWNoccXfEp0hSIss3
 9FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699111165; x=1699715965;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WjgEVUuZlPBUmsLlMTFn4SyoO43H3z3M3f/MEGNixZM=;
 b=S/Bv/O7LT++jZRskM68DP+p3Coa2D7GCZDICwfcqMXXPZVy4KJ6apoAVET+db50mdS
 9xAGYjGtBhaR5RjcY2OinIAbz/Yogr8eX3rmTc8ocmeLPvvtTtEU/79njEqrsPE5TpE6
 J2iuRYIX8Y7FgHqGGUWlNRLIk8MEiMYBY2x3zsCGenG/gfQA3jpNfH91kouTAiLB6Nib
 jqa7eDzN0WWaoRlmyA7TgxxZKF+SdtOoBRyg2zGel2ktgt35S780RykPSFZWku7z43Hy
 uNGui2p54ypiIMgKyO5bWFE26ZRbZyMyKLy5IvVjyXtr8XNWPHATinqU28cMj/6J6tK/
 NcBg==
X-Gm-Message-State: AOJu0YwIbRfQ6e1Wz7gL2Na748KLDAeEfs6qf6vYIJQODe3CQ2bb7jOQ
 Dk6gl3SUTAa0pcn04u0tIPo=
X-Google-Smtp-Source: AGHT+IERPerbiUbgQ5us2N+WgRHE9kp141kPpzTZAIyYGwOUN5rplZgtlwMpjMf9r2+KZwBmqSm3BQ==
X-Received: by 2002:a05:620a:4410:b0:76f:1d46:4a9f with SMTP id
 v16-20020a05620a441000b0076f1d464a9fmr31083023qkp.4.1699111165080; 
 Sat, 04 Nov 2023 08:19:25 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 p11-20020a05620a056b00b007742c2ad7dfsm1655368qkp.73.2023.11.04.08.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 08:19:24 -0700 (PDT)
Message-ID: <5b009ce4-53a0-a2db-878c-3cbf85f44440@gmail.com>
Date: Sat, 4 Nov 2023 11:19:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] spl: fit: Add support for LZO compressed images
Content-Language: en-US
To: Loic Poulain <loic.poulain@linaro.org>, sjg@chromium.org, marex@denx.de
Cc: u-boot@lists.denx.de, abbaraju.manojsai@amarulasolutions.com
References: <20231103143426.3643712-1-loic.poulain@linaro.org>
 <20231103143426.3643712-2-loic.poulain@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231103143426.3643712-2-loic.poulain@linaro.org>
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

On 11/3/23 10:34, Loic Poulain wrote:
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

Please add an appropriate commit message.

> ---
>   common/spl/spl_fit.c | 10 ++++++++++
>   include/spl.h        |  4 +++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 1d42cb1d10..08428660b0 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -18,6 +18,7 @@
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <linux/libfdt.h>
> +#include <linux/lzo.h>
>   #include <linux/printk.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -215,6 +216,8 @@ static inline bool spl_fit_decompression_supported(uint8_t comp)
>   		return IS_ENABLED(CONFIG_SPL_GZIP);
>   	case IH_COMP_LZMA:
>   		return IS_ENABLED(CONFIG_SPL_LZMA);
> +	case IH_COMP_LZO:
> +		return IS_ENABLED(CONFIG_SPL_LZO);
>   	case IH_COMP_NONE:
>   		return true;
>   	}
> @@ -357,6 +360,13 @@ static int load_simple_fit(struct spl_load_info *info, ulong sector,
>   			return -EIO;
>   		}
>   		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
> +	} else if (IS_ENABLED(CONFIG_SPL_LZO) && image_comp == IH_COMP_LZO) {
> +		size = CONFIG_SYS_BOOTM_LEN;
> +		if (lzop_decompress(src, length, load_ptr, &size)) {
> +			puts("Uncompressing error\n");
> +			return -EIO;
> +		}
> +		length = size;
>   	} else {
>   		memcpy(load_ptr, src, length);
>   	}
> diff --git a/include/spl.h b/include/spl.h
> index 8ff20adc28..e07092372a 100644
> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -1016,6 +1016,8 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
>    */
>   static inline bool spl_decompression_enabled(void)
>   {
> -	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
> +	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA) ||
> +		IS_ENABLED(CONFIG_SPL_LZO);
>   }
> +
>   #endif

Please also add a decompression test. I think spl_test_image should be extended to
test all decompression types (see do_spl_test_load for inspiration). do_spl_test_load
should also be extended to test LZMA FITs.

--Sean
