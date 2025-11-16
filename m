Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EA7CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19DCC8398C;
	Sun, 16 Nov 2025 15:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QTs+B79O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BEDF8398C; Sun, 16 Nov 2025 15:11:58 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F2A83979
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-44fff8c46bbso789177b6e.1
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763302314; x=1763907114; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Lv+0DLqgB/sKzcdH3ceq1+zQVLE70PdteBL5QYg5Eho=;
 b=QTs+B79O/WIdny/TiW/10SMcsTSEZoZJpBbKYxzGEZZWawuGstbblYwE2WcBkM2QM4
 XnL4JODTC6Wn4dgH9cYsncSBf5ameX8hIMssWhacM//Uxd6Lg3yCSao9hp5zDW2rcqiS
 lR9eb3u7TRT9Gnfp2MHEfJzC6RTWFRDlDSLmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763302314; x=1763907114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lv+0DLqgB/sKzcdH3ceq1+zQVLE70PdteBL5QYg5Eho=;
 b=DHrmm57Meh39TER42Diar3HQvqCaHFzSdO3wnoLpC15g9f5xs1S6cKgna5ZuiteERs
 g+iCNRqzZPdHDzTb1ziBmiDPgyrGbfkbOayZOaOET8WFOsi8qo1fvijy5RbL9bPDEozI
 IQmvOofllLthxRVyc3TxhACAgierpHb/t0umKiFS1UJtIk6+R0DxADkA+msJTO3rDZpN
 o85GlJAOt35Z/UJ3G6u844bQ7U664nHhq67+GED3kiJ39RcWP3bJM7yBur3RVPcQWhE+
 fapbxv8WFJwPfJ8YPcOjmENsOy8LBD8bGZz6ZUm7DbDjEO1T/hx5u6CACpxX41wsmbSU
 I9VQ==
X-Gm-Message-State: AOJu0Yyc/RTA7z5l742VBBy3Zr2ROlTdJXkveCN2y2PwSkCcf1rUN3oz
 E/vPfEQzKjVbDlDrV0epsXD4IqmqhwIdEqDvLOJCb9nqHFiKa393BBwXRYFlGDf7vBc=
X-Gm-Gg: ASbGncs8DJBCq6wVfKnUJvDoh2NGs/NzPlqogjUMjsV29Lei+b4ioQYDd03R7fadn2A
 aytAzrQHIFbpexXPnDK2Ro3Tq174NWBQqPJL8pFdNd0Jimcp12hoGsYBYY/QPQUVze3nilgZhPN
 Aqh26l7OhnbWAVlV3KiJW45TILf5YMvvX0rCtN5L4LJ5MyKE2AEiF9SRMejlaDdhK+f3B11Do55
 aBXqUgGneZbs6TkJ5VfnIiZD7Zd1PDxIHCgZIEsWiHZoSWm+RP4Ds6DF7gRofszhSsEe/TkWkg9
 snidl6SOpStekWLAYp9r3bafSPYDeDPrCdrq3r6ZlW+affd0Nih0VLpJL+SlN5Xa4wGAHa7qHZX
 Ots7zlSf2/qQBDQMH/Z2M14U5KHOzB9w+mUvpBt+Y0yv77ukUdcOiElY8yoYkhCIlNqyhmdWRLV
 XB8iLPLdcNAx5ZUH9JuWzoenGkN62EC/6aulbpKyRg+iJFOlnIcQ==
X-Google-Smtp-Source: AGHT+IGrMhHJVeMUCqOJRUrpjqerYx9YqFaL9UaG3IZfxNLRJTbZDbpZSTT3LEIrZn+8u1aBNIS00g==
X-Received: by 2002:a05:6808:320b:b0:450:c58d:8c3a with SMTP id
 5614622812f47-450c58d8da8mr389309b6e.46.1763302314703; 
 Sun, 16 Nov 2025 06:11:54 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e88a0fc8a7sm1613262fac.7.2025.11.16.06.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 06:11:53 -0800 (PST)
Date: Sun, 16 Nov 2025 08:11:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
Message-ID: <20251116141151.GC2125796@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
 <20251113184917.GN6688@bill-the-cat>
 <71261c83-0a3e-46b6-a0db-d3587a54d71c@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2k4dwmR+To9QD8a+"
Content-Disposition: inline
In-Reply-To: <71261c83-0a3e-46b6-a0db-d3587a54d71c@mailbox.org>
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


--2k4dwmR+To9QD8a+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 12:23:30AM +0100, Marek Vasut wrote:
> On 11/13/25 7:49 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > CI does show that no boards went oversize . If there is some growth on
> > > existing devices, maybe we can shrink that, but maintaining obsolete =
DTC
> > > code base going forward and picking random updates into it, that will=
 only
> > > lead to increasing maintenance pain, so I don't want to do that.
> >=20
> > Yeah, it's not an easy spot. But I'm really not happy with growing main
> > U-Boot almost everywhere by 2KiB - 4KiB, and SPL by ~512 bytes or more
> > just to keep up. I do see that integratorcp_cm1136 barely grows at all,
> > so maybe there's something that can be done more widely and just wasn't
> > clear at first. m68k only grows an average of 500 bytes and MIPS is
> > ~1KiB. PowerPC grows a lot. RISC-V a little.
> I suspect this might have to do with DTO support. The imx8mp_dhcom do use
> DTOs and the fdt_overlay.c code grew a lot.
>=20
> I also found out that if I patch out can_assume() and replace it with pla=
in
> 1 , then the size drops by 1-2 kiB, but that's probably not what we want =
to
> do.

I'm not sure, maybe we do? Or maybe we need to look and have *one* place
that confirms correct alignment and either fixes/complains, and then
every follow-up location doesn't need to perform that (or possibly many
other as well) validation checks. My impression from when I looked at
the code last, a few year ago, was that it was designed with "validate
with most? every? function" and we would be happy enough with "validate
once".

--=20
Tom

--2k4dwmR+To9QD8a+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRnbpwAKCRAr4qD1Cr/k
CleFAP43ZX256E1FYM3wpxMNfPmKvoye1nCRKEIMvlr04kuUhQD/d08tde+GhRte
w/TpRh6fh/A6rgRgiFWPkQcTEQ3AiQ8=
=H3+o
-----END PGP SIGNATURE-----

--2k4dwmR+To9QD8a+--
