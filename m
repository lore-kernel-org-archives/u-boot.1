Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EECCCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 14:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6554483826;
	Fri, 17 Oct 2025 16:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BgUy6gga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B3D83835; Fri, 17 Oct 2025 16:05:24 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A259B83734
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 16:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-64a6cff75e9so490453eaf.0
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760709920; x=1761314720; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LXjN5UVBBiNub8NIEO8SCO9h1T+MQzDc+Xuw4dDiVY0=;
 b=BgUy6ggatb5oSIzt82yb29l6uyxfq9R/VJ75LhUK8yvmzIwZqZfZDX73TemCvd9mPd
 WbAVG04Ab+XbiTs582BEzAM+XSbP0IFmuB1CunYMFvJ4Q7cY8sBRdao4x0hqaQhMyV51
 3WUOUF3P+OfjdAUL16hGVrenU+YSMftPHQw8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760709920; x=1761314720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXjN5UVBBiNub8NIEO8SCO9h1T+MQzDc+Xuw4dDiVY0=;
 b=qeCIvTpcjGu3SvGATXpTYKbTwiePcGyXXk2/VbrkCyrw/OQmWJUVds0wEOt2KBvjPJ
 bUQWm7gTu2O2bmiGkWdWZMoYbRH9kLba+1XJFMWsdjm/cQdg6G8gJdWOxG3GN9G6HIQl
 m/loEh6jKPIkLe1REhryvSpHbhFjvRPpvfEnbDo+nU8Y61OSQa4EbkyhP+JSgT+NMnDA
 Jeij2VXL54hs1hfeCj04PvJZUcRnPitqbvSKfPdSjrH9U/ANVeo3K4klAdFPBjn04uM5
 4l6xv48400wBP5DGTxTa2G/kIXR1diLkRuTY51YplyChtfN8Qaj9QSEVV6rJeKjFx+hF
 HwNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqkrw1bpgM/UK2Piy5eE1Avgvf5b1DmOLtbCEMcl7YyFBCFD2nkzlaDlhxdSbB/r3yBBL0w2k=@lists.denx.de
X-Gm-Message-State: AOJu0YzSpMphViSmQnDGAmealS9hGY2nwRD166ej9Q5qHVtaHcRbq57R
 cAsmOBA6bThyIgGdcjhB/SL9Izt5gjGq8zA38gleNgz07h5qN+mXThANi8LgW3H8D8U=
X-Gm-Gg: ASbGncuh4prCQo0KuZWiLpTrUT0X8nekV9QzmBN8dzikhXJoSHb3AA9ftKomdxgW8JH
 h45zOiFipjziWSaxoj5hkeIln5BZ7z5hhc2K0zIivIeAYF7y3/EpyrjnDKIHq91jEKlm98hl1W9
 TGxTP58bBxXknngdhkUGbCAGoIJXv93uE+GvD6TWHiYcXLqvy+LJZei0GXheDliBso7/bGHeanK
 dO+uzM9AFkPlsDI2w1OMBR78+xgDphwLnImt1U3vBsSt5qHiiovy8hxc29rK133ol17RKzvjBrT
 JHhBj6L4q+J5gsWRhLFcf7dhqtgJb3fbGuZPQg9+7Mr/TRn+ztAr51LPzldDyTL2ZY0WkonmsTR
 qqzJrGg2AeY3LG0wZxxh0ErIvIS5oWzDjH4xlUlelLZ1+9SN9tb3v9zydGw8fxH9l0FRd/equXL
 lPlCbIJu2omyDITbLap/O4CizF73gE/0Dc3mm0VAk=
X-Google-Smtp-Source: AGHT+IE8jJkiLrM18X6D7Rqs+l8a1AVj+DvQTmD3Dkb5fTKhsBAdghRToSswvSwWAlvoBG3TNQWEPg==
X-Received: by 2002:a05:6820:2913:b0:621:7582:b2b3 with SMTP id
 006d021491bc7-651c7e274f2mr1523830eaf.4.1760709920017; 
 Fri, 17 Oct 2025 07:05:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-650181ff02csm5419939eaf.16.2025.10.17.07.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:05:18 -0700 (PDT)
Date: Fri, 17 Oct 2025 08:05:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Simon Glass <sjg@chromium.org>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 open list <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/7] doc: make pdfdocs: Add pip install -r
 test/py/requirements.txt to the list of needed steps
Message-ID: <20251017140515.GE6688@bill-the-cat>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251005221057.255029-4-adrianocarvalho.pt@gmail.com>
 <de5cb786-0a26-40ed-b120-321afdd23624@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eGXy5TG4nMSifWIx"
Content-Disposition: inline
In-Reply-To: <de5cb786-0a26-40ed-b120-321afdd23624@gmx.de>
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


--eGXy5TG4nMSifWIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 03:50:44PM +0200, Heinrich Schuchardt wrote:
> On 10/6/25 00:10, Adriano Carvalho wrote:
> > As requested, I added this step to all doc targets.
>=20
> This change looks wrong to me.
>=20
> Everything needed to build the documentation should be in
> doc/sphinx/requirements.txt.
>=20
> Everything needed to run tests should be in test/py/requirements.txt.
>=20
> If there is an overlap that is fine. But, please, abstain from confusing =
the
> two.
>=20
> Please, add missing dependencies to doc/sphinx/requirements.txt.
>=20
> >=20
> > If I don't do this, this is what I get with
> > docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
> >=20
> > uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
> > [...]
> > WARNING: autodoc: failed to import module 'test_bind'; the following ex=
ception was raised:
> > No module named 'pytest' [autodoc.import_object]
>=20
> Why should pytest be needed to build documentation?

Because the pytest documentation requires it, ie
doc/develop/pytest/test_*.rst.

Can we just list pytest in both requirements.txt, or will it become
annoying to have to update two places each time? I'm not sure.

--=20
Tom

--eGXy5TG4nMSifWIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPJNGgAKCRAr4qD1Cr/k
Co2EAQCDJubirUG/UN/Hqa/oFELUvQ/NEllAUYuIOO6gE1XlPgEApkpuq0SwqwcT
8rTbq0s9vb4kz/04OZf/kFec1ZLtUAo=
=vKVy
-----END PGP SIGNATURE-----

--eGXy5TG4nMSifWIx--
