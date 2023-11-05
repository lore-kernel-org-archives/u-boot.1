Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81525C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 21:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C52867E2;
	Sun,  5 Nov 2023 22:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GSYNoE2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32A9865ED; Sun,  5 Nov 2023 22:20:38 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16BB867E2
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 22:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-66d13ac2796so25072296d6.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 13:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699219217; x=1699824017; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5xDHI+jb0+XASKMdIdbIp8nwGickgAaPXmwgq7BC96Q=;
 b=GSYNoE2CBL8VyX6vGXh0jAs0lZYpHoTzsNAWL08fe2gkHB3rY4/ijvWfUUURGp7z6R
 kuuR1oP5kTMEm48qs9QMEfu5EM7NHv59LadLMvRLf8/emQxV50Og3MRu36qqpdKOr54+
 poFB0OD0r3tUEIQLdYeWQOqdx8iEvxCne0GrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699219217; x=1699824017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xDHI+jb0+XASKMdIdbIp8nwGickgAaPXmwgq7BC96Q=;
 b=bwxLjLfr1anq5obOR92RhbP3N6XKKFoY0fFQDP5qQOSSI2oAOET4EOaM6aML7ssRza
 5pS84vYwYqRvep+MLkONqvKdhc6M+fhmp4HxuF0W910+wjMMAJRNRS8rYkLGiU+WU36R
 ZLK3RIa1FgjDon9f57WgKoU2kVcQf6nxwc/o2j8ukrMCLAUcYjbep1NkGZMyZ+BKcWbs
 1QqolMXmOEatdSRhBDId3IqeoCOsLODvoeH9fGqZhvPC3vx6NyKqALkFG7YY3LAPbh6L
 8vCMWkMCViDvd3ndUXxoN+ehIMVtEArUvBINiTi03NCWYykjDhgPmh8gnQVn63mnPEH0
 Cd+Q==
X-Gm-Message-State: AOJu0Ywa0GIyky7luA2DewEq3TkhkksvxUeklc/AfAhV0T3yr7DhacmD
 179ny2+lQcdOlSRb6Tio4Ba6Seg/teTktrIneIbW5g==
X-Google-Smtp-Source: AGHT+IEUeh9WNOkQy3jJE265vO6QMrQy5OaZF1dpggYhjvS3akBzwjUYMjIhESeieq4bpLL+WzOS4g==
X-Received: by 2002:a05:6214:2a45:b0:66d:17:9059 with SMTP id
 jf5-20020a0562142a4500b0066d00179059mr34317757qvb.64.1699219217296; 
 Sun, 05 Nov 2023 13:20:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 ez3-20020ad45903000000b0065d0dcc28e3sm2844134qvb.73.2023.11.05.13.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 13:20:16 -0800 (PST)
Date: Sun, 5 Nov 2023 16:20:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 2/4] bootm: Move arm64-image processing later
Message-ID: <20231105212014.GF496310@bill-the-cat>
References: <20231105200453.1887418-1-sjg@chromium.org>
 <20231105130351.2.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oduFtZtryUgnWf4d"
Content-Disposition: inline
In-Reply-To: <20231105130351.2.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
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


--oduFtZtryUgnWf4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 05, 2023 at 01:03:52PM -0700, Simon Glass wrote:

> If the image is compressed, then the existing check fails, since the
> header is wrong.
>=20
> Move the check later in the boot process, after the kernel is
> decompressed. This allows use of bootm with compressed kernels, while
> still permitting an uncompressed kernel to be used.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

How are we getting in to this case exactly?

--=20
Tom

--oduFtZtryUgnWf4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVIBw4ACgkQFHw5/5Y0
tyxKlAv+Prf+wulSHmlTriISfhnuaiLWN5kOxhGyM2rIsaqH2zGbJdmK/jBd3wLl
njuxJhfODBGZgAZqs4EzI+w3DGxJvCT4+PqksQ/CEkQ6zBu/NdBipReHcDJJdKc5
gS8TIFLfLWQi1DOpXWR/T+Snu0YaloIFNm7vMJSKT73G6P2atcDFEKAG58M+Qfp8
TeRbvRwnhcMOyRA6ql8qRGiYYohxoeifkRM0TI0cfmFreSRP0KE0Eh0Y9UYmzO3N
PDpO3GmRuwNMLLnM6vtIJnU4TBKih5BiMy6feQXA99U7eYQ5pzXvE0vX1HbnY2Xa
9dbxK4zEgfANkMixXOvZbcZ+enmGsFcrb8RygBLp84ScosuNE8k+SrEzY0BCCibW
z21A8unT+UKzkAa7DgR0l4TlB9IS/X4YAvWF6JlV6ITggpyIcU1YBHf/BwKnvo1F
nXTXZmDr0ZYFbqb/uBbIxnL0EiNZNDGqVqE38RRIjOSRJKDLB1UmfcHXBj0cfsqG
arKC2nNt
=Pvy+
-----END PGP SIGNATURE-----

--oduFtZtryUgnWf4d--
