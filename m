Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34EEE9A038
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 19:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5526883AC5;
	Tue, 17 Feb 2026 20:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bq3Dllsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B48B083B99; Tue, 17 Feb 2026 20:35:42 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BA683981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 20:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so3912246a34.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771356939; x=1771961739; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FjNTOjufNo8f1L1ZeM8gxDcrx65uLEK2OS+breL8L7g=;
 b=Bq3Dllscdu+Q/ks5QpBX3+Ww5WeuUOw6sp3ombp+6g1kmbM8w9lDdEIFz3ym1QXMFS
 /ib3/LLGPSKxnp43gR2D+6i4aENzAHl4MJ+vPbblKMFGTJOOQMqh1fnsvFqcLNnpUjFe
 AD32qFhJntV0aEoXVDoJUXkQrhVwOe9vmMwvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771356939; x=1771961739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjNTOjufNo8f1L1ZeM8gxDcrx65uLEK2OS+breL8L7g=;
 b=L7c1xQM+LKHbY6k7BVydRjJW4JobOT1GDgfxUSzywi+FYg6vXPTPh9tw2Ah2Gs7d7K
 gRZKZVMYpmq43AKSbPeE7jThz1tWE4aNZoHI+W6mUNgSUaHAFCb8/GZS3irhYgaxnDnW
 XywE1aFiuc111I4hIGL+Pw0ujnarM+9iVPvYSbww/3Yqq8IATHvUBcmhr7PGbPBmsLlG
 SmFmbikG3xHR1f/c843QCuDrZoVAKRFm4bydT2uKMA71mY9tB5h0P7awshzHVTwZdYku
 S9ylqthqpyPPEf7Loe9R5Y5ajguuBh9BSQ6JXo4qwmwIrslYEcWDYgJWHMAdr15llLLb
 BbAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3egkarq+p86gT7kN9dida/V+mprTDXzBjMl/zL5sgFI8lDkPWEPoxQ2NQF2+fxlWB0aJJR9s=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4bmAYw3V2rTlTXLq4jH91ONfW0B5J4ebFT9/6y4QIx6NiSDE9
 534rpTur7BQRNxdnhFpp5LUnC9Htc6uP/VJ3i+xNYyw9n9MqUzMDjJLeBSA/s5HrHcI=
X-Gm-Gg: AZuq6aKRW1hnIZT2H0BlRI5tXzD7oiewahYDGFxHcbY5xDDYLF2+Z1tEQ4RaP/eQgwR
 N6i+dYaCE2l1o7qcsDfYnpgaanUbRfcnAZwef8CRFOZDLwntrwmCeSJQhYwxOUa3qmOoSt1wfwe
 LikEntPYqYNr8UtoVhhb+U5+0vq2f51NvCByFb0Ff+LTQH/zxY/512v8EU85rTkTO7/HOffvEJ+
 LETEaAgaKg8qPkWDlxpHRyEATOxBhw987z0+CJfMlptwJWEpw3lggkf/XbvbY5XMiLrTAmnXa9r
 +X+jbLAH/XH8Mt5FXBDI4mp/YLa0qXqrZIXXb85FRJfA7Tdsa3X1WXuPeWM5RS6or3mvmup5jgG
 W+MY2Fr++KLXQb+zv2I36BaTv7jVGzx2lDJ72LTvozd28w1n9PZJgYC3FK24nkjBKzoRMKvw7Zn
 NHFTdgzwU1YZgbGJhlf8BmO2oSxxOTBIy7GGPbFbBr4XWAGPjej6ZSbJufMxpEYoF/buJkP2lhi
 x7gHa/rxSxhPxan4DZCkmLt6xBo00o64rzQ3qQXEIZi71GpuLA=
X-Received: by 2002:a05:6830:6314:b0:7d2:eb51:ca27 with SMTP id
 46e09a7af769-7d4c4ac07c2mr8898032a34.22.1771356938585; 
 Tue, 17 Feb 2026 11:35:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a7720a95sm15210096a34.29.2026.02.17.11.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 11:35:37 -0800 (PST)
Date: Tue, 17 Feb 2026 13:35:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260217193534.GI2747538@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217181358.GE2747538@bill-the-cat>
 <aZTBQykqCt7H8H4W@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8EcoISagGrCBjoNh"
Content-Disposition: inline
In-Reply-To: <aZTBQykqCt7H8H4W@makrotopia.org>
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


--8EcoISagGrCBjoNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 07:28:03PM +0000, Daniel Golle wrote:
> On Tue, Feb 17, 2026 at 12:13:58PM -0600, Tom Rini wrote:
> > On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> > > Hi all,
> > >=20
> > > This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> > > embedded rootfs" firmware model, along with the underlying infrastruc=
ture
> > > to load FIT images on-demand directly from storage devices without co=
pying
> > > them entirely to RAM first.
> > >=20
> > > I would like to discuss the design with U-Boot maintainers and fellow
> > > OpenWrt developers before submitting a formal patch series.
> > [snip]
> > > Three storage backends:
> > >=20
> > >   - Block device (eMMC, SD, SATA, NVMe, USB mass storage, virtio)
> > >   - MTD (SPI-NOR, raw NOR, raw NAND with bad block skipping)
> > >   - UBI volume (SPI-NAND, raw NAND)
> > >=20
> > > The "bootm" command is extended to accept a storage device specificat=
ion
> > > instead of a RAM address:
> > >=20
> > >   bootm mmc 0:4         # boot FIT from eMMC partition 4
> > >   bootm mtd recovery    # boot FIT from MTD partition "recovery"
> > >   bootm ubi recovery    # boot FIT from UBI volume "recovery"
> > >=20
> > > This infrastructure is independently useful beyond the OpenWrt boot
> > > method. Any board that stores a FIT image directly in a partition
> > > (rather than as a file on a filesystem) can benefit from on-demand
> > > subimage loading.
> >=20
> > For the user interface portion of this, since this is implementing
> > bootmeths, this should all be handled under bootflow/bootdev/etc
> > commands, and not adding further options to bootm.
>=20
> I thought it would be useful independently of bootmeth/bootflow/bootdev
> for `bootm` to have these options, as it will allow to gradually migrate
> a large number of our downstream boards. Many of them at this point
> still require scripts to handle things like extracting MAC addresses
> from flash (in ways the original vendor has decided to store them),
> updating U-Boot or TF-A blobs, ... and migrating all of that to use
> bootmeth/bootflow/... will take time.
>=20
> In the meantime, already getting rid of (duplicate) scripts "read
> firmware from mmc/ubi/mtd" would be feasible, is less of a burden and
> easy to test for people who got the respective board at hand.
>=20
> Also, testing loading (partial) images directly from storage outside
> of bootmeth has been very useful during development.
>=20
> Would it be an option to hide the new bootm cmdline features behind an
> additional Kconfig option maybe?

I worry that if we add this to bootm upstream, it'll be another
interface that can't ever go away. Building off of another bit of
feedback I sent after this message here, I think the testing side of
this support should be handled with CMD_something.._GENERIC, similar to
CMD_FS_GENERIC. But perhaps not as one other part of this I wanted to
ask about is, does this only support reading FIT images which set their
load address? Or is there a call somewhere to lmb_alloc to grab an
arbitrary hunk of memory somewhere?

> > Since you're also talking about an A/B mechanism, looking at the RAUC
> > support may also be helpful as that's another widely deployed
> > methodology we support now via standard boot.
>=20
> Yes, I've looked into RAUC and it has (more or less) recently gained
> support for UBI, which indeed brings it closer to being useful in the
> context of OpenWrt.

To be clear, I just meant in terms of how to implement a bootmeth that
is not just EFI or distro boot but instead something else also aimed at
real world end user devices. Lots of people have a Steam Deck and a
router built on top of OpenWrt :)

--=20
Tom

--8EcoISagGrCBjoNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZTDAgAKCRAr4qD1Cr/k
CgrQAP4tGmylBLSIQrN4bKR/Wwb7pAfRoesUaDRogAT437HiAAEAqncMLcQa6Kvz
6yapPHcfv+WPmWMI2wbPspcIfeoCRgo=
=6MKD
-----END PGP SIGNATURE-----

--8EcoISagGrCBjoNh--
