Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000D2C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 13:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC1F87823;
	Wed, 27 Dec 2023 14:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SZ9lsct0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A88878AF; Wed, 27 Dec 2023 14:32:24 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B97876FF
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 14:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-db3fa47c2f7so3470555276.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703683941; x=1704288741; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jRuiS3B9U3OxpJ1zSQB1xKpp9MPWFH+7INib5tlWUig=;
 b=SZ9lsct0l1aD0Pc7tjVQDsdlXVgpbfHkidb0k9O1ybEQSN0EA1lfqxT9t4Jin+tlaU
 6H8yFlw2l0+hX532N8pOGrBE8irIhAtKg4phRDhMBAb0T4tLZYNSJJDzjuS8H0GNlDP0
 ajY+nQBMjWn20ivgOThMLUtNWIFGDcicllYyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703683941; x=1704288741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRuiS3B9U3OxpJ1zSQB1xKpp9MPWFH+7INib5tlWUig=;
 b=OKWoSfQLpsYZ/JD+tM6lx3UMPWQLySsbHSUKoNRUPZIU4sp9bh8Ypo5w6t+95JS3eF
 VfR3iZqen4qFAjBQ7YKL6QsbjsoA48N2Dm3ajc0u1oi5B4rrneuoGZo7j3jGPtICqSzt
 LZZmKFljQ3MEnWunKsoHdlq7mRq/rMVvTSxAVsN+C16D2DmRLSRfioUt4qWTuiU84Qo0
 CZlc3aOE29trsf4x6LvxitutSMLaU0+JFldlgpYRCocZ57MayqxZPHJ8NipxqSs72Or+
 FFxo6mrD8pa9Jmgi41Q+ChJSSvAW7UAwVqz3jr3/bR3bRaDHpRzCQ1wKW/L48yXMwvfz
 KWBg==
X-Gm-Message-State: AOJu0YwiBzTx3AzFSLM/KG9BkwxG0H40/YXZpLn/OZPbr8MFnwjz6y3/
 wriNwGkIjPh8PVWoLDWi5BzfgAnQ0EONkw==
X-Google-Smtp-Source: AGHT+IGw4rGGhacvZUSRIPl3LMozgMCctJhOke1ImUSGaAL2L4evZF8LkGnOWLBP/4Jcoc7+FQKNEg==
X-Received: by 2002:a25:4f0a:0:b0:db7:dad0:60be with SMTP id
 d10-20020a254f0a000000b00db7dad060bemr3218934ybb.75.1703683940771; 
 Wed, 27 Dec 2023 05:32:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 h17-20020a258a91000000b00dbd5b48cce1sm5200696ybl.2.2023.12.27.05.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 05:32:20 -0800 (PST)
Date: Wed, 27 Dec 2023 08:32:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Bryan Brattlof <bb@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 00/26] sync am65x device tree with Linux v6.7-rc1
Message-ID: <20231227133217.GR2652760@bill-the-cat>
References: <20231221174412.210807-1-bb@ti.com>
 <20231221200056.GM2513409@bill-the-cat>
 <20231227123928.rt2wgr3qa7rw5jmf@imitate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+s2Gk1gvUtMPyVRJ"
Content-Disposition: inline
In-Reply-To: <20231227123928.rt2wgr3qa7rw5jmf@imitate>
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


--+s2Gk1gvUtMPyVRJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 06:39:28AM -0600, Nishanth Menon wrote:
> On 15:00-20231221, Tom Rini wrote:
> > On Thu, Dec 21, 2023 at 11:43:46AM -0600, Bryan Brattlof wrote:
> >=20
> > > Hello Everyone!
> > >=20
> > > This series gets the am65x booting again along with syncing the device
> > > tree files with v6.7-rc1 Linux.
> > >=20
> > > The bulk of these patches unify the WKUP SPL board file with the arm64
> > > files to make future syncs from Linux much easier. In the end the DTBs
> > > should look a lot like what the DTBs look like for the am64x which
> > > is fairly similar to the am65x.
> > >=20
> > > For those interested in what UART boot looks like:
> > >    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287=
bc
> > >=20
> > > Thanks for reviewing and happy holidays
> > > ~Bryan
> >=20
> > For the series,
> > Tested-by: Tom Rini <trini@konsulko.com>
> >=20
> > Nishanth, does this path work for you?
> >=20
>=20
> Other than the minor comments provided in the relevant patches,
>=20
> The following files also need sync up with v6.7-rc1.
>=20
> k3-am65-iot2050-common-pg2.dtsi
> k3-am65-iot2050-common.dtsi
> k3-am6528-iot2050-basic-common.dtsi
> k3-am6548-iot2050-advanced-common.dtsi
> k3-am6548-iot2050-advanced-m2.dts
>=20
> Jan - could you look at syncing those once an update to this series is
> posted? We could probably have a smoother v6.8-rc1 from then on.

I hope that by v6.8-rc1 time we'll have merged Sumit's patch series and
so instead TI platforms will move to the v6.7-dts tag there, and then
v6.8-dts once that's out.

--=20
Tom

--+s2Gk1gvUtMPyVRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWMJ14ACgkQFHw5/5Y0
tyxi7gv/bNq7Qj9aQjaBcoC4/QHx9nadJzLS9OHLVZstYVvNk9xzQF+784hMUVyN
Px9hZqiC+KrCye43p5x4R32LSluPimH2+8jbCI2SWQ3QDKDSbxc4Rn0FQlhaGBYp
ciwAcXpjVKbOOyJhO9/f7UKL+2QYOyNioNzXErcTT+7ld4euao1jpQU7kjETfR8t
Zq7sctwlLlUyzafnOK9Yf/gk8RBGDxurGkrzSbKNdL7zjAGsQ5ZIrjKFum64hjiF
Ve3jxiGJcJCeD8MmahB5NV5vPa9x9QX4rm/552hVzHLCVoN2V6ACjSBS6dpqscGc
IV3tvyrfzlmh14PmUQJE8dcs853x65fA5etOMlCV7XGJUPZjTcQqxTQwJNIU7iHB
B2NzClG8y/WqficloBbx+PojMlQQUEDJtL/BzrtD7VE26nJu0jyZASLOdeaY2Icn
kZpMhAB8iEz4xMii5KCngo/a+nBwtH3m5Mm/g9bifxY6uP1hNBxxikI6x8BiLQIg
dOH3y47O
=wtRj
-----END PGP SIGNATURE-----

--+s2Gk1gvUtMPyVRJ--
