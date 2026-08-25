Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18B6C5B572
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 04:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A06680D99;
	Tue, 25 Aug 2026 04:25:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YxBik0X7LaGf; Tue, 25 Aug 2026 04:25:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787631921;
	bh=7x35Ic33Aq4gkFACjIzfADU9VYTPmYUU9RwTTXMZvEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eaZvryc92qcjIJyBBQhnI0i4B27cuyyar7Af7jmAzlg4A1m4bqvYtnsy+Vs/htvCQ
	 ABxZNx/HU997SFdxqalz2lgZ8TU6qV+PO16Cn9GeppwS6qDP5gYV/J9I3unAl4q/Ch
	 cK8lqwow1hJIJyS8ppRV82qRDj8S2/H+ZowG0cX9U6Fs+lbv5t1GZUGztgLEnCZ7ju
	 h80iq+RgcNCHEA4e7gNtMEGRo6XtMhxIStJvRnDOFlJtFmACa1edpfqEUBO3WjRy0C
	 hpIRTTpLVviC9slb5BB/SJ8zrM/RxvjYj/bZzrwRGm5mtvtpt3bYZGOwDcc4nezpht
	 ++uVgS8XYr0MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7503B80D4B;
	Tue, 25 Aug 2026 04:25:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBDD8336
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8A4980DA4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p9Hkt_HEI307 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 04:25:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=FYBDtAwz
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6567B80CCA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5F3B601E0;
 Tue, 25 Aug 2026 04:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAED31F00A3A;
 Tue, 25 Aug 2026 04:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787631916;
 bh=7x35Ic33Aq4gkFACjIzfADU9VYTPmYUU9RwTTXMZvEQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FYBDtAwz85eTFBLfQRPxb/U12Pamb0E7GLTKL8HqXdD5knZlyrNFQ93+qb69/KLT3
 ZTpL6wTW06StLsjaLpytTXL002p4p2jqhBKDg1ZdhLQdVqDvytcNCbu9CfnL9UExQk
 8EYb7+DwXsCwHLX7rrgzFRYPRBEQdrSiYBLc+EfdnZsLeBYkWl9H6Sx3AhgFciIr4T
 v2uzjouX2S1Sa9kWR0MuA87B6BLyw7WG3b++3plh5wHupZX5nuQV9yiyon8xhSKEg/
 eWb3JE29wi66nMW+mVCrcHvv3fp4rgmTrHNkbW4ILE0XMueslPR3Q5oPC9/Md49lEn
 I0WPcH7N85TAw==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 25 Aug 2026 04:24:13 +0000
Subject: [PATCH 3/8] clk: spacemit: ccu_pll: add plla type clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-01-k3-clock-reset-support-v1-3-c430253e759c@kernel.org>
References: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
In-Reply-To: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7457; i=dlan@kernel.org;
 h=from:subject:message-id; bh=JP7DEjP7awEWWLjW9vIGisEhSJhFiA0Totop8y8QqeQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqjRkMUeXFWOL6kTlwZ7fqyIPbkEJ9Fvf/n+cFM
 orXYxZOe9CJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCao0ZDBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1Q+xAAkRtggFNF0v88eD3QjROlkz5xDeSNqlvXrm2Vw4iWA1btTrAaObzji
 ldbFlNiul6+BSX6Ae0QxcJyyTyJKGYJpoQ8YewJO7+iQZFFLYPP9IINHjQDOBASoimt4oFYy59q
 F+hxg4aFGow9+R2qMxarQy3u6ESI/3pwLKvEyCJdp3hF9YIGX1eYVdzYmxFDLvbZSK+sw4qiSmO
 NJYTIta6NAcRi1bSRzbRhClYcdk9ZqjtYb5mV6cLew772MKHnuVTmMxp+MQ94O+tzH8XFqQm6+u
 EAe6jYqSqF8HOVugfFCPvQ+Ip+b5dK1GMEIc4bHj3ys4ePgiAd0htY4cPsRQJz2QmsEQD0yJPvX
 disg9uEgpT3PKN/L5RH//HTyPFFi8epIJHBHUXrXbr3aNYYvxHMo5oxbx6WP8AwJo5rBS7w3+f1
 1WC0VCIVRMxyWzk7iJhKNkktNK0QA43WrsxCwcREnPU8L1GCwpR3O3jOIVFl82GSC/N9cz1wize
 TVRiNsogR5ZQ4mjxTLfEDxg6u1FuXJ7U0nzPJfHZe1m0lSFTmkto/fbQY7WyFb4Qvd9BsAHv/Mw
 KISo1UxG4AaoTpdzv8832wNCdAeEJezAud1xQs2ZLxVFHm1ULIhDkXh7g75tU4rJkEsLQO3sKoY
 2eWW4oQmUnwR5Xrk9KisSljvmBfj1A=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Based on upstream Linux:
  3a086236c600 ("clk: spacemit: ccu_pll: add plla type clock")

Introduce a new clock PLLA for SpacemiT's K3 SoC which has a different
register layout comparing to previous PPL type. And, It is configured
by swcr1, swcr3 and swcr2 BIT[15:8].

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/clk_common.h |   1 +
 drivers/clk/spacemit/clk_pll.c    | 124 +++++++++++++++++++++++++++++++++++++-
 drivers/clk/spacemit/clk_pll.h    |  43 +++++++++++--
 3 files changed, 163 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/spacemit/clk_common.h b/drivers/clk/spacemit/clk_common.h
index ea5ebf57784..60702414f2b 100644
--- a/drivers/clk/spacemit/clk_common.h
+++ b/drivers/clk/spacemit/clk_common.h
@@ -36,6 +36,7 @@ struct ccu_common {
 		/* For PLL */
 		struct {
 			u32 reg_swcr1;
+			u32 reg_swcr2;
 			u32 reg_swcr3;
 		};
 	};
diff --git a/drivers/clk/spacemit/clk_pll.c b/drivers/clk/spacemit/clk_pll.c
index 56da70af58a..36de37c3a25 100644
--- a/drivers/clk/spacemit/clk_pll.c
+++ b/drivers/clk/spacemit/clk_pll.c
@@ -13,7 +13,8 @@
 
 #include "clk_pll.h"
 
-#define UBOOT_DM_SPACEMIT_CLK_PLL "spacemit_clk_pll"
+#define UBOOT_DM_SPACEMIT_CLK_PLL	"spacemit_clk_pll"
+#define UBOOT_DM_SPACEMIT_CLK_PLLA	"spacemit_clk_plla"
 
 #define PLL_TIMEOUT_US		3000
 #define PLL_DELAY_US		5
@@ -21,6 +22,9 @@
 #define PLL_SWCR3_EN		((u32)BIT(31))
 #define PLL_SWCR3_MASK		GENMASK(30, 0)
 
+#define PLLA_SWCR2_EN		((u32)BIT(16))
+#define PLLA_SWCR2_MASK		GENMASK(15, 8)
+
 static const struct ccu_pll_rate_tbl *ccu_pll_lookup_best_rate(struct ccu_pll *pll,
 							       unsigned long rate)
 {
@@ -155,3 +159,121 @@ U_BOOT_DRIVER(spacemit_clk_pll) = {
 	.ops	= &spacemit_clk_pll_ops,
 	.flags	= DM_FLAG_PRE_RELOC,
 };
+
+static const struct ccu_pll_rate_tbl *ccu_plla_lookup_matched_entry(struct ccu_pll *pll)
+{
+	struct ccu_pll_config *config = &pll->config;
+	const struct ccu_pll_rate_tbl *entry;
+	u32 i, swcr1, swcr2, swcr3;
+
+	swcr1 = ccu_read(&pll->common, swcr1);
+	swcr2 = ccu_read(&pll->common, swcr2);
+	swcr2 &= PLLA_SWCR2_MASK;
+	swcr3 = ccu_read(&pll->common, swcr3);
+
+	for (i = 0; i < config->tbl_num; i++) {
+		entry = &config->rate_tbl[i];
+
+		if (swcr1 == entry->swcr1 &&
+		    swcr2 == entry->swcr2 &&
+		    swcr3 == entry->swcr3)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static void ccu_plla_update_param(struct ccu_pll *pll, const struct ccu_pll_rate_tbl *entry)
+{
+	struct ccu_common *common = &pll->common;
+
+	regmap_write(common->regmap, common->reg_swcr1, entry->swcr1);
+	regmap_write(common->regmap, common->reg_swcr3, entry->swcr3);
+	ccu_update(common, swcr2, PLLA_SWCR2_MASK, entry->swcr2);
+}
+
+static int ccu_plla_enable(struct clk *clk)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	struct ccu_common *common = &pll->common;
+	unsigned int tmp;
+
+	ccu_update(common, swcr2, PLLA_SWCR2_EN, PLLA_SWCR2_EN);
+
+	/* check lock status */
+	return regmap_read_poll_timeout(common->lock_regmap,
+					pll->config.reg_lock,
+					tmp,
+					tmp & pll->config.mask_lock,
+					PLL_DELAY_US, PLL_TIMEOUT_US);
+}
+
+static int ccu_plla_disable(struct clk *clk)
+{
+	struct ccu_common *common = clk_to_ccu_common(clk);
+
+	ccu_update(common, swcr2, PLLA_SWCR2_EN, 0);
+
+	return 0;
+}
+
+/*
+ * PLLAs must be gated before changing rate, which is ensured by
+ * flag CLK_SET_RATE_GATE.
+ */
+static unsigned long ccu_plla_set_rate(struct clk *clk, unsigned long rate)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_pll_lookup_best_rate(pll, rate);
+	ccu_plla_update_param(pll, entry);
+
+	return 0;
+}
+
+static unsigned long ccu_plla_recalc_rate(struct clk *clk)
+{
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	const struct ccu_pll_rate_tbl *entry;
+
+	entry = ccu_plla_lookup_matched_entry(pll);
+
+	WARN_ON_ONCE(!entry);
+
+	return entry ? entry->rate : 0;
+}
+
+static const struct clk_ops spacemit_clk_plla_ops = {
+	.enable = ccu_plla_enable,
+	.disable = ccu_plla_disable,
+	.set_rate = ccu_plla_set_rate,
+	.get_rate = ccu_plla_recalc_rate,
+};
+
+int spacemit_plla_init(struct ccu_common *common)
+{
+	struct clk *clk = &common->clk;
+	struct ccu_pll *pll = clk_to_ccu_pll(clk);
+	int ret;
+
+	ret = clk_register(clk, UBOOT_DM_SPACEMIT_CLK_PLLA,
+			   common->name, common->parents[0]);
+	if (ret)
+		return ret;
+
+	if (ccu_plla_lookup_matched_entry(pll))
+		return 0;
+
+	ccu_plla_disable(clk);
+	ccu_plla_update_param(pll, &pll->config.rate_tbl[0]);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(spacemit_clk_plla) = {
+	.name	= UBOOT_DM_SPACEMIT_CLK_PLLA,
+	.id	= UCLASS_CLK,
+	.ops	= &spacemit_clk_plla_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/spacemit/clk_pll.h b/drivers/clk/spacemit/clk_pll.h
index 3987cc1141b..0de027dc7a6 100644
--- a/drivers/clk/spacemit/clk_pll.h
+++ b/drivers/clk/spacemit/clk_pll.h
@@ -20,14 +20,28 @@
  * configuration.
  *
  * @rate:	PLL rate
- * @swcr1:	Register value of PLLX_SW1_CTRL (PLLx_SWCR1).
- * @swcr3:	Register value of the PLLx_SW3_CTRL's lowest 31 bits of
- *		PLLx_SW3_CTRL (PLLx_SWCR3). This highest bit is for enabling
- *		the PLL and not contained in this field.
+ * @swcr1:	Value of register PLLx_SW1_CTRL.
+ * @swcr2:	Value of register PLLAx_SW2_CTRL (PLLA only).
+ * @swcr3:	Value of register PLLx_SW3_CTRL.
+ *
+ * Regular PLL type
+ *  | Enable | swcr3 | PLLx_SW3_CTRL - BIT[31]    |
+ *  -----------------------------------------------
+ *  | Config | swcr1 | PLLx_SW1_CTRL - BIT[31:0]  |
+ *  |        | swcr2 | Not used                   |
+ *  |        | swcr3 | PLLx_SW3_CTRL - BIT[30:0]  |
+ *
+ * Special PLL type A
+ *  | Enable | swcr2 | PLLAx_SW2_CTRL - BIT[16]   |
+ *  -----------------------------------------------
+ *  | Config | swcr1 | PLLAx_SW1_CTRL - BIT[31:0] |
+ *  |        | swcr2 | PLLAx_SW2_CTRL - BIT[15:8] |
+ *  |        | swcr3 | PLLAx_SW3_CTRL - BIT[31:0] |
  */
 struct ccu_pll_rate_tbl {
 	unsigned long rate;
 	u32 swcr1;
+	u32 swcr2;
 	u32 swcr3;
 };
 
@@ -38,6 +52,14 @@ struct ccu_pll_rate_tbl {
 		.swcr3	= _swcr3,		\
 	}
 
+#define CCU_PLLA_RATE(_rate, _swcr1, _swcr2, _swcr3)	\
+	{						\
+		.rate	= _rate,			\
+		.swcr1	= _swcr1,			\
+		.swcr2	= _swcr2,			\
+		.swcr3	= _swcr3,			\
+	}
+
 struct ccu_pll_config {
 	const struct ccu_pll_rate_tbl *rate_tbl;
 	u32 tbl_num;
@@ -69,6 +91,18 @@ static struct ccu_pll _var = {							\
 	}									\
 }
 
+#define CCU_PLLA_DEFINE(_id, _var, _name, _parent, _table, _reg_swcr1,		\
+			_reg_swcr2, _reg_swcr3, _reg_lock, _mask_lock, _flags)	\
+static struct ccu_pll _var = {							\
+	.config	= CCU_PLL_CONFIG(_table, _reg_lock, _mask_lock),		\
+	.common = {								\
+		.reg_swcr1	= _reg_swcr1,					\
+		.reg_swcr2	= _reg_swcr2,					\
+		.reg_swcr3	= _reg_swcr3,					\
+		CCU_COMMON(_id, _name, _parent, spacemit_plla_init, _flags)	\
+	}									\
+}
+
 static inline struct ccu_pll *clk_to_ccu_pll(struct clk *clk)
 {
 	struct ccu_common *common = clk_to_ccu_common(clk);
@@ -77,5 +111,6 @@ static inline struct ccu_pll *clk_to_ccu_pll(struct clk *clk)
 }
 
 int spacemit_pll_init(struct ccu_common *common);
+int spacemit_plla_init(struct ccu_common *common);
 
 #endif /* _CLK_PLL_H_ */

-- 
2.55.0

