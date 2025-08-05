Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC069C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 01:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1D583A47;
	Tue,  5 Aug 2025 03:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cau4PEev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8817983A48; Tue,  5 Aug 2025 03:50:12 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474C083A1C
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 03:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3e3d31a9ac7so20037265ab.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754358609; x=1754963409; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kVMI+cDrj5XytlYeHBOkCVp5F7k9Y7hiHBx2a/akxjQ=;
 b=Cau4PEevCW5Vfie/VZ2oCI+507kZtsGJ/q8V9Xi/Yg+7CUNIghNBUS+pYyuv3/pbWG
 V6b1HjFzu0P/SM8HNvMbqtXZcOMM4j7IxaSIyYWGhvpLtX2uCfr+xAcVzIcYz5OCkvYD
 iPethEPzAWvgtTmWBV4siVBy4hLRydWuGCWd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754358609; x=1754963409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVMI+cDrj5XytlYeHBOkCVp5F7k9Y7hiHBx2a/akxjQ=;
 b=Wp0r/PJCFpCvX1Y3m2jgb8xUFrMdblpBBhQC1kZ/YEesE1qLiDHrC5sCaZlCQitGaZ
 T7MnA3icRfKxbEl09rKI0/WiyiVgawV6qmWkXhtjaLaVRjDKSfHhbEpHQxWFzL6E/Gu5
 NS2rkCkyCu1EEibPRLLwCnjYnOmshDv2pMvd3Lohh/XdJl+TGtS6DL/dYnaEDtcS2ht9
 XNJNskOwFq9N0iZeJeCV3uaPbX2Nmh/3RJRcE8XKDVVrDpI1PlkjVN2DcuxfcJ0Cy2pc
 XZFtCNZxFYd2K51OWjl8D3HyJqtiAIXr61+8KvC1C1I+a5RZPoNaaUn2oxJZyNENdldn
 SHOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWut1quMgNU5UFi2qjDBoVjmR2X/FlxfOM2rea9NmNfmsgNgFE9qPv/f14BmSsQ5USKIGDuADo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3aDPApoBONnycSi8fUJnWxO+JTk4jOrFyb2APDEq+Tm6PbsKz
 MLHBdc7T0PgW/dfYeFQJS00Xt/QF1Dc3tmOGiFPCgizd05ulrZcujbjMpdrwMKX+z6g=
X-Gm-Gg: ASbGncuLWgRaK/K0MH7oRvMiM6tIlMH7Hj3LrEJyhvYojM2oQ7tait/2WgsvyDqxGj7
 GQ2iVGKd2Kz6THouRqDNUsMR69Nxp+ovDrgXeQS8QkNo7pqOBjzkyeBaSmLNj+d8+YvC7Xo8r0W
 k28vyr7fFmx4qHzMibkxDaaNA3FnuTmy6+J8xFa5gqOVBVAIGE2iMBCWtCqzXUcl9e5GhiE9buq
 3QRw7WnuBOzi9xSs/e/mkO72FVr9SuSFyDMThwsEnPx1NSiJMa3GzvNaQm+q/58WxuDD1GaVaJT
 uJJ2zmvZpLUEvVGgn6tWKSpF/jIo9j9u+8tMDFtkYcmQ/rj4+cJJgkwn8fFuPZGU+uZdB+dgjAr
 x4/x0eP80x5nBKGMJ1odgau7XWZg9HRkKJ47tEvnHt3hwmGms0TJ/wakv
X-Google-Smtp-Source: AGHT+IEp2VbboEix0TFQ11Jf3t9aBdwbKkDi28p9Thk6PMzrF7aSWlAaXjxBchx8AZRJxWzHK+waMw==
X-Received: by 2002:a05:6e02:b22:b0:3e4:ac3:ffd6 with SMTP id
 e9e14a558f8ab-3e41637ebf0mr203235285ab.20.1754358608881; 
 Mon, 04 Aug 2025 18:50:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e40297c709sm46265165ab.3.2025.08.04.18.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 18:50:07 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:50:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] soc: soc_ti_k3: Add support for AM62P variants
Message-ID: <20250805015005.GG124814@bill-the-cat>
References: <20250804233718.1471877-1-jm@ti.com>
 <20250804233718.1471877-2-jm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ksi36MwzKhsjm1wj"
Content-Disposition: inline
In-Reply-To: <20250804233718.1471877-2-jm@ti.com>
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


--ksi36MwzKhsjm1wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2025 at 06:37:17PM -0500, Judith Mendez wrote:
> This adds a support for detecting AM62P SR1.0, SR1.1, SR1.2.
>=20
> On AM62P, silicon revision is discovered with GP_SW1 register instead
> of JTAGID register, so introduce GP_SW register range to determine SoC
> revision.
>=20
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/soc/soc_ti_k3.c | 66 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 5 deletions(-)

This is fine for what it is. But is there any clean way to guard some of
this data / tests with IS_ENABLED() checks so we don't grow every K3
platform?

--=20
Tom

--ksi36MwzKhsjm1wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJFjSQAKCRAr4qD1Cr/k
CtFtAQCyZV98PLK5qeHZUFUktfmblzqSTlcHsYN/pPwRtu1G0gEAwF9NW+79YCAx
NC9YbWRtjSIjedwEhbkMH+6jyD2cew8=
=JqJi
-----END PGP SIGNATURE-----

--ksi36MwzKhsjm1wj--
