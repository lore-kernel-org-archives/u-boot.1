Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D20CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 16:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2749D832EB;
	Tue,  2 Sep 2025 18:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q+tDqRnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2ADA8338C; Tue,  2 Sep 2025 18:13:04 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6298329B
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 18:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-743814bcca2so36234a34.0
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756829581; x=1757434381; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GGNceT3zXp4er8l1UewG4N7NTXGOVLGN6tgfqYSpZfU=;
 b=Q+tDqRnZO11KqelhsWnryhVqNpaIkt4hZyp4ANXCON005m9NIOK58IcmadogEzHcP3
 3ZpVtLbytduNC48R4vvMl3bIGK6LRFzWrgoNu7GoxhXQA21TMPwIYI1x7hTgZ3dY1GYo
 VIHbsqycjf92NCKxY/2X5O8jdEdm0322TGTq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756829581; x=1757434381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGNceT3zXp4er8l1UewG4N7NTXGOVLGN6tgfqYSpZfU=;
 b=FsrGz71OXEUTW6DLgY21BnfHBfbw1mZ54VAwPzOwTPIQ+5ddcqB+XkENR3NFFLTxlt
 DKbx70VQQbs4ZjzdOsWeTKOEcqWxcFdZBi09MLd9yPoBTuVtkXBnWKVMdoA+ISyg+QxK
 H5wplcXUaVLrRbJH8qA5BXg/bxTbw0Me0AQLhseMSV78jwLOHCEq1CE9Yocc2xH8jOvo
 H1dpIN0ujxx70KqKOJV9zg/9x35RG9PhwzaYF+i/ltVbdq1BFX7WEhgOFrUy/ISsgnov
 4E/tWKKxvsPmvgcnbRWn5fbk0Zcly1T3Sm8U25CAFaXxkuOovFUFKCJGC67mFOnKpQEa
 ubYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhuaOorDCB5ccMXMCpTasgFZNuFSXFqaW4zM+Vjl1KQa2+0893kyjJwJN4oKCpLdGfHIFnisY=@lists.denx.de
X-Gm-Message-State: AOJu0YwrXoIlG+ox+tPywGgU2TiJCrpRXox5myQLGIi3NeE25uS/I12W
 8MpBNerhR+4HpwohyvRmrRfuUrrjc256YuMqmkepS8vGX/xEd515v2nqagK1P7MUZ5VnRxtqcKp
 U/OO8jbw=
X-Gm-Gg: ASbGncvmktrrqJkLor52wIVMZ6Xhp2s1WiDtQCLU+FCTStbc5lgtQhuKMWNwQalB9nf
 e1U1qeOkZ9t2WjO26CyZ0I4ZkVvYqrHAoxVNtw5xUxWcQw/Oqmb+6awPIg+qXUvi7VOCIwBi9IE
 gvAP9QWzFF8qbtWHwyZ0k7x6JlH+aJEvAzJykJDcCWazidqpSbVVEN39P02TCp9IaNxjiSpaXFn
 TB4H8SXXGR6iiJKXPgaBepVIH92rRU9h7aZ7qOoo8hqy9dR4V1YmjFMA5WscwsOMitmdKz/WyZC
 PgSMu9Bgj6QfbtvoXKqJA3fyajpfMEBIf3ravsl5nanGnkXwWzsw8u4cKUYg5W3zt75AhDU0FvL
 4YWuEglHNSjjmI4d0/umIj7pmOvXVhzklQ6iEaNTaY23iiY86NE0vLa1lT/x+opkfBcw=
X-Google-Smtp-Source: AGHT+IGdVqskniGGaTTswkZKxSMDI7eUB612L1kHJQXnOOiOhBEy9WN/Bos+BsPMQHxSRkYtmbUcnA==
X-Received: by 2002:a05:6830:7101:b0:73e:9fea:f2a5 with SMTP id
 46e09a7af769-74569d9deb9mr8440136a34.4.1756829581157; 
 Tue, 02 Sep 2025 09:13:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7457438a622sm1664374a34.28.2025.09.02.09.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 09:13:00 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:12:57 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Anurag Dutta <a-dutta@ti.com>, n-francis@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/3] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO
 at SPL
Message-ID: <20250902161257.GF124814@bill-the-cat>
References: <20250902102000.1388848-1-a-dutta@ti.com>
 <20250902102000.1388848-3-a-dutta@ti.com>
 <20250902154656.GE124814@bill-the-cat>
 <5fec7216-9e0a-4d97-af23-60953cc1ef75@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GWzU4sjEzIdJVeLE"
Content-Disposition: inline
In-Reply-To: <5fec7216-9e0a-4d97-af23-60953cc1ef75@ti.com>
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


--GWzU4sjEzIdJVeLE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 09:36:25PM +0530, Kumar, Udit wrote:
> Hi Tom
>=20
> On 9/2/2025 9:16 PM, Tom Rini wrote:
> > On Tue, Sep 02, 2025 at 03:49:59PM +0530, Anurag Dutta wrote:
> >=20
> > > Commit 0e198ff1a911 ("configs: Resync with savedefconfig") removed
> > > the necessary configs required to boot HyperFlash successfully, due to
> > > missing Kconfig dependencies. Now that the Kconfig dependencies have
> > > been added, re-enable the HBMC and MUX_MMIO configs in the SPL stage.
> > >=20
> > > Fixes: 0e198ff1a911 ("configs: Resync with savedefconfig")
> > > Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> > Please note that this means it never worked to start with.
> > "savedefconfig" does the equivalent of "make foo_defconfig" and then
>=20
>=20
> It was working before but due to some boot issues , due to DT sync
>=20
> we disabled HBMC with commit id 5b2671594b80af116e259313d48bcd580d71f462 .
>=20
>=20
> Instead of saying Fixes: 0e198ff1a91,
>=20
> This patch is fixing sha id=A05b2671594b80af116e259313d48bcd580d71f462 by=
 kind
> of revert.
>=20
> my bad to give R/B , overlooked on sha id of fixes tag.

Again, no, that's not quite how it works. When we do a defconfig resync
like this we're just making the defconfigs reflect the present reality.
If you checkout 5b2671594b80af116e259313d48bcd580d71f462^ and then look
at the resulting defconfig, that option will be off. Doing a git blame
on drivers/mtd/Kconfig the right fixes tag is for:
commit 8f71d37838ba0b0bfa047f5133877092ee9d1110
Author: Anurag Dutta <a-dutta@ti.com>
Date:   Fri Nov 29 17:01:36 2024 +0530

    mtd: Kconfig: Change HBMC driver's dependency to MULTIPLEXER and MUX_MM=
IO
   =20
    The HBMC_AM654 driver was dependent on SYSCON because syscon APIs were
    being used to select the multiplexer state. Change the dependency to
    MULTIPLEXER and MUX_MMIO because mux APIs are now being used to
    select mux state.
   =20
    Signed-off-by: Anurag Dutta <a-dutta@ti.com>

As that's what changed the dependencies for the option.

--=20
Tom

--GWzU4sjEzIdJVeLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLcXfQAKCRAr4qD1Cr/k
Cm36AQCOpS8/XLrPeFUEICRmiy9LAqvpAwxOlI/5xw80cTrpagD/TFLgEoJ4sHFa
jdbNdiT3SY/NRQHAxNLyIj1LyUav4gw=
=ehyh
-----END PGP SIGNATURE-----

--GWzU4sjEzIdJVeLE--
