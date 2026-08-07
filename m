Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F36DC5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 11:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D3B481149;
	Fri,  7 Aug 2026 11:39:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cApkin_BBKV8; Fri,  7 Aug 2026 11:39:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A004F80FB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786102787;
	bh=iKZwOYbTPoH0Z1Nep7EIFP5CFRoyAd0B3wWcpl9aZ8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qeLXurb+H6+OBy5n7twTQ+ySHMIvY6X+yuVRYaX5RgF9smO32u8JYzx0978Fx+HtW
	 o1vlMPbas/W96wLPjiPU5V55O2WY2nDyvsI8sZyFvPF/++xm0fEszYEaB3XLFbQju5
	 6T2u3a8wCJQDy/oF+78KBVB6D9OW4G9JWjFFZeTIlXTZhZagjn5z9uWJAuX2C6sgWZ
	 2KEwQg5LR/RmVRoh5wQWPfhYJ4wBMqyz47mDKtzVTbSi6L9lReB4ZCNZWS2AAcsyzk
	 lvHbTqhxFk3stQvxN4n4edBDQ57QbM4TeWfwMvI2gJNyCvBVVVT1Wqv1VfI3pz0wUV
	 taZGNYyogsNhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A004F80FB4;
	Fri,  7 Aug 2026 11:39:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E1EAD10E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D644E6070D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:39:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3sYdxrA_BLxY for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:39:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 30088606E3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30088606E3
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30088606E3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:39:44 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c20755e8295so184688066b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786102783; cv=none;
 d=google.com; s=arc-20260327;
 b=gdfukBdhrTpfA4lMM11NCEL0UTyH/hK1KgWqMUfAwtxt4hJn2fOdBVeYhKQoGAihCe
 S9cTNpGXFcvhry0nyaPXar2WHhbe7jLMb8vE+zwKGsyn4Uh/D9m6vcg+yvmSZKz3JUCz
 KM16Q10RPbVP51SkyJvIUpx0nn9TGVOrfRRRmTEwLvksFVmEfD7m7BLSV9adEFlmPQJ9
 EstV41G43+6nG8SsfNnkGWQwlcbFUN/BzBUg5eh/QAK9XJb8bSdeYciUuFLBYOdxYYLX
 g2ltNpMEkW+nPKMrzuObIWMlAEFXAdSf6U/m46DHsmG3vindar1HahiygzrS8tf1qSPK
 mWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iKZwOYbTPoH0Z1Nep7EIFP5CFRoyAd0B3wWcpl9aZ8s=;
 fh=xQdwH8D3++TncLOLxAxuRFcRtIbbYrHscd4mEEUUBrs=;
 b=gta/pDELJD0DpEYLa6n5YXa78vyxKBOpRwPyl6VVcYOBaOXDleccqix1iXb5hkGVuM
 ZIM8LuXZLg7BWblnZLvjPaQa5W/vIawAsqeGXWh2jrhGqKMHIMQRJP2X6HWKgFdveeqR
 EPTXEv+9/SRiDD8VIttwU3KpkVkZcqereryQqUCFmxbPFacJTKh3Kapyr5IcU/NdDhxi
 UQDYomBTneKVVwo7k7vu/+xwM29BW0J+Y41lSLikrf97mNhFz/s5vuH3huBZQSfK55D7
 7QlmKv/W7dkmiyO75zKdv/UOOmDLxd2ZzTZxkbEdrf9mJBNcNx4tZGrcPr9BwtbbR3s4
 HSug==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102783; x=1786707583;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iKZwOYbTPoH0Z1Nep7EIFP5CFRoyAd0B3wWcpl9aZ8s=;
 b=QTQrEb3Zw+I+ml9eAXxLDcDLGgCcJnDcr2x6pCCq+LjhuOFAWqQCRvVA4ZNTvL8Ima
 oTtwunDaFmkE2ggxRaBzuJElbdp4ntpQl79uQ3IjcOHHXypHmyuqhX8IsGB/TKRHpFbo
 ZY8YMq3ATADBTtqAhDkn9cn5zYSvvp/qmqLFlCn4ddiwd7Dblip2LH13WONChg6QIiuL
 jVCWSVEH4P9UXXrUCZkNwYJkzX2R3fIrmGbO6rhet9V3dWEcNgxXskfrMjvstJApsb2u
 TKDWF1X13BykMLPt0dedFaHldHDJJnVObYlWa7d9n6Koif3XJTivOKl0jx0Ifzj0DT10
 DBLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrp+bv6YyyuY0cayhVzKy2SQSNwMa0/qOaBsb/WAK59bpWAziqEK0xuQUn6+q490K5jk0bTwm4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxzTn7ZXctflq+0BDKwSHXEWF9oc0C29NdjkkJZmMjq7I73yrtY
 uy8/izoj4qkew9AwalpbMdIOxqxaIEwMuOD1yBTaHEAY14vjy1tuUl3p5Yp0GljjuRzYlrJ3QJU
 J914df7t0WNkZYX9oEZfhd5ozIcsKP5KIC11m0qd4yg==
X-Gm-Gg: AR+sD11/CsswoQW8xUCHgdGfh0H57H6gWGKl2rog/IhXH04/qWafuhSyE+728MiN8+u
 wVytDN3dZ+T/OCjckX87IUmDd9/TjogiSRkTLJ6M3glg7OqW9Ot1OZGK8V2Y3B/teGkOkJZzEuP
 U4UUr4ODE8o4DIroRgObLENYcTVvMHPsI9uAD4YOCD4nzXNzl4f6YQHYadyEc5QxqCEEoE7MJbY
 aZGJbhUUAZhFFk8eorOwRxKiHcY6VXz46c6+HY8KKMngTCVz2cg4sAlt/TN2W/J4R2X+7QkDCAP
 UURNTvL/6Hsd9UUWQyeVfbUddpwgjUWBrWSJrVQUHu1clIce72Yq961N4iy7lR6HqysvexTlj4S
 L2iD+UyV6BZUeC4EQIIUhXH0ayPNiiojMLWkakN7UxaiCYezN4DbWCRh8PYQhxoY=
X-Received: by 2002:a17:907:7a8e:b0:c20:51e9:7dc0 with SMTP id
 a640c23a62f3a-c206358ac7fmr647248766b.9.1786102782386; Fri, 07 Aug 2026
 04:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
 <20260803-mtk-pinctrl-kconfig-cleanup-v1-3-fef1ff69d1cc@baylibre.com>
In-Reply-To: <20260803-mtk-pinctrl-kconfig-cleanup-v1-3-fef1ff69d1cc@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 13:39:31 +0200
X-Gm-Features: AUfX_mzsf1WMzDDfEjQEbm_CruLp56toxxZDGfautBs8wTxYKGjnXdeYkmOMKCs
Message-ID: <CAEHHSvZrS9B2xw7tf9+rB9dnge5RyPc0=YQCtOan9_+x5J0uMw@mail.gmail.com>
Subject: Re: [PATCH 3/4] pinctrl: mediatek: simplify Kconfig
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Sam Shih <sam.shih@mediatek.com>, David Woodhouse <dwmw2@infradead.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, Mingming lee <mingming.lee@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>, u-boot@lists.u-boot-project.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786102783; x=1786707583;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iKZwOYbTPoH0Z1Nep7EIFP5CFRoyAd0B3wWcpl9aZ8s=;
 b=TYDVkgnoklBtsiNIk+vhnV0RUeenqnneos9WWgxiOjp7KTx+PWJ65b0r36ehX6CWLW
 sOirz4ShbVjV3ZrYblrefTEI7VjePpA4edWPsNo6NCLhNTR3dzpsZtTZrpuJqoAB9Dmg
 nrdZq2m23/yU+uECUnCmKuaIpo9qT1IoBgWiFikr8SxFvvAA7RtQ3+ag5AeV0BQrhjXJ
 VTPhzENczUkv8/qt5ru/Jqy/h1OB3li+y4ldKy2qI5ZK4gd9zHY+VDqsNZgBFGNCHmPT
 jidA3YIAHTPdFYzgsqBqfsVU8vNz4tcocEbx0qGc9kufkLiLm1Ej/eOXR6YlVXAxyDpH
 FhpA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TYDVkgno
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le lun. 3 ao=C3=BBt 2026 =C3=A0 22:57, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> Change the MediaTek pinctrl Kconfig to just have a single option for
> all targets. This will simplify adding new targets and SPL support in
> the future.
>
> There is only one MediaTek target that does not have a pinctrl driver.
> All other targets enable it by default so the configs don't have to
> explicitly set it in addition to just enabling PINCTRL.
>
> In the Makefile, we can use the target config symbol to automatically
> select the correct driver. And the config selector on the common file
> was redundant since we already have the same in the parent Makefile,
> so it is dropped.
>
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> Closes: https://lore.kernel.org/u-boot/fba47ca8-7cf7-446a-9242-54c50087cf=
3c@cherry.de/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig  | 61 +++------------------------------=
------
>  drivers/pinctrl/mediatek/Makefile | 30 +++++++++----------
>  2 files changed, 19 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/=
Kconfig
> index 42c7c8b8c80..46e35cbfe6c 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -1,66 +1,13 @@
>  if ARCH_MEDIATEK
>
>  config PINCTRL_MTK
> +       bool "MediaTek pinctrl driver"
>         depends on PINCTRL_GENERIC
> +       default y if !TARGET_MT8183
>         select PINCONF
>         select REGMAP
>         select SYSCON
> -       bool
> -
> -config PINCTRL_MT7622
> -       bool "MT7622 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT7623
> -       bool "MT7623 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT7629
> -       bool "MT7629 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT7981
> -       bool "MT7981 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT7986
> -       bool "MT7986 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT7987
> -       bool "MT7987 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT7988
> -       bool "MT7988 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT8188
> -       bool "MT8188 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT8195
> -       bool "MT8195 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT8189
> -       bool "MT8189 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT8365
> -       bool "MT8365 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT8512
> -       bool "MT8512 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT8516
> -       bool "MT8516 SoC pinctrl driver"
> -       select PINCTRL_MTK
> -
> -config PINCTRL_MT8518
> -       bool "MT8518 SoC pinctrl driver"
> -       select PINCTRL_MTK
> +       help
> +         Enable MediaTek pinctrl support.
>
>  endif
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek=
/Makefile
> index f90c74314f4..983de040ba3 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -1,19 +1,19 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Core
> -obj-$(CONFIG_PINCTRL_MTK) +=3D pinctrl-mtk-common.o
> +obj-y +=3D pinctrl-mtk-common.o
>
>  # SoC Drivers
> -obj-$(CONFIG_PINCTRL_MT7622) +=3D pinctrl-mt7622.o
> -obj-$(CONFIG_PINCTRL_MT7623) +=3D pinctrl-mt7623.o
> -obj-$(CONFIG_PINCTRL_MT7629) +=3D pinctrl-mt7629.o
> -obj-$(CONFIG_PINCTRL_MT7981) +=3D pinctrl-mt7981.o
> -obj-$(CONFIG_PINCTRL_MT7986) +=3D pinctrl-mt7986.o
> -obj-$(CONFIG_PINCTRL_MT7987) +=3D pinctrl-mt7987.o
> -obj-$(CONFIG_PINCTRL_MT7988) +=3D pinctrl-mt7988.o
> -obj-$(CONFIG_PINCTRL_MT8188) +=3D pinctrl-mt8188.o
> -obj-$(CONFIG_PINCTRL_MT8195) +=3D pinctrl-mt8195.o
> -obj-$(CONFIG_PINCTRL_MT8189) +=3D pinctrl-mt8189.o
> -obj-$(CONFIG_PINCTRL_MT8365) +=3D pinctrl-mt8365.o
> -obj-$(CONFIG_PINCTRL_MT8512) +=3D pinctrl-mt8512.o
> -obj-$(CONFIG_PINCTRL_MT8516) +=3D pinctrl-mt8516.o
> -obj-$(CONFIG_PINCTRL_MT8518) +=3D pinctrl-mt8518.o
> +obj-$(CONFIG_TARGET_MT7622) +=3D pinctrl-mt7622.o
> +obj-$(CONFIG_TARGET_MT7623) +=3D pinctrl-mt7623.o
> +obj-$(CONFIG_TARGET_MT7629) +=3D pinctrl-mt7629.o
> +obj-$(CONFIG_TARGET_MT7981) +=3D pinctrl-mt7981.o
> +obj-$(CONFIG_TARGET_MT7986) +=3D pinctrl-mt7986.o
> +obj-$(CONFIG_TARGET_MT7987) +=3D pinctrl-mt7987.o
> +obj-$(CONFIG_TARGET_MT7988) +=3D pinctrl-mt7988.o
> +obj-$(CONFIG_TARGET_MT8188) +=3D pinctrl-mt8188.o
> +obj-$(CONFIG_TARGET_MT8195) +=3D pinctrl-mt8195.o
> +obj-$(CONFIG_TARGET_MT8189) +=3D pinctrl-mt8189.o

I know ordering was already broken, but maybe you can fix it as part
of this series

> +obj-$(CONFIG_TARGET_MT8365) +=3D pinctrl-mt8365.o
> +obj-$(CONFIG_TARGET_MT8512) +=3D pinctrl-mt8512.o
> +obj-$(CONFIG_TARGET_MT8516) +=3D pinctrl-mt8516.o
> +obj-$(CONFIG_TARGET_MT8518) +=3D pinctrl-mt8518.o
>
> --
> 2.43.0
>
