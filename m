Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C98C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7275188915;
	Mon, 26 Aug 2024 21:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B15gBpy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E0088AB1; Mon, 26 Aug 2024 21:59:34 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8E888915
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-842fd4e4de7so1310739241.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724702369; x=1725307169; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2lFOdWttZrmGXyhgzb7nVBqHJ9jJl1nIrWJWo49J+bE=;
 b=B15gBpy3RzQw9k7wKOWvF3QB/AOgAf1051W+1zNRvKLS8qVHqQmF6LQ7r3bzNjXexg
 JeD9JsAg9BTTklfEuKu5adPQnawUvOGL21PsmYRFUKfl2NnoFGTI01uZUDFYPlH0H66Z
 1e/H2NcWusNcOSCDp+1qT9BM4Ljdqg2thOC3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724702369; x=1725307169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lFOdWttZrmGXyhgzb7nVBqHJ9jJl1nIrWJWo49J+bE=;
 b=XYh9yjncE1WwJJ7kDO2gPW9BnxLdxfAGGW/BB/5/v/dlhkREN0Rm1+CCeQasCg2GkI
 FDo6Is6kEkKtAXgjxquYZMjHOreUFWzQjkGql4SeogAmLsI7WXn1Vnn/gxsKUHElwIDv
 UeZClqishxmMn8ttlcz63Cy1u1JxMMCwh47haQLKNyeh9kwj788b5KJi+9JdU32TS8ki
 axOhdo0rpQjCMMloXYg9fu8g+ObxM89bYPO+UPbNxBylYfl9wbhj8uyh2ON02aNzgGDD
 L+CDNcAS5aeQUQQH5hlde/72Dex0NMOaVj2aOGzvXlfLO/Ov7UbvThs8B5jOiAPGklWF
 B2bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0gFo/Z3bjlWOxMP9VflmCMuTFnSdk5AI83ScBdbSRWWHV+rd/7LcKG5mMjkHO15XeY0AGWOg=@lists.denx.de
X-Gm-Message-State: AOJu0YwEGsCBqu8j19CGq6X2TCrUsIju9Q9lRkYc2vcApWXM4M0ElqPG
 tmEPGMjSR+ymfneMiTng7JTvm/ayDslBM63T2EB57h/vNOrRjOwL/Xp30U+B00A=
X-Google-Smtp-Source: AGHT+IHqYFeijIopvrK6T0c5ajaAnQZO3NGlYQJaL0OXJJXK3rRJWJuBxr8GBOfxN2KHoNZsH//6Yw==
X-Received: by 2002:a05:6102:c8c:b0:492:9ef9:9d1b with SMTP id
 ada2fe7eead31-49a3bc93072mr992479137.22.1724702369197; 
 Mon, 26 Aug 2024 12:59:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d631dbsm49328816d6.63.2024.08.26.12.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:59:28 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:59:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Stefan Roese <sr@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Alexander Gendin <agendin@matrox.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 00/10] SMBIOS improvements
Message-ID: <20240826195924.GM2479150@bill-the-cat>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <CAFLszTjE+8BmdmtFXER94LmEYshNDEA4x_MDTqvyGhHYed2OCw@mail.gmail.com>
 <ffeb90f8-4f3b-4455-83db-d7b03b872c84@linaro.org>
 <CAFLszTg8gM53pcbHGj-LoA9GDSU-X294_q6ZRnP_QjYFppG0sw@mail.gmail.com>
 <20240826182345.GJ2479150@bill-the-cat>
 <CAFLszTiD4A2eCMfnnKvrbm__urLu+vdi_L1T1iiwU-qOY-yYJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NoOLn2aNrqdh/VvB"
Content-Disposition: inline
In-Reply-To: <CAFLszTiD4A2eCMfnnKvrbm__urLu+vdi_L1T1iiwU-qOY-yYJQ@mail.gmail.com>
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


--NoOLn2aNrqdh/VvB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 01:12:16PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 26 Aug 2024 at 12:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Aug 26, 2024 at 11:58:54AM -0600, Simon Glass wrote:
> > > Hi Caleb,
> > >
> > > On Mon, 19 Aug 2024 at 17:03, Caleb Connolly <caleb.connolly@linaro.o=
rg> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > > As a general comment, this is adding a load of code which is used=
 by a
> > > > > lot of platforms. As more and more aarch64 platforms are created,=
 this
> > > > > data grows. Why not use the devicetree for this hardware informat=
ion?
> > > > > That is what it is for.
> > > >
> > > > This data does not belong in devicetree, the various system registe=
rs
> > > > exist to describe this information... Putting it in DT would be
> > > > duplicating it.
> > >
> > > I am not wanting to duplicate info which can be read from system regi=
sters.
> > >
> > > >
> > > > Using DT for this would additionally require having bindings accept=
ed
> > > > upstream and for all SoCs to add them. To what end?
> > >
> > > To get the correct information in there. How are boards supposed to
> > > add SMBIOS info? Do we end up creating a whole infra in U-Boot just
> > > for the driver to read it out? It just doesn't make any sense to me...
> > >
> > > Let's put hardware info in the DT where it belongs.
> >
> > I'm a little confused here because of some older threads on this overall
> > topic. Part of the issue here is that in user space, "everyone" has
> > SMBIOS-based tooling today, and wants to have that work, rather than
> > inventing new tooling or modify existing tooling. And you were concerned
> > I thought that we had tied SMBIOS too much to EFI being present when
> > indeed it should be possible to pass the location along to the OS
> > without EFI, but at the time Linux at least only supported that notion
> > on MIPS I think?
>=20
> That is a whole other concern I have, that we are perpetuating this
> legacy format which is a real pain to work with, when we already have
> devicetree. Let's leave that issue aside as I have not detected any
> interest in solving that problem, or even any agreement that it is a
> problem.

OK, yes, lets set that aside.

> But for this particular series, I am just wanting to get the correct
> info in there. Having the CPU-detection code provide an opinion about
> what type of chassis is in use (just to take an example, the patch
> pieces I highlighted have been dropped from the email I am replying
> to) just seems a bit daft to me. Only the board vendor would know that
> info.

Yes, I agree the detection should be reworked a good bit as some
information will be board design specific while others SoC specific. And
we should avoid adding many unused at run time strings to all platforms
that enable this too (looking at all the CPU vendor related stuff).

--=20
Tom

--NoOLn2aNrqdh/VvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbM3pUACgkQFHw5/5Y0
tyyvNAv+P6Z/IQsEEIQzI1proHArvVYETRtRagumY9VoJ8wD1o9v0r31A3ofPC28
tnrWPNCD13EmjLdhZktszYzq5PvmHWQSCcqDtVWBF44Hz4D3A/GmGSsA3PuXx7k8
dMHniJZAzFrsjFsXH0VHsa0lUPhb9QibM8qUSEkzOt8WBVuDM4xBAjbBT81npdH0
Oq+YXteyWBZFoPyTBT7LShWERdpKfKuAWhIWZ85g8qtDsu9mxkA1Kzc4H1Uvdn0S
eFaq1dhO8Aq/IPH9ZodD9biudEa4bpLjjbNQaIncRqlk86ONqgZWMqjmGXKdjmPD
xDVCEnKGYrW+gNcv6/TxMtyuqJFH+LXnecktsVumNFx2qVegfBBMh54M5ADeQ4Le
AekuhR+Yl+NY/gsGExsVRQedgYHkm30K0VlNLlJkivDaDp03JwGTkJnxS1GgJ80p
I6yZJnRAKs3QQuFiQ4H5CuxtTWpSkp9NukbqbE66DOOEwql1a5e61gC1i2/+k8E4
01CfVVd3
=nTOL
-----END PGP SIGNATURE-----

--NoOLn2aNrqdh/VvB--
