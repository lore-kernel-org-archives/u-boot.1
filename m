Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D483C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 19:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B62807F1;
	Mon, 17 Feb 2025 20:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cWXV5bB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2B580843; Mon, 17 Feb 2025 20:23:23 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F9780077
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 20:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-221050f3f00so41056125ad.2
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739820200; x=1740425000; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KCYRaWW8GAnvGx60nUHESf86oRJ9scnqm6v25TVsdEs=;
 b=cWXV5bB43imy+VNa6g5G+HW0KCA4KlSn/+VLM4wlfkG8diknk/dGtjXoSaXvYJyu+l
 L8ddGcyWNHkaXFIeZSPUznpUO7yluzZRTkXGF7w15jXB3ujAJ0dDpK2A9B+aksruMVxZ
 5vB3W2wpR7S468QK8zh347Tc45815i38ddV4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820200; x=1740425000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCYRaWW8GAnvGx60nUHESf86oRJ9scnqm6v25TVsdEs=;
 b=LHbfDRW69ajB5vqZgYdGTAb7bLBgUBaCeJgvUAEAYuVSs/d1KIh2XX2/lisM2s5Wth
 qpNrnkHwiuAb/LLLmmMHStDqb5TX8+ISVJCRdHgk68jLFNwQn5qqZ72Qr34Vn/uifnyq
 ed2AjgnQt8Caz/FwziqOj0AV4GOIfjSbJq3Olj0zhDjJZEfksHQYVWFGzwkoRQ4nsCQi
 V5utWQ2AeRCJxisZdv7dlR1/VpI69YsiCCwlustACsqA/CpdlXVhs2Eg3nQaNVpnWmJg
 krbEYmtWMb//4hNJg4KSZRT7aULnDYYUdmLU5F94Q4I5UDW6iOcA++4dgZAOkuPGn6/t
 dfUw==
X-Gm-Message-State: AOJu0YwUSRewlZMsjtipqtBcCoNL8pCyALGOmWaCE6yYoV2oHdgzME0D
 L+o5Ctw4Q4IERu367LAOxdlHMsV9yeqsLBSZ7YgJGW3ImmvqETYBAs+k/oPwwI4=
X-Gm-Gg: ASbGncsNQOlPhox5ZpZteRu+U4E+A7ONZcGmzC31oASSEIBLtHzNaoZvxUPezH6hciB
 WHJOcc5GbiBcyla62LgjyYv8CXj0z2RaTuqWMd6xPPbMVsyYfDwLJiJPg/dR93sqqlPGIYwXmYd
 qux92pmgqj/FhpOriHHJNs2VPL24CAkZx+Q9q+YBhm1TZMSfZKiViXEUOP1add5+K2OuVmNDEBI
 HYZ4ZYHRZU60xXT37IbYO/H1kncQbJFU63Vv14ofsADWO892xN4s6oDTbk+05VygdIRUrsFFXbc
 J2+yggiMk/lstQ==
X-Google-Smtp-Source: AGHT+IFX/b7rlcq/9xsrnmz8Ym6NqKwIxYut6qIRDlPsoJ0Zyqiaaoa1mv0bIgKJFscQXblR8xzVvg==
X-Received: by 2002:a05:6a00:4fd6:b0:732:2170:b68b with SMTP id
 d2e1a72fcca58-73261446cf7mr21061522b3a.0.1739820199925; 
 Mon, 17 Feb 2025 11:23:19 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73274a11a0bsm3204846b3a.123.2025.02.17.11.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:23:19 -0800 (PST)
Date: Mon, 17 Feb 2025 13:23:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brandon Maier <brandon.maier@collins.com>
Subject: Re: [PATCH 2/2] u_boot_pylib: Clean up pylint warnings in gitutil.py
Message-ID: <20250217192316.GW1233568@bill-the-cat>
References: <20250209212714.2317040-1-sjg@chromium.org>
 <20250209212714.2317040-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E3Ewy/9f8ZvO1qNC"
Content-Disposition: inline
In-Reply-To: <20250209212714.2317040-2-sjg@chromium.org>
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


--E3Ewy/9f8ZvO1qNC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 02:26:01PM -0700, Simon Glass wrote:

> Reduce the number of warnings in this file.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  tools/buildman/func_test.py   |   4 +-
>  tools/u_boot_pylib/gitutil.py | 240 ++++++++++++++++++----------------
>  2 files changed, 128 insertions(+), 116 deletions(-)

As I think these all were warnings from whatever other linting you had
mentioned in another thread, I deferred this patch as it also doesn't
cleanly apply.

--=20
Tom

--E3Ewy/9f8ZvO1qNC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezjKQACgkQFHw5/5Y0
tyzkhQv8DWK0cTtLF4CP3W487KdjSjcoDut8MGWFRl8jD0uBkyIHcoc9RMGtGGP2
/6iG0jFOMrDPm9e3XWcbOVXqnHBdiqEhFqKljfs2deep2N8jT4lvXqc2UPRFXJr9
PUipWipePPhc2lD/LxpM5cYQ37EAxFza7CrBru/m1X4ypeaXfCX41gbYVRAOGRUY
IQs8eOAwo67+rYPwZbyI7X5QIGU5UOnFjW9/dxMOKL84dOmSX07/GyMdAJcKMIsg
EukF+1OUV5ybJXZMzCaLKCvHmPbX1p90eMnTxrLi32aSkDLZZ/m73qzwzCZ7OZNW
EozvgYVOfNJTIE5ZgBBx1pxNsfz9mAwmAkJxgfhkAAwkX4tQosmx45sQBPmqK7xP
LUWwWE5b/YvGVaHf3Ck/mPyBABwXW+upXtzyZv8llw63z1buMwHiJpKGbiI7jkTX
2QUoIGX8eh+DQ89MVnkYxmRyxD6YNce4/CLMS1lFnaIfi7f/wlNeWBeZ1h0NCucH
JkSVTpDN
=2YsP
-----END PGP SIGNATURE-----

--E3Ewy/9f8ZvO1qNC--
