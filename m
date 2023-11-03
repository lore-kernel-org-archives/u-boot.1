Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14842C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 16:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3D0D86FFF;
	Fri,  3 Nov 2023 17:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qzdZPq52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3CC87007; Fri,  3 Nov 2023 17:26:00 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F52686FED
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 17:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2EA0ECE2254;
 Fri,  3 Nov 2023 16:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B25C433C9;
 Fri,  3 Nov 2023 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699028751;
 bh=PUONrmI864eDZI1VLPZm9QazFtzXxdp/5wsubzFGVq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qzdZPq52cXjGoQzoDy8mco8ynWc1EggC2hTo0U45c68jEu0VakNWcFhNPOEPNrTjd
 lw8kcteSf0WpoqptspoFQNsgsVSF7G7Esfm99TY4MMuIjQybW3QuRGMfSYlHNJ1noD
 Uv6yBU6QbydCJw3/HVqYbaOgEfP0j1NMN5hidv6owR/+vK+00u29lbvn8iAgSHfPqN
 FZMB4uQwKXVUzlwcX+hKLLkdAdC6wQ3OgrFiN5/16woEdguNzgNsc9EKKWDyzBHJfi
 Z+dupFuJrJAz7uT1UDlZhJWXtToR0pPdFM2r83ZwKXOh6eHuYdx/ePH0kL2UJemu86
 pCYXAvk/30dfg==
Date: Fri, 3 Nov 2023 16:25:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Conor Dooley <conor.dooley@microchip.com>,
 Leo <ycliang@andestech.com>, Randolph <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Wei Fu <wefu@redhat.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH] riscv: Add support for AMD/Xilinx MicroBlaze V
Message-ID: <20231103-shell-those-d0776d5c2e41@spud>
References: <41c2fda5d6f96e44188d912811a63b8a40625e6e.1699027398.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lLeBhsWn1KoY+zXP"
Content-Disposition: inline
In-Reply-To: <41c2fda5d6f96e44188d912811a63b8a40625e6e.1699027398.git.michal.simek@amd.com>
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


--lLeBhsWn1KoY+zXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

Since you sent it to me, I may as well comment...

On Fri, Nov 03, 2023 at 05:03:25PM +0100, Michal Simek wrote:
> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> It is hardware compatible with classic MicroBlaze processor.
>=20
> The patch contains initial wiring and configuration for initial HW design
> with memory, cpu, interrupt controller, timers and uartlite console.
>=20
> Provided DT is just describing one configuration and should be taken only
> as example.


> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Xilinx MicroBlaze V
> + *
> + * (C) Copyright 2023, Advanced Micro Devices, Inc.
> + *
> + * Michal Simek <michal.simek@amd.com>
> + */
> +
> +/dts-v1/;
> +/ {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	model =3D "Xilinx MicroBlaze V 32bit";
> +	compatible =3D "xlnx,mbv32";
> +
> +	cpus: cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		timebase-frequency =3D <102000000>;
> +		cpu_0: cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "riscv";

You're missing a cpu specific compatible here.
"riscv" in isolation is only for {emu,simu}lators.

> +			reg =3D <0>;
> +			status =3D "okay";
> +			riscv,isa =3D "rv32imafdc";
> +			clock-frequency =3D <100000000>;
> +			i-cache-size =3D <32768>;
> +			d-cache-size =3D <32768>;

Missing an interrupt-controller child node for the cpu-intc, no?

> +		};
> +	};
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		bootargs =3D "earlycon";
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	memory@20000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x20000000 0x20000000>;
> +	};
> +
> +	axi: axi {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "simple-bus";
> +		ranges;
> +		bootph-all;
> +
> +		axi_intc: interrupt-controller@41200000 {
> +			compatible =3D "xlnx.xps-intc";

This is some non-standard interrupt controller, rather than a plic,
right?

Also, should you not also have a riscv,timer node?

Cheers,
Conor.

--lLeBhsWn1KoY+zXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUUfCgAKCRB4tDGHoIJi
0ukvAP9iiiU7xXjPYlFCot7QcdshspjlC9i1cZCa5TCTF0hUZAD+MXViC8t9HCfJ
0rMWVg2tMlOaVVnZSBWr/jiX/fLnnQc=
=9ERv
-----END PGP SIGNATURE-----

--lLeBhsWn1KoY+zXP--
