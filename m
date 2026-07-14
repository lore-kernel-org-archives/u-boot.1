Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5770BC4450A
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CC3C84D42;
	Tue, 14 Jul 2026 19:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NoszArSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B011D84D45; Tue, 14 Jul 2026 19:20:23 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 747FC84D22
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a384e29a20so2990583eaf.1
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784049620; x=1784654420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FFdj9YYy/dr6XqZFpITWFZxCP8zcnHb5dgN9I3nYvdk=;
 b=NoszArStlIPZhd1Cg+mQukvul6GLYNapoG6pQ5EYObyxdpR7VlXFMaJ9nxxE7Gn2aR
 +OijBnX4nUQx5qzobkGNBaZt6TSnbh4pV47WG2Nxv5rfBH+YZ5Z7+wfiEv6GydCFsEgQ
 JC+ERpY2a5elEoVeTF/PS09g2uBJWrC5tcTsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784049620; x=1784654420;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FFdj9YYy/dr6XqZFpITWFZxCP8zcnHb5dgN9I3nYvdk=;
 b=JSLaTfbIqkp06Hze49yei0nU4HfTblYIaaEIEzktlrtlc1Y/EYp9FqPCUUcfMeoyB6
 t/s2nyGtpbwvZL0ZAqFoArcXVJKDb4Y1qGbsxcgO5Fs8LP2L50LumPTOyRIBRUWFJNBt
 FWrM4cqeA+7bqdkZ3wXW49CNF3ZrZJ0+yACtdN2ixpf0qbu+lAOj9QQ6r9QipgJNzj+i
 SsI0rakf8hkd5IJTvMhwQ13m6oxdEfTrafytpCUnYK9tpyrAVRlvjw9LNS1O7qqoQUY/
 nx5GdBgBAqSMGoL0Fnm/MiX+A0b1rR/FHduH4l00mwwe4o+aiDNQqzH8UiAC+6yVWrxP
 OPQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8StchTWTh9axsw3FM+6aT5kqNEOnHc79D6Z3iMk9IZPSMNNNKDcp1+Sr5kCxiigkUta1dpoLo=@lists.denx.de
X-Gm-Message-State: AOJu0YxgNY5R9h/jcoGInEkhNWbh4N4ZQiN7/+cYkLJLRtXIYR2X/hRB
 a1ReNY5G1VdCPwmNhSGJlcvhR+T6i8rHD1gDpChp+1ykXur07Ce62fj5GG+zJxj6No6pihgChiu
 hqljNiWA=
X-Gm-Gg: AfdE7ckPtT6ZP161NkbICryjRZasXQmxOY3eQ9XCA7wbpY2vrKWcidlGOntEUzGRk63
 V5wcu/wn5Zd04XqRZ7oSl4/ynOlmsbL1gHR4mnZGi9582BL2QsmwQwmQeb1s8q4MBNgap102VOa
 ZauSiBgzBuisUi7uW4S+YKBAWa1C3quwRRp2SUFyZSCXd1MEt+a7RENLq/0CuFHhd7BbtR7vXl/
 knYPTP6V7mEoGVJpnJ/tLKzCPdTSRqgG09jC//kwQkbSUW4zCKhg3Q6O5wUMlXpVGV6rvtbzyJ+
 kwMw/Iz/jk/YA+in8tLDcbfy/4jwntvIir3GCFnh6XyxP5SCfcf7IP2rmvbeoODYQDJQCsM62+z
 yezQFEQPsnRMSNDKdbREmjw9+9YL2ItMEGc8RToDVzNNrwKq9IQxwfWchhBVDF1HYuicLHcWUM1
 Afx2fLv5xzCeAesvBIP/1XAWFJ/re6UsSS7pqHBvrRK/Cbwfpy0WmKpEIZJmlmNqq8tavAFW/aV
 DZbKI3Tb6kMcVpu8pl541PlnMGgbOcOJYmnBw==
X-Received: by 2002:a05:6820:2011:b0:6a3:1e40:6329 with SMTP id
 006d021491bc7-6a3c60083ccmr3036920eaf.13.1784049620065; 
 Tue, 14 Jul 2026 10:20:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39a4a7797sm7258279eaf.6.2026.07.14.10.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 10:20:19 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:20:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 11/16] LoongArch: Generic CPU type
Message-ID: <20260714172017.GC749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-12-me@ziyao.cc>
 <20260701175503.GR749385@bill-the-cat> <alZs9GZgBGI91_EB@pie>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BC4JSb3usITb1Meo"
Content-Disposition: inline
In-Reply-To: <alZs9GZgBGI91_EB@pie>
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


--BC4JSb3usITb1Meo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 05:08:04PM +0000, Yao Zi wrote:
> On Wed, Jul 01, 2026 at 11:55:03AM -0600, Tom Rini wrote:
> > On Wed, Jul 01, 2026 at 11:18:03AM +0000, Yao Zi wrote:
> > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > >=20
> > > Provide a generic CPU type with some common routines
> > > that expected to be implemented at CPU level.
> > >=20
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > ---
> > >=20
> > > (No changes from v1)
> > >=20
> > >  arch/loongarch/Kconfig              |  1 +
> > >  arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
> > >  arch/loongarch/cpu/generic/Makefile |  7 +++++++
> > >  arch/loongarch/cpu/generic/cpu.c    | 22 ++++++++++++++++++++++
> > >  arch/loongarch/cpu/generic/dram.c   | 21 +++++++++++++++++++++
> > >  5 files changed, 64 insertions(+)
> > >  create mode 100644 arch/loongarch/cpu/generic/Kconfig
> > >  create mode 100644 arch/loongarch/cpu/generic/Makefile
> > >  create mode 100644 arch/loongarch/cpu/generic/cpu.c
> > >  create mode 100644 arch/loongarch/cpu/generic/dram.c
> > >=20
> > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > index 109d37d8e2c7..5254afb2cd05 100644
> > > --- a/arch/loongarch/Kconfig
> > > +++ b/arch/loongarch/Kconfig
> > > @@ -12,6 +12,7 @@ endchoice
> > >  # board-specific options below
> > > =20
> > >  # platform-specific options below
> > > +source "arch/loongarch/cpu/generic/Kconfig"
> > > =20
> > >  # architecture-specific options below
> > >  choice
> > > diff --git a/arch/loongarch/cpu/generic/Kconfig b/arch/loongarch/cpu/=
generic/Kconfig
> > > new file mode 100644
> > > index 000000000000..ac7556d6d4d0
> > > --- /dev/null
> > > +++ b/arch/loongarch/cpu/generic/Kconfig
> > > @@ -0,0 +1,13 @@
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +#
> > > +# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
> > > +#
> > > +
> > > +config GENERIC_LOONGARCH
> > > +	bool
> > > +	select SYS_CACHE_SHIFT_6
> > > +	imply CPU
> > > +	imply CPU_LOONGARCH
> > > +	imply LOONGARCH_TIMER
> > > +	imply CMD_CPU
> >=20
> > Which of these "imply" values can ever really be turned off? CMD_CPU?
> > Yes, others, I don't know.
>=20
> CPU* are all optional, but to turn them off, we must also turn off
> DISPLAY_CPUINFO, which is broken without CONFIG_CPU since the
> implementation of print_cpuinfo() is guarded by CONFIG_IS_ENABLED(CPU).
> I think we should reflect the dependency in Kconfig?

So if you're using the CPU driver model implementation, then you should
have:
	select CPU if DISPLAY_CPUINFO
to cover that.

> For LOONGARCH_TIMER, it's necessary for delay functions to operate, but
> if a platform makes use of a non-standard in-core timer implementation
> in the future, being able to turn LOONGARCH_TIMER off in the board
> configuration might help in code size. But I don't have a strong opinion
> for this.

OK, this seems like the kind of thing to handle if or when the use case
comes up. Until such a core exists we don't know what other assumptions
it will invalidate.

--=20
Tom

--BC4JSb3usITb1Meo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalZvzQAKCRAr4qD1Cr/k
CkLnAQCCSPd0ukZIoHAYxCe9mt0cdo1oNsxBAsWmmtJpByKzNQD/V3nTgZSr9YCv
PEUPp92BSeWZ6o9IdFReFGKoqpcYzQI=
=0SIK
-----END PGP SIGNATURE-----

--BC4JSb3usITb1Meo--
