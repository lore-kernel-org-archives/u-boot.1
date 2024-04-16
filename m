Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6F1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 17:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6FC98842E;
	Tue, 16 Apr 2024 19:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RNtPrfhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0757B8841D; Tue, 16 Apr 2024 19:00:38 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF7E88429
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 19:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78d77b309f2so402265585a.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713286831; x=1713891631; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hQjeMHSoIzLKovuYix2kv2iCG8Kwl7UtxXbTnSjJfPE=;
 b=RNtPrfhvY82OyPSjNEIgeZ+OQv5a7yuss1b3iQp1DTomYylh7ZB+EiWvmK0Ele5MRH
 MKMEQqtoIz3lXeYZBZEbW3iHpFXU4uVLIX33zn72eze1OzQ2/9mJkUIKT50YwSiRRAPK
 qfHkqVIMRaM6gvl5Poygy7VLJRllHSx4FrfG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713286831; x=1713891631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQjeMHSoIzLKovuYix2kv2iCG8Kwl7UtxXbTnSjJfPE=;
 b=WphSA0BoKW5kGGyDgngqpmvHQBxqfAGOXfScTMllHAJ9ha261SOMxCRCHZJ1QqgNPh
 BcCv9AmftaY/h96F87sh4azoE/9wdyH5GjE5AoZjIRpjvyFzGbL7/aIR5d2NUwr4eRb9
 UqzNl2kK0lKVFXMd0AUON+xGgCrvZN6iaVY/SIY5OCRHa270L5Hk/WBt9BTVfuu7gDPq
 jrIL6anhdgdqGUt0+6WUpmUGbxuNRGoc3M6qkAZ9qexvjqMPWHqK4bopoV5l32Vt1Fcf
 XCv5jOgqDbWhABLDfeww9TQNvNdCTHoNDl21TXyccXY75h+5zt+5AFFp6B2zxrogrYOh
 2yPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj+XI+OSO/+0AiDf3YvJtHhkavTkgLetDSBglQ8Mka9m4z3eCJoP3KOsyAGf0r0j7e59J8rr+CEwV98MAUPthJCAYmKQ==
X-Gm-Message-State: AOJu0YwSosanbDHhNtpsLrc+2HLvDrhu/TeBwB9qsqMmAF4wdRYSscRl
 teH0Wq87819NL66vF91QZTDAUZZ5nMIir6MCy3hFGsEN8exyoJlGI96v3ZaIKWQ=
X-Google-Smtp-Source: AGHT+IGgWNhBtd7ECUt7S/KvD00iYBmoZuYdfzjMHUw7H5Im7jIqxvveRC8G/u81q0/AOIc1BxWYtQ==
X-Received: by 2002:a05:620a:159b:b0:78a:f3:34eb with SMTP id
 d27-20020a05620a159b00b0078a00f334ebmr14832655qkk.23.1713286831416; 
 Tue, 16 Apr 2024 10:00:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05620a084d00b0078a04882ac2sm7594986qku.53.2024.04.16.10.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 10:00:30 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:00:27 +0200
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>,
	Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: joe.hershberger@ni.com, simon.k.r.goldschmidt@gmail.com,
 Siddharth Vadapalli <s-vadapalli@ti.com>, sjg@chromium.org,
 marex@denx.de, nm@ti.com, afd@ti.com, vigneshr@ti.com,
 u-boot@lists.denx.de, dannenberg@ti.com, srk@ti.com
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Message-ID: <20240416170027.GQ1054907@bill-the-cat>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
 <20240112132607.GO1610741@bill-the-cat>
 <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
 <20240120164141.GA3652023@bill-the-cat>
 <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
 <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
 <20240411220741.GJ2493117@bill-the-cat>
 <2406c7be-114c-4082-9c14-1cd59917b9d8@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NFCBKMYzhCV4piiB"
Content-Disposition: inline
In-Reply-To: <2406c7be-114c-4082-9c14-1cd59917b9d8@ti.com>
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


--NFCBKMYzhCV4piiB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 05:52:58PM +0530, Chintan Vankar wrote:
>=20
>=20
> On 12/04/24 03:37, Tom Rini wrote:
> > On Wed, Apr 03, 2024 at 06:18:01PM +0530, Chintan Vankar wrote:
> > >=20
> > >=20
> > > On 22/01/24 10:11, Siddharth Vadapalli wrote:
> > > >=20
> > > >=20
> > > > On 20/01/24 22:11, Tom Rini wrote:
> > > > > On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vadapalli wro=
te:
> > > > > > Hello Tom,
> > > > > >=20
> > > > > > On 12/01/24 18:56, Tom Rini wrote:
> > > >=20
> > > > ...
> > > >=20
> > > > > > > The list of conditionals in common/spl/spl.c::board_init_r() =
should be
> > > > > > > updated and probably use SPL_NET as the option to check for.
> > > > > >=20
> > > > > > Thank you for reviewing the patch and pointing this out. I wasn=
't aware of it. I
> > > > > > assume that you are referring to the following change:
> > > > > >=20
> > > > > >           if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABL=
ED(HANDOFF) ||
> > > > > > -           IS_ENABLED(CONFIG_SPL_ATF))
> > > > > > +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL=
_NET))
> > > > > >                   dram_init_banksize();
> > > > > >=20
> > > > > > I shall replace the current patch with the above change in the =
v2 series. Since
> > > > > > this is in the common section, is there a generic reason I coul=
d provide in the
> > > > > > commit message rather than the existing commit message which se=
ems to be board
> > > > > > specific? Also, I hope that the above change will not cause reg=
ressions for
> > > > > > other non-TI devices. Please let me know.
> > > > >=20
> > > > > Yes, that's the area, and just note that networking also requires=
 the
> > > > > DDR to be initialized.
> > > > >=20
> > > >=20
> > > > Thank you for confirming and providing your suggestion for the cont=
ents of the
> > > > commit message.
> > > >=20
> > > Following Tom's Suggestion of adding CONFIG_SPL_NET in common/spl/spl=
=2Ec
> > > "dram_init_banksize()", the issue of fetching a file at SPL stage see=
med
> > > to be fixed. However the commit "ba20b2443c29", which sets gd->ram_top
> > > for the very first time in "spl_enable_cache()" results in
> > > "arch_lmb_reserve()" function reserving memory region from Stack poin=
ter
> > > at "0x81FFB820" to gd->ram_top pointing to "0x100000000". Previously
> > > when gd->ram_top was zero "arch_lmb_reserve()" was noop. Now using TF=
TP
> > > to fetch U-Boot image at SPL stage results in "tftp_init_load_addr()"
> > > function call that invokes "arch_lmb_reserve()" function, which reser=
ves
> > > entire memory starting from Stack Pointer to gd->ram_top leaving no
> > > space to load U-Boot image via TFTP since TFTP loads files at pre
> > > configured memory address at "0x82000000".
> > >=20
> > > As a workaround for this issue, one solution we can propose is to
> > > disable the checks "lmb_get_free_size()" at SPL and U-Boot stage. For
> > > that we can define a new config option for LMB reserve checks as
> > > "SPL_LMB". This config will be enable by default for the backword
> > > compatibility and disable for our use case at SPL and U-Boot stage.
> >=20
> > The problem here is that we need LMB for booting an OS, which is
> > something we'll want in SPL in non-cortex-R cases too, which means this
> > platform, so that's a no-go. I think you need to dig harder and see if
> > you can correct the logic somewhere so that we don't over reserve?
> >=20
> Since this issue is due to function call "lmb_init_and_reserve()"
> function invoked from "tftp_init_load_addr()" function. This function
> is defined by Simon in commit "a156c47e39ad", which fixes
> "CVE-2018-18439" to prevent overwriting reserved memory. Simon, can you
> explain why do we need to call "lmb_init_and_reserve()" function here ?

This is indeed a tricky area which is why Sughosh is looking in to
trying to re-work the LMB mechanic and we've had a few long threads
about it as well.

I've honestly forgotten the use case you have here, can you please
remind us?

--=20
Tom

--NFCBKMYzhCV4piiB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYerqcACgkQFHw5/5Y0
tywjWAv/crZAMmhiq7aQTeF9Bi1L7GnO84eMQcgzT3HeGGKSm5tHSBlODHjlksj1
ZmsUWKPhG6/Dw4uBhTgmMUoXkP0X+CmumI0qcb2Yu+4hfrJUFUzb9sU3pvvbODMU
qlXL4a5Pw6VyXpSsRPOMOQm2jHeqGP0U0TnG/3QIsnZSj2HXq8NLsbxXdtqocYHS
pWYJljXIsg6m4cGiGru5AlMw8PnlSWmSnQOuONvLqHv+6+zhhNGHrQsTyHVNDgsu
1ED12YGmcWhxm0cu4KLA827GneeDj957Lo8CUR4GvoXOP4RQdL8Dk03FyM+MkIHu
ChwsQ4KeKUYO7UjjsV9hQ3iQ+3wIlcelgajQdKxtux/FrJfVD2qvE+urJjsmSVtt
20ZyNkuwWjB4kLbjoMhrymCpYle/uDDO0i6TJoNgIk6LkS0xoLwyozl34jMXHCuL
kfKRKiaZdVB3F/PkjPmTAfjDmjFQcjqwAuCKe1jcyVJOmDjNDNACBj9yaMndkNGZ
Wn6ggP07
=miRP
-----END PGP SIGNATURE-----

--NFCBKMYzhCV4piiB--
