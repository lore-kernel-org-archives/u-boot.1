Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2129CF9D0D6
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 15:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85318841F2;
	Tue, 14 Apr 2026 17:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W6DNtbec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E88C8421D; Tue, 14 Apr 2026 17:19:04 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EB5083015
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 17:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dbce74e537so4475048a34.1
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776179939; x=1776784739; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JHwA7wQCQiWABQVWWMXB1iuppdcPxBZxxFnGdHywpl4=;
 b=W6DNtbecmn8g7Sxyrw0Kklg1GOwf3LxoDeKnRGupuf5LjKEVbwuq4DMZbGUNx5R9Qm
 2iLnLlw/LRvIm2NawVm0fgeT+ko5cTd2wQ/TjqgQEkIpAiJMhM+go7+qCVh/wtbhEVXk
 8JwOHrdk/mwf3S56fe+jD0XzbY4vYWEbfEFCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776179939; x=1776784739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHwA7wQCQiWABQVWWMXB1iuppdcPxBZxxFnGdHywpl4=;
 b=oVYdrU0vu3/VFYd0hQEAXD92cYn3UEhA6sm6kK8yAy1bgw2wwlRp4m8Ftwufymn+v/
 h6lOVETiXosAtMFNhMyHvxTc5HGdbMHzW5MlNufP4IDohKjBJ974cV1Mv089M+lfjACk
 R0dH365ailbbqM11K40DGHdCGIsXCVkxGDIOWYw0FlKLpXmnLHB21/ggpLZ8pQg6IxlW
 KCx5hyArq7zV9wzRvbA1iCOKVIh387HZr7/wmUkPwFvDEp080pAhLq3LQzCMeOH4Uhb2
 fHQGtkuhRHIgjbNTtHUsS+u6ibGDdyrEcJjtczfvFXRMIj/ClnZnmNda86a2oLqnUF+w
 s4iQ==
X-Gm-Message-State: AOJu0Yx3lscRJktYe4upMyPFwvv1S1oq+0NM9sg3mN57T/DR5YZyOc2Q
 ocrpy+oDxVSCzEysz8Eb71EaBkdT4GLV++W5yM+toEhORGLhVyLaDp3iXfLyKBTl4tI=
X-Gm-Gg: AeBDievzU5Ndncy6sitC3scgsrD9let/SKbhxIpXFRX291rk7pvO5GnqSHFKFlNNq9a
 1DEzVNck55eie7RrOYQt02lGFPdEyXHdSSmPX5ifCauxDgnE6xKlT+9VlzPIJO3U28j3Kabhfgo
 ADbmbp/L+l96tri1uJo/i1uPJg1xdkB20qz6FVnQd4sz+0mtft0kZcONXN2RLUdfU2kUohONHad
 MDnAziYYJ7XPpSagCnQpKSNmLLw85eHCzB09YDikSCHBgYGE8JdJWJ5L6XoSdCAZ+g6YLH5WNJA
 m5evVBJ0sdwe13YQ1Mi12r1iHS6TGIRypffq/E5t/hZmK4KiAL+LOq5rnxW6JzFji20DlLtoNa0
 vImZ4tOS4pcY/W9hBIBvzVPM/49oXNqDNP/lPdC67suT1doz5VchasGmXUp5+tNEiEvGE4ordI+
 l7iXTdLjZT9MR4REM7swTtptD+qWEg3ZFopu3u0mjpqqPGSRizNeTcFWdd6OenBAgGDJXiM4mT6
 XPlUyRPoA2KMWT2XkiOO5aYiJuj1C5Du31jnFrEnV/Wtn1zuJk=
X-Received: by 2002:a05:6830:2684:b0:7db:a832:b329 with SMTP id
 46e09a7af769-7dc27f02d10mr9990731a34.21.1776179939103; 
 Tue, 14 Apr 2026 08:18:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm10846464a34.21.2026.04.14.08.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 08:18:58 -0700 (PDT)
Date: Tue, 14 Apr 2026 09:18:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH] common: spl: nand: improve u-boot offsets overriding
Message-ID: <20260414151856.GL41863@bill-the-cat>
References: <20260414080321.39542-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hrxqCB6tsDIKhII5"
Content-Disposition: inline
In-Reply-To: <20260414080321.39542-1-weijie.gao@mediatek.com>
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


--hrxqCB6tsDIKhII5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 04:03:21PM +0800, Weijie Gao wrote:

> This patch introduces spl_nand_get_uboot_raw_page_redund() to wrap the
> CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND macro, similar as what
> spl_nand_get_uboot_raw_page() has already done.
> Also, make it possible to use these functions without defining related
> macros.
>=20
> This patch also replaces all references to CONFIG_SYS_NAND_U_BOOT_OFFS and
> CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND with the return value of the two
> functions mentioned above.
>=20
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  common/spl/spl_nand.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
> index f449b31f594..cce2e1a6df3 100644
> --- a/common/spl/spl_nand.c
> +++ b/common/spl/spl_nand.c
> @@ -18,21 +18,34 @@
> =20
>  uint32_t __weak spl_nand_get_uboot_raw_page(void)
>  {
> +#ifdef CONFIG_SYS_NAND_U_BOOT_OFFS
>  	return CONFIG_SYS_NAND_U_BOOT_OFFS;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +uint32_t __weak spl_nand_get_uboot_raw_page_redund(void)
> +{
> +#ifdef CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND
> +	return CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND;
> +#else
> +	return 0;
> +#endif
>  }

This is closer, but not quite what I was thinking. We should be able to
use IF_ENABLED_INT to get either the real value of
CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND or 0, and then maybe (maybe not)
clean up the rest of these changes a bit more. Thanks!

--=20
Tom

--hrxqCB6tsDIKhII5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad5a4AAKCRAr4qD1Cr/k
CrxsAP9K55xvik2HwgW+1gN7mRyNO7IVK1YnN5xH/XyjZKsaWgEA1goj9tWuNjHr
eGDAWeK4p2mRcCRR6oOo/kVviyXo9wU=
=XTOP
-----END PGP SIGNATURE-----

--hrxqCB6tsDIKhII5--
