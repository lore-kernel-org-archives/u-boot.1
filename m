Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8CCD3C908
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 00:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE9C8903C;
	Sun, 20 Oct 2024 02:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uNyFWDVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F4F89121; Sun, 20 Oct 2024 02:27:15 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A1EC890D9
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 02:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbe8119e21so24679406d6.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729384030; x=1729988830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a5CtGk7xliqMpZH7CzEbGxHRznfW9eOOYn+tV0caWcY=;
 b=uNyFWDVANS3yHVlOIqWZ4baUrD3z/lVqRqwBjI7Bfme3yitmO19uvzICoDXmARbJvJ
 Sf5Jv2Af0v2UmhohGkBQkDXlfuXTucVL49JcNrT0cinYLdORcI5RMItJe+YJhDitSkAP
 Zx41cvn2qr5YZ09WGwZmTbe6fe1Mo13FAZ8y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729384030; x=1729988830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5CtGk7xliqMpZH7CzEbGxHRznfW9eOOYn+tV0caWcY=;
 b=P5wKvgIjVXbU6vK+257qrMO4f2hYWrcw58hskNbZhPl5oPvHmUmaCQ3WuFlx7eQxWG
 D0FluosbKDQo0QAi25uC+tRsVJSavqIcQwbxvM/zfY6dAxtuGPOUB047eeVl8c4IUlCs
 5tyPHfVQfQAW/DxlFXuulW/fkR7+L7HnBsHTebhnWYgBLox+9Zx8W7sWzI/EW3nOgxpV
 Wa9vKiRDsVY/69rbg1vHQlxDt+GrIR7w2KvxujaLtCQsqXGMbvxqJKNTjiJhto1SjosH
 brA7CRZuFS6YtI/hbYRCvbYrPvOGaOXtZOnCA4kbVCJP1S/LHEYAv9F8+YYz0ha3IZri
 A0Kw==
X-Gm-Message-State: AOJu0YyI3IVMcWvQo9NbotTnTj4rR3cTQUzcIPLU+sXV9QwK9DSxDKXY
 I+4SMxJzfd0G0jkv1RdgDesjfcCNEo+sPhquLpBWy134J9iYTLA+9uNnvzmSPro=
X-Google-Smtp-Source: AGHT+IG3klcKSar4E5P9u1vufUkGGKcuxUGNY0qJnzDS8+QsIZXP5HbhxQ0UZx36NIa2UrBolZULqg==
X-Received: by 2002:a05:6214:5785:b0:6cb:3a1f:e47b with SMTP id
 6a1803df08f44-6cde163e394mr82975686d6.52.1729384029866; 
 Sat, 19 Oct 2024 17:27:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce00a02e15sm2702236d6.146.2024.10.19.17.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 17:27:08 -0700 (PDT)
Date: Sat, 19 Oct 2024 18:27:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
 Huan 'Kitty' Wang <HuanWang@gehealthcare.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 Adam Ford <aford173@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Baruch Siach <baruch@tkos.co.il>, Breno Lima <breno.lima@nxp.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Eric Nelson <eric@nelint.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiagofranco@gmail.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Niel Fourie <lusus@denx.de>, Nikita Kiryanov <nikita@compulab.co.il>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Parthiban Nallathambi <parthitce@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
 Richard Hu <richard.hu@technexion.com>, Sean Anderson <seanga2@gmail.com>,
 Silvio Fricke <open-source@softing.de>, Simon Glass <sjg@chromium.org>,
 Simone CIANNI <simone.cianni@bticino.it>,
 Soeren Moch <smoch@web.de>, Stefano Babic <sbabic@denx.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Troy Kisky <troy.kisky@boundarydevices.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
Subject: Re: [PATCH] ARM: imx: soc: Select default TEXT_BASE for i.MX6
Message-ID: <20241020002701.GC4959@bill-the-cat>
References: <20241019220938.365256-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vbW9yPW3lQ/fXgdp"
Content-Disposition: inline
In-Reply-To: <20241019220938.365256-1-marex@denx.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 20 Oct 2024 02:27:31 +0200
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


--vbW9yPW3lQ/fXgdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 12:09:03AM +0200, Marek Vasut wrote:

> Select default U-Boot and SPL text base for the i.MX6 SoC. The U-Boot
> and SPL text base is picked as the one used by various i.MX6 boards.
> Update all the boards.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
[snip]
> diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
> index 1f8022ee685..10b19984143 100644
> --- a/arch/arm/mach-imx/mx6/Kconfig
> +++ b/arch/arm/mach-imx/mx6/Kconfig
> @@ -15,6 +15,13 @@ config MX6
>  	select GPT_TIMER if !MX6UL && !MX6ULL
>  	imply CMD_FUSE
> =20
> +config TEXT_BASE
> +	default 0x17800000
> +
> +config SPL_TEXT_BASE
> +	depends on SPL
> +	default 0x00908000

Please do these in Kconfig and common/spl/Kconfig with the other
SoC-wide default values, thanks.

--=20
Tom

--vbW9yPW3lQ/fXgdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcUTk4ACgkQFHw5/5Y0
tyzw/wv/Wqiyf0t4AjdskaWqbsmYL12D3VFsNgPzYHR7bIgT98cgU+FbZsVe55YZ
FosCMMR4la22FOPCB0SQ4zAVRrci3MXOV0c+qicLz8KekbEAePVL+mKTqvbRAqK+
a/Ot2zUBXnUZu0ESkNdnWWlIjSEHuPrKE1ungo8halRuAQi3oHreqas1qqlguVUi
lX+jB5lFbno9b+5d+a3xhdM7nhYB07lx6mgzcp9YQ57ViDu7C/BatArcdKf40uUJ
XFaU3RnGz7guZooUzUKVs8lQLRQhGrVlsl48E2ZqU8azbcI8kvwU3YNcxSiMAQND
BmZuwM2A/+nWYDZiXvNd/BeQPc1E7VXKHgEJ9pkVGolc2oAVMh9T6QYARCMkCJAZ
Ah2H/EYvgUAQs4ScsqCra/3SWFwdBzbsUEAD5ws5j8mFZXmL0KX/2r134QysF7sw
Q9pouzpvBywAriPon1CxIDiT2tc2JffVRWBX+ywLzGBVakJVtdpFaTUgx9BKvoMn
gv+N0pRC
=Th1e
-----END PGP SIGNATURE-----

--vbW9yPW3lQ/fXgdp--
