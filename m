Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E2CCD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 17:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DED4A8063E;
	Fri, 12 Jun 2026 19:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D1sE4Ug5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12D2E839A8; Fri, 12 Jun 2026 19:52:23 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC5CA8056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 19:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c858b392697so591328a12.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781286739; cv=none;
 d=google.com; s=arc-20240605;
 b=NH1YuAkgDlALlCBVTTURqk3pGd4u+recWBJGsmz50dSUorHYJ10+KBWhINSd+91/BN
 opfclNnVAx15NzS+BPlT8V9F+91Yk4YDcpzEHn2OYSQUXVy3qBVDMzKvevP85Yh9eMqd
 eiBcnYLiWJW4uSXBixU/VcmebUDFTkUd6lK1vnMpMfv+o1CIAN9EpoM1rzATG5uFRfyd
 AzwFWxJ75InsKSybXgua/vHV9qn/mjgTi4IBtazAsW6E8+5oYe9m5GSKSl2LcTFPatob
 nuILypraGZ43gYstFzIyTNF0Dwx5J8ZBS84Q1/pw7fTcU3X0wxuoOpgklUsIBC5NNrsR
 ezJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4oHFFTekfr9h40QNwkvw2139tlqc6XQnr/7OsJcb3do=;
 fh=6tiiKQXR7OYUUVtNnCFLtPaegeMaJWKXydiwfZIkMKE=;
 b=WV6CXIF3VPjiQWG32cwOs/ipubcJmRKpxAkINDNHneuzk1WObFBsznY4HD22EVqDv5
 QTZmbK6Pgf98NtOhKhJ931KS0FyGnNH3UK3rDqcl3LCZxo2t0m1VNrySNsEAzOOsXgtZ
 +UGeLCMYP/z4ayGTBlrGiAFN/DhzTLxvrgv1INJrowXL4n2QkGsH4EHWQzIpUUoTCAB5
 ogljBevcscN1zuixZFsC3HnJ3osdcvpA/n2FHPQyemhQvfSqIn4TdF5sS62EonMgFXXG
 RNf0L1LluPejqRkCL8OumHl8+A8UdyAPFLqMlk2C6XS9lWH/TNkVutaqJBkvcKLvslK5
 fY/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781286739; x=1781891539; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oHFFTekfr9h40QNwkvw2139tlqc6XQnr/7OsJcb3do=;
 b=D1sE4Ug55udqQpNkGP1O84dDl+vE9NtBdeddRP5RtLLIY6+LGTEws1Rn1Zq1zIu9I4
 czDm2VIhnrLXo7cz3McOhO7jiahKhreIwuaQT/Md2xCpQsw25/hUaOU1kHMfZmXnpDys
 +/skAdeMXFyozy6fIGsV55sB6A6ZWsOvBYc1NGE5gU/oCRg+QHYS5pzqWLPhEabAStXs
 SGSoOIwzt4dC05L1BHtHmR9a7ebw8qeyU+O9ysu3OAUO2tgLfEMMt/aSK5aWuN9SyrGR
 mT0chKlH/Bk8RUdV7UuVY1dD5FQ+YHTQ6CXumMd4U37HizYG1QtI3Y7iKwRzLTfi3WEs
 qrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781286739; x=1781891539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4oHFFTekfr9h40QNwkvw2139tlqc6XQnr/7OsJcb3do=;
 b=Y3725CuJt2okXAsROl+v8KOT1tf66TUmgTER8p+U1DNeD/VW65kn6+WyYF4X/t4hB3
 SULtD+p5qvIksAyinSGpHH3cgodPPVGVrJHSZ/T86I6lk3MVtwDX9zahn5zxXxBy1tBo
 NrBLrXx43TDqbAcot/BRdT7OpltzWMTBykv7PoeyfMJwhujMl4lRQf/uYA8fIojw7ZSb
 3pim4sIbyth2HFF6MzOLUjuFFvSqiRyAqPwTViZoxlBlRBZIujydO2/QMhkrCyXf0hN3
 mE+4RAiUUDAtR3l5kshtW6bc8akMv5FB68e60SXDkVxvvMDhH1FxizACaC6H9fWfEHO6
 RQRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9z+6gvhYBiae9HZvl1T+sXiZxZ+auljIjSGjsbUHVI8nUdPj6dlvZeLF06eb9A4jYPCg9WzZ0=@lists.denx.de
X-Gm-Message-State: AOJu0YyXe1Z4P9Dy7ER47JGWtrYyhqJntezKIKy2hfdrlBbaWON1ghhT
 6Jya8+oPEviMO3K3Tgz+nh3ya/oZA2coqgdKNUGXL8s3H+YFm7GsHEUoVelu6CJJVmz9rEqZHeR
 4dv9YwYU/KI7TyjkyDFjzg+RPeqa+G9o=
X-Gm-Gg: Acq92OGU6zC/SsXhhFskMqZsUPGVmThiFvdi1rPOjlzkywA2KOcimhgjyuiGR3vZYO3
 lfuf7pqnPhV2zyVacxyEtmSPIpDQhc+kiaB/jgb1dSFYjNwo1HqaN0cmRLbPXMICP3hFV3ECE82
 L2k7Kh6nc/HAAydWAo4MmLEp5Tk5iK5l/v6u/jwOo8V9y4Kkdo2ga22wOQe87PuWgMOr4naKXIn
 XY8CqVowMF4VqaEcI9GPMetlkYO6LFyEIbCTru5llfSgr3H7jlZnLDNG7bsyAs+bsyV9Zb4J++W
 +ukFjOJRAmOaaRPstAHA7G5toFTHi2e7RfgwCQ0CdUqUGauAawM=
X-Received: by 2002:a05:6a21:1393:b0:3aa:c99b:aaf4 with SMTP id
 adf61e73a8af0-3b783ef4042mr5190853637.15.1781286739295; Fri, 12 Jun 2026
 10:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
 <20260611-mtk-fix-ram-size-v1-1-42ed330660ca@baylibre.com>
In-Reply-To: <20260611-mtk-fix-ram-size-v1-1-42ed330660ca@baylibre.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 12 Jun 2026 10:52:08 -0700
X-Gm-Features: AVVi8CfA34NVJwHTUzayBn4o-yViyCkYqnwP3eWwcR8llrv32WnoSAgfQeQNcYI
Message-ID: <CAH5Ym4i=fkGC_WvECVqzK=K-GL_fV8hyBH3qd30f02n9gnfq5A@mail.gmail.com>
Subject: Re: [PATCH 1/7] lmb: default LMB_LIMIT_DMA_BELOW_RAM_TOP for 64-bit
 Mediatek SoCs
To: David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
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

On Fri, Jun 12, 2026 at 10:32=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Add 64-bit Mediatek ARM SoCs to the default y setting of
> LMB_LIMIT_DMA_BELOW_RAM_TOP. These platforms have a 4GiB DMA limit, e.g.
> for the SD/MMC controller.

Hi David,

Is the 4GiB DMA limit due to the interconnect itself or are there
merely a few blocks that can't speak 64-bit? If the latter, I think
it'd be clearer to associate the setting with the culprit driver(s)
rather than the whole platform, so that it can be removed if/when
those drivers begin to use bounce buffers.

Marek: I fear that a lot of things are going to depend on this config
option being 'true' in the very near future, and with a lot of
still-unidentified drivers with bugs unveiled by this LMB change (e.g.
I spent much of last weekend chasing down a failure on RK3588 because
U-Boot's SDHCI-SDMA impl. assumes 32-bit addresses) would it be better
to make this setting default true for 2026.07 to buy us more time to
find those cases? I'm not very familiar with the rationale behind the
original change ("lmb: Reinstate access to memory above ram_top") but
it sounds like only some users need that access currently?

Best,
Sam

>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  lib/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index cf13ac1bdad..27ad43125e4 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1298,7 +1298,7 @@ config SPL_LMB_ARCH_MEM_MAP
>  config LMB_LIMIT_DMA_BELOW_RAM_TOP
>         bool
>         depends on LMB
> -       default y if ARCH_BCM283X
> +       default y if ARCH_BCM283X || (ARCH_MEDIATEK && ARM64)
>         help
>           Some architectures can not DMA above ram_top boundary,
>           which is after 4 GiB or 32-bit boundary too. Limit the
>
> --
> 2.43.0
>
>
