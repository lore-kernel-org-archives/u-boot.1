Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740C6CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E5486BD5;
	Mon, 16 Oct 2023 23:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J33t5sSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557AC86BF7; Mon, 16 Oct 2023 23:32:19 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2EB86D65
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a7b3d33663so68094347b3.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491926; x=1698096726; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Cp49yqIyUOkMvkEWiXR/+YoPi0Ad/ywGQEqwBfdWvD0=;
 b=J33t5sSHPdJso5dlDO0Ko3FyaRiCGxJ9OnuR5iN2ESh8TruUrjrXBkVH2RM8W2s1mH
 5FBwlVfsOAsV5oiJAQVOnNiootmjxjhZ9bQn6TPjnhL0YsqRI/pSg/fB7/fmQx1mfvo/
 z5parzWsrSt2EDV0gFC1iHpfgZTYSDhp5ufbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491926; x=1698096726;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cp49yqIyUOkMvkEWiXR/+YoPi0Ad/ywGQEqwBfdWvD0=;
 b=BnoJrceJpQVgIXhqVxdzH8GuZgesN4lXUaG/p5fdhqhsrCgKC42FmxSQfAxVNrMeqU
 A5CLLzadBz3T3htHUDbPKTrgJHQy3x7y71htM4sBcZV6+NR35t5sX0QvluW9GE1Wibtp
 dBmrwnmDY8gjBpseNdP0vtA+WYj4hrvPxBjeHuUYEb3tJy45aOVr7jOYwAYL3e//eH/C
 0j3+x3GyatFjXHIqmBCgR3hFhLj4Z8D2tsH3M/2/KeVmeKsQXFLEij2ttSymUeVG0NDD
 tFaMkGMmw2xjGv5LB0gbMBOkgziNVvvi7VtTyd//5T96NxecdUTv3udHQTRT3K6+ZCLN
 YaZg==
X-Gm-Message-State: AOJu0Yyr79jt904FXHEkeFleg7iBRvc228aD7yObV/Bu92xWRPf1dxgj
 WFSkgYppgfKQmKOBYVxHKI1LDKRGrYJHDZLpFGHFVQ==
X-Google-Smtp-Source: AGHT+IGkGKV8+3RCP0DZ9G9jiPL2bULlxwl7yzTWpzcruGU5itFBL/Wsl24kcZFPHPeZhFM2gS3/Gw==
X-Received: by 2002:a81:7106:0:b0:5a1:db6a:6459 with SMTP id
 m6-20020a817106000000b005a1db6a6459mr370645ywc.40.1697491925782; 
 Mon, 16 Oct 2023 14:32:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 j66-20020a816e45000000b005a7bf2aff15sm29935ywc.95.2023.10.16.14.32.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:32:05 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:32:03 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] command.h: Add a U_BOOT_LONGHELP macro
Message-ID: <20231016213203.GN3119521@bill-the-cat>
References: <20231007191308.2222470-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G9ltwKrfqAlezvhk"
Content-Disposition: inline
In-Reply-To: <20231007191308.2222470-1-trini@konsulko.com>
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


--G9ltwKrfqAlezvhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 03:13:07PM -0400, Tom Rini wrote:

> In order to be able to discard unused long help texts without further
> linker lists, add a macro for defining the long help messages which uses
> __maybe_unused.  This allows us to discard them as unreferenced as part
> of the link.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--G9ltwKrfqAlezvhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq9MACgkQFHw5/5Y0
tyxTCAv/WdnxEit+f1o1rwkejbPBAoRi366kfAsgo+ujLiTNV3kW/txAlyrTtc7U
AGOlTzDROKBA75aXVI8TwnN1r3+uNev/P7kyPGq8KBr+hYli5svkoE4OOaBm2ihA
8QxVcb7Ts7jDmSFl4RSGMMMPIAgXKIoKYr+sVaiZGGC8d6WdOlB/ghrUIlf8yT1H
nRIBysZaydimoUnSmkSkQgEWUcQMI8yNT+lDRuR/zZA3T58OQo3nm9U1gyZz3AjB
KlPUWAddQhRxRp83fl8RCJkDRFRCgjd2+DP8zCEYUBehRxE5p60xiNH6ZosCKX88
Px8cC/DrKXtmvjXjDt04vOFsyyWQJEFYCkpPJFTeql43aYjjjj2+vte/ni19gN7W
+G+eruyEG7eTBLI4pd8vSB+GCkcLEU1XCz5NYDd3nkmSQobIv0gSYwMHJy/VmRoa
H5L6wi6qMM+ykF0RncdGLKdQEsxCAhn/65cmJFI7Y83buHQUbO8qcK/gaLT5yF1z
l2BWLk2+
=BNR2
-----END PGP SIGNATURE-----

--G9ltwKrfqAlezvhk--
