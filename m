Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8C9E9A047
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 16:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8CCF83CE3;
	Wed, 18 Feb 2026 17:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BfJyxKhv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA7383AC5; Wed, 18 Feb 2026 16:58:47 +0100 (CET)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F180D83A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 16:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-67997ce9e1cso1402992eaf.2
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771430323; x=1772035123; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pzeU9DHf9kOhPYOcZUfGLst0B2Q+d/CYiFCedpJsTOQ=;
 b=BfJyxKhvdNoeBuquCkW7cJqVOw01jh2s+wnwPuyln5IHNsLTzGxIdT+J705chJ2MLG
 2zcyTz/K6tkiArkDzL6/2onmXFgZHKt6LUebSTY7w3z5VqTIBaSjDUsj3e5y+R3h0ls2
 NH2/n8HpIErMTpCfz3ONcFaGaJFGYoAiX9jw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430323; x=1772035123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pzeU9DHf9kOhPYOcZUfGLst0B2Q+d/CYiFCedpJsTOQ=;
 b=p82vukOJQ0UOReNHCQeejanWhvdI0s+R6lVZwqqQQ/haT+oI1t83K4ZpyRMCRn262F
 sTkPWebbcFnhSJlvthdwqusv9vQw0PGyQNuUhxOo/8HrqkWFek+UFH2ToFDM+UQ194AS
 54ZGZfVnziUXrBVNgYQ58yiz1c8yECYUM/JEAYXrCTBDV8jaFDst3CrFw2B+jS2t9UsR
 hjwwji7weYZigsp4elsE+iAOmNr7Xq5SpP++tW6zj6nqjHT0lzWF+f3osvb8YE8C2m2n
 773s9LqDWL3BbMofodSSeREv7tnVF3QFNAkoghyAe/2uH2aJIp1fMaYew0/fqP4y7WcM
 ipMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU07XLOp+Lh7ICDrciSXyEzb/yzLE80dNmCdm5+MuxmcfUuKHfq60+xZf3f9WoI/Sv/7OMN0+8=@lists.denx.de
X-Gm-Message-State: AOJu0YylXAofts8EQfqMtMW+QNeycA6jQcObhos7sSYxvwuAQqr7kX/6
 4sCmEubgFc3LGel4tc5FU2m5vA3fCduW7Z+3TFTt3ev6GfCoL9gOzjnGJ2h9NXpuMAI=
X-Gm-Gg: AZuq6aLLDa642o3ZC9Q5aYHCI1eiaymc+1nBJPnPLZApLd2eEtYJqCqrlWb/LFtynsp
 OQu3WwNkxmAkM7hDwyiLwHM/UxA/Yw1p6mHnQdL1m/z2ocWjhlLyqYMTkMEcSrGAA3X7/BkCFus
 CBlns10MQ97O3qvmQ5rreihIxRKJ8K4VoQv49JBEmhF4szzVDFOkrQnOSIteL7LFFj7mrvfNnni
 XIvxxA9O1f394LtIKT+lmLlHwG4+QxEM/zU528plQCG2YdlWlioXVHLCorQ4lqz3ES4XVqPgGVW
 XF8ltsjJ/iVI7Hqs5P6SlKGBZK8t9xnGzfsgzTtXlsZZfnbogjjlhZRbbqXBnXiXm46WjodGkei
 dIBtKfRNkrTF3KZqdB+pLIuOmqXrF9aF0uhayR2Kgv6wBYhCkAAAfl7tDp2H8NJwAyT3zbYNTEC
 avZwvT1wVzEJY+kV4YXGpOt2a5oDbhTGoAd3L5OKZwIhhWhAwrTNLJNfoMmBj2NfBE0Zw7dWNs0
 TktXN/g3gqrDfHXDlo4MLuLG3TWm/aeoxqTfZEiotnx4QDXk8I=
X-Received: by 2002:a05:6820:3095:b0:66a:1886:e4bf with SMTP id
 006d021491bc7-67859a8813emr7239591eaf.22.1771430323409; 
 Wed, 18 Feb 2026 07:58:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-676f444f315sm11089671eaf.1.2026.02.18.07.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 07:58:42 -0800 (PST)
Date: Wed, 18 Feb 2026 09:58:39 -0600
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
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260218155839.GC3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217181358.GE2747538@bill-the-cat>
 <aZTBQykqCt7H8H4W@makrotopia.org>
 <20260217193534.GI2747538@bill-the-cat>
 <aZTYk8E6r4S5zo_Z@makrotopia.org>
 <20260217211853.GJ2747538@bill-the-cat>
 <aZTqyRfqYe1iJ9EY@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Np7Pl5JYrVK3LnFa"
Content-Disposition: inline
In-Reply-To: <aZTqyRfqYe1iJ9EY@makrotopia.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 18 Feb 2026 17:18:15 +0100
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


--Np7Pl5JYrVK3LnFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 10:25:13PM +0000, Daniel Golle wrote:
> On Tue, Feb 17, 2026 at 03:18:53PM -0600, Tom Rini wrote:
> > On Tue, Feb 17, 2026 at 09:07:31PM +0000, Daniel Golle wrote:
> > > On Tue, Feb 17, 2026 at 01:35:34PM -0600, Tom Rini wrote:
> > > > On Tue, Feb 17, 2026 at 07:28:03PM +0000, Daniel Golle wrote:
> > > > > On Tue, Feb 17, 2026 at 12:13:58PM -0600, Tom Rini wrote:
> > > > > > On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> > > > > > > Hi all,
> > > > > > >=20
> > > > > > > This RFC series adds a new boot method for OpenWrt's "uImage.=
FIT with
> > > > > > > embedded rootfs" firmware model, along with the underlying in=
frastructure
> > > > > > > to load FIT images on-demand directly from storage devices wi=
thout copying
> > > > > > > them entirely to RAM first.
> > > > > > >=20
> > > > > > > I would like to discuss the design with U-Boot maintainers an=
d fellow
> > > > > > > OpenWrt developers before submitting a formal patch series.
> > > > > > [snip]
> > > > > > > Three storage backends:
> > > > > > >=20
> > > > > > >   - Block device (eMMC, SD, SATA, NVMe, USB mass storage, vir=
tio)
> > > > > > >   - MTD (SPI-NOR, raw NOR, raw NAND with bad block skipping)
> > > > > > >   - UBI volume (SPI-NAND, raw NAND)
> > > > > > >=20
> > > > > > > The "bootm" command is extended to accept a storage device sp=
ecification
> > > > > > > instead of a RAM address:
> > > > > > >=20
> > > > > > >   bootm mmc 0:4         # boot FIT from eMMC partition 4
> > > > > > >   bootm mtd recovery    # boot FIT from MTD partition "recove=
ry"
> > > > > > >   bootm ubi recovery    # boot FIT from UBI volume "recovery"
> > > > > > >=20
> > > > > > > This infrastructure is independently useful beyond the OpenWr=
t boot
> > > > > > > method. Any board that stores a FIT image directly in a parti=
tion
> > > > > > > (rather than as a file on a filesystem) can benefit from on-d=
emand
> > > > > > > subimage loading.
> > > > > >=20
> > > > > > For the user interface portion of this, since this is implement=
ing
> > > > > > bootmeths, this should all be handled under bootflow/bootdev/etc
> > > > > > commands, and not adding further options to bootm.
> > > > >=20
> > > > > I thought it would be useful independently of bootmeth/bootflow/b=
ootdev
> > > > > for `bootm` to have these options, as it will allow to gradually =
migrate
> > > > > a large number of our downstream boards. Many of them at this poi=
nt
> > > > > still require scripts to handle things like extracting MAC addres=
ses
> > > > > from flash (in ways the original vendor has decided to store them=
),
> > > > > updating U-Boot or TF-A blobs, ... and migrating all of that to u=
se
> > > > > bootmeth/bootflow/... will take time.
> > > > >=20
> > > > > In the meantime, already getting rid of (duplicate) scripts "read
> > > > > firmware from mmc/ubi/mtd" would be feasible, is less of a burden=
 and
> > > > > easy to test for people who got the respective board at hand.
> > > > >=20
> > > > > Also, testing loading (partial) images directly from storage outs=
ide
> > > > > of bootmeth has been very useful during development.
> > > > >=20
> > > > > Would it be an option to hide the new bootm cmdline features behi=
nd an
> > > > > additional Kconfig option maybe?
> > > >=20
> > > > I worry that if we add this to bootm upstream, it'll be another
> > > > interface that can't ever go away. Building off of another bit of
> > > > feedback I sent after this message here, I think the testing side of
> > > > this support should be handled with CMD_something.._GENERIC, simila=
r to
> > > > CMD_FS_GENERIC.
> > >=20
> > > Hm... The tricky part is kinda not the "load from somewhere" as that
> > > just ends up calling the .read() op, which usually is more or less
> > > identical to what some existing commands are already doing, hence easy
> > > to use 'mmc read ...', 'mtd read ...', 'ubi read ...' for testing.
> >=20
> > Yes, this part would be more of just an easier syntax, perhps "block
> > read type ...".
> >=20
> > > Seeing that all the steps in 'bootm' are working, sub-images are
> > > correctly loaded (or skipped), verification steps (hashes, signature,
> > > ...) are all working was the more difficult part...
> >=20
> > Presumably because of the partial read part? That does get back to
> > Marek's earlier question about if you can't get that already with
> > "mkimage -E" and I didn't see the answer, sorry.
>=20
> For partial read to work, using "mkimage -E" is a requirement, everything
> else wouldn't make sense. However, that still doesn't magically solve
> loading (and validating) on the needed parts from storage to RAM, at this
> point (ie. without this series) it is still expected that the whole image
> has been loaded to RAM at the point `bootm` is called.
>=20
> >=20
> > > > But perhaps not as one other part of this I wanted to ask about is,
> > > > does this only support reading FIT images which set their load
> > > > address? Or is there a call somewhere to lmb_alloc to grab an arbit=
rary
> > > > hunk of memory somewhere?
> > >=20
> > > In order to kinda do the same as was happening previously when first
> > > loading the whole image from flash to $loadaddr, I've implemented a
> > > trivial allocator for chunks with no defined load address in FIT.
> > > In this case, image_loader_map() is called and loads to alloc_ptr,
> > > which points to $loadaddr on init, and is then bumped by the
> > > size loaded. I can use the lmb allocator instead, it's cleaner than
> > > open-coding this.
> >=20
> > Oh yes, this cannot be open coded. The lmb framework is how we avoid
> > some classes of security issues and just open coding that brings them
> > all right back. But this is also something that's solved, today, for FIT
> > images of KERNEL_NOLOAD so we shouldn't need anything new here, either.
>=20
> +1
>=20
> >=20
> > > In case of known load address (ie. specified for that sub-image in FI=
T)
> > > and compression being IH_COMP_NONE, image_loader_map_to() is called
> > > which directly loads that sub-image to the specified target address, =
no
> > > allocation what-so-ever.
> >=20
> > Is that with the existing code, or did you write something new here as
> > well?
>=20
> As the existing code expects the whole image to reside in RAM and only
> take care of validation, decompression and relocation, I had to extend
> image-fit.c to use the image_loader to only load the parts *from
> storage* which are actually needed, and if possible, load them directly
> to where they are supposed to go. Imho, the code is simple enough to
> just look at it:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/ab7837536e4567b90d7cb662=
984dd7e637ef4361.1771275704.git.daniel@makrotopia.org/
>=20
> At this stage (because I first wanted to discuss the general approach)
> the patch still skips some parts of image-fit.c, which is obviously not
> acceptable for upstream inclusion, but good enough to demonstrate the
> idea and also try it in practise.
>=20
> Ie. the 'goto storage_loaded' has to go away and all of image-fit.c has
> to be changed to equally work on RAM-backed or storage-backed images.

I was talking with Marek to recall some of the details about what we can
and can't (easily..) do today with external data and he remidned me of
something. So one big concern here is that we have to be care to not
re-open things like:
https://nvd.nist.gov/vuln/detail/CVE-2023-39902
or otherwise allow for mix-and-match type attacks by having some sort of
partial reads allowed.

So a specialized partial-read of FIT images, in full U-Boot (not just
SPL), is something to figure out, but may also invalidate one of your
design goals because you do have to authenticate the whole image, unless
there's something both secure and clever I'm missing.

--=20
Tom

--Np7Pl5JYrVK3LnFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZXhpwAKCRAr4qD1Cr/k
CoqWAP9jpsE0YKAhypWEEg60g2KnZ88FRTf42QXszyrM4H/7LgEA4RsuKUbSw3o9
Wrlq0vfNS299ZjdbEh7M3oXndlKKXAM=
=E9y9
-----END PGP SIGNATURE-----

--Np7Pl5JYrVK3LnFa--
