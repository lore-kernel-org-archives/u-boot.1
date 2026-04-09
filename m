Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F45F364A6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB5A1841FF;
	Thu,  9 Apr 2026 20:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nkBQEC2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA51884099; Thu,  9 Apr 2026 18:33:40 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2757B83CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbd23bc684so628730a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775752417; x=1776357217; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eZilGuxLy59AZRZGfV2Q9ZQK3bmUsdcmJhuA/NRlfK4=;
 b=nkBQEC2WLwvTVT8O7X81oTEpbX3wFCs6g8d94+uH08wVDL8zz5q4rBmg1v8WHOgllQ
 fmWN+CTSpsjHM+bWv1xmQSwKyfuRGzZWDaGXLM5MuH14/Lhjo9CxsQ5r+zR7ibRtJYuJ
 /0w5mfQQlrWbxsB8IRhU2RoDQNFd/Wr1O7LVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775752417; x=1776357217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZilGuxLy59AZRZGfV2Q9ZQK3bmUsdcmJhuA/NRlfK4=;
 b=XEufzSeEGCoXilnUPq+nNCUYU/N3RXA+WV8VyZ56q6+TuOGBFUmW2oYHyUtnnz0d/V
 +KjGnw6HL7+D4U2o0bRId49EgxjLfoIIgPyZ/F7cCJDQbFtAOFiTX/ZkcA1LlyIX8CIT
 wOtUSQOlUj0dzF9vdgd0G7FeW8O8ygQ9eU6yV1KXTI5AIpmtu/5v29hu4Vkn/psum+ea
 WzAeKg4/E7S2E5XzI+90nl8zKn9rvLW6GgNKt46P6X2bUWjdBeSRlRQhJO9+xLoSuosI
 LWkGViwRjNF8gxeLmiGEIJBya2E74Ie2v0W3+oitNoP169fhYdT56xaCEVSCb8r6f1Ce
 ZP5g==
X-Gm-Message-State: AOJu0YxXwc+Axc46FFzR6e18ZjzqtQ7BmRTi89VM5jcZYd9TFo97eyUZ
 on8NAEhO1jYtcTpI299sHxtZBp9RpMpR3wlO4beKkqSZHFl6lG10s0KDhGL81EcPxEc=
X-Gm-Gg: AeBDieu6FFwhyncUlWu0FH5qTsU7+syYPikMuatU6Ou1/kYYhNsDqEmpab831/1tEYY
 5VlrsPW9N2JzJkN/9S1bvbuoDHCkWzVh6rnmRO8gQknE7W5xP43ZzK5PA/ZP7hk9yPZRK4ua6CM
 p892lsUXIyLhifll8A3L1MbY57SQH5b4HA6niHI4ViVLJWVUt+fpmi2mc1EdY4YwTq7iq5eOaQj
 pMO6FC0F0u7QgPKcm+sCTjo++0Tttxvk3wOW/2WW+4httG8Wef2WjXYgUPPJfx//uBp/avxS4/t
 kyVJdO0Qz+k8peeYVmwGyyy+8l3Ie4Wv4XJlfytSN2u996dVmGcS5cZuG8xLOdM2oL+hjqW4WWp
 D/cN73WuK2ErcMPJ5NkzUFNMKhEMWt3JJwWAluuQCmf3Q8AryEo1c68SHOpL7QKbWK2BUaNCIDs
 21hphpUhfb/8HtVI6VWYNk9FnZjxSt/LxJo85R8Z5inP99ycBHBEHFATaXiX+PG5fBn5Shm7NZA
 tUqDNY51d3i/fDrPkgJy27VEaW4xj3NNXZTxM0DqqUFzNkWiXjEYrMaz9v56Q==
X-Received: by 2002:a05:6830:440b:b0:7d7:fb0f:3e56 with SMTP id
 46e09a7af769-7dbb757ae46mr13686207a34.26.1775752416790; 
 Thu, 09 Apr 2026 09:33:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc269d52ffsm164254a34.26.2026.04.09.09.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 09:33:36 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:33:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Jorge Cisneros <jorge.cisneros@hpe.com>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>,
 Casey Connolly <casey.connolly@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tony Dinh <mibodhi@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>
Subject: Re: [PATCH 1/9] arm: hpe: Rename ARCH_GXP to ARCH_HPE and add GSC
 SoC choice
Message-ID: <20260409163332.GO41863@bill-the-cat>
References: <20260408-hpe-gsc-upstream-v1-0-2be1fb7cbbfc@hpe.com>
 <20260408-hpe-gsc-upstream-v1-1-2be1fb7cbbfc@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y+P4YqNGE8WDOPwI"
Content-Disposition: inline
In-Reply-To: <20260408-hpe-gsc-upstream-v1-1-2be1fb7cbbfc@hpe.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:34 +0200
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


--Y+P4YqNGE8WDOPwI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 07:24:13PM +0000, Jorge Cisneros wrote:

> Rename ARCH_GXP to ARCH_HPE to serve as an umbrella config for all HPE
> BMC SoCs. Add a choice menu under mach-hpe to select between:
> - HPE_GXP: Gen11 (GXP) BMC SoC (ARMv7)
> - HPE_GSC: Gen12 (GSC) BMC SoC (ARMv8)
>=20
> Update arch/arm/Makefile to use the new CONFIG_ARCH_HPE symbol and
> migrate the existing gxp_defconfig. Add stub Kconfig files for the GSC
> SoC and board to maintain a valid Kconfig tree.
>=20
> Signed-off-by: Jorge Cisneros <jorge.cisneros@hpe.com>
[snip]
> diff --git a/arch/arm/mach-hpe/gsc/Kconfig b/arch/arm/mach-hpe/gsc/Kconfig
> new file mode 100644
> index 00000000000..9821bf6149f
> --- /dev/null
> +++ b/arch/arm/mach-hpe/gsc/Kconfig
> @@ -0,0 +1,27 @@
> +if HPE_GSC
> +
> +config SOC_GSC
> +	bool
> +	select ARM64
> +
> +config SYS_SOC
> +	default "gsc"
> +
> +config GSC_I3C_HUB_DT
> +	bool "Fix up the I3C Hub Node in Kernel DTS"
> +	default n

Globally, "default n" is the default, so we don't need to add this line.

--=20
Tom

--Y+P4YqNGE8WDOPwI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadfU3AAKCRAr4qD1Cr/k
CuLDAP0Tv/clsFfNZoeBo36MFhPbXFbvOyksxQXvJGGw5qYTKQEAm/3D7LuyTC5C
hax9iHFL+G0XosDUciZ15lv5SEcvCAY=
=ylX4
-----END PGP SIGNATURE-----

--Y+P4YqNGE8WDOPwI--
