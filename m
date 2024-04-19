Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0975C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44809887F0;
	Fri, 19 Apr 2024 18:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F6p+JjXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8484887F3; Fri, 19 Apr 2024 18:38:38 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 689BB887E9
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-518a3e0d2ecso3540611e87.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713544716; x=1714149516; darn=lists.denx.de;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9h/8e3Zz3nY8RgDcV7Ue5qTzlGv6X4GkyjpUXzSBpFo=;
 b=F6p+JjXgsc/od4/2M/R8R9cBFPVtBUG+P2PmGn7wVNOERnqOnHwV8aQmn6ZEuZ+qG8
 WlViHH0pKdhyQ45FFnFp/Tjye4QF5D5ufRAksLsi9JC7Wbie0LpNyiw5WdOCcFw0Vata
 1Ytz9qiK6lZYKYo3Lm3etRUOS+rqdHYO81G7AD7xHcjGHaWOoaQT/PByBk87KCuxIvMO
 e1ndiaPLUBAclph5iXe5x7Ll3TH9QE8Oye3Vj2qtY2NLsISZZmQlKX4JQU7rzNnjHdKj
 PV1/xjRmvAB/N4CNdetcy+iV7kzLmuXQdX++jtN3q7pnnPCFVch6l0Qx08PcSCscRrPh
 XIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544716; x=1714149516;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9h/8e3Zz3nY8RgDcV7Ue5qTzlGv6X4GkyjpUXzSBpFo=;
 b=BWzckk8d+1IrGW2niDeerLUm9xKMpVi8dibRUUDDrSuSPIpYWVcpIle2xRVTzB5nka
 ECsG0L19rKrDAuXYHYEeeqeg35R0Wf0Jq3wXoLzuWpTM/vE0S1p9l+rYGEYGGPGiXgUI
 BRJhHSb6HG25qMTbveYk/KKGo8oAsmUiDiPQpsqLD8lA/WtCVrG0E9gf0Sl+Hy4gDe5Z
 LOPiuSUEy4g/ggWJHYd0u0iNiU2r+xbxv9KNgiNL/ZaivxnpfKA50BokdIYLR1xIFqJ0
 LnLNOTRqQnizOYuMbeSM+6nHi1j+c1rvif5Gg27ANzza6ceJvaDDIaJf0EiaZg+0jssv
 1L9A==
X-Gm-Message-State: AOJu0YzzrSSbNe3pY2wDwcPEdzcDUBmwBHz3GPknE5NYswali2SUojmd
 zUwNzRvXJoRsUp4HTX5y48MgktFgCPdXPd+ukttqzzU8HkyLhcrv
X-Google-Smtp-Source: AGHT+IEQ82s+RWsGX1wVpHIoiZde1VwvOtm/PBFJ2cVaw8ip25s89GP2g8HDI9brKNEJIUyjHAmZxA==
X-Received: by 2002:a05:6512:708:b0:51a:dcf4:5b2a with SMTP id
 b8-20020a056512070800b0051adcf45b2amr90973lfs.56.1713544715310; 
 Fri, 19 Apr 2024 09:38:35 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 qq22-20020a17090720d600b00a554f6fbb25sm2381104ejb.138.2024.04.19.09.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:38:34 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=c0bf2b35187cb0b1ee2fc508d1d1a37845e45a77cf8ced40c7ac73ef9d31;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:38:34 +0200
Message-Id: <D0O8WMHSVVCR.2AAWX7HDFZTDX@gmail.com>
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 04/18] video: tegra20: dc: pass DC id to internal
 devices
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-5-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-5-clamor95@gmail.com>
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

--c0bf2b35187cb0b1ee2fc508d1d1a37845e45a77cf8ced40c7ac73ef9d31
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Tegra SoC has 2 independent display controllers called DC_A and
> DC_B, they are handled differently by internal video devices like
> DSI and HDMI controllers so it is important for last to know
> which display controller is used to properly set up registers.
> To achieve this, a pipe field was added to pdata to pass display
> controller id to internal Tegra SoC devices.
>
> Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E156=
5
> Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 6 ++++++
>  drivers/video/tegra20/tegra-dc.h | 3 +++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/teg=
ra-dc.c
> index 5d8874f323..0e94e665ef 100644
> --- a/drivers/video/tegra20/tegra-dc.c
> +++ b/drivers/video/tegra20/tegra-dc.c
> @@ -45,6 +45,7 @@ struct tegra_lcd_priv {
>  	unsigned pixel_clock;		/* Pixel clock in Hz */
>  	int dc_clk[2];			/* Contains clk and its parent */
>  	bool rotation;			/* 180 degree panel turn */
> +	bool pipe;			/* DC controller: 0 for A, 1 for B */

Bool is a poor choice, even if there's only two of them. This is a
proper index, so it should be some sort of integer.

Also, the device tree bindings for the display controller specify a
"nvidia,head" property that can be used to identify these. If you add
that to the U-Boot DT you can avoid looking up by name to map this
value.

Thierry

--c0bf2b35187cb0b1ee2fc508d1d1a37845e45a77cf8ced40c7ac73ef9d31
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYingoACgkQ3SOs138+
s6EceA//YzLG4ewvVxDyRZ3p0QoI4pBZ6VJwyYoBfoPY5QNc/FlpJGehZmkgoCKT
cZmaOG/Ltm5+Z/w8Q0C4u+CnOd5FtCUzvmsOOt2RaB3xJZ9LTFy6Qdzqp9VdaiXi
tJoabPPueHJl3i2XJL8cNLR2IKTGcASQ9YixfablDQwybUmwAxjMTAqA6CXGoQxH
EJ6zqqx8HOLN7DmSvZ9/Egi9PZ3o0n9WI2NzDER9ZEyozXKJOqw9WrR5YIb7p8Wo
iQp7DcTIRuNvgVz4AugxIxTMLWrmUByRiom13VRlriMduRyT5PivP3ZmYvJE+/bb
iUyEwYGeJmrJIgSTTQhi9tIcjmFqRYDc05sp/KNQKDI/hxxzLXiaXocSRIYa5UtV
ZefUhjCHe2j61K2Bbq+7lTJAHTvibyVwG45EoectP/FphH+7O58bkLCDa2yq7eJY
xSYTYELaHMOjnnUqzSPbnPe9bpGxGgRD1ggr7oNNzv1/r2jCEBOKNurup503FliG
MStyzqx9+NhdG3pldRPlmesLHLGHgTxoeY6HDpPjtFsLStPNelwxSSlF6CeA5Xew
lVoKDMApREcmmwu+Ws16UXhTMffKp5GUkwcNb7Bu4DTTmWGb3OUCAFeNRiQ8+S6j
RRSwcA0NwRaO79YqBshHDeCvKN6ejftUgOTVRNKPFPUgj9opGKs=
=64fA
-----END PGP SIGNATURE-----

--c0bf2b35187cb0b1ee2fc508d1d1a37845e45a77cf8ced40c7ac73ef9d31--
