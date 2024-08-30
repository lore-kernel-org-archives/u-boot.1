Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33FACA0FF1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 13:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D63C88C19;
	Fri, 30 Aug 2024 15:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lfSGiXA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 690C488BDA; Fri, 30 Aug 2024 08:59:52 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EBD288C23
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 08:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcus.folkesson@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f3f68dd44bso14624201fa.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725001189; x=1725605989; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RB65wFPgpqXCMnZtLxD5+yiyEGbr2SfZBOkOdjbFbWA=;
 b=lfSGiXA8T1D53EvCxjGm2MPhXjC1Av4sc+YTqljHkOulnowwm/PNARz6Bac7IaUliR
 9zxl3O09N1IcFEXSCQZZ18RkVILNBSS6etWZUtcaXCAxAwa4t3PMATpyGOUVoRMz/aoA
 iGN2Qjf1ur+vaD5J8qYs2UAd/ss9dIk7DQjmwWNV/wcn7ul2eC0FPVO92/lDgoAgmi1H
 jfSgX4MVzcSZWf7q5q7/F+i8S7c1Loz3cs/bSwkyx77IwLoyqto4yYmBzjRuj9hJp/gU
 qSIuW28fz5ZZBnAEKF0A0PvXHdZInTlajZuiZ97V0ddySMVY9o2wx6QQTg2XM+bvQT0x
 rWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725001189; x=1725605989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RB65wFPgpqXCMnZtLxD5+yiyEGbr2SfZBOkOdjbFbWA=;
 b=wnwQC9JWFLxRP8P6ZNeizSoiuf7nY1FbPZTg32aN/ZqtST8CrsYMTnt+8tudhxZbVX
 GubbE7k7Qo4OjApzcNuECC5qOuQzUPpBTZOMQd84nCj3RfB/iA43XVEKDEsBbuAMWkFT
 3P/avREwYZzURMA0ltDkFOTzx2yrytjP6GVWbibdoB77VEAbP60+rU6D41w3prQBHRC/
 5pdOWj58zNP9oNfQqlg4GWeCKNdNAbmUkQLZAHDYjKVPZQylUgxNPLG6ukSmAEChjTqv
 a5/1kJpC00/cqjc0qwT2LxGVWLgnaZSmE6AgSHYpokAaogWcPS+Jry5M0uEUbco39Rzd
 mHwQ==
X-Gm-Message-State: AOJu0YyfHnJSKA+/DdgB3kyySPmEsanZPb7OOE0NIAKE64FwfOQgbhpo
 JSYS94GeydqN+CeXpBeiICUaEIR7Ipx18X7Wouc2Gie4JTvSkKyTkExdp4T0
X-Google-Smtp-Source: AGHT+IF1TW6VtA1Bhy7Io7Q/9kyAQQ9vvlVbLqJsK74xOFM89u8iwfBJAGQIJfjNFy8hCQMrh1Oixg==
X-Received: by 2002:a2e:a989:0:b0:2ef:232c:6938 with SMTP id
 38308e7fff4ca-2f61e025793mr8002911fa.6.1725001188632; 
 Thu, 29 Aug 2024 23:59:48 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f614ed1737sm5048191fa.2.2024.08.29.23.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 23:59:48 -0700 (PDT)
Date: Fri, 30 Aug 2024 08:59:46 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: u-boot@lists.denx.de
Cc: Alexander Dahl <ada@thorsis.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: remove unnecessary return value
Message-ID: <ZtFt4rBOzF7Qgm-K@gmail.com>
References: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bOKa5fasd0eN6+xe"
Content-Disposition: inline
In-Reply-To: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
X-Mailman-Approved-At: Fri, 30 Aug 2024 15:31:35 +0200
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


--bOKa5fasd0eN6+xe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 02:15:43PM +0200, Marcus Folkesson wrote:
> The condition 'ret' is always true as it is never set to other than
> -EIO.
>=20
> Remove 'ret' and the condition for copy.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Any more thoughts on this?

Thanks,
Marcus Folkesson

--bOKa5fasd0eN6+xe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmbRbd0ACgkQiIBOb1ld
UjLxAxAA0jhzYUjayuf4TVXt+EEZxpBfyoLdMgF3uOpUV/4EZfTG5Nsm4/K3xs3R
rZvZgDZHkfLa3JhSJLfZlTb9js9MfpDTQendAsz5o+ynq8KgUGJWhYJFdLA9VmgC
VBk9/wBMGW8n3fNGksPf5Lestcetsxju16Sb87RJrOtx8Ks36ErodRWz52C0pebd
0u2COz8GyRktXJCDUmLa1E+W0qq82qqUOmrMxJqnJzf1SPZ2K4dUp/IN3w2CqVqi
w37n6jXa5bztxcn5zIYG5jUsE9uMaVSiGxBMErS9DoYee4KLMA4wrY5Zq6XH5lwS
tlp8R7SnUlhy3QSdyGk/uqo47bdRyW7QT6ZPxlT4tp7C/JhSZThEUoL4MteFFjtS
ot8WSst7OPRiJRkUYkPiu6BtjN1h0DdZ9x3tnYibOZ/aAriVgJymBYpOBMP6+NcK
nJyJgUU4yNaZ5oX5cvhHLxOHXdOCqaQctIbwWHZWx/luyKShxutAwdWp1ohMnl46
b4eZ9fDqoAOUrv39oaZeaaYPZey70MSBeKH4zA/VQIdZbACUDBDDd+5T8lERMjI1
n4YrfBc+Zi775X/TM/rx6m9q+VPC3p9HUIFAeWuBOQnkOLl37tlGESotIv5SBEnz
hrXAdlqcJgYTUUD603FdxzxgEaFHQuaL90TeJFuz2LH9rzDeI3k=
=5P5/
-----END PGP SIGNATURE-----

--bOKa5fasd0eN6+xe--
