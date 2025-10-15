Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64861CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B7383817;
	Wed, 15 Oct 2025 17:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kDEiye+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043A48357F; Wed, 15 Oct 2025 16:32:43 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C1F835B0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 16:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so56292255e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760538760; x=1761143560; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KoOm1cjJDTzyzt43fZxwQ5sNSVmQxdz+VGsr3ZlNPrc=;
 b=kDEiye+IuStLGuT79VuemMh82XKUAz/RvfyHSgXXQsaEzeRjGvzzbpscQw+hH2AHbN
 7AGfoyFNTrcJUmXNZPt0SFu+97/mKCBljA5awB7SGE+7YBHQ5Qalz6x6JDEwTz1fdaWp
 Mcn0fl8vfuceLYD9b5GqKJzrIuy1fHn4C+eBgb6hhipG16WQ8c/oxNjfR7Z3ToDGILv+
 +SlZ1LUD+kwnj4ccppt/nrXC7t9xrbaAtwZoRd0eGapmqIMI5+QyY7XgcxDPuBRtdkVn
 vi/2lVRqlgNEjZJZZXFFXXnXJCQxjkK/lT652pQcTVQfNezoE/e0aLrN2J5GO24Wdd9w
 iatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538760; x=1761143560;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KoOm1cjJDTzyzt43fZxwQ5sNSVmQxdz+VGsr3ZlNPrc=;
 b=ajO4vAZouP8a5mEHuXN7I1fWvcTY1vS2ryAsOd461IRAQmTJkBfBE5Ob/1DuXdoRr0
 Eh3wXRjWDUKNtAQzmClMqrML+S+/N7vD67ymulMmLCnbf/ok2b/iOh+tmmPSJViZZIl4
 wqGDfOgYCl+lg4KsY22d4p6+LCgA5/T3pAqz6U3h0wxEl9bSlD8auhxSeiBSARDbgBji
 oK79uDGmQvPjcta9VT6JH3Rl8COYi5Qi/+9dkYq16GhwVjv2zb/fU2NVwazsGphoWvj5
 KvPGMUZJlroo/4lTyxLlhnFfIIXBjJXzIk/dDGJqLwJEgM7ddgDTGYP3LE4wDianNNzo
 yRqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI+pZsA6ua4YcNdvi/Bsn05yfAFGlvv7AWVMV2StwFO0V5yN8sj7n8RMXoD/UYR19Mj782Jzo=@lists.denx.de
X-Gm-Message-State: AOJu0YyygTiynv/ZUzC10RYnEUfrnHojSjLwNor+zna1UfZ8JNIYKmXB
 nIxCD293CLppa9npFaU3TkIeqLGjCOtdLXtYFdmII//2ol/teO5wcaoejKQxAzAn5hg=
X-Gm-Gg: ASbGncsDnjnIY5Z2u2Dl0nwGQaMeU3qBMzR8pzbEe0M+1TFC98BVeCbDgFFRtlo3NSb
 lxyb71jQ2Gwy1xmwkjV2MYwxkWDNHG6VUj5npM1ZiWuf6jylNk8+FMH1WTuOAFRZNvK7OsH3BUO
 zcJnhIPvYo6k3s3l4c9hMLKcEd6fW+MKM1ZyqqVXe3Fm+Ab8H/nFgy0gqa8B/Gg4jcPLutfyhWL
 TFgpYCfPhJ0+VINHu2+XYY0J4XuALV/kaDioOauEkxvDkTZWF5q/0par8xzD3MGN2uXf4nAAJ9r
 bVEKiQnR5WbkDsI6242T9GaolQ75lDEoN6lY1aUKYg9fdy0n/CKTZ68QSYMLIvugTWXCpf9iNcK
 mDy2dYiqmIa4X+s9UgenO+XTDYFgAhJTD0QQeu4vP2IgTe+Q2rnz8yhTItMMR2EbUiFBY9PATkg
 ==
X-Google-Smtp-Source: AGHT+IH6SRilvuO+S/9qch//05K26NtD74EVs5NOThPiTRFg7vOrJ4/CJT1rWgsqN1vH1AzBf4j4Bw==
X-Received: by 2002:a05:600c:1e86:b0:471:9fb:e386 with SMTP id
 5b1f17b1804b1-47109fbe4bbmr293175e9.35.1760538760020; 
 Wed, 15 Oct 2025 07:32:40 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-470ff15ef28sm43185915e9.5.2025.10.15.07.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 07:32:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 15 Oct 2025 15:32:14 +0100
Subject: [PATCH 09/24] clk: Remove negative error returns from clk_get_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clk_ops-v1-9-5f80f827407e@linaro.org>
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
In-Reply-To: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Paul Barker <paul@pbarker.dev>, uboot-snps-arc@synopsys.com, 
 Dai Okamura <okamura.dai@socionext.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 adsp-linux@analog.com, uboot-stm32@st-md-mailman.stormreply.com
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <ziyao@disroot.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Heiko Schocher <hs@nabladev.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Wed, 15 Oct 2025 17:55:48 +0200
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

clk_get_rate() returns a ulong so do not attempt to pass negative error
codes through it.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk-hsdk-cgu.c     |  2 +-
 drivers/clk/clk-uclass.c       |  4 ++--
 drivers/clk/clk_fixed_factor.c |  4 ++--
 drivers/clk/clk_k210.c         |  6 +++---
 drivers/clk/clk_sandbox.c      |  4 ++--
 drivers/clk/clk_scmi.c         |  4 ++--
 drivers/clk/clk_vexpress_osc.c |  2 +-
 drivers/clk/clk_zynq.c         |  4 ++--
 drivers/clk/clk_zynqmp.c       | 40 ++++++++++++++++++++--------------------
 9 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/clk-hsdk-cgu.c b/drivers/clk/clk-hsdk-cgu.c
index 53655059279e51d91b4fb81e43ca444c078cb956..5ec90cfa87156a401ee22ff7248d1f699e340ccd 100644
--- a/drivers/clk/clk-hsdk-cgu.c
+++ b/drivers/clk/clk-hsdk-cgu.c
@@ -703,7 +703,7 @@ static ulong hsdk_cgu_get_rate(struct clk *sclk)
 	struct hsdk_cgu_clk *clk = dev_get_priv(sclk->dev);
 
 	if (hsdk_prepare_clock_tree_branch(sclk))
-		return -EINVAL;
+		return 0;
 
 	return clk->map[sclk->id].get_rate(sclk);
 }
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3dbe1ce9441ca513d41be90520ff175c96b4253a..b2d5b883ad6fdbdc7d0b15d928a5b990193360c9 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -525,11 +525,11 @@ ulong clk_get_parent_rate(struct clk *clk)
 
 	pclk = clk_get_parent(clk);
 	if (IS_ERR(pclk))
-		return -ENODEV;
+		return 0;
 
 	ops = clk_dev_ops(pclk->dev);
 	if (!ops->get_rate)
-		return -ENOSYS;
+		return 0;
 
 	/* Read the 'rate' if not already set or if proper flag set*/
 	if (!pclk->rate || pclk->flags & CLK_GET_RATE_NOCACHE)
diff --git a/drivers/clk/clk_fixed_factor.c b/drivers/clk/clk_fixed_factor.c
index 1d740cf49f6277233f8403f85ab78daeae904c28..36fcecc44cb2aa4c9f0760156fc3f38e3cf14f65 100644
--- a/drivers/clk/clk_fixed_factor.c
+++ b/drivers/clk/clk_fixed_factor.c
@@ -28,8 +28,8 @@ static ulong clk_fixed_factor_get_rate(struct clk *clk)
 	struct clk_fixed_factor *ff = to_clk_fixed_factor(clk->dev);
 
 	rate = clk_get_rate(&ff->parent);
-	if (IS_ERR_VALUE(rate))
-		return rate;
+	if (!rate)
+		return 0;
 
 	do_div(rate, ff->div);
 
diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
index d1a6cde8f0f8e8ad52873caa9b52d30435d472f5..52667f02e1c172b1f150a965f71fe961dab096b4 100644
--- a/drivers/clk/clk_k210.c
+++ b/drivers/clk/clk_k210.c
@@ -1049,8 +1049,8 @@ static ulong do_k210_clk_get_rate(struct k210_clk_priv *priv, int id)
 
 	parent = k210_clk_get_parent(priv, id);
 	parent_rate = do_k210_clk_get_rate(priv, parent);
-	if (IS_ERR_VALUE(parent_rate))
-		return parent_rate;
+	if (!parent_rate)
+		return 0;
 
 	if (k210_clks[id].flags & K210_CLKF_PLL)
 		return k210_pll_get_rate(priv, k210_clks[id].pll, parent_rate);
@@ -1075,7 +1075,7 @@ static ulong do_k210_clk_get_rate(struct k210_clk_priv *priv, int id)
 		return parent_rate / (2 << val);
 	default:
 		assert(false);
-		return -EINVAL;
+		return 0;
 	};
 }
 
diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
index c8c5a88c52d985632733030b0cb92970920a5fc5..722e1d7133b60887bb302d25ac34065ba9ebccfb 100644
--- a/drivers/clk/clk_sandbox.c
+++ b/drivers/clk/clk_sandbox.c
@@ -16,10 +16,10 @@ static ulong sandbox_clk_get_rate(struct clk *clk)
 	ulong id = clk_get_id(clk);
 
 	if (!priv->probed)
-		return -ENODEV;
+		return 0;
 
 	if (id >= SANDBOX_CLK_ID_COUNT)
-		return -EINVAL;
+		return 0;
 
 	return priv->rate[id];
 }
diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index a7d89f32cd7c97a0ede1995612ce0b7302d06392..93ca81f7c008eb5da860ef22285f8adb81849872 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -211,11 +211,11 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 
 	ret = devm_scmi_process_msg(clk->dev, &msg);
 	if (ret < 0)
-		return ret;
+		return 0;
 
 	ret = scmi_to_linux_errno(out.status);
 	if (ret < 0)
-		return ret;
+		return 0;
 
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
diff --git a/drivers/clk/clk_vexpress_osc.c b/drivers/clk/clk_vexpress_osc.c
index 85ac92c908a7382963cf861252211d597cfddbe8..79ff003aa8f623142e3ec05098fdd1a10610f4fb 100644
--- a/drivers/clk/clk_vexpress_osc.c
+++ b/drivers/clk/clk_vexpress_osc.c
@@ -32,7 +32,7 @@ static ulong vexpress_osc_clk_get_rate(struct clk *clk)
 	data = CLK_FUNCTION | priv->osc;
 	err = misc_read(vexpress_cfg, 0, &data, sizeof(data));
 	if (err < 0)
-		return err;
+		return 0;
 
 	return data;
 }
diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index a8505f62bbadf917254f8098a3565654db0511c4..ca5c476f1a811356555e96e0f95b988a76f197cb 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -283,7 +283,7 @@ static ulong zynq_clk_get_gem_rate(struct zynq_clk_priv *priv, enum zynq_clk id)
 	debug("%s: gem%d emio rx clock source unknown\n", __func__,
 	      id - gem0_clk);
 
-	return -ENOSYS;
+	return 0;
 }
 
 static unsigned long zynq_clk_calc_peripheral_two_divs(ulong rate,
@@ -398,7 +398,7 @@ static ulong zynq_clk_get_rate(struct clk *clk)
 	case usb0_aper_clk ... swdt_clk:
 		return zynq_clk_get_cpu_rate(priv, cpu_1x_clk);
 	default:
-		return -ENXIO;
+		return 0;
 	}
 }
 
diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 7a433a667a49510ccaf712fa97ad4386634a85e6..ceaedd074f10ea0fb0f6acd27f17a0d953c86cd4 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -382,7 +382,7 @@ static ulong zynqmp_clk_get_pll_rate(struct zynqmp_clk_priv *priv,
 	ret = zynqmp_mmio_read(zynqmp_clk_get_register(id), &clk_ctrl);
 	if (ret) {
 		printf("%s mio read fail\n", __func__);
-		return -EIO;
+		return 0;
 	}
 
 	if (clk_ctrl & PLLCTRL_BYPASS_MASK)
@@ -409,7 +409,7 @@ static ulong zynqmp_clk_get_pll_rate(struct zynqmp_clk_priv *priv,
 		ret = zynqmp_mmio_read(dpll_lpd_reg, &cross_div);
 		if (ret) {
 			printf("%s mio read fail\n", __func__);
-			return -EIO;
+			return 0;
 		}
 
 		cross_div = (cross_div & PLL_TO_LPD_DIV_MASK) >>
@@ -431,7 +431,7 @@ static ulong zynqmp_clk_get_cpu_rate(struct zynqmp_clk_priv *priv,
 	ret = zynqmp_mmio_read(CRF_APB_ACPU_CTRL, &clk_ctrl);
 	if (ret) {
 		printf("%s mio read fail\n", __func__);
-		return -EIO;
+		return 0;
 	}
 
 	div = (clk_ctrl & CLK_CTRL_DIV0_MASK) >> CLK_CTRL_DIV0_SHIFT;
@@ -439,8 +439,8 @@ static ulong zynqmp_clk_get_cpu_rate(struct zynqmp_clk_priv *priv,
 	srcsel = clk_ctrl & CLK_CTRL_SRCSEL_MASK;
 	pll = pll_src[ACPU_CLK_SRC][srcsel];
 	pllrate = zynqmp_clk_get_pll_rate(priv, pll);
-	if (IS_ERR_VALUE(pllrate))
-		return pllrate;
+	if (!pllrate)
+		return 0;
 
 	return DIV_ROUND_CLOSEST(pllrate, div);
 }
@@ -455,7 +455,7 @@ static ulong zynqmp_clk_get_ddr_rate(struct zynqmp_clk_priv *priv)
 	ret = zynqmp_mmio_read(CRF_APB_DDR_CTRL, &clk_ctrl);
 	if (ret) {
 		printf("%s mio read fail\n", __func__);
-		return -EIO;
+		return 0;
 	}
 
 	div = (clk_ctrl & CLK_CTRL_DIV0_MASK) >> CLK_CTRL_DIV0_SHIFT;
@@ -463,8 +463,8 @@ static ulong zynqmp_clk_get_ddr_rate(struct zynqmp_clk_priv *priv)
 	srcsel = clk_ctrl & CLK_CTRL_SRCSEL_MASK;
 	pll = pll_src[DDR_CLK_SRC][srcsel];
 	pllrate = zynqmp_clk_get_pll_rate(priv, pll);
-	if (IS_ERR_VALUE(pllrate))
-		return pllrate;
+	if (!pllrate)
+		return 0;
 
 	return DIV_ROUND_CLOSEST(pllrate, div);
 }
@@ -479,14 +479,14 @@ static ulong zynqmp_clk_get_dll_rate(struct zynqmp_clk_priv *priv)
 	ret = zynqmp_mmio_read(CRL_APB_DLL_REF_CTRL, &clk_ctrl);
 	if (ret) {
 		printf("%s mio read fail\n", __func__);
-		return -EIO;
+		return 0;
 	}
 
 	srcsel = clk_ctrl & CLK_CTRL_SRCSEL_MASK;
 	pll = pll_src[DLL_CLK_SRC][srcsel];
 	pllrate = zynqmp_clk_get_pll_rate(priv, pll);
-	if (IS_ERR_VALUE(pllrate))
-		return pllrate;
+	if (!pllrate)
+		return 0;
 
 	return pllrate;
 }
@@ -503,7 +503,7 @@ static ulong zynqmp_clk_get_peripheral_rate(struct zynqmp_clk_priv *priv,
 	ret = zynqmp_mmio_read(zynqmp_clk_get_register(id), &clk_ctrl);
 	if (ret) {
 		printf("%s mio read fail\n", __func__);
-		return -EIO;
+		return 0;
 	}
 
 	div0 = (clk_ctrl & CLK_CTRL_DIV0_MASK) >> CLK_CTRL_DIV0_SHIFT;
@@ -523,8 +523,8 @@ static ulong zynqmp_clk_get_peripheral_rate(struct zynqmp_clk_priv *priv,
 		pll = pll_src[PERI_CLK_SRC][srcsel];
 
 	pllrate = zynqmp_clk_get_pll_rate(priv, pll);
-	if (IS_ERR_VALUE(pllrate))
-		return pllrate;
+	if (!pllrate)
+		return 0;
 
 	return
 		DIV_ROUND_CLOSEST(
@@ -543,7 +543,7 @@ static ulong zynqmp_clk_get_crf_crl_rate(struct zynqmp_clk_priv *priv,
 	ret = zynqmp_mmio_read(zynqmp_clk_get_register(id), &clk_ctrl);
 	if (ret) {
 		printf("%d %s mio read fail\n", __LINE__, __func__);
-		return -EIO;
+		return 0;
 	}
 
 	div0 = (clk_ctrl & CLK_CTRL_DIV0_MASK) >> CLK_CTRL_DIV0_SHIFT;
@@ -586,13 +586,13 @@ static ulong zynqmp_clk_get_crf_crl_rate(struct zynqmp_clk_priv *priv,
 		pll = pll_src[CPU_R5_CLK_SRC][srcsel];
 		break;
 	default:
-		return -ENXIO;
+		return 0;
 	}
 	if (two_divs) {
 		ret = zynqmp_mmio_read(zynqmp_clk_get_register(pll), &clk_ctrl);
 		if (ret) {
 			printf("%d %s mio read fail\n", __LINE__, __func__);
-			return -EIO;
+			return 0;
 		}
 		div1 = (clk_ctrl & CLK_CTRL_DIV0_MASK) >> CLK_CTRL_DIV0_SHIFT;
 		if (!div1)
@@ -603,8 +603,8 @@ static ulong zynqmp_clk_get_crf_crl_rate(struct zynqmp_clk_priv *priv,
 		pll = iopll;
 
 	pllrate = zynqmp_clk_get_pll_rate(priv, pll);
-	if (IS_ERR_VALUE(pllrate))
-		return pllrate;
+	if (!pllrate)
+		return 0;
 
 	return
 		DIV_ROUND_CLOSEST(
@@ -729,7 +729,7 @@ static ulong zynqmp_clk_get_rate(struct clk *clk)
 	case gdma_ref ... dpdma_ref:
 		return zynqmp_clk_get_crf_crl_rate(priv, id, two_divs);
 	default:
-		return -ENXIO;
+		return 0;
 	}
 }
 

-- 
2.47.3

