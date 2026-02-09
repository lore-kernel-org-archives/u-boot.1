Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082A9E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60EE183C54;
	Mon,  9 Feb 2026 19:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lFrlBIUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743BF83C61; Mon,  9 Feb 2026 19:49:55 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA048397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so14231775e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770662992; x=1771267792; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vnCyw5RCaYi3pOhnRND+cWUriUyUWfZfz0IRvZ3uZ3M=;
 b=lFrlBIUtLFQoAcLg58jE14T38kHOovlnBlNoaBkDdwuWOb3/oHWrUJRG4G8zLJQg3u
 YLAB2TmJbbM4zVMNPBZX91t0zEaUxbEjZcuES8aAbfQNMQszdlRRcxsft0FFE5SV6iHo
 YaPhtNEBm4q9hHnx8LLWto2cYVGXnBQM6lO6WrKwjxrFt/E4EAfYIYrsZRjtVXUuq9WV
 t+e4Aoa14T0MMwgnhKFXcgvVDzWPaN6ddWGeAVP9yvcWqz7yvgYSiwEH1CA4b40KI7Za
 gA1wHuF/D+eLR/xEsQVn5KgIfO4IBBZbdZtqGl4znio2WPyfLZlgQSgqHXtWcr/8WolM
 /Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662992; x=1771267792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vnCyw5RCaYi3pOhnRND+cWUriUyUWfZfz0IRvZ3uZ3M=;
 b=Nib48RQzdhtw5SEOIRACWYFGdSLTkBDDH76P/iwWgHFywhe11ZnqKQce4h993KfEHb
 +XqXEY+q6x/OWKnsnmud/2iQRtdVXchk2eRcbk+YwkHJxuIVLDf2KO1kwJ5juKKAu3Rn
 cPcmn3YWQzHd1o8p6TzFy3iafuLqy9sBdgmiMrVQ3ZcFN/sq9ubErVFWjyMH4gMIaulm
 0wiGMeNDJuw7LGB0ZPpvyyqL3m3Tr0+Z9l8ZXKqJAUOGm3uFtAsaV64zaP0Rm2k+wy3a
 WoGd64/h+w5TmBYKgOZo0lcx+PZuT96M7yBL8FXwRhRO6HPOtZHWY43Guwny5fYknhmE
 ge7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiz8GmWLyuzQfoTo9OYzj2+6FHhvPtRJXB9NyHEvfelp95tIE4krABKcDBkpdXK+BfZwKUZ+k=@lists.denx.de
X-Gm-Message-State: AOJu0YwJm+g0IgocTF8BL1u51TzZ10DaQV4CkxDD1Ow17jOmA84qa+07
 VlgDmYC8mbEvxA2y8O78zxhxcTxHJLRQGhF34OZEj88Mnhd3Oj7rNnMFAD+L8fVN6UQ=
X-Gm-Gg: AZuq6aIVWgunpyDxbzQTWmgc/O2GaVa6xpT37Ghx8oQyeWQeppZMf8KMw0lj89cplOU
 mTlUqkAuU5hxabk52yIs/VfcYqdGSXw7ruMK3CzolytlXkW/aNfR5RO20uUU23qRr17PmFJ8L0x
 mC2b6wY6ZFsbcm1UjzOpYjHOi/D5ZOIFqzSZwAwa2NHcKGr5x+oEOW6J/bAJ+65n++SwkDaV/N+
 /wFlyGKfjwxjojcX0aGuEj7xDj/AEnJAK3IC2eRSsnLKD/GRYRJ8gbe4jbK9KQY5vCM7Sj+nqOx
 UX7NxdZN0rjuGCGdVOTzcpGiI7zrPRqmyen2CX5AUQ2NaX5hrKLFrOsLCo9QiWnp82t5gzO/2nn
 VIG2x03GKFndXRnIvIBeV5Ow+EVyLaZcoQpLcDTeyApqFZi7gpKpi71+PoDocme8AL7aSxTNmKU
 E9j7Y8+0MzkUHFPb4VvYzUFPlqwzWyDaKcnl3e+iWgiz61/7NzgQ==
X-Received: by 2002:a05:600c:1912:b0:482:df17:bbbc with SMTP id
 5b1f17b1804b1-48320966cf7mr138222355e9.20.1770662991672; 
 Mon, 09 Feb 2026 10:49:51 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483228ed4f8sm217720015e9.0.2026.02.09.10.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 10:49:51 -0800 (PST)
Message-ID: <2aa39055-ea59-48ba-becc-39df8f62540b@linaro.org>
Date: Mon, 9 Feb 2026 19:49:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mach-snapdragon: of_fixup: Add OP-TEE DT fixup
 support
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, neil.armstrong@linaro.org, jens.wiklander@linaro.org, 
 ilias.apalodimas@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
 <20260127062341.723966-3-sumit.garg@kernel.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260127062341.723966-3-sumit.garg@kernel.org>
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

Hi Sumit,

Thanks for respinning this.

On 27/01/2026 07:23, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for OP-TEE live tree DT fixup support which enables U-Boot
> OP-TEE driver to be probed. As well as the EFI DT fixup protocol allows
> the live tree fixup to be carried over to the OS for the OP-TEE driver
> in the OS to probe as well.

The EFI DT fixup protocol hook seems to be missing here?
> 
> Note that this fixup only gets applied if OP-TEE support is detected via
> checking for OP-TEE message UID.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 35 +++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 5b6076ea8e5..644afc22d88 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -25,6 +25,7 @@
>  #include <fdt_support.h>
>  #include <linux/errno.h>
>  #include <stdlib.h>
> +#include <tee/optee.h>
>  #include <time.h>
>  
>  /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
> @@ -164,6 +165,37 @@ static void fixup_power_domains(struct device_node *root)
>  	}
>  }
>  
> +static void add_optee_node(struct device_node *root)
> +{
> +	struct device_node *fw = NULL, *optee = NULL;
> +	int ret;
> +
> +	fw = of_find_node_by_path("/firmware");
> +	if (!fw) {
> +		log_err("Failed to find /firmware node\n");
> +		return;
> +	}
> +
> +	ret = of_add_subnode(fw, "optee", strlen("optee") + 1, &optee);
> +	if (ret) {
> +		log_err("Failed to add 'optee' subnode: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = of_write_prop(optee, "compatible", strlen("linaro,optee-tz") + 1,
> +			    "linaro,optee-tz");
> +	if (ret) {
> +		log_err("Failed to add optee 'compatible' property: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = of_write_prop(optee, "method", strlen("smc") + 1, "smc");
> +	if (ret) {
> +		log_err("Failed to add optee 'method' property: %d\n", ret);
> +		return;
> +	}
> +}
> +
>  #define time_call(func, ...) \
>  	do { \
>  		u64 start = timer_get_us(); \
> @@ -178,6 +210,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>  	time_call(fixup_usb_nodes, root);
>  	time_call(fixup_power_domains, root);
>  
> +	if (IS_ENABLED(CONFIG_OPTEE) && is_optee_smc_api())
> +		time_call(add_optee_node, root);
> +
>  	return 0;
>  }
>  

-- 
// Casey (she/her)

