Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2635CC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3EBE88CEA;
	Sat, 20 Jul 2024 14:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bXhCJ6rn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jzVd77Zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF5788C9B; Sat, 20 Jul 2024 14:44:11 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF4F883BA
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5p10lJxz9sWw;
 Sat, 20 Jul 2024 14:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MO4Sd8u+y/mhWJXSlHf2H1enwhq9Pjsgqih0rIzFtnU=;
 b=bXhCJ6rnHNREzSNUBZrjPNit1WSy1WJjdo4VHhIubzqFqGHgvp1nUBlZcNXoPawQ4um2sO
 B+kW3CFlhTkC81envsP9Hva8ZJEMgA9JAfTrTSGtMFRj1TNHGbTda9DKqrCAH/XE2frUaD
 blvXyUhCMVH2+FVJv3n/KYF8NgrZKrY8Hd1HPfRdza5ahYI7/uMrN51a03ruwWraPLWlJZ
 jYZ83pEkL0JqayNusMf39pgYZ1bXkVTPs00XGO9xy53u+IBS/zQ/qqOaGEZG64bOJNOD9/
 Jcc6VDssF4iTFP9O5OjvZNjg9PiChPPRLD05zB9LEhNvj3XaGveg6jjhVtPvnQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MO4Sd8u+y/mhWJXSlHf2H1enwhq9Pjsgqih0rIzFtnU=;
 b=jzVd77ZidOwBWP+JVEkPQjI5Yln+hA/jfIdWfKAORgD3CWRJZekWkRHlC7ZtKyn4JiWF9s
 VS8UA3953Z6ZCkw19AeiwlWRj4TpJ/hi6mAUbTgghLoZsWcp4q+y9IvWNaCajVwsTuyIXb
 GaWg3JC4AstpNSWMp75a7kBZ6LT4PS+6ej9KB3bOs7TYhs6plesJXlWKKUgbbbajYAXPQE
 Xgbf83V4q+5JP+3J9QqtVfgEjE8BjfNyqSSV7crvtx1Xb6PXkEnYV4Ii2megYrhV2GOiaa
 RZI8BeOUe3FAovUxphXlDd1CjryZNURLMajodEXKnGNqDK1WhkgBFmnFluSkdw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 39/40] drivers: video: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:41:04 +0200
Message-ID: <20240720124239.7553-39-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3c101e95af5952776d3
X-MBO-RS-META: kt3n5xpww389qguuynsixspnugdxoaqo
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/video/broadwell_igd.c             |  1 -
 drivers/video/console_rotate.c            |  1 -
 drivers/video/dw_hdmi.c                   |  1 -
 drivers/video/exynos/exynos_dp.c          |  1 -
 drivers/video/exynos/exynos_dp_lowlevel.c |  1 -
 drivers/video/imx/ipu.h                   |  1 -
 drivers/video/imx/ipu_common.c            |  4 ----
 drivers/video/imx/ipu_regs.h              |  2 --
 drivers/video/mvebu_lcd.c                 |  1 -
 drivers/video/pwm_backlight.c             |  1 -
 drivers/video/rockchip/rk_edp.c           |  2 --
 drivers/video/rockchip/rk_mipi.h          |  1 -
 drivers/video/stb_truetype.h              | 10 ----------
 drivers/video/sunxi/tve_common.c          |  1 -
 drivers/video/tegra124/dp.c               |  1 -
 drivers/video/videomodes.h                |  1 -
 16 files changed, 30 deletions(-)

diff --git a/drivers/video/broadwell_igd.c b/drivers/video/broadwell_igd.c
index a26154ab588..03b37fd8a9e 100644
--- a/drivers/video/broadwell_igd.c
+++ b/drivers/video/broadwell_igd.c
@@ -319,7 +319,6 @@ err:
 	return ret;
 };
 
-
 static unsigned long gtt_read(struct broadwell_igd_priv *priv,
 			      unsigned long reg)
 {
diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotate.c
index dc969836274..a3f8c6352f8 100644
--- a/drivers/video/console_rotate.c
+++ b/drivers/video/console_rotate.c
@@ -100,7 +100,6 @@ static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y, int cp)
 	return VID_TO_POS(fontdata->width);
 }
 
-
 static int console_set_row_2(struct udevice *dev, uint row, int clr)
 {
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev->parent);
diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index 35559cef229..1bf65fbd89e 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -762,7 +762,6 @@ static void hdmi_audio_set_format(struct dw_hdmi *hdmi)
 	hdmi_write(hdmi, HDMI_AUD_CONF0_I2S_SELECT | HDMI_AUD_CONF0_I2S_IN_EN_0,
 		   HDMI_AUD_CONF0);
 
-
 	hdmi_write(hdmi, HDMI_AUD_CONF1_I2S_MODE_STANDARD_MODE |
 		   HDMI_AUD_CONF1_I2S_WIDTH_16BIT, HDMI_AUD_CONF1);
 
diff --git a/drivers/video/exynos/exynos_dp.c b/drivers/video/exynos/exynos_dp.c
index b0afb2338fb..d17cea396fe 100644
--- a/drivers/video/exynos/exynos_dp.c
+++ b/drivers/video/exynos/exynos_dp.c
@@ -1064,7 +1064,6 @@ int exynos_dp_enable(struct udevice *dev, int panel_bpp,
 	return ret;
 }
 
-
 static const struct dm_display_ops exynos_dp_ops = {
 	.enable = exynos_dp_enable,
 };
diff --git a/drivers/video/exynos/exynos_dp_lowlevel.c b/drivers/video/exynos/exynos_dp_lowlevel.c
index f007b319b20..552524d838d 100644
--- a/drivers/video/exynos/exynos_dp_lowlevel.c
+++ b/drivers/video/exynos/exynos_dp_lowlevel.c
@@ -65,7 +65,6 @@ void exynos_dp_enable_video_mute(struct exynos_dp *dp_regs, unsigned int enable)
 	return;
 }
 
-
 static void exynos_dp_init_analog_param(struct exynos_dp *dp_regs)
 {
 	unsigned int reg;
diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index 1e02c7ab6d5..4c13c9342f7 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -143,7 +143,6 @@ enum ipu_dmfc_type {
 	DMFC_HIGH_RESOLUTION_ONLY_DP,
 };
 
-
 /*
  * Union of initialization parameters for a logical channel.
  */
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index d582fb8ad9d..bd1ef0a800d 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -204,7 +204,6 @@ static void clk_ipu_disable(struct clk *clk)
 #endif
 }
 
-
 static struct clk ipu_clk = {
 	.name = "ipu_clk",
 #if defined(CONFIG_MX51) || defined(CONFIG_MX53)
@@ -272,7 +271,6 @@ static inline int ipu_is_dmfc_chan(uint32_t dma_chan)
 	return ((dma_chan >= 23) && (dma_chan <= 29));
 }
 
-
 static inline void ipu_ch_param_set_buffer(uint32_t ch, int bufNum,
 					    dma_addr_t phyaddr)
 {
@@ -588,7 +586,6 @@ int32_t ipu_init_channel(ipu_channel_t channel, ipu_channel_params_t *params)
 		clk_enable(g_ipu_clk);
 	}
 
-
 	if (g_channel_init_mask & (1L << IPU_CHAN_ID(channel))) {
 		printf("Warning: channel already initialized %d\n",
 			IPU_CHAN_ID(channel));
@@ -954,7 +951,6 @@ static void ipu_ch_param_init(int ch,
 		break;
 	}
 
-
 	if (uv_stride)
 		ipu_ch_param_set_field(&params, 1, 128, 14, uv_stride - 1);
 
diff --git a/drivers/video/imx/ipu_regs.h b/drivers/video/imx/ipu_regs.h
index deb44002d75..8d6ec4845f4 100644
--- a/drivers/video/imx/ipu_regs.h
+++ b/drivers/video/imx/ipu_regs.h
@@ -353,13 +353,11 @@ struct ipu_dmfc {
 #define DMFC_GENERAL1		(&DMFC_REG->general[0])
 #define DMFC_IC_CTRL		(&DMFC_REG->ic_ctrl)
 
-
 #define DC_REG			((struct ipu_dc *)(IPU_CTRL_BASE_ADDR + \
 				IPU_DC_REG_BASE))
 #define DC_MAP_CONF_PTR(n)	(&DC_REG->dc_map_ptr[n / 2])
 #define DC_MAP_CONF_VAL(n)	(&DC_REG->dc_map_val[n / 2])
 
-
 static inline struct ipu_dc_ch *dc_ch_offset(int ch)
 {
 	switch (ch) {
diff --git a/drivers/video/mvebu_lcd.c b/drivers/video/mvebu_lcd.c
index 3fc5640b71e..9f1ea9c3564 100644
--- a/drivers/video/mvebu_lcd.c
+++ b/drivers/video/mvebu_lcd.c
@@ -334,7 +334,6 @@ static void mvebu_lcd_register_init(struct mvebu_lcd_info *lcd_info,
 	 */
 	writel(0x00000000, regs + MVEBU_LCD_SPU_SRAM_PARA1);
 
-
 	/* Clock settings in the at 01A8 and in the range F0A0 see below */
 
 	/*
diff --git a/drivers/video/pwm_backlight.c b/drivers/video/pwm_backlight.c
index a4576c888cf..1470eaf4cab 100644
--- a/drivers/video/pwm_backlight.c
+++ b/drivers/video/pwm_backlight.c
@@ -250,7 +250,6 @@ static int pwm_backlight_of_to_plat(struct udevice *dev)
 	priv->cur_level = priv->default_level;
 	log_debug("done\n");
 
-
 	return 0;
 }
 
diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
index eb881ba4b0e..0ba68dbce3d 100644
--- a/drivers/video/rockchip/rk_edp.c
+++ b/drivers/video/rockchip/rk_edp.c
@@ -72,7 +72,6 @@ static void rk_edp_init_refclk(struct rk3288_edp *regs, enum rockchip_dp_types c
 		reg ^= REF_CLK_MASK;
 	writel(reg, &regs->pll_reg_1);
 
-
 	writel(LDO_OUTPUT_V_SEL_145 | KVCO_DEFALUT | CHG_PUMP_CUR_SEL_5US |
 	       V2L_CUR_SEL_1MA, &regs->pll_reg_2);
 
@@ -314,7 +313,6 @@ static int rk_edp_dpcd_write(struct rk3288_edp *regs, u32 addr, u8 *values,
 	return rk_edp_dpcd_transfer(regs, addr, values, size, DPCD_WRITE);
 }
 
-
 static int rk_edp_link_power_up(struct rk_edp_priv *edp)
 {
 	u8 value;
diff --git a/drivers/video/rockchip/rk_mipi.h b/drivers/video/rockchip/rk_mipi.h
index 3d1e440b0ec..0d75a263e45 100644
--- a/drivers/video/rockchip/rk_mipi.h
+++ b/drivers/video/rockchip/rk_mipi.h
@@ -28,5 +28,4 @@ int rk_mipi_dsi_enable(struct udevice *dev,
 
 int rk_mipi_phy_enable(struct udevice *dev);
 
-
 #endif
diff --git a/drivers/video/stb_truetype.h b/drivers/video/stb_truetype.h
index c6973bb353c..32a7b6e1dc0 100644
--- a/drivers/video/stb_truetype.h
+++ b/drivers/video/stb_truetype.h
@@ -412,7 +412,6 @@ int main(int arg, char **argv)
 }
 #endif
 
-
 //////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////
 ////
@@ -564,7 +563,6 @@ STBTT_DEF void stbtt_GetBakedQuad(const stbtt_bakedchar *chardata, int pw, int p
 STBTT_DEF void stbtt_GetScaledFontVMetrics(const unsigned char *fontdata, int index, float size, float *ascent, float *descent, float *lineGap);
 // Query the font vertical metrics without having to create a font first.
 
-
 //////////////////////////////////////////////////////////////////////////////
 //
 // NEW TEXTURE BAKING API
@@ -737,7 +735,6 @@ STBTT_DEF int stbtt_InitFont(stbtt_fontinfo *info, const unsigned char *data, in
 // need to do anything special to free it, because the contents are pure
 // value data with no additional data structures. Returns 0 on failure.
 
-
 //////////////////////////////////////////////////////////////////////////////
 //
 // CHARACTER TO GLYPH-INDEX CONVERSIOn
@@ -749,7 +746,6 @@ STBTT_DEF int stbtt_FindGlyphIndex(const stbtt_fontinfo *info, int unicode_codep
 // codepoint-based functions.
 // Returns 0 if the character codepoint is not defined in the font.
 
-
 //////////////////////////////////////////////////////////////////////////////
 //
 // CHARACTER PROPERTIES
@@ -919,7 +915,6 @@ STBTT_DEF void stbtt_MakeGlyphBitmapSubpixelPrefilter(const stbtt_fontinfo *info
 STBTT_DEF void stbtt_GetGlyphBitmapBox(const stbtt_fontinfo *font, int glyph, float scale_x, float scale_y, int *ix0, int *iy0, int *ix1, int *iy1);
 STBTT_DEF void stbtt_GetGlyphBitmapBoxSubpixel(const stbtt_fontinfo *font, int glyph, float scale_x, float scale_y,float shift_x, float shift_y, int *ix0, int *iy0, int *ix1, int *iy1);
 
-
 // @TODO: don't expose this structure
 typedef struct
 {
@@ -994,8 +989,6 @@ STBTT_DEF unsigned char * stbtt_GetCodepointSDF(const stbtt_fontinfo *info, floa
 // The algorithm has not been optimized at all, so expect it to be slow
 // if computing lots of characters or very large sizes.
 
-
-
 //////////////////////////////////////////////////////////////////////////////
 //
 // Finding the right font...
@@ -1017,7 +1010,6 @@ STBTT_DEF unsigned char * stbtt_GetCodepointSDF(const stbtt_fontinfo *info, floa
 //             from the file yourself and do your own comparisons on them.
 //             You have to have called stbtt_InitFont() first.
 
-
 STBTT_DEF int stbtt_FindMatchingFont(const unsigned char *fontdata, const char *name, int flags);
 // returns the offset (not index) of the font that matches, or -1 if none
 //   if you use STBTT_MACSTYLE_DONTCARE, use a font name like "Arial Bold".
@@ -2809,7 +2801,6 @@ typedef struct stbtt__edge {
    int invert;
 } stbtt__edge;
 
-
 typedef struct stbtt__active_edge
 {
    struct stbtt__active_edge *next;
@@ -4970,7 +4961,6 @@ STBTT_DEF int stbtt_CompareUTF8toUTF16_bigendian(const char *s1, int len1, const
 
 #endif // STB_TRUETYPE_IMPLEMENTATION
 
-
 // FULL VERSION HISTORY
 //
 //   1.25 (2021-07-11) many fixes
diff --git a/drivers/video/sunxi/tve_common.c b/drivers/video/sunxi/tve_common.c
index 7bc2b3b2909..b3e9bd98ef1 100644
--- a/drivers/video/sunxi/tve_common.c
+++ b/drivers/video/sunxi/tve_common.c
@@ -7,7 +7,6 @@
  * (C) Copyright 2017 Jernej Skrabec <jernej.skrabec@siol.net>
  */
 
-
 #include <asm/arch/tve.h>
 #include <asm/io.h>
 
diff --git a/drivers/video/tegra124/dp.c b/drivers/video/tegra124/dp.c
index 763f7ee39fc..b95b14da77d 100644
--- a/drivers/video/tegra124/dp.c
+++ b/drivers/video/tegra124/dp.c
@@ -627,7 +627,6 @@ static int tegra_dc_dp_calc_config(struct tegra_dp_priv *dp,
 	if (link_cfg->hblank_sym < 0)
 		link_cfg->hblank_sym = 0;
 
-
 	/*
 	 * Refer to dev_disp.ref for more information.
 	 * # symbols/vblank = ((SetRasterBlankStart.X -
diff --git a/drivers/video/videomodes.h b/drivers/video/videomodes.h
index 405f4e1fc2c..3c9638670f1 100644
--- a/drivers/video/videomodes.h
+++ b/drivers/video/videomodes.h
@@ -24,7 +24,6 @@
 #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally used) */
 #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/
 
-
 /******************************************************************
  * Resolution Struct
  ******************************************************************/
-- 
2.43.0

