Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A59C25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63FD38793E;
	Mon, 23 Oct 2023 18:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B59yuV24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9698C8793E; Mon, 23 Oct 2023 18:59:00 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3633C8793C
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d9a6399cf78so2944423276.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698080337; x=1698685137; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PpRDTr/SjqI7u9cHigusDrRJo1PBaJdLXmeB7mcPA2E=;
 b=B59yuV24YPM4/L5peao262XMI3YljvkUGAApi2OpxmfWWBj2SFQ9P40xuIa1W9ZGRh
 boahNUCe3qx9OETkNk4xkaGFZY+9mJQ4C4i2x6EEJh2wG0mk3yQCAIpVkT+8dAbscnde
 UlvD1gxQm2+H29B25Ai1cctWOyBLYQVVRPtpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080337; x=1698685137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpRDTr/SjqI7u9cHigusDrRJo1PBaJdLXmeB7mcPA2E=;
 b=I235kY5g1FrzZK1q2t67V/+h9CssPbY3nElHmOfSYuYCQbsUcTHx7vtO9poj2jtCQO
 ric6nHkMuH5RK5zc8avke89V8QjN/HI3TIyACqULBFwRnLGozpYhBrBdgXqUPv0DCyo5
 FxWyBszx1GBA/KDwEQUF1XCySKHH8JvZIecn8oa3GPQ/NIn0eOQ88ixroZsoEa9xEJbJ
 mGwGK/tXz9bXVXmyrSi2IPUAwlhgrPgUyF2qwOFP5EVTHQ0lzgoKkPiNXBGkqOZNK+wW
 AJcop9+xXEBYjnIh/HF/oaaKp+EML/zTTAUwrRbnDZzFwW5hpaWQdh/jCODha107vg/x
 ZHBQ==
X-Gm-Message-State: AOJu0Yw7VU2K7XlIlFaNF4XbRKZ9S0FbOEfbcydmdw41qGQbN2Mx0vm6
 nYo9XcglZlyaQUsLzFF3NPkqvg==
X-Google-Smtp-Source: AGHT+IEwPcfS8VFCLlzKQRTimI2x6e3pvjlBWqNcM5ueVK/M9mV+rx9XdeDkZnDtrzNsrGNKsXF4Pw==
X-Received: by 2002:a25:ae0c:0:b0:d9c:ee80:9215 with SMTP id
 a12-20020a25ae0c000000b00d9cee809215mr10651477ybj.26.1698080336903; 
 Mon, 23 Oct 2023 09:58:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a25a2ce000000b00d81bb7ef494sm2826347ybn.19.2023.10.23.09.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:58:56 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:58:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>
Subject: Re: Pull request: u-boot-sunxi/master for v2024.01
Message-ID: <20231023165854.GP496310@bill-the-cat>
References: <20231023104830.792659-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4NrcLYGt0f2p17kx"
Content-Disposition: inline
In-Reply-To: <20231023104830.792659-1-andre.przywara@arm.com>
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


--4NrcLYGt0f2p17kx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 11:48:30AM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull the sunxi/master branch, containing the first part of the
> 2024.01 changes. Apologies for the late PR, there were quite some recent
> activities (fixes and reviews), but I didn't want to delay this series
> any longer, since it's been around one year in the making already:
>=20
> This is mostly about support for the Allwinner R528/T113s SoC, which is
> reportedly the same die as the Allwinner D1, but with the two
> Arm Cortex-A7 cores activated instead of the RISC-V one.
> Using sunxi code outside of arch/arm proved to be difficult, so apart
> from enabling this Arm SoC, the patches also prepare for more refactoring
> to get the D1 nicely supported some day:
> - We get rid of some Kconfig (hard-)coded GPIO pins, responsible for
>   enabling regulators.
> - The GPIO code is moved out of arch/arm, into drivers/gpio.
> - Some definitions are moved out of header files under asm/arch.
> - Some T113s/D1 specific definitions are guarded by a generic Kconfig
>   symbol (CONFIG_SUNXI_GEN_NCAT2).
> - The DRAM controller initialisation code is located under drivers/ram.
> - The base SoC .dtsi files are shared (under arch/riscv, as in Linux).
>=20
> Of course there are also the usual new SoC specific patches, like clock
> and pinmux descriptions, alongside a rework of the pinctrl code, since
> Allwinner changed the GPIO register layout, for the first time since
> sunxi's inception.
> On top of this the PSCI code sees some update, to provide SMP services
> for R528/T113s boards. Many thanks to Sam for providing this code and=20
> staying strong through the review cycles.
> The final patch enables support for one popular board, I hope to see
> more DTs and defconfigs contributed in the future!
>=20
> Many thanks to all the various contributors, testers and reviewers,
> that series was a real team effort!
>=20
> The gitlab CI completed successfully.
>=20
> Thanks,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> The following changes since commit 9a3a58396b78b1f9d0c14580dc03f81d29207d=
d2:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-marvell (2023-10-=
20 12:54:33 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to fa066df62ed9bfe0aed7749a68457468ad8bcc1c:
>=20
>   sunxi: add MangoPi MQ-R board support (2023-10-23 01:00:56 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--4NrcLYGt0f2p17kx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2pk4ACgkQFHw5/5Y0
tyxTIQwAhN0mANE3WldiwmWcG3toZZPVjePOQIra8pccCvxF4gXzvlh3JjfWhOwE
lc78BUnx+DqUNpXOWymeYPzfkudOpBy7bA2ABILoVErkxjfyNnQAt5lg6WbuBCAg
xYvLKAAKJHw6w2FXNe+uni8hXaEO/IhEUF5iG4yQ+OYXmMyUlOh2pArY05KAzaua
c6qr65kZbr1HN8UvmZihJJJZTVVEXrMUYR2XtURFutxg4AWdXIcv8KopUu3VpWMs
mEH8qRE+idaD139XTd+o7F/M3YAzTJy4D9cx3KDZCWSUzmQK5VQuE0fr8ugy8X5w
gNHegHlaGjvdMIA0bnQEFK5ocP545V95UnyZyaISmxbW/z8kFrSvwRRoc/rwbz/r
lJC8gTWz1fkskcaw6VvmuFFIg6Y61cgyexXZgytQuozmKSltUcnD5PkeOqveHSl4
RTJNMQfmGuQOmsLrxorCOgQvmPD6cbI3IcFYuVij2f2FeGwfOlLpipGbwQSZkjuP
U8DN7OnV
=M2nI
-----END PGP SIGNATURE-----

--4NrcLYGt0f2p17kx--
