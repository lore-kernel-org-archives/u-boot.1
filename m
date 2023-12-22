Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A275C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D83D88788E;
	Fri, 22 Dec 2023 13:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oir5zz4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0C78788F; Fri, 22 Dec 2023 13:35:11 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49ED68781E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bb8977162aso461785b6e.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 04:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703248508; x=1703853308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HIZBfGv9LtAtFenv8+TGA6Xh14WHDP/c1bVzHrgUpxc=;
 b=oir5zz4ON+DasM6L+fiSdUKkHC+UtCNcjN9NZDXv9GeHeuwT9kkVijf6/EWCSMOCl5
 hxOIPb8o85Dr9xLdaMZAS0zeURulY5J2wuISEuLM7CpQ9G3l+TAwQoa2bk3eI3tDjPDf
 FQ2jXvCFOUfoOklH72gc4se9pteSauK62XjHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703248508; x=1703853308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIZBfGv9LtAtFenv8+TGA6Xh14WHDP/c1bVzHrgUpxc=;
 b=n4U+2C1qeuQjCVa8meEygKqO/x2N/2raZa5q/jHsiB2+hC36ZPQBdz6/NGu7zSw9B/
 W0fFZG8sWkCOKxY82wkC83Qn63Z8Kqcvnp61RH75yEUMQ2f5/+1u/qFhEkxl49nTzABB
 D0yqoYcjOqS5CKD15LCXJkxTkTZgStXx/is3BYrvzqalgcCvI1IaL9g3jj1HTBfYfS4O
 8e7y2lgAV1X3M/nU++wXBvmekqWiHEkYWKWj1Z4DZ0qoTqp80upkzCiud3cNnqniay4I
 eGrlXl5xljisYniLFr4OfnblIHlNyXd0q0lBbiy1jm2xLmymS7NV5htBUSzXlgUqwq+S
 1lAQ==
X-Gm-Message-State: AOJu0YxVsTIywEdKADYAdAZooeriitvz++TsQmWBDXzXKTOrYoj1bX5F
 LotYtAOFztpobx2d5Ti3A7xP1Y+1M9B+PQ==
X-Google-Smtp-Source: AGHT+IE41PnzRSn2wS1tymZPbww5YxQimxV/E1yXR3PSCZFntEN1bMAcFmVTxbiyqDKrzEKV/oNUYg==
X-Received: by 2002:a05:6808:1152:b0:3b9:d7a0:d152 with SMTP id
 u18-20020a056808115200b003b9d7a0d152mr1386175oiu.40.1703248507869; 
 Fri, 22 Dec 2023 04:35:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a37c20d000000b0078131528fefsm139141qkm.32.2023.12.22.04.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 04:35:07 -0800 (PST)
Date: Fri, 22 Dec 2023 07:35:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH v2 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Message-ID: <20231222123504.GA2513409@bill-the-cat>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-6-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WIFT3Kxx628i5V4Y"
Content-Disposition: inline
In-Reply-To: <20231222061208.3009970-6-sumit.garg@linaro.org>
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


--WIFT3Kxx628i5V4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:42:05AM +0530, Sumit Garg wrote:

> Encourage SoC/board maintainers to migrate to using devicetree-rebasing
> subtree and maintain a regular sync with Linux kernel devicetree files
> and bindings.
>=20
> Along with that add documentation regarding how to run DT bindings
> schema checks.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  doc/develop/devicetree/control.rst | 108 +++++++++++++++++++++++------
>  1 file changed, 86 insertions(+), 22 deletions(-)
[snip]
> @@ -81,18 +94,21 @@ Failing that, you could write one from scratch yourse=
lf!
>  Configuration
>  -------------
> =20
> -Use::
> +Traditionally, U-Boot placed copies of devicetree source files from Linux
> +kernel into `arch/<arch>/dts/<name>.dts` which can be selected via::
> =20
> -   #define CONFIG_DEFAULT_DEVICE_TREE	"<name>"
> +    #define CONFIG_DEFAULT_DEVICE_TREE	"<name>"

Oh, oof. This never got updated for Kconfig rather than config.h. Can
you please include re-wording this to be setting <name> when prompted
for DEFAULT_DEVICE_TREE by Kconfig? And the rest of the text you're
updating as well to match, thanks.

--=20
Tom

--WIFT3Kxx628i5V4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFgngACgkQFHw5/5Y0
tywNvQv+PXpqYfCm/efG62coaHwNWo28VEE/MVnLf2mUSYx8LSHw+Hzyfk5Q6xlH
MZTQJm+8GuUjNS9JMiLsAKIracsxpOvVtfeGrmMLrdOlzLcLLx1ueWRFYhynKEr3
G3DXka8uDm4etz27fIGz96vcHPTtkxL9w+/SdQUFln/2Vk9GGxL9k9bL6w0sggez
hTbDvkwcTov+5r1YCvzh9Kj26HN8sbpg7aT5hNbhSM4Ba8hvbq4UJ4yifnvAzseL
Lfg+Us+QhuIJNbnieHYdV1riiFPC1fD21Gq2uIYZ2Rq4eFkm2ngZLtKqto8uHW71
hEbdwh0FGkTwxvMMpLD6EdLTPrC8r/k6nkaCeRETciokisrV8mfOr9wrLoZjBXiu
S/pTWLEXw/WlRtEs1ZwVAaEzAEnVvm7BHy3VPAW7zjffNvlJ0ffjR54YrTqYEJAW
ySeAN2ILB5kttXmc7ylxtr1AUYqdnQigL5lF+X4dMuYcxceDmfcRYQ+FhFUjRUd8
n4DngR11
=B0Vc
-----END PGP SIGNATURE-----

--WIFT3Kxx628i5V4Y--
