Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE69BC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71CA481F45;
	Fri, 14 Mar 2025 17:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ORr+Rg68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7169881ECA; Fri, 14 Mar 2025 17:54:11 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50BBA81F45
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-47691d82bfbso7226241cf.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741971248; x=1742576048; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnYmKbuuPXGOrVGoet6aemJBS7GttJoJ5t2i6T4PKko=;
 b=ORr+Rg68gutAvfR+KRRqfxUtHKFCXJAAiGWjR8nFZaZyfGkvHQ2+f1RJhwtxyCTWE4
 Nl0zezUDFIA8htbU7irHSt+85RBJsS+qQdnpg0GTH8EITI7swSq5Z2tIbHhhoMZRvz4M
 2jQwdSd3djLZDu1cJzDusYu29npgWByBeBGJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971248; x=1742576048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnYmKbuuPXGOrVGoet6aemJBS7GttJoJ5t2i6T4PKko=;
 b=msqZIpG9H/C8Qz4C3r0ITILRGhkio8pHkhRrEYdVhy2+NDm7wcNTC0hegLq9Myh0ZF
 laMV62DXCLNu2nSeL1+pR9WUuwMHS1ZMXnHAHtBVa8IxyaeD4Xexfxf1aZelHcsokqni
 l0yfAsbW2FNyQPFEO1Pvnlljhu29LADM8EKrDlhrHCYRJMVGSCBeuEExJwevSgqNG6QS
 oxQq+GPJ2ZUBmHUsCyubRDt9V20hWRHD7ZQ+wJoCIcGZ0wDS8pCwX8WlhzO66Zy7l9FD
 iqCDkQiSRYUglgsR+sPvKsqdG3D8YOYjaR2eGpFr2DOxjubvaBeZSo/kndya+5reM05u
 sDlw==
X-Gm-Message-State: AOJu0Yyyk/BhHtCk8Ep24XxkpIGFRZyXbxYVql/E8kK0Pny+xRAfGTjx
 ZrtovX7Ys1qcjLLXKN6NQjsuy98oxHV900EzObcls/ECYaFkEH2C5jFEKEkLrPE=
X-Gm-Gg: ASbGncsVQw4p4IfbbAGWBAXGszReYBPsBexcGVLXsW0AtjrjRmR9jIWJdtVdMXLJNK+
 Zy6k9Gj04ngpQ1H9XX+C1oU1OPdTQAlP4/F747ngHRo5lIPmcxYwUO22Uew17U6QpOHdLlKb1gh
 mp7l4bqNKNBbXPSpWo/ioyhRYtLv9TXKYScFOedqGeOdgegGTGIxEQe9gkejQdx3JvS2ilLy68B
 dQFxbcXuIX2dai8EXcvEhZjrvzWrGoX6Ry5HzOCQ2wV+alpvyHxX9IGnn+k8G7S8t/ePnppZqpr
 rgoTH329F3qEclmI28hmRJhtJYXyuuAU48dD9dXA9Bt+6Q==
X-Google-Smtp-Source: AGHT+IGTgQ+C300r3qF+X8VOpHQjZHRfM1tUxKzWWp7C1cULqwb3LyJSCKPOABktCaPyT6VCJ6ILNQ==
X-Received: by 2002:ac8:5955:0:b0:476:7199:4da1 with SMTP id
 d75a77b69052e-476c81d94b1mr42373561cf.46.1741971248182; 
 Fri, 14 Mar 2025 09:54:08 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb611c83sm25258751cf.2.2025.03.14.09.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:54:07 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:54:02 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: Re: [resend v2 12/13] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Message-ID: <20250314165402.GC2640854@bill-the-cat>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-13-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7+3GSbJOIXYOyCj7"
Content-Disposition: inline
In-Reply-To: <20250314040902.43621-13-dinesh.maniyam@altera.com>
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


--7+3GSbJOIXYOyCj7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:09:01PM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Enable configs for sandbox i3c.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  configs/sandbox_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 861a1f4cd90..d3617da8792 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -364,3 +364,6 @@ CONFIG_TEST_FDTDEC=3Dy
>  CONFIG_UNIT_TEST=3Dy
>  CONFIG_UT_TIME=3Dy
>  CONFIG_UT_DM=3Dy
> +CONFIG_I3C=3Dy
> +CONFIG_I3C_SANDBOX=3Dy
> +CONFIG_CMD_I3C=3Dy

In both config patches, you need to use "savedefconfig" when adding
options, not just adding to the end of the file.

--=20
Tom

--7+3GSbJOIXYOyCj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUXyoACgkQFHw5/5Y0
tyz3jQwAjgHYSR3Dn3jXk/YR7AfCRpVD+reunsJ9wrIm8nPH4ucvs/Kv8B61WsZW
zKn2QZL711NMp30EZxZlaTrhidDg9bmCMCO90zbiSvaVDY3g1QGSqVWi3x5jOvKo
UoCypECBzP/Bpy5qsPblcbRUdgUNODq+GNOfBp9AROeCaR56otfx1IDjzPs6jcx7
aOgvPaMkyB1YrE9MPlAs7Uv2u99vqDRP6lIpYEZzyWxWavQKm+9gc/NPLCEdZJqc
nDLMZXF4OlfEuYNUEYE6WUc1JiG/3uyb4O82Z6wS9dBEjF+ErYgl9TGggN/1RRK0
/aPYdi97E55IEClFY1J1cRT0WEhcd7w7W8PvNLx8ikHg++VBAiTncg8ntDDE/Wm0
a0qn3KRbiOooA4sngkOT+nnrSfuWYxOy6h0CuWXDPstmU4sJZxpwsQyxLa0XXeU6
/YR32CzPNKwyieMTsflMgtHgDrGmjKl7bRx9/nLXxzVlJHNZ45WlTcpryqKiEbs5
CftOpIsR
=c21e
-----END PGP SIGNATURE-----

--7+3GSbJOIXYOyCj7--
