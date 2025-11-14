Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C89BCE8D44
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529DC84132;
	Fri, 14 Nov 2025 16:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ngKzYnlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E92284141; Fri, 14 Nov 2025 16:22:42 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 381F784105
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4501b097976so1027673b6e.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763133759; x=1763738559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0OpP25wMjrgj62pqTtMKC5lUyIPuAl51ZoOSKtHq+2s=;
 b=ngKzYnltn20acur+bFH8IJYueIh22jcEjdrx0Kf880l7l2kz33VEC/e62mafxBK+Qf
 R+8QX9FlyqhoQyQzzRX4NZQdDpRL0jnLTkKUbpJSfiHxmWJJeECmWN4gQdANpo4DfHYX
 XuPY8oT6J9TlkGWtOgSjHQp+aAj/QJmQn9NMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133759; x=1763738559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OpP25wMjrgj62pqTtMKC5lUyIPuAl51ZoOSKtHq+2s=;
 b=O0QbqF+88pM5kIlb0ioHAC1oLdN/EJy7v6INmKPeSitcnpkVxf+HZOV/+ndibixMUw
 ieIqFu7sDSfWwrN4lDtaM/UalZnXGjrBG28ybevn4Sk+Ja8HR2ZXycZcpQ8yY3ylHPJ3
 W24XParfhUgat7+5wiLt4e1svCBkgKInCeDEJGbYQOfUMbBsebEaeWcWCwft0E9FeT+V
 D42El+/kBZ2Bd5K8hJ4RW2AckSBAafpV5HEEHrtchKml1yTZi1uoaB10TAdUOTzt5A/9
 H8thWaig9PlZU6QRwcyHcy+mxzbcxe+2Tebt6WbLYg0kEXanuP65Ho4CYJn7PiYzkpdJ
 jLiQ==
X-Gm-Message-State: AOJu0YzNtuj6H+ykaRHexo8j0055WJj22z5SMcC/eqP8/EmL7/syA2lm
 MwAHZYJk3bil02vi/XADocfoU5iJSh8uCwiNBGDxhKKIU8HGRB8FVw/jRxsG04T5N2o=
X-Gm-Gg: ASbGncufciCt+8UG8gTROeBza6QfL1gcJgcx48+3XvOmBvFXiS7ZAN5rm9hZIcJ0qpE
 5TjcLWEJd5Vcchubec5FKF44hzNDJa+zqRbnOlrmZ3QFdAHECoTg2VbknE46ZJxt1o5+2SQMgV3
 Rj3CvnH8R40aGZVYkd0e3grW1Xy5uS2SVXX2RJUyS8PLW0kbZhUmtHSFiFp2bXBrar4gu+Kook7
 Z90UYsrlrUaK8aFuiUjkpTW1rBd/dL554Q3rtQSS9ddO8Ufnhq/WJWfjVLSBjXAKhX7KRJCSgCj
 dHeoGIi8SiS0DooQHmFXy3OD0S8FbYQ+x1dbvIR41GeB3/fV+pkl7lbtJzRLFYlO6EHyq64jnUZ
 cshP4TQP4U6cSmoCFGfjzotjmH1wyXqDyfpqLzL6gfq9xIRl1rlmn/go0z94e+3cm81flbFQTBa
 ehzJYGNlzpSsWfU+eSG1XFY5/QRgpuGnXYfqFFyZM=
X-Google-Smtp-Source: AGHT+IE4I8Tpg4LBhnRwLQuFBB7IRLOshRVlr/uj1g3s243ahAulbh69CmrFBlhIPBstOY/HSyuYXA==
X-Received: by 2002:a05:6808:3096:b0:450:65dc:1fce with SMTP id
 5614622812f47-450973fb954mr1551819b6e.3.1763133758918; 
 Fri, 14 Nov 2025 07:22:38 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6d7b24sm2081325b6e.21.2025.11.14.07.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:22:38 -0800 (PST)
Date: Fri, 14 Nov 2025 09:22:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] drivers: rtc: add PCF85063 support
Message-ID: <20251114152236.GB6688@bill-the-cat>
References: <20251114151255.2008694-1-mwalle@kernel.org>
 <20251114151255.2008694-2-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zJs7JjGVG+dGuJXM"
Content-Disposition: inline
In-Reply-To: <20251114151255.2008694-2-mwalle@kernel.org>
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


--zJs7JjGVG+dGuJXM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 04:12:47PM +0100, Michael Walle wrote:

> Add support for the Microcrystal RV8263 and compatible RTCs. The
> driver's name was taken from linux. It should work with any NXP PCF85063
> compatible RTCs. It was tested with a RV8263.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/rtc/Kconfig    |   8 +++
>  drivers/rtc/Makefile   |   1 +
>  drivers/rtc/pcf85063.c | 107 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 drivers/rtc/pcf85063.c
>=20
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index ed903999f06..2336f2e57c9 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -161,6 +161,14 @@ config RTC_MAX313XX
>  	  - Temperature sensor
>  	  - CLKOUT generation
> =20
> +config RTC_PCF85063
> +	tristate "Enable PCF85063 driver"

tristate is wrong for U-Boot, only bool is meaningful (and I need to go
update checkpatch.pl to complain about this). This is I assume otherwise
checkpatch warning free and compiles on sandbox?

--=20
Tom

--zJs7JjGVG+dGuJXM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRdJNAAKCRAr4qD1Cr/k
Co0TAP0RP/8CkNNtH5bUvtQslLwkHDz7Yxqj2Yhr+kO+/cgSZAEA+Tem5vCdzYPR
kNL5fCT1EO1N0rWOFkRrW5QZWRQG7wc=
=1L+n
-----END PGP SIGNATURE-----

--zJs7JjGVG+dGuJXM--
