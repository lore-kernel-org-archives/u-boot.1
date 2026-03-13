Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA26105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C640E842FC;
	Fri, 13 Mar 2026 15:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mFcotUGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2AC8432A; Fri, 13 Mar 2026 15:49:40 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CB68423C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b942a41c5fcso310410166b.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 07:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773413377; cv=none;
 d=google.com; s=arc-20240605;
 b=LUXHUl9leOaAJnPcM9eHxiHRUjiex0y6f0TSm4tWYk0+Wf6pSRX5aFxuUzd0W2GlCn
 nmSQEqku2XaOOWDn190D8dMzdPySOOOweOhlY4ZACc+EjXBkk8hQMEeJGv3C6q/lXnLF
 2hzb8ZS1nUPAJlLrwgNDMoQFHPSHBiCdV8gMYfijz3LPyY60aCT6/9CkJ0NAO5KiUiuc
 sVaVEtze7QStVGQdiyQvUJosgNy3ewYPv3xD8zzlHmRwmXTfEdQZob/dcG8j9RXeCe/r
 nq/O7A/0SnDGNv18qwO0T1dkNT/4oFWz6rHtKbRdyZHvRd2Imc5g6C/6tuDcJCTdvMq4
 T+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2PHxFmj6RIQIbtL5xuSbjK7u6DMDUXk5OIDhyBrxMVc=;
 fh=MHjHes+HI6yBoiCpLaiBkc/d0R+yhVJXlXc2ZXXf2sk=;
 b=cAhAwrwn0x6bLV6o3Bdz9LulvaM4cEXAfCB1iPfMvqluegQbqYveNzFjz0oExq6pcy
 Cg8yDpxMisDeqb91xJNWC33hNnnxA0UbhZqNgI+k9j1qCDcVoLDovq0Tu94LL6d3CP+L
 mMxnAR80P7pMxL0OgZW7zTt8llmmN6JGEOx48fCcny+6B+wl46AtQPUmF73tQUAfQXz5
 5A4I4x5RSiLDumsi9JXHpyj+eh5U0dyM0Ccg6GrD3hevh8z+xSjsMP0d9NwxvVKFF6c3
 TJ+qYC81rw0pAs6kxwMN8ZsYdqdA0onFLX50PkHmi24wtwIoSB9DYSC7c7yt2KXEhC2T
 7hvg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773413377; x=1774018177;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PHxFmj6RIQIbtL5xuSbjK7u6DMDUXk5OIDhyBrxMVc=;
 b=mFcotUGoxfPR5LmkXdy3s0JRHQhwdUSYvMu/EOsHdntft1elAxuowETiUG0jsqtQET
 G7i6e+tRlh5yZ0liQYBoQHQt2DMn5zzwf5AtlmTxVWM232INZ60p0ElDWYvLpjO5+kDP
 LlaAyFBBz+iXJKGFB5nsNlbyV+r1vz0bFh4FnbVWQACZZ2QGsabLhpkFEJtbZ1TvwLgK
 5lAJafWcJJk9zfrkYj/rXmzd9WZNqO2p8rRcqFgnHEfcIXuTJa8miWA5tNtAidTGP4Jp
 Cipn2TxaGopcfAlf0zMNY+Q5Mzewu1Ak7pluUVBq+Rkks92o6/S4sgHik3/8tcFdM7oq
 VjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773413377; x=1774018177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2PHxFmj6RIQIbtL5xuSbjK7u6DMDUXk5OIDhyBrxMVc=;
 b=aWLHIEtodG2RvlEXHhaJYjv/jZcfITUm7Rju8slhFsWNYlF31JaRkVk1c1wvFLSAzD
 tjG92HosjaT8DpVIRfyBGAf4NP1XDKMR0IqMpC9/SJ4OffZ7Hsk8i9xyzOGF+qJDSdWx
 jQkTr0wSZY4IMdiSdHGKAoAtvzozerhXrhBBFckqYlrvYAl2Xt3NGMlboh87H/gt3Khx
 EgDiUSB+aUOAIxmz2+iOR3oQvrFgbBINgC+/YcH/Db+1eFEsxza8Q5fU33m7v3uUHtcl
 h8AMjklzG8jueX1ofjbHzAyvNRl3jotl2jDqd/bBiBu2666XB9WIRDMBvI10AidWxeGp
 J1ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQU0F60McB+bVr7vbg/RZZfJBWolusAmbS7rkiz9t/h47IxiwmdtvdIMLVxuuueSFa9bb+QNE=@lists.denx.de
X-Gm-Message-State: AOJu0YxKF4CsjDJicWONtJ877dNS+loEYkxGnrA88wFDa/cXS9dj3Iov
 BphL0bzz3pV55R0LdRNxJ3moN4SD+/G4pEuAp34h+jSkRnc3B8sp28kcb4WiYDP1UC1OhAYmPHT
 E81FQvm2KWJ4ucoHAXPVgJD0XUZDdKudb/B50PCVLzQ==
X-Gm-Gg: ATEYQzynmkxLhmxml9Sdljgsu8Doc3Bn1yNremPBrx7HGTR3r+zAabfxAlU52Ub5Hko
 +pHbI04YBQ3XSJ/Eis0wEOoBNSXYgRDwfmsXeEUN/7d1AhuwB7x59f4izCVzk6cQ078j6IZvSfs
 ofqhUiBh5uuQ7X8IkppB544JPHju4lvjCkgVRT4A9Gocx4IERTI4sw38YtFXNUqmpvaljlX3wqi
 /UkTILsAmi74F0/8dVp5D8DXsJAiFP2UjbPwTXeUchqEb60vF8SgRh0j//OsYqJcIkMrA2wJXfC
 FJROuXhR39zt7vUx1UtK72MEzggw3GrY4wT2PbCYAEngs4UOVl1f5LT/0usgoIZRdT/4bVDcdzV
 5ozuurdmC/KQBY73bjxY3/jaElg==
X-Received: by 2002:a17:906:cd04:b0:b96:ff4f:11ea with SMTP id
 a640c23a62f3a-b9765375653mr156893066b.41.1773413377109; Fri, 13 Mar 2026
 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
 <20260310-clk-mtk-parent-cleanup-v1-1-66175ca8f637@baylibre.com>
In-Reply-To: <20260310-clk-mtk-parent-cleanup-v1-1-66175ca8f637@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 15:49:29 +0100
X-Gm-Features: AaiRm50FbW6LakK6IeXpMs6E-J7fRNuG6Q9hcqKiiHKr-UE_5yLLkklfp4YX-Ko
Message-ID: <CAEHHSvak-Ebscv7u7STNYOp05o33sUbGsB6bSbhyVrwFu13o+w@mail.gmail.com>
Subject: Re: [PATCH 01/16] clk: mediatek: replace xtal2_rate with struct
 mtk_parent
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Le mar. 10 mars 2026 =C3=A0 16:34, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Replace the hard-coded xtal rate for PLL parents with struct mtk_parent.
>
> This avoids declaring the same clock rate in multiple places and will
> allow future drivers to use an arbitrary clock.
>
> The variable is renamed to something that better indicate what the field
> is actually used for.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt7622.c | 12 +++++++++++-
>  drivers/clk/mediatek/clk-mt7623.c | 12 +++++++++++-
>  drivers/clk/mediatek/clk-mt7629.c | 16 ++++++++++++++--
>  drivers/clk/mediatek/clk-mt8183.c | 12 +++++++++++-
>  drivers/clk/mediatek/clk-mt8188.c |  2 +-
>  drivers/clk/mediatek/clk-mt8189.c |  4 +---
>  drivers/clk/mediatek/clk-mt8195.c |  2 +-
>  drivers/clk/mediatek/clk-mt8365.c |  2 +-
>  drivers/clk/mediatek/clk-mt8512.c | 12 +++++++++++-
>  drivers/clk/mediatek/clk-mt8516.c | 12 +++++++++++-
>  drivers/clk/mediatek/clk-mt8518.c | 12 +++++++++++-
>  drivers/clk/mediatek/clk-mtk.c    | 33 +++++++++++++++++++++++++--------
>  drivers/clk/mediatek/clk-mtk.h    |  2 +-
>  13 files changed, 110 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk=
-mt7622.c
> index e9a3f8ef0ba..cb637981499 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -28,6 +28,14 @@
>  #define MCU_BUS_MSK                    GENMASK(10, 9)
>  #define MCU_BUS_SEL(x)                 ((x) << 9)
>
> +enum {
> +       CLK_PAD_CLK25M,
> +};
> +> +static const ulong ext_clock_rates[] =3D {
> +       [CLK_PAD_CLK25M] =3D 25 * MHZ,
> +};
> +
>  /* apmixedsys */
>  #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,  \
>             _pd_shift, _pcw_reg, _pcw_shift) {                          \
> @@ -597,7 +605,9 @@ static const struct mtk_gate ssusb_cgs[] =3D {
>  };
>
>  static const struct mtk_clk_tree mt7622_apmixed_clk_tree =3D {
> -       .xtal2_rate =3D 25 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK25M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .plls =3D apmixed_plls,
>         .gates_offs =3D CLK_APMIXED_MAIN_CORE_EN,
>         .gates =3D apmixed_cgs,
> diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk=
-mt7623.c
> index 9e1522d4615..1c34bfbf596 100644
> --- a/drivers/clk/mediatek/clk-mt7623.c
> +++ b/drivers/clk/mediatek/clk-mt7623.c
> @@ -24,6 +24,14 @@
>  #define AXI_DIV_MSK                    GENMASK(4, 0)
>  #define AXI_DIV_SEL(x)                 (x)
>
> +enum {
> +       CLK_PAD_CLK26M,
> +};
> +

Can we define these enum values in a common header?
For example, CLK_PAD_CLK26M is defined in various different soc
specific drivers.
Also clk-mt8189.c uses defines instead of enum, so maybe we should
stay consistent.

> +static const ulong ext_clock_rates[] =3D {
> +       [CLK_PAD_CLK26M] =3D 26 * MHZ,
> +};
> +
>  /* apmixedsys */
>  static const int pll_id_offs_map[] =3D {
>         [0 ... CLK_APMIXED_NR - 1]              =3D -1,
> @@ -994,7 +1002,9 @@ static const struct mtk_gate hif_cgs[] =3D {
>  };
>
>  static const struct mtk_clk_tree mt7623_apmixedsys_clk_tree =3D {
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .id_offs_map =3D pll_id_offs_map,
>         .id_offs_map_size =3D ARRAY_SIZE(pll_id_offs_map),
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk=
-mt7629.c
> index 42670269d3e..beba7fc4abc 100644
> --- a/drivers/clk/mediatek/clk-mt7629.c
> +++ b/drivers/clk/mediatek/clk-mt7629.c
> @@ -28,6 +28,14 @@
>  #define MCU_BUS_MSK                    GENMASK(10, 9)
>  #define MCU_BUS_SEL(x)                 ((x) << 9)
>
> +enum {
> +       CLK_PAD_CLK20M,
> +};
> +
> +static const ulong ext_clock_rates[] =3D {
> +       [CLK_PAD_CLK20M] =3D 20 * MHZ,
> +};
> +
>  /* apmixedsys */
>  #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,  \
>             _pd_shift, _pcw_reg, _pcw_shift) {                          \
> @@ -567,7 +575,9 @@ static const struct mtk_gate ssusb_cgs[] =3D {
>
>  static const struct mtk_clk_tree mt7629_clk_tree =3D {
>         .xtal_rate =3D 40 * MHZ,
> -       .xtal2_rate =3D 20 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK20M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .fdivs_offs =3D CLK_TOP_TO_USB3_SYS,
>         .muxes_offs =3D CLK_TOP_AXI_SEL,
>         .plls =3D apmixed_plls,
> @@ -582,7 +592,9 @@ static const struct mtk_clk_tree mt7629_clk_tree =3D =
{
>
>  static const struct mtk_clk_tree mt7629_peri_clk_tree =3D {
>         .xtal_rate =3D 40 * MHZ,
> -       .xtal2_rate =3D 20 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK20M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .fdivs_offs =3D CLK_TOP_TO_USB3_SYS,
>         .muxes_offs =3D CLK_TOP_AXI_SEL,
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk=
-mt8183.c
> index 54e31efd2ea..6158441fb95 100644
> --- a/drivers/clk/mediatek/clk-mt8183.c
> +++ b/drivers/clk/mediatek/clk-mt8183.c
> @@ -17,6 +17,14 @@
>  #define MT8183_PLL_FMAX                (3800UL * MHZ)
>  #define MT8183_PLL_FMIN                (1500UL * MHZ)
>
> +enum {
> +       CLK_PAD_CLK26M,
> +};
> +
> +static const ulong ext_clock_rates[] =3D {
> +       [CLK_PAD_CLK26M] =3D 26 * MHZ,
> +};
> +
>  /* apmixedsys */
>  #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _rst_bar_mask, _pcwbi=
ts, \
>             _pcwibits, _pd_reg, _pd_shift, _pcw_reg, _pcw_shift) {      \
> @@ -598,7 +606,9 @@ static const struct mtk_composite top_muxes[] =3D {
>
>  static const struct mtk_clk_tree mt8183_clk_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .fdivs_offs =3D CLK_TOP_CLK13M,
>         .muxes_offs =3D CLK_TOP_MUX_AXI,
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk=
-mt8188.c
> index e4297c92bd9..ca5fa8af86e 100644
> --- a/drivers/clk/mediatek/clk-mt8188.c
> +++ b/drivers/clk/mediatek/clk-mt8188.c
> @@ -85,7 +85,7 @@ static const struct mtk_pll_data apmixed_plls[] =3D {
>
>  static const struct mtk_clk_tree mt8188_apmixedsys_clk_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
>         .ext_clk_rates =3D ext_clock_rates,
>         .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk=
-mt8189.c
> index bce54c9a45f..1f75d873516 100644
> --- a/drivers/clk/mediatek/clk-mt8189.c
> +++ b/drivers/clk/mediatek/clk-mt8189.c
> @@ -1636,8 +1636,7 @@ static const struct mtk_gate mminfra_config_clks[] =
=3D {
>  };
>
>  static const struct mtk_clk_tree mt8189_apmixedsys_clk_tree =3D {
> -       .xtal_rate =3D 26 * MHZ,
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
>         .ext_clk_rates =3D pad_clks,
>         .num_ext_clks =3D ARRAY_SIZE(pad_clks),
>         .plls =3D apmixed_plls,
> @@ -1645,7 +1644,6 @@ static const struct mtk_clk_tree mt8189_apmixedsys_=
clk_tree =3D {
>  };
>
>  static const struct mtk_clk_tree mt8189_topckgen_clk_tree =3D {
> -       .xtal_rate =3D 26 * MHZ,
>         .ext_clk_rates =3D pad_clks,
>         .num_ext_clks =3D ARRAY_SIZE(pad_clks),
>         .fdivs_offs =3D CLK_TOP_MAINPLL_D3,
> diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk=
-mt8195.c
> index 76ece913187..28b2e2f12ac 100644
> --- a/drivers/clk/mediatek/clk-mt8195.c
> +++ b/drivers/clk/mediatek/clk-mt8195.c
> @@ -97,7 +97,7 @@ static const struct mtk_pll_data apmixed_plls[] =3D {
>
>  static const struct mtk_clk_tree mt8195_apmixedsys_clk_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
>         .ext_clk_rates =3D ext_clock_rates,
>         .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk=
-mt8365.c
> index 16531491a0f..15df6422661 100644
> --- a/drivers/clk/mediatek/clk-mt8365.c
> +++ b/drivers/clk/mediatek/clk-mt8365.c
> @@ -75,7 +75,7 @@ static const struct mtk_pll_data apmixed_plls[] =3D {
>
>  static const struct mtk_clk_tree mt8365_apmixed_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
>         .ext_clk_rates =3D ext_clk_rates,
>         .num_ext_clks =3D ARRAY_SIZE(ext_clk_rates),
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk=
-mt8512.c
> index de0d3eae7ee..f7d41f4cfdb 100644
> --- a/drivers/clk/mediatek/clk-mt8512.c
> +++ b/drivers/clk/mediatek/clk-mt8512.c
> @@ -17,6 +17,14 @@
>  #define MT8512_PLL_FMIN                (1500UL * MHZ)
>  #define MT8512_CON0_RST_BAR    BIT(23)
>
> +enum {
> +       CLK_PAD_CLK26M,
> +};
> +
> +static const ulong ext_clock_rates[] =3D {
> +       [CLK_PAD_CLK26M] =3D 26 * MHZ,
> +};
> +
>  /* apmixedsys */
>  #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,  \
>             _pd_shift, _pcw_reg, _pcw_shift, _pcw_chg_reg) {            \
> @@ -786,7 +794,9 @@ static const struct mtk_gate infra_clks[] =3D {
>
>  static const struct mtk_clk_tree mt8512_clk_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .fdivs_offs =3D CLK_TOP_SYSPLL1_D2,
>         .muxes_offs =3D CLK_TOP_AXI_SEL,
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk=
-mt8516.c
> index 6b30ea9ce4a..74966051b1c 100644
> --- a/drivers/clk/mediatek/clk-mt8516.c
> +++ b/drivers/clk/mediatek/clk-mt8516.c
> @@ -16,6 +16,14 @@
>  #define MT8516_PLL_FMAX                (1502UL * MHZ)
>  #define MT8516_CON0_RST_BAR    BIT(27)
>
> +enum {
> +       CLK_PAD_CLK26M,
> +};
> +
> +static const ulong ext_clock_rates[] =3D {
> +       [CLK_PAD_CLK26M] =3D 26 * MHZ,
> +};
> +
>  /* apmixedsys */
>  #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,  \
>             _pd_shift, _pcw_reg, _pcw_shift) {                          \
> @@ -738,7 +746,9 @@ static const struct mtk_gate top_clks[] =3D {
>
>  static const struct mtk_clk_tree mt8516_clk_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .fdivs_offs =3D CLK_TOP_DMPLL,
>         .muxes_offs =3D CLK_TOP_UART0_SEL,
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk=
-mt8518.c
> index 34fa5a127d5..85cbb35446b 100644
> --- a/drivers/clk/mediatek/clk-mt8518.c
> +++ b/drivers/clk/mediatek/clk-mt8518.c
> @@ -16,6 +16,14 @@
>  #define MT8518_PLL_FMAX                (3000UL * MHZ)
>  #define MT8518_CON0_RST_BAR    BIT(27)
>
> +enum {
> +       CLK_PAD_CLK26M,
> +};
> +
> +static const ulong ext_clock_rates[] =3D {
> +       [CLK_PAD_CLK26M] =3D 26 * MHZ,
> +};
> +
>  /* apmixedsys */
>  #define PLL(_id, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,  \
>             _pd_shift, _pcw_reg, _pcw_shift) {                          \
> @@ -1494,7 +1502,9 @@ static const struct mtk_gate top_clks[] =3D {
>
>  static const struct mtk_clk_tree mt8518_clk_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> -       .xtal2_rate =3D 26 * MHZ,
> +       .pll_parent =3D EXT_PARENT(CLK_PAD_CLK26M),
> +       .ext_clk_rates =3D ext_clock_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates),
>         .fdivs_offs =3D CLK_TOP_DMPLL,
>         .muxes_offs =3D CLK_TOP_UART0_SEL,
>         .plls =3D apmixed_plls,
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index fa4a84bfceb..0b6eb0dbc04 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -499,16 +499,21 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pr=
iv *priv, u32 id,
>   * @postdiv:   The post divider (output)
>   * @freq:      The desired target frequency
>   */
> -static void mtk_pll_calc_values(struct mtk_clk_priv *priv, u32 id,
> -                               u32 *pcw, u32 *postdiv, u32 freq)
> +static int mtk_pll_calc_values(struct mtk_clk_priv *priv, struct clk *cl=
k,
> +                              u32 *pcw, u32 *postdiv, u32 freq)
>  {
>         const struct mtk_pll_data *pll;
> -       unsigned long fmin;
> +       const struct mtk_parent *parent =3D &priv->tree->pll_parent;
> +       unsigned long xtal_rate, fmin;
>         u64 _pcw;
>         int ibits;
>         u32 val;
>
> -       pll =3D &priv->tree->plls[id];
> +       xtal_rate =3D mtk_find_parent_rate(priv, clk, parent->id, parent-=
>flags);
> +       if (IS_ERR_VALUE(xtal_rate))
> +               return xtal_rate;
> +
> +       pll =3D &priv->tree->plls[clk->id];
>         fmin =3D pll->fmin ? pll->fmin : 1000 * MHZ;
>
>         if (freq > pll->fmax)
> @@ -523,9 +528,11 @@ static void mtk_pll_calc_values(struct mtk_clk_priv =
*priv, u32 id,
>         /* _pcw =3D freq * postdiv / xtal_rate * 2^pcwfbits */
>         ibits =3D pll->pcwibits ? pll->pcwibits : INTEGER_BITS;
>         _pcw =3D ((u64)freq << val) << (pll->pcwbits - ibits);
> -       do_div(_pcw, priv->tree->xtal2_rate);
> +       do_div(_pcw, xtal_rate);
>
>         *pcw =3D (u32)_pcw;
> +
> +       return 0;
>  }
>
>  static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
> @@ -533,11 +540,15 @@ static ulong mtk_apmixedsys_set_rate(struct clk *cl=
k, ulong rate)
>         struct mtk_clk_priv *priv =3D dev_get_priv(clk->dev);
>         u32 pcw =3D 0;
>         u32 postdiv;
> +       int ret;
>
>         if (!mtk_clk_id_is_pll(priv->tree, clk->id))
>                 return -EINVAL;
>
> -       mtk_pll_calc_values(priv, clk->id, &pcw, &postdiv, rate);
> +       ret =3D mtk_pll_calc_values(priv, clk, &pcw, &postdiv, rate);
> +       if (ret)
> +               return ret;
> +
>         mtk_pll_set_rate_regs(priv, clk->id, pcw, postdiv);
>
>         return 0;
> @@ -546,8 +557,10 @@ static ulong mtk_apmixedsys_set_rate(struct clk *clk=
, ulong rate)
>  static ulong mtk_apmixedsys_get_rate(struct clk *clk)
>  {
>         struct mtk_clk_priv *priv =3D dev_get_priv(clk->dev);
> +       const struct mtk_parent *parent;
>         const struct mtk_pll_data *pll;
>         const struct mtk_gate *gate;
> +       unsigned long xtal_rate;
>         u32 postdiv;
>         u32 pcw;
>
> @@ -557,6 +570,11 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk=
)
>                 return mtk_find_parent_rate(priv, clk, gate->parent, gate=
->flags);
>         }
>
> +       parent =3D &priv->tree->pll_parent;
> +       xtal_rate =3D mtk_find_parent_rate(priv, clk, parent->id, parent-=
>flags);
> +       if (IS_ERR_VALUE(xtal_rate))
> +               return xtal_rate;
> +
>         pll =3D &priv->tree->plls[clk->id];
>
>         postdiv =3D (readl(priv->base + pll->pd_reg) >> pll->pd_shift) &
> @@ -566,8 +584,7 @@ static ulong mtk_apmixedsys_get_rate(struct clk *clk)
>         pcw =3D readl(priv->base + pll->pcw_reg) >> pll->pcw_shift;
>         pcw &=3D GENMASK(pll->pcwbits - 1, 0);
>
> -       return __mtk_pll_recalc_rate(pll, priv->tree->xtal2_rate,
> -                                    pcw, postdiv);
> +       return __mtk_pll_recalc_rate(pll, xtal_rate, pcw, postdiv);
>  }
>
>  static int mtk_apmixedsys_enable(struct clk *clk)
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mt=
k.h
> index 10a0723de47..682b4303585 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -234,7 +234,7 @@ struct mtk_gate {
>  /* struct mtk_clk_tree - clock tree */
>  struct mtk_clk_tree {
>         unsigned long xtal_rate;
> -       unsigned long xtal2_rate;
> +       const struct mtk_parent pll_parent;
>         /* External fixed clocks - excluded from mapping. */
>         const ulong *ext_clk_rates;
>         const int num_ext_clks;
>
> --
> 2.43.0
>
