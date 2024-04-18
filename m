Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841EBC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED7F886A3;
	Thu, 18 Apr 2024 20:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g/wc1YNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD0188697; Thu, 18 Apr 2024 20:13:22 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641FC8868E
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78edc0f9636so83960785a.2
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713463999; x=1714068799; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aAJF+R/PuBJvzgGiVzr1Vqod2qpS98bm3Jru9CQ5JDU=;
 b=g/wc1YNGpJ/u8p5fhlD+E5+t0yEn5r79cuu0G9npb8styk8A3pO1ineH3bpoctgC/S
 w/F6VzCgpQ0XAHuJmf+k3wXxtSgn9wHF3l+PQeDD5QNaU7IDMeyH9nMwm0C/p6Tlr1U3
 uxtvJVOkPnLkPX5B9ECZj7HhSQzP1t2wlT2Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713463999; x=1714068799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAJF+R/PuBJvzgGiVzr1Vqod2qpS98bm3Jru9CQ5JDU=;
 b=EPjFrsXWf2iOvgLv7O+/kNZDadLVG4YkFjESWR1NfTAPuJuARwGBjSxHCJpvKnXnYv
 rRZzuehhzhzf9HspC2fSktkm3z/j/ezH8cjd8sAA/PUgN0ypoqj1Zt7wAOiPrviZQNom
 p28DLouuMO3k931CqmAX90PQVxlZw9AaFR8r3bOWBYwegLmVGLHTnwLg7T29f1LfIvsL
 kD47hgAkiCvpbmZLcBFAIsTCczDK/zhCnIP/v9arYYkJOvlLDyBoruo0Nreio3bgiwQ7
 T87IuCXR2VnRjjEWScywGmSikoTkn9s9l36LqbTgw273Qk1mFzjb+XMfcBqXZuzp9EWa
 63WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOFwTrhKes3O2ksMyE1rV7xFKnoARhRqUuJmRHUhJCjOChFAVXHb/xuaVq7IaPD6qI5moeq1N5L1v77bOvYFA1IVg/QQ==
X-Gm-Message-State: AOJu0YwZO1dUsg89jI2+Df1CrdkuaZKu+yeKF2rP/QwJxajnpiZDUHXr
 a0mnCxF1W93C4nAggYIj7CLLG+K/T1hQMoun1b/tLfRVHG1KxBkpTuoOTdJOEb4=
X-Google-Smtp-Source: AGHT+IG6PZu9nDwbI9x/rs2L0O+KnRJohF/pXdUVN/mdN591VzqCLYDIfEb1VRI7B66L15oYggTYmQ==
X-Received: by 2002:a05:620a:5607:b0:78e:df50:9f4a with SMTP id
 vu7-20020a05620a560700b0078edf509f4amr3735348qkn.56.1713463999182; 
 Thu, 18 Apr 2024 11:13:19 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 pb6-20020a05620a838600b0078d6bf63710sm842828qkn.55.2024.04.18.11.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 11:13:18 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:13:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, afd@ti.com,
 vigneshr@ti.com, dannenberg@ti.com, srk@ti.com,
 Sughosh Ganu <sughosh.ganu@linaro.org>, joe.hershberger@ni.com,
 simon.k.r.goldschmidt@gmail.com, sjg@chromium.org, marex@denx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Message-ID: <20240418181315.GJ1054907@bill-the-cat>
References: <20240120164141.GA3652023@bill-the-cat>
 <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
 <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
 <20240411220741.GJ2493117@bill-the-cat>
 <2406c7be-114c-4082-9c14-1cd59917b9d8@ti.com>
 <20240416170027.GQ1054907@bill-the-cat>
 <97f84067-ba36-47f6-befa-221be47a1d25@ti.com>
 <CADg8p97udLbFvbZ_FZf9Hfwg3R4=YJMNWrAtqvu97mL7vVYREQ@mail.gmail.com>
 <20240417160446.GF1054907@bill-the-cat>
 <42fd6f28-bcf6-406c-8d43-7b4f3966ebb2@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4CxR6aOBRp9jyPHe"
Content-Disposition: inline
In-Reply-To: <42fd6f28-bcf6-406c-8d43-7b4f3966ebb2@ti.com>
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


--4CxR6aOBRp9jyPHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 04:08:46PM +0530, Chintan Vankar wrote:
>=20
>=20
> On 17/04/24 21:34, Tom Rini wrote:
> > On Wed, Apr 17, 2024 at 05:48:31PM +0530, Sughosh Ganu wrote:
> > > hi Chintan,
> > >=20
> > > On Wed, 17 Apr 2024 at 13:21, Chintan Vankar <c-vankar@ti.com> wrote:
> > > >=20
> > > >=20
> > > >=20
> > > > On 16/04/24 22:30, Tom Rini wrote:
> > > > > On Tue, Apr 16, 2024 at 05:52:58PM +0530, Chintan Vankar wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 12/04/24 03:37, Tom Rini wrote:
> > > > > > > On Wed, Apr 03, 2024 at 06:18:01PM +0530, Chintan Vankar wrot=
e:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > On 22/01/24 10:11, Siddharth Vadapalli wrote:
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > On 20/01/24 22:11, Tom Rini wrote:
> > > > > > > > > > On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vad=
apalli wrote:
> > > > > > > > > > > Hello Tom,
> > > > > > > > > > >=20
> > > > > > > > > > > On 12/01/24 18:56, Tom Rini wrote:
> > > > > > > > >=20
> > > > > > > > > ...
> > > > > > > > >=20
> > > > > > > > > > > > The list of conditionals in common/spl/spl.c::board=
_init_r() should be
> > > > > > > > > > > > updated and probably use SPL_NET as the option to c=
heck for.
> > > > > > > > > > >=20
> > > > > > > > > > > Thank you for reviewing the patch and pointing this o=
ut. I wasn't aware of it. I
> > > > > > > > > > > assume that you are referring to the following change:
> > > > > > > > > > >=20
> > > > > > > > > > >             if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CON=
FIG_IS_ENABLED(HANDOFF) ||
> > > > > > > > > > > -           IS_ENABLED(CONFIG_SPL_ATF))
> > > > > > > > > > > +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(=
CONFIG_SPL_NET))
> > > > > > > > > > >                     dram_init_banksize();
> > > > > > > > > > >=20
> > > > > > > > > > > I shall replace the current patch with the above chan=
ge in the v2 series. Since
> > > > > > > > > > > this is in the common section, is there a generic rea=
son I could provide in the
> > > > > > > > > > > commit message rather than the existing commit messag=
e which seems to be board
> > > > > > > > > > > specific? Also, I hope that the above change will not=
 cause regressions for
> > > > > > > > > > > other non-TI devices. Please let me know.
> > > > > > > > > >=20
> > > > > > > > > > Yes, that's the area, and just note that networking als=
o requires the
> > > > > > > > > > DDR to be initialized.
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Thank you for confirming and providing your suggestion fo=
r the contents of the
> > > > > > > > > commit message.
> > > > > > > > >=20
> > > > > > > > Following Tom's Suggestion of adding CONFIG_SPL_NET in comm=
on/spl/spl.c
> > > > > > > > "dram_init_banksize()", the issue of fetching a file at SPL=
 stage seemed
> > > > > > > > to be fixed. However the commit "ba20b2443c29", which sets =
gd->ram_top
> > > > > > > > for the very first time in "spl_enable_cache()" results in
> > > > > > > > "arch_lmb_reserve()" function reserving memory region from =
Stack pointer
> > > > > > > > at "0x81FFB820" to gd->ram_top pointing to "0x100000000". P=
reviously
> > > > > > > > when gd->ram_top was zero "arch_lmb_reserve()" was noop. No=
w using TFTP
> > > > > > > > to fetch U-Boot image at SPL stage results in "tftp_init_lo=
ad_addr()"
> > > > > > > > function call that invokes "arch_lmb_reserve()" function, w=
hich reserves
> > > > > > > > entire memory starting from Stack Pointer to gd->ram_top le=
aving no
> > > > > > > > space to load U-Boot image via TFTP since TFTP loads files =
at pre
> > > > > > > > configured memory address at "0x82000000".
> > > > > > > >=20
> > > > > > > > As a workaround for this issue, one solution we can propose=
 is to
> > > > > > > > disable the checks "lmb_get_free_size()" at SPL and U-Boot =
stage. For
> > > > > > > > that we can define a new config option for LMB reserve chec=
ks as
> > > > > > > > "SPL_LMB". This config will be enable by default for the ba=
ckword
> > > > > > > > compatibility and disable for our use case at SPL and U-Boo=
t stage.
> > > > > > >=20
> > > > > > > The problem here is that we need LMB for booting an OS, which=
 is
> > > > > > > something we'll want in SPL in non-cortex-R cases too, which =
means this
> > > > > > > platform, so that's a no-go. I think you need to dig harder a=
nd see if
> > > > > > > you can correct the logic somewhere so that we don't over res=
erve?
> > > > > > >=20
> > > > > > Since this issue is due to function call "lmb_init_and_reserve(=
)"
> > > > > > function invoked from "tftp_init_load_addr()" function. This fu=
nction
> > > > > > is defined by Simon in commit "a156c47e39ad", which fixes
> > > > > > "CVE-2018-18439" to prevent overwriting reserved memory. Simon,=
 can you
> > > > > > explain why do we need to call "lmb_init_and_reserve()" functio=
n here ?
> > > > >=20
> > > > > This is indeed a tricky area which is why Sughosh is looking in to
> > > > > trying to re-work the LMB mechanic and we've had a few long threa=
ds
> > > > > about it as well.
> > > > >=20
> > > > > I've honestly forgotten the use case you have here, can you please
> > > > > remind us?
> > > > >=20
> > > > We are trying to boot AM62x using Ethernet for which we need to load
> > > > binary files at SPL and U-Boot stage using TFTP. To store the file =
we
> > > > need a free memory in RAM, specifically we are storing these files =
at
> > > > 0x82000000. But we are facing an issue while loading the file since
> > > > the memory area having an address 0x82000000 is reserved due to
> > > > "lmb_init_and_reserve()" function call. This function is called in
> > > > "tftp_init_load_addr()" function which is getting called exactly be=
fore
> > > > we are trying to get the free memory area by calling
> > > > "lmb_get_free_size()".
> > >=20
> > > I have no idea about your platform but I was wondering if there is any
> > > particular importance of the load address of 0x82000000? It looks as
> > > though the current location of the SP when arch_lmb_reserve() gets
> > > called means that the load address is getting reserved for the U-Boot
> > > image. Do you not have the option of loading the image at a lower
> > > address instead?
> >=20
>=20
> Sughosh,
>=20
> I think my explanation was not clear at:
> "We are trying to boot AM62x using Ethernet for which we need to load
> binary files at SPL and U-Boot stage using TFTP."
> - In Ethernet Booting we are fetching U-Boot image at SPL stage via
> TFTP at specified address 0x82000000. While loading U-Boot image we are
> getting TFTP error, since address from stack pointer till gd->ram_top is
> reserved due to "lmb_init_and_reserve()" function call. I want to know
> for which purpose this address range is reserved.
>=20
> > Or using a higher address for SPL stack? You might be able to solve this
> > just by re-examining which addresses (and RAM size limitations) need to
> > be considered here.
> >=20
>=20
> Tom,
>=20
> We tried this approach of assigning a higher address for SPL stack, but
> it is not working as expected.

Looking at the context here again, I think you need to re-evaluate what
addresses are used and for where / what. I'm not happy with the
combination of "enable LMB in SPL and then also remove the functionality
of LMB", which is what you're proposing in essence now. There's either a
different set of memory locations that should work, or some underlying
bugs elsewhere that this exposes that need to be fixed. Thanks.

--=20
Tom

--4CxR6aOBRp9jyPHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYhYrsACgkQFHw5/5Y0
tyxr5Qv5ASlH9EO+EoOD+GsezE+LRmmoKPDY4kz78IEyhrNpgEyGU2oWn+r2Me1f
1KIFduCN4IjrCkk4fj6Q1lCXOb6a3IddU7BQc5EBvEJAoAx7mC1b16B3GmxkTG4K
R2S98/Egf15QVYycZ/9EwclVTvcS3i/EI7kV5pV6V1Q3PLh4Iy02KTltkgh+vd4f
5kSWbIJbyUzLVQRZ5V+Af2WZeKsbo/ueAa7+swYldWq3YfHYttNaOuwwYfTaqRkn
FkAsXa9gPid3hWsiyBvH1o4WB5bGlSaZ3tRmdeukIx/y1qgsLJwnN8hIFHbaJNtI
XYIjwrIOAPFqc6fI3jJxKGrewjBfvBbiJd1BCbBeqW6Dpq8I7vNrliBI31QKeRew
CW7xUMbVbGbm3g83U/s9az/sMWVbGOqqbxrGIG6unOXqaz/B/O6X2Y7GQEzAO/Qy
p3Hw0iZXggaGPTjKQGRtTKzsj3Q3uV01xRcd8T+D21RJdvhTh62f16DXgvWSRTkT
dTwWaiz+
=/bTX
-----END PGP SIGNATURE-----

--4CxR6aOBRp9jyPHe--
