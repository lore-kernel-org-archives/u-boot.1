Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16327C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BBBF88BA6;
	Wed,  7 Aug 2024 16:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nW0grJ5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE4988D46; Wed,  7 Aug 2024 16:57:23 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 709EA88BC6
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso1410601f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1723042641; x=1723647441;
 darn=lists.denx.de; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfmsOSpANS8+KeBONwDZT/ek3syxnE4lRFk2Idk10aY=;
 b=nW0grJ5lH+xcaPzvdPqkxaWGG/VDBQGRSPyOSTLwnfjaOWRIUzB+FanQMlH/sWm6LR
 2yGC7AdB4RhgzRzGMQlIXD+4M/8Hlj1TOgGwsgOUkai3yghvz3S+4d9ZTHKXYYssye3J
 Rd1ckrobgxoR8tf2RJLVDJgUPKd9cDG22bn/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723042641; x=1723647441;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfmsOSpANS8+KeBONwDZT/ek3syxnE4lRFk2Idk10aY=;
 b=pRDnKTUirywtMOd0XY/w6vsyH5ZcZrhXcZmCrj3fw1Gqty2HKEZNHsi2PcZ+uzmsYW
 6dkyN9YN30AtihbpK19zDGU0tXkX16VVz7Fpa4OEnoHaEjLwNoLWX9PpqB7YEm3IBDzr
 XRQMMffsinaFp0tZpMv6x/jQjeBConOp+EHTfRIfaCOeESjL1sXdSsDyqWvEMhmHhUBt
 2EFKimqmQIbidQ6qe1PckpBEkrUB/gQxioDK1ubz/Y9xl6lo10Y1NfIl8OUq1J+DmEgL
 XoyLDwU913xZMTsyB+PKlZpKtPjbqf3hTZ302fqNXf64apyGzS144OL0/b4g/CrFWcCJ
 xxfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuulHlnIMWnr0c6LKkLwv4U5t9lVZ8O0/Qk1GwlgC9N4lZVM+c47jVfohWMEKkGmYdNWoI6CgZXwhC87Ui43UId0n75g==
X-Gm-Message-State: AOJu0Yx33shK2vd4mywyFddodjMfjBfCFUghQv6K340PPRxwfXvsJHyb
 ZeufdID9G6LZfgRfuCI3xpwza/gb03wdrvcq8OCHNSBK/bF7BfAQWaCGqL7R1p14xssiLUWF2Zl
 cppJjk6xN4zYxdtQwHcLgZXgMebsKaFG3WL3xuADqDmNhfcQL
X-Google-Smtp-Source: AGHT+IFaG8aJuCQm/7UVils/FNzkStuTEn/5SsUYN/vnFdY+p/g2iyELOv6Wg0RREXrpZXrb9ibo59FipC1rtHmZfoI=
X-Received: by 2002:a5d:6a4a:0:b0:368:4910:8f43 with SMTP id
 ffacd0b85a97d-36bbc0e118dmr14084466f8f.3.1723042640671; Wed, 07 Aug 2024
 07:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240805173140.84453-1-michael@amarulasolutions.com>
 <20240807-pancake-estimate-ea370d7f9dc8@thorsis.com>
In-Reply-To: <20240807-pancake-estimate-ea370d7f9dc8@thorsis.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 7 Aug 2024 16:57:07 +0200
Message-ID: <CAOf5uwk10U0u-h=Lxkhn026kWKCHMP5JZxzb1KCzHHcJ1B6OHw@mail.gmail.com>
Subject: Re: [RFC PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
To: Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Alexander

On Wed, Aug 7, 2024 at 4:55=E2=80=AFPM Alexander Dahl <ada@thorsis.com> wro=
te:
>
> Hello Michael,
>
> Am Mon, Aug 05, 2024 at 07:31:40PM +0200 schrieb Michael Trimarchi:
> > The inode should be freed after a reference is get to avoid
> > memory leak
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> Tested this on top of my recent ubifs series.  No obvious problems
> found on U-Boot command line with various combinations of commands,
> no crashes, so =E2=80=A6
>
> Tested-by: Alexander Dahl <ada@thorsis.com>
>

I think that we can resend including last heiko remark and let heiko
to pick it from his own tree

Heiko I will add CoDevelopment if it's ok for you

Michael


> Greets
> Alex
>
> > ---
> >  fs/ubifs/ubifs.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
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
> > --
> > 2.43.0
> >



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
