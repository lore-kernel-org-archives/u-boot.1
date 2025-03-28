Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE98C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E977B81951;
	Fri, 28 Mar 2025 17:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sx1k5zqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2429381E13; Fri, 28 Mar 2025 17:30:06 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6691D8144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-601f3674116so569393eaf.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743179402; x=1743784202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x9/NG/MYsWFI1jD/yZHhO90Uuoii6gTTebRL2cyaiB0=;
 b=sx1k5zqhkeW6X2SRscJwZpuq9IOChSx1Qvvy5nQFLwxHGLOwJjaBBeMcNC58Fe83T1
 zPeAkS9dgvxNzI94tfhocaJDQ2HkhK3cw1zRp5VdVvDcNKr2JJ0OXmhE4AD+aLeyRG+f
 R6vWWKdQQoWRdyynEuJ907vxNVyFd2PXxqM/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743179402; x=1743784202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9/NG/MYsWFI1jD/yZHhO90Uuoii6gTTebRL2cyaiB0=;
 b=QkJ4ZQhPnt0DQN5GZtsnZT7nOlyvWRrlG/oTRG+JyTVIjAcao3soZbGyAtDwzxe5Uz
 O/HZvG21gAHUBorMzFWJVO3FI3ekICpvewiYKLIg0gt8yr9YFErdNZBbwgqxi724QSo0
 YD7dpwqczuInsBan7EAlWt2/MDu9QHxiWqDBucibM5PoO3pJ8ts/ti/Gqz+uQogRgBgi
 LOe9YyqD9Y0i0adp/a88A530H5ZGKa4aIAhHmBNYXkL1sBAB5okUKbky+uOiXY9X7sB1
 QN6fzAK5x6IB0i3EHM3kuQ6ut0vFQuNozA8VsHP7wKa9Szfh4jXRKrg/XYLh03kC5pwn
 Vn4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6pvJjNGVTvX1WQPza76k3tkc+iIQrnwfM92eoiTArBR+UsdKzXqVh+400x2QB3/46h9oCulc=@lists.denx.de
X-Gm-Message-State: AOJu0YzVtqVyyY0j6S954wptFLW6T9jbqEZVNsHXhg/oX4twQG/peNww
 JiKvDOWtXFAS3mPtx7r3yR6gSSFSM/wtsjtu/S2++7sqjwJmbXqbkH6ki31EZYY=
X-Gm-Gg: ASbGnctXab7Z0G3CbSIiMZwSKhl5TSTJq8H3JhP3ZXugQLMB8i/r7sdoWfDx8f+KBuL
 nQpPh/bWPb4nFqOrduHW/l0zYWrEqi9MN+k0bq6q6AEbiQjJobLhK2oLFwQCYUbvjTecjdEsVCv
 MuadYB+8OG4D1+FtGrIW8CoehK6hFfkLSosYIwo8KIg4Uq7t9COksqWjn0hMlhP4sRWsP53YlWw
 QjGIV4mPR+Rfgv1z1dZAz9QAGhGVJScgs/U4nJm2g+crS2R2DH1dIL6pj7YE28erU65x6qIt4PR
 5vPLHQqY6Y8/MdKMv2n6rjmJlVJu0y0Ixl/9CoX89J0CoqTdubBKLE3NKFQBp0cW6A5V+0fjv7o
 oC9uDAg==
X-Google-Smtp-Source: AGHT+IGIPExybC/8Q2hxVi+R1p2FYUm2ggKsmpGL/nfErpJffuL/Zt+CzKlqavp4IFihKz8X8cnjZg==
X-Received: by 2002:a05:6820:a10b:b0:601:d595:3b1f with SMTP id
 006d021491bc7-6027864016emr4271121eaf.6.1743179401939; 
 Fri, 28 Mar 2025 09:30:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602846221e5sm386544eaf.40.2025.03.28.09.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:30:01 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:29:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
Message-ID: <20250328162958.GD93000@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
 <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
 <20250318155256.GA2640854@bill-the-cat>
 <CAFLszTjC47nk3FmEyHw13zaaWwdcEavk3JY5iewKWF65iVqHiA@mail.gmail.com>
 <20250319154047.GM2640854@bill-the-cat>
 <CAFLszThVHKU+nZhmp5ysNxqTnLJ8AMX8E8eO2zvBhDQTZ5LYNw@mail.gmail.com>
 <20250320142240.GR2640854@bill-the-cat>
 <CAFLszTjG1pvSEV-ET+M0S4bV6biJBcS-ZodVOMhuJU7qL7PZ2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QidTkOVQplL7euvj"
Content-Disposition: inline
In-Reply-To: <CAFLszTjG1pvSEV-ET+M0S4bV6biJBcS-ZodVOMhuJU7qL7PZ2g@mail.gmail.com>
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


--QidTkOVQplL7euvj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 07:38:27PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Mar 2025 at 15:22, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 20, 2025 at 03:43:36AM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 19 Mar 2025 at 16:40, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 19, 2025 at 03:03:49PM +0000, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 18 Mar 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Mar 18, 2025 at 03:24:02PM +0000, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > Any 'bootable' flag in a DOS partition causes boostd to o=
nly scan
> > > > > > > > > bootable partitions for that media. This can mean that ex=
tlinux.conf
> > > > > > > > > files on the root disk are missed.
> > > > > > > > >
> > > > > > > > > Put this logic behind a flag and update the documentation.
> > > > > > > > >
> > > > > > > > > For now, the flag is enabled, to preserve existing behavi=
our. Future
> > > > > > > > > work may provide a command (or some other mechanism) to c=
ontrol this.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >
> > > > > > > > Isn't this backwards as the existing behavior (prior to boo=
tstd) was to
> > > > > > > > scan and use these files, and so that's the behavior we nee=
d to preserve
> > > > > > > > by default.
> > > > > > >
> > > > > > > Not so far as I know, but I've already spent too much time tr=
ying to
> > > > > > > decode those scripts.
> > > > > > >
> > > > > > > If you look at scan_dev_for_boot_part, that is what I was try=
ing to
> > > > > > > replicate with bootstd.
> > > > > >
> > > > > > The feedback from the community call where this was brought up =
was that
> > > > > > it used to work and now didn't, I thought. Heinrich, I think yo=
u had one
> > > > > > of the cases here (something about RISC-V and multiple distros?=
) or am I
> > > > > > misremembering?
> > > > >
> > > > > OK let's see if Heinrich chimes in.
> > > > >
> > > > > Are there notes for the call? It would help me if they could all =
be in
> > > > > a shared document, like we used to use[1].
> > > >
> > > > Yes, they're in email.
> > >
> > > What subject should I search for to find them? I looked for 'community
> > > call' and a few other things, but cannot find them.
> >
> > They're in reply to every announcement email and sent to all three
> > lists.
>=20
> OK, well I can't find them, sorry. I did see the first one you sent
> but after that I have no record.
>=20
> It sounds like you don't want them in a doc for easy reference?

I don't want them hidden away in some document, I want them easily
accessible.
https://lore.kernel.org/u-boot/20250128171923.GQ1233568@bill-the-cat/
https://lore.kernel.org/u-boot/20250211204927.GF1233568@bill-the-cat/
https://lore.kernel.org/u-boot/20250225191031.GS1233568@bill-the-cat/
https://lore.kernel.org/u-boot/20250311203117.GV2640854@bill-the-cat/

All of which are in reply to the announcement email for the release.

--=20
Tom

--QidTkOVQplL7euvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmzoYACgkQFHw5/5Y0
tywHkAv+Nk+U8ENSAQOMRScxYFdxo5IezXKGPO4Ec/1eUHAfkmOsG2MXLpxYsYhi
+k/0oA+lXiaqd2e6SBZCexeOlCeQZEEsQZI7VNGOfLFRSJvdQDk3aNxw2bPfiFN0
EtzaHQvUeSLM352TOCBozVyzd5HWgCCfIP//WZWyZwhZeHcclcWXrSiXI5a84Tvg
bVLBFAd3KsduWKHfimPGCDNSjukC2+bi6hKXV1xfZCRICk3RyfaNll8rVVT7ePHq
n7L1nho+J1jdA8rGef8THVWosDt6vNJecjrCmg0+MYWMmJrj+VF1RyKGXr+ccWm1
Uq4Yx/ThsCE82kxke0ge68Ce+ek5VEXQvEo5EdgAtV/XL79hkf5r8t5l2iFAasRy
hDtxXP3aZd/aGgVrhayDcKF4sdWBQE4f5wQvMIHf6DqOCDHYUaeaKEH5IWTeR8TI
O3CLe0a+hexHFvWyEsvMmh+w2d49iCyXtHOcHCgKDqOjgta2nt5TUr6RpI0q2cc1
t6PMfhcf
=DLtD
-----END PGP SIGNATURE-----

--QidTkOVQplL7euvj--
