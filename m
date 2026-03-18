Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1985103E162
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 11:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F615840CB;
	Wed, 18 Mar 2026 12:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AI6hTR3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3324B84114; Wed, 18 Mar 2026 12:16:17 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CB2840B0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 12:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AECDA4335B;
 Wed, 18 Mar 2026 11:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BB9C19421;
 Wed, 18 Mar 2026 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773832569;
 bh=SAA9eAnt7cy5T2Rt4JwBkBAv7boG5XwNIFsqpMRLo5k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AI6hTR3/ArVWS6DyOrcdoTqRj5U3Rz0XR8QUWO2DZ+lsRR0I2kyTvXoBdm59zKEKe
 OTr1jXEwTbc+ayegriQKp8GRldgRkyrQl+0jdti2XOinqw1NpDy5i9fy8kr6ho5Cop
 VQBy8qvXb7Oj1scXzeMqynCSqwVEqMqSg5bx8LB3qYlpm97PfLeL2NvPza+47HPMlE
 qrtzUoG/CNqi6KTMphb7dt3HEMDhMviuLNUeup91FD4ai39OpOAbfkuTAac25zpKkO
 ysV6ig2rLS4H5hzrGuRkEjWBmTerVYApxYeebNSoljgzIoHE1ucTadpeMkzRFBQyR7
 7kIMLBYUag8YQ==
Date: Wed, 18 Mar 2026 11:16:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Uros Stajic <uros.stajic@htecgroup.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v5 2/8] board: boston-riscv: Add initial support for
 P8700 Boston board
Message-ID: <20260318-moocher-cupbearer-bfbe474d8d55@spud>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-3-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BLtm5EV75sxVUyiM"
Content-Disposition: inline
In-Reply-To: <20251224154449.946780-3-uros.stajic@htecgroup.com>
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


--BLtm5EV75sxVUyiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 03:45:47PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
>=20
> Implement initial board-level support for the P8700 Boston SoC.
>=20
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> diff --git a/arch/riscv/dts/boston-p8700.dts b/arch/riscv/dts/boston-p870=
0.dts
> new file mode 100644
> index 00000000000..f27ebeda4a2
> --- /dev/null
> +++ b/arch/riscv/dts/boston-p8700.dts
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/clock/boston-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/mips-gic.h>
> +
> +/ {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	model =3D "p8700";
> +	compatible =3D "img,boston";

This is not a unique id, this is used by a mips mips board already.
I think the one that is being used in opensbi is mips,p8700-boston.

> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		timebase-frequency =3D <25000000>;
> +
> +		cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "riscv";

There's a specific cpu compatible for this now. "riscv" in isolation is
only for qemu etc. OpenSBI actually wants the specific compatible.

Can this be sent to Linux, so it can get more eyeballs on the dts, and use
OF_UPSTREAM to import it to U-Boot?


--BLtm5EV75sxVUyiM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabqJdgAKCRB4tDGHoIJi
0u16APsEoeUsYwoQXxst6GHhg6qMc9918lDNlwKfS4kW6YAZUQD/RIlE8O08uVo3
Y90AIjTI7aiJjy4SEVe+yL/JVlBrsAw=
=er1d
-----END PGP SIGNATURE-----

--BLtm5EV75sxVUyiM--
