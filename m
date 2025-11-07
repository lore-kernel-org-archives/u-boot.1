Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3CBCCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638B083CB9;
	Fri,  7 Nov 2025 11:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="roG9/eDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE83C83D00; Fri,  7 Nov 2025 11:56:42 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78F5B83CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-640c48b3b90so1072067a12.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 02:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762512999; x=1763117799; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jUnabaxHMMlLEGQDrdRQoxXnYjrV1ume8GJdM1uWe8o=;
 b=roG9/eDJGOUnyG0/ofHI+aKdhbe3SfcUGV6/Nax9Hx8/BS7gzFy8dDBLZVN15MtI9s
 5n5+bftxz/ZW7yms+z3Hhzn+eVRgdDhnXiR7XRhj4E4Nrb3H04jyXIDF9icHg5pyR7uZ
 d5I7+NlbkBcrpMTv1SXxtYNeTOS5qq/1rfKEl6e9dssyu9syPK9iI46vXeQg0UCeV+a7
 VBBVmocQzVZqCFl+9q8y6ymYroClgyS5MfoAScYgv+tvOB0O8Os2rnNeZy8pNxLbFaJx
 tGQbhf/CDXPDW3PNSNppTwWIS+vzLRuHLmtf0qGEmz4k+wnPbgupECbdM2QtIn13/DwU
 WFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762512999; x=1763117799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUnabaxHMMlLEGQDrdRQoxXnYjrV1ume8GJdM1uWe8o=;
 b=B1qD7qSX3K4lP4yjN+bghqSiND9u+sG+oxBFx8mluhI8RDF1Ia2u+ZlmTm/tQ+7vXR
 w8ziBapUMihV7Kryg+FNwRJ8noHV2VaHE3wFBbaS9cJgOUuTQugzs/6God5nY2mcTQWT
 M4LStR/gFn31VFVoGMp9HnM0GTFNbeKhrfB2iXnkXQnYINlLy6J8rXKNe9ygZ/30j+Ke
 nWsTJFvXs0EB/nuM8bdOWXiHyA/jhQS7c55Ii8SDfsnRn5eecq2moHG54GUUxpYAayrJ
 Q4U48J1OJA6Rg8xIceVpK8ecRWRKIYcSygZWyUTrCkYvzjdA3QDvt7+Y162IZkWVh6GG
 efMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1ysJMQfrVvwwpYo47G69eh9HwhnXnJKJ+qEfSjADegy/cMpcITOUTtToapRcRirg+MGaDSfE=@lists.denx.de
X-Gm-Message-State: AOJu0YzvzwVI9xHPkfj1+9XBA3AZKgt4N2OadIL4Ve+RTho8ry8OO6LV
 1ijXo8WI5/uYamNl0MFe82BQca+1+6N8yrnp269/WOqBaxtN+iP/h3D8z8MaNHJXIfg=
X-Gm-Gg: ASbGncsAoTZeafTrQVXdDvJYqPTCzQuj1aHKbtc/bb8wO6wb/rrYC7jzVxIdo5OQegQ
 kK3xTGDgQDx6rDt+hDtVx2JLPgszd2+Pj/ZIp9EdRrMjLTiDKlxz4XkymyDO5bPRDZ9Oph1CilU
 /Qv1heVS9KqCFsvXR7cJbF72mB05NJCQRexNLXJvQd5sPJfhXm6yTBvenshZUhOtTEZLIN0uUYQ
 Cat1srZ0HyvtSEwdtfPxpJD252y5ERT9LmfWwTH3sijPhrfIwf3L7lAmeYtbclbbkpecXX/4mjg
 JWjdih2ftuUkHbnafJwTWFO33ShQlutrd4vhtk799VxbjHHUCp/wLOuEl4r4Zgz9odHtPoaZZQN
 dkTK/bngnJAQgWcx8gnfzzHWhZ6JVFPxa9uQKo/c2aHtF60pkNm9ER8Xz0rIXY2fpc0xoryyXYN
 2sBL52LxKespfv2QN6RL5t22IgVwmyxBrIzFLUIfWlfg==
X-Google-Smtp-Source: AGHT+IEK6wN00O7GZ9O7yxN91OUaguB6x0XPvWUivYxed1a5qZbxlk71wQIstYybXHJv+5xKpZkbyg==
X-Received: by 2002:a17:907:1c26:b0:b2a:10a3:7113 with SMTP id
 a640c23a62f3a-b72c099299bmr232905166b.29.1762512999347; 
 Fri, 07 Nov 2025 02:56:39 -0800 (PST)
Received: from [172.20.148.34] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbcadb5sm223600966b.9.2025.11.07.02.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Nov 2025 02:56:38 -0800 (PST)
Message-ID: <68d45e9e-8eed-439d-be9b-9d6f9e13fe89@linaro.org>
Date: Fri, 7 Nov 2025 12:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mtd: rawnand: atmel: Remove timing from atmel_pmecc
 struct
To: Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
 <20251106-pmecc-v1-2-a1f3cf430be9@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251106-pmecc-v1-2-a1f3cf430be9@hifiphile.com>
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



On 11/6/25 13:12, Zixun LI wrote:
> "timing" is unused in atmel_pmecc struct, also it's not exist in Linux
> driver, let's remove it.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/mtd/nand/raw/atmel/pmecc.c | 2 --
>  drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index 7c4e9bd5f9967b119239adf2b39e683ea62b71fd..8fc5614cc0091d3e0f4b9280beee9e684fe2a57d 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -839,8 +839,6 @@ atmel_pmecc_create(struct udevice *dev,
>  	ofnode_read_resource(dev->node_, 1, &res);
>  	pmecc->regs.errloc = (void *)res.start;
>  
> -	pmecc->regs.timing = 0;
> -

I see there is also an unused parameter to atmel_pmecc_create() called
timing_res_idx .
Maybe this parameter was intended to be passed to the timing mapped memory ?

If the timing_res_idx is related and unused as well, isn't it supposed
to be removed together ?

I see it's being called with a hardcoded "2" , does this have any
significance that you know of ? Or it can be safely removed.

Eugen

>  	/* pmecc data setup time */
>  	if (caps->clk_ctrl)
>  		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/atmel/pmecc.h
> index 43f96b2f168c7b88e0c907996f2ae64f8554ed58..88b0d18040e7c48f226c74ce9b5caf93b5760360 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.h
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.h
> @@ -65,7 +65,6 @@ struct atmel_pmecc {
>  	struct {
>  		void __iomem *base;
>  		void __iomem *errloc;
> -		void __iomem *timing;
>  	} regs;
>  
>  	/* Mutex used for pmecc enable/disable */
> 

