Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8158CC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0450387AB6;
	Thu, 28 Dec 2023 16:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RlUMFTCU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F4E87AB6; Thu, 28 Dec 2023 16:25:13 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 799ED87A7B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e745891a69so48384917b3.2
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703777108; x=1704381908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P5pPQAOFZvjdwYbvIJmTtI3GibSN+hHRfK0LXP8QNxE=;
 b=RlUMFTCUWk7cB+D1svOBRSlY9561SxwHaGB91Ts4TT7DNx/hx6s4yghj041EN/Bqda
 e7vFJz2NkxOQ9+bkamRpnsmNauRNhhDl9a2Vahpn/FuqjA2JvJ7OJxDip1zANLSwi4W6
 5q3CTIJ5Fx7sxUkJhibDYf9utkxXJ/Bxq16Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703777108; x=1704381908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5pPQAOFZvjdwYbvIJmTtI3GibSN+hHRfK0LXP8QNxE=;
 b=AstZb1GxLoUgQo9D5ljUpExldeew8DgQUUQcXajuwYQPBbQyDzbvg9WPByDq+XYg+T
 dpxBCASlm5w9I3yFxC8cO0o8P0pMCs8gVgAi+5rEnxEXywzJMJgWxOWo2zStdeg5IgzE
 KmG8fPDgBEM4RAqDPnkASOAbj89WJ1TZgOsGeL0x4gUpyh3Z/H2EQJ76m4kzQk0m8BRJ
 Ckt67JFwZKixBW0LlMuJ0ZkFqOOTCLSa0s6Blj11oLaM23DgPaepm4W0G0iaHbOYKClf
 cjVRUM9J1RTUtN5QMYlKEEipH6Bf6S1ZNdIF4iJ5tJyKQtYexBZjZWMmqRpeiTTCcrzi
 kYvA==
X-Gm-Message-State: AOJu0YwLBzRDD40EC5Rg9dIGyfFzW4DEsyosbPR16nu4tugo67njLwWz
 d4HS8Up7lmvr3tONUD850aFg6ojy5rpvYg==
X-Google-Smtp-Source: AGHT+IF6qVORWiEfQSthAdjihIjx2lnsV46lpKAuIwz8bK+VtVq0r7ic5RCm4QJ8Cxev4ivs41TJQg==
X-Received: by 2002:a81:48d4:0:b0:5e9:f02a:5a23 with SMTP id
 v203-20020a8148d4000000b005e9f02a5a23mr5579752ywa.68.1703777108172; 
 Thu, 28 Dec 2023 07:25:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c5-20020a81c945000000b005ea9425db98sm5788251ywl.8.2023.12.28.07.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 07:25:07 -0800 (PST)
Date: Thu, 28 Dec 2023 10:25:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 7/8] dts: meson-gxbb: Switch to using upstream DT
Message-ID: <20231228152504.GF2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-8-sumit.garg@linaro.org>
 <CAFLszTg=CDfyTGG9c-t=98eFYvYy61L1kzmrssNKPSS6dZL3cg@mail.gmail.com>
 <20231228135642.GA2652760@bill-the-cat>
 <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0z+czaZUpOOm8ORG"
Content-Disposition: inline
In-Reply-To: <CAFLszThP+GJcPP_LJBva1M5mi9Wj-Nh-z7A6-fkSpPgOTtLmRQ@mail.gmail.com>
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


--0z+czaZUpOOm8ORG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 03:09:41PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Dec 28, 2023 at 1:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 01:37:11PM +0000, Simon Glass wrote:
> > > Hi Sumit,
> > >
> > > On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > >
> > > > Although there were still some variations in board DTS files based =
on
> > > > meson-gxbb SoC but I think those were minor differences from upstre=
am
> > > > and shouldn't impact boot on these devices.
> > > >
> > > > So switch to upstream DT via mirroring amlogic/ directory from
> > > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby direc=
tly
> > > > building DTB from there including *-u-boot.dtsi files from
> > > > arch/$(ARCH)/dts/ directory.
> > > >
> > > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > > --------------
> > > > - Dropped Makefile portion and enabled OF_UPSTREAM for SoC instead.
> > > >
> > > > Changes in v2:
> > > > --------------
> > > > - Picked up review tag
> > > >
> > > >  arch/arm/mach-meson/Kconfig           | 1 +
> > > >  configs/nanopi-k2_defconfig           | 2 +-
> > > >  configs/odroid-c2_defconfig           | 2 +-
> > > >  configs/p200_defconfig                | 2 +-
> > > >  configs/p201_defconfig                | 2 +-
> > > >  configs/videostrong-kii-pro_defconfig | 2 +-
> > > >  configs/wetek-hub_defconfig           | 2 +-
> > > >  configs/wetek-play2_defconfig         | 2 +-
> > > >  dts/arch/arm64/amlogic                | 1 +
> > > >  9 files changed, 9 insertions(+), 7 deletions(-)
> > > >  create mode 120000 dts/arch/arm64/amlogic
> > > >
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > > diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kcon=
fig
> > > > index d6c89058061..8ddb59161a0 100644
> > > > --- a/arch/arm/mach-meson/Kconfig
> > > > +++ b/arch/arm/mach-meson/Kconfig
> > > > @@ -25,6 +25,7 @@ choice
> > > >  config MESON_GXBB
> > > >         bool "GXBB"
> > > >         select MESON_GX
> > > > +       imply OF_UPSTREAM
> > > >         help
> > > >           Select this if your SoC is an S905
> > > >
> > > > diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defcon=
fig
> > > > index 41dbf7981f8..2e1c756bf7a 100644
> > > > --- a/configs/nanopi-k2_defconfig
> > > > +++ b/configs/nanopi-k2_defconfig
> > > > @@ -6,7 +6,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> > > >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x20000000
> > > >  CONFIG_ENV_SIZE=3D0x2000
> > > >  CONFIG_DM_GPIO=3Dy
> > > > -CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"amlogic/meson-gxbb-nanopi-k2"
> > > >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> > > >  CONFIG_DM_RESET=3Dy
> > > >  CONFIG_DEBUG_UART_BASE=3D0xc81004c0
> > >
> > > So now I am wondering if we can (later) have the SoC be implied when
> > > using OF_UPSTREAM so we can do:
> > >
> > > CONFIG_DEFAULT_DEVICE_TREE=3D"meson-gxbb-nanopi-k2"
> > >
> > > and it will add the 'amlogic/' automatically?
> > >
> > > Perhaps that might be a way to bridge the gap in terms of file layout?
> >
> > That's going to start to look real ugly real quick I suspect and I'm not
> > sure what it really gets us? It seems to me that the convention of
> > "vendor/board" has already been well enough adapted outside of the
> > kernel, with the odd sticking point being getting everyone used to
> > whatever will be happening for 32bit boards long term. So I think hiding
> > the vendor part of the string here will be more, not less, confusing
> > long term.
>=20
> Now that I dig in a bit, I see that the devicetree-rebasing tree does
> not have any Makefiles in it. How does Linux build with it? Does
> anyone have instructions?

Linux doesn't build with it, it's the relevant parts of the kernel tree
extracted for other projects to more easily use (more or less).

--=20
Tom

--0z+czaZUpOOm8ORG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNk0oACgkQFHw5/5Y0
tywn5Qv/aQMBqT8pVUc8tFmt6cT4+DscisoSl+Ncrm9MYzWD3yGcfq4me3VJQbbE
3QK6fmj95e3CgTYCz4slvtSqdqIP/7i+t1/5s2c4IVs82m/u4NTLymBOwOzDkUoE
kQXTtZ9Ayqhe3lT2B6nD1QpyKbHuq86qOo2AyWk2beFh0rQI4GwT+jCp9RBNC6IH
+4Q8RO9wvs3O8SzYKnVhYXzfAMhdoCr46Og14vZq1HdX7z7/0VU4jI/M+275wyHO
T8UR/U1cHypSGz0R3X9Rm5M/YYdXelvathWlEqFCiMzZJcEyTrpU/0KvYFk0s+Gr
WTlLQd6dXIKIV+dbeWtj0bI0Ah02qGJiu2VgJ2fPND+riStZVXYJ4KEVWqX6PrHN
qrbVS9FhDmtjZBgSPDv/MJ491qaMiVWuOQGHadQm5EswBpmF8VoE8yteZ0fbCP/o
JpVQwDYjR6EAw5mytdDjl0LXT7UegmgVUr3Uohp8pvWuf12UIrb/hHvxEzLzoCSy
GLN9eVwo
=Xzm8
-----END PGP SIGNATURE-----

--0z+czaZUpOOm8ORG--
