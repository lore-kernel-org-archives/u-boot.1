Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8990DD35E4D
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 20:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB37C88EBB;
	Tue,  5 Nov 2024 21:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LBI1VNaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D0B8900E; Tue,  5 Nov 2024 21:55:26 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC22288E96
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 21:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-84fccf51df1so2012702241.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730840122; x=1731444922; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BUTW0m8EbkWDq2JgWL5hV5Swiet0yVn/XFxdLtjSvHo=;
 b=LBI1VNaZLy9HSXtixbIRffafpSHbzRronfCCLkRS8IhQ8tOvvjB2HfcDYgAeWOOfNd
 z0zxtJbW2PN4OBMVDAkVS+RxpTpJ0Md5865Bvnw49Le7HXDwVK+4y7SUMKQLv0Shsc/D
 gomiMC60DjllPJ0aWWySZvNlMgW5ekyuPfUnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730840122; x=1731444922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUTW0m8EbkWDq2JgWL5hV5Swiet0yVn/XFxdLtjSvHo=;
 b=kQzdZXx0a04qJgEOECGRVl9p+ZtiUhX1WMaUDUYoN19dgLqoYiD6sd0QJYDQB+FjXj
 lCsKLLlKozwsdgZAxDUgLNBNhaiUhbgKy+JkM5QqIK/0Ac7QBhV2W4dc4wsPlMQePf4+
 nWJ31oPYKntflfrkAv1GuNK3hv/Wp1bl9FAjGV0+U5rJgHu4iv0f2/A4TaZu1ySENMuD
 cbWjGOqnl2u+34lSCU8urDEtktgf0aGZTcEObqA7Ey/hncHGaEBlgeFdk/TuJTCmRTiP
 AXbid7cXiNC7em7GkJu2g0LUo7a2W8NLo61SxN+31WWscYSZfZHcFRiOa1fldDm6HKZF
 kGCg==
X-Gm-Message-State: AOJu0YygwjE5Dgp+RvkBP2RmZBONb5FUtqHIqj3lEKBzCpLijzCktPsH
 8VnQlFP6g3MdOwRZHtcQDSjVGP+ft11VzooesH3YqKNfsooTZaMWCi/LTHrIei0=
X-Google-Smtp-Source: AGHT+IGyV9bH/dkYV7CzBNApfa4r8m3fFG7VwZHAnSwE/hW6lAoU9oIuu7/Bnis31L4ZrW81WxJbNg==
X-Received: by 2002:a05:6102:32ca:b0:4a4:7609:35f with SMTP id
 ada2fe7eead31-4a8cfd6d7bemr33161147137.24.1730840122544; 
 Tue, 05 Nov 2024 12:55:22 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f391f782sm561697185a.0.2024.11.05.12.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 12:55:21 -0800 (PST)
Date: Tue, 5 Nov 2024 14:55:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 4/9] docker: Adjust packages for arm64
Message-ID: <20241105205518.GM3600562@bill-the-cat>
References: <20241105160738.3795497-1-sjg@chromium.org>
 <20241105160738.3795497-5-sjg@chromium.org>
 <20241105161145.GJ3600562@bill-the-cat>
 <CAFLszTj2=0t1LmNr5kY=SBxaZtR8DB6bHwdfcgXwRqAr5ue5UQ@mail.gmail.com>
 <20241105164554.GK3600562@bill-the-cat>
 <CAFLszThuzMvK+iSin+6sHP=g2xF5bBTMNG7ig2B733vpi3wxfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sCq+Mg8wGxE0qyIk"
Content-Disposition: inline
In-Reply-To: <CAFLszThuzMvK+iSin+6sHP=g2xF5bBTMNG7ig2B733vpi3wxfg@mail.gmail.com>
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


--sCq+Mg8wGxE0qyIk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 12:20:51PM -0700, Simon Glass wrote:
> HI Tom,
>=20
> On Tue, 5 Nov 2024 at 09:45, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 05, 2024 at 09:26:10AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 5 Nov 2024 at 09:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Nov 05, 2024 at 09:07:33AM -0700, Simon Glass wrote:
> > > > > The package names are slightly different for arm64 and we don't s=
eem to
> > > > > have a linux-image-kvm package. Provide a different set for arm64
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Swap order so that amd64 is the exception
> > > > >
> > > > >  tools/docker/Dockerfile | 12 +++++++-----
> > > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > > > > index 540718df062..84661b036c6 100644
> > > > > --- a/tools/docker/Dockerfile
> > > > > +++ b/tools/docker/Dockerfile
> > > > > @@ -44,7 +44,12 @@ RUN wget -O - https://mirrors.edge.kernel.org/=
pub/tools/crosstool/files/bin/x86_
> > > > >  RUN wget -O - https://github.com/foss-xtensa/toolchain/releases/=
download/2020.07/x86_64-2020.07-xtensa-dc233c-elf.tar.gz | tar -C /opt -xz
> > > >
> > > > Oh no, here's a big problem ^^^^^
> > > > You didn't switch to downloading arm64 toolchains, no wonder everyt=
hing
> > > > else blows up.
> > >
> > > Er, yes I know that...I would have to put 'if' statements on each one,
> > > but I was hoping we could come up with a better way of handling this.
> >
> > Yes, hopefully we can do something with $TARGETPLATFORM to set another
> > variable that's exposed for wider use.
>=20
> I recall that docker doesn't let variables set in one phase affect
> subsequent ones, but perhaps something can be done in the ENV section

Yes, my hope is we could set something in the ENV section.

> > > Same with all the variables being set for grub.
> > >
> > > >
> > > > >  # Update and install things from apt now
> > > > > -RUN apt-get update && apt-get install -y \
> > > > > +RUN if [ "$TARGETPLATFORM" =3D "linux/amd64" ]; then \
> > > > > +             EXTRA_PACKAGES=3D"grub-efi-amd64-bin grub-efi-ia32-=
bin libc6-i386 linux-image-kvm"; \
> > > > > +     else \
> > > > > +             EXTRA_PACKAGES=3D"grub-efi linux-image-generic"; \
> > > > > +     fi; \
> > > >
> > > > Again, grub-efi should be used for everyone and linux/amd64 adds
> > > > grub-efi-ia32-bin. And linux-image-generic should work for everyone,
> > > > too.
> > >
> > > So what about this commit?[1]
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] f9abaa53ec8 tools: docker: Install a readable kernel for libguest=
fs-tools
> >
> > Yes, linux-image-generic should also provide a useful image, and you
> > would need to check what CI says when using this image.
>=20
> OK, so we don't actually need the kvm one, it seems?

No, that was just a reasonable at the time choice for a kernel image
file.

> Anyway, the upshot of all of this is that you want arm64 to run the
> full suite of tests, including kvm and world builds. But presumably
> not in addition to the x86_64 ones...? I suppose I am just unclear as
> to what you are looking for. Are you trying to test that QEMU works
> properly, or that U-Boot's code works?
>=20
> My expectation was that we just want sandbox testing on arm64...I
> don't see much point in anything else. What am I missing?

I would like, especially if we get additional compute resources donated,
to duplicate much of the testing we do _also_ on arm64 as a host, at
least on tagged releases. This is a thing more and more people do, and
it would be good to be able to point at CI when something like:
https://source.denx.de/u-boot/u-boot/-/issues/44
is filed.

--=20
Tom

--sCq+Mg8wGxE0qyIk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcqhjIACgkQFHw5/5Y0
tyysGwv+Otawaen3iHxZ68dAzdHYHLf1hNtYMYbYr9q7UPWCJfW4EIuPOfsotuyA
RulY6Oc8bv4EiUdzsiKpOCWpS+hWos2JkMOw167oAKv0Rbf/xhhAQk7VjOZpxYD1
SE0FmczR2SH4KJL7CD+gL7p1AUyzAbcElaDbYc43HVbj21pyx4TVDTB3/rQP/0Xu
yT3HilvIXnWcKbu1xUi+p+MWqyQSjRhmWjXO5E+LfDC2wjvuYfdYvcJFh1Ly5COi
90VfhI3XTcF6qZOcTA9WeSNT2qzaKpsPC5wZgrshPJJHxyel8yEu4Lg6py7Xg0mG
kQikmLLKKVeP2ek/yb4UwNbabEexGFZ/Pcwzp5ny/za5fMGWu/SkPmELE27vgeZy
pR+6cMY55dkGY5goJbfmGKtD/2c2UkrJ/j9JBW8TAxtVA4bTy7vZIxy4VkE+SQJp
GLSMETKoWoyGnWcLxGAfciWSlNf5aExyLcOeF9RlazJBOX533N9HGpwb+PU9ViqM
5SdXtR2V
=M73i
-----END PGP SIGNATURE-----

--sCq+Mg8wGxE0qyIk--
