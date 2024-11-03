Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B244E67807
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 08:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2708D88FBD;
	Sun,  3 Nov 2024 09:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z2tCGURo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D72B68908D; Sun,  3 Nov 2024 09:21:45 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C9288A37
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 09:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e3010478e6so2496384a91.1
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 01:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1730622102; x=1731226902;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hwqyco7OgtCCNznxz1plJh4U/skVTZZCi+gOz36WrRo=;
 b=Z2tCGURoTht/h1cSzRNopCx6mFAEMJFWxZ7E/NMnqGRU3GxbK64nS1OLI+4Qb1IzFI
 0v7JRHu/EGfoMR3Y04th+VCNbfEutX6uPmO7531tmnz8vgTIndLvFIex/VTFu7LEGrQq
 xE7RygxcnNIwuEyreDDdd+7sTpkQZ8vKOVj2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730622102; x=1731226902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hwqyco7OgtCCNznxz1plJh4U/skVTZZCi+gOz36WrRo=;
 b=jYyZLuDP49UPYQbnhhxdED1awj1ExJnhBCUNjlojicmw3Bz1Xnb6SuCXeDqFanQ3PZ
 NTziQfsvSbj92EpanOKX5Gdrdg5ZfbWVEwFdmK+NRp0u6pUTWYqD57fbRROyRfB7giDn
 uNAk3CuU8Ow6qwZOeJlbuenu6uYYTDAMZuZv4ABq1XlnmH+tKVRG/I+mb6YwKp2ztIlA
 vl/ez1ZkOJG15ZZq+d5hyVp0dFeOI+aCpCEGzESQmU6jNyAfKQIjylShUn+oM3yVNN2r
 U8S8YilmMj2nLY/1n2WqPzvOrHu61cWsZ2aV/OL2K0vlEEbhDeoSL7rG7Idl3gTwYC+3
 EMtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa559Bpi0n2N3bTM6VF9GxtD6SW6vzNmg5zngjFeOeckp154SSNKEiqRdkPiJfT3epXYfYvTc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3Ap+snEVXAlBUCI18UV/671PLU0y+VIVMKrVyofjvzlJnFeHa
 eGaZ8oTn6BmoDAo4RExhleWJ0mE81EzXSA859KU00FVabr0rEQlD9/sNI1tgvWEVZz0TFTDSSEW
 0L/Aa6KCDFamRDCVKHyughLT6zK1EgzaIbofsAQ==
X-Google-Smtp-Source: AGHT+IHAcJybkkXHCdKxPwqdb2/iv8MFx6CyNuUXZwBrITmVyrNji5vdw2afrQG8Y9IeeyciQR+JI/JsPIE0V+N4nks=
X-Received: by 2002:a17:90b:4b42:b0:2e3:191e:7ef7 with SMTP id
 98e67ed59e1d1-2e94c2bfd49mr12605448a91.12.1730622101939; Sun, 03 Nov 2024
 01:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
 <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
 <20241102235319.GY3600562@bill-the-cat>
In-Reply-To: <20241102235319.GY3600562@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Nov 2024 09:21:30 +0100
Message-ID: <CAOf5uwnJwMaoA73kSwyibkRCV=tbFem3a4-ajBnH1mRkWdE-xA@mail.gmail.com>
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, U-Boot-Denx <u-boot@lists.denx.de>
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

Hi

Il dom 3 nov 2024, 00:53 Tom Rini <trini@konsulko.com> ha scritto:

> On Sun, Nov 03, 2024 at 12:36:38AM +0100, Michael Nazzareno Trimarchi
> wrote:
> > Hi Tom
> >
> > On Sun, Nov 3, 2024 at 12:26=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:
> > >
> > > > With this series opendir, readdir, closedir are implemented for ext=
4.
> > > > These functions are needed for the UEFI sub-system to interact with
> > > > the ext4 file system.
> > > >
> > > > To reduce code growth the functions are reused to implement the ls
> > > > command for ext4.
> > > >
> > > > [...]
> > >
> > > Applied to local tree/v2-tidy-test-dir, thanks!
> > >
> > Am I sleeping?
>
> ... I always forget b4 compares with checked out branch, that should
> have been master.
>
> > int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp) {
> >     struct ext4_dir_stream *dirs =3D NULL;
> >     struct ext2fs_node *dir =3D NULL;
> >     int ret;
> >
> >     *dirsp =3D NULL;
> >
> >     dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
> >     if (!dirs)
> >         return -ENOMEM;
> >
> >     dirs->dirname =3D strdup(dirname);
> >     if (!dirs->dirname) {
> >         free(dirs);
> >         return -ENOMEM;
> >     }
> >
> >     ret =3D ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
> > FILETYPE_DIRECTORY);
> >
> >     if (ret =3D=3D 1) {
> >         ret =3D 0;
> >         *dirsp =3D (struct fs_dir_stream *)dirs;
> >     } else {
> >         ret =3D -ENOENT;
> >         free(dirs->dirname);
> >         free(dirs);
>

I have add in this path the free of dirs, because according to the code I
can see from this email is not reference anymore and anyway according to
what I have commented already moving allocation of dirs later make the code
a bit simpler.

Michael


>     }
> >
> >     if (dir)
> >         ext4fs_free_node(dir, &ext4fs_root->diropen);
> >
> >     return ret;
> > }
> >
> > Should not be like this?
>
> Please elaborate?
>
> --
> Tom
>
