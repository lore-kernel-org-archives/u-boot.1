Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66F8C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 17:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C50D805C3;
	Mon, 24 Mar 2025 18:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gSpuQbPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CA2810E8; Mon, 24 Mar 2025 18:24:44 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C24800C1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2b38896c534so2260844fac.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742837080; x=1743441880; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oXfznV6F70GdsDJXaZy2OAMSAT3BXFVJcKf6Dgjt8v8=;
 b=gSpuQbPVC6qVUm6vh8RU3RZGNzPb/qYSEgF1cKNzHiiGTAQoGLuOv3QmpHFtVp6cSu
 UmrVLGcZxptGcbFFG/aBa208ajCPGJC+e9PMsirp6JNxQtYb/oKnHW9z603WLC6fm8k6
 4xGXlko7sm7ggp+qW+FkrDM/JjtU8/T8lTCnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742837080; x=1743441880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXfznV6F70GdsDJXaZy2OAMSAT3BXFVJcKf6Dgjt8v8=;
 b=eQh2EQ1u9Of01VTbF2czEpanS9qCUQSpp5ZTVvz1U9lHt57QI5+cZPIqcZGDtTgNKH
 1W/O1/pqsBGpzKbF/YUe7GPvhz9To2wjUla0VGlYJ/3MUr09OF/nR2KaAaSjw3X1oWLe
 R4CMEKh6Kufqgx58mcLNerxgrAe7RDhRWdHDetF4PT5WRj1HauyAyN4YSRx5/uLu1qfG
 /ov5SqvHbeUSf9xJD4wrAJmnevsKGMwP1Z2Nw9t6Z0DYpwD6PXy9VW2OhFD/590xwAWH
 HL+I1w/PNcFzixg8UcSLBTcdz9pe/TXTFx1ets7UlFNWm+WNLTud0zeH8bEcDLco56tW
 JamQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4hhENwCnNGIJYs2Ql0FauUxH7PBjG0zjzIbZZQYsrqrPoLa/6UVSnCTbZl+D/UJh5+M34JZU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7N4UdViJs2CevGEbm0HRskkGZmaZ1gkxvD9WPBkpu754kfH84
 C2qv2KHy7ElKsw4DUKfLeeLwfO558u2mx/0VZbF70ggw3uWY6dla/Fz61gdIT58=
X-Gm-Gg: ASbGncul4g0KhLxmK1M7oyRHSlW1minK2wGycWzMauy9O651yLaaWmzfTNzzzULNJJU
 /Jxzc5X4qbFEeYNNvEWlZKZttSWd3jKoDeyKUAYuQeFBvvZN5rHmh1noFNZq3cRGrjFOn7r7fql
 ovumVDv8i0h4UA7LpvyYMmEuLtUsH642ToqR9/fKFZSY24I0OnHiQ65pVrrUjOqrMjthlf9xwNc
 kb+W8n6Z7BsVHlcC064emHtjmugXWk1bi/cBXgXXaKK3qeZgAbY7HTW3tp8qmGSv4CdWrBa+z/M
 0OsxAciPStaKvpMkW8E166CQq1vEA8Hntic+9qvQwTk=
X-Google-Smtp-Source: AGHT+IHoyGYxcc121mrfShzjpDL8WvH6oXe+HLR5b6rdPsaFALM2cn549eJc394cGqzWwrrEjE/VDg==
X-Received: by 2002:a05:6870:470e:b0:2bd:456c:923 with SMTP id
 586e51a60fabf-2c7802d4edcmr8475917fac.11.1742837080080; 
 Mon, 24 Mar 2025 10:24:40 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c77f0ed902sm2099210fac.48.2025.03.24.10.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 10:24:39 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:24:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: n-francis@ti.com, s-vadapalli@ti.com, vaishnav.a@ti.com,
 a-limaye@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com
Subject: Re: [PATCH 1/3] mux: Kconfig: Add Kconfig options for MUX_MMIO
Message-ID: <20250324172436.GC93000@bill-the-cat>
References: <20250320063004.1069653-1-a-dutta@ti.com>
 <20250320063004.1069653-2-a-dutta@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OKds07a+1POicrS6"
Content-Disposition: inline
In-Reply-To: <20250320063004.1069653-2-a-dutta@ti.com>
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


--OKds07a+1POicrS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:00:02PM +0530, Anurag Dutta wrote:
> Add Kconfig options for MUX_MMIO so that it can be enabled
> in SPL stage.
>=20
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>  drivers/mux/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index f15ee4f833f..2b95eb02177 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -10,6 +10,16 @@ config MULTIPLEXER
> =20
>  if MULTIPLEXER
> =20
> +config SPL_MUX_MMIO
> +	bool "MMIO register bitfield-controlled Multiplexer"
> +        depends on MULTIPLEXER && SYSCON
> +        help
> +          MMIO register bitfield-controlled Multiplexer controller.
> +
> +          The driver builds multiplexer controllers for bitfields in a s=
yscon
> +          register. For N bit wide bitfields, there will be 2^N possible
> +          multiplexer states.
> +
>  config MUX_MMIO
>  	bool "MMIO register bitfield-controlled Multiplexer"
>  	depends on MULTIPLEXER && SYSCON

First, "config SPL_FOO" should follow "config FOO". Second, "config
MUX_MMIO" is written wrong because doing:

if MULTIPLEXER

config MUX_MMIO
	bool "..."
	depends on MULTIPLEXER

endif

Is redundant. Lets fix that and then not repeat it when adding
SPL_MUX_MMIO.

Next, it should be "default y if MUX_MMIO" _unless_ it's really not
going to be needed in most cases, and then yes, what you did is right.

Finally, SPL_MUX_MMIO should depend on SPL_SYSCON as that symbol does
exist.

Thanks.

--=20
Tom

--OKds07a+1POicrS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfhlVQACgkQFHw5/5Y0
tyxsiQv/YGBRyP16FnZcBrJ83XlOsMl08ff5xqqvwy6bwwHWBpUBBYyPtDbPK0W5
Pw70+jLdr2Nf0+61HctK6UmKjbnIZasWpmUE8ecCU9nzAq2v6LyLwbUEGrB/KkqD
letskwOjTIf9qiJmVakvPsd7nNiK10D4nHGnZneXUcoCShBJBwYQwv/jsk3bsqNB
ISCmrcskDL0IJGpEXBkzqxdESD86Rg2078dVvsVHDeqMTeaBVGo74yanKNymE6Uu
lW00wllG0fQbBGF2lv+yUFIv5lDVi3ejhvIRv+JW7ol5EJZAjURyImHE+ra2isUJ
gemDJul9N1L4U3lEGG1HaX3644X7dX9Dz3jhzh5IO/GlrN1Eg08eEbRlW0/cM7+Z
VMkUX7acqFsY77dJIaDGr4b8gAIib7uafFbHXbe+F0jkVxtEudNIRuK7+GTsI/y6
gn4sw58Cf+9xebEecjb3cdIbM1P9AeupCcMb/OlU5PIx/MQc3mYFUgeENFHzxPZ3
ORU3H947
=U+Q8
-----END PGP SIGNATURE-----

--OKds07a+1POicrS6--
