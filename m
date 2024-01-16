Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493FFC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 14:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A8A8796E;
	Tue, 16 Jan 2024 15:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UoXx0bGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5076879A0; Tue, 16 Jan 2024 15:55:17 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B76487078
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 15:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5f0c0ca5ef1so96803347b3.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705416914; x=1706021714; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ckDj56g1IHS41679Eq/bP+N5g3VqiBu8P7zCE0IjftU=;
 b=UoXx0bGsDr8g+qI7Eo8UQxFSqma4XOCw7OPQUaqAFl//ZDnFRHAJ2ebR6Ws2miV427
 AKn5erd+1s/wEmYnrfI06Bf4iLHcUr56qG8CWfgS6J1djmEP2os/pU5zctDh2CRkCbc9
 hc8no6iDDUHNkxNQ+0dXP9Qvg/+B0+bAjVLPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705416914; x=1706021714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckDj56g1IHS41679Eq/bP+N5g3VqiBu8P7zCE0IjftU=;
 b=QnOQd+MhzjlJjOgfGingl5BEOkUzj/vO39Aj24nAYVgdmcblek7UvcVYE8x8bKqHcl
 jZyEG4XzwH3TflkXFppp9FSNbR2WXFie0Ej5Ldg67YZvdPAvvvCC4terD1nzo4WtxLTt
 8dhnITFm+JdFTKl3lI+hEgzlGQf/DQ7K9quAxaOGthbD50DvLUKk5m8vzNjYMYDKHloB
 dPGKD/8svq94iBJJWQJezUFzJvYFAX50r8mvqgBvW3hJ4yEb1Jo/sbskQOXSY/mVZhdy
 yl/avjJcb5heUBIwGDG2hK/OlJsYAbg5VdKt220K60c6ZKakLkcnHiuGOtfrBZd0/WQv
 Gn6A==
X-Gm-Message-State: AOJu0Yz5gNp8nbDPqll+0Gzmlmpz06xiWEDbnQBcZh9laiC2OQLos1D7
 7UN9XzDLQQfw/pnRvLZ+zSw7B7TpTGGAGw==
X-Google-Smtp-Source: AGHT+IGal1Admh0fAMyxS+LZfGcibNYTZ9yig0NpZR8TqNkLQBjN3BlMccm9esfknKuZ45Cwo0/KVQ==
X-Received: by 2002:a81:b61e:0:b0:5ff:52db:48c3 with SMTP id
 u30-20020a81b61e000000b005ff52db48c3mr859100ywh.85.1705416913609; 
 Tue, 16 Jan 2024 06:55:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 r200-20020a819ad1000000b005ff42feb3e3sm986797ywg.69.2024.01.16.06.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 06:55:12 -0800 (PST)
Date: Tue, 16 Jan 2024 09:55:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, nm@ti.com, upstream@lists.phytec.de
Subject: Re: [Upstream] [PATCH v4 0/2] *** Add support for phyCORE-AM62x ***
Message-ID: <20240116145510.GB12635@bill-the-cat>
References: <20231220091811.80373-1-w.egorov@phytec.de>
 <a6dda694-7451-4725-8fd7-bffb7498522b@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Qem8ozS5irNN55y"
Content-Disposition: inline
In-Reply-To: <a6dda694-7451-4725-8fd7-bffb7498522b@phytec.de>
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


--7Qem8ozS5irNN55y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 06:54:57AM +0100, Wadim Egorov wrote:

> Hello,
>=20
> is there something missing in this series for it to be applied?
> I would like to add support for a 2nd k3/am64x board based on this. So it
> would be nice to know if I can do it the same way or should wait for more=
 k3
> changes to come in first?

Yes, sorry, I'll pick this up soon.

>=20
> Regards,
> Wadim
>=20
> Am 20.12.23 um 10:18 schrieb Wadim Egorov:
> > v4:
> >    - Rebase on current next
> >    - Drop schema file overrides from binman
> >=20
> > v3: https://lists.denx.de/pipermail/u-boot/2023-December/539779.html
> > v2: https://lists.denx.de/pipermail/u-boot/2023-November/538971.html
> > v1: https://lists.denx.de/pipermail/u-boot/2023-October/535750.html
> >=20
> > Wadim Egorov (2):
> >    board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
> >    doc: board: phytec: Add phyCORE-AM62x
> >=20
> >   arch/arm/dts/Makefile                         |    4 +-
> >   .../arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi | 2190 +++++++++++++++++
> >   arch/arm/dts/k3-am62-phycore-som.dtsi         |  324 +++
> >   .../k3-am625-phyboard-lyra-rdk-u-boot.dtsi    |  166 ++
> >   arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts   |  266 ++
> >   arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  314 +++
> >   arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts  |  119 +
> >   arch/arm/mach-k3/am62x/Kconfig                |   17 +
> >   board/phytec/phycore_am62x/Kconfig            |   33 +
> >   board/phytec/phycore_am62x/MAINTAINERS        |   15 +
> >   board/phytec/phycore_am62x/Makefile           |    8 +
> >   board/phytec/phycore_am62x/board-cfg.yaml     |   36 +
> >   board/phytec/phycore_am62x/phycore-am62x.c    |   59 +
> >   board/phytec/phycore_am62x/phycore_am62x.env  |   23 +
> >   board/phytec/phycore_am62x/pm-cfg.yaml        |   12 +
> >   board/phytec/phycore_am62x/rm-cfg.yaml        | 1088 ++++++++
> >   board/phytec/phycore_am62x/sec-cfg.yaml       |  379 +++
> >   configs/phycore_am62x_a53_defconfig           |  115 +
> >   configs/phycore_am62x_r5_defconfig            |  130 +
> >   doc/board/phytec/index.rst                    |    1 +
> >   doc/board/phytec/phycore-am62x.rst            |  158 ++
> >   doc/board/ti/k3.rst                           |    1 +
> >   include/configs/phycore_am62x.h               |   15 +
> >   23 files changed, 5472 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/arm/dts/k3-am62-phycore-som-ddr4-2gb.dtsi
> >   create mode 100644 arch/arm/dts/k3-am62-phycore-som.dtsi
> >   create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
> >   create mode 100644 arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts
> >   create mode 100644 arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> >   create mode 100644 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> >   create mode 100644 board/phytec/phycore_am62x/Kconfig
> >   create mode 100644 board/phytec/phycore_am62x/MAINTAINERS
> >   create mode 100644 board/phytec/phycore_am62x/Makefile
> >   create mode 100644 board/phytec/phycore_am62x/board-cfg.yaml
> >   create mode 100644 board/phytec/phycore_am62x/phycore-am62x.c
> >   create mode 100644 board/phytec/phycore_am62x/phycore_am62x.env
> >   create mode 100644 board/phytec/phycore_am62x/pm-cfg.yaml
> >   create mode 100644 board/phytec/phycore_am62x/rm-cfg.yaml
> >   create mode 100644 board/phytec/phycore_am62x/sec-cfg.yaml
> >   create mode 100644 configs/phycore_am62x_a53_defconfig
> >   create mode 100644 configs/phycore_am62x_r5_defconfig
> >   create mode 100644 doc/board/phytec/phycore-am62x.rst
> >   create mode 100644 include/configs/phycore_am62x.h
> >=20
>=20

--=20
Tom

--7Qem8ozS5irNN55y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWmmMoACgkQFHw5/5Y0
tyzQ6wv6A0h6MStem1EL9vOiOZpCKZw1PtX6JKJqEkJmayDFEIqJSQ+sBBQyItRx
fP1B5pJqzvQUqyccxH7Ci2UXJKI5Iz+ejRlUTiN+9nohIujj1isqgXnmw4xurHu7
VRtGKU3pydBFpo7r39hCIyZQlW06wCMv2VJwkVHSERi92TQrnlDcvWja6S5P/WDt
VUc6H0dPDQ1WI8J6L1R/0wQyNkhHRhvkBvfPy0XwEiuBMtrBM1QaF+F6FnYFe9NK
zVqi/oEQbUmfqmbiGCzFjAGnm4/7ywWbB859JcQCE8T+FK32ilvXEFSvsMcO8HkB
VRs3XklYA0lrD8qmWwyMP9GvQ6coA58veHnyIW65XA43N9GYZj56jAWg3ueJa68n
mEs0By1yrvIuDbCcDbG/8tMsITTWfaSXw4V8QAY6CZmBBilf60kjOwRKFbRwmEzF
yBw1E2VDNHrjhVqtH/b4/IBie00VqszC/FNEo9hH1Cg2Zi5MSgZOErP788znKl2P
eKoHGFQC
=NY+w
-----END PGP SIGNATURE-----

--7Qem8ozS5irNN55y--
