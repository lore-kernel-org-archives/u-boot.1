Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AE2C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 11:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3859F885D0;
	Thu, 18 Apr 2024 13:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xrEdgMgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D1D885D3; Thu, 18 Apr 2024 13:02:47 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF591884D0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 13:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41551639550so5170665e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713438163; x=1714042963; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9iW12sXZOB5FRaWx+8lxH93YcyOID2RM5SQhO8ukvbo=;
 b=xrEdgMgO2x4NmGmZQcMG9JPSxMWnTHZGr6U20ZzwnVgbK1zoZJn3qU2dFAf3XV8KVN
 zYHgnaIyJUiYAVKi/++tYoo37jcRdbgBAkZJAw4TWhhGGF0Wv3B+SQQjOdlrUm5IuKmm
 sw6WFUxcn07InW2UnomnCAXWpthnWM6hZuzBjZcPHHN+PJRR82LN740JPXaCfFBp3ZLg
 vaz00lyytWjBLpr7Tn4eX1aTScFH/TzhSKpErpl55OCL5AxoZGLnTvnJYgY6EJENgIIF
 mOeHk3haxzcdRP0ltVsZpObIJbWLKD/FXNTfdLtkrfye0wlzf3BQKQGJMXGoCwtsYj7+
 E84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713438163; x=1714042963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9iW12sXZOB5FRaWx+8lxH93YcyOID2RM5SQhO8ukvbo=;
 b=ao73IYZsNRbUdi0hrCAD51yFmKjZVBcrgj/gyVwb97w0ivT36zKYC1MwLv7acBiJzk
 QOZ5jQzGjDwBwYtNoD3kkbC5vdWWrg1PI9RaL9F96TmBDEfwcbVF3EheNXSPUEAYAY98
 IYoXh65TQzCINshHqWRXjpAABQ8+NzBMLjP1jjVBqZdHGEM8Mf803tHxRR15YtYMOKAY
 wySVknB1Dj+v5W5kiMcKuo9W/+tpU+rB0+iXGN64RJuGA6hTs4kFwq8Vv0r6A9g+ONFe
 bFYq3qGvRn64IrHQ4cWLk0LsdRpXJY5hYqRAptd2sqK8KVcUgGwf21z41nxXOUZDtiRb
 8tcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMBxbXaK6vTSxM4u3h49tSS+9UDB1VrKINwlZohy7nngZIqomg5H4IFEFMXbnmeyJ+zBF7P1xDyH/4ihAQ0wiPL8JkFQ==
X-Gm-Message-State: AOJu0YzYzDD0eZRqDkCVKVE4ANWXlqbGhGfcCZQUlCyPnRP2ekvIvkZJ
 uCgbSV4LT/yXdYoXny0INu7T6g3Wlk1Jd2z/iiGEe5w2OEbfLGMllMaM67SZK/Q=
X-Google-Smtp-Source: AGHT+IHF3M/1Btnd/c2ALk7T97OiP5uyy4sEfC2GACx/3Lvdedc1n1JKpg6DN3g5Zcim5sjUdYHmjQ==
X-Received: by 2002:a05:600c:1d24:b0:418:f8c2:c3bc with SMTP id
 l36-20020a05600c1d2400b00418f8c2c3bcmr5418wms.33.1713438163147; 
 Thu, 18 Apr 2024 04:02:43 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a5d6dc4000000b00341ce80ea66sm1559080wrz.82.2024.04.18.04.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 04:02:42 -0700 (PDT)
Message-ID: <63fec346-81d4-4846-bddb-615887505fc9@linaro.org>
Date: Thu, 18 Apr 2024 12:02:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mach-ipq40xx: import GPIO header from mach-snapgradon
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com
References: <20240418091435.18232-1-robert.marko@sartura.hr>
 <20240418091435.18232-2-robert.marko@sartura.hr>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240418091435.18232-2-robert.marko@sartura.hr>
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

On 18/04/2024 10:14, Robert Marko wrote:
> Pinctrl driver was refactored and moved, but the required header that
> it depends on was not included.

Thanks for these patches!

I'm a bit worried about duplicating this header file, we could probably
move it to the main include directory instead?

Alternatively, do you think it would be sensible to combine
mach-snapdragon with mach-ipq40xx ?

I received some patches a while ago from some Qualcomm engineers trying
to introduce support for newer IPQ SoCs, where they also seem to want to
build U-Boot as 32-bit (something I guess ipq40xx may also do?).

I'm easy either way, just want to get a better understanding of this.

Kind regards,
> 
> Fixes: 24d2908e987a ("pinctrl: qcom: move ipq4019 driver from mach-ipq40xx")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm/mach-ipq40xx/include/mach/gpio.h | 37 +++++++++++++++++++----
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-ipq40xx/include/mach/gpio.h b/arch/arm/mach-ipq40xx/include/mach/gpio.h
> index a45747c0fe..53c6ae0649 100644
> --- a/arch/arm/mach-ipq40xx/include/mach/gpio.h
> +++ b/arch/arm/mach-ipq40xx/include/mach/gpio.h
> @@ -1,10 +1,35 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * Empty gpio.h
> + * Qualcomm common pin control data.
>   *
> - * This file must stay as arch/arm/include/asm/gpio.h requires it.
> - *
> - * Copyright (c) 2019 Sartura Ltd.
> - *
> - * Author: Robert Marko <robert.marko@sartura.hr>
> + * Copyright (C) 2023 Linaro Ltd.
>   */
> +#ifndef _QCOM_GPIO_H_
> +#define _QCOM_GPIO_H_
> +
> +#include <asm/types.h>
> +#include <stdbool.h>
> +
> +struct msm_pin_data {
> +	int pin_count;
> +	const unsigned int *pin_offsets;
> +	/* Index of first special pin, these are ignored for now */
> +	unsigned int special_pins_start;
> +};
> +
> +static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
> +{
> +	u32 out = (selector * 0x1000);
> +
> +	if (offs)
> +		return out + offs[selector];
> +
> +	return out;
> +}
> +
> +static inline bool qcom_is_special_pin(const struct msm_pin_data *pindata, unsigned int pin)
> +{
> +	return pindata->special_pins_start && pin >= pindata->special_pins_start;
> +}
> +
> +#endif /* _QCOM_GPIO_H_ */

-- 
// Caleb (they/them)
