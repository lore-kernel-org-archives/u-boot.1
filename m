Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F911C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 998EB8774B;
	Mon, 27 Nov 2023 19:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J0H5wfwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA33F8762E; Mon, 27 Nov 2023 19:17:26 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A0887225
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so45738947b3.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701109043; x=1701713843; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eoq0MMdTS4o8okI9cfFBTre9YvLtiOFLRLJ5nC49XZs=;
 b=J0H5wfwEoL3vJ2zLDv/N8pBZ4Y/fJerexotW/WkLkFGGz9tU6dQ3xMGMbxtanBMw1u
 hs1DL1q8ixEcY15WIaGi7iIVKh6JIjQy68Ik/qQBYFjtKepXEOFYb5E+NvBtxhnCZbog
 A+ieNYHNlz4dysujzlX3tXVlei6TA7DXBGIOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701109043; x=1701713843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eoq0MMdTS4o8okI9cfFBTre9YvLtiOFLRLJ5nC49XZs=;
 b=W9IfC9qoZtSj0VfDtNHjjgFV30C5Gi7m9tv2DUVeLgYF55G1sHcH55IvFkxEmsNLPB
 j07KKQLp8WdnZ4nuqzpqoD1xuT6CcHgDQ1w2o9AsHJ5zQZx1UPc89I9jPQGqnN5b+nqU
 8V8YESUUhEcZkPuUP1ik1Car4djo2sIbC+CABL1nTpD44jfUUeoWeGb8g/lSvtnLd/nt
 n4hHRk5ButLdAlzgqjPSFj+myNV/+82loqCAyhKVs517JGxRCLJaTo0MtqrmZRx9E88M
 oU/ZCusxeqSWkHnAHMCwIrhORI6kILqwFgNdvRMTW44wTeWmRurXtnVDkgMvAAIi9UZB
 35XA==
X-Gm-Message-State: AOJu0Yxn4c+brHiq5snPDT5AMYUPjMRyP7pQfO4LDEiNT6LNn+6JRYKn
 aVVMIE02HmeiwLSRKbivi6c0Mg==
X-Google-Smtp-Source: AGHT+IFVkqKlmfoYGeDPGWFQ1YNQfabYktU3H6oPi7P3uab1CcfWuqTDmtURQgX9mGaVbPEamxQ5Vg==
X-Received: by 2002:a0d:d147:0:b0:59b:dbb7:5c74 with SMTP id
 t68-20020a0dd147000000b0059bdbb75c74mr11720876ywd.32.1701109043620; 
 Mon, 27 Nov 2023 10:17:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 i188-20020a0ddfc5000000b00576c727498dsm3422513ywe.92.2023.11.27.10.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:17:22 -0800 (PST)
Date: Mon, 27 Nov 2023 13:17:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 39/43] Makefile: add dtbs to clean
Message-ID: <20231127181720.GM2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-40-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dynOxiD5Kh8bo20f"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-40-maxim.uvarov@linaro.org>
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


--dynOxiD5Kh8bo20f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:22PM +0600, Maxim Uvarov wrote:

> CI test checks that generated dtb has to be cleaned up.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 769111bf09..2fc04450c6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2172,7 +2172,8 @@ CLEAN_FILES +=3D include/autoconf.mk* include/bmp_l=
ogo.h include/bmp_logo_data.h \
>  	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
>  	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
>  	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
> -	       net/lwip/apps/ping/ping.c
> +	       net/lwip/apps/ping/ping.c \
> +	       ./*/*.dtb *.dtb
> =20
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_DIRS  +=3D include/config include/generated spl tpl vpl \

This, and I think a few other parts of the series are general fixes,
and can we put them in a separate series which lwip depends? They're
non-controversial and can be merged easily. Thanks.

--=20
Tom

--dynOxiD5Kh8bo20f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk3TAACgkQFHw5/5Y0
tywxlwv/Qy1mzSoyYPc6SurC+7RxjDt5Kkh3eSVIRiYHPL4HuYPelkzL+DVCPciK
ciZ6QG6OeqWmuLUI0ya8P9OtL2Ia3UN9h+HDJpx1pr24T5dGc+wELcT4R4kjBnKQ
DDU0wQYZINBCWMwL3sMLf9oxTlgXZHq9cFP7BfmVrJA5Bi6F8vtCGpjsaxpsZL9r
kOsDhZCWZ9xjj/90MkeIjYzg+mA6VHZCnCvfYI9jJgooCKDPjdVR23WV3El9xCPJ
tPGgOLdnGsH6Ifk5f6wYo4g4CYQj8QIJSlCffYGQXc6aWQQ2ldux0WHpjPRVJa6y
uG5BplcU96hlk8nVs7EwBIgZ5NelPrn3HVw064fBn+8JttjbS2rHJ9NYABvws0qf
/+VIPzjZvo4TCbFcqMTASCXWLhyRMld/qvNg39BYPxr85WXQzkPyJqhwCX7qZ9HT
EKvxilWPrYcBlD1W2kXZoW4lvAYLEEePNZb8A+PgZVU4s0HUL1XyRv5nw+HLkj6t
R2lG5kQF
=nO2A
-----END PGP SIGNATURE-----

--dynOxiD5Kh8bo20f--
