Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E416C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 14:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84DE1809D4;
	Thu,  1 May 2025 16:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p4L6ZxaW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AF180BAD; Thu,  1 May 2025 16:17:50 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9CCB809A5
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 16:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3fa6c54cc1aso755027b6e.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 07:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746109067; x=1746713867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ds0tpkPYBEER/okJnZIRS0M38bcGwety6QHRXEGm+cM=;
 b=p4L6ZxaWo74qAuvqfI3rLMjmbaFyRZLzCrK4fMaYthFu7agYvCv0lJF+hsW3YSzVjC
 bQVWQ+5Eud1w4WuWnS0SBHI5aRb0+zqHLSBxBYVmIfcVheq9UhSLX9Ot+NuaV00xMKKV
 NfXx6Ex9jXkPd9pLToEAqR68QlNWrLArYOfCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746109067; x=1746713867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ds0tpkPYBEER/okJnZIRS0M38bcGwety6QHRXEGm+cM=;
 b=d1iuVitjgvEKGu7zgf9Rk7fjbq7P/OHdKBIf61TUcyKqClC2uI7SbWDMOHWyY2fVON
 h1UDe8tORrYSOctYnWUSzq2Y08Ehwr2w5irsrhbgVtdOTP24CK8+j+XMWI2dAFAkTYr3
 /dEfCNsOmEovMqjjmlyPI9gSom1XkwTBA1deaXicXtBSMAucYKKPSbCF++OeqFLrWqJH
 I4OYsHw1peta0sn8CiDFshGRrPnYLM8A29vkTyte8qcbsT6WJV0WUGRuDnQ4pxQicJ+j
 ra0DGm0FJ6LWFjaBK2zVVn5PxtNlwfMa7fITMFru7Qjhdt6we9dYViUt7xHQ1iPuxlyx
 GCBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8guJK92wpoYDwg+jhL9+i2Mf9hz6z2ObAF+0v2E8rEfmX8qCil7YPYv0gjDmCS5gMMAgJA0w=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4RnLeumStCQZB/lhRQc1dYKqf2RhnbEhuqJSsNaehFvmeLy2c
 z1valZtewncnI/CANSx0RkQv1dt98EyO4Ea8VAk2Hu3H4x+fKJUJAuzT6JL7OxqmgrvAzeHeHf3
 7
X-Gm-Gg: ASbGnct9xjCzq17tEllmFCKGyaLtD8BdWIxBmkWH6Crcb0NguEb5Ms98nKnZId/Jqok
 hWBRIrzyQ/voSzBB5pK7YjO5VeLnnxw9QAmLgBNG7PG1H9OEt4i/qAh4M94zOKKPWGcc0B8ZMQs
 R7TqzNLU0DjM0dgvfSBZ2TqQcw8D8qyZim3QJjL+LBNDVdwEXYDmRmj5z9hl6t5EHV+uNg6Nroa
 IUHi13cwqs7f5PrbWw1EvAK9WdsmRoA1b6t7lSLcKDrHCyBaYbqIOAlHTQQgnE3CUwaE+mxqays
 Xf3pWwCiZeiSXd88lHRSQ5dz11ajATgDzZ4v32U+57HQJbTR4ROdpdKxbvhzKwgOwX9PBhr1hN1
 oEw==
X-Google-Smtp-Source: AGHT+IHwJ2ci+dNeHxNEv5WTRKAcysQsYRYtkshXrGFebR+iOXpWpMu2UZdkofjZM1bndKmKZ9Su4Q==
X-Received: by 2002:a05:6808:3992:b0:3f9:17f9:3099 with SMTP id
 5614622812f47-403344724e3mr1997359b6e.27.1746109066618; 
 Thu, 01 May 2025 07:17:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033dae6f2dsm123711b6e.29.2025.05.01.07.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:17:45 -0700 (PDT)
Date: Thu, 1 May 2025 08:17:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 00/22] Deal with exfat versus byteorder
Message-ID: <20250501141743.GE1261075@bill-the-cat>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <96025fbf-c636-4726-8534-d95e54ff1017@mailbox.org>
 <CAFLszTgFfcd01rdwH_TM74xwt_Uiy+DGba=6bF=-CH3GPRj+sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3NQ5nGbW5qt52j/W"
Content-Disposition: inline
In-Reply-To: <CAFLszTgFfcd01rdwH_TM74xwt_Uiy+DGba=6bF=-CH3GPRj+sQ@mail.gmail.com>
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


--3NQ5nGbW5qt52j/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 06:07:15AM -0600, Simon Glass wrote:
> Hi Marek,
>=20
> On Wed, 30 Apr 2025 at 20:02, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 5/1/25 3:04 AM, Simon Glass wrote:
> > > Since exfat has its own byteorder functions we need to be careful abo=
ut
> > > including the normal U-Boot byteorder headers in code included by exf=
at.
> >
> > ...
> >
> > >    net: Use a forward declaration for cmd_tbl in net-common.h
> > >    congatec: Include env.h to permit reading the environment
> > >    dhelectronics: Include env.h to permit reading the environment
> > >    imx8ulp_evk: Include env.h to permit reading the environment
> > >    venice: Include env.h to permit reading the environment
> > >    phytec: Include env.h to permit reading the environment
> > >    ronetix: Include env.h to permit reading the environment
> > >    toradex: Include env.h to permit reading the environment
> > >    advantech: Include env.h in imx8qm_dmsse20_a1
> > >    tegra: Include env.h to permit reading the environment
> > >    synology: Include env.h to permit reading the environment
> > >    amlogic: Include env.h to permit reading the environment
> > >    freescale: Include env.h to permit reading the environment
> > >    google: Include env.h to permit reading the environment
> > >    liebherr: Include env.h to permit reading the environment
> > >    technexion: Include env.h to permit reading the environment
> > >    elf: Only use network environment-variables if net enabled
> > >    net: Include byteorder in net6.h
> > >    net: Include string.h in net-legacy.h
> > >    net: Include env.h in pcap.c
> > >    net: dc2114x: Include env.h to permit reading the environment
> > >    net: Move env_get_ip() out of the header file
> > >
> > >   arch/arm/mach-tegra/dt-setup.c                |  1 +
> > >   board/Synology/ds414/ds414.c                  |  1 +
> > >   .../imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     |  1 +
> > >   board/amlogic/jethub-j100/jethub-j100.c       |  1 +
> > >   board/congatec/cgtqmx8/cgtqmx8.c              |  3 +-
> > >   board/dhelectronics/common/dh_common.c        |  1 +
> > >   board/freescale/imx8ulp_evk/imx8ulp_evk.c     |  1 +
> > >   board/freescale/mx7dsabresd/mx7dsabresd.c     |  1 +
> > >   board/gateworks/venice/venice.c               |  1 +
> > >   board/google/chameleonv3/board.c              |  2 +
> > >   board/liebherr/xea/xea.c                      |  1 +
> > >   .../common/phytec_som_detection_blocks.c      |  1 +
> > >   board/ronetix/imx8mq-cm/imx8mq_cm.c           |  1 +
> > >   board/technexion/pico-imx7d/pico-imx7d.c      |  1 +
> > >   board/toradex/colibri_imx7/colibri_imx7.c     |  1 +
> > >   board/toradex/verdin-imx8mm/verdin-imx8mm.c   |  2 +-
> > >   cmd/elf.c                                     | 41 ++++++++++------=
---
> > >   drivers/net/dc2114x.c                         |  1 +
> > >   include/net-common.h                          |  9 ++--
> > >   include/net-legacy.h                          |  1 +
> > >   include/net6.h                                |  1 +
> > >   net/net-common.c                              |  6 +++
> > >   net/pcap.c                                    |  1 +
> > >   23 files changed, 53 insertions(+), 27 deletions(-)
> > There are no fs changes in this series , what does this series have to
> > do with exfat ?
>=20
> I found that in some situations, the exfat code includes
> linux/byteorder.h instead of its own local byteorder, which is
> implemented differently. This then causes build errors in the exfat
> code. One way to trigger it is by adding '#include net.h' to
> include/efi.h

Setting aside if it's a good idea to have efi.h include net.h, we should
unwind what the heck is going on. The build error is on CLUSTER_INVALID
somehow becoming weird. Looking harder at this, the problem I see is
that include/fs.h includes <rtc.h> (which in turn pulls in many things)
when it only needs <rtc_defs.h> for struct rtc_time. This however
exposes some other implicit includes. I'll go and take a look at hunting
these all down.

--=20
Tom

--3NQ5nGbW5qt52j/W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgTgn8ACgkQFHw5/5Y0
tyzVLgv/Q8KM9tX5SpMHw4B25AySSPi1S+syiuL9QauXL7OJglqvcdmWst4lQG2h
XKbM7rrUIdLswWqoXEshnDJDilBTzVaN23hctMpxfyRhs2wfahfcI2Imou/GFGVX
sTgPuPMxELUsfD9snWBJSS/TuPioJLWbZI4NaaOlFUUbRhkK/zT5rBfa237Qa0iK
1HQp5/K6NM4dH/izguDa//6Po7ZExZj9pIOi8kqd2XizId9EzpsVjXbK9q00L+pq
cCMoICXK/EKmOX8iL+rP+OtMt06rpn7e/YnAGsSzggtCOqxfVoXauekfItszjYVD
L5+LmfLaiQMB68x1OrNNZkUD/zwPSm058oZA1Gu19ODG80DnKjPNnGiVVS4hxC23
naZgbHc3TDbXroirYNm2AtdoJUxe+WzY6wE/T34KS+UMaVY0oh2qE7krKB/qx5QN
fU+PNbg8ytH0qGXKFcKZ6QMY9ws/IQiXXet5nfCRVNPaG3qPSf3fiFuXZGX1D0Vl
i83oHQYw
=Yxyu
-----END PGP SIGNATURE-----

--3NQ5nGbW5qt52j/W--
