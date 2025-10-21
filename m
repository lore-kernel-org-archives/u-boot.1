Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69887CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 16:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC5C802C1;
	Tue, 21 Oct 2025 18:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l3RD7emd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A6D5807C0; Tue, 21 Oct 2025 18:14:35 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A541380107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 18:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 153B941AAF;
 Tue, 21 Oct 2025 16:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B944C4CEF1;
 Tue, 21 Oct 2025 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761063270;
 bh=ppQCc13WBtOoq4D1KOmocnbRb4eH9pPtRyMGRlY+2NQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l3RD7emdNeqHO0b2NLbdSz4WpRBcN60mJLTnyrMMx0gCu50qJmesMSzzTZUCEwGQq
 uMawVyxkA6gyFo6fP/3m2YK4vxQL+KJT7AzjsmV9Nm03tLMi/x4XWLzinzdhB5jVNu
 QR6pqarBuhjPsue3SOTpfrK3Nw/wdHwRCLOCu0CYtN/Jh6POqF9/0a6CfabkG/9zNI
 oRl0H/QyLmPMubK1T1dMZKsftgJoFWQQVKjZDo2Np/wD2nOBql/ZuidmzBp6366C+b
 NpMWV90iQsVJeoka4SdUZRNzR/1dcBJNhj6bK2NpkLiwj84VNHJlpyKkUzatpFlAZA
 T0yIkgqfcWmuw==
Date: Tue, 21 Oct 2025 17:14:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Heiko Schocher <hs@nabladev.com>, Jim Liu <JJLIU0@nuvoton.com>,
 Stanley Chu <yschu@nuvoton.com>
Subject: Re: [PATCH 3/6] clk: microchip: mpfs: Fix error detection
Message-ID: <20251021-varsity-geologic-5717ede58560@spud>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
 <20251021-clk_funcs-v1-3-acf51a40eea7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5yS9OK3BEYUoMCk1"
Content-Disposition: inline
In-Reply-To: <20251021-clk_funcs-v1-3-acf51a40eea7@linaro.org>
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


--5yS9OK3BEYUoMCk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 05:08:27PM +0100, Andrew Goodbody wrote:
> clk_register() will return standard error codes so the use of ERR_PTR()
> is incorrect. Furthermore the code was ineffective as it lacked a return
> statement that would have actually made use of the result. Add the
> return statement and remove the use of ERR_PTR to correct this.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/clk/microchip/mpfs_clk_cfg.c    | 2 +-
>  drivers/clk/microchip/mpfs_clk_msspll.c | 2 +-
>  drivers/clk/microchip/mpfs_clk_periph.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5yS9OK3BEYUoMCk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPexXgAKCRB4tDGHoIJi
0gRJAQCqkWbTggzLftPBDoi1njSo3tKX0Ib02jrVgWTBKrn8xwD9FOmQdB04dbK5
FAdG47o/UJaP36bgjOOGM66CqK1bLQc=
=SF0T
-----END PGP SIGNATURE-----

--5yS9OK3BEYUoMCk1--
