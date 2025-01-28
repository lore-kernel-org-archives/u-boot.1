Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8728DC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 14:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86B181DCD;
	Tue, 28 Jan 2025 15:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jYWS+Cb0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92DBC81DCD; Tue, 28 Jan 2025 15:15:10 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB4481DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 15:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e1a41935c3so83073446d6.3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738073707; x=1738678507; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vf2WnMvg98jlrqPQqBWWQJD0leJ1BFDcmJIHuUrM9L0=;
 b=jYWS+Cb0xwD033mUA31XWQTl5WP1b0Gc8IOGGdMXOevMn02as8f409gwuTBR1vCmah
 8R+kvbeFudX1pq3c8BS58VZ0kK8WdnVv7ojzeNyPpuubCrCo6ob1Wt2pEooo5BHeoM/A
 J3TMOfqbT4IoAID6ZEsZOlY5lb1wf2P2tTzuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738073707; x=1738678507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vf2WnMvg98jlrqPQqBWWQJD0leJ1BFDcmJIHuUrM9L0=;
 b=XLWo2i7FfmRcKyfN3KnPXwCjrna6gA2uYx+GApp0Y/rM1aKkkVqxOB5AHuQUwOl3YC
 NuI/nKN3MFs97OqiME2WEkvdEnbk9n2z0ToCnc6gGFKh1YzmThvY+5qFHUNvh9ANhKoq
 9JcQi4GcndM7MukRu3YGNXkoGVZep8lLsn+PhzlHDnzN86Zqr1ugwmnhkg/KNPMvsT3N
 sKwmuyn1cmOCT1QsrR9zUVFJPDrqZjdJx48FgBItPuiZuGwWp72o50I/uBKa6TUEf/LA
 OOEIVgSGwr+mo9h8hSUZVCJ/mIGFfdUT0nLvXxv6qWMy4xVCzlYCd3B6cC63/m77+6Lk
 5MOg==
X-Gm-Message-State: AOJu0YwA+PEoTHw9c/XKjC/+6WSeA462HJICrkThhK2fyW3na8kM/mNc
 hQ2FzScxxPFRqkC9EmBldszm0djyMijipouxnxXSAKroMbfLPsJpbpykAVsRgUM=
X-Gm-Gg: ASbGnctQ3TeOVH3EWGz5vOxDqAanjdEkcQHjqlnxH6xAvb+bli1wr+0sHlC/jXhvNez
 hFedpAN47hDSIee7M++eTEL6veh2B9rq7YOKkvbOX7LxjaF1tp/P7sCfvXDWOdBdX+jRfOxV8Eg
 RR862mD7iICCj4ZXobgF0x7P7PP+Kj3ZAkj77aOw/s82Mfo3iz20j/tGT7wBj0UsFwy2IIOlvuC
 UWRd5kxBUuJ7e5w92Z4DtaR68kZfKoJf+wWQ3tkMQ3nilT+aevYI0x0QMkSRH733qSYcw5Ei//Q
 nevh7JeO3tFuByk=
X-Google-Smtp-Source: AGHT+IE5nhpfsg7rWJE1j+opSCzkr2fcoYPZc7C9Ttpm1vvI39FH2+iiZnhfE+aVX2p+jvLIUubOFg==
X-Received: by 2002:a05:6214:29ea:b0:6d8:932a:eaa3 with SMTP id
 6a1803df08f44-6e1b216ef63mr705752406d6.3.1738073707339; 
 Tue, 28 Jan 2025 06:15:07 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2057a97e0sm45398416d6.85.2025.01.28.06.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 06:15:06 -0800 (PST)
Date: Tue, 28 Jan 2025 08:15:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 2/2] led: add function naming option from linux
Message-ID: <20250128141503.GO1233568@bill-the-cat>
References: <20250128135246.74838-1-hs@denx.de>
 <20250128135246.74838-3-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NlnGI/NcJwYq5A3+"
Content-Disposition: inline
In-Reply-To: <20250128135246.74838-3-hs@denx.de>
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


--NlnGI/NcJwYq5A3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 02:52:46PM +0100, Heiko Schocher wrote:

> in linux we have the option to create the name of a led
> optionally through the following properties:
>=20
> - function
> - color
> - function-enumerator
>=20
> This patch adds support for parsing this properties if there
> is no label property.
>=20
> The led name is created in led_post_bind() and we need some
> storage place for it. Currently this patch prevents to use
> malloc() instead it stores the name in new member :
>=20
>         char name[LED_MAX_NAME_SIZE];
>=20
> of struct led_uc_plat. While at it append led tests for the
> new feature.
>=20
> Signed-off-by: Heiko Schocher <hs@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NlnGI/NcJwYq5A3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeY5mcACgkQFHw5/5Y0
tyxDOwwAmvql63LJMGScRrLlJFCqZe/hGVHAr755McJ0c5/lm0e4M3hcBjrUJhdT
+sclWuc7aN0KzsavXcKIeUM2Tz6BHp6dFGgv7RXqwiIIaBIznart2RBuPFbDyYwt
gGdE9/Kuuaz5WdQsMx0/PJQD9vrpIxdbqN9ZAUw/nhwD75F7grjE7uAML+mK5hqK
L9G+cG3eoBpZ+tc3NmcM7nHDV3DYfje97ScIodpP8SStcor82RbeZl6tiXy2DQ9k
6VVToh4P6nbpnS2lIaQhB3w5ndCp0dIRDy9fNQ22zdkAlm2tBECMse6p3lESMIIt
yKySyzod4Eqee/uTer54vC0Bijo+mx0PZIHt/G6bS3ehOULdEkyrW3IBq+e3HC9M
I0Tml1umfdsm3gFYGJAhYWRNfF5BSATLh/1nySC28jKsqq/L5gJi3vEPTAKFetHc
nOJYVKhBgrzpW8W84wriBGJPspZaEJJbB1qf5QnBTz4PCUeNUv9ycgCOAu6Fesdq
25bEteGr
=ebGY
-----END PGP SIGNATURE-----

--NlnGI/NcJwYq5A3+--
