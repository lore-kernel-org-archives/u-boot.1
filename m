Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1123ACCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B2D583A8C;
	Fri, 31 Oct 2025 18:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pJi54c0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D73A83A8D; Fri, 31 Oct 2025 18:47:40 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0564983A7A
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3d220c5a16aso1639431fac.2
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761932857; x=1762537657; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JqnzJtVrQknUnWA1XVJThI7v0ePAG+yOW/AqMTPTUtI=;
 b=pJi54c0DmrEHe+qe/xpJsb2L4/OFgW/wmAnMpXOcSzUMrZiT0dwoco4a4srcytDHk1
 0Ziqg38OD1UnQRrfgifL8AlPhYG71ZM7Z9QVlwaedY90EF8PXZ7NUpl/l3pq1L9TqB8s
 skkKyl2F23C71I1KoEKM8MxrAa5fmxzNkpUNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761932857; x=1762537657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqnzJtVrQknUnWA1XVJThI7v0ePAG+yOW/AqMTPTUtI=;
 b=PoZmgIlIPsK0ABtFWz1MHUjq01Sg5anPtQPFY9sV8kZMBUla3bcDn4Pq8frmT0AJ+6
 zYzv9lelDjj/cGHTbvfBO8vDKGIMQ0TY8h6QaRqRjlbIHXuA2UYD19KkZ+1TZgZwZAZu
 77bbch7VPFQhvjBAXBzUbtTf/WEBCzyihnVbKmR+W4oNTHND/MnODbKlqJ0ByqXOQKdQ
 0RYZzO9qW1FUTwUqo4m21fY4JUTGNzOBwHhxYooXEA6nENEy5wVps56E2LB5qI2NUIGB
 Sky+NBtvxbY1X7hnZc4WqTixaYJr5w0wvVSBRI25Ve+clog4qcc8IXDVzBJH0pQkwy3O
 ed9g==
X-Gm-Message-State: AOJu0Yw5+KvGr8EmHqslvqWCi6Yw3ZVAvHONs1WrsL6PFX6P7JLvNDD7
 U/TRbl6ZMqyTrZJqkwMkzW5EZFKzkSQByeOhX9S7XdRxwENAMBPbSaca/VUfOXDCda4=
X-Gm-Gg: ASbGncufM6tOwg08t5zLS8KHxRYR7/W0tvewDf7k8GWTBTvg1TZkZDI8aXp9reipN5s
 eu7gWlULrC4TA9cLSCmrTiFmoePVqgJOOGDax0/2lfcDudm4KJMpTOueH0qhfkBBMyYhafaF97A
 EEKKhHiA1Z6v9fPTkVebnMn0Ef0D9QmWnjvjdSRo/K2MqsL2EapjM+FLQsTVXqnqTjBgHhF04Pi
 +7nRiReIBPTFtAfbG1cRU+JAk8Ym4B7pcEbYWaZ4+nmwt3LUXfecK/oKpm2eft4cy8+h6UWev6d
 JYajUsMkTPthpod4Va6PBcYWmQ0hvDX27X/pulJsk1+CauJcPx9o+gq+Nf5C7+UOC8EBL2xoRiI
 hWprl7bSMrPY0Xp6Rk0D9pgTf72AHuD8CJtgGEVkYprw8BFFX952nY1P/H4B9aYwz0N4pkaUAqO
 4Msxwe+YYHw46ZUK5AINp/gP5COcz7PcmawLP1XTYLnK+S7gac3w==
X-Google-Smtp-Source: AGHT+IFKDiZnYJ8PUDYZaHWqwH+tgpGKp6TuRMZQ+Jocd89XQ33R78uPWTAp7JfGZ4XHk8sTksSYig==
X-Received: by 2002:a05:6871:a206:b0:3d1:cea9:7dca with SMTP id
 586e51a60fabf-3dacab331a4mr1679589fac.22.1761932856681; 
 Fri, 31 Oct 2025 10:47:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c699d9dd7fsm703343a34.21.2025.10.31.10.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 10:47:35 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:47:33 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 0/2] Add support for customizable find_distro_rootpart
Message-ID: <20251031174733.GE6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A1o5T4U2Dv3cOhsS"
Content-Disposition: inline
In-Reply-To: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
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


--A1o5T4U2Dv3cOhsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 05:36:02PM +0100, Kory Maincent (TI.com) wrote:

> Add a customizable find_distro_rootpart command to allow each board to
> define its own logic for locating the rootfs partition inside the
> config_distro_bootcmd logic.
>=20
> Convert am335x_evm board to this new find_distro_rootpart customizable
> environment variable to locate the rootfs partition dynamically, instead
> of finduuid which hardcodes the rootfs partition location (mmc 0:2).
>=20
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
> Kory Maincent (TI.com) (2):
>       distro_bootcmd: Add support for customizable find_distro_rootpart
>       include: configs: am335x_evm: Replace findduid with find_distro_roo=
tpart

The first question here is, can we migrate these to standard boot
instead, or is that kind of functionality also missing there?

--=20
Tom

--A1o5T4U2Dv3cOhsS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQT2NQAKCRAr4qD1Cr/k
Ci/6AQCytdOOV2tIW+T7ag+fLMkvF5qH57WAs/iENpBIZ2PH3gEAxEk6hh7msthX
7vJ6fJizbs8Kxkeww+BlPe1DiKOFGQM=
=QNtc
-----END PGP SIGNATURE-----

--A1o5T4U2Dv3cOhsS--
