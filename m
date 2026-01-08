Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC0CD185FE
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69ABC83B72;
	Thu,  8 Jan 2026 15:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qd+asuJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 749B184175; Thu,  8 Jan 2026 15:12:41 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1714583A1E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c750b10e14so1404656a34.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767881558; x=1768486358; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KwL4PXHFV9OatzYZMTW5OQ91Es83rWbvolpzLyvrnAg=;
 b=qd+asuJFm8kXetQPcmbPHY1jboUWduu5I/rRApqFstqDTyhvhThHc9oIVte3C61B4f
 dmBR7ed2zCSRZwOaMnQ/xza74WZ0+YR8AU83juUL7HxXk3+vDgi7i1tDOsjQ5ceQRWke
 +rADFccLKydwhgau2jdfiiGhZSJEMzuHtFtpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767881558; x=1768486358;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwL4PXHFV9OatzYZMTW5OQ91Es83rWbvolpzLyvrnAg=;
 b=Hz7ngNHKjMxV6d2QiaadSrZdfS8dEQ7YQmE8K25F2PLxBi89tRMPvdN/uERLDtW9Uj
 YtAtEmKWbaFkPSbgPHdsTd44DRsxlPee05sObGti4fo9bg7LiHnkU2CwU1+PhyO2XvA0
 +O11tUdXaQzjCdWkScjv0SSnmKuqjXrKk/pVkIFN04KXaxYVX4UJ5wk5paoE63DXBa6K
 JZId9mhZHZOeh2NQIo1evjq8R7Rn4DswRZ4/ns9vJdBeOnbOkurJ4/gpD/AhUkmgdqTc
 IpQpHYi0mdju9ky/DT1iLmDKTcuC/WcEzWPHP8qRBXbuvxG05x/cq2X2ZJfL+5fAYXad
 IXIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVocANdGe9UfnRBsRB3+8eOt3vcaVkI1IaAKUdABuI/UK4hJvPKWyCDABttlGxm8I1Xg/+WwuE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8OehTkC8/4TkgSzvqY9Za3tdhcwK6wPTfsdcyUXsRG1B9gy6m
 7IC5Fy52BfhnjPEbrV2KvEKOmBKbvUmSbvwLQ48kjHKJkKsQSBBbL/qZWxyZJpPMoSA=
X-Gm-Gg: AY/fxX5HhIXnUNScYC3KfrJpH3dHTQw1TYMNVfVtE5Y7sOR0duUaGjepTiBxz2rc+1b
 +xio39DSynUE5NGp5FxSpf3APGEUM2gZIRJXwdzMn0/SdiaJ2t4OgxNsZl/CaMacHYHk6ftkxzi
 c0lsLZeKoa3a2aj74w5/TEhTIBGBAMntdMZgrrMAu9ODTJXAtJ05PM8aWkU5hdcjbLVNRIq9QfT
 rLtb2C6RwwdJrFL7vw/fGmEbwYgnhIPy8FsDdnVcIk4ytf6jI1eqZE+vi0JpawGyA7xgRvFlVPI
 zZsn0Mg8iejrYBLYcp0oYJ9F/gCDth7vwvCCSB/g/OH9/88KVpVlZ5OyIkm1aSW1q1s4GR6ihz4
 t2iZkNiCyXodDjA/OeCCgZgcQWbm+9XJ8EsM36XwfFkjYQ+fooBAaG2NhPJkkApKw1pygcsx/dR
 hIVAj24Hw6FJy2CL+tw9z0Td6wLm1APTatw/SW/n9N1d0ByDHEGofcO2oIQNbgak8yIVOdaNwOI
 VnCH89vzNbbDmtS+Qp9f2OMBhxfi8C2ZE6qPP0jMYmc+7ZsRA==
X-Google-Smtp-Source: AGHT+IGELUCOOc/5kYjVNVY4EFLRu0ziiSd8GVa/yCzHLCoZNf0xlDZliDrR07gx9cPIejPwAKoeOQ==
X-Received: by 2002:a05:6808:1311:b0:450:d693:4d2d with SMTP id
 5614622812f47-45a6bebb60emr2791028b6e.33.1767881557640; 
 Thu, 08 Jan 2026 06:12:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4de55ffsm5043726fac.2.2026.01.08.06.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:12:36 -0800 (PST)
Date: Thu, 8 Jan 2026 08:12:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 vigneshr@ti.com, b-padhi@ti.com, n-francis@ti.com, nm@ti.com,
 afd@ti.com, u-kumar1@ti.com, i-sihag@ti.com
Subject: Re: [REGRESSION] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Message-ID: <20260108141233.GQ3416603@bill-the-cat>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <DFJ950O0QM0D.380U0N16ZO19E@ti.com>
 <DFJ9947VLHEL.PCDIJCRU24BS@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iXG4S0p3StpOhp/a"
Content-Disposition: inline
In-Reply-To: <DFJ9947VLHEL.PCDIJCRU24BS@ti.com>
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


--iXG4S0p3StpOhp/a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 07:21:10PM +0530, Anshul Dalal wrote:
> CC+: TI folks
>=20
> On Thu Jan 8, 2026 at 7:15 PM IST, Anshul Dalal wrote:
> > Hi all,
> >
> > On Wed Dec 3, 2025 at 1:02 AM IST, Marek Vasut wrote:
> >> Synchronize local copy of DTC with Linux 6.17 . This includes the
> >> following picked and squashed commits from Linux kernel. The squash
> >> was necessary, since the DTC here contains changes which were also
> >> part of DTC in Linux alraedy, and the squash helped resolve those
> >> without going back and forth with the changes.
> >>
> >> The following commits from Linux are picked:
> >>
> >> 8f324cd712df7 # scripts/dtc: consolidate include path options in Makef=
ile
> >> b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
> >> 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14-gc86=
da84d30e4
> >> ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57-gf26=
7e674d145
> >> 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23-g879=
63ee20693
> >> 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30-g702=
c1b6c0e73
> >> 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
> >> 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22-gc40=
aeb60b47a
> >> 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent brack=
eting of properties with phandles"
> >> 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
> >> 40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2-g87a6=
56ae5ff9
> >> 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> in non=
-standard path
> >> b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11-g9d7=
888cbf19c
> >> 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting cons=
istent
> >> 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS instead o=
f overwriting
> >> b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31-gcbc=
a977ea121
> >> 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DTC pro=
ject
> >> 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51-g183=
df9e9c2b9
> >> ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
> >> a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
> >> e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
> >> d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19-g0a3=
a9d3449c8
> >> a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from help=
 text
> >> 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
> >> b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63-g557=
78a03df61
> >> f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66-gabb=
d523bae6e
> >> 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93-g1df=
7b047fe43
> >> ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95-gbcd=
02b523429
> >> ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35-g52f=
07dcca47c
> >>
> >> This also includes forward port of U-Boot commit
> >> e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
> >> to avoid binary size growth.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Adriano Cordova <adrianox@gmail.com>
> >> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> >> Cc: Christian Marangi <ansuelsmth@gmail.com>
> >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >> Cc: Sam Edwards <cfsworks@gmail.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.denx.de
> >
> > We observed several boot failures on K3 platforms since the addition of
> > this patch at the R5 SPL stage, the issue seems to be the newly added
> > check for alignment in fdt_check_header in scripts/dtc/libfdt/fdt.c:95
> > but the binaries generated don't have 8-byte aligned FDTs.
> >
> > I have been able to reproduce the issue on AM62p EVM with a clean
> > working directory (this is important since any minor change to the
> > SPL binary size such as by the added "-dirty" tag could make the address
> > aligned) and GCC 13.3[1].
> >
> > Are we ensuring the fdt present in the SPL binary is properly aligned?

Yes, the device tree must be 8-byte aligned, this is a requirement of
the device tree spec itself that we had been lax over until now.

--=20
Tom

--iXG4S0p3StpOhp/a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV+7TgAKCRAr4qD1Cr/k
CsvOAQCyBV3pS2l3jzkMK4vqN8EDc0SCxIlMk6LIqAfuleKGfQEAnNNcjuxPhlCO
25wZhgTW9ZGWUfa2eJXx5vmlK2khAAM=
=4L+O
-----END PGP SIGNATURE-----

--iXG4S0p3StpOhp/a--
