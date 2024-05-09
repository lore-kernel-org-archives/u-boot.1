Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40C8C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 22:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A74B8810E;
	Fri, 10 May 2024 00:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ie7p6VEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5D988167; Fri, 10 May 2024 00:23:39 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B36A87D33
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 00:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c98b66c5f9so833782b6e.0
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 15:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715293416; x=1715898216; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zFxIeHSoFi5MbPh0QF5Ders9os1H1bT+GionFyfUpYU=;
 b=ie7p6VELeUqg30vr6aCYnqWtYH6zBttwNWabPjvoKPwhXffdqH1fvP5rg+4GD94vZN
 i8IreLEN8brCPUlUG6g5EaHHdec7hLHiOL2clE0fuFR2vBsh78EPvKnIh8glC+3dpjIj
 IRyui2aKLUFFuIyzxgnMX5pzk5u2KzC9wACKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715293416; x=1715898216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFxIeHSoFi5MbPh0QF5Ders9os1H1bT+GionFyfUpYU=;
 b=bWfK4VKSFItX3fdirpUmgL4OWHEBiNjts11LlMwiE3IYR/htNMaDkwqdCCQICVQABn
 Ltnjqdq7RlY/L6rtqqpRKNtqHbClDhQMmmJzLxghblOpUWCIgK0qtfhNshkIkZKYsICO
 IcFmqr+Gmwz3Affe/0dMJSmbvBt3bL91OEKEDoN/BBROnozwNV2dIPRQykYdRVW7Wztt
 LaEN/xMZZtLVjLDRVip9ky0V3JR8WQaca3M9fdohaNQupla7BPNFzlwJaIL+QJa7A5Yd
 ibCSpihNvym4Hl57GWoAtHqSeTGNM8LPIv7JXLQUMqunIICCFDPH5Fl9biqF7cIt3ZeC
 CGCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzTAJzEHuRppHcEIZsVXA+n0Nu5ErXOPQWrWy0XzZYblcnvbuwOnk9VSNV6dfD2qrmBYUNUpbRy3zt2TjF3R6P5+1riA==
X-Gm-Message-State: AOJu0YzF6n6pk86P/kIO1sgBsmERaa/Ijr7v9aHHN6QA+HJ5ETv1Mmc0
 wfEMSWvZ9UFhRun+eHTQDguNCfu8kyiQ/PB7AOFDYhdh8UQTRy6QzeeABwHrjKI=
X-Google-Smtp-Source: AGHT+IHaAFnXvWihoy1YUgqo6E/8aS1YSuTCDnhXJl2PY2guzJarPQpuPGzGTfOVzXWDjlFb9tVL+A==
X-Received: by 2002:aca:2117:0:b0:3c8:6468:73f6 with SMTP id
 5614622812f47-3c9970b9585mr966222b6e.43.1715293415870; 
 Thu, 09 May 2024 15:23:35 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f205d88sm11010726d6.144.2024.05.09.15.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 15:23:35 -0700 (PDT)
Date: Thu, 9 May 2024 16:23:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 04/19] doc: board: ti: am64x: document OSPI layout
Message-ID: <20240509222330.GM2568172@bill-the-cat>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-5-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xHkvda6gtALRD/cs"
Content-Disposition: inline
In-Reply-To: <20240509164123.1753050-5-j-humphreys@ti.com>
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


--xHkvda6gtALRD/cs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:41:08AM -0500, Jonathan Humphreys wrote:

> Added OSPI flash layout diagram, as well as example commands to flash
> firmware to it.
>=20
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Thanks for reworking things to use SVGs here.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--xHkvda6gtALRD/cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY9TN8ACgkQFHw5/5Y0
tywzDwv+J6SuzewAxzpl//9+woFEXXQ2ga+QHTtqVzn5U+IrBBk1tjUe+/7QshO0
p5g2po0Uh/twHBoz/f9MMcR1BTslHeUrJg++NOYc5TS7TKDcZdm4XyRjxcaMlIME
s+4pkIVN35Ibm5cdiOZuNc3BZDFdXtw7F+PNBhPE/i886APpf1syFAVKcVsrUHzT
D07P3SeT9DmBGZseU5C76H1gMfjd8RCnqjnSnI/maZTlrR0PZeNG0y23YBC3/eVU
/jrv4RWNVfDKtHMyz/Mja92tG471Ce0Kop3zbrM0L2wsJpxjMPU57yfqQkFWWqab
yKXWJCZK3YooPrvYZzzlhxoudbsOLSCLzLGxQ9BNtf7DpNHxqXdXNLGLk7/NN/qN
EN6uQCxObp83J+Jv83g4M/U2HAA5SecPwYNjwXc+yZDs/FadUcwL3knjofTUYVC5
vQfjh+uQVDag68bLEfDlHlDOJyOmGWQDFs4ffNmlqrxebVF89JGL2mElwcFdSyaE
vsVH0PuC
=qkOV
-----END PGP SIGNATURE-----

--xHkvda6gtALRD/cs--
