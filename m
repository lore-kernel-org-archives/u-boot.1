Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613F5CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 18:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E53838BF;
	Mon, 27 Oct 2025 19:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E9Ymjpuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B434B838F8; Mon, 27 Oct 2025 19:50:39 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915F180422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 19:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-443ac11a7b7so1151374b6e.0
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761591036; x=1762195836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TKbWsf/uRnBkppZ8prk/K0akfZT15D/kVvzvTlVFVsQ=;
 b=E9YmjpuqJK+Oxp11CeQIuWO4+b33uhmW25TtRW4gaG9c1tVkx4svDHivoVnpq2aThh
 xB+Qq2ZM5TjHGBSnGT/gQBjb7gasa6CgSz9qThY7s/jI+QUjbtJ/BsA9BqmRY4150FWM
 lG0muJNH3oIUmfA+I2/HdclNQ2/mdDmiX0dtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761591036; x=1762195836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKbWsf/uRnBkppZ8prk/K0akfZT15D/kVvzvTlVFVsQ=;
 b=xUQ3ZdLBeRCFnFs2qxU1s8oCsvtoY3Id3pOWl1F2KOZHzFRp6K/+9kNFX/NQI5ObJl
 CoiZxc615jtBn52KY7o8gvT/zbT0kAJciHCZfqDD7UVa0VkJX8q3Nui8z+Q4ceTvCGCs
 CU7HcA0P+0+zkFSLiBIFckl7SzK/PqHKMzj7DtF2WW74c6EXfBMYfAu73WgxPhkOBeJo
 8MSSr9p7MmmIEUG9V8uQxFvS1bj3mm2LtsdLYWHO1Cj0ZHyN4x5Lh2DGu5NWGlxENTK0
 u5m9ssub7qD9yCxtJHmKIeakStvG5fkl/5GFFQevK1yQ4p1HV7Ml0PlwPV4NfY1C0cUL
 50Kw==
X-Gm-Message-State: AOJu0YyQj2wbd1XJF0F4DPHbB6DIOlqzjYMShrg7ysrWHpS3pRa+6SA8
 zUHJ0knAm5eNPeSLXv+p8X2dexLrpuemkncJlL47F/wmyQrvOi56ElTPREICnp6LWrbsWbkRFJh
 K8YM0EA67YA==
X-Gm-Gg: ASbGncuIQy5XFGgi/IV67GvAyAOpXu47pFHAWdhv1CVLTzxuopvIwfgW6RLIzw6Pv2H
 ftshIlbtKI2jpGHLrHyjFgx3ZFfo/NjdMIRaVnvOXSAAUG7yAgxqVfqspxGG19nkzzhPxwfZus1
 LtCh7QncNMqDXWR8St/CUquiz8cOq+zY2G3u9nzkajOiJuKxZo/vXXOeREM0KwOsiDtWMN3Felr
 hAU/qsqAH2+VgJV4iYQGuPA5HDbgd0eG5lRx/u1R9eSkjoTg9C5wul0gNYSwL24xlBvfySWk9wB
 /3ASYsxXleaFtr5xcy8SW8C7nnmn23zVj8mUSg+04FnCrNcp++C0MHm8WdfJn9XQCDPMUvdrb3e
 WBKJawhfHRrycR7iaDyP08ueuvk4uYLEd5qppaa3mMzEDY2oUU4KBK34iCeYQA/AlsBVVwf3x6g
 takv40vLR2W2XQVksr+Rmn2N6KY4qdmRFYiY+ABi0=
X-Google-Smtp-Source: AGHT+IEV6HA7wT6rmtPnHOz/dNpLFcQL4bPquHiHbkcJaT0diHxj6eZHd+aj7CGzV8VVj2Pq7zxS7g==
X-Received: by 2002:a05:6808:870e:b0:443:a224:8f98 with SMTP id
 5614622812f47-44f6bb746edmr337696b6e.61.1761591036279; 
 Mon, 27 Oct 2025 11:50:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef285e6bsm2029126eaf.6.2025.10.27.11.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 11:50:35 -0700 (PDT)
Date: Mon, 27 Oct 2025 12:50:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mario Six <mario.six@gdsys.cc>, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 0/7] Implement the Generic System Interconnect
 Subsystem for U-Boot
Message-ID: <20251027185032.GA531948@bill-the-cat>
References: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
 <ef48b1b9-9aca-41cb-bd8f-1e972fe60561@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GJxC/B9ZXv8AgTKR"
Content-Disposition: inline
In-Reply-To: <ef48b1b9-9aca-41cb-bd8f-1e972fe60561@linaro.org>
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


--GJxC/B9ZXv8AgTKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 01:51:36PM +0100, Neil Armstrong wrote:
> Hi,
>=20
> On 10/10/25 16:35, Neil Armstrong wrote:
> > Let's introduce the Generic System Interconnect subsystem based on
> > the counterpart Linux framework which is used to vote for bandwidth
> > across multiple SoC busses.
> >=20
> > Documentation for the Linux Generic System Interconnect Subsystem can
> > be found at [1].
> >=20
> > Each bus endpoints are materialised as "nodes" which are linked togethe=
r,
> > and the DT will specify a pair of nodes to enable and set a bandwidth
> > on the route between those endpoints.
> >=20
> > The hardware resources that provide those nodes and provides the way
> > to vote for the bandwidth are called "providers".
> >=20
> > The Interconnect uclass code is heavily based on the Linux one, with
> > some small differences:
> > - nodes are allocated as udevices instead of Linux idr_alloc()
> > - tag management is minimal, only normal xlate is supported
> > - getting nodes states at probe is not implemented
> > - providers are probed on demand while the nodes links are traversed
> > - nodes are populated on bind
> > - id management is simplified, static IDs and dynamics IDs can be used
> > - identical consume API as Linux, only implementation differs
> >=20
> > DM Testsuite is provided, testing all the API and nodes lifetime.
>=20
> Is there any comments on this patchset ? or at least the DM emums and
> the general code organization ?

Seems fine to me.

--=20
Tom

--GJxC/B9ZXv8AgTKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP++8QAKCRAr4qD1Cr/k
ChlnAQDRjqPLE/9Czv7UlLllMEna/4BdmFX1PguzaA8ADwXLnwD+K4M/mlO0dJHp
u15u2Ow9ASPwoB+xyIJ1wtVVuSalCwE=
=WIUR
-----END PGP SIGNATURE-----

--GJxC/B9ZXv8AgTKR--
