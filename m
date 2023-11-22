Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC55C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FEB58767C;
	Wed, 22 Nov 2023 21:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BFiS4uU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C328765C; Wed, 22 Nov 2023 21:49:43 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1F287655
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-daf2eda7efaso219105276.0
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686180; x=1701290980; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zEVxK8jRMihbvqFh13X5RY/sCQMZzYPaJosGfvjt+5g=;
 b=BFiS4uU26xEbl0Wm8dFAYFcIEimpdlYBUThb1c3pFqQt17kpKiSs97kzO+kDBk1brx
 Ml++alBdvE8X7hPo35JMd/NE9YNJp8ZUnsmASqfVewl/sRUOLt+rGwh7mPFbXLi8JF4c
 Ulx2Yez2oxMA/sTFCDfbDFqROAXAX04VbsXoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686180; x=1701290980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEVxK8jRMihbvqFh13X5RY/sCQMZzYPaJosGfvjt+5g=;
 b=oOFI9ae/tXkvKB2H/SNRMTId9wncI0Q7Lko8KiUhlrl4HJ02+9E4GOtY3bhxy7t+2M
 Q50uEHDLVCacFiJgCDV9u6PYGoPKspWYcHYlKrcdsw3wxcyfTTXsDGXMQTB8gx2X+QwI
 Lh4yVNfjNn5m9tJRyOWS+DNFQ/Xyt4hShGvXnEhWwogfyzAYnzRLUPP2H5wL9eU1pRuU
 V++LsvzowtFhGqM4QxHkic4lt5avn9gVrk02euC5zixadUtgY+Ocw0g+Msoga9T85Kl3
 ewL53mqyLn3EuQJiDqvMEWKC87WdN4m7LAQIAMZOkachDAK/rdhpuJgmmEXNDf1kIlyv
 Ksug==
X-Gm-Message-State: AOJu0YzmVmy9aSopluxuCXiaoSFrO7ZTr559iJRhdFKgL9FhGAhmx7Mj
 YVWwMSZIi/KFLkFVqmn6BsLz0w==
X-Google-Smtp-Source: AGHT+IFe1CA3rPDWetgqsJoI7WXi0YA1LeOxTkrxOT8jqEUO+mlPQHyWzs2Tp8rO8PsheUoLPiBXrQ==
X-Received: by 2002:a25:40c2:0:b0:d85:abce:3f43 with SMTP id
 n185-20020a2540c2000000b00d85abce3f43mr3770354yba.38.1700686180643; 
 Wed, 22 Nov 2023 12:49:40 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a5b00cd000000b00d8674371317sm1534983ybp.36.2023.11.22.12.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:49:40 -0800 (PST)
Date: Wed, 22 Nov 2023 15:49:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: sjg@chromium.org, nm@ti.com, u-boot@lists.denx.de, vigneshr@ti.com,
 u-kumar1@ti.com, reidt@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: misc: Move esm-k3.txt to
 ti,j721e-esm.yaml
Message-ID: <20231122204938.GF2513409@bill-the-cat>
References: <20231113043023.2126690-1-n-francis@ti.com>
 <20231113043023.2126690-2-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nGUyVZ67WlpbrNsr"
Content-Disposition: inline
In-Reply-To: <20231113043023.2126690-2-n-francis@ti.com>
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


--nGUyVZ67WlpbrNsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 10:00:22AM +0530, Neha Malcom Francis wrote:

> Move esm-k3.txt to ti,j721e-esm.yaml in line with the devicetree
> documentation in kernel.
>=20
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--nGUyVZ67WlpbrNsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaWIACgkQFHw5/5Y0
tyyj3Av/VmK+M8RJLk1ScKO6wNBkztqdTTNKeNt+aLHuuQX4TOLh8tofUDH1Ehxt
XsONwbWvfyv2+bwH+MVinTKXOxpRzgu/eP/AuT5svwspvSnTt0HNnQhQSo2Lew3u
7/CROOpyqOaN/dPZhX3rcl4RgGj9GLO5EF6UQk/llF2ahvyyE5UUCqLCp15cv/jO
M56Rb9/r+jp9hRmcVMtOCoVuwsN7oSQ8p75VaoCO5xcVGf8PiBFvQbIM8KimBCXl
1Sgh1Wu2+ixWG7OaLKFAvpGVb15o5+hAr6LvCOwFyWvFHu9PiG2n94M2hxz3Vwld
sN8mQvNeFCmBzj6FroIwxvN3foCbufKqKFrKl9RD1E7oL1TweYSr5yWieHYHcsCt
2YWLjCECpeDMit1+2fhVnymO8WPnGm3nt8ihMcrMXekhc+risf9Da/O8VUSSuv6M
kX5pwzpO5TdnCQHE6PvOA2dP39cvPk9uprmAYpg1SvFfU2KP4kDC/FJ+WAfqKiga
pLr1MXK4
=PGuj
-----END PGP SIGNATURE-----

--nGUyVZ67WlpbrNsr--
