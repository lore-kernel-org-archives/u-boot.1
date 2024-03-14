Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD95C54E66
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 00:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C74287E40;
	Thu, 14 Mar 2024 01:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A0vOz2nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72A587F05; Thu, 14 Mar 2024 01:38:50 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A19B187E3A
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 01:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-42a029c8e76so2612061cf.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710376727; x=1710981527; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T5s92V2io+pf8yq95oI/Gl2dcnN1lYHZ5Ymj3sO6HH0=;
 b=A0vOz2nxNUf/CSXT0kd6fRI4b0BTDL+mvQk8kjdoNve6HPnpLYUIWHXP/gIZUkvTBa
 LvIsL3jtB8HjDOxmg7pJi6XbTSZtyv5+UDbaXZbyhkmr0hnlEx+ioG4YuVzzT04Y6K/e
 X5SgB4/YJzBIwtkrXQwFgG/eek5zGuU1coE1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710376727; x=1710981527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5s92V2io+pf8yq95oI/Gl2dcnN1lYHZ5Ymj3sO6HH0=;
 b=tHRE7HXDQP0vhH8Qydk4M5XXJykCbVOOWmhk3HcqnYSoaQQNZKrBKhOIPY/vFGgNba
 i+lbdeAUUc81mtU+TptF0ANW6mN+yQzXw4sz8rSF9TGPeF2sQHvTGWe5LpwxpqxI1IJQ
 92EECSplsIgdFWOGIAeMPQTg0X/swA+DuYW6hcHRRwJ3X6vcp96UuRld8xsaw1PXdLow
 gMkTgBU9oxDKmvXNLRYRgfq2zT7pCrlPByPzWrJh0KiFNu5NI7OpWXToI934dK9dnqLD
 lZMZ7yl6gGoKlkZcF/qCU6DoboEJw7YYFQYm8EKdBvJmIHcTf/hIRCYR9IJeUA9xyztX
 jGlQ==
X-Gm-Message-State: AOJu0YzAzAxRDCbaicuemkfseL0r8USX6z7F2oEmVp6rETLrqWX/jW/K
 yr6QgmLz491vrH2y/YJNeALi1TLbPOBRaYGD9KF/ijYRsJMNNXhnraa6hKyB888=
X-Google-Smtp-Source: AGHT+IH72dnymKMYBmQjgndixJRF+R4hjntu+eXgZlP6IOCmMcGzW0+WIStv1UDxqO6bklPd6+OA6w==
X-Received: by 2002:a05:622a:110c:b0:42f:3075:3e09 with SMTP id
 e12-20020a05622a110c00b0042f30753e09mr323810qty.4.1710376727398; 
 Wed, 13 Mar 2024 17:38:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 gx9-20020a05622a27c900b0042ef4b5f4fbsm139227qtb.38.2024.03.13.17.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 17:38:46 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:38:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
 Simon Glass <sjg@chromium.org>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] fdt: Fix bootm_low handling
Message-ID: <20240314003844.GB3442575@bill-the-cat>
References: <20240302225527.179601-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KROCBm3hSGYSJ1BM"
Content-Disposition: inline
In-Reply-To: <20240302225527.179601-1-marek.vasut+renesas@mailbox.org>
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


--KROCBm3hSGYSJ1BM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2024 at 11:54:02PM +0100, Marek Vasut wrote:

> According to README CFG_SYS_BOOTMAPSZ section, in case both "bootm_low" a=
nd
> "bootm_size" variables are defined, "bootm_mapsize" variable is not defin=
ed
> and CFG_SYS_BOOTMAPSZ macro is not defined, all data for the Linux kernel
> must be between "bootm_low" and "bootm_low" + "bootm_size".
>=20
> Currently, for systems with DRAM between 0x4000_0000..0x7fff_ffff and with
> e.g. bootm_low=3D0x60000000 and bootm_size=3D0x10000000, the code will at=
tempt
> to reserve memory from 0x4000_0000..0x4fff_ffff, which is incorrect. This
> is because "bootm_low" is not taken into consideration correctly.
>=20
> The last parameter of lmb_alloc_base() is the maximum physical address of
> the to be reserved LMB area. Currently this is the start of DRAM bank that
> is considered for LMB area reservation + min(DRAM bank size, bootm_size).
> In case bootm_low is set to non-zero, this maximum physical address has to
> be shifted upward, to min(DRAM bank start + size, bootm_low + bootm_size),
> otherwise the reserved memory may be below bootm_low address.
>=20
> In case of multiple DRAM banks, the current change reserves top part of
> the first bank, and reserves the rest of memory in the follow up banks.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--KROCBm3hSGYSJ1BM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXyRxQACgkQFHw5/5Y0
tyy+EAwAqCuMnIdc+UTfxqDwWHY9ojVM06JrVV26otDtn/93nNquJAR01l2elZEF
x7QG9+8VzXVW6rNyqF6lGE5FOXIYwwCWaNLrwS89AZnbDA568KIpvYrZRq0ba5H7
J1Jkulnbb6NybvCtjD8QXmZS7dQYzEkfsDTOIydi1SkAN8cR4SoATe6CIE8akWb8
np9ItFphuHcpBQMJPVyzhg9/r0FAG1nsgc3jBu+Ro4IV93vMQjTaNrr8Y0zLwIVI
oq2XJrpJ6Rinhfz6E/tzxrHLgt2U18pW5oUf6kbKy5UUuU4Krm6LjN3imG8CSlOk
Ta4iNePsZgaloIbF//l36NreKQnEsmzNBxsFA9LzzwJqcQMnyTwDVj8fn43oc8X4
KkkHJ0Go+nSChDmPvaSFSDFChlYPFYQqasN4ErH/Dde1IC0WYzLVmyoOeCti2ePu
Zq5xS0XOtKmY+KKJv2p8yTSLYAzHNb/8PEokimeQK4pGe90uZNF1kD+6An8txcwS
EL0MW8H4
=frHw
-----END PGP SIGNATURE-----

--KROCBm3hSGYSJ1BM--
