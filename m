Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4117CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 17:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB07E8399D;
	Thu, 14 Aug 2025 19:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VcBZ/PHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE5AB839D7; Thu, 14 Aug 2025 19:50:47 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C310183980
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 19:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cce90227aso508051fac.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755193844; x=1755798644; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mALW2RQO13r5w09QFKQBK8swxpd+TnN08Xl/45rUwbc=;
 b=VcBZ/PHuWXBCXGUy0EQiQq8Vc5Eo0ECPDawtMETj0DxTG9U+wU6gMubb0puGulCsQd
 WdL5s2fYm+jBJSqgP0RLIBERTm+NzlpOANy0CWxcVxK47dEFtegxZY0Ma6x0xtNK5X+U
 KAYMNgLsu9nckUPeZzSum577/LnJpBaPVmMbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755193844; x=1755798644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mALW2RQO13r5w09QFKQBK8swxpd+TnN08Xl/45rUwbc=;
 b=uPqEZRojINljITyOyrYghxlh3pgQ+VfghQfKlTuNXMhQZWwQQ9FXeiYv41THAY7F/a
 KLT5omvJkrlfERBKSU7PH3tvAxhKe9WaCPNtjoztWS1OFS0QVC7u/sV5f3HGGv/54Wp7
 yHu8CbCPaVZ6jSM94QhsrBC9tw0oR99UZamogB16pVJrC1ji/E3gtnCVgynX9crGRRu4
 /8y86NavkoivOVN17sqgZzLaqPSRA7z1vXs/317XkZWJ6Vsq1+pHL78E81nXO6pwxqgg
 iSMIKRZdqY16siKDsQcLpEB0tNYD/0LrkfUbbhv4XfNKsSxxKPfkwpm02uxU6E25XtjK
 dEIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8W+RisEtu0I1HXVVx0SfgCmlgUUgP/hodnVnSmNYmn8pWzAk0APn3c/OxpzDlzNzqA4OSEk4=@lists.denx.de
X-Gm-Message-State: AOJu0YxX9y8Wx8VOqmY+oGNtnMU/IDRYSm/rUF3eVBbBrCWUrIkFif5q
 +xuUIJjAVjnAc3+ePUVDVwQr4XPAoJTxuiRXcJr5xnFBXyPnmYRbjmkvTtPRlkMTNMI=
X-Gm-Gg: ASbGncvp4Br5P3ikV0GTXiMx8ixFPXD9VCCoJL5qwRarGtA3iAXKj7YMKM2NI7NE5BX
 dFtvgOBETQmdLr+aMH7b0EYXW1F2OStT2uSu1c7S/APGUQ9K0G6bxQaqDciTbX/dnOHf6Go2mXQ
 a2TnN7Gw05D/ohS0zkOsJ7NVG5hMYJVwG0myxMOKuL8feXWUIqAH15mG20zwWyLFCwrwb5yB69y
 Ns8++RGzOv12RNgzwZRolwvyBkJfELq+CiayzxUcRe2zXmq/Nov0MqRBPoTUxL0WxtxZYOwS0PD
 URkBQ0sfPmoCgXU+K9AvUBU7jsOjhTS1fYfFo4SzNgzjt19ww6De/59pOPbpreu3J7w/gfUCmtI
 vvfIN8Le+nOFWtD78aqIFGxtlO0QzCBT5JO+yBVLQe6yg2TTnFEw9OjbO
X-Google-Smtp-Source: AGHT+IFUtA14HIEdGNwRWIvzwL/3zVLOjsGjlxMc65YW0yl86XTqFuNeNFmuH+sfzfW0Rr5Iugc5Og==
X-Received: by 2002:a05:6870:414c:b0:2d5:1232:b081 with SMTP id
 586e51a60fabf-30cd1338d4dmr3077297fac.29.1755193844350; 
 Thu, 14 Aug 2025 10:50:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50ae9bd3286sm4543209173.64.2025.08.14.10.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 10:50:43 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:50:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, jan.kiszka@siemens.com, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH 2/2] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
Message-ID: <20250814175041.GN124814@bill-the-cat>
References: <20250814165932.1584854-1-festevam@gmail.com>
 <20250814165932.1584854-2-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9UedeaE/Cs/IxhS3"
Content-Disposition: inline
In-Reply-To: <20250814165932.1584854-2-festevam@gmail.com>
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


--9UedeaE/Cs/IxhS3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 01:59:32PM -0300, Fabio Estevam wrote:

> Select CONFIG_SYS_EARLY_PCI_INIT so that eMMC emulation can
> work.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  configs/qemu_arm_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> index d5890bf87fb3..db60f7de6da9 100644
> --- a/configs/qemu_arm_defconfig
> +++ b/configs/qemu_arm_defconfig
> @@ -28,6 +28,7 @@ CONFIG_USE_PREBOOT=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
>  # CONFIG_BOARD_INIT is not set
> +CONFIG_SYS_EARLY_PCI_INIT=3Dy
>  CONFIG_PCI_INIT_R=3Dy
>  CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
>  CONFIG_CMD_NVEDIT_EFI=3Dy

I thought Jan was doing this on arm64? But we should probably imply it
under BOARD_SPECIFIC_OPTIONS in board/emulation/qemu-arm/Kconfig.

--=20
Tom

--9UedeaE/Cs/IxhS3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ4h7QAKCRAr4qD1Cr/k
ClPBAP49fhevrU/yTGf4kIhOtbifS7DktEGK8Xe17vgGoNO28QD/YyCLE7HyXK1q
jtQuXWe5lzgHNHGmFBfCKxpksr4Q7A4=
=sXTO
-----END PGP SIGNATURE-----

--9UedeaE/Cs/IxhS3--
