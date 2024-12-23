Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697A1E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 12:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76A58056B;
	Mon, 23 Dec 2024 13:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Uip2dLTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C445A806FB; Mon, 23 Dec 2024 13:57:31 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F028056A
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 13:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso2878771a91.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1734958648; x=1735563448;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZD13oQAbi+cgeDfVij/3RHq+oj2t2uLrgbryBS1OAk=;
 b=Uip2dLTG/Yev+w0JNVa4VrhLOnyMlg8BHVgWRBkziDxYlJv0zdSBu2VZFJSA/3hSZg
 6iemg9CdI/D2HC3vJcf2F9XubfY2pfMtB4qI5cEmk0STpOVa4WD9qbFXQEUswbqhCkDO
 1Y2BndG7KWG8pluDe3ajGgeYXj4vlF2apLyeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734958648; x=1735563448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ZD13oQAbi+cgeDfVij/3RHq+oj2t2uLrgbryBS1OAk=;
 b=XOKrvKXxJdFom2rEFFKqDEMqB/0A3YsDZJuff5VYScbrJZR3nM55C5O75Lrzdd+bDx
 yb+UzckmZXro9b52XU8VnHOqQdQDzQXA45psNLatpnQc30tKqO+RvF9USeYmsctECAxb
 5rsQFYOjgAaDUEjsOms0mFqUwoBZnID9GRdfLVcXDShrKMiP/7YTdWccDrJLpOeEe2N1
 jtAPnNo1ajcgZST7KhoBz6yT1+9tUEzZ3zm9Ou6OssLJsk4jmrLWKmF7f7v7ANzthcig
 dhKAa2fSawr2jAK/VvjcL01y1JeDbfG2mWUb5cAMgqcSJNH5NWyUW7d+Yh9/Dud12nsR
 mMfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhLWjZz4eMqf1NWBGpF4TRxdG0fq+ULbiIcoCx86eoRfjhnGO+lVy4vPAz04OP/wEnLynOmhw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9oUnLNmoxiWeeRJ+FHkM3oH6AXu6wUom5z68EdiCOIzmS36pg
 gU58SNIN9tP+zP6llrageRMxdnD4IVPV05jRMV3zaoomQK3FKVkNDyCWmmH0Awt875lLIw0Zn9K
 EM9k0mYLT9dueY4UXU3q8/KNDETef8pUmGNn7wQ==
X-Gm-Gg: ASbGncuk+pynDLkvIRR2M/+KE1xnX3PBRhEttpRoxDxPUr9fzSeB6cy4N0dZ3BuVDAO
 0+CjAh9vdUkgkuw5uwMR0rrsPLJfaRKqIoYo=
X-Google-Smtp-Source: AGHT+IEjxvpHJ6eqEWih0OLTElLUoOP6jIxUikvVIMZsWPRRZC2Pz92H/efoHTlaC7l4G2PnySh04O1SJfTvKPLhSrE=
X-Received: by 2002:a17:90a:c88b:b0:2ee:f687:6ad3 with SMTP id
 98e67ed59e1d1-2f452eb0eb9mr17968084a91.28.1734958647786; Mon, 23 Dec 2024
 04:57:27 -0800 (PST)
MIME-Version: 1.0
References: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
In-Reply-To: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 23 Dec 2024 13:57:16 +0100
Message-ID: <CAOf5uwmb6W1BjCsc437_aFnO0fjVHrr-mU0r8ZGK_jpwn-75Kg@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: always use OOB bytes during write
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@salutedevices.com, 
 oxffffaa@gmail.com
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

On Sun, Dec 22, 2024 at 10:23=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> If 'oob_required' is not set by the caller (for example 'oobbuf' is NULL)=
,
> then driver doesn't copy OOB data from 'oob_poi' to special controller
> structures, so zeroes will be written as OOB. But, generic raw NAND logic
> in 'nand_base.c' already handles case when OOB is not required to write b=
y
> filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
> always read 'oob_poi' data for OOB.
>
> Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same way,
> so need to keep same behaviour here.
>
> Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 81122315f4..82a12ac061 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_info=
 *mtd, struct nand_chip *ch
>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
>
>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYTE);
> -
> -       if (oob_required)
> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

I will queue it

>         return meson_nfc_write_page_sub(chip, page, false);
>  }
> --
> 2.30.1



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
