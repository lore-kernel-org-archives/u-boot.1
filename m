Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54BBC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 11:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C8482A76;
	Fri,  4 Jul 2025 13:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="RaYOx3Pq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D2B182A8D; Fri,  4 Jul 2025 13:29:55 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE198806D8
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 13:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=273a31b10=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751628592; x=1783164592;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nKI3VhanVLJYkZmxNJmCoNEmjcgRFD1zDojhOvGyQmg=;
 b=RaYOx3PqOTRahEFaMIlKbn550Va4MEMJs9lyyc0OyS8TYGakmv0ldd/j
 Dn9h76PGDcEyvolB0E19JQ/kkpWkgEaPdkSYc6USB/YoI1pVmkdRv+ylQ
 Ub/QYrIbpXv8Sqbo9zfazdz4hfQPjZ8gJL1P9qJ6iiMCNHD1AEIVpB7O3
 5Lu0A3sJY+/kh6bKQ2yQwL4KSvtkCYPQKoKPJI4freUm2mCuMH1TKPu7b
 7v6yELPJKlpyKdQfDOuRsTi5ukTMAYSn/7rf5d/1KMDj9+81yOQyKenQb
 CZTe38NDr9B0oqC3acLNyrz28u5PNj1EGQJCDIDnjPqL7K+r2q35jhHyR A==;
X-CSE-ConnectionGUID: jmVewWutRueVz5m1FhpQYw==
X-CSE-MsgGUID: D7ti3cPBTj67AfT2YmRTDA==
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
 d="asc'?scan'208";a="211051838"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Jul 2025 04:29:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 4 Jul 2025 04:29:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44 via Frontend
 Transport; Fri, 4 Jul 2025 04:29:28 -0700
Date: Fri, 4 Jul 2025 12:28:15 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Leo Liang <ycliang@andestech.com>
CC: Conor Dooley <conor@kernel.org>, <u-boot@lists.denx.de>, Ivan Griffin
 <ivan.griffin@microchip.com>, Cyril Jean <cyril.jean@microchip.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Simon
 Glass" <sjg@chromium.org>, <Jamie.Gibbons@microchip.com>
Subject: Re: [PATCH v2] board: mpfs_icicle: implement
 board_fdt_blob_setup()/board_fit_config_name_match()
Message-ID: <20250704-habitant-raisin-19c55be39a20@wendy>
References: <20250623115137.4017059-1-conor@kernel.org>
 <aGZW8cabMrd_76sw@swlinux02>
 <20250704-mortified-defense-b100145ed06d@wendy>
 <aGe0gtU0TaeHYlNd@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SxqgC1MzvGA0nUt9"
Content-Disposition: inline
In-Reply-To: <aGe0gtU0TaeHYlNd@swlinux02>
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

--SxqgC1MzvGA0nUt9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 07:01:22PM +0800, Leo Liang wrote:
>=20
> The PR has been sent and merged.
> Could you send a fix for this?


Yup, it may be Monday before I send it though.

--SxqgC1MzvGA0nUt9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaGe6zwAKCRB4tDGHoIJi
0njWAP4/IUuBZWAcVr2tcSOlLwEPrSq5znQhmvzdsNu64Aa60AEAvcPLBMhH899z
vYGGn9ivAMfYKN2aw1BlBE0JqAGReg8=
=KmMC
-----END PGP SIGNATURE-----

--SxqgC1MzvGA0nUt9--
