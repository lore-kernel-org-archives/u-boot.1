Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C47C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 12:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D19E488802;
	Sat, 10 Aug 2024 14:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hy/xRBYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB4788868; Sat, 10 Aug 2024 14:58:48 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59863887E8
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 14:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a1337cfbb5so3916013a12.3
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1723294726; x=1723899526;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd9i1Vrac1lhj9hEXj2pBmg3+bzs0r+olgbHziSP2PY=;
 b=hy/xRBYLogtybNVX67y5Rl3ogNbW8cIAXOhRu/o3ZGaSyV35j0hG/bjRQvtFqdTH3s
 F6Xezma8BkYatEy3epYL+1q89Cf68hJvvzjdJ1B+Z2LF1c/L1nAqDV3s4mceP0ZXHEkV
 +kYOgLIIJ4gZTmvQhUkiVTAnczyOn0pzsQAUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723294726; x=1723899526;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rd9i1Vrac1lhj9hEXj2pBmg3+bzs0r+olgbHziSP2PY=;
 b=UWaxGt+TITBZlz2EqKgwwN8gDVbO6ETmusP8QzQEPYWbC72FB1PkuoGmFKRcH42KZt
 GY1tkIKFPI2AeOJ9YPxremDBFaNqHa+7TLqh5CLoi8wktn0hAx6ZsbX3AHPRLcqihgzG
 prq1nxmAQS++C2wfQdi15snH0As9MzBLzFBYhBF/F7MyrBjWJGSDe5U+Fn+CjAHsUQxg
 AGDwPSQ3gbU6NPD7/vLMBOCyessmZq0QuFzTXXBkg7QKlJxCJsrgx9z6EdH6o1/PocuN
 rvC5bbuRllE3cwl5mttncY1lzs6uPpm3jwXSAsFF+a6V/6tSByBPWjxxIutyfrayW1Bz
 c23A==
X-Gm-Message-State: AOJu0YyRh/SUCehfS3p+1aex0r6FB2JcD/EZwtXOsg29MCJ/jSww4BZ8
 q0+/uCiE+q5MfCzQY8rkCY6QMcXzMSm44SL3k6zU8f1Cnmbt6E3sAoiyk41pDAS675oFycAWXUN
 0Qnocm5NNNArkUnjscemt1d7EL+5sdv3aahCngkYXjVw+Ef9ccdk=
X-Google-Smtp-Source: AGHT+IGp9FUQBmYDBS14JHYymw3avByxrt0cFLFBl3/Jbsu+5zIiInTlrJJKIVkzMu8LSvClX6aFVnc4KuR3uQ96h90=
X-Received: by 2002:a17:907:1b04:b0:a7a:a138:dbd4 with SMTP id
 a640c23a62f3a-a80aa67ae8bmr320211266b.64.1723294725803; Sat, 10 Aug 2024
 05:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240807154210.1224130-1-michael@amarulasolutions.com>
 <f35969d7-4677-1c7f-e70b-1b3245720009@denx.de>
In-Reply-To: <f35969d7-4677-1c7f-e70b-1b3245720009@denx.de>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 10 Aug 2024 14:58:34 +0200
Message-ID: <CAOf5uw=_0NOTha+bBF8GncG-GEo2Td61xKdoQ83=8tcsfTVG2A@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
To: hs@denx.de
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Dahl <ada@thorsis.com>
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

Hi Heiko

On Sat, Aug 10, 2024 at 1:11=E2=80=AFPM Heiko Schocher <hs@denx.de> wrote:
>
> Hello Michael,
>
> On 07.08.24 17:42, Michael Trimarchi wrote:
> > The inode should be freed after a reference is get to avoid
> > memory leak
> >
> > Tested-by: Alexander Dahl <ada@thorsis.com>
> > Link: https://lore.kernel.org/u-boot/b698ec3e-d857-6512-8cc9-4edcab0a41=
b9@denx.de/T/#t
> > Link: https://lore.kernel.org/all/8f3a7059-6330-f332-8e9f-729b853e001e@=
denx.de/T/
> > Co-Developed-by: Heiko Schocher <hs@denx.de>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> > RFC=3D>V1:
> >       - Heiko gives more points to address on the patch and review it
> >       - Alexander Dahl test on top of his own series reported in the
> >         commit message
> >       - add leak on super.c file too from Heiko
> > ---
> >   fs/ubifs/super.c | 1 +
> >   fs/ubifs/ubifs.c | 9 ++++++---
> >   2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> > index d8d78a2d3d..7721e168fb 100644
> > --- a/fs/ubifs/super.c
> > +++ b/fs/ubifs/super.c
> > @@ -2321,6 +2321,7 @@ static int ubifs_fill_super(struct super_block *s=
b, void *data, int silent)
> >               goto out_umount;
> >       }
> >   #else
> > +     ubifs_iput(inode);
> >       sb->s_root =3D NULL;
> >   #endif
>
> This breaks build:
>

I was silly not to pay attention on it

Michael

> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D120&view=3Dlogs&=
j=3D4f2a9147-48ab-50e3-8e13-2f207368f205&t=3D617c682e-fe32-5637-a697-bfafa3=
14b3b3&l=3D271
>
> obviously it must be
>
> ubifs_iput(root);
>
> Sorry... can you send a v2 please?
>
> bye,
> Heiko
>
> >
> > diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> > index 048730db7f..6acd6c3776 100644
> > --- a/fs/ubifs/ubifs.c
> > +++ b/fs/ubifs/ubifs.c
> > @@ -319,9 +319,7 @@ static int filldir(struct ubifs_info *c, const char=
 *name, int namlen,
> >       }
> >       ctime_r((time_t *)&inode->i_mtime, filetime);
> >       printf("%9lld  %24.24s  ", inode->i_size, filetime);
> > -#ifndef __UBOOT__
> >       ubifs_iput(inode);
> > -#endif
> >
> >       printf("%s\n", name);
> >
> > @@ -557,6 +555,7 @@ static unsigned long ubifs_findfile(struct super_bl=
ock *sb, char *filename)
> >
> >                       /* We have some sort of symlink recursion, bail o=
ut */
> >                       if (symlink_count++ > 8) {
> > +                             ubifs_iput(inode);
> >                               printf("Symlink recursion, aborting\n");
> >                               return 0;
> >                       }
> > @@ -568,6 +567,7 @@ static unsigned long ubifs_findfile(struct super_bl=
ock *sb, char *filename)
> >                                * the leading slash */
> >                               next =3D name =3D link_name + 1;
> >                               root_inum =3D 1;
> > +                             ubifs_iput(inode);
> >                               continue;
> >                       }
> >                       /* Relative to cur dir */
> > @@ -575,6 +575,7 @@ static unsigned long ubifs_findfile(struct super_bl=
ock *sb, char *filename)
> >                                       link_name, next =3D=3D NULL ? "" =
: next);
> >                       memcpy(symlinkpath, buf, sizeof(buf));
> >                       next =3D name =3D symlinkpath;
> > +                     ubifs_iput(inode);
> >                       continue;
> >               }
> >
> > @@ -583,8 +584,10 @@ static unsigned long ubifs_findfile(struct super_b=
lock *sb, char *filename)
> >                */
> >
> >               /* Found the node!  */
> > -             if (!next || *next =3D=3D '\0')
> > +             if (!next || *next =3D=3D '\0') {
> > +                     ubifs_iput(inode);
> >                       return inum;
> > +             }
> >
> >               root_inum =3D inum;
> >               name =3D next;
> >
>
> --
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de



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
