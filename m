Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756B5C52D72
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00E786BE9;
	Thu, 17 Aug 2023 21:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NkBf4BKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3FB586BE8; Thu, 17 Aug 2023 21:02:37 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2705886BF1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58c68c79befso1532707b3.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692298954; x=1692903754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5L4hzVZkrtGe+vMYVKcs0pOCN8GJ6eWR/O2IlrHY648=;
 b=NkBf4BKV/N85xWEx8d0yGEUhKrLyhUe7PUuj4nuFBK+JWMgOes/Ox6hZ6YFsjuBb8N
 W0LlwpRQ+AljqTPDLjCImKFBZxcMxpXpxe/ebbI03iT2QqWpslDa3LqFM/OU54YrckQh
 p20/F1tT+46+1l0mnzrxedcIreV0HuBg56RMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692298954; x=1692903754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5L4hzVZkrtGe+vMYVKcs0pOCN8GJ6eWR/O2IlrHY648=;
 b=VPWnBg4WoJsmROasjF9f6jvnb0XPgX29D/p2IBwilUzIehOzZLBBSEv0/ulGptW1MX
 Sm4Hr6tq19wEgvO+7TF21Qb2l/l4l5EQVZJeOViwi8kGL4Ucbu+jQFPDOTR+4YbbhUvS
 ki3S5jRniW9GPi+VEWNNB/tvGWVoROYIn3IHfi0pplHYvHhJdrpHAWTJ0jHVOd6EE6oe
 LHAmMCaU3Nhbr04QKvEPMlRY00bXMNvsLPtxshsxZYhma5Nj35w7NwaB5xcvivQtbd7H
 rAlj4JVmagX/2RTPZFEpAUrzw3tRZFT3K3GGWKWmFnNKDRjvZ/2X2ILBqLpqBzrF6vR5
 ijDQ==
X-Gm-Message-State: AOJu0YyyD1hocXN/qnHLCxFBAm1CRpfDNWGncxa4q1lb4ZmcFeqmNHvj
 ogFf1hESQOfAogd97ixjGFgUOA==
X-Google-Smtp-Source: AGHT+IGVWIZ5Fw2OokEDYfoA8S2Oys+9ZYUrRxZua+hAJFadj6hKbvvG2X+AYrS7wYbPat8uDmW9Hg==
X-Received: by 2002:a81:83cb:0:b0:589:f4ec:4d51 with SMTP id
 t194-20020a8183cb000000b00589f4ec4d51mr292932ywf.3.1692298953823; 
 Thu, 17 Aug 2023 12:02:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 w193-20020a8149ca000000b00585e2c112fdsm45517ywa.111.2023.08.17.12.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:02:33 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:02:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, bhupesh.sharma@linaro.org,
 marek.vasut@mailbox.org, nm@ti.com, vigneshr@ti.com,
 u-kumar1@ti.com, sjg@chromium.org
Subject: Re: [PATCH] MAINTAINERS: Update UFS maintainer
Message-ID: <20230817190231.GS1515023@bill-the-cat>
References: <20230817120914.144240-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L1X329wNaDNF283K"
Content-Disposition: inline
In-Reply-To: <20230817120914.144240-1-n-francis@ti.com>
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


--L1X329wNaDNF283K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 05:39:14PM +0530, Neha Malcom Francis wrote:

> Dropping Faiz Abbas from the UFS maintainer list as his e-mail ID is no
> longer valid.
>=20
> Adding Bhupesh Sharma who has been using this framework working on
> Qualcomm Snapdragon SoCs as well as sending out fixes.
>=20
> Adding myself as well to support in reviewing and testing patches.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--L1X329wNaDNF283K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTebscACgkQFHw5/5Y0
tyyLoAwAhx44Q52Zj6R5/eXGFSf2CAU1J8vmqjbgNqYJTZkibS44yhm2rYN8PMt6
wMfi6gyYGWezJbhAabpAG/wjYlVRJWT80nCY+3pZYdpg3yGoI4isQGVFsttzCnxh
xk5QcO1BzZ+lr6I4PNTnu5iqwi8H/iG3XmYRor1buFQ5mcpOUxtGV7ZsC/YxLJpl
khr+eFs7tkSXrkrMuGRB6zlcTlgldP/OTSiyMiyoxTObL/BWI1sEWGC0gYcqgZyZ
mTpNSFwpJ+qCAogf7KWA+Zx8NElkEr0qfO/ZbNQbJAaBFJ+wrWnFLJNum4TY5R3o
kEQgkEBhHFGliHKujCVz7Pi3SA/47eBVyLalPclugOWZZuSNyXvSq3IuXB4lR8so
zo4d9vPFZeDmJ9INK+DPyGaNqOIZyctXS7ERhXASr3/jaWdEHLZtJntkYVNWgxAB
8syV+PWi+pfoTvG5xQkfjRzW2tq5ZhrO/82nMHcvAf6hvEGOcHwi8QIsplWIWL93
7mXSeTvE
=5s/4
-----END PGP SIGNATURE-----

--L1X329wNaDNF283K--
