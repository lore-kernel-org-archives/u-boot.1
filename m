Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D735F483F2
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F4C83FED;
	Mon, 23 Mar 2026 21:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FVot6pES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8054383FED; Mon, 23 Mar 2026 21:08:04 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC1C83A91
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-67bb04151dcso2278961eaf.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774296479; x=1774901279; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o48Pjkys9XGxGQaxsUMhz9AhjcKN1t2N+hJcNfsuF+g=;
 b=FVot6pES5KL73eZp+eu+kALEtYr8u1FrKYVwqZiZHW54mLSU3y7WP0pn2tjrz7GueP
 wwNcLxmJfpIvQ0Gf8LnNY+Mw4l7L561Lnc0IgvKzigJthuj95HL2FN8IuVneqSFRGBJN
 Ov8cwypNhB3b92gVvbUt7N5M5GadJkbt/t9vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296479; x=1774901279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o48Pjkys9XGxGQaxsUMhz9AhjcKN1t2N+hJcNfsuF+g=;
 b=chxbJ/xNGjB5InE/4moALIoSUujZnGdtkp12HWM9oX+pWKrz4fZeGof0kKIiRN3TnQ
 cf+rX1bsrDido2mMQpdzP4E2YSe1jqHxWOdx51BHX6SYqm10opVDRRsnhXB1pNMZySg/
 Nmyl6hyQytRWK4AOip/3/fwvBOdHkzTHhYyUxGrKIvObbBFPCWIr0Lwwig6xhwlBA5k/
 6Qf3lBibTS6u6qyxmpMBBWtlqeqp/3MqiK6mdROquXknMSDsaIjwhXSd94UarLu3kIUp
 jtGykF1EBxxZQUr5kisOb4kcmaCAdWX7aoTo9j/c4Cy3S0BbGgvC4+LoogRN8lQELnwC
 a3Rw==
X-Gm-Message-State: AOJu0YyIXNB+0/25RNbSjptfBRJi1Yub99bItj0B6HqVP5nnPOTWL4Xy
 65VrylI9ESJpMRVyjvIhjRHXZaDJBbjQWpJY3xmasyBzSXRNr24aK81jN3m4lANbHSp6c/exmIV
 VSZb13bA=
X-Gm-Gg: ATEYQzxi+aJijTWGVPW4yyqfs13+w1b9ykmqpZqwD1ygfcnBckvEaNzDsbh4sn0BKnn
 ZQ43LWuxaNK9kBGzI/wxKIdyTB8B+es0Hth5hTMHZ5mok6q/i8le/bpBP8p6mk6RKNqrN4mY6Yu
 toZ4GFL0lHY400/yONnp1rQCrVcc9x6+ubYSFS3BW+Nsesev6N6uQQ4+LsKq9B/gXWxmpn2LHYh
 4p2V4OLjfSCF6i8lH9yT7pqsquKNm6fsq/FOd7ZHeu1/DDgJHdImte6gy7grFUNyJyunDw64rzF
 PzwABEbJ57MyFZQyD0Y4yIF0+2mVL1/KozUyQlCs5gDII5ZnjlUV8/rw8GhpnUvctPqwNpt0B9V
 4zCFSJZT1s4EcQtnpuvQQHSz44wZDlic8VR275elB+6HUSaHLDbRDnmnsWlCJIP97XtSVWS2qFY
 hEum3ShXbIvKRGmdhS3IWS020/mfdCEUNYhcH6V0ZG6jL1nZK6Jh5er+c38OzTvMXfqPNIVLLAg
 TdjFCBIno5nQ+2hlNlPO0noilF/wSAkSoxgl0Fln09Pb3Yz
X-Received: by 2002:a05:6820:81d2:b0:67b:d547:26dd with SMTP id
 006d021491bc7-67c22eca784mr11964029eaf.21.1774296479300; 
 Mon, 23 Mar 2026 13:07:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252c892dsm7165373eaf.4.2026.03.23.13.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:07:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:07:56 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de, Leo Yu-Chi Liang <ycliang@andestech.com>,
 rick@andestech.com, hal.feng@starfivetech.com, jamie.gibbons@microchip.com
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-ID: <20260323200756.GK502704@bill-the-cat>
References: <20260317060146.3983817-1-ycliang@andestech.com>
 <bb87214b-8b1a-428c-a339-2e632ebc2b15@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PiykUc0uRjXv5akn"
Content-Disposition: inline
In-Reply-To: <bb87214b-8b1a-428c-a339-2e632ebc2b15@freeshell.de>
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


--PiykUc0uRjXv5akn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:20:02PM -0700, E Shattow wrote:
> Hi Tom,
>=20
> There are some Fixes tags for master in this pull request applied to
> next and not yet applied to master, noted inline below.
>=20
> On 3/16/26 23:01, Leo Yu-Chi Liang wrote:
> > Hi Tom,
> >=20
> > The following changes since commit 841856ed9675b26ec517fdd00b5cc0aef8db=
508e:
> >=20
> >   Merge patch series "Add PCIe Boot support for TI J784S4 SoC" (2026-03=
-16 08:24:18 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> >=20
> > for you to fetch changes up to b51e59c8b34c780e28728bc0cb58783855c7ffbf:
> >=20
> >   riscv: Add support for BeagleV-Fire (2026-03-17 11:39:18 +0800)
> >=20
> > CI result shows no issue: https://source.denx.de/u-boot/custodians/u-bo=
ot-riscv/-/pipelines/29548
> > ----------------------------------------------------------------
> > - board: starfive: Add Xunlong OrangePi RV
> > - board: starfive: Add VisionFive 2 Lite
> > - board: beagle: Add BeagleV-Fire
> > ----------------------------------------------------------------
> > E Shattow (5):
> >       board: starfive: visionfive2: Add Orange Pi RV selection by produ=
ct_id
> >       configs: starfive: Add Orange Pi RV to visionfive2
> >       doc: board: starfive: Add Xunlong OrangePi RV
>=20
> >       doc: board: starfive: jh7110 common give build output dir by env =
not arg
>=20
> commit 24662f698f5ad6f444e6dc437c0b5a932726a6ef
> Fixes: 8304f3226700 ("doc: board: starfive: update jh7110 common
> description")
>=20
> >       doc: board: starfive: jh7110 common update OPENSBI build env refe=
rence
>=20
> commit 1edeb52086c6e160d93d86386505e6cc6ce1457c
> Fixes: 8304f3226700 ("doc: board: starfive: update jh7110 common
> description")
>=20
> >=20
> > Hal Feng (7):
> >       eeprom: starfive: Simplify get_ddr_size_from_eeprom()
>=20
> commit 6015c98be50f2fc571c294d2f2b0768212fb7e99
> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
>=20
> >       eeprom: starfive: Correct get_pcb_revision_from_eeprom()
>=20
> commit 78253aeeecdfea4c71779905ff2b400fa7400b1c
> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
>=20
> >       eeprom: starfive: Support eeprom data format v3
> >       pcie: starfive: Add a optional power gpio support
> >       configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST
> >       board: starfive: spl: Support VisionFive 2 Lite
> >       board: starfive: visionfive2: Add VisionFive 2 Lite fdt selection
> >=20
> > Jamie Gibbons (1):
> >       riscv: Add support for BeagleV-Fire
> >=20
> >  arch/riscv/Kconfig                                 |   4 +
> >  arch/riscv/cpu/jh7110/spl.c                        |   2 +-
> >  arch/riscv/include/asm/arch-jh7110/eeprom.h        |  13 ++-
> >  board/beagle/beaglev_fire/Kconfig                  |  43 ++++++++
> >  board/beagle/beaglev_fire/MAINTAINERS              |   7 ++
> >  board/beagle/beaglev_fire/Makefile                 |   6 ++
> >  board/beagle/beaglev_fire/beaglev_fire.c           | 117 +++++++++++++=
++++++++
> >  board/starfive/visionfive2/spl.c                   |   6 ++
> >  board/starfive/visionfive2/starfive_visionfive2.c  |   4 +
> >  .../starfive/visionfive2/visionfive2-i2c-eeprom.c  |  64 ++++++-----
> >  configs/beaglev_fire_defconfig                     |  29 +++++
> >  configs/starfive_visionfive2_defconfig             |   2 +-
> >  doc/board/starfive/index.rst                       |   1 +
> >  doc/board/starfive/jh7110_common.rst               |  11 +-
> >  doc/board/starfive/orangepi_rv.rst                 |  35 ++++++
> >  drivers/pci/pcie_starfive_jh7110.c                 |   8 ++
> >  include/configs/beaglev_fire.h                     |  57 ++++++++++
> >  17 files changed, 375 insertions(+), 34 deletions(-)
> >  create mode 100644 board/beagle/beaglev_fire/Kconfig
> >  create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
> >  create mode 100644 board/beagle/beaglev_fire/Makefile
> >  create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
> >  create mode 100644 configs/beaglev_fire_defconfig
> >  create mode 100644 doc/board/starfive/orangepi_rv.rst
> >  create mode 100644 include/configs/beaglev_fire.h
> >=20
> >  Best regards,
> >  Leo
>=20
> I note that there may be other authors' contributions applied to next
> with Fixes tags for master that are not part of this pull request, not
> highlighted in my reply here.

Thanks for looking at this. To be clear and to repeat what I said on
IRC, we don't have the formal process (nor tooling nor human backup)
that the linux kernel has about fixes tags and what they get applied to.
It's up to individual custodians to decide if a Fixes commit is worth
pushing to a pending release, once the next window is open, or holding
off for more testing, as it's not serious enough of a problem. That
means it's also up to a contributor to follow-up if they thought
something should really go to master instead (and custodians should be
uinsg b4 and b4 ty, so contributors know where something is applied,
once it is applied).

--=20
Tom

--PiykUc0uRjXv5akn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacGdlQAKCRAr4qD1Cr/k
CnVbAP9VO1SS3zlRK+JgbK6RGMQFC12g5/cH9p9A995Zl5tXpwEA4C81CbrnxG8P
oNlvAiLZEZA5dne0lYExqEad+rENcwM=
=2SSZ
-----END PGP SIGNATURE-----

--PiykUc0uRjXv5akn--
