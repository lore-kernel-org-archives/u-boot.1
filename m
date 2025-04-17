Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B131C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 12:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCAF8300B;
	Thu, 17 Apr 2025 14:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIKKh4qb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E1CD83019; Thu, 17 Apr 2025 14:45:54 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D817D82FD4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30820167b47so700710a91.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744893950; x=1745498750; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y95N9Y7UzZUa+BGuk6o5OynlXPWKwdM9EHGjrbNzaT4=;
 b=YIKKh4qbksLhtn68UqKDH6z7jEvDG4zE1gUOw9t5SPFTh8WImc1A9VMl6FwRaKcjXL
 m6z7wEUPFJg4EkzJiH6qTUvPcDrZj9ruR9secauWr0tffeZydn+xk7QNEZSCzIT7nwgr
 b+S6mpd2XITvytnM9sWykeIhNIBJXREK5h8OdJBNBQefT1raU1sRGh5gE2Dw1kG25vic
 AccmRf1C7S1/IkyUvUvX72ZCFgVCrUZ1nSiie4dozvbQVQs4ikn0N3lSZQ9HBwn+uRWd
 m9pxEUb/VXE7p5LrPx7j86R0U/+FY1B1TeVM/cl2WFgsMv4X9O9s/ljUpkbbBFaPUyRh
 gVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744893950; x=1745498750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y95N9Y7UzZUa+BGuk6o5OynlXPWKwdM9EHGjrbNzaT4=;
 b=VrmynbnynlfsMzbitDNPASDKT300NlPotd7qzEHx5zNXgo4kisKvSfdH6KckL9xPYO
 kFY08m2h9md/oagA//LA9pPyA4v9Ne2E1W32nG5SY7J2F6Sm/2svupd3qfHRINMyOvDQ
 PButxxS0kqFUZhxTrAb6j6GEhyvlVn0FLpbEQ8YezR133XkfgSXgovBZxobNHUL/9Rjy
 pX31I1vCXlWjwGeEXBqAxv4h0ASTEuER3Z/KDQakOpIFAnps/woito6Y89I00yq5P8AA
 S77YQeH58zQYCyjwIuN13v+gy7GCUjHPWWTV9LAykctvXeqrlJj3A5x9wH4CJZtLFm1D
 sxyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRXUOKN0n7Bua6sJZ0ftOvYP/EWsa992bNgsT5UjwQrx31v5fIeND1L5dz12Orh2yYPUGR3uk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyjq/TOy6KfHBfruTnJJSRNshPNJB/DfDR9W5XabotKWYIW/GJ8
 cXXYKVckmvjdnLbAf6TRbZhl4w40Ffc49BNNGdPCEe6d7G0z1zviAcXsGQwCQJ6EfC7jJJE28xR
 mIDdaofYoF3XBuwtgPHQkidEuXFVcmw==
X-Gm-Gg: ASbGncsJ2UJnC2CtRfaOVUNT2TIoE2+EIbGGzDHd9qSMBwaxcCEiA9RNvzobTSoupBt
 LiPTEHIeUtR0Vfo3vA7apraiRzTki7IeZcVTqhZD4U5reA1cX0CKsnlfHurl0H+5f2G6UYIib65
 Yo0gWkLY6ZG6Lga+u9LTgBag==
X-Google-Smtp-Source: AGHT+IGOmyFQSjwjEeteAergRYmJ74TmnPUYPJnE0T6CRjpCJfWDxpduV/1ZYkQuNsgNUNMmViyaLA9QlpU67fruzgI=
X-Received: by 2002:a17:90b:1f8f:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-3086f6f6e9emr4365686a91.14.1744893950158; Thu, 17 Apr 2025
 05:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250417123156.2526548-1-festevam@gmail.com>
In-Reply-To: <20250417123156.2526548-1-festevam@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 17 Apr 2025 07:45:38 -0500
X-Gm-Features: ATxdqUGdG81fHXhIESDsuc9jn1sKbVC45X1-DrazvIOY-TCWaYjVoungmdjouJU
Message-ID: <CAHCN7x+-92Rz6+_iep1Mxhr4R70itUv_pQSu9_Svwm7JWRwpBQ@mail.gmail.com>
Subject: Re: [PATCH] clk: fixed-rate: Use "clock-output-names" to name fixed
 clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de, 
 francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Apr 17, 2025 at 7:32=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Currently, fixed-rate clocks in U-Boot are named based on their devicetre=
e
> node names. For example, given the following node:
>
> osc_24m: clock-osc-24m {
>         compatible =3D "fixed-clock";
>         #clock-cells =3D <0>;
>         clock-frequency =3D <24000000>;
>         clock-output-names =3D "osc_24m";
> };
>
> U-Boot registers the clock as "clock-osc-24m", derived from the node name=
,
> ignoring the clock-output-names property.
>
> This differs from Linux, which uses the clock-output-names property when
> assigning clock names. As a result, clock consumers expecting names
> like "osc_24m" (as defined in the property) may fail to resolve clocks
> correctly in U-Boot.

You read my mind!  I just sent out an e-mail to the other thread with
this very suggestion.

>
> Update the fixed-rate clock driver to check for the clock-output-names
> property and use it as the clock name if present. If not, the fallback
> remains the node name. This makes U-Boot behavior consistent with Linux.

Agreed.

>
> One concrete impact is on i.MX8MP, where USB clock lookup failed followin=
g
> commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*").
>
> With this change applied, fixed-clocks are correctly registered with thei=
r
> expected names:
>
> u-boot=3D> clk dump
>  Rate               Usecnt      Name
> ------------------------------------------
>  32768                0        |-- osc_32k
>  24000000             5        |-- osc_24m
>
> This change restores i.MX8MP USB functionality by ensuring the proper clo=
ck
> names are used.

Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon
>
> Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
> Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  drivers/clk/clk_fixed_rate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
> index d1da05cc18a5..7b89f9c80e95 100644
> --- a/drivers/clk/clk_fixed_rate.c
> +++ b/drivers/clk/clk_fixed_rate.c
> @@ -35,6 +35,8 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev=
,
>                                     struct clk_fixed_rate *plat)
>  {
>         struct clk *clk =3D &plat->clk;
> +       const char *clk_name;
> +
>         if (CONFIG_IS_ENABLED(OF_REAL))
>                 plat->fixed_rate =3D dev_read_u32_default(dev, "clock-fre=
quency",
>                                                         0);
> @@ -45,6 +47,16 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *de=
v,
>
>         clk->dev =3D dev;
>         clk->enable_count =3D 0;
> +
> +       /*
> +        * If the "clock-output-names" property is present, use it
> +        * as the clock name, like it is done in Linux.
> +        * Otherwise, the original behavior will be preserved: the fixed =
clock
> +        * name will be its node name.
> +        *
> +        */
> +       if (!(dev_read_string_index(dev, "clock-output-names", 0, &clk_na=
me)))
> +               dev->name =3D clk_name;
>  }
>
>  static ulong clk_fixed_rate_raw_get_rate(struct clk *clk)
> --
> 2.34.1
>
