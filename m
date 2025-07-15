Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB26C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 16:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4742382BF6;
	Tue, 15 Jul 2025 18:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OwC7pHjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7AA783071; Tue, 15 Jul 2025 18:58:51 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F78801BE
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 18:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73afbe149afso3036344a34.1
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752598728; x=1753203528; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vsPRxbK4vwEbA6jZAsKIeDDBD54locdNIkG3Ax0MgCE=;
 b=OwC7pHjSFmmxnYbxsp1/VlO+ZNPa7c52Eo1aIVvXY+mXVlwacLookuJX5Yi777tMWI
 gMKzg//vvzlFc5gccWqI4aXv90PFbmPPWObWY1RF1EECLkD91T26qBZCGWzCKGdM5Bed
 KtHiG05uD1zIrULpM6SInv9af0Bro/clfhT1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752598728; x=1753203528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsPRxbK4vwEbA6jZAsKIeDDBD54locdNIkG3Ax0MgCE=;
 b=c+2wbPpzHkXj9ggv0mqRKWoKzm5IK7A1zU2S5UDqljnLnFlXvG0D4t3BF7Y6D7D8U6
 5vHMgIEDT6A2HgKaTSVHiG9X4bLRDd0TbsIWSukVB8Nap1+f2cMINKg3XEzeKya51RmV
 ozes389/VmMDAaoEDQrPjE5eCtwXphPDaPZkEzRxLUlIlsa00Pu8/gadu6E9ME3e2Jta
 sNGmOlSqy5D19bb/H6gJT7WuXrsD4sSe/H+/1pyn8VfLeOefy8Prj3mochHL4jh1jJCp
 CY/a8py+mkh7R38YZoHSlVK04v82zP/5locccVqYP1G6uCqpTnBbHZEmPEmj2nQcSlYb
 j5nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWzj8xqKOQeYHwVLpmhbArTCgKgeQB3fzqrzwbDsg3FQT1W49ewEMKD8Dy/KSqirrOUdBMWow=@lists.denx.de
X-Gm-Message-State: AOJu0YyQNM4GoeOgaHq95IwiFtoJNVYTMOiERlbuVwSvfrxch6Be2bvU
 CloQUO3YpyAeX34FsJtZvE4tvV/PjbM2bWsJO3MG3c12/X18HFZqNEChH6tltxf6UGs=
X-Gm-Gg: ASbGncvwon/NeN9hxAsRQUCY+X09pDJ2Y1G7kZqJCEBi++8Owpyl377+djazvIzSazo
 4La4j9HrcO6C0vt2gYL7fmVRBxbwKk7U7IeMSIq9bOjNeyNhLa3fQMBfdaOSw+elBY5HAFxp1+L
 Vk+s3zTDMZ1h9SGAUc2Mr7Q6s9HUhQcQKLLv37CbY6Gr9DbIYc+mF01olqhtTznE/KlAX+nun1n
 ikUhN0UyqYedbek+CLKRC3u461ILxDkU6rW00tmBKEq1VnEd+qu0937WzCZVlPChzxf7TxrWsGH
 6bfecPUnwjNIhSgSUkA9I1DNhSsebB44WJ+9UKKCGSRwyIQjXMfxmRjjHLG7oF/W140p1M3oSwz
 Ucjr7a27xBT0MHPsz4ZxXtVeixfUkluBGObPnLXT7QuvQHDsLwXVv5i7O
X-Google-Smtp-Source: AGHT+IGCCK8JlS3FrHkvYxD5H8IV68YcZ/55bFqsp+BB/tQRuo0/s51a9FMJg0ljzykmPwc68eKJQQ==
X-Received: by 2002:a9d:6014:0:b0:72b:a465:d955 with SMTP id
 46e09a7af769-73e64a49a2bmr137336a34.12.1752598728434; 
 Tue, 15 Jul 2025 09:58:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e5a69bcc4sm615259a34.47.2025.07.15.09.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 09:58:47 -0700 (PDT)
Date: Tue, 15 Jul 2025 10:58:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] include: env: ti_common: remove bootm_size
Message-ID: <20250715165845.GF193579@bill-the-cat>
References: <20250715-initrd-fixes-v1-1-8c41b1fdea6b@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TTUv4yjRJ25q5uOZ"
Content-Disposition: inline
In-Reply-To: <20250715-initrd-fixes-v1-1-8c41b1fdea6b@ti.com>
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


--TTUv4yjRJ25q5uOZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 11:21:12AM -0500, Bryan Brattlof wrote:

> As the size of the kernels, DTs, and initial ram disks continues to grow
> in size the 256MB size limit set aside for image processing by the bootm
> command has become too small for some boards.
>=20
> Rather than increasing this limit let's just remove any limit by default
> and let each board set its own (if needed) for there use case.
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  include/env/ti/ti_common.env | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index 7029d12bf203320fde859965ae57c272ed4c685c..03e3267ef8a1bf3e14c65df12=
4ed1ac842c88760 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -8,7 +8,6 @@ rdaddr=3D0x88080000
>  ramdisk_addr_r=3D0x88080000
>  scriptaddr=3D0x80000000
>  pxefile_addr_r=3D0x80100000
> -bootm_size=3D0x10000000
>  boot_fdt=3Dtry
> =20
>  boot_fit=3D0

So, which of the older families of parts use this file if any? This can
be a concern on am33xx for example, still.

--=20
Tom

--TTUv4yjRJ25q5uOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh2iMEACgkQFHw5/5Y0
tyz/fgv+Ph1HNo7nBCwTFAyN4/csK7hZza1axDz7jR8UGSF4iO8qIdDK5wEqJoLf
fgxazdI/pvA1qdEcsMBuC3R2Togadm8kR3QT+Oi6zqlW9D1dL0x66U6Y6OySPV/H
2OY4adZH7RhYOgnmDXlpK/tKbRgryJL0XXBi1Sr46uLuHNxMr8OqraHlKbMOFq6y
7yO0uwWntSwm0NSmL1n2YMuAtAx3878E9+2xQUfAMsfS2guiQJLndiw9PECwThXM
C/++Y9Ud7Gh96PvwMonOCj11GGBx6IgMxBka3KJXOD6EO4EJocYiaCXmnmCiOddD
je1nZ1/0ZmFqmak/KCGR6wUfMuCI/UeUbX+g5vHMpmcKXfTGqxC33ljZwO31pIQD
+cTEcIj+C3W//OyhIgf2sfDOQVtdp1TraWi/DpEb2XfNGC93wKl8NkaXCglCNXfv
utWBB9cA1R16FigBekbSrvo+aCDp1mYmim6rfEeBqbJhXtFBxSLSoP+cblqZBkbw
st8oUWnG
=zlJY
-----END PGP SIGNATURE-----

--TTUv4yjRJ25q5uOZ--
