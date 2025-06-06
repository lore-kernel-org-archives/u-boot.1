Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442E2C5B555
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6FD81FEE;
	Fri,  6 Jun 2025 16:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oi+rQcrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6392582AA7; Fri,  6 Jun 2025 16:17:19 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4494D800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2cc57330163so1554476fac.2
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749219436; x=1749824236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JjdYOhal4R342FRgPl2CG+CQp09BOIhFtR3Axz1vX/4=;
 b=oi+rQcrSFGlyXekINHF936VYsUNN5BsZpe6H9mJ3g9uaFLMj1cdAj/nvOJuInpr2He
 gaoSKMKAN/z0B7xk5FKjSbBUrXc22BnR7qoDNRmkRcOwksxkHsUTyIgqWcwJsBgrTkE2
 4Cj633E+NPKPh45Ef/Y0bCRVM5eWm8JOi5Bt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219436; x=1749824236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjdYOhal4R342FRgPl2CG+CQp09BOIhFtR3Axz1vX/4=;
 b=STWbfZmLFnLgbR9bOlpRvrLlhPm4xZbmj1CcIcmZOQiDMlOLCq9R6fYUH05RittorM
 /sQ9bS+HTVv4HRafWUv3YiK+adLeB0Y67IQdB7zy/a4q2ROMHfUjJFAGPxbHo/kfAzKZ
 y6dq/8TGZ/Wz0Ozb/NAckgun2ZwdqhqPh+KCZADn9XjIF/ZWpjSvYTYz0+VCo2TGmJxY
 CtP06FTEdmc/QDgS01SWTK8AfSzdIcmIOIHxB7vFJL5aqN/MBEMMIkOd725NccCltHD6
 G/ZRsQ1umWI7RH+LLhPvNEaSBdLyAz++97S9sZaxW5HbBbQtQ/2A/fMtr+mK56UD4CLk
 2djA==
X-Gm-Message-State: AOJu0YyrDeheTm78VdBTS6wVxT0fiQpJf64nxnrBlUGDah07Yevjwpx9
 mO+bnNaUW0KatgwBOl1EmEw/buVx+xsXrv7fsjrIpuRCpNAT7W8Pvkk2SyaylAMsHgI=
X-Gm-Gg: ASbGnctuh4mIegSWbWgh6YqYdT4YrMcp4pqAinDetJUYlpCWy5WWOwqRnnzf8tcuO4w
 E+lsy34zykhS70X5FLHK31zTUOJXwnMKXqaL1npRvux2NvvmdQZ2M540+cF9KQ6OeWUXaDGYFeh
 Ef6vXVM7DYTnmElDSN9oyLD9ercKIMABbe2WY0AWrCSuWvM+WCu6HFVszaMw9piSPaFQE8RXZSb
 MbLK0iSsCO8tbFB/Rbpe0OLnghVXqwREY3Nak0uzzOsbaX+OvY+vdamh2eHKF3iPYKJ6dw+4OO6
 TaPMGsfjji7w4tgfzdURGXOZnEkxxQ3+jptzQ0mbo00kHMKjjxgfHTgXNsLdnJMpNJLwQ8Dreei
 QEJkVqt5Qinu1reN/3g7yBcY=
X-Google-Smtp-Source: AGHT+IF7biPce+KfM9ylqhXQy4M5bn50E4/WZDdJQnltOC1PNVqNmkRXoF6Dx4Q+XLoyPAEVmWQTKA==
X-Received: by 2002:a05:6871:36c7:b0:2cc:3603:f05f with SMTP id
 586e51a60fabf-2ea0155a4a9mr2209522fac.35.1749219435881; 
 Fri, 06 Jun 2025 07:17:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea073afe22sm335844fac.50.2025.06.06.07.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:17:14 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:17:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 04/13] lwip: move net/lwip/dns.c to cmd/lwip
Message-ID: <20250606141712.GN1382132@bill-the-cat>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
 <20250606064211.3091237-5-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="khLhgThpVs/34z/z"
Content-Disposition: inline
In-Reply-To: <20250606064211.3091237-5-jerome.forissier@linaro.org>
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


--khLhgThpVs/34z/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 08:41:40AM +0200, Jerome Forissier wrote:

> Move the implementation of the dns command under cmd/.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>=20
> Changes in v2:
> - New patch
>=20
>  cmd/lwip/dns.c    | 123 ++++++++++++++++++++++++++++++++++++++++++++
>  net/lwip/Makefile |   1 -
>  net/lwip/dns.c    | 128 ----------------------------------------------
>  3 files changed, 123 insertions(+), 129 deletions(-)
>  delete mode 100644 net/lwip/dns.c

I assume this is copy/paste from the previous file to the new file.
Since I've asked for other changes, maybe if you do the move then split
cmd/net-lwip.c up git will more clearly see this as a move? I think you
you reword the commits with "Prepare to split $cmd from cmd/net-lwip.c
by moving ..." it will be sufficiently clear in the logs why there's a
short time of not strictly cmd code in cmd/lwip/. Thanks!

--=20
Tom

--khLhgThpVs/34z/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC+GgACgkQFHw5/5Y0
tyw+Wgv+NfU5lupeLFnulv6wQOU6MFlCSTMMMUcWrBlqaiqy706Fgd/mYOwYbi0I
PyVGMWQ6JMWTqXgb97XbTEFmF0Be07bXXUnHoPogVycDHMnL1hpJBz5LFJuOs5sg
gDtzolQ8CQMwx7pzh8dq3X+Gy6SVCMPN/+8Z2+1sb9ocVbhB3gEpvueml6YN4x1J
RBOsGdo45mmjvB4PLEf8TZPWs32DmJUMHv09NsFxzqHI6vVFAtMcAskaEMR9WAIq
tN6mLnAJn8f9r/V9wZIzrI4nAJdbFwIXtuPYoDw0u79kOamN7srULqT54/vF7fWn
Rb7/sIKdeDzewubXvucS7QrvYcTJfWGgaPvkMCvNzJ0IoiKSIs1EYyjLPDoT28wU
VUpNF6zzPPJEs8TE/3T+oP3GXIFSUAQrWrKHveZK/Wqj1kDRD6VD7pCIMn6rRjnU
N+JRvfMTEnYdNbiXgQhegVCseIQk7TAD/UhLt78hqSP9upWY8qcMZ7Hy37UNp02h
C5UIWK46
=zFfK
-----END PGP SIGNATURE-----

--khLhgThpVs/34z/z--
