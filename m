Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DB7C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 13:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C18D786D38;
	Sat,  4 Nov 2023 14:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XtjAwQx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 058AC8703A; Sat,  4 Nov 2023 14:57:28 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642B887060
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 14:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-778940531dbso188325685a.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699106233; x=1699711033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkFWchkEj8YxiSHRiuk3AYf6FZnEypBQIsp0mI4SUKM=;
 b=XtjAwQx5pUMxJE37KE2XOUHxl6mAPCiKsE5QAmVcbJIuvWKioPU9aDgMWRsYMACfBT
 gBLfgFALCKnqiZQiSYNwiWT73xMFWanWPMEC006NYLSe2ZmQRCAoD/hJ9bUAchRyrYXJ
 Rfts84iwMFPqMYyJsVa3C8lplsgn7UQ28De00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699106233; x=1699711033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkFWchkEj8YxiSHRiuk3AYf6FZnEypBQIsp0mI4SUKM=;
 b=WMyZeW7fFSxKSmGKqx2nF+P4W2T33eq2j2VSjTxuznmrpwNZFtf2NFcd9MEAheh/yV
 0v1JQwsX8quBmVn+CLrGmqeUTO+84BCEMQiXAkTdl1FN72F1VVsnXLN+94JWfSz/5nsh
 1oZVmzHOKjvZRaxfpnhrcjI6Buc69xUfb6wcPsySQJX+5xTFiMLoQiPdHlGguncGYF/T
 CX4aEhWB3fKYwjd/qO05mN/7pDyX41U1+rtthSB4mCxE9+lqwg/fyjqhFvdYRRHEsYJ/
 esUaZ+BeS4k7NKCVv+z0XjSSoGDctWKTp8eWXPaxMaX/k8fNlacbaFc2Wq28rOiKRsQ4
 3AmA==
X-Gm-Message-State: AOJu0Yz65lOf2WvqW9Xxh7v1xli3kKu1zUNSPh4iRRhNrvHS4JxobiPc
 0gvLfV3rUv0hi03hv2ljdGTWDZHJXRUY52Y3me2NAQ==
X-Google-Smtp-Source: AGHT+IENwNzsRtuKH8IX8IN1C0I8lU/GAnnmLf+Epshq34nvX1uef7GPa0Dv3H2iga+LJ8MFCswkbg==
X-Received: by 2002:a05:620a:47b0:b0:77a:1cc0:6e41 with SMTP id
 dt48-20020a05620a47b000b0077a1cc06e41mr22188274qkb.33.1699106233076; 
 Sat, 04 Nov 2023 06:57:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 y15-20020a05620a0e0f00b00765ab6d3e81sm1584540qkm.122.2023.11.04.06.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 06:57:12 -0700 (PDT)
Date: Sat, 4 Nov 2023 09:57:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/2] ARM: tegra210: set default-tap and default-trim
 values in sdhci nodes
Message-ID: <20231104135710.GY496310@bill-the-cat>
References: <20231003063352.42660-1-clamor95@gmail.com>
 <20231003063352.42660-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="15s/HObero0BdJ96"
Content-Disposition: inline
In-Reply-To: <20231003063352.42660-2-clamor95@gmail.com>
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


--15s/HObero0BdJ96
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 09:33:51AM +0300, Svyatoslav Ryhel wrote:

> Tegra MMC driver has hardcoded tap and trim values as for now.
> Set default-tap and default-trim values in sdhci nodes to avoid
> regressions in case Tegra MMC driver is upated to use dts values.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--15s/HObero0BdJ96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVGTbYACgkQFHw5/5Y0
tyxgrgv+Jh8IgfvrSmGhyuGGI4nreNCYcdRNle++7xIXx0/ZV4CUlUs2Z8cpKwPj
g874NTvBHlguZpkkrvSSHZ6q/J/XH7bCVjTaX36d+ZbycZQWcVq2Hi+4rQHFbfO4
pJK58spJuE1PDOydB383l/1mlNUgJ/UFT1X5rC5mP6KTC7vE5ZEdyAzVoA3SLfpJ
+5xJ/yLTgWSJFxLxiUlrp+2Ub4jB89+h6GOg/TdntJFV32Ae7yUw2qtzVO/i+eyY
APSFS3YmzIYlv4u+BhXHc7VhJ9DiVyIC6byu9s+A73HQvgXjXQ04qLwE4QNydmi1
3crnMvPb74s7c/ds+tNKfh/84kyqN6TfB31W6QR71xwWY6a6nCsqr83F6w/ak0Jz
q7qB7ByMiC1qzoGUWWEEEiWKQ0xZjltnCRzM7TX2cDpAem+onXh6bRGiNhJl2sIx
qlfcnLqGp/hvT8LJdxH0gSGXIptkb/v8eLxYa7DK2q+kAFJ01UpPIVoq923xer6w
KJj9qong
=QTWJ
-----END PGP SIGNATURE-----

--15s/HObero0BdJ96--
