Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903B8CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C7F882FD;
	Wed,  3 Apr 2024 14:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kQ5ADpfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469448822C; Wed,  3 Apr 2024 14:27:44 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49D1188356
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a4e39f5030dso653466966b.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712147262; x=1712752062; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NIBDVa8P9ggiI6A82ZKXGf0jR7vzhX8g1Lhiv+5duKM=;
 b=kQ5ADpfX1VQ3RZvM/dFx67t8WtDtybCuE4jnLFmUGtQxbkAd+g4EaRoe5/Du3JqJUR
 nRUJN6ni/nxuSGnaw1kZ7o2SENkSrhyGonEwcDgk/sC1rVKUEUjigJhw5fUSTEIGQN9u
 ZcunJgpwiJjPBohBKpekBEygiPiouhCI+9XxiIkuKjwdnF8FVhlMpcVPFQk0w6Ty4hyn
 QmbS3c0KSIhpyW0Fh8BbUfIwIxUEuZuLCBx5TI92fOYIi78R/Ppe+JLFi7kwfPNGBj66
 zp/pYuugyPtlh9nXPSzZLQHv+cJs3SgUEQ6aSSrJ/XhxbBXdJt/0g9Aq087yi7MaQhaG
 9DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712147262; x=1712752062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NIBDVa8P9ggiI6A82ZKXGf0jR7vzhX8g1Lhiv+5duKM=;
 b=dLG+ZFUCkj2AASJLXr2daDqbSd5GdrVSOZNvYaHDXYXlPlYmy2rmPcPP/eTSYnukwp
 fty6TYPJi+Q19xR07MGkXLwLDbFW4eqwEcdsdBY1i/eELa/MUHO1CdmvHimUhDefs3Io
 lFzkhjlT5bM5iA506xDH0G9QGTt8s5eLsjj6uOJw03+JwojXQnFKG1u2/uUjHSpadTGO
 Drj/PhLjiN/p9B+HqVv01FGK2ArhGs/u0L8gEbULbkyFmQUjGpL009v2sphx6LfKHnNw
 Ucqbvh4qHq+03Y3Lq5+OQKcFgfMhVDHI7A3ZX6sQPCDjpKIqSKzZ9zVkJeV4PiXYmyL7
 e9nQ==
X-Gm-Message-State: AOJu0Ywh62Ctvt/Ew4VAeo4Dj8XTzMo0HU78oc0LsYIJMee5XjNK8Rsh
 vbKYJTlfFtYh89CrUO1/AXJ7JUVJqB+wAWouFDAUeKlGXeVQar+Yfdx8p/MDjx2IvP3EPJ9Ofca
 mlt4=
X-Google-Smtp-Source: AGHT+IGO84CbbGU1HRqTi1dMOumhTg574WDlEDVV+wqynHWAkRyHrle2djRxFXCKDwdL+zkZ2KmI3A==
X-Received: by 2002:a17:906:384d:b0:a46:a1d0:8451 with SMTP id
 w13-20020a170906384d00b00a46a1d08451mr10597057ejc.16.1712147261720; 
 Wed, 03 Apr 2024 05:27:41 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::38e6? ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a170906581000b00a4a3807929esm7649213ejq.119.2024.04.03.05.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 05:27:41 -0700 (PDT)
Message-ID: <aaec67e7-b711-4ad3-927f-bb9185f4d8b4@linaro.org>
Date: Wed, 3 Apr 2024 14:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/16] usb: gadget: UMS: fix 64-bit division on ARM32
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
 <20240403-b4-qcom-livetree-v6-16-130f8f50b538@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-16-130f8f50b538@linaro.org>
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

argh, forgot to drop this patch again, will do so while applying.

On 03/04/2024 14:07, Caleb Connolly wrote:
> The patch introducing support for dynamic sector sizes changed the types
> used in some divisions, resulting in the compiler attempting to use
> libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
> lldiv() to handle this correctly.
> 
> Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   drivers/usb/gadget/f_mass_storage.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index d880928044f4..ef90c7ec7fb5 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -239,8 +239,9 @@
>   /* #define VERBOSE_DEBUG */
>   /* #define DUMP_MSGS */
>   
>   #include <config.h>
> +#include <div64.h>
>   #include <hexdump.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <common.h>
> @@ -768,10 +769,10 @@ static int do_read(struct fsg_common *common)
>   		}
>   
>   		/* Perform the read */
>   		rc = ums[common->lun].read_sector(&ums[common->lun],
> -				      file_offset / curlun->blksize,
> -				      amount / curlun->blksize,
> +				      lldiv(file_offset, curlun->blksize),
> +				      lldiv(amount, curlun->blksize),
>   				      (char __user *)bh->buf);
>   		if (!rc)
>   			return -EIO;
>   
> @@ -942,10 +943,10 @@ static int do_write(struct fsg_common *common)
>   			amount = bh->outreq->actual;
>   
>   			/* Perform the write */
>   			rc = ums[common->lun].write_sector(&ums[common->lun],
> -					       file_offset / curlun->blksize,
> -					       amount / curlun->blksize,
> +					       lldiv(file_offset, curlun->blksize),
> +					       lldiv(amount, curlun->blksize),
>   					       (char __user *)bh->buf);
>   			if (!rc)
>   				return -EIO;
>   			nwritten = rc * curlun->blksize;
> @@ -1058,10 +1059,10 @@ static int do_verify(struct fsg_common *common)
>   		}
>   
>   		/* Perform the read */
>   		rc = ums[common->lun].read_sector(&ums[common->lun],
> -				      file_offset / curlun->blksize,
> -				      amount / curlun->blksize,
> +				      lldiv(file_offset, curlun->blksize),
> +				      lldiv(amount, curlun->blksize),
>   				      (char __user *)bh->buf);
>   		if (!rc)
>   			return -EIO;
>   		nread = rc * curlun->blksize;
> 

-- 
// Caleb (they/them)
