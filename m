Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E2CC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 05:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9401D8277D;
	Fri, 16 May 2025 07:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747373348;
	bh=IbX3KjuNQu1d0YJcHVMITJFxX4o7B1HS8NoQrA3xYWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xZE/Bsv2sfmwf9mvO2NrfHvklkg+TMq6Y/ZDxljbYqedr1QFuLaZEmYfvGp2MhN9q
	 Q6jUj53SqW11T8NtHEFaw6jsZFk8VoG3V/nr1aFnSGDJmUl4hkc1vIEkgex6odqNpK
	 r4JE4hs89hg7kg2Ws9TJgjx5aAkIjp7TND8hMbJ+TbUswl0iblBa4F1gIQkof9uL9U
	 gSjOTOAoLMEhqDW064JdbxgPd/hbZYWxbb1CzteNkkdyE1MCVuzpSBowP7g0YegofE
	 kTFYgeUzYHLEOPsEpkG3f0Nd0DOxwMjPCV/yhp0ODQkSbi/9OvxZYJitG4EaFiGwUN
	 u0H9wr+MX/CtA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F00028288D; Fri, 16 May 2025 07:29:06 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125F780AE0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 07:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gG7xqLSo"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9188010397281; 
 Fri, 16 May 2025 07:29:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1747373344; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=IbX3KjuNQu1d0YJcHVMITJFxX4o7B1HS8NoQrA3xYWc=;
 b=gG7xqLSoxTTI+0T/t10wly9Ic5zwcq8yPRAhGh706KWfn6Q1dI4B4TkSvlLK62ZapQWmfY
 z4lIsC457qPKGSbDRg4+0Um12JzdY7qViRxCP6IKo9Gcx4IjNYSGPuMWTW9/uzh2Sa+c9I
 cF3TiMfyIWJKjLXIHdz7DrN41E1VT6x+2yiWTBgYdq78PdQ3fxxCIICk5YkOEsw11gF84d
 t7hL/vMlQvql/aLzsC1RcB5JesJOsPpO/yPngU4cKhlvvoIVu+yzpC26CQ/3yv3dSbZtkR
 e80IPgH8LFAV8T53p/G5YuqfGcMTIuTWdUr27KT1xKRaOS1PZWU92My2G9/yig==
Date: Fri, 16 May 2025 07:29:01 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 16/22] liebherr: Include env.h to permit reading the
 environment
Message-ID: <20250516072901.5fc2e2f9@wsk>
In-Reply-To: <20250515234154.1859366-17-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
 <20250515234154.1859366-17-trini@konsulko.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/drIdGHZJ_7hQvSc2VA.m+UQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3
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

--Sig_/drIdGHZJ_7hQvSc2VA.m+UQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 15 May 2025 17:31:45 -0600
Tom Rini <trini@konsulko.com> wrote:

> From: Simon Glass <sjg@chromium.org>
>=20
> This file reads from the environment but does not include the correct
> header. Update it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes in v3:
> - None
> ---
>  board/liebherr/xea/xea.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
> index 1d4f165fd13a..9630e7f576b2 100644
> --- a/board/liebherr/xea/xea.c
> +++ b/board/liebherr/xea/xea.c
> @@ -13,6 +13,7 @@
>   *
>   */
> =20
> +#include <env.h>
>  #include <fdt_support.h>
>  #include <init.h>
>  #include <log.h>

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/drIdGHZJ_7hQvSc2VA.m+UQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgmzR0ACgkQAR8vZIA0
zr2xVAgAw7uyp46fLa2NMj4B+7d3oPIWnqkCjZly7LoX+vmBGCAmD2gQru486AvZ
Hlc1P40cwa14ek41nEBThcBJb7kMem1beSevK0S/HCnHnVpBMosPEycVlb/K/dya
+8QrkiHHQE37Pplq2nUBWcF6jEOU3fl7eI9UwcGpuS5WYSGVYh6Fb8RXcSDHtDk2
4zdCp2ZEhVnvpBH3M1kxOMSbrjzbQCxItb8Nzx7M2O6wuXIyyPHwC+lkRPDRLNs9
5U6QNWlKxi80rThqAz+MiMqfpOLaW+xbrCU9Iac/SNiIYHGDfI0E5cgP+qjim/Nn
ZRhSoADwbFjJQ48m6s2iMrfQHIfVBA==
=4WDa
-----END PGP SIGNATURE-----

--Sig_/drIdGHZJ_7hQvSc2VA.m+UQ--
