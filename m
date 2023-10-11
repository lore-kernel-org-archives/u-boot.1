Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EB8CDB47A
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 18:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 241FC86D02;
	Wed, 11 Oct 2023 20:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LXpzI5In";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D8386CE8; Wed, 11 Oct 2023 20:36:47 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C9E86D01
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7b91faf40so1955747b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049385; x=1697654185; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m4v6ozC4BnE0Byu4m/1DgN9YZEGJ5V0wcAOzuknAUEA=;
 b=LXpzI5Iny+cU2M4Sn3wRZ4C38YSo0gwUF2gPBWEsaSnKXsYW0f+CCdts3vbG/YxTS6
 hjE/8t2MppEfW7WrDiCqSpLclHiHYrV3pdW7Kdg8THfv/hb5kfcqmdG/pD0fAtNfyfic
 aglPXOZ59b2vVVwm5z4tOIIXBRPVWQJWf/ZwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049385; x=1697654185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4v6ozC4BnE0Byu4m/1DgN9YZEGJ5V0wcAOzuknAUEA=;
 b=NHFapuWaE5U3NEcGSVFs7aMtUZmBUj4N4Aa9+y6JAb/w3St683G9X6HZEpPysEaJpz
 YzRlXslMiCLqEQZb/GVfS/X+H27EEje7jnhlEQBEmafPtkK3xxczcP6XwVoKAQ3ZPBFK
 XwG8kpSilkQ7xO2kk8nHvtRzPz41bsEUOqnGasF8tkC5H5UuV2JmKniMcSebr6D9kEin
 frlPARWm551YjxyoCx/XNZv8JsHIQdVlcdmoZrPiKBYmTXJcVDFWZHrSfgByBYf4L1P9
 jRG1tnHfIbTebv3RJkSYFWLKoSrpEsacN/EywP+Gzfa1xPH57Uphk+kTaK9cHvEL5hMW
 e97A==
X-Gm-Message-State: AOJu0Yxa5gmpFLikqDAZCNvyFfNyOy3o57vRWpLAYQ2HJfm7nI6sMsGi
 dbcAbCfiFam3ZBihFBnuNQ+eCQ==
X-Google-Smtp-Source: AGHT+IFlsu3599UsCpdqOD9d1wVMSy3w0mjP4PH8k5p464e5YZZp6Z6B3WavJnkVt/3HgHJgd5FBaQ==
X-Received: by 2002:a81:65d6:0:b0:59b:dbb7:5c74 with SMTP id
 z205-20020a8165d6000000b0059bdbb75c74mr21866643ywb.32.1697049385248; 
 Wed, 11 Oct 2023 11:36:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 o203-20020a8173d4000000b005a237c85821sm5379252ywc.110.2023.10.11.11.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:24 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] configs: Make TI_SECURE_DEVICE default for K3
Message-ID: <20231011183622.GG3119521@bill-the-cat>
References: <20230803145441.315515-1-afd@ti.com>
 <20230803145441.315515-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mmJE62qLRrhZYE0K"
Content-Disposition: inline
In-Reply-To: <20230803145441.315515-2-afd@ti.com>
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


--mmJE62qLRrhZYE0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 09:54:41AM -0500, Andrew Davis wrote:

> All K3 boards now are secure by default, instead of setting this in each
> defconfig, make it implied by the ARCH config.
>=20
> The only exception is IOT2050, which I do not believe will have any
> problems with being a TI_SECURE_DEVICE, but for now turn it off to keep
> its config the same.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Tested-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--mmJE62qLRrhZYE0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm6yYACgkQFHw5/5Y0
tyw1UgwAudWW4DqX3s5clEWAIdRH5cOi1xBXccvimlt6sjL/SP6xooymko/3nC3e
slc/Z2Xvw6SYUpbNExsEGPnQkEAoyI2McpEa24NqGNxzAndSnaF0LlNIAHWVE+EF
3YL7P7HwNak6AcPstG9p+9/JObZrf0ZajKVp1MY5Iqiren8msbzMRDUdhZFJ89F+
9GxmPnQdGPaddEqAx86l/EO4XQYCz2V+OYakYIOkbm8PeHF6ZgDWRrT2P1VqauwG
bFI7jpOFW3HKH/S4/bdoUXndSSGqDZPojpUAQymQFmbPOCAF0078lDf2wD8yEkqD
qg9lUjPEPqeEbWBmUP2RjKXflhcH1KKBhqaSB5rXSadcy2LeUaGSI/oaTZv3vc74
jNMSEWlxts1ctU4DGXYdyX5BR6mcmK+dARzoa8wSQwXO5TSIC1JoSRtdh6f5cK9D
+BXzBarfyxWL/q9I1+Ra9HwTNo6xJI8X4YDRFiV3ClZxD3BgT+QkEvecWk6o5qKH
0vxio0we
=saPs
-----END PGP SIGNATURE-----

--mmJE62qLRrhZYE0K--
