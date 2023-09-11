Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8287BEE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 08:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3678642D;
	Mon, 11 Sep 2023 10:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=short.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C77886D3E; Mon, 11 Sep 2023 10:27:47 +0200 (CEST)
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2758642D
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 10:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=short.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gszymaszek@short.pl
Received: from [192.168.192.146] (port=40768 helo=nx64de-df6d00)
 by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gszymaszek@short.pl>)
 id 1qfcGf-0001ov-Vu; Mon, 11 Sep 2023 10:27:38 +0200
Date: Mon, 11 Sep 2023 10:27:36 +0200
From: Grzegorz Szymaszek <gszymaszek@short.pl>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/7] rng: stm32: rename STM32 RNG driver
Message-ID: <ZP7PeFpJzneU2h9k@nx64de-df6d00>
Mail-Followup-To: Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U+/2MNMhGgq+YarA"
Content-Disposition: inline
In-Reply-To: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
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


--U+/2MNMhGgq+YarA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 07, 2023 at 06:21:54PM +0200, Gatien Chevallier wrote:
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> -%<-
> -config RNG_STM32MP1
> -	bool "Enable random number generator for STM32MP1"
> +config RNG_STM32
> +	bool "Enable random number generator for STM32"
>  	depends on ARCH_STM32MP

Shouldn't the "depends on" be updated as well?
("depends on ARCH_STM32 || ARCH_STM32MP", like in STM32_RESET.)


All the best

--=20
Grzegorz Szymaszek

--U+/2MNMhGgq+YarA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEZT55kPBhnB69hD4ZeE9lGUIcpz4FAmT+z3cACgkQeE9lGUIc
pz68SQ//VFui3En7zRyXmQrUSY9PDk3nwEPAZwCAy3hmAfDmnCVOSXAgQ1o1pHz1
g596Jmn+k0kOeDd4lAv9WWWy7NBtmCwNTORQ+iHIz/xesA+dBslmewzqNX9dZeAL
NVUySeRm0Sqijv7vpw5aWlDnWJMUcaiREDK7ZLwayg6HMjcOoGWAKwlIIUqYBjS+
DlTvrlCTJpr5I976vyvbAVdNItW0YFc9uYRbJ31IMnhQec+7fDfepifZHQgVa4i7
5KK3zHn/KgaAzHxmdibcm013FhaiNw6V4Q0bV3N2lXdqk3NQHn7Y/EF6pNkTkorr
ze4zANwDWQRaIMXoWzmRP4f+ON8ikrw/8Z8ui29sh7h63e8DJ1xFu0G9GlYOwVu4
pZpbEPSZtb8bOv18i2NahizT6j3msGZk9Cy01wO13nZxfz/bTccnASOiKCEPY7VI
E+R95PuTEU6X5+Hbz4ktKRtGY14ztuTBmQFg6n7ctcaf/kDy6405sd6BFSUVJIwk
sL5lbZ6M1dcUn8D6NYlEIKMPGGYuV71+Ro1nnK+T5p70Fojg+Dj6UwNTEAmOJIXr
hDCfx9b0u98FQU1v+rLEAr6kI9OVeryfDK1b/qaAb39egmx/Mx0yEG00buL0XNgx
DeCj8snz7rWLs6bQbdFL9efU9Jp+o7jaE/L8YiacFbTTRTWkNWE=
=9V0N
-----END PGP SIGNATURE-----

--U+/2MNMhGgq+YarA--
