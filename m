Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BC1C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0FC80F91;
	Fri, 21 Feb 2025 18:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XN+mDeXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEBA180F96; Fri, 21 Feb 2025 18:09:45 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88AFA80F91
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220bff984a0so47973885ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740157782; x=1740762582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F4zwV+TPY8UZNInQJylSdSCmxbz/EqtJLO4myiA5zKo=;
 b=XN+mDeXXjObxBgPoWYQeLVxhB2G8y4pDWxMC8i9Afsax+PI10faXAC5BmCcwArMqgf
 yxCr32RHZWluo6Mz9/ONAG1dl9a5o6x7tSvm8lAX8NEIEFzccZzEcNz7Pf0nvdV9gLYY
 sYJUwEU47djUAFjFPEgaFEFf28nULP3SI3KRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157782; x=1740762582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4zwV+TPY8UZNInQJylSdSCmxbz/EqtJLO4myiA5zKo=;
 b=F11wk8RqJ1Vw9aZLUCXfgXhS71WKjDqMlEj2r2HJ5UR1eW4lDDqKlUfO3UYpKCb4Xj
 wFOorGjpCkNo0P7asZGNDsb7amcujxk8TY0994I4JS1Rp5rL4vlOcu8hQkqTZAZJr0hu
 xOsOZCc37iLISiLdy9txtj0DxhmBEwu+wONgJYd9Rrdfa+xRe73Ay8bPlC4VX13hezPM
 qW564esvL5/Rh2DLLAT9XUKfi8QaJN/64xGwlm42uoWuWmyWS3rGMFhKTf8M669smWK+
 bsXF8RHYpka+Ddux3Ls9NK8Crx439E9P+VlNVt1Z0N+5HZ/LC0kakTiIOq+/fJihp1x4
 xBhA==
X-Gm-Message-State: AOJu0YxOEzMxes13loiekEF2oHnCqWHiIrHTibD3L/10rbxQUs5wgopX
 t564XoKpZA6Eg/dZ/MlMbLTPll0hFz/14l4XTz5nalcUBoduvtaJpBYEy2Jwgy8=
X-Gm-Gg: ASbGncvM+qZ5IK4Xjje2izrfNob9x76dFdmNYilJZ3BPuLAOeq1nF4eAI0rzeeYiTq/
 +WhQbUUugn3AfXxQC2SxBU0hbZbiXDi9D7yzwPuBAq43qXH/pp1ytim6xgj9YiskwVJttlFk6PN
 NpJfNoFxYSdYG5pZLGWz0GnqeUyLw2qmcJnhIFFW7qZS/chAFhBrT0U4HQ1NMkGRc3JvOs/TCip
 nD4I+CJzNQ1pfCaqzgIVsYkZY/Xqk1zOALRZs8/NS3/P2PUKThXK4tK4jqA4+L/KZu+XSy3v5Hv
 uE+jy5RrrymyeRb97/uLnPL4
X-Google-Smtp-Source: AGHT+IFYfkBNap521KpCeYVm2UzShRJhhia7ZIJviCr73WySyphsNY9RsMr2gsNw6S7r0TdsQ0wRDA==
X-Received: by 2002:a17:902:f64f:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-2219ff334bcmr74122945ad.4.1740157782114; 
 Fri, 21 Feb 2025 09:09:42 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d039sm138598315ad.133.2025.02.21.09.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:09:41 -0800 (PST)
Date: Fri, 21 Feb 2025 11:09:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] ARM: stm32: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD update on DH
 STM32MP1 DHSOM
Message-ID: <20250221170938.GM1233568@bill-the-cat>
References: <20250221170851.184893-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wb5ri22CHIrB8dnB"
Content-Disposition: inline
In-Reply-To: <20250221170851.184893-1-marex@denx.de>
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


--Wb5ri22CHIrB8dnB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 06:08:38PM +0100, Marek Vasut wrote:

> The environment is missing closing quotes for string variable, but the
> variable is empty on this system, remove the CONFIG_BOOTCOUNT_ALTBOOTCMD
> assignment entirely.
>=20
> Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfi=
g")
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Wb5ri22CHIrB8dnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme4s1IACgkQFHw5/5Y0
tyxxRgv5AYlPVrVY2aqfj3+6GqnQ3CFq1shBjgHS2jkhnl+zqsJiwSKekVQzlC+G
1mjzqbS4y+HC+YEIMtFFxra89/fswyyjmDFna+DKf/BdMClfV/nA/4FgrqX9m6Ox
HC+T0wfbm67I2S1SE5ghSq1qI7pbtnRNIq8nH5on0gpJ8BI7f+kcHeTCpFmPlVLi
4rj9PvAeG/+zugzNg8h3EDe/RK4lIO6YV6cf/mjk6Bi18JKmvgdmXntkhCse000M
6MXuHqBHqBRe7DXsRYQklHKcJOfY4T5pim66T2WhmfaKR63iyzg13bMM7aGaxY+M
47EWd5redmQQyufy5DB0RkFkVdBwC8No0VJLhrMO6qo6KNNU+ZAJQRBy+WjqhBxA
oZMBgzL/KVXiWdvVP5yy2TCS9IImgAXQNoX7RJZiLggQ2rfEY2vXgrfA5vzNy1jH
CN/cSk7HJ22wTrUZhThLzL+gTk2w59IMe3CgKQfcRXjvJLFRNFNd17KUp2cmMyX5
OEHJgADb
=I9/z
-----END PGP SIGNATURE-----

--Wb5ri22CHIrB8dnB--
