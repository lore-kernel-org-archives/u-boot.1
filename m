Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9278C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E14E48449D;
	Thu,  7 Aug 2025 10:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQGikQv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF8783AD5; Thu,  7 Aug 2025 09:46:36 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C9883A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-313bb9b2f5bso938827a91.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552791; x=1755157591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOBy5SrrqUdP970XxqCHv/WQaNwLgUTNsaXzcrvbBoM=;
 b=aQGikQv1DYeioXMF0CIx1Bppcfz7vGCrAdqyuDux5nb5u+5E+TOSBOjLVO/go1oRb0
 XnF/3CDmmleJXpWX17hD9MecZ5j2xbcijOOUnoGLAffIanlb74nKw5S2Z8a5s4Cuztqy
 xQYAg9OareifLyhOuRM4av5RB+A9MqYyfjjcbG61v/ZaXMwBaJtkiDhRCp9PVB2xrIt0
 gfGMLOeDcUDGYsGdrkTXfcAXny7DoefzYgaUjIoXLN/Y484dp08JIYIRMWgdvqJfXqlv
 /QdZRxfZQO+TS+Q1wUOrcoF1zZWYk7+P5zNRqvtzei0Veiud6DbjFM7vjtDBRe5P4ZmL
 CcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552791; x=1755157591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOBy5SrrqUdP970XxqCHv/WQaNwLgUTNsaXzcrvbBoM=;
 b=tx0H47HrJDIoF14+2F8gIY8SlEUc8VysKefJdtHk3WNqVFfhZ5aNRLuyyfbM3tOMzI
 Ss0rbgu0aY+QVosdCEAmZ/tptSHidfqNtmKfItCOoIhxqvPODcGrJYnyIao3zajN57La
 YZqLvBMCAAsL1yg1elQUm82S4wiDcWzjhVFCKfT8FLuBbNkDfOpC5A8/5sqlckb6QHZr
 oYY0otMUgp1qBhaSPAeQPyyfx7+6HwQiqihhwm1J3wZ+BEEmI1uNxfI3GoOtCQKC3uZw
 y9xnD9elqIZ9aDoMicr6c/rPwPIP2nFh4A2IyjcWQBp9T2zbI8SDmwUbyyc9tnT0pqeF
 Oc0g==
X-Gm-Message-State: AOJu0Yy5bf/UVmew1IdKm57UKbki3EqyZzxnjDM5goTzrM2ycTxnKPq0
 TEA9hflEREx2y6P1kKl6oQBpWaXfe+8ayEu5DQ75mzRc1zVX8w5qUUVjJ/cy9tQv
X-Gm-Gg: ASbGncvfdIo7HeEh7pQEl0btzEdhBaI+5eZ5zS310TJRRCWqXx4NsVFtqvqKOcnV/sd
 jEzX3zxwPBu0Q2kH37k+Id25CLq31bUchNpc2EpfZtxfmE6XTb3anfyiSTMZrgzcFLBpUk+0F6b
 cHPak6noo7JITEW9AE8mJnRx1SmoX3s2zXz9wYTx5UuMGQFcIKCaOx+GtC7tj+IdRtxKohvtlFK
 eKkb1iiil+QsVevQS7JAFyMcZMO3VYjcamFILuJvv+uPgsV8mOQPBC9901ZehJEtgcActirzPEu
 uHg29qPtsav/ff5rNeTAsXmqK5zHCkyvhp8nRRncQqd1khkg6COZ9a0U0ugEW4wJ1qysRqnaUgD
 /3y2NKtyj/zC5+Igajpc1XHKNPwD0RxsojXvB
X-Google-Smtp-Source: AGHT+IHoO+lv2ReUnwC67p2EZTw6iaPDDgQYVoNnO8ryTRWjdXKuoVse5o+I3EHTQjMGxdMOJkx72w==
X-Received: by 2002:a17:90b:3b45:b0:321:38e0:d58e with SMTP id
 98e67ed59e1d1-32166c1548bmr7856969a91.3.1754552791385; 
 Thu, 07 Aug 2025 00:46:31 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:46:30 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 06/10] clk: rockchip: rk3368: Add vop clk get/set
Date: Thu,  7 Aug 2025 15:44:14 +0800
Message-Id: <20250807074419.336752-7-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Patch get form Rockchip downstream uboot repository.

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 .../include/asm/arch-rockchip/cru_rk3368.h    |   5 +
 .../include/asm/arch-rockchip/grf_rk3368.h    | 111 ++++++++-
 drivers/clk/rockchip/clk_rk3368.c             | 230 ++++++++++++++++++
 .../include/dt-bindings/clock/rk3368-cru.h    |   1 +
 4 files changed, 346 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
index 29f90454d4..8178d4e013 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3368.h
@@ -150,6 +150,11 @@ enum {
 	DCLK_VOP_DIV_SHIFT		= 0,
 	DCLK_VOP_DIV_MASK		= GENMASK(7, 0),
 
+	/* CLKSEL21_CON */
+	HCLK_VOP_DIV_SHIFT		= 0,
+	HCLK_VOP_DIV_MASK		= GENMASK(5, 0),
+	HCLK_VOP_DIV_WIDTH		= 5,
+
 	/* CLKSEL_CON25 */
 	CLK_SARADC_DIV_CON_SHIFT	= 8,
 	CLK_SARADC_DIV_CON_MASK		= GENMASK(15, 8),
diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3368.h b/arch/arm/include/asm/arch-rockchip/grf_rk3368.h
index 0079d20078..ef6cd167e2 100644
--- a/arch/arm/include/asm/arch-rockchip/grf_rk3368.h
+++ b/arch/arm/include/asm/arch-rockchip/grf_rk3368.h
@@ -77,11 +77,99 @@ struct rk3368_grf {
 	u32 soc_con15;
 	u32 soc_con16;
 	u32 soc_con17;
-	u32 reserved5[0x6e];
+	u32 reserved5[0xe];
+	u32 soc_status0;
+	u32 soc_status1;
+	u32 soc_status2;
+	u32 soc_status3;
+	u32 soc_status4;
+	u32 soc_status5;
+	u32 soc_status6;
+	u32 soc_status7;
+	u32 soc_status8;
+	u32 soc_status9;
+	u32 soc_status10;
+	u32 soc_status11;
+	u32 soc_status12;
+	u32 soc_status13;
+	u32 soc_status14;
+	u32 soc_status15;
+	u32 reserved6[0x10];
+	u32 cpu_con0;
+	u32 cpu_con1;
+	u32 cpu_con2;
+	u32 cpu_con3;
+	u32 reserved7[0x4];
+	u32 cpu_status0;
+	u32 cpu_status1;
+	u32 reserved8[0x6];
+	u32 cci_status0;
+	u32 cci_status1;
+	u32 cci_status2;
+	u32 cci_status3;
+	u32 cci_status4;
+	u32 cci_status5;
+	u32 cci_status6;
+	u32 cci_status7;
+	u32 cci_status8;
+	u32 cci_status9;
+	u32 cci_status10;
+	u32 cci_status11;
+	u32 cci_status12;
+	u32 cci_status13;
+	u32 cci_status14;
+	u32 cci_status15;
+	u32 reserved9[0x20];
 	u32 ddrc0_con0;
+	u32 reserved10[0x1f];
+	u32 sig_detect_con;
+	u32 reserved11[0x3];
+	u32 sig_detect_status;
+	u32 reserved12[0x3];
+	u32 sig_detect_clr;
+	u32 reserved13[0x17];
+	u32 uoc0_con0;
+	u32 reserved14[0x5];
+	u32 uoc1_con1;
+	u32 uoc1_con2;
+	u32 uoc1_con3;
+	u32 uoc1_con4;
+	u32 uoc1_con5;
+	u32 reserved15[0x3];
+	u32 uoc3_con0;
+	u32 uoc3_con1;
+	u32 uoc4_con0;
+	u32 uoc4_con1;
+	u32 reserved16[0xe];
+	u32 usbphy_con0;
+	u32 usbphy_con1;
+	u32 usbphy_con2;
+	u32 usbphy_con3;
+	u32 usbphy_con4;
+	u32 usbphy_con5;
+	u32 usbphy_con6;
+	u32 usbphy_con7;
+	u32 usbphy_con8;
+	u32 usbphy_con9;
+	u32 usbphy_con10;
+	u32 usbphy_con11;
+	u32 usbphy_con12;
+	u32 usbphy_con13;
+	u32 usbphy_con14;
+	u32 usbphy_con15;
+	u32 reserved17[0x10];
+	u32 pvtm_con0;
+	u32 pvtm_con1;
+	u32 pvtm_con2;
+	u32 pvtm_status0;
+	u32 pvtm_status1;
+	u32 pvtm_status2;
+	u32 reserved18[0x3a];
+	u32 io_vsel;
 };
 check_member(rk3368_grf, soc_con17, 0x444);
 check_member(rk3368_grf, ddrc0_con0, 0x600);
+check_member(rk3368_grf, io_vsel, 0x900);
 
 struct rk3368_pmu_grf {
 	u32 gpio0a_iomux;
@@ -104,6 +192,27 @@ struct rk3368_pmu_grf {
 check_member(rk3368_pmu_grf, gpio0h_sr, 0x34);
 check_member(rk3368_pmu_grf, os_reg[0], 0x200);
 
+/* GRF_SOC_CON7 */
+enum {
+	RK3368_DPHY_TX0_RXMODE_SHIFT = 6,
+	RK3368_DPHY_TX0_RXMODE_MASK =
+	   0x1 << RK3368_DPHY_TX0_RXMODE_SHIFT,
+	RK3368_DPHY_TX0_RXMODE_EN = 1,
+	RK3368_DPHY_TX0_RXMODE_DIS = 0,
+
+	RK3368_DPHY_TX0_TXSTOPMODE_SHIFT = 7,
+	RK3368_DPHY_TX0_TXSTOPMODE_MASK =
+	   0xf << RK3368_DPHY_TX0_TXSTOPMODE_SHIFT,
+	RK3368_DPHY_TX0_TXSTOPMODE_EN = 0xf,
+	RK3368_DPHY_TX0_TXSTOPMODE_DIS = 0,
+
+	RK3368_DPHY_TX0_TURNDISABLE_SHIFT = 5,
+	RK3368_DPHY_TX0_TURNDISABLE_MASK =
+	   0x1 << RK3368_DPHY_TX0_TURNDISABLE_SHIFT,
+	RK3368_DPHY_TX0_TURNDISABLE_EN = 1,
+	RK3368_DPHY_TX0_TURNDISABLE_DIS = 0,
+};
+
 /*GRF_SOC_CON11/12/13*/
 enum {
 	MCU_SRAM_BASE_BIT27_BIT12_SHIFT	= 0,
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 2a20c8b50f..17707600ee 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -31,9 +31,27 @@ struct rk3368_clk_plat {
 #endif
 
 struct pll_div {
+	ulong rate;
 	u32 nr;
 	u32 nf;
 	u32 no;
+	u32 nb;
+};
+
+#define RK3368_PLL_RATE(_rate, _nr, _nf, _no, _nb)	\
+{							\
+	.rate	= _rate##U,				\
+	.nr = _nr,					\
+	.nf = _nf,					\
+	.no = _no,					\
+	.nb = _nb,					\
+}
+
+static struct pll_div rk3368_pll_rates[] = {
+	/* _mhz,  _nr, _nf, _no, _nb */
+	RK3368_PLL_RATE(594000000, 1, 99, 4, 16),
+	RK3368_PLL_RATE(424200000, 5, 707, 8, 0),
+	RK3368_PLL_RATE(410000000, 3, 205, 4, 16),
 };
 
 #define OSC_HZ		(24 * 1000 * 1000)
@@ -41,6 +59,7 @@ struct pll_div {
 #define APLL_B_HZ	(816 * 1000 * 1000)
 #define GPLL_HZ		(576 * 1000 * 1000)
 #define CPLL_HZ		(400 * 1000 * 1000)
+#define NPLL_HZ		(594 * 1000 * 1000)
 
 #define DIV_TO_RATE(input_rate, div)    ((input_rate) / ((div) + 1))
 
@@ -61,6 +80,105 @@ static const struct pll_div cpll_init_cfg = PLL_DIVISORS(CPLL_HZ, 1, 6);
 
 static ulong rk3368_clk_get_rate(struct clk *clk);
 
+#define VCO_MAX_KHZ	2200000
+#define VCO_MIN_KHZ	440000
+#define FREF_MAX_KHZ	2200000
+#define FREF_MIN_KHZ	269
+#define PLL_LIMIT_FREQ	400000000
+
+struct pll_div *rkclk_get_pll_config(ulong freq_hz)
+{
+	unsigned int rate_count = ARRAY_SIZE(rk3368_pll_rates);
+	int i;
+
+	for (i = 0; i < rate_count; i++) {
+		if (freq_hz == rk3368_pll_rates[i].rate)
+			return &rk3368_pll_rates[i];
+	}
+	return NULL;
+}
+
+static int pll_para_config(ulong freq_hz, struct pll_div *div, uint *ext_div)
+{
+	struct pll_div *best_div = NULL;
+	uint ref_khz = OSC_HZ / 1000, nr, nf = 0;
+	uint fref_khz;
+	uint diff_khz, best_diff_khz;
+	const uint max_nr = 1 << 6, max_nf = 1 << 12, max_no = 1 << 4;
+	uint vco_khz;
+	uint no = 1;
+	uint freq_khz = freq_hz / 1000;
+
+	if (!freq_hz) {
+		printf("%s: the frequency can not be 0 Hz\n", __func__);
+		return -EINVAL;
+	}
+
+	no = DIV_ROUND_UP(VCO_MIN_KHZ, freq_khz);
+	if (ext_div) {
+		*ext_div = DIV_ROUND_UP(PLL_LIMIT_FREQ, freq_hz);
+		no = DIV_ROUND_UP(no, *ext_div);
+	}
+
+	best_div = rkclk_get_pll_config(freq_hz * (*ext_div));
+	if (best_div) {
+		div->nr = best_div->nr;
+		div->nf = best_div->nf;
+		div->no = best_div->no;
+		div->nb = best_div->nb;
+		return 0;
+	}
+
+	/* only even divisors (and 1) are supported */
+	if (no > 1)
+		no = DIV_ROUND_UP(no, 2) * 2;
+
+	vco_khz = freq_khz * no;
+	if (ext_div)
+		vco_khz *= *ext_div;
+
+	if (vco_khz < VCO_MIN_KHZ || vco_khz > VCO_MAX_KHZ || no > max_no) {
+		printf("%s: Cannot find out VCO for Frequency (%luHz).\n",
+		       __func__, freq_hz);
+		return -1;
+	}
+
+	div->no = no;
+
+	best_diff_khz = vco_khz;
+	for (nr = 1; nr < max_nr && best_diff_khz; nr++) {
+		fref_khz = ref_khz / nr;
+		if (fref_khz < FREF_MIN_KHZ)
+			break;
+		if (fref_khz > FREF_MAX_KHZ)
+			continue;
+
+		nf = vco_khz / fref_khz;
+		if (nf >= max_nf)
+			continue;
+		diff_khz = vco_khz - nf * fref_khz;
+		if (nf + 1 < max_nf && diff_khz > fref_khz / 2) {
+			nf++;
+			diff_khz = fref_khz - diff_khz;
+		}
+
+		if (diff_khz >= best_diff_khz)
+			continue;
+
+		best_diff_khz = diff_khz;
+		div->nr = nr;
+		div->nf = nf;
+	}
+
+	if (best_diff_khz > 4 * 1000) {
+		printf("%s:Fail to match output freq %lu,best_is %u Hz\n",
+		       __func__, freq_hz, best_diff_khz * 1000);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Get pll rate by id */
 static uint32_t rkclk_pll_get_rate(struct rk3368_cru *cru,
 				   enum rk3368_pll_id pll_id)
@@ -525,6 +643,104 @@ static ulong rk3368_bus_set_clk(struct rk3368_cru *cru,
 	}
 	return rk3368_bus_get_clk(cru, clk_id);
 }
+
+static ulong rk3368_vop_get_clk(struct rk3368_cru *cru,  int clk_id)
+{
+	u32 div, con, parent, sel;
+
+	switch (clk_id) {
+	case DCLK_VOP:
+		con = readl(&cru->clksel_con[20]);
+		div = con & DCLK_VOP_DIV_MASK;
+		parent = rkclk_pll_get_rate(cru, NPLL);
+		break;
+	case ACLK_VOP:
+		con = readl(&cru->clksel_con[19]);
+		div = con & ACLK_VOP_DIV_MASK;
+		sel =  (con & (ACLK_VOP_PLL_SEL_MASK <<
+			ACLK_VOP_PLL_SEL_SHIFT)) >>
+			ACLK_VOP_PLL_SEL_SHIFT;
+		if (sel == ACLK_VOP_PLL_SEL_CPLL)
+			parent = rkclk_pll_get_rate(cru, CPLL);
+		else if (ACLK_VOP_PLL_SEL_GPLL)
+			parent = rkclk_pll_get_rate(cru, GPLL);
+		else
+			parent = 480000000;
+		break;
+	case HCLK_VOP:
+		parent = rk3368_vop_get_clk(cru, ACLK_VOP);
+		con = readl(&cru->clksel_con[21]);
+		div = con & HCLK_VOP_DIV_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return DIV_TO_RATE(parent, div);
+}
+
+static ulong rk3368_vop_set_clk(struct rk3368_cru *cru, int clk_id, uint hz)
+{
+	struct pll_div npll_config = {0};
+	u32 lcdc_div;
+	int ret;
+
+	switch (clk_id) {
+	case DCLK_VOP:
+		if (!(NPLL_HZ % hz)) {
+			rkclk_set_pll(cru, NPLL, rkclk_get_pll_config(NPLL_HZ));
+			lcdc_div = NPLL_HZ / hz;
+		} else {
+			ret = pll_para_config(hz, &npll_config, &lcdc_div);
+			if (ret)
+				return ret;
+
+			rkclk_set_pll(cru, NPLL, &npll_config);
+		}
+		/* vop dclk source clk: npll,dclk_div: 1 */
+		rk_clrsetreg(&cru->clksel_con[20],
+			     (DCLK_VOP_PLL_SEL_MASK << DCLK_VOP_PLL_SEL_SHIFT) |
+			     (DCLK_VOP_DIV_MASK << DCLK_VOP_DIV_SHIFT),
+			     (DCLK_VOP_PLL_SEL_NPLL << DCLK_VOP_PLL_SEL_SHIFT) |
+			     (lcdc_div - 1) << DCLK_VOP_DIV_SHIFT);
+		break;
+	case ACLK_VOP:
+		if ((rkclk_pll_get_rate(cru, CPLL) % hz) == 0) {
+			lcdc_div = rkclk_pll_get_rate(cru, CPLL) / hz;
+			rk_clrsetreg(&cru->clksel_con[19],
+				     (ACLK_VOP_PLL_SEL_MASK <<
+				     ACLK_VOP_PLL_SEL_SHIFT) |
+				     (ACLK_VOP_DIV_MASK <<
+				     ACLK_VOP_DIV_SHIFT),
+				     (ACLK_VOP_PLL_SEL_CPLL <<
+				     ACLK_VOP_PLL_SEL_SHIFT) |
+				     (lcdc_div - 1) <<
+				     ACLK_VOP_DIV_SHIFT);
+		} else {
+			lcdc_div = rkclk_pll_get_rate(cru, GPLL) / hz;
+			rk_clrsetreg(&cru->clksel_con[19],
+				     (ACLK_VOP_PLL_SEL_MASK <<
+				     ACLK_VOP_PLL_SEL_SHIFT) |
+				     (ACLK_VOP_DIV_MASK <<
+				     ACLK_VOP_DIV_SHIFT),
+				     (ACLK_VOP_PLL_SEL_GPLL <<
+				     ACLK_VOP_PLL_SEL_SHIFT) |
+				     (lcdc_div - 1) <<
+				     ACLK_VOP_DIV_SHIFT);
+		}
+		break;
+	case HCLK_VOP:
+		lcdc_div = rk3368_vop_get_clk(cru, ACLK_VOP) / hz;
+		rk_clrsetreg(&cru->clksel_con[21],
+			     HCLK_VOP_DIV_MASK,
+			     (lcdc_div - 1) << HCLK_VOP_DIV_SHIFT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rk3368_vop_get_clk(cru, clk_id);
+}
 #endif
 
 static ulong rk3368_clk_get_rate(struct clk *clk)
@@ -565,6 +781,13 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 	case SCLK_SARADC:
 		rate = rk3368_saradc_get_clk(priv->cru);
 		break;
+#if !IS_ENABLED(CONFIG_XPL_BUILD)
+	case ACLK_VOP:
+	case DCLK_VOP:
+	case HCLK_VOP:
+		rate = rk3368_vop_get_clk(priv->cru, clk->id);
+		break;
+#endif
 	default:
 		return -ENOENT;
 	}
@@ -609,6 +832,13 @@ static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
 	case SCLK_SARADC:
 		ret =  rk3368_saradc_set_clk(priv->cru, rate);
 		break;
+#if !defined(CONFIG_XPL_BUILD)
+	case ACLK_VOP:
+	case DCLK_VOP:
+	case HCLK_VOP:
+		ret = rk3368_vop_set_clk(priv->cru, clk->id, rate);
+		break;
+#endif
 	default:
 		return -ENOENT;
 	}
diff --git a/dts/upstream/include/dt-bindings/clock/rk3368-cru.h b/dts/upstream/include/dt-bindings/clock/rk3368-cru.h
index ebae3cbf81..b951e29069 100644
--- a/dts/upstream/include/dt-bindings/clock/rk3368-cru.h
+++ b/dts/upstream/include/dt-bindings/clock/rk3368-cru.h
@@ -72,6 +72,7 @@
 #define SCLK_SFC		126
 #define SCLK_MAC		127
 #define SCLK_MACREF_OUT		128
+#define SCLK_MIPIDSI_24M	129
 #define SCLK_TIMER10		133
 #define SCLK_TIMER11		134
 #define SCLK_TIMER12		135
-- 
2.39.5

