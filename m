Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D4CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 267E884843;
	Fri, 15 May 2026 23:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YLyCbPLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE5584865; Fri, 15 May 2026 23:43:13 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F305084812
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 23:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-47c35be031dso257670b6e.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778881390; x=1779486190; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+FFwCSAEfSCa6Xmh9Agx+/fC8WNAOnHMhFCl43Z6gV8=;
 b=YLyCbPLHBYxBIFE9HWW0FgT3fOsMqMa4w0ISNViDkTt25GFI9riy4Je9DzqrexrsrI
 J2hDsG9SPSKPckkvzbYv4AQnPyXIS1tN8VI4hB54+DoXYn57qt784F7wcerJxekqMuks
 n5Z6dC/nMro23IvN/xMKOX6OG37uTqAmRmn2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778881390; x=1779486190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FFwCSAEfSCa6Xmh9Agx+/fC8WNAOnHMhFCl43Z6gV8=;
 b=LGw2dv37DZ+nTJFMdvUJor/RY3DO4OGWe/z+yMfJ4uZNaCiXdUV3WhB4lOKCExqbaU
 pKAuVEIIMUwcigqJMrJ6LDDwYfWMfzz1I5S2Au0iCU7Pk5hxnYwMeAjxQ0oFpvOia6LD
 D1GAoziGEjePNfuVaAuhRYeD8wEz1bQ5ZnxQXnmyoKK+V7T0Ou7k5nYrqpMMxl4stFJo
 Q96hxsWzybz8Q9DcRig15phFoL3QOYfW9t62cIT6lHQuRcVpGcZFBU1nas8euupW+yBz
 xycrVWlFS/AO1iObkTUCeNskcuxK+2oN43zHaoIIEXylxeAtZO5m4w4O3Jot2pCWvtxP
 NbeQ==
X-Gm-Message-State: AOJu0YzrwswSry01S4hkJNUvYJjUD519TMhtSZuG+gRpKEgf2ViqjFdF
 o2mYHA8s9WdsokqK8ZTAHeosG5/RbsF/eo3tdtwKfrIFwzgaN/UsGRK0xTNjkdxfCx0=
X-Gm-Gg: Acq92OFyTIaO9gI5X5B6dMGC7dLsdUnVgOThgAjS7QwAQXu67Nr/ZIX+/m1Fe7qHikM
 VE5ggpr78ur9dKMuIEat5J8eqLAlZy2ZopEkTE5q5sTv3IYMOWyx1JeonfP1wcCZFejpjfaCFdg
 sCqfDFQwhyuTYvGuaY1mUN8acIBFvzdEytuz2QMWwgwir8hrhJ8nvmkdmfDKVT9Iy5kQDsozxD3
 I0rNEw9+Nab2glyL8EN0jeBQqJgKwxa889viNVgv8vpaiOmOsrdqUm8s199Z88zOsP2tyjYV4hb
 hEZdZcEXhMOw6qcPCdQ7HpzZzdgJDkfQNkzBJ5qgrZtrJqAsC7n81QluYyALYWTi3Kwg8prR1Qc
 VdTV+JfAggxg07HFPsn78o7tjanhM5lmCDRahGVXj5tt8ydSdjZBGX95dESHAYL8cyPG3fzRgKF
 gvOzMVnXq/tcZ1Ymt4tvtkcpkV7VyBKWj49q1CW47ScVNp0kyjHLZEhIWWuT27qxhRA/4Rc8PeA
 udo531zvnZTZK04gvB8udUu6UJYdK8gCJ8ZckGLUyZN1Ey7u4SpVLCY3uTlaA==
X-Received: by 2002:a05:6808:1a07:b0:482:5bd1:d8e5 with SMTP id
 5614622812f47-482e55afc67mr3682025b6e.9.1778881389613; 
 Fri, 15 May 2026 14:43:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2560042a34.12.2026.05.15.14.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:43:08 -0700 (PDT)
Date: Fri, 15 May 2026 15:43:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [RFC PATCH 00/11] Tidy command option parsing and use it a bit
Message-ID: <20260515214305.GL1858239@bill-the-cat>
References: <20260515203311.2555651-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="funH3/SH6/6AQip2"
Content-Disposition: inline
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
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


--funH3/SH6/6AQip2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 02:32:51PM -0600, Simon Glass wrote:

> We have had getopt() for over five years but it is not much used. It is
> much easier to understand arg-parsing using getopt() and it avoids
> common errors. As the named maintainer I decided to look at how to make
> more use of it.
>=20
> So this series explores the impact of converting a few commands to use
> getopt() instead of ad-hoc parsing. It updates getopt() to handle flags
> anywhere in the cmdline and provides a few helpers to reduce
> boilerplate.
>=20
> The chosen commands are:
>=20
> - echo: very simple with no flags
> - hash: fairly simple with just one flag
> - env grep/export/import - fuller examples
>=20
> The series also adds a recommendation to use getopt() for new commands.
>=20
> To try to reduce the code-size increase, a lower-case function is added
> and called from a few places. The difference is fairly marginal.
>=20
> Overall, the result is not pretty (see below) with about a 1.1K size
> increase on arm64:

I think that means this is a no-go, and you need to work out what might
lead to a much smaller growth here.

--=20
Tom

--funH3/SH6/6AQip2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCageTZQAKCRAr4qD1Cr/k
CsyRAP97xhPnOCIyzCvjIf7Iaq3YuniKqnNY59fsl5B+k2saCgD/aBfYfIPmE21M
3beRwSRkq75MjXGCIWZ2OdZju+xbtgg=
=vAZB
-----END PGP SIGNATURE-----

--funH3/SH6/6AQip2--
