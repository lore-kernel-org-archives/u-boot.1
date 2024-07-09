Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B8EC3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 14:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE848862E;
	Tue,  9 Jul 2024 16:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mn+5fefp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C2D88633; Tue,  9 Jul 2024 16:37:19 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917EE885FA
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 16:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-25982aa59efso2526038fac.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 07:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720535835; x=1721140635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x+1Lpd2YhKBRBbJVrTF/VChRSVrLZoHRnlHy7ejocMw=;
 b=mn+5fefpguIcubcooKz6turaej3IJekiY3Gq1HLwZ8WCHugUdZXk9b9Vh3QwVcYWMe
 OBguHDThtOC+dVnAhbp+450YYHSts0RBBv2sutq2L8UwNmgfPdR+2xrAL05EPRU+YT6+
 UdSoQW79plJvXknggJ2BL80QXN6J64245zMWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720535835; x=1721140635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+1Lpd2YhKBRBbJVrTF/VChRSVrLZoHRnlHy7ejocMw=;
 b=sxnhOSF3L3SkD9TL8VDg9RVoGv5lwvtGoFowtf086FjfL6/BTZyUEoqagtnUjhkJ6w
 HLG/7zV9fkJCK0ivebn5P3YRQmOh+RfqaDoZ/4tspdOEYpZkU5Rg1zx3i0V9kCozjznm
 x9ah93C7RnljR/lezqwq4TONhCYlZLJGYzDqxETG2pFGIc5jsDYS3zH/ffgvAs0Djh9L
 WqrPE4Bldys7+Qj2Tjj4qNHuEh1RY+tGCYUU9y3Rcbr2pPHFfBsQBGRLEWlRxT1J24FP
 9JhIHxP1uA8hM9rJpif2noIhQcyjOlPl23W2hU0WdCCdZNPnsjBoBXIVpbJhuD8hWpma
 Oumg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoG3h5QebosQsvVD+nx4mASA5TjxcEkJUnbbSKqUU/H4M8Q9ShwzVy/2fcXy9jS0sRU2Rcryg7bYO4u+OvpUQNMN07mA==
X-Gm-Message-State: AOJu0YwTL1B6Wo9g+Z1dZa4UOtxtg3voB1HuLaeGbcgO2V2UxjW9cclX
 A/TxD8aRtPa/jJ6uY2kzpgqIPsjO1xC9nWKuPcy7KS1UE5JCzzYH+buVDUladtc=
X-Google-Smtp-Source: AGHT+IHATtkUc1qhUJciF7HVsUG9AnuSvN2vumzmcl336sYa1MICVqH7ADoFIbpjTjyuPQk66eZcmQ==
X-Received: by 2002:a05:6871:6e8b:b0:254:9182:180b with SMTP id
 586e51a60fabf-25eae878683mr1442860fac.29.1720535835237; 
 Tue, 09 Jul 2024 07:37:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa0783dbsm639608fac.32.2024.07.09.07.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 07:37:14 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:37:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Sjoerd Simons <sjoerd@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Nishanth Menon <nm@ti.com>,
 srk@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 07/10] configs: am62: Add configs for enabling ETHBOOT
 in R5SPL
Message-ID: <20240709143710.GM38804@bill-the-cat>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-8-c-vankar@ti.com>
 <20240705153721.GF38804@bill-the-cat>
 <e6b94491-f186-42f8-ba54-11651811db31@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KTYMweHu6xnH6PD0"
Content-Disposition: inline
In-Reply-To: <e6b94491-f186-42f8-ba54-11651811db31@ti.com>
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


--KTYMweHu6xnH6PD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 12:29:15PM +0530, Chintan Vankar wrote:
>=20
>=20
> On 05/07/24 21:07, Tom Rini wrote:
> > On Fri, Jul 05, 2024 at 10:20:27AM +0530, Chintan Vankar wrote:
> >=20
> > > From: Kishon Vijay Abraham I <kishon@ti.com>
> > >=20
> > > Add configs for enabling ETHBOOT in R5SPL.
> > >=20
> > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> > > ---
> > >=20
> > > Link to v2:
> > > https://lore.kernel.org/r/20240425120822.2048012-8-c-vankar@ti.com/
> > >=20
> > > Changes from v2 to v3:
> > > - No changes.
> > >=20
> > >   configs/am62x_evm_r5_ethboot_defconfig | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > >   create mode 100644 configs/am62x_evm_r5_ethboot_defconfig
> > >=20
> > > diff --git a/configs/am62x_evm_r5_ethboot_defconfig b/configs/am62x_e=
vm_r5_ethboot_defconfig
> > > new file mode 100644
> > > index 0000000000..7b1932b215
> > > --- /dev/null
> > > +++ b/configs/am62x_evm_r5_ethboot_defconfig
> > > @@ -0,0 +1,20 @@
> > > +#include<configs/am62x_evm_r5_defconfig>
> > > +
> > > +CONFIG_SPL_GPIO=3Dy
> >=20
> > You need a few other options set in order for buildman to work in this
> > case, please look at the other #include users.
> >=20
>=20
> Are you referring to include "configs/k3_efi_capsule.config" ?

No, I'm referring to:
$ grep -l '#include' configs
configs/am62px_evm_a53_defconfig
configs/am62x_beagleplay_a53_defconfig
configs/am62x_evm_a53_defconfig
configs/am62x_lpsk_a53_defconfig
configs/am62x_lpsk_r5_defconfig
configs/am64x_evm_a53_defconfig
configs/am68_sk_a72_defconfig
configs/am68_sk_r5_defconfig
configs/am69_sk_a72_defconfig
configs/am69_sk_r5_defconfig
configs/j721e_beagleboneai64_a72_defconfig
configs/j721e_evm_a72_defconfig
configs/j721e_sk_a72_defconfig
configs/j721e_sk_r5_defconfig
configs/j784s4_evm_a72_defconfig

--=20
Tom

--KTYMweHu6xnH6PD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaNSxIACgkQFHw5/5Y0
tyxEWQwAgBhZVukAqMpZlhimLaaPHP7VZB57+5T1h2ECdyM5wixq4CBQEwnrLU3a
4EDwbmErrHOf3C57oCtn8UcS4Ro2xYnqk00eURJMSE5uPHbzonICCU9CuPDR/Q3p
8Sj7ZBDZVWPWrMUD9NLDGsGd02wfTMv203C4854X/mnISBasIBXjW+FWxapXZgcv
1CiGCVShrvhf31vC+1ecGHlUpJ+W9Xov7fLr7muz9U8ZCpBViDFq+l1N/YgPxUTb
NTyzWyWFftiZ95PL3Hng6eM23LhRE9OPgUwGHb8l+MZTiteJaiGJxb0tJIRERLdF
MXb/jnFsMp1BfJyVj1lfkWL+/UmnzMdi7rlW25stUrEXdc1D3a/tpeOuZeK7oNJd
cxr0Fi2lidYq5t6Fs99x7g3+woipbjVZ1onzkP1PBKTKc5Vt53Q2ijMi0WKK8p3b
QJHkqE86GTDNIUs8QVe9XV2u6HQlNF0ksndrdzoGGDVdgxrokqGfyBpO8J6hbYtW
/d1OjgJn
=7qDa
-----END PGP SIGNATURE-----

--KTYMweHu6xnH6PD0--
