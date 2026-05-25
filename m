Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2D9CD5BD2
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EF7846C6;
	Mon, 25 May 2026 16:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jPgQ0djc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B26484702; Mon, 25 May 2026 16:08:56 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67DC680398
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4855562f32eso1049850b6e.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779718133; x=1780322933; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o+MlK46uCJeXNn3RoiGSNIv5qaEHuvVw1QbEYuHSauk=;
 b=jPgQ0djcUDDxYokzmmUAZhl8XMpK1iUdfUr9HCFZpEMIZVxfcpZtxTnDq+BFH74rNk
 7qy4begrURk9U93S5Un+Km2mHzqpIe85yuu1dR2fsiDEdulajYWu1+BADRUyztNPWN3u
 m4ox0Ws1pdqIC2+1XYzr7eGWx1hhcXKG2iWcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779718133; x=1780322933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+MlK46uCJeXNn3RoiGSNIv5qaEHuvVw1QbEYuHSauk=;
 b=NCbt3YrS9MfJRb3EOMqG1pFFfZjzfsDuZOkGeapjhY6j5rqNqyFvokq6xnAPPmdCtL
 iHzu6r78/ZKkLUSl88Zb12uvaaXYbF7d3ymWrLRTLbmksZftAZxEoUbVl1kPDrE+AVSV
 j6GghU2k44Ydm799ewGBU8TDVqPf7KaDkTKxgan013icaixlzLI5azjPUncYeV5UBiUM
 8ef0tUS+22B5Efbhk1zD/UZwTfkxwZanYfRt7P1ZA/nX+iMtXoeJlyr3CWVKG34+RSlY
 5vA9vFFRSYxBXW67ZV/++/Buxru199qW5l/WZgJBSv27F8jjh7zkrE1MSHT4ZUpkL9ZX
 fIeg==
X-Gm-Message-State: AOJu0Yy67uJccmKuvCZCByCURBk5FwxhKpdQQdPFldWzmeUyOkNRBQpI
 Oe2YYRQtqYL6Pru+dbuD8muXdMO4UrYeT02QQlMyEIManLZuRERYVx5sb7+a0o+Av54=
X-Gm-Gg: Acq92OGcCfHzg/qEBsIdmHm6XZZ0wo5nKOaF5Kbc04v2RTkaf9ZboIIMtoU4TkD4XdB
 jkVw9+QxxEg1GNzt7tWunZokutEDMdJ1XB8P3oGHAO3htTH5M7JLAyxsFEr1Hmh9ySwNGXRYVA2
 In83pkwjatTixEHeOtaJABdA2h8jCBP7izc5w3rMIAyOfytDdm3Cb//ei/nUWFSHkDr6UwhF2Ic
 kr/nuo37w2RajbWuCbHG2ytZPG42qI+98RVQqJ9UE5fSbT0t83a1bZT4Quf5WolOhE512jxcapz
 kmkarGC9uzlVHRoo++kmz4YrkDKy8OAbLcslVG51F2InG6XgcxVUydNvU9NBFHaTCjORtUFIIob
 SKSgoa8BBu3VgPPrm+C9xAy97ONZHI0WJer0KS68599ZjmRSaa/W3LioTSIRwuyNE1+goI40WmF
 BLOLca3ErZ36kMMbbLBtHwwfdneWMfHoU+SpT06LBYr7a6umy2CJbjBg+Lpst+R9Nt95z4LwlTW
 ANIVnqP6D2VbOl7ddP1tVhIM31iseRG6ZnP9GkP3b7Yyg==
X-Received: by 2002:a05:6808:1804:b0:485:3a2c:e78f with SMTP id
 5614622812f47-4854a3fecc3mr7544275b6e.40.1779718133047; 
 Mon, 25 May 2026 07:08:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm4759154b6e.17.2026.05.25.07.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:08:52 -0700 (PDT)
Date: Mon, 25 May 2026 08:08:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Alexander Koch <akoch@initse.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/3] binman: imx8mimage: Handle nxp,boot-from = "fspi"
Message-ID: <20260525140849.GG1858239@bill-the-cat>
References: <20260524172402.119517-1-marex@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uyNWCUvIUiMlChup"
Content-Disposition: inline
In-Reply-To: <20260524172402.119517-1-marex@nabladev.com>
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


--uyNWCUvIUiMlChup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 07:22:54PM +0200, Marek Vasut wrote:
> Boot from FSPI requires additional 448 Byte long header, with U-Boot SPL
> starting at offset 0x1000. Currently, both i.MX8MM and i.MX8MN attempt
> to generate this header using fspi_conf_block with filename pointing at
> CONFIG_FSPI_CONF_FILE file. This does not work, for two reasons.
>=20
> First, the CONFIG_FSPI_CONF_FILE is generated by mkimage -T imx8mimage
> and may not be available yet when the fspi_conf_block is evaluated. That
> leads to a race condition where highly parallel builds fail to find the
> CONFIG_FSPI_CONF_FILE, which is usually called fspi_header.bin, on first
> build attempt.
>=20
> Second, binman gets confused and patches incorrect offset of DDR PHY
> firmware blobs into U-Boot SPL, the offset is incremented by exactly
> 0x1000 which is the size of fspi_conf_block.
>=20
> Fix both problems at once, make imx8mimage handle the generated FSPI
> header and prepend it in front of the imx8mimage processed data. This
> way, the race condition is solved, because the data generated by the
> imx8mimage are surely combined only after mkimage -T imx8mimage ran.
> The binman offset calculation is also solved, because there is no
> fspi_conf_block node in the DT anymore.
>=20
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Alexander Koch <akoch@initse.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  tools/binman/etype/nxp_imx8mimage.py     |  8 +++++++-
>  tools/binman/ftest.py                    |  5 +++++
>  tools/binman/test/351_nxp_imx8m_fspi.dts | 18 ++++++++++++++++++

Tests finally have subdirectories instead of the frequently conflicting
numerical prefix, please pick a subdirectory of tools/binman/test/ for
this for v2, and include a short cover letter as well, thanks!

--=20
Tom

--uyNWCUvIUiMlChup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahRX7gAKCRAr4qD1Cr/k
CkYxAQDhqVe9dl9aDBJcRyU3PauQGq2pkvvJC+VrlrxXToi1JwEAx/nPbKUvDYUE
BuwYOqEdzy1pMHIOWhUFZEPgrd766wo=
=M/Ub
-----END PGP SIGNATURE-----

--uyNWCUvIUiMlChup--
