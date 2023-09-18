Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87EBCD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A4386A08;
	Mon, 18 Sep 2023 16:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SgSrXkD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2031C86A08; Mon, 18 Sep 2023 16:45:53 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1466E869AC
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d7b9c04591fso4383777276.3
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 07:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695048349; x=1695653149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=isp2hGXl7nDbc846C13MYKtLFrolJrKS+y314LGoONg=;
 b=SgSrXkD58Ra8Szi5TNXtUL7rmBaM+CH5w/ESJLMYzbM+uXyrBiX84EfRfTFGnGwFTp
 8NHyqTvZsd59qHofjThvo/TPK/iLKgbC5RoGm7MX0sXN6fiHVkYITkrXqezof8NOBL0U
 Gjs1L8x4ypPC4IotZxujnG9pLA2KG9WsMFT8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695048349; x=1695653149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isp2hGXl7nDbc846C13MYKtLFrolJrKS+y314LGoONg=;
 b=tHg76NJR8MamyWh+3N8ZnGbbmubGyZ4w4KgtvuyCnBSyyEPJWOr88CjJ3GUWxnivxh
 PpWm1830FJUbYSHYyRuDbMCDLASIwekUb0BacUlPWrgTwCJkUT0eybqUhrOoolOOUhnD
 l87wUDyGdbfTy+NaWDqMR/1yfrIieu9NZ0MF5CQ/oPyArZAECulWs5h7IZFwxz79FphD
 lvsBf3S9M18dey17EiYwu9R+306aTIfUruy6MOk5GCGqEvq0PlehCjS6E8P9CqdSXmGd
 buvLQz3gaUbNPwtxqdKNgTvt+EmXSPfuOFOXknUM0w1lA3M1+1M/Rni+A9adPa5Nztwg
 ZGlw==
X-Gm-Message-State: AOJu0YyPiIg4s0NvyqTUR90fBnBEDVYoxOEyjsyFwEPNw0AUBeIsHCN8
 uNSuLsTXJHqQoehqmijUKHNLJQ==
X-Google-Smtp-Source: AGHT+IFilf4HhgFglL4EGUMwR9SyGB+gkV/hzz63LpzUjCCj+oD7G7sUG9n3nhE41xszaE7TI+6Fmw==
X-Received: by 2002:a25:4086:0:b0:d73:eaff:3045 with SMTP id
 n128-20020a254086000000b00d73eaff3045mr9493223yba.13.1695048349725; 
 Mon, 18 Sep 2023 07:45:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fccb-cc62-ada8-13e0.res6.spectrum.com.
 [2603:6081:7b00:6400:fccb:cc62:ada8:13e0])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a259207000000b00d815cb9accbsm2199892ybo.32.2023.09.18.07.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 07:45:49 -0700 (PDT)
Date: Mon, 18 Sep 2023 10:45:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: Re: [PATCH v4 1/4] spl: fit: support for booting a GZIP-compressed
 U-boot binary
Message-ID: <20230918144547.GS305624@bill-the-cat>
References: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
 <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
 <20230917192628.363502-2-abbaraju.manojsai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HJCqhLY5RlM7D46w"
Content-Disposition: inline
In-Reply-To: <20230917192628.363502-2-abbaraju.manojsai@amarulasolutions.com>
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


--HJCqhLY5RlM7D46w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 12:56:25AM +0530, Manoj Sai wrote:

> If GZIP Compression support is enabled, GZIP compressed U-Boot binary
> will be at a specified RAM location which is defined at
> CONFIG_SYS_LOAD_ADDR and will be assign it as the source address.
>=20
> gunzip function in spl_load_fit_image ,will decompress the GZIP
> compressed U-Boot binary which is placed at
> source address(CONFIG_SYS_LOAD_ADDR)  to the default
> CONFIG_SYS_TEXT_BASE location.
>=20
> spl_load_fit_image function will load the decompressed U-Boot
> binary, which is placed at the CONFIG_SYS_TEXT_BASE location.
>=20
> Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
> Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--HJCqhLY5RlM7D46w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUIYpgACgkQFHw5/5Y0
tyyY2wwAsn3TANKWyhxE2XmJPzVK0PNlHyH8S+WRHEUXXmFbjpliwqtwyNj4A55C
ltajTC7vNjEgdwBenqQmPadZpBMAL1F3o6BePI2wvllsplgptVndX74esUXn+baq
6nMa9Wwc1DfqSsuqBtnI9RZeE94E+tbdl9gh07xk21FVDn7hmCKkUaUTYlYT40fn
qt2XAaROoqxvTZvBhrI4klpXn+zUaxmIYWcdV1XCffjDSyEqOGOAhF9gXbXAzsFX
1oXVhO5YimgKh0zOqRA84h/6Y3RWR3oYrh6MNMDBBWyaJS4jzpnhltg2Oo22YNbg
O5Tti2OxKqAFM2JPCIOnQvxDqXoBF0b7ThIrrqt2rViPat0f54AnoD1Jkp3B5iky
n7vuunFo5rFyAWSEH3BEgFdWaxj+mgM90gN2t2d1kkGXDYcTxr3scccNd98M/ihx
SgeuZnf+u16HYO1NyIh1ryP36b1Qm+uyrtl2J9Az7bzBFfwdWNxZUCm873jbV8np
9EDIQjWc
=mqbj
-----END PGP SIGNATURE-----

--HJCqhLY5RlM7D46w--
