Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F2EE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A6988021D;
	Wed, 18 Dec 2024 14:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s56+M17r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EEC680243; Wed, 18 Dec 2024 14:00:17 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 444B880214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso43142315e9.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734526815; x=1735131615;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c9DpYgfZQwo1RNQgkpBJ7wD5VfAmJemn1lian6+oRQ8=;
 b=s56+M17rngN3TqGt5zvpA8kuL/BDBbdluOYnolZDGkxM0q2fXBTnKfavabFZcqQapq
 /nNKk5ZZbH0qmJuLXUv74f6+egMimgnFVrFcWKlHmW5j7rnK3XNZDkk6yOVJp4RixjiO
 ueT9dvqCSgbIZdDC2x85103DhajC3QwtT1BrkyunqzdYU6DfhpAH7BZUFY5wXTu/KdTb
 xzNYGf40UQL7fIVgvy9guYaZcc7oa2topjuiPcU+nvS/Pg87k2JtLLwFZ/W0yeRSmJr9
 oW+ESUffDJY2rJ2oFG72irDclIZH9Pkz5GMdSmqcV9+0wS/BgCkYmsqj4YXyfFmfht7n
 HOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734526815; x=1735131615;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9DpYgfZQwo1RNQgkpBJ7wD5VfAmJemn1lian6+oRQ8=;
 b=NhLI/Li9FJosS7/kgBdhj14LIqwJf2A0GZ7raA5stMbTSnipVN/TuudPSR56pPcqPQ
 TS7Q68eo1T/Y/h0QdW5xPj+k/2PK1GympeINktHOe5o6GmpMs7XCDZAHVboOkIbTpoTJ
 GUpdEvEe3so6chkHAZeA2zk12/8NEAMmT8J5WJraIl7nwO/Z0kO0ySqgJRUq4v9Pnzes
 RXY+8eodHunTbAPSaSHRx8wIH/exTpIvp1dqOP/af96K4uhtZT/guqlwOpCvGwFW0wOZ
 58M3VG5J9G0jJ7uPhQN/FKG1avwo/pgGzeBNi/NkfGGqpLA3iCmeAQVQJwF4AmT6AVVy
 O3jg==
X-Gm-Message-State: AOJu0YycFlvh2pzJjUI5qu2hDJWgA3ip8RYIitGWD4MOOF1MtM3yFhgl
 6yHcWJ25XP/aw9CxMfkvdRDG4HE4AwxqgXjSoypXIca4LehuTjYfDtZZU0HLI7A=
X-Gm-Gg: ASbGnctH5os70iGtSxR1qK6xJJOg9AEi8Ssu7iVFkug66x0L4SFWF6zNzrJNgF80ooA
 xhPqcV/jkJNPX9WltdBuQRf9bMeezmJBi5eMggxGUltR+iwHzenYv3SBmOGh1Si47nFYUkM8IhX
 s9q8AO37cdSggmStrrnDnUcJGfa9zqqamBOlV0ZwYekjm34ln8pnw65zq3hRjG49EuBQVaZNh75
 MNYTDX+pxMzCZfSz8C++HxrOuJ41J2n6DZeK6fS0sp58RZm4/Tih94gX0SNgIlhsg==
X-Google-Smtp-Source: AGHT+IEmDYI9vf5XOKkCJyfueY8z6bYeuvySCHx5jPrGAZ5nejmHyT2ZJ0enDTc7qpRjEY0lNLBA0Q==
X-Received: by 2002:a05:600c:3b23:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-43655347782mr22231345e9.5.1734526814628; 
 Wed, 18 Dec 2024 05:00:14 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162b1sm13830856f8f.38.2024.12.18.05.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:00:14 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH v2 1/5] board: ti: am62px: env: include environment for
 DFU Boot
In-Reply-To: <20241218124542.3519447-2-s-vadapalli@ti.com>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-2-s-vadapalli@ti.com>
Date: Wed, 18 Dec 2024 14:00:13 +0100
Message-ID: <878qsdw3he.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Siddharth,

Thank you for the patch.

On mer., d=C3=A9c. 18, 2024 at 18:15, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> Include the TI K3 DFU environment to support DFU Boot and DFU Flash.
> Also add "usb" to the list of "boot_targets". While at it, add a newline
> at the end of the file.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> v1:
> https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-3=
-s-vadapalli@ti.com/
> Changes since v1:
> - Updated commit message indicating that a newline is also being added
>   at the end of this file based on feedback from Mattijs Korpershoek on
>   the v1 patch.
>
>  board/ti/am62px/am62px.env | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
> index 7ef54079aa8..e0838196e3a 100644
> --- a/board/ti/am62px/am62px.env
> +++ b/board/ti/am62px/am62px.env
> @@ -1,5 +1,6 @@
>  #include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>
>=20=20
>  name_kern=3DImage
>  console=3DttyS2,115200n8
> @@ -7,7 +8,7 @@ args_all=3Dsetenv optargs ${optargs} earlycon=3Dns16550a,=
mmio32,0x02800000
>  	${mtdparts}
>  run_kern=3Dbooti ${loadaddr} ${rd_spec} ${fdtaddr}
>=20=20
> -boot_targets=3Dmmc1 mmc0 pxe dhcp
> +boot_targets=3Dmmc1 mmc0 usb pxe dhcp
>  boot=3Dmmc
>  mmcdev=3D1
>  bootpart=3D1:2
> @@ -17,4 +18,4 @@ rd_spec=3D-
>  #if CONFIG_BOOTMETH_ANDROID
>  #include <env/ti/android.env>
>  adtb_idx=3D3
> -#endif
> \ No newline at end of file
> +#endif
> --=20
> 2.43.0
