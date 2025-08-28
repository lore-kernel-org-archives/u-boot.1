Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2444CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 17:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF17A832C8;
	Thu, 28 Aug 2025 19:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jvzof4ZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC99833BF; Thu, 28 Aug 2025 19:35:00 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BACA7805D7
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 19:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-61dc56dcd2dso898621eaf.3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 10:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756402497; x=1757007297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xbQmyS/ZoU3XyiTV3/mcnIgk0+h3uWdrVlEc2UnCqC0=;
 b=jvzof4ZQYH+IzQ9T+lnC5b+QbWeIkHS/Y829ClIIjcZhcBnYYa7DoHgwghXpSYVprI
 in2i5qFvhPdL6e3ynY91W985IL7+93pVEaut14/5LxK0WjfXZ6DSohwc6D9RQZeMeYY1
 L6cbE6hjYezIKfJ/R17dM0GpC6RfHbaGX2q+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756402497; x=1757007297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbQmyS/ZoU3XyiTV3/mcnIgk0+h3uWdrVlEc2UnCqC0=;
 b=ZrzmDH4CFnvFfjya577s8OeXzcKflx5Znme0mcQQFt25aceJNOb9By4QcLvvhVRSEo
 W8qsDP3ZdVIsA6QlUfA0heBRYJbg4Iv7odyspBUi8zpkaXU0+bOQqK45iYH/KWyOrK8J
 cbuA8u+YqKbVKDnI0JbNsD46gJfGgfe/g8TusYMQXgL6dXHAQiYBT+5HgtbTtGdkNcMi
 WUaf2SynmSfzl1pMUjOJtLWWsi1/zByjUJ9AVVtor5MgdGZlgE0/LnoP8KiO4DgCxCTJ
 eSU/Wl95S19V2kpGBSLw0PnWkQRJeFtVfrTRJeHyeQd7VLE5HySe1H/v5P4IHDYcXCQH
 EnNw==
X-Gm-Message-State: AOJu0Ywx5KzSf+aGfgLf6686NAjGLTM7Gf4Tm01Q5eSI/UdaGRJJL0kU
 NcAuh7JXC7zzbc2doi//SqXwElUWeGaLtk/6pHVapHuwPG27Y13G/EcEmjzIWwTuZqKE/iX/d3J
 81igdMog=
X-Gm-Gg: ASbGncsDWgC2hLgTwRBjfhwIXUBHizJ/GFKDafjdR0MMBGNpK6ExeDnprwUnMaiAxM1
 lIx0YNTftV2/gPpBpXoBryiYHAlLBO6UldEIKgqdgbHdr1Ug3/JAxwvCRJJ+4J3pJlNGHE6IAqQ
 WqUgaouDUmP5OL1vt8cULM5dd5SqfnSOXHVPx+PFiJJrHYAc00NhmGXGrNBZZbgxJqn+IXAaUhl
 oABPSM36r2uvyJk7Q/b6cVrG2e7S+nuMXV6Z149wt6Zvw1paz96blZe5gpsD9gprrJkG53vN5rK
 8+9bCF3an6y1D+IHd0dn1sO4udSvp8sODOJMqoCFgsAfQo5wuKbWzuHHs+bKNZeqQ4ZhjILBucc
 Wu3K3v6Wy3OjcXmRoBxBhuyn2JYu6AqFpZ1RsIxjq1SKZxMwujzvds90R
X-Google-Smtp-Source: AGHT+IF8R5KHZrh7pQKIkNdQU8kZi9PplpDqn4to8YLos1PCPOawF1PttFoJ606GannqyUDE1jYxZg==
X-Received: by 2002:a05:6808:10d5:b0:40a:533c:c9cb with SMTP id
 5614622812f47-437852cd597mr12378461b6e.38.1756402497344; 
 Thu, 28 Aug 2025 10:34:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-437968f0cb9sm2585954b6e.26.2025.08.28.10.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 10:34:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:34:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Said Nasibov <said.nasibov@arm.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, andre.przywara@arm.com,
 peter.hoyes@arm.com, david.hu2@arm.com, michael.zhao2@arm.com,
 marek.vasut+renesas@mailbox.org, mkorpershoek@kernel.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 m.schwan@phytec.de, quentin.schulz@cherry.de,
 rayagonda.kokatanur@broadcom.com, tien.fong.chee@altera.com,
 casey.connolly@linaro.org, patrick.rudolph@9elements.com,
 alif.zakuan.yuslaimi@intel.com, boyan.karatotev@arm.com,
 Oliver.Gaskell@analog.com, duje@dujemihanovic.xyz, 1425075683@qq.com
Subject: Re: [RFC PATCH 1/2] bootmeth: implement semihosting (smh) boot method
Message-ID: <20250828173453.GR124814@bill-the-cat>
References: <20250828130657.249153-1-said.nasibov@arm.com>
 <20250828130657.249153-2-said.nasibov@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZuLTaI6gbQ7CtWkV"
Content-Disposition: inline
In-Reply-To: <20250828130657.249153-2-said.nasibov@arm.com>
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


--ZuLTaI6gbQ7CtWkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 02:06:56PM +0100, Said Nasibov wrote:

> This commit introduces a new standard boot method that supports booting
> via semihosting as provided by ARM FVP platforms.
>=20
> Semihosting enables the virtual platform to access host-side files as if
> they were block devices, which is particularly useful in early boot
> development and simulation environments. It removes the need for physical
> storage or networking when loading kernel components.
>=20
> This method mirrors the distroboot logic for semihosting, which is the
> default boot method for vexpress64 platform. The load_file_from_host
> helper function is implemented to mirror behaviour of "load hostfs" u-boot
> command, so it similarly sets filesize environment variable after loading=
 a
> file - this is useful for later commands.
>=20
> This implementation is marked with BOOTMETH_GLOBAL so it is always
> considered during bootflow scan without requiring a boot device.
>=20
> Signed-off-by: Said Nasibov <said.nasibov@arm.com>
[snip]
> +       env_set("fdt_high", "0xffffffffffffffff");
> +       env_set("initrd_high", "0xffffffffffffffff");

Why do we need to do this? U-Boot should be able to move things if
needed, as there's good reason when it does this.

--=20
Tom

--ZuLTaI6gbQ7CtWkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLCTPQAKCRAr4qD1Cr/k
CnevAP9dSR6PBw1lyXyfR5APZ3+EiAsQeEVL9nYBm4CupvUbxgD/XZLI9wIvHz6i
ecvohqCeswyHidQte9cC9UfHDG74WQE=
=UuVK
-----END PGP SIGNATURE-----

--ZuLTaI6gbQ7CtWkV--
