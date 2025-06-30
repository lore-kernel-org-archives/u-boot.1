Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8731C83000
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 07:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6017381FEE;
	Mon, 30 Jun 2025 09:24:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cLWW/1xC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B61B382B20; Mon, 30 Jun 2025 09:24:38 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F205C81E13
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70e302191a3so39770647b3.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751268273; x=1751873073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5YzXS2pnKQwyiM/t7AsIlLoRwH3NlK75KhDvrfGXPxc=;
 b=cLWW/1xC3Tp9kIaF9uN2dKG1Tqfd9Gx0TcvJQ3frH0t7D372JAffEmMvqZ7xUd/72y
 VqXJP1ChLxeHefh7kI0tkqE66dFbAnMHcE8KZP1O2O02+w4R5t0Qexo+nNH1R6QEamYF
 f2F10erjeFk3W6c1Fne5+9B/8NqwqTu6yoj9z5Tue7JYo7TLUTeQdwWJvi0a2DQ+SMdq
 d+UCTEsAG1XCy5tt7r2pic0xUfqebaIB/BHsta9l6UHJugD6Nk3mCKjjxHYLN+Ds8F0E
 uhWdXgSIc3oAGHiIp34o3LvZQeAwo25XiJ6blVMK29/gqvvqW1FWlhVwQiQcpREVoT6T
 76Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751268273; x=1751873073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5YzXS2pnKQwyiM/t7AsIlLoRwH3NlK75KhDvrfGXPxc=;
 b=I6k636CS/Vk/YiyFJ+SdLYdQcnkJosGm4oFYxEN7GFe9AJyqFN3tydHjw1PW25Dx0C
 rvBXoWlDbYa23SHkl91UrFh7x4GCOCVVUilE3g305gVs1g0zaUpbGdBLkIdAQdS7s/PN
 ezgJVP/ACka5Rzy2D9T48aJb0vJgh6UyRaO0007QIr3DItiH5MXvZAUOIU/Jg40R6j3h
 uGilS4z+H/8Wr1yX2mHZaRSZM0tvBPsITowuIESvIfmum6jHyY5AA53S9z9jDEhlESvT
 fLGz2Ealw2ZlWjLlnHMw8uZ3B2R1ES3dsS0p/GK0weT1EHtMbVwhOrm9iNr/cJhF6llR
 F5MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2uU9NQMMed6EqqQNER/TzBEhc2EVgOqhRfiIBcvh+t6Yje8bkUsP4JihyW5q+JfAt9ZcEXkM=@lists.denx.de
X-Gm-Message-State: AOJu0YxGCdzXUSweJ6U7aIVuZyY+G3Zn8lc1hJl8pod5YGhlA91rSWlY
 Go/8Uc+NnTTRBC8CbAla0epXiq8OLX9CKd0Rf0ugQxYfcM8AAobuXiJjQzUJiG2zVFIdezAse8w
 BCzTtGABF8Lhmo2AZ859tyaPe2raoymAx+rx20AjGHQ==
X-Gm-Gg: ASbGncuflcSqtsc9DO1mYPhHPtCW3jZQeh15nPsrh95+kiuGmU1KOIuVLfzXPHGuyTW
 sD/85idnts+k/WzapMjB7pTQmk+rcxiT9SSweAqcLwRQiy8uP9V2EhSgSRjm/XV/G6olkEK5i7G
 xXyw1CQ0qf3JdHOA28ghVdwDUThtJcnBbfvtqal/NlPW4U
X-Google-Smtp-Source: AGHT+IGmHN2g+sNjAcMLzAaJBOq6yV5T33qg6ANH2i7n/nrM8sVYdx3FRtQlYoZWszPuZTMY7lQZvNgr/kAsM6wdd1A=
X-Received: by 2002:a05:690c:4801:b0:70c:bd93:452d with SMTP id
 00721157ae682-7151714fc9dmr188849447b3.15.1751268272751; Mon, 30 Jun 2025
 00:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250625-tpm_enum-v2-0-ea3f84f6b639@linaro.org>
 <20250625-tpm_enum-v2-2-ea3f84f6b639@linaro.org>
In-Reply-To: <20250625-tpm_enum-v2-2-ea3f84f6b639@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Jun 2025 10:23:56 +0300
X-Gm-Features: Ac12FXzzqcgzjO2WhdtU_5EPNUIxI13vnrqGGr2xMq4OszAEfrxiRgEZTDPyws4
Message-ID: <CAC_iWjJTOJte3BFpV0NcuqJziYFaKwnEHU9USKiBHUZ5ZvHRcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tpm: Make use of TPM2_ALG_INVAL from enum
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Fri, 27 Jun 2025 at 12:37, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> Now that the enum includes TPM2_ALG_INVAL, use that name in the
> code.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  cmd/tpm-v2.c | 6 +++---
>  lib/tpm-v2.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> index a62862e94f9..346e21d27bb 100644
> --- a/cmd/tpm-v2.c
> +++ b/cmd/tpm-v2.c
> @@ -113,7 +113,7 @@ static int do_tpm2_pcr_extend(struct cmd_tbl *cmdtp, int flag, int argc,
>                 return CMD_RET_USAGE;
>         if (argc == 4) {
>                 algo = tpm2_name_to_algorithm(argv[3]);
> -               if (algo < 0)
> +               if (algo == TPM2_ALG_INVAL)
>                         return CMD_RET_FAILURE;
>         }
>         algo_len = tpm2_algorithm_to_len(algo);
> @@ -157,7 +157,7 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
>                 return CMD_RET_USAGE;
>         if (argc == 4) {
>                 algo = tpm2_name_to_algorithm(argv[3]);
> -               if (algo < 0)
> +               if (algo == TPM2_ALG_INVAL)
>                         return CMD_RET_FAILURE;
>         }
>         algo_len = tpm2_algorithm_to_len(algo);
> @@ -288,7 +288,7 @@ static int do_tpm2_pcrallocate(struct cmd_tbl *cmdtp, int flag, int argc,
>                 return CMD_RET_USAGE;
>
>         algo = tpm2_name_to_algorithm(argv[1]);
> -       if (algo == -EINVAL)
> +       if (algo == TPM2_ALG_INVAL)
>                 return CMD_RET_USAGE;
>
>         ret = get_tpm(&dev);
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 9ca7933c094..5b21c57ae42 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -1141,7 +1141,7 @@ enum tpm2_algorithms tpm2_name_to_algorithm(const char *name)
>         }
>         printf("%s: unsupported algorithm %s\n", __func__, name);
>
> -       return -EINVAL;
> +       return TPM2_ALG_INVAL;
>  }
>
>  const char *tpm2_algorithm_name(enum tpm2_algorithms algo)
>
> --
> 2.39.5
>
