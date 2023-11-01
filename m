Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F6DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 23:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DF6287006;
	Thu,  2 Nov 2023 00:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IqOnYo28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA678272A; Thu,  2 Nov 2023 00:21:54 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543CE87008
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 00:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67131800219so2318356d6.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698880902; x=1699485702; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yijdr9fgBBFUBVk/DxyKd9z60UlpnuZdpsMOteRondk=;
 b=IqOnYo28dVvyKHSqYiCwHHYN4qQmBYJBw/W9WCyPFyrXzfAhZVxqN744H3t5ZkDWN3
 DtWK/HqA5HUWJnH7f9ZgEtlMV2FIs4HRDeIAh4SMR+MKN1ZOT6ib8xoe/o+Q1RUd5sLz
 /+9NFdb8afwTBNvPmJ2iOM6d0snE+lN4DNK00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698880902; x=1699485702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yijdr9fgBBFUBVk/DxyKd9z60UlpnuZdpsMOteRondk=;
 b=wyEK4BBMahfD14OpG/uzU0m3nPhccZmDvnk45RH3Xh1NPJWFORwWxRqabyy7jlQaKA
 AIwY6jCSqk29ZDgAs4efXEOtIlRIlg1VfcbpLMiWKr9WXVK9KdkcyBGDLhX851w2nZlc
 tEysTOt9Md8lRAlwmtAKx569Wq7dIS/WORQvA6uC9sYKiyjnCp9F1Oh76/MF+VBRCOF3
 Wj/XkZehQdhuCn/B8ThRCnFerSZ10IRDpMc95AnLSUCsb/c3pal9zk7SeIbVlLIANTdi
 VQXUfAFDi7Y/U0ZwWR+ywhsWl6S8ojMI2kjrvAuEExVgJ0Iw9NtQhKvWXZeyOuP1PpCo
 yIFA==
X-Gm-Message-State: AOJu0Ywt2eh9G0CnPNMAz716QYGLRt22nfkmdWLC7Bo7FWetOQ2VIGvx
 ILy1J4OHXSHBb7X/E7Ifxynsug==
X-Google-Smtp-Source: AGHT+IEEplEkTMAs8CJuNGjHcFvJghpqhUqXXhBlRUtAO53pJXpSFlRiMcNLER5setpRsSyVZ+lhvg==
X-Received: by 2002:a05:6214:20e8:b0:671:2c4f:3e37 with SMTP id
 8-20020a05621420e800b006712c4f3e37mr15842113qvk.19.1698880901955; 
 Wed, 01 Nov 2023 16:21:41 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 cr6-20020ad456e6000000b006564afc5908sm1885794qvb.111.2023.11.01.16.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 16:21:41 -0700 (PDT)
Date: Wed, 1 Nov 2023 19:21:39 -0400
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de, nm@ti.com
Subject: Re: [PATCH 1/2] board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
Message-ID: <20231101232139.GC496310@bill-the-cat>
References: <20231031133732.265589-1-w.egorov@phytec.de>
 <20231101155734.5mzpvq4xcm2o5emm@dhruva>
 <33df3edd-3ede-4cb9-83b0-984c1cada5bb@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c5vyEr76Kw76FwTp"
Content-Disposition: inline
In-Reply-To: <33df3edd-3ede-4cb9-83b0-984c1cada5bb@phytec.de>
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


--c5vyEr76Kw76FwTp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 07:23:24PM +0100, Wadim Egorov wrote:
> Hi Dhruva,
>=20
> Am 01.11.23 um 16:57 schrieb Dhruva Gole:
> > Hi,
> >=20
> > On Oct 31, 2023 at 14:37:31 +0100, Wadim Egorov wrote:
> > > Add basic support for PHYTEC phyCORE-AM62x SoM.
> > >=20
> > > Supported features:
> > >    - 2GB DDR4 RAM
> > >    - eMMC Flash
> > >    - OSPI NOR Flash
> > >    - external uSD
> > >    - Ethernet
> > >    - debug UART
> > >=20
> > > Product page SoM: https://www.phytec.com/product/phycore-am62x
> > >=20
> > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > ---
> > >   arch/arm/dts/Makefile                         |    4 +-
> > >   .../arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi | 2190 ++++++++++++++=
+++
> > >   arch/arm/dts/k3-am62-phycore-som.dtsi         |  324 +++
> > >   .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  229 ++
> > >   arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   |  266 ++
> > >   arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  532 ++++
> > >   arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |  134 +
> > >   arch/arm/mach-k3/Kconfig                      |    1 +
> > >   board/phytec/phycore_am62x/Kconfig            |   52 +
> > >   board/phytec/phycore_am62x/MAINTAINERS        |   15 +
> > >   board/phytec/phycore_am62x/Makefile           |    8 +
> > >   board/phytec/phycore_am62x/board-cfg.yaml     |   36 +
> > >   board/phytec/phycore_am62x/phycore-am62x.c    |   59 +
> > >   board/phytec/phycore_am62x/phycore_am62x.env  |   23 +
> > >   board/phytec/phycore_am62x/pm-cfg.yaml        |   12 +
> > >   board/phytec/phycore_am62x/rm-cfg.yaml        | 1088 ++++++++
> > >   board/phytec/phycore_am62x/sec-cfg.yaml       |  379 +++
> > >   configs/phycore_am62x_a53_defconfig           |  116 +
> > >   configs/phycore_am62x_r5_defconfig            |  131 +
> > >   include/configs/phycore_am62x.h               |   15 +
> > >   20 files changed, 5613 insertions(+), 1 deletion(-)
> > >   create mode 100644 arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
> > >   create mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
> > >   create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.d=
tsi
> > >   create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
> > >   create mode 100644 arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> > >   create mode 100644 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> > >   create mode 100644 board/phytec/phycore_am62x/Kconfig
> > >   create mode 100644 board/phytec/phycore_am62x/MAINTAINERS
> > >   create mode 100644 board/phytec/phycore_am62x/Makefile
> > >   create mode 100644 board/phytec/phycore_am62x/board-cfg.yaml
> > >   create mode 100644 board/phytec/phycore_am62x/phycore-am62x.c
> > >   create mode 100644 board/phytec/phycore_am62x/phycore_am62x.env
> > >   create mode 100644 board/phytec/phycore_am62x/pm-cfg.yaml
> > >   create mode 100644 board/phytec/phycore_am62x/rm-cfg.yaml
> > >   create mode 100644 board/phytec/phycore_am62x/sec-cfg.yaml
> > >   create mode 100644 configs/phycore_am62x_a53_defconfig
> > >   create mode 100644 configs/phycore_am62x_r5_defconfig
> > >   create mode 100644 include/configs/phycore_am62x.h
> > >=20
> > > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > > index 55aceb51cd..8b371266dc 100644
> > > --- a/arch/arm/dts/Makefile
> > > +++ b/arch/arm/dts/Makefile
> > > @@ -1383,7 +1383,9 @@ dtb-$(CONFIG_SOC_K3_AM625) +=3D k3-am625-sk.dtb=
 \
> > >   			      k3-am625-beagleplay.dtb \
> > >   			      k3-am625-r5-beagleplay.dtb \
> > >   			      k3-am625-verdin-wifi-dev.dtb \
> > > -			      k3-am625-verdin-r5.dtb
> > > +			      k3-am625-verdin-r5.dtb \
> > > +			      k3-am625-phyboard-lyra-rdk.dtb \
> > > +			      k3-am625-r5-phycore-som-2gb.dtb
> > Thanks for upstreaming Wadim!
> >=20
> > However I would prefer that you split all these patches into smaller
> > chunks for each file (preferrably) or group together files that have
> > like 20-30 lines of changes.
>=20
> Hm, seems to be difficult and not really reasonable to split like that.
> The big files are generated files or copy pasted from TI's evm. So I do n=
ot
> think they need a big attention in the review process.
>=20
> - All yaml files are identical to TI's evm
> - k3-am62-phycore-som-ddr4-2gb.dtsi generated with TI's SysConfig DDR Tool
> - k3-am62-phycore-som.dtsi & k3-am625-phyboard-lyra-rdk.dts are 1:1 copies
> from vanilla Linux tree
>=20
> The rest is pretty small and reviewable IMO.
>=20
> I agree, I should have created a cover letter. I can do that in the next
> series.
>=20
> Please let me know if you still want me to split it into more patches.
> But it would be nice if you could tell me how to split it exactly without
> ending up with broken pieces.

Yes, I don't see the value in splitting this up further, but we do need
to note where the upstream dts files are synced from.

--=20
Tom

--c5vyEr76Kw76FwTp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVC3X0ACgkQFHw5/5Y0
tyx91gv/YJlWqNZE88qENrNC20xz63x0XEC5Amcfjngkkoh7SNJR85CBMPeeNNxu
5yCDafBxrcbYX9JyG1sbIT9DFkNEntJ0+0ibpdk/KX4Q74n7TCQpxwvoPp1gRYiF
DCJy4fieVmDKmOAl11dpTTYs53ri9N8qNVV/Lt2hAuBbsuam/caPlSQ8ot2aYJ4h
KLgPzJ2MXCMc5RH+Q78k8ZYTYg8MUYl3VJ212GSYPnQE7A4XUx7dd4sDtuGu/ssa
pAVwEgBBOlrSs4LEls71QD6mt0/s+7sVGsBJZStG8kXCSMdXUkEadVVaGpj/slNj
U5RzkFQqcKAIFSGUDDbT9CyODWyUHgidklHZbr19dOXYX7VLfrdcCnKq1alSCMcJ
zYzSV3TvZDHAvBLKKpfoBuijnEfii2WzyW6vtZjXEJtpQ4EiwufOLy7uPXxeCXCE
M809MSrhduLoNbtGsX+nV1lyk0OioReVvNsdeixwi8Qrg2WGNKb9SoCqrWMctLB8
7fz0X0AK
=Kh7C
-----END PGP SIGNATURE-----

--c5vyEr76Kw76FwTp--
