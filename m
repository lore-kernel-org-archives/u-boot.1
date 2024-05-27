Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E572EC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 21:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D9887B1A;
	Mon, 27 May 2024 23:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LiV6OX5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78EA987D87; Mon, 27 May 2024 23:33:57 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A28187AD2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 23:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-43fb0f2daadso749881cf.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716845634; x=1717450434; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zrONe/EFWyCI1eKvp64j48+4/0bf+PcvS1oyOLCrLD0=;
 b=LiV6OX5Rhrtyo+mu6Rwb+Vt4u27REEWCz95FD2XjHeRdj+tlblriTOPTOGBgDTjzDE
 XK/79OD3Yj+7eBfeJRjy5RnL0eXotM/R2fZrHAqe9bWy43d0Pv5t1wXQ/92PxPEa7CYD
 7xDkGk4KUHsb2Jnt+a4rnOnlXditAKj0Uld50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716845634; x=1717450434;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrONe/EFWyCI1eKvp64j48+4/0bf+PcvS1oyOLCrLD0=;
 b=FSYa5WxqkeUFX2QAE7vFxUJVZ4lOJbKv1B8VKqvPM8G/OFCY4a4HqxSQputwXy6zIo
 9ulkmjZmRVNwfcmEpAzIJzBAdncPso31bD5TmdCVh18LowkMEbPW8+cIJ41Wi+d3C24i
 xwriihlN4s3cJpR/i+XJtrAywfv1asfg7RChaed/CWigCl5fkurifi650+cm7FhP2iC1
 neNpb79mZGC/yxMAD53PqFiv9EzLoDZlCgXDEACl6cCaZ1D2K6jfJKa/wlOyEUTSRvD+
 KDl3QQJHiJ8CSzcoiXUK7gjEWHX847RCxqtdAGjZUbwNwpH21c+6pNC4s8wvbYa7CcHh
 2CEw==
X-Gm-Message-State: AOJu0Yw+fyWRewheu23Lodcof9v7Ny3nrnJNNKHGgnU4Sv/hdRRf3V74
 mrCZeZ6N8MGH6gj/TM7keQV6Oirpog8ZSWFWUmd5ktNfhaY+HeshRyNZAZKi5Y0Aq8mXd5pNfOT
 x
X-Google-Smtp-Source: AGHT+IFo/Zpk1ZajvW3TOAwcnC7fWnIAiZSOa9WnhWB5gzJ8Vz2NypekC/CMdG/HnXOyY44S4Xwqwg==
X-Received: by 2002:a05:622a:389:b0:43a:a89d:ee8 with SMTP id
 d75a77b69052e-43fb0e88d31mr106653891cf.58.1716845634120; 
 Mon, 27 May 2024 14:33:54 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb16bffecsm37605131cf.1.2024.05.27.14.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:33:53 -0700 (PDT)
Date: Mon, 27 May 2024 15:33:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Benjamin Schneider <bschnei@gmail.com>
Cc: u-boot@lists.denx.de, Benjamin Schneider <ben@bens.haus>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] configs: add mvebu_espressobin_ultra-88f3720_defconfig
Message-ID: <20240527213350.GM2568172@bill-the-cat>
References: <20240527190737.49025-1-ben@bens.haus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JjA18GuE7butWGwM"
Content-Disposition: inline
In-Reply-To: <20240527190737.49025-1-ben@bens.haus>
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


--JjA18GuE7butWGwM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:07:35PM -0700, Benjamin Schneider wrote:

> Add support for a Marvell Armada 3720 device variant
>=20
> Signed-off-by: Benjamin Schneider <ben@bens.haus>
> ---
>=20
>  .../mvebu_espressobin_ultra-88f3720_defconfig | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 configs/mvebu_espressobin_ultra-88f3720_defconfig

You need to update the relevant MAINTAINERS file too:
board/Marvell/mvebu_armada-37xx/MAINTAINERS

--=20
Tom

--JjA18GuE7butWGwM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZU/DsACgkQFHw5/5Y0
tyxUOQwAhpysIdscf4tpUWeieHCZ70rYtU/dgaK14uokNZ4++aCr2JZt8m+Js7nb
bgMeH0F3dghkUajFmXjx0vPm6NFp5IywfFeBI+UYgCbEYVWERZSfBewX5t/7B+2J
QDOg9OoUVIaj1wdS0FjfFq+fJIZwcuqsBoYaNgTtAE0n/LRTQIh0ghDzddP/6RmA
/wjzHsSaO/saybQ6d/c7q+gUw2BkBO5FyEJ41NtLr7ysERhn7JRlYA3EXxlTKoy5
4XITqzgm0Pz4fzQVW/EfF34EXc71KnSMU+VA8aYe7KyOrQsQXOAL1zqZC+7ryfV5
EdmMJ9BQnXY9q5fW98LMoNlU2eTTXM60YuDzGoHh9sQLN6BevDAQwxWVOJzKvuUC
A50IdS4DsqXJ5xpw24vmgUEG6uLpjnGssFCjxYcXXRMt0zpdL7uVx120Mmg9uRj0
ZWlbPtdp+5vO01mmwMVu53NZQLI9iW7DUbfSXIGfZdoSt1zpFMQgOd3AJDbplZpz
huhIfZ1x
=1WjF
-----END PGP SIGNATURE-----

--JjA18GuE7butWGwM--
