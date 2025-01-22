Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04409C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 14:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CA7808E6;
	Wed, 22 Jan 2025 15:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LXM58gnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536FE80944; Wed, 22 Jan 2025 15:15:04 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2162680882
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 15:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dfbc45355bso81152556d6.2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737555301; x=1738160101; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7gu59uuQ1xdgKxuBbyYma9QVpACHpIvkS2MKKEhdFnU=;
 b=LXM58gnzlLLH0aWFPXk1dxYWwusg+uiCWJErlztyZDCmSD4EeqhPgJs7pQ4ZVPiS8Z
 +A0FDwMucX2ElYqguYioRzPJd2hJ1I1N2B+dhCDQLzvXp92VLBlEZAwR13oVTbJd9c0h
 x3L4u4ULeXrtMIQVNMIgueMgMgtOUyqu0MqvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737555301; x=1738160101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gu59uuQ1xdgKxuBbyYma9QVpACHpIvkS2MKKEhdFnU=;
 b=Q60HjrXkft+fdiRSG+eXvdh4uDwTZ3WZwIRQXzsgN4LMSxRIeutsx29Xp95gRp9x83
 gsvcI01aIzk9N5bKziraBSRhAXCrEQ9BIhwkOy5G6Uu7SYTqnhn8kGsX9tfvWOdJzxNv
 nY7VYvDHZDij0Gj234I96BwK8Fv+8AVDf+eYy6rUbMyU1pzj/sAZCOz8LfuscydbH82K
 4AZKB4pBvumD/hyDaKKSKOEbrrqeoEJQwfykuTv9tZH7+rf7GvZxgb81fgbTe6Cfv1fd
 8W5rYmIn1d5Q1z6gg762HfDkswEU8dlm6eIb37bZ3bYrCMq5gkzQXrrEsfeU8Lqe0nJ1
 A/ng==
X-Gm-Message-State: AOJu0Yyr6rk//Vq9y7dHrmOdM+7FMX6iqAAzxsEhyEFKc5Ehtjmff2xB
 uFhfdg3azumnBTQ0oPNIkXG9GBb+s5Fz2XQID1SWfkoOicHCsZW/OwcscqtuY6A=
X-Gm-Gg: ASbGnctogmgzy2NomAvpUxook5NAn+eLeKpwmeMwtdYRrREFVzSVRloh/Xhi4n14e9e
 03D9SFJaKxzd/ZKQLjXZqBUtoz39EzChqQBUsGnBJCjNndmwV0J6bYoYZFFA5ll5ORp87kizrDL
 4q77/551mJriTKYReHzR8QJbIsLGYy8uJMDnnH+FHIUXxR4n27U/1XwwYI99uA/K0LW6l5OjdPU
 4N/OTCfu5eSYAxlN1JpGfxScb2mAKzu7/4BLo8TA003UDQ1k/U2Jbyh6Mfcfp8o6iM=
X-Google-Smtp-Source: AGHT+IEP24DlSBqrsZJ4H1u4tOtgTRNZGTmQIuRxhTcabTn0T3TJRHmkJq/Hn4EfwNzPBe3SnV78xw==
X-Received: by 2002:ad4:4ee7:0:b0:6d4:85f:ccb7 with SMTP id
 6a1803df08f44-6e1b1a23d12mr365435926d6.0.1737555299463; 
 Wed, 22 Jan 2025 06:14:59 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e102fc99asm65011701cf.29.2025.01.22.06.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 06:14:58 -0800 (PST)
Date: Wed, 22 Jan 2025 08:14:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2] led: add function naming option from linux
Message-ID: <20250122141455.GK3476@bill-the-cat>
References: <20250122121201.55597-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QpdHHoDZyB/J40ao"
Content-Disposition: inline
In-Reply-To: <20250122121201.55597-1-hs@denx.de>
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


--QpdHHoDZyB/J40ao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 01:12:01PM +0100, Heiko Schocher wrote:

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
> To be as close as possible to linux import the following files
> from it:
>=20
> include/dt-bindings/leds/common.h
> include/linux/uapi/linux/uleds.h

I think you missed my message on v1 saying we need to just use
dts/upstream/ for these.

--=20
Tom

--QpdHHoDZyB/J40ao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeQ/VgACgkQFHw5/5Y0
tyz9iAv8D7y/0g8aX4HDyzuhw/jbZAgT49Bg7vQGS75p0fJrSoF6Iarmsd6aNB7e
0v+XSQbYHFxopbNghJLiZKvgZZ9ujO1cTYiaOK2CC8MNo3sde+1bCvoUMcljSbFX
c8sTnqc/jmxN9M1K6PGIStA9D/8FUliq/qpwFUiUx8+r12aSb9/iDKHvawb17Vuu
m/Q+ay0k1YHXrHkbLN7Qwa5o6VFxgUzWzgtnUAOZZSYOlok4NEheTFxFECTpBzRu
I5U5Ra1h/YDGTt/tZkhxev5vJgE1p0I1wg85hqpFMUE4O6x92+6exWOBDWYWEEFQ
kg9mD0wr3b7KUL2xaHIe99fqzfxWEuaSa7Q26B2UilNuXhpt6oPEWcyeYEf8XGNA
jnBwToytUPdtXqq5sPIO6nslxoV3y2+4JkmFWleVNAw9iHhGAZf+AaGN3kXAQqDr
+kySeJ5Y7lodZgFsf7Hvb7asSgDo3EWdtJREnFCw9Xrh+1h+EcI89MqA7Mw+5SBV
g+vgs14z
=I9zz
-----END PGP SIGNATURE-----

--QpdHHoDZyB/J40ao--
