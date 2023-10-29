Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA301C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 13:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF8987068;
	Sun, 29 Oct 2023 14:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rtk6que7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CAE987068; Sun, 29 Oct 2023 14:06:50 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CAAD8704E
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 14:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso7427766a12.0
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1698584805; x=1699189605;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLq5JIxzoFOGOINSqevc+cULGSI8qJYXbAWpzWYqF28=;
 b=rtk6que7+nWwGD9OMg0EbqNi9t6PhEo4TXlcW5KcT49d79/Q2vhisADg+V+KovCER5
 /4mtZY16u+yj7em2R/cAl4KwDfH+qZvYnupAQ5bfo+uneE0vHmvEDaAXHkfrdyyezW+H
 hUA2OMqJOVqJydkLX3qZG6SbNJhK2BRVI53P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698584805; x=1699189605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLq5JIxzoFOGOINSqevc+cULGSI8qJYXbAWpzWYqF28=;
 b=PYTsAco+AEGXFUPd7INIPqKphWTRSBHD5zKeaVk+4Ts7m1l3k7uzcN37xMp4Gh7kqu
 YLZRbjtTA3rWVmQ8hCLq2HO6Bb4A3H2SRza5u6Eo04IAZCw+n4W7SgFhEza/4GSP8elO
 hH1ngmgF3BNgjHFOJL5sa1pwtH9TVZL7v9H9yH0B46fcE0rbHDC4PSxLFZCtKDvPxVL1
 OiDdf0W26iqPyVkCHgHUvPGDuOvPXgg2h9Q4h104+9hl4HmXJHTQFfBfkUFwn9/nHDMb
 nnfXueXJ0gpB/GOychIG3m4q5c+hdwdE1rXTiKWgRI9i18eD+fSTzWlbce8rh1uqG/Vz
 iSCg==
X-Gm-Message-State: AOJu0YygAAQgmbHbm46YY3nfq8FlPFSyCU+1t6oe9NOuT/AB+Cd+ar7A
 RJiCu1CKwIvygri348+phkzKabkX7Uu72MZyi5OV0g==
X-Google-Smtp-Source: AGHT+IEAIf2w0wre7Kx9mDfU+Evfr3uOtq6V3Xa7uTVA4c2Z32vUzG7JrFMaEAUBMfGIrGOIFFF293GUx2lVZMj62bM=
X-Received: by 2002:a50:aad0:0:b0:542:fe59:2234 with SMTP id
 r16-20020a50aad0000000b00542fe592234mr1581820edc.6.1698584804939; Sun, 29 Oct
 2023 06:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231029034845.1169614-1-seanga2@gmail.com>
 <20231029034845.1169614-3-seanga2@gmail.com>
In-Reply-To: <20231029034845.1169614-3-seanga2@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 29 Oct 2023 14:06:33 +0100
Message-ID: <CAOf5uw=reXv_eYwmTDKE8zks4NaCLG1mL5m7e82t-AhqyEt5gA@mail.gmail.com>
Subject: Re: [PATCH 02/15] nand: Don't dereference NULL manufacturer_desc
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

On Sun, Oct 29, 2023 at 4:48=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:
>
> When no manufacturer is matched, manufacturer_desc is NULL. Avoid
> dereferencing it in that case.
>
> Fixes: 4e67c571252 ("mtd,ubi,ubifs: sync with linux v3.15")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  drivers/mtd/nand/raw/nand_base.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index 6b4adcf6bdc..44b6cb63a01 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4462,17 +4462,14 @@ ident_done:
>         else if (chip->jedec_version)
>                 pr_info("%s %s\n", manufacturer_desc->name,
>                         chip->jedec_params.model);
> -       else
> +       else if (manufacturer_desc)
>                 pr_info("%s %s\n", manufacturer_desc->name, type->name);
>  #else
>         if (chip->jedec_version)
>                 pr_info("%s %s\n", manufacturer_desc->name,
>                         chip->jedec_params.model);
> -       else
> +       else if (manufacturer_desc)
>                 pr_info("%s %s\n", manufacturer_desc->name, type->name);
> -
> -       pr_info("%s %s\n", manufacturer_desc->name,
> -               type->name);
>  #endif
>
>         pr_info("%d MiB, %s, erase size: %d KiB, page size: %d, OOB size:=
 %d\n",
> --
> 2.37.1
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
