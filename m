Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF19C25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 15:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34152883AE;
	Fri, 17 May 2024 17:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GwPmCkxm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3B1880EED; Fri, 17 May 2024 17:15:55 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A055883E6
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-792b8bf806fso57354085a.0
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715958951; x=1716563751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tuvLkOG2EHVx/O1KeeYRNFWzwQ/nUdNZzSWVpopbejk=;
 b=GwPmCkxmM4AKhOA6iXXwBuZVJgRcK9JJmZslOPJpgsD9c+EiC8mpaPKU7A6W2qrdjf
 wTX60bGPKRa52B5nEdxx8cCtl8N1xMfnApF6cUgGyBm7ZAzNIpZ27KOo1pFL66DGJp5r
 U0PcmeI/ZfqcR4tH6YeCckonnoJFf3Ke4a4AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715958951; x=1716563751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tuvLkOG2EHVx/O1KeeYRNFWzwQ/nUdNZzSWVpopbejk=;
 b=XkiUtKQSV6mPhXgFxa66c16UoYPR2X2WryYaKRP0VttM9R/sGM5XKOeogd37NAGhz/
 6h08Q7N+SmWPAz3ZqBQlxpvC8WIzP+3koRJ7MBJMaYkTl45BtHa6QBQACb4lKpMpqiaP
 qJeYyNrFHPZLGkgr+YYE/65+AAGCihZ6BKdMjGZ40VO2B0YihpDF5u1ZU/2RdaLoVQsI
 IewO2/BvfA5924QZo15ykyWtNTH21QIn3Ywi5zYj7fPiZCYXg+K070YwxRfBTTXtC9ex
 AHpoz7PVCFeQDhRFXZLYW300jTXcJQGjArFAPKSd92vSBgbYYlvKZ8rYLuKM5sIueMI0
 GRUw==
X-Gm-Message-State: AOJu0YwtTQzKhrgrKGb+L4WoqI0hui1xfPWZ5OW8plaZxRIMYkZKUHww
 eyNJ0BIkXOk9zd+hwTU1pOjeZobIEuBaKjwCBsIv7uGMKsnr6cCJdn7wgwHx4dE=
X-Google-Smtp-Source: AGHT+IGKhihXaIw61Fcpjh/HWAcePDjQPiCX8l7nUnQM/KUlgJ2Pkm8Ta87IHwbhdZrl4F21OYiPKQ==
X-Received: by 2002:a05:620a:27d0:b0:792:c5d1:1d99 with SMTP id
 af79cd13be357-792c759aeabmr2953510785a.28.1715958950837; 
 Fri, 17 May 2024 08:15:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27fa04sm906304285a.41.2024.05.17.08.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 08:15:50 -0700 (PDT)
Date: Fri, 17 May 2024 09:15:46 -0600
From: Tom Rini <trini@konsulko.com>
To: tingting.meng@intel.com
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: Re: [Agilex7 M-series Platform Enablement v1 16/16] configs: Add
 defconfig for Agilex7 M-series
Message-ID: <20240517151546.GJ2568172@bill-the-cat>
References: <20240517052701.12949-1-tingting.meng@intel.com>
 <20240517052701.12949-17-tingting.meng@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VBLOz82qGKTjJ7jI"
Content-Disposition: inline
In-Reply-To: <20240517052701.12949-17-tingting.meng@intel.com>
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


--VBLOz82qGKTjJ7jI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 01:27:01PM +0800, tingting.meng@intel.com wrote:
> From: Wan Yee Lau <wan.yee.lau@intel.com>
>=20
> Add defconfig for Agilex7 M-series.
>=20
> Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
> Signed-off-by: Teik Heng Chong <teik.heng.chong@intel.com>
> Signed-off-by: Tingting Meng <tingting.meng@intel.com>
> ---
>  ...onfig =3D> socfpga_agilex7m_sdmmc_defconfig} | 110 +++++++++---------
>  1 file changed, 54 insertions(+), 56 deletions(-)
>  copy configs/{socfpga_agilex5_defconfig =3D> socfpga_agilex7m_sdmmc_defc=
onfig} (56%)

You need to put this in a MAINTAINERS file.

--=20
Tom

--VBLOz82qGKTjJ7jI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZHdKIACgkQFHw5/5Y0
tywEngv+OUTQby0NJtbgMN8y+Um6SZ73XihQK4iDrOg9jEsSPWFOPd+oZ3i7/sWI
yUEXGIXRLt9TIbN3Lz+fPKGnvOoHboLNkg9Lrb0R/DhHuLs5yVS1IVAAlN8oYTnX
7baa0IrUBOpHaiP12RiE1VNsGMf7s0npAn0KIA6KFozpVUzKgNPFlqWrn6madsUa
8PDXCZlfVw0LfKdNB+JjfRCQa6C4Fsj8YgM0Ds4lDDUGVn26gjBKlsnpOcstm9Uy
bPXaGwZsLfG6hEt/jm1+AkI3IqbEzXwmoHUkdIhqfPUrnXrcasbqzZQER2lXIKse
Jl4qJg+ZhM1PxU4kkiY/kJxWFhx8nJAMo+9qJsZWNVUnfci2x1lPmz2h0GVI7Btb
tQWn5HZMt5B6LdEk9ta6TjCFa8q51i0Pc3itfo8E+BgL3p1bXHBspeZoFq8lOWZa
Ge3urjq2ZIeF3pyZxjYJrlmp/3Pa+jcBzH1QWo/2E0TxTtNpCdMD3IwkJn5fqljm
HhfsgBQC
=T8uR
-----END PGP SIGNATURE-----

--VBLOz82qGKTjJ7jI--
