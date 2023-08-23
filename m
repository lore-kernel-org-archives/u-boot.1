Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88669EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5F28645E;
	Wed, 23 Aug 2023 16:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NW20n4MQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F94863F5; Wed, 23 Aug 2023 16:41:51 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADE608645F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-591ba8bd094so40696387b3.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801708; x=1693406508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=socls220x+rZRb9SXSLGJ8uW678J0mnc8WYxf9jiM8Q=;
 b=NW20n4MQx7gmLzjoE5XtU3BrMTxCMILUUaG6A4UZe0ImdfzvY4VRDSe+JVQvptmMjE
 I29MjPmWiDM1P03RcbGJ2KmqR3r6gt6lHKDVowmriaa0+OFuUXAgnladKKKib2AQntzO
 UN+ERHYFbc79E5x0Ph+lit7BQMfk9ONVZ3E8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801708; x=1693406508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=socls220x+rZRb9SXSLGJ8uW678J0mnc8WYxf9jiM8Q=;
 b=kn2F/Trn40ewz4ENlhr8Fz9eVvHTB8Jor1biRmu/xF0dDOdAmGaDL4CP6oUq+vDx8X
 OPDFnNY7uJoGNlUY51ajAh8bbIPqnf3fPhh2ObDuOQEXjDyYjsGMyZO77RkO51y+kCe+
 uPxYy0K4PXbfaGQedqcaGsb+QGKyXsbKg5WSSkx/djvPRlPidYeyFlbESe4rFE0X0Hhd
 SeMmDbu/+rE+LBzeAowZbJWWpuQn/MPas0hNpuLfCJ0JXJAHjfdli7KjeWAhnowT+Ssc
 aMfNsBXn6EHy24qMchHXq8V3Tql01WwnV1wHpbU1irWWPSZuRKmNxZJ7o0c9dunF05g2
 oEDg==
X-Gm-Message-State: AOJu0Yxt+rxoaN1SOQo4/82gqdS3aR9usFxQLfT9QfaNmR2r1/B5ug8X
 aMteZTZqIzIdStGRu0g+xt10og==
X-Google-Smtp-Source: AGHT+IFKCNYpj5Sr2yUmnqR4JPvHCvB2u4/YBrkVNU3nDRZzTdxU7ZgCi0+s6k6sL8rWKAtiwg+hKA==
X-Received: by 2002:a0d:fbc2:0:b0:575:4b1c:e5ea with SMTP id
 l185-20020a0dfbc2000000b005754b1ce5eamr14589075ywf.47.1692801706877; 
 Wed, 23 Aug 2023 07:41:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 o63-20020a817342000000b0058fc7604f45sm2378830ywc.130.2023.08.23.07.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:41:46 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:41:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bhupesh.linux@gmail.com,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] armv8: Disable SYS_DCACHE_OFF & SYS_ICACHE_OFF
 for ARM64
Message-ID: <20230823144144.GO3953269@bill-the-cat>
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
 <20230822075112.717992-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yi8nK0stCbFa6iq6"
Content-Disposition: inline
In-Reply-To: <20230822075112.717992-3-bhupesh.sharma@linaro.org>
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


--yi8nK0stCbFa6iq6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 01:21:12PM +0530, Bhupesh Sharma wrote:

> Ideally SYS_ICACHE_OFF and SYS_DCACHE_OFF should never be set for
> ARM64 (ARMv8) platforms, as it makes booting u-boot slower on these
> platforms.
>=20
> However, if some platforms require ICACHE or DCACHE  to be disabled
> only for the smaller SPL stage, we should support such configurations
> in u-boot as well.
>=20
> Compile-tested for:
> - qemu arm64
> - imx8
> - stm32
>=20
> and run-tested on:
> - Qualcomm RB3 platform
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--yi8nK0stCbFa6iq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGqUACgkQFHw5/5Y0
tyy/7Qv/ahGtPfbx1VNdTNoVuBhYWTCoJ2B9rXPbYGCgxGCgi6q41K0hTRDnl1JG
Top5Ue55SN+FnKikkwSzsgp/yaEUp+lZvA2B1qUYkgwgCi7aIqsJkpCi7tcG+CEs
RyINodS4tOCP+Zad71XkgRGajLcRNulZmXvyC6jGBuHXrlLQvCRzNR6cAQ7wR0kS
gfApKauuK2eCmAwD6Sw2EJ+tfv0PSEpo+b3mad4E1vpqOI8alWfxQkv+7V+QO2t2
Qz5g4Hp+Rl5fxk+ii28uZ6jIJ7KlMu4Pi4eLqpQkkOkGjpcyS551bnqKLZTW8k96
FZz/CJt9QC1ghw3jrCyJ1kkLiedlfmSX4MZwfZSOfJ1JUt69EyXHtGHt6mL4vM0L
EhwZ3p+u3WYkH0HCVXJt7VP6KsOaIxRY+/vchH7JN50n+bZBoBDu8G7fH/HjPlg0
YkFGUQU2UXQB9aACEyu/0NWNp60bRuv2dBzozqQNwUY73TtWayqeiVQjh4hJRkTC
nuYRI9pV
=8Pmg
-----END PGP SIGNATURE-----

--yi8nK0stCbFa6iq6--
