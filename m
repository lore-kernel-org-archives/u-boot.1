Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72153C3063A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 15:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E17386B94;
	Thu, 17 Aug 2023 17:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AISs1qe4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B415886B8B; Thu, 17 Aug 2023 17:10:46 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A7086B88
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58de42f9f05so10192827b3.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692285043; x=1692889843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JhY+mWO/vuYqfGrjUVo6QHxp9LE8cZVlol7m9f5GFDw=;
 b=AISs1qe4XTUttL4rJuPkF0NgAGY5htkfEHMZ1wHzV395gf6OFgPuvAktBHVPab5pJ1
 BKQLAX+t0DmapvdgiT24/mwYiJy8NF0qfnH2AHfrrdE5AV1x+Lz0HR9NizbhTm8qwd0+
 yC4teeWPOXgDGOSJ15h66Rj6AO4ITdS1Aoe8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285043; x=1692889843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhY+mWO/vuYqfGrjUVo6QHxp9LE8cZVlol7m9f5GFDw=;
 b=cwI0WAgxMMMmPUd1Er7GwS4Tgc79EA2re0ilvkJB7L4MR+e8X3VQK8+GIsnBj4Vvks
 n9E74tu+ni8fDHx/Z0u6eQ/HR4be99qS1UEdM7QcaDXmDC/e4jwPUczMkqhOQfRA327G
 7vBQEuz0O12ylXHz6Yp0Zt4zZEAXzvO2NRqu65yqjEz29/Tt0NlKVyEECBiqYMNFKUU9
 Xk8ANAMkeoFL3ypc5IyIlBrhnT2Js4SgxxUky5/ypY0fHRUg0ULsR7uil9Bnvzx5Jn0e
 bEjCPlS+ODQ4YLNiuvs9EjLZfCCt7dgwVMBOfGBcQdI++rGzgUKW6w2eq+Uum/lmVrtj
 AcQw==
X-Gm-Message-State: AOJu0YzHl0ZCcHNGBmhNf5ZKD/yxxW6W9qfrrOQ8Zzgs8DnsgalNpwcI
 1D2TvtRlr+gpIoTYFWh+xFYzhQ==
X-Google-Smtp-Source: AGHT+IGRJm//YP8LFyXSzGoqAORDN1UajD6bFgGxsxMoSSbxeHvOC1sjfUH7y4nvKwgWvHKnC18Skw==
X-Received: by 2002:a0d:d7d2:0:b0:589:fb81:dcde with SMTP id
 z201-20020a0dd7d2000000b00589fb81dcdemr5192872ywd.11.1692285042843; 
 Thu, 17 Aug 2023 08:10:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a819c10000000b00582b239674esm4623716ywa.129.2023.08.17.08.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:10:42 -0700 (PDT)
Date: Thu, 17 Aug 2023 11:10:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v2 3/6] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
Message-ID: <20230817151040.GH1515023@bill-the-cat>
References: <20230817054856.2019253-1-sughosh.ganu@linaro.org>
 <20230817054856.2019253-4-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="846hK2d+7SK0jK5l"
Content-Disposition: inline
In-Reply-To: <20230817054856.2019253-4-sughosh.ganu@linaro.org>
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


--846hK2d+7SK0jK5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 11:18:53AM +0530, Sughosh Ganu wrote:

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

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--846hK2d+7SK0jK5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTeOHAACgkQFHw5/5Y0
tywGuAv7BeODtDtNeKuCKRlSS5PoIveIGpmnsdgr0jEpzrcx9ksrkvNMVzSa2h/z
AK+YJFhFOa5t5L65g9U1EMR+gQLKZp/6mhBKT4pgtg26nx3d2wohWfolO7cCzpvw
oZawkfHaFDRVutnkkGEA1Qji13aoRzvCqAJkFcPWl7LiN5spFDlNg7A5Ok99e3SR
RQph32CLF7AvrvKHDOYdZ43It0Z4AHwta2dxehbACa2cWghodYnDKYwidte8zUd3
ppN2Bhq2QfRMtv1h/IfKayLlVZUqF4ylcwykNnh+eKxwUFrA7OyHs/4Hnu8VPd18
r//ATbxJalthHMErHyfuYOlQjkpV/pWZtz3+PaxzFmMxzMg8QXSCpyji6IW9ygUf
xUXd372zW1tHEMn2FXCWc40YRS2Uyh2XZ9oPzcBZ42D5lZrimmrJ6ljC8QMFRbMo
bsZgpy32Jf8Cz5muKU3BpjCavqU0QfXLDvULoZ2Jc1G51OXAKGVBUlaXc3KEjjPw
fGb0D6fp
=2x1r
-----END PGP SIGNATURE-----

--846hK2d+7SK0jK5l--
