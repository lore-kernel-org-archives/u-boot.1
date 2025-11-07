Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F92CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D306283CB9;
	Fri,  7 Nov 2025 11:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z5ZXA6ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 894B383CEA; Fri,  7 Nov 2025 11:45:43 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 223E983CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-787ab220b1cso7838397b3.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762512340; x=1763117140;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I72dYfiPMAwIGCmTEdEGdmExZJC5tURPxTn+j3I41eE=;
 b=Z5ZXA6ay6RBE7HiM/oM0b72cBaJ6aCg53zAuRlZpfetWYTxGji9a9uyqFdhdllLZ/K
 2feWn2X4OtKmlKDWQ/AzCyY5niaV5J4OYGIur2DrSFgIYbuzj3g3Swk9LxHEY1WDjsGQ
 sHAD6UwH1PBpmQiDqygHQpaavSjUdTYt1H+Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762512340; x=1763117140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I72dYfiPMAwIGCmTEdEGdmExZJC5tURPxTn+j3I41eE=;
 b=rzO+E1UaG+esNQ5j03l/G7M2Cf3ZVxK3RUG5FRLMTkI3SB7MhsKOd6CtaqXBG5vrhB
 fH4bYgn1xlE5LRKNWAB0MeSqIdCVUF10genVBa6Gk4mx0wSheWSkvpB5p1oNZ2Fxtgsr
 IO9eOncrYjuqteoe2EXqZDzpNdwsjP3c+3SqRtOSLuneXF7Rpt3YOMUUdq3pf5N/GP5O
 RWhedptl2O8vLPJ+0uz/dJhESU9KH+NYA7JvL2eu9BAF6FQz7Odwoau99yyWTi9WqAXI
 errLrCnuip3lwQGT//d6mN4Wf/41S9otVz7x+WnG2pQiRscEBM7Pj0NL1VzwH4oZ0It2
 1zyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBDVto487Kb5ecrqk/h2b19l55Rx+sMsfNm7E6mD4ND6D0aGualmMP7VeCOlPaVRgH+Hv3BRw=@lists.denx.de
X-Gm-Message-State: AOJu0YxeLJgAwdRqgPTZdvCnaoJsEc3AXVU2aoQKNQG2ZIEbep/vbuhp
 iuS5AIMLL1hp4aI7nXnY9rit1YwZvJEXY1nmKPB5TDIeokAVI8QbJIMQ5OHVHhvN+I27Ftu6EO8
 qdYk1bn+BVGjF4KCGlaB4WSIum12uvUDiLYDenVNYNQ==
X-Gm-Gg: ASbGncsURNd3feEEPX2iunWr0d3+dREG8S3zcn8SCmf5TqjQ9H3XYdOqdFuhabkmk4F
 ibFHGDfX3+WbykU9naEXQvfHfYmXfSVWfSN3BSnHZsVbaJVydtrAu/xPPZ5/8laVGlILVxoFyGl
 73eUmlJZyGKTnTLMwYSV23ZavRJRATzgaphnX34uqp8zJYNGWr8dvLkL/W4S0qZUJSqGxw81YVd
 pccrhgb64zxMyU49XPwTAD5p5Fsh2GvE8pz06f8Zvfxt0Y9wW87kRAZtvo+9IC+mCd+rtE2jS97
 kvoEo5EEwqtmQg==
X-Google-Smtp-Source: AGHT+IEAhm/s2pLLdPsdgbJ0HGPJKa8BF/kAdLNTrq5n6CS3bAOt4gVIC3ETJgStCC/W9ItRorbrED86FcSDJb/EeB0=
X-Received: by 2002:a05:690c:101:b0:787:badd:50 with SMTP id
 00721157ae682-787cab8e2e3mr9322307b3.27.1762512339760; Fri, 07 Nov 2025
 02:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20251106170124.3992080-1-admin@hifiphile.com>
 <1116a46b-6261-487b-8418-1c638df56e15@linaro.org>
In-Reply-To: <1116a46b-6261-487b-8418-1c638df56e15@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 7 Nov 2025 11:45:28 +0100
X-Gm-Features: AWmQ_bmUjKmgIRBRitz0tnePls5jF_AY5wBFkCWE80HbSLa37tGnQ-cWW-Cz654
Message-ID: <CAOf5uwnO_VtG5sajp-_fq4KvK+V3O8V-PnZmQz0d0MNDPEnn8A@mail.gmail.com>
Subject: Re: [RFC PATCH] mtd: nand: raw: Add ONFI NAND unique id read support.
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Zixun LI <admin@hifiphile.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi all

On Fri, Nov 7, 2025 at 11:41=E2=80=AFAM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
>
>
> On 11/6/25 19:01, Zixun LI wrote:
> > This patch adds support for reading the unique ID from ONFI-compliant N=
AND
> > flash devices.
> >
> > The unique ID is a 32 bytes long identifier that is useful for device
> > identification and tracking.
> >
> > Tested on SAM9G25-EK with Macronix MX60LF8G18AC flash.
> >
> > Signed-off-by: Zixun LI <admin@hifiphile.com>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c | 69 ++++++++++++++++++++++++++++++++
> >  include/linux/mtd/rawnand.h      |  8 ++++
> >  2 files changed, 77 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/na=
nd_base.c
> > index 48e3685d995..30aa578e074 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -991,6 +991,75 @@ static int nand_onfi_set_timings(struct mtd_info *=
mtd, struct nand_chip *chip)
> >                                      tmode_param);
> >  }
> >
> > +/**
> > + * nand_onfi_read_unique_id - read the ONFI unique ID sequence
> > + * @chip: NAND chip descriptor
> > + * @buf: destination buffer
> > + * @len: size of the destination buffer
> > + *
> > + * Issues the ONFI UNIQUE_ID command sequence, validates the unique ID=
 and
> > + * copies it into @buf.
> > + *
> > + * Return: 0 on success or negative error code otherwise.
> > + */
> > +int nand_onfi_read_unique_id(struct nand_chip *chip, void *buf,
> > +                          unsigned int len)
> > +{
> > +     struct mtd_info *mtd;
> > +     unsigned int copy;
> > +     unsigned int byte;
> > +     unsigned int copy_len;
> > +     u8 raw_id[ONFI_UNIQUE_ID_LEN * 2];
> > +     u8 *out =3D buf;
> > +     int ret =3D -EIO;
> > +
> > +     if (!chip)
> > +             return -EINVAL;
> > +
> > +     if (len && !buf)
> > +             return -EINVAL;
> > +
> > +     if (len > ONFI_UNIQUE_ID_LEN)
> > +             return -EINVAL;
> > +
> > +     if (!chip->onfi_version)
> > +             return -EOPNOTSUPP;
> > +
> > +     mtd =3D nand_to_mtd(chip);
> > +     nand_get_device(mtd, FL_READING);
> > +     chip->select_chip(mtd, 0);
> > +
> > +     chip->cmdfunc(mtd, NAND_CMD_UNIQUE_ID, 0, -1);
> > +
> > +     for (copy =3D 0; copy < ONFI_UNIQUE_ID_COPIES; copy++) {
> > +             for (byte =3D 0; byte < ONFI_UNIQUE_ID_LEN * 2; byte++)
> > +                     raw_id[byte] =3D chip->read_byte(mtd);
> > +
> > +             for (byte =3D 0; byte < ONFI_UNIQUE_ID_LEN; byte++) {
> > +                     u8 lo =3D raw_id[byte];
> > +                     u8 hi =3D raw_id[byte + ONFI_UNIQUE_ID_LEN];
> > +
> > +                     if ((lo ^ hi) !=3D 0xff)
> > +                             break;
> > +             }
> > +
> > +             if (byte =3D=3D ONFI_UNIQUE_ID_LEN) {
> > +                     copy_len =3D min_t(unsigned int, len, ONFI_UNIQUE=
_ID_LEN);
> > +
> > +                     if (len)
> > +                             memcpy(out, raw_id, copy_len);
> > +
> > +                     ret =3D 0;
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +out:
> > +     nand_release_device(mtd);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(nand_onfi_read_unique_id);
> > +
> >  /**
> >   * nand_setup_data_interface - Setup the best data interface and timin=
gs
> >   * @chip: The NAND chip
> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > index 3e80b134063..87083c34aed 100644
> > --- a/include/linux/mtd/rawnand.h
> > +++ b/include/linux/mtd/rawnand.h
> > @@ -88,6 +88,7 @@ void nand_wait_ready(struct mtd_info *mtd);
> >  #define NAND_CMD_READID              0x90
> >  #define NAND_CMD_ERASE2              0xd0
> >  #define NAND_CMD_PARAM               0xec
> > +#define NAND_CMD_UNIQUE_ID   0xed
> >  #define NAND_CMD_GET_FEATURES        0xee
> >  #define NAND_CMD_SET_FEATURES        0xef
> >  #define NAND_CMD_RESET               0xff
> > @@ -409,6 +410,10 @@ struct onfi_ext_param_page {
> >        */
> >  } __packed;
> >
> > +/* ONFI unique ID */
> > +#define ONFI_UNIQUE_ID_LEN 16
> > +#define ONFI_UNIQUE_ID_COPIES 16
> > +
> >  struct jedec_ecc_info {
> >       u8 ecc_bits;
> >       u8 codeword_size;
> > @@ -1385,4 +1390,7 @@ int nand_write_data_op(struct nand_chip *chip, co=
nst void *buf,
> >  /* Default extended ID decoding function */
> >  void nand_decode_ext_id(struct nand_chip *chip);
> >
> > +int nand_onfi_read_unique_id(struct nand_chip *chip, void *buf,
> > +                          unsigned int len);
> > +
>
> Something appears to be missing. Where is this function called ?
>

I prefer to apply if we have a use case and a consumer of this patch.

Michael

> Eugen>  #endif /* __LINUX_MTD_RAWNAND_H */
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
