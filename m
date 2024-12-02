Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989ECE69E8E
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 20:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31BA2894F4;
	Mon,  2 Dec 2024 21:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hKDBKrq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97AD5894B7; Mon,  2 Dec 2024 21:18:39 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA69894A9
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 21:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b68e73188cso245446985a.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 12:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733170716; x=1733775516; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xcttBWOGrCVv0lBEm05xtLvPAj5VJljEMI79VKNgDbE=;
 b=hKDBKrq3ar8EsJTdTxZ/1RFi6HYeT8JqUAfjGNxEusFFdp47JCTubEMabGrOqNNq2K
 3kEKeqNeje5NPJTcByT/oMQR2mgL+FxmC9wwON6OAGI9yKzCh7SHjprWsd/tbO3no0pR
 yvJu7T23II+2xaAN9I9xWIbgL9hSuluK6WIws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733170716; x=1733775516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcttBWOGrCVv0lBEm05xtLvPAj5VJljEMI79VKNgDbE=;
 b=oXKS7ALbl+aq5nm3e0hhcX1k0IJiZhDOjge6nBbtPghsEM2ucRRi1stOTVbyAcxWwM
 HDBDfCOpEK52fYSqiOFkUJDCzPTMgaMSXpPsTN1DL/awSS1GXjUXs8R8MSnk0pXNUi2a
 SaRPMFQPgF7efDlTDwNJmsLudY3YhMLuyrWKUxiZX6SjUJqhJTtwOPBOzJtmQpEKSd3d
 ZegbXh0gaHOHWwy4itUD0HSZOEALeK35XbpMs0X82xYioWGgJM89wUnOHxRNyRj97q1D
 bdZhiul04braXxhqRMluLypCKG8ensUIG4p7aLcZXXDjJm/5JbcdA3w2r9iMcVXjUUGY
 vVtg==
X-Gm-Message-State: AOJu0YwzUJ114Et1sXDdKgOOd5BVREhAw/3nTnlcI5QptSaj0VPle1gL
 Uzk+aFWukh+ukI0ApW2/v/6vDN4LFgXCJ1k9oIDhYpgP9OS9GeCAqKG9L8OUNpM=
X-Gm-Gg: ASbGnctAoBfwZtzkFMLpLcaIQBwOF8yxxjpBThBvajw+ynLdmqxss+7mgJpXhVMNnMQ
 eK1upjmG7Kz0PcCyOx9WQXCO58JMdR2c5sPQheoYmcLxmtWWIPH174XJfHZcjk5mVVi593gfHfF
 yEKdAXey2tcYxOb5D2dMKdCreKdgiOePfN3LYgwbFKDEwx8lemLFN22EVOIeyGeiynEcVPazRdC
 A4v9bxtAoxGelTOgRKS2zxcwbWKnRWbEj6rTo6ZuxFqhOMuUg==
X-Google-Smtp-Source: AGHT+IHbxPo0hSesob7s+JpMW4WX/uj5gWPGqVQoauEILZ07sjrQ2JhdL/myEo3cuXbM1bRmTlP0hQ==
X-Received: by 2002:a05:620a:27c8:b0:7b6:604c:f334 with SMTP id
 af79cd13be357-7b67c4921edmr3720938285a.55.1733170716354; 
 Mon, 02 Dec 2024 12:18:36 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849c5a6dsm439185985a.117.2024.12.02.12.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 12:18:35 -0800 (PST)
Date: Mon, 2 Dec 2024 14:18:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 04/25] efi_loader: Add comments where incorrect
 addresses are used
Message-ID: <20241202201832.GH2457179@bill-the-cat>
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WPLiQ0Ik9oc/hQ43"
Content-Disposition: inline
In-Reply-To: <20241201152505.1666789-5-sjg@chromium.org>
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


--WPLiQ0Ik9oc/hQ43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 01, 2024 at 08:24:23AM -0700, Simon Glass wrote:

> Some functions are passing addresses instead of pointers to the
> efi_add_memory_map() function. This confusion is understandable since
> the function arguments indicate an address.
>=20
> Make a note of the 8 places where there are problems, which would break
> usage in sandbox tests.
>=20
> Future work will resolve these problems.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Please just resolve these rather than introducing a patch to then fix
them later. This is something that should have been fixup'd before
posting. Thanks.

--=20
Tom

--WPLiQ0Ik9oc/hQ43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdOFhgACgkQFHw5/5Y0
tyxBMgv+NxnaT2JQae5J7SDtwrjdzQdv1cudB/2usGyVzi0P2QLXwtS4c03feaZK
UNEL2gZWgxQJ7vfOk0xg5AzzeP+IG1f1vj1BaqwpXETI72SlDEHH7zuH35bdZ+aE
eftCC0cjLEgi43ldvl6Bonu5losQ37jywFooVGv3+eSg1vNXfS+f9oiYj/38mc3u
Mac4DuWn1L7Vb+198E+5S+4ihSYjEQzCK409C/+94cB2u+UWJtI/VJpNYGVfh74v
A3kygfypUKN8jqwELgUVbAPqs6hhHogAhvUH7sLvRnKKc1YFb2suKSdeXpTv0SBI
z2yVU5nAL7CnO7e53MpAn8tyIxaq8142+dtyhpJM3yU2gkDGl25zsr7UamtWFlA5
lTYU0RPSf1xKmo8v/lNuLPg62ckhDrv8FFGwAaFYT3A/HiI5cCiFD9uNZxzywzoD
dEEtF4D9Mbc1X7ZB+QqU4qgarS82hLrRLLq6HwZxvIjFC/Hkq+0OXGwToZy0bl4l
3Y93kfBe
=PRnq
-----END PGP SIGNATURE-----

--WPLiQ0Ik9oc/hQ43--
