Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35E9CD37BB
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 14:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6E85864D4;
	Sat, 16 Sep 2023 16:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="kaHKu1Ny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7606C8652B; Sat, 16 Sep 2023 16:18:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E74864CD
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 16:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1694873885; x=1695478685; i=frank-w@public-files.de;
 bh=qXiAgOIygMcF/fz9MwVc+w1kyE4izEbzVcA1titQ1Ns=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kaHKu1NymWwqUsoWD0gxfUL7zqi4E7k/gftLLbTKPpG9ahlrqqIGGbun9V1kBH1Y49IGjzA/roN
 BoKNZLPak3O6ljJRrrftXQVxKMob2mWkyX/VCq9OLvzy8ENB7+zZUWZSMJZBWXj1zVTnw/xpRXE45
 UbQHc1avXMOOP2wbLdoCYmPHbowRv05cv3idhLta0x1bMY2dqieoOzbvHXp1rKKJnVXm7WU8a9Ghk
 mSLb1sePoJ733wpbrxFTj0a3MIoZYQ5A77/Jv0p0Tgf3/QLFb5CaTmV4x+/oNGLEw/8edEXqhsCJj
 cEw9nuVgS85Z5ckdrDs8sWKlwAs4yEwfEyjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.145.236] ([217.61.145.236]) by web-mail.gmx.net
 (3c-app-gmx-bs23.server.lan [172.19.170.75]) (via HTTP); Sat, 16 Sep 2023
 16:18:05 +0200
MIME-Version: 1.0
Message-ID: <trinity-6cf108b4-a879-40e2-a04a-54451262d671-1694873885042@3c-app-gmx-bs23>
From: Frank Wunderlich <frank-w@public-files.de>
To: Frank Wunderlich <linux@fw-web.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Marek
 Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>
Subject: Aw: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 Sep 2023 16:18:05 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20230820160004.44880-1-linux@fw-web.de>
References: <20230820160004.44880-1-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:lXOm7xy6F/CEtigv/9HHPLMWHHJh2xLbHZx2iCQUG0C6/kA+GJqLHVQXr8kIa9pwag/JH
 5jkA0DKV/sn/akJo3mC1taay26lx2iaoqf9k9bYEO3CJKpZAXvrsU6As5OCLMh1zamTYzQxB14Hb
 5LYH9BG98QFYgqM4zyaZ/i9y/9z2IPIM4iA/MNMyIj8jIFKxYUCTNxQjKv1XAPTq+3jAyJEq/vA+
 uBb7LwVwnlNaZqOcworOyvdyuKnUrOVQBr39ureb12tlyxMIHkYtmTzz/gE1WvoKQ1/fmalgbZYP
 xc=
UI-OutboundReport: notjunk:1;M01:P0:FHIKTOBs/ek=;zLP1PaHglwJ/Qx3+HH0SsZ6/rwa
 w46ZmKycoFwSshd4JcBPVUxJl5IYDBwDxNoQ1LN0nrUI02/YNZ77jDu9/3kSr+xIOWZL8BFpJ
 RZK8ITXh/76MO/H+Onl2NcDQPaNUHD+1+3tfKEhX6Lbr7LVRL3epsDrlijOZdDbvykcbDjVfy
 Dt0SJiaiLuYnYNGdv9KsJwZTppnwsV7BOmaiYqU2iBv23BEwbFT+horRDa65G6jvzSMSjOeEZ
 MEYhEUG8N5wk1D/H6XSrfA4ABEcowiirltVpZrJidG5vS/2MwOc6DcZBlwcKioAN+PO7TbT/o
 xp4qa+6t2L+11xOUqP/LTr5ilhKVnc8b6ar49BPRRHzC3CERatPNhqgBGouAP7J68flZUD5vQ
 0bhVy5CCUoNrJCeUIcRxVOFCvRLQWKksfn0Ck9Ipo1bo4OE4XoJbw/2LiF1bdxZxesapPscxm
 WbyMivsh2G9DZfwganeqvx9BB2Lxv+lC/2WTTVDfCRPHv6p5S+NSosLphbgY75m98D8hO64hV
 ba1j1PdcJIFKyrevB/pLU9cZ3HZ+66pOzbpdMJy9V1FQZCaBF8qclN8kPpHoMjK13YSvBU50s
 q1GcOqsVvn6gxOlqlH2ITujobqIIJxKWgb7oS5hEf7TmCkcHmwFRPtp8M26uMHeFrRfnIFLil
 OuNi2B7S59FK8B7nYHv+6xSdYj3AkQE/Qf4PU2m0LBsrXvggt0lsBOBg4JgVQdS1pIjsrmnU4
 uqdmp6We48j1vYOXpO06mINAqhXuY+LJbfr4XyUZ+BU9Dk2ITjhdcwPx2EX5Jb7wwzUMJURNM
 FLbzaakQ0x92QtIAEBjmpwRA==
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

Hi,

just a friedly reminder. would be great if it can be merged in next uboot-=
version.

regards Frank


> Gesendet: Sonntag, 20. August 2023 um 18:00 Uhr
> Von: "Frank Wunderlich" <linux@fw-web.de>
> An: u-boot@lists.denx.de
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@chr=
omium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Kever Yang" <ke=
ver.yang@rock-chips.com>, "Marek Vasut" <marex@denx.de>, "Jonas Karlman" <=
jonas@kwiboo.se>
> Betreff: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Add Bananapi R2 Pro board.
>
> Till now evb dts could be used, but iodomain is different
> (evb has 1v8 on vccio2 and vccio4 which are 3v3 on r2pro)
> and with iodomain driver this can cause hardware fault.
>
> Devicetree in mainline-Linux:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:
> - disable gmac0 as switch-driver is not yet ready to attach to the mac
> v2:
> - drop switch-node for now as u-boot driver works differently to linux
> ---
>  arch/arm/dts/Makefile                     |   3 +-
>  arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi |  23 +
>  arch/arm/dts/rk3568-bpi-r2pro.dts         | 549 ++++++++++++++++++++++
>  configs/bpi-r2pro-rk3568_defconfig        | 101 ++++
>  4 files changed, 675 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro.dts
>  create mode 100644 configs/bpi-r2pro-rk3568_defconfig

