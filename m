Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13319F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95832839D5;
	Tue, 21 Apr 2026 23:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YMt9jpix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AEF9839D5; Tue, 21 Apr 2026 23:07:47 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462E0805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479d68a9063so834953b6e.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776805664; x=1777410464; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fe1cEI2qKUjacOMMPHXv0ezgLij/8KRUYV4rsTP3dUE=;
 b=YMt9jpix8IDjlMEtVgLfkAwdGykRaWYdU66y8gSVBreADWj/0MnXS304jCK1h+tZNv
 a+3nJQOfMF2otzKCDvsve9P/yc1XibyivmoECcPaRKmABsHv1Qd3fpDNPbPJPEIT+Ifm
 fYnsTKei8x9cOmE4/6BcRDUICIve/VwYI7yOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776805664; x=1777410464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fe1cEI2qKUjacOMMPHXv0ezgLij/8KRUYV4rsTP3dUE=;
 b=JaxP2Ys+2zEJo0I6llEEdhx3XHO87WNJw14hCUqI3SNPLylaJ8YhQeIh4I+wngHM2m
 ujx3PbZ3c1fhG9lfI77NGiyw7a7MvAeM0MoSWbmTyyT5BnuW16lOxoM6FgFB2vwD+nOM
 0Am6kzUrQp5LNUUIcXR4s7Ojne5jlRdlipVZuSTMdUmS67HjFJdT8P49DwfZBdYmY/l4
 w/jChhV0ILN4Ili+t/oXGncnDzE0Yva9f1iGSlqHDU6f3U8egHJZLaR+NPA4gIu8L6bk
 bk/ZUgQ4KxNYbGnzjIP0caK6WKSoxm5sXOykGeQaZ+Rb89c0xdEObJ/LqhmbVk/NHlDf
 Iudw==
X-Gm-Message-State: AOJu0YxNqiSm/cBqzDpf/r/VKgiw7j9p29O3rDDVPfK4g7YUzglOsqOr
 jXhsKCr5y1tZlvxECqiJSYMskNnyzWawQzELu1bXFRzucuZntOLYn+sk7Xh2Z9kW3fc=
X-Gm-Gg: AeBDieuLTmiHoMjxN7AhBIhANfhtVP8gLg5/VL+c8UgTzZDOp8/g1+1V6vBf9aPUCxe
 7dIssQ1G7bfQumIiqlAplR/S2WS/3cEadmlDQuH3Y17YS2LTleayjSvvTnDr1OHKWYDDU4ZJ8w3
 bGlb+gy7hbQtu45cdtymqOkmdohe+1nl1HK0hkDz8Ibwa+6sJGdf034lfYkgmJir08/7Yjqqaey
 A15m2Lqbv/haGI4cJ3bLqP6oshmMGpFkI9VvLmIRgAzDJSrIscMsTGvCtSC9Ob2XRhAd6HoYrAB
 o6MJQtElnvP440Fe/+CA1cdqcTpbaLiduBfHbLuDHRHMSal3LYi5UII+DvAU5wKT4a84OD1WnVI
 F4OY+nrywWtU3ukvLUYQsI5+tpgDbeo0bcdnFvmIy+SPNr9K/x8/iFfJ+GlmQtBlkgLBQOjv/8E
 yyurXTfP9ufidxHFv0WJ6h/DPTUwrilnBFoAvARZrlgD4Q+Vu3yAgMRfEX1rAFJhUGiE2UWSf6p
 yMBR8Fc5CxlDa9IfU3zaQwnSO873Id7M/HE4f1dTmzoY25+sqs4RZui9jv0Zg==
X-Received: by 2002:a05:6808:2f0c:b0:466:ecc2:6f47 with SMTP id
 5614622812f47-4799ca087cfmr10605332b6e.31.1776805663955; 
 Tue, 21 Apr 2026 14:07:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm12327115fac.13.2026.04.21.14.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 14:07:43 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:07:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 01/11] vsprintf: add %pOF
Message-ID: <20260421210740.GA1613912@bill-the-cat>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
 <20260401-casey-ccf-compat-v2-1-414d5b7f040b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EWJvLK3ry9yLMGiX"
Content-Disposition: inline
In-Reply-To: <20260401-casey-ccf-compat-v2-1-414d5b7f040b@linaro.org>
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


--EWJvLK3ry9yLMGiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 04:15:17PM +0200, Casey Connolly wrote:

> This prints a full ofnode path.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  lib/vsprintf.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

This is a notable amount of growth, globally, as almost everyone enables
OF_CONTROL. I think this is OK for now, but once the CCF stuff is in,
maybe a new Kconfig option and the CCF part can select it? I'm not
exactly sure, but, it's between 180 bytes (fine) and 600 bytes (not so
fine) depending on the platform.

--=20
Tom

--EWJvLK3ry9yLMGiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaefnGQAKCRAr4qD1Cr/k
CvlRAQCnJH/Wyod5mvg4HpSPNDmvGLWjzjlSJK/YZMGy4l4prgD/TUl8I5ArOSLH
h3c9UFNonmW6IM+tqzuU2DWs1INY+ww=
=qQcx
-----END PGP SIGNATURE-----

--EWJvLK3ry9yLMGiX--
