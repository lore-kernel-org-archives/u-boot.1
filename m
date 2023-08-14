Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A785C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1BE86983;
	Mon, 14 Aug 2023 17:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZU5nmmWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A5286983; Mon, 14 Aug 2023 17:04:36 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7DC58696B
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-589e0eef06dso12604427b3.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692025473; x=1692630273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RZ/BQYcdpJvT3rm/suD2k5Fdu03j8j3CtZasyL6gCiw=;
 b=ZU5nmmWBTZ9yCGFlC+WA2qaq9YrqOtT6XfxKhmn2j97C+vVDrPGNhOTCf2wdmf4FKG
 sqot0/2VVylu4oS55BSyAGMgQeiE6ZKrbdQQ4wtuVGwehuoqcm94QU8xE7Z4Oz4z8R8f
 mSv2+yusQHqelTtKEB1YppQTuS9SxrIuS1x7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692025473; x=1692630273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZ/BQYcdpJvT3rm/suD2k5Fdu03j8j3CtZasyL6gCiw=;
 b=Fv8WhW2YwnsVFblqbLcx27P8F623Hd6NYriMpJUqsTqAhusADOmeOu9lhsVwge2I9I
 3aeKcTgAGOQzo0CbjofqHv4k+reSFZU6ScsZqFjxXFneNOeAKE3ZcFvG34vzeOzKKWb6
 JaTDuSoGzuKz+SY+/k5vVo9c3lIU56kCQAXm+lFUPhlABBS61RxA9VuzhFuOjhjmh4/i
 B4fCs0FoJXzTk6apJBYQZTs8xyGxbDG1JwZskUqMZWwEw9pkdPx1a3zSgvAJw4ACOpRd
 Sm4aeJkQx/H9Lc0YZxLhLMEZA7IEjVEzUnbKl/RuO9FdneLRX6rzgwQQTF0MoplAkBAQ
 kyPA==
X-Gm-Message-State: AOJu0YzIZY3JiizEo9r+H7kgD+Um4gYHLvgqdSxHhQXpTxncUrsfcR0J
 1xBAnSCnfrnqXucfMAi/rftQag==
X-Google-Smtp-Source: AGHT+IGrZd2KDFTWJP7tSJ6BHrxdpnOf/fCh1dGfNyob4gVvlRImQfGu+ZRcOf0l9LExJS+2uRFJ1g==
X-Received: by 2002:a81:5c04:0:b0:575:4b1c:e5f1 with SMTP id
 q4-20020a815c04000000b005754b1ce5f1mr7873850ywb.39.1692025473448; 
 Mon, 14 Aug 2023 08:04:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a0dd904000000b005772154dddbsm2794764ywe.24.2023.08.14.08.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:04:32 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:04:30 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [RFC PATCH 2/4] scripts/Makefile.lib: Embed capsule public key
 in platform's dtb
Message-ID: <20230814150430.GX3630934@bill-the-cat>
References: <20230814090309.1548310-1-sughosh.ganu@linaro.org>
 <20230814090309.1548310-3-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dyx8kXzxKFs2fnZe"
Content-Disposition: inline
In-Reply-To: <20230814090309.1548310-3-sughosh.ganu@linaro.org>
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


--Dyx8kXzxKFs2fnZe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 02:33:07PM +0530, Sughosh Ganu wrote:
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
> ---
>  lib/efi_loader/Kconfig             |  9 +++++++++
>  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
>  scripts/Makefile.lib               | 17 +++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
>=20
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 9989e3f384..f40a62a0ba 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -272,6 +272,15 @@ config EFI_CAPSULE_MAX
>  	  Select the max capsule index value used for capsule report
>  	  variables. This value is used to create CapsuleMax variable.
> =20
> +config EFI_CAPSULE_ESL_FILE
> +	string "Path to the EFI Signature List File"
> +	default ""

No default.

[snip]
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index f41b16781d..cf4eef0b05 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -334,8 +334,25 @@ cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
>  		; \
>  	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp > $(depf=
ile)
> =20
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

This seems right.

> +include_files +=3D $(capsule_esl_dtsi)
> +
> +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(obj)/.capsule_esl.dtsi FORCE
> +	$(call if_changed_dep,dtc)
> +else
>  $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
>  	$(call if_changed_dep,dtc)
> +endif

I think this implies to me that we should have been depending on
$(include_files) (once renamed to be less vague) here already ?

--=20
Tom

--Dyx8kXzxKFs2fnZe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaQn4ACgkQFHw5/5Y0
tywz6gwAqwICr3GuyHKVOCg2TMYY5OJvFoY3/lCu6SsZE4+pU+zT0GZNw4FQLk6C
CfKTFGVEyzRNN21PByHiDDCllCDng4wMeCrRdxgi6voQTZdPBncKwaBt+uO2jNwv
oC7JEAwKHtvSbHEkhKHPV0h+XX6l5AOVqfxUe7mpp63Lf+SBnNAPpDZEvD5lpiZU
hHhdgKclEPU/xOLf15uer/X4NlFgCBJtsSb6hh3ocWG1W8Cvh2Kf/MGSv19KXkQO
KiGuaAn+aDRpTTZw8nhL+YK5CVTRRm0amoibbXJrpOU3HPSrLQZmNHt4KDqLnJco
j8s7IZdpG0cT4687wpndzykXMs62n9TVM5Hn7UxGzN5FiIYB1RWLnSngoaXENG2U
95bbG20BVwlrgmB8O/C6DpeURzo87Et8eMT2IV9nubW+Oe/Q8fZlEQaMX8LT5ES1
UR4odaBJYZcOMsAkQb3ihBbvnT8lcEq1uVNsLzIstk2PRrHUK8ZxXsAdk+yr8m1J
pNmCTQDq
=nHgF
-----END PGP SIGNATURE-----

--Dyx8kXzxKFs2fnZe--
