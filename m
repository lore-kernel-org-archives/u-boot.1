Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E61C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 11:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D36879AF;
	Fri, 21 Jun 2024 13:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZAg3cXRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63173880A3; Fri, 21 Jun 2024 13:26:07 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D2A87923
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c80657e4a3so913720a91.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 04:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718969163; x=1719573963; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EP3TKKHobvjq0LdcG0T5DVo5rIbl+utDkrsuURvB008=;
 b=ZAg3cXRU825ULZcA7j5vHRU7f3C3BW/SOgb0K1O0nAcByz7cy0HgJwHRaS/G6vkoiV
 QLdnuCxjo5e6CIJxSbY8km9XOhPMeeuDi7yd1Ji8aBGAeEukRHPQ/0zzelroqEORIGRn
 9Vb5kEKEL3aFy0AqdLx4QPS/Fy+gMKdd6v7RmGUIHGBFWz2LLUTUpSiDgVNpdFD4uhcW
 iiJBMS1gbd+nmLKu3YwqDizHtfAjDWqLXZkd5LUumkwGG85H4yY6x0O90Yx7emMwqxaY
 n6E6SHGjcF2rPkiZemGseTH1e+DuEaq87z9uk0AbfVoYy4ukPMbfRKZXzmoNDKi31YCi
 Oyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718969163; x=1719573963;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EP3TKKHobvjq0LdcG0T5DVo5rIbl+utDkrsuURvB008=;
 b=qM7XiAEywFHDYBVttYghJjS4sc7ilomSekRMuBHANRLmNT9f3jjmBC3nkaYcTu7ojh
 XIoQbX+k19gKV0A8ru75yg5ScmkunOdFdr8NC6HP+fsj+lKbPJgH4b0Jx4na516lQmP+
 IUb6qtioqpBCGPuc/v4eu68YVvQzdA9A66VpFRm0qIw37ZJVtSUikLNdRwv73z60WXFb
 EGe7af3nMxrhRvrAtzkzweXsfHRpq5oYv7/j+jb18ZVqOqT5Tp2zq+xJFKfPCHJn8QrL
 1Dd0DKIkHZxGJQ1RDqAyphzjlB+bsC/1yLH5cqPrXldtiBPxvANuejogQ1rMm32uW6vL
 U0mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz+YV6e6gv3kC+q7y7AGpGbVXZd/kgSVbd+6VMJ6U7e8Gkz6cap21oxuR99MnYKDOxIrgcdeFeeUPqG96rGsWYMOBG5Q==
X-Gm-Message-State: AOJu0YwLYPzeq7MR9S5PpP+a5/zXMaqFou+xxe0prAyvFuCXnDCY/9mT
 FDt/yzcajFGIazmiVuv9smGg4OCKekC6TdXE6SnOQlt1UbiCJFWAj65z+9Dx83CI+aMMe1VLOCt
 ue5RKoWd7SVvl2TCHlfqdfbxQL0B8gxgzH9NvIg==
X-Google-Smtp-Source: AGHT+IGJiCPVwRsQrqISS7Q49rQcyOGDa2koApACrEf4WdYbCwNmRHDrmePXi0V5iYznoGo/nbksDsq671Sx597rlIk=
X-Received: by 2002:a17:90b:378f:b0:2c2:d0cc:3b9e with SMTP id
 98e67ed59e1d1-2c7b5d95a9bmr7409623a91.46.1718969162542; Fri, 21 Jun 2024
 04:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <ZnLk_pXstP2dlRGo@debian>
 <CAC_iWjL_rytosTAcsW2-3fmwVhjTgkMRAB0LwPuNpq73K=YmcQ@mail.gmail.com>
 <ZnVEALsxt2b9s-cI@debian>
 <CAC_iWjJp6wVqDhW_kJ0Pd77Y+NpbuzoOOYqiQX5Gna2TXRN0Gg@mail.gmail.com>
In-Reply-To: <CAC_iWjJp6wVqDhW_kJ0Pd77Y+NpbuzoOOYqiQX5Gna2TXRN0Gg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Jun 2024 14:25:26 +0300
Message-ID: <CAC_iWjL-HN21rrravFukfDm03UeJjSvnfSRD1-Cm=cJJxXzTug@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, 
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 21 Jun 2024 at 14:01, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Vincent,
>
> [...]
>
> > > >   $ uuid -d 935FE837-FAC8-4394-C008-737D8852C60D
> > > >   encode: STR:     935fe837-fac8-4394-c008-737d8852c60d
> > > >           SIV:     195894493536133784175416063449172723213
> > > >   decode: variant: reserved (Microsoft GUID)
> > > >           version: 4 (random data based)
> > > >           content: 93:5F:E8:37:FA:C8:03:94:00:08:73:7D:88:52:C6:0D
> > > >                    (no semantics: random data only)
> > > >
> > > > A reserved Microsoft GUID variant does not look right.
> > >
> > > This seems like an existing bug. RFC4122 defines the MS reserved GUID=
s
> > > in the variant as
> > > 1     1     0    Reserved, Microsoft Corporation backward
> > > compatibility and the existing UUID_VARIANT_MASK is defined as 0xc0..=
.
> >
> > I think the variant mask 0xc0 is correct:
> >
> > - The variant field is in the top three bits of the "clock seq high and
> >   reserved" byte, but...
> > - The variant we want is 1 0 x (do not care for bit 5, a.k.a. "Msb2").
> >
> > With the mask 0xc0 we can clear the top two bits as we set the top most=
 bit just
> > after anyway.
> >
> > ...the mask needs to be used correctly, though; see below.
>
> Ah yes, the current code is using it in clrsetbits_8, which inverts it
> internally, so it's indeed correct.
>
> >
> > >
> > > The patch below should work for you (on top of Calebs')
> > >
> > > diff --git a/include/uuid.h b/include/uuid.h
> > > index b38b20d957ef..78ed5839d2d6 100644
> > > --- a/include/uuid.h
> > > +++ b/include/uuid.h
> > > @@ -81,7 +81,7 @@ struct uuid {
> > >  #define UUID_VERSION_SHIFT     12
> > >  #define UUID_VERSION           0x4
> > >
> > > -#define UUID_VARIANT_MASK      0xc0
> > > +#define UUID_VARIANT_MASK      0xb0
> > >  #define UUID_VARIANT_SHIFT     7
> > >  #define UUID_VARIANT           0x1
> > >
> > > diff --git a/lib/uuid.c b/lib/uuid.c
> > > index 89911b06ccc0..73251eaa397e 100644
> > > --- a/lib/uuid.c
> > > +++ b/lib/uuid.c
> > > @@ -411,9 +411,9 @@ void gen_uuid_v5(const struct uuid *namespace,
> > > struct uuid *uuid, ...)
> > >         memcpy(uuid, hash, sizeof(*uuid));
> > >
> > >         /* Configure variant/version bits */
> > > -       tmp =3D be32_to_cpu(uuid->time_hi_and_version);
> > > +       tmp =3D uuid->time_hi_and_version;
> >
> > Not caring for the endianness at all does not look right.
> > Indeed, while this does work on my side in little-endian, this does not=
 work on
> > on big-endian simulators.
>
> Yes, we need the conversions
>
> > Also, this is a 16b quantity, not 32b; we need to redefine tmp to uint1=
6_t and
> > use the be16 functions.
> >
>
> Yep I already pointed that out earlier.
>
> > >         tmp =3D (tmp & ~UUID_VERSION_MASK) | (5 << UUID_VERSION_SHIFT=
);
> > > -       uuid->time_hi_and_version =3D cpu_to_be32(tmp);
> > > +       uuid->time_hi_and_version =3D tmp;
> > >
> > >         uuid->clock_seq_hi_and_reserved &=3D UUID_VARIANT_MASK;
> >
> > We need to mask with ~UUID_VARIANT_MASK, I think.
> >
> > >         uuid->clock_seq_hi_and_reserved |=3D UUID_VARIANT << UUID_VAR=
IANT_SHIFT;
> > >
> > > Can you give it a shot?
> >
> > This does indeed work on my little-endian machines, but not on big-endi=
an
> > simulators.
> > For testing on big-endian, I suggest using only genguid as the sandbox =
will not
> > help there:
> >
> >   $ make sandbox_defconfig
> >   $ make tools-only
> >   $ ./tools/genguid 2a5aa852-b856-4d97-baa9-5c5f4421551f \
> >         -c "qcom,qrb4210-rb2" \
> >         QUALCOMM-UBOOT
> >
> > ...and feed the resulting UUID to `uuid -d'.
> > (The genguid command is the online help example.)
> >
> > > What I am afraid of is breaking existing use cases using a different
> > > variant mask....
> > > If that's the case we might need to keep the buggy existing
> > > UUID_VARIANT_MASK and use the new one only on v5 and newer code
> >
> > I tried to debug further and I suspect that:
> >
> > - Operations on 8b clock_seq_hi_and_reserved might need further casts.
> >
> > - My understanding is that we are generating the v5 UUID as big-endian =
in
> >   memory; if this is indeed the case, genguid should not print it with =
the GUID
> >   byte order.
>
> RFC4122 says that
> "put name space ID in network byte order so it hashes the same no
> matter what endian machine we're on "
> the EFI spec says
> "It should also be noted that TimeLow, TimeMid, TimeHighAndVersion
> =EF=AC=81elds in the EFI are encoded as little endian. The following tabl=
e
> de=EF=AC=81nes the format of an EFI GUID (128 bits)."
>
> Which is lovely....
>

But this brings up something that Heinrich also mentioned. Since the
efi spec and RFC4122 interpret the endianess differently, how do you
expect uuid -d to work?

Thanks
/Ilias
> I'll send a patch with the changes
>
> Regards
> /Ilias
> >
> > For the moment I am unable to make the code work in all the following c=
ases:
> >
> > - genguid on little-endian
> > - genguid on big-endian
> > - sandbox ESRT on little-endian
> >
> > I will let you and Caleb know if I make any progress.
> >
> > Best regards,
> > Vincent.
> >
> > >
> > > Thanks
> > > /Ilias
