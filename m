Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C93C25B4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 23:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109EB88302;
	Thu,  9 May 2024 01:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ss31O3iq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E2E882AE; Thu,  9 May 2024 01:17:43 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB03F882A8
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 01:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-792b8efed93so24308585a.3
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715210260; x=1715815060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KKJbKvJRKfaHt9hre+Q3SZTbE2R2Ra4kKM3LcbmqL7s=;
 b=Ss31O3iqnqz1yH23NBSOZd/yZa/96ah3v5kYn0E0yC6P761KSqgq+42gxRFFwfFnQL
 9zjSoWALzf7k9g3J8DMwSA5jHGSQwCFr1oJBAwZV7KSrLnbsSG/Ra49ftp3tjN9JwvQA
 OaEm7EqwSDknCZyZb6IVL5YzA+RO/wHWu2nu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715210260; x=1715815060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKJbKvJRKfaHt9hre+Q3SZTbE2R2Ra4kKM3LcbmqL7s=;
 b=CnuRUTjbYGh7Caqg7WrT2+S1ECF1sxN5ewOlStS5k6W6//0D0EizgGOBzncem1ybFv
 mk2DfBSr2cr17ZAgFXgJ66WjA/9nfAFKJgwW5vyBOWyauLts9Kc2SThdOkIGrbDktOc/
 DSwgIJ1IGI29ujwV7prx/K23hcuI/SLllnOZjy57PERcnLMx4WkLeqkqZ0BfB54YiW48
 kDkXD18DGNrVHdL9GmWA1FRHQ8USpAFj3HoRTrWHULgVndxy+/zhRVDABMVGfehq+Zvb
 B+NGPN3syFzp6TXo4IgGCzzZ5MI4oGhVn23/ETNqX5FgV9/Vikcj4VBSm4Wc+nJoBFPF
 Slbw==
X-Gm-Message-State: AOJu0YxQNycUDwGaG9lne9PfU5kM6G0xOQ12q3qgbZYWxTiyI58qYM0p
 RzKt1eHAdrY8cB/98RKM32iu/68wrImsqwKlc/lQmYFwUbG0mbpnUz9CLww+Y4Q=
X-Google-Smtp-Source: AGHT+IEgWw/MKkWnXcJ1pXZI0XiJ3McVA8lXsoldYAR+Wmw5+fD6JV26zoJ6Gaw0mYyttvHJGifVqw==
X-Received: by 2002:a05:620a:1119:b0:78d:6182:fa35 with SMTP id
 af79cd13be357-792b2863ef5mr401714285a.53.1715210260661; 
 Wed, 08 May 2024 16:17:40 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2777fesm3120785a.11.2024.05.08.16.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 16:17:40 -0700 (PDT)
Date: Wed, 8 May 2024 17:17:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@intel.com>
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>
Subject: Re: [PATCH v1 1/1] net: Add drivers for Sysnopsys Ethernet 10G device
Message-ID: <20240508231736.GE2568172@bill-the-cat>
References: <20240417074656.5417-1-boon.khai.ng@intel.com>
 <20240417074656.5417-2-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1U8X1QfH9K3ID+p0"
Content-Disposition: inline
In-Reply-To: <20240417074656.5417-2-boon.khai.ng@intel.com>
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


--1U8X1QfH9K3ID+p0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 03:46:56PM +0800, Boon Khai Ng wrote:

> This driver support the Synopsys Designware Ethernet 10G
> IP block refer from the driver dwc_eth_qos.
>=20
> The driver MAC register mapping is different between
> Synopsys QoS IP and Synopsys 10G IP, and thus new file
> is created meant for Sysnopsys 10G IP.
>=20
> The dwc_eth_xgmac_socfpga.c is specific to a device family,
> the driver support the specific configuration used in
> Intel SoC FPGA Agilex5.
>=20
> This driver is extensible for other device family to use.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>

Applied to u-boot/next, thanks!

--=20
Tom

--1U8X1QfH9K3ID+p0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY8CAwACgkQFHw5/5Y0
tyyAMwv9GEPSSX3dYx/XgJI6z+3ML1FIYWFETBR7uc4dS3mXGB8BxkOq2eR/eQSA
OlamPu6dTur+4vlrPZhzNQUxLdC53VE8rbS/y1o7/LM5p/kbcZH+CvSeiL5qHqCW
pxDbdZehoxiyaaw/VVsUhGBNGKW7PotStHzJBx3Wr+RsekHdI1KjocbpLo8Nzvfx
IHXEHWNwlibm80r+YPkBrzxw5mcImh0IzbZhHObHSvBAkv6Bdz/ylfypd6b4vqXl
WJaK7t4UGPNKhlmN5NourxKuOzwmxJJbP+GtCO7g2Ty58S0rXlZqisMaOjMIoXi0
waYx2s3vi4wmryfNnJrM2l0RgaSeP9mkYA+LCjcRl/YG+aNRrupH//7ES266jIuV
zKAJr+AS+R58grxBPl/uZsjqTXU0ElcuEafa3x4isSHZRDlP7LrFOWBusa+0yP7w
VFRGs1pI3ZpFtspwIDicwgn5ZnGonOxEpZgKgneldyjw9jWGfj2dDKR6rTwrR1Lf
z2Exzdzy
=8vE2
-----END PGP SIGNATURE-----

--1U8X1QfH9K3ID+p0--
