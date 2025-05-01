Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD37BC3ABAA
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 15:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D438081A;
	Thu,  1 May 2025 17:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CIoeMVkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F2F809A5; Thu,  1 May 2025 17:35:24 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D0E8070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 17:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-60658e1fedfso546283eaf.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746113720; x=1746718520; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S5z3D3cu8QAyckweL6PdLL6Fn0GzxXf1B70NFVfzHkQ=;
 b=CIoeMVkx3Jlus+VG538sOW+3wQMe+vYPOENfs/khje27Hio88iGsA9K5bJCYppgTTN
 0l2xWYj4QqKvrHSQmUrushJaTy0fStWKSV0OzAyo3q8kwJVyr7C5QdUr/k6AoI+tJs91
 h9966M6Kmr4Cypsay8E2tnMRD7au4lQd7PTv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113720; x=1746718520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5z3D3cu8QAyckweL6PdLL6Fn0GzxXf1B70NFVfzHkQ=;
 b=XKHq0WX5tVLnQ9O/iuYA3M4Ws4vJGB8t+3FgsN3KeuxyY7QD4umvFTDsLYo0NopPUa
 YQkqZaOpF/DAxf2f7MPsE4lME3qbxKZoFzQ3nPDI3igBihcgD63idaBySITGX2AM5dg3
 2r2u9ivy62d4szXdvtJ7wBI4mfVxu/ySpZ77eGoosG6ZERRMbnno6HhaOEp596KYLHl9
 F1b8ZHttzpllraE0/E8pWC07hzw2OdJh1ZylucPLPPEuquNfnNb6GC6+F38+rDZGv2ZN
 sQCcYTxs/T5+nZzwNoDqHRcpNzZ9PsInZsAneA1sHnka0xjceCPWiJnNuC5Cy/O5L7e7
 SBBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzyC2jfcWfROmV1s0XHXtXsUybx+w7KYHJX4S89e51kQpeQKQfJBRnx3VPRJQlOkflW6qPwW0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzeo5dWyPo9+IErTla7WGwtCDIJ97Lo21eQ5CPrVgzYZiSaD2Tj
 jPRoBphBG9avBjhRheyhVGHvVlApdWSpYpWc1ZJKaACCF9aQTnBfr+9vnNgSR+8=
X-Gm-Gg: ASbGncs0s0NP1hv48BYdBOZ1zEOlirDGOEIFZk8mECpGShn5Mx9lLZa2jjWz+RoAEoj
 4nKPARC8AZGDglR165bwIL9yIE4W2MnTugSPcQ4sVXIY0eqsFLf9T8eIehiijyIekT5raG1gje4
 nBM8pjH4EeqPu2uUNXy+2svHGgX6KCBseQtUVMZisN7nEyeNLzA+A79pzuoy6izugy4yfAS7Lib
 0dzN6QBM9IzeQNyehmUSa9cG5cwLR9trSFCyOIK7lmle48ztveBkR0FTwEJcXwTpbVdsM4PCY3z
 /1LOS8hmP2aGHyVTB5VBnb/B3UEMnoDc3wQkKZeH58o5DAK+qhFhdf+rvIaYtOqzGaBoC0a54NC
 m/H/Wll0ioZ5P
X-Google-Smtp-Source: AGHT+IFjMXdnN2Kyy6ySqxfdWBu3OT+yIKK0myxhhu5H0ckj55V1adphMO2FzEPIqMNbgPkDSRX8iw==
X-Received: by 2002:a05:6820:1f01:b0:606:85ad:881 with SMTP id
 006d021491bc7-607e172d2b9mr1724218eaf.0.1746113720587; 
 Thu, 01 May 2025 08:35:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm147815eaf.39.2025.05.01.08.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 08:35:19 -0700 (PDT)
Date: Thu, 1 May 2025 09:35:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 00/22] Deal with exfat versus byteorder
Message-ID: <20250501153517.GI1261075@bill-the-cat>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <96025fbf-c636-4726-8534-d95e54ff1017@mailbox.org>
 <CAFLszTgFfcd01rdwH_TM74xwt_Uiy+DGba=6bF=-CH3GPRj+sQ@mail.gmail.com>
 <20250501141743.GE1261075@bill-the-cat>
 <CAFLszTi2mHGGO+wXBfKc1j3c3Hh4kzoOdyOgbmySYow7LgZYXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OsLlZRLWRvw5s6Gn"
Content-Disposition: inline
In-Reply-To: <CAFLszTi2mHGGO+wXBfKc1j3c3Hh4kzoOdyOgbmySYow7LgZYXQ@mail.gmail.com>
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


--OsLlZRLWRvw5s6Gn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 09:03:18AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 1 May 2025 at 08:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 01, 2025 at 06:07:15AM -0600, Simon Glass wrote:
> > > Hi Marek,
> > >
> > > On Wed, 30 Apr 2025 at 20:02, Marek Vasut <marek.vasut@mailbox.org> w=
rote:
> > > >
> > > > On 5/1/25 3:04 AM, Simon Glass wrote:
> > > > > Since exfat has its own byteorder functions we need to be careful=
 about
> > > > > including the normal U-Boot byteorder headers in code included by=
 exfat.
> > > >
> > > > ...
> > > >
> > > > >    net: Use a forward declaration for cmd_tbl in net-common.h
> > > > >    congatec: Include env.h to permit reading the environment
> > > > >    dhelectronics: Include env.h to permit reading the environment
> > > > >    imx8ulp_evk: Include env.h to permit reading the environment
> > > > >    venice: Include env.h to permit reading the environment
> > > > >    phytec: Include env.h to permit reading the environment
> > > > >    ronetix: Include env.h to permit reading the environment
> > > > >    toradex: Include env.h to permit reading the environment
> > > > >    advantech: Include env.h in imx8qm_dmsse20_a1
> > > > >    tegra: Include env.h to permit reading the environment
> > > > >    synology: Include env.h to permit reading the environment
> > > > >    amlogic: Include env.h to permit reading the environment
> > > > >    freescale: Include env.h to permit reading the environment
> > > > >    google: Include env.h to permit reading the environment
> > > > >    liebherr: Include env.h to permit reading the environment
> > > > >    technexion: Include env.h to permit reading the environment
> > > > >    elf: Only use network environment-variables if net enabled
> > > > >    net: Include byteorder in net6.h
> > > > >    net: Include string.h in net-legacy.h
> > > > >    net: Include env.h in pcap.c
> > > > >    net: dc2114x: Include env.h to permit reading the environment
> > > > >    net: Move env_get_ip() out of the header file
> > > > >
> > > > >   arch/arm/mach-tegra/dt-setup.c                |  1 +
> > > > >   board/Synology/ds414/ds414.c                  |  1 +
> > > > >   .../imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     |  1 +
> > > > >   board/amlogic/jethub-j100/jethub-j100.c       |  1 +
> > > > >   board/congatec/cgtqmx8/cgtqmx8.c              |  3 +-
> > > > >   board/dhelectronics/common/dh_common.c        |  1 +
> > > > >   board/freescale/imx8ulp_evk/imx8ulp_evk.c     |  1 +
> > > > >   board/freescale/mx7dsabresd/mx7dsabresd.c     |  1 +
> > > > >   board/gateworks/venice/venice.c               |  1 +
> > > > >   board/google/chameleonv3/board.c              |  2 +
> > > > >   board/liebherr/xea/xea.c                      |  1 +
> > > > >   .../common/phytec_som_detection_blocks.c      |  1 +
> > > > >   board/ronetix/imx8mq-cm/imx8mq_cm.c           |  1 +
> > > > >   board/technexion/pico-imx7d/pico-imx7d.c      |  1 +
> > > > >   board/toradex/colibri_imx7/colibri_imx7.c     |  1 +
> > > > >   board/toradex/verdin-imx8mm/verdin-imx8mm.c   |  2 +-
> > > > >   cmd/elf.c                                     | 41 ++++++++++--=
-------
> > > > >   drivers/net/dc2114x.c                         |  1 +
> > > > >   include/net-common.h                          |  9 ++--
> > > > >   include/net-legacy.h                          |  1 +
> > > > >   include/net6.h                                |  1 +
> > > > >   net/net-common.c                              |  6 +++
> > > > >   net/pcap.c                                    |  1 +
> > > > >   23 files changed, 53 insertions(+), 27 deletions(-)
> > > > There are no fs changes in this series , what does this series have=
 to
> > > > do with exfat ?
> > >
> > > I found that in some situations, the exfat code includes
> > > linux/byteorder.h instead of its own local byteorder, which is
> > > implemented differently. This then causes build errors in the exfat
> > > code. One way to trigger it is by adding '#include net.h' to
> > > include/efi.h
> >
> > Setting aside if it's a good idea to have efi.h include net.h, we should
> > unwind what the heck is going on. The build error is on CLUSTER_INVALID
> > somehow becoming weird. Looking harder at this, the problem I see is
> > that include/fs.h includes <rtc.h> (which in turn pulls in many things)
> > when it only needs <rtc_defs.h> for struct rtc_time. This however
> > exposes some other implicit includes. I'll go and take a look at hunting
> > these all down.
>=20
> OK. I wonder if we could drop the special byteorder macros in exfat?

Potentially. I'll leave it to Marek to comment on how much pain and
future pain that might cause.

--=20
Tom

--OsLlZRLWRvw5s6Gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgTlLUACgkQFHw5/5Y0
tyyQnwwAoFhdaJ1wDjjX/yxjK6OlmVDwWuzz9Jq30GvEOmnbOksXh5kTuq/vUZwg
ajRlkTGoF/DsmpBVQiSdYrGnyXygjim7twzCpQYeyhjVsqnUROsSBM0klB23qd9w
NC6lMTLz2NVFME0FvFO2xPASH13NzGUbK/cMibVMp7zLnEIZi9OBApuExC6c165M
VpeGcDXA8SzwIHVL8o8FlMFV3gkaWsLGCzGoBl20NpmKOEqWGrlIw5oiM9s1B/0c
Br74HMkBeRE3UpJTgonucHrry5ru/oC+qbjWKZAYvV4g8BJjeEqSbvCsf++xd7qY
y3ktazsu1IX6QCI3/IGjPoCkeDaF8jdn2U8TmoS0PaLL9+pAIJ1RhmxkUuefqIGU
9/JvTYDFmNKGgiyX4mHiEKG6LnXbvLMXj27ZfN9puPXPNefLj0Z7+etn+rDYjQHs
VZU0ESg0sDF9RLwMZaTtVcXOHOEwYQzRE0TPqVhlr0bz1U2Il4PJnCBcGQwYiw80
d5pT/MMb
=U7xy
-----END PGP SIGNATURE-----

--OsLlZRLWRvw5s6Gn--
