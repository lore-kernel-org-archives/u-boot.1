Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FCBC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 13:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B60E871CD;
	Thu,  9 Nov 2023 14:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="myp5+/YX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE50870BE; Thu,  9 Nov 2023 14:38:12 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB52871E7
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 14:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-778999c5ecfso53916985a.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 05:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699537087; x=1700141887; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5hT8CnfUgW3KJXLLqfkba6mNjOBPHFV6/5HeC7630Ec=;
 b=myp5+/YXiCzgdxMxiVUcxRazopGtW8FojuTrOqgU6badaEikHsuAmB3m+OeQ/fvvi3
 /VC7L7jvgpawHztc+pO1fOvePLVrItYx1LF185i03soc2XZu2FVmJ9pM9aAbhsWvQXeu
 0D5IMUYwBHi4meftlgEgH5bk28BfUPLa30TjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699537087; x=1700141887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5hT8CnfUgW3KJXLLqfkba6mNjOBPHFV6/5HeC7630Ec=;
 b=UvtqEX7SHGNf1XU0p4+g/7orWdliAVS9X7Ge9/OKns+5d5dvrDistvV6nYiWxFbIfU
 rjbZWALAJd6GyhLCIVk51fBf1CCjyLvkiaVZEyfmVtt9ac57Spw8X+2S7TaPVuozv1Au
 eEOOzPJOZ6df7rj6dD4bIddd+0QbJdcD3G0ezG0KGIFSGlrW5Phz7K1lBo3KaRgHDAl5
 MvfhvGtu1kLTvZi0/d945VmFZ/DpJDgSALi04MBiN2dL9EXLLbP1ulGbxJSS1UiCg8Md
 YpgPAE3ouy4IbEpxKuLlM8BKrN3rUk9JnOVKOzYzs4j6K+1PAUnf62Az7KKcn3HuSYsN
 ul8g==
X-Gm-Message-State: AOJu0Yw5IxA8ZP2/FYmr41r7tTVHJK3mAl5oW9OY/gSYl0sVJOsAsCWY
 7QzPqylt4jBYwaKYQaDGDid54A==
X-Google-Smtp-Source: AGHT+IFt/78OaFG2Ey5deEiRHPHfEyZprokkOm1JzU4E6EY1lK6N3OqXvOk4Lds7uPcJkhOUNE0H7g==
X-Received: by 2002:a05:620a:4116:b0:77a:1476:fb93 with SMTP id
 j22-20020a05620a411600b0077a1476fb93mr4808798qko.47.1699537087533; 
 Thu, 09 Nov 2023 05:38:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 y29-20020a05620a09dd00b0077a7d02cffbsm2012022qky.24.2023.11.09.05.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 05:38:07 -0800 (PST)
Date: Thu, 9 Nov 2023 08:38:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 John Keeping <john@metanate.com>, Michael Walle <michael@walle.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH v11 09/24] cli: Add menu for hush parser
Message-ID: <20231109133804.GE6601@bill-the-cat>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
 <20231107214121.132079-10-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ie3kQ4ZmSst35LYA"
Content-Disposition: inline
In-Reply-To: <20231107214121.132079-10-francis.laniel@amarulasolutions.com>
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


--ie3kQ4ZmSst35LYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:41:06PM +0200, Francis Laniel wrote:

> For the moment, the menu contains only entry: HUSH_OLD_PARSER which is the
> default.
> The goal is to prepare the field to add a new hush parser which guarantees
> actual behavior is still correct.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
> ---
>  cmd/Kconfig     | 13 +++++++++++++
>  common/Makefile |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index fd16c3a48e..f3a00ee59b 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -23,6 +23,19 @@ config HUSH_PARSER
>  	  If disabled, you get the old, much simpler behaviour with a somewhat
>  	  smaller memory footprint.
> =20
> +menu "Hush flavor to use"
> +	depends on HUSH_PARSER
> +
> +	config HUSH_OLD_PARSER
> +		bool "Use hush old parser"
> +		default y
> +		help
> +		  This option enables the old flavor of hush based on hush Busybox from
> +		  2005.
> +
> +		  It is actually the default U-Boot shell when decided to use hush as =
shell.
> +endmenu

The indentation is very wrong here, please fix it.

--=20
Tom

--ie3kQ4ZmSst35LYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVM4LwACgkQFHw5/5Y0
tyy1XgwAgbb257eNgZRgjAnfmPKL22xTiU1McghZ8Xcb+zW3P2nsO0rlNHZGA5Hr
Av8PABLvBSwrcmUMqhnJCO0EZwj1t4m9eqFHV3vhrGve70SSFzgf4PeedJAiLuGN
AQIYkHh4oidwHBp4B8r3G41Jnm6PxR0XI2pwH/1mm9JT8YkPlTrrUJxxfo6BI3fe
1n/GTaZFpw1a+yv5i2a0HxDFB6emxlims8cZpnV90uezlXAqbag5iXqNeNi+O0FR
p9dCmSsPgt9TYg/q3eJ3qXCcH1+/zMBJLIpHTLwZ0yKmsYQzfdf0Fj6W5eCVwPi1
46JOt1TLZ5Ons7Cgbcdnw4DvgpKDBRgY4QEFWZLYLl2T4die3xMWpNiTkhAkon2j
jbv7Nvv3HxeUl5j5y8XzBPOuqm1YxH8WMojOvEg2pXKOF510N1x8eYwuaKepQ72j
rgb+KfMHbqxcrEhxXONgN5gAs+/tj/NjtjaNA1HrLp5X3NZhkQCsWqP3hXSHfwkN
o/QCcdXL
=EAac
-----END PGP SIGNATURE-----

--ie3kQ4ZmSst35LYA--
