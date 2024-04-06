Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28486CD1284
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 00:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09B088163;
	Sat,  6 Apr 2024 02:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kKo9Ef98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29787882B4; Sat,  6 Apr 2024 02:44:35 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8E287ED0
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 02:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6969388c36fso12198536d6.1
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712364271; x=1712969071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tOHHX/rlvqquzgebOVFbv9Njv6rEByZhYjgO9yJisew=;
 b=kKo9Ef986K7av9aGcipqLiIYLmKQmDsUS6iAWaMYQ7WZ80eGJ8wy5Nlz/29YiIidUE
 +jF0JW+SPQXDhYFKTuyxDYtdD9+ixSHEV0trGfI7/LCXO2K4Jwr0Ohino5K24Wn/0Mkq
 axPUI1i3cl0S/5HKjPLrkMMn9oewWvPEeJLUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712364271; x=1712969071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOHHX/rlvqquzgebOVFbv9Njv6rEByZhYjgO9yJisew=;
 b=AkkCoclTnXvdEq2zvHm7dVYqQimdgQDTyDVrVUIRNXDEoOChwGG+hka4df3AWY+IlS
 KB0Tr/WPJwoeYMsN2nmeVSYWQGCCqdNeyHJzx0KBdKUjd4UB+Mvoa0FSTi1cpOU7cwHz
 2IC2xuRzJogmWat5mTZpmwh3wHenCFZfMuGkHrwMX9PdzzhgcNXPtZ5U1uu3qHuuMHSQ
 q6aeSMYTw26vn3/cf99KxV2ocUuYUNRyXD9pDXfKSQb5gfucbh5pLgeaMqEFbmHfoc1Y
 EE6fZm0yN7T8T1hKdu6Mh73JvWv3DuV4m/WGzJ8mQA8W2FfD6mPVtB2rTTFP1F5rYgNd
 0rzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIJDVMkcTlTYC0gU61yXwO8J6Ah3VRagJ3r0BrBG2WMRsDPqxWYG0m2cBirWYujAVtCkWyrc2ObcEtDEYZWSLW7LNJ9Q==
X-Gm-Message-State: AOJu0YyQ0JOBaXildyqfFTGZlqM1DzJrQ/GzWv2uv5itYyq13jgJg0c+
 hYznA+hKiQPse4C7+CVXy+6pWy8cP3m/19AZsTTbAZ4pf5cPE+QiERHN0SVHGwY=
X-Google-Smtp-Source: AGHT+IGboQv+QsNf/Mh5qlFWbBBXhS3L9SfNSX4JF0LGMpUnHYpFsRxqfO4fjTgjhAB64AYlMI8Eqw==
X-Received: by 2002:a05:6214:ca7:b0:699:2754:2e8b with SMTP id
 s7-20020a0562140ca700b0069927542e8bmr3088064qvs.39.1712364271393; 
 Fri, 05 Apr 2024 17:44:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a0ce34a000000b00698f9a12ccbsm1034957qvm.20.2024.04.05.17.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 17:44:30 -0700 (PDT)
Date: Fri, 5 Apr 2024 20:43:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom-next-2024Apr04 (attempt 2)
Message-ID: <20240406004358.GD114971@bill-the-cat>
References: <20240404215421.2151698-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tk1a8VSDLqCr5/rk"
Content-Disposition: inline
In-Reply-To: <20240404215421.2151698-1-caleb.connolly@linaro.org>
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


--Tk1a8VSDLqCr5/rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 11:52:57PM +0200, Caleb Connolly wrote:

> Hi Tom,
>=20
> Sorry for the noise, totally fluffed that PR... Please ignore the previous
> email.
>=20
> Some new Qualcomm features for you:
>=20
> * Ethernet, i2c, and USB support are now enabled by default
> * The clock driver gets some bug fixes and cleanup
> * Invalid FDTs are now properly detected in board_fdt_blob_setup().
> * The pinctrl driver gains preparatory support for per-pin function muxes.
> * Support is added for two generations of Qualcomm HighSpeed USB PHY
> * A power domain driver is added for the Globall Distributed Switch Contr=
ollers
>   on the GCC hardware block.
> * SDM845 gains USB host mode support.
> * OF_LIVE is enabled by default for Qualcomm platforms
> * Some U-Boot devicetree compatibility fixups are added during init to im=
prove
>   compatbility with upstream DT.
>=20
> The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea=
1a:
>=20
>   Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/c=
ustodians/u-boot-dfu (2024-04-02 22:37:23 -0400)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-ne=
xt-2024Apr04
>=20
> for you to fetch changes up to b2511143fba4c0631446c968fb4c0d962b01d850:
>=20
>   qcom_defconfig: enable USB (2024-04-04 17:46:48 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Tk1a8VSDLqCr5/rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYQms4ACgkQFHw5/5Y0
tyyn4Av/XTX6voj67WNI+1KvgLsyX2hB/B5S9hDJrg6mJ7dWtEyhULQQLJ+2yRsc
5EjKtA99NtNLScrYC2nKEfqThl6NjPdtimNwEKccfueT3mblR68KcSdQWjsqbzUf
EZm7BAKEyhtjcCIoP1o+pKYUpTI11NjZStXAWz0dyTNkMIS66F8AteLLCI7m7+4f
/i5b3tLbiaSBe6gZG4GbmkuqBYnsZRjmnDYpgswsJ3wmj8mimrZMfHp+KKKcGT91
yPr0zGI41HpWO0e93LLYyaWScfLQBHUjwEoSyp2CVlVGZG8iLgpX0O3Gsuh94iIW
3/NfaF1315TrgVge4jAPZaquaFuXVgiziV8TBF6IDnEANmqphLuMq/lp3qsiuiuH
nI3Rpr/v3f+jQBZgdtj1gBK7A5+GiF9ru6JUzRWKPHuQsRXAl7RJhftKvxIgrvxv
B+xfmF3CyLK9pGgV1bX+3dNt5obcL4jbl+5y6dSk+ZVttiaex6IDBfW0D7LT9oOR
EZ6+3JUn
=GMTM
-----END PGP SIGNATURE-----

--Tk1a8VSDLqCr5/rk--
