Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E02C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DAD587A7B;
	Thu, 28 Dec 2023 16:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JM2oP6Js";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DACB87A68; Thu, 28 Dec 2023 16:28:08 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AA987A7B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5e54d40cca2so39183647b3.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703777284; x=1704382084; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pcCtoMnC633/H4UVqMronBhB5HLHozMMuBeKo2ZII5I=;
 b=JM2oP6JsbtddR2ZCUkdIhBuPdlNQRSkih99kSHDLRLBNY/l24HvjYdxezHYysFJyK0
 pYg87ntsf6xMslqZBhu/IHnpXjpGHYoyZx8hGJhecdDrJ1gLJE2kneFfwQeZcudgpO0O
 eEIi4IuYV9L/64DL9jP8eFjr8boyTj2usnBJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703777284; x=1704382084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcCtoMnC633/H4UVqMronBhB5HLHozMMuBeKo2ZII5I=;
 b=f9OJAxbQ9JHXueEEcnEomLMVH58RhNGccCj4FMaxT4BAKtC0hUwbYK6wdEB7q9HGGq
 ZWhaxQIxSx10is2yuDuCTD6jpa1Utq8YXVH5m2zqbAf7FrenzU66KU7+sp543rU6SePX
 VgU4T3z9kRDAsaPhvKYYUQ1QXmtUlLY1+uFjM6JvljLTgYQ0kkv1VNET91rz2ENyWOTZ
 wP5xwGwVSa/K4HhoUh4merZtMY6qMhwJTEASz+hr+9lm+i1aNMkzc/8x16P/L2Nzdrhj
 BG+EtROHTgYLzRVejL+Jts0SViACZe0XGhGm4mDcwhZx7AWZUCK/F288lwf+ufltvrxe
 pjTA==
X-Gm-Message-State: AOJu0YwfGsYe0V9XMlFWn1dD5AydTiP8Q3f6Fw+rq0D1LxvDjJcfaYfJ
 N+bpc5+bgyBq/VW3Osaz2TrzxkQAdJPKLQ==
X-Google-Smtp-Source: AGHT+IGpCAL4dgIBykxbq4KbSsMpVV6iBNoHHuER2PG10x+tvZIE3XdBwEOkMVYhQIM7pVeJzifEWw==
X-Received: by 2002:a81:dc07:0:b0:5ee:5daa:2426 with SMTP id
 h7-20020a81dc07000000b005ee5daa2426mr1400941ywj.45.1703777283991; 
 Thu, 28 Dec 2023 07:28:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 p84-20020a0de657000000b005e1a5593c0csm7476987ywe.60.2023.12.28.07.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 07:28:03 -0800 (PST)
Date: Thu, 28 Dec 2023 10:28:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231228152801.GG2652760@bill-the-cat>
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
 <20231227201130.GV2652760@bill-the-cat>
 <CAFLszThJc04Zh1tFA4Cp7+oKVv2oKtk2015F37eMzPcXgqW7bw@mail.gmail.com>
 <20231228134809.GZ2652760@bill-the-cat>
 <CAFLszTj+gVLyGr82mf5VT3KS86pkH+gjpM525o973WKYQcNv4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o9m7EVg3Wx7cLBJw"
Content-Disposition: inline
In-Reply-To: <CAFLszTj+gVLyGr82mf5VT3KS86pkH+gjpM525o973WKYQcNv4w@mail.gmail.com>
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


--o9m7EVg3Wx7cLBJw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 03:09:45PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Dec 28, 2023 at 1:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 01:37:39PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > >
> > > On Wed, Dec 27, 2023 at 8:06=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Wed, Dec 27, 2023 at 05:48:42PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, Dec 26, 2023 at 12:07=E2=80=AFPM Tom Rini <trini@konsulko=
=2Ecom> wrote:
> > > > > >
> > > > > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > > > > >
> > > > > > > Standard passage provides for a bloblist to be passed from on=
e firmware
> > > > > > > phase to the next. That can be used to pass the devicetree al=
ong as well.
> > > > > > > Add an option to support this.
> > > > > > >
> > > > > > > Tests for this will be added as part of the Universal Payload=
 work.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > > The discussion on this was not resolved and is now important =
due to the
> > > > > > > bloblist series from Raymond. So I am sending it again since =
I believe
> > > > > > > this is a better starting point than building on OF_BOARD
> > > > > >
> > > > > > I really don't like adding another option for "DT is given to u=
s". Why
> > > > > > isn't adding another enum to fdt_source_t sufficient
> > > > >
> > > > > That is added by this patch, but...
> > > > >
> > > > > >, and if we have
> > > > > > bloblist enabled, that will look for and use if found?
> > > > >
> > > > > ...this is the question. I would like to be able to enable blobli=
st
> > > > > without *requiring* the DT to come from there, hence the separate
> > > > > Kconfig option.
> > > > >
> > > > > > Maybe some other
> > > > > > code needs to be restructured and cleaned up too?
> > > > >
> > > > > Possibly, but I really am not keen on this board-specific solutio=
n. I
> > > > > believe Ilias & I agreed that OF_BOARD should fade away, so I don=
't
> > > > > like adding another thing onto it.
> > > >
> > > > I think you're missing something then. It should not be board speci=
fic
> > > > to just find the dtb via bloblist, without a new CONFIG.
> > >
> > > Yes, that is what I am looking for.
> > >
> > > > Whatever is
> > > > stopping that is what needs to be refactored and then you can just
> > > > extend fdt_source_t without a new CONFIG option.
> > >
> > > OK, but I need a way to turn it off, at least for development.
> > >
> > > [merging in the other thread:]
> > >
> > > On Wed, Dec 27, 2023 at 8:11=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Wed, Dec 27, 2023 at 05:48:44PM +0000, Simon Glass wrote:
> > > > > Hi Ilias,
> > > > >
> > > > > On Wed, Dec 27, 2023 at 6:44=E2=80=AFAM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > > > > > >
> > > > > > > > Standard passage provides for a bloblist to be passed from =
one firmware
> > > > > > > > phase to the next. That can be used to pass the devicetree =
along as well.
> > > > > > > > Add an option to support this.
> > > > > > > >
> > > > > > > > Tests for this will be added as part of the Universal Paylo=
ad work.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > > The discussion on this was not resolved and is now importan=
t due to the
> > > > > > > > bloblist series from Raymond. So I am sending it again sinc=
e I believe
> > > > > > > > this is a better starting point than building on OF_BOARD
> > > > > > >
> > > > > > > I really don't like adding another option for "DT is given to=
 us". Why
> > > > > > > isn't adding another enum to fdt_source_t sufficient, and if =
we have
> > > > > > > bloblist enabled, that will look for and use if found? Maybe =
some other
> > > > > > > code needs to be restructured and cleaned up too?
> > > > > >
> > > > > > Same here. On top of that the bloblist has a few items in there=
, e.g a
> > > > > > TPM eventlog. What are we going to do? Add a Kconfig for each i=
tem?
> > > > >
> > > > > No, but that is just a straw man. The DT is special and U-Boot re=
ports
> > > > > where it comes from.
> > > > >
> > > > > >
> > > > > > This has been going back and forth for a while. I've lost count=
 of how
> > > > > > many times I repeated the same proposal, but here it goes again=
=2E We
> > > > > > have OF_BOARD and BLOBLIST options. The bloblist and its proper=
ties
> > > > > > are scannable at runtime. Can't we use the combination of these=
 2 can
> > > > > > be used to imply we expect things from a bloblist. If we want t=
o be
> > > > > > stricter in the future and explicitly expect the DT from a blob=
list,
> > > > > > we could add a Kconfig option failing the boot if that's missin=
g.
> > > > >
> > > > > I would like to have that Kconfig option now, not later. In my mi=
nd,
> > > > > the boot must be deterministic, so that if OF_BLOBLIST is enabled=
, the
> > > > > DT must come from there, or it is an error.
> > > >
> > > > Determinism doesn't require a CONFIG option, it just requires an if=
/else
> > > > tree where we say what the "correct" priority list should be and th=
en
> > > > set a flag so that we can tell the user where we found it too. This=
 also
> > > > means that we can get whatever is going to use this mechanism to
> > > > migrate over, and have less of a chicken-and-egg type of problem.
> > >
> > > OK I think I understand what is going on here. We need a way to enable
> > > OF_BLOBLIST while still allowing the prior stage to NOT provide a
> > > bloblist, at least for a transition period (=3D forever, I suspect, b=
ut
> > > that's another discussion).
> > >
> > > How about if OF_BLOBLIST enables the option, but we allow a fallback
> > > to OF_BOARD if the DT is not there?
> >
> > Oh, OK, so your use case is development. Why don't we just make
> > OF_EMBEDDED be the first clause in the if/else (and yes, if
> > (IS_ENABLED(CONFIG_OF_EMBEDDED) :)) and move on still not needing a knob
> > for "bloblist has it"?
>=20
> Because OF_EMBED doesn't work with binman, and takes a lot of
> different code paths, etc. It is somewhat useful when loading U-Boot
> using a debugger, but that is about it.
>=20
> I sent a v5 that I hope does what is needed.

It sounds like binman needs to be fixed to just handle the case of not
needing to do something with the device tree, since it's already
embedded? I'll look again at v5, but since you sent it out while we were
still talking about v4 and only just now understanding what your use
case is, I don't think it's right, still.

As you've said your use case is development and needing to ensure you
get the device tree you want (because you're modifying it), and OF_EMBED
is supposed to be used only for that exact use case, that's how we
should solve this problem.

--=20
Tom

--o9m7EVg3Wx7cLBJw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNlAEACgkQFHw5/5Y0
tywcNAv6A4/9SOWIVuB3A7bcUyyk2jbk8sL71uFjnby91aj0opo6JMYjNt00gUzJ
QB4KfKjC59t7zO+EYbYY+nRNOgKaWhjB/Kn+ovqN4aNJvWPYQJzosVYPOeL9/hQk
zlFrajcIBT6vpl2VpxWnMTfnQ/NvwVZm7g3BVuFvAm+wYd7nE9uDILumWT+rruee
ffkCm3madHllNnc+VKoYOg6u0m6o9VfE2aGKscmyjhvmuLEBDo72Nb32GS0NT0QU
84x2I3Diy4rGHEXRokKXMVgLGqGHDj4qDGcieoyratR7Cil2idqE9mi+ZwKqbddc
WF0JchQDlEry0jKvFtw7CCovCK10srys5uiJZMELH6Zf7vNKA/NDoNXnAWwc883b
1d4WcTMXtmtry+r7SWgasYUgp/Fmfo28MAnNzOraX0EQM9x1e77ZnciRbyV3G/wj
bf+C44PtHtxtHtjyJZf3lH1+zqA1+Em34/omsmk8JgAvBenHFkFq5w0AyZfXQ3i1
WRTBB6N/
=pbwi
-----END PGP SIGNATURE-----

--o9m7EVg3Wx7cLBJw--
