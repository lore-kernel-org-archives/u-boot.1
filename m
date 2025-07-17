Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34448C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 17:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F6098343B;
	Thu, 17 Jul 2025 19:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jjbN9b+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B1983445; Thu, 17 Jul 2025 19:41:56 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C60B833FC
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 19:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2edec6c5511so612648fac.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752774113; x=1753378913; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zReWN892sPPz2AcwjcEilIxus6jRmSG2BgJG56zlGgM=;
 b=jjbN9b+aiuvoIKO9WyJgZ2B3TgCrDoXvEPxqp+j41IQpHqt9pJqKWc4ro9rXrHRY0k
 cIKi48vQkUq4Wtvf4yz9zGs/mUuEQ5xCIpbumnjMo/saAcyjiDFomYC03QtDaPT6qC50
 /tNx2T84rUDuh2mlM2xWP1Ahp9+SCBQ98Pvdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752774113; x=1753378913;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zReWN892sPPz2AcwjcEilIxus6jRmSG2BgJG56zlGgM=;
 b=n/0o6n/sOBik/kkTyjfHvbagXTlvj04pBd9qG504WepVzJjG/oiGckLf5bYKbXhJM3
 oUFi10VSRftqO7M3rdA51elCblrOihKVCMZFwRF6sY+g1qugzStbYb5jLeaSglMskRts
 bIAPXc0fu0NpPgIXzy1T/Ox/57a0hHkn12OGkXbY4Rr60c9zTJqM1lgQCI6d8wDJTg1I
 y05Ne8t4nm0JTjG9VsXf9wI+OlQm97xht10CuOlUKnN6wvCcP5GKX0r591FH42OrDWVf
 hsFSdgYDfZU7DUDrVNyJ7cQZdSUg8YYSCDNfTeZOwKnhIb4zEHGuixn3gMgXf91BwRBO
 MAOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuikI8n46EB6329xIgQSJgWjrciuKwPA6i8ubsBANwdzB57bRVleI8bNVGQLpeXCJaz+oX4lw=@lists.denx.de
X-Gm-Message-State: AOJu0YxJN7NX04gEPQcu9DdQOPV5bIHJcrCdOeXl/SAFjd3kKa/W8Jd2
 m4DtKPSphHJJJjf1+31SmoKLQZIV1VeBEgEnEuHYm1N9Q40GCgtknAU1yd/bt5vbxU8=
X-Gm-Gg: ASbGncvWB2fnG3/YyhiM7Wkh4+SakFBAc4JLPiYPZ+dW9ymRo1N5b56dwuePchLGI2B
 xTCXyWvVhkpaR5BzoMjpeR6pYjNLGjmzQtEYHIPJuCUhMNAMpZeqKSV6vL3Y7IPLAfqpStTNYPH
 YV70B4vjfRRNFBLj1v5wPX75+P7QDfg7LIGG4tqGWLsU891X94GsXe7f+KbySlWpl3YKxQ9EK1a
 p7c2QqXZsCbdpBs1LN6VNEyARGBMRDhPPRYdRzEQ3Gsgd0HJ3g52SeaosVkpuUGxFkR/NX4hTjj
 faNEZvbsgNDDm31UXuO7LjRQWW/LlBTht+w0zw9vu+hOMPCh4By9sBj0SkZ9H8rJz174oT8VRdu
 IxKPsCTBV/aoOFWsKATMP2Iwc5Dpg9iAlp66a2fDCPvR35WbcAgXF6AwO
X-Google-Smtp-Source: AGHT+IF7HEhZpAtOjiE2PmPfSkhPy1a1pyI91K3lAGd2Fd5YqnMxaAiRyJLO4X5zaF3FpkzG6/k/rQ==
X-Received: by 2002:a05:6870:9623:b0:2d6:b7b:a83 with SMTP id
 586e51a60fabf-2ffaf2a2c40mr5673790fac.13.1752774112874; 
 Thu, 17 Jul 2025 10:41:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1064f51sm3998775a34.3.2025.07.17.10.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 10:41:51 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:41:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sughosh.ganu@linaro.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
Message-ID: <20250717174148.GO193579@bill-the-cat>
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
 <20250627185723.342553-2-ilias.apalodimas@linaro.org>
 <CAPKp9uZPPOdQi_vFKEjTA4NE3oy0WPth-ugc21wKR7GPu4OD1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kYmyliaSrpVOHqT2"
Content-Disposition: inline
In-Reply-To: <CAPKp9uZPPOdQi_vFKEjTA4NE3oy0WPth-ugc21wKR7GPu4OD1Q@mail.gmail.com>
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


--kYmyliaSrpVOHqT2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 06:03:09PM +0100, Sudeep Holla wrote:

> Hi,
>=20
> I see build break with clang after the commit 5f520875bdf0 ("kbuild:
> Bump the build system to 5.1"):
>=20
> Build command:
> $make -j`nproc` ARCH=3Darm64 O=3D$BUILD_DIR
> CROSS_COMPILE=3Daarch64-none-linux-gnu- HOSTCC=3Dclang
> vexpress_aemv8a_semi_defconfig
> $make -j`nproc` ARCH=3Darm   O=3D$BUILD_DIR
> CROSS_COMPILE=3Daarch64-none-linux-gnu- HOSTCC=3Dclang CC=3Dclang all

Does it still fail if you don't pass ARCH=3D? That's not valid in U-Boot
and can lead to breakage.

--=20
Tom

--kYmyliaSrpVOHqT2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh5NdgACgkQFHw5/5Y0
tyxEgAwAskzwlLMWB+DsXxOPI9YN6nckf//tCke0lzYZNf4/mAt20piWf0230SlX
+6tPMQpW9tspWoLpl3vbtyvflpfCkHvIlRSzc+G3dqO92k9nsEVQQYLo6tM0dNH6
69GkiljspJ3YurKPIzv0q5OX+z15rCMbhTNb6jGFM0//9hTunXrBR1T5sBFvgHA7
Ta+jqBS5acwmxAXdRAKIXZC2956eo+yKkUFOTogtbVSwCZ5zCfuH5/0DOyaBW1sN
dY5UCdHOjl2ykYfdRG3o7Q8SsLt04fw/EwT/56cca5BP/+/mZe8Ew8/yHxmz1Nql
H8Q1OqMFFPlRGEzX21BR8q/8reuQM5eNCroS7/ahpgJOT9V+OVbCmVYET7edZMZv
oTOhWOLsURo4nyswhlGoB/uHdsQbcR6siTqhiZmQKvdZNt6OL27O4F/b5GtMWFi0
VPmYsEQ8jq3j3I9DZxtVcuS5Lzzmb1n8VfkLZ1lXacU9YpiM7qsGEwZEDbn2Ln9V
2a9MycLZ
=iizY
-----END PGP SIGNATURE-----

--kYmyliaSrpVOHqT2--
