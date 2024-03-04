Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53414C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9618E88012;
	Mon,  4 Mar 2024 16:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nk9ksucL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE90887FF5; Mon,  4 Mar 2024 16:27:03 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D19B087FF3
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-783045e88a6so360955485a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566019; x=1710170819; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zhhXW2mCjT09zJbUNuqFm0Y7PMbwY3YRLe+V3/B20j8=;
 b=Nk9ksucLNgcvU+CJswHw1Ld9HArPVo+ZBnsZPYCM0u8yCIfA52eOkgv98sn7ZpTRF6
 6HqZ23xXIy0I5oPdDz8lhk5zfbgCt13pBfkVWn9cGApYFz+uQpAhtBUH2mfZAGmd2xUY
 IcybdYDe9CO0zSzkWqYTx/R8lJxjDx6Vr8oso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566019; x=1710170819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhhXW2mCjT09zJbUNuqFm0Y7PMbwY3YRLe+V3/B20j8=;
 b=QAn3CvF9KAnbXj3rC4DsTAfAprNBp9tXlwAYkRO3Py25u8dTEDjwnxAgB6LasKvr66
 PAquN4QzYbJtLegL0W2HGiFoPY7vi5suI0eYBJ6KEpHy5v8um1+ldGSyTpsVGrN+i4v2
 bSrHnphUtv2rt9O8dKgRrTWSkyHbRAivFbEsw9LQTCEOqIUNvdS/VnUMkG1srXE2xhzv
 vP68gpm6czsGnArHcwGno7hTb4BXxyzXo4K7/TEBZxyMCxGz+xG2hPofNVwCqgO18yIf
 wxygXUBT+r+VjX166JVzCXBps1ANPabBYaomWCcsbxP+wCy30xGcKW/lCw9LUl7RhSaX
 UJaw==
X-Gm-Message-State: AOJu0Yy6pt3a/8BpgRPaQOk+eIseVQMiGIv6/XSxOl+0OctpDrKe3o3v
 /WISj3dzxk4Thcr4N4iOUSqSDUC27PQu6Gf7jHd6orRQuZf5RF0rmpS+gzsDJJs=
X-Google-Smtp-Source: AGHT+IEnzv3sddIry0XNEkXM2/BiDei1IxhpU8MBKUDFS5R+ZYk7MjqZr4LD56fy12Pq0nxPwglgtw==
X-Received: by 2002:a05:620a:559c:b0:787:ccb9:78c9 with SMTP id
 vq28-20020a05620a559c00b00787ccb978c9mr10335316qkn.62.1709566019683; 
 Mon, 04 Mar 2024 07:26:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 z17-20020a05620a101100b007876e91f392sm2546730qkj.79.2024.03.04.07.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:26:59 -0800 (PST)
Date: Mon, 4 Mar 2024 10:26:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, ardb@kernel.org, jens.wiklander@linaro.org,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v2] qemu-arm: round down memory to multiple of 2MB for LPAE
Message-ID: <20240304152656.GM1523872@bill-the-cat>
References: <20240201124054.2094572-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VZhuES+cJWxK+dPO"
Content-Disposition: inline
In-Reply-To: <20240201124054.2094572-1-igor.opaniuk@foundries.io>
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


--VZhuES+cJWxK+dPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 01:40:54PM +0100, Igor Opaniuk wrote:

> QEMU's -m option can take fractional megabyte values,
> and lowest granularity seems to be 0x2000.
> For example, run qemu with amount of memory set to 100005k (0x61A9400):
>=20
> $ qemu-system-arm -machine virt -cpu cortex-a15 -m 100005k \
> -bios denx/u-boot.bin -nographic
>=20
> =3D> fdt addr $fdt_addr
> =3D> fdt print /memory@40000000
> memory@40000000 {
>         reg =3D <0x00000000 0x40000000 0x00000000 0x061aa000>;
>         device_type =3D "memory";
> };
>=20
> When LPAE is enabled, 1:1 mapping is created using 2 MB blocks.
> In case amount of memory provided to QEMU is not multiple
> of 2 MB, hang occurs during MMU initialization.
>=20
> How to reproduce:
> qemu-system-arm -machine virt -m 1058 -nographic -bios u-boot.bin - boots
> qemu-system-arm -machine virt -m 1057 -nographic -bios u-boot.bin - hangs
>=20
> DRAM:  1 GiB
> initcall: 60011df8
> initcall: 60011904
> New Stack Pointer is: 80fffe90
> initcall: 60011a20
> initcall: 60011bcc
> initcall: 60011bd4
> initcall: 600119b4
> Relocation Offset is: 22042000
> Relocating to 82042000, new gd at 81001ed0, sp at 80fffe90
> initcall: 60011b8c
> initcall: 82053ea0
> initcall: 82053ea8
> initcall: 60012040 (relocated to 82054040)
> dram_bank_mmu_setup: bank: 0
> - hang here during mmu init -
>=20
> This patches rounds down to the nearest multiple of 2MB when
> CONFIG_ARMV7_LPAE=3Dy.
>=20
> Fixes: 3fa914af82("arm: qemu: implement enable_caches()")
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io

Applied to u-boot/next, thanks!

--=20
Tom

--VZhuES+cJWxK+dPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6EAACgkQFHw5/5Y0
tyywwgv9EbsR/4s01EpfECJxphDzSyn7LEAxnwvnizUnO4keCshJ/H8qfpeIRBK6
3SKYnOgTqVWMhr+7ZQ8gBwUzEPkQZsVO4IL/eM3V90Sv4bYJYBI7yy3W8spvDojr
kj1wIngpMHP92MdHe+ccIVNOYKfU6yNn1Lj7uQGSikKsKKiPSOLMZqAZOxxNb9u6
yZfwEV2wQT/KzZoRq9kVLm+xGVi6AtIFlNlHp7LM7X5dpEoakZsx7yOqqwh2CX/d
xzsEG8BIudYnPyJ5ctaSpIrN8q2Te2YMf6Ci7vndM4t1ZpMiSEWOz+gT/VKwWIi5
Xhdaev661uKgIy/YwkCW4j7JuTrPIKNK8erGhu+M4LqH13KV7jlYXbPs6RbbXLjd
A8f8f4PdwH7pCzYZZKXX5E2/jqjF9uqXFNUUM/NBAWphFWO/mDEu5b/7VqfYKUBQ
pgwxf/v4jUvxD3oYlXt3jDjngADyU4SiezbeCte1V7EHsoktpmRwLFDQ9zAdoRm8
u2vmtrfy
=PziC
-----END PGP SIGNATURE-----

--VZhuES+cJWxK+dPO--
