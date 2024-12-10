Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B41E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 10:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9351E89089;
	Tue, 10 Dec 2024 11:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KzexzSOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504D889407; Tue, 10 Dec 2024 11:01:11 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525D788F7B
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 11:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3d143376dso4995353a12.3
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 02:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733824869; x=1734429669; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cOUVAGM+79ZbYHudGfktAyOXlmPH7Gup+Tn6wf+4Nl4=;
 b=KzexzSOi2Kn+r468/UunZCoEP0i46wg5wDvNX0TCatOCyHd4aHHhlgmrOD8dCE339D
 EZMAg5jpSZWyQc9IkZIf8ypjmQOFtqRjZ7x9OCmjpQnU7YaRX3oz659Ke6QifjVqy9JF
 kJXLs4B932hgVA2J9O0NcnUxncxHOhcpEOWOwvDDN0urn24zmU6WTODfkpqtVM8DcsSh
 xsJMCyQy36rTKnaJZYKVMnDmS0R/uWHZlhzMLAI+BV6mMVF6dqyILoStnNe1efzsiXQV
 u5G5b6wrleUGsltMRT5e637j+CSw4GSSb1KA4ZNyb3eAuyv86heks4+MKw1fc3QnCQb4
 JfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733824869; x=1734429669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cOUVAGM+79ZbYHudGfktAyOXlmPH7Gup+Tn6wf+4Nl4=;
 b=BbvQn5UFCU5IdJIpecbAgDhRsOVqj79fM5o3fZTq2Bd88KNYBVmJYs8s7IP/oLZ0sM
 DTT4gD18pqdMZFQ4efTEUzxRHfG75lM0x7rUJTeYTwVtSHPdPjG5LT3IyQ/YZYsEcLL+
 dbO5XKEmbuFUYmF/mayVCNnz3IB7SoZsZoYzHI1HQlMnOub8JzD3YmKsRWD0rk+jJw2P
 8UMO2U3x9etlFl20K645u7BPe33L6h1+FTEciE/V3MpEf0F10A1dk6+ZcWaeW7tisrsM
 eBlb9P0k3vIHPuv3HPQFdbYOA9TRExBt51MbokKs3MfKNjCDhkUz3eo7bmuxBGicC6+v
 3CEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlLM53r5iE34PPTHEEf94yO1YGtIhZctPCZC0OKkxldumEw9/72tBfZl5/3XhBEhFjGcyfleo=@lists.denx.de
X-Gm-Message-State: AOJu0YxwCLFTOFjgcPbAcM/ks6zmkquwGnPdTt7GjtC2jWYRlX/q2EZI
 F/t7rOQGXs7lTBVmxshRp/sWM6p/c2cF7NYFab85mQv44STV7t5gHb4gPIzXYco5ulBNYpML2Ec
 1sHQJlYORgcSNAZ5RlLBsjWWrTrEAV8nH4zS6aA==
X-Gm-Gg: ASbGncuJftiIxFC/fh8njPR+YdwofownaDqTxi3Z62ebA03ddMvzOpeByf1sSM2CtzM
 oCsdBrGKvH1HZzUK5fXURqRxO1tTsiZOT5iYv
X-Google-Smtp-Source: AGHT+IHODi/Yon2vMdBfjP4G00m5+Ue/sFXec1W8u80C4D5RbX4xUpB1i68panbHfXpNH0ejLe1m2wjic4FmkZE5Q0I=
X-Received: by 2002:a05:6402:1e90:b0:5d0:88da:c235 with SMTP id
 4fb4d7f45d1cf-5d41863c29cmr4102184a12.31.1733824868724; Tue, 10 Dec 2024
 02:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20241208105223.2821049-5-ilias.apalodimas@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 10 Dec 2024 15:30:57 +0530
Message-ID: <CADg8p97FMuPkc2CYhPpG5MKE5YRGsxRYsmKeUy=UAz8uBcm4og@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] lmb: Remove lmb_add_region()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 16:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> There's no point defining a function that's called only once just to
> avoid passing the flags. Remove the wrapper and just call
> lmb_add_region_flags().
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>

-sughosh

>  lib/lmb.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index ffdd23d87b9b..56e005308dde 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -640,19 +640,13 @@ void lmb_add_memory(void)
>         }
>  }
>
> -static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
> -                          phys_size_t size)
> -{
> -       return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
> -}
> -
>  /* This routine may be called with relocation disabled. */
>  long lmb_add(phys_addr_t base, phys_size_t size)
>  {
>         long ret;
>         struct alist *lmb_rgn_lst = &lmb.available_mem;
>
> -       ret = lmb_add_region(lmb_rgn_lst, base, size);
> +       ret = lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
>         if (ret)
>                 return ret;
>
> --
> 2.45.2
>
