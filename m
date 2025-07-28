Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FD9C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 22:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0571F82E34;
	Tue, 29 Jul 2025 00:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XsZumuiy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7557B82E34; Tue, 29 Jul 2025 00:25:39 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBB1B82D21
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 00:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73ff32d8b8aso997519a34.1
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753741535; x=1754346335; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DaZ21b/PlK23qUcRh2Vep8rnUol9ySnosa1MQExS/Qk=;
 b=XsZumuiykbStrlT1KFoFN2exZIdfzNaPDW6Hmf3lmEfX7gbZ4wie3eOSXxE6iqxmGO
 NlzXZu8UTSi9PY67kYF9AvVXdvzr+cWvwNdrGCo8R81wFJWnKCA0n3CzCkBWx4twUOXr
 MWYYd6fTga4R9cW0nnCSkXMWAmFSmtXjEmN9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753741535; x=1754346335;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaZ21b/PlK23qUcRh2Vep8rnUol9ySnosa1MQExS/Qk=;
 b=XeNE4ILfT9dRhqzWQ+pbYbS7Cgwccxut1A90gpNYF/xae8Dr1/f4msnaqKUFT3mrmy
 Fx1fASuN53QvXp7jIPx70LhvkcrhOZh8vHsc1zxb94joh+3Rt/yBUa1xkykQivjhcNcI
 7yKDNdBgYOrBSGxqIfw2mdEOY6Zc9tmgk7LbDQuQHiAutvpMjUseEwOO4z3gl2xUhuNF
 qTREPY9vGERpPCMMw3I1227hiEtBu+NUKj7pLZ7Vv3L9pB0XDAUiazWfj6gHkqMUaBMN
 mazSYWxcRvp95Ed8f2ElVrQz9hICbAuIdakWzQ6Ns5ufZ07CLJNb2v/sxngFbOzQU2ih
 Yl0Q==
X-Gm-Message-State: AOJu0YxkVH4jbpiipSnvCytMLwseGKzH2/rP1JBoF246+0QU6X8/TYmz
 o4Hm0WNRJanR4AXkVPf3PaLGBy8popVbs2vJb8LJBTvkUvrmE14M89Y9mJlY1TeThp4=
X-Gm-Gg: ASbGncvo7dxDjSZ09kY932cD6vdOb/j+aC9snJPp9n6bn0bMMDmVPctJBIcm1rrAQxV
 kH95A2wNGHkrXTga4jrqjA+hunN0oa/1M8m0DNkyxYMspR9qobi877idILSRueoDjn1YtVzbUT3
 xEARHFYjbt3qOi+uLXPq9T2KX8lhSVJT5dXUM9xYrAtS8ioJdmw5QdOsIHeDI7cmc3X9q3zr9N5
 fT8/nRWA6EcEo2/zKZUpPuj+BCUmDCbsRNCXd95lFkBPnV/WMmkl/T0M4UP8eWVajzTB4bHk80Z
 iA4BgiQicN5nG4wJy44Ni3+QqRpp6MJ1vtn+uiQ28uwo9DEZNN6USSRSdxg4cFtZwo/Q9LTV9ji
 Z+OxhBMIgiSPgyhPbEn27TZhsg/FOV8Vd6I/DS6kxU8fkaTfPX9N17HUHXDlnYpLjoJY=
X-Google-Smtp-Source: AGHT+IHfaxKo3RSsP1G3BJEnYvTHlJ+cSpFRnvaW4kiUabpIS8nDgcyNvf7UPIrppZYRON12n3pABw==
X-Received: by 2002:a05:6808:198f:b0:41f:79f9:1b4a with SMTP id
 5614622812f47-42bb7bc293bmr7928030b6e.12.1753741535455; 
 Mon, 28 Jul 2025 15:25:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61913f96d2esm1009803eaf.10.2025.07.28.15.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:25:34 -0700 (PDT)
Date: Mon, 28 Jul 2025 16:25:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 1/3] Makefile: Add size check for u-boot-with-spl.bin
Message-ID: <20250728222531.GA1754718@bill-the-cat>
References: <20250708103959.26129-1-pro@denx.de>
 <20250708103959.26129-2-pro@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FnzVf1lM8EuqsF+K"
Content-Disposition: inline
In-Reply-To: <20250708103959.26129-2-pro@denx.de>
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


--FnzVf1lM8EuqsF+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2025 at 12:39:57PM +0200, Philip Oberfichtner wrote:

> Like other images, u-boot-with-spl.bin may be subject to size
> restrictions. Extend CONFIG_SPL_SIZE_LIMIT to handle this case.
>=20
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>=20
> Notes:
>     Changes in v4: none
>    =20
>     Changes in v3:
>     	Reuse existing SPL_SIZE_LIMIT instead of implementing a new option
>    =20
>     Changes in v2: none
>=20
>  Makefile           | 1 +
>  common/spl/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

This is not quite right enough, sorry. This causes a number of boards
(evb-ast2600 ibm-sbp1 stm32746g-eval_spl stm32f746-disco_spl
stm32f769-disco_spl) which have size checks and are fine to now fail
their size checks, presumably because they're checking the "wrong" file
now or similar. So if you can't see a way to fix both them and your
board then sigh, I was wrong initially and we will need another size
check method like you proposed to start with.

--=20
Tom

--FnzVf1lM8EuqsF+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIf41wAKCRAr4qD1Cr/k
CpwjAP90lvwSW0Eks6Anh0U5qgeE6a2cSEHif1oZiv/rxUv5AgD+KSoqDk57cW3v
Me04gZnrdnsHNotc85hdHC78pY7C2gY=
=fIHz
-----END PGP SIGNATURE-----

--FnzVf1lM8EuqsF+K--
