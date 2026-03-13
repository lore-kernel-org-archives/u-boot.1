Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C993105F799
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB35184246;
	Fri, 13 Mar 2026 11:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="crTyyQxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E9484253; Fri, 13 Mar 2026 11:56:20 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77B8A84221
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-663a60768f2so612365a12.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 03:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773399378; cv=none;
 d=google.com; s=arc-20240605;
 b=e/lUWaQ/aHwt+09lPjNSWpU/Nn8N2VyW+HBkdS4hkGXXPdqtQ5CQDAdcciCTZafYge
 XWBsbIawcDz3yNeTdQJehl5HajBehffnc1CGQ9f3hRumMWdS+LE3uRud62tmZxfPkT7M
 z84EjRuQWCiPxibJ4FDE2ae9EE78vqQJQb7/PDnDt5bZJWniGBhaElpuslGHRYTbMe6B
 vA82ceTtNth2uBU+blRFyP3ei743Is2oSucrKNZJFJIS3Z7Gx1O5H3S0tUR116d1uyEv
 ezjD4xMsjyA/ypcWiOf0Njqwph5lG5jEnMj/F6cfcobO/WNxWPUHJnFfyH8EVwc7CSvR
 ic2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8SEMFrw38pu2rqYRKlt3SnTHTYrBkGe3rIm9DUTe58E=;
 fh=u132hPZI/lbeuwWUcpkPff/0gH8Hgmn5HMmgRjrSwVA=;
 b=T0HgU7hotvmxVE03vYOUQJ4j0qyfYN13e8P1Nuw3sYVtaarcicWShstdZ+DhQ+czVT
 aGaEb1w4udAOnQXQF87n5ge4pNN/ku2cup4mIsDsUcEqhQXsyoMuNOCbNHxy4sQnMNsB
 gCiWrO5rDZ/5nnmzgib/hTcecYay5WAvtIuYkh0tm1jEFD2PA4W0UIPRofQgZoVrAvBu
 OLQdF9rjRvrE5lk3xOYdYOfaUujOcXq7uN08hnQ3VH6tSbnx8OvtblStvuAPaFZaaT2f
 enJkWZo5DCKLRoutpDOznwkKpULaJC0ZtT1SMphWiS3ACT0+J+M0hWDLy85EaTfETdCb
 GP0g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773399378; x=1774004178;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SEMFrw38pu2rqYRKlt3SnTHTYrBkGe3rIm9DUTe58E=;
 b=crTyyQxSIpVxZ0rh1cvgHuHPLrcUuRlFkpR/OSFhCUuGwnPkBE6cgcehZiIy4w2RRj
 bpzVUsvDqZxhpYxdB7rOAYtQJcMpYx4aiyO1Sm/IA6x1sHyeITb/rx3BUJDNt/fs4xud
 wc8mWO8qcDs90Vn5fagK+gfVACD5m1f1yoQ8NlTia5fA2PYfXwLB6MiiEhCIAK385/iy
 coNrPl2UWBbFJgz3CW4TNoz1BZtDP6ARlkL6sQJ1M0qBabE3xfjtIwSNEtM8i7I5/UtB
 5JSWcFja2Ypht6STmwELyGG2wtCIZDQH6icGVpLs/b7wA6vwb9ImyfxS6fmS1CTFKDz/
 mwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773399378; x=1774004178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8SEMFrw38pu2rqYRKlt3SnTHTYrBkGe3rIm9DUTe58E=;
 b=bYPBCtVM08RS3RAeLgoNutgvicxU3xQ+DOlsNV3hiNUaaAQEOgCbcj/oxOMq0XK3Rj
 Ga6+vDB/STWSH4Ygz0f1s7FTx6Kg3WQWfc8GXPEv6bxss1p0WT+Bf/qySXljbKEtatxH
 dWygAPh218/asKi5B9Dm6fr7HGuVPXFTR4DfjwjDtXxmbrVPuJMrWdSxLahEpCElSFWk
 pw6Ap9nMh6h3beUKtuJ50F43LUym+b+aUFin0N6LLh0ZjifNOWu4G0G+YLktQ8zhxsMx
 8ZQJQG14bt4ComdpnxF7+kh/nDMkuSPzAPXC3zxU3vwb8c9oAq1gValF+x6pJFnBNTvJ
 Z+zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeiE/X8LbAzyjjugmH35t/W+g2FM/th7xI6aqImLfSZqy0lQQ2aFzFyF479z+TX5yEE9ecklA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6eWHrL+SX+eqKLCBlQe6FX0zfmlnaije12XkdymEWCDnxBvcA
 M4OHploil+fQo/dD1hP3vg+wTgdZmmakewzkjnSnKWuq9DLrZP83u2Lb5684Bv4pgDwLZnGgoDe
 RRWVjM6v27jKBL0UolVHV+SjZPF7Bg+iuVAORB1spXA==
X-Gm-Gg: ATEYQzyb7WUhRQR7AzGJSOz+WDYE/yWPnxdClWUX/cFd0udmDengZUoB0ToMHu+DNnq
 zSq95XH2IZj3CmuDful5P0oR32B7nHG8RHnKsKcJxFI6FWrVFdJA4f5L6QpAKoOJA/Km1YM+KKF
 2hY4+tQwOKmr1uDv+0fwF0Q1FPQyh0d+TMEsBR6rWpEp5zKmppMN9ZXIx3RycG49/cAkKFEduvw
 ruCbCy73iiLzO5Xp7yl798P8MtV4jN/ewoef0H0ESDaeliok0HTwSH67bdgjBsxJm+6E/GAVcX/
 IEMDCxHhCpaGFWR3zmA6Y76DyTG4d4PxN4yXI2Y/k7ufEReydKjciycelHy8beHgr6NWqA0BmgU
 IaIu7Nv2rGhYxamNl/NNVcxIzIg==
X-Received: by 2002:a17:906:fe06:b0:b93:9407:ea5c with SMTP id
 a640c23a62f3a-b976540ef14mr171218866b.57.1773399377770; Fri, 13 Mar 2026
 03:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260305-clk-mtk-fix-mt8188-rates-v2-1-0ce2b5212775@baylibre.com>
In-Reply-To: <20260305-clk-mtk-fix-mt8188-rates-v2-1-0ce2b5212775@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 11:56:10 +0100
X-Gm-Features: AaiRm53ZOst9cCn0PcifA_Lav1uDCetJV4KNpC8GQvjd9CUi5z7E8YmaaL8s9zE
Message-ID: <CAEHHSvawvk+UL+DY5gOa62brbaOnfGU4EnohAQM1gBSwC9VE8w@mail.gmail.com>
Subject: Re: [PATCH v2] clk: mediatek: mt8188: fix CLK_TOP_CLK{13,26}M rates
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
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

Le ven. 6 mars 2026 =C3=A0 01:45, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Change CLK_TOP_CLK13M rate from 130_000_000 to 13_000_000 and
> CLK_TOP_CLK26M rate from 260_000_000 to 26_000_000. As the names
> suggest, these clocks are 13/26 MHz, not 130/260 MHz.
>
> Fixes: 5e9bbbdab003 ("clk: mediatek: mt8188: add missing fixed clock")
> Fixes: 11f3cc46322a ("clk: mediatek: add MT8188 clock driver")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> In v1 I said that this should go into master, but I found that there
> were other fixes that went into next already instead of master. Applying
> the v1 patch would cause a merge conflict because of this. So I've
> changed the patch to apply to next to avoid merge conflict. This driver
> and the board that depends on it isn't really usable in master anyway
> so I think this should be OK to not fix it in master.
>
> And I found that next had the same bug on CLK13M, so I've updated the
> patch to fix both.
> ---
> Changes in v2:
> - Added fix for CLK_TOP_CLK13M as well.
> - Link to v1: https://lore.kernel.org/r/20260304-clk-mtk-fix-mt8188-rates=
-v1-1-c71fb26179b3@baylibre.com
> ---
>  drivers/clk/mediatek/clk-mt8188.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk=
-mt8188.c
> index b720eec8ba7..803330717c6 100644
> --- a/drivers/clk/mediatek/clk-mt8188.c
> +++ b/drivers/clk/mediatek/clk-mt8188.c
> @@ -97,8 +97,8 @@ static const struct mtk_fixed_clk top_fixed_clks[] =3D =
{
>         FIXED_CLK0(CLK_TOP_466M_FMEM, 533000000),
>         FIXED_CLK0(CLK_TOP_PEXTP_PIPE, 250000000),
>         FIXED_CLK0(CLK_TOP_DSI_PHY, 500000000),
> -       FIXED_CLK0(CLK_TOP_CLK13M, 130000000),
> -       FIXED_CLK0(CLK_TOP_CLK26M, 260000000),
> +       FIXED_CLK0(CLK_TOP_CLK13M, 13000000),
> +       FIXED_CLK0(CLK_TOP_CLK26M, 26000000),
>         FIXED_CLK0(CLK_TOP_CLK32K, 32000),
>  };
>
>
> ---
> base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
> change-id: 20260304-clk-mtk-fix-mt8188-rates-9c733a841d56
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Tested on genio-510-evk

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Tested-by: Julien Stephan <jstephan@baylibre.com>

Thanks
Julien
