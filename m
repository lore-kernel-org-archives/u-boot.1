Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6BCCD98C5
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 16:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9CA84704;
	Tue,  9 Jun 2026 18:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eNrXo8tG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A9E8488A; Tue,  9 Jun 2026 18:04:44 +0200 (CEST)
Received: from mail-m83196.xmail.ntesmail.com (mail-m83196.xmail.ntesmail.com
 [156.224.83.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07DF28466E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 18:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from smtpclient.apple (unknown [59.56.83.5])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41b46210b;
 Wed, 10 Jun 2026 00:04:34 +0800 (GMT+08:00)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 5/5] rockchip: pinctrl: use include from dts/upstream
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <a2401657-650f-45a8-96be-0e16660ac3cf@gmail.com>
Date: Wed, 10 Jun 2026 00:04:23 +0800
Cc: philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 afaerber@suse.de, =?utf-8?B?6Zer5a2d5Yab?= <andy.yan@rock-chips.com>,
 u-boot@lists.denx.de, quentin.schulz@cherry.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <08F3E253-8EC8-4D63-9539-3819280679EC@rock-chips.com>
References: <a5bb85ba-c159-4ac0-a1e3-4be1c6db1441@gmail.com>
 <a2401657-650f-45a8-96be-0e16660ac3cf@gmail.com>
To: Johan Jonker <jbx6244@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-HM-Tid: 0a9ead20e32009cckunm9b9f3bfe43dc3b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGRhOVkJCQkkfSB4YSRpJHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlOQlVOTVVDSFVOWVdZFhoPEhUdFFlBWU9LSFVKS0lPT0
 9IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=eNrXo8tGuTPi5l0Ifeq4wtkBBtn7coUn+1q/2tqBsp7IlarQwT/8fq4NlReeg+nhMS617pnxAgbo3MlAoMw12jV5TaDuXY09lS6sM5H7E44BJGDo9iboyV9areZEP/65izR1DJIdoYkBVHvq1ehXDUogDatGN7MnhSCGe0sUUBk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=i8xWxpCuDbqOopM6W4/9OsJyBSLDgDIG9G4FjvviE8M=;
 h=date:mime-version:subject:message-id:from;
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

Hi Johan,

	This patchset does not clean all the pinctrl source code using =
=E2=80=9C RK_GPIO=E2=80=9D, eg rv1126 and rk3568.

Thanks,
- Kever

> 2026=E5=B9=B45=E6=9C=888=E6=97=A5 02:38=EF=BC=8CJohan Jonker =
<jbx6244@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Use Rockchip pinctrl include from dts/upstream and remove what
> is now redundant.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> include/dt-bindings/pinctrl/rockchip.h | 60 --------------------------
> 1 file changed, 60 deletions(-)
> delete mode 100644 include/dt-bindings/pinctrl/rockchip.h
>=20
> diff --git a/include/dt-bindings/pinctrl/rockchip.h =
b/include/dt-bindings/pinctrl/rockchip.h
> deleted file mode 100644
> index 1c28d6cb1fad..000000000000
> --- a/include/dt-bindings/pinctrl/rockchip.h
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> -/*
> - * Header providing constants for Rockchip pinctrl bindings.
> - *
> - * Copyright (c) 2013 MundoReader S.L.
> - * Author: Heiko Stuebner <heiko@sntech.de>
> - */
> -
> -#ifndef __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
> -#define __DT_BINDINGS_ROCKCHIP_PINCTRL_H__
> -
> -#define RK_GPIO0 0
> -#define RK_GPIO1 1
> -#define RK_GPIO2 2
> -#define RK_GPIO3 3
> -#define RK_GPIO4 4
> -#define RK_GPIO6 6
> -
> -#define RK_PA0 0
> -#define RK_PA1 1
> -#define RK_PA2 2
> -#define RK_PA3 3
> -#define RK_PA4 4
> -#define RK_PA5 5
> -#define RK_PA6 6
> -#define RK_PA7 7
> -#define RK_PB0 8
> -#define RK_PB1 9
> -#define RK_PB2 10
> -#define RK_PB3 11
> -#define RK_PB4 12
> -#define RK_PB5 13
> -#define RK_PB6 14
> -#define RK_PB7 15
> -#define RK_PC0 16
> -#define RK_PC1 17
> -#define RK_PC2 18
> -#define RK_PC3 19
> -#define RK_PC4 20
> -#define RK_PC5 21
> -#define RK_PC6 22
> -#define RK_PC7 23
> -#define RK_PD0 24
> -#define RK_PD1 25
> -#define RK_PD2 26
> -#define RK_PD3 27
> -#define RK_PD4 28
> -#define RK_PD5 29
> -#define RK_PD6 30
> -#define RK_PD7 31
> -
> -#define RK_FUNC_GPIO 0
> -#define RK_FUNC_1 1
> -#define RK_FUNC_2 2
> -#define RK_FUNC_3 3
> -#define RK_FUNC_4 4
> -#define RK_FUNC_5 5
> -#define RK_FUNC_6 6
> -
> -#endif
> --
> 2.39.5
>=20
>=20
>=20

