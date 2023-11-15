Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FE1C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 19:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1E1870D2;
	Wed, 15 Nov 2023 20:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OY4ot3XG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C83D870F2; Wed, 15 Nov 2023 20:55:47 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F31F864E7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cd4446cf5so409041cf.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700078144; x=1700682944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+o601DgVX9Lo4NCMYEzCjWeSE+XQGXUm//Rophvt7Ck=;
 b=OY4ot3XGdBRwzb31X+p3/mz+4RFPo1GaCt60UXk2bqaV+LJ2NTCgE7Ktw74M8+oedp
 TVXLoxLAINXvf7yv0hlEG5/Tu9in3ejNSScBM40Gbp2J5yeTwEICCcvA8RQWmRwDFRPw
 O6FCfdBcUo7Cnec0wQywG/dugDFZlej7JIw1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700078144; x=1700682944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+o601DgVX9Lo4NCMYEzCjWeSE+XQGXUm//Rophvt7Ck=;
 b=r1UBhGb1bfh6mZ7efImWlEwI+NHY68dF0stOQQrakmiI+te8CuOHN22JQ6WhkSwgn8
 /SIa75Ma2sPlCFI+zFLYWvLyiNuo2PQ2+9Nap1P7x5nSOlBlOTGQT5dYl7AG401++Z8C
 dK9RoVXspSQrMgE7o5sl6EFCfz/37RmDEAJzsGv1KEiKIQkXdrLgU4P0srdJKHfqA3BO
 /1Y5Hhz15nwgRIXs/RzmHgsExt4vbZd7eYLWa4byzC2HIjtjhhTjikO7pWwtmBi+TkVf
 8BKJODWaCPN7f36+qiscjwCKf/2WPVKPiHaPOvXqR+lnsAgW39wlWdTIgkUSEnNVUYET
 PVpg==
X-Gm-Message-State: AOJu0YzqsRWLOkcOmPr8qBnEMmuPS00z75xiKIq2mCvHs1jqiW1aVODi
 kW8NUMhccT6qULw4m+6kjZkBIw==
X-Google-Smtp-Source: AGHT+IFJojc+x0be+09wYl0Qc7ME97FbFUtmiUNFtDqoIfCFhIwUIZuRS86bh6m9cwy/EV3qWFjF4g==
X-Received: by 2002:a05:622a:146:b0:421:c6ef:4b1f with SMTP id
 v6-20020a05622a014600b00421c6ef4b1fmr9050847qtw.26.1700078143948; 
 Wed, 15 Nov 2023 11:55:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-03f5-0f73-ac9e-a6c1.res6.spectrum.com.
 [2603:6081:7b00:6400:3f5:f73:ac9e:a6c1])
 by smtp.gmail.com with ESMTPSA id
 a5-20020ac87205000000b0041b83654af9sm3783924qtp.30.2023.11.15.11.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 11:55:43 -0800 (PST)
Date: Wed, 15 Nov 2023 14:55:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 01/29] arm: x86: Drop discarding of command linker-lists
Message-ID: <20231115195541.GL6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oE4T2kyaS5CZOpe9"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-2-sjg@chromium.org>
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


--oE4T2kyaS5CZOpe9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:46PM -0700, Simon Glass wrote:

> Since we can now cleanly disable CMDLINE when needed, drop the rules
> which discard the command code.  It will not be built in the first
> place.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oE4T2kyaS5CZOpe9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVIj0ACgkQFHw5/5Y0
tyxA8wv/QawLNah+p5dOds8+nhmsQkI7DA1PYeYWZAmlY1yEaHnFZr6SgaDsb8iQ
GJRV+Iu4uchVM0y6J9CaJg+4gMsWjIUXcpJINncgcpD4IAcPu2SibVLqMepnRrjY
8ZvLLfuOujPM+MY3IhjDrv+zVJQQt7yNjf8Gep5lHtbaYBnRmzRlma2PE4QI09Ds
ccFv2NRfsyuWiSJqx/K/j8Ph2pIMvdRrXxEHMQyPpT2LSzM30CYCompWouYUNb6I
WKtyGV6bAfTMGmjeCUHjbiasfxLW21DFX2t5hIWSe8s0E7rSTih9Kbq5V9A86puF
REMr7LSdF9weiKXU5aB7hKpE+d5eGoolq5Les9bp3JTCFcX2NKSxsdCbGu63578W
9I9URaNaRE6raU1Zua9+I6eiq++k4oByyNBC0OyXxcb/vA2bs4JFDWAzRxjtirUT
iSwY9x081c7n4DNHHb6Bj/Yh8k20Nfh1xUXl4i4dNrNrUfb7phU2NpLy1O5++1UG
2HRVkTHb
=ic2r
-----END PGP SIGNATURE-----

--oE4T2kyaS5CZOpe9--
