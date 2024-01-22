Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD9FC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 09:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E90C875E9;
	Mon, 22 Jan 2024 10:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pTehmpHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50A987214; Mon, 22 Jan 2024 10:16:31 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778EB875E9
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 10:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-68183d4e403so18869736d6.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705914988; x=1706519788; darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=el/KKVb/DZ0QPxK42UZ9M7VbjIfhwWXIol5DYUbpRWc=;
 b=pTehmpHK1YclBeh961KIiigpg89PHhvy9SM8DdXXdiom82O0a6RA+YWGg7KOe/RgxD
 /bxOs1Lo5fJaE4K1+Uzpe25u5iqANrnk9mXTFV1rskLrK30e4ln92lzHnaycaOED0iLU
 t09QFHwjgdiDo676l00d6/N5jLlC6zbEH885GB3y750IJQKHhX8Zq55lUz1zXPGH2x2a
 Fdf7IOluofmA+/ySCdv4cnqfGKQCMxSXJMVb0ViFF5Clb3ygeDd0KhfFOuhAzCRm94lU
 Q0plVEGw99PBMtLuYtNYW/5kCC/6BWSZxfLtqrhD1gpNQl2kTowc7au9Lw0+dynUYYMK
 fmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914988; x=1706519788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=el/KKVb/DZ0QPxK42UZ9M7VbjIfhwWXIol5DYUbpRWc=;
 b=NA2Z97jOZwufrBgH5u/dO2rspLsF+U9Xj9inaCDR0XYcc6CnX3j7YZ0hQGr/kGQutq
 Du/r6lpWo/MKZUGpRAGnrU6Hu18u+TbGrj6DIbPpwxKNoxOOn6twgPKItN2rjwEucJtz
 6RepCrxYUKqlVlD5du84Gw8dXY3NitznTLPZnFJhlfCZCkJKfhZBcfCBFCB8Qbk4I+YV
 nqlgswlvFd0Ev0noBmAemd7C2t/LmFv6n//vdv1v9U2TFuzSbfATurIcY49+aBdBWuex
 Pmv6WodPS3lwhoTAfgrCyj1SfsezBfEZ4LM1ESgpNjg61qhvqc/okisuX2P8fJj6m22m
 AjjA==
X-Gm-Message-State: AOJu0YyWRfEc3d6SIa9xwNOSeFFaGrNXvXVWS0Ryij/XAOBv6tcb48RL
 jc/nNPJ+7p+kazYfeJexhljBK9c9kRelCsY9+AK1VPpxNkoQnR4+B5s9WqhVrDugLtVLjBQE+5L
 CpH5cbcbPEeQn5snlU4s4q6hErgBGFO0YpLz2Lg==
X-Google-Smtp-Source: AGHT+IEXR2w2f1wK/9NN9NzYhp5UvJDog0sBmFBYqLtuHzCaP00LbRS1rgeqbdweYdeU/fHqBnBdjApZTnirc35X4t8=
X-Received: by 2002:a0c:f212:0:b0:685:97e7:afce with SMTP id
 h18-20020a0cf212000000b0068597e7afcemr3466454qvk.10.1705914988154; Mon, 22
 Jan 2024 01:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
 <20240116123643.563412-2-mchitale@ventanamicro.com>
 <e3e76e8a-74e8-baa9-3605-6a3b3c5290e6@gmail.com>
In-Reply-To: <e3e76e8a-74e8-baa9-3605-6a3b3c5290e6@gmail.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Mon, 22 Jan 2024 14:45:52 +0530
Message-ID: <CAN37VV7oX99U0YBkNow1S3aU=Z-EXRY9c7zL66J9x8ncpVuHJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] part: Add a function to find ESP partition
To: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>, 
 Johan Jonker <jbx6244@gmail.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Wed, Jan 17, 2024 at 6:43=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:

> On 1/16/24 07:36, Mayuresh Chitale wrote:
> > If a disk has an EFI system partition (ESP) then it can be used to
> > locate the boot files. Add a function to find the ESP.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >   disk/part.c    | 16 ++++++++++++++++
> >   include/part.h | 11 +++++++++++
> >   2 files changed, 27 insertions(+)
> >
> > diff --git a/disk/part.c b/disk/part.c
> > index 36b88205eca..6b1fbc18637 100644
> > --- a/disk/part.c
> > +++ b/disk/part.c
> > @@ -848,3 +848,19 @@ int part_get_bootable(struct blk_desc *desc)
> >
> >       return 0;
> >   }
> > +
> > +int part_get_esp(struct blk_desc *desc)
> > +{
> > +     struct disk_partition info;
> > +     int p;
> > +
> > +     for (p =3D 1; p <=3D MAX_SEARCH_PARTITIONS; p++) {
> > +             int ret;
> > +
> > +             ret =3D part_get_info(desc, p, &info);
> > +             if (!ret && (info.bootable & PART_EFI_SYSTEM_PARTITION))
> > +                     return p;
> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/include/part.h b/include/part.h
> > index db34bc6bb7d..30e049c8f19 100644
> > --- a/include/part.h
> > +++ b/include/part.h
> > @@ -690,6 +690,14 @@ int part_get_type_by_name(const char *name);
> >    */
> >   int part_get_bootable(struct blk_desc *desc);
> >
> > +/**
> > + * part_get_esp() - Find the EFI system partition
> > + *
> > + * @desc: Block-device descriptor
> > + * @Return the EFI system partition, or 0 if there is none
> > + */
> > +int part_get_esp(struct blk_desc *desc);
> > +
> >   #else
> >   static inline int part_driver_get_count(void)
> >   { return 0; }
> > @@ -700,6 +708,9 @@ static inline struct part_driver
> *part_driver_get_first(void)
> >   static inline bool part_get_bootable(struct blk_desc *desc)
> >   { return false; }
> >
> > +static inline bool part_get_esp(struct blk_desc *desc)
>
> Please use the same signature as above.
>
Yes.

> > +{ return false; }
>
> The statement here should be on its own line.
>
> Ok.

> --Sean
>
> > +
> >   #endif /* CONFIG_PARTITIONS */
> >
> >   #endif /* _PART_H */
>
>
