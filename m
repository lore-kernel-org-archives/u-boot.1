Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26F3C83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1182C865DE;
	Thu, 31 Aug 2023 21:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B6tCm8aZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF66865DE; Thu, 31 Aug 2023 21:07:17 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ABE186553
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5922b96c5fcso13732237b3.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693508832; x=1694113632; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lihXGB6e6F7b/x07IILVWt8l3MlJEDWl7lW4k8eVK8o=;
 b=B6tCm8aZocscxi5FPxj1OfWUkaQBe12DyOcyxtZavbzZdUt+o+2KI8mFAA+Pi95MeC
 S85zSyph8jyNIgDuMDVtYLCnQmVHbbFW7XzgvmDl2X3fQF5qtz0W7PvNlgn5VHIynErS
 1ykgRv4AXZDu+6QwGOZAWhGGN1z9ksKK4RbzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508832; x=1694113632;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lihXGB6e6F7b/x07IILVWt8l3MlJEDWl7lW4k8eVK8o=;
 b=ULlnzluR232hhNkOqbrWIM5febbTgSdKMg10pdtK6q5n11hiZxvviYmdjmsApN/BvH
 01zTH4TSFP1bBS1KFRm7havmDs3YUaSEiFL5Yc1jg4LBXDET/V4S9aR6d2VfJdvKmaij
 PiOZkNETPmYZsSjT+gEmADTcOX1c+g6AJUQ3onpUvqjIf0Hbu+xOva1QOYACpO2AHi3n
 vZPnSBxV6rcl3rxkUx6UMowlBNWFpA2GhJXRKcQ1OWhLcddLxFzpsa4UllKIzV9PHPCy
 VXr5WXYugypkgmTzMi7HDfi+b3fC4V9bYj6jvs0wN1D8JKdty8T6epYZ/zpWKVl0eMCk
 zw+A==
X-Gm-Message-State: AOJu0YwgsBE90FRHPm/b1mCVzWRjV7D6aUouC8B+xi2lJ0amAfKr7FUY
 //U3mxxSAq10/Au6cu+mR/O1Wg==
X-Google-Smtp-Source: AGHT+IGy69Zd1otLmHkTljBaRN091UOrTdekzAwoL08wbg+a/6CY8obQK4y0ofGP94wiDW3ltfTHlA==
X-Received: by 2002:a0d:d68c:0:b0:590:e116:cef6 with SMTP id
 y134-20020a0dd68c000000b00590e116cef6mr372998ywd.26.1693508831745; 
 Thu, 31 Aug 2023 12:07:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a81d549000000b00594fff48796sm601305ywj.75.2023.08.31.12.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 12:07:11 -0700 (PDT)
Date: Thu, 31 Aug 2023 15:07:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>, Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
Message-ID: <20230831190709.GO3101304@bill-the-cat>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
 <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
 <d4ce17ae-8b84-4c8a-acaa-287549ec23a3@gmail.com>
 <CAPnjgZ0sTAoZi5TDAaTZUNPVNQ5dqoyVENDWJr=exa5z2R8srw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w3hewfFBUNrsNyoT"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0sTAoZi5TDAaTZUNPVNQ5dqoyVENDWJr=exa5z2R8srw@mail.gmail.com>
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


--w3hewfFBUNrsNyoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 01:01:59PM -0600, Simon Glass wrote:
> Hi Alper,
>=20
> On Thu, 31 Aug 2023 at 04:20, Alper Nebi Yasak <alpernebiyasak@gmail.com>=
 wrote:
> >
> > On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> > > Hi Alper,
> > >
> > > On Sun, 27 Aug 2023 at 13:17, Alper Nebi Yasak <alpernebiyasak@gmail.=
com> wrote:
> > >>
> > >> On 2023-08-24 06:02 +03:00, Simon Glass wrote:
> > >>> In this early stage of using binman to produce output files, we are=
 mostly
> > >>> seeing people using common extensions such as '.bin' and '.rom'
> > >>>
> > >>> But unusual extensions appear in some places.
> > >>>
> > >>> We would like 'buildman -k' to keep the build outputs, but this is =
hard if
> > >>> there is no consistency as to the extension used.
> > >>>
> > >>> This series adjusts binman to enforce just 4 extensions for output =
images:
> > >>>
> > >>>    .bin
> > >>>    .rom
> > >>>    .itb
> > >>>    .img
> > >>>
> > >>> Other extensions will produce an error. With this rule observed, bu=
ildman
> > >>> can keep the required files.
> > >>
> > >> I dislike this limitation. We know what files we will generate, they=
 are
> > >> listed in binman dtb, so we can add something like `binman build --l=
s`
> > >> to print their names/paths for buildman to preserve them.
> > >
> > > Yes, it would be good to have that...
> > >
> > > But why do you dislike the limitation? Do you think extensions provide
> > > useful information? I suppose one problem is that *.bin might pick up
> > > private blobs that happen to be in the source directory?
> >
> > I guess my strongest argument is that people already/will have workflows
> > that depend on certain filenames or extensions, and shouldn't have to
> > modify binman code (consider that people may be using the PyPI wheels)
> > to accommodate those when we are already putting the name in the dtb.
> >
> > I do want some standardization to the U-Boot build outputs though, but
> > more like a global binman.dts with like u-boot.rom, u-boot-sdmmc.img
> > images with well-defined TPL, SPL, U-Boot sections that arch-dtsi files
> > can fill in.
> >
> > >> Regarding the output directory suggestion, I think the binman outputs
> > >> (not temporary/intermediate files) should be in the same directory as
> > >> make outputs
> > >
> > > Agreed
> > >
> > >> , and the Makefile should default to O=3Dbuild to achieve the
> > >> "output dir". I'm not sure if that's going to happen.
> > >
> > > I would quite like the 'non-output' file (i.e. things that are not a
> > > binman image) to appear in a 'binman-work' subdir of the output dir.
> > > What do you think?
> >
> > I'd prefer them to go in a tempfile.TemporaryDirectory() and discarded
> > at the end of a binman run, and a "--tmpdir <path>" option to use a
> > given directory instead and preserve things for debugging.
>=20
> Actually, that was the original purpose of the output directory in the
> u_boot_pylib.tools module. But with all the files binman creates, that
> has been lost. I think we should restore that purpose (with an output
> dir as a temp dir) and then I think what you have written here will
> work.

Just please note the rest of the feedback that's been given to this
series too.

--=20
Tom

--w3hewfFBUNrsNyoT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTw5NoACgkQFHw5/5Y0
tyyz6Av/a5yUFtF9wrgC20sA473Ip6+PezKJwattoJQcY2RGtbgRMrpCRBZyKbue
UC7qSEaxRN3tjXIDPuO7F35WU2q8qmnHhL9RyWHYyq1NeWpfe2Fo25Vn0SUd7LU2
L7EhAf0cz0K8Wi1XPJJQ/NwBioZ6CdeuBRDB2hUhdbQxXkCvZ4LaAK2Af3gp6g94
w5VIrrmm7dmdyiL3W+hKoSfVZlSwNY7wO1lQljiZ0WjA8BiwXR2CWQ7O+F5otm6c
O2aK29gbPUzJ0LIW8hVgpQ6ViJgOmF9mUWgaPLhetp56ph2EsvvBPZ3hQ3tb56Mn
jZOmD6d53emfQ/SYR3KwSAZanhjOFS891mmCaDgR0BUJ4ihqJnyWrG8Z4Xt0ZZCP
EMZjlBE960dyDEBuvSrMBPD1hqELzIngNGq+ACNKmStkm79/413fABuNLipPx4a9
/7CoOWAkgG6rw3ejtKdLLFBM66YqeMiTz7znlgED3ddVy/Ba3wVAuVIAped7Pudt
XO2iyCoF
=1s/U
-----END PGP SIGNATURE-----

--w3hewfFBUNrsNyoT--
