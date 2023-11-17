Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4534DC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52A086F56;
	Fri, 17 Nov 2023 23:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ESGsRz7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9E486F7C; Fri, 17 Nov 2023 23:40:57 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C3E086D3C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1f084cb8b54so1386130fac.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700260847; x=1700865647; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eBLKunytHZZ+6cn5Vn4qMoTjxIoaR7Fo27l0d3cKqPI=;
 b=ESGsRz7qvJF4cpf3hpBeED/44uauUwdBX82Ao8ZWhKWxNy2kXJJfaSiCgq2cqK1fjV
 /VimIQgCidVbrDOgpWu1NLu7sxggoJUDmQbvOGF+rYfgE0q2kURZ22lZARH0iADn3iUr
 uBHD56/8izVvBq55ZdoW3u7teHTb9BUvuW0pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700260847; x=1700865647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBLKunytHZZ+6cn5Vn4qMoTjxIoaR7Fo27l0d3cKqPI=;
 b=FvTPf9/skYFbDDEIL5CoaCdBgezxCtDHHUDN0KjQZfW7DbJ/rl3YmCfs5Ve4xrWRea
 +w/+fBdnEPbMgZzIEN3hgVsoGbKH9UhDFEU6PQKZ2fGqaBTnkWjvkiIDfAILQxpc2XHF
 kRNiJ1kkRhuz1LdSCv+5sMMhQG7I0cvplWdH5LfISqLUtOmFA1jUL8kIDrjlMWJqw47A
 3ajmQ0Mkp/HhrE448w/m/mLbnfAVv1LNd37CB0BoAKYC++oV+/SlzlOqSIGaQU1n2kpj
 Qdg8HLNbVpDww1E1X2vIzu3EoZb3D058M0eZM6uT3cJlI39oRv3TF2r8p45yMvqtIby3
 Kv8w==
X-Gm-Message-State: AOJu0YxNw6IelaMlioifrCMR0UHdbSHrmYODMRVD7db46Ln0JCnVuHBB
 iyyATOjw7yaWrbH6F5ZFlu2GYQ==
X-Google-Smtp-Source: AGHT+IFwROqakHliKr5NIyumfi6ZyF+LfiK20dTRr5FMlE0gieafXIRg8JLTDT83S2VC+jBtwbjxOw==
X-Received: by 2002:a05:6870:cc8c:b0:1f5:56b2:e502 with SMTP id
 ot12-20020a056870cc8c00b001f556b2e502mr766062oab.0.1700260846955; 
 Fri, 17 Nov 2023 14:40:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 bq31-20020a05620a469f00b007789a3499casm912617qkb.115.2023.11.17.14.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 14:40:46 -0800 (PST)
Date: Fri, 17 Nov 2023 17:40:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] configs: keystone2: Do not include hardware.h
Message-ID: <20231117224044.GD170968@bill-the-cat>
References: <20231117223829.346652-1-afd@ti.com>
 <20231117223829.346652-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pnXlLM8X2bsLPp8C"
Content-Disposition: inline
In-Reply-To: <20231117223829.346652-2-afd@ti.com>
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


--pnXlLM8X2bsLPp8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:38:28PM -0600, Andrew Davis wrote:

> This is a hacky way to have this file included in all source files that
> include common.h, instead just include from the files that need it.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/memory/ti-aemif.c            | 1 +
>  drivers/soc/ti/keystone_serdes.c     | 1 +
>  include/configs/ti_armv7_keystone2.h | 1 -
>  3 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> index c4bc88c1510..41325eb0f94 100644
> --- a/drivers/memory/ti-aemif.c
> +++ b/drivers/memory/ti-aemif.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <common.h>
> +#include <asm/arch/hardware.h>
>  #include <asm/ti-common/ti-aemif.h>
> =20
>  #define AEMIF_WAITCYCLE_CONFIG		(KS2_AEMIF_CNTRL_BASE + 0x4)
> diff --git a/drivers/soc/ti/keystone_serdes.c b/drivers/soc/ti/keystone_s=
erdes.c
> index 2ece1a8f647..0e1bf8ff39d 100644
> --- a/drivers/soc/ti/keystone_serdes.c
> +++ b/drivers/soc/ti/keystone_serdes.c
> @@ -8,6 +8,7 @@
> =20
>  #include <errno.h>
>  #include <common.h>
> +#include <asm/io.h>
>  #include <asm/ti-common/keystone_serdes.h>
>  #include <linux/bitops.h>
> =20

Is there going to be a follow-up to remove common.h from these files
then? Thanks.

--=20
Tom

--pnXlLM8X2bsLPp8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVX6+kACgkQFHw5/5Y0
tyztbgv/eVFPgM8IN8howQIjqJq3zt4SUsD4BGADl/KUYqT308FfNJdDHctufnAE
5o7dBKv8z1521GsC81AZAZ/RqUtIwecC92I/BmpHRu5prCCHXhr57KGgbDjq7EK7
Z0UIXVQEBOivCFMLpucY9Y68WbuGSTv9Ndo8MnIJy+cAJQDegYIGCdgHCwMdQo17
zocFJI3kTDTdPkWCrrM88QwmUtGcg++82mE0vEsuvjANPKq/b+QsTE9ggbYSuUqg
LBxcwvAgQUfBphb8GbqclHnE3JBCAWSzXgm+d6hiVNcUhwPRKF7gleou7jgnL0i/
ulbp+GgfEB63sjDJn/e2ykw7qP86sfNrzBSs8aRtTzdKwbDHNSq3hGLqrMGCP4ls
MnCABu+04N9sO7ESjppt0Eochcf4Fiz5ZTNaljqJyxVCQs9YVsfvGLvG5sB/bFVE
zO+qXOTEprGqsWqyxD9jcMkpEnOJ0XDYxoLmO0sVPzPWFqi/1wy7fWekvOEr71Bh
fwnqK8sP
=fpV6
-----END PGP SIGNATURE-----

--pnXlLM8X2bsLPp8C--
