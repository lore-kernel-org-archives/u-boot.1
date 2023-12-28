Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE7CC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F379087A06;
	Thu, 28 Dec 2023 14:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ODD6Yv3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB0887A34; Thu, 28 Dec 2023 14:37:29 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4970087A01
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d4414ec9c7so10235785ad.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770645; x=1704375445; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxVyGGFOZecFbHRa4Msw9FEQemnMAJDZ0rCN66Sncbg=;
 b=ODD6Yv3IeQrwnlcV+Sh3FfkVgXrfzzhyqz3DlZUC/vCLIjVTEHQW4R0ATfr8TpxCV7
 3kiCdUq9lrSRNKXFtMzVyfCXos5IY2Q81gKlTHRNM9GoBFGlUBJquzb2YQ/g+OjqK4Np
 wlDPapCbTmvasVrheB6GC8hHxyDV9oHb8f+XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770645; x=1704375445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxVyGGFOZecFbHRa4Msw9FEQemnMAJDZ0rCN66Sncbg=;
 b=YwBB6mSxye36NW+nyJTuT5cfVB8MStNohbD3YjLN5cXmahLdsNRbTR33kcFwCxyuV4
 gSsLa4AGiQIdUUj3WSlJkhxTlUtV+zEwpSTK8y6rzFwrYIggDRhzR4EEp4Fo1TCfcINw
 TtEx1b+zK9W2Jld6uGukhpMYCkE0SjIpgzQVZRi81v1e0DwE/Znj2WL9zGBnOhyPxy/E
 tEMcDM6Q92ibM4yF3R9zHNB6Js6d3FI0CKmU0SAeJzFMS/g1QcPm7nNY71fC0lBdiSdk
 FcV7LJwFMF3UKaE9Bv7E54g52r9jmIcLukOSkYiOwzxTNfYF7vxOF24LIbJblOx2C2Ri
 mqeA==
X-Gm-Message-State: AOJu0YzaoDctmBF38OcHaS25er6Mot2Kms7BXcpV/mlfRskF+igBgJsN
 ysnBOX9ff4EcjTLEj02cPmv4JZ9urwpjoguE9rKJ8RAq0gZp
X-Google-Smtp-Source: AGHT+IEvyxnVVkYf/GP80lY9Zum0VUX0+m5aFHvWralZOPS7dnad4rNHW9FCPgR8duNI2FQt6qxeGz/ijqugSUN/NXQ=
X-Received: by 2002:a17:90a:5802:b0:28c:2623:c31a with SMTP id
 h2-20020a17090a580200b0028c2623c31amr2539204pji.94.1703770645642; Thu, 28 Dec
 2023 05:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-9-raymond.mao@linaro.org>
 <CAC_iWjJ2GAOU93x1gHPYKXyiU0j6Tp0yHqeCtsctY3mOdz+9VA@mail.gmail.com>
In-Reply-To: <CAC_iWjJ2GAOU93x1gHPYKXyiU0j6Tp0yHqeCtsctY3mOdz+9VA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:12 +0000
Message-ID: <CAFLszTiWbdziP2NLGuFoGaJO4reU4MF+k7kLecDYL6KsS5ZaQQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] bloblist: Handle alignment with a void entry
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Ilias,

On Thu, Dec 28, 2023 at 11:32=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Raymond,
>
> On Wed, 27 Dec 2023 at 23:08, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Rather than setting the alignment using the header size, add an entirel=
y
> > new entry to cover the gap left by the alignment.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >  common/bloblist.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 705d9c6ae9..73dbbc01c0 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -142,7 +142,7 @@ static int bloblist_addrec(uint tag, int size, int =
align_log2,
> >  {
> >         struct bloblist_hdr *hdr =3D gd->bloblist;
> >         struct bloblist_rec *rec;
> > -       int data_start, new_alloced;
> > +       int data_start, aligned_start, new_alloced;
> >
> >         if (!align_log2)
> >                 align_log2 =3D BLOBLIST_ALIGN_LOG2;
> > @@ -151,10 +151,25 @@ static int bloblist_addrec(uint tag, int size, in=
t align_log2,
> >         data_start =3D map_to_sysmem(hdr) + hdr->alloced + sizeof(*rec)=
;
> >
> >         /* Align the address and then calculate the offset from ->alloc=
ed */
> > -       data_start =3D ALIGN(data_start, 1U << align_log2) - map_to_sys=
mem(hdr);
> > +       aligned_start =3D ALIGN(data_start, 1U << align_log2) - data_st=
art;
> > +
> > +       /* If we need to create a dummy record, create it */
> > +       if (aligned_start) {
> > +               int void_size =3D aligned_start - sizeof(*rec);
> > +               struct bloblist_rec *vrec;
> > +               int ret;
> > +
> > +               ret =3D bloblist_addrec(BLOBLISTT_VOID, void_size, 0, &=
vrec);
>
> I just noticed the 'BLOBLISTT'. Is that on purpose? or a typo?

It means 'bloblist tag'

>
> > +               if (ret)
> > +                       return log_msg_ret("void", ret);
> > +
> > +               /* start the record after that */
> > +               data_start =3D map_to_sysmem(hdr) + hdr->alloced + size=
of(*vrec);
> > +       }
> >
> >         /* Calculate the new allocated total */
> > -       new_alloced =3D data_start + ALIGN(size, 1U << align_log2);
> > +       new_alloced =3D data_start - map_to_sysmem(hdr) +
> > +               ALIGN(size, 1U << align_log2);
>
> So, wouldn't it make more sense to add the dummy record and align the
> whole thing *after* we've added the entry?
> Doing it like this might leave the last entry on an unaligned boundary, n=
o?

I will let Raymond respond as I'm not sure what this means.

>
> Thanks
> /Ilias
> >
> >         if (new_alloced > hdr->size) {
> >                 log_err("Failed to allocate %x bytes size=3D%x, need si=
ze=3D%x\n",
> > @@ -164,7 +179,7 @@ static int bloblist_addrec(uint tag, int size, int =
align_log2,
> >         rec =3D (void *)hdr + hdr->alloced;
> >
> >         rec->tag =3D tag;
> > -       rec->hdr_size =3D data_start - hdr->alloced;
> > +       rec->hdr_size =3D sizeof(struct bloblist_rec);
> >         rec->size =3D size;
> >
> >         /* Zero the record data */
> > --
> > 2.25.1
> >

Regards,
Simon
