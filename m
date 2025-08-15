Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F1CCA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 16:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4541283AA1;
	Fri, 15 Aug 2025 18:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E67HpV7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BDAE83AC6; Fri, 15 Aug 2025 18:12:44 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3327F83A9A
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 18:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30cce90227aso827594fac.1
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755274361; x=1755879161; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wWfzRKKHCBRgblqqNiAej+XSoSagfYIskF8G6tHmucE=;
 b=E67HpV7r4JKngIyJxorj7oBIXOgn0EuMQOM4M2qYmRqRdgqb2E6iWc5UeoA6PQKYIF
 l534fOE1hjBtqQwGL0vM68PEmfvyOjtV5Frv/RA9rpOEx9ImIP4wdKVAsISBtSLMJ4Of
 4Xdy0lxrtXRgXBhlAnrkSTacSc3JiHiwckuDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755274361; x=1755879161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWfzRKKHCBRgblqqNiAej+XSoSagfYIskF8G6tHmucE=;
 b=pc2AyhnIKYLAtiCSPdKZ/WXeCoD10VN5+YphcNMs/QU5al+LCSdO3llB6EEtsD2w5p
 F6bumyaXYuhLaOxWbtuOlVAFg4bRWMT60Vo9hlGolnVh9oe/qebsAgPFANgfZDjZDctW
 TVj0PopaRqz4/ryT+k/vfdCnCcMJz1fSvDLgMU1Ze2lWWsbAxnZffiJ/GUfsX2hJ/oo7
 yJJMv6H9kKCguhR56MZ/rTxBBDsE2wytdjz56/CfGSpeSoeRV6qYsbsfqBCica56jWhl
 dTpe0fNzDjI/MW8rcPOL9HbOPVrpu4100BAq9eEeka/MwVnEQHhFrpzZxIVOnP2h9+Sa
 Zx4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxUmue+UyqsUaaCURcQq9/E2qBozOvr+nP/iFqSwQA4GLqAghwxIAc+GhU7lVaH8kULxSN2Zc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7PeX+hdZvapqgCrO5l3xw15oK0nTJoS4XnHsX0nRxmr1ougn6
 X+uYvJl/NhIxIyULkC1M1ITdRK/t8D6zLaJgTIHK7SrLEHmNEoaCSYhuLOYkFxjoha8=
X-Gm-Gg: ASbGncsf2AlVyhPiOmCRJBMkuaNTW6sUERZQVmTFoEoZmC0FlP7UFtCzT/LyCgICcU8
 BD3f2fbs73F63cLHgF7gPKbyY9uryRokkYVl++oFcWi9RaciXM+pWqc7MPgkO5XkVHlrEgs1ROS
 OaBys3Ptpc6s+UpTq18Ie8wEiCK/iJzRORl5yxwSTE9lrv6ENlLxIu82/WjWh4udjG3Gez39P8T
 7nvUjR4sqRZlsbREQFRe6NAPEsEC4PqDEqH0eusaNUS+rx77kP10RqstogmL2ReVtHaPepyhWAY
 B9GhkqBzQQBBXrzkIdfnUirlY80Q8rUjrzZ0EpSPWUzxxfScLvHFQajBHAVbZf0QDTXVTR6Ucqx
 rTqtRSlNmsXd7WmSJrYXIAcGfywWKYKQT91G70EiTNy5/XnV7lvUlYuY8
X-Google-Smtp-Source: AGHT+IE/mY2gLUCnRuVeuHzmKJa6/4hjlDZOV7rb6NrEErah3xnRcRSgzC6OCPAepQo673mXZZjDTQ==
X-Received: by 2002:a05:6870:2009:b0:308:155d:47e8 with SMTP id
 586e51a60fabf-310aab4aa60mr1519510fac.16.1755274360879; 
 Fri, 15 Aug 2025 09:12:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310abbad019sm479113fac.25.2025.08.15.09.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:12:39 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:12:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: holger.brunck@hitachienergy.com, hs@nabladev.com, sjg@chromium.org,
 jh80.chung@samsung.com, u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: Re: [PATCH] cmd: Remove default prompt from output
Message-ID: <20250815161237.GT124814@bill-the-cat>
References: <20250815160635.3575367-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4BlSTJ2ReBHK5Yok"
Content-Disposition: inline
In-Reply-To: <20250815160635.3575367-1-d.schultz@phytec.de>
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


--4BlSTJ2ReBHK5Yok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 09:06:35AM -0700, Daniel Schultz wrote:

> Some commands include the U-Boot prompt (=3D>) in their output,
> which can interfere with tools like labgrid that rely on prompt
> detection to determine when a command has completed. This may cause
> such tools to misinterpret partial output.
>=20
> To avoid this issue, it's better to update the command output itself
> rather than modifying the actual U-Boot prompt. Changing the prompt
> is not acceptable in many cases, as some boards have used the default
> prompt (=3D>) for years, and altering it - especially just for testing -
> could lead to inconsistencies or unintended side effects.
> Instead, replace instances of the prompt that appear within command
> output (not the real prompt) with an alternative like -> to ensure
> correct parsing by tools that rely on prompt recognition.
>=20
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>  cmd/i2c.c      |  2 +-
>  cmd/mtdparts.c | 12 ++++++------
>  common/hash.c  |  6 +++---
>  3 files changed, 10 insertions(+), 10 deletions(-)

This is two cases, and I'm not sure I like the proposal here, sorry. For
cmd/mtdparts.c, it's debug statements. We can change them, but are they
also enabled by default in anything? The other cases, we're changing
output along the lines of:

> -	printf ("CRC32 for %08lx ... %08lx =3D=3D> ", addr, addr + count - 1);
> +	printf("CRC32 for %08lx ... %08lx --> ", addr, addr + count - 1);

In each case, and I'm surprised there's not testing that globs on that
today. I see the wget case that uses "=3D=3D>" and we do have a test that
checks it, today. Is your testing framework not able to handle "=3D>" in
the middle of a line? Thanks.

--=20
Tom

--4BlSTJ2ReBHK5Yok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ9cbQAKCRAr4qD1Cr/k
ChkxAP0WvyzyUBvtDJS7i3QErv6r+aKrhR33pJDOmJ8fQX257QD+PnlEE26edPKD
e4kfj2h2xrAkqpmZUDZ3/JMiNXGjXQ0=
=W+4A
-----END PGP SIGNATURE-----

--4BlSTJ2ReBHK5Yok--
