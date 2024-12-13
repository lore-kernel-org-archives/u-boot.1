Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15767E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 17:47:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8506B800D7;
	Fri, 13 Dec 2024 18:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WCWcYrUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4855080141; Fri, 13 Dec 2024 15:05:22 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0528B8012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4675feed835so14936401cf.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734098719; x=1734703519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cWKCO0fwK+U1wjoCBxe2RlQhn27twcCsUTUbtRIk1yw=;
 b=WCWcYrUisP5WnuUqY657z57GjRoW+Mo6GQjdi5krQ/UieL0iU6R2UNwn7q03ZbdCPj
 uyF5ArktjtqoI6I7/MMAm81CIB8XALRK2q6Cod5GRBRgzzHwHfEZhfVGgfd0lTQz5/f9
 5vIwLKqi2Zb1u8IdqzrlY4ITF+UZN7+uzP3y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734098719; x=1734703519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWKCO0fwK+U1wjoCBxe2RlQhn27twcCsUTUbtRIk1yw=;
 b=fHtg/wMPcz5302kgAf+zlbZz+iTWl23lhx9/nJMPv+MzpJVYCVyq6WkQP1IFrmb8Qg
 uiPEoR4/Kt1b0Gtw5qGdGAEOGfKuFUalBjy0j7HZmRbfCLWvrnbUr6EzlC54Z4XTctXs
 O6SEVHqnvmrZXxjhQE1AWEvMnrPZlJVEYVtScgPJMXOl4MUOwavB9tPN/CDPzqwIlYTn
 nYbdtdKkgW+A/mJY6rAxLfW4MITU4dLjf6f+YrbL14At2h+2ZVle11UXIrDF7ZwCSgLx
 4ObHfmDSHmg0N7BqhwlPvIggQ4Cy+l2TXEj4JxzjPeWVndk77/m3feHgfkNA4jmVqVVv
 lYlA==
X-Gm-Message-State: AOJu0Yz3emO962k7awXu59IbZl4OXNEQ2xv02itfnq+aohAIhhAZFZo+
 QVk6FMqbuStPP08Bx+bl8eqMZrg/vsy8jSdNdW6WKDbd8C5X4Y7RjlLh8qW9fKc=
X-Gm-Gg: ASbGnct0GxuvNyJel72jseVK+YmynrQ4tpoUwUe4V94lR0Ebzl+6X301UF7Ys5yRFPw
 zxU6Wxkyyd/dUodZmkWnXInaFY/anDmFTBPGOhafWigzkQLi+jFXEUjJ37kymdQ0PtSaAJwdC7y
 i0indTYz854fxOTH/qEyVUnFVGmSNXPMtnibt6Fyy4uND9Lp4dBKbg2RNyacs6SXkOp2HuX13gy
 bJbf8/bvmk9QfML8VT3eC4Hb2CHYja094aC4/KZzrxyJJOUXyEBpZPN
X-Google-Smtp-Source: AGHT+IFehF1FandRUpwOCUH8VMOBcpQkhrnDUlgHTWQTFEzMAsWYJkG8uIQtrVxB/1g0LHH0YjYrMg==
X-Received: by 2002:a05:622a:1a29:b0:467:56a2:b05c with SMTP id
 d75a77b69052e-467a574c951mr54060301cf.10.1734098718453; 
 Fri, 13 Dec 2024 06:05:18 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6d5dbf6d9sm495068485a.38.2024.12.13.06.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:05:17 -0800 (PST)
Date: Fri, 13 Dec 2024 08:05:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Dragan Simic <dsimic@manjaro.org>,
 Gary Bisson <bisson.gary@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v3 00/19] vbe: Series part E
Message-ID: <20241213140510.GS1505244@bill-the-cat>
References: <20241207172412.1124558-1-sjg@chromium.org>
 <173405231528.1635625.10928592597091154587.b4-ty@konsulko.com>
 <20241213030940.GO1505244@bill-the-cat>
 <CAFLszTj2av9Cj4x5k7wYcxEZXNQt6O=0_5oXUKMSw4RGbnDAfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X+gR7fOdO7a2N5do"
Content-Disposition: inline
In-Reply-To: <CAFLszTj2av9Cj4x5k7wYcxEZXNQt6O=0_5oXUKMSw4RGbnDAfg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 13 Dec 2024 18:47:00 +0100
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


--X+gR7fOdO7a2N5do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 08:24:06PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 12 Dec 2024 at 20:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 07:11:55PM -0600, Tom Rini wrote:
> > > On Sat, 07 Dec 2024 10:23:53 -0700, Simon Glass wrote:
> > >
> > > > This includes various patches towards implementing the VBE abrec
> > > > bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting w=
hat
> > > > fatures are available in VPL.
> > > >
> > > > Changes in v3:
> > > > - Add new patch to avoid size growth in spl_mmc_find_device() debug
> > > > - Use strlcpy() instead of strncpy()
> > > > - Rebase to master
> > > >
> > > > [...]
> > >
> > > Applied to u-boot/next, thanks!
> >
> > And, ugh, I missed that CI was failing for real. This causes
> > rcar3_salvator-x to fail to link due to size growth, so I'm reverting
> > this for now, sorry. I thought the CI failure I saw was due to something
> > else at the time.
>=20
> Hmm, sorry about that...it passed CI when I sent it!
>=20
> The growth is quite alarming and I am not sure how to make sense of
> it. Here is the last patch:
>=20
> 21: hash: Plumb crc8 into the hash functions
>    aarch64:  +   rcar3_salvator-x
>    aarch64: (for 1/1 boards) all +2109.0 bss -48.0 data +56.0 rodata
> +5.0 text +2096.0
>             rcar3_salvator-x: all +2109 bss -48 data +56 rodata +5 text +=
2096
>                u-boot: add: 1/0, grow: 1/0 bytes: 136/0 (136)
>                  function                                   old     new  =
 delta
>                  crc8_wd_buf                                  -      80  =
   +80
>                  hash_algo                                  280     336  =
   +56
>=20
> So perhaps apply all but the final patch? Then I can sort out things from=
 there.

I tried that before going off for the night without remembering that the
problem is:
+(rcar3_salvator-x) u-boot.img exceeds file size limit:
+(rcar3_salvator-x)   limit:  0x100000 bytes
+(rcar3_salvator-x)   actual: 0x100392 bytes
+(rcar3_salvator-x)   excess: 0x392 bytes

So no, just the last patch alone is not enough. You need to sync up with
Marek about what can/can't be disabled on the platform (or more likely
really, r-car gen3 platforms overall0.

--=20
Tom

--X+gR7fOdO7a2N5do
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdcPxYACgkQFHw5/5Y0
tyz6KQwAi1Gm0R8XYhfyvGtPM/GL6y7JdNgxJCKEB0COFd5ypiAw6bHwK8tpfsqp
xZ7FkPXDx7PKMhcWgokti+nnynPjj1bYGgNHs6qKh3zoNWeAyn1+fHVgPIWMZMfU
m54JCoGry09DA+hmaRl3/Sz4YhLJ9VbmlsyRPy0rUQlqkCapgPfYDHaSinWVLdft
oHcpbb0EVF1M13AIpf04m16ePIshXIV7WnioJGJqED5veq8uvpwz1gV+K8T9XzSR
2lWl74Pz3BOF+j1YuIhXkLRknzXx/6CmKwLh60hvC/73C9u3l8IbFY0392/ytZ7k
NQjYUgA8STLvoVn19JGhsnQiDmyK++hj+cpPYplWHJFlMeVeqky1V3E6O4QN0je5
DO8OE1vHtP/4XNAsxCnhv9inY2ntYHT6s+F+HMKg8tIxgBgeVZrifpfnsgZ+90/C
0mBWgQWfXMKoU2f9UX18xIRq8x/IA7Y4CfHP112pL6l2Yw8srcUZSIbuzU0ZGt1n
+Lgb5x0y
=I+Xp
-----END PGP SIGNATURE-----

--X+gR7fOdO7a2N5do--
