Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3BCC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 19:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2AFA86F3D;
	Tue, 24 Oct 2023 21:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FBvAOrY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A87C86EBA; Tue, 24 Oct 2023 21:28:44 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0948C86F3D
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 21:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7c08b7744so48348167b3.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698175719; x=1698780519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4TcRnaApQFZ78qjNxt+RHrj4a1qDRdRFqfXSBMLAZrA=;
 b=FBvAOrY1N7QZh0D82LJsJisaZYwfr/sfheTos3X2dGNuF3mXzf8DVn1jIjGEd31bcP
 pbqHmBgPswIq+wtYGpshqTF4RsyxLmp9AqHTIjmkk1W5Iiss51+D5eXw7H69yx/aeW7W
 9nXMr+B7N9v5YGPs+eLs8tJT5ltmtJyfuEutg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698175719; x=1698780519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TcRnaApQFZ78qjNxt+RHrj4a1qDRdRFqfXSBMLAZrA=;
 b=cXWFD8DgFe2KP6vgZKXfcZjjCOSJTG+CRlyNeyHIWlvUAOEP1hub03yIXrWksosbkZ
 94NQc2IcJkd7Q5/JGbVa5xhL/7S6gznAoDPT/vNybiGkfQC4+BvWRP+3+dcLz3wrvu0o
 +X8X6nD3AmZGrKPcYJDyitOB0UMRLeNRgtal43YY8XXAK+m88Gqmom2tBjE5qjLdYeXq
 jThRSFPvak5B1OjSdZDB59synLVSBRAoqJt3NKVqwLOm1GsW34WTT+M2Udt2YQkCZLcy
 sKxVxf7acoFBBHJhd5nTiM+1WJiLy0evS4peBD+o9bth3HqPtVM70LrTZOhcfsUUmmNX
 jsgQ==
X-Gm-Message-State: AOJu0YxZUdC2ebBWbr94Y+6u589V0zUx/R7C7WPw0pbmHu1scxEmyQG+
 xIBg+/eizgXtdA8X5Xio3ciffg==
X-Google-Smtp-Source: AGHT+IHFj9p5MBLSl7CIycfiQAYF3+ByB6+xmaLElnG8Xxebaz2AHxuNjEpxUpNyPGQK5fn326RQLA==
X-Received: by 2002:a81:7356:0:b0:585:ef4e:6d93 with SMTP id
 o83-20020a817356000000b00585ef4e6d93mr12801617ywc.47.1698175719444; 
 Tue, 24 Oct 2023 12:28:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 i138-20020a819190000000b005a1cc37aff1sm4268668ywg.20.2023.10.24.12.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 12:28:39 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:28:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] arm: init: add an option to use FDT from previous
 bootloader
Message-ID: <20231024192837.GI496310@bill-the-cat>
References: <20231024-b4-prevbl-fdt-v2-1-7822ec6b0b20@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kMq9KHluwdsG2vRS"
Content-Disposition: inline
In-Reply-To: <20231024-b4-prevbl-fdt-v2-1-7822ec6b0b20@linaro.org>
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


--kMq9KHluwdsG2vRS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 06:38:43PM +0100, Caleb Connolly wrote:
> Add a new config option to allow u-boot to reuse the FDT provided by the
> previous stage bootloader when available.
>=20
> On some boards the previous stage bootloader can populate
> platform-specific parts of the devicetree such as the memory node, this
> allows us to avoid hardcoding it in u-boot and instead determine it
> dynamically at runtime.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
[snip]
> +/**
> + * get_prev_bl_fdt_addr - When u-boot is chainloaded, get the address
> + * of the FDT passed by the previous bootloader.
> + *
> + * Return: the address of the FDT passed by the previous bootloader
> + * or 0 if not found.
> + */
> +phys_addr_t get_prev_bl_fdt_addr(void);
> +#else
> +#define get_prev_bl_fdt_addr() 0LLU
>  #endif

Question in v1 aside, why do you need the dummy define here?

--=20
Tom

--kMq9KHluwdsG2vRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4GuUACgkQFHw5/5Y0
tyyzQgv/TBaqRcwIMOj6m6v9dkMH0tdj/MgeHeUY4MnTFT4kj9zQm9WRdR97RXbp
9GI6BMKeZPlzvd1ULkNVg+SSmh/dqWIjQALPA2N1m3k89wWBNGNm49ulf9qnmYkR
BLhIRNrbfgoTWJuVepo9Dkl/nrGyoxsEUG9Vt85CMPnug2yuiT/kqkqnjupNlkXg
OktbqG8R3myNsEql7ecrtnPjeuEFKA+Mn9Arynvi40muiD1CmB3uXfQnn36RCA3n
hA8hssvjWe1mSgGdv+WpTR0xvxsGa7ualbm412HPQbPHQaY4E3ReO1zHt8OxddJ7
WNjij5dp/9Nx9yWuBya+gpM6cx1qf1fpSDq+GGAqX8mKnE2z3WRYuJXf4sl3eAKk
cXoLPZ3/KodPi0pShz6+hQxSUX0Z4RbFkSWeOX8/wPfa52XnrFsT0hPJv611zWKI
R3kkTSKgi+GHVeyqrBkG0jGm8/PVz7uccmTxTlPoqQgx5pUABQbuYuu+ZUL0JIbd
BPHbK971
=kHVJ
-----END PGP SIGNATURE-----

--kMq9KHluwdsG2vRS--
