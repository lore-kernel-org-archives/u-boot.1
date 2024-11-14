Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5D8D6A22C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 20:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB0A88E81;
	Thu, 14 Nov 2024 21:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cMbhzpqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC77F88DB2; Thu, 14 Nov 2024 21:33:58 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49C288FC5
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 21:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b155cca097so85360585a.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731616434; x=1732221234; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uvePSZkwyL0pJ9lAgqvvYjxrBhPhUWVMGSHaIvR9QHU=;
 b=cMbhzpqZFdDYFwVJ/E2fVsXhGVx1WmBtibooADriZ7yrm8bQbrAqKyPWl3F0DzY0R6
 sVO9xTaDtlU5PRprBDPFrZFVHmepuTr+f9H9QBaA1y7HuUvKldWugOjYQiSBdv/2Ydnc
 dGv1HqxemlayXcZpg9Gj+rgNlG6ovuFQ6pwFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731616434; x=1732221234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvePSZkwyL0pJ9lAgqvvYjxrBhPhUWVMGSHaIvR9QHU=;
 b=Lcbf8LWiGHBvIiWtZgcYYjS/atZT/e8FQmRVqZzLvvTQnQJTfrMH7TLm11bi72Efxi
 rt+j/xVfK7B20kY6MZOTvNAoCvYfvnIZcuSqsbokzUWQwOkikZ8bw8BNscM68EGlYUQ8
 ECoiW4/pO64mX/ZAuTm9qJEa2XasB27WqvnaZcI46/To8DG4sK6oTIBMEeAefh2mN92Z
 JqszdzIuVZu/zSM9Y2114QdjDqO9X8KOQQnZt13wKkdqLVHmsI24bMzm9Nmt857u7WH+
 cJgjZRl1XLpx0Zgl6iET/ZsqIk9Z/JB7bxM9QHvGK3eUXC5Yqj54KoTm1cx5R5o825l0
 eh4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtXhKH9lFy5Qyt82sNOLRhQkpp8BC2r3bC5xWcSX1SkYi1kMlrd8QAviAM5K1rygOPD/KAXno=@lists.denx.de
X-Gm-Message-State: AOJu0YwGlFxf3ZBFwy4KImXnzRYDbo89T+yp2LxnsIwTBrsunyh19hDd
 793KD+Q/XQvm/tD1JuPAFxTR5IgNkHA7ptIlSKGwMkfxhfwJ8/1BowlsSDvTBr8=
X-Google-Smtp-Source: AGHT+IGjxX9EdfBR9Jf3Z6s8wPV7AMpg8cq2U9Ey8158GAiXFsBo6ZPLI7EY2i3+zG7UlLrGQ+YTgw==
X-Received: by 2002:a05:620a:4006:b0:7ac:9bdd:6e78 with SMTP id
 af79cd13be357-7b361fcc567mr78428285a.14.1731616433608; 
 Thu, 14 Nov 2024 12:33:53 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35c9acad7sm87845185a.63.2024.11.14.12.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 12:33:52 -0800 (PST)
Date: Thu, 14 Nov 2024 14:33:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Wolfgang Wegner <w.wegner@astro-kom.de>,
 Thomas Weber <weber@corscience.de>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Phil Sutter <phil@nwl.cc>, Siddarth Gore <gores@marvell.com>,
 Luka Perkov <luka@openwrt.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Heiko Schocher <hs@denx.de>,
 Evgeni Dobrev <evgeni@studio-punkt.com>, Stefan Roese <sr@denx.de>,
 Ilko Iliev <iliev@ronetix.at>, Dave Purdy <david.c.purdy@gmail.com>,
 "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
Message-ID: <20241114203349.GM3600562@bill-the-cat>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
 <20241114163354.GH3600562@bill-the-cat>
 <CAJaLiFyw5jba5g=8h6R_aB26wqJvdN9eLvu3T6FJBBpm4LkzhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1Pidz8EjblhDmr4P"
Content-Disposition: inline
In-Reply-To: <CAJaLiFyw5jba5g=8h6R_aB26wqJvdN9eLvu3T6FJBBpm4LkzhA@mail.gmail.com>
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


--1Pidz8EjblhDmr4P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 12:18:49PM -0800, Tony Dinh wrote:
> Hi Tom,
> Hi Stefan,
>=20
> On Thu, Nov 14, 2024 at 8:33=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Nov 14, 2024 at 04:07:15PM +0100, Michal Simek wrote:
> >
> > > Hi,
> > >
> > > On 11/14/24 15:56, Tom Rini wrote:
> > > > On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trendmicr=
o.com wrote:
> > > >
> > > > > Hi,
> > > > > Do you have any updates to share regarding this vulnerability rep=
ort?
> > > >
> > > > Michal, microblaze-generic is the most active platform that enables
> > > > FS_JFFS2 by default and so vulnerable here. Can you find some resou=
rces
> > > > to look in to fixing this please? Thanks.
> > >
> > > We have actually discussed this recently and we have other issues wit=
h jffs2
> > > and not going to fix it or recommend to use it.
> > > JFFS2 should be removed from our configs and it is also not under our=
 regression.
> >
> > Ah OK, thanks. Adding a few more maintainers now then.
>=20
> Does this affect only boards that explicitly use CMD_JFFS2? how about
> boards that have not been converted to bootstd and still use "nand
> read" like this:
>=20
> include/configs/openrd.h
>=20
> #define CFG_EXTRA_ENV_SETTINGS  "x_bootargs=3Dconsole=3DttyS0,115200 " \
>         CONFIG_MTDPARTS_DEFAULT " rw ubi.mtd=3D2,2048\0" \
>         "x_bootcmd_kernel=3Dnand read 0x6400000 0x100000 0x300000\0"     =
 \

It's a problem for boards which read from JFFS2 in U-Boot, yes. So in
the case of the kernel / etc being read from a raw location (or ubi or
what-have-you), if FS_JFFS2 (or CMD_JFFS2, same list of platforms) is
disabled the problem goes away. And if we're down to just a few lightly
used platforms, we can just drop JFFS2 support. Thanks!

--=20
Tom

--1Pidz8EjblhDmr4P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2XqkACgkQFHw5/5Y0
tyxIrwv9GLZGX6cWPq5uazVRtIpVUs1PlMYTOxG5xIB+i/uw9rergj1oAf/Kk29C
lOmtAef8A/eiHDYfcUQjY1ZvX/Kxj8BsE4QanfchKhLSaHz2x2zIzMpEyKS4dWhf
Nn3GBoV66d6eFcYL3SyZhSthGuBtcoV+J9NW+E7HUNI2ZkYQaixv+zsG78n6vWNH
FR+nm+BI/67jbSUhyw6g+hiUl3ZScFPmD4pya2mLg/4vMSIiUii84edPC9T98mlg
bpfv0ITjJpvWRT92DFLtVQVM7bjFPFRQuZU2v2uMcoGE0/grw7eE7wxqiRGpcGKa
WkYiwoSH1cZK6gTQZIt22he37y3HoxBDMEZH4nXHLvCIeHpDfuX6KzqYUpEDl6r6
ItnvIg0MSmzBHwBqq0qezuD1E1s96uv0uZF1qf3ueRP+JYhUwbax9tIcjSejdWZ1
SjW/DITRQaPJuN2mAfvnY7q8PwDG97TiFaM82panuB7n71NMpHXjZDcvYxDzFGWJ
R8eWx8DS
=JUUS
-----END PGP SIGNATURE-----

--1Pidz8EjblhDmr4P--
