Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9552FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 19:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D77A848C2;
	Wed, 29 Apr 2026 21:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UV9QdTWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89DB9848C6; Wed, 29 Apr 2026 21:48:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA8A848BE
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 21:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7142260180;
 Wed, 29 Apr 2026 19:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6C7C19425;
 Wed, 29 Apr 2026 19:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777492125;
 bh=fOlO+fUUARKa5FEUPtrIN/KRKJt8xlpYE8/LpriAs7I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UV9QdTWM1FpOCRdSzlCb84DGUf7ivGEvf16ZE+z0enkEllhQM6A/WmZMrd5bCfgK0
 NDUIbAmsz6KrcrEpxVnBIlXSdHg36BE8u5URLeqjaZ0QcSSGB+eCl4nJ5P31z6khmh
 aXRMBpzMYLxQU4vjkGPQyCAOzSGdRfDu/e/hUakzJd79xPzhxRYiKbtGNMTve79FQn
 2+G+mU8TjCPaa/l/1Up/Itlu1pCzfIX+au9CnWQvhYHiP/ML1IOveXshTptbagfLF5
 Ihgqxp3rqlKnmVoRRr1AoSYaB+otobIXv7gl5apzbKNkKjQOGu+p6j1dM5x1/R++TS
 JCpmwlCuvSrPA==
Date: Wed, 29 Apr 2026 20:48:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, samuel@sholland.org
Subject: Re: [PATCH 04/16] dts: k1: import pinctrl dts file from upstream
 folder
Message-ID: <20260429-glare-anybody-16c98d01184e@spud>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
 <20260422143112.1329478-5-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NpQx7j3QKVruBJvP"
Content-Disposition: inline
In-Reply-To: <20260422143112.1329478-5-raymondmaoca@gmail.com>
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


--NpQx7j3QKVruBJvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 10:31:00AM -0400, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
>=20
> Import k1-pinctrl.dtsi from upstream folder.

Why doesn't the platform just use the upstream dts directly?

--NpQx7j3QKVruBJvP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafJglwAKCRB4tDGHoIJi
0vAxAP9iPeFclFur1u+yBVfQU/NACBtsJhdA/7WKqMKcRFJr6QEAzBxUTK0ikO9w
k3K9SP55jC7DpuPRp28HqPcspzBroQw=
=7aZw
-----END PGP SIGNATURE-----

--NpQx7j3QKVruBJvP--
