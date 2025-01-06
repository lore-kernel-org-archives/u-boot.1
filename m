Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A68E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 21:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FA7805D7;
	Mon,  6 Jan 2025 22:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="geZRoUTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18FD0805F4; Mon,  6 Jan 2025 22:40:33 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752D3801DB
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 22:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6e9317a2aso1320700785a.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 13:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736199629; x=1736804429; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=049UxrqM3D1ziVNZUeW1ZDtOSAUNZhdyNaZj5vYPZT4=;
 b=geZRoUTxUbdNw1WSiLdJ7JyR4GorBm3leDsWiO11iIcZDTkVAUPBa4IDIryG5zsib3
 fW6xNg6fbF07Jr16hwiZEWNHCD1rrIF0OMSMJqtAYLx1pIjCZtFyZoCxz/yRRh0u7L41
 oXOHLmoTpLBeIS6mnpy4yPeblUn/Iq65Ozbyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736199629; x=1736804429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=049UxrqM3D1ziVNZUeW1ZDtOSAUNZhdyNaZj5vYPZT4=;
 b=WitRun/r2Gq2iMPPMmqForSxlPP3QQIUFvk90F0TFCvzDXm8U1ZI/C0m5KgZ99i/PZ
 up+mCHbIzEoBSeqYyn4QgCuGfa3xKvVMvjyjz4bfiY0FQ6fLAnO1mdYxSN1TIQbWjhIX
 EKD4N5HCnRcihcmcdzFU5IG+qWtHE9ZTNV3nrwNY14ebNreOsAhIUXSLFHFXkxfkHbeU
 /rK/VObaLUtLh8TqQ7WoT0VS1uLtCt7bhtEYwzpWrKFEWeWCPwI7IdKqi24zfKu9cpNN
 QOiDawYJVFRJ9lguTUZTtvBBzEg6MjMalmbtC6jMjm1qmww0CS3e7WEBk99WJUsxcXq9
 gq8Q==
X-Gm-Message-State: AOJu0Yz2IqbvwphcWP/vhy89XP5v5XLZAed94jcG7KkKYjqWHBhFNuZf
 jXHhiPOi8j10xa2FLQvdeXHoxAVbngVz2IDJBVW9ksh6gWU0tn4PqvScc04lG/o=
X-Gm-Gg: ASbGncvr75xK2YlV4bOIWCFT4EwYPt1uxF4O3XA7liueRnTYoH+DusjM4xn0KhF2YYo
 g0eePC3uls1mv/bY3r06O8vaZK/EDdkUvsTZXvex0Osd3uZ9w8Mnj0ikH4b8mn29Ml3DcaLSRbt
 SEqz0GkI9GjiStNsXbHhBEa9vVIhYyyysuuwawRkDqhMoZRc4NfgKbM4ayVg0RcnFJe2PTMWeU4
 U7jy8iuGKJ5qG8QcCiIc29uOA9m34gGeOxKR5fpGrQKPnOezqDpCAo=
X-Google-Smtp-Source: AGHT+IGpDrEmX9frsZv1p+MJOsn+5xKqZQfSfv2/DFoKBBdJRBjW0Q7BOmkskHWVTM9t83iRE+zXwA==
X-Received: by 2002:a05:620a:1917:b0:7b6:cf18:66d1 with SMTP id
 af79cd13be357-7bb90302766mr134898585a.21.1736199629286; 
 Mon, 06 Jan 2025 13:40:29 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480ea7sm1539785185a.94.2025.01.06.13.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 13:40:28 -0800 (PST)
Date: Mon, 6 Jan 2025 15:40:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v2 21/33] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
Message-ID: <20250106214025.GB3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-22-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="79As2ZAP0SVEKCjP"
Content-Disposition: inline
In-Reply-To: <20250106143229.3023771-22-sjg@chromium.org>
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


--79As2ZAP0SVEKCjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2025 at 07:32:17AM -0700, Simon Glass wrote:
> QEMU always gets its devicetree from the OF_BOARD mechanism so we should
> not depend on !BLOBLIST here.
>=20
> The logic of PRIOR_STAGE is quite a mess, unfortuantely. We should rely
> only standard passage to receive things from the prior stage. QEMU
> should implement standard passage to provide its devicetree to U-Boot
> However Linaro has blocked my patch to provide devicetree additions[1],
> so little breath should be held in respect of either change.
>=20
> [1] https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromi=
um.org/
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
> ---
>=20
> (no changes since v1)
>=20
>  dts/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 41a758e83a6..fc25a854708 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -191,7 +191,7 @@ config OF_BOARD
> =20
>  config OF_HAS_PRIOR_STAGE
>  	bool
> -	depends on !BLOBLIST
> +	depends on !BLOBLIST || ARCH_QEMU
>  	help
>  	  Indicates that a prior stage of the firmware (before U-Boot proper)
>  	  makes use of device tree and this board normally boots with that prior

Since OF_HAS_PRIOR_STAGE has no prompt, it shouldn't have a depends line
either really. I believe 2b71470628c is part of an attempt to say that
if you have bloblist enabled then that's how the previous loader needs
to pass the device tree. But indeed that's not quite how to enforce that
kind of demand, so we should just drop the restriction here (and some
other time fix the "imply OF_HAS_PRIOR_STAGE" to be "select
OF_HAS_PRIOR_STAGE" because it's not prompted, imply is the wrong
keyword.

--=20
Tom

--79As2ZAP0SVEKCjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd8TcUACgkQFHw5/5Y0
tyxHpwwAnXYLj0TtT7uZmaKlAf5ojp2slMEMy3tGBrGTWswAAQeUdTe3bNiaK3cF
0e+pF381RWEWFAyP5rv0qjayPdBo6abhP6m2/B4zMhMAeea1nkSOxwvv4ktysWH6
ThhzeklzZ70pF+sGEksBT3kMbvgIXaHMCqrNZLYOmwelR1c0ylRpDJw09GOKK8Ai
XIr2hDVjxSraM/Cmf+jJ0uiwDp6N+AEbi+QN0YL0uE4BGDCKYtl2J5tAI8b+L8eV
2gvcFEFDflmAOGfrArAJPIuPsSfWns1X1zQD/XU9AVuO0OshM3zErS6NI2DyuBgo
DkFOyf/+ZMOGTC2D7yGv9aTTVzeO1axZP4LdAGuerFW3C46A7NRxrjEYKafPFmwo
PO/A9irHyh4MbyuYjjutYnShpRTWxzRvsC3FgKRZbyY0WbnOkqzaT7EvCdcCfMxr
t5n3kk6FjEFXqd7rujC9UCTRglgqF5tP1fWac0eVLkfPcMdUu6uV5cbDXYQ/g7Ch
xIY/Loxy
=ifeD
-----END PGP SIGNATURE-----

--79As2ZAP0SVEKCjP--
