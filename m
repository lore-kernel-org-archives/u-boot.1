Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9044C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 18:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E92087514;
	Tue,  7 Nov 2023 19:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h9iK425Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D84C87528; Tue,  7 Nov 2023 19:16:08 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA1B86ED6
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 19:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-778711ee748so418705385a.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699380965; x=1699985765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V4goRw3ePEaS0Z/BMWU+ZxnNZpxEtVXJkQr8q181VV8=;
 b=h9iK425Y73/CU/UyDId0b/5LG+iAmT8QGtH1rqiwXRMVg486TbRafvMU7SxSkXvGF8
 E/CZvFjDkUqFmZTPWL8xLJQGRbrzLdI4sjihOV3xhkHUFnhGQczb3D5/dEGg2Syty+PD
 XariXbd6Z2cz2MqrJnjizPxzx9rpfkGl/OTrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380965; x=1699985765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4goRw3ePEaS0Z/BMWU+ZxnNZpxEtVXJkQr8q181VV8=;
 b=ucp6LKHLc2SgTsWyMoxSQBFn0LP4ncVoEt0+BrGfyeZyLNmxoeCvZv6HsEc4nzTIOE
 I116w4bb7H/O1OOkpfAbZZesrUhmBmSuLhahCWnWAQ4f4eAmSaQ105HdnVhB6yenYbZl
 taX4Q1RVdGB5pZfAA4KX566gjRSZZ2MsavVkcEthNuv+4ia2EVPILCnVpwOE6djKi5nx
 L+RVj4Hg8jXxutipDLFVHpfXm1rEPeWX21PwpcxJPBpdKXn1z/dIDKH7R9HySZ8r/McP
 TVEFqmHbxWAyZZnQIRgC/k/V2a2+cGGJWvMkPhZT0LnYGnY6dFZtq3bvg81+XxgsM+es
 fiUw==
X-Gm-Message-State: AOJu0YyQPzQlPio/+7gcZLKozQ555RXgF6weWcZylPCiH2nGTvwGOtf0
 GShTl36xeeffcuy3PhJmvIjoxg==
X-Google-Smtp-Source: AGHT+IGpx1aBn7BbYow5XPTvxOia7QxqRlp11NvVZPyKrM6RlOGBBIcid/jNI1DNncP0UHN8lRJUTA==
X-Received: by 2002:a05:620a:290a:b0:775:96c8:f560 with SMTP id
 m10-20020a05620a290a00b0077596c8f560mr40842264qkp.31.1699380965242; 
 Tue, 07 Nov 2023 10:16:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a37f50d000000b0076f16e98851sm133878qkk.102.2023.11.07.10.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:16:04 -0800 (PST)
Date: Tue, 7 Nov 2023 13:16:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: u-boot@lists.denx.de, nm@ti.com, thomas.petazzoni@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 4/8] board: ti: j721e: Add resume detection for J7200
Message-ID: <20231107181602.GJ6601@bill-the-cat>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-5-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IZumj9/5AT1MhCQq"
Content-Disposition: inline
In-Reply-To: <20231107161802.855154-5-thomas.richard@bootlin.com>
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


--IZumj9/5AT1MhCQq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:17:58PM +0100, Thomas Richard wrote:

> Add the capability to detect a resume.
> To detect the resume, SPL searches a magic value (0xBA) in a register
> of PMICA.
> This value is set by DM-Firmware during the suspend sequence.
>=20
> Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>
>=20
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>=20
> (no changes since v1)
>=20
>  board/ti/j721e/evm.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>=20
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 38fe447d8f..b4b94c8c69 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -22,6 +22,9 @@
>  #include <spl.h>
>  #include <dm.h>
>  #include <dm/uclass-internal.h>
> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_E=
VM))
> +#include <power/pmic.h>
> +#endif

We _really_ should not be guarding include files. If the code doesn't
compile with the header included, we need to figure out what's wrong
with the header or if, ugh, a more worst case of moving the #include to
by the now-guarded functions.

[snip]
> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_E=
VM))
> +
> +#define SCRATCH_PAD_REG_3 0xCB
> +
> +#define MAGIC_SUSPEND 0xBA
> +
> +static int resuming =3D -1;
> +
> +int board_is_resuming(void)

I wonder if we should (a) have a file for just r5 related code and then
(b) rely on this being discarded on link anyhow for non-SPL and we just
comment that this is only used in resume in SPL. Guarding functions with
#if (IS_ENABLED(CONFIG_A) && IS_ENABLED(CONFIG_B))
isn't what the macros were intended for (and yes, I know checkpatch.pl
complains otherwise, which is a point of contention).

--=20
Tom

--IZumj9/5AT1MhCQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKfuIACgkQFHw5/5Y0
tyw0fgv+LLV0dgFS0J8u46DxMaf6qXEYc8d9N0oJxYzv9RxS3vJ6ky31He4J+qUW
zq8tCSa8aL7XLC25gv4QqP+cTJt2NhjU4cwhhtYDPp4S+sBHswKr9uqIYD7myL+b
BuNQgFJ0YbtCC7/lrvlb/bZYMsCm2nmZOQ/H0ntasAq2rLJTI5hX23SXbPp0F13b
VydLh3W+Q8iGxtu0KaoO6QYEj22cThPAAD270La/szCj+NET8mPb9VRN1vuzOqKZ
BLvNRLqZcXMXdGh2CfokkduPL54GdbiI8RDos4cWG1fBiz9vsYnhoCgFUhKdrZ5X
2w8b+OaaJepvE0ewXZfGJSpzE3N9TWdSqJC89N810Do6wrwOxjyFrrz2zKqeHhM3
IUkuzR4AkuggMxDnicidbQSYYFJLI9mGdXlLWivXqTF8wEffvH0CAfryAtHP8mwN
c6ph2fBpy5vpkk+emL8sriHC2TfV985X8U2TDeCdXrXNwZSToRsJukAAk9dcMadG
KXvyCMQG
=tGli
-----END PGP SIGNATURE-----

--IZumj9/5AT1MhCQq--
