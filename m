Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A94EEDF17E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C86EC83AA9;
	Fri, 13 Feb 2026 18:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J/c0EZfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8AD83CB5; Fri, 13 Feb 2026 18:18:44 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B557383015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4042fe53946so404035fac.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771003121; x=1771607921; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RGRt3x2RBR+w4k+WbWrMMIGlxf0ZtMsiSO9tA+YB6ZM=;
 b=J/c0EZfP5K8IOKVLpGJu3RrWW6JqQrIEpybgZrTTbjl3+lDqX4YP5ni7vaEjhCG8JQ
 MC92FwxsrSxM0gk96leeU1clWrrQkbJoztloOregBMf0EKHWsvYcE6lNS4oCZd8e70W7
 B17WtkfdJfoGAk0BiJ7zgrSUf0AhUHLzFXkPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771003121; x=1771607921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGRt3x2RBR+w4k+WbWrMMIGlxf0ZtMsiSO9tA+YB6ZM=;
 b=dvrOyKIM41hq/dL9yRxNWTIWVNz/J7H2cLYPXW5vW6b63w0dZa8z7WPWO/KE0SaFvn
 1sJItQVZpWpPfs7tw8Oogs1OdCBxneBhGwgLYTX73rKEuzoZqnUBFb0Go+8FIioHlVFl
 N0rR8BLEm3zxTsLIPUnBUBxzTVf2qrJHSBobbb0oBMYuYn3nVibNQdk32nzlR1cvs2Ep
 rW/8X9aIKBz+DcaflhfrpwF+iJ9aNkTMfWwPUUbGNsNfyMJcKwPGQEYE+lRUz7AMNcKx
 tRFVm1HFx+seZsF7ZFp+Ml9fvZXTDPZUDutJlovQ1VQAczoNY5eTqFSUfQp3RQoH5OtJ
 04lA==
X-Gm-Message-State: AOJu0YzpFysvPngp/Iu+GPG70b/qsoimYcqq/PFWdZesE8a0OP2/xyuQ
 6orBQVUGYebsUPnTK5OnHSRIIxXcO53FaKYXzqruLvBcBPuNjg1x4NUHLnXQIeOXUzc=
X-Gm-Gg: AZuq6aKDJLzOgW7Syw2iVkLrrm7WDUcrA6o+oVVcTKrfQLzDnjuFyKRBAfZ2GlTsANt
 cS/Ve/QV6Dbs1D0iBYNkmsGOHP0HCdm/bSaMiLEBO/tgS2FWMjH2Mwa3ngPwY6LEGjGxE9ESHYC
 AgBllQXp41zxyKK8fH1EbgLiebG9lUy46lCZNMV/Hm+YbGkK4As4Nw2fNjWWcY1ZSDg0+2nI/Jy
 NYnxM4L8LUdMeVNKkKEDulmpExjx2LamUSpM9jiG+kwbx5OWn3VYE9J/ELP7b7mRQUgDq5vw9KJ
 beWz+DaKiNo6mhoEe8jtvgBPe2idLqAOH4zO50ZTdvSOf2OxX49rE5fMs6EYe0amG1qVNnnogTL
 o5APkwWdffUkmgxo+RmwNOlheqHUY3goU7N6S0g0l0l1qn2Wtl4pLgIxpLyQ/6djobdP4OTIuOk
 couhhPPqOBOmOLWC+NEU7KIairVe0D8kcp1WQYTJvTMyqLos02zldzVXAJViQAkXjw3I302+mDT
 ka4R2TBU6ejE3rJAoQKPB7gdCVTxNPbUHNBgX7aXrRzD+My+qs=
X-Received: by 2002:a05:6870:d1c1:b0:404:1c81:596e with SMTP id
 586e51a60fabf-40f0d577145mr79020fac.12.1771003120692; 
 Fri, 13 Feb 2026 09:18:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm7327898fac.12.2026.02.13.09.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:18:39 -0800 (PST)
Date: Fri, 13 Feb 2026 11:18:37 -0600
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
Subject: Re: [PATCH 2/2] mtd: spi: add support for BoyaMicro BY25Q256FS
Message-ID: <20260213171837.GB2393069@bill-the-cat>
References: <OS7PR01MB13834542EA65B2EEC830EE37CBCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
 <OS7PR01MB13834946A7860DA02B8E59769BCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MCFhpnFjyVtWlFDw"
Content-Disposition: inline
In-Reply-To: <OS7PR01MB13834946A7860DA02B8E59769BCBDA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
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


--MCFhpnFjyVtWlFDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 08:32:33PM +0800, Shiji Yang wrote:

> BY25Q256FS is a 256 Mb SPI NOR Flash chip. This Flash supports the
> SFDP standard. Since SFDP is optional in u-boot, we still describe
> all features it supports in the flash info table. This change has
> been tested on Mediatek MT7981 platform. SFDP dump:

What if we just say that new platforms and new chips need to be done via
SFDP by default? Or is there a good reason to not go that path and that
will close off some use case? Thanks!

--=20
Tom

--MCFhpnFjyVtWlFDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY9c7QAKCRAr4qD1Cr/k
Co3FAQC0XRLvWT4ctQvip2qHIuEbrQxP7oS4J4+4Kk6Z3n2gSQEAsnJwJ5ZoG2CT
Ys3NwKyJlntr9XGzKpQieU9GhT5aWgo=
=IAZX
-----END PGP SIGNATURE-----

--MCFhpnFjyVtWlFDw--
