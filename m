Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E36AC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9542888828;
	Wed, 22 May 2024 16:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IqRLFuf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A2A88836; Wed, 22 May 2024 16:15:33 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC378847C
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6a8dcc794fdso4913526d6.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716387330; x=1716992130; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YaDEBQJ8Q0Z18GBRqUJlvfEVT7sBeQgmxlIiIG9KzfQ=;
 b=IqRLFuf3fNAeohGJl7XKxmf4UfhBV2Qw8OTamTJm5pZ6AysGGVSqW2YptFjZFcqRxw
 QyoPpfdEBUBXN3nFPPaG7Z2W8EXITxXYAQ9bquhGHT6uf+O9LrbdhPZUgBMXXRM4CbBb
 MhnR7dtpwM2UA4eys2J9/HqUsOYhgVpNrw56I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716387330; x=1716992130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaDEBQJ8Q0Z18GBRqUJlvfEVT7sBeQgmxlIiIG9KzfQ=;
 b=FdwRlMvcMumOdGeRKxbbJRzXefDE1UtAdOR2utyAis9hpDpL7tBVJPdIaiujEJS4jV
 BZedqdILSzMkAkVTTC29lg0vVtR+K5QmEK5lvu2PJl2eaQiF3sjuUwFfb3OZy7tuuUTg
 E9Nmq+iybLAbUKspwEgil1TYTZGbwyz2H8DfS9vqcIYR4Cd1nYi1NDkGjK2uWwD8Kka9
 I+ohQWsza8DBIyD5AXS1whFSKnZZ+E3NW7pskRVyMg2HXdHLEvjp5yapXI4e8vpOH2w9
 bZOAXTx7rn+JjL5RjVi5ZOdkwqf/qS9yY9uiCRhpZj1/94K5nvZR+L8MgD5pqBtw6KLe
 o1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb0G5cPfFXej2axZqe/sHwAQRZMSpDsWszg86NsgDGy1GhHJAvCytj2R9p/zZ7R+uHB+4ZQUTm55dk9QopJkxTUviv+Q==
X-Gm-Message-State: AOJu0Yyk/hm624pdWgB/r/I7ryoRApVUqSRnV6BwaAUmW9WRFla6aFma
 KKb7E2Vai2k/phi72r/USVcjR44ahaepsdvYvqX2kneAGAxL+88UNl6uEmKDID0=
X-Google-Smtp-Source: AGHT+IEtEiq6fzERpJmYNfETLYiEeS22IhIatlt4NoqIy7kXcKZ1is2QNbbWpkvjUpd7P/ZIfEZ5ig==
X-Received: by 2002:a05:6214:5902:b0:6aa:12cc:5adb with SMTP id
 6a1803df08f44-6ab8087cde2mr19072656d6.33.1716387329830; 
 Wed, 22 May 2024 07:15:29 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cd266sm133500886d6.80.2024.05.22.07.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:15:29 -0700 (PDT)
Date: Wed, 22 May 2024 08:15:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, jonas@kwiboo.se
Subject: Re: [PATCH 00/10] rockchip: px30: migrate to common bss and stack
 addresses + UART fixes for evb-px30
Message-ID: <20240522141524.GH2568172@bill-the-cat>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
 <20240521180444.GC2568172@bill-the-cat>
 <c9a78f7a-5b63-4d37-93d4-2c6bd8db0076@cherry.de>
 <2148002.OBFZWjSADL@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="87gEAgqaTJFRnYBk"
Content-Disposition: inline
In-Reply-To: <2148002.OBFZWjSADL@diego>
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


--87gEAgqaTJFRnYBk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 02:14:47PM +0200, Heiko St=FCbner wrote:
> Am Mittwoch, 22. Mai 2024, 10:39:25 CEST schrieb Quentin Schulz:
> > Hi Tom,
> >=20
> > On 5/21/24 8:04 PM, Tom Rini wrote:
> > > On Tue, May 21, 2024 at 07:39:53PM +0200, Quentin Schulz wrote:
> > >> PX30 Ringneck ran out of memory in the allocation pool of U-Boot pro=
per
> > >> pre-reloc. Something needed to be done. Jonas did migrate a few SoCs
> > >> already to this common bss+stack addresses so it made sense to follow
> > >> the same route for one additional SoC: PX30.
> > >>
> > >> While at it, also fix a few issues related to UART on the PX30 Mini =
EVB
> > >> I could test.
> > >>
> > >> Boot (to U-Boot CLI) tested on PX30 Ringneck and PX30 Mini-EVB.
> > >>
> > >> Thanks to Jonas for hinting where to look at.
> > >>
> > >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >> ---
> > >> Quentin Schulz (10):
> > >>        rockchip: px30: default TPL_SYS_MALLOC_F_LEN to 0x600 on PX30=
 Kconfig level
> > >>        rockchip: Use common bss and stack addresses on PX30
> > >>        rockchip: ringneck_px30: Use common bss and stack addresses
> > >>        rockchip: evb-px30: Use common bss and stack addresses
> > >>        rockchip: firefly-px30: Use common bss and stack addresses
> > >>        rockchip: odroid-go2: Use common bss and stack addresses
> > >>        rockchip: px30-core-*: Use common bss and stack addresses
> > >>        rockchip: px30: make UART pinmux accessible to TPL/SPL DTB
> > >>        rockchip: evb-px30: do not remove pinctrl nodes from SPL DTB
> > >>        rockchip: evb-px30: make UART5 the debug UART
> > >>
> > >>   arch/arm/dts/px30-u-boot.dtsi                 | 16 ++++++++++++++++
> > >>   arch/arm/mach-rockchip/px30/Kconfig           |  8 +++++++-
> > >>   configs/evb-px30_defconfig                    | 23 +++++----------=
--------
> > >>   configs/firefly-px30_defconfig                | 19 +++------------=
----
> > >>   configs/odroid-go2_defconfig                  | 19 +++------------=
----
> > >>   configs/px30-core-ctouch2-of10-px30_defconfig | 19 +++------------=
----
> > >>   configs/px30-core-ctouch2-px30_defconfig      | 19 +++------------=
----
> > >>   configs/px30-core-edimm2.2-px30_defconfig     | 19 +++------------=
----
> > >>   configs/ringneck-px30_defconfig               | 19 +++------------=
----
> > >>   9 files changed, 46 insertions(+), 115 deletions(-)
> > >> ---
> > >> base-commit: a7f0154c412859323396111dd0c09dbafbc153cb
> > >> change-id: 20240521-px30-2024-07-rc-7136f6241d29
> > >=20
> > > As I assume we want to fix the platforms for v2024.07, is this the le=
vel
> > > of config changes everyone is comfortable with on the platforms? Or
> > > should we just go with the minimum for release and the rest to -next?
> > >=20
> >=20
> > I can tell you that Ringneck doesn't work anymore on v2024.07-rc, but=
=20
> > the PX30 Mini EVB was still reaching U-Boot CLI without the changes. I=
=20
> > don't know about the other boards.
> >=20
> > So I could split this into two series, one for master, one for next.
> >=20
> > I could suggest: patch 1 to 3 in master, the rest in next. Patch 1 is=
=20
> > just moving things around. Patch 2 is doing nothing if nobody uses=20
> > ROCKCHIP_COMMON_STACK_ADDR and SPL_SHARES_INIT_SP_ADDR (which is the=20
> > case for px30 boards). Patch 3 is for fixing Ringneck, which I know is=
=20
> > broken.
> >=20
> > Heiko having access to the Odroid Go2, maybe he could test without my=
=20
> > patches and see if it reaches the CLI to know if we should pull it in=
=20
> > for master as well.
>=20
> I did that yesterday evening. The Odroid Go2 also reached u-boot CLI
> and also booted without these changes. So I guess it's small enough
> or whatever.
>=20
> So at least the Go2 is fine on 2024.07-rc3 either way with or without
> this series.

OK, thanks. I'll grab 1-3 for master shortly then.

--=20
Tom

--87gEAgqaTJFRnYBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZN/fwACgkQFHw5/5Y0
tyxCngv/S4TCBeCGuTzvQMKNalz+0C5Xb96Ciw4SI87v/CpqiGWB7KaNSy9ZxnzD
He0wLcJ/A1dw7vt0HgC/+UuF7h4IHWWNMnE13yBL7EE0JkhsCdSQ9j9N47Hksfki
C3BpSY7E5iJ5zUqOK/qHMHVNhSJ/N+vqKM6P5uiSzSaMf1AMlbSGONfEmEzZfHZX
0ArEX/ZjD+VWhc5a0HJ1oZNK8Hb2wOcv4RrGi833mnGWCrsZJhBbkadi9AxVu54S
mdos41ghnyJeZbcUAvxkx9BnKNNuVMMLXeJ6kkmTI1HpsH4PUC6w41YEQts99tkj
1GtHmPZRD9pyi5Suic9YpUbRNgNk76Myj4+qfPvu2TY8SlB8mC38HC/gbe6xeJ6w
vUFOrV0AlPSc/LZXktA7EMG+VdgT/R0Dg/dgIlDgWgjitYWqDepMWizj8ZaUIj+a
O90JB3bRg2gfNvoQhyWEyBVzkcXW3FSIx3YhZMPAPuPnOIz0X1MHMFEWxrT91sBE
1BIcNbIW
=djIM
-----END PGP SIGNATURE-----

--87gEAgqaTJFRnYBk--
