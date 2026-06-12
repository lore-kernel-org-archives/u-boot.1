Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2B6CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 22:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29E4583FEC;
	Sat, 13 Jun 2026 00:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6llLfsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B9908466E; Sat, 13 Jun 2026 00:35:12 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363B88005D
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 00:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8589498839so626703a12.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 15:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781303708; cv=none;
 d=google.com; s=arc-20240605;
 b=aNLE6risq+cBMLeQ3+P7CByuBcpV4DapxLqezJAp06lEsOlV4jbrgSjuGp5dIEYkYO
 /fYq2op2jBurKEeptr0Zc5okOqxVsuV0PSFbyscOY2p+AJtFyBdsl7Tm0NV/5+7hSbHg
 KE7gGH3+MJ7GtEAmT0IOWpkWrUxZUUS/U8zYDirhRuBiS+JvaF3Y7NhbSEouLNGcqHGi
 /26+FN/I4AXsYZRSZONndZ3LXcwh1DzNKRamgQrpGwgzXnAPeQOBkswBTUoSgPVwWyWV
 2/93TEDmUNRR9yAJRKhkoNxLttKALHaM6et64+XBfuclnzd7h5iqf0uFBcdVHlR3XNIC
 7hIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GPMnLskaY+Or69P+W0cHIIvsiOqYnbtwte9ygM7Bjj4=;
 fh=a4HxlRj/YSLi3NMVxFwehkOAPLPmGo2gw4qYndOIW18=;
 b=RCl+GoYzzIvfAV+n/SWL5V0AzHt3vXNaHu4a6yKHXdQiB5OPHybbMixZAXchV4D16q
 zWGYGoib6skr3tAXbuSbw9xd0qM6wpE4XXpQb0oAZwPPr9yQXvXtNxZZq2Da6Va7nRPi
 MZSrvwfqNcirk03vOa5C/Tm3wKqdmfCGCxuKSnsyUU8tw4en0Woy1lIvshuxWGFKFwle
 vym1k9mnrkv/XJF7TyPGxrqztQNVGmhzawoKT9NUpEcVj/K4ptIrajLYZ06dUtfmtQgS
 OmQcU8e6Sr+4cBEq1nkPFmVezbMaC4PZHyXIuXWfCEoHTJJVVmJFtPnDlcQSw6JoxGEJ
 S9Jg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781303708; x=1781908508; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPMnLskaY+Or69P+W0cHIIvsiOqYnbtwte9ygM7Bjj4=;
 b=V6llLfsUxI2BHwDVR3l7IEAnLihXbgobb5GQPF6bVulukV0jK1hi6FwY6W8F3KO4EH
 Dae8icl3CjkJPhsJ5Q8viDFU8KH++NX/uHcLRINSHhkvr6mzb11LMSxzqd+8XKz5zQDO
 KXKIyivmlb7ilRLc/Azq7o6IxzsuC8l7ZzoET9PMWJKFeKh4zSuORiBha2eVfLQUqjBY
 Bt4FOu4GHBhc+a4q1qt1OGR9SfXFrX8rQ8GVempqAhOM6M0wheU0bQonIXG22caVMxv2
 0h3//cNDFuOTdRrIz9sDaKDu2A09zT6KnCeVABMd1+SdM0QE7Tbaj5yhIlj5aHzb/r8U
 bFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781303708; x=1781908508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GPMnLskaY+Or69P+W0cHIIvsiOqYnbtwte9ygM7Bjj4=;
 b=GDxOinPUNi9ysO3ftaCiWMfet7lvGh1uLIxP3nluME3fkGIt6JTYDIG/gaWE2r5ROR
 IP0ThC9Djbr+XS9w8AeWVBD7Ja8q7j+nxkKxMJlceXHrnc1flWyFAP5RPMqYWv9kKtqA
 e6DmYePa2/aC0JH2ZbZ0tVMxkg/YHuvYkC+imgYy3m0t/QTpIpatbt2jBp+d7OWMYDXh
 +LMM8COtFW0Fij5bCK8luT+IesdKl7zRN4P5pFVty5b1iVmoCcM7v1pYDUMwKqccLIi5
 vsz6UvHPW5KBg1eCkz5H9J3QOmWr5R2fjBd3OG/vheYjxgIkOVy8NJzM9nDzt+wb+zyV
 H29w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QABGf/qhyhST9YSJX0JEInccbfDWjIu225TlOdT3JsJBWnbHfNlcrFlpEfrHBmNfH3tBmlpU=@lists.denx.de
X-Gm-Message-State: AOJu0YyMOiyB3NQL783W3YK1hsgJqqDv3EhabeQd0kwrEAu0vddRBN1Y
 /vfbAAonsS8knhL+0RxrjQxHKy9SHWdK0YxW5qABQmHiAJzONwP9vkx3+2/phfSU3n7BUjAYe5p
 zH137iHKRMyE0YNMWVsY5BlMA/Fd/RuQ=
X-Gm-Gg: Acq92OG/21JM/9A4Rksoa8I+T8LYiEPacVp7BxrTGw2vPxd7Acd454eIklDaXSLA9vp
 uicjNEV2QnAKRUqBhbaeK5vBnkAnLtseQVq6GHIljbiVDHHrO1WP/yYFkzl3AlyFtIQKtx/FbGQ
 O4xSn5d5DhENyJPWTpMbjjvvgeb+p8vX3MU8PRhssx35LkL8CHqfiC/claRKxl5Dr9OnPXWCnhi
 ejW/Oc83kE4wyzGVS3moh2oR3uLj0E6bTc3ZXJJG80foRhK0cocGVnj+30S2CiLahgfKw916hwB
 D94p1kbH77DfAmh0E9+REEvshZjFb+XK7/gJkOvKeyAxRO+cOD0=
X-Received: by 2002:a05:6a20:d046:b0:3b4:b276:3650 with SMTP id
 adf61e73a8af0-3b79637bbf3mr1539688637.26.1781303708556; Fri, 12 Jun 2026
 15:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
 <20260611-mtk-fix-ram-size-v1-1-42ed330660ca@baylibre.com>
 <CAH5Ym4i=fkGC_WvECVqzK=K-GL_fV8hyBH3qd30f02n9gnfq5A@mail.gmail.com>
 <249e2ffb-2ad1-4dd4-8d24-dce8053244e2@baylibre.com>
 <0d9f31df-34a4-4454-9eb5-7fe82fbc5482@baylibre.com>
In-Reply-To: <0d9f31df-34a4-4454-9eb5-7fe82fbc5482@baylibre.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 12 Jun 2026 15:34:57 -0700
X-Gm-Features: AVVi8Ce0GT3exsY3IB8jqu6G_3SUWGM1OG7dD_Hx2f9LpC90t_x4LT1YGX-N0Hg
Message-ID: <CAH5Ym4hrmZPkoEXkwa4Zzp+AguPDib_q7UgTSLzWnc64Uc+piA@mail.gmail.com>
Subject: Re: [PATCH 1/7] lmb: default LMB_LIMIT_DMA_BELOW_RAM_TOP for 64-bit
 Mediatek SoCs
To: David Lechner <dlechner@baylibre.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jun 12, 2026 at 3:13=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 6/12/26 4:30 PM, David Lechner wrote:
> > On 6/12/26 12:52 PM, Sam Edwards wrote:
> >> On Fri, Jun 12, 2026 at 10:32=E2=80=AFAM David Lechner <dlechner@bayli=
bre.com> wrote:
> >>>
> >>> Add 64-bit Mediatek ARM SoCs to the default y setting of
> >>> LMB_LIMIT_DMA_BELOW_RAM_TOP. These platforms have a 4GiB DMA limit, e=
.g.
> >>> for the SD/MMC controller.
> >>
> >> Hi David,
> >>
> >> Is the 4GiB DMA limit due to the interconnect itself or are there
> >> merely a few blocks that can't speak 64-bit? If the latter, I think
> >> it'd be clearer to associate the setting with the culprit driver(s)
> >> rather than the whole platform, so that it can be removed if/when
> >> those drivers begin to use bounce buffers.
> >>
> > For MediaTek, I think it is mostly specific IP blocks (e.g. MMC in the
> > mt8xxx targets in and NETSYS in mt79xx targets covered by this series a=
re
> > the ones I am aware of).
> >
> > Weijie Gao, maybe you have more information about this?
> >
> >
>
> Sam,
>
> Just to make sure I understood you correctly, your suggestion is to
> do this instead?

Yep -- to me, that says "this driver currently has broken 64-bit DMA"
rather than "this platform can't ever tolerate 64-bit allocations."

> ---
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 24bd16ad5f3..e2c5a54f925 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -858,6 +858,7 @@ config MMC_MTK
>         bool "MediaTek SD/MMC Card Interface support"
>         depends on ARCH_MEDIATEK || ARCH_MTMIPS || ARCH_AIROHA
>         depends on OF_CONTROL
> +       select LMB_LIMIT_DMA_BELOW_RAM_TOP
>         help
>           This selects the MediaTek(R) Secure digital and Multimedia card=
 Interface.
>           If you have a machine with a integrated SD/MMC card reader, say=
 Y here.
> diff --git a/drivers/net/mtk_eth/Kconfig b/drivers/net/mtk_eth/Kconfig
> index 5d4e54ab90e..7d58f542bde 100644
> --- a/drivers/net/mtk_eth/Kconfig
> +++ b/drivers/net/mtk_eth/Kconfig
> @@ -5,6 +5,7 @@ config MEDIATEK_ETH
>         select PHYLIB
>         select DM_GPIO
>         select DM_RESET
> +       select LMB_LIMIT_DMA_BELOW_RAM_TOP
>         help
>           This Driver support MediaTek Ethernet GMAC
>           Say Y to enable support for the MediaTek Ethernet GMAC.
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 27ad43125e4..cf13ac1bdad 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1298,7 +1298,7 @@ config SPL_LMB_ARCH_MEM_MAP
>  config LMB_LIMIT_DMA_BELOW_RAM_TOP
>         bool
>         depends on LMB
> -       default y if ARCH_BCM283X || (ARCH_MEDIATEK && ARM64)
> +       default y if ARCH_BCM283X
>         help
>           Some architectures can not DMA above ram_top boundary,
>           which is after 4 GiB or 32-bit boundary too. Limit the
>
