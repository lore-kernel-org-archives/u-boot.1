Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C437BE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33CC08971F;
	Mon,  9 Dec 2024 19:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IqMPZKH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D666A89723; Mon,  9 Dec 2024 19:47:13 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C0F88F2A
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d8878ec049so42492616d6.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 10:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733770029; x=1734374829; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JTJanccZNuFk9QQH+oh3/m6oFrdOaWqGZDEKEY/iDEU=;
 b=IqMPZKH84pmNEynHwU37mbrAqn3PUHHYybNmsaOXc12YZcrW/ysPDuAh8zf5yeAAid
 65qEGrNMGsLgn2o1aneNCZRwFohJsIvGD1MJ3SlxW1cP00CRsoJ+lg9eYrL64ZdzmU6E
 DW2vrbocem9QUV0DCvOcxg3kGRAF9CNWpkBvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770029; x=1734374829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTJanccZNuFk9QQH+oh3/m6oFrdOaWqGZDEKEY/iDEU=;
 b=aUlYuDyxDDHkMRwtWVOkcwlOVn18EEtTfOmNQOY2Lcw6h5KdGIyVzJY6GNYc84S1ZE
 UUfMsXSElFYWwcrBFA/yKmrraNWUxYTN6octLj29CI9QA7GWqrufNza/czGY51IwSkKl
 7iMtRWK1YRncIMwgb01nhY2JtrRpLPkpMSLG1axIkddKabwsokODBcOjL8+qnIVKanZp
 sl9OlmZNGuds8h2Z8nnlMScNXfzs57L0gaC74aasogZ5dyrC+FI9pLsOeKpW9N8yIfVb
 tuj1rNkAJ+zzVwIZSAjXrvcg1Y7NjibSyy9ht3pcLf5I+b9Fdr1st7v+IvidgfJJ4Ns2
 B2hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8FE5GPXbaAHFVmiOlr1MMlqZ+6mIGICxl8Twa0NwTDWtI6Ke1kQc/fSwNwAifmuqShVIVLH4=@lists.denx.de
X-Gm-Message-State: AOJu0YxO0XjT0EuClvNqnsZiRb5UrjTKC8Xhtwl/i6bzMmiqF63HWQSk
 T1a6PcUfwQkuz3r5YEAppbV8dOA3dfZz29hQLm0UiX7bGRsQeLGrjbKktPvNHRg=
X-Gm-Gg: ASbGnct07g2shqVQfyplNDy55Gbp+dBcdOgu7bSSPSbMlwXP6TjBbi3br0CRUq99tse
 GHr+TIOFZQKOuHXqWw6BwiS3Qtb/ZZ+8QOcZ7gzzCG0T5TeQ4nZGbq3zKNxgk+SSCgJpPJfPtxD
 0ARJmwHATpBOInPakYJBzrC8UxrLdXGQvDm8R4tJTnJJOJ+nAEuKmcHJ+/2ExOd/Jn2/wTt8lVq
 dcWhGZqsrr2yxUXn7jHVFww29h8LaYECFv5rZmn8YMJcymXgWw=
X-Google-Smtp-Source: AGHT+IHrH+ya6nrBdiQuz+vOJ6C8FZMMnU/yLshEmBebTf/04HhzKkvxyVRLoBZ4VeRbkggnX0og6Q==
X-Received: by 2002:a05:6214:f0f:b0:6d8:8cb0:b40d with SMTP id
 6a1803df08f44-6d8e71ab7f4mr241811646d6.39.1733770028854; 
 Mon, 09 Dec 2024 10:47:08 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d91626e4bfsm9629116d6.130.2024.12.09.10.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:47:08 -0800 (PST)
Date: Mon, 9 Dec 2024 12:47:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Nam Cao <namcao@linutronix.de>,
 Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 1/7] lmb: Replace lmb_reserve() with
 lmb_reserve_flags()
Message-ID: <20241209184704.GO2457179@bill-the-cat>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-2-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tmbtjPu399V3kYkt"
Content-Disposition: inline
In-Reply-To: <20241208105223.2821049-2-ilias.apalodimas@linaro.org>
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


--tmbtjPu399V3kYkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2024 at 12:52:04PM +0200, Ilias Apalodimas wrote:

> lmb_reserve() is just calling lmb_reserve_flags() with LMB_NONE.
> There's not much we gain from this abstraction, so let's remove the
> former and make the code a bit easier to follow.
>=20
> The code size increase is minimal - e.g for sandbox which includes all
> of the LMB tests
>=20
> add/remove: 0/1 grow/shrink: 12/0 up/down: 46/-4 (42)
> Function                                     old     new   delta
> lib_test_lmb_overlapping_reserve            1018    1030     +12
> version_string                                70      76      +6
> test_get_unreserved_size                    1032    1038      +6
> test_alloc_addr                             2933    2939      +6
> test_multi_alloc.constprop                  3034    3036      +2
> test_bigblock                                911     913      +2
> load_serial                                  946     948      +2
> lib_test_lmb_flags                          2101    2103      +2
> do_bootz                                     526     528      +2
> do_bootm_linux                              2067    2069      +2
> bootm_run_states                            5275    5277      +2
> boot_relocate_fdt                            599     601      +2
> lmb_reserve                                    4       -      -4
> Total: Before=3D2492742, After=3D2492784, chg +0.00%
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--tmbtjPu399V3kYkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXOyQACgkQFHw5/5Y0
tywKXQwAlLUySNy16HI+1OO6/ZI0taOkivYHW3+OICKzED8n9YU8MrIWDx/1hu7S
wc6d1vgMpiOq4CjV7xxN6C0xWEK8hb2IY+5I7sh7iAO4rkNonojxZeY/RUZacz9p
KK4wDJwIsuSBA/OncJbabeJUXdQk9s2wkWAR4PM2fGXPRWPwOU/OnV+cdrwpZ7fr
ajQzxim7A9RybYocPgfqm+b6+GUgQeD1iARcXqqGyir4mVCs8Z1pCTtXPSjbq45A
I0++ar4IfA5OqtHi5XkW7AJLwxUGIufsqvrP9io4O3arI/rM21ULGxmZaVKCQ5/j
aqb1uYKq7P0MsFyd+y3FKb451ZuFauVPgeZr0II2M7Vk8HqGj7Zv9f/HyVg6K+rk
HJ75WV+sdJ52px1k+D4MVpiJPDjlt3FOsQq8zM9UvVFrurf+gbeziX3S78P2kpIN
AB6gau5qWUNbz16y3ReGl2rlRc9L18xYbAlQLE7VSd+UxsiolTa+rm5JuzkKHxQv
PiYsVgwb
=dEgR
-----END PGP SIGNATURE-----

--tmbtjPu399V3kYkt--
