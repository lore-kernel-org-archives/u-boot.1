Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BADAF46C59
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CBB840AB;
	Mon,  6 Apr 2026 18:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b++oq3+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 485D88341A; Mon,  6 Apr 2026 16:20:39 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE59883EC6
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-46fc5b8a06bso1721658b6e.0
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775485235; x=1776090035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8DSdEjsi7Lc8WEC/TLpIHajAdPF+Ta4DXoexOydylfQ=;
 b=b++oq3+hCeYDrM0yAA20ePTidt/xbQU92hC7aeR+rj3MR28gpfOeCQ6S+0+JWl9CwQ
 bstzdI2YTdALlaIKE5fbK8XzE+VIzvlgE34sx8MKxDNs8YW4wL/cmtHWVf3zPjwTIQ8V
 5QRCo6LNuyxPpbe55fU9Bc0ZvoxfzYjC9FONU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485235; x=1776090035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DSdEjsi7Lc8WEC/TLpIHajAdPF+Ta4DXoexOydylfQ=;
 b=bwh1qREax/IrzRpqctbzkS7kbRmTFxBTHKlTqTBUw2rkK2TcOSq7SUBwjOsvlJPNmd
 XDDlOpKgr+k8yQb+TKCOIDA7pQkmYn6it/D0B1LppZ/A5WnwVE17afEPUiXWjOlC2qv4
 fRGKn4r/IOMGtGUam/a3gwwzwpKzzwwCWyaCx75wCzc+wy77ztpeVFTQYLr75PTVqPNC
 xZgkJ0GMXBga4eomDHG4TRG37kEIwxd3zxL4oMDbiLSm/56DSW75ksaIF697n22Wrrmh
 zNn4xn1sJcuKkEJkOzDWVOwYNxgjgKO1r/ko6EseEVmh7RUTsa5/sj/5iHwKiEJnHs0p
 HwyA==
X-Gm-Message-State: AOJu0Yy0uvVdZtGM4TH7neJq4zsveXvYuvYf6xhia/7BPFfDhRcgRZy7
 Q5FV0x4Wstsfqbao53bNk+oIuZpnSfbkHWg84luWn23EGw77QdkonXY5FWx8FkCxJ+M=
X-Gm-Gg: AeBDies09mqTz3o+1wPqgNqMrH9/AZ34lWgEmvQ6EXRTCN5+SWUpw5KUyvuvjCKONfs
 l73IzIUS5e8OJAJdKfs0KbWMYchKC8YM/hXqBWupMNEzZ2Xzyj/D9O4G1qVL3JOiaomJzqUcXWr
 emxLrBiic9nafw94HtMScxy9VGoCWvUjrBcXxILDlFFvKmGCZ/Q7qun9Yv6sfl7ZhWfFNLE7OIN
 n/Geuu+8hRUOm4cNj6nqEGHAahP/fu35wr0K4L4MP8hh64BUjoIQKtvlmv28Yz/wsO/5rMdncdE
 CV6Zej7W5MXCq7VlfwPqms/Ywnp7tBPtlnHqcq86egkF0DoB7c5gsgx93gm4LKRVkvF6DEtNF9X
 y3wrAF5kg3f6LseecfyGoI2LxpyrNcOSI7f1MnocloOedU//GrKcpNMe4ElWj8bZcFFs+F7zF4D
 QEkutjOFae7hrVSmMtzKJYBrbYlOxgHI5RYt9995XF7vlVTNdMxyhZFKrZWQ7c4NXa7S9PPfwyG
 aqQ0vX0YtbfToWLXF4BVo/xCuXgqXbd9k3/LjttvkcCGOOt
X-Received: by 2002:a05:6808:4f69:b0:467:f9f7:6356 with SMTP id
 5614622812f47-46de2215cb2mr7257941b6e.16.1775485235397; 
 Mon, 06 Apr 2026 07:20:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbd6c3e905sm3599909a34.5.2026.04.06.07.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:20:34 -0700 (PDT)
Date: Mon, 6 Apr 2026 08:20:30 -0600
From: Tom Rini <trini@konsulko.com>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] of_live: support in SPL
Message-ID: <20260406142030.GL41863@bill-the-cat>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-2-9e6c2ac66587@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RnT9wFqNuubTxAdn"
Content-Disposition: inline
In-Reply-To: <20260404-qcom_spl-v1-2-9e6c2ac66587@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 06 Apr 2026 18:50:36 +0200
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


--RnT9wFqNuubTxAdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2026 at 01:18:17AM +0200, michael.srba@seznam.cz wrote:

> From: Michael Srba <Michael.Srba@seznam.cz>
>=20
> Add CONFIG_SPL_OF_LIVE and if set, initialize of_live in spl.c
>=20
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
[snip]
> diff --git a/dts/Kconfig b/dts/Kconfig
> index af8d30b45ab..f3472c9c0e8 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -86,6 +86,11 @@ config OF_LIVE
>  	  enables a live tree which is available after relocation,
>  	  and can be adjusted as needed.
> =20
> +config SPL_OF_LIVE
> +	bool "Enable use of a live tree in SPL"
> +	depends on SPL_DM && SPL_OF_CONTROL
> +
> +

Extra blank space, and we should have a minimal "help" entry here,
thanks.

--=20
Tom

--RnT9wFqNuubTxAdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPBKwAKCRAr4qD1Cr/k
ChiTAP9cJpzVKfIj7FGIJLJaNZ+0lT+p7OhtPy4EJb02l+sIgAEA22WLp47dYqcF
3gQCDCY03FDulRr9FAbVqN59tLKqtQY=
=XrOV
-----END PGP SIGNATURE-----

--RnT9wFqNuubTxAdn--
