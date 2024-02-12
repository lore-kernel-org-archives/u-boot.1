Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335B8C4829C
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE8C87ED8;
	Mon, 12 Feb 2024 17:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K59caSle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4611A87ED9; Mon, 12 Feb 2024 17:57:29 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC4A8718A
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6077789e054so3900577b3.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707757045; x=1708361845; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WY/mTWFA/kLcPUSeUjLEZHn2Eo8rRFnXjAuKqfwf3tM=;
 b=K59caSleEdEpeAT8AoaCb0zlAiq+/5FhVGdiF0y9pTHWZ8m15hHeAyh5wEoRCmfWA0
 CtxHNZrfIaZbZL8hv9rVdJwij0g2ziPHzIYcsXZGbREP20+JH/4zglSDMjvzywHvrLhz
 TylcuZI134bX4AlZNPamTAY2ruVYfCRHk25Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707757045; x=1708361845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WY/mTWFA/kLcPUSeUjLEZHn2Eo8rRFnXjAuKqfwf3tM=;
 b=VD67MlIGM6CNxDn4br1UAlYTFhXeeVTYi+qGpGMqcYXUVHBtbrRn7SV8hVKNdW+Z2H
 lfneEoCS87BgVA/maCCYeQUFkjmlGw355KQU6152JJrHbnbkEgH5Al4NhwAEEUFynQ7p
 tvQJv4ej1UvZx/6eV7TtntfbIJuAK5VodI+1avQ+7wfIxwBtQLrji6175llQLwQ1xAF5
 p5iidxLcQNtvhzOEAcjZpf1k4OjtfdFm8zWAB6Bbn1CQwkqE5wiTdynHY3UoxRWJ5ol7
 gRIfKgE1sDAoGwRTgc1XFHp/PAtouNZfS2jwaZ0Ik/f0e1upOdzYULb44aff3gpB1xp7
 8r0Q==
X-Gm-Message-State: AOJu0YzqtSlotITq0YKN5C1Lfjeeu4Elb8U8OGvKvvo0WngY5UWDmrPH
 fW8ui6E4DpqXCYGgosh2uMckbgsNZb+mRU/7Tcqy41dn+ZWs0ka3zfXWsZbSyZE=
X-Google-Smtp-Source: AGHT+IHCQ2X/dR8mt9KNTFuWTtSOcRYVpJLpG6LoFEMmHPZAVaOAzAEv0AJzF3wjdQoMp1yii4folQ==
X-Received: by 2002:a81:9254:0:b0:604:5c41:e3cf with SMTP id
 j81-20020a819254000000b006045c41e3cfmr5283381ywg.24.1707757045092; 
 Mon, 12 Feb 2024 08:57:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCULwfY2CBHFUZpor8JwXvc3aI6xsWl4SBvpwWoY4NI4tQID3nOqMuPs+NBMtam2jg58CV11bOnRHuctfKjuT0aaYQzZoXxA0/rFwhVA4OBEehPtbHiifIPDWnWN8ZkSkp9TOYZLO//UCX9LDJELJZ9XoGxEo2Eh2/F58mdqU3kdnQU=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 a4-20020a0dd804000000b006048395c0f9sm1243728ywe.77.2024.02.12.08.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 08:57:24 -0800 (PST)
Date: Mon, 12 Feb 2024 11:57:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: remove common.h from exception command
 implementations
Message-ID: <20240212165722.GI3040305@bill-the-cat>
References: <20240212165329.17847-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DQMbMGqtO124xLe4"
Content-Disposition: inline
In-Reply-To: <20240212165329.17847-1-heinrich.schuchardt@canonical.com>
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


--DQMbMGqtO124xLe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 05:53:29PM +0100, Heinrich Schuchardt wrote:

> The common.h should not be used anymore.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--DQMbMGqtO124xLe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKTfIACgkQFHw5/5Y0
tyw1UAwApBmLtRcmw82dz/w2EsverpNGf9hyABItaoj3HyTXQbM3oljaP1DrrCv3
k+nwvl7uqot6tHK0/mTGqlMfCP/gtE9sjGM+49sXZxKVPEVxC9NJ3z5U0WXV2jZi
erMfOYZTrG/0JQU/h8Y+407D3DQYw39Y3MKo06HxdEJMZm7V54KjaF1mqsZa4K2K
wea11rtsuQRiQnvQRzJBhruOMuinaN7jTpQox3tiL/tijhMtHSJEx99WWCflFPxG
4+/tV40/WLIV0nyeyjBXUWrSn7QgpNlCk/oX8q8zYW3znafxRn8Ifk4pFV0D9f4d
+JUjQeLcP+BDkNyy4wbAk2Gb+PApzBRK+p7HYjUFQx9pN+LxSmJqPNvqNte+m5Hx
EBqtDYr8ziDmFcf7/Ta17MduTrabUlc4HKB+aBiu95xvKi94H0rQHQob2e1XNoVU
gbpeCdQcGFf9hq4eTO/e5h0jTDTpbwa+5Hcqh7fiRaQZpyVd19GvCn8XtWYTa7kc
+0+Xji2H
=27x9
-----END PGP SIGNATURE-----

--DQMbMGqtO124xLe4--
