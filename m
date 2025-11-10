Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B109CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 11:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C10B839A5;
	Mon, 10 Nov 2025 12:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YapMABde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC236839C6; Mon, 10 Nov 2025 12:52:02 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BBB83980
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-786d1658793so24974007b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762775519; x=1763380319; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NYhdCYJR6JaLWFu7XszOFJ8EUkm6FIm7j+rmbJue3As=;
 b=YapMABdejH5CT85zOL4zytwLDLDWubYfWQaTh9mYRArObSMDNr/wW+ZPBhyKmOX0NZ
 5WYTFYZGNfFQ+j/3m1+5hO7HTmd4PytmbDuxsSayvgbLjKDssDDA/P7TAUUQRwQM81+5
 X6VgRUoJlrdrhKG8y0qa1bUzVKXJ5Bi8Fhu64uJr8Fm1eWd0xOQaECI7Vt8Dtl+1GT2G
 7Wlci+I61pwZ4Ke+mkYmsmiVQVg1/47DvruecOimZeXiOwhs76omRBBs9vPV0WMSXFUT
 2yJkzhRfvdhPru4ukMuy0SK1ZiS35uOJdDXI7xBmNWXhD3uUDhXUBAyVJ6mZAT0X3nuO
 9YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762775519; x=1763380319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYhdCYJR6JaLWFu7XszOFJ8EUkm6FIm7j+rmbJue3As=;
 b=YTGvL35KB1oRr2U9pi2AHdItmEDt8jGTgk4env2Xj2ZhWImHrtLxDctQyyc9OL083E
 ADh68BWt5xlnjOsbrHsvRDu2yzII6NdV2WOqswrU54UNevYLorqkHMSZKSVLvwiLcwMh
 6JbXv2l6qt5VJ8p+MlH/j/AJQoLD1cE3aEu+LaBMnCXuaZQ+0vbdJEzK3wsPhoThJ3tf
 rKN9RO1wssgdGjR9WorImITrcqPgCD+Q6Flxib5Og1U1HhEH4gc5tljfpuaFZen8u5TW
 loQGrYFZZZ2HmeihrDScvoYzcisTiLprcCy6BSQuwd35FjmhpsFztSoO5X/YG/Jv0fot
 +pBA==
X-Gm-Message-State: AOJu0YxksF5NdbKw7Aq7A8tBsHk5OI2Bwb2l3TxhOmmmbdn7vnZlGC68
 z3alDQjsF3e5yFOeBpeW2Z/RoXm3bfB39rHqRL3zOVB7tca4cqEMBkiPWmc9qIQdO60x28o6c3W
 bv7DncBkoOCdo96K+jMo+UAxnyYNE6UBxkP7RC5nLWg==
X-Gm-Gg: ASbGncvT/padoU6J9RDpc8+cofKjeeetZ0Pf4KG4Gzf8QGHyloJeB/tgconqPHcaSWh
 PCYHzaYodJjai7HyBX+oqQKg2myOiJxnYN5KSd7Koy2p30RTRv21SJXtPP5SWEGAZ01kiYS8BIf
 D7M9u/xHhu/kcsw4BpRIcACY9M0iAbCkd/z0uAsxlK2xuqvY4jMrsusQvVczZC/hUlhQykK/+yO
 9a7PAhzux+aP7SXHHFwDXeukXKqel/pYQb0EMifCgssMdKBMzX5/D7eX9TdAhYpBinGrzgzysl0
 JWdyC//ER7ojsEI5XjfbVoHIOSiegbUYdxbOY/tM
X-Google-Smtp-Source: AGHT+IFmsv2QL1u9+/cuts2GTN1gCBDtR7Y07HSGpWT/bBhu8QWwOmbLuYQM0DbGQ1eP35FYvoGyinygCe/Z5Xf7nEA=
X-Received: by 2002:a05:690c:6f13:b0:786:8331:6a02 with SMTP id
 00721157ae682-787d5476d40mr123709517b3.69.1762775518671; Mon, 10 Nov 2025
 03:51:58 -0800 (PST)
MIME-Version: 1.0
References: <20251101064907.5037-1-hs@nabladev.com>
 <20251101064907.5037-5-hs@nabladev.com>
In-Reply-To: <20251101064907.5037-5-hs@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Nov 2025 13:51:22 +0200
X-Gm-Features: AWmQ_bnL_HVaDSEDG9Pk6JpPLww0FyWI8AQymQ-ly6KwQ8O0X9V26goPBxREABs
Message-ID: <CAC_iWj+GH3kFfHJTpE57M4q+L+jmxtACuQqFP-+WiAvhPLk76Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] tpm2: add sm3 256 hash support
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hello Heiko,

Thanks for doing this.
This patch is fine. I do think we should extend this more though.

Adding the missing SM3 algo is indeed needed. But when using a TPM,
the specs that currently describe it require all the PCR banks to be
extended. IOW we need to add some code to lib/tpm_tcg2.c as well.
I haven't looked at all the details yet, but we at least need to add
the new algo to tcg2_create_digest(). I am happy to help if you need
more details.

[...]

>
>  /* NV index attributes */
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 5b21c57ae42..0fea35e5ae0 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -686,10 +686,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
>
>         pcrs->count = get_unaligned_be32(response);
>         /*
> -        * We only support 4 algorithms for now so check against that
> +        * We only support 5 algorithms for now so check against that
>          * instead of TPM2_NUM_PCR_BANKS
>          */
> -       if (pcrs->count > 4 || pcrs->count < 1) {
> +       if (pcrs->count > 5 || pcrs->count < 1) {

Since you are changing this we might as well make it future proof.
Can you please change this and just use the ARRAY_SIZE() of the
hash_algo_list[] instead?

>                 printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
>                 return -EMSGSIZE;
>         }
> --
> 2.20.1
>

Regards
/Ilias
