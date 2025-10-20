Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26C6CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 14:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5332383642;
	Mon, 20 Oct 2025 16:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RLtyAxYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E70836B4; Mon, 20 Oct 2025 16:26:57 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8243980422
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7827025e548so1807329a34.2
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760970414; x=1761575214; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BIV9bzESwqIuQKQIybL/m9MYgn82r5bGRngy63cGu58=;
 b=RLtyAxYDuQcmd3rdCgPKz1IZ0lHvsHzxtFPoMMJCJVVg7KLSeXQE05A17qpc/7rhbg
 eQAZI40uTlvaCcYmnz7QM3NT6+3eObVwIDaqwf1O+wWEdkIDZ0o61qpYJXoRRtSkI6j/
 Nsgs5VZFo66W3Jg22rZJJviIees2MAd8nXSZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760970414; x=1761575214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIV9bzESwqIuQKQIybL/m9MYgn82r5bGRngy63cGu58=;
 b=gR3UBMFyyl2MjWAyONbG3GnXNEwxQ1oc1vS2d+08mWDXGfrKmnIXfEAmpzXnUuittK
 monjpwNJ3lMkMrlaUszq2Cj0n6ABbq0dWIuWG5boBKy8igcKZDFmZsyn7WMABzE7Xvx5
 PmK1ZI+6ceNkLzPCLaWmUkdDCuV67JGYZXejdrlyL8LAwcXqtW/HqVMg8oxViHNulkN2
 lNjM7UhLI6ysZk4bWHG3ld2Gax3CC//M/t2lVZGgm3PLVxTSUD1mlVr+7+++2Nwh9Kpy
 JS+oFaaxQz/J0YSYuce9C610yOMrIsEZ2rGS1XrOiaSS98Jjyb94qrs8SFs1k2S99XeF
 frJA==
X-Gm-Message-State: AOJu0Ywmx7JeOyvRwQwmXTblRadUSjq4c0BQwhXmISVmMEh3p2fBOARv
 h102UHGb4NEDeB56AuFl2bJoQYoKWBce3B5M2/Sl38LJChHvN676YhwKTqmkbhdEzQp+ha6dr+K
 OU+lBAAU=
X-Gm-Gg: ASbGncsdtAdEJtoyBH3rCf+vugfbAkU0TmQserog4aV+bKvbzveLwbPfpp44KVyadCw
 q/olaTx94j3x4vquGQcX2O8kVsDZxuKTF1rvdRFZMxj7S2RVAkGoiiwypYnSMqrdtFYhI6IQ2DE
 W1UlXV42RIWACpqJHdWBQEHshAHjtbJNH8GvxNlLbPTWVw5WoBkwU+rtLsu7Ga5cWOSJlv4OmeA
 ec/XoajwaTLk/ITlYMrNle+1bsO5WKI9jlt4SxphRLDjPH7daoNhHc9gkY+i/HKHAKZ4Gr88c1Z
 +0DfiPAOueps7KInmu7Obew/B5h1m8FaGXqMhgkd/edZR+mAoG58vvIdqRbrAhNV5J/i/SMRLf+
 gfy4SXtP2ufLjAQEmwlMhbpMn68knhDv1wFWoXOEgqDXQLkYDV4xI3XOQ+E6Kvnn52R9ZZZyYmD
 VXowDs96PRMcO35CVK0H2MTHtsP1YZVozSGsJ7eSc2aLjPjAHMNg==
X-Google-Smtp-Source: AGHT+IEiL7RLOimGm2xf8Sy1JV0epl6HmrQTt/KQHbgShyYLcxrWuCsFatZZBf33yJcTqwCFz/cPyg==
X-Received: by 2002:a05:6808:1b0d:b0:438:27c0:f1dc with SMTP id
 5614622812f47-443a30d1262mr4964061b6e.44.1760970414220; 
 Mon, 20 Oct 2025 07:26:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d38ff5d3sm1972818eaf.0.2025.10.20.07.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 07:26:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:26:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH] doc: board: nxp: Add remoteproc guide
Message-ID: <20251020142651.GV6688@bill-the-cat>
References: <20251020-rproc-doc-v1-1-61fbaec7c40c@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UkRk3FCHRldzIM25"
Content-Disposition: inline
In-Reply-To: <20251020-rproc-doc-v1-1-61fbaec7c40c@nxp.com>
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


--UkRk3FCHRldzIM25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:26:58AM +0800, Peng Fan wrote:

> Add guide on how to use the Remote Processors on i.MX8M and i.MX93.
>=20
> Update MAINTAINERS to include doc/board/nxp.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  MAINTAINERS             |  1 +
>  doc/board/nxp/index.rst |  1 +
>  doc/board/nxp/rproc.rst | 69 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 71 insertions(+)

The NXP examples are good, can you also please add
doc/usage/cmd/rproc.rst in general, and then reference back to it in the
NXP example?

--=20
Tom

--UkRk3FCHRldzIM25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZGqwAKCRAr4qD1Cr/k
CosmAQDb0TKKufjzGTXQkDm80/JYqwm4vGxq/P3h2z0hP6H/ZgD/eCVAcS9Zy8t3
aykRbYfDiuWHHx4sl85ZslospXPeWQk=
=OqTT
-----END PGP SIGNATURE-----

--UkRk3FCHRldzIM25--
