Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3BBC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F91D86529;
	Tue, 29 Aug 2023 16:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j5WictYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC568651E; Tue, 29 Aug 2023 16:09:38 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B406C86500
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-592976e5b6dso46504857b3.2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318174; x=1693922974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+LPth4mF4+CuGyF2xR2HwctlgL/wzn+aQceXw3Tg7fE=;
 b=j5WictYlwIN+NzlAWhhFR+Zel7uYwk1WgUcG7jtr8pfmkOkuh3bDFiKcGB0j0W/5SC
 a4TEH8BL9hRKAnr+KJ6cSSfmcAdAq+iaMGXud72miIhaKLzCWS+ngkv9VHeZXaB+uSxk
 fNZjoFVphZDsMVKg5Dtfg82y0p4CG+DhF+Cv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318174; x=1693922974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LPth4mF4+CuGyF2xR2HwctlgL/wzn+aQceXw3Tg7fE=;
 b=VRfnZ3dyc/oIoASeb0VlUTXsbSSzYZbi1cAS/LXqhPDvsOGRpQiMoPaaAeEHoBRUbq
 PQV/m33ucKDAYQoRfs1vfwRZz80QyG2j666+/H0sTIgOCli8Q2Pz9zXoixlE0juBruBB
 /+IMITbrZb8ntrA8MOEblkkMSJC3/+EHQUOa5LNu1s+UeGN99OmwzKb5eGYVc1/YgSn7
 poXXaGsmD4ylBC7HHM7xh/gAiBM4npo3Bk+H4vd2n9TJ65g7zKXgm8C4hDUoeihkHuMq
 pEMya+BFAQIpk1659M+mktJdd3p5YuAKBSuT3yBIiU50wVU4YeHOVB8Yz3DZczUxRq3y
 UGSQ==
X-Gm-Message-State: AOJu0YyWokfGTgTpOSUVADNJkawVQaJwNWXXUmm7qjOqnSWpkAClPdjH
 msDIymHEbUzkiPH+EMin2ARiaXHDdWY7/j1xMToa+g==
X-Google-Smtp-Source: AGHT+IF0z2L7ZC8OwFZ2G8RExQzXUn3ZdjVPV71f/r9WUHyPO4RqIxTnnxz1x2VFhBws+siNdUNYmQ==
X-Received: by 2002:a05:690c:3002:b0:594:e145:112e with SMTP id
 ey2-20020a05690c300200b00594e145112emr9961474ywb.24.1693318174460; 
 Tue, 29 Aug 2023 07:09:34 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a81bb46000000b00590f25ef8afsm2747705ywl.43.2023.08.29.07.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:34 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] MAINTAINERS: remove Wolfgang Denk
Message-ID: <20230829140932.GX3953269@bill-the-cat>
References: <20230823221247.62710-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E2vWkJWD4ibtPlrU"
Content-Disposition: inline
In-Reply-To: <20230823221247.62710-1-heinrich.schuchardt@canonical.com>
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


--E2vWkJWD4ibtPlrU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 12:12:47AM +0200, Heinrich Schuchardt wrote:

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--E2vWkJWD4ibtPlrU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/BwACgkQFHw5/5Y0
tyzkEAv8DCEmV4zlUADWYARQzSiBHzUsVbjd9mJh0sAPpMK4VoKSCIpLRyV8z5Xt
TePedUq+mDL6VAlMLsYfLNxKk8g2Hvcd+bV/7PLps5HQK+y3ectSniZL2o6vigUH
teq9OKEDWlTig1/7FzOaoUUttVlxMIU5ZXSqfC0HxG6ni7TZigIPpNp6GGIXKbiJ
YYFRHe9aYci4AVB/MjaFErG5PwaAX/OHWJCo0Tpy+bN/KjW5WfOVrbFzX6K+GKAv
FKDWBQk0eaxZloGUM9d35ZcOQ0SLDdgUrnRhmEpUzfqdpr4C9fNgF0MzbucOZky/
A7YlTTLuJ9/GhGDqvy9c4nQs4LIH10GEIjiJyLkgdrZs60UQZwP11l0MLpNwfotC
RCoP/RYwop2DkNCPNgdxYNxlqfv4qnuWC1hBMZTqL32xEoxx0PjYlorLaOECyI/O
gAXnsIR7mo2ZB8yHS/SMv6nY9cV8MiPT599jty74qfTdq/qTnRFZPeUh+tm+WS/7
ZSuFiXmT
=DTVl
-----END PGP SIGNATURE-----

--E2vWkJWD4ibtPlrU--
