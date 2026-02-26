Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8F0FD8FF4
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 18:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DDD783E96;
	Thu, 26 Feb 2026 19:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hXqvvMe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CFB983EF5; Thu, 26 Feb 2026 19:45:22 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9574D83E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 19:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so1175071a34.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 10:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772131516; x=1772736316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DYw7uc46okRugnx9kQ0s84tOvCvsFcmU6Dsa+8cUgp8=;
 b=hXqvvMe+cNN1md9DkmC3MVvAH9cyHoJG274Q4cXIBBitBCchEn+s8Isz8S79/HA5xh
 F6IRQbn/Caststk771JNQJCPv/lPyUvKUhFF1Grd9/WZNkQF1FpkHfw6rssQtANS2O+g
 Ps0eSxsbJIWPpQmk+E/ap2aLFasxytqLPTovs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772131516; x=1772736316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYw7uc46okRugnx9kQ0s84tOvCvsFcmU6Dsa+8cUgp8=;
 b=q8MNTwMNXRpHmgh1UgVh6ncP3RV66Syv6MR8lUV93I4BG3w/pZlviaNlOclhxEoEGz
 oSNgBpvcMLc/LeSYu2QV+tptpwK6bb4oIRnJ0P3sQQIhxWgMRs+UVRYJfOV4hrzWQ63m
 IWQkztaaG6Vu40VX4sh/Cx3XnwKntCR0/ewkhGfsWPnrPEPcQJLeqsdfa00ET+mtdVHc
 beC94zSx71U5jTfmKXF9V4A1FjoG+IGZy00RSA4/67ZfSwUvdLhUWS1/P9sh+2VjXuul
 IgbxNHCcsX/zrrCBcAC73HsCzhzo67zwzJjmb+DFcYgHFPtTvtyGh1rl929wBz79bxOV
 ApAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHeCoBhTrS6cQ0BVvZ8myQ9HexO+Rt8jElHXlM4xLL6EsiIsByFOJZWcY/PnFE/1pRfTpndBc=@lists.denx.de
X-Gm-Message-State: AOJu0YzPPKx6sIC/3TlWKKbLs+2QaVgKD6GSN39GIF+KtfYaiTyEDLi5
 s/CQB7eZiYAaIKafHcjoUmxhfHQTDjhyA59n42rm75l+0bSPim8Ma2GgNHwSDmHVHOs=
X-Gm-Gg: ATEYQzwRQk3+gzlaVDWv7+9wlyevENbwPKyWUPGEPDRBySfjuMDvLBnfWfy+WWnxFe9
 p8uCCEuz6TmzPZuuBTCW75XTPT1SvD4DdAJzFoI2oqHQ+PEc8oydc9yvm3fzh08PtqAp2K2DOMa
 jEAKv+J4JdCXpEGFZHSoeBPAcdfW7NO4+eppCi1VLNi5qL5VrCEttRbWyet9Yp5Hl3X1vNH9oLj
 7V40iFM9ZCJyUAVM5aMSURhiwsa8OI/HyFnZSNJ6tcQlQUL/A+cjBubTiLgVU0UzN66XFa8woDC
 frH8snNbLb94ZmIGMXbxiJ9jG2jL5vMM62RzDj9bUwMWRD/+wDU734lYd0k4hHksEgxmy+SQxD8
 8R4o0YBvP5cssN3lbQvRVcYU2LBT8L5H/X5BMmk0IE0PA1N2yezjv97EKgCQFLPiKdS2GIpnKsq
 xmfAc/CbULuDs1txfDha4ohLyJyN/Z2c2EKXx+v6CsELYVwNykgCw/vFUk8soczd7rTcJBlzST0
 V0pQSpYaW2OGCXVuE3yy1wTQ3gZXdtJLYH+K6TxQsOrdrFpcI4=
X-Received: by 2002:a05:6830:2117:b0:7d5:1101:9196 with SMTP id
 46e09a7af769-7d591b0f76cmr172102a34.6.1772131516311; 
 Thu, 26 Feb 2026 10:45:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5866541e5sm2353285a34.20.2026.02.26.10.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 10:45:15 -0800 (PST)
Date: Thu, 26 Feb 2026 12:45:12 -0600
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
Message-ID: <20260226184512.GL1593142@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217174617.GD2747538@bill-the-cat>
 <20260223193219.GF3233182@bill-the-cat>
 <aZ2SI0rKuMEgSq1F@makrotopia.org>
 <20260224172444.GA3233182@bill-the-cat>
 <aZ8IXfm1TEPMqb4a@makrotopia.org>
 <20260225221611.GX1593142@bill-the-cat>
 <aZ-KgxENCGLR73lf@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jOzeZjWzH9ABX2ci"
Content-Disposition: inline
In-Reply-To: <aZ-KgxENCGLR73lf@makrotopia.org>
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


--jOzeZjWzH9ABX2ci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 11:49:23PM +0000, Daniel Golle wrote:
> On Wed, Feb 25, 2026 at 04:16:11PM -0600, Tom Rini wrote:
> > On Wed, Feb 25, 2026 at 02:34:05PM +0000, Daniel Golle wrote:
> > > Thanks for digging all of them out. I took the freedom to answer all =
of
> > > them here as it makes it easier to keep track of all the topics being=
 in
> > > a single thread.
> > >=20
> > > > https://lore.kernel.org/u-boot/20260217150820.GB2747538@bill-the-ca=
t/
> > > > And I see you're using CI, but I didn't see an ack about the size
> > > > investigations portion.
> > >=20
> > > I had to remove the -E (errors-as-warnings) option from the script
> > > because my host toolchain is too new and caused a few warnings about
> > > discarded 'const' qualifiers. Most can be fixed by updating dtc to
> > > that in upstream Linux, the other one is in
> > >     tools/atmelimage.c:64:31: error: assignment discards =E2=80=98con=
st=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifi=
ers]
> > > and can also be fixed easily. I'll post the patch for that after I
> > > send this email.
> > >=20
> > > Updating dtc, however, caused a cascade of new warnings in existing
> > > device tree files, newly introduce node-name checks, ... so at that
> > > point I decided to just remove the -E option passed from the script
> > > to buildman...
> > >=20
> > > Results:
> > > For any board having CONFIG_FIT enabled but none of the new features
> > > there is a slight increase:
> > >    aarch64: (for 1/1 boards) all +8.0 text +8.0
> > >             mt7622_rfb     : all +8 text +8
> > >                u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
> > >                  function                                   old     n=
ew   delta
> > >                  fit_image_load                            1632    16=
40      +8
> > >=20
> > > The increase by 8 bytes is caused by this hunk:
> > > --- a/boot/image-fit.c
> > > +++ b/boot/image-fit.c
> > > @@ -2279,8 +2362,9 @@ int fit_image_load(struct bootm_headers *images=
, ulong addr,
> > >  			return -EXDEV;
> > >  		}
> > > =20
> > > -		printf("   Loading %s from 0x%08lx to 0x%08lx\n",
> > > -		       prop_name, data, load);
> > > +		if (data !=3D load)
> > > +			printf("   Loading %s from 0x%08lx to 0x%08lx\n",
> > > +			       prop_name, data, load);
> > >  	} else {
> > >  		load =3D data;	/* No load address specified */
> > >  	}
> > >=20
> > > It could obviously also be guarded by some
> > > if (!CONFIG_IS_ENABLED(IMAGEMAP) || data !=3D load)
> > > so the compiler would end up with byte-identical code in case
> > > CONFIG_IS_ENABLED(IMAGEMAP) is false.
> > > Do you think that'd be worth it?
> >=20
> > So 8 byte growth here is fine, it would be more unreadable to avoid that
> > than to accept it, and 8 bytes is nothing really.
>=20
> As keeping things byte-identical in case !CONFIG_IS_ENABLED(IMAGEMAP)
> I've added that additional condition, and now indeed end up with 0
> size increase.

OK.

> > > With CONFIG_FIT enabled already before, the changes are more reasonab=
le:
> > >    aarch64: (for 1/1 boards) all +6057.0 data +296.0 rodata +513.0 te=
xt +5248.0
> > >             mt7986a_bpir3_emmc: all +6057 data +296 rodata +513 text =
+5248
> > >                u-boot: add: 21/0, grow: 3/0 bytes: 5336/0 (5336)
> > >                  function                                   old     n=
ew   delta
> > >                  fit_verity_build_params                      -     9=
48    +948
> > >                  cmdline_set_arg                              -     6=
88    +688
> > >                  imagemap_map                                 -     6=
40    +640
> > >                  openwrt_boot                                 -     5=
16    +516
> > >                  fit_image_load                            1632    19=
80    +348
> > >                  copy_in                                      -     2=
28    +228
> > >                  imagemap_map_to                              -     2=
12    +212
> > >                  openwrt_read_bootflow                        -     2=
04    +204
> > >                  imagemap_record                              -     1=
80    +180
> > >                  bootm_run_states                          2256    24=
36    +180
> > >                  imagemap_create                              -     1=
76    +176
> > >                  bootflow_cmdline_set_arg                     -     1=
64    +164
> > >                  imagemap_cleanup                             -     1=
36    +136
> > >                  _u_boot_list_2_uclass_driver_2_imagemap       -     =
120    +120
> > >                  _u_boot_list_2_driver_2_bootmeth_openwrt       -    =
 120    +120
> > >                  imagemap_lookup                              -     1=
12    +112
> > >                  bootflow_cmdline_set                         -      =
76     +76
> > >                  openwrt_bootmeth_ops                         -      =
56     +56
> > >                  alist_uninit                                 -      =
48     +48
> > >                  openwrt_bootmeth_bind                        -      =
44     +44
> > >                  openwrt_check                                -      =
36     +36
> > >                  imagemap_post_probe                          -      =
36     +36
> > >                  fit_image_get_data                         188     2=
24     +36
> > >                  openwrt_bootmeth_ids                         -      =
32     +32
> >=20
> > Adding 5K or so isn't unreasonable, but I'd still suggest looking around
> > to see if there's any easy optimizations.
>=20
>=20
> One thing which I'm anaway not interely decided about is whether to
> build fit_verity_build_params() (the function which reads the dm-verity
> parameters from FIT and generates the Linux cmdline arguments from that)
> on top of bootflow_cmdline_set_arg() or to just generate the whole
> string and use env_get(), env_set() on the "bootargs" env variable.
>=20
>=20
> Not using bootflow_cmdline_set_arg() would also mean that in the case of
> bootmeth_openwrt nothing would be using it, and that would free 688
> bytes, while fit_verity_build_params() might get a very tiny bit larger,
> certainly less than that.
>=20
> The thing is that it looks to me like bootflow/bootmeth is meant to ignore
> "bootargs" and overwrites it just before boot. On the other hand, having
> a generic feature such as generting the dm-mod.create=3D... Linux kernel
> cmdline parameter from the values stored in FIT depend on bootmeth, or
> even a specific bootmeth, also seems wrong.
>=20
> I'd be happy to hear your opinion about that.

It should probably exist outside of the bootflow/bootmeth code, yes. As
we start expanding the real usage of bootflow/bootmeth we do need to
make sure that it's not doing things that violate user expectations, so
I'm not 100% sure if we are or aren't doing anything odd with bootargs,
depending on the flow.

> > > > There's:
> > > > https://lore.kernel.org/u-boot/20260217192000.GH2747538@bill-the-ca=
t/
> > > > And I didn't see anything about that.
> > >=20
> > > Re: boot: add OpenWrt boot method and on-demand FIT loading
> > >=20
> > > (Re: not enabled on any board nor in sandbox)
> > > In my new series I'll add the OpenWrt One as a sample board and also
> > > enable the new features on the BananaPi R3.
> >=20
> > OK, thanks.
> >=20
> > > Should I also enable the imagemap base feature in sandbox as well so =
the
> > > unit tests can easily be run?
> >=20
> > Absolutely.
> >=20
> > > (Re: splitting series)
> > > There aren't any actual fixes part of the series. Of course, some
> > > smaller changes and refactoring to create the helpers needed by
> > > imagemap and the bootmeth could be broken out as indidivual patches
> > > sent separately in advance, but they wouldn't have any in-tree users
> > > at this point. Eg.
> > >  - mtd: set flash_node on DT-created partitions
> > >  - mtd: add mtd_read_skip_bad() helper
> > >  - cmd: ubi: add ubi_part_from_mtd()
> > >  - cmd: ubi: export ubi_find_volume()
> >=20
> > Maybe I'm mis-recalling but some of the changes seemed to be worded /
> > implied they were fixing existing problems, not adding things to be used
> > later.
>=20
> "mtd: set flash_node on DT-created partitions"[1] could be considered a
> fix, however, up to now nothing within U-Boot was ever interested in the
> of_node of an MTD partition, so because of that it also doesn't really
> fix anything. After I had already posted the RFC series I found a
> theoretical infinite-loop issue when all blocks are bad which also
> exists in the original code, and the new mtd_read_skip_bad() helper
> fixes that.
>=20
> All the rest is adding helpers or refactoring existing code into
> reusable helpers, and then adding stuff on top of that using them. Plus
> documentation, unit tests and all that.
>=20
> [1]: https://patchwork.ozlabs.org/project/uboot/patch/e21bf2c12eb5a4b7954=
f50c8739655d749e6d38e.1771275704.git.daniel@makrotopia.org/

OK. I think this really falls under reviewing the commit messages then.

> > But also, those changes should have some impact on size growth? To make
> > sure to look at other platforms as well. The goal is not zero growth,
> > but rather explainable growth. I'm not asking you to do the world
> > before/after that I do, but making use of qconfig.py -f CONFIG_FOO to
> > find boards that enable code you're changing and then checking them and
> > seeing if it's tens of bytes or hundreds of bytes of growth on something
> > unsupported (and likely never supported) by OpenWrt is important.
>=20
> Yes, boards using CONFIG_MTD=3Dy or CONFIG_UBI=3Dy will see minimal incre=
ase:
>=20
>     mt7987_emmc_rfb: all +552 text +552
>        u-boot: add: 3/0, grow: 2/0 bytes: 528/0 (528)
>          function                                   old     new   delta
>          mtd_read_skip_bad                            -     256    +256
>          mtd_read                                     -     196    +196
>          do_mtd_io                                 1624    1688     +64
>          mtd_post_bind                                -       8      +8
>          add_mtd_partitions_of                      400     404      +4
>=20
>=20
>     mvebu_ac5_rd   : all +48 text +48
>        u-boot: add: 1/0, grow: 2/-1 bytes: 104/-56 (48)
>          function                                   old     new   delta
>          static.ubi_dev_scan                          -      88     +88
>          ubi_find_volume                            124     136     +12
>          add_mtd_partitions_of                      400     404      +4
>          ubi_part                                   280     224     -56
>=20
> The groth of the boards using CONFIG_MTD seems larger than I would have t=
hought,
> I'll figure out that is happening there and try to reduce the binary grow=
th,
> especially the mtd_read() function should be smaller and not bigger now t=
hat
> it calls mtd_read_skip_bad() -- but may calling a function has a larger f=
ootprint
> than the actual code itself. In every case, 196 bytes still seems too muc=
h.

Thanks.

> > > I also think it makes sense to discuss the new feature (not part of t=
he
> > > original RFC series) to store dm-verity parameters for IH_TYPE_FILESY=
STEM
> > > subimages in the FIT structure separately, and that would start with
> > > discussing the FIT spec amendment for it:
> > >=20
> > > https://github.com/open-source-firmware/flat-image-tree/pull/37
> >=20
> > Yes, that's a separate discussion.
> >=20
> > > > There's:
> > > > https://lore.kernel.org/u-boot/20260217190554.GF2747538@bill-the-ca=
t/
> > >=20
> > > Re: test: boot: add image_loader unit tests
> > > (Re: AI fixes in the wrong commit)
> > > Yes, this was an oversight and I've of course folded in that change,
> > > and later, upon Simon's comment, switched to use alist instead of a
> > > fixed-size array anyway.
> >=20
> > > > https://lore.kernel.org/u-boot/20260219153100.GL3233182@bill-the-ca=
t/
> > > > Which go together and I think "human written only commit message" m=
ight
> > > > well be a good policy as it helps ensure the patch in question has =
been
> > > > read and summarized by the human author (and enforcement is on the
> > > > honor system).
> > >=20
> > > While it was very useful to use an LLM for quickly drafting the intial
> > > RFC and receive feedback for the overall approach, it became less and
> > > less useful at later stages -- instead of ending of micro-managing the
> > > LLM for each little change and fix it's easier to just do it yourself
> > > from some point on.
> > >=20
> > > So what you are going to see in v2 surely still got some onchanged li=
nes
> > > of code, comments and parts of commit messages which have intially be=
en
> > > fabricated with the help of the LLM, but most of it is by now the work
> > > of a human (me).
> >=20
> > OK.
> >=20
> > > Regarding the commit messages, I get the idea of enforcing a
> > > human-written message, however, when it comes to the use of English
> > > language (I'm not a native speaker) I think the use of things like
> > > deepl.com does create more benefit than potential damage even though =
it
> > > can also be considered an AI/LLM tool.
> >=20
> > This is a project that was started by Germans and initially contributed
> > to by other Europeans and has an extremely long history of global and
> > non-native-English speakers contributing, I would much rather see some
> > imperfect English than overly polished and often useless LLM messages.
> >=20
> > It is sometimes joked that LLMs speak great Manager-English, but that's
> > not what we want here.
>=20
> No but we do want accuracy, and sometimes using ones native language to
> describe something throughing that into a machine translator can produce
> more accurate results than trying to use a foreign language directly.
> I sometimes do both and then compare the outcomes, for example.

Right. At the end of the day, getting a word choice or two from whatever
(it's hard to find translation sites that aren't LLM rather than
dictionary these days) is fine. But LLM drafted and then human tweaked
isn't right. That's the difference I'm trying to get it. And for what
it's worth, my own experiences with translating are a lot more mixed
quality.

> > > > Finally there's:
> > > > https://lore.kernel.org/u-boot/20260217191536.GG2747538@bill-the-ca=
t/
> > > > where I was hoping for more feedback.
> > > Re: reuse imageloader (by now renamed to "imagemap") in SPL
> > >=20
> > > First of all, I don't have any boards which use SPL. All modern
> > > platforms I deal with use U-Boot as "Non-Trusted Firmware (BL33)" or
> > > the OpenSBI equivalent of that on platforms using RISC-V.
> > >=20
> > > Especially regarding the UBI part, the implementation intended for SPL
> > > is way too basic to be useful as imagemap backend.
> > >=20
> > > For BLK (ie. MMC) or SPI-NOR it would be a possibility to reuse
> > > imagemap in SPL -- but (as I've replied earlier) I don't think it
> > > makes sense to merge it with the exising FIT reader in SPL for the
> > > reasons I've explained:
> > > |> So there really isn't much overlap other than the fact that there =
is a
> > > |> struct with a priv pointer and a .read callback, and even that use=
s a
> > > |> different addressing parameter (sectors vs. bytes).
> >=20
> > You should go back in to that thread, so the other interested parties
> > see this as well and also keep in mind that you're adding something that
> > may be useful in other cases, not that you should use what we have today
> > instead. Especially for the cases where people are trying to add
> > less-basic support in SPL for various flashes.
>=20
> The quote above *is* from the original thread. Or do you mean the
> threads you have linked in the reply above?

Yes, I mean go back and reply in that thread, which has a different set
of people on CC please.

> Building imagemap with SPL in mind or not still makes a difference when
> it comes to depending on LMB or alist imho (both come very handy, and as
> discussed earlier, open-coding a naive allocator or using a fixed-size
> array comes with disadvantages and risks).
>=20
> >=20
> > > > I don't recall if we came to a conclusion, or just look again later,
> > > > about if we should have this functionality both exposed via "bootm"=
 and
> > > > the new distro bootmeth, or not. It might be "talk more" and I'm le=
aning
> > > > currently on saying the migration path is something openwrt holds
> > > > downstream while getting things migrated?
> > >=20
> > > That's also what I understood from our discussion. Adding new cmdline
> > > features to 'bootm' can be considered a liability, so I've dropped th=
at
> > > from the v2 series and only use the direct-storage FIT loading in
> > > bootmeth_openwrt. We can still add the 'bootm' features as an
> > > intermediate step to easy migration of all our boards as downstream
> > > patch (and later remove it again once all boards and features work wi=
th
> > > the bootmeth).
> >=20
> > OK, thanks.
> >=20
> > > > And in sum, this series will need to be split up a bit I strongly
> > > > suspect. Being clear about the end goal is good but implementing ea=
ch of
> > > > the backends as well in a single series will make this too large to
> > > > review.
> > >=20
> > > The current state of the series looks pretty much like what I've push=
ed
> > > to Github for the sake of getting CI exposure.
> >=20
> > I don't look at all the emails it generates and sends to me, but it was
> > 20 commits at least?
>=20
> Yes, it's 22 commits by now. Our of which 3 are documentation, 1 is for t=
he
> unit tests, and 3 are for adding/modifying boards to use the new features.
> So 15 out of 22 actually adding/touching code.
>=20
> >=20
> > > Do you agree with the submission strategy drafted below?
> > >=20
> > > Commits (reverse git order, starting from the one directly
> > > on top of u-boot.git master branch, ie. in the order of
> > > the patches to be submitted starting with the first to be
> > > sent).
> > >=20
> > > SERIES 1: dm-verity paramters for FIT images
> > >=20
> > >  - boot: fit: support generating DM verity cmdline parameters
> > >  - doc: fit: add dm-verity boot parameter documentation
> > >=20
> > > To be discussed together with
> > > https://github.com/open-source-firmware/flat-image-tree/pull/37
> >=20
> > This is a stand-alone thing yes, and should wait for that discussion to
> > be resolved / merged.
> >=20
> > > ---
> > > SERIES 2: imagemap storage abstraction
> > >=20
> > >  - boot: add imagemap on-demand loading abstraction
> > >  - boot: imagemap: add block device backend
> > >  - doc: imagemap: document on-demand loading framework
> > >  - test: boot: add imagemap unit tests
> > >=20
> > > This would be a meaningful series together with enabling imagemap
> > > in sandbox so the unit tests are run there.
> > > ---
> > > SERIES 3: imagemap MTD and UBI backends
> > >=20
> > >  - mtd: add mtd_read_skip_bad() helper
> > >  - boot: imagemap: add MTD backend
> > >  - mtd: set flash_node on DT-created partitions
> > >  - cmd: ubi: export ubi_find_volume()
> > >  - cmd: ubi: add ubi_part_from_mtd()
> > >  - boot: imagemap: add UBI volume backend
> > >=20
> > > This would be one or two small series adding the backends.
> > > Maybe including another commit completing the documentation
> > > to cover the newly added backends.
> > > ---
> > > single PATCH
> > >=20
> > >  - boot: fit: support on-demand loading in fit_image_load()
> > >=20
> > > This would be good to be discussed individually as it is
> > > the most intrusive change and needs the most eyeballs.
> > > ---
> > > SERIES 4: OpenWrt boot method
> > >=20
> > >  - boot: bootmeth: add OpenWrt boot method skeleton
> > >  - boot: bootmeth: openwrt: implement read_bootflow
> > >  - boot: bootmeth: openwrt: implement boot via imagemap
> > >  - boot: bootdev: add MTD boot device
> > >  - boot: bootdev: add UBI boot device
> > >  - doc: bootstd: add OpenWrt boot method documentation
> > >  - board: mediatek: add OpenWrt One support
> > >  - mt7986a-bpi-r3: add OpenWrt boot method
> >=20
> > This kind of split doesn't help with review because series 2, 3 and 4
> > have to be seen as a whole for them to be useful and understood. It had
> > sounded like earlier there was support for block devices (eMMC/SD for
> > example) but that's not included yet? I was going to suggest excluding
> > them, or just including the smallest backend support to start with, and
> > follow-up with other backends. So I'd rather see 2, 3 and 4 as a single
> > series than split up, so that it's possible to understand real usage.
> > Thanks.
>=20
> Another way could be to skip series 3 (imagemap MTD and UBI backends)
> as well as the MTD and UBI related patches in series 4, and then
> have 2 follow-up series adding MTD and UBI features respectively to
> imagemap and bootdev/bootmeth_openwrt.
>=20
> In that way you'd end up with something complete and useful on the
> shortest path, and more features (MTD, UBI) are added on top after.

OK. What I want to avoid is a series where we introduce imagemap but
can't really evaluate it because there's also not users present (which
wasn't an issue so much when it also was added to "bootm").

--=20
Tom

--jOzeZjWzH9ABX2ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaCUrQAKCRAr4qD1Cr/k
ClNIAQC3m51TIcth65kBicKHP7/JPmeaVg3tjYVWb4MmdRO7awEAnN5Q7FRMNkEn
iDkXufO92Qcrfs/LzlaHjNiu1s0nPws=
=iUO4
-----END PGP SIGNATURE-----

--jOzeZjWzH9ABX2ci--
