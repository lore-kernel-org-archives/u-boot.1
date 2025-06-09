Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39767C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 15:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B83D82AA7;
	Mon,  9 Jun 2025 17:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MNqq1lr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8EED82B0E; Mon,  9 Jun 2025 17:21:48 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE99826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 17:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ea65f5a0easo340228fac.1
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749482505; x=1750087305; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TEITP9mG0qz91fxfHwqEcfPkhTxnJGgijIhfetuwgeY=;
 b=MNqq1lr+iWNcA1fun2JKrJK3qrZZI0ONNm3mpHbCoGpqXI9MsTAFLqDZwO8oyqhEYs
 H454RpbrgpoyLC8+1P6nUQ9alDG3FR2lsSQgvuqNakBiQTJjSXEXR0aM8ZPa2C9U12us
 hnEz9OM9BtN8L+Hd/b0ZIGCiTO1hIttWqNCds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749482505; x=1750087305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEITP9mG0qz91fxfHwqEcfPkhTxnJGgijIhfetuwgeY=;
 b=V022V3h7MplwxAyASzX6rMjHC1UaCYESdctiB+qaEI+AHD4EV+dKrCj0PhfccTqvgQ
 lue4d58hqJtDP4HRjNmxVXm0a/wCoUOX10RuNvZX2RPonMax5pOk1ckV3+pKJijCnwtL
 sz0cR4ba0fy/NVEJktuMRrMwEyZaHER/Z67RJe0EhFV9YUNAmNO+U3ArERHzY22p6czd
 rXW4VLNhnd4CvcZjmZOSxyXqXBCqnB9Yr1+4Mo+bTkU10MR2tvcDf9DiD7tyt9uZkl/k
 +cbhHS3wJhPkWqK2xSlj+CW9FcNLjSFc0GI3EBwvJ45jZ62bgmpOK7jKvTuvyikOkaws
 QrIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZc2sjsRL6ZsaW5VEcj15fCEVTIhXOTlZGQC2nXjN+ulpMXOu6qINuLwUR3ji6jQOQqhGUsIc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1W7EQzVWvNXXVR7oNWcaOyuMTYwwvNpnGwWoPQ7B514h1jF4W
 XwSdBa27rewd65DPd6/BqZBVS4rhWKSwLmyRO1bL+kH8doL5SHpca3lRHPxzbgrJiw4=
X-Gm-Gg: ASbGnctyHCzl19LlFIhBujIXU9yTw/owfxK4utbWLGz16dJpcimLZ9RP0iumk4IFBXZ
 +8v/3KU6r3S7DCF9bdcVmM1gw9oiU3IIs+AdRAhvu38tCnCrKYBOV1cH6n5NASqw2CU9LVoG0TH
 ROtfbrU6pWKGQHo6HCMoZoI9WroLRCxHUOuOKoghGGENFcif01HnkWRPgF+gk/A88ZM+rRqUXyu
 RsWcJo35sYBlyiWQ5u9j34LnRJCNJM0lP27q4LpJLRaiWeF7h8kN444sFAE8HGCZFeNdHUzqEyI
 8Q9wW/mqpMdK2v7NoytpEtEhmoefpsUa2oz50T0QSihs0K1c6X1bWf/UNXMFkrosIwqkPfXUHu0
 hlhVAqQzDgMqq
X-Google-Smtp-Source: AGHT+IEpykBy3/BdHIBC3tjiPHolG7ITVAy2nzs7B4+SvpCXPE0K03K2bwhdlgMp6sgR908B7azTIA==
X-Received: by 2002:a05:6871:6013:b0:2c1:2262:7941 with SMTP id
 586e51a60fabf-2ea74fd2865mr146525fac.16.1749482505146; 
 Mon, 09 Jun 2025 08:21:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea072e901csm1972247fac.31.2025.06.09.08.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:21:43 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:21:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] verdin-am62p: include linux/sizes.h
Message-ID: <20250609152140.GO1382132@bill-the-cat>
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
 <20250608074228.12407-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YOTjc9ZbBXa+RBxm"
Content-Disposition: inline
In-Reply-To: <20250608074228.12407-2-heinrich.schuchardt@canonical.com>
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


--YOTjc9ZbBXa+RBxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 08, 2025 at 09:42:26AM +0200, Heinrich Schuchardt wrote:

> Avoid build failures
>=20
> In file included from include/config.h:3,
>                  from board/toradex/verdin-am62p/verdin-am62p.c:9:
> board/toradex/verdin-am62p/verdin-am62p.c: In function 'dram_init':
> include/configs/verdin-am62p.h:13:33: error: 'SZ_2G' undeclared (first us=
e in this function)
>    13 | #define CFG_SYS_SDRAM_SIZE      SZ_2G /* Maximum supported size */
>       |                                 ^~~~~
> board/toradex/verdin-am62p/verdin-am62p.c:63:65: note: in expansion of ma=
cro 'CFG_SYS_SDRAM_SIZE'
>    63 |         gd->ram_size =3D get_ram_size((long *)CFG_SYS_SDRAM_BASE,=
 CFG_SYS_SDRAM_SIZE);
>       |                                                                 ^=
~~~~~~~~~~~~~~~~~
> include/configs/verdin-am62p.h:13:33: note: each undeclared identifier is=
 reported only once for each function it appears in
> board/toradex/verdin-am62p/verdin-am62p.c:65:28: error: 'SZ_1G' undeclare=
d (first use in this function)
>    65 |         if (gd->ram_size < SZ_1G)
>       |                            ^~~~~
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	drop change in board/toradex/verdin-am62p/verdin-am62p.c
> ---
>  include/configs/verdin-am62p.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/configs/verdin-am62p.h b/include/configs/verdin-am62=
p.h
> index eef360ee9b6..c3464bdb838 100644
> --- a/include/configs/verdin-am62p.h
> +++ b/include/configs/verdin-am62p.h
> @@ -8,6 +8,8 @@
>  #ifndef __VERDIN_AM62P_H
>  #define __VERDIN_AM62P_H
> =20
> +#include <linux/sizes.h>
> +
>  /* DDR Configuration */
>  #define CFG_SYS_SDRAM_BASE	0x80000000
>  #define CFG_SYS_SDRAM_SIZE	SZ_2G /* Maximum supported size */

I dislike adding <linux/sizes.h> here even if we end up using SZ_xx in
config.h because this gets included *everywhere* and so we can mask
other errors by doing this.

--=20
Tom

--YOTjc9ZbBXa+RBxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhG+/0ACgkQFHw5/5Y0
tyz0ewwAtB2/AJY8dRkI/lLkMP7M5g1jrMq+UQnyXRVt0lPI/S/bMqSIgqu1c8ak
jKtmHJ+e4W/1q8nFUE3PfhPaIhXD6zICrGJQLDaSDxMxAkiW6RdciD2axC9F+yld
rTV7muCTtqRzuYNdIAQ5TAE836vOxW/GZ3lEE7ktVbyfMJYiinNsBP76FrHrNkXX
jbQEIt+SRooul3iIdY3QIpHbLnqrCPMtDXdJBeXeJ6aXKyASqjZK8D2TKTVOyIT2
+r8scOKsFMgdEJhN6Up/q5uEOoW+HdssiCL5wu/doDk9C2y5y+V86jQz0bKKLRUa
P1XdVMaAygJc/x2NkQDb1lv7NYQZ/tADUwGwFdsSx0GJGIrHDD1+yOpbxE4nZ37+
rZg1knXv9k2RhoaLID1+bZzLbb2s8a76AkWi4KNFhkktIJwSdFiFTB2953UpRpKb
COZSWbOmfZwtVb0iRNfq2PL8HU85zKslGUsf2spEsMNZeL7NAIWx6rwqu0nuf/Xu
IJNyNSqw
=Br4G
-----END PGP SIGNATURE-----

--YOTjc9ZbBXa+RBxm--
