Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E07D3B7F3
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 15:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A06C8392C;
	Mon,  8 Dec 2025 16:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OEktSO2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4AC283946; Mon,  8 Dec 2025 16:38:58 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5BE835FD
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 16:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so3420533a34.1
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 07:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765208335; x=1765813135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yd/P8FEPpSXIiJHJWNlwY83eLwgrLfKzZkimXEUtTFo=;
 b=OEktSO2EhXBat8BAmM3wLqQgrTv1OzQJe6OeIUwO2/Q4QuSdyU3sQkGgzaa4jqGTQy
 OvboKW5BEnpZPMMYUt23lCFAJOSnqu5HGoPp0jbw8fr6dc3n3sCOXoaV+lN9Qr0ySHHq
 /GDQmdz+XWqzRkhZJFecAJvJUCIIlSA/8KqDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765208335; x=1765813135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yd/P8FEPpSXIiJHJWNlwY83eLwgrLfKzZkimXEUtTFo=;
 b=kNRca5LatY2GriAmB+/KRpQoAu0WKyX2s17VDouu301euiUqov9fAvzxrQZ87ek5JG
 tmzW2LvxUGtsFcnyg+iods9SnZdkIsOOiHycMGPGa86fUJcdP+BITwa24TKewY54yZyO
 CJKeuarxke1qUuX2QWSP7f+1ALPLdSV4NAksGj3jXULZrbnRPrNXxg7SQPtcZLPh//us
 4zW8kZevLOlDX/Bg6sL/fp/u+5N+FcCbGVzuMIaTmi1HWYcW+sWe0hWhW7HWn5mjAIoA
 U0dYvUiu+Uu6Xfv5xPm+ziI/8BtSLvN8n2SR3OwaQG5cCh7Tr8R7JggjFgVG9ZcZ2lw3
 x4+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVoyk8ZvEYS2NRM8i/h5ejilwlD3eklTIWb8ehoREGJzOAiSx/rf+0vwLTYSP1SpdlDbEW8u4=@lists.denx.de
X-Gm-Message-State: AOJu0YxlV9pGb3k5Y85pULgBrn2A7HNRhT3ylvAYhtFWapbWLkzlr+oh
 5uYzuddeCt3si9DxHuSfo4UcbHIbltY915V8q/nQIVsZh9JidvQiLQygRzqa3ZgCXwA=
X-Gm-Gg: ASbGncsL0cpPtxB01mEDUEjyVIaMw9/sb37eStutsrgGt8e3StKO/+Ix0s1tijriPk3
 TkdbrXCqymBzN4A22H0uB2y9kjHGI/keIy39QOo3ZRusvK+Wt19xEopi237QYwP5oRnJyd/9gKw
 erljwxydehLWOFff9fU85ip7Z7drUUh1YxInYaKkTH6lL5uGlmmYF2W5ZN47b8GUU8Id64OPWPc
 oCdc7yQ1zO2IjIy90fdth6G8Zj1rROoelRiHz5Z1fQiQ8R4yR/6XSJpORre4KG+F3VPkdAtyjjE
 bM4tJCf9K9nAPl4rtdmwliayfojK+EDB4Vh+XK6rDUQo7sqh8iL+qEIkBrYRJ5s+HTgUCY5XZtR
 7o8/Ui7kUnEUYxLIuVm9Z47lEiVyxWXoeK/kKvMoE4E/s5hpNfyvj5UHuhlmRL0/qDcGJAY51v0
 Or6qm85o+bbnVFltHzJ8tHtePxhKgNZIap2j6mqlQZD2Itq0AhiA==
X-Google-Smtp-Source: AGHT+IFDhjb9DpqP0DCsia4Y0I8gpr91x7hvM86htfHv0gkp8wCkuPsO9am8e9sjVKWDtSb9TlUjHQ==
X-Received: by 2002:a05:6830:254b:b0:7c9:5b7c:8a33 with SMTP id
 46e09a7af769-7c97080bf92mr4977001a34.19.1765208335097; 
 Mon, 08 Dec 2025 07:38:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acaf826sm9886274a34.22.2025.12.08.07.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 07:38:54 -0800 (PST)
Date: Mon, 8 Dec 2025 09:38:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Message-ID: <20251208153852.GP303283@bill-the-cat>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
 <20251208153226.moktyjv3irmjlg6q@lingo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cHDg7ZRmHjK5ofms"
Content-Disposition: inline
In-Reply-To: <20251208153226.moktyjv3irmjlg6q@lingo>
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


--cHDg7ZRmHjK5ofms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 09:32:26AM -0600, Nishanth Menon wrote:
> On 08:10-20251206, Tom Rini wrote:
> > On Fri, 21 Nov 2025 17:34:30 +0000, Andrew Goodbody wrote:
> >=20
> > > Smatch reported an error where a value calculated by ERR_PTR was not
> > > used. Fixing this to return the generated value led to a test failure
> > > which meant updating the sandbox clock code so that it would still ca=
use
> > > the tests to pass with the above correction.
> > > Debugging this problem led to a SIGSEGV which is addressed in 1/3.
> > > Possible memory leaks noticed are addressed in 3/3.
> > >=20
> > > [...]
> >=20
> > Applied to u-boot/next, thanks!
> >=20
> > [1/3] clk: Prevent SIGSEGV on debug
> >       commit: 1c0a46e2918a1ddf42f51449e45077513dd52417
> > [2/3] clk: Return value calculated by ERR_PTR
> >       commit: fe780310cfa8bf5a093894b5cd7fe85c6b02fd91
>=20
> This commit seems to have broken TI platforms in next branch.
>=20
> u-boot$ git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [bc1819331ece7aa4e7d0573c9cdacdb8efbdb067] Merge patch series "clk=
: Return value calculated by ERR_PTR"
> git bisect bad bc1819331ece7aa4e7d0573c9cdacdb8efbdb067
> # status: waiting for good commit(s), bad commit known
> # good: [384d3785df4dbe452f9fbb4bd9c9c9e986cdc205] Merge patch series "le=
d: remove unused legacy LED code"
> git bisect good 384d3785df4dbe452f9fbb4bd9c9c9e986cdc205
> # good: [1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc] board: ti: CAT24C256WI=
-GT3 require min. 5ms delay (tWR) between write/read
> git bisect good 1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc
> # good: [1165e8efcba0ab3efd1ea4ff956d26746fc386b0] reboot-mode: Correct m=
acro name from U_BOOT_DEVICE to U_BOOT_DRVINFO
> git bisect good 1165e8efcba0ab3efd1ea4ff956d26746fc386b0
> # bad: [fe780310cfa8bf5a093894b5cd7fe85c6b02fd91] clk: Return value calcu=
lated by ERR_PTR
> git bisect bad fe780310cfa8bf5a093894b5cd7fe85c6b02fd91
> # good: [1c0a46e2918a1ddf42f51449e45077513dd52417] clk: Prevent SIGSEGV o=
n debug
> git bisect good 1c0a46e2918a1ddf42f51449e45077513dd52417
> # first bad commit: [fe780310cfa8bf5a093894b5cd7fe85c6b02fd91] clk: Retur=
n value calculated by ERR_PTR
>=20
> Confirmed by reverting the commit. Looks like
> 9ed8fafbcde3425d8817ec5953edd428c7508153 revert is needed again?

Interesting, OK. What Andrew did in commit
fe780310cfa8bf5a093894b5cd7fe85c6b02fd91 is more complex than before and
there's two stanzas there. Our lab is current being re-worked again
right now so I can't test on the K3 platforms I have, but can you please
see which of the two changes in clk-uclass.c is the one that breaks
these platforms? Thanks!

--=20
Tom

--cHDg7ZRmHjK5ofms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTbxCAAKCRAr4qD1Cr/k
Ch64AQCz9CZBY/M8oYBOqHG+CXTVLDk1xwlpQSCfmA5pzjMrqAEA9AP9axTdKg6n
FIwFzhWKbFU7hpU4f8Q8OwDvl1Df5A0=
=miU0
-----END PGP SIGNATURE-----

--cHDg7ZRmHjK5ofms--
