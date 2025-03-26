Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A52C3600B
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 15:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4D381253;
	Wed, 26 Mar 2025 16:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Re1XMBnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A92BB81951; Wed, 26 Mar 2025 16:40:02 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA37A8070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso9671343a91.3
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743003598; x=1743608398; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0TGp6y1MqvI6pF4XykIs3KFz+PDw4DdftaVrhgjDN8=;
 b=Re1XMBnPpR3FxFSvXhoaziRi/xQXK1/sKjjwXRnWYTDPBB7+2yC6QutfSJSqnGBEID
 S6fhL7BbkvZt801YF/A16meM1vVReC/xZB3coO9RB+obWTkkJHpgisKdm1/i7rxt872e
 5jAx86RhSICmnUpiGErUtQy81a3I/fpaYZ8tkbZfQYUJRpaaWzjm+aTKeqycNu3EBAci
 6O+h31gI36E6K55VrfH1wiCnBB+r0ufasYnK/fg5q8iBLf8N1jEPfIMByaiihhaN49Vs
 ikQQUFFVj+Ui0eL19CAyXWc0Ft8rID1I7kYgV51SPJXVUVRVgyojxe8bLqy7BOCXYggw
 y9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743003598; x=1743608398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0TGp6y1MqvI6pF4XykIs3KFz+PDw4DdftaVrhgjDN8=;
 b=TS9V8gU+LoT9FiQDaqETrc/ATGhE2AwmVc1kuWJSXzEQLWa2R1NmNL1p1TVhqkuCA9
 VEW/Un5SAqagbmF63CwphevLDKZt5QOL0STFsgvIhFzdlLtkfI2E/PtkZvEkYJW3OAol
 YCuVzFwkZ1j34fpGtSlIKW664BvIiv2Hz9FiLQepkPTcTGb85I/LZw2NUybVbUUpKrMv
 NczAEkhz9bQPsO3eal+wU7rkoH/1zhWYgxXjCDRZbgvWhQ7Cowc7AXEmK2ICeCXxa+Q/
 LFT17IAe+/S2hcSba/TWhEFiJsgzLi9ntEjkeXYe0o6bXKIExgG+86GEy7RbXclv4CGY
 lxrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPTqYF+r24YmS/UTv3lYLY/OJYroNyxfzkNFjWzgCiNcfts+kc/og8Z2lYC3wX2cgm/8Uv060=@lists.denx.de
X-Gm-Message-State: AOJu0YxDLn5wL4gXtukeiHGdc75i2vmq6AXgbVGV25ai6LdQ7hY4Anen
 HeMSzNCT6SIhEFul3qXiHtF5Prz66VvU1Vgglk9KxBy8TfBID0QUO2eq1YrRKXYkD0LjBbw1XsI
 6cDxB408QkKI97COjJH4bq+icaXg=
X-Gm-Gg: ASbGncuq7VGyluBWSUAJZSCULKOlYx6upTypm+gnRRkcb8sDypneIMQPgsAy9Wt1qFy
 JxAg8IX2lRTrXwQYK0ZsJVXRQgko8cEXPkRyaAn4lFqRBXd+wyOq/ermc8Ai07h98N7Ed4ow9ZP
 cQ155XcLNX9dZhKjmRhguz2T3cGw==
X-Google-Smtp-Source: AGHT+IFJaSMY1GvcOK9Rm7ZKdtecQJ/Yfh4GlzdbsEXA3KS/27lFuAy0AkKcDBFo3fbsnpMwcZadbwHaqDfusQn5wFI=
X-Received: by 2002:a17:90b:2e8d:b0:2fa:e9b:33b3 with SMTP id
 98e67ed59e1d1-303a7c5b918mr173011a91.6.1743003597399; Wed, 26 Mar 2025
 08:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
 <20250326-ge-mainline-display-support-v5-7-ea4bc3fc9bca@bootlin.com>
In-Reply-To: <20250326-ge-mainline-display-support-v5-7-ea4bc3fc9bca@bootlin.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 26 Mar 2025 10:39:44 -0500
X-Gm-Features: AQ5f1JrZsR7BejYzwDlM1GKj7ezDmO0vPXbkeorKrtXFaYjA9qFnZ69LGrT6bJM
Message-ID: <CAHCN7xLSWwY8Ffi2FVS3fh99wbR5dASLokU2DvAmwdQzwHA7ow@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] clk: imx8mp: Add media related clocks
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Fabio Estevm <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>
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

On Wed, Mar 26, 2025 at 10:01=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> These are all the clocks needed to get an LCD panel working, going
> through one of the LCDIF and the LDB. The media AXI and APB clocks are
> also described.
>

You might need to rebase off the 'next' branch.  Marek V submitted a
bunch of clock changes that slightly tweak the way clocks are
registered and it impacts the parent-child stuff.  I am not sure this
will apply cleanly anymore.

adam

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/imx/clk-imx8mp.c | 69 ++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index bad579f8d5e47fcf078c6ca25e651ddc00fcb30f..f3c8ecf3a2080e74e6a108b99=
5fbdd3ea2aa7b91 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -14,7 +14,14 @@
>
>  #include "clk.h"
>
> +#if CONFIG_IS_ENABLED(VIDEO)
> +static u32 share_count_media;
> +#endif
> +
>  static const char * const pll_ref_sels[] =3D { "osc_24m", "dummy", "dumm=
y", "dummy", };
> +#if CONFIG_IS_ENABLED(VIDEO)
> +static const char * const video_pll1_bypass_sels[] =3D {"video_pll1", "v=
ideo_pll1_ref_sel", };
> +#endif
>  static const char * const dram_pll_bypass_sels[] =3D {"dram_pll", "dram_=
pll_ref_sel", };
>  static const char * const arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll=
_ref_sel", };
>  static const char * const sys_pll1_bypass_sels[] =3D {"sys_pll1", "sys_p=
ll1_ref_sel", };
> @@ -31,6 +38,12 @@ static const char * const imx8mp_hsio_axi_sels[] =3D {=
"osc_24m", "sys_pll2_500m",
>                                                     "sys_pll2_100m", "sys=
_pll2_200m", "clk_ext2",
>                                                     "clk_ext4", "audio_pl=
l2_out", };
>
> +#if CONFIG_IS_ENABLED(VIDEO)
> +static const char * const imx8mp_media_isp_sels[] =3D {"clock-osc-24m", =
"sys_pll2_1000m", "sys_pll1_800m",
> +                                                    "sys_pll3_out", "sys=
_pll1_400m", "audio_pll2_out",
> +                                                    "clk_ext1", "sys_pll=
2_500m", };
> +#endif
> +
>  static const char * const imx8mp_main_axi_sels[] =3D {"osc_24m", "sys_pl=
l2_333m", "sys_pll1_800m",
>                                                     "sys_pll2_250m", "sys=
_pll2_1000m", "audio_pll1_out",
>                                                     "video_pll1_out", "sy=
s_pll1_100m",};
> @@ -43,6 +56,16 @@ static const char * const imx8mp_nand_usdhc_sels[] =3D=
 {"osc_24m", "sys_pll1_266m"
>                                                       "sys_pll2_200m", "s=
ys_pll1_133m", "sys_pll3_out",
>                                                       "sys_pll2_250m", "a=
udio_pll1_out", };
>
> +#if CONFIG_IS_ENABLED(VIDEO)
> +static const char * const imx8mp_media_axi_sels[] =3D {"clock-osc-24m", =
"sys_pll2_1000m", "sys_pll1_800m",
> +                                                    "sys_pll3_out", "sys=
_pll1_40m", "audio_pll2_out",
> +                                                    "clk_ext1", "sys_pll=
2_500m", };
> +
> +static const char * const imx8mp_media_apb_sels[] =3D {"clock-osc-24m", =
"sys_pll2_125m", "sys_pll1_800m",
> +                                             "sys_pll3_out", "sys_pll1_4=
0m", "audio_pll2_out",
> +                                             "clk_ext1", "sys_pll1_133m"=
, };
> +#endif
> +
>  static const char * const imx8mp_noc_sels[] =3D {"osc_24m", "sys_pll1_80=
0m", "sys_pll3_out",
>                                                "sys_pll2_1000m", "sys_pll=
2_500m", "audio_pll1_out",
>                                                "video_pll1_out", "audio_p=
ll2_out", };
> @@ -175,6 +198,17 @@ static const char * const imx8mp_usdhc3_sels[] =3D {=
"osc_24m", "sys_pll1_400m", "s
>                                                   "sys_pll2_500m", "sys_p=
ll3_out", "sys_pll1_266m",
>                                                   "audio_pll2_out", "sys_=
pll1_100m", };
>
> +#if CONFIG_IS_ENABLED(VIDEO)
> +static const char * const imx8mp_media_disp_pix_sels[] =3D {"clock-osc-2=
4m", "video_pll1_out", "audio_pll2_out",
> +                                                         "audio_pll1_out=
", "sys_pll1_800m",
> +                                                         "sys_pll2_1000m=
", "sys_pll3_out", "clk_ext4", };
> +
> +static const char * const imx8mp_media_ldb_sels[] =3D {"clock-osc-24m", =
"sys_pll2_333m", "sys_pll2_100m",
> +                                                    "sys_pll1_800m", "sy=
s_pll2_1000m",
> +                                                    "clk_ext2", "audio_p=
ll2_out",
> +                                                    "video_pll1_out", };
> +#endif
> +
>  static const char * const imx8mp_enet_ref_sels[] =3D {"osc_24m", "sys_pl=
l2_125m", "sys_pll2_50m",
>                                                     "sys_pll2_100m", "sys=
_pll1_160m", "audio_pll1_out",
>                                                     "video_pll1_out", "cl=
k_ext4", };
> @@ -199,12 +233,19 @@ static int imx8mp_clk_probe(struct udevice *dev)
>
>         clk_dm(IMX8MP_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0=
));
>
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_VIDEO_PLL1_REF_SEL, imx_clk_mux(dev, "video_pll1_re=
f_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
> +#endif
>         clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux(dev, "dram_pll_ref_se=
l", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux(dev, "arm_pll_ref_sel"=
, base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux(dev, "sys_pll1_ref_se=
l", base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_SYS_PLL2_REF_SEL, imx_clk_mux(dev, "sys_pll2_ref_se=
l", base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_SYS_PLL3_REF_SEL, imx_clk_mux(dev, "sys_pll3_ref_se=
l", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_VIDEO_PLL1, imx_clk_pll14xx("video_pll1", "video_pl=
l1_ref_sel", base + 0x28,
> +                                                 &imx_1443x_pll));
> +#endif
>         clk_dm(IMX8MP_DRAM_PLL, imx_clk_pll14xx("dram_pll", "dram_pll_ref=
_sel", base + 0x50,
>                                                 &imx_1443x_dram_pll));
>         clk_dm(IMX8MP_ARM_PLL, imx_clk_pll14xx("arm_pll", "arm_pll_ref_se=
l", base + 0x84,
> @@ -216,12 +257,18 @@ static int imx8mp_clk_probe(struct udevice *dev)
>         clk_dm(IMX8MP_SYS_PLL3, imx_clk_pll14xx("sys_pll3", "sys_pll3_ref=
_sel", base + 0x114,
>                                                 &imx_1416x_pll));
>
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_VIDEO_PLL1_BYPASS, imx_clk_mux_flags(dev, "video_pl=
l1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pl=
l1_bypass_sels), CLK_SET_RATE_PARENT));
> +#endif
>         clk_dm(IMX8MP_DRAM_PLL_BYPASS, imx_clk_mux_flags(dev, "dram_pll_b=
ypass", base + 0x50, 4, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass=
_sels), CLK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_ARM_PLL_BYPASS, imx_clk_mux_flags(dev, "arm_pll_byp=
ass", base + 0x84, 4, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sel=
s), CLK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_SYS_PLL1_BYPASS, imx_clk_mux_flags(dev, "sys_pll1_b=
ypass", base + 0x94, 4, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass=
_sels), CLK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_SYS_PLL2_BYPASS, imx_clk_mux_flags(dev, "sys_pll2_b=
ypass", base + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypas=
s_sels), CLK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_SYS_PLL3_BYPASS, imx_clk_mux_flags(dev, "sys_pll3_b=
ypass", base + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypas=
s_sels), CLK_SET_RATE_PARENT));
>
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_VIDEO_PLL1_OUT, imx_clk_gate(dev, "video_pll1_out",=
 "video_pll1_bypass", base + 0x28, 13));
> +#endif
>         clk_dm(IMX8MP_DRAM_PLL_OUT, imx_clk_gate(dev, "dram_pll_out", "dr=
am_pll_bypass", base + 0x50, 13));
>         clk_dm(IMX8MP_ARM_PLL_OUT, imx_clk_gate(dev, "arm_pll_out", "arm_=
pll_bypass", base + 0x84, 11));
>         clk_dm(IMX8MP_SYS_PLL1_OUT, imx_clk_gate(dev, "sys_pll1_out", "sy=
s_pll1_bypass", base + 0x94, 11));
> @@ -267,13 +314,23 @@ static int imx8mp_clk_probe(struct udevice *dev)
>         clk_dm(IMX8MP_CLK_A53_DIV, imx_clk_divider2(dev, "arm_a53_div", "=
arm_a53_cg", base + 0x8000, 0, 3));
>
>         clk_dm(IMX8MP_CLK_HSIO_AXI, imx8m_clk_composite(dev, "hsio_axi", =
imx8mp_hsio_axi_sels, base + 0x8380));
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_CLK_MEDIA_ISP, imx8m_clk_composite(dev, "media_isp"=
, imx8mp_media_isp_sels, base + 0x8400));
> +#endif
>         clk_dm(IMX8MP_CLK_MAIN_AXI, imx8m_clk_composite_critical(dev, "ma=
in_axi", imx8mp_main_axi_sels, base + 0x8800));
>         clk_dm(IMX8MP_CLK_ENET_AXI, imx8m_clk_composite_critical(dev, "en=
et_axi", imx8mp_enet_axi_sels, base + 0x8880));
>         clk_dm(IMX8MP_CLK_NAND_USDHC_BUS, imx8m_clk_composite_critical(de=
v, "nand_usdhc_bus", imx8mp_nand_usdhc_sels, base + 0x8900));
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_CLK_MEDIA_AXI, imx8m_clk_composite(dev, "media_axi"=
, imx8mp_media_axi_sels, base + 0x8a00));
> +       clk_dm(IMX8MP_CLK_MEDIA_APB, imx8m_clk_composite(dev, "media_apb"=
, imx8mp_media_apb_sels, base + 0x8a80));
> +#endif
>         clk_dm(IMX8MP_CLK_NOC, imx8m_clk_composite_critical(dev, "noc", i=
mx8mp_noc_sels, base + 0x8d00));
>         clk_dm(IMX8MP_CLK_NOC_IO, imx8m_clk_composite_critical(dev, "noc_=
io", imx8mp_noc_io_sels, base + 0x8d80));
>
>         clk_dm(IMX8MP_CLK_AHB, imx8m_clk_composite_critical(dev, "ahb_roo=
t", imx8mp_ahb_sels, base + 0x9000));
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_CLK_MEDIA_DISP2_PIX, imx8m_clk_composite(dev, "medi=
a_disp2_pix", imx8mp_media_disp_pix_sels, base + 0x9300));
> +#endif
>
>         clk_dm(IMX8MP_CLK_IPG_ROOT, imx_clk_divider2(dev, "ipg_root", "ah=
b_root", base + 0x9080, 0, 1));
>
> @@ -312,6 +369,10 @@ static int imx8mp_clk_probe(struct udevice *dev)
>
>         clk_dm(IMX8MP_CLK_WDOG, imx8m_clk_composite(dev, "wdog", imx8mp_w=
dog_sels, base + 0xb900));
>         clk_dm(IMX8MP_CLK_USDHC3, imx8m_clk_composite(dev, "usdhc3", imx8=
mp_usdhc3_sels, base + 0xbc80));
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_CLK_MEDIA_DISP1_PIX, imx8m_clk_composite(dev, "medi=
a_disp1_pix", imx8mp_media_disp_pix_sels, base + 0xbe00));
> +       clk_dm(IMX8MP_CLK_MEDIA_LDB, imx8m_clk_composite(dev, "media_ldb"=
, imx8mp_media_ldb_sels, base + 0xbf00));
> +#endif
>
>         clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor(dev, "dram_=
alt_root", "dram_alt", 1, 4));
>         clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags(dev, "dram_core_c=
lk", base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_co=
re_sels), CLK_IS_CRITICAL));
> @@ -355,6 +416,14 @@ static int imx8mp_clk_probe(struct udevice *dev)
>         clk_dm(IMX8MP_CLK_WDOG2_ROOT, imx_clk_gate4(dev, "wdog2_root_clk"=
, "wdog", base + 0x4540, 0));
>         clk_dm(IMX8MP_CLK_WDOG3_ROOT, imx_clk_gate4(dev, "wdog3_root_clk"=
, "wdog", base + 0x4550, 0));
>         clk_dm(IMX8MP_CLK_HSIO_ROOT, imx_clk_gate4(dev, "hsio_root_clk", =
"ipg_root", base + 0x45c0, 0));
> +#if CONFIG_IS_ENABLED(VIDEO)
> +       clk_dm(IMX8MP_CLK_MEDIA_APB_ROOT, imx_clk_gate2_shared2(dev, "med=
ia_apb_root_clk", "media_apb", base + 0x45d0, 0, &share_count_media));
> +       clk_dm(IMX8MP_CLK_MEDIA_AXI_ROOT, imx_clk_gate2_shared2(dev, "med=
ia_axi_root_clk", "media_axi", base + 0x45d0, 0, &share_count_media));
> +       clk_dm(IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT, imx_clk_gate2_shared2(dev=
, "media_disp1_pix_root_clk", "media_disp1_pix", base + 0x45d0, 0, &share_c=
ount_media));
> +       clk_dm(IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT, imx_clk_gate2_shared2(dev=
, "media_disp2_pix_root_clk", "media_disp2_pix", base + 0x45d0, 0, &share_c=
ount_media));
> +       clk_dm(IMX8MP_CLK_MEDIA_LDB_ROOT, imx_clk_gate2_shared2(dev, "med=
ia_ldb_root_clk", "media_ldb", base + 0x45d0, 0, &share_count_media));
> +       clk_dm(IMX8MP_CLK_MEDIA_ISP_ROOT, imx_clk_gate2_shared2(dev, "med=
ia_isp_root_clk", "media_isp", base + 0x45d0, 0, &share_count_media));
> +#endif
>
>         clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4(dev, "usdhc3_root_cl=
k", "usdhc3", base + 0x45e0, 0));
>
>
> --
> 2.48.1
>
