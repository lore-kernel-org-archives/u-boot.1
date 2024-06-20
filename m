Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF7AC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 20:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C3C88385;
	Thu, 20 Jun 2024 22:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UeVx3p39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D366288535; Thu, 20 Jun 2024 22:16:23 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA5288427
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 22:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6fa0d077694so604207a34.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718914580; x=1719519380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=muHi0WOv0ewoYwvvzn+fTE8gxCQbp7j7+J48UA1M2/k=;
 b=UeVx3p39Db4CzVBoOS85w9L/ZN5cR3jQS/Enxp1b5sTygcY7dwBafZ3dbokM6JPkKn
 W1tzgJiaySZT8zrKhyH5ZxtCFKX1ZfnLAdCYlb8O5GSmF8kdrF7t9/uYpnRhzdEOgCum
 FtmapPRWmIcD1uvtlHwJ5ZxN9I9JpaARf5024=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718914580; x=1719519380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muHi0WOv0ewoYwvvzn+fTE8gxCQbp7j7+J48UA1M2/k=;
 b=MrABjdv31+3suTYH4MN+3VNH9rDFjSZO1Q2z7Uvlt9AVc7LRmKr6dCK8i800zp0Rz+
 DsxUoJM2F2/luJlYWjEeVizXMwXPu3DqaMEM5GddmP3GCHCy4GWW2EjT81vmsDmAu0n0
 pJIjXtFCSxVbz4HdGq88rx/KgpH1GYgxwzymnmHywiCurR+PK7T8G0UBI7egN7mC31iK
 y8VWz2rcYmKCpZHgnwQK92e0NdXrl3sF90cYlglve/fGs+/WzSKQyjbDAfumFI9Kr4TG
 KMJWz0GuTwjJfaDW5nsNh/IYV68+5mieefJgx4leDnDkXIqqmCWaIVlAXCwfsyhcL/Jm
 xBTg==
X-Gm-Message-State: AOJu0Yz3AKJo64HTekrKRO6hT5lHV2LZmIquVtxR5hdUC9sHUZxrJ0s0
 m5l4+lk8aS7gPqNTKyG2ChHQ4OKl7A7oyV29jncHp3EtoBO9LsDXI9LUOtViwHxmmHSACLXAYy0
 nm0Y=
X-Google-Smtp-Source: AGHT+IH7ubu4Tl5Jk42TylGMNqumxRzSoFwe+m9w0zzJkBiYcwIu0vFk/12Thbbo1TEBF91jV+Gadg==
X-Received: by 2002:a05:6830:459:b0:6f9:8a29:8e8c with SMTP id
 46e09a7af769-70076c0b4cbmr7987835a34.23.1718914580347; 
 Thu, 20 Jun 2024 13:16:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7009c67666csm31673a34.75.2024.06.20.13.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 13:16:19 -0700 (PDT)
Date: Thu, 20 Jun 2024 14:16:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Chris Webb <chris@arachsys.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
Message-ID: <20240620201617.GA3566532@bill-the-cat>
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6g+8gxS4Vb0jVfua"
Content-Disposition: inline
In-Reply-To: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
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


--6g+8gxS4Vb0jVfua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:59:05AM +0100, Chris Webb wrote:

> 48b3ecbe replumbed the gpio-hog probing to use DM_FLAG_PROBE_AFTER_BIND.
>=20
> Unfortunately gpio_post_bind is called after the non-preloc recursive
> dm_probe_devices completes, so setting this flag does not have the intend=
ed
> effect and the gpio-hogs never get probed. With instrumentation:
>=20
>   [...]
>   CPU:   MediaTek MT7981
>   Model: GL.iNet GL-X3000
>   DRAM:  512 MiB
>   <mtk_pinctrl_mt7981_bind called>
>   <dm_probe_devices called: root root_driver root_driver [+] [ ]>
>   <dm_probe_devices called: clk fixed_clock gpt_dummy20m [ ] [ ]>
>   [...]
>   <dm_probe_devices called: led gpio_led signal-4 [ ] [ ]>
>   Core:  34 devices, 14 uclasses, devicetree: separate
>   MMC:   <gpio_post_bind called>
>   mmc@11230000: 0
>   [...]
>=20
> Probe them directly in gpio_post_bind instead.
>=20
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>  drivers/gpio/gpio-uclass.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index 4234cd91..1c6e1715 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -1539,7 +1539,9 @@ static int gpio_post_bind(struct udevice *dev)
>  				 * since hogs can be essential to the hardware
>  				 * system.
>  				 */
> -				dev_or_flags(child, DM_FLAG_PROBE_AFTER_BIND);
> +				ret =3D device_probe(child);
> +				if (ret)
> +					return ret;
>  			}
>  		}
>  	}

Adding Marek, as the author of commit 48b3ecbedf82 ("gpio: Get rid of
gpio_hog_probe_all()").

--=20
Tom

--6g+8gxS4Vb0jVfua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0jgkACgkQFHw5/5Y0
tyxsYwv+NdhHXniPmtqa6FMDxt/pIHt1N4iIrEBatQo7nTkb2oKanonMY3fBStcV
SWhrJ3tVN+XY0QgfpchTO34iuA6Z7weng5FDmkLS7NXN5b7+jCfXxrpbdvmJSl3H
qkpvpo3aJeu8TP0loWAasAQbtjNeNlm5EmXZrZFIqFP30hnV0DS2sIFbouzG5lhU
AsGhk1TjqrDo/we+PysHaB2XFjz4Tt12q+R4ig+rdM+LwlrzVX4817H0QBit5Mi2
M/KKNeoqPfVauY0+eVQ9ViFx+l6P4HacwV27hylaLVFG6OGa5aKnGW2wrlMDpsSI
/HPsU/AL3knRxlspkRjVYmZuZjvJr2NbutdnY/TEZTV9BOcbMm5mld2v+zZogEDN
XrEY3jTMKUaPD8YQSSXJ3W7T8lMB66OIPkhcM62imVxCWw69K71sNGQN2rzs4uED
hvH6UMrMMhKLN4KuW9CjGkq63+xtJoy86BA6igTv4NH8yRtFAZS4CoUg1qOmKSnM
XUzD8Im0
=zks/
-----END PGP SIGNATURE-----

--6g+8gxS4Vb0jVfua--
