Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB5FC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE3D8283E;
	Tue, 29 Apr 2025 15:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AJe3ajS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9FF8288D; Tue, 29 Apr 2025 15:48:53 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E92978272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2cc57330163so3992357fac.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745934530; x=1746539330; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hUyhCcQPn1TsPFBGEcYOfenc5xVH77tX/5nol93CPP4=;
 b=AJe3ajS7AMlym4BKXqo+WDqjOnT5oHyiUiZkCfdZNtOElmqZesHX2MsAGvrNJZ2VMQ
 QFMQXxpj0nKS51WpBHS3IOUBCma3Vwt5jtS8FinGVLp6cGj/EUWIeBppDovN8dAxezsy
 KdVvqGpWSIBV0REeTgv32WvRK30vSg2mZxQRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745934530; x=1746539330;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUyhCcQPn1TsPFBGEcYOfenc5xVH77tX/5nol93CPP4=;
 b=vhVAdcemSlXtiCmi8ZG/u3jlEDM+ECjLlAOf/Je3PKoNZehZqmPxI5hTSWdUudVCpm
 LLhCMTuceHEzh/lT6CKARmMC17wNvBtFwgqRcpkO1uLfRef+wXMMqAfy29u1LD2nhWn3
 rCVzz8ASQ1jFGdIupoHileywc82xzmfz5ssRttn/O1wu3Q9L8VymlFTEMIQpn5Mhj3HN
 E3tSGd0ehrwn7JpqyxkEoVxn4FN355cDUfxtpmhAP+Ah+nSJoyQ2G65BIs2C5zW+8bOZ
 XIX82ZLhQ8myoAcPehipVKKa+DKmn+7VkREcHWfCcflTalRij3Kyyi1NAMjQ8N+oM+mv
 hcPA==
X-Gm-Message-State: AOJu0Yy2oPJHiSWPiXqBkwrHDczOavPe2oNlXwULbBX4jUcYfSGh/IXq
 bP/68URL2LkbYtJGZXcXo/4fhFjuwMvuNnX/gP9Z+WXJkIfmwV9dHCH6/P6jLEE=
X-Gm-Gg: ASbGnctbBprbuIm0YxIRq9vLdJjQ5PA8h3LRbHNAFoLJlRSRS2L99hQU4uEgGPU7S4Z
 mLKBtmoO3Pg1HQfYOeOhRMIHrPbK+ywJMD+rYBGpMBEx1NR4rcMXyhS0bVoLtsdJzAzndwmpv61
 5nLL3Xr6TqeNSi7GBiqsUswIXY0AatmW6Lavfq2rSefpkCkHK7XY5raZzl1HwVDE4g5X00TsX2C
 5ZAlevAg1mGjm/R1ka3VjMP5owkvt7dOoPQTRBXmKInUu+zNaMG0xBdzxILU+3BcG9FP2bLkDtN
 iiO3N002BkX6wZhO4cNDpn/MUbsVKODEAgcQdoDjT6IDU2Eo+wGpb/tdBUAfuu9mPPCIqGuDclL
 JYg==
X-Google-Smtp-Source: AGHT+IFZBy3rgEJAzygTOjbakslVbdkMKRpThwWzoiOunzvlbTJVwevg7dfjApK76mrQUOs/PFklzA==
X-Received: by 2002:a05:6870:380d:b0:2d5:4b92:a2fc with SMTP id
 586e51a60fabf-2da4842e5e2mr1601028fac.3.1745934529681; 
 Tue, 29 Apr 2025 06:48:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973c1bc28sm2697003fac.44.2025.04.29.06.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:48:48 -0700 (PDT)
Date: Tue, 29 Apr 2025 07:48:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 00/30] patman: Move to asyncio and other updates
Message-ID: <20250429134846.GA1261075@bill-the-cat>
References: <20250429132239.251756-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JCLFMA2KC/MciHvE"
Content-Disposition: inline
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
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


--JCLFMA2KC/MciHvE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 07:21:57AM -0600, Simon Glass wrote:

> This series moves patman to use asyncio instead of ThreadPoolExecutor
> since it makes it easier to handle requests sent from different parts
> of the code.
>=20
> It also includes some updates to bring patman in line with the other
> major Python tools (buildman and binman).
>=20
> With this series, we have a better basis to add support for syncing more
> data from a patchwork server.
>=20
> After this, the next step it to add a new 'patman series' subcommand, to
> track and manage series workflow.

This conflicts with master, please rebase this if you intend for it to
be merged to mainline. And to avoid confusion, while I think managing
these python projects in this manner (and not AFAICT following python
best practices) makes life harder for everyone else, that is not me
NAK'ing taking more patches, I continue to be compromising and "Saying
Yes" to things you do that I disagree with on non-arbitrary technical
grounds.

--=20
Tom

--JCLFMA2KC/MciHvE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQ2LoACgkQFHw5/5Y0
tyxlwgwApKdI3Qayy3EiXZi2/O3fWMlhTtg4MiUH8XuuM/1Yj18WLZypFJ4cizd/
iPUByaF2zZUTE3sn8SzGYnvZuam6QBpS++h46syToT5unc24dpl8gCK9ibvgjA+j
qOEimCVEboqQpPNZinu9QfSL+DaJAyVxrh1IBqZlpEM2EAaNQnaQgr01Ap5sWHyj
9Z9rXzCYlFS/B5+GMT3ZVMVmqeBXAgntrIwq7Bt6lyQBikr/4ZEdBL6mGIr9bqrB
AelB/cSbWc6SPUn7l70kUVKhV8rF93yOlRDHkF0wqLhx5ZDmCU5Zle45SgTEFovg
j5Xd2K0wu1/ewI2SOTk/kPOaqcY6avlrw7GCR7SFn8gt/BMljgY/5ksGLb4gZmin
db2+qtwe/xm620may5pzQVQrsvrngmlbHisKTNS/EGzPJ1XnB63GGW0sj4AWvZuE
8ZD8MDp+iDJd4meH0uMArbWIkr+sk3yUSEg2bA880v3jAtXJWRvZetHuFYXRz4uh
lZbErG6V
=qXMF
-----END PGP SIGNATURE-----

--JCLFMA2KC/MciHvE--
