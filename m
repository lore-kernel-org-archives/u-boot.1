Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22CAC87FCB
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 08:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD0483D13;
	Sun,  3 Aug 2025 10:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z2HXP6Uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E3B83D17; Sun,  3 Aug 2025 10:17:19 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6FB83B5F
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 10:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4235495646so1401750a12.2
 for <u-boot@lists.denx.de>; Sun, 03 Aug 2025 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754209035; x=1754813835;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ihfrmAxGMMSRh6d+ZUr/KGZqmDJb5do4e6yen0D0gmU=;
 b=Z2HXP6Uvb5Zza8A1IwAxatZIqMLWFgF2RQpyEvvrSmHrvenJXLMuB+WviHvUSJVqEe
 IBEaI4xXEEg0s0KwAnCF/hWTTOhviCDG19Ae2rekuZHgeEN5aPDiuB0M4XldNXQVYd6D
 R/A0a2Ep0VDsBSX0mUyzI+gDcqku2l3SLDHNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754209035; x=1754813835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ihfrmAxGMMSRh6d+ZUr/KGZqmDJb5do4e6yen0D0gmU=;
 b=jLiAeNj2lI/beYjPEYjnB5//yDZ/pPjDpXmrpseHHhEltX6V8W69Tpf3Do99nKt0/7
 MYL9ZNebdFrCnudfQJK8RrTCq8DuVM99c3cVIze4qiPYkDV8lnlIO2dkqVs08I4ZX9aU
 mso130whgMe8eTqk5k9ulpZN2qgBTAD3Hwd7BLT3UZsU/AWEvPm6eVC3tHmW2YJS8kDr
 MuFFVrRyBltqwhclkbYyAl4XDX7UPb0EJWm2y85WvocL5GgndoccywuRsZoLg8ODNr6o
 JgmrIHfcAxyE/GoPcEeDgqueNVtpu/JfxqZdEni7OAWM1YMxdo3i4j7aeEEQ+7e72fdA
 tOrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHK8WETRF+AfUXCyrRZxRJWqw2N9g4Yd+nVJvqzYpqPTtRqYY0qqx3mgqW97eCiEDN6zMaNRs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5iLgIor0Q8hMxAiILOBkrFysjp8w03HkGDoii8Zt3KAQCxUct
 +7xyCI6/f+SDsILeK9IngJWZzWkWmyvVlOVMrj7UMDrkabrVyul89N46h5jbrnbhezY6tIzA3KQ
 KuWbhRUekqdz40ewiI3YVHQcq453Bp4v/N/FtFsvQ2A==
X-Gm-Gg: ASbGncvYcn8EEf5C59T8yWWMli4EkcItVRO4dJdbOECYR9IBXDJi4jy0VKt757PhBGY
 OR8VKYyVnFrhQhHn2YoIAbpW4UbNyRlGdYqMi0MCsTFzSUq70sHp2pwvSzf9+Pispyr+qV7eEsE
 3nWttBMhnySgB0TwoJ/67E2l2FbPZC+FYM19zVgJidZYfuXi4mainA9tqMga3FYffHoVFZRkmuz
 eetTg==
X-Google-Smtp-Source: AGHT+IHv5bvuXKXY8oj8xwcohTTW/3Pnxc9Eoba0ZL1n8D6biBDMv4hfSryPCsh7i+0mT13xha0ef/l6thSIzVhu6XI=
X-Received: by 2002:a17:90b:58c4:b0:31e:cb1a:3dc5 with SMTP id
 98e67ed59e1d1-3211620acdfmr8613818a91.11.1754209035108; Sun, 03 Aug 2025
 01:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250801-mtd_nand_raw-v1-0-80c316f5bb99@linaro.org>
 <20250801-mtd_nand_raw-v1-3-80c316f5bb99@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw-v1-3-80c316f5bb99@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Aug 2025 10:17:03 +0200
X-Gm-Features: Ac12FXy74xYS8Y6XFZVtHHaQkJV3g4IFTrxXuc12-OSBP6w5XACq-h2_uq5kalg
Message-ID: <CAOf5uwmc3F7Y3fbuyW=Qe7Ni79Vq0sh4MsuVsLGCDitUs1cdhg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtd: rawnand: mxs_nand: Ensure err is set for error
 path
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, Aug 1, 2025 at 11:54=E2=80=AFAM Andrew Goodbody <andrew.goodbody@li=
naro.org>
wrote:

> In mxs_nand_init_ctrl there are a couple of error paths that do not set
> err which could lead to the errors being silently ignored despite the
> function not completing. Rather than just using if to detect these
> errors use err to collect the error return value from the called
> functions.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/mtd/nand/raw/mxs_nand.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/mxs_nand.c
> b/drivers/mtd/nand/raw/mxs_nand.c
> index ba67466069b..fecf1f5ba91 100644
> --- a/drivers/mtd/nand/raw/mxs_nand.c
> +++ b/drivers/mtd/nand/raw/mxs_nand.c
> @@ -1640,10 +1640,12 @@ int mxs_nand_init_ctrl(struct mxs_nand_info
> *nand_info)
>                 nand->setup_data_interface =3D mxs_nand_setup_interface;
>
>         /* first scan to find the device and get the page size */
> -       if (nand_scan_ident(mtd, CONFIG_SYS_MAX_NAND_DEVICE, NULL))
> +       err =3D nand_scan_ident(mtd, CONFIG_SYS_MAX_NAND_DEVICE, NULL);
> +       if (err)
>                 goto err_free_buffers;
>
> -       if (mxs_nand_setup_ecc(mtd))
> +       err =3D mxs_nand_setup_ecc(mtd);
> +       if (err)
>                 goto err_free_buffers;
>
>         nand->ecc.read_page     =3D mxs_nand_ecc_read_page;
>
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


> --
> 2.39.5
>
>

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
