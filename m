Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746FDC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 19:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7124986D4C;
	Sat, 18 Nov 2023 20:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pnCIqS8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B2186D82; Sat, 18 Nov 2023 20:15:16 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 114C886564
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 20:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5c6705515d8so21593077b3.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 11:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700334911; x=1700939711; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1GIglmwFl9/ejHZpqr/X9ANNxH6ROc9mZyPn5OrVTIQ=;
 b=pnCIqS8v7frJDhgxT9MBKGvPU+n+n04ixpQL9sFg2DdDkfrbCgNCY4Zf7SYy7BfqGQ
 BgSEio2UiLAhyLtjRRQ4rdQpkCMh0frgfzGkLMEG90oCyi4GJqXOftE9zQqR1ibSd3pa
 YrE829A4SU252tj8dptDlyxdR/RVCdZILh3co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700334911; x=1700939711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GIglmwFl9/ejHZpqr/X9ANNxH6ROc9mZyPn5OrVTIQ=;
 b=HyO4swrvbQbJf0tprVimJN3wFk58cJDObi+NwUkp4lmPRjC/E83mBawN2UJRtVegbS
 1M80yGbkGrhXbQsBENeFqdiWPX4koVnV4FJslzVj6PmPUhOrHa11OfyWg77kV8r1E2lz
 9O0KQNPMqjMLgb2GO5zGQSskgpahlpzwqLWwbBd4o2y/kH65o+7cgmIT5N8m9wjm/ac1
 haIlfLxq8mx09TN8h9dZPnGWrO4fU/cdLuADV675hShp8JnD200Hqxd8B3Jb1wUxfBg3
 a35vo2LOK1C6dKiC/2JueJlnBhRBB2gNrGltteesfUNqJZxKHuyCkmC/tpeVyzlUzvpq
 iuXA==
X-Gm-Message-State: AOJu0YwJ2poOZtvztLSV+FsPO94jFALHg1RtJ03I2Mb8ikjDGcTf45Vl
 EZZG4g1gIdwCL2gReF2Q6KNevg==
X-Google-Smtp-Source: AGHT+IFoAX+Dy1FXwffZoW/lI2XbKArZe1B6ogBYbARIxseq6owRyqVuge4LKiFuVLIcQtKCPZospw==
X-Received: by 2002:a0d:e615:0:b0:5c1:25f:5674 with SMTP id
 p21-20020a0de615000000b005c1025f5674mr3506280ywe.32.1700334910734; 
 Sat, 18 Nov 2023 11:15:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a0ddf09000000b005a7a92a62besm1266341ywe.8.2023.11.18.11.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 11:15:10 -0800 (PST)
Date: Sat, 18 Nov 2023 14:15:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH v2] smbios: arm64: Allow table to be written at a fixed
 addr
Message-ID: <20231118191508.GL170968@bill-the-cat>
References: <CAPnjgZ2ZFSbUYPVq+A1jQBy8s=DOO8Cz+epHGL++KSEN-pr-wA@mail.gmail.com>
 <32facf81-f2bf-460a-9104-cae1dcef0cbe@gmx.de>
 <CAPnjgZ20bRUP7KFwRpe7dmbxbQFMJmHB55dkXpEjv3fyX++M3A@mail.gmail.com>
 <CAPnjgZ1Ao_ikgwPR8-fGVzbBfzRQYm0bxz9LgVHs1FP7+HG3cw@mail.gmail.com>
 <CC91949C-3BBF-452B-906F-93520A314858@gmx.de>
 <CAPnjgZ0sgCtPXa5ZOOpW-zyCnVm_cNU3OyDjzPercdY1=Y1_dQ@mail.gmail.com>
 <20231103192548.GR496310@bill-the-cat>
 <CAPnjgZ1QhQ0Kx7S8nof4Hs6cX9b+tKyMOyzg2dod-WvjOkoMTg@mail.gmail.com>
 <20231103201341.GU496310@bill-the-cat>
 <CAPnjgZ2LnT=esHGNRf0RNCPaf1BNhzA+QxWcQbjnBfy9B3QUuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PryLUHkmL3V8PfKl"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2LnT=esHGNRf0RNCPaf1BNhzA+QxWcQbjnBfy9B3QUuQ@mail.gmail.com>
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


--PryLUHkmL3V8PfKl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Splitting things in two again..

On Sat, Nov 18, 2023 at 10:10:17AM -0700, Simon Glass wrote:

[snip]
> This is the bug report of trying to boot into U-Boot on arm64 with
> more than 3GB of memory.

OK, so can we just please fix this, for v2024.01, in a way that won't
make things harder? Fixed memory addresses aren't the right choice. We
need to have the discussion about memory allocation/reservation
elsewhere, outside of this patch, to have something that works for
everyones use-cases. And possibly a similar discussion about when data
structures get populated/updated.

--=20
Tom

--PryLUHkmL3V8PfKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVZDTgACgkQFHw5/5Y0
tyyDRQv/a3dx22lI7Ce+iOrUpkVm87T8MP1Ig2wGQiq6ULIiiok/iGjsrTDfqFw7
JOF6HrDfvhVreDCbw1s1gF2fdnZeGaBpgVUpi6PUXUCqi/XtBtLPO+lJwBe9PZia
SJ7vku/fUUaXjc++VtUVvbinBG6cOHaZ9TJVSHs0J+pqJ6Mby7Q9dE1ukNVsPdvi
XN4HoxYD8n+/cTZjYEtl/+NpCTgaFB/klJRSBG1C1gdXgAU/MlpFiZWNXEnEYF2S
LVoCKzoBXV08ZudRWFsqBKHcKIBIR5uN/gC+W7JDiq/eQcV+N64tfb19BLzPQEeG
K8idxUsOXkWPCMiwAlhhvAMRV9tPST1bXSfvSKkp9tiP/QImzgCaJr8TiGzA6OOA
hhk7Fdio0O0YUh1bs9TbGI/DE5omlwGUFtkhyTOT1zvDB8lw5TSvOeexgnMOk3I0
2f+/6e3jl4hUq3EVlV+hKPJyGWlyahOKLrthusUdYxwvJd4fgvGKE2fcA4qWvqtO
Kp8XBzi1
=szfr
-----END PGP SIGNATURE-----

--PryLUHkmL3V8PfKl--
