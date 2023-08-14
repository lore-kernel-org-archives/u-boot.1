Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93A0EB64DD
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 19:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 103C486828;
	Mon, 14 Aug 2023 21:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o99iRIMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C79968696B; Mon, 14 Aug 2023 21:18:53 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F14807F9
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 21:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-586df08bba0so52068817b3.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692040730; x=1692645530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pqhYOspZFrBaY7kdRwG83uP1Tuv8LXP+Dy+OmsVeBZ0=;
 b=o99iRIMG6K8FMKYrPGj+IBvgBXmiPOpuRQC2ttyTb8EI6ctreuRDGTPNC1vgy41+3A
 mq+he6My3dcl98wvzI5a1hU1nltD31raSt78MesKB0FNtalynPNhx5iZ1dqwIZnJwZ97
 XVO3oYvySuXkTmKunZ+az/XBQc0N1rJVechxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692040730; x=1692645530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqhYOspZFrBaY7kdRwG83uP1Tuv8LXP+Dy+OmsVeBZ0=;
 b=LzZeZVbGjQLuOQg41yUgxjVu1WLctP63QmkD86I3UkwmsPQ9mJhObR81zU0wNdKcCc
 GgAXqOW+nFtuDIu0uIAZ07MCSS2VXEPseiCJbQmu834t39bP0NsmO3QQ5n7ALx3+o8TJ
 dxRce02us03BrtcezOgZE0gkvkVir1n3b/3BDZoZR21X4DcVbkzPt5wtGCGprE77OF9v
 kB+qYYSI2QOgmGgo8enjKs/6Eb2rsX7jm2jqUyM/UCWYKzPUr/CYinoTAw9wlF4vfES5
 jH1jkF4ULWZ9QyeGNs7et/KwKF9d051+wb6PNsExwc/iQEpFIy7RkUV33xzxWhq9zaJH
 DE6A==
X-Gm-Message-State: AOJu0YyUSFXXwJ27j6K4LoUNnwtiNLueWllFexUB5syYAZjzw/BhYKhB
 b2qGntB+gZWNrw53jHNWG0T7JA==
X-Google-Smtp-Source: AGHT+IE8bw2uyGZg5RWeoVogHYe24fIGSSyLUaGx41gaR/Vkr3EDYflIponXiOYxJnOYUw9s8ZVVrA==
X-Received: by 2002:a0d:d544:0:b0:589:f4ec:4d51 with SMTP id
 x65-20020a0dd544000000b00589f4ec4d51mr4428395ywd.3.1692040730290; 
 Mon, 14 Aug 2023 12:18:50 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 db4-20020a05690c0dc400b005844ae2bfa3sm2945246ywb.95.2023.08.14.12.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 12:18:49 -0700 (PDT)
Date: Mon, 14 Aug 2023 15:18:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [RFC PATCH 2/4] scripts/Makefile.lib: Embed capsule public key
 in platform's dtb
Message-ID: <20230814191847.GG3630934@bill-the-cat>
References: <20230814090309.1548310-1-sughosh.ganu@linaro.org>
 <20230814090309.1548310-3-sughosh.ganu@linaro.org>
 <20230814150430.GX3630934@bill-the-cat>
 <CADg8p96MtFiWf=u2j6b9+ZxfGSyAZ=T11CDd6pFifLz_Bh4qwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IhCYCBbEoiLLuarZ"
Content-Disposition: inline
In-Reply-To: <CADg8p96MtFiWf=u2j6b9+ZxfGSyAZ=T11CDd6pFifLz_Bh4qwQ@mail.gmail.com>
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


--IhCYCBbEoiLLuarZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 12:19:36AM +0530, Sughosh Ganu wrote:
> hi Tom,
>=20
> On Mon, 14 Aug 2023 at 20:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Aug 14, 2023 at 02:33:07PM +0530, Sughosh Ganu wrote:
> > > The EFI capsule authentication logic in u-boot expects the public key
> > > in the form of an EFI Signature List(ESL) to be provided as part of
> > > the platform's dtb. Currently, the embedding of the ESL file into the
> > > dtb needs to be done manually.
> > >
> > > Add a target for generating a dtsi file which contains the signature
> > > node with the ESL file included as a property under the signature
> > > node. Include the dtsi file in the dtb. This brings the embedding of
> > > the ESL in the dtb into the U-Boot build flow.
> > >
> > > The path to the ESL file is specified through the
> > > CONFIG_EFI_CAPSULE_ESL_FILE symbol.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  lib/efi_loader/Kconfig             |  9 +++++++++
> > >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> > >  scripts/Makefile.lib               | 17 +++++++++++++++++
> > >  3 files changed, 37 insertions(+)
> > >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> > >
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 9989e3f384..f40a62a0ba 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -272,6 +272,15 @@ config EFI_CAPSULE_MAX
> > >         Select the max capsule index value used for capsule report
> > >         variables. This value is used to create CapsuleMax variable.
> > >
> > > +config EFI_CAPSULE_ESL_FILE
> > > +     string "Path to the EFI Signature List File"
> > > +     default ""
> >
> > No default.
>=20
> I think Simon wanted to keep this so that it would not break the build
> if no option was provided.

No, that means that there's a missing dependency.  Blank defaults are
almost never right.  And "so that we don't break configs" means that
something else is wrong, generally a missing dependency.  And maybe I
cut out too much context here as yes, this option needs to depend on
some part of the capsule framework.

> > [snip]
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index f41b16781d..cf4eef0b05 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> > > @@ -334,8 +334,25 @@ cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
> > >               ; \
> > >       sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp =
> $(depfile)
> > >
> > > +ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
> > > +quiet_cmd_capsule_esl_gen =3D CAPSULE_ESL_GEN $@
> > > +cmd_capsule_esl_gen =3D \
> > > +     $(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl=
_input_file) > $@)
> > > +
> > > +$(obj)/.capsule_esl.dtsi:
> > > +     $(call cmd_capsule_esl_gen)
> > > +
> > > +capsule_esl_input_file=3D$(srctree)/lib/efi_loader/capsule_esl.dtsi.=
in
> > > +capsule_esl_dtsi =3D .capsule_esl.dtsi
> > > +capsule_esl_path=3D$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_E=
FI_CAPSULE_ESL_FILE)))
> >
> > This seems right.
> >
> > > +include_files +=3D $(capsule_esl_dtsi)
> > > +
> > > +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(obj)/.capsule_esl.dtsi FORCE
> > > +     $(call if_changed_dep,dtc)
> > > +else
> > >  $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> > >       $(call if_changed_dep,dtc)
> > > +endif
> >
> > I think this implies to me that we should have been depending on
> > $(include_files) (once renamed to be less vague) here already ?
>=20
> Okay. That can be done. I had kept the .capsule_esl.dtsi as a
> dependency primarily because that file needs to be generated before it
> can be included. I suppose the same can apply to some other dtsi as
> well.

You shouldn't need to have it be explicit, if it's in dtsi_include_list
as there's a rule so make can resolve how to satisfy the dependency.
But since we dynamically #include the other files, I don't know that
they will be caught with the normal dependency logic.  But, it will
still be cleaner to have the dtb rules depend on the automagic #include
files too, rather than special casing the rule here I believe.

--=20
Tom

--IhCYCBbEoiLLuarZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTafhcACgkQFHw5/5Y0
tyzT5Av8CRkrBO9gz/em9yxSR4YPrBy0Oij0USiQ1kNA452nNrwPlfUCQ/gCl5Fd
emFrCRy7/HTw4TlwVpIhbtwyLyyArWAzeq4tVAj4J/M2ZOERKpxxNMnnW3SpEkuV
ZxfS/en7CKV1EmhSoWG108HeiTDW6+72iQ894xW+17eVmV3Sp/pX4rfuZAQvyz6k
ktsc4pw00sK0PQhF2Hfn5GyxoiwfCq+pmjMz5NLOFdNrP6/eIpSyxMInqyOunNJO
TjaZLd+nFw5yoE/qxzCLbxuex7CwCQy2xHQGjxwmVGzjzg4bJFvKgS4mRFNcyltr
k0qSmctEdhaTkwbtvGxgpbDMsYR892d1ESUo/lpvnYOYVPjRdWEsFkmi2alRryHd
qYNkS1e1xndRGQSrp0ZnFpE1YJzq9Zi+tNIE7ASB/wojxqe/bz4LB+NQiklZZ6z5
P3b91BH7SPMXlu2RC1/K8IuoJNBvL3OWEZ55zvMspmLFhWG12S8WsaBpyaFr6EXQ
yA60JTOA
=CJIC
-----END PGP SIGNATURE-----

--IhCYCBbEoiLLuarZ--
