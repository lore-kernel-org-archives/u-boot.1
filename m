Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C873C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA8F87EE6;
	Tue, 23 Jan 2024 18:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pV0sp+8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70DE87BBC; Tue, 23 Jan 2024 18:58:56 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFE687E70
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5ff84214fc7so43529097b3.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706032733; x=1706637533; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k76tXF1EEl5BumP+88mSzGHFk6sV2Ks+IRcGxKRSwS0=;
 b=pV0sp+8Lp7/6sLaybnZdX8MGBSH32y3HD3ZZL72P7BBZPOYXl+V86LiEw7WlNn2D8c
 mEVsffvAzJKHwptBDn6XayTXD6bocuAedvQ4U9tKWn5X0szAPtDBYLF0tlw8Vm2wmlsn
 Hxr5OyBz8zBXA1fpIspe3AjIicbxJVMXgNKNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706032733; x=1706637533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k76tXF1EEl5BumP+88mSzGHFk6sV2Ks+IRcGxKRSwS0=;
 b=NCp9+WBG3ihywA2Ghny6qzD03/bSpQiWU7s5sgmr2CuPHI3kCJPPztlxZUJV9Zpyfq
 qh4RA/nyPDXtVcjcLjPhR30LppD46t1fdcie61b3eDJAY+T5Ch07pV1+fEgf+MUflpyD
 IEYD1n2wyUAOCY///CXIhsfZ4uz8FaIhZLMFY+aZzJf8o0by3sIoRtr8cxjYfNVRxo2m
 qzyFbktB8/g0F1n5IF2c4/oyHWGbnB1oXa+hZS13SvHmWKvGoIVTKvD8CFHHAyqYnr5W
 AEdGDndkacfKjdev233kc3ReBEYvl1OjWm0DQlYH6pEzep9bsQfcQirR+Y+lg/gj3VoK
 OKBA==
X-Gm-Message-State: AOJu0Yzf1adwp/bxuZYh++J3gP6tfcFcUqT++dh8FzCB3NsjAw9qfb9b
 EJKAEUKkThOamYNKPGHc3en81cN+oTLsqmq+oXPq5SxG8dplxqZJReIKJhfV9L/RHgAkQw1oMn3
 F
X-Google-Smtp-Source: AGHT+IHUm1WpX4HR0ax2Gg8/g8+ri1KtFKZLjz+cZDhDtvxTUhokJdos8GOZD4DdUAZjm5D6+a85Mg==
X-Received: by 2002:a0d:e657:0:b0:5ff:ab70:843f with SMTP id
 p84-20020a0de657000000b005ffab70843fmr4313348ywe.58.1706032733178; 
 Tue, 23 Jan 2024 09:58:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 p68-20020a819847000000b005ffbee10d14sm2241487ywg.10.2024.01.23.09.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:58:52 -0800 (PST)
Date: Tue, 23 Jan 2024 12:58:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 02/16] xilinx_mbv: Remove empty config header
Message-ID: <20240123175851.GU3652023@bill-the-cat>
References: <20240122223920.3630168-1-trini@konsulko.com>
 <20240122223920.3630168-2-trini@konsulko.com>
 <d6f63f01-5b53-48da-ab50-75bf8f0d83c3@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dHfXl6Sip7sibDoc"
Content-Disposition: inline
In-Reply-To: <d6f63f01-5b53-48da-ab50-75bf8f0d83c3@amd.com>
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


--dHfXl6Sip7sibDoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 08:53:21AM +0100, Michal Simek wrote:
>=20
>=20
> On 1/22/24 23:39, Tom Rini wrote:
> > Now that we support having CONFIG_SYS_CONFIG_NAME be unset to indicate a
> > lack of board.h file, unset this on the xilinx_mbv platforms and remove
> > the otherwise empty file.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Michal Simek <michal.simek@amd.com>
> > ---
> >   board/xilinx/mbv/Kconfig     | 3 ---
> >   board/xilinx/mbv/MAINTAINERS | 1 -
> >   include/configs/xilinx_mbv.h | 6 ------
> >   3 files changed, 10 deletions(-)
> >   delete mode 100644 include/configs/xilinx_mbv.h
> >=20
> > diff --git a/board/xilinx/mbv/Kconfig b/board/xilinx/mbv/Kconfig
> > index 4bc9f72c541b..d2dec397ed6f 100644
> > --- a/board/xilinx/mbv/Kconfig
> > +++ b/board/xilinx/mbv/Kconfig
> > @@ -9,9 +9,6 @@ config SYS_VENDOR
> >   config SYS_CPU
> >   	default "generic"
> > -config SYS_CONFIG_NAME
> > -	default "xilinx_mbv"
> > -
> >   config TEXT_BASE
> >   	default 0x80000000 if !RISCV_SMODE
> >   	default 0x80400000 if RISCV_SMODE && ARCH_RV32I
> > diff --git a/board/xilinx/mbv/MAINTAINERS b/board/xilinx/mbv/MAINTAINERS
> > index 445654fe740e..db9f03388df9 100644
> > --- a/board/xilinx/mbv/MAINTAINERS
> > +++ b/board/xilinx/mbv/MAINTAINERS
> > @@ -4,4 +4,3 @@ S:	Maintained
> >   F:	arch/riscv/dts/xilinx-mbv*
> >   F:	board/xilinx/mbv/
> >   F:	configs/xilinx_mbv*
> > -F:	include/configs/xilinx_mbv.h
> > diff --git a/include/configs/xilinx_mbv.h b/include/configs/xilinx_mbv.h
> > deleted file mode 100644
> > index dba398aeec49..000000000000
> > --- a/include/configs/xilinx_mbv.h
> > +++ /dev/null
> > @@ -1,6 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -/*
> > - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> > - *
> > - * Michal Simek <michal.simek@amd.com>
> > - */
>=20
> Acked-by: Michal Simek <michal.simek@amd.com>
>=20
> But maybe in future we need to revert this patch to add more options ther=
e.
> Or do you plan to remove all of these configs?
> I can imagine distro boot wiring but that can be done via vars file only =
but
> it is not practical.

Do you mean that plain text environment feels impractical for standard
boot (which should be used instead of the pure scripts of distro_boot) ?

--=20
Tom

--dHfXl6Sip7sibDoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWv/lsACgkQFHw5/5Y0
tyxDBQwAiaSBfHKf0WGHDZQto3eKYbIPPTyl2xiLbEVlOUnpe/4v5SKkEDsGaljl
+LLiDzMg4VCsqg6qmmWPBy4nx83pFncezNODXe9GYNJhH0dOJHFq08FyLeTfrzD/
uPPBwU9K8o8DTLXtSJrrB863sKUaAgie3VEpW1jk+SiKlvqWHsAUc4AL24IH3j6p
TFLJob+EoyrmkTzUC5v7dJljBQzaze65BbMKZpd0bW2jWj3chTFM/VIVcpPH8N2B
/Dlm8Scg3Wm+pycob8L/K4VGPkWJHVsEnkkeCwmN4ZWb7I2nT8cJKYZK+h8uW49D
kPoHFETChG+A82saqQjZ4lOIctmJk/3IwqArU+EeXtl6ORgan24wK2EGXmwLo5Bj
FJQCXl2TTORLWW+0BkK9+lu7bRjyTt3loci+XXsT++AV9jsU8tnFDmrYPoif+Kgf
wbnbd09kQkl2Tv/30oZd93i0/qIlJAQLgfIqdVI8kNvV6BTIkohox4gbxbDaiCL4
Gpvmd2a2
=Bac8
-----END PGP SIGNATURE-----

--dHfXl6Sip7sibDoc--
