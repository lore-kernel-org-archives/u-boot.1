Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6D4CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 16:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E968F8484A;
	Fri, 12 Jun 2026 18:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FgD48PAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 949A284841; Fri, 12 Jun 2026 18:35:26 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D2E8484A
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 18:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6c047c6bfso924924a34.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781282123; x=1781886923; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GLFnnSRpOBxMXJBPAeNx5pHgJ/Yd39hwpi0S3Xzj5Js=;
 b=FgD48PAiyM5yehyvpaPXNhUBISUf8vhlRjilqyjRRsD6eMAFeDH/pgYFx34L9qYIlr
 xA7ltGfLPNY3xigl+voA2ZFHpS7QnBm4DKy/R26wD36ybIgbldtq6dR7jKYA4l2wcQhg
 iEtUfhuqMsY7bPdqRhuJe2mi0wzD+fuz++dnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781282123; x=1781886923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLFnnSRpOBxMXJBPAeNx5pHgJ/Yd39hwpi0S3Xzj5Js=;
 b=n1uqBHuDSLHqI8/d2bqZuSuZmNpQii/GAff6mOGrLDrSkMGgZ88dYSi1KWgP2hqnsH
 7y/rUyU9ABXf3rrFWcFaJmm9QrMO17WwkSmT3llgN5BYTiHBwhmjFN3lAnmTgresBegb
 dNluNnifqDMGBC21JDbuLpJvSPRJklCZdJ242HqEMoGnHqIOgi7G2/6WfM30qoJ+CIkg
 M9ycMfFQ6Dc2GUBIdUC1erZZtrM8RzVIeqjeGbZ2tTsS9tHYFbWx2SjXDrfSkXs14joX
 C65cdzZZnAdVY6kZc8nSyJPi5mIsQES0L1xPgtxTsSA1mMBvFAYdFlzAoXREcJ58HZzE
 4iow==
X-Gm-Message-State: AOJu0Yx12PmHv9MoZP0oWAcbGcrlkKevY54sI4ij5WkbVWDWrm444l+H
 xe5YzuaiEc47BbCFhI5OM6fmtyuIn7UEINiAzXjwJyf+9yEDxazRjIwsa2CpNunkTa0NoiC/Ptk
 xYQsL+0U=
X-Gm-Gg: Acq92OEu99511HtDQHw5zZ6vPVP+8OuGjJgP1TGEZW5JlpttAjsaxs8QHKvGlokstto
 WRiLu5MG9R1XzQwlQ+i/7TD1hPAgr9KSW+RyiU6VD9sVklMubNpDiHQEfJlPek3p3RM6I0NdQKq
 J12hZGupM+aq23NVpiiROfrte3K5oA4X0PPsHIds9QJG+BOSk1XjTAtOziv2PG/6bkbV4EmyOdc
 IDgrHQmUS5/6b7JvCTdyHNklkddX4JHS+B8mWqFmtv337LQepLqfKbL8p/S1BQKzpe9ZwWcw7VJ
 kw2qgshdeVjzDMo+XObwhCcIKmmRtO+0YS1l1YxcUfCsQ27rpcOmW9X7P9+byJCsKP8d+mNg2jY
 Om5Enso4EX7ZqBUCAlyDxlkhZJJoguR+hEwBCtSARVhe6kYII8np4oEqmrQEfUwRPqG7udAked1
 60bquT0e4Zhd7Ejee79oXZ9PyneXYtiCvLqllkx0whDALn76F2x8DU75rSLRRWuzi29lKDQ9XpU
 XosljpCVxioexM7EYCDM3mUlurAUEXRQOETVA/hZn0TdEuL
X-Received: by 2002:a05:6808:1707:b0:485:dac0:a7d with SMTP id
 5614622812f47-4872f50d8e7mr2432222b6e.22.1781282123180; 
 Fri, 12 Jun 2026 09:35:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e781740de4sm2144444a34.23.2026.06.12.09.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:35:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:35:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>
Subject: Re: [PATCH v4 4/4] ufs: document the UFS command
Message-ID: <20260612163520.GO382693@bill-the-cat>
References: <20260611-ufs_tool2-v4-0-a4de78bc2409@mobileye.com>
 <20260611-ufs_tool2-v4-4-a4de78bc2409@mobileye.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sow1ZRsWbs3r8Jfa"
Content-Disposition: inline
In-Reply-To: <20260611-ufs_tool2-v4-4-a4de78bc2409@mobileye.com>
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


--Sow1ZRsWbs3r8Jfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:49:38AM +0300, Raz Ben Yehuda wrote:

>     Add documentation for the UFS command-line interface.
>=20
>     The document describes the available UFS subcommands and their usage,
>     and provides a complete command-line reference for configuring and
>     managing UFS devices.
>=20
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>  doc/usage/cmd/ufs.rst | 462 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 462 insertions(+)
[snip]
> +Query Description
> +------------------

You didn't run this through CI, despite the cover letter saying you did.

--=20
Tom

--Sow1ZRsWbs3r8Jfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiw1SAAKCRAr4qD1Cr/k
Cp+tAQD4ZIpKVW7W+ODnk24bkeHlO39+ibJqEaCegAd3j8luLwD/Wy55gtE064fc
/2uTXYW6i5BSKqU/YpFyDIG2QPVfPwg=
=gsuw
-----END PGP SIGNATURE-----

--Sow1ZRsWbs3r8Jfa--
