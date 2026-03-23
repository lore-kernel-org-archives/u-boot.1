Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94325F483F7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 127AA83FED;
	Mon, 23 Mar 2026 21:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ap6/GI0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D8C83FED; Mon, 23 Mar 2026 21:24:05 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A20883FA7
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d751ef36ccso1660268a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774297442; x=1774902242; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dRhwcG3CxOKsVyU2e2e/eAaKJcK/mRWdY0QlO40HdI0=;
 b=ap6/GI0H1TIRVl2AHBorWgAK/KBFSS6wR2vs3QmkD+npN9CzIw5YUPwdIMfzeRRS2C
 ++ElaPw2Qy0OrCNW3cBhkA+dE+FQjbRUpuv/lj6RIuhrEzSdqJqEzSOeBTcbwhFHIUx8
 XDpOZF3lMfnfAUJle1wr7A9Znw9DrPAEogA48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297442; x=1774902242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRhwcG3CxOKsVyU2e2e/eAaKJcK/mRWdY0QlO40HdI0=;
 b=rRm6rhPLquIoEk8cZHnI3+Waar0MRO75nSwPpoAWeRlybrPmh12r2/0AW9DPNf5S6t
 w2vOAhk4Yd7m+k78KeH5Ko/PaFDfIPKoc4inbqorTlcm+JTslkr5+LR0hEkQQoj3Gghc
 qWXT4l4zPB9OWy9FzBLmfRPzgZk2Pvyw55gb9Uy2Gnwl5A8iif0EKPhYsk/TWUoj2UX4
 ry6DSTeJMSU+EyMLYc7CvlmBg1bDde9+XeGqN6yNNobIjhBuTrDnxBpgEyb29u7CrQxq
 RGct3lga/Rfm1Mhsrkr5CjYeG9sSlp7xp5RAy61j2lZjUd1s+2IFoOueKhu/FeGlcJBR
 MfHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQwmhA20I975+G9KclEzy1Q2YoBLHnFSWaaca+dbcpY0NPYZMnkGWKAn5HC7+PdiAHIWvuU9U=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu1ATt3+kan4SJ4HTa2nHRqGJ5vvs8scE08fjqR5qL2/hOQWzq
 Hd57Kyzy0DDgn8BNr/cx9XgHXlicgO1tAE7+Z3nVXNtIEbcWzBg8nGMQ1K/gTxIGEcM=
X-Gm-Gg: ATEYQzxyxi9NxX20hWzHvW3SVPA5eDB4vvspG2olAKJJuk/JeupQ40bnzBAjvLbuw8p
 S1sWliiErB97cHvNquxNRU8AzNtzeb5SrXNdIovFf0FEkmiyRIWyAlkrooYu7JX70B8oflAH80Y
 qIW8vMcW5RKJCfKQr8A6vM5JmcvAfGMHWMO7RKP5YpYGRNu5c+ZVSZQcIa0NSPiEJJgFFkZB5b3
 +Nr+N/GINZ/1gId8hhNVBzsGIekcb/X5oUinIulLqy2Jmb5tBai74YUApZ7en8Oi0eYDjtS2b5k
 9fBGW2GULddRBFxR3aniOczlU+QYt4j3M9yty1W0tKu73DjQr/4xV/NpH96fqAtW8vlYCuLC69V
 je0k8QhufrSifDd5InNa0BRcTXxXFYUYnUHNgMic1Ort1PvGTSgy+1nN4ConguM9RciZcNDUTk0
 H+dBisPPxvWXXKv6SBauyQoZn3Gu6AaJIOjAys5P8p8/LDYZPmqI4eVK+/Y+NozdGmbkrKQjDl6
 jQu9/quRtHdLvG+3cyPzKhZAgFnjLtZUkEO7bFzB1Bkw552
X-Received: by 2002:a05:6820:1789:b0:67d:e308:bad3 with SMTP id
 006d021491bc7-67de308ed77mr5736651eaf.36.1774297442065; 
 Mon, 23 Mar 2026 13:24:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252dbd05sm6613832eaf.6.2026.03.23.13.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:24:01 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:23:58 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/6] clk: mediatek: mt8189: add some VLP clocks
Message-ID: <20260323202358.GM502704@bill-the-cat>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
 <20260323-mtk-mt8391-initial-support-v3-1-19dd92f4543f@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RdrQlYpn0wuvIvH9"
Content-Disposition: inline
In-Reply-To: <20260323-mtk-mt8391-initial-support-v3-1-19dd92f4543f@baylibre.com>
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


--RdrQlYpn0wuvIvH9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 03:16:52PM -0500, David Lechner wrote:

> Add some VLP clocks needed by the PMIC on MT8189 and similar SoCs.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt8189.c | 289 ++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 289 insertions(+)

I'm working on a series now to fix this globally, and it's not a
MediaTek only problem, but:

> @@ -1733,6 +2012,16 @@ U_BOOT_DRIVER(mtk_clk_topckgen) =3D {
>  	.flags =3D DM_FLAG_PRE_RELOC,
>  };
> =20
> +U_BOOT_DRIVER(mtk_clk_vlpckgen) =3D {

This is a bad name to use. I bet in other parts of the series you re-use
it. These names need to be unique within a binary, and while today they
will be I bet (since all the other examples are fine), someday we'd like
to be able to compile test (and so static analyize) more code, and it
will clash and fail to link. A better one would be
"mt8189_clk_vlpckgen".

--=20
Tom

--RdrQlYpn0wuvIvH9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacGhXQAKCRAr4qD1Cr/k
Ck4oAP94wCL7e0HyavjAS3uJ0FfmLsqxTqYm12rrsjuMXo3heAD/XYF5LBgkX+TB
S7IiZ/BQBKQ0CHMZ2o7mMmK0lfqgPQc=
=5G/9
-----END PGP SIGNATURE-----

--RdrQlYpn0wuvIvH9--
