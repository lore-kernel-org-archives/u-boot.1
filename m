Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B13FCFA446
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 21:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC6E8409E;
	Thu, 20 Nov 2025 22:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NSGkbltQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E6B98409E; Thu, 20 Nov 2025 22:13:59 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC2883F14
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 22:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-44fff8c46bbso341104b6e.1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763673235; x=1764278035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sn4J0NkbbU7vUQDHoun6/wCJbikZV1Wm5Wbn1tSYYKk=;
 b=NSGkbltQOPasSzRgscjBgjCsyY7gbpnZpy/uwVPsvwfLr8e1DOBFXA4+tY4cg45RWt
 xDBJtgKAfNJ4ZXsnPpj6lTpIMJBMryc2FIOrsDU7WpBKjArjnJ4j+1jmpCk4l5P8yhhF
 FRwNgiYDFPpgvdlhgT47BLEfnLtzK8Rb6IYjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763673235; x=1764278035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sn4J0NkbbU7vUQDHoun6/wCJbikZV1Wm5Wbn1tSYYKk=;
 b=saqFV4I3V4pNUpH9nKaPhWbG9f/mJ+gr4SikL3Sglkkyj3vk81Zxu+wQV174BgLm5G
 0QWt/iDH8L1vm1KOKBivrxmavNktPpXkFkK9NdgTqsOFWY0vwkrECSNMg5qeonxbr/GE
 UCdfEE9mLsdfU7Jlg5nsOzXeWd+WvPuH1juhacgUxo6qtsd60iKwtfDWhKQu3V2dCoGO
 aHBBhklUnT3QjaEzzLZldFqNwyd4MzsPXB8HT6/FxkEWiueM76jnX8Fh9mZAIQHpqIES
 zwFCHovmU2IprsapPevpqaiUsoQwSzGMFJtj5tZTWa+LVZje9VshRB4dAu43kzLk8ZzQ
 DUbQ==
X-Gm-Message-State: AOJu0Yxt/ks2f3JptPUd5RaZKslTB5KGrrZVMUoqweqdqdRQmZGP+EHX
 1hRpZ9AWv7VRsNSHZMKo9suOHsYYeE/V0FTRsWUn3kpxOFUCvnw+B5Y4laX9UEf8sxQ=
X-Gm-Gg: ASbGncu4ho/OilulXkRZ33zmL2VOV1dHJXZh49s2RelyXq1zge0CbNYjEFcvcpP2bQX
 4yEYNzXrvm7L1HDzMOhLTibY60uhcYOz2sjkQd+sXLfDkvp2oblDTTOYf8MFYjTK6zVpGVsELR7
 uhGAvna4w6GYk+1I3s0Euk41gwwyxNTLLhgtXmmPEW7YGI8KuB4aWuPZCHScoV0+cIzVAuXDVkk
 JXOmT1obsz10nb138/rrelByycachNAvfVa+Gq+bV1EXMaz2N9lq7Ss3PEQtrjvgsHoPOPDnjMd
 vdW3+E2qH845dCNqD7J+7BbvqFh3pxad5gEry0es7z1dWgN5Pb9UMq7Pqa7XudFpcDV7Pvl7qU3
 evgtnlunZPBJyV8Jyeb7iASOzLPiq9RC/jwaZe1tXuM7w4NI2GkYDbcA4tNkjP2MNouUkcPOQ05
 wBxH+C9st24XI8pyz2tU/ZGTEBEiym5VfHX0vTlfM5HE7u0JPg2Q==
X-Google-Smtp-Source: AGHT+IG3B7BfM3F7ziFO8p94zEyKcMwsEUqPxtLO/gg8JS/6g1NaK9NF5LGxDvk+WNXJ5z/sUKsFJA==
X-Received: by 2002:a05:6808:6f85:b0:444:1450:c1 with SMTP id
 5614622812f47-45112d7a2b6mr12587b6e.64.1763673235521; 
 Thu, 20 Nov 2025 13:13:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450fffbd091sm1035090b6e.16.2025.11.20.13.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 13:13:54 -0800 (PST)
Date: Thu, 20 Nov 2025 15:13:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <malysagreg@gmail.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 05/12] docker: add Analog Devices tools to docker image
Message-ID: <20251120211352.GP2125796@bill-the-cat>
References: <20251118064000.14613-1-malysagreg@gmail.com>
 <20251118064000.14613-6-malysagreg@gmail.com>
 <20251118143918.GS2125796@bill-the-cat>
 <CABdDSeVDLPM7ahFS_rn9N7GhdpOssoFRp3M7xWnr9PK=G6F9RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YHlSb0tbncBH/9Rn"
Content-Disposition: inline
In-Reply-To: <CABdDSeVDLPM7ahFS_rn9N7GhdpOssoFRp3M7xWnr9PK=G6F9RA@mail.gmail.com>
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


--YHlSb0tbncBH/9Rn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 01:20:21PM -0500, Greg Malysa wrote:
> Hi Tom,
>=20
> On Tue, Nov 18, 2025 at 9:39=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > [snip]
> > > +# Build ldr tool for Analog Devices boards and create prefixed symli=
nks to match
> > > +# $(CROSS_COMPILE) as used by different supported platforms
> > > +RUN git clone https://github.com/analogdevicesinc/lnxdsp-arm-poky-li=
nux-gnueabi-ldr.git /opt/lnxdsp-arm-poky-linux-gnueabi-ldr && \
> >
> > We need to be getting a specific branch/tag (or worst case, commit) and
> > using --depth=3D1.
>=20
> I'll address this in v3, thanks. There's a release tag I can use.
>=20
> >
> > [snip]
> > > +ENV PATH=3D"${PATH}:/opt/lnxdsp-arm-poky-linux-gnueabi-ldr"
> >
> > Does this actually do what you want, update the PATH for the shell that
> > we spawn and run CI in?
>=20
> It does appear to do what I want, which is allow buildman to find and
> invoke the ldr tool, but as for whether it is the right way to do it,
> I am unsure. If I run and attach to a container to manually go through
> the steps, without the ENV line I get:
>=20
> ~/adi-u-boot$ tools/buildman/buildman sc598-som-ezkit-spl
> Building current source for 1 boards (1 thread, 32 jobs per thread)
>    aarch64:  +   sc598-som-ezkit-spl
> +/bin/sh: 1: aarch64-linux-ldr: not found
>=20
> and with it, I get
>=20
> $ ./tools/buildman/buildman sc598-som-ezkit-spl
> Building current source for 1 boards (1 thread, 32 jobs per thread)
>    aarch64:  w+   sc598-som-ezkit-spl
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNING =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +CONFIG_OF_EMBED is enabled. This option should only
> +be used for debugging purposes. Please use
> +CONFIG_OF_SEPARATE for boards in mainline.
> +See doc/develop/devicetree/control.rst for more info.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>     0    1    0 /1              sc598-som-ezkit-spl
>=20
> so it is sufficient for finding aarch64-linux-ldr. The CI build also
> passes, which has previously failed on the world build stage for me,
> when it was unable to locate the ldr executable.

Ah, good, OK.

> Bigger picture though, is hacking up $PATH the right way to do this?
> Buildman inherits the env it runs in, so it picks up the modified PATH
> and then adds the toolchain directory to PATH itself, so I could drop
> symlinks into the aarch64 and armv7 folders as well and have it work,
> but I thought that might be even less appropriate. ADI's packaging
> (for amd64 only) currently installs it as "ldr" (no CROSS_COMPILE
> prefix) into /usr/bin, which won't work for us either, because the
> yocto SDK build does add CROSS_COMPILE prefixes if one were to use
> that to build uboot outside of CI, and we need to somehow be
> compatible with all three options, which PATH+CROSS_COMPILE achieves
> for now.
>=20
> So the options are probably:
> 1) Create local symlinks to rename the binary and hack up env/$PATH to
> attach this
> 2) Drop symlinks into
> /opt/gcc-${TCVER}-nolibc/(aarch64-linux,arm-linux-gnueabi)/bin
> 3) Modify buildman to be aware of ldr and have a separate
> configuration section where we can round up settings
> 4) (Cannot be done for now) ldr tool rewrite as python
> package+executable wrapper, update binman to use the library and
> package in LDR format
>=20
> Option 4 actually makes a lot of sense, but it is not something I can
> get support for from ADI for the time being, but it would solve the
> other big problem: u-boot can produce a stage 1 and stage 2 boot ldr
> file for us by calling ldr with uboot artifacts only, but the stage 2
> ldr is rarely useful in production and is only used for standalone
> testing. It is typically repackaged in a separate yocto recipe to add
> optee and tfa, or to replace u-boot proper with a kernel for falcon
> boot, and being able to generate ldrs from binman would allow us to
> combine the other files as well.

Thanks for the details, I think for now, option 1 is OK enough, and a
future option 4 does sound like a good idea.

--=20
Tom

--YHlSb0tbncBH/9Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR+EjQAKCRAr4qD1Cr/k
CnCiAP41SDeM5s0fEPo/z7HhbyX37c3z6vKkkCD7hE8UtqTaNQEA9P8ov/2lAFHp
lu97E2O7JPVIt88wrAS7RPOAqpMcDQw=
=mf5M
-----END PGP SIGNATURE-----

--YHlSb0tbncBH/9Rn--
