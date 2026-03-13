Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B185103E305
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A04F8436C;
	Fri, 13 Mar 2026 16:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="orUnVq0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A523184372; Fri, 13 Mar 2026 16:32:07 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E23818423D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-66438f18ea1so765007a12.3
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415924; cv=none;
 d=google.com; s=arc-20240605;
 b=S3RH1crvq535mMSglGBbrx51jwADHU4gjWDh8sPVCNn41vsjB/BrYYS3B4a7og9zjT
 pI+6j+lkvpJnVrRw6/Es/6GCWfRhRfdOjPl5WaAeNsCEiRuKneoR+vaIIEU4MSRtoOxo
 dM9Q9FA3wxnF09kZquWg2MY8gt9HBnadt/NmyAhWB8ohllRfQQwSQvx6V+49PD3NdLIp
 iCb+xDz/nT/RBPp+7jyt1/C0HzpO0vu2Wp4nfiuH/knrj08Rx1TE6n0uw33v49a1l6UB
 V86gQESXZ+71QWGk30ipfnYqhLi7ZWo942jEgkDuFU0GlZyEZwfxmr1xcqFDvESLuBF/
 BIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d/4oJ0IxYCMvo/OT3gLMPQZyU5Q7kJvWfJsEOiwaFfA=;
 fh=2oJ9eckyD2v7lGQn+InEve6L/sYDfr0krUzwVIwyv94=;
 b=PxGBOscbtM7QreXkwLq3pnmEWYs2yMiz2hrNbf18eVWvwEY3SXeHh+QbM8EOO5H26Z
 vGSWzJjHfCFaTLJj/lRv/msSSh4wjuPQxYKo0UnOdpfku+D9mLOn8tOxK/ytkILnrfRa
 rLONnnnEG4hUmzPsB8tDBYopQG3nE57cCt9zjDJqJeSipXrmTbiYlCppMUzqbJFR1fc5
 zhdQXx0jGZ0VEhrh9H3ix+LYb30yGuBvPy1tra9qR2hev9GrPZLLT5gDHMp5WjNo2lIp
 Y5q5RsXGRQOFkFWypGZA9lq6zd92L/FZbOJyBUNaEJBtzL+/F0ie8B8BAle+5E+ZwRxK
 5Pbg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773415924; x=1774020724;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/4oJ0IxYCMvo/OT3gLMPQZyU5Q7kJvWfJsEOiwaFfA=;
 b=orUnVq0Epp2RmkEcw8MMpF7M2YhlrIRfQGqkJ8EYVXkH5Hyb5e4JBva1RVXjDk0k1Q
 KabBfPNCcE+raTbWFq2UDWSwbHT7Dq2G8HSOftFZcYEef9P1/xyjrkWaY0UIL2nm6134
 Nyw/VpjM91zLjk8o2BFJxXLP8JYXc+Tdqfo9qMqp7Zf+iIYPLsfbp+fkG/kYF6w487LN
 D2DHOF9g7pN5Rh9PeDc0QkbZMXvd0ZgeGgLrQwTOsWkc4qTRJAEjdKn2BK06oGQVrV1v
 O6XDTgh379E77f/FtbwOiOzGjBLFn2GRhEa2Arwh6dKEPLdd2kzAFbp4GGNBh6EuPTEZ
 D1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773415924; x=1774020724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/4oJ0IxYCMvo/OT3gLMPQZyU5Q7kJvWfJsEOiwaFfA=;
 b=KZBO3LCpEFh1kHEsZIPvn3g4fEtV++RgYoLP73Ex5RgTm1xzjdryKar4cKguUsZr9a
 ljy4fctesOfxsHNCm0y4UwPAJatKL7LvKV2fWnEfSzNkWVJWqRiFQH/ygpkFdHcegQzz
 ky8nrRMMWLI9uo6P1DBk3lIbHVlF84K94MxbBR6Z/ICP3rgl9h49R4KQR3Z5zkEOx93o
 x1jLLt+jYm0v0virRcnBjJRMSTCUnoKfnHV3Zr9OFUwGFNf5eHw4rI/iOsJG+7EDODym
 xrB5a8dQTceWsGGOyn+ioVDos2PpFlMeWp9vJEku8sWuWXvlpG9cZBbCgxavuvVkrvaN
 795w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0pBcoyS86WyKrt5CNuYvW18u4Y33o19fuaDcHQ8bAesIMi0bLwdU7ILxStE8zGdiI+DEsy7Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6GUnCEnoR2wNDEN0v+f/4ZvF1doRO+aXf038l83ILBeaRkfbI
 1dGVujqzF75CuvrcWVdsdRov86Y0g3d2IcDryxSLpLNiV9u+tTZwTUGAvwY5fL4OhK9nOMHAtxU
 LdOGw13dGP5ipFBTQ1ltJapLwtDS6p+F63pIt0rx69w==
X-Gm-Gg: ATEYQzwhWyZVAZwCuDtZGbeMLc728MBTA1hHZAnQDr8wqj+fPoypXiPUbAap4/uVUb0
 IV8S8O8k2ALrQqbyRFFCiXrbbFMt9ZmGc9FL7d/7Um+EtXKcCv1cDxmC3pGkm9eyAFYqUq/GxMR
 gOqk6gUFkCbw5O8M9ZNT3vX1Q1UZNO3N4B6h0E8D1wHvWIjPRMZglTd1Qp8HaLEE4P0jcRL+yKS
 kKMOKJ16kk9qqVv5SnUhmS+qKG4pr/hz4PMdJ9D38Nd4YtoKOcmgdjqGz0uL8vTBo0+n73XTWNO
 vLm1BT2hA0Tbz+hviA3mV2C1TSnOOQJ+9cxBxbXCURTxtAHHunH9mG+ZqrJ3dzv+EflpRFye8iw
 qjhTIL0LA8WMwB1/LG75AD8jlYA==
X-Received: by 2002:a17:906:358c:b0:b87:1741:a484 with SMTP id
 a640c23a62f3a-b9765375648mr161324866b.43.1773415923987; Fri, 13 Mar 2026
 08:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com>
In-Reply-To: <20260303-mtk-clk-8365-drop-map-v1-1-17f81c375290@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 16:31:56 +0100
X-Gm-Features: AaiRm53Wpo87iXe0Kp-Mdsasb41-j3t97wuT8ftNF1lHHgeGb8333b2OLKyAFMQ
Message-ID: <CAEHHSvYJ6HgRX556BbGG+Lh+7mPLfJXSr7KPvsjW6gRbYtJvRA@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: drop topckgen map
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

Le mar. 3 mars 2026 =C3=A0 23:18, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Drop the clock ID map for MT8365 TOPCKGEN clocks.
>
> Previously, we didn't have the EXT clock feature, so we needed the map.
> Now we can replace it with the new feature to avoid the map.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This was tested by comparing the `clk dump` output from before and after
> the changes on mt8365_evk for the expected changes.
>
> This depends on:
> * https://lore.kernel.org/u-boot/20260303-mtk-mt8189-clocks-v4-0-ee85f8dd=
2f0d@baylibre.com/
> * https://lore.kernel.org/u-boot/20260223-clk-mtk-remove-clk-bypass-xtal-=
flag-v1-0-a7dc97bc2660@baylibre.com/
> * https://lore.kernel.org/u-boot/20260302-clk-mtk-unify-mux-parents-v1-0-=
32f45085f4d0@baylibre.com/
> ---
>  drivers/clk/mediatek/clk-mt8365.c | 307 +++++++++++++-------------------=
------
>  1 file changed, 103 insertions(+), 204 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk=
-mt8365.c
> index c6803090f35..16531491a0f 100644
> --- a/drivers/clk/mediatek/clk-mt8365.c
> +++ b/drivers/clk/mediatek/clk-mt8365.c
> @@ -13,9 +13,15 @@
>  #include <dt-bindings/clock/mediatek,mt8365-clk.h>
>  #include "clk-mtk.h"
>
> -/* Missing topckgen clocks definition in dt-bindings */
> -#define CLK_TOP_CLK26M         141
> -#define CLK_TOP_CLK32K         142
> +enum {
> +       CLK_PAD_CLK32K,
> +       CLK_PAD_CLK26M,
> +};
> +
> +static const ulong ext_clk_rates[] =3D {
> +       [CLK_PAD_CLK32K] =3D 32000,
> +       [CLK_PAD_CLK26M] =3D 26000000,
> +};
>
>  /* apmixedsys */
>  #define MT8365_PLL_FMAX                (3800UL * MHZ)
> @@ -70,151 +76,14 @@ static const struct mtk_pll_data apmixed_plls[] =3D =
{
>  static const struct mtk_clk_tree mt8365_apmixed_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
>         .xtal2_rate =3D 26 * MHZ,
> +       .ext_clk_rates =3D ext_clk_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clk_rates),
>         .plls =3D apmixed_plls,
>         .num_plls =3D ARRAY_SIZE(apmixed_plls),
>  };
>
>  /* topckgen */
>
> -/*
> - * The devicetree bindings missed a few clocks and can't be changed, so =
we need
> - * to provide a mapping to fix the omissions.
> - */
> -static const int mt8365_topckgen_id_map[] =3D {
> -       [0 ... CLK_TOP_NR_CLK - 1]      =3D -1,
> -       /* FIXED */
> -       /* Fixed 32K oscillator is not available in devicetree definition=
s */
> -       [CLK_TOP_CLK32K]                =3D 0,
> -       [CLK_TOP_CLK_NULL]              =3D 1,
> -       [CLK_TOP_I2S0_BCK]              =3D 2,
> -       [CLK_TOP_DSI0_LNTC_DSICK]       =3D 3,
> -       [CLK_TOP_VPLL_DPIX]             =3D 4,
> -       [CLK_TOP_LVDSTX_CLKDIG_CTS]     =3D 5,
> -       /* FACTOR */
> -       [CLK_TOP_MFGPLL]                =3D 6,
> -       [CLK_TOP_SYSPLL_D2]             =3D 7,
> -       [CLK_TOP_SYSPLL1_D2]            =3D 8,
> -       [CLK_TOP_SYSPLL1_D4]            =3D 9,
> -       [CLK_TOP_SYSPLL1_D8]            =3D 10,
> -       [CLK_TOP_SYSPLL1_D16]           =3D 11,
> -       [CLK_TOP_SYSPLL_D3]             =3D 12,
> -       [CLK_TOP_SYSPLL2_D2]            =3D 13,
> -       [CLK_TOP_SYSPLL2_D4]            =3D 14,
> -       [CLK_TOP_SYSPLL2_D8]            =3D 15,
> -       [CLK_TOP_SYSPLL_D5]             =3D 16,
> -       [CLK_TOP_SYSPLL3_D2]            =3D 17,
> -       [CLK_TOP_SYSPLL3_D4]            =3D 18,
> -       [CLK_TOP_SYSPLL_D7]             =3D 19,
> -       [CLK_TOP_SYSPLL4_D2]            =3D 20,
> -       [CLK_TOP_SYSPLL4_D4]            =3D 21,
> -       /* Skipping CLK_TOP_UNIVPLL since isn't a real clock. */
> -       [CLK_TOP_UNIVPLL_D2]            =3D 22,
> -       [CLK_TOP_UNIVPLL1_D2]           =3D 23,
> -       [CLK_TOP_UNIVPLL1_D4]           =3D 24,
> -       [CLK_TOP_UNIVPLL_D3]            =3D 25,
> -       [CLK_TOP_UNIVPLL2_D2]           =3D 26,
> -       [CLK_TOP_UNIVPLL2_D4]           =3D 27,
> -       [CLK_TOP_UNIVPLL2_D8]           =3D 28,
> -       [CLK_TOP_UNIVPLL2_D32]          =3D 29,
> -       [CLK_TOP_UNIVPLL_D5]            =3D 30,
> -       [CLK_TOP_UNIVPLL3_D2]           =3D 31,
> -       [CLK_TOP_UNIVPLL3_D4]           =3D 32,
> -       [CLK_TOP_MMPLL]                 =3D 33,
> -       [CLK_TOP_MMPLL_D2]              =3D 34,
> -       [CLK_TOP_LVDSPLL_D2]            =3D 35,
> -       [CLK_TOP_LVDSPLL_D4]            =3D 36,
> -       [CLK_TOP_LVDSPLL_D8]            =3D 37,
> -       [CLK_TOP_LVDSPLL_D16]           =3D 38,
> -       [CLK_TOP_USB20_192M]            =3D 39,
> -       [CLK_TOP_USB20_192M_D4]         =3D 40,
> -       [CLK_TOP_USB20_192M_D8]         =3D 41,
> -       [CLK_TOP_USB20_192M_D16]        =3D 42,
> -       [CLK_TOP_USB20_192M_D32]        =3D 43,
> -       [CLK_TOP_APLL1]                 =3D 44,
> -       [CLK_TOP_APLL1_D2]              =3D 45,
> -       [CLK_TOP_APLL1_D4]              =3D 46,
> -       [CLK_TOP_APLL1_D8]              =3D 47,
> -       [CLK_TOP_APLL2]                 =3D 48,
> -       [CLK_TOP_APLL2_D2]              =3D 49,
> -       [CLK_TOP_APLL2_D4]              =3D 50,
> -       [CLK_TOP_APLL2_D8]              =3D 51,
> -       /* Fixed 26M oscillator is not available in devicetree definition=
s */
> -       [CLK_TOP_CLK26M]                =3D 52,
> -       [CLK_TOP_SYS_26M_D2]            =3D 53,
> -       [CLK_TOP_MSDCPLL]               =3D 54,
> -       [CLK_TOP_MSDCPLL_D2]            =3D 55,
> -       [CLK_TOP_DSPPLL]                =3D 56,
> -       [CLK_TOP_DSPPLL_D2]             =3D 57,
> -       [CLK_TOP_DSPPLL_D4]             =3D 58,
> -       [CLK_TOP_DSPPLL_D8]             =3D 59,
> -       [CLK_TOP_APUPLL]                =3D 60,
> -       [CLK_TOP_CLK26M_D52]            =3D 61,
> -       /* MUX */
> -       [CLK_TOP_AXI_SEL]               =3D 62,
> -       [CLK_TOP_MEM_SEL]               =3D 63,
> -       [CLK_TOP_MM_SEL]                =3D 64,
> -       [CLK_TOP_SCP_SEL]               =3D 65,
> -       [CLK_TOP_MFG_SEL]               =3D 66,
> -       [CLK_TOP_ATB_SEL]               =3D 67,
> -       [CLK_TOP_CAMTG_SEL]             =3D 68,
> -       [CLK_TOP_CAMTG1_SEL]            =3D 69,
> -       [CLK_TOP_UART_SEL]              =3D 70,
> -       [CLK_TOP_SPI_SEL]               =3D 71,
> -       [CLK_TOP_MSDC50_0_HC_SEL]       =3D 72,
> -       [CLK_TOP_MSDC2_2_HC_SEL]        =3D 73,
> -       [CLK_TOP_MSDC50_0_SEL]          =3D 74,
> -       [CLK_TOP_MSDC50_2_SEL]          =3D 75,
> -       [CLK_TOP_MSDC30_1_SEL]          =3D 76,
> -       [CLK_TOP_AUDIO_SEL]             =3D 77,
> -       [CLK_TOP_AUD_INTBUS_SEL]        =3D 78,
> -       [CLK_TOP_AUD_1_SEL]             =3D 79,
> -       [CLK_TOP_AUD_2_SEL]             =3D 80,
> -       [CLK_TOP_AUD_ENGEN1_SEL]        =3D 81,
> -       [CLK_TOP_AUD_ENGEN2_SEL]        =3D 82,
> -       [CLK_TOP_AUD_SPDIF_SEL]         =3D 83,
> -       [CLK_TOP_DISP_PWM_SEL]          =3D 84,
> -       [CLK_TOP_DXCC_SEL]              =3D 85,
> -       [CLK_TOP_SSUSB_SYS_SEL]         =3D 86,
> -       [CLK_TOP_SSUSB_XHCI_SEL]        =3D 87,
> -       [CLK_TOP_SPM_SEL]               =3D 88,
> -       [CLK_TOP_I2C_SEL]               =3D 89,
> -       [CLK_TOP_PWM_SEL]               =3D 90,
> -       [CLK_TOP_SENIF_SEL]             =3D 91,
> -       [CLK_TOP_AES_FDE_SEL]           =3D 92,
> -       [CLK_TOP_CAMTM_SEL]             =3D 93,
> -       [CLK_TOP_DPI0_SEL]              =3D 94,
> -       [CLK_TOP_DPI1_SEL]              =3D 95,
> -       [CLK_TOP_DSP_SEL]               =3D 96,
> -       [CLK_TOP_NFI2X_SEL]             =3D 97,
> -       [CLK_TOP_NFIECC_SEL]            =3D 98,
> -       [CLK_TOP_ECC_SEL]               =3D 99,
> -       [CLK_TOP_ETH_SEL]               =3D 100,
> -       [CLK_TOP_GCPU_SEL]              =3D 101,
> -       [CLK_TOP_GCPU_CPM_SEL]          =3D 102,
> -       [CLK_TOP_APU_SEL]               =3D 103,
> -       [CLK_TOP_APU_IF_SEL]            =3D 104,
> -       /* GATE */
> -       [CLK_TOP_AUD_I2S0_M]            =3D 105,
> -       [CLK_TOP_AUD_I2S1_M]            =3D 106,
> -       [CLK_TOP_AUD_I2S2_M]            =3D 107,
> -       [CLK_TOP_AUD_I2S3_M]            =3D 108,
> -       [CLK_TOP_AUD_TDMOUT_M]          =3D 109,
> -       [CLK_TOP_AUD_TDMOUT_B]          =3D 110,
> -       [CLK_TOP_AUD_TDMIN_M]           =3D 111,
> -       [CLK_TOP_AUD_TDMIN_B]           =3D 112,
> -       [CLK_TOP_AUD_SPDIF_M]           =3D 113,
> -       [CLK_TOP_USB20_48M_EN]          =3D 114,
> -       [CLK_TOP_UNIVPLL_48M_EN]        =3D 115,
> -       [CLK_TOP_LVDSTX_CLKDIG_EN]      =3D 116,
> -       [CLK_TOP_VPLL_DPIX_EN]          =3D 117,
> -       [CLK_TOP_SSUSB_TOP_CK_EN]       =3D 118,
> -       [CLK_TOP_SSUSB_PHY_CK_EN]       =3D 119,
> -       [CLK_TOP_CONN_32K]              =3D 120,
> -       [CLK_TOP_CONN_26M]              =3D 121,
> -       [CLK_TOP_DSP_32K]               =3D 122,
> -       [CLK_TOP_DSP_26M]               =3D 123,
> -};
> -
>  #define FIXED_CLK0(_id, _rate)                                         \
>         FIXED_CLK(_id, CLK_XTAL, CLK_PARENT_XTAL, _rate)
>
> @@ -222,7 +91,6 @@ static const int mt8365_topckgen_id_map[] =3D {
>         FIXED_CLK(_id, CLK_TOP_CLK_NULL, CLK_PARENT_TOPCKGEN, _rate)
>
>  static const struct mtk_fixed_clk top_fixed_clks[] =3D {
> -       FIXED_CLK0(CLK_TOP_CLK32K, 32000),
>         FIXED_CLK0(CLK_TOP_CLK_NULL, 0),
>         FIXED_CLK1(CLK_TOP_I2S0_BCK, 26000000),
>         FIXED_CLK0(CLK_TOP_DSI0_LNTC_DSICK, 75000000),
> @@ -256,6 +124,7 @@ static const struct mtk_fixed_factor top_divs[] =3D {
>         PLL_FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", CLK_APMIXED_MAINPLL, 1=
, 7),
>         PLL_FACTOR(CLK_TOP_SYSPLL4_D2, "syspll4_d2", CLK_APMIXED_MAINPLL,=
 1, 14),
>         PLL_FACTOR(CLK_TOP_SYSPLL4_D4, "syspll4_d4", CLK_APMIXED_MAINPLL,=
 1, 28),
> +       PLL_FACTOR(CLK_TOP_UNIVPLL, "univpll", CLK_APMIXED_UNIVPLL, 1, 1)=
,
>         PLL_FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", CLK_APMIXED_UNIVPLL,=
 1, 2),
>         PLL_FACTOR(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", CLK_APMIXED_UNIVPL=
L, 1, 4),
>         PLL_FACTOR(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", CLK_APMIXED_UNIVPL=
L, 1, 8),
> @@ -286,7 +155,6 @@ static const struct mtk_fixed_factor top_divs[] =3D {
>         PLL_FACTOR1(CLK_TOP_APLL2_D2, "apll2_d2", CLK_TOP_APLL2, 1, 2),
>         PLL_FACTOR1(CLK_TOP_APLL2_D4, "apll2_d4", CLK_TOP_APLL2, 1, 4),
>         PLL_FACTOR1(CLK_TOP_APLL2_D8, "apll2_d8", CLK_TOP_APLL2, 1, 8),
> -       PLL_FACTOR2(CLK_TOP_CLK26M, "clk26m_ck", CLK_XTAL, 1, 1),
>         PLL_FACTOR2(CLK_TOP_SYS_26M_D2, "sys_26m_d2", CLK_XTAL, 1, 2),
>         PLL_FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", CLK_APMIXED_MSDCPLL, 1,=
 1),
>         PLL_FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", CLK_APMIXED_MSDCPLL,=
 1, 2),
> @@ -299,21 +167,21 @@ static const struct mtk_fixed_factor top_divs[] =3D=
 {
>  };
>
>  static const struct mtk_parent axi_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL_D7),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL3_D2),
>  };
>
>  static const struct mtk_parent mem_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_MMPLL),
>         TOP_PARENT(CLK_TOP_SYSPLL_D3),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D2),
>  };
>
>  static const struct mtk_parent mm_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_MMPLL),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL_D5),
> @@ -324,7 +192,7 @@ static const struct mtk_parent mm_parents[] =3D {
>  };
>
>  static const struct mtk_parent scp_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL4_D2),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D2),
> @@ -334,20 +202,20 @@ static const struct mtk_parent scp_parents[] =3D {
>  };
>
>  static const struct mtk_parent mfg_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_MFGPLL),
>         TOP_PARENT(CLK_TOP_SYSPLL_D3),
>         TOP_PARENT(CLK_TOP_UNIVPLL_D3),
>  };
>
>  static const struct mtk_parent atb_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D2),
>  };
>
>  static const struct mtk_parent camtg_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_USB20_192M_D8),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
>         TOP_PARENT(CLK_TOP_USB20_192M_D4),
> @@ -357,26 +225,26 @@ static const struct mtk_parent camtg_parents[] =3D =
{
>  };
>
>  static const struct mtk_parent uart_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
>  };
>
>  static const struct mtk_parent spi_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
>  };
>
>  static const struct mtk_parent msdc50_0_hc_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D2),
>         TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL2_D2),
>  };
>
>  static const struct mtk_parent msdc50_0_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_MSDCPLL),
>         TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D2),
> @@ -387,7 +255,7 @@ static const struct mtk_parent msdc50_0_parents[] =3D=
 {
>  };
>
>  static const struct mtk_parent msdc50_2_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_MSDCPLL),
>         TOP_PARENT(CLK_TOP_UNIVPLL_D3),
>         TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
> @@ -398,7 +266,7 @@ static const struct mtk_parent msdc50_2_parents[] =3D=
 {
>  };
>
>  static const struct mtk_parent msdc30_1_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_MSDCPLL_D2),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL2_D2),
> @@ -409,73 +277,73 @@ static const struct mtk_parent msdc30_1_parents[] =
=3D {
>  };
>
>  static const struct mtk_parent audio_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL3_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL4_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D16),
>  };
>
>  static const struct mtk_parent aud_intbus_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL4_D2),
>  };
>
>  static const struct mtk_parent aud_1_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_APLL1),
>  };
>
>  static const struct mtk_parent aud_2_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_APLL2),
>  };
>
>  static const struct mtk_parent aud_engen1_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_APLL1_D2),
>         TOP_PARENT(CLK_TOP_APLL1_D4),
>         TOP_PARENT(CLK_TOP_APLL1_D8),
>  };
>
>  static const struct mtk_parent aud_engen2_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_APLL2_D2),
>         TOP_PARENT(CLK_TOP_APLL2_D4),
>         TOP_PARENT(CLK_TOP_APLL2_D8),
>  };
>
>  static const struct mtk_parent aud_spdif_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL_D2),
>  };
>
>  static const struct mtk_parent disp_pwm_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
>  };
>
>  static const struct mtk_parent dxcc_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D8),
>  };
>
>  static const struct mtk_parent ssusb_sys_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
>         TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
>  };
>
>  static const struct mtk_parent spm_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D8),
>  };
>
>  static const struct mtk_parent i2c_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
>         TOP_PARENT(CLK_TOP_UNIVPLL3_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D8),
> @@ -483,20 +351,20 @@ static const struct mtk_parent i2c_parents[] =3D {
>  };
>
>  static const struct mtk_parent pwm_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL3_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D8),
>  };
>
>  static const struct mtk_parent senif_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL1_D4),
>         TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
>  };
>
>  static const struct mtk_parent aes_fde_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_MSDCPLL),
>         TOP_PARENT(CLK_TOP_UNIVPLL_D3),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
> @@ -505,7 +373,7 @@ static const struct mtk_parent aes_fde_parents[] =3D =
{
>  };
>
>  static const struct mtk_parent dpi0_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_LVDSPLL_D2),
>         TOP_PARENT(CLK_TOP_LVDSPLL_D4),
>         TOP_PARENT(CLK_TOP_LVDSPLL_D8),
> @@ -513,7 +381,7 @@ static const struct mtk_parent dpi0_parents[] =3D {
>  };
>
>  static const struct mtk_parent dsp_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYS_26M_D2),
>         TOP_PARENT(CLK_TOP_DSPPLL),
>         TOP_PARENT(CLK_TOP_DSPPLL_D2),
> @@ -522,7 +390,7 @@ static const struct mtk_parent dsp_parents[] =3D {
>  };
>
>  static const struct mtk_parent nfi2x_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL2_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL_D7),
>         TOP_PARENT(CLK_TOP_SYSPLL_D3),
> @@ -533,7 +401,7 @@ static const struct mtk_parent nfi2x_parents[] =3D {
>  };
>
>  static const struct mtk_parent nfiecc_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_SYSPLL4_D2),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL_D7),
> @@ -544,7 +412,7 @@ static const struct mtk_parent nfiecc_parents[] =3D {
>  };
>
>  static const struct mtk_parent ecc_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
>         TOP_PARENT(CLK_TOP_UNIVPLL1_D2),
>         TOP_PARENT(CLK_TOP_UNIVPLL_D3),
> @@ -552,7 +420,7 @@ static const struct mtk_parent ecc_parents[] =3D {
>  };
>
>  static const struct mtk_parent eth_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D8),
>         TOP_PARENT(CLK_TOP_SYSPLL4_D4),
>         TOP_PARENT(CLK_TOP_SYSPLL1_D8),
> @@ -560,7 +428,7 @@ static const struct mtk_parent eth_parents[] =3D {
>  };
>
>  static const struct mtk_parent gcpu_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL_D3),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL_D3),
> @@ -568,13 +436,13 @@ static const struct mtk_parent gcpu_parents[] =3D {
>  };
>
>  static const struct mtk_parent gcpu_cpm_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL2_D2),
>         TOP_PARENT(CLK_TOP_SYSPLL2_D2),
>  };
>
>  static const struct mtk_parent apu_parents[] =3D {
> -       TOP_PARENT(CLK_TOP_CLK26M),
> +       EXT_PARENT(CLK_PAD_CLK26M),
>         TOP_PARENT(CLK_TOP_UNIVPLL_D2),
>         TOP_PARENT(CLK_TOP_APUPLL),
>         TOP_PARENT(CLK_TOP_MMPLL),
> @@ -684,6 +552,14 @@ static const struct mtk_gate_regs top2_cg_regs =3D {
>                 .flags =3D CLK_GATE_NO_SETCLR_INV | CLK_PARENT_TOPCKGEN, =
\
>         }
>
> +#define GATE_EXT(_id, _parent, _shift) {                              \
> +               .id =3D _id,                                             =
\
> +               .parent =3D _parent,                                     =
\
> +               .regs =3D &top0_cg_regs,                                 =
\
> +               .shift =3D _shift,                                       =
\
> +               .flags =3D CLK_GATE_NO_SETCLR | CLK_PARENT_EXT,          =
\
> +       }
> +
>  static const struct mtk_gate top_clk_gates[] =3D {
>         GATE_TOP2(CLK_TOP_AUD_I2S0_M, CLK_TOP_APLL12_CK_DIV0, 0),
>         GATE_TOP2(CLK_TOP_AUD_I2S1_M, CLK_TOP_APLL12_CK_DIV1, 1),
> @@ -700,19 +576,19 @@ static const struct mtk_gate top_clk_gates[] =3D {
>         GATE_TOP1(CLK_TOP_VPLL_DPIX_EN, CLK_TOP_VPLL_DPIX, 21),
>         GATE_TOP1(CLK_TOP_SSUSB_TOP_CK_EN, CLK_TOP_CLK_NULL, 22),
>         GATE_TOP1(CLK_TOP_SSUSB_PHY_CK_EN, CLK_TOP_CLK_NULL, 23),
> -       GATE_TOP0(CLK_TOP_CONN_32K, CLK_TOP_CLK32K, 10),
> -       GATE_TOP0(CLK_TOP_CONN_26M, CLK_TOP_CLK26M, 11),
> -       GATE_TOP0(CLK_TOP_DSP_32K, CLK_TOP_CLK32K, 16),
> -       GATE_TOP0(CLK_TOP_DSP_26M, CLK_TOP_CLK26M, 17),
> +       GATE_EXT(CLK_TOP_CONN_32K, CLK_PAD_CLK32K, 10),
> +       GATE_EXT(CLK_TOP_CONN_26M, CLK_PAD_CLK26M, 11),
> +       GATE_EXT(CLK_TOP_DSP_32K, CLK_PAD_CLK32K, 16),
> +       GATE_EXT(CLK_TOP_DSP_26M, CLK_PAD_CLK26M, 17),
>  };
>
>  static const struct mtk_clk_tree mt8365_topckgen_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> -       .id_offs_map =3D mt8365_topckgen_id_map,
> -       .id_offs_map_size =3D ARRAY_SIZE(mt8365_topckgen_id_map),
> -       .fdivs_offs =3D mt8365_topckgen_id_map[CLK_TOP_MFGPLL],
> -       .muxes_offs =3D mt8365_topckgen_id_map[CLK_TOP_AXI_SEL],
> -       .gates_offs =3D mt8365_topckgen_id_map[CLK_TOP_AUD_I2S0_M],
> +       .ext_clk_rates =3D ext_clk_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clk_rates),
> +       .fdivs_offs =3D CLK_TOP_MFGPLL,
> +       .muxes_offs =3D CLK_TOP_AXI_SEL,
> +       .gates_offs =3D CLK_TOP_AUD_I2S0_M,
>         .fclks =3D top_fixed_clks,
>         .fdivs =3D top_divs,
>         .muxes =3D top_muxes,
> @@ -778,12 +654,33 @@ static const struct mtk_gate_regs ifr6_cg_regs =3D =
{
>  #define GATE_IFR6(_id, _parent, _shift)                                \
>         GATE_IFRX(_id, _parent, _shift, &ifr6_cg_regs)
>
> +#define GATE_IFRX_EXT(_id, _parent, _shift, _regs)             \
> +       {                                                       \
> +               .id =3D _id,                                      \
> +               .parent =3D _parent,                              \
> +               .regs =3D _regs,                                  \
> +               .shift =3D _shift,                                \
> +               .flags =3D CLK_GATE_SETCLR | CLK_PARENT_EXT,      \
> +       }
> +
> +#define GATE_IFR2_EXT(_id, _parent, _shift)                    \
> +       GATE_IFRX_EXT(_id, _parent, _shift, &ifr2_cg_regs)
> +
> +#define GATE_IFR3_EXT(_id, _parent, _shift)                    \
> +       GATE_IFRX_EXT(_id, _parent, _shift, &ifr3_cg_regs)
> +
> +#define GATE_IFR4_EXT(_id, _parent, _shift)                    \
> +       GATE_IFRX_EXT(_id, _parent, _shift, &ifr4_cg_regs)
> +
> +#define GATE_IFR5_EXT(_id, _parent, _shift)                    \
> +       GATE_IFRX_EXT(_id, _parent, _shift, &ifr5_cg_regs)
> +
>  static const struct mtk_gate ifr_clks[] =3D {
>         /* IFR2 */
> -       GATE_IFR2(CLK_IFR_PMIC_TMR, CLK_TOP_CLK26M, 0),
> -       GATE_IFR2(CLK_IFR_PMIC_AP, CLK_TOP_CLK26M, 1),
> -       GATE_IFR2(CLK_IFR_PMIC_MD, CLK_TOP_CLK26M, 2),
> -       GATE_IFR2(CLK_IFR_PMIC_CONN, CLK_TOP_CLK26M, 3),
> +       GATE_IFR2_EXT(CLK_IFR_PMIC_TMR, CLK_PAD_CLK26M, 0),
> +       GATE_IFR2_EXT(CLK_IFR_PMIC_AP, CLK_PAD_CLK26M, 1),
> +       GATE_IFR2_EXT(CLK_IFR_PMIC_MD, CLK_PAD_CLK26M, 2),
> +       GATE_IFR2_EXT(CLK_IFR_PMIC_CONN, CLK_PAD_CLK26M, 3),
>         GATE_IFR2(CLK_IFR_ICUSB, CLK_TOP_AXI_SEL, 8),
>         GATE_IFR2(CLK_IFR_GCE, CLK_TOP_AXI_SEL, 9),
>         GATE_IFR2(CLK_IFR_THERM, CLK_TOP_AXI_SEL, 10),
> @@ -798,7 +695,7 @@ static const struct mtk_gate ifr_clks[] =3D {
>         GATE_IFR2(CLK_IFR_UART1, CLK_TOP_UART_SEL, 23),
>         GATE_IFR2(CLK_IFR_UART2, CLK_TOP_UART_SEL, 24),
>         GATE_IFR2(CLK_IFR_DSP_UART, CLK_TOP_UART_SEL, 26),
> -       GATE_IFR2(CLK_IFR_GCE_26M, CLK_TOP_CLK26M, 27),
> +       GATE_IFR2_EXT(CLK_IFR_GCE_26M, CLK_PAD_CLK26M, 27),
>         GATE_IFR2(CLK_IFR_CQ_DMA_FPC, CLK_TOP_AXI_SEL, 28),
>         GATE_IFR2(CLK_IFR_BTIF, CLK_TOP_AXI_SEL, 31),
>         /* IFR3 */
> @@ -806,19 +703,19 @@ static const struct mtk_gate ifr_clks[] =3D {
>         GATE_IFR3(CLK_IFR_MSDC0_HCLK, CLK_TOP_AXI_SEL, 2),
>         GATE_IFR3(CLK_IFR_MSDC2_HCLK, CLK_TOP_AXI_SEL, 3),
>         GATE_IFR3(CLK_IFR_MSDC1_HCLK, CLK_TOP_AXI_SEL, 4),
> -       GATE_IFR3(CLK_IFR_DVFSRC, CLK_TOP_CLK26M, 7),
> +       GATE_IFR3_EXT(CLK_IFR_DVFSRC, CLK_PAD_CLK26M, 7),
>         GATE_IFR3(CLK_IFR_GCPU, CLK_TOP_AXI_SEL, 8),
>         GATE_IFR3(CLK_IFR_TRNG, CLK_TOP_AXI_SEL, 9),
> -       GATE_IFR3(CLK_IFR_AUXADC, CLK_TOP_CLK26M, 10),
> +       GATE_IFR3_EXT(CLK_IFR_AUXADC, CLK_PAD_CLK26M, 10),
>         GATE_IFR3(CLK_IFR_CPUM, CLK_TOP_AXI_SEL, 11),
> -       GATE_IFR3(CLK_IFR_AUXADC_MD, CLK_TOP_CLK26M, 14),
> +       GATE_IFR3_EXT(CLK_IFR_AUXADC_MD, CLK_PAD_CLK26M, 14),
>         GATE_IFR3(CLK_IFR_AP_DMA, CLK_TOP_AXI_SEL, 18),
>         GATE_IFR3(CLK_IFR_DEBUGSYS, CLK_TOP_AXI_SEL, 24),
>         GATE_IFR3(CLK_IFR_AUDIO, CLK_TOP_AXI_SEL, 25),
>         /* IFR4 */
>         GATE_IFR4(CLK_IFR_PWM_FBCLK6, CLK_TOP_PWM_SEL, 0),
>         GATE_IFR4(CLK_IFR_DISP_PWM, CLK_TOP_DISP_PWM_SEL, 2),
> -       GATE_IFR4(CLK_IFR_AUD_26M_BK, CLK_TOP_CLK26M, 4),
> +       GATE_IFR4_EXT(CLK_IFR_AUD_26M_BK, CLK_PAD_CLK26M, 4),
>         GATE_IFR4(CLK_IFR_CQ_DMA, CLK_TOP_AXI_SEL, 27),
>         /* IFR5 */
>         GATE_IFR5(CLK_IFR_MSDC0_SF, CLK_TOP_MSDC50_0_SEL, 0),
> @@ -829,12 +726,12 @@ static const struct mtk_gate ifr_clks[] =3D {
>         GATE_IFR5(CLK_IFR_MSDC0_SRC, CLK_TOP_MSDC50_0_SEL, 9),
>         GATE_IFR5(CLK_IFR_MSDC1_SRC, CLK_TOP_MSDC30_1_SEL, 10),
>         GATE_IFR5(CLK_IFR_MSDC2_SRC, CLK_TOP_MSDC50_2_SEL, 11),
> -       GATE_IFR5(CLK_IFR_PWRAP_TMR, CLK_TOP_CLK26M, 12),
> -       GATE_IFR5(CLK_IFR_PWRAP_SPI, CLK_TOP_CLK26M, 13),
> -       GATE_IFR5(CLK_IFR_PWRAP_SYS, CLK_TOP_CLK26M, 14),
> +       GATE_IFR5_EXT(CLK_IFR_PWRAP_TMR, CLK_PAD_CLK26M, 12),
> +       GATE_IFR5_EXT(CLK_IFR_PWRAP_SPI, CLK_PAD_CLK26M, 13),
> +       GATE_IFR5_EXT(CLK_IFR_PWRAP_SYS, CLK_PAD_CLK26M, 14),
>         GATE_IFR5(CLK_IFR_MCU_PM_BK, CLK_TOP_AXI_SEL, 16),
> -       GATE_IFR5(CLK_IFR_IRRX_26M, CLK_TOP_CLK26M, 22),
> -       GATE_IFR5(CLK_IFR_IRRX_32K, CLK_TOP_CLK32K, 23),
> +       GATE_IFR5_EXT(CLK_IFR_IRRX_26M, CLK_PAD_CLK26M, 22),
> +       GATE_IFR5_EXT(CLK_IFR_IRRX_32K, CLK_PAD_CLK32K, 23),
>         GATE_IFR5(CLK_IFR_I2C0_AXI, CLK_TOP_I2C_SEL, 24),
>         GATE_IFR5(CLK_IFR_I2C1_AXI, CLK_TOP_I2C_SEL, 25),
>         GATE_IFR5(CLK_IFR_I2C2_AXI, CLK_TOP_I2C_SEL, 26),
> @@ -859,6 +756,8 @@ static const struct mtk_gate ifr_clks[] =3D {
>
>  static const struct mtk_clk_tree mt8365_infracfg_tree =3D {
>         .xtal_rate =3D 26 * MHZ,
> +       .ext_clk_rates =3D ext_clk_rates,
> +       .num_ext_clks =3D ARRAY_SIZE(ext_clk_rates),
>  };
>
>  static int mt8365_apmixedsys_probe(struct udevice *dev)
>
> ---
> base-commit: 5f01b24d93976de4d38656df24fcc4f56869753d
> change-id: 20260302-mtk-clk-8365-drop-map-eef332876f99
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

Thanks
Julien
