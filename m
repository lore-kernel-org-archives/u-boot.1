Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A8FC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E74B1807D6;
	Mon, 10 Feb 2025 17:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L7QqJ3pG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5081A80821; Mon, 10 Feb 2025 17:25:25 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 026FE80548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6fb0200b193so7751757b3.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739204722; x=1739809522; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=spbnuWsIslTqcZKF6iYXVOVs66oLLuNCrkxZauMuoN8=;
 b=L7QqJ3pG9Lb5VUztRwG0Hv8mdsyW2u1aRUupyaYbhCwG3OqYJ7DELjIxoxeAmjt6/o
 kW3UGzdSkMbSkWID9vMEjZuWemc13vsK44ya8MYC+ofPPE43ttO1zbc3YKZY2VgJ38tQ
 7qrRQfAmnW4atnbkCZADVaSTJgeG9RczerTtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204722; x=1739809522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spbnuWsIslTqcZKF6iYXVOVs66oLLuNCrkxZauMuoN8=;
 b=AebKWBGVNWnZz2W7pY2RlUyZjQ80kr5NhoIchiSfdWxUZwLejedb7s+pKGXUNaf73y
 AZNuhlnE3SGChljDcWGBrjyTsaRBkXbUrwJfOCDn9MvdQ5V9dax2TWwrnV0J4wKmpGrR
 zFq6oE/xbYe59Eck+Bxr9hP0cjJZlQIaQU4g9QLQdrIgKlxhsPTrNbgYnqkMe7mElIjt
 bXzXWtr41A3pXx/I8cP0d1Wmyi/Bt8iXiLdKeGK+H2jdPUgjm39rp9OaQABQhP1H8H3/
 W8XukwuRsUPPJSMwk+7+okyCHwRaAkdRwCtZzD0hHT9Ar29u/4CWgSW2MmdRk4sVbAKd
 hT0w==
X-Gm-Message-State: AOJu0YwPQbx7FrMtzcFLKTzjJk/qmyEfaF1hQ2NOb3JIxPHgCnGzTH0z
 HQFYg3WfFYq/2fm/n00/Vt6n1lpDBLayVdFNaQRWMoAU0+HasoIXvJR9PyFXFKeL5ZkbvEbJOaa
 3
X-Gm-Gg: ASbGnct21iJJ5qFmddkvdiIc+oonNOpCgUyzfRdFFT+oH+J6yX4jLyaRnYu+MdmP7hO
 4pVRUIgQf8HcEQVbIbmXgkobN0u12w4KlfE52U/3oZgrzgqsaDSLgIzQ7S7APhtJ6Tjxy+0/lmB
 Phzr62uXs14HDlQY4KWhJk4BHOIN6mgIqptmzYLuKIPvju+lBTawRpewtxRNSQoKTD56nORt/2c
 Jhi0ziAruHktwuBzCixGbz7H5s/wemwD2KF1tIxGv/oqKnUVNtw0XEtvP8fTaPJvtZi7goGnGWg
 GeZcVSrikAlY+cM=
X-Google-Smtp-Source: AGHT+IF9Tm/P4eQXi/kSYLxXPZ55ZZMtaaq1U6qSsqmyEPwa1lEy2lVdbqux2oOMjym+nylKR4QUCQ==
X-Received: by 2002:a05:690c:6f83:b0:6ef:9017:3cd8 with SMTP id
 00721157ae682-6f9b2a1a007mr134102847b3.35.1739204721799; 
 Mon, 10 Feb 2025 08:25:21 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd550casm17256067b3.50.2025.02.10.08.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:25:21 -0800 (PST)
Date: Mon, 10 Feb 2025 10:25:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250210162518.GA2902864@bill-the-cat>
References: <20250206223858.64672-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EX9RZ0vyjDiieZXq"
Content-Disposition: inline
In-Reply-To: <20250206223858.64672-1-sjg@chromium.org>
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


--EX9RZ0vyjDiieZXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:

> This is a global default, so put it under 'default' like the tags.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Please make v4 include the way you redid the second patch and be on top
of mainline, thanks.

--=20
Tom

--EX9RZ0vyjDiieZXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqKGQACgkQFHw5/5Y0
tyxKSAv9HqIgV7R3upwVCjJNkbLkOnvxGiqRLiwkk9PO+6wPNl2K8goeGRyjXQ0k
kyfRoH1cMfR0bnhDir9n/JjHJOZWdXetvH7lUPT1DdNz0ULr9BqGvdgikzhPDxvu
8Sr3gHclt10OXlxC0eK7AX5hwTr9Hkt8lgIaUsUni7rbpfewHqGiW7T+KSvwLqpn
CA8CMuWEawhwEiIkkoeYhMt5oJDtEVt6jacPa7XGc3q1SBwGQU9VGdms5/3COctY
+RIrIosYUvfFoHB5xGRi+6a+MmzrnDIAAYdAa4zFPo8yJv2wFaSfaGxdEYhuuvpS
CRY/byUwjZ81/AmBHmFxjB+Kg+wRAAVRdA3Rk2xh99h8VGWXm4ZRHmkSFNrG8A+3
GiWPLNfExHiX1KxUQuX24tybN6B355GGJfS/16p68Cvqwm9vV9UnzQnw+qq7dxVy
EseSIVT9BhPOz/n7hOERgaIGAIriV4vkw7LY0TpyWWIrk3yREACOcBodP3y0p7CC
8HSKWOpK
=811r
-----END PGP SIGNATURE-----

--EX9RZ0vyjDiieZXq--
