Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B03CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:14:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5D286D94;
	Wed, 11 Oct 2023 20:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HJWta21B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C285F8082A; Wed, 11 Oct 2023 20:36:59 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA83E86CE5
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7af52ee31so1850497b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049409; x=1697654209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=406+NOWqJM5bs9NAMaXkhYQCvBJa6BRW9rYCrp0kT9M=;
 b=HJWta21B3pS93tKOigx8PARcfZ5Llcpk7yw3Yv56I0wcYdUBbdVTAQVR7LAUsQL7c5
 2VpxToIF/ittRbLW10JXjiQrPTzPLuCsR4tBZMWmjshoB9aIBDs3Mq1detzWU5izy3rv
 eXtRRzyswgSR2eE4p7OjK0I4iEnFIbLphvqXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049409; x=1697654209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=406+NOWqJM5bs9NAMaXkhYQCvBJa6BRW9rYCrp0kT9M=;
 b=Hxg0kc6oNttI0BIgzrieIV8SfuJGUS+uD1zTfEFmTAvnM5/u/ztkNuMm5JG/qKMldk
 PUOheu/RNf80R7tT8ArGDsYKNz6iCPjBHyJj+KXyufMb+k2y9JCokREZj8t+wQvR0aZ+
 wb79a2bBNj5XGa51gVxqkF6pLTKcId8YdtZXl/KUl/q+9pJoR5oiKxthGljA8JKfzZgt
 +VB1GTtBnW6pTkgIG7lgrziPNMSfz8PsnpS5RkgGpydc0TER20/gjq0+hrDxO8ZzzxF3
 1QXJq2aY90kLoi61JAmyyRo0x/bvRq+OeuhHoMUqkVwUw37poFWAhst/qlQs2Q+e634S
 pdew==
X-Gm-Message-State: AOJu0YwVs8yCiLJhaOYUBOyGupu+CmzdT0rizEs5TAtlsWqBzu9sJFyz
 vMFkQKUeZoLn86BuueWvo0cs9++q/VLKUo+XHRFd7w==
X-Google-Smtp-Source: AGHT+IE9ptKIc8eUFvqdGDI8wNqRjIpLdMRRx8lz40iOivp+TI/JlmUZbLfT3uQpVLRJnhUVAOv9IQ==
X-Received: by 2002:a05:690c:d87:b0:5a5:7ed:cf80 with SMTP id
 da7-20020a05690c0d8700b005a507edcf80mr25901778ywb.23.1697049409280; 
 Wed, 11 Oct 2023 11:36:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 w129-20020a817b87000000b00589c103d00asm5339083ywc.79.2023.10.11.11.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:48 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: u-boot@lists.denx.de, Nishanth Menon <nm@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v1] arm: dts: k3-am625-verdin: fix boot
Message-ID: <20231011183646.GL3119521@bill-the-cat>
References: <20231010111304.200307-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a3HeHbUUEisugs4F"
Content-Disposition: inline
In-Reply-To: <20231010111304.200307-1-marcel@ziswiler.com>
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


--a3HeHbUUEisugs4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 01:13:04PM +0200, Marcel Ziswiler wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> A53 U-Boot proper got broken because nodes marked as 'bootph-pre-ram'
> are no longer available in U-Boot proper before relocation.
>=20
> Fix this by marking all nodes in u-boot.dtsi as 'bootph-all'.
>=20
> Fixes: 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-r=
eloc after relocation")
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied to u-boot/master, thanks!

--=20
Tom

--a3HeHbUUEisugs4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm6z4ACgkQFHw5/5Y0
tyydugv/ahlu4NywL2XbYZffafPhPWRREYm419NOEebG5ypG7hpNv6RdwIcvSMnY
zseT2sHHvGrUWnRkRWiifiP/Intt05ZAlLIS1R57pp6sLqeSArBJGeutLM9M59Yp
epSoIF5+knMKVsJ0BTPE/hV6apf0y6ousDM0nsnaQGxb1Tm31/IEnJHo17JsxUfQ
FcigfAwwxnV8D5xbUPcHSgGqt1Y1HU070SZP/j5E2zeIV3QrDiHnSwTjReAr6jMY
FjgxKiA4rdD8dZLTPIbx0ZRS0IfzYbEE+3HOpif9dRBZ8FLS1R7TSMxuFqQJ24d5
BwAggr6XdWHIDuyku2kECwZm351ONaA54+Jt22w0fzYr6tQHvfz1txmv6Iwpvg2P
pIau/0Mx+nB6pAZdNgP8pjVgafjGbCRDyEqPmQraXMBDZAgVTPtFRTLUNMGP6HHt
QHCLN+0yu5hQlROIgx0cg1EwQ/1G2Rho1Ji3+fPRxuaipcXRaKC2sb0mMMLNp64o
i6e2S8gP
=PIWX
-----END PGP SIGNATURE-----

--a3HeHbUUEisugs4F--
