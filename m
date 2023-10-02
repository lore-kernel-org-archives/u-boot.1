Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7911E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CB0870DE;
	Mon,  2 Oct 2023 16:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AIovjXb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E6386DC3; Mon,  2 Oct 2023 16:04:57 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B84E870B7
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59c215f2f4aso204874247b3.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696255492; x=1696860292; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JccEgtEC5+WtPnMfbb7PpgGzXUfyG/eH6E3J2fkqhBI=;
 b=AIovjXb2a1jLma9Ul3PHuNStQRnADvtgxScaJNnF5PVnpr7xLamxqhRtjF98tM9I4S
 RW3IPVeTxhyQQsFAMxRfytd4DamfhRPLG3EWbSd9Pi1TS4wP6otBeDueTXNtkHwxsO3z
 LbGPPJkGpJgoHvreN34k35yiaXq+PY5QDkyU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696255492; x=1696860292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JccEgtEC5+WtPnMfbb7PpgGzXUfyG/eH6E3J2fkqhBI=;
 b=bfnsyS27+INgWlht0YQpBcBoxsx0BgnmM3pQRWfCsYmawQr3mRz5QV9ik7t2xHMERa
 FMytI8HwJb6ql3a3YCsRMvwxfo07PVyO9jOboGqr5+xEco5+J3xaSuLYupJgIdy3M58i
 kep+FmLt80GESFbnDLktNo83ezhqD1T6J1BAG6SAyeUQmpOfYf6m+4fDvNxzrjErBPO6
 y1rRklI2lwZ3y84UYHJrs8SJObAaiVqwvO2dKVmjKkdBD2u698g4FQci/GUZ8Yq70mqj
 80b9VGa8pUlcohJ814ylXTlguJWnCyNvZNVUKBi6llZ5C0MLA4lgaz7fTv651jVPTZER
 gSPw==
X-Gm-Message-State: AOJu0YwwBF+Ci+3pZ+QcfnvnI8qO629DeOK5iZ5O1pz7C6HW7VKHke6C
 D6J6+Irm969uPOfIDSeBWE9cpw==
X-Google-Smtp-Source: AGHT+IGZ2AMl1s+ctXhsFvyCV9cDoPOIWULMBbjySJabg75i1DsJYGX+MlBz0hd4v1wtQ+uRsJpVJA==
X-Received: by 2002:a0d:dfcd:0:b0:59f:761a:fe70 with SMTP id
 i196-20020a0ddfcd000000b0059f761afe70mr11560010ywe.19.1696255492229; 
 Mon, 02 Oct 2023 07:04:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92a5-a961-a832-88f6.res6.spectrum.com.
 [2603:6081:7b00:6400:92a5:a961:a832:88f6])
 by smtp.gmail.com with ESMTPSA id
 s123-20020a0de981000000b0059b4e981fe6sm7664157ywe.102.2023.10.02.07.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:04:51 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:04:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, u-boot@lists.denx.de,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: Re: [PATCH v1 3/3] arm: npcm8xx: support dcache off
Message-ID: <20231002140449.GS305624@bill-the-cat>
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
 <20230926085651.395069-4-JJLIU0@nuvoton.com>
 <20230926134807.GT305624@bill-the-cat>
 <CAKUZ0+FRnrEuyGpNMeqD_Tbi8VXTgtV=8A1ZoQPU=ZaMJRT3TQ@mail.gmail.com>
 <20230928122317.GD305624@bill-the-cat>
 <CAKUZ0+Fr+2mYYK8naK6gxLdzSDtQ=MW2Yp12ipXE5D3-pq-y1w@mail.gmail.com>
 <20230928161657.GE305624@bill-the-cat>
 <CAKUZ0+HnYEKxJUbXdrHPMUMVROcFSu7aA_mspd9OnaMCPozXTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U8KU7XzS5A9ZAlOG"
Content-Disposition: inline
In-Reply-To: <CAKUZ0+HnYEKxJUbXdrHPMUMVROcFSu7aA_mspd9OnaMCPozXTQ@mail.gmail.com>
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


--U8KU7XzS5A9ZAlOG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 12:40:54AM -0700, Jim Liu wrote:

> Hi Tom
>=20
> I followed your suggestion to modify the code.
> but still have errors.
> Should I use my workaround?

No, please figure out the errors, or at least post what you've got,
thanks.

>=20
> Best regards,
> Jim
>=20
> On Thu, Sep 28, 2023 at 9:17=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Sep 28, 2023 at 10:32:51PM +0800, Jim Liu wrote:
> > > Hi  Tom
> > >
> > > Thanks for your understanding.
> > > but  this patch  is an incomplete patch.
> > > After I applied this patch  I had another error.
> > >
> > > arch/arm/cpu/armv8/cache_v8.c:773:2: error: #error Please describe
> > > your MMU layout in CONFIG_SYS_MEM_MAP and enable dcache.
> > >   773 | #error Please describe your MMU layout in CONFIG_SYS_MEM_MAP
> > > and enable dcache.
> > >
> > > This error is the same as that link.
> >
> > Please use that patch as a starting point (and also possibly needing to
> > grab
> > https://patchwork.ozlabs.org/project/uboot/patch/20230822075112.717992-=
2-bhupesh.sharma@linaro.org/
> > as that's how I'd like to proceed with addressing this generic armv8
> > issue, thanks!
> >
> > >
> > > Best regards,
> > > Jim
> > >
> > > On Thu, Sep 28, 2023 at 8:23=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Thu, Sep 28, 2023 at 08:49:23AM +0800, Jim Liu wrote:
> > > > > Hi Tom
> > > > >
> > > > > Thanks for the quick review.
> > > > >
> > > > > if we set the CONFIG_SYS_DCACHE_OFF the  armv8 will build error.
> > > > > So we added a workaround for our bmc uboot.
> > > > >
> > > > > the error message as below:
> > > > >
> > > > > CONFIG_SYS_DCACHE_OFF can't be enabled on armv8, or the following
> > > > > build error would happen.
> > > > >
> > > > > arch/arm/cpu/armv8/cpu.o: in function `cleanup_before_linux':
> > > > > arch/arm/cpu/armv8/cpu.c:60: undefined reference to `icache_disab=
le'
> > > > > arch/arm/cpu/armv8/cpu.c:68: undefined reference to `dcache_disab=
le'
> > > > > arch/arm/cpu/armv8/cpu.c:69: undefined reference to `invalidate_d=
cache_all'
> > > >
> > > > OK, so you need
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20230811054228.372=
1455-1-bhupesh.sharma@linaro.org/
> > > > to be applied, as-is, yes? Thanks!
> > > >
> > > > >
> > > > > Best regards,
> > > > > Jim
> > > > >
> > > > > On Tue, Sep 26, 2023 at 9:48=E2=80=AFPM Tom Rini <trini@konsulko.=
com> wrote:
> > > > > >
> > > > > > On Tue, Sep 26, 2023 at 04:56:50PM +0800, Jim Liu wrote:
> > > > > >
> > > > > > > do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=3Dy
> > > > > > >
> > > > > > > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > > > > > > ---
> > > > > > >  arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
> > > > > > >  arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
> > > > > > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/ma=
ch-npcm/npcm8xx/Kconfig
> > > > > > > index 5f4a0506dc..163e7e7d48 100644
> > > > > > > --- a/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > > > > +++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > > > > > @@ -6,6 +6,10 @@ config SYS_CPU
> > > > > > >  config SYS_SOC
> > > > > > >       default "npcm8xx"
> > > > > > >
> > > > > > > +config SYS_NPCM_DCACHE_OFF
> > > > > > > +     bool "Do not enable dcache"
> > > > > > > +     default n
> > > > > > > +
> > > > > > >  config TARGET_ARBEL_EVB
> > > > > > >       bool "Arbel Evaluation Board"
> > > > > > >       help
> > > > > >
> > > > > > Why do we need a new Kconfig option here on top of the existing=
 generic
> > > > > > ones to control cache?
> > > > > >
> > > > > > --
> > > > > > Tom
> > > >
> > > > --
> > > > Tom
> >
> > --
> > Tom

--=20
Tom

--U8KU7XzS5A9ZAlOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUazfsACgkQFHw5/5Y0
tywl0wv9EyK47mbYny3wP1v08RjDzdDxMIsC1wmTtbH39LxAR/39UjWih24MgrQ9
zFTMspbNI4F6yfShF+TAtyW0IFcY89ydn8CnxsG9E9Lm71Eiet0Xd0Uchq1LsEr2
ZIfpcrAZQzVGIXdVPzbskhr1f10UmM1Sp3mi2v9QyUJtNudFswq6rwIIx2v06kA1
xbT2jeY86p63Xq2LNpbM/bx+OT2+gcprnPIBE8mPG3jjmhMkSqcOE71IzJZe6yF+
dEOZP6GwPP1GaCcCbthCPLhzrQwpJTcVjKiYhSBKtOiKf8lZ7Xm633iW8/9iWIGj
Y3Im3F5L9/deNSMU/8MW8u3Vz7jsHEtV4MCo7FjcG8Rg/4jm6bmh+VXgpLFgSJNf
KiBFbrltHdvivSY7i04Tv+gVF42vQaMipxDaSzs+PBjuaELNGJHAbV9kyL1BYtye
pK6Avw9iAOuPsrJqjfa2MuHUBEbrVzTcMGXjkYrofQaRCIv0f0ZQnW8rXL8KUBEK
hSOwKULb
=R8Lr
-----END PGP SIGNATURE-----

--U8KU7XzS5A9ZAlOG--
