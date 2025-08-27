Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542E3CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40E7831C6;
	Wed, 27 Aug 2025 16:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fk8Gqy0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FDE2831C6; Wed, 27 Aug 2025 16:32:26 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BF8B83214
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 16:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7452b3a0b31so784117a34.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756305142; x=1756909942; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LssNDlbaILFNWI9m2GDRT1zk1QY/0gn8MNy91OlcHjs=;
 b=Fk8Gqy0Gd37LBrFEUxR2/fZTcyztsh/QbtkwEhPNFPcklzdSRCFUz2z8kUl6rQ2JWO
 GftI3Rvjw7mqZ0+G/fdi4P2Wl1r8ilRLe+RcZeTxCZi/+cTBPYQ2mBcIGvgUPXNnISR4
 o6szYIfX5MPJ6JxsrObNmj++guvo3QAr+tzyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756305142; x=1756909942;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LssNDlbaILFNWI9m2GDRT1zk1QY/0gn8MNy91OlcHjs=;
 b=V1FTRuJSl/pW0Ze25gxFsqDas0PTIi+B8ohWQZ975GjrHPIoGE43MfEI9QX3FIwpDZ
 nosSw1TqcDWgj9+t4ZHAHumuEM8/tANm4TfwT+9zShPzkTYkfv4gmEq2Zz0LwMhSWeRu
 ZzDzMp+eNEM5G+HT3+H8bLhk9pnzuUjClYXQcMD0AisMlwe/6dBXm8PC2Vnk63sEMChp
 QQjOfg3lPoz9vOMui5iWhj7pIY++78jey4hQOCNl3bXG6KZpYvNVTOzz37fUsKqMIoNG
 NqgMRS/k/2UkMuPrcjD0qV+6BE6rEe98gB2PvuisTvRpcuv2zMjSAmb2pUjcXFhEsRMU
 DGzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6eHbPhQxnNSbfiutbBHf1ppkWVw3T30pFVfUWTiI8gurqKUDkep6zOZsjRrWoN1ORcXX4/i0=@lists.denx.de
X-Gm-Message-State: AOJu0YzfyUUnScDvIkjW4Y97Xa6PDduaucq5eyyOdhfB4GHtXJurowVa
 FQp43dRnEqtahzT7A1bDYteA362MmCxht6HeWCh6WFv/o9lQrN0wV7otu18LEEuTHmw=
X-Gm-Gg: ASbGncs/i5ZOVmScQX46rwQuPDc0ISlOYfggvaiCd3yi4KAv/GJVwU+uDGHsvWnobv3
 W8y9ZH3WwX/GJZsadHuk/4kS3XLZEc09g74GTIcIn8G0NkDVJc4xNZ63U/CK/uytWQIuUaLmA8f
 F5uua5iUj8Jw3eXnCK43pDPLOzcBMhD5NoyGU/ISTvEbSNhHQ1Rp1nEdD7ujw3rUlt7L26UN+Xz
 Og1UeZPUiJaAUdQPyashhaIykymCIwRcxzNXkQtaif8/5lXcttkJpWSGSLeWGeLmbsr2MFem/WF
 HL2XuMLgNQD/c0EZulIlmyat3anMhluYGyaPSGb2Tcd3deMJRvbmoMwfSZV/F1PC3RVjgbYQ0dd
 qEyVl7vEIHqurMAmDZFFkxe6wpq/x5gxuMrYD/JAMest+P1Ctl+/z+G33
X-Google-Smtp-Source: AGHT+IGhZmcr9RZduY1aW5Xs9nz6PV70ztuQJknQ1rKIL/f+PZF949RL3Q4oxx6VShxMuG71SafnBg==
X-Received: by 2002:a05:6830:b91:b0:741:dffb:13fa with SMTP id
 46e09a7af769-74500a515a6mr10109924a34.21.1756305142212; 
 Wed, 27 Aug 2025 07:32:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e49d363sm2993224a34.37.2025.08.27.07.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:32:21 -0700 (PDT)
Date: Wed, 27 Aug 2025 08:32:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Joy Zou <joy.zou@nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Frieder Schrempf <frieder@fris.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
Subject: Re: [PATCH 0/6] Use correct LDO5 control registers for PCA9450
Message-ID: <20250827143218.GH124814@bill-the-cat>
References: <20250811131213.211124-1-frieder@fris.de>
 <42ae44e8-b368-44a9-a828-578c77d4d15c@kontron.de>
 <PAXPR04MB84595561F74B01EEA36C020C8838A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ffe365e5-2d0f-415e-a084-1926e3d4b2a8@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SRpBRIXCTJ7Rf5Hj"
Content-Disposition: inline
In-Reply-To: <ffe365e5-2d0f-415e-a084-1926e3d4b2a8@kontron.de>
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


--SRpBRIXCTJ7Rf5Hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 09:37:24AM +0200, Frieder Schrempf wrote:
> Am 27.08.25 um 07:46 schrieb Peng Fan:
> >> Subject: Re: [PATCH 0/6] Use correct LDO5 control registers for
> >> PCA9450
> >>
> >> Hi Jaehoon,
> >>
> >> Am 11.08.25 um 15:11 schrieb Frieder Schrempf:
> >>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>>
> >>> This is a port for the following series in Linux, which is already
> >>> available in mainline:
> >>>
> >>>
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> >> patc
> >>> hwork.kernel.org%2Fproject%2Flinux-arm-
> >> kernel%2Fcover%2F20241218152842
> >>> .97483-1-
> >> frieder%40fris.de%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C51
> >> 6d
> >>>
> >> 65c0706c4d71292d08dde3b31d9d%7C686ea1d3bc2b4c6fa92cd99c5c
> >> 301635%7C0%7C
> >>>
> >> 0%7C638917080648452454%7CUnknown%7CTWFpbGZsb3d8eyJFbXB
> >> 0eU1hcGkiOnRydWU
> >>>
> >> sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%
> >> 3D%3D%
> >>>
> >> 7C0%7C%7C%7C&sdata=3DneJx6WZU4iZWjSUcsnzOVQvFiaCTKLChE8srEx
> >> 6cwEQ%3D&rese
> >>> rved=3D0
> >>>
> >>> This aligns the PMIC driver with current Linux and allows to use
> >>> upstream devicetrees in U-Boot.
> >>>
> >>> Frieder Schrempf (6):
> >>>   Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
> >>>   pmic: pca9450: Fix enable register for LDO5
> >>>   pmic: pca9450: Fix control register for LDO5
> >>>   pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
> >>>   arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated sd-
> >> vsel-gpios
> >>>   arm: dts: imx8mp-dhcom-som: Remove deprecated sd-vsel-gpios
> >>>
> >>>  arch/arm/dts/imx8mp-data-modul-edm-sbc.dts |  1 -
> >>>  arch/arm/dts/imx8mp-dhcom-som.dtsi         |  1 -
> >>>  drivers/power/pmic/pca9450.c               | 22 -------------
> >>>  drivers/power/regulator/pca9450.c          | 37
> >> ++++++++++++++++++++--
> >>>  4 files changed, 34 insertions(+), 27 deletions(-)
> >>>
> >>
> >> I saw that there are several patches on the mailing list for
> >> /drivers/power that have received no reply from a maintainer for
> >> several weeks (see [1]). I just wanted to make sure that you are aware
> >> of this and kindly ask to have a look.
> >=20
> > I could help handle that via mmc tree, if Tom and you are ok.
>=20
> I don't mind. If Tom agrees to take power patches through the mmc tree
> from you that's fine.

This would be helpful, thanks!

--=20
Tom

--SRpBRIXCTJ7Rf5Hj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK8W8QAKCRAr4qD1Cr/k
CjfcAP9o1QI6+3L6O3eag9L1Dh2uE3kTLXAfk5Ce6zYmT9/LsQD+K2RIMajsgcRN
XrRA6juDUd/56G1LH4++VnpmyTru/AQ=
=cUYi
-----END PGP SIGNATURE-----

--SRpBRIXCTJ7Rf5Hj--
