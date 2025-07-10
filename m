Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FDAC83F0F
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 01:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C3F83599;
	Thu, 10 Jul 2025 03:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P9d+ivjH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54487835CD; Thu, 10 Jul 2025 03:58:34 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E96D6834B4
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 03:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7387f21daadso837257a34.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 18:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752112710; x=1752717510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z2Lryxcgqk2oR8Hoyi5QtScBN7/3K9ubmT5diY4W8Ls=;
 b=P9d+ivjHQEHhuXKXRLswMSy+kirc/DgCMSR07Erc+yibnXqWqWs/ooPt+167Z8GhV7
 M8g+1xnRYs0QIZCcUuCEAXKjqjI5WH/JVCh46Ka/xJN8KW+8gdeSFLlwJG6tUxhAtG+S
 oU3L4sbE0ZZZKzfLAxyWq4Vv1RDTr+vKz8USA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752112710; x=1752717510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2Lryxcgqk2oR8Hoyi5QtScBN7/3K9ubmT5diY4W8Ls=;
 b=JXBRbw8B2d14czkR76dFIc8BgzSFx2qNwiBGaEe+xusHMLR9FmjVJdndl5Hxo0pw/5
 j4gZL74Gj3RpPvSPHx+xlWb/cymdAQDAfqc3jVhSuy0bIqK9vM8xx0R/xlWNHvIaQyW8
 +faabWQgxYwGnjSjKwZhQ31WMxG857j1sM+5wsxP7QVhUuvxPOmVa5kWtsGq8NiEZpAk
 mULoCfyNWuZGD566DxD/cDgZ4lbanfPXRI/+p/+orttw1DKcq7k8ZhVjvEBJ0CyFXx+s
 9NOtWY7hWXEU5uSkrEixRgbZB2uv/cq0+//85g2MLVJI3TyX/3mjPPCJXWuAUTyuljRR
 uttA==
X-Gm-Message-State: AOJu0YwR51gpZIe/opZ0cPBEb/IXuM+WCUGcmLAiLGTNTWfUvjw3tPeC
 L5LUCVjkjzrTFDjAhF5GlCkz2BcL2LVEH7WKGyJ8hQLVMc0OlwYjlhdexMZ4M3OwY94=
X-Gm-Gg: ASbGnct9F3O/IDXZtytIB0Fv9PfU9ZICw7oej46lkKvnIZX/BYtxMecdc3mhmV7U6Tv
 4zBxYvFqjenXFeUs4NYUJnX79sNzNHp+ZNSGOrIU09Z6r6TMfF6mWQ51acvm6wx9M2VRnIL54o2
 2PZF6tCOcsOfoYXaIDac7+99qt8yqI18HZLGuuQiPJbGJA+J5/gwvx6gdIfMPOKl6XmI4Js7xJH
 TSAo0uZVBT1rTIMICGAFvYQwIuDXrlU2mvgdT5ExJaTKpL7eJZOqantgt40ER2E8753ubFUszOl
 0d28ZRFHil/JEmLUjMzk3SAKVLooHMKM92dVF84YDxdR5vZVTEzXUCP4hGP0hyMsScfwI4drnxd
 kWvBUUtNaRf4K0OJFm1Pq4KqDpJH0Dik=
X-Google-Smtp-Source: AGHT+IEifsr7iMbWbzxa5diyKlnlbRCSnDaL21/YaNu1JaJ+M70PAiNjVm5rFCUgvmhtUr4BjKnvdw==
X-Received: by 2002:a05:6830:4ab:b0:738:5294:785a with SMTP id
 46e09a7af769-73ceea8bc95mr997765a34.6.1752112710609; 
 Wed, 09 Jul 2025 18:58:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff116dd664sm112746fac.42.2025.07.09.18.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 18:58:29 -0700 (PDT)
Date: Wed, 9 Jul 2025 19:58:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH V4 0/3] cmd: env: select: Add output for available
 environment targets
Message-ID: <20250710015826.GY6424@bill-the-cat>
References: <20250630151232.39100-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2iCeue6P03NexyQa"
Content-Disposition: inline
In-Reply-To: <20250630151232.39100-1-cniedermaier@dh-electronics.com>
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


--2iCeue6P03NexyQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 05:12:29PM +0200, Christoph Niedermaier wrote:

> Add the "-l" parameter to the "env select" command to print the available
> environment targets, convert all argument parsing in the file nvedit.c to
> getopt() and check that with unit tests.
>=20
> The first patch converts the parsing of arguments to getopt() for all env
> commands. The second one adds unit tests for checking the env command.
> These were used to check the env commands before and after the conversion.
> The third patch adds the actual new parameter "-l" for the "env select"
> command.
>=20
> Christoph Niedermaier (3):
>   cmd: nvedit: Convert the parsing of arguments to getopt()
>   test: cmd: nvedit: Add basic unit tests
>   cmd: env: select: Add output for available environment targets

Can you please make a v5 that's run through CI? I saw that am64x_evm_a53
fails to build now and I'm seeing the tests fail too:
https://source.denx.de/u-boot/u-boot/-/jobs/1196652

Thanks!

--=20
Tom

--2iCeue6P03NexyQa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhvHj8ACgkQFHw5/5Y0
tyxs7wv+ID5uvBEoQ0URXY8cdPYJU+fJaiEm8sLLIpjIPve/GX4Qi1sTWiSeu8ZU
t0A8Kt4U7Xj4RMc0BVrmzPG9y6MO2a4ypd47rkTmgJW12u80EuqBc8+495kZluUP
NkP6pJpp+1Pnn5+42zdSmuPrtP9QYavFDEQVZmQcTXv2MtqVYytiwxLZExOdMNlI
M59D49+g9R894LC7cszPq9MfCURHSbGCo+moCUAqjxJHSbG4c0fU2gSS3SORDXMV
7PkC0YSIuuImQFfNTcvXbLMEjkgmi33F8752P/D/0uoTj4i3RGKkNFoGUGWD1xaC
djdSUmtDDh/bbL7ths+CyPWNzYeFQToyb92fG3mFFmxmFezVQUqf+zc7Yqq86iJ3
ZcGGPrD4Ctnl7InHWHGG/9ZNGCpX5Nz3yEGyNmJHKUkGAl9IzOHokxS5nQjkRKf3
eLzpL+o+A/PaUnH8C6FlcPeB2p9BWogTs5Zp//HLEwj2TROZO5dVAUFaFYVWsNka
EGATf72X
=FcZZ
-----END PGP SIGNATURE-----

--2iCeue6P03NexyQa--
