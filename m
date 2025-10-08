Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA70DCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6712B839DE;
	Wed,  8 Oct 2025 16:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qeKp7z/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB2C83C91; Wed,  8 Oct 2025 16:57:41 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C70839DD
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-35ba7c71bfdso3948067fac.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759935457; x=1760540257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uqftDDlzIS1lTxEOoo6vaUS2rkaJZtB7ACn60fuI2kU=;
 b=qeKp7z/dBhBSJGmzMknZHiinMximv8Zo2KCZoY2UfU4Lg4mspWUsSvKXbGprbfAdAn
 18879Fc9bjhyKcYfGM61HntIv3G9d2QW6n34oQ8ql0m7SejbkPtXqgFOow2i2AP9JkP6
 8BmfTm3sJylewYpLvUbbWitBnTGmr1JOhfKQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759935457; x=1760540257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqftDDlzIS1lTxEOoo6vaUS2rkaJZtB7ACn60fuI2kU=;
 b=byZZzR4IVZu9m0h+DOvQYzMSWG/fexCC0f94UtANenevVMtpQPoinjFYKtoC0MUXfp
 l4El1VdONmjw3ZcWEN9MyWAZCmZ4pWKuST8R9o3iWKmzn+AuUDj1O7rlLCUyPWzVU7Dw
 sAaMM07o2jyQVT3B5p5YW1d+xZEBxf0xy/OcUqwaQmfhaotzBGsa5Kz2nwG1FjUtLKIK
 eHfIYJVdnjZVfu/J/0Nf2ZC8lKm2s9FLrZiiHO56r3smKPhKEXnWtRlqdEzTP3AhhGnW
 gb4OtxaehBOkrUOPUtXscs82FpYr7HdEDzsuzJh31KSJndJl2NNiH+QY/u454Tky8sjU
 gd5g==
X-Gm-Message-State: AOJu0Yz/8zBGiyHXiGXzUfcetUWLoh9ShYBvZic4/Onzld/d3BistsdM
 Cq4+G/9TTWkO3NULJzwqLdAbuuBGjYJj0X37sq3vmZAwc4c4JAAOMpf/BiB1p1QJnJM=
X-Gm-Gg: ASbGnctUpLhMPM5M/i+5E45i70ypT6z5lqDVhhGtZyrUx0Aqvd+a3iq++ZgQGSvSUbt
 yINkpavL0vDcTWlK6MTk8FHfU7mvJbVecxCbvI3Yn0uvqlbMqdIcUEEssgiW6Xg+CbZBXaEwrhZ
 vJk/3pEpDoX6wznu4KPg1frw7LzRr4LeIp381U2hgjLywSCY5dxjN7Yfuf8bOUTSi0Z657o5tQA
 6u+lmWi94ieqiFd7NjjVwKtgouX0ZrXa7zdaAC0gdJLbtlr/EBqXzLiGj26i9Dxxi9dDp0SC67P
 qYWEdBbnAbkg5aZYVtTQDX+Fx3M6Eb+ABuW8YahcjK2aoyEjaohlxY89ZX+NaahFwBq04bWyqx9
 jI1wsp15/JLbHViqT+MFmB4QUhGWA6dkTW2KSyJQVYXbIiUof8RKm9yhm3hocm7nnMmD54kOMPK
 jy/HA5d7m1PA==
X-Google-Smtp-Source: AGHT+IG7oQiiqLDMHGHm+d56C2kHx55euSQzFvzRR0Uo0CIAtqKEZC8TSzTk1V5h9lt23IaFtbQbTA==
X-Received: by 2002:a05:6870:810c:b0:301:fec8:fc5 with SMTP id
 586e51a60fabf-3c0f91a5af1mr1957328fac.23.1759935457468; 
 Wed, 08 Oct 2025 07:57:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab794be68fsm6162088fac.12.2025.10.08.07.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 07:57:36 -0700 (PDT)
Date: Wed, 8 Oct 2025 08:57:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
Message-ID: <20251008145734.GX298503@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
 <20251007181356.GO298503@bill-the-cat>
 <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
 <20251008143415.GU298503@bill-the-cat>
 <CAFLszTh=jWE0pefvXCpxvBZUtWWuJVem7f5HsYeJU1C7dkvq+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vFe6R4k2IrurhU0e"
Content-Disposition: inline
In-Reply-To: <CAFLszTh=jWE0pefvXCpxvBZUtWWuJVem7f5HsYeJU1C7dkvq+g@mail.gmail.com>
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


--vFe6R4k2IrurhU0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 08:45:54AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 8 Oct 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Oct 08, 2025 at 06:53:44AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 7 Oct 2025 at 12:13, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:
> > > >
> > > > > At present when one bootmeth fails on the final partition, the ne=
xt
> > > > > bootmeth is not tried. Adjust the logic to go to the next bootmet=
h,
> > > > > which is the more natural behaviour.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > My feedback on v1:
> > > > https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-the-cat/
> > > > was that we need to do a documentation change when doing a behavior
> > > > change. And I cannot recall if this change here is because of repor=
ts of
> > > > problems or not.
> > >
> > > This is a long time ago, but I think it might have been an
> > > inconsistency that I found myself. Otherwise I would probably have
> > > mentioned the person who reported it.
> > >
> > > The documentation already implies the logic in this patch, as I see
> > > it. But please suggest any changes.
> >
> > OK, I guess it's because the commit message doesn't explain the bug
> > clearly enough. Is this a correct description of the patch:
> >
> > At present, normally when one bootmeth fails on a partition, we move on
> > and try the next bootmeth. However, this was not the case for the final
> > partition due to a bug. Rework the logic so that all partitions are
> > treated the same.
>=20
> We can certainly say that if you like. It is fair to say that the
> algorithm is still being evolved as new things come up. Most of the
> behaviour has been driven by new tests that I've written. The global
> bootmeth is the biggest change since hunters were introduced, but I
> suspect there will be more in future.
>=20
> I'm heading out later today but can probably send v3 series (with the
> tweaks you've given) tomorrow. After that I'm not sure as I'm on
> holiday for two weeks.

Peter's feedback should be addressed too for a v3 (and not just set
aside).

--=20
Tom

--vFe6R4k2IrurhU0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOZ73gAKCRAr4qD1Cr/k
Cp/LAP0QJsPyGLUt9HOVW8pW5R8NJuyKk2y+Btr63o45RlRr3gD/RVyQEPNlnbsH
iq2hDXxb/VwoitvU6L8Gr04oa2uaIgY=
=+x2e
-----END PGP SIGNATURE-----

--vFe6R4k2IrurhU0e--
