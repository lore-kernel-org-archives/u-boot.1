Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50358E732C7
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 12:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F56F866AA;
	Thu, 28 Sep 2023 14:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ePrchA+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4B586E31; Thu, 28 Sep 2023 14:23:24 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04DA48646A
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 14:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59f6441215dso116829027b3.2
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 05:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695903800; x=1696508600; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uBHvLPIhXuOkGgaTHV1S4vSYOjK30CTZK8UOUXz3x4w=;
 b=ePrchA+iZ5sropBBRskV6Yyq34T+7EpeiY5/Iy86Ml5DNEB9k8+sp8kXX2fi4Y5/Sw
 DfBdp/dCU8ZG9k1A979jAvz97fo6DK01sSB5uqRZQyBeV5K8MLdftTJjh/fE0yyeAXGl
 op0JLyPuJjabFLvjDHiSSsP+OevgrTYmsKlb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695903800; x=1696508600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBHvLPIhXuOkGgaTHV1S4vSYOjK30CTZK8UOUXz3x4w=;
 b=ItVvAIywrpLO1XTS+8JWC6jduqcxmNziMBTxdxCqE6yz8zsB4Z4UG8g55vQ1exxu7Z
 S6I/BcqBvwa8q+gEMZFIkW1WrNgzOo+tdfAnvPTHTW5O+0MHlETSOZ+Qc4zpef3B+5aT
 L+9/l0x4kYE/11ZLBM1e+fyBj7g3eZY8YoSoLHxgprHnynCJVCTr6Jm0KmZyiZC0KL4A
 o8mBxA8WhUxz/eiGl21HKr9+Ldydw/sRawejWB8GZp7GzPVxknYZgVVWdg+fJcGwgWF8
 4ptJDblED7vD3svB9yHakL2yf38UxB60wP2zxHRnA6ldgNt4BYuzi2CAypvuLKshnlF+
 VRlw==
X-Gm-Message-State: AOJu0YyVHSrc1oPYS1MbQiLJFYUqVJcG04zMLSbOvpHO4R6AUTQuCBaD
 NFRFkD5jyyUQdQZF33e9QCBfdw==
X-Google-Smtp-Source: AGHT+IFColJHj+YLD58nTG49C4kXpO1cuVHbUbKbMoz2FGqaGmvShUfRTouPvFQX8J4JHEaGoW0uPg==
X-Received: by 2002:a81:df01:0:b0:59b:cfe1:bcf1 with SMTP id
 c1-20020a81df01000000b0059bcfe1bcf1mr841132ywn.44.1695903800572; 
 Thu, 28 Sep 2023 05:23:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-e373-86d8-7506-01bc.res6.spectrum.com.
 [2603:6081:7b00:6400:e373:86d8:7506:1bc])
 by smtp.gmail.com with ESMTPSA id
 f184-20020a0dc3c1000000b0059af121d0b8sm4537074ywd.52.2023.09.28.05.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 05:23:19 -0700 (PDT)
Date: Thu, 28 Sep 2023 08:23:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, u-boot@lists.denx.de,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Subject: Re: [PATCH v1 3/3] arm: npcm8xx: support dcache off
Message-ID: <20230928122317.GD305624@bill-the-cat>
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
 <20230926085651.395069-4-JJLIU0@nuvoton.com>
 <20230926134807.GT305624@bill-the-cat>
 <CAKUZ0+FRnrEuyGpNMeqD_Tbi8VXTgtV=8A1ZoQPU=ZaMJRT3TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Vc42YH9mojTetQW9"
Content-Disposition: inline
In-Reply-To: <CAKUZ0+FRnrEuyGpNMeqD_Tbi8VXTgtV=8A1ZoQPU=ZaMJRT3TQ@mail.gmail.com>
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


--Vc42YH9mojTetQW9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 08:49:23AM +0800, Jim Liu wrote:
> Hi Tom
>=20
> Thanks for the quick review.
>=20
> if we set the CONFIG_SYS_DCACHE_OFF the  armv8 will build error.
> So we added a workaround for our bmc uboot.
>=20
> the error message as below:
>=20
> CONFIG_SYS_DCACHE_OFF can't be enabled on armv8, or the following
> build error would happen.
>=20
> arch/arm/cpu/armv8/cpu.o: in function `cleanup_before_linux':
> arch/arm/cpu/armv8/cpu.c:60: undefined reference to `icache_disable'
> arch/arm/cpu/armv8/cpu.c:68: undefined reference to `dcache_disable'
> arch/arm/cpu/armv8/cpu.c:69: undefined reference to `invalidate_dcache_al=
l'

OK, so you need
https://patchwork.ozlabs.org/project/uboot/patch/20230811054228.3721455-1-b=
hupesh.sharma@linaro.org/
to be applied, as-is, yes? Thanks!

>=20
> Best regards,
> Jim
>=20
> On Tue, Sep 26, 2023 at 9:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, Sep 26, 2023 at 04:56:50PM +0800, Jim Liu wrote:
> >
> > > do not enable dcache by setting CONFIG_SYS_NPCM_DCACHE_OFF=3Dy
> > >
> > > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> > > ---
> > >  arch/arm/mach-npcm/npcm8xx/Kconfig |  4 ++++
> > >  arch/arm/mach-npcm/npcm8xx/cpu.c   | 12 +++++++++++-
> > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/mach-npcm/npcm8xx/Kconfig b/arch/arm/mach-npcm/=
npcm8xx/Kconfig
> > > index 5f4a0506dc..163e7e7d48 100644
> > > --- a/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > +++ b/arch/arm/mach-npcm/npcm8xx/Kconfig
> > > @@ -6,6 +6,10 @@ config SYS_CPU
> > >  config SYS_SOC
> > >       default "npcm8xx"
> > >
> > > +config SYS_NPCM_DCACHE_OFF
> > > +     bool "Do not enable dcache"
> > > +     default n
> > > +
> > >  config TARGET_ARBEL_EVB
> > >       bool "Arbel Evaluation Board"
> > >       help
> >
> > Why do we need a new Kconfig option here on top of the existing generic
> > ones to control cache?
> >
> > --
> > Tom

--=20
Tom

--Vc42YH9mojTetQW9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUVcCsACgkQFHw5/5Y0
tyw2UQv7B99jMJfgBDoyruTXsSob/LhKNlquVttx5jJ8uWiHLv6ppUbBxcBe1MSF
6T8zqDYnHt8kYgE6FT4aKK8t+nSDo757E97FNbflCAGGxhcCGMnpQo3PAeq183iL
W6jdkAWS9UKNvrcpE+eUnuX37BhWZAwTYiBWdwv/SNyTnxRVC2QE3TBqqSZl9AqQ
zVCIODMSrKkkgSCKAL84l5trqJ1TZTki4JFnZALVFXF2MQlYMcB2eKO9FSGs0IE3
ueNsRXCF3Tlo8ye0+yrNE+fXSizB448yrU7OnJvgO//x83mMIFQpvmlMQTmoxVI/
opGB7lgWzKLDRfP3sZhQTEjkgeN97yetGruWqhfqmck097/nhQ0BCO+weatHKniI
ewHFek+92Kqml3jsz3the6Y3+lL+vpBHTtc4s6HrEAny0QuvH3cQVtTKphASGih4
ZI+F5BPz5Qluq7vf/8f+/Ua4Jm8JXqSr66WN0YcxeoeUjQjVRS5SjSlRTG2Z4YTo
L8WKse5D
=oKjL
-----END PGP SIGNATURE-----

--Vc42YH9mojTetQW9--
