Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFF4C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 16:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A849880A5;
	Wed, 15 May 2024 18:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="E7Zi8pS4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E437E88276; Wed, 15 May 2024 18:29:46 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F21188260
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 18:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a5a89787ea4so193384366b.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715790583; x=1716395383; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aub+xpLtsuK65oldYgWCYhKiE+666x71m1Bv0Re7hgY=;
 b=E7Zi8pS4JCRVlUe9vb1zpjjn0hkPHmb+HgJIpV4q2fPbf9erLtk7RKZ1r3uGF0LeCO
 2AJn/99qJLerv2WhPse433f8kwuimz6FJ8s/lowIsj9D0VVYyTa4rAI4T7MHbLaEVCBb
 xajcvOixw7LwXQeAQdsnI1qaURxwKqS7+LvEz8nBqzmv2231GCSo2QrNPI12/8NqvPOx
 FwldYhumidMyE5P+lmKcqYf1SjaJgPjlTqHY75ss0c4ncCpMBZbIBvXgtZwxWIEr3HmW
 YmvSyDEPGDsf8zDBYPWv0ku1Ms4MlHK1LU0iS8LxfxWlLARfTxo78RIKE2FlkP0wN7gD
 snug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715790583; x=1716395383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aub+xpLtsuK65oldYgWCYhKiE+666x71m1Bv0Re7hgY=;
 b=tUIFe5k1nlAt0SzfYSPaKBQ3tnXr6uy7ewFWC0jlIIoj0MOH58vYoBZ4kwb2vGLFHK
 /cg/T0pOKwHI7UzCChSLcRjnLzCof7UqPaZhjgRMAFwfLvJxJ+vephSus340S3hOYaeW
 SDCVhyTOud7riJM5fJRjFGFzdKLvuH1QzG1NTymbSVikq2+W7/3rXHytehT9B40hXdPn
 q5q8vqoH/MRsBRS7YNoJsaMxzqk/8gZrhN+kK3t9vykgGpqyThiUsVLHJHzuLhyDVskl
 s7Zyd4CpRKkOWNXSF5+l0X9oBY0D5PCRCZuKqApDx81r2AqQV8awG/OLDeYDv2Nz/JCM
 CibQ==
X-Gm-Message-State: AOJu0YxJXa+PoKnGJ1jZYsZnA+ryl5sgRW4jOWMZ3pYzOhbPJPstXdEX
 fIcRCKw08+r3OiEa/Cfvkt5gWWD+7QVkCfRY5AY5kFVSA4LJAiGvxsVumlqFUU9JWRHrnI7xief
 Q2R8t0PGc0Qo4mz29DjUuIbhAjmWeBYm6mIzdwA==
X-Google-Smtp-Source: AGHT+IGbsdj56EN4ru+jJCT43JbeEemaHCZ4BnoOJ5cMJni4+kF7wsO82eHZAKPqWwCnnirs+NXURqigI6OGBoHkLOk=
X-Received: by 2002:a17:906:3155:b0:a5a:1b78:9450 with SMTP id
 a640c23a62f3a-a5a2d54c0aamr1054815666b.6.1715790583591; Wed, 15 May 2024
 09:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240515002248.2920155-1-tharvey@gateworks.com>
 <039c0adc-3014-4ae7-99b3-0df9e5366b79@denx.de>
In-Reply-To: <039c0adc-3014-4ae7-99b3-0df9e5366b79@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 15 May 2024 09:29:31 -0700
Message-ID: <CAJ+vNU0nSV-xKkrrXtod9zYfsSe2vUQsCVEgq9PntTxCnqV0dA@mail.gmail.com>
Subject: Re: [PATCH] fdt: add kaslr-seed if DM_RNG is enabled
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
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

On Tue, May 14, 2024 at 5:50=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 5/15/24 2:22 AM, Tim Harvey wrote:
> > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > randomize the virtual address at which the kernel image is loaded, it
> > expects entropy to be provided by the bootloader by populating
> > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>
> Thanks for working on this one, this is really nice.
>
> > If we have DM_RNG enabled poulate this value automatically when
> > fdt_chosen is called.

Hi Marek,

Just noticed a typo in the commit log - I'll s/poulate/populate/ in v2

> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >   boot/fdt_support.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 874ca4d6f5af..cd3069baf450 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -7,10 +7,12 @@
> >    */
> >
> >   #include <abuf.h>
> > +#include <dm.h>
> >   #include <env.h>
> >   #include <log.h>
> >   #include <mapmem.h>
> >   #include <net.h>
> > +#include <rng.h>
> >   #include <stdio_dev.h>
> >   #include <dm/ofnode.h>
> >   #include <linux/ctype.h>
> > @@ -300,6 +302,27 @@ int fdt_chosen(void *fdt)
> >       if (nodeoffset < 0)
> >               return nodeoffset;
> >
> > +     if (IS_ENABLED(CONFIG_DM_RNG)) {
> > +             struct udevice *dev;
> > +             size_t len =3D 0x8;
> > +             u64 *data;
> > +
> > +             data =3D malloc(len);
>
> Can you allocate this 8 byte array on stack , i.e. u64 data[2]; ?
>

Sure... that makes sense - u64 data (just 1 64bit value)

> cmd/kaslrseed.c could use similar clean up (and
> lib/efi_loader/efi_dt_fixup.c and boot/pxe_utils.c ... uhhh). Maybe you
> can deduplicate this functionality into common code shared by all those
> duplicates before the duplication gets out of control ?
>
> lib/kaslrseed.c looks like a good place to put the common stuff.

Yes I started off making a function to do this but then I noticed we
had an fdt_chosen function and it fit there nicer as I didn't have to
find/create the chosen node. I also didn't know of a great place to
put it.

I will create a lib/kaslrseed.c with function for v2.

>
> > +             if (!data)
> > +                     return -ENOMEM;
> > +
> > +             err =3D uclass_get_device(UCLASS_RNG, 0, &dev);
> > +             if (!err)
> > +                     err =3D dm_rng_read(dev, data, len);
> > +             if (!err)
> > +                     err =3D fdt_setprop(fdt, nodeoffset, "kaslr-seed"=
, data, len);
> > +             if (err < 0) {
> > +                     printf("WARNING: could not set kaslr-seed %s.\n",
> > +                            fdt_strerror(err));
> > +                     return err;
> > +             }
>
> You're missing free() here, but it shouldn't be needed if you allocate
> the array on stack, which is better/simpler.

Yes, I will avoid the malloc to fix that.

Thanks,

Tim
