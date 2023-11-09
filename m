Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBB0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 21:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF6F875B6;
	Thu,  9 Nov 2023 22:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GeqtGU88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A172874FB; Thu,  9 Nov 2023 22:26:16 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB578760D
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 22:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7788f727dd7so83204085a.1
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699565172; x=1700169972; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ETVLxG/cIBOBDxM+T/e0v6Mf0cI+d08NdR1KQztnRo4=;
 b=GeqtGU88wb+NdRLWXacvejeL335rvduTtzESmSHvY0yugc+gbdj8TMoMpfyRjNwqhd
 o6Qt4Xooc9JpUSfrFENLEGuVljAGnovd1zarEcRvvCBCgMRssev1mPE/1t4/PqUboKEO
 kuxqig8CbACWdWYOC/ptWIUAnV0lZS2oOce3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699565172; x=1700169972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETVLxG/cIBOBDxM+T/e0v6Mf0cI+d08NdR1KQztnRo4=;
 b=L/28lXbTNtE9lJOPG3VuyA8YmFn1C7C3rCaFwyAWO1N4RNOiZP3FosYXPYQcG6OPi4
 vlbPerShAzAxZBWpTAgtm8+o6+y9zYZvE3e8DfFwRDj9oIsMai58abH8JXqcSipG7tmw
 rQmFQpw3ehrXTkrVTdEadRQzWv04GuJKvHDI13sUaBkGKWU8q8HzhsppOn9atTyCZ2DH
 zijc9HEbfaBMcsdynBz20qVTlNTsNdkZ6RpdGvcfyoXGEEG+ji+lymK9BvRPdU4fkoAS
 FC98T8u1baUv1fk8sfVer5+NyGSB+zMUR9TyB7fBgN4E82vNzNLtP89gJvrx4FpXGEIk
 Wihg==
X-Gm-Message-State: AOJu0Yzt5wFMXU87sKIUBwHOliSd3mD1ttLdMqxlUGXdm493iHO/RTyQ
 7IK8AHqSJ+2mna/OAQ7utzU/mA==
X-Google-Smtp-Source: AGHT+IFNxcozK9MJIfSFbrvHmCnhxAUEQJj/brv4m4d0ywvEGUgUyokJqBjiDK5kYrMotYLoe29BFQ==
X-Received: by 2002:a05:620a:318c:b0:77a:5112:c1e8 with SMTP id
 bi12-20020a05620a318c00b0077a5112c1e8mr6989167qkb.23.1699565171978; 
 Thu, 09 Nov 2023 13:26:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a05620a034300b0075ca4cd03d4sm209624qkm.64.2023.11.09.13.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 13:26:11 -0800 (PST)
Date: Thu, 9 Nov 2023 16:26:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 3/6] rockchip: puma-rk3399: only declare functions in
 U-Boot proper
Message-ID: <20231109212609.GM6601@bill-the-cat>
References: <20231108-env_default_theobroma-v1-0-cb493bfdeffd@theobroma-systems.com>
 <20231108-env_default_theobroma-v1-3-cb493bfdeffd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sqNpeI3Q1mJwXwr1"
Content-Disposition: inline
In-Reply-To: <20231108-env_default_theobroma-v1-3-cb493bfdeffd@theobroma-systems.com>
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


--sqNpeI3Q1mJwXwr1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 03:20:32PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
> Those functions are useless in anything but U-Boot proper for now, so
> let's compile them out explicitly.
>=20
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  board/theobroma-systems/puma_rk3399/puma-rk3399.c | 2 ++
>  1 file changed, 2 insertions(+)

Please do this at the Makefile level and just not build the file rather
than #if out the entire thing.

--=20
Tom

--sqNpeI3Q1mJwXwr1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNTnEACgkQFHw5/5Y0
tyyZmQv/aobG/IySEdH9n33g0TMii/PQOca/Nu8ZtrRq2fY9JreXn2ySu/XQLfpj
bwaiCbjEirLu6jTeLnsbqOwAAtKHqbVoRZia7/tbT3GhUj4lqBLShFxlQlNdpHEL
bGP4sATHZGIkJbcADjiAU7l45VQmCxw+0Zli/XumIEkktGvlyB/sI/IKysxTaJg/
nYzeThgFdY3gb7HWqxHl58G9ayySTnX7AcUe0otKH5YOy3vMra/XYW8M4++11S5Z
//BAH6Uj8g8TX6kW7kSPVoXZykB9p+FgdnzXDlC9s2vzN2Nw1OYNDC6UbjK/P5p1
MqQpUJiBOaOw4dLnG6Fu+p4Pm5A2aBJSct1y60KywsFR4VSCexyFHH12QI8vOM8P
owb3+b2x3WINUz1m+m8npKvUqE2+S6kcnq43WgbnT1A+FYHcXDn43xdEX+4iFxFB
HmNv21kxMjOYwMfkwEuXcY3Z+Vn6QJl+ym5tEsloscCpdCIfHIXWdecl5womXOko
aGz0iCVn
=aJ0T
-----END PGP SIGNATURE-----

--sqNpeI3Q1mJwXwr1--
