Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4774AC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 21:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA7E88BE0;
	Wed,  7 Aug 2024 23:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OoVjBDC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BAB988BFC; Wed,  7 Aug 2024 23:12:32 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCE588BCB
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 23:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-26875acdf72so249936fac.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723065144; x=1723669944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nz4M7OaiAzdisG8eIEBs4fbHVMq5RV7DQxNDW3bqpTs=;
 b=OoVjBDC9HTK8qGWCNsvtTo58gm9qYtuatyR54vq41oNni3X5EgSusxRKOFJaXpE9Gb
 ia1ZsJyGTna+AVSORBiS6mkjzhNufid3aPIjoKjZEyab/xrGQky1fdtkmlH4Mhmx1Hd1
 6DGnaLzhA+seWl9NLs7mBxs8IP1OeT6l/+maU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723065144; x=1723669944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nz4M7OaiAzdisG8eIEBs4fbHVMq5RV7DQxNDW3bqpTs=;
 b=GQGa8Y4sSoTbu4dlRGePNBnZeL6X7BcTq7wtsTb0dJ9hd3wNndXXNnPEU5KqKdT62N
 PiezDt3j2TsIZwJBrf3jqOCFZGLOJwQN+YaURkSr1iTKTh3xLjx1lKjk4+ZcZC1yfTpw
 upt6+N7uouQpvTvbpgySOKWF875EzL7yh91VHLvdtB/D19msbH99VvIKhbZd9ysqZgZx
 G7PTL5Pw0CsOBsKLIt6qDSgrnOd1Yd5nDd2d3Jq/eKt6RWhDe/V8tB6ouEG3sGi6MOsJ
 MKepYln+BOQ/wvlVxuqX2EevvL8rIsEphjFOzghakVeUXk2GoV30Qdj6u6L5p9oRcYRt
 JaMA==
X-Gm-Message-State: AOJu0YyEMv1uhFT37WqClAy56bohbGWdtcDSDj1oMBPAdZ3iEKJbXKUe
 kohRLnbh+e44x65pmxocKQR55IrzQVCUkmUWqbw7r1vgYrVHRFAFj85zEy8OwLE=
X-Google-Smtp-Source: AGHT+IH3wMg9tLtGtQ7Mxp0g78xMXmq3GG+sK32u3TrO7PfiDIT0BmTGHn4uOlMydDyJNcq6wIaGng==
X-Received: by 2002:a05:6870:1eca:b0:261:1ffb:4ab2 with SMTP id
 586e51a60fabf-26891afdaa8mr23180108fac.20.1723065144483; 
 Wed, 07 Aug 2024 14:12:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a445379sm4232104fac.33.2024.08.07.14.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 14:12:23 -0700 (PDT)
Date: Wed, 7 Aug 2024 15:12:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Prasad Kummari <prasad.kummari@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com,
 venkatesh.abbarapu@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
Message-ID: <20240807211221.GK1626301@bill-the-cat>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HK6NN7SFYtPCl7JY"
Content-Disposition: inline
In-Reply-To: <20240806120659.686073-1-prasad.kummari@amd.com>
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


--HK6NN7SFYtPCl7JY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 05:37:00PM +0530, Prasad Kummari wrote:

> Added LMB API to prevent SF command from overwriting reserved
> memory areas. The current SPI code does not use LMB APIs for
> loading data into memory addresses. To resolve this, LMB APIs
> were added to check the load address of an SF command and ensure it
> does not overwrite reserved memory addresses. Similar checks are
> used in TFTP, serial load, and boot code to prevent overwriting
> reserved memory.
>=20
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>

This is a much more generic issue that should be looked in to with the
LMB rewrite that Sughosh is working on.

--=20
Tom

--HK6NN7SFYtPCl7JY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaz4x8ACgkQFHw5/5Y0
tywW2wv/ZlAR7hlfLM+gvdr+LuwttXqfQy8WQaJFSEwkd8Ea4+6AHc/QCTxxtr3z
qs0jz+7FxhDIL+a9SLRc2LYEeYvyCye8JsNkgEIEk5ZjXZEOFIq0bInrAlRQbaXD
44bqzhFKi9AITHs/XFBOM7HKA/RRrKL5S6Oo2IbgGljYnhPOHFs9nkW7sK6ucs61
5m8CUQMA3dGW5Y/502mxyOeI0CuC9RD9k14Z6LUKRIDTntxJ19L5mhMHRdcUTBPd
B/JDYLk9moOvqPrbdI/rTqdxZMpDWk94cD7n0rMbHAnm1DK/PzN0pl/Hwoetic9c
3v+JXPxE6sk+YZFfXNhww8eZvryO026ZkUV+bSBM1no0Dm/+SCwfAWJm857LGFNC
iaL+nfYca2Nnr0GNrHhacVqplB2IYUbz5YNqqbjxd8CtaO8/zzBJPXbNiNR+E+bc
dd0QdWHp7ZXdTYsYKhqIYrgs7f3lVDzoybS0OdMmyIz9BhLy+jVbxwvoisFYGzXr
ubHXxEEo
=98Bj
-----END PGP SIGNATURE-----

--HK6NN7SFYtPCl7JY--
