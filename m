Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3196EC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 20:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A50AB8780E;
	Fri, 10 May 2024 22:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VkY1uUBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C27487964; Fri, 10 May 2024 22:01:04 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD9D587572
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 22:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78f043eaee9so144282085a.3
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715371260; x=1715976060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ULkJnyfnK7aIe5NfzCFTlg95J7sOhuz5DJvzuW6uurU=;
 b=VkY1uUBMYfh4/bUnlVIuE/1Meh+FIc9fBh0fhCmyuo9NS/PIuqS0mYouWLhVtYDe9C
 Ewcgck735MZ6lIwy1jkBfRWlsZFtxvRWpuIOuv0KC9/RHfazS86UjNRorbw02PJ6Acz5
 7CHXwdNihdLRd8pP6CL+t3bi5iJYvfzfrxaHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715371260; x=1715976060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULkJnyfnK7aIe5NfzCFTlg95J7sOhuz5DJvzuW6uurU=;
 b=emrnMl/L2FTIPkruY0C7rT4qP+ly1f5/aH3egRAj/fQDnVaYheju+w94iNQ4UAjG3f
 Q/16K12mVwvy8qjgvJOqyBKcsJECcogXZ7NMvvKXNNfHj9WuB2gXIwcmUcbDmXhiA3YO
 e/7g5o7kwpRNFYLAeSVxs9ZmsDf42hIpiCQjl5GXs+WKHVWJGhLqgfLYeqYhIAoYpocO
 gPdvixgfnuCptTrGXog6KURAt0FDDseCgooZAsLJ7Hiq/mu/KDWv/Pd3UZg0sveF+BNL
 tTSDtWxyXU7QQJoLVEr1U6H+SjuSx1jqn0iua8lrAB1TzAmjlAiDUKzsGSZyhx3y9asu
 r44w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1B4tN+DXpwcVlWf+VupykhkjiePzm/pk2gRKcgqFWu+x8KRYA6nngCyQ4jEcFDAFVcxhDnRK4U+ArGickvN27RCIFHA==
X-Gm-Message-State: AOJu0YzIHT2ejDa+vgPVWNSu6ijwthQvs8jAIEnt5sz7T2ezKp11YuQ2
 DWmIFvnjZsPTJ3Xtga6/l1qVgpL41HLyGqevHrRpImDwZA0Vl0jnHETldRgVsw0=
X-Google-Smtp-Source: AGHT+IHgauVNTkWsjdCJz02XFO06GxKHjE4EoqPlhs0DRq+mtMZ2cYzQ/rNKBDpfrNi/AK/tj3qQ4g==
X-Received: by 2002:a05:620a:51d0:b0:792:c429:1267 with SMTP id
 af79cd13be357-792c7597e48mr367574685a.24.1715371260546; 
 Fri, 10 May 2024 13:01:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df5da15f4sm23951001cf.68.2024.05.10.13.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 13:01:00 -0700 (PDT)
Date: Fri, 10 May 2024 14:00:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-ID: <20240510200056.GY2568172@bill-the-cat>
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
 <9baa5ac5-8ce9-4aea-9a3d-ec1d68ea5505@kernel.org>
 <20240510130830.GT2568172@bill-the-cat>
 <08b22e06-f316-4ef6-bd42-a4600f1f8035@kernel.org>
 <20240510193325.GX2568172@bill-the-cat>
 <20240510195837.oebzog4czpn4wzxs@spearfish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oWKfwDrshOo6enLU"
Content-Disposition: inline
In-Reply-To: <20240510195837.oebzog4czpn4wzxs@spearfish>
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


--oWKfwDrshOo6enLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:58:37PM -0500, Nishanth Menon wrote:
> On 13:33-20240510, Tom Rini wrote:
> [...]
> > >=20
> > > [1] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
> > >       commit: 0b1133ee36ecbf3b02f69cc4e8a169f1b6019e40
> >=20
> > Ah, since it's been merged to -next now, Nishanth, what do you want to
> > do?
>=20
> No biggie.. it is on route to kernel master anyways, was planning on
> OF_UPSTREAM migration for beagle once we settle 6.10-rc1 settles into
> u-boot.

OK, I'll just grab this iteration.

--=20
Tom

--oWKfwDrshOo6enLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+fPIACgkQFHw5/5Y0
tyxTmwv/RHypvnQvxhj0MF7z0ymriwPy2kNO/Zo38A7Os7Ex1eRdjDgiyvR5VRQO
j1Z/pgnUSG5hY6AJrTNFy9/uGLtJGIinFKhuZ2Z6XGM0MSogt+XkFVdbsJm8aue3
V70PhD+DgDvQkaqD5k7wX6P8eZ0ryOBDh62wUF+MBKAYls5Y7LZnYr7pTfIQ44Uz
CiVCU4g7THBMm9tyCDAxKDKsyHK9YLYmdm5NcV65UClXuKL4r5K+9fmVaLLh1QRk
jgumU3WQ9M5cdMZMI8SaXQrA4VU1vWVR3QOQZEm6u4f8Haci0sZCXvRXo2hwd7dk
izA5FQJRAILzkb+lTPliTGB1FUVfHD0sO2+kShBQzGE+jh9VTf/wZE+hPm8+nDLv
h//xpbA04sAYflZnnM7Eif4KrhTnwMQHPefauzObhdLE7oYj92thBhEPTUTp8ViC
jmKRwdAiLOL6XOoz3+yo4GcgvliDBJWHYLdh7bm5L4Vecsb4FNwSMKCvl1M6MMXv
rvQhVgRX
=zo2/
-----END PGP SIGNATURE-----

--oWKfwDrshOo6enLU--
