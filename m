Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD32EE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE52186682;
	Thu,  7 Sep 2023 03:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VxQmkDtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA7186682; Thu,  7 Sep 2023 03:52:57 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C75E869BB
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-58d40c2debeso4827137b3.2
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051573; x=1694656373; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4mlXmWsmVJw0eTvXyj65mOHIZSTp2MPuQMWqFFFJjQI=;
 b=VxQmkDtLKHzNP0nA6NkTAxAcvXv9DLGn3R65XeBYcQ6SMlcyC5M0UVM8UCXSPJxhxH
 pViyiA/6bkVjAVs6uhFjsukn1+6TBYJDNSbOswFsV1OmmGCvdceqpfMptTfdb3wO68AM
 rtaazPhImFMyW3Yx67kb+LYwedLHGke0ZbqQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051573; x=1694656373;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mlXmWsmVJw0eTvXyj65mOHIZSTp2MPuQMWqFFFJjQI=;
 b=IYMcPFmZbNP46NpjsZq8ziEklx40bhpublUeMEzXKxRQimIcxUheUCQd/2+b/JDAF+
 oBILLYaiff1EWW4BomIqOQyY7aLFpnixzysAoCJn3BIWDt/1RmFQfnYRp0LdYUz9mCt2
 yxOwhJiDKsFwAw8ekBZXzBaztN45mLNokWhlBJ+TF3MeHEkNojaGK6Mt7S170i9Z/+R0
 ERyO1AWOBumwR62iQL3d2JikURIrRJ6+bXtiAvxhuRycXEcK8ZQRVq1Llu5mEc8M/6E6
 Qsavmk+lSbp6zD6IhP7Fa939a3rkMAQ3isVBIE4NEUBPid5ZZhGxj5b59dWnxJliWSrd
 pqMA==
X-Gm-Message-State: AOJu0YxugTbZ31phdaXfTrxiNnbc0brFusMXswR62D5y1zMkQN+W2Jre
 TtzTnw3230DsbXtKIAI/kHV/u8R2Ma3KIpeJULfg9g==
X-Google-Smtp-Source: AGHT+IFVZH8AOpj0IwNVaM6GY0sJpS34eZxsToq4nEGjFStn55U8WGGzliODnZ+w2WgKNDwXEth1tw==
X-Received: by 2002:a0d:e255:0:b0:570:28a9:fe40 with SMTP id
 l82-20020a0de255000000b0057028a9fe40mr17650674ywe.5.1694051573615; 
 Wed, 06 Sep 2023 18:52:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 t76-20020a0dea4f000000b005922c29c025sm4046516ywe.108.2023.09.06.18.52.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:52:53 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:52:51 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] CI: Drop some jobs we didn't really utilize
Message-ID: <20230907015251.GN305624@bill-the-cat>
References: <20230820173129.781985-1-trini@konsulko.com>
 <20230820173129.781985-4-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EeqComGIpWiSzM7v"
Content-Disposition: inline
In-Reply-To: <20230820173129.781985-4-trini@konsulko.com>
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


--EeqComGIpWiSzM7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 01:31:29PM -0400, Tom Rini wrote:

> - We have added more TODO/etc comments since this task was created and
>   never focused on removing them.
> - The output of sloccount isn't preserved or looked at, and if desired
>   should be in the release stats pages instead somehow.
> - The results of cppcheck aren't investigated and require modeling work
>   to be useful to start with.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--EeqComGIpWiSzM7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LPMACgkQFHw5/5Y0
tyzEawv9EWwznauhmzZq04kAu7fQwLh/ncTyVq1N+Sn8au72aHZZqhxDMQRjLx19
DAOZQbmZzavqGgpyvuJWSJzbTKrKOYDTYv1BgaZBAqK0c5Ew6kvWg89atNl3o9b2
Orv+t0adcj7LzSiDxrcERGfr/hublYjQGuojRlD+0+jKuOfZN1QEwAkQ6wvyaT3Z
LmBmLRvBKhtxhIRn4OJbll0ziDXB9AreeIEyOapEXbrY0hcbnDu6/sWYRcJEr5W8
S7PtWJRz6y3QuYGnEZHlEUQMg/qSEJCIoOB5Zx+hl1B7i3JJ+stU2+0Taj6mpwPX
AznuO0/qC7VymrT9fWK2sEeh/7GwLkgtwTZCGwkWWOEVnzmG8mena0OBDp6659GB
9txJoNa+hwEjanlbAnDjGScpUnasyO4hxiVOxo+2J8g9vtZMliYQjBguzZxDv0/J
Gru3YMPOzvNnmZNQ2g6X43nnG0sxzON1r2ybZbnj6so7jy6OsPY++R0T2mgGpRyh
oOPCIqK6
=nIcy
-----END PGP SIGNATURE-----

--EeqComGIpWiSzM7v--
