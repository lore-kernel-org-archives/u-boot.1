Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0743C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 17:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8F8833D1;
	Fri, 30 May 2025 19:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="efmUs25x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9578F833D3; Fri, 30 May 2025 19:22:41 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F64833CA
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 19:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-735ae79a44bso1725824a34.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748625758; x=1749230558; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qei5PI4ZFH/hFBUwmBOQ5Q61t+woKOmGxigbiz4aEm8=;
 b=efmUs25xe5RjOCdyTKHr/jPI3CxFv7H9MREqqr254vQ5PgvqKFDRAD/FaQhwiXfEKi
 KUPjnvDhv3NXT5VwxfncsQDXv5q9pSgOMS733dXJ6/mtVhupKe7VMWBgjGOUBeYCu6fx
 oxPsd2IcOHcmUp3Y+ORSDpVOak2zYcP77zEDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748625758; x=1749230558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qei5PI4ZFH/hFBUwmBOQ5Q61t+woKOmGxigbiz4aEm8=;
 b=mukpFfB7YHNuFcC8r+5tg4VB8ZaN4WlEPcZSDzysohjb3mQzb/RhrsMie3+IO/A+mw
 OHX8H37t38iTzInzfpX32zqdKyFekk6Yq5+2B9oa9xQaAaddL6oQbN5Z9Fw3MQbAT7N3
 RLr1xL+XhKaTDK7yUzQzkxYRiSjOoGAMMYmI8PCmNWIphsrTYJ3t6lZ2yorofk5J06FQ
 IdQiyWSyzSxgDBrPi92Flujgb3Qs1pncuJ//tx53MbkiGVer7fUw3C6wXqFLXPIBlC/0
 LVXOyzvVwRJf7Kxme5DyPSiFRR5pfJxwTSRJkGXFEvUkr3oZexo6YXdOKGLIiVNH9m18
 O1FQ==
X-Gm-Message-State: AOJu0YwllKl6l+sdUG4AC+EwGC2ZeyOSrxOQkkhDEC5gpRp4yE6UE5ZL
 1kOBRWBXz31pdpOqjU/7fpr8GLYhDIH4EBWEMZ5SIdBsBnQIty3QfRm7bFfO84l4VlE=
X-Gm-Gg: ASbGncsESwOTAlzCCMeYhCa3/W2IGyVtsxcpwECygMdoX7brFpW7eap3QQXVFLfwdi9
 oedQkY62pb9fINDPVJ4JiPuOq/9yGictQCjuwYsdU3cccOFXwyxOrNO/Hxm4l7JenLezjOUhNG3
 8X24i+nkXzS0896V2rAU18otqxaR+ndWSEuO7CObA/gNuJs/YQxUruopVKqjhTYMQsmInaWmLf7
 ESNAxmcf1Z0jabnAVuibd8GNdSnmo8tt5dEotzLuj4hQHlVIwErqCbDSk61nbVqrM2XQ9buTRBJ
 XK1yM1qZQxaf6By3KZ/QN2U1UpE/sSqRIcqhrv74qFVLfp/AhDggRgzTNutQ41/ldLZDTLUV5Ws
 1q+qJ3fdI6LHc
X-Google-Smtp-Source: AGHT+IFUavDTlw8gCzdQyd+iO7b3tQLD+fTtVhMjR5iVpS1s710cINecWIRf7QeX83M59eIA4F0xzA==
X-Received: by 2002:a05:6830:710d:b0:72b:992b:e50 with SMTP id
 46e09a7af769-73670a1038emr3235988a34.21.1748625758130; 
 Fri, 30 May 2025 10:22:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9bc8f6sm658383a34.50.2025.05.30.10.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 10:22:37 -0700 (PDT)
Date: Fri, 30 May 2025 11:22:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH v4 1/2] CI testing: add http server to CI tests
Message-ID: <20250530172235.GA4050067@bill-the-cat>
References: <20250516085256.30386-1-adriano.cordova@canonical.com>
 <20250516085256.30386-2-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tKcrADl4zemM6dlV"
Content-Disposition: inline
In-Reply-To: <20250516085256.30386-2-adriano.cordova@canonical.com>
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


--tKcrADl4zemM6dlV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 04:52:55AM -0400, Adriano Cordova wrote:

> Add an http server to CI tests so that HTTP booting and
> loading can be tested.
>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>=20
> changes in v2:
>   - Remove HTTP_SERVER argument for test.py
>=20
> changes in v4:
>   - Remove comment in .gitlab-ci.yml that was preventing
>     parsing
>=20
>  .azure-pipelines.yml | 11 +++++++++++
>  .gitlab-ci.yml       | 11 +++++++++++
>  2 files changed, 22 insertions(+)

So, I have a concern. Did you confirm the tests run? Since we're firing
up the webserver on port 80, and that requires extra permissions, I'm
not sure if it's working.

--=20
Tom

--tKcrADl4zemM6dlV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg56VIACgkQFHw5/5Y0
tyyszQwAnZp3nqgy5mkQzYEhUGGpZ2WJHY7UeNMNWpfjp9MJRZQ+ONUhHdNDc547
PZVSUnhV+r3wj7y944dkjJbs8dkM4pyi2D3OjF/YaOffir3OmvvWL35j4MPOwusA
2p66Knu7d7ENmi6CkzlJ2iaquUTJyKsuhu8zeUqtEkbRjCaM8qdXMnEFhQH0j7SK
yaB1v3rvBtAEKWjRL4EEMwCJddLUQS3kgH8EcpPX9bcE0W9v2W9PqtPnB0fm41lI
1xIjSQwwR4gRJticRZZtHd6ZpeJS4pAqLSkjBFttJg7/UyAlYi+8Q7A3OwinJFQs
U+bVb5zhG2Eq5MwPcBeb4gkmZF078RRY6QwRSKGzosXojVK5RkQwhIazgaAv/zza
ktx61uYxH2M18QiZ/3C2SyE0VHacyndhY3sjNmd8QGVx7vRcXwxZCc/Jn93BOwAX
GESUI7mlcCfS7hj5KFAy0TrBnoRQpbkA4ly24gJVooCoUJu5whqe9S5PlHr8lolA
hmXoZHUT
=YcPc
-----END PGP SIGNATURE-----

--tKcrADl4zemM6dlV--
