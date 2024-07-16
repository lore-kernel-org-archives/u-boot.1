Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29324C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 22:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77216889E0;
	Wed, 17 Jul 2024 00:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aODjLcJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F392588440; Tue, 16 Jul 2024 21:09:01 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8241D88706
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 21:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c661e75ff6so81068eaf.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721156937; x=1721761737; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HqUuDjHfeH48QVi0gxfq0lp01BURHFnGi/Bl0YzJ7aY=;
 b=aODjLcJGmtCnONhUM691g+30yBYKiT/5lomXLpIIcBYyhSaY0KrIXyPF0jRepjdhR5
 4KPKlhNnwQshMDpaH+ZFR/14l+m9mnZZvAw0WWfqG3HyvWWoyztko24cBnP+Qfa3Mw4p
 zwFe+iC+PYPVG/NorsIPBciwekiy/MX9lYy1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721156937; x=1721761737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqUuDjHfeH48QVi0gxfq0lp01BURHFnGi/Bl0YzJ7aY=;
 b=otaCi0Xk7d9ZU4N2B85LZnCRhy8p0ACIFGJLvYj6sgohrU6OCZ3PphkknC2clEpFd1
 g4PxwNtmwgMJg/mMntoY2MrpOrgTqdZaGFMIwhHXQaAH7Jz0ON09qs3aWukAC9L8Dm4b
 cTH2cSprwICDqBLOf4xGaBIAbMwJqSz9Gh88Lcja53s6arTHL0IhEIrd/VN39cCdzBko
 YTe66V23O4Yk7DVi1ZUNtu8FYWXesQZI91gkoZWVHPGtE/JWDICrSg68xC/asBl90SVX
 mJuZRhbTv6Uhj41QCvFH07X45iHhWMWIRIuWslcVwcCqz3kR9ecshub9P2vZcR7iwOgG
 ZD9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzWdLclOGMwY1H3wH2+WI1sHSm5rTZ2DfNxpofZHCJMI/DgI+k09zYRAXifxakG5OYxRyvefqkufQrPxbTQ+ZoTNs1yg==
X-Gm-Message-State: AOJu0YzVcmP6mib2IuRrK45aGYlpgmbdtO1svlo2vRitpCnCZAgeL3YC
 nApRxAIBnWSUJKejmxsIbgXub68d3PThBxe/rcRLYHWcCevabdOjaPh9RIUR150=
X-Google-Smtp-Source: AGHT+IE+wPyhbaJzKrHrIO9ik8TlSzqXBxOVBbQxfwiD3dUS9P3rvnH5OyqcscwGii0hziA7AScJ/Q==
X-Received: by 2002:a05:6820:c83:b0:5c4:27f0:ae with SMTP id
 006d021491bc7-5d3cbce073bmr530885eaf.1.1721156937223; 
 Tue, 16 Jul 2024 12:08:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d3c9ec56b8sm38164eaf.10.2024.07.16.12.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 12:08:56 -0700 (PDT)
Date: Tue, 16 Jul 2024 13:08:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, michal.simek@amd.com, seanga2@gmail.com,
 sheng.tan@9elements.com, akashi.tkhro@gmail.com,
 abdellatif.elkhlifi@arm.com, agendin@matrox.com,
 linux.amoon@gmail.com, andre.przywara@arm.com, afd@ti.com,
 artur@conclusive.pl, bmeng.cn@gmail.com, bb@ti.com,
 caleb.connolly@linaro.org, chanho61.park@samsung.com,
 devarsht@ti.com, eajames@linux.ibm.com,
 etienne.carriere@foss.st.com, francis.laniel@amarulasolutions.com,
 ilias.apalodimas@linaro.org, vanbaren@cideas.com,
 mr.bossman075@gmail.com, jonas@kwiboo.se, jpewhacker@gmail.com,
 kever.yang@rock-chips.com, leon@georgemail.eu,
 lukas.funke@weidmueller.com, abbaraju.manojsai@amarulasolutions.com,
 marek.vasut+renesas@mailbox.org, marex@denx.de,
 mkorpershoek@baylibre.com, n-jain1@ti.com, nm@ti.com,
 oleksandr.suvorov@foundries.io, pbrobinson@gmail.com,
 rasmus.villemoes@prevas.dk, raymond.mao@linaro.org,
 semen.protsenko@linaro.org, samuel@sholland.org,
 yangshiji66@outlook.com, sughosh.ganu@linaro.org,
 sumit.garg@linaro.org, sunil@amarulasolutions.com,
 tom@tom-fitzhenry.me.uk, troykiskyboundary@gmail.com
Subject: Re: [PATCH v2 00/21] Universal Payload initial series
Message-ID: <20240716190852.GL561963@bill-the-cat>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <87a5iliubh.fsf@bloch.sibelius.xs4all.nl>
 <09FB197A-06C8-4162-AAB6-3823BA2840B3@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MbQ7wcNsZ6Kczf/Z"
Content-Disposition: inline
In-Reply-To: <09FB197A-06C8-4162-AAB6-3823BA2840B3@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 17 Jul 2024 00:04:11 +0200
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


--MbQ7wcNsZ6Kczf/Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 09:40:17PM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 13. Juli 2024 10:12:50 MESZ schrieb Mark Kettenis <mark.kettenis@xs4al=
l.nl>:
> >> From: Simon Glass <sjg@chromium.org>
> >> Date: Sat, 13 Jul 2024 08:00:34 +0100
> >>=20
> >> Universal Payload (UPL) is an Industry Standard for firmware
> >> components[1].
> >
> >I think you have some trouble understanding the concept of industry
> >standard ;).  I guess you want this to become an industry standard.
> >Firmly https://xkcd.com/927/ territory if you ask me.
> >
> >> UPL is designed to improve interoperability within the
> >> firmware industry, allowing mixing and matching of projects with less
> >> friction and fewer project-specific implementations. UPL is
> >> cross-platform, supporting ARM, x86 and RISC-V initially.
> >>=20
> >> This series provides some initial support for this, targeting 0.9.1 and
> >> sandbox only.
> >>=20
> >> Features still to come include:
> >> - Support for architectures
> >> - FIT validation
> >> - Handoff validation
> >> - Interoperability tests
> >>=20
> >> This series is available at dm/uplb-working and requires the alist
> >> series at dm/alist-working[2]
>=20
> Why is this series needed?

Because UPL is a standard, supported by other projects, which requires
more than Just Nothing Else on top of what we do today. Please do
provide constructive feedback on the changes themselves, but bringing in
UPL support proper is something we should (and will) do. Thanks!

--=20
Tom

--MbQ7wcNsZ6Kczf/Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWxUQACgkQFHw5/5Y0
tyyuDgv7BMQUFlo+Oa50qO8y8xQA0fnFpBbtfYMBAnFtJJM1In9SPl6tNM5JrJjf
L771jgm8PTcBMKKlQpC+XGUAfns7YteN70mkzB5MB5KQwC7v/ygWms8ULJ+ndP+Z
eKDrgOy+5dW6M34gI4ViMm4504/5SUAN09rilxvcDCt4gRBPBeZE+GbIEmya6Pne
p5iUMBeMliAcW2UXoddB9lkt5HSC91ZUybYDa1ALQgBJ4HtLjr2ub8Jhg8/NanYV
ScELQx5AbMjI8QhO52XXf3PaSNF8M9yfJiOhbuQYBlOjx7zk2hABxWAaR3icy7lF
O62yFc9gljeuyiTf+4CUj6MrjkGkA5DPycUlMJvvtkwG9WnHp3DKiVCtco9YfwVs
0etlRfLfgZO+fYw1KsnUBrSCY3k483LFFaW3hRGHLLovmvqAgXMAf19IuJgPYFal
48bxamPwGR0ZYrRNM38Aj6fCdnC+O3ju1FSo65Q3b9CL+QVxFef800QsFaFWKnrc
4cMDp0cW
=Yqan
-----END PGP SIGNATURE-----

--MbQ7wcNsZ6Kczf/Z--
