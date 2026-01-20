Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8150D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:52:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A6583A8D;
	Tue, 20 Jan 2026 15:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V3RteiVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22B383A91; Tue, 20 Jan 2026 15:52:19 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39DA383A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45c8984fac8so1681940b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768920736; x=1769525536; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1xLPHpmT//415y6uqk9ePeDGGZwS41sDwkYlfxOmVIY=;
 b=V3RteiVp+Jh/mCTwFIxClDWKgIOYHe37u/hP5GYKggTk8AcK4pejMrF9ti73+Ynuyf
 b0f8e03k7nN8cegqwi2umv4fNJTPKdrihfPUwDnI47ipGB4e7Bz6prs9y9xOYibk6Nf8
 Hl8vYBPzcSiwU35aE+8CBKf4zAyknFllm5+u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768920736; x=1769525536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xLPHpmT//415y6uqk9ePeDGGZwS41sDwkYlfxOmVIY=;
 b=Uvne7AAujEkUcRbeynu1hD0o3+19ydiZ/S3Q5+pXKPp/3Jcp+8hFfk02z7dGkDQmeW
 bP0Lnyv4Kwt3v3L2oVouLr13zA4E5cngZOmeNqucmksDOxQVcjxXmiXJRairN4ydsYf4
 ilk7D1TUQXrB7Pb0w4pVvY4/wSbxiaKC31rvK+J1YtCnC6NeqKBNff8IRlweVtMRJvoe
 2YD94OXdxtVPwpRK3tYOT1xs4kIJ48vTKbqrGljfmAyqjYmRVgPEy2mXh+CebdE86ZlH
 LbCvxhDkQqi6x3mMktFoN8wa2fCFByN2LyGWdhbUWDONmEKU8f3okFaSK7WhKLLU3MKt
 nrLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Y3TwvN7LBBsIwa1bpB/RG2jSRTyTdhmL2N7aWWKspCeFT5wno90cD35oOtnf9IWTkxiYBP4=@lists.denx.de
X-Gm-Message-State: AOJu0YwPEhGbqHtTWRPRW51+VIBe5WEYSSLRvEUts8EVqT9dpJOsnjQZ
 Ve2VUFwX7BAYEouUu7/uGH8hWkBYAE62CbjpqgUl19+YYTsUDUTF1WHx6DYZeIJ8BQo=
X-Gm-Gg: AY/fxX6mn1Yd5A6ZFuseIBrIW3HOLFepBsx9IeioeRAVQamq3le4gTiNlg3uj01GzoQ
 FJMvzX6fnDGK70LAe8ymHzqlfMGkMe1wEjtsinxYH0b8X2rdcW76/Hq3AhyPuxZUGzsaDkvWuzi
 Rp/cuWEXzKFEy/OKSS3j/Q436S8F9ZA5T+o+E0KumTqCiTkHDSdB7TOL3abIx8oL2oNBEN6c8cm
 ITl4voOtOMz9VtjaIOIX1RhQlmuH8XaSuSC3sGQrkx2PxPFKkmKVuzhR+68Hk6DLCQvcDK9JSj2
 U/PxZ2KJJEnTUjSFbif6IuRzdwWgRlOKSlXWYcXlJyCynFmUkcXA0GziKASI77/xjcKjMHLgoyN
 YZ5Fj85imhDtzrkXElVdKP25cAoT+CwVjyrWVIAtg3kii4CNQfVAGKC9MBuggKdajGsUB1wcxc8
 QYjkwYMvnpJq+7yhxjtYFGizGqgwDjrCedZJzU5E7cnX2AnMTzBEzJNDrIsCetSGd/Pw6dEsRNx
 kezzOB6DHVQx1IfdGNm+xlPEZtK8xl5pt2z+Z8=
X-Received: by 2002:a05:6808:191e:b0:459:b412:e728 with SMTP id
 5614622812f47-45c9bfc6a39mr5893713b6e.17.1768920735896; 
 Tue, 20 Jan 2026 06:52:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9dff95a2sm6950283b6e.11.2026.01.20.06.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:52:15 -0800 (PST)
Date: Tue, 20 Jan 2026 08:52:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Frank Wunderlich <linux@fw-web.de>,
 Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v4] cmd: mem: add function for getting ram size for use
 in scripts
Message-ID: <20260120145213.GK3416603@bill-the-cat>
References: <20260118105021.19760-1-linux@fw-web.de>
 <7906ae57-4700-48fd-8740-66b8626640f1@cherry.de>
 <1CBAB275-C7DD-4E52-87D8-B648BE9A4981@fw-web.de>
 <585f12d6-4d4e-46b3-ab52-049adf7d216e@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DwfFDfegJQx9ltuS"
Content-Disposition: inline
In-Reply-To: <585f12d6-4d4e-46b3-ab52-049adf7d216e@cherry.de>
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


--DwfFDfegJQx9ltuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 01:47:00PM +0100, Quentin Schulz wrote:
> Hi Frank,
>=20
> On 1/20/26 1:09 PM, Frank Wunderlich wrote:
> > Hi
> >=20
> > Thank you for your review
> >=20
> > Am 19. Januar 2026 11:22:07 MEZ schrieb Quentin Schulz <quentin.schulz@=
cherry.de>:
> > > Hi Frank,
> > >=20
> > > On 1/18/26 11:50 AM, Frank Wunderlich wrote:
>=20
> [...]
>=20
> > > Otherwise I see a few issues:
> > > - rounding not made explicit, (also it's truncating and not rounding =
I believe here?). Why not print the actual value here as a float (of course=
, not using floats)? I vaguely remember some of my Rockchip board printing =
1.5GiB when booting up (cannot verify because this happens due to a bug in =
the SDRAM init and isn't easily reproducible). We do have some boards with =
256, 512MiB of RAM so we should be clear whether we are printing 0 or 0.25 =
since that will influence how to do math operations with the variable conta=
ining the value.
> >=20
> > I have dropped my previous round because it leads to wrong values and i=
 wanted to avoid floating point numbers. But yes 2 decimal digits seem to b=
e needed to give correct output. I guess var is then string,not any floatin=
g point type.
> >=20
> > So for GB sonething like this:
> >=20
> > u64 ram_gb_x100 =3D GB_X100(gd->ram_size);
> > char buf[16];
> >=20
> > snprintf(buf, sizeof(buf), "%llu.%02llu",
> >           ram_gb_x100 / 100,
> >           ram_gb_x100 % 100);
> >=20
> > env_set("ram_size_gb", buf);
> >=20
>=20
> I believe we should be using GiB and MiB, so multiples of 1024, which mak=
es
> the part after the dot more cumbersome to calculate.
>=20
> Likely something like
>=20
> gib_per =3D (gd->ram_size % SZ_1G) * 1000 / 1024
> gib =3D gd->ram_size / SZ_1G
>=20
> This should give us
>=20
> 250
> 1
>=20
> for 1280MiB for example (1.250GiB). Still.. that would truncate at the MiB
> level (but is there really DRAM chips which aren't multiples of 1MiB???).
>=20
> I'm not sure this is worth it, especially since that would make the varia=
ble
> a string and I don't think string comparisons are appropriate for compari=
ng
> two numbers :)
>=20
> We just need to make it explicit that the value is truncated.
>=20
> > > - what if I want to save the byte size in a variable? With the curren=
t implementation, only mebibyte or gibibyte sizes can be stored. I would su=
ggest to argc-- if m or g is passed, and then compare against argc > 1 in w=
hich case you'd use this third (in case m or g is passed) or second (if the=
y aren't) argument to store the value.
> >=20
> > Good idea, thinking about how to implement this the correct way :) as v=
arname could be "g" or "b" too.
> >=20
>=20
> You could also force the use of the first argument to be able to dump to a
> variable.
>=20
> memsize
> memsize b|m|g [varname]
>=20
> memsize would be an alias to memsize b.
> memsize b var stores the byte size in var.
> memsize m var stores the (truncated) mebibyte size in var.
> memsize g var stores the (truncated) gibibyte size in var.
>=20
> You could also decide the prefix your size argument with a dash and if no
> argument with a dash is passed, it means it's a variable name and the
> default is in byte size.
>=20
> > > - missing documentation on the base for the environment variable. We =
have some commands setting hex digits in variables, some others in decimal,=
 so this needs to be made explicit so that people know if they need to tran=
slate stuff before using it (or how to compare two numbers against each oth=
er). Here it's decimal according to the code (maybe we should have it in he=
x instead? I am not sure what is the expected base for variables :/).
> >=20
> > As i want to use it in scripts to choose correct bl2 file for bananapi =
r4. Imho decimal is better to read here,but it should be mentioned in doc.
> >=20
>=20
> OK. Considering test
> (https://docs.u-boot.org/en/latest/usage/cmd/test.html#numbers) compares
> numbers assuming they're decimal if they don't start with 0x, this is fine
> to do (we would need to prefix the number with 0x if we were to store it =
as
> an hex value).
>=20
> Can you tell us more about the initial issue and how you plan on fixing it
> here?
>=20
> That sounds like a board file (board/....) would be potentially more
> appropriate for this? What is this bl2, why does it need to be different
> based on DRAM size, isn't there anyway for U-boot to pass the DRAM size to
> bl2 and only have one bl2 binary for example?
>=20
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +#endif /* CONFIG_CMD_MEMSIZE */
> > > > +
> > > >    #ifdef CONFIG_CMD_MEMTEST
> > > >    static ulong mem_test_alt(volatile ulong *buf, ulong start_addr,=
 ulong end_addr,
> > > >    			  volatile ulong *dummy)
> > > > @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
> > > >    );
> > > >    #endif /* CONFIG_LOOPW */
> > > >    +#ifdef CONFIG_CMD_MEMSIZE
> > > > +U_BOOT_CMD(
> > > > +	msize,	3,	1,	do_mem_size,
> > > > +	"get detected ram size, optional set env variable with value",
> > > > +	"[m, g] [envvar]"
> > >=20
> > > Explain m and g so the user knows when typing help msize.
> > >=20
> > > We need tests in test/cmd/ and a new entry in doc/usage/cmd/ for this=
 new command.
> >=20
> > I see this note in checkpatch,but as i rely on dynamic value and i saw =
no test for mem yet.
> >=20
>=20
> There's one for meminfo, but honestly I'm not sure it's a test that makes
> sense (just checking whether some fixed strings are printed and not
> associated values that are printed afterwards). I haven't written a C unit
> test in U-Boot so far so won't be able to help there. But we really do wa=
nt
> docs in doc/usage/cmd for any new command.

Docs are always valuable, tests are sometimes valuable.

--=20
Tom

--DwfFDfegJQx9ltuS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW+WmQAKCRAr4qD1Cr/k
Cmw/AP4rgYDs61xX5Ton7fFPbvptrii+cgr+XHWd55YXQ1WQpwEA7+xTtuD+vnUl
t0xnR/6y+csZ99pZt4xKEvo5TL9AUAw=
=jOKC
-----END PGP SIGNATURE-----

--DwfFDfegJQx9ltuS--
