Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD1CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 13:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E85D88701D;
	Wed,  3 Jan 2024 14:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fvlaMvUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A183387516; Wed,  3 Jan 2024 14:26:18 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BD286FD8
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 14:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7818ab57d7dso391572685a.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 05:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704288374; x=1704893174; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lRHLvDgAtREN0jwN+hEvxoCN7BzPSK76gHPpF3i6djk=;
 b=fvlaMvUHhEqOfzD+HxQZgnDeNvuXGu+Prz+nUiU8A08gf7hUBxz11RWBM9LkXRE/8B
 nLHGFdiuarnnNo9hn+c7TbyR6kZHC1Dj0j3SnYkaF9x2y8zsblNeXBmGDFhIl8aW2iK7
 ThVFdixCn/jYOU/+dJmi2qetSU0qFHy0dktD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704288374; x=1704893174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRHLvDgAtREN0jwN+hEvxoCN7BzPSK76gHPpF3i6djk=;
 b=tlZojXP63xdOj3yYHCcz9rXacfaMVknEuMGtwGvB8xD2Gm5OJTr+nZwY26AhlBTj3R
 3hL9bnKNDoj4yPASGMVrx2D37kyEs9/2JaUCH3VJnWKW7K2c23ko8qe9YqFPAaVF8fQR
 obu3NLfvZ+bqSYnvFJeepDZgIrNtWnik7EQxQp4/nEGAen9HtKJZhyS8gJoGqq0Nirzg
 Q41S6eSk3szMlHClhR3VRKWvZ8GTGWfFDvvbh1ThhLBld6z8uFpg9XDG7CzFiM6SvKoU
 cBP7At/0PpZdlIxhclIqDCMQAZtHDjrvqXuKxxZaodhbDtersZfXMMZE/EcM3KMot/Qf
 LOSg==
X-Gm-Message-State: AOJu0YyrX+7wuHkFbm0xcbYU/L+lM9CnJhwYqves4HdIQlLtuSr+S6+f
 sI7xWiIuezlKpcOGkotwCsKxrwbUUxBEFQ==
X-Google-Smtp-Source: AGHT+IHdh9Dlx6ibXTkFXVDH+5oj5p9ghrXnp/C8/kQYR+SvZf8rSMQf+vDKRA1HtmJPLJJK2L/hUw==
X-Received: by 2002:a05:6214:4103:b0:680:c86d:3f6c with SMTP id
 kc3-20020a056214410300b00680c86d3f6cmr1537840qvb.36.1704288374306; 
 Wed, 03 Jan 2024 05:26:14 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 b12-20020a0cfe6c000000b006806114a111sm5747006qvv.66.2024.01.03.05.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 05:26:13 -0800 (PST)
Date: Wed, 3 Jan 2024 08:26:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 rfried.dev@gmail.com, dsankouski@gmail.com, seanga2@gmail.com,
 marex@denx.de, laetitia.mariottini@se.com, pascal.eberhard@se.com,
 abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mach-snapdragon: Move APQ8016 SoC derived board code
Message-ID: <20240103132611.GH1610741@bill-the-cat>
References: <20240103130716.4144892-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QnnDbjmyKyNg1rX2"
Content-Disposition: inline
In-Reply-To: <20240103130716.4144892-1-sumit.garg@linaro.org>
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


--QnnDbjmyKyNg1rX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 06:37:16PM +0530, Sumit Garg wrote:

[snip]
> Tom, Simon,
>=20
> Is there any U-Boot policy in regards to board code going forward? Are
> we moving in a direction to get rid of most board specific stubs from
> generic U-Boot code?

There's not a policy, no. But this brings this platform more in to line
with others (assorted TI SoCs) that already have "board" files under
arch/arm/mach-foo as most of the board hooks are already abstracted such
that it's per-SoC with only an occasional further hook for true
board-specific changes.

--=20
Tom

--QnnDbjmyKyNg1rX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVYHMACgkQFHw5/5Y0
tyyifgv/epKucR/sMZqWDIzktO0nDMS6qIHOMhXLiXsUNMccIxzC20QtkJwcizpb
R84oHe+YNYpci+AqgOhVL8HkAdB9gWVF6daQ4K34evH2UQU2DNgm6N/mEKZAuyrb
F198fyhZo7qc3799lFSnJxBSSRudeHlCaa8yY4pMKSPKAi9DMNT5WR4pnSkuKIvM
uJa23f70uNhU1M1Qie1Urf6Tz/knqHhm5OeesqzJHNwS6Ry5+d89bP2tG68NUO1V
sRB098nHeqZc08N5SHeToYHZIpxchOqWwQkQ+GFXi7LNJAKxO920rpEEwG1ScNnW
X7OMexv65PCL+B0pNJw8Gz8jwVa+ic/lyu6YclxeCpFoYslp9OwNcNtpL/p5gyyp
+H/25tH9FXJxIqTJAaDtSS3br1DrT+cNBb8oDyxevWWScQI/oBNEuTZuqPzIKWCZ
nvZw6b1P6kygN82h6nYFAGfZlB4yJ2ilofHm7zONi+ue9AjXD66OD4nYaiOjW/mI
ZegMiGah
=AUnu
-----END PGP SIGNATURE-----

--QnnDbjmyKyNg1rX2--
