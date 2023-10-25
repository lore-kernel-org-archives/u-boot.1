Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FF6C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 21:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FCB87A73;
	Wed, 25 Oct 2023 23:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sweFYbI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D9C87A73; Wed, 25 Oct 2023 23:14:00 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E4787258
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 23:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7789a4c01ddso15642385a.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698268437; x=1698873237; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SsMdqWyq7sih3un1NXcc5OVvoulDxbJoN2BSVdZ3W1Y=;
 b=sweFYbI6a1AHUCNC0Bw/9olh1ZZzUPfasQo16maxvZZkKgXwafMEbvYNiQht39CRPZ
 SWO4VrlhAExpgzwY+V8QR4v/Uc0CRv748JcFUepXXMGsvFlRnVQd0Mb14pUtKyFYG7y2
 xtdbKQSjZzYy37/Fx0dsU10QBKkTQUdoM5Md0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698268437; x=1698873237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsMdqWyq7sih3un1NXcc5OVvoulDxbJoN2BSVdZ3W1Y=;
 b=FZluSHkoqOPDXRe8jnRVtbmMIBdXKv6wJRC3yqdubMzkE2Adz/iDl4UbzelJmIerx+
 AIQHWzCHC5TPRb0qXrlGLhhV0I57fvm4D7armmLTDDG8svpG8mfAF4w93jhvsVvxJnHJ
 OVUBdXzTv/eiCL9P8PphEXsjxquGpJA/IOm3RNeua86n2Bi5iXYdF2rpuWNWHNj8MjdM
 GBLJmHx1N1yS4xzsj2pFpxOgLP28qu0uEn82eggTsQIGMx8TdEeI9gHvBSwYjm+u7nP8
 NcCm5K6WgTwqyvvDNoDM1QjFsV3mW9RVp3R251/sSxwMBPzAzaZAy5vh4V1kOjb1x4ay
 z4eQ==
X-Gm-Message-State: AOJu0YxEosLfB6DT4/D5N4hGXlDEGLzp7WGa4s8MNVeEndXqWInEhoYg
 TZmutUnbohlFouyCfwIol+sEzQ==
X-Google-Smtp-Source: AGHT+IFyWbGlTPRp9ObycLaUkbZMmSo/sTfNxAOCwpsn8VWIFOzEj8toJUQX6nZVRCjx/gwf0vwQ1A==
X-Received: by 2002:a05:620a:1710:b0:778:a93c:e661 with SMTP id
 az16-20020a05620a171000b00778a93ce661mr18470083qkb.32.1698268436807; 
 Wed, 25 Oct 2023 14:13:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a05620a408100b007789a3499casm4457439qko.115.2023.10.25.14.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 14:13:55 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:13:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, sjg@google.com,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231025211354.GZ496310@bill-the-cat>
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ07zojtkV6ReQiC3XPf_AW96YnAc6APqhfk7wUDMmyOrA@mail.gmail.com>
 <CAPnjgZ3zFnAaivWa1BaUDbTfzRc-SZ_H8+YSvAKtwBJ64=XftQ@mail.gmail.com>
 <1ac5013d-8991-4abd-baad-94776801c58c@canonical.com>
 <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CWDa2S84H/zwl2I1"
Content-Disposition: inline
In-Reply-To: <87a5s6qwfe.fsf@bloch.sibelius.xs4all.nl>
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


--CWDa2S84H/zwl2I1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:28:05PM +0200, Mark Kettenis wrote:
> > Date: Wed, 25 Oct 2023 21:57:44 +0200
> > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >=20
> > On 10/25/23 20:23, Simon Glass wrote:
> > > Hi Heinrich,
> > >=20
> > > On Tue, 24 Oct 2023 at 18:02, Simon Glass <sjg@google.com> wrote:
> > >>
> > >> Hi Heinrich,
> > >>
> > >> On Mon, 23 Oct 2023 at 23:20, Heinrich Schuchardt
> > >> <heinrich.schuchardt@canonical.com> wrote:
> > >>>
> > >>> Forward and backward compatibility of Linux kernel device-trees is
> > >>> sometimes missing. One solution approach is to load a kernel specif=
ic
> > >>> device-tree. This can either be done via a U-Boot scripts (like the=
 one
> > >>> generated by Debian package flash-kernel or by a boot loader like G=
RUB.
> > >>> The boot loader approach currently requires to know the device-tree=
 name
> > >>> before first boot which makes it unusable for generic images.
> > >>>
> > >>> Expose the device-tree file name as EFI variable FdtFile.
> > >>> This will allow bootloaders to load a kernel specific device-tree.
> > >>
> > >> kernel-specific
> > >>
> > >>>
> > >>> The variable will not be exposed on ACPI based systems or if the
> > >>> environment variable fdtfile is not defined.
> > >>>
> > >>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.c=
om>
> > >>> ---
> > >>> v4:
> > >>>          Generalize the description of the content of $fdtfile.
> > >>> v3:
> > >>>          Add documentation
> > >>> v2:
> > >>>          Use a unique GUID to enable future U-Boot independent
> > >>>          standardization.
> > >>>          Do not try to add the variable on ACPI based systems.
> > >>> ---
> > >>>   doc/develop/uefi/uefi.rst  | 14 ++++++++++++++
> > >>>   include/efi_loader.h       |  5 +++++
> > >>>   lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> > >>>   3 files changed, 49 insertions(+)
> > >>>
> > >>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > >>> index fb16ac743a..702c490831 100644
> > >>> --- a/doc/develop/uefi/uefi.rst
> > >>> +++ b/doc/develop/uefi/uefi.rst
> > >>> @@ -916,6 +916,20 @@ So our final format of the FilePathList[] is::
> > >>>
> > >>>       Loaded image - end node (0xff) - VenMedia - initrd_1 - [end n=
ode (0x01) - initrd_n ...] - end node (0xff)
> > >>>
> > >>> +EFI variable FdtFile
> > >>> +~~~~~~~~~~~~~~~~~~~~
> > >>> +
> > >>> +Ideally U-Boot would always expose a device-tree that can be used =
for booting
> > >>> +any operating systems. Unfortunately operating systems like Linux =
sometimes
> > >>> +break forward and backward compatibility. In this case there is a =
need to load
> > >>> +an operating system version specific device-tree.
> > >>
> > >> This seems to be a strong statement. Given the effort that goes into
> > >> the DT, changes are supposed to be backwards-compatible. Is this
> > >> generally true, or is it just that we want an up-to-date DT for the
> > >> kernel to enable new features?
> > >=20
> > > Did you see this comment?
> >=20
> > It would have been nice to put the person which made that comment on co=
py.
> >=20
> > The truth lies in the world "supposed":
> >=20
> > The idea of a device-tree that never needs to change is quite old and=
=20
> > never became true on ARM devices.
> >=20
> > We all know Linux tends to break both forward and backward compatibilit=
y=20
> > of device-trees. Here is a nice example:
> >=20
> > d0c6707ca423 ("arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode=20
> > rgmii-id")
> >=20
> > Driver changes broke forward and backwards compatibility of a lot of=20
> > Allwinner boards.
>=20
> Well, that happened in 2020.  Things have gotten better over time.

Well, yes and no.  Given the brief summary here, I bet this was just
like when phy-mode and am335x platforms had DT compatibility broken and
the answer was that it was OK because the DT was incorrectly describing
hardware. So this is the reminder that there are cases of breaking DT
compatibility that are allowed. Even if the DT has been out (and wrong)
for several years.

That's not the main point of this thread and I don't want to derail
things further along this point, I just want to note that the details
here reminded me of when things are allowed to be incompatible with
previous trees.

--=20
Tom

--CWDa2S84H/zwl2I1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5hREACgkQFHw5/5Y0
tyyrkQv+IDKyld9rvRSX0+mo9UOSB1XxzIiI/J9s1QsJ0jrrH/XNd+Q6FDAwVKtX
1XnsVX/+PqUwLTh9FVK4OaIwyXWuaSBLbdYk+RpiwvBlJmw+Ws4adYNz9EgYoEha
90mmwSw1PSjzW5zDcFBtt+l54PDWBj4GpeuMVhHZO62m1bUZXv+G1d/UmFamdXTZ
1K8FQSEa8qU/cnKIDB8q6s/EKaEBlL31fJyh1G36JV2JX4IKUm5YMw396Bii1oP9
zV9KbAz5WHzLf4G2/RiUTSaIemSfE3ht9+HgUuIgFW4Qo1mfFx+a/nCqwp6TB8To
EGKV45JaB8wXJSLdqkaEt9NAkODKnEiqYsmEmYHZ8BOBR85BO+d3zRhsAY9Gs9Xf
GX4VGMo2bYyHkUD6hZLNTPgOy49ARBCgFCJtaYyJDk2lilNE1tBieBov1/uX/5vv
fW44pIicgRkZ1bqk/n9RJU1V3nI6TuCQtT0gsx7iy5rFceV6CwE0TaSC7za98U5Y
FqjM+DiY
=cyjR
-----END PGP SIGNATURE-----

--CWDa2S84H/zwl2I1--
