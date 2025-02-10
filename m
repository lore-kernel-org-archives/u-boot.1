Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB99BC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 23:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25BFD803CC;
	Tue, 11 Feb 2025 00:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a05rBOpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD278043C; Tue, 11 Feb 2025 00:54:02 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03BAB800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 00:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f768e9be1aso51094347b3.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739231639; x=1739836439; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1gDy7MSjjqw9EajNvUWc6bKi7qH3JGcOAM0WUs16eCk=;
 b=a05rBOpVmqh7vKP6Nr8O55R3fmlYpz/6OXW5nkJjCeluKPCPsLtf6Xnjv1IEhmbxFw
 aJQH1nXSou1J68uZxwLGWHGMQDFcpWm6HydCV87bWOR6oZ1NILtyqRkFAa8vzL6NpY0J
 +Qi1tILxKcOfYCVi05UC8X73xhjl9hlq/9uLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739231639; x=1739836439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gDy7MSjjqw9EajNvUWc6bKi7qH3JGcOAM0WUs16eCk=;
 b=Y06ijpPbF167JUOqwrGNKaaPBVf2iYUnzBT2RG5N5hENfJFLh35HYRWbTekMZzSOnD
 h4S5zgR5MUcUSPN5ZjRbbNe5kCD4bpdW7BnHgVRpi713I7bAKegJaE7/B9WaukxfXkaa
 u6x5MN1wBEudni0K0zxY8rNcuAiXb3+T1CqpLNFRcRaqKQ3CMR5W4l7rOKuiEyxw/FyG
 4NQOQ1mzqbL+OJRCjorgJlX1y181RsnDi52jsRpWt1+N3vrIy9eYGpldvMLKyvqoAeob
 vyZ5FyG39YlEq8A4I9iCkpeZSkpfANXiAm2BZ407jDJt9BhlNiDgtcywp/k/99Cv/Y7Z
 ciOQ==
X-Gm-Message-State: AOJu0YyYjjH2LizCp0GqqK518+S++l/3DCqBBF1D//1pQBktQd2cq2dX
 GwPvjalTVal4OvAcFQ1rvov3LgswEOV0EAoyoWVRQ5xmABUEeX3BROLtIh0GCSvw0iVXQUGlUda
 1tTA6Ig==
X-Gm-Gg: ASbGncvlczQoJ3SYxATOXKZD6UpvU3IfwKgRGDADrYN6yj09PJ6RZ++P3gsPYChv/GJ
 Oc7gNPquD58CVjfEEKrTHIQ1veahVOzwJvaKcGzbuWACKwSjscV6gMfzfAQg5mehfkWHDYnNHRu
 SQ3pW9q6Njt3suBpCAa2cf9H6kHsg52X6hljb4Pg73cv030SN9vxP0Qb/0EHFwkayRwmfW8CZHQ
 1HKHYxB6zzRMhJN0t7uyiOe2+d6BrmvksT7kDLF/1ZBT23xLo88siNFZTbPCNnO30U2SHpKcyaS
 Xyv+f6m6weFzW7o=
X-Google-Smtp-Source: AGHT+IHmu5E0lboCM/dqhrsEst2obDdlHI9rzT04mjRqcGr+CH6e+0iPKmnlocoJoMgg8o57RAlSzw==
X-Received: by 2002:a05:690c:4987:b0:6f9:51e0:d01e with SMTP id
 00721157ae682-6fb0c471c74mr18689367b3.5.1739231638665; 
 Mon, 10 Feb 2025 15:53:58 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a5e1sm18835567b3.86.2025.02.10.15.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 15:53:57 -0800 (PST)
Date: Mon, 10 Feb 2025 17:53:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] common: Fix memory leak and incorrect comparison
Message-ID: <20250210235355.GA2992480@bill-the-cat>
References: <20250206134809.3048114-1-maks.mishinFZ@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ddx8evSIb3i6AyAS"
Content-Disposition: inline
In-Reply-To: <20250206134809.3048114-1-maks.mishinFZ@gmail.com>
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


--Ddx8evSIb3i6AyAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 04:48:09PM +0300, Maks Mishin wrote:

> Changing the order of actions: the input argument is checked before=20
> memory is allocated.=20
>=20
> The input argument `n` is of type `size_t` and cannot take=20
> negative values, so the comparison has been fixed.
>=20
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  common/dlmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This introduces runtime failures:
https://source.denx.de/u-boot/u-boot/-/jobs/1018726

--=20
Tom

--Ddx8evSIb3i6AyAS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqkYwACgkQFHw5/5Y0
tyzOvAv8Dl3gFHRoHBaN5Fz+mKzWmB794aV3d65R4bdkzPCb16KIchMm6pzHQimf
BuMUtafSoNyODIkGoqvLN24ZdSQp4DWmxKNtSwhZKFmvt3Nb4ypBEz64kcu3riVg
BkO9Xcswh9LG7oaEjltYZu81lBgmzbbiqC39qwM3wTG+J7FfWB9+crT8FYAWPExj
LOH8ACfYMQ2GpSiCT1KtajYNZ8EViNz6jo/Dq+Mld7kBRK4Ue5BXdHiJuBpejBPs
DQYVJXVcoLgD1wFf99XyZCCiBYuG1nzXveZB0T/psxQH7Up/PFgTAVCnBChWOJ7k
osByzo5gPou+3dVUkOy2G5zmT1VMoQ1Cmen9SDxemNa/yldzdVa/SiqWT4SPA01p
XXlUSSqO8gBTrL0Q8gb+hwgs4aIYf1GeNJMYrHckDTE+x5hpLGKweRgVQTxf2Emn
8dDB49bEqwuulhE1gkOhv02ha7tJEah+ZBrP7MMTIamKfUAF3DR13ztqvSDbhsBY
krXREn1H
=Orpy
-----END PGP SIGNATURE-----

--Ddx8evSIb3i6AyAS--
