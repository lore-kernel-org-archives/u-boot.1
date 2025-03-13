Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30E5C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 10:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C60C80FF7;
	Thu, 13 Mar 2025 11:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nxy03srN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E69F80FF7; Thu, 13 Mar 2025 11:40:38 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30FF680F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 11974A46155;
 Thu, 13 Mar 2025 10:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439A0C4CEDD;
 Thu, 13 Mar 2025 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741862421;
 bh=r2KMjQ0Ow49P5VGFzooLmiIC+MqjnVaF5CKn/HrSkTA=;
 h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
 b=nxy03srNmu6Rn1lWv8I9rQlb52dN6wpX6WHwiYNL132um/evWaZBVPZ9abdwPPKU6
 +Ro0PBPtgFDJqDGrz4GdtSpbNGUX86xkTIBfNUZ9pTmi7Hjp7TLJe/ISgWoHIBV/Vr
 wGWDHq21sEdIuvWotI75NcPfaNjAEMJdbiw6Ru8nFaPw5zIRpBM+ONkheAvR7c9dN8
 Onm9pjABRoOYAcnoHCKleZHnXylBZWnk8lcBpadPMsNr5zWnoRto75xFnUxBxGdhQV
 R81g7Zq0/1UHl4NGTnlePRx1q9tq1IJNYH2mGgPD6dRf9s0wuQPsDgQiHYSWfQmfaX
 lzofPWaAw1lCQ==
Content-Type: multipart/signed;
 boundary=d64b824cdaca910ee34be917a9dc27f47f033581e33888ac4212538d17b1;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 13 Mar 2025 11:40:17 +0100
Message-Id: <D8F2OZR75XC6.1EHBQFP9CRT17@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Quentin Schulz" <quentin.schulz@cherry.de>, "Tom Rini"
 <trini@konsulko.com>, "Joe Hershberger" <joe.hershberger@ni.com>
Subject: Re: [PATCH 3/3] env: mmc: fix offsets relative to the end of the
 partition
Cc: <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0
References: <20250312074019.2281884-1-mwalle@kernel.org>
 <9c1f674f-8309-4170-b49b-34778afb8563@cherry.de>
In-Reply-To: <9c1f674f-8309-4170-b49b-34778afb8563@cherry.de>
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

--d64b824cdaca910ee34be917a9dc27f47f033581e33888ac4212538d17b1
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > According to the help text, you can set negative offsets to indicated
> > that the offset is relative to the end of the parition. But kconfig
> > doesn't let you specify negative hex values. I think this fell through
> > the cracks when converting the symbol from a '#define' to a kconfig
> > option.
> >=20
> > Introduce a new boolean kconfig option to switch on the "relative to th=
e
> > end" behavior.
> >=20
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> >   env/Kconfig | 42 +++++++++++++++++++++++++-----------------
> >   env/mmc.c   |  8 ++++++++
> >   2 files changed, 33 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/env/Kconfig b/env/Kconfig
> > index 4438f0b392c..49888bf700c 100644
> > --- a/env/Kconfig
> > +++ b/env/Kconfig
> > @@ -231,14 +231,6 @@ config ENV_IS_IN_MMC
> >   	  These two #defines specify the offset and size of the environment
> >   	  area within the specified MMC device.
> >  =20
> > -	  If offset is positive (the usual case), it is treated as relative t=
o
> > -	  the start of the MMC partition. If offset is negative, it is treate=
d
> > -	  as relative to the end of the MMC partition. This can be useful if
> > -	  your board may be fitted with different MMC devices, which have
> > -	  different sizes for the MMC partitions, and you always want the
> > -	  environment placed at the very end of the partition, to leave the
> > -	  maximum possible space before it, to store other data.
> > -
> >   	  These two values are in units of bytes, but must be aligned to an
> >   	  MMC sector boundary.
> >  =20
> > @@ -249,9 +241,6 @@ config ENV_IS_IN_MMC
> >   	  valid backup copy in case the other copy is corrupted, e.g. due
> >   	  to a power failure during a "saveenv" operation.
> >  =20
> > -	  This value may also be positive or negative; this is handled in the
> > -	  same way as CONFIG_ENV_OFFSET.
> > -
> >   	  In case CONFIG_SYS_MMC_ENV_PART is 1 (i.e. environment in eMMC boo=
t
> >   	  partition) then setting CONFIG_ENV_OFFSET_REDUND to the same value
> >   	  as CONFIG_ENV_OFFSET makes use of the second eMMC boot partition f=
or
> > @@ -592,9 +581,18 @@ config ENV_OFFSET
> >   	  Offset from the start of the device (or partition).
> >  =20
> >   	  This offset may be interpreted differently depending on the chosen
> > -	  ENV_IS_IN_* options. For example, for ENV_IS_IN_MMC=3Dy, this offse=
t may
> > -	  be negative to indicate an offset backwards from the end of the
> > -	  partition. See the relevant help messages for more details.
> > +	  ENV_IS_IN_* options. See the relevant help messages for more detail=
s.
> > +
> > +config ENV_OFFSET_RELATIVE_END
> > +	bool "Offset is relative to the end of the partition"
> > +	depends on ENV_IS_IN_MMC
> > +	help
> > +	  Treat the environment offset as relative to the end of the MMC
> > +	  partition. This can be useful if your board may be fitted with
>
> I guess by MMC partition you meant hardware MMC partitions, as opposed=20
> to GPT/MBR partitions?

Yes exactly.

> It's not clear from JEDEC standard if there's a word that would apply to=
=20
> the boot partitions, User Area (I think it can be split also?), RPMB,=20
> etc.? But if there's one, maybe use that term?

I didn't come up with that, as I just moved the help text. But I can
certainly add "(hardware) MMC partition".

>
> > +	  different MMC devices, which have different sizes for the MMC
> > +	  partitions, and you always want the environment placed at the very =
end
> > +	  of the partition, to leave the maximum possible space before it, to
> > +	  store other data.
> >  =20
> >   config ENV_OFFSET_REDUND
> >   	hex "Redundant environment offset"
> > @@ -607,9 +605,19 @@ config ENV_OFFSET_REDUND
> >   	  environment location.
> >  =20
> >   	  This offset may be interpreted differently depending on the chosen
> > -	  ENV_IS_IN_* options. For example, for ENV_IS_IN_MMC=3Dy, this offse=
t may
> > -	  be negative to indicate an offset backwards from the end of the
> > -	  partition. See the relevant help messages for more details.
> > +	  ENV_IS_IN_* options. See the relevant help messages for more detail=
s.
> > +
> > +config ENV_OFFSET_REDUND_RELATIVE_END
> > +	bool "Offset is relative to the end of the partition"
> > +	depends on SYS_REDUNDAND_ENVIRONMENT
> > +	depends on ENV_IS_IN_MMC
> > +	help
> > +	  Treat the redundnat environment offset as relative to the end of th=
e
>
> s/redundnat/redundant/
>
> > +	  MMC partition. This can be useful if your board may be fitted with
> > +	  different MMC devices, which have different sizes for the MMC
> > +	  partitions, and you always want the environment placed at the very =
end
> > +	  of the partition, to leave the maximum possible space before it, to
> > +	  store other data.
> >  =20
>
> Same remark as for ENV_OFFSET_RELATIVE_END.
>
> Looks good to me otherwise!

Thanks for reviewing.

Let's give this patch a couple more day, then I'll resend it with
your remarks being addressed.

-michael

--d64b824cdaca910ee34be917a9dc27f47f033581e33888ac4212538d17b1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ9K2EhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hckAGA69Mmvaixd6a8IE/SeeLgzc7GX3H/jYi8
0tnw4Crj2PM418HrpFtkzmuawxlXREWEAYDk3Lc97ss9NtDzVMuoMc1ZU3bfdS2e
r89kqq7jEn5nDcdtRzn6ejG0lgKqX0k6eKA=
=Pvoq
-----END PGP SIGNATURE-----

--d64b824cdaca910ee34be917a9dc27f47f033581e33888ac4212538d17b1--
