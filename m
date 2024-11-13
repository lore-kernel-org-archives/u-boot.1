Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C27ED597C5
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 02:40:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23A18894D8;
	Wed, 13 Nov 2024 03:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bVwgsuKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3304088CF1; Wed, 13 Nov 2024 03:40:49 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00623894D5
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 03:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbe53a68b5so46945056d6.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 18:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731465646; x=1732070446; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GXYdM4nVnNHkdzINiaGJ/3kcSSxp0BHXAUbtkedrUwE=;
 b=bVwgsuKWP/PNkytGPr9YHdu5tlxLrUiqSYBHHEHuxUccEQIxMOnEy0A5IcB9PdLzPn
 BqMHrwi+rEY24B6cPvkdAVnCSJpAMiYMT01wmTjjX+C27N/6swoGhtaqOQKsSK9S6BLe
 lwtycYfWeySdAIw5sMqCBfDwfg5cTa2OZmW+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731465646; x=1732070446;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXYdM4nVnNHkdzINiaGJ/3kcSSxp0BHXAUbtkedrUwE=;
 b=PPfByEwAdZLZ1FvgO3a7ql2paC5mFWplUMmgWuQZGS97fAsFOd0kZGJIpz4nlu/MdX
 kLOpWVRMwH3FcS7AoQmY7uQpam7D7Fotxw/sSQJFo9necaKOKZA5ShgELrLZW1JKh8pe
 6rmU6w1dgQsxohCd7vbNi4yaG2nEWOvWV1MyJpskzDrq3rsnpInJtYP5kNNex2mKbG/R
 DivYKbt1K7+HnGaT8FwIJcGna+WxcdncwxKwy0xvuwMFtlSgnKOiQ9qtTl62biWjfsC1
 LlwLvu2dD2yYoOpKWLBOt8m0PM1Y1WBCxGssijeqxQV7IfGeZupJ2U33go1Uxy69ejNa
 l4fQ==
X-Gm-Message-State: AOJu0YxvM9t5C7kqOE5onZT8y5Z4wHWicCJuGcd6RpDheD4dd5McCDV5
 rT2K+2lP8LYnDLrakdbNnpZXAFDIPeC9UHFRAloaojNmaTOCCCbmGvhg2PUOaMA=
X-Google-Smtp-Source: AGHT+IHKRgPWWbOdPQavnbkbTyot1O9LKKRbXec+67+881IZxiYtur4aNiv7I6kVPfe2FyZ4bO7Ayg==
X-Received: by 2002:a05:6214:2d46:b0:6cb:f936:f9ce with SMTP id
 6a1803df08f44-6d3d03a8960mr58247456d6.41.1731465645850; 
 Tue, 12 Nov 2024 18:40:45 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d396631480sm78648306d6.113.2024.11.12.18.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 18:40:44 -0800 (PST)
Date: Tue, 12 Nov 2024 20:40:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH RFC v1] Dockerfile: Have "sandbox" build with i386
 toolchain not x86_64 toolchain
Message-ID: <20241113024042.GJ3600562@bill-the-cat>
References: <20241105165357.620796-1-trini@konsulko.com>
 <CAFLszThU2T2A4DG-=isO6vP=149Lw6jQaB3vs8ggJ2H8CcDwBg@mail.gmail.com>
 <CAFLszTjYy-wCuOx5Nv-F1uDcVYJEqi2pwTBTws=UHWB0z026ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BLO3JDd7QUl/r64u"
Content-Disposition: inline
In-Reply-To: <CAFLszTjYy-wCuOx5Nv-F1uDcVYJEqi2pwTBTws=UHWB0z026ww@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--BLO3JDd7QUl/r64u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 10:34:15AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 5 Nov 2024 at 10:03, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Tue, 5 Nov 2024 at 09:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > A long time ago, we had to use "i386" and "x86_64" toolchains for our
> > > x86 platforms, depending on the target. We then moved to being able to
> > > use the single "i386" toolchain to support all x86 platforms. At the
> > > same time, we had been building sandbox with our "x86_64" toolchain in
> > > CI. When x86 switched to being able to use a single toolchain we did =
not
> > > update our CI buildman file to match. Do this now as we want to ensure
> > > that sandbox is built with the same compiler version the rest of our
> > > platforms are and not the host one.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Simon Glass <sjg@chromium.org>
> > >
> > > I'm posting this as an RFC to start the discussion as when I mentioned
> > > this to Simon on IRC, he was very much not in agreement.
> > >
> > > My main argument is this, sandbox needs to use the same toolchain that
> > > we compile (virtually) all other platforms with as one of the points =
is
> > > to be able to catch warnings and compiler behavior changes as soon as
> > > possible in our CI. And just like how developers can use
> > > distribution-provided toolchains today, nothing changes in that regar=
d,
> > > we only make CI be more consistent now.
> >
> > OK, that makes some sense to me, actually. It isn't the toolchain that
> > people will be using, but catching things earlier seems good.
> >
> > The main concern I have is that we are not testing sandbox on the
> > toolchain that everyone will be using. But I haven't noticed failures
> > in CI which I cannot repeat locally, so we can cross that bridge when
> > we come to it.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> This doesn't seem to work, for a few reasons:
>=20
> 1. Buildman doesn't support setting HOSTCC and CC unless using -O to
> override the toolchain (so the setting in this patch has no effect)

That shouldn't matter tho.

> 2. Using the toolchains from kernel.org gives this error:
>=20
> NO_LTO=3D1 make O=3D/tmp/b/sandbox defconfig all
> HOSTCC=3D/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux=
/bin/x86_64-linux-x86_64-linux-gcc
> CC=3D/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin=
/x86_64-linux-x86_64-linux-gcc
>  -j30 -s
> /home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/../l=
ib/gcc/x86_64-linux/13.2.0/../../../../x86_64-linux/bin/ld:
> cannot find crt1.o: No such file or directory
> /home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/../l=
ib/gcc/x86_64-linux/13.2.0/../../../../x86_64-linux/bin/ld:
> cannot find crti.o: No such file or directory
> /home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/../l=
ib/gcc/x86_64-linux/13.2.0/../../../../x86_64-linux/bin/ld:
> cannot find -lc: No such file or directory
> /home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/x86_64-linux/bin/../l=
ib/gcc/x86_64-linux/13.2.0/../../../../x86_64-linux/bin/ld:
> cannot find crtn.o: No such file or directory
> collect2: error: ld returned 1 exit status
> make[3]: *** [scripts/Makefile.host:95: scripts/basic/fixdep] Error 1
> make[2]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefil=
e:503:
> scripts_basic] Error 2
> make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefil=
e:568:
> __build_one_by_one] Error 2
> make: *** [Makefile:177: sub-make] Error 2

So yeah, here's the real problem. In the past the kernel.org toolchain
was (unintentionally I believe) good enough to make user-space programs
too. That's not the case now, and sandbox is really a userspace program
and not a bare-metal program.

So really the current line from the Dockerfile just needs to be removed.

--=20
Tom

--BLO3JDd7QUl/r64u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc0EaoACgkQFHw5/5Y0
tywHsAv+Iwm7f8R8uRsDIU52ONaMiNvJCGHHdI3z9RMuSa/T0wBV2MLegN7TG+tI
3OGKMCQ8TPIYClvMW9p4bWslbZd5Zn6iF/EZxpkDCSOSxTYNnC32BRCZ8E7FzrVE
CLmaxQJWPP0vKWr0bUFKUrhPkoaRXeI/HLM5LU6W0vd+wFhA/8DJrMmQcnBGw08/
LvE4BGDRjUpspeABb49qMSGY5XCi0EMnC29n4aDXkbCXxQj3BwDpqejnHDE/IzkD
66tEJ8XRx/9TEjLWzoSflWhlfoZ5wO5LJ8IwLDS/JGN7RQiWwg3M5zl41t+xwyTv
O2RpOzDqhy3dt3xHANoknBQO3AOlZDuYX/jrpq/jBn2LufxhuzSZhTdM4A6bCxwm
Lm/qfYErjwTgBY4nzY0tOcBmtOb7ynKlIis9xv3hZiq+HWrl0xZg7t6gQfKnhuUO
6mvuv2rMprup0hKlNy/QNxk56vwlYkVxGE95zGQsjpEsh12eudGG+jda+vVfltIb
/3ZEJ/o6
=brDI
-----END PGP SIGNATURE-----

--BLO3JDd7QUl/r64u--
