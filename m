Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCAFCD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2478490D;
	Wed,  6 May 2026 17:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rkDjGU+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9527984915; Wed,  6 May 2026 17:00:58 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B3B84903
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-9568159ee07so4166824241.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778079655; cv=none;
 d=google.com; s=arc-20240605;
 b=lu2Q4yJRyMM5mFHuX73AD0JgH2/FvVaOX22NoxuNuDGB5+IFGqjkeD0n2EIxUjefLJ
 jnnXMJU9xeYZylT572WryXCOipXxCcOUVqMfIdyLNCGBjYV0gpC+SR7uRiq78fy5UrBi
 zPf/XLTgCig7ybcG0IpcWEIAns6qB2MeC9peSP/gJf936YFzfmeLgFy7DZ4jFHCkTA3k
 8JeMb3TnWlEGxoRg92rONYHb/X+iE4BuC+QWiC7xgvDzBpKi5vidCL/+ksl5PlCKjWVg
 FRPMTEI4nCUIJpAmViIMOim7gxTQ9TD3KQkqKFnC4dbLRXfKAp3kzHeBzJven6v+74pE
 +nzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QdNM4USzhtzXWbOw45q3Ztws0njuQZklE/mcIb4cpUc=;
 fh=OblTLGc+1lUH8TfSwNzRn3G+tmUUu8l4kpFItvLaOJ8=;
 b=CXo/gz4UulSQ0Wp0vjEWMAJHd25gz5zkhzAFFZeBAzyjmd5zhEKqyuaTau70zxCzPa
 mlKuesazgOcJxgn63tb0ARONR8aEZceb4JNZOTAu0k+E6SHweMtHRQBi7E92DVdLUEpE
 XoNXBWU3TjpZo6EERkIsez45BCMl86d1VBtXy1tLSGGPgdSGzjcXJl0KJQShJ3maCXW5
 KLFEDsaeVrpb8J4P9L2FK6qo6wK1C6r4ACK5DKgqVk9rVULQwJLa21vKE1ptZaWSFR6a
 h9mfCy+TamkrJ+mPo9kAonbAcRCC0PXYlCW70b3PasfHopT8cUty3R9aySeYJczEN0Pc
 oQwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778079655; x=1778684455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdNM4USzhtzXWbOw45q3Ztws0njuQZklE/mcIb4cpUc=;
 b=rkDjGU+UKlYJZX4RB43jku9oxdkIHkrTYhaZ1HkUAoOSwoe/rA6K1V0yhHMl5gTqEK
 BBvot/Dqp/nIBE/T+LWd5bN3Qn3tYM5T/+8tFzJUsFceFHt3DKtMb24NNCY+it3c0t2V
 Z+zgv93Tl2soIXhneD5+LHQQxqvH0e5oWVfLJbHin+jiiALOMwF6PuKvxI6TqpPChCr8
 cG6RJ3YzTW4EbA6kbI++GOp/c8+kVbtVkaKnJbfI5DSQCwZdJOSxuXdX3cy7RlXX4pyT
 2bOg1z+lzigYIkZ5OYfAj0SElcJgvj7CGbQFAJZWt3Mq68emx6sw9XvpxU09bEXV6Wy+
 c6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778079655; x=1778684455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QdNM4USzhtzXWbOw45q3Ztws0njuQZklE/mcIb4cpUc=;
 b=FgJSpPoShEjQXAbtWNxzXdJ2FNPUY3dApDS6B/7SDgE1vqvdhxVLL+LxuvOybIK+ue
 6R3x7PislmVsAWypgyV4QPZ8l1xF6tF6QuVzBukTsZ2N+SrTx/Mzf4ILd5cZiUHFHwkz
 evpvqZSSE9as9LtyFYDJDIBdgpeRlfOeyTP3HXIi0kR57xp/VFmeX8lwu38ERU67dA1y
 gKLekGN/AuhJn96KuWIl2q5IQE/KFZTR8a4B39TYvevW3E49ki2UW6wn27sAJ3X5AN/C
 tu2BfkPjiX9vbVte1Joqlaq4w8bUQe9Hc3OErAT/4cDaLvEevCAeXjZ1HeeXT7WtPl6f
 P5zQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mPCfFIkeK+YjOxThLSYL2Pa167HWMYsKYNdXAytny1IpZY211JIkzHLi6L4VAjjv1ZXI1WD8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5CGnH+2a37tLr2DTnMxLyHEWUXihvaSkhxJvPSc5XhvS/CbO3
 Ag9wsbgoNiS7/dyqW7Cr4wkwRBZEc7v6oHtiBOioLwKrP0dI4Tk46QYFexP09wySLSq2fQSKQro
 iM5Gm+auvKwvKdM3DpwFH48qcOxe9KTU=
X-Gm-Gg: AeBDiesI/0YL8w1EIYoGRKI06wyH9f9H+B8YgwdIuQmJRxG7f5YiT5Yt2a1HHVYm+wl
 sUGcFLhEbMDSWEdY5EHXc7w+88torQIlu2GIqEbqv6y3b7T+ren5Evi1VGe2++lmtYlPMnW4w+K
 xbhAsLx/PUyRmxac3/R/fbDWdSRc0z2svo2zuZI7l2qt80ZfVX9PxNSwsH/v2S9pqBNLaVTjYKf
 XntaLgdr24EurAJy9lW4tdjlMoFWGCf1m070CvRkf+JC7g8FZ60GAwmdGvCoY/oTLUd/EmsFFxf
 bk1V617hElPRnvct4uzXQXlKcx1kZA==
X-Received: by 2002:a05:6102:3f52:b0:604:f29d:84be with SMTP id
 ada2fe7eead31-630f8e78530mr1739585137.3.1778079654573; Wed, 06 May 2026
 08:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260504212524.1665166-1-raymondmaoca@gmail.com>
 <b7432c55f00b4c9b2043ca8efb262a5d5ec4d6e2.camel@siemens.com>
 <CAMDkj5yUHypTiuYk+VqOVA3FSJpDo6CsqsVAWn69nOS3EapAcw@mail.gmail.com>
 <064b011e32963eb1e6220cafe4614186a1fc16c8.camel@siemens.com>
 <20260505143219.GQ1614990@bill-the-cat>
In-Reply-To: <20260505143219.GQ1614990@bill-the-cat>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 6 May 2026 11:00:43 -0400
X-Gm-Features: AVHnY4KThHJlL8UQU5_RB6h2wANWaKTTGx-J6rhqdchf6y0gd2knQlY025G5sYY
Message-ID: <CAMDkj5xX5Vpzg1OEc=FGaJNWAyNrsPwtD9HQnVOxDbkr42VUQQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
To: Tom Rini <trini@konsulko.com>
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "casey.connolly@linaro.org" <casey.connolly@linaro.org>, 
 "raymond.mao@riscstar.com" <raymond.mao@riscstar.com>,
 "pranav.sanwal@amd.com" <pranav.sanwal@amd.com>, 
 "michal.simek@amd.com" <michal.simek@amd.com>
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

Hi Tom,

On Tue, May 5, 2026 at 10:32=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, May 05, 2026 at 01:49:53PM +0000, Sverdlin, Alexander wrote:
> > Hi Raymond,
> >
> > On Tue, 2026-05-05 at 09:47 -0400, Raymond Mao wrote:
> > > > > Coverity Scan defects are observed in fdtdec_apply_bloblist_dtos(=
),
> > > > > since the live FDT taken from the bloblist is passed to libfdt he=
lpers
> > > > > which consume header size/offset fields:
> > > > > - fdt_open_into()
> > > > > - fdt_pack()
> > > > > - bloblist_resize(..., fdt_totalsize(...))
> > > > >
> > > > > Add a small helper to validate the FDT header and confirm that th=
e
> > > > > advertised totalsize fits within the currently allocated bloblist
> > > > > record. Use the sanitized size before calling fdt_open_into(), ag=
ain
> > > > > after overlays are applied before calling fdt_pack(), and once mo=
re
> > > > > after packing before shrinking the bloblist record.
> > > > >
> > > > > This keeps the existing flow unchanged while making the size cons=
umers
> > > > > operate on validated FDT metadata.
> > > > >
> > > > > Fixes: b70cbbfbf94f ("fdtdec: apply DT overlays from bloblist")
> > > > > Addresses-Coverity-ID: CID 645837: (TAINTED_SCALAR)
> > > > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > > > ---
> > > > > changes in v2:
> > > > > - Rebased on master.
> > > > >
> > > > >   lib/fdtdec.c | 43 +++++++++++++++++++++++++++++++++++++++----
> > > > >   1 file changed, 39 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > > > index 2d66860f6ed..601f418db6e 100644
> > > > > --- a/lib/fdtdec.c
> > > > > +++ b/lib/fdtdec.c
> > > > > @@ -1744,9 +1744,31 @@ static int fdtdec_apply_dto_blob(void **bl=
ob, __maybe_unused int size)
> > > > >        return fdt_overlay_apply_verbose((void *)gd->fdt_blob, *bl=
ob);
> > > > >   }
> > > > >
> > > > > +static int fdtdec_get_valid_fdt_size(const void *fdt, int alloc_=
size,
> > > > > +                                  int *fdt_sizep)
> > > > > +{
> > > > > +     int ret, fdt_size;
> > > > > +
> > > > > +     /*
> > > > > +      * Validate the header before libfdt trusts any header offs=
ets/sizes.
> > > > > +      * Also make sure the advertised totalsize fits in the blob=
list record.
> > > > > +      */
> > > > > +     ret =3D fdt_check_header(fdt);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     fdt_size =3D fdt_totalsize(fdt);
> > > > > +     if (fdt_size > alloc_size)
> > > > > +             return -FDT_ERR_TRUNCATED;
> > > >
> > > > here you return an error from the libfdt error space, but...
> > > >
> > > > > +
> > > > > +     *fdt_sizep =3D fdt_size;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > >   static int fdtdec_apply_bloblist_dtos(void)
> > > > >   {
> > > > > -     int ret;
> > > > > +     int ret, live_fdt_size;
> > > > >        struct fdt_header *live_fdt;
> > > > >        int blob_size;
> > > > >        size_t padded_size, max_size;
> > > > > @@ -1760,8 +1782,12 @@ static int fdtdec_apply_bloblist_dtos(void=
)
> > > > >        if (live_fdt !=3D gd->fdt_blob)
> > > > >                return -ENOENT;
> > > >
> > > > ... the caller returns the codes from the standard errno.h
> > > >
> > > > >
> > > > > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &liv=
e_fdt_size);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > >        /* Calculate the allowed padded size */
> > > > > -     padded_size =3D fdt_totalsize(live_fdt) + CONFIG_SYS_FDT_PA=
D;
> > > > > +     padded_size =3D live_fdt_size + CONFIG_SYS_FDT_PAD;
> > > > >        max_size =3D bloblist_get_total_size() - bloblist_get_size=
() + blob_size;
> > > > >        if (padded_size > max_size)
> > > > >                padded_size =3D max_size;
> > > > > @@ -1772,6 +1798,7 @@ static int fdtdec_apply_bloblist_dtos(void)
> > > > >                if (ret)
> > > > >                        return ret;
> > > > >
> > > > > +             blob_size =3D padded_size;
> > > > >                ret =3D fdt_open_into(live_fdt, live_fdt, padded_s=
ize);
> > > > >                if (ret)
> > > > >                        return ret;
> > > > > @@ -1781,12 +1808,20 @@ static int fdtdec_apply_bloblist_dtos(voi=
d)
> > > > >        if (ret)
> > > > >                return ret;
> > > > >
> > > > > -     /* Shrink the blob to the actual FDT size */
> > > > > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &liv=
e_fdt_size);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > >        ret =3D fdt_pack(live_fdt);
> > > > >        if (ret)
> > > > >                return ret;
> > > > >
> > > > > -     return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize=
(live_fdt));
> > > > > +     ret =3D fdtdec_get_valid_fdt_size(live_fdt, blob_size, &liv=
e_fdt_size);
> > > >
> > > > doesn't the fdt_pack() already guarantee a valid header? Can the pa=
cked size
> > > > exceed the blob_size if packing only shrinks?
> > > >
> > >
> > > This might not happen, but just in order to solve the complaint from
> > > the coverity tool, otherwise we need an exemption.
> >
> > Is it some king of new U-Boot policy that Coverity false-positives just=
ify
> > a dead or cargo-cult code? Shall it maybe fixed in Coverity itself?
>
> If this is a false-positive we can just mark it as such in Coverity.
> That would be the correct path.
>

v3 is posted at:
https://lore.kernel.org/u-boot/20260506145535.1679611-1-raymondmaoca@gmail.=
com/T/#u
leaving the report (as below) between fdt_pack() and bloblist_resize()
as a false-positive.

1784            /* Shink the blob to the actual FDT size */
1785            fdt_pack(live_fdt);
>>>     CID 645837:           (TAINTED_SCALAR)
>>>     Passing tainted expression "fdt32_ld(&((struct fdt_header const *)l=
ive_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
1786            return bloblist_resize(BLOBLISTT_CONTROL_FDT,
fdt_totalsize(live_fdt));

Regards,
Raymond

> --
> Tom
