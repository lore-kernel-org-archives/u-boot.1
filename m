Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55079C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB11889BE;
	Fri,  5 Jul 2024 17:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OZ09kHJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41AD488619; Fri,  5 Jul 2024 17:38:41 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5BC188395
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7034d975f18so865902a34.3
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720193917; x=1720798717; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kT8S24QVu5L+H18glSlImjdYgQ+hJx2Ldsv5Ah3n2M8=;
 b=OZ09kHJlbyDgNhDH7v6n0I0Fps5YxnAmsJT249gDtDyxsypyBxPMrPshULO4Xto5Va
 kvBW12rnvrcUVrEVgp3jf78N5igqo8oDiUsEEcd5LYYjHbjTrV5yEmd79nRHRvjVJFU7
 +6u70BAG4BfmAgptxDoK4/PJ+mtkf/p3RLib8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193917; x=1720798717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kT8S24QVu5L+H18glSlImjdYgQ+hJx2Ldsv5Ah3n2M8=;
 b=g12h+P3zz/fkKOq+HBz1voElxXTkmPleN3c+0D0vpqKKIHjKA9vbs+/a1FKSKvpqNZ
 dXcsBntu2aUaScE/Q7EZ5LIe2FkogbCV0qZf9sdJER28drWXOOEWvZHwYPT6VK5u792W
 sL1J+oSKckyXCxl3v+hu3KhSw5MvgTkAkkSs3PvB7DpckRsX+ybs1SB3IpP6REas2BhY
 nc/laM1NyRLvRuotjEZEAs8aRFRfxV9TPdhFwimjtqxJPGY8vtTaTr0VrNXAA+K7saA3
 sN4zincqJp/vFxAO7pBYEDdm4bnlXHdW41yFNblXKzV3IskNQ9Q9n6XiuLQXw64NQ5kF
 5o1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW7DuSgoNHfRyHSyV6O/7PfnuAdMYqHdFaoRegtjDTqg9n7MGcXPyI4zL3cg8T3aSKV3iovbr+Sc9N75sT88WUFnV3Dw==
X-Gm-Message-State: AOJu0YydtFgH1hpvJJhJr0hlAU328ASO/FxGKJs/HQg0amkGjpD0KC0Q
 DjxPL7hTKas9lL99zAcEjnhCr2eBZbJP8cComBW5rqParmB3vDWSnpk8yVBjHaY=
X-Google-Smtp-Source: AGHT+IHN1G7KkXuZHQoUWQBZIYU7eVx3E1CTpTlsGpe+YAIyLq65Q+HKngjkLOvLHk8XBhrm/tqlYw==
X-Received: by 2002:a05:6870:96a2:b0:254:997e:ea4c with SMTP id
 586e51a60fabf-25e2bb7ecc7mr4062130fac.31.1720193917517; 
 Fri, 05 Jul 2024 08:38:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25e4659b5d9sm334184fac.12.2024.07.05.08.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:38:37 -0700 (PDT)
Date: Fri, 5 Jul 2024 09:38:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Sjoerd Simons <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Nishanth Menon <nm@ti.com>,
 srk@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 08/10] configs: am62: Enable configs required for
 Ethboot
Message-ID: <20240705153833.GI38804@bill-the-cat>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-9-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="omcJ0891BenCv9Bn"
Content-Disposition: inline
In-Reply-To: <20240705045030.1141934-9-c-vankar@ti.com>
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


--omcJ0891BenCv9Bn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 10:20:28AM +0530, Chintan Vankar wrote:

> From: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Enable config options needed to support Ethernet boot on AM62x SK.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>=20
> Link to v2:
> https://lore.kernel.org/r/20240425120822.2048012-9-c-vankar@ti.com/
>=20
> Changes from v2 to v3:
> - No changes.
>=20
>  configs/am62x_evm_a53_ethboot_defconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 configs/am62x_evm_a53_ethboot_defconfig
>=20
> diff --git a/configs/am62x_evm_a53_ethboot_defconfig b/configs/am62x_evm_=
a53_ethboot_defconfig
> new file mode 100644
> index 0000000000..1f9ad63571
> --- /dev/null
> +++ b/configs/am62x_evm_a53_ethboot_defconfig
> @@ -0,0 +1,12 @@
> +#include <configs/am62x_evm_a53_defconfig>

Same problem as the other defconfig.

--=20
Tom

--omcJ0891BenCv9Bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIE3kACgkQFHw5/5Y0
tyyKrQv/eYZR8hDglFZpsuwPNRE94FlswDSGRn38YFLnoZF1R6wM+29XwBVeCYPx
6ok3ymKew4EKJtaNDWitqp0yoq5+/q5ab9YGDj+bYDThya0LRStpScsE0QgeAARp
7WLAK0IhAWVhm2foZZMXTlpv1/jBzMpf6bVewgFg3ykyx02Nog31jagXMkMKvoC8
8QzHsFcZ2mvO7tp0FOmZrNwMSRl/Q9K8Ygmb43+/gJ1uPioXxJYGnhtWkf5uvXyw
MwpZit5LwMWUfnMTXBuLp6bJ0vkMNqAZ0GgldYISHIUjI9THsAQK01TovCe0/+4M
ASJSJ9XmACE8wXAEsRuzeRh1Q00CoQAluOv3W/3Vw46HyHU3telNWEa12xy1URP/
wi2yI/Kp/LnqOe5uSwOONufUc8pSPHQK4PWCbAOH7p7KEJStbAzdN55ALWDryEBh
eOiECLIAhOdqzUwOBsmEkBwq16mgBqJFlHQeQzrUDYfEWsdSLhcwQJWDOZ4ucI4m
z23y1llF
=cUEN
-----END PGP SIGNATURE-----

--omcJ0891BenCv9Bn--
