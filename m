Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA5C021A8
	for <u-boot@archiver.kernel.org>; Sat, 14 Sep 2024 17:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7733B88C71;
	Sat, 14 Sep 2024 19:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nce43wgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EBA885C5; Sat, 14 Sep 2024 19:33:30 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DB288C71
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 19:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2db89fb53f9so2194092a91.3
 for <u-boot@lists.denx.de>; Sat, 14 Sep 2024 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726335206; x=1726940006; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LLUe6HAyYqoGg4c4vRtN51SKGRuZXVUO1kLtNQvS1Q=;
 b=Nce43wgXkXYYdT6Lquywd+5KzLcp5tFxzlVdQPk9t69v2LKNRETxNYoXj6Zd5f2OS1
 WALwWzYFKYdWwZ+qZLf1Uyy6DHNVz023UuRDVRn/VEwVchKzRTfFsvWudkVg8/5MPtms
 Wa/GwPkd3Vo5xtkrVcDaSNEV4mjz/p2sHYp/5MSCQE75U9tWcY0FWYNJonz6iCOHyYFO
 B4L/bJfphDnNhKP8aS/f4Q0AR5B4yFCUTNzVhGAvgIS3DayEFk/6mh2mVc5/1fngvA8w
 Z/tfRafWFY+/Vc0tX0vj6kt/Z6CicZBxNAt1mzTnOrp/vap6c3NIhTc32aoGqAPvH3xs
 Y4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726335206; x=1726940006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LLUe6HAyYqoGg4c4vRtN51SKGRuZXVUO1kLtNQvS1Q=;
 b=pr4A8Cg25sdCf5ehlVFzzskkjjVu28KFKuynNS0oVZ/q4tlbxao/JSV0cKHhOXWNMF
 qkBaZbDPzh0naAeNd2YSc0qLEFbvsoVOdBAUneSe03YysrQIceg8+iLcfHMw7Bad9J8N
 taOh1Cr1YA4Y0UPwi++OukfcOsnnI3VOT2s0ugU+x5PRohyjLWTGVrbHBdvp34ZrnQCZ
 KNtS5R4eCf34h0pC7ml+iYQr/Ix+qpVXR8pLgcm/m9bGYMTLgTQjF7AgLhyh0Kat++4C
 HwgXUK7i3MY0H+HPmBorpmXKLxZzKenjXg0smpBFAIkBX7H85kvH5SvLEtCqfn0yARXu
 Md0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBpHEM07Smpj8UhYTbNiluq7uFDPN5CqWttEnMi02lSDkrGjFn8SFRael1CS+Qt1n+c7qHYEE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+gcUCOIMF8iwVsEmGUHkWHrtGyUyDI3Q8Aw8mR4xSNB3RqsuP
 dz60IiQbVzzOhvYl/USb20XZ3SfiTp3uzTkd5IG8oOHrqVcGG1Z62zTcTiNvT50a7dZaiFJhDbZ
 JdZsZjObrSDpZDfwlu7HjWWDo0Cg=
X-Google-Smtp-Source: AGHT+IEiibCUN8bQ0nxD/59p+rbUJPoSNh0mcjZAzhbEeRoutjYeMwQKgiweeNrFgEIJlqYMIfMXK0htqSooXAt3PDQ=
X-Received: by 2002:a17:90b:1c07:b0:2d3:da82:28e0 with SMTP id
 98e67ed59e1d1-2db9ffc1c9fmr10861108a91.9.1726335205802; Sat, 14 Sep 2024
 10:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-4-miquel.raynal@bootlin.com>
In-Reply-To: <20240910101344.110633-4-miquel.raynal@bootlin.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 14 Sep 2024 12:33:14 -0500
Message-ID: <CAHCN7x+ibBpGKV2c6p4DhHArxXzCCbbQw21tj+CB+A29eG2-gg@mail.gmail.com>
Subject: Re: [PATCH 3/8] clk: imx8mp: Add media related clocks
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>
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

On Tue, Sep 10, 2024 at 5:14=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> These are all the clocks needed to get an LCD panel working, going
> through one of the LCDIF and the LDB. The media AXI and APB clocks are
> also described.

Are these clocks going to be enumerated in SPL?  I am concerned it
might bloat the SPL phase if they do.  If that's the case, can we
encapsulate these new clocks inside #if config_is_enabled() so they
are only enabled when needed?

adam
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/clk/imx/clk-imx8mp.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 7dfc829df2c..92c5d8441c0 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -15,7 +15,10 @@
>
>  #include "clk.h"
>
> +static u32 share_count_media;
> +
>  static const char *pll_ref_sels[] =3D { "clock-osc-24m", "dummy", "dummy=
", "dummy", };
> +static const char *video_pll1_bypass_sels[] =3D {"video_pll1", "video_pl=
l1_ref_sel", };
>  static const char *dram_pll_bypass_sels[] =3D {"dram_pll", "dram_pll_ref=
_sel", };
>  static const char *arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_ref_se=
l", };
>  static const char *sys_pll1_bypass_sels[] =3D {"sys_pll1", "sys_pll1_ref=
_sel", };
> @@ -42,6 +45,14 @@ static const char *imx8mp_nand_usdhc_sels[] =3D {"cloc=
k-osc-24m", "sys_pll1_266m",
>                                                "sys_pll2_200m", "sys_pll1=
_133m", "sys_pll3_out",
>                                                "sys_pll2_250m", "audio_pl=
l1_out", };
>
> +static const char *imx8mp_media_axi_sels[] =3D {"clock-osc-24m", "sys_pl=
l2_1000m", "sys_pll1_800m",
> +                                             "sys_pll3_out", "sys_pll1_4=
0m", "audio_pll2_out",
> +                                             "clk_ext1", "sys_pll2_500m"=
, };
> +
> +static const char *imx8mp_media_apb_sels[] =3D {"clock-osc-24m", "sys_pl=
l2_125m", "sys_pll1_800m",
> +                                             "sys_pll3_out", "sys_pll1_4=
0m", "audio_pll2_out",
> +                                             "clk_ext1", "sys_pll1_133m"=
, };
> +
>  static const char *imx8mp_noc_sels[] =3D {"clock-osc-24m", "sys_pll1_800=
m", "sys_pll3_out",
>                                         "sys_pll2_1000m", "sys_pll2_500m"=
, "audio_pll1_out",
>                                         "video_pll1_out", "audio_pll2_out=
", };
> @@ -174,6 +185,15 @@ static const char *imx8mp_usdhc3_sels[] =3D {"clock-=
osc-24m", "sys_pll1_400m", "sy
>                                            "sys_pll2_500m", "sys_pll3_out=
", "sys_pll1_266m",
>                                            "audio_pll2_out", "sys_pll1_10=
0m", };
>
> +static const char *imx8mp_media_disp_pix_sels[] =3D {"clock-osc-24m", "v=
ideo_pll1_out", "audio_pll2_out",
> +                                                  "audio_pll1_out", "sys=
_pll1_800m",
> +                                                  "sys_pll2_1000m", "sys=
_pll3_out", "clk_ext4", };
> +
> +static const char *imx8mp_media_ldb_sels[] =3D {"clock-osc-24m", "sys_pl=
l2_333m", "sys_pll2_100m",
> +                                                    "sys_pll1_800m", "sy=
s_pll2_1000m",
> +                                                    "clk_ext2", "audio_p=
ll2_out",
> +                                                    "video_pll1_out", };
> +
>  static const char *imx8mp_enet_ref_sels[] =3D {"clock-osc-24m", "sys_pll=
2_125m", "sys_pll2_50m",
>                                              "sys_pll2_100m", "sys_pll1_1=
60m", "audio_pll1_out",
>                                              "video_pll1_out", "clk_ext4"=
, };
> @@ -196,12 +216,15 @@ static int imx8mp_clk_probe(struct udevice *dev)
>
>         base =3D (void *)ANATOP_BASE_ADDR;
>
> +       clk_dm(IMX8MP_VIDEO_PLL1_REF_SEL, imx_clk_mux("video_pll1_ref_sel=
", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux("dram_pll_ref_sel", b=
ase + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux("arm_pll_ref_sel", bas=
e + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux("sys_pll1_ref_sel", b=
ase + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_SYS_PLL2_REF_SEL, imx_clk_mux("sys_pll2_ref_sel", b=
ase + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>         clk_dm(IMX8MP_SYS_PLL3_REF_SEL, imx_clk_mux("sys_pll3_ref_sel", b=
ase + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
>
> +       clk_dm(IMX8MP_VIDEO_PLL1, imx_clk_pll14xx("video_pll1", "video_pl=
l1_ref_sel", base + 0x28,
> +                                                 &imx_1443x_pll));
>         clk_dm(IMX8MP_DRAM_PLL, imx_clk_pll14xx("dram_pll", "dram_pll_ref=
_sel", base + 0x50,
>                                                 &imx_1443x_dram_pll));
>         clk_dm(IMX8MP_ARM_PLL, imx_clk_pll14xx("arm_pll", "arm_pll_ref_se=
l", base + 0x84,
> @@ -213,12 +236,14 @@ static int imx8mp_clk_probe(struct udevice *dev)
>         clk_dm(IMX8MP_SYS_PLL3, imx_clk_pll14xx("sys_pll3", "sys_pll3_ref=
_sel", base + 0x114,
>                                                 &imx_1416x_pll));
>
> +       clk_dm(IMX8MP_VIDEO_PLL1_BYPASS, imx_clk_mux_flags("video_pll1_by=
pass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_by=
pass_sels), CLK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_DRAM_PLL_BYPASS, imx_clk_mux_flags("dram_pll_bypass=
", base + 0x50, 4, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels=
), CLK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_ARM_PLL_BYPASS, imx_clk_mux_flags("arm_pll_bypass",=
 base + 0x84, 4, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), C=
LK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_SYS_PLL1_BYPASS, imx_clk_mux_flags("sys_pll1_bypass=
", base + 0x94, 4, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels=
), CLK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_SYS_PLL2_BYPASS, imx_clk_mux_flags("sys_pll2_bypass=
", base + 0x104, 4, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sel=
s), CLK_SET_RATE_PARENT));
>         clk_dm(IMX8MP_SYS_PLL3_BYPASS, imx_clk_mux_flags("sys_pll3_bypass=
", base + 0x114, 4, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sel=
s), CLK_SET_RATE_PARENT));
>
> +       clk_dm(IMX8MP_VIDEO_PLL1_OUT, imx_clk_gate("video_pll1_out", "vid=
eo_pll1_bypass", base + 0x28, 13));
>         clk_dm(IMX8MP_DRAM_PLL_OUT, imx_clk_gate("dram_pll_out", "dram_pl=
l_bypass", base + 0x50, 13));
>         clk_dm(IMX8MP_ARM_PLL_OUT, imx_clk_gate("arm_pll_out", "arm_pll_b=
ypass", base + 0x84, 11));
>         clk_dm(IMX8MP_SYS_PLL1_OUT, imx_clk_gate("sys_pll1_out", "sys_pll=
1_bypass", base + 0x94, 11));
> @@ -267,10 +292,13 @@ static int imx8mp_clk_probe(struct udevice *dev)
>         clk_dm(IMX8MP_CLK_MAIN_AXI, imx8m_clk_composite_critical("main_ax=
i", imx8mp_main_axi_sels, base + 0x8800));
>         clk_dm(IMX8MP_CLK_ENET_AXI, imx8m_clk_composite_critical("enet_ax=
i", imx8mp_enet_axi_sels, base + 0x8880));
>         clk_dm(IMX8MP_CLK_NAND_USDHC_BUS, imx8m_clk_composite_critical("n=
and_usdhc_bus", imx8mp_nand_usdhc_sels, base + 0x8900));
> +       clk_dm(IMX8MP_CLK_MEDIA_AXI, imx8m_clk_composite("media_axi", imx=
8mp_media_axi_sels, base + 0x8a00));
> +       clk_dm(IMX8MP_CLK_MEDIA_APB, imx8m_clk_composite("media_apb", imx=
8mp_media_apb_sels, base + 0x8a80));
>         clk_dm(IMX8MP_CLK_NOC, imx8m_clk_composite_critical("noc", imx8mp=
_noc_sels, base + 0x8d00));
>         clk_dm(IMX8MP_CLK_NOC_IO, imx8m_clk_composite_critical("noc_io", =
imx8mp_noc_io_sels, base + 0x8d80));
>
>         clk_dm(IMX8MP_CLK_AHB, imx8m_clk_composite_critical("ahb_root", i=
mx8mp_ahb_sels, base + 0x9000));
> +       clk_dm(IMX8MP_CLK_MEDIA_DISP2_PIX, imx8m_clk_composite("media_dis=
p2_pix", imx8mp_media_disp_pix_sels, base + 0x9300));
>
>         clk_dm(IMX8MP_CLK_IPG_ROOT, imx_clk_divider2("ipg_root", "ahb_roo=
t", base + 0x9080, 0, 1));
>
> @@ -309,6 +337,8 @@ static int imx8mp_clk_probe(struct udevice *dev)
>
>         clk_dm(IMX8MP_CLK_WDOG, imx8m_clk_composite("wdog", imx8mp_wdog_s=
els, base + 0xb900));
>         clk_dm(IMX8MP_CLK_USDHC3, imx8m_clk_composite("usdhc3", imx8mp_us=
dhc3_sels, base + 0xbc80));
> +       clk_dm(IMX8MP_CLK_MEDIA_DISP1_PIX, imx8m_clk_composite("media_dis=
p1_pix", imx8mp_media_disp_pix_sels, base + 0xbe00));
> +       clk_dm(IMX8MP_CLK_MEDIA_LDB, imx8m_clk_composite("media_ldb", imx=
8mp_media_ldb_sels, base + 0xbf00));
>
>         clk_dm(IMX8MP_CLK_DRAM_ALT_ROOT, imx_clk_fixed_factor("dram_alt_r=
oot", "dram_alt", 1, 4));
>         clk_dm(IMX8MP_CLK_DRAM_CORE, imx_clk_mux2_flags("dram_core_clk", =
base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_se=
ls), CLK_IS_CRITICAL));
> @@ -352,6 +382,11 @@ static int imx8mp_clk_probe(struct udevice *dev)
>         clk_dm(IMX8MP_CLK_WDOG2_ROOT, imx_clk_gate4("wdog2_root_clk", "wd=
og", base + 0x4540, 0));
>         clk_dm(IMX8MP_CLK_WDOG3_ROOT, imx_clk_gate4("wdog3_root_clk", "wd=
og", base + 0x4550, 0));
>         clk_dm(IMX8MP_CLK_HSIO_ROOT, imx_clk_gate4("hsio_root_clk", "ipg_=
root", base + 0x45c0, 0));
> +       clk_dm(IMX8MP_CLK_MEDIA_APB_ROOT, imx_clk_gate2_shared2("media_ap=
b_root_clk", "media_apb", base + 0x45d0, 0, &share_count_media));
> +       clk_dm(IMX8MP_CLK_MEDIA_AXI_ROOT, imx_clk_gate2_shared2("media_ax=
i_root_clk", "media_axi", base + 0x45d0, 0, &share_count_media));
> +       clk_dm(IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT, imx_clk_gate2_shared2("me=
dia_disp1_pix_root_clk", "media_disp1_pix", base + 0x45d0, 0, &share_count_=
media));
> +       clk_dm(IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT, imx_clk_gate2_shared2("me=
dia_disp2_pix_root_clk", "media_disp2_pix", base + 0x45d0, 0, &share_count_=
media));
> +       clk_dm(IMX8MP_CLK_MEDIA_LDB_ROOT, imx_clk_gate2_shared2("media_ld=
b_root_clk", "media_ldb", base + 0x45d0, 0, &share_count_media));
>
>         clk_dm(IMX8MP_CLK_USDHC3_ROOT, imx_clk_gate4("usdhc3_root_clk", "=
usdhc3", base + 0x45e0, 0));
>
> --
> 2.43.0
>
