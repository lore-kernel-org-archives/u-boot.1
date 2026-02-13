Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E661CEEA860
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A05683AA9;
	Fri, 13 Feb 2026 18:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LhvvLdSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D9083AAB; Fri, 13 Feb 2026 18:17:48 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEEA083015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c68f0e47so427219a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771003065; x=1771607865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JooiIFqTZE3TGXEE2qhoEah78ltLqBtgxFxp/vHiyEc=;
 b=LhvvLdSNnt8Ff23F2d5uCE00/9da9HBnrug08e0HsOJjQUaSoGivz9ruCXpVE5iJQF
 PQP9b0hvyAlRRy7/ohbv8aX3J8g+P68G6uxYqZpWyuGyJ2XU8uTVMR3adtk/1LyHzgqB
 kdtH3IT/r/MfiRP4RiqUehBidcFPDReProwjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771003065; x=1771607865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JooiIFqTZE3TGXEE2qhoEah78ltLqBtgxFxp/vHiyEc=;
 b=KfJBS/1vESF5swsGQugexolpFxiDw7zF9lK1Wc2NeQPA2s7t7508IEhuazz/TkYn46
 LFXaDMc7y3uT92IJvjY0pr91ij98+oVPQ8ODJGZ6/+8tiFolWk5QuiMM4k//nveS8A4d
 fUDTvjMoU+lb6oAL8sHbxAvXE3WBCe4S7/3s2rN/Vu+CyE3e2IZzODmDY7kxgblbx8X8
 5wQSzDVTYEBNXbT8E7KioM+0BCnA/4u9ME9qQbBx32yRfxugsrG8UNEMkZWb1ZlaS12M
 c1SIdXtqmIya/EP+pEb0hDK5noyeRmUoHtE42SG0sMsLGWlxV+bjEGwe0O+rDm1ViEPE
 gOGA==
X-Gm-Message-State: AOJu0YzXpaTY872cSaZ6iGfR0Yf3By+qLwyapJ0+B3cgt0lJWWNyaxGV
 bsUk/v8nXEmN6+OmBBIR/GF8YKBKt6g4QkS0xvj9lCL3u63TH74yAsLBfkpFTxF8PWA=
X-Gm-Gg: AZuq6aIVQgDyRsOXLLHlDJF0hkuJdrcFm+MF/xHIFoYoS623wB7awHRj+YWmKH62Qy9
 02VQJn9A7mFaicBrXC/pzgkKYXrSQ7kprw9uHww28y6tanyfc4Mm8EcMl6jK+vE+sOnLuhXrmp1
 qCzS1ImpgX4uvpL6tgBwIt4jMsF0P8PLYdSxxbF9ZKOSx6nyLn9KCdomiZfU12w+mLSxJHMGe0u
 YNoPlUb9JHlK5niBnPdsgXH4hnGN1IPpxcMStwPI9lTsaXQKFEO/bhWjQgMrq291XIc75b9/gkf
 LXsh03gxPLI3bF2mofNJAz0BdPzV9SoooEdP85remxe/nsvfLnBCOddasPJdMcFo1b0qtLcZJ/e
 vo8kguMdACuVxaFKC7VxxKTGM39pmo/DXgdHJ/Sfuqn2YDr4jpVFDWN5wbf/j8/nv13/xZ3Zqun
 gkztTrL85ttU65xd7Hl0sWS4SzbGHQSqIAGhzx/GxYy02Iqb9MX4wPRPIS1ixl2q+tYgnplvwLu
 BeLNy6+BXWxiXo2/3aeDBBvTp28dLITjVlXNoAqfgtnqDpFNo8=
X-Received: by 2002:a05:6830:4487:b0:7d1:90d6:403 with SMTP id
 46e09a7af769-7d4d0b0d6acmr24683a34.16.1771003065387; 
 Fri, 13 Feb 2026 09:17:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm6391695a34.14.2026.02.13.09.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:17:44 -0800 (PST)
Date: Fri, 13 Feb 2026 11:17:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/2] mtd: spi: simplify the conditional compilation of
 quad_enable feature
Message-ID: <20260213171742.GA2393069@bill-the-cat>
References: <OS7PR01MB13834542EA65B2EEC830EE37CBCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
 <OS7PR01MB13834E7A59ADC3EE1E21C41B4BCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qj+lPZVm0aLzBFnT"
Content-Disposition: inline
In-Reply-To: <OS7PR01MB13834E7A59ADC3EE1E21C41B4BCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
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


--Qj+lPZVm0aLzBFnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 08:32:32PM +0800, Shiji Yang wrote:

> Introduce new SNOR_SR1_BIT6_QUAD_ENABLE and SNOR_SR2_BIT1_QUAD_ENABLE
> macro definitions to guard the quad_enable codes. This can make the
> review easier. It's also a preparation for introducing the new Flash
> vendor BoyaMicro.
>=20
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Qj+lPZVm0aLzBFnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY9cswAKCRAr4qD1Cr/k
CswNAQCWqKgXTVNq4S+WzNt0PDyZUljY8VxrOq0SLPzIDTss3gD9EkyJwEspff/L
YRr4kS/hsbhe3j5Sdc38AFh/8AsWdQI=
=FC2+
-----END PGP SIGNATURE-----

--Qj+lPZVm0aLzBFnT--
