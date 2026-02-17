Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41C7E9A03E
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 21:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F7C83AC5;
	Tue, 17 Feb 2026 22:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YfH+zKxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0367B83B99; Tue, 17 Feb 2026 22:19:02 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D2783981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 22:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45efd53148eso1463420b6e.0
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771363138; x=1771967938; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JzPdv3KwGNjyYLYbxtnT00OInrAkOkWT+5fDmBVROYg=;
 b=YfH+zKxrjxcYZrDXqxsF3DtyAsO+AM8eRnvwte3dzHMqUQWjNw5/J+1mBtpjSxB/rQ
 mKwa4x4LANxOa03jA68PVYmbauZOCyaaOxln8KwVnVgBjHga82xft9Pp9UX93dKa+O8M
 ZBbpzUzA/SqUVgqfAFy4mMlQH1vbTAQ3rg8Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363138; x=1771967938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzPdv3KwGNjyYLYbxtnT00OInrAkOkWT+5fDmBVROYg=;
 b=ehU8y4n6jdc0Xm0i4kqOKDj6FtDNNMSd+/jQZIKBCaqWSOHScmDGvGI0Rd9baVFaLv
 IZOXvp7YHN9LiXIvFWWfxgey9y08ePj0h4P5O46XigLebsGKzTnB8duWV/twt74TuQB8
 apMuSyLlde3w3ooXgHMY5ZJI9JGJs+fS6YPe2cHQp2XKnpRET2NJfDdkAqHOSK6NJJHW
 /KViBRsHnULgNsNsqZol2WfuUhciQumNtq6gv3nxO5qIXg9dE+d8EZm409GnG9ZIwXyw
 YKFOApjxi0aGdycFo8nKwMVvJZjw+UFowP8arg1sigLsA79u2IRDsQzpKNmfcuESH60c
 3Lbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9IbaidqSVoIBI2kErKHmc2R+XRU1Qmt9mlSid6iVvfQN73YLdVUtJAJGxJxD2rVno6Gtp7xI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz5EbN/2p4G1E4KaLzwkivSc27X84OK6+PZM7SG9pe38R2p/L7
 1mmM2LdZMtYgkdX9KU8WrfMq8BuPQXPh/uYE64Itee5PWMCTE3J66NuvMVCsDmCivkI=
X-Gm-Gg: AZuq6aKOzhAa3369kmWsNr/Neoy2dhrPTuUAz6LdLLptENaukhAiKYNODCT+ZpKQmNS
 JdtQpTsd0vFagEzUx6yEEQaTQvlxpwtEOUwetSyad6wiM+JmkgNA6oUqvPHJSfCFmCIcKiYkvj4
 Yr5pUdOssk5S3fNTLyHi+2YCJPC1+U3FQjmPCcw4CpPsLrmdufcsIEpYmHRvUTrj4g7jCjBpwny
 KdUtAa56+S/XE3wkNe81tTdW+u+PjTe70NklDKbxnDretqBRVxfVlOrjL3WGqHjWjNxDhNgf7kz
 yE+iAHEzR4nB3+JQHALXNpCJhlaGKCOnh2IQ211SmPtcavaTEQHLicy55kuJAFRFr/HveZmis3w
 rTrdKUIGA+83aRy8imr9JGrzjh8JzvCFmpOQ7Jhks1l2axQ5v0EhISshuLLfpnd1apAPLnG395R
 2k04M16a+PuxVCkT0X60PseOzA70fU2VWwsuC4EdrdKguVK/rn8XU/L9+bvIyjrpNpG0fa5BZ+T
 ua1DYCd/ZblFZP4dFtQUDfG2NJjIyLLq7jCvfFeaaNyX1DWXPlc0K7J6Z663A==
X-Received: by 2002:a05:6808:22a3:b0:450:c321:d50d with SMTP id
 5614622812f47-463b403deb5mr5607624b6e.40.1771363137982; 
 Tue, 17 Feb 2026 13:18:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40ef89944e2sm13636629fac.2.2026.02.17.13.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:18:57 -0800 (PST)
Date: Tue, 17 Feb 2026 15:18:53 -0600
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
Message-ID: <20260217211853.GJ2747538@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217181358.GE2747538@bill-the-cat>
 <aZTBQykqCt7H8H4W@makrotopia.org>
 <20260217193534.GI2747538@bill-the-cat>
 <aZTYk8E6r4S5zo_Z@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5RWCXdD6qoFlh8zQ"
Content-Disposition: inline
In-Reply-To: <aZTYk8E6r4S5zo_Z@makrotopia.org>
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


--5RWCXdD6qoFlh8zQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 09:07:31PM +0000, Daniel Golle wrote:
> On Tue, Feb 17, 2026 at 01:35:34PM -0600, Tom Rini wrote:
> > On Tue, Feb 17, 2026 at 07:28:03PM +0000, Daniel Golle wrote:
> > > On Tue, Feb 17, 2026 at 12:13:58PM -0600, Tom Rini wrote:
> > > > On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> > > > > Hi all,
> > > > >=20
> > > > > This RFC series adds a new boot method for OpenWrt's "uImage.FIT =
with
> > > > > embedded rootfs" firmware model, along with the underlying infras=
tructure
> > > > > to load FIT images on-demand directly from storage devices withou=
t copying
> > > > > them entirely to RAM first.
> > > > >=20
> > > > > I would like to discuss the design with U-Boot maintainers and fe=
llow
> > > > > OpenWrt developers before submitting a formal patch series.
> > > > [snip]
> > > > > Three storage backends:
> > > > >=20
> > > > >   - Block device (eMMC, SD, SATA, NVMe, USB mass storage, virtio)
> > > > >   - MTD (SPI-NOR, raw NOR, raw NAND with bad block skipping)
> > > > >   - UBI volume (SPI-NAND, raw NAND)
> > > > >=20
> > > > > The "bootm" command is extended to accept a storage device specif=
ication
> > > > > instead of a RAM address:
> > > > >=20
> > > > >   bootm mmc 0:4         # boot FIT from eMMC partition 4
> > > > >   bootm mtd recovery    # boot FIT from MTD partition "recovery"
> > > > >   bootm ubi recovery    # boot FIT from UBI volume "recovery"
> > > > >=20
> > > > > This infrastructure is independently useful beyond the OpenWrt bo=
ot
> > > > > method. Any board that stores a FIT image directly in a partition
> > > > > (rather than as a file on a filesystem) can benefit from on-demand
> > > > > subimage loading.
> > > >=20
> > > > For the user interface portion of this, since this is implementing
> > > > bootmeths, this should all be handled under bootflow/bootdev/etc
> > > > commands, and not adding further options to bootm.
> > >=20
> > > I thought it would be useful independently of bootmeth/bootflow/bootd=
ev
> > > for `bootm` to have these options, as it will allow to gradually migr=
ate
> > > a large number of our downstream boards. Many of them at this point
> > > still require scripts to handle things like extracting MAC addresses
> > > from flash (in ways the original vendor has decided to store them),
> > > updating U-Boot or TF-A blobs, ... and migrating all of that to use
> > > bootmeth/bootflow/... will take time.
> > >=20
> > > In the meantime, already getting rid of (duplicate) scripts "read
> > > firmware from mmc/ubi/mtd" would be feasible, is less of a burden and
> > > easy to test for people who got the respective board at hand.
> > >=20
> > > Also, testing loading (partial) images directly from storage outside
> > > of bootmeth has been very useful during development.
> > >=20
> > > Would it be an option to hide the new bootm cmdline features behind an
> > > additional Kconfig option maybe?
> >=20
> > I worry that if we add this to bootm upstream, it'll be another
> > interface that can't ever go away. Building off of another bit of
> > feedback I sent after this message here, I think the testing side of
> > this support should be handled with CMD_something.._GENERIC, similar to
> > CMD_FS_GENERIC.
>=20
> Hm... The tricky part is kinda not the "load from somewhere" as that
> just ends up calling the .read() op, which usually is more or less
> identical to what some existing commands are already doing, hence easy
> to use 'mmc read ...', 'mtd read ...', 'ubi read ...' for testing.

Yes, this part would be more of just an easier syntax, perhps "block
read type ...".

> Seeing that all the steps in 'bootm' are working, sub-images are
> correctly loaded (or skipped), verification steps (hashes, signature,
> ...) are all working was the more difficult part...

Presumably because of the partial read part? That does get back to
Marek's earlier question about if you can't get that already with
"mkimage -E" and I didn't see the answer, sorry.

> > But perhaps not as one other part of this I wanted to ask about is,
> > does this only support reading FIT images which set their load
> > address? Or is there a call somewhere to lmb_alloc to grab an arbitrary
> > hunk of memory somewhere?
>=20
> In order to kinda do the same as was happening previously when first
> loading the whole image from flash to $loadaddr, I've implemented a
> trivial allocator for chunks with no defined load address in FIT.
> In this case, image_loader_map() is called and loads to alloc_ptr,
> which points to $loadaddr on init, and is then bumped by the
> size loaded. I can use the lmb allocator instead, it's cleaner than
> open-coding this.

Oh yes, this cannot be open coded. The lmb framework is how we avoid
some classes of security issues and just open coding that brings them
all right back. But this is also something that's solved, today, for FIT
images of KERNEL_NOLOAD so we shouldn't need anything new here, either.

> In case of known load address (ie. specified for that sub-image in FIT)
> and compression being IH_COMP_NONE, image_loader_map_to() is called
> which directly loads that sub-image to the specified target address, no
> allocation what-so-ever.

Is that with the existing code, or did you write something new here as
well?

--=20
Tom

--5RWCXdD6qoFlh8zQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZTbOgAKCRAr4qD1Cr/k
CgVKAP9IV/WHyLI2MLpI+GP+Qnq5BHPGFBbuD1JAsB5HgOciegD/QGBFy0nU7Lvs
YZOmnv2zDFTMgxaXWyCBB2PKlKuyuA0=
=fzs0
-----END PGP SIGNATURE-----

--5RWCXdD6qoFlh8zQ--
