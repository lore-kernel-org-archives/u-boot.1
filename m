Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6291AC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 17:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C84879D2;
	Wed, 27 Dec 2023 18:49:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nl60EdBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B4D877E2; Wed, 27 Dec 2023 18:49:04 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60CD287946
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 18:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f5c0be04cso49083206d6.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703699339; x=1704304139; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CL2dBEvDz4lOJWFW2JFN/+GnqvgYu37hva5KM44TkPM=;
 b=nl60EdBbwOwYjGk/OqNrHBrQ54x29d4gaodSbWuNstx05V2Kdw6e4jZ8shl/EnIzi6
 E6S8N2u5z9wLizv5p5lwTqH6Qghy7ct9KDIpNbgHsyN6FH50OQ6hbBDi3j47X1olfdO8
 Q6klHyvGb/PzRIHEUdJrJf45sm0eL+d9NjXhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703699339; x=1704304139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CL2dBEvDz4lOJWFW2JFN/+GnqvgYu37hva5KM44TkPM=;
 b=aKmCV92KuLo8my6C0eM12LyNjZpM+E7WSFgyXXbtnEmpD9LTvFNsui3W5G9Yl6RPP/
 2t/dXJfRtfPV31GgqM+XOOWCk7HhKrZ+F8yrouMZx6yW25pKVj1ZT6p925SFwEbbHNeI
 xrOp6v5QI3bHmN8oFRl1Yj+a2AVnoPJ1+dXi3FsY9qCHXY24V33uR8NvAzvW1g7aNQt5
 IUMwLYJaHmWSbqcArFkiINX/w1r1wjL7sKpeQ4D15je/CmtlxWMGgki/ste1k5UBAMud
 JaavuYhb8tXTEzehpMcd9HyjeHpB5rzX+qAMre/F7NVuxagJa9dKTWLHXrfXwI2ryAC/
 5wHQ==
X-Gm-Message-State: AOJu0YzG3cxZZYAcC25adlPqRyqtKH0BP91Rd60BrdLPxO+xZ0Kg19i/
 GPVN0fi3ulC/x9GC1ylGNHfn7MGYQ2tOuzwAd6LZTqnlExPo
X-Google-Smtp-Source: AGHT+IE7u+9a6v2PVevf+EZ11mO/FnUihxDyEDpUe5T+Nx+gK9jYETGJMoiRuKPO1E0p6rnAaHqVtN9symyumffJaaA=
X-Received: by 2002:a05:6214:2b0a:b0:67f:91f6:21c5 with SMTP id
 jx10-20020a0562142b0a00b0067f91f621c5mr16197306qvb.2.1703699339281; Wed, 27
 Dec 2023 09:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-4-sjg@chromium.org>
 <0979cfd8-edf6-4934-9dfe-46e0fb6a67f6@gmx.de>
In-Reply-To: <0979cfd8-edf6-4934-9dfe-46e0fb6a67f6@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 17:48:48 +0000
Message-ID: <CAFLszTiTw973P3w3qG6X2wOwKZwHi_nSxqRyvb48vaxeybXXcA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address above
 4GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Tue, Dec 26, 2023 at 11:01=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> On 10/15/23 04:45, Simon Glass wrote:
> > When the SMBIOS table is written to an address above 4GB a 32-bit table
> > address is not large enough.
> >
> > Use an SMBIOS3 table in that case.
> >
> > Note that we cannot use efi_allocate_pages() since this function has
> > nothing to do with EFI. There is no equivalent function to allocate
> > memory below 4GB in U-Boot. One solution would be to create a separate
> > malloc() pool, or just always put the malloc() pool below 4GB.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Check the end of the table rather than the start.
> >
> >   include/smbios.h | 22 +++++++++++++++++++++-
> >   lib/smbios.c     | 24 +++++++++++++++++++-----
> >   2 files changed, 40 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/smbios.h b/include/smbios.h
> > index c9df2706f5a6..ddabb558299e 100644
> > --- a/include/smbios.h
> > +++ b/include/smbios.h
> > @@ -12,7 +12,8 @@
> >
> >   /* SMBIOS spec version implemented */
> >   #define SMBIOS_MAJOR_VER    3
> > -#define SMBIOS_MINOR_VER     0
> > +#define SMBIOS_MINOR_VER     7
> > +
> >
> >   enum {
> >       SMBIOS_STR_MAX  =3D 64,   /* Maximum length allowed for a string =
*/
> > @@ -54,6 +55,25 @@ struct __packed smbios_entry {
> >       u8 bcd_rev;
> >   };
> >
> > +struct __packed smbios3_entry {
> > +     u8 anchor[5];
> > +     u8 checksum;
> > +     u8 length;
> > +     u8 major_ver;
> > +
>
> This empty line is superfluous.
>
> > +     u8 minor_ver;
> > +     u8 docrev;
>
> 'doc_rev' would be more consistent with the other fields.
>
> > +     u8 entry_point_rev;
> > +     u8 reserved;
> > +     u32 max_struct_size;
> > +
>
> This empty line is superfluous.
>
> Please, consider copying the comments from my patch
>
> [PATCH v2,1/2] smbios: SMBIOS 3.0 (64-bit) Entry Point structure
> https://patchwork.ozlabs.org/project/uboot/patch/20231223010334.248291-2-=
xypron.glpk@gmx.de/
>
> Otherwise looks good to me.

Thanks, I added in your patch and resent the series.

I tested it with dmicode and it seems to work OK.

Regards,
Simon
