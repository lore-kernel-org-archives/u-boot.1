Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BACD31765
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F3A089001;
	Tue,  5 Nov 2024 17:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c6U7Ep0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657598904C; Tue,  5 Nov 2024 17:46:01 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA80588DE9
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d382664fadso5033006d6.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730825158; x=1731429958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HGEP/TYDMEoNet3Po65wupd4upVp01oXdtQJuDMN5MI=;
 b=c6U7Ep0AbXzWmryZeyejTFA7Ud8Ec9NJ1Q5lomFJzh6+Q2Gfw9fhvVp8rie0bZYzvM
 +h4Piwr895MUmwkFpg+uCFZWqkkF9gBfM/9hlZ9dYlIrJyJDrVPcAnHh7QbhbkMdQGRU
 TJKQxgV9qWuUtoKdCC18gT/ZhPHRJvxV7SVjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730825158; x=1731429958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGEP/TYDMEoNet3Po65wupd4upVp01oXdtQJuDMN5MI=;
 b=dng1W4xu7w4r0QMGwVYACncNoTvRrQZd0T36UowhXpm/p9YZVr+henD6YBr1Ym0pUG
 X20LQcTkfXRB9qVmBYErSnxxe/Sk7eTXi7QWhOAyZq/th94dxWojTg/Jb2/xvlErs+f0
 hy9NUmJba/PL/k3eT7TwcR3P3ZvgzHv3jUoV6mQTz2komExqdvrZydZ/dG6REFuse/hH
 zbLL/+AZrv3vsS/nFxvLj3ipuvCPF7c+MikUq/wjhwJeUx/7v8Ioxf+iiHce/F/5H94O
 A0jANy00mSh5Z31MkYrv/3KYClBVbiKSsqL9yt7VEGpQUkkbG2L3r+Xq3uQ2KJ1jJK6N
 UGqA==
X-Gm-Message-State: AOJu0YwakgfzmNeqnXJYHB5tPqM2U8c30iZ8bgDiUYOQvjVyVJspUV15
 J9mCJg4E6ph7VVFf4ykET1oyUz+fBq/qIZz6RE1EP/uD8qxz0wO3xUR69zMaKZA=
X-Google-Smtp-Source: AGHT+IGUUD0OZcN4eo5j3VCMsrHzcnGdMzHze5dRZnlcdc74TCiCntEi0BH3ZEwDZ9ePQQDtElvn1A==
X-Received: by 2002:a05:6214:5889:b0:6cb:fcbe:b34b with SMTP id
 6a1803df08f44-6d34609ab17mr321961436d6.32.1730825157761; 
 Tue, 05 Nov 2024 08:45:57 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d35415b731sm62207886d6.83.2024.11.05.08.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:45:57 -0800 (PST)
Date: Tue, 5 Nov 2024 10:45:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 4/9] docker: Adjust packages for arm64
Message-ID: <20241105164554.GK3600562@bill-the-cat>
References: <20241105160738.3795497-1-sjg@chromium.org>
 <20241105160738.3795497-5-sjg@chromium.org>
 <20241105161145.GJ3600562@bill-the-cat>
 <CAFLszTj2=0t1LmNr5kY=SBxaZtR8DB6bHwdfcgXwRqAr5ue5UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fa0NGRzIgameKSk1"
Content-Disposition: inline
In-Reply-To: <CAFLszTj2=0t1LmNr5kY=SBxaZtR8DB6bHwdfcgXwRqAr5ue5UQ@mail.gmail.com>
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


--fa0NGRzIgameKSk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 09:26:10AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 5 Nov 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 05, 2024 at 09:07:33AM -0700, Simon Glass wrote:
> > > The package names are slightly different for arm64 and we don't seem =
to
> > > have a linux-image-kvm package. Provide a different set for arm64
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Swap order so that amd64 is the exception
> > >
> > >  tools/docker/Dockerfile | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > > index 540718df062..84661b036c6 100644
> > > --- a/tools/docker/Dockerfile
> > > +++ b/tools/docker/Dockerfile
> > > @@ -44,7 +44,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/pub/=
tools/crosstool/files/bin/x86_
> > >  RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/down=
load/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
> >
> > Oh no, here's a big problem ^^^^^
> > You didn't switch to downloading arm64 toolchains, no wonder everything
> > else blows up.
>=20
> Er, yes I know that...I would have to put 'if' statements on each one,
> but I was hoping we could come up with a better way of handling this.

Yes, hopefully we can do something with $TARGETPLATFORM to set another
variable that's exposed for wider use.

> Same with all the variables being set for grub.
>=20
> >
> > >  # Update and install things from apt now
> > > -RUN apt-get update && apt-get install -y \
> > > +RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then \
> > > +             EXTRA_PACKAGES=3D"grub-efi-amd64-bin grub-efi-ia32-bin =
libc6-i386 linux-image-kvm"; \
> > > +     else \
> > > +             EXTRA_PACKAGES=3D"grub-efi linux-image-generic"; \
> > > +     fi; \
> >
> > Again, grub-efi should be used for everyone and linux/amd64 adds
> > grub-efi-ia32-bin. And linux-image-generic should work for everyone,
> > too.
>=20
> So what about this commit?[1]
>=20
> Regards,
> Simon
>=20
> [1] f9abaa53ec8 tools: docker: Install a readable kernel for libguestfs-t=
ools

Yes, linux-image-generic should also provide a useful image, and you
would need to check what CI says when using this image.

--=20
Tom

--fa0NGRzIgameKSk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqS7oACgkQFHw5/5Y0
tyyflQwApR/F2jhBDbUu9kMIsyXEAKtxk80MVoiOPLea/UFtKAbQ7wCerS7wDLog
+0tAkppZW0tlVRG9oP3lmBDNtXw4JDRHKAqhNU4WbvaVUS2klKX/ix7GgHN6VkGc
j49yQrP/61jIWveIJKNDEpa//M/ZlXaf9t5xYgRwrCNRm/v2IJhguw5hoRMdjaQb
JjjGz/9iAqe0ADm1VzkxN+RsaK8gzsja3KU2ZzN4l8ohQRpODYzEgZl4IA315zw/
JnFd/6+zH7Fxo10XHxuQKdp7W+nxc7XUAKhN71ndoQtKBkueb4ow7qfX7Jm9qCI0
PfM/kgJadPkLfKLMcyticvLS/N9ZEUnIxPgZVlUJeI/sCTC+DbWFedygWALPDhzu
p1GXUu/+Ahm0jc8s7Gae76bnM8DCKKMm7pwEmTBRaLAtuK1UHYM2YBhWt5AxjEID
3FE+H+/8kfNyamaY4j43h/XSd40ZvEkr1RCIK3Q8muq1k0KNHTOuFV4ZGPuN8ICn
3H6NvC9i
=xVyY
-----END PGP SIGNATURE-----

--fa0NGRzIgameKSk1--
