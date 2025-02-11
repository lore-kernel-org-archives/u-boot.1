Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBBFC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 21:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C18680BAA;
	Tue, 11 Feb 2025 22:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="didQxv5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C7C80BAD; Tue, 11 Feb 2025 22:22:30 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 965F280A55
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 22:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f9d627b5fbso11442787a91.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 13:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739308946; x=1739913746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k9oc95J+ovHWFXXmsPyNTz4ViwZHo+1EAzZyPPUOQ9k=;
 b=didQxv5Sf/QR4mGRU8QX/1lT6tXUapUXCRgC4KWXY/IidXSaRYKVdU22Ex4bxCIfKA
 SzmKpnZPFZde9j/dy7KjKi/1tY12M8nAuMIZfQT5K8annidZ43bcOv3RvBgBdiZvnPeS
 2dI6Hi5Bh3LjMQQKlvBGeKbdiVDJgzyVt3nI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739308946; x=1739913746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9oc95J+ovHWFXXmsPyNTz4ViwZHo+1EAzZyPPUOQ9k=;
 b=YzuyS36X5jrUGAO0X+Cb+n1tUnQY4BZcSbDKJHW5CaprAmp6oviM3gZe1GtIrzzf+W
 5eTo7UNWQOIeVFTJPhcAU3s2cDuW1S963x5T5gn2jCoqw8ArukiTR2s3GmMya3GX68El
 IiRVotFZesfvBTVfkX5GV0pqSb3Bp2RIHN5I0vMQjhR0N+nZjOdwoiaGlh26/DQruu+L
 UHldcXXzqw5liN4LnIZqdAfqhk1lGt2bjqqG+MUITLVp4QmadUp0lt9KHOzvxD2g6hRA
 5ZLsAPUfVztkm9eOAE6D75M1F2zBktHdAwmKtMBcxOrMbhgKKRY4i46LVoDVGwPOVMy1
 BVSw==
X-Gm-Message-State: AOJu0Yxv4VteQD1ISTZ7Vs8qni1/5rUBXQfp3C3/jRrscJRGSHgguJwc
 yx9PRbgf12ve5LrfJkvS3b3tmRdgbjKqW3cz7s2Zddzq62oO8eNHydpfJrWbkIA=
X-Gm-Gg: ASbGnctsOqADgi4zegOvsWcTlsDLbK8xyJLFTMimcznrmlcH78Lnh1k+W8rhqNyYplw
 6T7hoOZomTtSxE928kBJIpeBgq+rMiKVaWH1q8S+jzvGcAN5mGzz1lWTB4jy0u4Uc7eKa2Q7/VU
 bqm1b7sK5cYH2nHFXD5F0iXiuHpmu8bGHd5sUu0UJrfK0ZPdsqgBkLUVYZABh0SnWfcyJUEd1nJ
 r/g/0bHu7CCCqocJ5tNhD1wvEaMMc9rYSllEz6xe2H42NwiauqoU5KBCqwCa1sVXvTTL7OfC1+0
 6YxRYpz09cdMfKk=
X-Google-Smtp-Source: AGHT+IG9xPeX8pkkyIVit7Dbtc7IVZG8Lfh11+smzd5msDbpis1Df2Kji/F39BTbikE/xdRawD/RLA==
X-Received: by 2002:a05:6a00:3d46:b0:732:2793:6b65 with SMTP id
 d2e1a72fcca58-7322c3df8ccmr881982b3a.15.1739308946022; 
 Tue, 11 Feb 2025 13:22:26 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73083999abasm5329957b3a.10.2025.02.11.13.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 13:22:25 -0800 (PST)
Date: Tue, 11 Feb 2025 15:22:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250211212222.GH1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VzWcoJiLjl1Hyn7J"
Content-Disposition: inline
In-Reply-To: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
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


--VzWcoJiLjl1Hyn7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> Hi,
>=20
> I just wanted to send a note to (re-)introduce my ideas[1] for the
> next iteration of xPL.
>=20
> A recent series introduced 'xPL' as the name for the various
> pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> still use filenames and function naming which uses 'spl', but could
> potentially adjust that.
>=20
> The major remaining problem IMO is that it is quite tricky and
> expensive (in terms of time) to add a new phase. We also have some
> medium-sized problems:
>=20
> a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> can be confusing, particularly when combined with ifdef and ifneq
>=20
> b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> different things. For any given option, some code uses one and some
> the other, depending on what problems people have met along the way.
>=20
> c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> the option is enabled in one or more xPL phases, or just in U-Boot
> proper. The only way to know is to look for $(PHASE_) etc. in the
> Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> and has not scaled well.
>=20
> d. We need to retain an important feature: options from different
> phases can depend on each other. As an example, we might want to
> enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> may also want to share values between phases, such as TEXT_BASE. We
> can do this easily today, just by adding Kconfig rules.

I agree with a through c and for d there are likely some cases even if
I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
important as the other ones.

> Proposal
>=20
> 1. Adjust kconf to generate separate autoconf.h files for each phase.
> These contain the values for each Kconfig option for that phase. For
> example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
>=20
> 2. Add a file to resolve the ambiguity in (c) above, listing the
> Kconfig options which should not be enabled/valid in any xPL build.
> There are around 200 of these.
>=20
> 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> useful in rare cases. This indicates that the option applies only to
> U-Boot proper and is not defined in any xPL build. It is analogous to
> CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> needed at present, basically to allow access to the value for another
> phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> the address to which U-Boot should be loaded.
>=20
> 4. There is no change to the existing defconfig files, or 'make
> menuconfig', which works just as today, including dependencies between
> options across all phases.
>=20
> 5. (next) Expand the Kconfig language[2] to support declaring phases
> (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> declared once for any/all phases. We can then drop the file in 2
> above.
>=20
> With this, maintaining Kconfig options, Makefiles and adding a new
> phase should be considerably easier.

I think this will not make our life easier, it will make things harder.

I think what we've reached now shows that Yamada-san was correct at the
time in saying that we were going down the wrong path with how we
handled SPL/TPL.

My request instead is:
- Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
  DM_MMC) as a prefix.
- Likely need to introduce a PPL symbol as you suggest.
- Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
- Split something like rockpro64-rk3399_defconfig in to
  rockpro64-rk3399_ppl_defconfig
  rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
  and add Makefile logic such that for X_defconfig as a build target but
  not configs/X_defconfig not existing, we see if any of
  configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
  subdirectories of our object directory, and then using binman combine
  as needed.
  - Maybe instead the Makefile logic above we would parse X_defconfig
    and see if it's a different format of say PHASE:file to make it
    easier to say share a single TPL config with all rk3399, have a few
    common SPL configs and then just a board specific PPL.

This solves (a) by removing them entirely. This solves (b) by removing
the ambiguity entirely (it will be enabled or not). As a bonus for (b)
we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
Linux Kernel again. This solves (c) again by removing it entirely.

--=20
Tom

--VzWcoJiLjl1Hyn7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerv4sACgkQFHw5/5Y0
tyzQIgv8DYMN6X+sjSTkW+WtO5IuWNyRx6OCNddvPUpe98GUiWv9JnXoC/8nJ4mm
T9TFq6aijZCGbfYCDvIHErgn+iZY7uwVD3x5l4b57Nj8Olj4X4iJVGtsodfmO7Uz
uBUBklzOUORYlJvPU/rL9x+ggZInksFGL8GKHi2+jXdXyyjRIhSCykF1BdL/DtLw
4iPfsh0yY/rNEZp1fBER50xCRB5SZS6/1rhmhTZy2KSY1YmI7tLPsWffv6uafkDK
JP3gkdpS/8apR/96f1khvLcMgxL7smXC067547uiSdLctGNfb5U1fvtJc8NaH/Wf
EERjN+wineC2Zw8aokxHtT4C3M5yVPU0rNw7mlpXYH+cFQ88WcNapYk3aF4n5zoQ
6LH7FUVwbU2Q9L1JSChoaCki6GcHORwH6yIqu0CQlMePAdiYjOea79QsveYqTVU0
QLm+rltr1tAoaftkCnxcmi/rPlLAtFzVZSoqebqge8cYRboa/bq095/zz6RHk82T
3gzybV+4
=4Aav
-----END PGP SIGNATURE-----

--VzWcoJiLjl1Hyn7J--
