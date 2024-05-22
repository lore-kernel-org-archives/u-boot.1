Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB1EC25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 09:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0D887E96;
	Wed, 22 May 2024 11:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="dGJE0wSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4556D87ED1; Wed, 22 May 2024 11:44:20 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6851387E83
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 11:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1716371052; x=1716975852; i=marcel@ziswiler.com;
 bh=G/ZK/Yazsd27hd+HEzJyQW4zl9Odp1DSFMRnT26cuaA=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dGJE0wSaJSOHf/7xy7pB1CUYheTb3/NrsPbndC2sMSdtZ5ONS5psUAPJE6hamclp
 7bkaXb9lraz4W3+md1OJ1xPHj0dSqRMW43hE9CSYenumHsdJ6upim3MIykgrP8J3l
 wNW666uoKrB6pMoSmu+reAvH/HRYweFtan7K+TbDFf5z3Lx6whz5P5Ci9gfGz90pu
 MvpxWwaUYFhnlsY7O4z9BNVtAma88luV0IYP+zllqlopz1R8s9HPoYWN+25KKK41F
 1z7eINBmktfMwPtwNoasmvkReEGV7OKOIroRSpYAf9+ol7raQouqGwpunjMj8Pz9N
 r2/z+pFX/Ln6WZdsQQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.107] ([178.39.203.75]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MILw8-1sLlCS1cyS-00EL3m; 
 Wed, 22 May 2024 11:44:12 +0200
Message-ID: <c2a6c91f87286f815289cccb1b92f9288d61728e.camel@ziswiler.com>
Subject: Re: [PATCH] board: toradex: change maintainer to Francesco
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Francesco Dolcini <francesco@dolcini.it>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Date: Wed, 22 May 2024 11:44:07 +0200
In-Reply-To: <20240522082848.21536-1-francesco@dolcini.it>
References: <20240522082848.21536-1-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:DhMgnmUwXgu6ksZmRjRfqETjOpgozKbxGGvQA118n7VS8Yuaibf
 QHnkvPIr989rIeGeXXL0Txf4fHzPGJjYHFDYjq3gZEZHdYeOULA3sF5XbrXn8elYK1B4Xa4
 yC4Um0i1XPIiloibvI1TPfPOTDl0CBU2ZqNw5zJ99eyB7cQOUXSwKzKaJDmOBOoljlFVBr9
 YnjDyJQFj/QM6P/nnlcGA==
UI-OutboundReport: notjunk:1;M01:P0:z9dIhnLjKkc=;nVJqX//f/0uPH/ZeR+L1Xs8gnLh
 i+vh0yye1EapBA9ijbtbuDb8LB23bJYYcOGiucpWu1jwdbypeLHU7ZDMmMh15zMmZg7y23JNR
 Uk3J9bVa2DoWTSpVB8Ck9rgRej0NfhmnIPsXXaSdiZwRPesbsSFbaHNqVRpjytQmS7xQvkLrC
 Lw+sKtY89s8Sfc5Xs3UDLyPB4BOtOcji8+9Bp3slfH4q8f/JFDbo70HcrFJGS+i73FjcSZ/5x
 gSl+PqJRCU8uS4ARg/StDRl9JyF/SpTwqV9UelCjqtFY2B2sEUkIupKsKP93aTdaVUgWNe4yc
 ZI6s1sxWucJP4rnXfZHlU7P8k2jzf7uml/wgPyRTJRDFtWkvaRuOVwX4NzL7iX7ZWJWIbbOIt
 qwUDS/wum1lzysAdbT1TJEHBa7QHARFQ3HckteYBTzIJjWVRQTbBvGgvSUr0ujw0hGZm4Yvt5
 AGCOcnGaCIm1KexSjGhFoYLg4U4k1VyStISFTsJcyTtuJK8zOaSsgFwNi7NFMDzrxnNy3oba3
 1Xuj/xVqStd2JsJ75esf8y38gALdk+eYOvv9cBg90oSSFvV0gJ/x3zjN12pW9Z2H5I1O+018s
 wWfoXq9MsRMisYAP1s3Dde8zdCms/AiCd+cFPV/NldPpsDRETfb9TfHJ8IZoBiVXdJRiR8JR4
 oQg3Kgy6Fq7KRb0BfNuOx9XIiMU7XgvHL5OmngSIFyQXR/kQ87M2Zr4Aqzo5R6c7+oUJIsTq6
 FJBJAavAszb/OKv2bAOBuPLw4ycZyMwODs5hdHZ2V8o3kUNz2152YE=
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

On Wed, 2024-05-22 at 10:28 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Marcel is leaving Toradex and the email will start bouncing in a few
> weeks, move maintainership to myself.
>=20
> Cc: Marcel Ziswiler <marcel@ziswiler.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> =C2=A0board/toradex/apalis-imx8/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A0board/toradex/apalis-tk1/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 2 +-
> =C2=A0board/toradex/apalis_imx6/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A0board/toradex/apalis_t30/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 2 +-
> =C2=A0board/toradex/colibri-imx6ull/MAINTAINERS | 2 +-
> =C2=A0board/toradex/colibri-imx8x/MAINTAINERS=C2=A0=C2=A0 | 2 +-
> =C2=A0board/toradex/colibri_imx6/MAINTAINERS=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0board/toradex/colibri_imx7/MAINTAINERS=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0board/toradex/colibri_t20/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A0board/toradex/colibri_t30/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A0board/toradex/colibri_vf/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 2 +-
> =C2=A0board/toradex/verdin-am62/MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A0board/toradex/verdin-imx8mm/MAINTAINERS=C2=A0=C2=A0 | 2 +-
> =C2=A0board/toradex/verdin-imx8mp/MAINTAINERS=C2=A0=C2=A0 | 2 +-
> =C2=A014 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/board/toradex/apalis-imx8/MAINTAINERS b/board/toradex/apalis=
-imx8/MAINTAINERS
> index 198399c879ac..761034a516aa 100644
> --- a/board/toradex/apalis-imx8/MAINTAINERS
> +++ b/board/toradex/apalis-imx8/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Apalis iMX8
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0W:	http://developer.toradex.com/software/linux/linux-software
> =C2=A0S:	Maintained
> =C2=A0F:	arch/arm/dts/fsl-imx8qm-apalis.dts
> diff --git a/board/toradex/apalis-tk1/MAINTAINERS b/board/toradex/apalis-=
tk1/MAINTAINERS
> index e2c6f63dcc7d..393c8dcf8016 100644
> --- a/board/toradex/apalis-tk1/MAINTAINERS
> +++ b/board/toradex/apalis-tk1/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Apalis TK1
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0S:	Maintained
> =C2=A0F:	board/toradex/apalis-tk1/
> =C2=A0F:	board/toradex/common/
> diff --git a/board/toradex/apalis_imx6/MAINTAINERS b/board/toradex/apalis=
_imx6/MAINTAINERS
> index 0b2907bbe709..d84527c06783 100644
> --- a/board/toradex/apalis_imx6/MAINTAINERS
> +++ b/board/toradex/apalis_imx6/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Apalis iMX6
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0W:	http://developer.toradex.com/software/linux/linux-software
> =C2=A0W:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://www.toradex.com/community
> =C2=A0S:	Maintained
> diff --git a/board/toradex/apalis_t30/MAINTAINERS b/board/toradex/apalis_=
t30/MAINTAINERS
> index 097db7deb08f..368decf66744 100644
> --- a/board/toradex/apalis_t30/MAINTAINERS
> +++ b/board/toradex/apalis_t30/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Apalis T30
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0S:	Maintained
> =C2=A0F:	board/toradex/apalis_t30/
> =C2=A0F:	board/toradex/common/
> diff --git a/board/toradex/colibri-imx6ull/MAINTAINERS b/board/toradex/co=
libri-imx6ull/MAINTAINERS
> index ee6fe6c13ead..6c93e35cc65f 100644
> --- a/board/toradex/colibri-imx6ull/MAINTAINERS
> +++ b/board/toradex/colibri-imx6ull/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Colibri iMX6ULL
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0W:	http://developer.toradex.com/software/linux/linux-software
> =C2=A0W:	https://www.toradex.com/community
> =C2=A0S:	Maintained
> diff --git a/board/toradex/colibri-imx8x/MAINTAINERS b/board/toradex/coli=
bri-imx8x/MAINTAINERS
> index 8c9bf1f63f43..938c2ca0ca01 100644
> --- a/board/toradex/colibri-imx8x/MAINTAINERS
> +++ b/board/toradex/colibri-imx8x/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Colibri iMX8X
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0W:	http://developer.toradex.com/software/linux/linux-software
> =C2=A0S:	Maintained
> =C2=A0F:	arch/arm/dts/fsl-imx8x-colibri.dts
> diff --git a/board/toradex/colibri_imx6/MAINTAINERS b/board/toradex/colib=
ri_imx6/MAINTAINERS
> index 25d3a06a8523..c1067502c082 100644
> --- a/board/toradex/colibri_imx6/MAINTAINERS
> +++ b/board/toradex/colibri_imx6/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Colibri iMX6
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0W:	http://developer.toradex.com/software/linux/linux-software
> =C2=A0W:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://www.toradex.com/community
> =C2=A0S:	Maintained
> diff --git a/board/toradex/colibri_imx7/MAINTAINERS b/board/toradex/colib=
ri_imx7/MAINTAINERS
> index e4583d5a86a2..80770cc71a96 100644
> --- a/board/toradex/colibri_imx7/MAINTAINERS
> +++ b/board/toradex/colibri_imx7/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Colibri iMX7
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0W:	http://developer.toradex.com/software/linux/linux-software
> =C2=A0W:	https://www.toradex.com/community
> =C2=A0S:	Maintained
> diff --git a/board/toradex/colibri_t20/MAINTAINERS b/board/toradex/colibr=
i_t20/MAINTAINERS
> index d0c5b1133313..58842434024f 100644
> --- a/board/toradex/colibri_t20/MAINTAINERS
> +++ b/board/toradex/colibri_t20/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0COLIBRI_T20
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0S:	Maintained
> =C2=A0F:	board/toradex/colibri_t20/
> =C2=A0F:	board/toradex/common/
> diff --git a/board/toradex/colibri_t30/MAINTAINERS b/board/toradex/colibr=
i_t30/MAINTAINERS
> index 006a0e55f113..73859fd25c2e 100644
> --- a/board/toradex/colibri_t30/MAINTAINERS
> +++ b/board/toradex/colibri_t30/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Colibri T30
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0S:	Maintained
> =C2=A0F:	board/toradex/colibri_t30/
> =C2=A0F:	board/toradex/common/
> diff --git a/board/toradex/colibri_vf/MAINTAINERS b/board/toradex/colibri=
_vf/MAINTAINERS
> index 2e1a74c2db75..a41bd165a7ca 100644
> --- a/board/toradex/colibri_vf/MAINTAINERS
> +++ b/board/toradex/colibri_vf/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Colibri VFxx
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0W:	http://developer.toradex.com/software/linux/linux-software
> =C2=A0W:	https://www.toradex.com/community
> =C2=A0S:	Maintained
> diff --git a/board/toradex/verdin-am62/MAINTAINERS b/board/toradex/verdin=
-am62/MAINTAINERS
> index 3e30d1d51121..3f69ea88c00e 100644
> --- a/board/toradex/verdin-am62/MAINTAINERS
> +++ b/board/toradex/verdin-am62/MAINTAINERS
> @@ -8,6 +8,6 @@ F:	configs/verdin-am62_a53_defconfig
> =C2=A0F:	configs/verdin-am62_r5_defconfig
> =C2=A0F:	doc/board/toradex/verdin-am62.rst
> =C2=A0F:	include/configs/verdin-am62.h
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0S:	Maintained
> =C2=A0W:	https://www.toradex.com/computer-on-modules/verdin-arm-family/ti=
-am-62
> diff --git a/board/toradex/verdin-imx8mm/MAINTAINERS b/board/toradex/verd=
in-imx8mm/MAINTAINERS
> index d567f0e1097d..0d58a73b9303 100644
> --- a/board/toradex/verdin-imx8mm/MAINTAINERS
> +++ b/board/toradex/verdin-imx8mm/MAINTAINERS
> @@ -1,5 +1,5 @@
> =C2=A0Verdin iMX8M Mini
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0W:	https://www.toradex.com/computer-on-modules/verdin-arm-family/nx=
p-imx-8m-mini
> =C2=A0S:	Maintained
> =C2=A0F:	arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
> diff --git a/board/toradex/verdin-imx8mp/MAINTAINERS b/board/toradex/verd=
in-imx8mp/MAINTAINERS
> index 9fe76d8e42f5..a68344885395 100644
> --- a/board/toradex/verdin-imx8mp/MAINTAINERS
> +++ b/board/toradex/verdin-imx8mp/MAINTAINERS
> @@ -5,6 +5,6 @@ F:	board/toradex/common/
> =C2=A0F:	configs/verdin-imx8mp_defconfig
> =C2=A0F:	doc/board/toradex/verdin-imx8mp.rst
> =C2=A0F:	include/configs/verdin-imx8mp.h
> -M:	Marcel Ziswiler <marcel.ziswiler@toradex.com>
> +M:	Francesco Dolcini <francesco.dolcini@toradex.com>
> =C2=A0S:	Maintained
> =C2=A0W:	https://www.toradex.com/computer-on-modules/verdin-arm-family/nx=
p-imx-8m-plus
