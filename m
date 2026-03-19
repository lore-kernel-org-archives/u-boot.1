Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54261091930
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D24E9842C2;
	Fri, 20 Mar 2026 00:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sx8GR+zN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77A8183FC5; Thu, 19 Mar 2026 21:58:49 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD47F83F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486fd5360d4so8087855e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953926; x=1774558726; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mw5badEuNe3CrA0BAnPAn55maOsXGTags+TNv5L2MA4=;
 b=sx8GR+zNMqPtzL5jEoG/Mq6gavXN017SefqKhUhFCI7ilnBPxy4STso4vXn7q6dn22
 VOzcQPwEKGeGUkI6aI5Jcppa2Okc/+3qSsqnDtZs2w1MFjZDr1WRQYesC2a5VpFu0yFX
 GEWZdaV48vhZNPTpkLJtDgRtC54Qn08DnsDYrLjEDfwHkMGX21VDv9oRKtWosxCdPuzO
 IgJmnWk5U67GwZhLJOcu8f6d0CMR2FGJTMnVp7aBd4pIIZ1qv2RQajLXOgpmGr7duWcw
 LUlOv2FErtJhEMIgVByOLp0GPI83G9UBR8HE1LpauPlRTXtrHHu9cBko5NAUYGtpIV87
 YB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953926; x=1774558726;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mw5badEuNe3CrA0BAnPAn55maOsXGTags+TNv5L2MA4=;
 b=SsnVjA3Nlz/eC6iST2Uf7LTSKYwv77O94BTZPq6fTqCN3kQaP2yaTSvK8LOBP1MMCM
 it9ToT6ZP5h8ABADa0i9WXBr2DPL5SltbD54B3/9S43JXQ0S/u8cD4xhOPnFAY1zhH2P
 43IqF0jMqlRbbKB4Mn5Vk53wrGpvGuHKOFQdjMtxcCkN+dDDIolpD3LqG059g+hdhmnq
 BjorzqImhtcSTXXEs+jJfcH3j23DeO1RqFiz2NJ6AYq+Uko4zw5Rci0R2iacdR9aLLGR
 9rUcjpk9cSXPkKQCkcoshtqAPJvzjgORgktglW8lScag9fKeCUnv7GdyJYlADzE9/Inb
 bMug==
X-Gm-Message-State: AOJu0YyXWDs8vDDX33isOGgNpeHNnYzPE19hGEphFrYeunwUiNxBmq1N
 HXwkcsZ/Nuzvgxs6PY/q3qLsObwhtz6zhYRa/YPUcuW+jXEnrNMY0IqA2cCx8LyZa3Q=
X-Gm-Gg: ATEYQzyL+xjZ39UWFJzR7EMRyAqjDoX5tZ/kMcWV7+3fjjLFklZiZVwu5mgwaQ5fOUM
 AiE/XQCZ+I0GVOuCU69MfWxQ4KDYXHnWREk6VrLzQKG0LYdOHbiXmM3VBCKRB76afLPZOE5vzo+
 Xc4gr0gX6gNqs8ildM3fosOT2PNC1VaJj+mBWC9qSxefSgz+7eMP/Pm7Z2rRT2Cghd8hQiF1fS1
 SofkP4Xmuyn4zPmFUqcOiAb74PqijOMI6HqSyv8M+nNoQ3HWynaOlieW0gW2Gl+/fucAoaJaGVW
 kD8tWfbRSxQKw+Is5K87efvWL2zgrCpkL5VrYRACrHourRJb0G6dno1m7KL7X4V1SoGvrU/oBMm
 M8MeeqKpKz0tEo+PTPBAsyuA6iK5Rdtzpx41jUv3ua/Dn/WnrTXtpwbmWFkbXc7mEfjjr9mmRvO
 vBW3QjDUWn+tGVMM47NuHn/UY1XtFYIpVB8h7Ci/6SbEG9UheSn128kg16RbEcInyp4NE=
X-Received: by 2002:a05:600c:4750:b0:485:3812:36dc with SMTP id
 5b1f17b1804b1-486fedbd0bbmr8054725e9.9.1773953926120; 
 Thu, 19 Mar 2026 13:58:46 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:45 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:50 +0100
Subject: [PATCH RFC 28/40] clk/sandbox: add a CCF_FULL port of clk_sandbox
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-28-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=11289;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=j3qwhkeGh+bMPbESDj72o0O96bvue2HzZkd+eSfDkdA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yQLqJvrJk6fmBmvOtP/v+Pby//XJlr56jBOr122Tt
 PlaUl3RUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACZincLwi6nL/vrE7Y3nuIPX
 dAW7xT6dabCiYYmVAqdx+Hbem25C8xgZ5ngHTttzPTc7vE1BdFFcaMMshuUrSnNPGHo37nSqezt
 JGQA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

This is based on the uCCF version with trivial changes to use the full
CCF API and demonstrate how clk drivers can be ported from U-Boot CCF to
full CCF.

Notably, the line count drops by about 20% with the removal of the
different U_BOOT_DRIVER definitions. It also becomes possible to
register clocks with direct references to their parent clocks, avoiding
the need for global string lookups.

The test dts is also updated to give the clk-ccf device a proper handle
to the fixed osc clock, enabling proper lookup via the clock-names DT
property.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/sandbox/dts/test.dts              |   4 +-
 arch/sandbox/include/asm/clk.h         |   2 +-
 drivers/clk/ccf/Makefile               |   1 +
 drivers/clk/ccf/clk_sandbox_ccf_full.c | 220 +++++++++++++++++++++++++++++++++
 drivers/clk/clk_sandbox.c              |  43 ++++++-
 include/sandbox-clk.h                  |   3 +
 6 files changed, 270 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 762c1d9bbe29..5c9eb3f6f8eb 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -635,9 +635,9 @@
 			clock-mult = <2>;
 			clocks = <&clk_fixed>;
 		};
 
-		osc {
+		xo_board: osc {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <20000000>;
 		};
@@ -678,8 +678,10 @@
 	};
 
 	ccf: clk-ccf {
 		compatible = "sandbox,clk-ccf";
+		clocks = <&xo_board>;
+		clock-names = "osc";
 		#clock-cells = <1>;
 	};
 
 	efi-media {
diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
index 37fe49c7fcf6..c67ea92d3331 100644
--- a/arch/sandbox/include/asm/clk.h
+++ b/arch/sandbox/include/asm/clk.h
@@ -145,9 +145,9 @@ ulong sandbox_clk_test_round_rate(struct udevice *dev, int id, ulong rate);
  * @dev:	The sandbox clock test (client) device.
  * @id:		The test device's clock ID to configure.
  * @return:	The new rate of the clock.
  */
-ulong sandbox_clk_test_set_rate(struct udevice *dev, int id, ulong rate);
+long sandbox_clk_test_set_rate(struct udevice *dev, int id, ulong rate);
 /**
  * sandbox_clk_test_enable - Ask the sandbox clock test device to enable a
  * clock.
  *
diff --git a/drivers/clk/ccf/Makefile b/drivers/clk/ccf/Makefile
index 39879b34e645..e831666ccdb9 100644
--- a/drivers/clk/ccf/Makefile
+++ b/drivers/clk/ccf/Makefile
@@ -15,4 +15,5 @@ obj-y += clk.o \
 
 obj-$(CONFIG_CLK_COMPOSITE_CCF) += clk-composite.o
 
 obj-$(CONFIG_CLK_CCF_FULL_COMPAT) += compat.o
+obj-$(CONFIG_SANDBOX_CLK_CCF) += clk_sandbox_ccf_full.o
diff --git a/drivers/clk/ccf/clk_sandbox_ccf_full.c b/drivers/clk/ccf/clk_sandbox_ccf_full.c
new file mode 100644
index 000000000000..921948022d91
--- /dev/null
+++ b/drivers/clk/ccf/clk_sandbox_ccf_full.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019
+ * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
+ *
+ * Common Clock Framework [CCF] driver for Sandbox
+ */
+
+#include <dm.h>
+#include <clk.h>
+#include <malloc.h>
+#include <asm/clk.h>
+#include <clk-uclass.h>
+#include <dm/devres.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <sandbox-clk.h>
+#include <linux/err.h>
+
+/*
+ * Sandbox implementation of CCF primitives necessary for clk-uclass testing
+ *
+ * --- Sandbox PLLv3 ---
+ */
+struct clk_pllv3 {
+	struct clk_hw	clk;
+	u32		div_mask;
+	u32		div_shift;
+};
+
+#if CONFIG_IS_ENABLED(UNIT_TEST)
+int clk_get_enable_count(struct clk *clk);
+#else
+#define clk_get_enable_count(clk) 0
+#endif
+
+int sandbox_clk_enable_count(struct clk *clk)
+{
+	return clk_get_enable_count(clk);
+}
+
+static ulong clk_pllv3_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	return parent_rate * 24;
+}
+
+static const struct clk_ops clk_pllv3_generic_ops = {
+	.recalc_rate       = clk_pllv3_recalc_rate,
+};
+
+static struct clk_hw *sb_clk_pllv3(enum sandbox_pllv3_type type, ofnode node, const char *name,
+			      const char *parent_name, void __iomem *base,
+			      u32 div_mask)
+{
+	struct clk_pllv3 *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init = { 0 };
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->div_mask = div_mask;
+	hw = &pll->clk;
+	hw->init = &init;
+
+	init.name = name;
+	init.ops = &clk_pllv3_generic_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_data = &(struct clk_parent_data){
+		.fw_name = parent_name,
+	};
+	init.num_parents = 1;
+
+	ret = of_clk_hw_register(node, hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+/* --- Sandbox PLLv3 --- */
+
+struct clk_hw *sandbox_clk_composite(const char *name,
+				  const char * const *parent_names,
+				  int num_parents, void __iomem *reg,
+				  unsigned long flags)
+{
+	struct clk_hw *hw = ERR_PTR(-ENOMEM);
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto fail;
+
+	mux->reg = reg;
+	mux->shift = 24;
+	mux->mask = 0x7;
+	mux->flags = flags;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto fail;
+
+	div->reg = reg;
+	div->shift = 16;
+	div->width = 3;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST | flags;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto fail;
+
+	gate->reg = reg;
+	gate->bit_idx = 28;
+	gate->flags = flags;
+
+	hw = clk_hw_register_composite(NULL, name,
+				     parent_names, num_parents,
+				     &mux->hw, &clk_mux_ops, &div->hw,
+				     &clk_divider_ro_ops,
+				     &gate->hw, &clk_gate_ops, flags);
+	if (IS_ERR(hw))
+		goto fail;
+
+	return hw;
+
+fail:
+	kfree(gate);
+	kfree(div);
+	kfree(mux);
+	return ERR_CAST(hw);
+}
+
+/* --- Sandbox Gate --- */
+/* The CCF core driver itself */
+static const struct udevice_id sandbox_clk_ccf_test_ids[] = {
+	{ .compatible = "sandbox,clk-ccf" },
+	{ }
+};
+
+static const char *const usdhc_sels[] = { "pll3_60m", "pll3_80m", };
+static const char *const i2c_sels[] = { "pll3_60m", "pll3_80m", };
+
+static int sandbox_clk_ccf_probe(struct udevice *dev)
+{
+	ofnode node = dev_ofnode(dev);
+	struct clk_hw_onecell_data *data;
+	struct clk_hw **clks;
+	void *base = NULL;
+	u32 reg;
+	u32 *clk_regs;
+
+	data = devm_kzalloc(dev, sizeof(*data) + sizeof(struct clk_hw) * SANDBOX_CLK_MAX, __GFP_ZERO);
+	if (!data)
+		return -ENOMEM;
+
+	clk_regs = devm_kzalloc(dev, sizeof(u32) * SANDBOX_CLK_MAX, __GFP_ZERO);
+	if (!clk_regs)
+		return -ENOMEM;
+
+	data->num = SANDBOX_CLK_MAX;
+	clks = data->hws;
+
+	clks[SANDBOX_CLK_PLL3] = sb_clk_pllv3(SANDBOX_PLLV3_USB, node, "pll3_usb_otg", "osc",
+				     base + 0x10, 0x3);
+
+	clks[SANDBOX_CLK_PLL3_60M] =
+		clk_hw_register_fixed_factor_parent_hw(dev, "pll3_60m",
+						       clks[SANDBOX_CLK_PLL3],
+						       CLK_SET_RATE_PARENT, 1, 8);
+	
+	clks[SANDBOX_CLK_PLL3_80M] =
+		clk_hw_register_fixed_factor_parent_hw(dev, "pll3_80m",
+						       clks[SANDBOX_CLK_PLL3],
+						       CLK_SET_RATE_PARENT, 1, 6);
+
+	/* The HW adds +1 to the divider value (2+1) is the divider */
+	clk_regs[SANDBOX_CLK_ECSPI_ROOT] = (2 << 19);
+	clks[SANDBOX_CLK_ECSPI_ROOT] = clk_hw_register_divider_parent_hw(dev, "ecspi_root", clks[SANDBOX_CLK_PLL3_60M],
+									 CLK_SET_RATE_PARENT, &clk_regs[SANDBOX_CLK_ECSPI_ROOT], 19, 6, CLK_DIVIDER_READ_ONLY);
+	clk_regs[SANDBOX_CLK_ECSPI0] = 0;
+	clks[SANDBOX_CLK_ECSPI0] = clk_hw_register_gate_parent_hw(dev, "ecspi0", clks[SANDBOX_CLK_ECSPI_ROOT],
+								  CLK_SET_RATE_PARENT, &clk_regs[SANDBOX_CLK_ECSPI0], 0, 0);
+
+	clks[SANDBOX_CLK_ECSPI1] = clk_hw_register_gate_parent_hw(dev, "ecspi1", clks[SANDBOX_CLK_ECSPI_ROOT], CLK_SET_RATE_PARENT, base + 0x6c, 0, 0);
+
+	/* Select 'pll3_60m' */
+	reg = 0;
+	clk_regs[SANDBOX_CLK_USDHC1_SEL] = 0;
+	clks[SANDBOX_CLK_USDHC1_SEL] = clk_hw_register_mux(dev, "usdhc1_sel", usdhc_sels, ARRAY_SIZE(usdhc_sels),
+							   CLK_SET_RATE_NO_REPARENT, &clk_regs[SANDBOX_CLK_USDHC1_SEL], 16, 1, 0);
+
+	/* Select 'pll3_80m' */
+	clk_regs[SANDBOX_CLK_USDHC2_SEL] = BIT(17);
+	clks[SANDBOX_CLK_USDHC2_SEL] = clk_hw_register_mux(dev, "usdhc2_sel", usdhc_sels, ARRAY_SIZE(usdhc_sels),
+							   CLK_SET_RATE_NO_REPARENT, &clk_regs[SANDBOX_CLK_USDHC2_SEL], 17, 1, 0);
+
+	clk_regs[SANDBOX_CLK_I2C] = BIT(28) | BIT(24) | BIT(16);
+	clks[SANDBOX_CLK_I2C] = sandbox_clk_composite("i2c", i2c_sels, ARRAY_SIZE(i2c_sels),
+					 &clk_regs[SANDBOX_CLK_I2C], CLK_SET_RATE_UNGATE);
+		   
+
+	clk_regs[SANDBOX_CLK_I2C_ROOT] = 0;
+	clks[SANDBOX_CLK_I2C_ROOT] = clk_hw_register_gate(dev, "i2c_root", "i2c", 0, &clk_regs[SANDBOX_CLK_I2C_ROOT], 0, 0);
+
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
+}
+
+U_BOOT_DRIVER(sandbox_clk_ccf_full) = {
+	.name = "sandbox_clk_ccf_full",
+	.id = UCLASS_NOP,
+	.probe = sandbox_clk_ccf_probe,
+	.of_match = sandbox_clk_ccf_test_ids,
+};
diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
index 667526810fc2..36ca128892b5 100644
--- a/drivers/clk/clk_sandbox.c
+++ b/drivers/clk/clk_sandbox.c
@@ -165,9 +165,10 @@ int sandbox_clk_query_requested(struct udevice *dev, int id)
 		return -EINVAL;
 	return priv->requested[id];
 }
 
-int clk_fixed_rate_of_to_plat(struct udevice *dev)
+#if !CONFIG_IS_ENABLED(CLK_CCF_FULL)
+static int clk_fixed_rate_of_to_plat(struct udevice *dev)
 {
 	struct clk_fixed_rate *cplat;
 
 #if CONFIG_IS_ENABLED(OF_PLATDATA)
@@ -196,4 +197,44 @@ U_BOOT_DRIVER(sandbox_fixed_clock) = {
 	.plat_auto = sizeof(struct sandbox_clk_fixed_rate_plat),
 	.ops = &clk_fixed_rate_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
+#else
+static int clk_fixed_rate_probe(struct udevice *dev)
+{
+	ofnode node = dev_ofnode(dev);
+	const char *clk_name;
+	struct clk_hw *hw;
+	u32 rate = 0;
+	int ret;
+
+	ofnode_read_u32(node, "clock-frequency", &rate);
+
+	clk_name = ofnode_read_string(node, "clock-output-names");
+	if (!clk_name)
+		clk_name = ofnode_get_name(node);
+
+	hw = clk_hw_register_fixed_rate(dev, clk_name, NULL, 0, rate);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+	if (ret) {
+		clk_hw_unregister_fixed_rate(hw);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id sandbox_clk_fixed_rate_match[] = {
+	{ .compatible = "sandbox,fixed-clock" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(sandbox_fixed_clock) = {
+	.name = "sandbox_fixed_clock",
+	.id = UCLASS_NOP,
+	.of_match = sandbox_clk_fixed_rate_match,
+	.probe = clk_fixed_rate_probe,
+};
+#endif
diff --git a/include/sandbox-clk.h b/include/sandbox-clk.h
index eb02a474c741..fd16aacf1a73 100644
--- a/include/sandbox-clk.h
+++ b/include/sandbox-clk.h
@@ -20,8 +20,11 @@ enum {
 	SANDBOX_CLK_USDHC1_SEL,
 	SANDBOX_CLK_USDHC2_SEL,
 	SANDBOX_CLK_I2C,
 	SANDBOX_CLK_I2C_ROOT,
+
+	_SANDBOX_CLK_MAX,
+	SANDBOX_CLK_MAX = _SANDBOX_CLK_MAX,
 };
 
 enum sandbox_pllv3_type {
 	SANDBOX_PLLV3_GENERIC,

-- 
2.51.0

