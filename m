Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4C2C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 14:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F26807B1;
	Fri,  6 Jun 2025 16:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I2vLfJb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A79281FEE; Fri,  6 Jun 2025 16:17:12 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00155800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 16:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-404e580bf09so554151b6e.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749219429; x=1749824229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=drImVEcZ4XbrC2Xa8LAZoyLBYfTipgUJzh4kR6k6DjY=;
 b=I2vLfJb5Ihzkcp88iv9k+S4o7qNxluumOfTPs3eevLVGewQPgk1b5fSHrcQGnsWlMD
 zSB7THiLkZOnFRTaRDD3KtzNVKrTcqJ7EaI8MIBUG6A+jEM74LhyUh9GH+haeGODVq/C
 sfbkGgfwBXgouclJkMoXN3kDUFvb1gDY6A1DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749219429; x=1749824229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drImVEcZ4XbrC2Xa8LAZoyLBYfTipgUJzh4kR6k6DjY=;
 b=OYGOqFAGJBzDMchVIoP/Jn3sQcIod+horGk0rPwuflC5hEEv8uGV5UtMJf4XW6eZNp
 D3EjFvZtsBzfC+y/CzC1D/o0BWnWZd04qhQ67Hij3reU7JJBK3KfiMZ/wYyDbtcicp09
 duyYY7JPksYhygUWez+8yjgo4JTKDqSno2BuIy94323yQzxcuLd+m5SRrrJ0k73+DV0c
 ac88D49TULzxwe0L+W8riTQa670OvxSD4Um+eMOmdelNQY9fKBg0k0O/dj2gftFkzljr
 zKAaB5NNo57zLIW/IYIh1iTUGuR3Gmn0gCGONd7XsCcb9yO/yUb9I6CyGO6/4b8ZjqU5
 Cc2A==
X-Gm-Message-State: AOJu0YzV6bETY0NZP4Xb0kK34I58uAhFZP5D7y6YLbaI3RsDd9kysW5c
 lnNouLgiuzjepJuMjjobIn0SCBreQi+x1RUWgz2poPYo8CSV8ljkNAPrr9sDXInd0QQ=
X-Gm-Gg: ASbGncuF0KNAtA8v39W8G0I1rmGBP20ZbJ32JmRkfWr6O296nDtxrDgwtdxx9Ade0+M
 ctkyGC3H93P+QDFhSKMcLLZpIfRwQ/56lVRJXporb6wX6XVsQaQ3Z4u8uFPh/A2tZJBdcykPZ4y
 PGgeKhzouK4yfhe8jWgnlQgPW5RZhIZdWxwBDe0ltbJSHhiXVtZ9MK8sR+rPF+Ij/qrew65RTIN
 w+obmp3jk54tDT2YrMpgxuGCZPVOEf/buj/ERnq+m+THdf/qXC68nKn8z5WORT0pActVmTBi1KL
 XeyZiF+K9t0SGf1NAltRCHLdr/ZGjUBUfjmr/GiA9OWBK3N6XZvvO9hbi5iV3wuGS+gKYMUHNJH
 GxvDGBDJBefH/joSR9vIFII4=
X-Google-Smtp-Source: AGHT+IGjPabHuJYkoCNeOn4byVmIHwmjg702XBlAk+LHkbHJJInhYjxjpopCcD8NlhGd3xzgQeOfGA==
X-Received: by 2002:a05:6808:6804:b0:406:7277:7a52 with SMTP id
 5614622812f47-409051a4f72mr2709234b6e.2.1749219428690; 
 Fri, 06 Jun 2025 07:17:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73889f5a1c7sm289289a34.26.2025.06.06.07.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 07:17:07 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:17:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michael Walle <mwalle@kernel.org>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 03/13] lwip: split net/lwip/wget.c
Message-ID: <20250606141705.GM1382132@bill-the-cat>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
 <20250606064211.3091237-4-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="obKkFLhIBoLP1TF+"
Content-Disposition: inline
In-Reply-To: <20250606064211.3091237-4-jerome.forissier@linaro.org>
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


--obKkFLhIBoLP1TF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 08:41:39AM +0200, Jerome Forissier wrote:

> Split net/lwip/wget.c in two: one part which implements CONFIG_WGET
> stays in net/ while the part that implements CONFIG_CMD_WGET is moved
> into cmd/.
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
[snip]
> diff --git a/include/net-lwip.h b/include/net-lwip.h
> index b762956e8fd..cf3cf513b2b 100644
> --- a/include/net-lwip.h
> +++ b/include/net-lwip.h
> @@ -6,6 +6,19 @@
>  #include <lwip/ip4.h>
>  #include <lwip/netif.h>
> =20
> +#if CONFIG_IS_ENABLED(WGET_CACERT)
> +/* HTTPS authentication mode */
> +enum auth_mode {
> +	AUTH_NONE,
> +	AUTH_OPTIONAL,
> +	AUTH_REQUIRED,
> +};
> +
> +extern char *cacert;
> +extern size_t cacert_size;
> +extern enum auth_mode cacert_auth_mode;
> +#endif

Since we aren't going to run in to compile problems elsewhere because
these are in the header file (IOW we don't reference CONFIG symbols
which might not be set), we shouldn't guard these here. In general it's
an anti-pattern because it makes it harder to do:
if (IS_ENABLED(CONFIG_FOO)) { ... }
in code. Thanks.

--=20
Tom

--obKkFLhIBoLP1TF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhC+GEACgkQFHw5/5Y0
tyw8Awv7BRKENSPsppM4LYVofkGdbFN+4BJvnD47URNRUNBqWqG1AwXkPRy6qIho
fZtV61sCJuxrLBJ5ubybmx2t0E7HvxfAgnmnYFOmB7D7IoV02HTrawgt8z19QB4u
1knDxFaoCSDRlLFOfKJVdTLTWHoDNjswcQXgbcNFzuA8AJgM2LYKTuygk4JrH+Vo
HLdS3KzWCOTEBrdK4r3C0YKxgunrM8NyHJR65ZeIjXehXpFk19vWdp6dC5N5wWPQ
0QMc5+7uFVRYFxaVKL4hOAP+dWj6ENjZmIMr2lS/RA6Ky76NYf2ESF0gdEo0miz5
k4WYOzFwLqhyDz/+8RTrJfQJEiBSIS/HVXIH8sg0qsRA1XpENSZ5vtzF6Z5NiVY4
QzqZIQixsQNa4QQv2g/EkSHE7zMRJspcQ18/5mCiAdZdfbzH7TEKYewH4LyeJ27D
jl7KieNS/HaXIKkPo3BSlOfolzpt476I4zZxvQH369XaoIxf5IUoXrBZPkTsKR6h
8yzDCIAW
=z9E0
-----END PGP SIGNATURE-----

--obKkFLhIBoLP1TF+--
