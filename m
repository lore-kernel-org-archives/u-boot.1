Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AC6E7F143
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 22:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897B386053;
	Wed, 27 Sep 2023 00:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E3zOKa38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A447F86A24; Wed, 27 Sep 2023 00:44:46 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681B480569
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 00:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5044dd5b561so10654535e87.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 15:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695768283; x=1696373083; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfPSh4rRYEXNJotymP98XKhruTaqbPr4ByJl7cDjO/I=;
 b=E3zOKa38LAMsURF6wQwOAw8Qag6m28pbzVEebVpQ+9xTKKWMqXQefUtPnUObaIAfkQ
 TQvjkoALScrZv6slsmh2TWPL16vPpzTZufkpW7rPMZxERIwSHm6BispOfABwD6k1qtPk
 9hqchvJq5bvhY1jTPdr4EP9C22rjEfiPCsF4MQh8M7mc5j5qjwzXUHGpc/IvQ4RAyx1v
 7h9iuxM3xqxwi4nBDEXUW0ZgG6ZGMWu7nb+4762Ov19bB+f0wYOB0XFv2okAin+RPR0C
 wpp3EUsopUbMIpy35iyWZsbuKJoMlAV0a2FSZmcGqmHilxqNBGbvJTZ4m59YUxS7PZEi
 vZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695768284; x=1696373084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfPSh4rRYEXNJotymP98XKhruTaqbPr4ByJl7cDjO/I=;
 b=rvdn7N++Ds9lBDGPi3kmwRaQXC8FXUmaX/KdO5Yi4i1vmdGzyrqXcmxeFy6JQsYbLn
 zvgLehqw/lr67FAHKyUyoA3kUQZks39sgEBw55nK6LNW6oFp5+xPPijc89JKKH89dq0V
 zvK9MMX8b/Puplk/4uEU602OoA8s5OFeHq4fHf8cqkmBJ+rtIhBu56QDFFGsNv7XFFxX
 xvsJuvIHwFUzGyZn4PYizE190REPtkifHagjP8FsaDkUKAVxTFoP+L/w3I1kDAS3+O2D
 dxB0cTaCQ6v+4ySOfJJfJTT4CifSYtl/+HCfDP6Lsqxk5MOPEa7VK97iCj3rNq5q1Zd2
 52HQ==
X-Gm-Message-State: AOJu0YyJARKZhWZjaMu90QFMljLaXmyJtV348yff2i8KNdFuGCS4LLtW
 w6osIzZw0313getjjMZRnRKwwLsoOEIo0TOSxyp1aymz+YA=
X-Google-Smtp-Source: AGHT+IF+sy1+Z7u9SBzmDlFDinHWqoY6MixMvkKR2sjw1S5/BuYNGZiZze+imYV8oYArAur9FQzt4bTVjpNvLFkoVBU=
X-Received: by 2002:a19:9101:0:b0:4fe:25bc:71f5 with SMTP id
 t1-20020a199101000000b004fe25bc71f5mr137526lfd.11.1695768283323; Tue, 26 Sep
 2023 15:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-10-bmeng@tinylab.org>
 <875y3wohrt.fsf@waldekranz.com>
In-Reply-To: <875y3wohrt.fsf@waldekranz.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 27 Sep 2023 06:44:32 +0800
Message-ID: <CAEUhbmX7KhVpwVk37ySGY8pzRFHK5iJjebdwa_5=HPcMbU0J=Q@mail.gmail.com>
Subject: Re: [PATCH 09/15] blk: blkmap: Support mapping to device of any block
 size
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Bin Meng <bmeng@tinylab.org>, Simon Glass <sjg@chromium.org>, 
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

Hi Tobias,

On Wed, Sep 27, 2023 at 3:29=E2=80=AFAM Tobias Waldekranz <tobias@waldekran=
z.com> wrote:
>
> On tis, sep 26, 2023 at 16:43, Bin Meng <bmeng@tinylab.org> wrote:
> > At present if a device to map has a block size other than 512,
> > the blkmap map process just fails. There is no reason why we
> > can't just use the block size of the mapped device.
>
> Won't this be very confusing to the user?

I don't see any confusion.

>
> The blkmap device uses a fixed block size of 512:
>
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/block/blkmap.c=
?ref_type=3Dheads#L393

Yes, the blkmap device was originally created with a fixed block size
of 512, and that's fine.

>
> So if I map a slice of a 4k device into a blkmap, then
>
>     blkmap read 0x80000000 0 1
>
> would copy 4k instead of 512 bytes from the lower device to 0x80000000,
> even though the blkmap reports a block size of 512.
>
> It seems to me that the expected behavior would be that only the first
> 512 bytes would be copied in the command above.

No, the blkmap block size was later updated to match the real
underlying device parameter during the map process. So it will copy
all 4k to 0x80000000.

>
> >
> > Signed-off-by: Bin Meng <bmeng@tinylab.org>
> > ---
> >
> >  drivers/block/blkmap.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> > index f6acfa8927..149a4cac3e 100644
> > --- a/drivers/block/blkmap.c
> > +++ b/drivers/block/blkmap.c
> > @@ -171,11 +171,11 @@ int blkmap_map_linear(struct udevice *dev, lbaint=
_t blknr, lbaint_t blkcnt,
> >
> >       bd =3D dev_get_uclass_plat(bm->blk);
> >       lbd =3D dev_get_uclass_plat(lblk);
> > -     if (lbd->blksz !=3D bd->blksz)
> > -             /* We could support block size translation, but we
> > -              * don't yet.
> > -              */
>
> Hence this comment ^

This comment was completely removed with the new updates. There is no
need to do any block size translation. We could just use whatever
block size the lower device is using, hence this patch.

>
> > -             return -EINVAL;
> > +     if (lbd->blksz !=3D bd->blksz) {
> > +             /* update to match the mapped device */
> > +             bd->blksz =3D lbd->blksz;
> > +             bd->log2blksz =3D LOG2(bd->blksz);
> > +     }
> >
> >       linear =3D malloc(sizeof(*linear));
> >       if (!linear)
> > --

Regards,
Bin
