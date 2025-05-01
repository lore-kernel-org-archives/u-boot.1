Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE45C3ABA9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 06:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B1AE8070C;
	Thu,  1 May 2025 08:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746080232;
	bh=RtQ5LcSBX3TldabhzQ6t4Bni6RkpPW3KbVQeZvioGCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zIe2ROxXwvlUs0hXjtiO0Jc50YxO00EgOOhTlpif1yCfGcZIK4HboUXnhUBUzDCPr
	 x5qel7pbi1vjDUAyEqrzL9TDbEsXhYNjQQ9nSbO02K4v49/YEYBH+FyuKpUaCZjhJB
	 S9/9hHxcSiAAFK04mIATVcCdCXmFQXP9ZiBhrxK7wGJT/bqWcR1nkqWHHmMEVZqfrq
	 kxFFqBhAUafpoeJHUtT0ym/3LwyxOM1dYmsyK1yJYcFWFjROead70PzP/9b2VVtReK
	 34XzqpiRqqaXc6zuHuBNqkPTtvccSJl+jpGHQWu27zrI5RlaLQFPzL6sQ4g6bhieeB
	 Dt5Boh/XHX7zA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2BF8081A; Thu,  1 May 2025 08:17:11 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3479E8059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 08:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VYKKRS2P"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8CC3C102A8CBB; 
 Thu,  1 May 2025 08:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746080228; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=RtQ5LcSBX3TldabhzQ6t4Bni6RkpPW3KbVQeZvioGCY=;
 b=VYKKRS2PCgosGQqhRNm8PTYy+vmmlBXtQ4jHDFL0aGuGK7IDktFG0ag1Mp72yWd+uiKpyE
 T7NaEdm/J8jg4OJt4zxZ6xkqGDceN24xNsZKLNGs1RDP/vALR3gYct3bNj8Qbgz02wNwEz
 +pzGkIJk4BgEiuiZZBEfqAmcomWKbZn/m+pLcCFu+uOEdM/l2MuYhfmMECkgwru6b6X4xS
 a6itVUspqseDa1O0P1sznD2+SShS5lFEZIZpzHBmSiZgQpcZRv7wURZFQ0jqOOfglDL/OH
 JXPxfZeu4Qtsa95zzrYx3VfYkskxvMTGd94PTcYQKXbCB7ANBwkV5CeQ9i0kdw==
Date: Thu, 1 May 2025 08:17:05 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH v2 15/22] liebherr: Include env.h to permit reading the
 environment
Message-ID: <20250501081705.402bf67c@wsk>
In-Reply-To: <20250501010456.3930701-16-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-16-sjg@chromium.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gD/M1TK4IiDPVzKMxHgmqS+";
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

--Sig_/gD/M1TK4IiDPVzKMxHgmqS+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 19:04:40 -0600
Simon Glass <sjg@chromium.org> wrote:

> This file reads from the environment but does not include the correct
> header. Update it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  board/liebherr/xea/xea.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
> index 1d4f165fd13..9630e7f576b 100644
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

--Sig_/gD/M1TK4IiDPVzKMxHgmqS+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgTEeEACgkQAR8vZIA0
zr0DQQf/V+KQY2Lut+nILaNi7r9niCVVOl5bY8ctUUJk+jdEFihjZV8D4HURe/AS
xZUMHlPu5NS/fjcpaLUe5mZyHyYqjxRGtGJbDqAvar1XxJ7VR+330rHC1WrY87C2
5ytf71Jez2YGLBPRoCwr/hJXfnLnjY+c0bBL8IKo6yhSm9uelqJ0cm4Mg6M5ruMX
/LjcRT9LAEtyZeSFLzIKxbyJfV+Me1piGwUhnnECzTg2IlJSAAKhmZDF3iHgPHpB
P5Bf7TkaiiJfwuxCpBp3D0MdJFEcdH0uQR4iMEniQRPwIvxEemfOeJEnLqwdwi3l
XVU7S3QsaByZK8DQHF0POtBMRGt0ZQ==
=NjQ6
-----END PGP SIGNATURE-----

--Sig_/gD/M1TK4IiDPVzKMxHgmqS+--
