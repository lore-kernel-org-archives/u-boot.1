Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609ADC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3DA880AE5;
	Mon, 10 Feb 2025 15:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HIu7425H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AD4880AE5; Mon, 10 Feb 2025 15:32:53 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DA680BAA
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e5b4d615267so2107258276.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739197967; x=1739802767; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vjdu77tOyuJwo6Kpxtti5F9HvUuzkRLjzniDC1ik5fU=;
 b=HIu7425HkOfAwIxHIlStfaCrPw7b+tIl7JpSHl6o3MzXvmfuGxmvuCvu/yB3fEgoiY
 NppkjDLCh6eVT8KnAk5Ou+IvkVIsLLoj6s+jZ0LcJYqWAAwbiEaDAkxEOcvwBRTBlQFN
 0/otHheSgg6i57NRQsFe8xrVH/6lTEPBd0UmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197967; x=1739802767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjdu77tOyuJwo6Kpxtti5F9HvUuzkRLjzniDC1ik5fU=;
 b=MIjcWxsPzpr5RnNPfyR5WMvE2fGy4pmGr6jzYqpOcziF/EyDFcEs4QguZfkIeGCMw8
 pj+nC0HAIHko2yYxHeuFZ3E9sY8iG4EYtELs2aB1BJTEfGVQ3JwbvMHD0WmGe0CvvEW7
 MOl0kkPFFWDrsEopj5igiDcw9Aw/Z1XNJXMR7wqIf++eOH6mrqvOu9DgSdOXP8rTbySp
 i3+ly37qTnjotmQWPrNEDPTA/3q9LmRODmJZvdl7LFDS6QEYKootAe8cMIfPas31NI0x
 4iCiKjqdthZ/rLcbDT9CAkaTnNF/IFgYHhCx3w1RrIcP0nYw47C5mweKxaR8xevFVIt1
 j/zQ==
X-Gm-Message-State: AOJu0YwD3hmNGOZG0NWYJj3ad8FaQUPlpyWpzEvxAPZwlvHk22Ek8n9+
 uTJwPNofFk3pVnA03ZHBk7AsdVBPluOfQ+98uMZ2F3sbzrt67FrfKb4yyHGXOIo=
X-Gm-Gg: ASbGncuRmKKHRJLLNXcpnJexZ1qJMeq1DmuUzy6dVkeQltjEbPGl+Cm22gqjnzM2OrZ
 2tLTZpYCG9LYI98QFtrF2c9jC0qSaYcPC+E3J9zRtVb8NSL3zQS3gD+IGT87iEGLIP3x9rBAe/x
 AHQWOTuxyDI5gB6vKi26SCBgNKhRUQCfwqr9bTci06sbX6daFO/6inumX7Fr4OFPuy72ukwigbD
 EAXVhlGyuGJzlYegFqeqRWhYg57WzPJI47YtesdHsjc+Fvhxp2vsb8bVQQsd7ccvYY91pWLDQo3
 hvj3NvdQAoWgs4Q=
X-Google-Smtp-Source: AGHT+IHAPUOieLn/s7W+xSUBhU1in7cGVxvAI+4z2bfVhxf9kPNp+++gvzuZFc6BE3bB19SpOyYAfw==
X-Received: by 2002:a05:690c:3812:b0:6f4:8207:c68d with SMTP id
 00721157ae682-6f9b2845562mr118049187b3.3.1739197967427; 
 Mon, 10 Feb 2025 06:32:47 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ffc0c0csm16656947b3.114.2025.02.10.06.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:32:46 -0800 (PST)
Date: Mon, 10 Feb 2025 08:32:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v3 26/29] efi: arm: Disable STATIC_RELA for the EFI app
Message-ID: <20250210143244.GY1233568@bill-the-cat>
References: <20250209020136.4108987-1-sjg@chromium.org>
 <20250209020136.4108987-27-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fD8PadZNCQI1z54o"
Content-Disposition: inline
In-Reply-To: <20250209020136.4108987-27-sjg@chromium.org>
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


--fD8PadZNCQI1z54o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 07:01:25PM -0700, Simon Glass wrote:

> This feature should not be used with the app, since we don't know where
> U-Boot will be loaded. Disable it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--fD8PadZNCQI1z54o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqDgwACgkQFHw5/5Y0
tyxtgAv/T9Xznh465jzqvPejF+99iHaaYNZLV3UrYRyGg+p1mtmBjEK1jXKoJgjv
d6+8bqXEyULAoUJJd9EF/ZWNvOGZFOXNLcY/bN+ceCBQYeITJJlAogQAb8nW/x4a
65IMqvINc/5xPfG6Zqc0jT80Xb57Xl4lEHxg0mePHBT3UybfO/s06teRhoJ3+LNS
7B2SvFNu17ySZHBNQbWdzeLX5RUizmjI60tbHvbJHwgIMCEEijgtTjJT1GE5Z4xe
OzdD4Wi+iFEs9T6E6+Hs3aaqcF0aaw0+4DXtWpRHkwfosy61LhkgKEf2FTG/7sPT
2i3dZoNOJn+uzn40iuJk4tD/CdmpWdIFwiOFq0SsyHGCixIONKPDeVepi8TBhzKN
diCF9rhZqDUYz72+q/Yx175Xo7ZFoqppVFX2kRDIQNMqUMuJspt0EEJNMd/1BZB5
j8+wNDjGONIT74eWAIYLzx+2ZaQBuzBf0QPx67MSbm+bW+Q17iwJ2VpHnhtZeoeS
KR1ODUL2
=1Rlm
-----END PGP SIGNATURE-----

--fD8PadZNCQI1z54o--
