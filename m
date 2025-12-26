Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A38E8FDAA
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 18:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A32A83A3B;
	Fri, 26 Dec 2025 19:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FziyKJAl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D0183A3D; Fri, 26 Dec 2025 19:59:30 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A11E38398D
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 19:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3e3dac349easo7777014fac.2
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 10:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766775567; x=1767380367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qTsKQAIt2N6sqZgrCFwR1hCO3u+vCJ2p4BWm9LqBujc=;
 b=FziyKJAlew838iJu8lksyI3FWmlRr8EeX68LcT65onwkpB4vYSgThyTh4StGgk9ZaQ
 ePnWVHjQmhGAa1BUCWx131D5MkZ17/AfvOMPfR/7JjMC9Zq0mX0TcouY7VSYvigtOGNn
 yKD6N5qlmx0jUFlUeT9yKxB0YhYb0bsFLzWa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766775567; x=1767380367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTsKQAIt2N6sqZgrCFwR1hCO3u+vCJ2p4BWm9LqBujc=;
 b=l477LBxxzEh0hUsLLTwzhIMnsTz6zNGqIs59y0UvKhaKtCdY1o85UxS/ERupfrTeNh
 ht3FadIw5pxkirViLpNuh938khKv4Mz+ofZWXt/DsKaDrcPztci+R5DXV/utpKnqldO+
 7ZCrZymtOZUbjWdiyYBJlfSkenBOu+ziBQgyp9DXeAjssSeKXWv9twQZaWae5NooYylf
 KSMOHM/EMN9tNUSC3RKbefGHrl2q+KZ0uXF+tm8XSSgM5B26dP/zZydU8A1UNAfyoVdC
 qe+a4LrO/TKPPudaPwBk4sI7SF2/vagVbVbovdCnx9A4o9MWc2YjDsTHGdnCw1WUyGv1
 QgCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3OEONh7RXM5hHn49dY/BnTv+MzfIybKiGbMjoQMVOX9Lytq3JmXylmQwanpDCLW8BokakZjg=@lists.denx.de
X-Gm-Message-State: AOJu0YwpAF7uaVJMqJvyl/bslOB2gXnwOORLmd2OWl2979ok/lHtC9Oj
 SQ64LUMZgRhi8rJtlvWsyOEK4C7aTlFi9onQ1HD6wycNW3u/lLSX0kfnCEQRarZqB+LmBPC5uCi
 kCQkrb5E=
X-Gm-Gg: AY/fxX5P03KjQQ8a2l6D11w3XdmtgVswlmOI0mo7k/tHY+mg9bBbPcgOgiXaGCX3OsW
 E186iSrbBzJc8zXp0iiaQB6KITnRQX4JRbqzaETUrAkV9bZvB1PU8aqysiq42dbBUg++hOZdM0y
 ovgatpsUXhFdY3weIMt6wJBKVYRquk6wBxD2nnc/N3GseD1XY4uZkSXDVmF3EBG5l8sLklCgJcc
 Fk2pIu8Ec7diVTrIIpCVfyjcKBn27oCCx+ATuzHj+LvThr05XzXuWF1MedeASrNVMvC451wrYe0
 2vRKLzhBF5bVfjhfpYmUBGrCTFAbWpnf0irXcYDwsdNe+GKlwYiGgyEcvkpudbrhG71CYV/vMZE
 p7Wh+d/6ta+ueS8GpuEwQHthlPB0a7ZEczEX2Q5Cs3odcuPocMH2NF1dGbf7EIEY4ch43OPFmLF
 JXQJ2LOlvdGAclh9B5AGyeHD1JGekDANkg0tgKAw11w9NVmEWm3Q==
X-Google-Smtp-Source: AGHT+IFQp9fYQtK3F49UaowmcuHjXt4xIU2ukRL6TOa2VYb0pyr/UTZxsa28/HCw5DG50cYeA7gzRA==
X-Received: by 2002:a05:6870:2405:b0:3ec:554d:c222 with SMTP id
 586e51a60fabf-3fda58b9062mr10381995fac.46.1766775567270; 
 Fri, 26 Dec 2025 10:59:27 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaabbf2c4sm14462843fac.19.2025.12.26.10.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 10:59:26 -0800 (PST)
Date: Fri, 26 Dec 2025 12:59:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/4] CI: Add test jobs for QEMU m68k virt machine
Message-ID: <20251226185924.GH710860@bill-the-cat>
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-5-visitorckw@gmail.com>
 <20251226180904.GF710860@bill-the-cat>
 <aU7ah4cc1maMH1KU@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hrAQcNtOgaRSyH1P"
Content-Disposition: inline
In-Reply-To: <aU7ah4cc1maMH1KU@google.com>
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


--hrAQcNtOgaRSyH1P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 02:57:11AM +0800, Kuan-Wei Chiu wrote:
> Hi Tom,
>=20
> On Fri, Dec 26, 2025 at 12:09:04PM -0600, Tom Rini wrote:
> > On Fri, Dec 26, 2025 at 05:54:00PM +0000, Kuan-Wei Chiu wrote:
> > > Enable CI testing for the newly introduced QEMU m68k 'virt' board on
> > > both GitLab CI and Azure Pipelines. This ensures the new M68040
> > > architecture support is built and booted correctly in the emulated
> > > environment.
> > >=20
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> > > Changes in v2:
> > > - New patch to add CI testing jobs for gitlab and azure pipelines.
> > >=20
> > > Note: This patch depends on a corresponding patch to the
> > > u-boot-test-hooks repository to provide the necessary QEMU
> > > configuration: "travis-ci: Add config for QEMU m68k virt machine"
> > >=20
> > > The gitlab CI job has been verified locally using gitlab-ci-local tool
> > > with a passing result. Azure Pipelines has not been verified.
> > >=20
> > >  .azure-pipelines.yml | 4 ++++
> > >  .gitlab-ci.yml       | 7 +++++++
> > >  2 files changed, 11 insertions(+)
> > >=20
> > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > index e4695f1c55b..41bba8ed0f1 100644
> > > --- a/.azure-pipelines.yml
> > > +++ b/.azure-pipelines.yml
> > > @@ -518,6 +518,10 @@ stages:
> > >            TEST_PY_ID: "--id qemu"
> > >            TEST_PY_TEST_SPEC: "not sleep and not efi"
> > >            OVERRIDE: "-a CONFIG_M68K_QEMU=3Dy -a ~CONFIG_MCFTMR"
> > > +        qemu_m68k_virt:
> > > +          TEST_PY_BD: "qemu-m68k"
> > > +          TEST_PY_ID: "--id qemu"
> >=20
> > I see why you set TEST_PY_ID but that's only used in this manner for
> > platforms which can be real or virtualized, for the qemu targets we just
> > omit that (and then name the u-boot-test-hooks files to be "_na" or can
> > just omit that part. Thanks for adding this!
>=20
> Thanks for the quick feedback!
> I'll fix the TEST_PY_ID usage.
>=20
> Is there a preferred waiting period (like the 24 hr rule in Linux
> netdev) before I send v3? I can send the fix immediately, but I want to
> make sure I'm following the proper etiquette, especially during the
> Christmas holidays.

We don't have a specific defined waiting period, but since this isn't
a critical fix, yes, you can wait a few days even for more feedback
(since I recall you're collaborating with others that've been doing m68k
work on their own) before posting v3.

Ideally, this will get in v2026.04, which means it should be done and
merge-ready by end of January, so, plenty of time.

--=20
Tom

--hrAQcNtOgaRSyH1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaU7bDAAKCRAr4qD1Cr/k
CmNVAQDsRfhmkeTEF16F7xtsbnKqMNXtEX5QnO6SgLXPoeASDQEAj1E7KhbexIOh
kQUyRW1tJkUA/6qo2Npg6BkFIW4BUwU=
=EGB6
-----END PGP SIGNATURE-----

--hrAQcNtOgaRSyH1P--
