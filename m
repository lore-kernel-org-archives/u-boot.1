Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD723C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50BEA87A47;
	Wed, 25 Oct 2023 01:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H+bn8/bF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D5586FB9; Wed, 25 Oct 2023 01:17:37 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20A8786FE3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a90d6ab962so39097597b3.2
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189436; x=1698794236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qQUUlAs+e5qtgBWp0CUp8YoPCMxEe8qDXpj86ayp7kM=;
 b=H+bn8/bFiXtoi5NLVTw9L/jTG7M6Q4dsH/YXxski1/X99y+w2EQpXLtJtxXtLsHSJ2
 a4S9JJZm4xLax4EQpoUU0VJMA7+RJvoQa1/Nqt1TivXDLF+1mPans83+V76LJvKA2n4W
 M+4kVCMm4LWgGq541sM+ZENay5AFBwWFAnjwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189436; x=1698794236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQUUlAs+e5qtgBWp0CUp8YoPCMxEe8qDXpj86ayp7kM=;
 b=rqyh4cHR8v4KdVLVENGxWjRkndBaIujTgXwNrmrooAADWCZqm+eaIb/BPf7YfIh/D8
 Xe420kJ3hGpme73D6Cg1Oeuo+JIVDFHt4MTY5NuzkgIko8DtnE3jZ2vdppHkjQg7FdeG
 mz8d3fzIaDi0kSeTCFqF4xScrCsOip5nJbW0+z0Mu2H7Sh2HJ4ynjeyVy2VmHe0B+u/L
 EnjFQXNl5aWHFBBKCbj+AuV3YNpHCwHPSvzwvnBSpILkjQmqGG1mXhb2leAWmo8aPVSJ
 7QIfIW4sEaHdtScoL2/L/ACAkOMiKN/xag9ck5AF94GksLYTbzRrq95qbnYKQloTEroq
 eYJg==
X-Gm-Message-State: AOJu0Yy3Nz7WStxLTS6S5yWhcS9OPfckIDoP5E92UKitab8UDyLlK4Je
 lEt9/xj3vAaez8shxuQhGeTNcP52uZmfTOytiqfMQw==
X-Google-Smtp-Source: AGHT+IG8f183LoalMf4rAgp8QiIoghtCamQ3VVnZ6Bq1kJufc0dZEiG9WOFb2Har87Y2CzWse5kE8g==
X-Received: by 2002:a0d:d8cd:0:b0:5a7:af65:4ec6 with SMTP id
 a196-20020a0dd8cd000000b005a7af654ec6mr16774524ywe.32.1698189436751; 
 Tue, 24 Oct 2023 16:17:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 p130-20020a815b88000000b0059b20231f1dsm4480966ywb.121.2023.10.24.16.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:17:16 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:17:14 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] sandbox: add SCMI power domain protocol support
 for testing
Message-ID: <20231024231714.GH496310@bill-the-cat>
References: <20231016053946.470458-1-takahiro.akashi@linaro.org>
 <20231016053946.470458-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yuL+LKIV08X+ss6V"
Content-Disposition: inline
In-Reply-To: <20231016053946.470458-4-takahiro.akashi@linaro.org>
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


--yuL+LKIV08X+ss6V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 02:39:45PM +0900, AKASHI Takahiro wrote:

> SCMI power domain management protocol is supported on sandbox
> for test purpose. Add fake agent interfaces and associated
> power domain devices.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--yuL+LKIV08X+ss6V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UHoACgkQFHw5/5Y0
tyy3bwv+MPQk1aov3lhsjHGKtW3+T6ARjIAnz34yWUcfmChfIr0pogpQCBV6Krzn
DXE2dX/89CULkppDcR3W0OUyqe4znc6FGzazP7CIAIwJrpddbZJO9JLDhF/KS0uF
r14ODLwd6xUlDthZNnJK9f+Ce73awjqUaBiYI0sDvc3VZtCxiQl1vPwvpp88Wwor
p6M6j7RY3X2epsFJYXZDpD0ZwoUaYUxSe0+feIV8X1mwiseBztPsIh1VXRUAXB4L
nQUBwgtSOuvhN1CMZbLSPcH5PuqCBF5CCDnXeXqbSP6d09xv0SSWLc8xzhH4hDND
YoMRPnA7Zv1nP0pkkcyw1CdDhAqp40XL/CVPI28UzTxCxIOkiYZTNpeAa6fd3RDI
IxOWFovViBWXqK5n6BmS4EUAmSnPHIyd33eY+J5dkdQ/DV/RTgiJgeLjkmqPuUWw
Mv5eJQdCY7z4IR2FJKTrAXfOjo60lccTdUR3hhrBA2ZKU4Uk0KlGznhAV4CmzMCD
SA3YY5Zy
=RHCG
-----END PGP SIGNATURE-----

--yuL+LKIV08X+ss6V--
