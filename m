Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE111CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190A686B89;
	Mon, 25 Sep 2023 16:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fj85n/UM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EBB986B91; Mon, 25 Sep 2023 16:19:13 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D3386B2E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59bebd5bdadso79515607b3.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695651549; x=1696256349; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RbyhckPT5vr6OYERDiGKLIWgnWTUaY7bfv9A070cIio=;
 b=fj85n/UM98GR5bKtSPsdTH2jgAWfSIJnDQAEfn1WdxNbK3NgBcg93byxUUruzcxuQH
 B9UbCValzyiSubEWjbFqWaT8QXJOekGEUxra30J3rgvwkW0bNvgHt3r0i1DVPazNsNeG
 IWTTzSjMToN0LwSSinmrDX5/Q5dmISDmsq4vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695651549; x=1696256349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbyhckPT5vr6OYERDiGKLIWgnWTUaY7bfv9A070cIio=;
 b=NoYFoAXdkJMcjAG6LtgVaX6f83ZGsTzPbwMDV9lkenRZNuhURwrxh1iOKDkH0iU9vC
 Cdv9j8/v6MDM7UiLYQoTQ1DI++f3R1217w/yIa2s+LHqVAlecLrA5nlZLW8Qwsu+vcWZ
 PZ7cJggq1V6aL32vtsPRwlDDfBp9haeqnLhnHEqsZ6E52nQpbtXjiGV/fu3v5jQFWCHc
 eFPsNJ5lN9AUAhKHbb60gXW6ym+TA2W3rbrN0+YgQx6N2vie2Fpb/cVTg4OkD0e6Gik9
 /Dkzbo9ZM45Y62V5kivCDK0JemLg+drA3S352QHUFs6H+VjTHdgDLztq7bHFJ55oGmQV
 msww==
X-Gm-Message-State: AOJu0YxkWLPm6RtmGcMqKiiQYPZGQHv6m3/GSQ2rw1e4BUo0MRRhsHnJ
 btN1Djg5PXxAjCVtedYFXJjGkQ==
X-Google-Smtp-Source: AGHT+IEoJ0xfy9HH8dgJ78QNHuNtpAr6oqdKIEPzK2A8AsqpEmAQhfhe1LcmceT74Y/06CcdX7h8BA==
X-Received: by 2002:a05:690c:d93:b0:59f:8026:4260 with SMTP id
 da19-20020a05690c0d9300b0059f80264260mr3362728ywb.24.1695651549490; 
 Mon, 25 Sep 2023 07:19:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a81bb4e000000b00579e5c4982fsm2403522ywl.36.2023.09.25.07.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:19:08 -0700 (PDT)
Date: Mon, 25 Sep 2023 10:19:06 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Message-ID: <20230925141906.GW305624@bill-the-cat>
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
 <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gY1qIUNDoXeFbC10"
Content-Disposition: inline
In-Reply-To: <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
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


--gY1qIUNDoXeFbC10
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 04:10:38PM +0200, Michal Simek wrote:
> Hi Simon,
>=20
> On 9/25/23 16:01, Simon Glass wrote:
> > Hi Michal,
> >=20
> > On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> wrot=
e:
> > >=20
> > >=20
> > >=20
> > > On 9/25/23 15:10, Simon Glass wrote:
> > > > Hi Michal,
> > > >=20
> > > > On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> =
wrote:
> > > > >=20
> > > > > Hi Simon,
> > > > >=20
> > > > >=20
> > > > > On 9/23/23 20:13, Simon Glass wrote:
> > > > > > Current alignment which is using 16 bytes is not correct in con=
nection to
> > > > > > trace_clocks description and it's length.
> > > > > > That's why use start_addr variable and record proper size based=
 on used
> > > > > > entries.
> > > > > >=20
> > > > > > Fixes: be16fc81b2ed ("trace: Update proftool to use new binary =
format").
> > > > > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >=20
> > > > > > Changes in v2:
> > > > > > - s/start_addr/start_ofs/g'
> > > > > >=20
> > > > > >     tools/proftool.c | 31 +++++++++++++++++++++++++++++--
> > > > > >     1 file changed, 29 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > Applied to u-boot-dm, thanks!
> > > > >=20
> > > > > FYI: I have merged it to my tree and already sent pull request to=
 Tom.
> > > > > Without it I couldn't pass CI loop to get all reviewed features i=
n.
> > > > >=20
> > > > > https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@=
amd.com/
> > > >=20
> > > > Ah OK, well that's fine. It was in my patchwork queue still, which
> > > > suggests that the patches were not set to 'applied'?
> > >=20
> > > I am not using patchwork. But I expect my reply to cover letter was r=
ecorded there.
> >=20
> > Probably. If you reply to each patch, it shows up in the patch, but
> > the cover letter is hidden somewhere else.
>=20
> I have never started to like patchwork. I installed that client long time
> ago, I also have account for quite a long time.
>=20
> > If you are not using patchwork, how come you are a custodian? Is
> > someone else dealing with patchwork for you?
>=20
> Not really. I am just keep track on it via emails.
>=20
> DT folks did wire CI loop on every patch which they get. I am not aware
> about any feature like this which would bring me something. That's why I =
am
> considering patchwork as unneeded layer. And I also don't think that I ha=
ve
> read anywhere that all custodians should be using patchwork.

Right, patchwork isn't required, but can be helpful.  Part of how
patchwork is maintained for everyone (in U-Boot) is that I have a script
that will update the status of patches to accepted and add the githash,
based on the "patchwork hash" of a given commit.  There's a number of
automated tooling things that other projects use which could be helpful
here, but due to lack of time/resources, we haven't tried them here.

--=20
Tom

--gY1qIUNDoXeFbC10
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmURltAACgkQFHw5/5Y0
tyz+ZwwArqTVigYADa2vfHJZgv7TF4AfohLZ4YbhW9g6Cpb9Ty1mQurbBsxd1xrW
pQXgHtkFm6OaQPp37DbLvKXZT+c7Z82gnXoIz2PAochHjo+A1NyDHMjBBJoYevs4
T/VfhsPEXbpjopNY39ihFDMxyP/y/o2ORuN0akatb1eF1B4OLiQ0V/Sn/RuQBsIU
npAfS7bBPisjI51fLTMAEM5dgwPpma+dkSKyWiv0m99cvK62WCiyeDWqRhwON+j1
kHYD6DfuK4qWZQOQsJhqZ2AlQETQ+NPrnIeIDigV9puiisWd+SxXwZhlvc/3IT97
cnb3VjvBFtal49ecIV5OpnXJJbjYdT0jG2gEFGyGdrhiYKlAS8ycnsiNWWgDL2Im
IA9Ih1Zdr5glsWlHlBvYl76Mi/LK/LzqtJR5CydHg/Hcy7z6nVQF4Iq7nkpQCpgz
zh3wqNlfbHwz5OR3yYWZ+ciRifpv32K0VX/Netj4o2B/IbOsLB0A3ts9uCMQc7yS
tma//Vie
=M/Q6
-----END PGP SIGNATURE-----

--gY1qIUNDoXeFbC10--
