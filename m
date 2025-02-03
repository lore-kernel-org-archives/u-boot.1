Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82186C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5828805E2;
	Mon,  3 Feb 2025 21:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ufu7TzdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B30F6805FF; Mon,  3 Feb 2025 21:09:26 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DBA805D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d88cb85987so39357856d6.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613362; x=1739218162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r3wscFC3vs05l2A1ybJfOKVROh/c1GX1Wvb8n7CvZwA=;
 b=ufu7TzdCHY2+Sk1TAK/ir2qyYA4wQ/uZ7akD6/HoXvb4ZlZsS3a/lfQpQhVjkqzjpq
 EkN8d0uPfmsKhJX0HK3jqTYB5x4fIiCTs6Ps1/dmM8jyiKNzSUEjRkKnG5dLusdlkvTe
 v2lUh5NZoghDwQ4NaXfXWkKS5cikYUcw5k518=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613362; x=1739218162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3wscFC3vs05l2A1ybJfOKVROh/c1GX1Wvb8n7CvZwA=;
 b=lGlyKeeqPqSWlNI9c10faq4NQQSKxGkx3ybC8f0fQm9AD+oHKXEri9sOT++pnyW6aK
 ZA8X8SS+XHe3UqFxDirnJTSBHQSNZRX1AwJcA/5XWGYm74dZadhjmbMjVpwuehaEvmgw
 13GRovnF4WfYDyINdgfs7HKQvZsNfj6YQziYeM6IeeKI9Dg4TfUQa92NQ5+bhT1gEc6d
 rSbqj9isvTu/SYU3qW5qaTv3I1mjTsG+CxDegladjHyJwVDr3clcv3c8kF0aw3vXbS97
 Wb+FNm1ymLPVz0wnbmjX3+cQSKtkkiZLtsgvs8pMa8EFjevdqqXH5xnBedhwDBAEN16W
 XBlg==
X-Gm-Message-State: AOJu0YyDgOjlzYUXxfkWOELf1y32Nf2jqBZ2jrt+xsGLAXQRwtCVB5Z0
 6ktcRPBYZKVgD5D16iq/p1z+dMDwHW7nY1iILleJNKNRp27wmUIBCOREfAtSaKA=
X-Gm-Gg: ASbGncvu2C4rjy7Om6sjKgSy3MOZpHQr0OSFUPjcrBQiMfALw/0vEDl1btE1HMUTMWu
 7toc1aDuoTfN9ulwVoi47OISFdrvpCvwo4eB383xd0ZqvJwD67OjMHMeebNkDKT9TcGHuAX+Ja5
 ZH23OzKSAvWFDh7Ya1o3BfJJ8v0qeGdIOqmDGfShD/e0PqTGc4iKHasABMSWWe4tmP9ClxRv9/M
 IcJpfIMXq8U3I/rkBvkjIbLOPs33yglqP5n+0+yjpy1HXR51CSIldpTZsqf4yPeGpVDjX+LQzMz
 1hWnoJ33h9ds/Lo=
X-Google-Smtp-Source: AGHT+IGs0rEgwqAga/7KpK9Mt0fcSb08CAEBFmhdcy/i4X6a+roeY4vwjzXmokUZsGCZ+zHUSzWz4Q==
X-Received: by 2002:ad4:5e87:0:b0:6e2:485d:fddd with SMTP id
 6a1803df08f44-6e420f3b30bmr13876726d6.1.1738613362427; 
 Mon, 03 Feb 2025 12:09:22 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f0e16sm53849526d6.15.2025.02.03.12.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:09:21 -0800 (PST)
Date: Mon, 3 Feb 2025 14:09:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 16/32] efi: arm: Don't do the EL2 switch when running
 under EFI
Message-ID: <20250203200919.GJ1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-17-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2CIiI2cBA4gfR+Hd"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-17-sjg@chromium.org>
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


--2CIiI2cBA4gfR+Hd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:09AM -0700, Simon Glass wrote:

> The previous bootloader has likely done this already, so avoid trying to
> do it again. This fixes a crash in QEMU when booting from EDK2
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  arch/arm/lib/bootm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> index 974cbfe8400..688c2f3f29b 100644
> --- a/arch/arm/lib/bootm.c
> +++ b/arch/arm/lib/bootm.c
> @@ -16,6 +16,7 @@
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <dm.h>
> +#include <init.h>
>  #include <log.h>
>  #include <asm/global_data.h>
>  #include <dm/root.h>
> @@ -186,8 +187,10 @@ __weak void setup_board_tags(struct tag **in_params)=
 {}
>  #ifdef CONFIG_ARM64
>  static void do_nonsec_virt_switch(void)
>  {
> -	smp_kick_all_cpus();
> -	dcache_disable();	/* flush cache before swtiching to EL2 */
> +	if (ll_boot_init()) {
> +		smp_kick_all_cpus();
> +		dcache_disable();	/* flush cache before swtiching to EL2 */
> +	}
>  }
>  #endif

Since Marek just did a bunch of work around "use U-Boot for all ELs" I
wonder if there's something cleaner / different we should be doing here?

--=20
Tom

--2CIiI2cBA4gfR+Hd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIm8ACgkQFHw5/5Y0
tyyYnQv/XaYdKOQl5UwNnEuqHNYB33y6XynO3WUFKMWHtFrGGLg/Jc52a+/75wdI
qZ0SJaX1XV9vzNkXT+CgmEqQt1iGoCH+8foR8OfK5VLZhNYn+ywp2I8LKU82s8TC
0RKCqmzcduYg6FdtkbSH+nvIgftWfZHlYiZMJEt6OsLGZ+eUlBBhdTjJT9uhErAZ
iVmksfxuxz/oaQvSvnRPBFfwruRd6f6n/zjh/PSarLmpzaz7FNSu1e//7uGbha7m
Ld5yC1DmFo88zzOJ/Di4gsVSqdL4b2ONBO06QfEjRwW+7IP20SmkjslN0hDViv8G
jw0pLpE0+xWdr7IKFbS9kkvdw1lNIbejTg0G7/W3deBOnJ9H3xnqnOqtxkwEhCEc
BHcTZz/w7R2/YSK1ooHs37Wcn6V3qaXF7YilfQWbBNPsJEVBk7Q+SWLBhRdcvRH2
aGvVDWAEr8T9vIuAoGxm/KmquwGGu+BslZYaXMs0kNr3eQVo4FQKXzs4wZr41BzJ
EEpLS+TC
=P06A
-----END PGP SIGNATURE-----

--2CIiI2cBA4gfR+Hd--
