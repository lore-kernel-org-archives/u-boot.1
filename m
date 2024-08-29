Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE6DCA0ECA
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 00:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5977F88C67;
	Fri, 30 Aug 2024 02:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c6M8/OiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CBA88BB2; Thu, 29 Aug 2024 20:33:09 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DE788C5C
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 20:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4568571de47so4042601cf.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724956384; x=1725561184; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LdyhFHiI3fLVCzNhNbBgUOzDfmbAlvyDsSGYF/dfZPQ=;
 b=c6M8/OiQ+YaHXV5QGx+h4DZTyGi1IsA6RY2kzecYvvvR/kHTpi18+8wTqDjRlXM2lo
 ZGgrlX+7VME6B4PwGwduQ3OXTRzocpE1ZhdzCkizl+bz7CDLRLy9X6BAfGulLDdNj4LN
 +J8JGxw3OWlSr6Q6BXzJIJKeUrUt26f/21OXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724956384; x=1725561184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdyhFHiI3fLVCzNhNbBgUOzDfmbAlvyDsSGYF/dfZPQ=;
 b=a0k/3Y15fedTpzt1Yve5KnSv0A7CW0lYVswZ7F8zF/vyHd41/JxDbnXqGuW9bkjlGd
 m8SniRCWV8Ro6GZMpT0vGKN6IxebQI63pEytWvZm2guXYMSw6poz5FDfwsG4ylHUo37r
 oQwK02K/HkH/msuC9Q0nSP2Y6TbpIRKw8wJLBLXxkDuNQm4JFs971h8Uc1+s+H2gKqly
 aykok65mDJZjPbEPkEEZqeD0ycTRRa3j8BLLzrdHtNTqBuFBVqK/iAs2UtZv8yqdxKOH
 f/plxy3dEfDE6SAd470wZrZBIIVSXjhtl3hjni7pLqXgj6H1+uAXJwmZJboCQsKzS444
 pVLg==
X-Gm-Message-State: AOJu0Yw2hvBb2A2StxXaxn5S1t1vhZMFLGrH5gWU3ZmFlrRwymgYyJ75
 UPxFGqRI5kXepJY9dh1YBTilr156lc9B3rWn19NsGCWOVbFHloEA2nU8gfnsguc=
X-Google-Smtp-Source: AGHT+IGknn1aU1UJ4AiAT4xoY9weqceBa34dSneZgyd+sBu0Yr4Jt6gxvYE0gwsuSxoN84nQyn2Yog==
X-Received: by 2002:a05:622a:4d9b:b0:455:6e2a:1504 with SMTP id
 d75a77b69052e-4567f52fff0mr43365271cf.20.1724956384318; 
 Thu, 29 Aug 2024 11:33:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682c98067sm7198151cf.22.2024.08.29.11.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 11:33:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:32:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Eddie James <eajames@linux.ibm.com>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 00/19] vbe: Series part E
Message-ID: <20240829183257.GN2479150@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BVuA7N2Oz0EJjNiv"
Content-Disposition: inline
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 30 Aug 2024 02:36:13 +0200
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


--BVuA7N2Oz0EJjNiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 08:57:43AM -0600, Simon Glass wrote:

> This includes various patches towards implementing the VBE abrec
> bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> fatures are available in VPL.

A lot of this series makes me really want to stop and rework how we
configure / build things. Having say ZLIB, SPL_ZLIB, TPL_ZLIB and
VPL_ZLIB really isn't good.

--=20
Tom

--BVuA7N2Oz0EJjNiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQvtIACgkQFHw5/5Y0
tyx/Owv/d2xDlxsclXlKvjHd+5MEClgJzkQaQSM9qA4scg7c1uC7NUian4VSMsue
kM06g0FFPsUKLyFSXMdOZ+p8bRh65sdWY8nOj/kcNLvLUF2KHYQ33reyf5YoOpoV
jiXfZ2P3LVWT4tJCLeAAiy2YJ0MZX84UE1AAKTe+qgCaYL01J9Rr1yOEbTzxPFdv
TOxs1QRQ/OIbuEtilZRNHrSwzPFy5PzaZaRJSbIr9VDDIlP4bMjlgasCX0aKbdVG
ut4kuyg742dBfk7FnrKm3y3kg+pfTerTnotm2yCmuIYRGWcTUeuY7sywfE5ryNbd
UdBHWQLmo9uWFxuh4i+s01TmzqjIz5w1ln3eL6bMGvfiXlfNOsROwiJ5eBMB9cY/
9reNOIyEbNpH7tFI+PfJ/mea3cT5FS+XcHZVxYZV2sPVQL9U78j8lPELD6DyPZ1H
qXrO9cI4MHYjBQub+so8burMZhLyX8PG6tV3Re9/7cj19p9Lx0poNfpmWKwDuPC5
Xz0TRCMF
=6VMA
-----END PGP SIGNATURE-----

--BVuA7N2Oz0EJjNiv--
