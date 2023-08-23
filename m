Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10B7C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D82486416;
	Wed, 23 Aug 2023 20:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bLXopeMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1F24864AD; Wed, 23 Aug 2023 20:00:01 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC36C86412
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5925e580f12so10423247b3.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692813598; x=1693418398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yUjmLJZleTqGWh0Mj+grXiohMrtCOB+pC937HSHk7sE=;
 b=bLXopeMRC98d5Lz/8Yww8B0Wcd95/PQxSQfRvxj8Jqebwt7TjJnKqePaSPTc+YeRBZ
 J5ba92RgRZgnrQjnMI2IVEEbJCnXWcQ1LbxQdYhnOEPRXbmHH6qgKY3HNVv6uJ61kdt3
 tFkpdKPx3LAZIBQ9Himgwo007vu3GTLcpAPfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692813598; x=1693418398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUjmLJZleTqGWh0Mj+grXiohMrtCOB+pC937HSHk7sE=;
 b=mGu32KErgASLPX3+KtHmkj2FZEdyqUGkds7svreB/93L5j5LRvtsgUWO+EqGaKXRS1
 kez59/GHGwedI+Rgs7pRK/DRRmxS4wgTQhf6IndwkvYZB8pD0cXvb/a80n9Vp57xqJSH
 btiqyGDTBf3jGI5CzLAdKZ/4D451//fKwyjukDyTb0FJgMzHSvlgQ+Vm8uLuI6sWwVvn
 mLP1fD7PkF32n8RPQYBzpRy5anMV/JNIRjj+yyULpGWO5NEeBu3fNCXtR9jjd+VYwiWH
 rFAAiTkCa+I9dB4KFRZ6J61ii+GxuME7apQImvLnbkPAK0mXJXIMvOZ0zAMgSDrzEwOr
 6+IA==
X-Gm-Message-State: AOJu0YykjmuUyc1snm9U0suXi3LM+hX5J36w4diSSI7dQANDDKe1HhM1
 6ovsYYogEpZxC8w92fB7qIqF6Q==
X-Google-Smtp-Source: AGHT+IGDMVhUos4FXq9BXGh/utC0q+149Wx6Yv2NbdIp4v0p8rDyZosvGivFlqA/ROZ/T6LohSqL+A==
X-Received: by 2002:a81:4843:0:b0:561:cb45:d7de with SMTP id
 v64-20020a814843000000b00561cb45d7demr13486311ywa.31.1692813598572; 
 Wed, 23 Aug 2023 10:59:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 u80-20020a0deb53000000b00592236855cesm1641039ywe.61.2023.08.23.10.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:59:57 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:59:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2 3/5] thermal: imx_tmu: Increase the log level for high
 temperatures
Message-ID: <20230823175956.GY3953269@bill-the-cat>
References: <20230823175911.319414-1-festevam@gmail.com>
 <20230823175911.319414-3-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lsG+8Y3HvCAde/hh"
Content-Disposition: inline
In-Reply-To: <20230823175911.319414-3-festevam@gmail.com>
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


--lsG+8Y3HvCAde/hh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:59:09PM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> dev_info() message is not printed by default. Increase the log level
> to dev_crit(). This allows the critical messages related to the temperatu=
re
> getting beyong the alert threshold to be displayed.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--lsG+8Y3HvCAde/hh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmSRwACgkQFHw5/5Y0
tywlVAv/e6pAiHh/zjv3KCZXEBoczLJGGRGTcHXRb4Ly92GoqIjXbr2r6cuUcMam
7skTWoa48cai7t6mByE/jesR4qAfp8LS+C0VU5enftxzsc4r+QVHbnqcs16Lv/2m
DbbaRYDUF4PLP3enlKd6Qrqwf+MV+I9l7zv86TdHYW4P/I0+jvM1x+QkTymazJce
B14Lbwq9JsFPfFtDeILwUQwXpkhNvqWSuvr12PebRfeQ6Fed+9KXm7TKcXNG1drq
qIdy+ix3zCZ8ni7Dpoe45cgCKsWG6wpKDgvBM+YRrktEVvlbkIvWD9XmJa0mLeCd
n4TEMvKAhCGDHVzyO/KwCFSv1eN9HCqwLxE+huFwbVBfzXQEnr7guJRPIvSMY1M2
6L3ESsNRkgP8+pyNT97XPRDxGhNtilux6rPsBjbYK0YmySC/n56j69Vv2qwK+ElS
PLgFC/WvXZG5hD7Qyf0nW2ciIHrNp/tBN8qhWW7CHkOxsnSh+g0qx6fcdpQCr/QE
BpqCETDu
=J92z
-----END PGP SIGNATURE-----

--lsG+8Y3HvCAde/hh--
