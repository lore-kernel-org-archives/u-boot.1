Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F9BCA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 19:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1FF683642;
	Fri, 29 Aug 2025 21:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I2toyzoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E9E83653; Fri, 29 Aug 2025 21:01:06 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA8383526
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 21:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30ccec928f6so1280239fac.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756494062; x=1757098862; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sYyscMv7J0FUHK+TCJg6YRATWD65NYAjNyhigzfZVb4=;
 b=I2toyzoXq/e3a3ZrQ0ndHsImeE8woNOVolY1jiQVmpnk65ltKC1B/9aj5M+vXKI4oh
 0B9jiSkMBFgzPsEZ3BcZZGzWqS2ulvOhXs9OMLntYn7iUouJw/3rsLaTjUdw1TbMHjG8
 gMd4joICIK/aB/ZDqtvE6k6SJGdPosyZt+rIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756494062; x=1757098862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYyscMv7J0FUHK+TCJg6YRATWD65NYAjNyhigzfZVb4=;
 b=WNPUmJU+PM4stxPeQSiucbN7sXR0j3XqIuQ1XZSUQ/5QX4LrRGhHYdeYtrCvKo+IMV
 2E1EAnea1XEeVnqRhV4xh7FWCweEcNy7Ujju9IX9zJG+DU2jPJMMMG8c8zgHffM3jPH3
 dnvwRRr3FePJolPKRaQlCpdI7plkj1BVg8HWe+Pm5suBEJ+3p1rrhJLUGpjWACT/XsMJ
 GRH8NL+EQanIxpSgwbEF79tqgR1lklHvAWkFG3DivQwdg1aD7Z1H5EOHYICE+aVOWmMv
 BkpTSG8iY7O8/owfLmpWW2XlKCV8NRUAID8jSoIOd+sbjzaAOVNlqhMbk7CCp7+qM3QY
 s3dw==
X-Gm-Message-State: AOJu0YzaseZyZcJwRyCX2ru9S4c+KyC97Mmz9ApakDtD3ww76H1DhVgc
 mz7/c42sZYEh8FH7focoKlX1aPDW4wjMhRpqpC0DzL81Y8PbiAHauDWinCBTMYzMVjQ=
X-Gm-Gg: ASbGncvE2lQMJAXb2gKnWf3/G/QQaCb1GvN5DOdJ+gFAKh4zT3R00UTwTndVGw7/K1D
 bx6rTp5tiFXH+CY0Yoj7iK5a4UrRLAzG0QeFc81usGr9p4ZlWNri8bLXI81aymJN5R1glZFRsyV
 KTMhBuuB5BpwJX1R8qcHPP59Y3hNHsnhDEN2mReXFiqatLCEHRXUj5Bnj8uHHaMMfh7O4MVV7Zs
 wM9OkqG1pRk3T9stf7zW9OPF422qhluPMGsu6SsZWRC3kn1o551ZHO/zd3jTuWCEIPGIs+AzWik
 7TnSbkWMI4RBt7NLOoTxVTqlXYWDrQrWdn0UrqT7C07A8jBV4vgEqspE8uQ5gWpC2kWwLCH1efq
 O5WA5P+wojGsHtSqqpvSGaVq6TL3zLdrRdRWS2eSwd49kE95RGzsvGoxOSdzm/XAjWKY=
X-Google-Smtp-Source: AGHT+IGIRZaTtzYqmrvBLZvgHagOetJqekH1tuTYqUwiWtLptdVBYw+Q+Z7yLQIt5c29WjOMJLriwA==
X-Received: by 2002:a05:6870:3d9b:b0:315:b80b:4f81 with SMTP id
 586e51a60fabf-315b80b5162mr1879067fac.44.1756494062041; 
 Fri, 29 Aug 2025 12:01:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-315afc59dc7sm1563584fac.10.2025.08.29.12.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 12:01:00 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:00:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v0] clang-format: Add configuration file
Message-ID: <20250829190058.GY124814@bill-the-cat>
References: <20250829183026.250519-1-javier.tia@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9uCArEzhlCMQnARQ"
Content-Disposition: inline
In-Reply-To: <20250829183026.250519-1-javier.tia@linaro.org>
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


--9uCArEzhlCMQnARQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:30:25PM -0600, Javier Tia wrote:
> Introduce .clang-format configuration file to U-Boot, providing
> significant improvements over the existing scripts/Lindent approach for
> C code formatting.
>=20
> Benefits of clang-format over scripts/Lindent:

Oh goodness, I forgot scripts/Lindent was even a thing still. We've
never updated it, and it's not even been touched in the kernel since
2017 either. We should drop the tool and also update our documentation.

> - More comprehensive formatting rules: While Lindent relies on the basic
>   'indent' tool with limited options, clang-format provides extensive
>   control over code formatting with 800+ configuration options
>=20
> - Better handling of complex code structures: clang-format understands
>   modern C constructs and handles nested structures, macros, and complex
>   expressions more intelligently
>=20
> - IDE and editor integration: Native support in major development
>   environments (VS Code, Vim, Emacs, etc.) enables real-time formatting
>=20
> - Consistent results across environments: Eliminates variations between
>   different versions of 'indent' tool and system configurations
>=20
> - Active maintenance: clang-format is actively developed and updated,
>   unlike the aging 'indent' tool
>=20
> Alignment with Linux kernel practices:
>=20
> Continues U-Boot alignment with Linux kernel development practices,
> maintaining consistency between these closely related projects. The
> Linux kernel adopted clang-format to modernize its code formatting
> infrastructure and improve developer experience.
>=20
> The .clang-format file is based on the Linux kernel configuration,
> specifically copied from Linux kernel commit 07d9df80082b8, which
> itself builds upon the initial introduction in commit d4ef8d3ff005c
> ("clang-format: add configuration file").

As there's no change in .clang-format from v6.16 to the commit you
mention here, I'd rather say we sync this from v6.16 and so that will
make future re-syncs easier.

Then comes needing to document this. We need to update
doc/develop/codingstyle.rst to not talk about Lindent and then explain
how to use clang-format with some examples.

--=20
Tom

--9uCArEzhlCMQnARQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLH45gAKCRAr4qD1Cr/k
Cg3zAQD4+jByb3SLVpD9bGxLd5X53eShEEu/6Ki7Ipjuvbzb9wEAuE3GqJOMZelM
MC25oeaBkcGtbosEeTtOGrHiqumbAwA=
=pjm7
-----END PGP SIGNATURE-----

--9uCArEzhlCMQnARQ--
