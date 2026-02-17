Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1374FE9A039
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 19:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFAB83AC5;
	Tue, 17 Feb 2026 20:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEBS4USW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D103783B99; Tue, 17 Feb 2026 20:15:44 +0100 (CET)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F4BC83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 20:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-40efc77933fso2486026fac.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771355741; x=1771960541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=efXWlRQFgDmvkvrScstJPl5adjqZJpzCwH5YO50kdKU=;
 b=eEBS4USWtoPrUSE51ow4BYvuGBLlrGYaDVgQtS82z78pPqzEQCrhSO7uZOGyn/NnrC
 sJiPciYgAE7+CJSU68kSRh1EDbolPFnqhiIQHkz+JUBt709Lqgly661oHfhRFMo2JPhw
 x9HGZBoqIqo0vuyDm0UtKrNCVlAYbdmrDaGg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771355741; x=1771960541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efXWlRQFgDmvkvrScstJPl5adjqZJpzCwH5YO50kdKU=;
 b=tewlCUtKxF+vN0lqnjKCbntNKclgJR5s6wObEQ5jyGZwwpjEO8Qm81VmgMcBH+hWrp
 kl4al56S1z2ACE4kiR2u6/HNMSgKB0thOtJyFmo+3/Q7PttQi0r6g/KUVBp75tJ4S9Rq
 O8Ca+ERvr+GPCyi/oJMNjPR+ZsBiwqS0pCxC/kvEtHJToy2c+acmU6daEbCtAQ7p5GzO
 P0cSCQPvHzYSPdoUAXeNYR2o1s/P+x+5gCO8lNLH9wqjEYnegUV3E4dvFAf39XC2XrN5
 7VfxfV1datzp88o3Y3WYEnJ6Gi+VjYrnJkNjXnkkFaNbIwLp2E/jWRZjFIWuCYQMwCct
 IIyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdVS5cXod7EyQDMLpnc+YY1m1wdCG7TkUg5km/BkroqW1A/pUKp2VI5oKWXn7GIrspy6UCa3M=@lists.denx.de
X-Gm-Message-State: AOJu0YwCOMdJlkjZcokv7ByKT1DOu9LNMB3s5ZLztLgMKvoGlttPnh/S
 zfNSY/7PDzNfKtciPKpr1d83zhGemBpWIXqPmu6vwRGG9VYXn0qeSag9617ljOnkC7I=
X-Gm-Gg: AZuq6aKcnFUUdzqciY0T+GWrHZLoqflKB7mc/dwdg2yFQEYBRt34ltbdq+x3zVXIzjq
 s+k/TP5NL4W2l4475rroh9TBmkRHn8gT3hr1RJiiqbHn99rm4MZdi2JMle2DZR6a7xJmrYC+TYm
 vXDYAWZZ9UaJpxXnrIYEpXxORXxx5EsXzz9oJTF6/g/VjMTxLL6MNafTxlTVQEl7f946pE9FKmw
 kWV5rCoJVZkWC+yLcKMY83yJrTJUnSidK0CNjwAIinqy169LBZWn0XS8ReUBYWCGe02RC4viKyy
 fhkeVOoTBbJohjHwyuOMRT9a5nxjTjoUUcQOdMcM41vQPxUoRFNEVLqZDGTE/mJh098qhhPYYK8
 T8WN+zKBDnhZBY5ADb9+3qT5zDLfctfLDHPBMgntkbHTI5IR4s26XS2NuUzHr0fXO0xpRgmAZsd
 sv7WrK0MPjxwIWhthxCFHx6Gmg/kOt4GnfOM+4f+/ns1P90ujBZXMKygvUSGll6W8DsZxRNoKJx
 +tAyJ8Wzgn56wfOhZA7Y8i8pJt5PAsQdE6VN0KKjsz8WaGmE18=
X-Received: by 2002:a05:6870:3182:b0:409:8e86:c0a1 with SMTP id
 586e51a60fabf-40f0d550878mr7425204fac.11.1771355740646; 
 Tue, 17 Feb 2026 11:15:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-413956e44aasm4105996fac.15.2026.02.17.11.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 11:15:39 -0800 (PST)
Date: Tue, 17 Feb 2026 13:15:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
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
Message-ID: <20260217191536.GG2747538@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <49aa54f6-78a0-4eb4-bd60-d7e17263e586@mailbox.org>
 <aZPB8o9bvkNNpGT6@makrotopia.org>
 <dd636864-2e3e-4701-9e42-fd32353afe92@mailbox.org>
 <aZRm1DVkEgUtInqt@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CH9DpIFY+Tcc5YBF"
Content-Disposition: inline
In-Reply-To: <aZRm1DVkEgUtInqt@makrotopia.org>
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


--CH9DpIFY+Tcc5YBF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 01:02:12PM +0000, Daniel Golle wrote:
> On Tue, Feb 17, 2026 at 03:04:09AM +0100, Marek Vasut wrote:
> > On 2/17/26 2:18 AM, Daniel Golle wrote:
> > > Hi Marek,
> > >=20
> > > thanks for taking a look at the series!
> > >=20
> > > Let me reply inline below:
> > >=20
> > > On Mon, Feb 16, 2026 at 11:16:24PM +0100, Marek Vasut wrote:
> > > > On 2/16/26 10:21 PM, Daniel Golle wrote:
> > > >=20
> > > > Hi,
> > > >=20
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
> > > >=20
> > > > [...]
> > > >=20
> > > > > 4. On-demand loading: None of the existing methods support loadin=
g FIT
> > > > >      subimages directly from storage. OpenWrt's FIT images typica=
lly
> > > > >      contain a 5-20 MB squashfs that does NOT need to be copied t=
o RAM =E2=80=94
> > > > >      the kernel maps it directly from flash. The bootloader only =
needs
> > > > >      to load the kernel and DTB (~5-10 MB), not the entire 20-50 =
MB
> > > > >      container. This requires a new loading abstraction.
> > > >=20
> > > > Isn't this partial loading exactly what SPL does when the fitImage =
is
> > > > generated with external data (mkimage -E) ? SPL loads and traverses=
 the
> > > > tree, and then loads the remaining chunks (files) only when needed =
if I
> > > > recall it right ?
> > >=20
> > > Yes, the image_loader abstraction in this series is essentially the
> > > main-U-Boot equivalent of SPL's spl_load_info.read(), adapted for the
> > > richer set of storage backends, byte-addressed, providing an interface
> > > for both "load this to where ever" and "load this to a specific target
> > > address" (image_loader_map() vs. image_loader_map_to()), and the full
> > > fit_image_load() verification pipeline. The integration point in
> > > fit_image_load() (patch 09/20) is ~50 lines of new code gated by if
> > > (images->loader && external_data) - it reuses all existing FIT proper=
ty
> > > parsing, load address negotiation, and hash verification unchanged.
> > >=20
> > > That said, the image_loader abstraction itself is format-agnostic - it
> > > only deals with byte offsets, lengths, and RAM destinations. The same
> > > three storage backends could be wired into other executable formats w=
ith
> > > minimal effort, such as ELF, legacy uImage or UEFI PE.
> > >=20
> > > Likewise, adding a backend based on fs_read() would be trivial,
> > > extending U-Boot's wget to support range requests and using it as
> > > image_loader backend would not be hard either.
> > >=20
> > > > Can that SPL code be reused instead ?
> > >=20
> > > I considered factoring out a shared "FIT external data reader" between
> > > SPL and U-Boot proper, but the two callers want fundamentally differe=
nt
> > > things: SPL wants minimal code size and populates spl_image_info; U-B=
oot
> > > proper wants full verification and populates bootm_headers.
> >=20
> > I suspect the feature set of each loading stage can be configured e.g. =
using
> > "if (IS_ENABLED(...))" to keep the size under control ?
> >=20
> > I would be very happy if we could have ONE consistent code base used for
> > loading in all of TPL/SPL/U-Boot . Custom special loader in U-Boot and
> > different special loader in SPL and so on, will only lead to inconsiste=
ncy
> > and increased maintenance burden. Worse, it will lead to obscure bugs w=
hich
> > will differ between U-Boot and SPL, or bugs being fixed in one and not =
the
> > other.
>=20
> This implies changing the parameter "ulong sector" to a byte offset,
> which means all existing readers and users will have to be changed as
> well, and also code to deal with unaligned start offsets will have to be
> added. Other than that it's mostly a matter of adding some #ifdef-ery,
> conditionally extending struct spl_load_info with
>  - a cleanup callback function pointer
>  - alloc_ptr for bump allocator
>  - the array of already mapped regions
>=20
> None of that is used by the readers, so the low-level spl_mmc reader
> could be reused and extended -- but it's already very messy with many
> hacks and special cases, it's own device and partition hunters, ...
> and would basically need adding almost all of the code which is currently
> in image-loader-blk.c (to handle the unaligned start offset, ...)
>=20
> The other SPL readers are even more unsuitable:
>=20
>  - The SPI-NOR and NOR readers lack support for MTD partitions, instead
>    they are using a downstream DT property to specify *one* static offset
>    ('u-boot,spl-payload-offset')
>=20
>  - The UBI reader deals only with static UBI volumes, and support for UBI
>    in SPL is a light-weight minimal thing incompatible with the full UBI
>    implementation in U-Boot proper.
>=20
>  - The FIT reader in SPL uses a very different approach from the
>    image_loader approach I suggested. It is basically a minimal
>    implementation of a FIT parser, while I'm suggesting to glue
>    support for the image_loader into boot/image-fit.c of U-Boot proper,
>    hence keeping and reusing all of its features.
>    See patch "boot: fit: support on-demand loading in fit_image_load()".
>=20
> So there really isn't much overlap other than the fact that there is a
> struct with a priv pointer and a .read callback, and even that uses a
> different addressing parameter (sectors vs. bytes).
>=20
> Imho, trying to unite the two "with a hammer" will do more harm than good.

So, we have some conflicting problems and solutions here, in general.
Outside of this thread, we have:
https://lore.kernel.org/u-boot/20260217112156.272154-1-a-dutta@ti.com/
with the biggest feedback being to look at:
https://lore.kernel.org/u-boot/2b5ebaa9-76f1-e2b0-4e8c-fc8b6c197136@gmail.c=
om/T/#m4f33f294f050574baafef1cbfaa7e88a2a47eb5c

Because yes, we need better support in SPL for more fully-featured flash
access (on platforms with the initial memory space to support it).

There's also as you note earlier, a reasonable abstraction for reading
=66rom a filesystem, but there's not an equivalent for reading from a
block device directly. Something like CMD_FS_GENERIC (and another
symbol if useful just for the library portion of it) is what the image
loading section seems to do, and feels entirely reasonable. That being
its own series would be something that can be reviewed on its own, too.
And from there, we can see if that can be leveraged to work with SPL
too, as there's both not a generic solution within SPL today nor a
generic solution (for both raw and filesystems) outside of SPL.

--=20
Tom

--CH9DpIFY+Tcc5YBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZS+WAAKCRAr4qD1Cr/k
Co9OAP0bUjAukNNWX2IeoeWLH1smCF4JYA+HjoW2oKaf9bEJxgEA8qOrN+uCURxW
v9VwNUJ76nFovd8BLzOdgNdQuzzmYw8=
=nq5P
-----END PGP SIGNATURE-----

--CH9DpIFY+Tcc5YBF--
