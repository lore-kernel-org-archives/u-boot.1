Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806E9FD45F6
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3648366F;
	Wed, 25 Feb 2026 23:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MXcjfocb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84A983AA9; Wed, 25 Feb 2026 23:16:20 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C7282A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d4c3896e32so66342a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772057776; x=1772662576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hMe73kfbhzz6jEb85Dq42plxCwFFCXBydmg1wRJC1n8=;
 b=MXcjfocbatzxeN2eW31k6NJCeNkTk0i0zYHQIWXByE9TUIVu+HIsBLP2gqNw1t3GOD
 jIB7n+G3A4fRuEU+Xc9OygS6HphwNBVZiZW24fPO9t79Nymz13XiTjyQyUI4N8W2uu6O
 l518MvQT+hobXoU1INBbHYlcjNQfuA8JxRttg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772057776; x=1772662576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMe73kfbhzz6jEb85Dq42plxCwFFCXBydmg1wRJC1n8=;
 b=HW02vlqkrX9BP1/mhsQF18fgsmwusjvfvE7XN1sJDjpxwWX3y0ucRzZjVx00YmB8Bj
 SFSG+5MUQe60UAp/vFK6NUXq7uJouplMfon6I0Sm0Y0aj+Rah18t8mqUrj5enN+pzvVq
 U7oQuMccJGjY2DMqT2CGTYzsNLA3iR7Ug2qPMZK3NrubJoHoEVJe3HIb3L9iquClmvAh
 fZmm2BTv+LgWf+1KqVTEFCSEpKAiv5OgmHJ8ATOKnMAw6Fi1QWA/iPJbEbEejb2zbaUO
 b91cV71uOaoXHP0RmBop493y/PRAfSBGBC7Zk1l35zv/q8HV7dkIgjRGOntk7O50YtSx
 mH0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtwQoR14L5O7Oe+KWgJbwH1MDpGPunqut4KKZl5IQ8blpnwpU+SduiwHcquDXjTiim/z42jkc=@lists.denx.de
X-Gm-Message-State: AOJu0YyV9Gg0aFf7jRi+r/re1BiBRzZq/xEqic5pFs4YFyEkwrvBRAx7
 mdih/8z1Y+CRWYhROBGHOydj0PIKVAISjEfWiWFuYmjG6jxQxy/4H4sfRDRlhhReBqE=
X-Gm-Gg: ATEYQzz+6PcRiilGkwh9y5Ul6YQ9RxsZoPgj8zp4VUqenT3h+p5ExXhsPsrg05rok+c
 GFdvX6yulUGoYnm/L9Qg80EHmOpbcDljBZn7Wkb39BMIYU6q+JqMsmEG9AwHPVsBqDk3KXYbGdr
 mMXGYF/v/IMv3rZSSN6hrmfz2YHLMAWJK4iO6LGz/vcV6YZEBa/bQ1324xm3DbLKSw/48cLOL/N
 wwtIOSQJVUVPn2gXUq3SLAXMdXk3DWhlwVY8TvP2Z9kVT9Eehb2rZpRHL6wNVxjZYbJEz8naL/R
 M24q+q/M2attTRC378srIV8NsTNPnvUb8E+SBBEhf9nw4iPXqjIhV0yi4mIuMMSAWC9mLOzQk26
 o1ZFAjB3Z3RCWN2+P01Q9kpY9ftpseBcquhA0PlXGRdY5PO9LPvwNdoEy23ZydpFJBE+SV20f9n
 OF6xpnFNCAYZvwXujDfGRRQN1efh1K2zXDhxCzlJI8NwQXURdPAe3614zuuacc6qlKvzB07a6MI
 JH+qx84H9nPy7JRetkLP7Mo0x5hBCo8q6ookKMU2uHoZ2cR2mI=
X-Received: by 2002:a05:6830:81ed:b0:7cf:c482:4982 with SMTP id
 46e09a7af769-7d52c2c9274mr9678513a34.25.1772057775879; 
 Wed, 25 Feb 2026 14:16:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edf0sm205572a34.2.2026.02.25.14.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:16:15 -0800 (PST)
Date: Wed, 25 Feb 2026 16:16:11 -0600
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
Message-ID: <20260225221611.GX1593142@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217174617.GD2747538@bill-the-cat>
 <20260223193219.GF3233182@bill-the-cat>
 <aZ2SI0rKuMEgSq1F@makrotopia.org>
 <20260224172444.GA3233182@bill-the-cat>
 <aZ8IXfm1TEPMqb4a@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B/wRfG+91yzR1ZSe"
Content-Disposition: inline
In-Reply-To: <aZ8IXfm1TEPMqb4a@makrotopia.org>
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


--B/wRfG+91yzR1ZSe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 02:34:05PM +0000, Daniel Golle wrote:
> On Tue, Feb 24, 2026 at 11:24:44AM -0600, Tom Rini wrote:
> > On Tue, Feb 24, 2026 at 11:57:23AM +0000, Daniel Golle wrote:
> > > On Mon, Feb 23, 2026 at 01:32:19PM -0600, Tom Rini wrote:
> > > > On Tue, Feb 17, 2026 at 11:46:17AM -0600, Tom Rini wrote:
> > > > > On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> > > > >=20
> > > > > > Hi all,
> > > > > >=20
> > > > > > This RFC series adds a new boot method for OpenWrt's "uImage.FI=
T with
> > > > > > embedded rootfs" firmware model, along with the underlying infr=
astructure
> > > > > > to load FIT images on-demand directly from storage devices with=
out copying
> > > > > > them entirely to RAM first.
> > > > > [snip]
> > > > > > AI tool disclosure
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >=20
> > > > > > Major parts of this series were developed with assistance from =
GitHub
> > > > > > Copilot (Claude Opus 4.6, Anthropic). The AI was used as a codi=
ng
> > > > > > partner for scaffolding boilerplate, drafting documentation and=
 commit
> > > > > > messages, running checkpatch sweeps, and iterating on review fe=
edback.
> > > > > > All architectural decisions, U-Boot subsystem integration, hard=
ware
> > > > > > testing, and final review were done by the human author. Every =
line of
> > > > > > code was reviewed and tested on real hardware before inclusion.
> > > > >=20
> > > > > First, I appreciate your honesty and explanation in the disclosur=
e here.
> > > > >=20
> > > > > This topic comes up, and will keep coming up, and as a project we=
 have
> > > > > not yet decided on a position. I know that the Linux Kernel has c=
ome up
> > > > > with:
> > > > > https://docs.kernel.org/next/process/generated-content.html
> > > > > so far. But I think that:
> > > > > https://docs.postmarketos.org/policies-and-processes/development/=
contributing-and-ai.html
> > > > > brings up points that are quite relevant too. Absolutely no one h=
as been
> > > > > happy with when gitlab or patchwork were unusable / unreachable (=
and for
> > > > > some people are still unusable) but it's because of all the AI sc=
rapers
> > > > > that things were unusable or now have anubis in front of them (bl=
ocking
> > > > > other humans now).
> > > > >=20
> > > > > With that said, I want to stress the "human is responsible" porti=
on of
> > > > > what both links say, and that given where exactly these changes a=
re
> > > > > aimed for, extra scrutiny is required. Things like:
> > > > > https://cyberplace.social/@GossiTheDog/116080909947754833
> > > > > show just how bad they are about introducing security bugs these =
days.
> > > >=20
> > > > Following up on this part I suppose, I see in CI you're working on =
v2
> > > > but please make sure to follow up with the other outstanding questi=
ons
> > > > I've asked before posting that. Thanks!
> > >=20
> > > I've carefully reiterated over all your emails regarding the series a=
nd
> > > my replies to them. Apart from your request to share an image making =
use
> > > of the proposal to include dm-verity parameters in uImage.FIT (and use
> > > the presence to decide whether has varifications of that subimage may=
 be
> > > skipped) I haven't found anything which hasn't been answered. But may=
be
> > > I missed something, of course.
> >=20
> > There's:
>=20
> Thanks for digging all of them out. I took the freedom to answer all of
> them here as it makes it easier to keep track of all the topics being in
> a single thread.
>=20
> > https://lore.kernel.org/u-boot/20260217150820.GB2747538@bill-the-cat/
> > And I see you're using CI, but I didn't see an ack about the size
> > investigations portion.
>=20
> I had to remove the -E (errors-as-warnings) option from the script
> because my host toolchain is too new and caused a few warnings about
> discarded 'const' qualifiers. Most can be fixed by updating dtc to
> that in upstream Linux, the other one is in
>     tools/atmelimage.c:64:31: error: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifier=
s]
> and can also be fixed easily. I'll post the patch for that after I
> send this email.
>=20
> Updating dtc, however, caused a cascade of new warnings in existing
> device tree files, newly introduce node-name checks, ... so at that
> point I decided to just remove the -E option passed from the script
> to buildman...
>=20
> Results:
> For any board having CONFIG_FIT enabled but none of the new features
> there is a slight increase:
>    aarch64: (for 1/1 boards) all +8.0 text +8.0
>             mt7622_rfb     : all +8 text +8
>                u-boot: add: 0/0, grow: 1/0 bytes: 8/0 (8)
>                  function                                   old     new  =
 delta
>                  fit_image_load                            1632    1640  =
    +8
>=20
> The increase by 8 bytes is caused by this hunk:
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2279,8 +2362,9 @@ int fit_image_load(struct bootm_headers *images, ul=
ong addr,
>  			return -EXDEV;
>  		}
> =20
> -		printf("   Loading %s from 0x%08lx to 0x%08lx\n",
> -		       prop_name, data, load);
> +		if (data !=3D load)
> +			printf("   Loading %s from 0x%08lx to 0x%08lx\n",
> +			       prop_name, data, load);
>  	} else {
>  		load =3D data;	/* No load address specified */
>  	}
>=20
> It could obviously also be guarded by some
> if (!CONFIG_IS_ENABLED(IMAGEMAP) || data !=3D load)
> so the compiler would end up with byte-identical code in case
> CONFIG_IS_ENABLED(IMAGEMAP) is false.
> Do you think that'd be worth it?

So 8 byte growth here is fine, it would be more unreadable to avoid that
than to accept it, and 8 bytes is nothing really.

> Enabling the new features for the BanananPi R3 required also enabling
> CONFIG_FIT which previously wasn't selected for that board.
> With all the new options (CONFIG_FIT, all imagemap backends, OpenWrt boot=
meth):
>    aarch64: (for 1/1 boards) all +47701.0 data +848.0 rodata +5001.0 text=
 +41852.0
>             mt7986a_bpir3_emmc: all +47701 data +848 rodata +5001 text +4=
1852
>                u-boot: add: 142/0, grow: 22/-1 bytes: 27785/-4 (27781)
>                  function                                   old     new  =
 delta
>                  MD5Transform                                 -    2528  =
 +2528
>                  fit_image_load                               -    1980  =
 +1980
>                  fit_print_contents                           -    1228  =
 +1228
>                  fit_verity_build_params                      -     948  =
  +948
>                  fit_image_print                              -     780  =
  +780
>                  cmdline_set_arg                              -     688  =
  +688
>                  imagemap_map                                 -     640  =
  +640
>                  bootmeth_vbe_ft_fixup                        -     640  =
  +640
>                  bootm_run_states                          1908    2436  =
  +528
>                  fit_image_verify_with_data                   -     520  =
  +520
>                  openwrt_boot                                 -     516  =
  +516
>                  sha256_finish                                -     404  =
  +404
>                  image_locate_script                        272     668  =
  +396
>                  boot_get_fdt_fit                             -     396  =
  +396
>                  fit_image_print_data                         -     392  =
  +392
>                  boot_get_loadable                            -     384  =
  +384
>                  fdt_check_full                               -     332  =
  +332
>                  bootm_help_text                            910    1234  =
  +324
>                  sha1_finish                                  -     300  =
  +300
>                  bootflow_scan_next                         424     724  =
  +300
>                  bootmeth_vbe_simple_ft_fixup                 -     288  =
  +288
>                  hash_command                               188     468  =
  +280
>                  hash_algo                                    -     280  =
  +280
>                  fit_all_image_verify                         -     272  =
  +272
>                  bootmeth_vbe_simple_probe                    -     264  =
  +264
>                  MD5Update                                    -     260  =
  +260
>                  do_imgextract                              668     924  =
  +256
>                  boot_get_fdt                               592     848  =
  +256
>                  static.sha1_update                           -     240  =
  +240
>                  boot_get_ramdisk                           480     720  =
  +240
>                  static.CSWTCH                              139     371  =
  +232
>                  copy_in                                      -     228  =
  +228
>                  fit_image_get_data                           -     224  =
  +224
>                  static.sha256_update                         -     220  =
  +220
>                  fit_conf_get_node                            -     216  =
  +216
>                  imagemap_map_to                              -     212  =
  +212
>                  openwrt_read_bootflow                        -     204  =
  +204
>                  fit_conf_get_prop_node                       -     192  =
  +192
>                  MD5Final                                     -     188  =
  +188
>                  imagemap_record                              -     180  =
  +180
>                  imagemap_create                              -     176  =
  +176
>                  fit_image_print_verification_data            -     176  =
  +176
>                  source_help_text                            40     212  =
  +172
>                  event_notify                                 -     168  =
  +168
>                  vbe_simple_fixup_node                        -     164  =
  +164
>                  bootflow_cmdline_set_arg                     -     164  =
  +164
>                  fit_check_format                             -     152  =
  +152
>                  vbe_get_blk                                  -     148  =
  +148
>                  vbe_read_nvdata                              -     140  =
  +140
>                  ofnode_add_subnode                           -     140  =
  +140
>                  imagemap_cleanup                             -     136  =
  +136
>                  fit_image_verify                             -     136  =
  +136
>                  fit_image_get_address                        -     136  =
  +136
>                  ofnode_copy_props                            -     120  =
  +120
>                  boot_get_setup_fit                           -     120  =
  +120
>                  _u_boot_list_2_uclass_driver_2_imagemap       -     120 =
   +120
>                  _u_boot_list_2_driver_2_vbe_simple           -     120  =
  +120
>                  _u_boot_list_2_driver_2_bootmeth_openwrt       -     120=
    +120
>                  next_glob_bootmeth                           -     116  =
  +116
>                  fit_parse_subimage                           -     116  =
  +116
>                  fit_parse_conf                               -     116  =
  +116
>                  calculate_hash                               -     116  =
  +116
>                  vbe_simple_get_state_desc                    -     112  =
  +112
>                  sha1_csum_wd                                 -     112  =
  +112
>                  ofnode_write_prop                            -     112  =
  +112
>                  imagemap_lookup                              -     112  =
  +112
>                  hash_lookup_algo                             -     112  =
  +112
>                  vbe_simple_read_state                        -     100  =
  +100
>                  vbe_read_version                             -     100  =
  +100
>                  vbe_find_first_device                        -      96  =
   +96
>                  uimage_phase                                 -      96  =
   +96
>                  ofnode_write_u32                             -      96  =
   +96
>                  md5_wd                                       -      96  =
   +96
>                  genimg_get_kernel_addr_fit                  24     120  =
   +96
>                  imgextract_help_text                        85     178  =
   +93
>                  board_init_r                               572     664  =
   +92
>                  vbe_find_next_device                         -      88  =
   +88
>                  simple_read_nvdata                           -      88  =
   +88
>                  sha256_starts                                -      88  =
   +88
>                  fit_get_node_from_config                     -      88  =
   +88
>                  bootmeth_get_bootflow                        -      88  =
   +88
>                  bootflow_check                               -      88  =
   +88
>                  bootmeth_setup_iter_order                  284     368  =
   +84
>                  bootmeth_glob_allowed                        -      84  =
   +84
>                  board_init_f                              1168    1252  =
   +84
>                  image_info                                 208     288  =
   +80
>                  get_table_entry_id                           -      80  =
   +80
>                  fit_image_hash_get_value                     -      80  =
   +80
>                  fit_image_get_emb_data                       -      80  =
   +80
>                  fit_image_get_type                           -      76  =
   +76
>                  fit_image_get_phase                          -      76  =
   +76
>                  fit_image_get_os                             -      76  =
   +76
>                  fit_image_get_arch                           -      76  =
   +76
>                  bootflow_cmdline_set                         -      76  =
   +76
>                  sha256_csum_wd                               -      72  =
   +72
>                  fit_image_get_node                           -      72  =
   +72
>                  fit_image_get_data_size                      -      72  =
   +72
>                  fit_image_get_data_position                  -      72  =
   +72
>                  fit_image_get_data_offset                    -      72  =
   +72
>                  fit_image_get_comp                           -      68  =
   +68
>                  vbe_reqs                                     -      64  =
   +64
>                  sha256_padding                               -      64  =
   +64
>                  sha1_padding                                 -      64  =
   +64
>                  image_setup_libfdt                         344     408  =
   +64
>                  hash_finish_sha256                           -      64  =
   +64
>                  hash_finish_sha1                             -      64  =
   +64
>                  fit_image_check_type                         -      60  =
   +60
>                  fit_image_check_os                           -      60  =
   +60
>                  fit_image_check_comp                         -      60  =
   +60
>                  fit_conf_get_prop_node_index                 -      60  =
   +60
>                  do_source                                   84     144  =
   +60
>                  crc32_wd_buf                                 -      60  =
   +60
>                  crc16_ccitt_wd_buf                           -      60  =
   +60
>                  sha1_starts                                  -      56  =
   +56
>                  openwrt_bootmeth_ops                         -      56  =
   +56
>                  oftree_path                                  -      56  =
   +56
>                  ofnode_write_string                          -      56  =
   +56
>                  hash_finish_crc32                            -      56  =
   +56
>                  hash_finish_crc16_ccitt                      -      56  =
   +56
>                  fit_image_hash_get_algo                      -      56  =
   +56
>                  fit_get_desc                                 -      56  =
   +56
>                  bootmeth_vbe_simple_ops                      -      56  =
   +56
>                  hash_update_crc32                            -      52  =
   +52
>                  hash_update_crc16_ccitt                      -      52  =
   +52
>                  hash_init_sha256                             -      52  =
   +52
>                  hash_init_sha1                               -      52  =
   +52
>                  crc8                                         -      52  =
   +52
>                  hash_init_crc32                              -      48  =
   +48
>                  hash_init_crc16_ccitt                        -      48  =
   +48
>                  alist_uninit                                 -      48  =
   +48
>                  openwrt_bootmeth_bind                        -      44  =
   +44
>                  bootmeth_vbe_simple_bind                     -      44  =
   +44
>                  openwrt_check                                -      36  =
   +36
>                  imagemap_post_probe                          -      36  =
   +36
>                  hash_update_sha256                           -      36  =
   +36
>                  hash_update_sha1                             -      36  =
   +36
>                  vbe_simple_read_file                         -      32  =
   +32
>                  openwrt_bootmeth_ids                         -      32  =
   +32
>                  generic_simple_vbe_simple_ids                -      32  =
   +32
>                  bootflow_scan_first                        236     264  =
   +28
>                  genimg_get_type_id                           -      24  =
   +24
>                  genimg_get_phase_name                        -      24  =
   +24
>                  genimg_get_phase_id                          -      24  =
   +24
>                  genimg_get_os_id                             -      24  =
   +24
>                  genimg_get_comp_id                           -      24  =
   +24
>                  genimg_get_arch_id                           -      24  =
   +24
>                  fit_image_get_load                           -      16  =
   +16
>                  fit_image_get_entry                          -      16  =
   +16
>                  fit_get_end                                  -      16  =
   +16
>                  bootm_find_images                          268     284  =
   +16
>                  _u_boot_list_2_evspy_info_2_EVT_FT_FIXUP_3_bootmeth_vbe_=
simple_ft_fixup       -      16     +16
>                  _u_boot_list_2_evspy_info_2_EVT_FT_FIXUP_3_bootmeth_vbe_=
ft_fixup       -      16     +16
>                  sha256_update                                -      12  =
   +12
>                  sha1_update                                  -      12  =
   +12
>                  genimg_get_kernel_addr                      20      32  =
   +12
>                  event_type_name                              -      12  =
   +12
>                  event_notify_null                            -      12  =
   +12
>                  vbe_simple_read_bootflow                     -       8  =
    +8
>                  vbe_req_random_seed                          -       8  =
    +8
>                  vbe_req_efi_runtime_rand                     -       8  =
    +8
>                  vbe_req_aslr_rand                            -       8  =
    +8
>                  vbe_req_aslr_move                            -       8  =
    +8
>                  oftree_root                                  -       8  =
    +8
>                  genimg_has_config                            8      16  =
    +8
>                  boot_get_setup                               8       4  =
    -4
>=20
> This seems excessive, but it's mostly due to CONFIG_FIT not being enabled
> in the upstream U-Boot defconfig for the BananaPi R3.
>=20
> With CONFIG_FIT enabled already before, the changes are more reasonable:
>    aarch64: (for 1/1 boards) all +6057.0 data +296.0 rodata +513.0 text +=
5248.0
>             mt7986a_bpir3_emmc: all +6057 data +296 rodata +513 text +5248
>                u-boot: add: 21/0, grow: 3/0 bytes: 5336/0 (5336)
>                  function                                   old     new  =
 delta
>                  fit_verity_build_params                      -     948  =
  +948
>                  cmdline_set_arg                              -     688  =
  +688
>                  imagemap_map                                 -     640  =
  +640
>                  openwrt_boot                                 -     516  =
  +516
>                  fit_image_load                            1632    1980  =
  +348
>                  copy_in                                      -     228  =
  +228
>                  imagemap_map_to                              -     212  =
  +212
>                  openwrt_read_bootflow                        -     204  =
  +204
>                  imagemap_record                              -     180  =
  +180
>                  bootm_run_states                          2256    2436  =
  +180
>                  imagemap_create                              -     176  =
  +176
>                  bootflow_cmdline_set_arg                     -     164  =
  +164
>                  imagemap_cleanup                             -     136  =
  +136
>                  _u_boot_list_2_uclass_driver_2_imagemap       -     120 =
   +120
>                  _u_boot_list_2_driver_2_bootmeth_openwrt       -     120=
    +120
>                  imagemap_lookup                              -     112  =
  +112
>                  bootflow_cmdline_set                         -      76  =
   +76
>                  openwrt_bootmeth_ops                         -      56  =
   +56
>                  alist_uninit                                 -      48  =
   +48
>                  openwrt_bootmeth_bind                        -      44  =
   +44
>                  openwrt_check                                -      36  =
   +36
>                  imagemap_post_probe                          -      36  =
   +36
>                  fit_image_get_data                         188     224  =
   +36
>                  openwrt_bootmeth_ids                         -      32  =
   +32

Adding 5K or so isn't unreasonable, but I'd still suggest looking around
to see if there's any easy optimizations.

> > There's:
> > https://lore.kernel.org/u-boot/20260217192000.GH2747538@bill-the-cat/
> > And I didn't see anything about that.
>=20
> Re: boot: add OpenWrt boot method and on-demand FIT loading
>=20
> (Re: not enabled on any board nor in sandbox)
> In my new series I'll add the OpenWrt One as a sample board and also
> enable the new features on the BananaPi R3.

OK, thanks.

> Should I also enable the imagemap base feature in sandbox as well so the
> unit tests can easily be run?

Absolutely.

> (Re: splitting series)
> There aren't any actual fixes part of the series. Of course, some
> smaller changes and refactoring to create the helpers needed by
> imagemap and the bootmeth could be broken out as indidivual patches
> sent separately in advance, but they wouldn't have any in-tree users
> at this point. Eg.
>  - mtd: set flash_node on DT-created partitions
>  - mtd: add mtd_read_skip_bad() helper
>  - cmd: ubi: add ubi_part_from_mtd()
>  - cmd: ubi: export ubi_find_volume()

Maybe I'm mis-recalling but some of the changes seemed to be worded /
implied they were fixing existing problems, not adding things to be used
later.

But also, those changes should have some impact on size growth? To make
sure to look at other platforms as well. The goal is not zero growth,
but rather explainable growth. I'm not asking you to do the world
before/after that I do, but making use of qconfig.py -f CONFIG_FOO to
find boards that enable code you're changing and then checking them and
seeing if it's tens of bytes or hundreds of bytes of growth on something
unsupported (and likely never supported) by OpenWrt is important.

> I also think it makes sense to discuss the new feature (not part of the
> original RFC series) to store dm-verity parameters for IH_TYPE_FILESYSTEM
> subimages in the FIT structure separately, and that would start with
> discussing the FIT spec amendment for it:
>=20
> https://github.com/open-source-firmware/flat-image-tree/pull/37

Yes, that's a separate discussion.

> > There's:
> > https://lore.kernel.org/u-boot/20260217190554.GF2747538@bill-the-cat/
>=20
> Re: test: boot: add image_loader unit tests
> (Re: AI fixes in the wrong commit)
> Yes, this was an oversight and I've of course folded in that change,
> and later, upon Simon's comment, switched to use alist instead of a
> fixed-size array anyway.

> > https://lore.kernel.org/u-boot/20260219153100.GL3233182@bill-the-cat/
> > Which go together and I think "human written only commit message" might
> > well be a good policy as it helps ensure the patch in question has been
> > read and summarized by the human author (and enforcement is on the
> > honor system).
>=20
> While it was very useful to use an LLM for quickly drafting the intial
> RFC and receive feedback for the overall approach, it became less and
> less useful at later stages -- instead of ending of micro-managing the
> LLM for each little change and fix it's easier to just do it yourself
> from some point on.
>=20
> So what you are going to see in v2 surely still got some onchanged lines
> of code, comments and parts of commit messages which have intially been
> fabricated with the help of the LLM, but most of it is by now the work
> of a human (me).

OK.

> Regarding the commit messages, I get the idea of enforcing a
> human-written message, however, when it comes to the use of English
> language (I'm not a native speaker) I think the use of things like
> deepl.com does create more benefit than potential damage even though it
> can also be considered an AI/LLM tool.

This is a project that was started by Germans and initially contributed
to by other Europeans and has an extremely long history of global and
non-native-English speakers contributing, I would much rather see some
imperfect English than overly polished and often useless LLM messages.

It is sometimes joked that LLMs speak great Manager-English, but that's
not what we want here.

> > Finally there's:
> > https://lore.kernel.org/u-boot/20260217191536.GG2747538@bill-the-cat/
> > where I was hoping for more feedback.
> Re: reuse imageloader (by now renamed to "imagemap") in SPL
>=20
> First of all, I don't have any boards which use SPL. All modern
> platforms I deal with use U-Boot as "Non-Trusted Firmware (BL33)" or
> the OpenSBI equivalent of that on platforms using RISC-V.
>=20
> Especially regarding the UBI part, the implementation intended for SPL
> is way too basic to be useful as imagemap backend.
>=20
> For BLK (ie. MMC) or SPI-NOR it would be a possibility to reuse
> imagemap in SPL -- but (as I've replied earlier) I don't think it
> makes sense to merge it with the exising FIT reader in SPL for the
> reasons I've explained:
> |> So there really isn't much overlap other than the fact that there is a
> |> struct with a priv pointer and a .read callback, and even that uses a
> |> different addressing parameter (sectors vs. bytes).

You should go back in to that thread, so the other interested parties
see this as well and also keep in mind that you're adding something that
may be useful in other cases, not that you should use what we have today
instead. Especially for the cases where people are trying to add
less-basic support in SPL for various flashes.

> > I don't recall if we came to a conclusion, or just look again later,
> > about if we should have this functionality both exposed via "bootm" and
> > the new distro bootmeth, or not. It might be "talk more" and I'm leaning
> > currently on saying the migration path is something openwrt holds
> > downstream while getting things migrated?
>=20
> That's also what I understood from our discussion. Adding new cmdline
> features to 'bootm' can be considered a liability, so I've dropped that
> from the v2 series and only use the direct-storage FIT loading in
> bootmeth_openwrt. We can still add the 'bootm' features as an
> intermediate step to easy migration of all our boards as downstream
> patch (and later remove it again once all boards and features work with
> the bootmeth).

OK, thanks.

> > And in sum, this series will need to be split up a bit I strongly
> > suspect. Being clear about the end goal is good but implementing each of
> > the backends as well in a single series will make this too large to
> > review.
>=20
> The current state of the series looks pretty much like what I've pushed
> to Github for the sake of getting CI exposure.

I don't look at all the emails it generates and sends to me, but it was
20 commits at least?

> Do you agree with the submission strategy drafted below?
>=20
> Commits (reverse git order, starting from the one directly
> on top of u-boot.git master branch, ie. in the order of
> the patches to be submitted starting with the first to be
> sent).
>=20
> SERIES 1: dm-verity paramters for FIT images
>=20
>  - boot: fit: support generating DM verity cmdline parameters
>  - doc: fit: add dm-verity boot parameter documentation
>=20
> To be discussed together with
> https://github.com/open-source-firmware/flat-image-tree/pull/37

This is a stand-alone thing yes, and should wait for that discussion to
be resolved / merged.

> ---
> SERIES 2: imagemap storage abstraction
>=20
>  - boot: add imagemap on-demand loading abstraction
>  - boot: imagemap: add block device backend
>  - doc: imagemap: document on-demand loading framework
>  - test: boot: add imagemap unit tests
>=20
> This would be a meaningful series together with enabling imagemap
> in sandbox so the unit tests are run there.
> ---
> SERIES 3: imagemap MTD and UBI backends
>=20
>  - mtd: add mtd_read_skip_bad() helper
>  - boot: imagemap: add MTD backend
>  - mtd: set flash_node on DT-created partitions
>  - cmd: ubi: export ubi_find_volume()
>  - cmd: ubi: add ubi_part_from_mtd()
>  - boot: imagemap: add UBI volume backend
>=20
> This would be one or two small series adding the backends.
> Maybe including another commit completing the documentation
> to cover the newly added backends.
> ---
> single PATCH
>=20
>  - boot: fit: support on-demand loading in fit_image_load()
>=20
> This would be good to be discussed individually as it is
> the most intrusive change and needs the most eyeballs.
> ---
> SERIES 4: OpenWrt boot method
>=20
>  - boot: bootmeth: add OpenWrt boot method skeleton
>  - boot: bootmeth: openwrt: implement read_bootflow
>  - boot: bootmeth: openwrt: implement boot via imagemap
>  - boot: bootdev: add MTD boot device
>  - boot: bootdev: add UBI boot device
>  - doc: bootstd: add OpenWrt boot method documentation
>  - board: mediatek: add OpenWrt One support
>  - mt7986a-bpi-r3: add OpenWrt boot method

This kind of split doesn't help with review because series 2, 3 and 4
have to be seen as a whole for them to be useful and understood. It had
sounded like earlier there was support for block devices (eMMC/SD for
example) but that's not included yet? I was going to suggest excluding
them, or just including the smallest backend support to start with, and
follow-up with other backends. So I'd rather see 2, 3 and 4 as a single
series than split up, so that it's possible to understand real usage.
Thanks.

--=20
Tom

--B/wRfG+91yzR1ZSe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ90qAAKCRAr4qD1Cr/k
ChSNAP4shNJlU9T426Belgze7jd34oxHbufGQ8+TSxH1NJD0wQEAgYJSN/FGSV2J
mKrXVaTWh6bXUiUOHLCn4DxGTqV/6g8=
=qSHZ
-----END PGP SIGNATURE-----

--B/wRfG+91yzR1ZSe--
