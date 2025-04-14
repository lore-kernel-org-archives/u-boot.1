Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F486C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A678214B;
	Mon, 14 Apr 2025 22:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VYN4Gror";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF938214B; Mon, 14 Apr 2025 22:06:43 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1A782102
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c03d237a7so1614934a34.3
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744661198; x=1745265998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ipa8exr6HccicC2p4vSzUhjdai2YxaQr3g9/Rcx8QtM=;
 b=VYN4GrorFq3hNg67kmuZef4oW6UT2hRIdGaNaQCnk8MlIUWNRMugqYbwhhpOACRFDo
 5tu42gDlDPJth8EDK4I82U9LMKTG9zWX6nzE9BSZlorhLd4IBmEvsxUpvZP8vgYmG0uT
 EMJeiJtRXGDPyb/E8Lu1TDcgF4GhjM0YaaDzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744661198; x=1745265998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipa8exr6HccicC2p4vSzUhjdai2YxaQr3g9/Rcx8QtM=;
 b=PW52+LGgbam6iHZFhA8Nm3A6kVoov/uhY48DzWvyw3/0smsOsAOrZEyhQAKR1z8Ro2
 26t0fEmhEqBt67hW6mquCS+of/SjDoSqyG9V+dayQhdnDwwW5UiTuHKdnVYhExqN5Ujh
 OJ8Kx9h/QdVxuB8y7g4CPT9f9Z2HlARoGFX8XGGaMNi63USibOazICfEcqsJh/UhcqsH
 UCG75UZeqK+uOP3DhfLrA0/748B3Ad7gSbM6DijMmRjmRdFr2AfUpvZ8k4bJGcaer0W9
 CxFiUKbVgt+3bUhttp4G2GCeC4dcgcOy5kw5z2DPrmxS3qlcvoJgEenZJSjUEqEw/Pbj
 UPzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu7wJOvTI2C/OeMpvBaWLYAe2BuP1WKHxRjpgFqoag+Pz/m3/BH0Dg0GdlPhJpeqd0kfDHFNc=@lists.denx.de
X-Gm-Message-State: AOJu0YzPiZSihF955APCDtkuM4LuImp78r0g4BTEVj9hh8aHGdhoRAIo
 OtNehI1BPNJpvPOOp19Svlow2LW0Eg7bLAQv2VSChN99/Pu09w2vQaK3+VsWUWc7OZdeO4w8N7g
 4
X-Gm-Gg: ASbGncs8N2EFA0qjxy+hp/F6BmHr5TbOtjIBUYNdTBQTr5QwPdvYNt4174Fz+WRDPGy
 uZtvjUYzhC4tQdbbUEZxrjne0/nZIfpKtjrJAZ8W2QzqAqFqCU5ScnDr8TMoP0Kd3SD5REXd6Iy
 I5q1EayxHY7+rz+Ojeh81FXANMCqpZrFwjSnCwGGeZFcNeetIxhcX9cuxksKUO7I7aQiiM8cxqu
 5JNziqmqAlLL+1kq/cDo+sBWzrT9fTpSYGF8E8GaRAU0k73Ryf+ZyoeI+DZpzO6QoFUDR1M/OBR
 KHeyt8keJ+mOpzvgUQaCzoU6DSs09WnQ8VGdOAcMFcWaz4wfKTPyblvQOd1tyetUrzeE3FUsX8e
 QL6ghxzNcFUqL
X-Google-Smtp-Source: AGHT+IHRr8JkkSuBifVjKcltDVOT1joc64xau5I1go6hMvpt+7GgtydWoGt1RCsIVtJxkXT02bzv/Q==
X-Received: by 2002:a05:6830:6203:b0:72b:872f:efc8 with SMTP id
 46e09a7af769-72e863c2869mr9715341a34.24.1744661198581; 
 Mon, 14 Apr 2025 13:06:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e67050sm2123744a34.56.2025.04.14.13.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 13:06:37 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:06:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: "Francis, Neha" <n-francis@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
Message-ID: <20250414200635.GC5495@bill-the-cat>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
 <20250414180727.5d5zyenfagdc5qw2@unable>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TWHaClizhytUCBdm"
Content-Disposition: inline
In-Reply-To: <20250414180727.5d5zyenfagdc5qw2@unable>
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


--TWHaClizhytUCBdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 01:07:27PM -0500, Nishanth Menon wrote:
> On 23:06-20250414, Francis, Neha wrote:
> > On 4/3/2025 1:09 PM, Miquel Raynal wrote:
> > > It is very surprising that such an uclass, specifically designed to
> > > handle resources that may be shared by different devices, is not keep=
ing
> > > the count of the number of times a power domain has been
> > > enabled/disabled to avoid shutting it down unexpectedly or disabling =
it
> > > several times.
> > >=20
> > > Doing this causes troubles on eg. i.MX8MP because disabling power
> > > domains can be done in recursive loops were the same power domain
> > > disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> > > timings to respect and it is easy to produce a race condition that pu=
ts
> > > the power domains in an unstable state, leading to ADB400 errors and
> > > later crashes in Linux.
> > >=20
> > > CI tests using power domains are slightly updated to make sure the co=
unt
> > > of on/off calls is even and the results match what we *now* expect.
> > >=20
> > > As we do not want to break existing users while stile getting
> > > interesting error codes, the implementation is split between:
> > > - a low-level helper reporting error codes if the requested transition
> > >   could not be operated,
> > > - a higher-level helper ignoring the "non error" codes, like EALREADY=
 and
> > >   EBUSY.
> > >=20
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> >=20
> > This commit looks to be breaking K3 platforms boot, please see "Latest =
Boot
> > Summary" [0]. Reverting the commit fixes boot.
> >=20
> > [0] https://lcpd.itg.ti.com/upstream/k3-boot-build/main/build-trends.ht=
ml
>=20
> Uggh. This link is a TI internal link. Nutshell, it is broken
> between:
> v2025.04-921-gcb7555e93075 : https://source.denx.de/u-boot/u-boot.git
> and
> v2025.04-1041-g407d68638fe3 : https://source.denx.de/u-boot/u-boot.git
>=20
> Neha bisected it down to 197376fbf300e92afa0a1583815d9c9eb52d613a commit
> which is this patch.

And assuming it's the same failure I got reported this morning by one of
my coworkers, we just get:
U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')

For example on console.

--=20
Tom

--TWHaClizhytUCBdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf9ar4ACgkQFHw5/5Y0
tyxaVgv/T/VelmV3Iplq7zQtndE7Qt2KpqqvQdMyX+akJbWj1LS9B7Bqc6T/B9pW
vzA4Mz309EcsuYOeaC2Glm6dD8nb61NlIP4YFwz4kgXr/SrH5xmKbtpfSjg+mwv3
QvvB1pB0xeemy6dMcOH3VZIX/aRHM+JZD46QdCmGT9rlSApSiaR2pLr51oglobGa
sofVyvw8uoJuNPxtaFRxLg8i2UUcKS02yqA4A+gwShfg9kGxZFfvzbZJverCsnsY
9X2Um/hop5Oc3c92SawDefXVO7M09CNZmCi0IVbOdcP631q29OwK9aB7/khZIkgX
l9bZ0zDzTSq2F/XYrUxmUwplG97edgwyEjomkTL1J/PmlFRAXaeA7dDGpXVMypre
OPUP6EDNcz8FLlwBjdPc4KrChAh0B8MN83CLaVpiCl7N62gdPhelhJ81oGafwC3t
UcVh5JpOebbKBV95iGTCHWesc6QBL9lafpMu52iDbBg2IxHH11Qd+htyI+M+potS
ATPCiMbA
=qSIg
-----END PGP SIGNATURE-----

--TWHaClizhytUCBdm--
