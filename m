Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D58C54E55
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 10:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD40879E8;
	Thu,  7 Mar 2024 11:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OZYswMSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80EA987F07; Thu,  7 Mar 2024 11:02:12 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7C4871C7
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 11:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56715a6aa55so598351a12.2
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 02:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1709805722; x=1710410522;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6OaRsAuhikSVI/8ainA00fsOwc8jZDvU+iy4IAYexU=;
 b=OZYswMSB4qXd2+gGKiPDAorRfzuEb3cI4FxKD28hJ7TkhMFt99LzILhk/lhAUn5rao
 nzyqmVg+aiBGrts7ScKMNXGkr9isa/j0Vb2DWDu+kBVLzGoPBl09LejjZcKdb+4BWZYU
 B5UxJWZL5TdNMVxSiQE5cF6uJJGswAJG9pFwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709805722; x=1710410522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6OaRsAuhikSVI/8ainA00fsOwc8jZDvU+iy4IAYexU=;
 b=I/8W3FZQouQnufdegcSGWeXvCblVcqijY7Y0Rbz6tCO1Y6E5opnfGiO+f6aaQ8xuDD
 OtBwm5DtFAUX0lfsmArNwCQSQQ5dX8+c1aCoAZyk2rpVMaWwRs6u5dA6yIHkwzp+QmeE
 cpes1StyCVtjiSCDU2riQkxuV3g/VSW+Spv1CEubBHh+gwyDLpMdG/Rvvy4VywNkgvfm
 niW9fyvdE0ltw73+akbXmDfRZzwQZQz3nbWWKGrvWwRr7Zp8HdSVVtp2pJAnnoEWtNRb
 6S5HYAssCRO1pMNtgArBGAeNi4GYrsoPXffoKPmYMHVBCTvs8mX5TEhmiFZD+CDxVvWe
 0SPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwwG6fItb0m5DotBuLEDykM8UYyk2ry2fngyGm9wLQi/GC/YbBqD4VsSVPLCIk/ahq4Ho8kUgTCow62HClI+CCxLyvUg==
X-Gm-Message-State: AOJu0YyXj1ahHAvzUuXoYKbJ9eiwcKxrf1pqA9a7+ZLWXMBI3I3CuYTJ
 kY93ugMT7foPTEdw9fp9/UY0QBND7UrNQ029hKXQGlV8A3GqkG7TwiqC93Ec7dMQOpAgblWs9m6
 38jOvV1SYWrQBTqisnzW4eXBRDNdUXEITOAFEOQ==
X-Google-Smtp-Source: AGHT+IHdanMH+QDE/JxFtIHZT/XojjQ2LV9JuGjcokKzu5oRYSX3K8RhQLiQszeDK4aaKbdZT5qFK5+LmUvbL3rM5Zg=
X-Received: by 2002:a17:906:1814:b0:a45:6818:e07b with SMTP id
 v20-20020a170906181400b00a456818e07bmr6773181eje.64.1709805722089; Thu, 07
 Mar 2024 02:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-2-ada@thorsis.com>
In-Reply-To: <20240307091014.39796-2-ada@thorsis.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 7 Mar 2024 11:01:50 +0100
Message-ID: <CAOf5uwm2cTWpqrOc-y9QXC3e4JHK6LLmedyqVxXQjXCeV51nuw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mtd: nand: raw: Use macro nand_to_mtd() where
 appropriate
To: Alexander Dahl <ada@thorsis.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
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

On Thu, Mar 7, 2024 at 10:10=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wr=
ote:
>
> In every other place in this file the macro is used, make it consistent.
>
> Fixes: 9d1806fadc24 ("mtd: nand: Get rid of mtd variable in function call=
s")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index c40a0f23d7b..688d17ba3c2 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4118,7 +4118,7 @@ static int nand_get_bits_per_cell(u8 cellinfo)
>   */
>  void nand_decode_ext_id(struct nand_chip *chip)
>  {
> -       struct mtd_info *mtd =3D &chip->mtd;
> +       struct mtd_info *mtd =3D nand_to_mtd(chip);
>         int extid;
>         /* The 3rd id byte holds MLC / multichip data */
>         chip->bits_per_cell =3D nand_get_bits_per_cell(chip->id.data[2]);
> @@ -4185,7 +4185,7 @@ static int nand_manufacturer_init(struct nand_chip =
*chip)
>   */
>  static void nand_decode_id(struct nand_chip *chip, struct nand_flash_dev=
 *type)
>  {
> -       struct mtd_info *mtd =3D &chip->mtd;
> +       struct mtd_info *mtd =3D nand_to_mtd(chip);
>
>         mtd->erasesize =3D type->erasesize;
>         mtd->writesize =3D type->pagesize;
> @@ -4265,7 +4265,7 @@ static const struct nand_manufacturer *nand_get_man=
ufacturer_desc(u8 id)
>  int nand_detect(struct nand_chip *chip, int *maf_id,
>                 int *dev_id, struct nand_flash_dev *type)
>  {
> -       struct mtd_info *mtd =3D &chip->mtd;
> +       struct mtd_info *mtd =3D nand_to_mtd(chip);
>         const struct nand_manufacturer *manufacturer_desc;
>         int busw, ret;
>         u8 *id_data =3D chip->id.data;
> --
> 2.39.2
>

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>

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
