Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E9ACD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 16:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112A584898;
	Fri, 22 May 2026 18:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RvX33chJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEDD48489D; Fri, 22 May 2026 18:43:50 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410A8846F1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 18:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-69498319ee7so3892988eaf.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779468227; x=1780073027; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C/IQnsXGlciqgTMkkC59/LB6/zQmIjNZ1caEBUF0/3c=;
 b=RvX33chJ3/rkVWJaCJlJbByxS8sH/9/9xlbAhDFzVSWJA6jHcVuMkRRuERtGOdlEuU
 8pK/6Lq2hUrzJF1PyoDh3BIQdC5iRsT5bXgYZEr/vc17BOFpUTWra3V7ghXHNoli0v1M
 FLI7XXXkvWPtUZ4mfqBEI0YnD1VWAQFfWCjOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779468227; x=1780073027;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/IQnsXGlciqgTMkkC59/LB6/zQmIjNZ1caEBUF0/3c=;
 b=mD9UaLoNe2YIGUTLoT4MiEZ7v6Qarxy+leYwhHbDzFZnGz3PQeihLOiNGl2iWZKZUl
 Xv8c2mQ+Ti87R6SSg29euevdRlMRviLCc+ecc7jmZn8RoJgx6tdnZ+zRkwt1v2KmKMik
 HuLBD7/mnfra7pEHRNUwJndnCojk8UDLpi5fNxv++fW+R4uPIfa6Bc2ayELac2tBtF8u
 4qPxxWpr/Kg0cnXEwJtJGxVLpWqPn8eDHW5blQZs2rL0z5OQ3H0htc4jyg3G6thSYPwX
 7p2gbdtKzuovHTuHAxTr3+3RL4mbzVsRK8LY2+uY2MAe1GdzbTiUdYleHh3BvjWBi9Ex
 SsiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EEGfTU4gCadWLy4xYx9+n/KxcGMCL8/wJk64X2LUuGd7m0o1PhwcJ9LOurAuQJvWpH5mpurY=@lists.denx.de
X-Gm-Message-State: AOJu0YxHXRyw0Lj1s37c+pnUda02hLTtm0oDCmKoNgaXjDTGTo7aU/zN
 j/H8Vh4m63rOU/DL1K5VkIQtYxpe+rp1Kv7krm0TdmDTSdH5rk1jfQIfyn/GPZr7Gyk=
X-Gm-Gg: Acq92OGEB1qp7lTxFYQdWNgxOrT4ab9B1qFHYnZeMuCL+L+7Zy2NBOU/J4WGZdq43gw
 uCrKT/+VFkG7sMw1cT/xxCBc7gXTfJrSC+/x0muqeC2NARc5pWstV9KlfCRG3YrbtIHUPY8FAh4
 RFGjl5DBxoQgfMFRK1yXxoqzzidtq+BQbb6er1p9iX9ChJ70UZh50BeadvopZR0VOYmJjRB38qU
 OH6yHBCckqG+H2mP7Uu7FP+zh3YzhLrqktBbklsvFtpcmTKulHh8xWGOtQvG3Z3L3zoa1F0vnRV
 L+zCTqqtVLJF+U/svecW3nhv4J6sGyncB3XsK1RJKM0Ij7zk13hvSanboPe3h6sDLw1iO8nxNz3
 FbfNCtvdnF2RBlyeqlIcyNIvbEPIajWYpnambWs2p7VX3dlSDIKcLodIpvuXp16Gr70a+HbtJR2
 TYLW5FEPlfrrSrqnWgmofZ8GgYhkaPqZSNsro7/rWC5eFRKHUHP1T11tLinDLrNy/z77/Cgf3BD
 d1xkohQlZ4DgIh+QKeiPit79amRyIYhGLerYrERFZs1vOussW2J9iDc
X-Received: by 2002:a05:6820:4809:b0:696:2ae9:8b0c with SMTP id
 006d021491bc7-69d6e3d9046mr2600768eaf.41.1779468226893; 
 Fri, 22 May 2026 09:43:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63976202sm1884835fac.12.2026.05.22.09.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:43:46 -0700 (PDT)
Date: Fri, 22 May 2026 10:43:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>,
 Paul Kocialkowski <contact@paulk.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v2 0/5] arm: aspeed: add initial AST2700 SoC support
Message-ID: <20260522164343.GT1858239@bill-the-cat>
References: <20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CA/budNAHTZRhpUZ"
Content-Disposition: inline
In-Reply-To: <20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com>
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


--CA/budNAHTZRhpUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 04:24:47PM +0800, Ryan Chen wrote:

> AST2700 is the 8th generation of Integrated Remote Management
> Processor introduced by ASPEED Technology Inc. It is a Board
> Management Controller (BMC) SoC family with a dual-die architecture:
> SoC0 ("CPU" die with four ARM Cortex-A35 application cores) and
> SoC1 ("IO" die with peripherals) each SoC have its own SCU PLLs, clock
> dividers and reset domains.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v2:
>   * v1 only have clk driver, v2 apply full AST2700 platform and
>     reset, clk, ram driver.
>   * Move scu_ast2700.h from the clk patch into the mach-aspeed
>     patch so the SoC header is provided alongside the SoC code
>     that consumes it.
>   * Link to v1: https://lore.kernel.org/r/20260508-ast2700_clk-v1-1-2797a=
626a238@aspeedtech.com

Somewhere in this series, a MAINTAINERS entry should be updated with:
N: ast2700
As well, thanks!

--=20
Tom

--CA/budNAHTZRhpUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahCHvwAKCRAr4qD1Cr/k
CkMqAP9Gis9KAWsNJOyErBcRi8aIaWJpqYHDHGCebg81rlZXAQEAyasNP3t/zMGP
8GgjvnSrlnjwYMnyYj3jZNqzlJc6Hwk=
=Mx6k
-----END PGP SIGNATURE-----

--CA/budNAHTZRhpUZ--
