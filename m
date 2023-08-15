Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED249C001E0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 20:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77898697B;
	Tue, 15 Aug 2023 22:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m+bNUV2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72748671F; Tue, 15 Aug 2023 22:24:09 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED680869A0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 22:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-58c55d408daso12955377b3.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692131044; x=1692735844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3bVo8On6j85OVZBWVzewONnCFacpKQ2a8OisfVjZn4s=;
 b=m+bNUV2RHtejJndCbzEA9KXH/h1vPG2MxlpyjgtwNL31vwhscmLo8SwcoqYVL2ykYY
 Fsl7acXTveo9SYpdRuhnAXJ7fjpx3eFXpkMthX6xRQHBhizvoIOvEShLWH539Poznf8A
 q0x2sJiA8/giOS0rYlXzPPBUNzjKHWhD9efLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692131044; x=1692735844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bVo8On6j85OVZBWVzewONnCFacpKQ2a8OisfVjZn4s=;
 b=VoUrf8o1dz2Gcmh8E/Wu77da76c8goaIPmvO4ty09RAggW9JoqrtdHvNOXKSQa29DA
 P9vFjCH1caTrZj2ysB8lGoIfSj9PgcWFXOWrjgpdFTbp96RzYRggoldgnjHLa0sCYorn
 2xroPJ/9V7671LzSIjo7LWjVv5jUR5Ikhb6GslyPSjbkE8eJwg9yWgjeACco9jxffH1W
 DCeKGuGQsLG5RCmQHHqQtXLGi/TfDBdUmDrJXG/OCZygpBBYm90p/sCTZp2buMG0pJvF
 EwGU8qs/bnNpUSWqduk2N/RgeTEZVF0svOoczjtc9v40A8llYmnFlCNJ7cLM4amdVyT6
 feCw==
X-Gm-Message-State: AOJu0YxWYNCdG0csLrG5CslZMjXOelrGImllx21PRaXe+iACEr5DsEVp
 SralQswOA79cwU1ohxXan/tkpKpYSmR0H8j02d6h1g==
X-Google-Smtp-Source: AGHT+IFK0XLm6CeiQM+smuUaRQ8oT0ccHWCcTk3UyC9oTDO/asPecyxIn5+Qgprsgmp3V14I7Rw8Hw==
X-Received: by 2002:a81:82c3:0:b0:57a:6bf0:2100 with SMTP id
 s186-20020a8182c3000000b0057a6bf02100mr19716375ywf.1.1692131044690; 
 Tue, 15 Aug 2023 13:24:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 o128-20020a0dcc86000000b00577139f85dfsm3586888ywd.22.2023.08.15.13.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:24:04 -0700 (PDT)
Date: Tue, 15 Aug 2023 16:24:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 2/5] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
Message-ID: <20230815202402.GD3630934@bill-the-cat>
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-3-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qAAdYqEWGjtr9qIj"
Content-Disposition: inline
In-Reply-To: <20230815162623.1824357-3-sughosh.ganu@linaro.org>
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


--qAAdYqEWGjtr9qIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 09:56:20PM +0530, Sughosh Ganu wrote:

> The EFI capsule authentication logic in u-boot expects the public key
> in the form of an EFI Signature List(ESL) to be provided as part of
> the platform's dtb. Currently, the embedding of the ESL file into the
> dtb needs to be done manually.
>=20
> Add a target for generating a dtsi file which contains the signature
> node with the ESL file included as a property under the signature
> node. Include the dtsi file in the dtb. This brings the embedding of
> the ESL in the dtb into the U-Boot build flow.
>=20
> The path to the ESL file is specified through the
> CONFIG_EFI_CAPSULE_ESL_FILE symbol.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
[snip]
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 368b5a3e28..2e71f190bc 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -334,7 +334,23 @@ cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
>  		; \
>  	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depf=
ile)
> =20
> -$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> +ifdef CONFIG_EFI_CAPSULE_AUTHENTICATE
> +quiet_cmd_capsule_esl_gen =3D CAPSULE_ESL_GEN $@
> +cmd_capsule_esl_gen =3D \
> +	$(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_input_f=
ile) > $@)
> +
> +$(obj)/.capsule_esl.dtsi:
> +	$(call cmd_capsule_esl_gen)
> +
> +capsule_esl_input_file=3D$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
> +capsule_esl_dtsi =3D .capsule_esl.dtsi
> +capsule_esl_path=3D$(abspath $(srctree)/$(subst $(quote),,$(CONFIG_EFI_C=
APSULE_ESL_FILE)))
> +dtsi_include_list +=3D $(capsule_esl_dtsi)
> +endif

We should only need to ifdef around appending to dtsi_include_list.  The
rest we can / should just leave always there, that's cleaner reading.

> +
> +dtsi_include_list_deps =3D $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_=
include_list)))
> +
> +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE

This part here is a separate bugfix and we should do that as patch 2,
and the rest of the changes here as patch 3.

--=20
Tom

--qAAdYqEWGjtr9qIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTb3uIACgkQFHw5/5Y0
tyymmgwAlPeH+FPqvYUme+WG97FkNidNil4bhOnCujfMuiyxp/VRLAaC2aCN0YxC
IF95eVaEeEqjLq5d2rEA4rOpgM3KKWRE8TWebWo7gIniu1I/Q54ew0K0KwlFs0Dc
otM4mtaHvfD2qtBsq1DYykFgziHNugolKrwU3viJwc04fS0h5YILRcG/Tda/bZhB
zDIzAMrB11rsGi9xpEhTRHFJAZTMv4K1vkN/YXv2ew4ZkDlmgKNSsonMJVwlJWRK
DED/02rxYkdPe7RqImQFkefX2xVc0P//E97pkQ4czOem22Qt3cx4R8qLzTbh9v0p
gtxlJhJXeWAw4KyXVWNKvj15z0se0un4lQDrPuKHZEzVSY+GMe/YUVKL+6ygK48c
h7IeGsBIGxOkcj+tcUogeKGiIpfxtV1ig9SJbdDD952709+zj0rJzcvgzcO0FFaU
PPHfUhDYgYeM37kdhNejUClUKFQ7CVHnJijzMIPYJGX0R9Zqdd94z++OmfFrL6TT
sbp7EX3/
=Tpxo
-----END PGP SIGNATURE-----

--qAAdYqEWGjtr9qIj--
