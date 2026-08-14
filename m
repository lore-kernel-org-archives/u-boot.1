Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC5FC5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 01:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14DC860664;
	Fri, 14 Aug 2026 01:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IQAODkBIScKd; Fri, 14 Aug 2026 01:48:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3782160621
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786672100;
	bh=5MP0E9OkqZXseGPG03OlDqwXtLCWSKCYRj3dfUjJ0fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Toi8MeQH/5xxlc0F+XnkL6ZnidqHd3Fb4FENszjvlQ+P0gcoLKpoFIpy7BwoRN83H
	 3ZWuCukgVrItGKUzYPM/P7WUR4Y6+IViJ8teGAURlTVwyicCzyVhWZfM+jjXI1xkjz
	 oadyFTRSnfH+onY/GuRqpJI1zNY7t3IPRN74PjwYEOTbTcqmr5EYu2ahKCXw1SBB/B
	 T8yQ6ZQGoQ9JEEs+flnG9YFhQ6/ScgdKoEWUYZenbkY0apEl8bjJn7KiPFpVogHFx/
	 l4s1EMkUza7ER8Ul+8NOiH7wvgCVo05mC2bZed88ys0sYMw2ewuym/ln4+dXV1ieP0
	 yeQ4n/Bj75ufA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3782160621;
	Fri, 14 Aug 2026 01:48:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD26A1393
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF75C400D8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmTFKLesZged for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 01:48:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5FA92401BB
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FA92401BB
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=ejW9+Zet
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FA92401BB
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 01:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786672070; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Xy1SYZC10B5Ju0xiZ6bmMO+Omh59oQcbsXqCSiuR3/wdKNYxwLjzxJtzCbSh1UaojJ/fUDtv91Tp9F8xjXbtyN8b8nNTIgHs+OoldlDLGOP9g1UTdok29mmsm6dhi05lys1Inztv7fwumg9Vtj6MgZT6QY5/VWC+CAS7izPr2IA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786672070;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5MP0E9OkqZXseGPG03OlDqwXtLCWSKCYRj3dfUjJ0fg=; 
 b=IT4SXYoFx5tl7Tec5tX6skUvva7d4fvtA95u6tDX1N+A44CmzLeej/BeAKdPrVyVoPo+ELrZUpAuY6v8AmBBpdIuMuRw3kMlgP8LRbMx6Ap53ZyuXR9tmW+chmJ1JdUI5g7PUjcDX7RJPO8uN3IaD/g7YP2HWUg1+v6Ydu3nMSE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786672070; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5MP0E9OkqZXseGPG03OlDqwXtLCWSKCYRj3dfUjJ0fg=;
 b=ejW9+Zet4W5mH35gYps5kRUVQ+iGJDTUSAinOcPp4zxkRYWwt4KX0DsDt18oxsfe
 IqMycvjO1pXpitdJbSAbjo0llW4eauDiDXN7uojPvp+8/15S5ilE9JOJLHVYDSZOW3d
 pa6Yg7GXGfywx+SbcToX8e6azNuUuDL/r1gvXEmk=
Received: by mx.zohomail.com with SMTPS id 1786672069194526.2959719393502;
 Thu, 13 Aug 2026 18:47:49 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 14 Aug 2026 09:46:57 +0800
Subject: [PATCH 2/2] i2c: k1: enable all clocks for I2C controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-k1-i2c-fix-v1-2-f2e19cbe0af6@pigmoral.tech>
References: <20260814-k1-i2c-fix-v1-0-f2e19cbe0af6@pigmoral.tech>
In-Reply-To: <20260814-k1-i2c-fix-v1-0-f2e19cbe0af6@pigmoral.tech>
To: Guodong Xu <guodong@riscstar.com>, Heiko Schocher <hs@nabladev.com>, 
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6668;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=X0S/qnilp83ZGaHiRv4wm7N4II2CfCpYh6g+8Do0cmk=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLqitfn/Nn87/ObzQHli+MkZQ4LOLnOX5L05eTL7zx1D
 C73C/fwdZSyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjCRj7MZGaZdvW8TVlV2indJ
 2EyLMo/y+YUlybMZfuee5+fKtjbWvsbIsPBr+QPuLQK9HyNV7s3Kclz4UvW88upTO7dEb2ze/4x
 5KTcA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The K1 clock driver modeled the bus clock enable bit as part of the
functional clock for regular TWSI controllers. The I2C driver then only
enabled the functional clock, ignoring the separate bus clock described
by the device tree. Although this happened to work, it did not match the
hardware clock topology or the device tree binding.

Model the functional and bus clocks separately and make the I2C driver
acquire and enable all clocks provided by the device tree. Also add the
TWSI2 and TWSI8 bus clocks, together with their APB clock dependencies,
to the SPL clock tree.

Keep the combined functional and bus gate for TWSI8, whose clock control
register is write-only, and retain its bus clock as a fixed-factor
placeholder.

The clock-provider and I2C-consumer changes should be applied together,
as either change on its own would leave I2C unusable.

Fixes: 3aa2882a3e1a ("clk: spacemit: Add support for K1 SoC")
Fixes: 271546fb8e54 ("i2c: k1: add I2C driver support")
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/spacemit/clk-k1.c | 41 +++++++++++++++++++++++++++++++++--------
 drivers/i2c/k1_i2c.c          | 10 ++++------
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
index 07adc126ee39..20b8595aa3c4 100644
--- a/drivers/clk/spacemit/clk-k1.c
+++ b/drivers/clk/spacemit/clk-k1.c
@@ -154,11 +154,27 @@ CCU_GATE_DEFINE(CLK_PLL1_409P6, pll1_d6_409p6, pll1_d6_409p6, "pll1_d6",
 		MPMU_ACGR, BIT(0), 0);
 CCU_GATE_DEFINE(CLK_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
 		MPMU_ACGR, BIT(13), 0);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_102P4, pll1_d24_102p4, pll1_d24_102p4,
+		       "pll1_d8", MPMU_ACGR, BIT(12), 3, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_51P2, pll1_d48_51p2, pll1_d48_51p2,
+		       "pll1_d8", MPMU_ACGR, BIT(7), 6, 1);
+CCU_FACTOR_GATE_DEFINE(CLK_PLL1_25P6, pll1_d96_25p6, pll1_d96_25p6,
+		       "pll1_d8", MPMU_ACGR, BIT(4), 12, 1);
 CCU_FACTOR_GATE_DEFINE(CLK_PLL1_31P5, pll1_d78_31p5, pll1_d78_31p5,
 		       "pll1_d4", MPMU_ACGR, BIT(6), 39, 2);
 CCU_DDN_DEFINE(CLK_SLOW_UART2, slow_uart2_48, slow_uart2_48,
 	       "pll1_d4_614p4", MPMU_SUCCR_1,
 	       CCU_DDN_MASK(16, 13), 16, CCU_DDN_MASK(0, 13), 0, 2, 0);
+
+static const char * const apb_parents[] = {
+	"pll1_d96_25p6",
+	"pll1_d48_51p2",
+	"pll1_d96_25p6",
+	"pll1_d24_102p4",
+};
+
+CCU_MUX_DEFINE(CLK_APB, apb_clk, apb_clk, apb_parents, ARRAY_SIZE(apb_parents),
+	       MPMU_APBCSCR, 0, 2, 0);
 #else
 CCU_GATE_DEFINE(CLK_PLL1_307P2, pll1_d8_307p2, pll1_d8_307p2, "pll1_d8",
 		MPMU_ACGR, BIT(13), 0);
@@ -298,7 +314,7 @@ static const char * const twsi_parents[] = {
 
 CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI2_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 /*
  * APBC_TWSI8_CLK_RST has a quirk that reading always results in zero.
  * Combine functional and bus bits together as a gate to avoid sharing the
@@ -306,6 +322,9 @@ CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
  */
 CCU_GATE_DEFINE(CLK_TWSI8, twsi8_clk, twsi8_clk, "pll1_d78_31p5",
 		APBC_TWSI8_CLK_RST, BIT(1) | BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TWSI2_BUS, twsi2_bus_clk, twsi2_bus_clk, "apb_clk",
+		APBC_TWSI2_CLK_RST, BIT(0), 0);
+CCU_FACTOR_DEFINE(CLK_TWSI8_BUS, twsi8_bus_clk, twsi8_bus_clk, "apb_clk", 1, 1);
 
 #else
 static const char * const uart_clk_parents[] = {
@@ -326,7 +345,7 @@ static const char * const twsi_parents[] = {
 
 CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI2_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 /*
  * APBC_TWSI8_CLK_RST has a quirk that reading always results in zero.
  * Combine functional and bus bits together as a gate to avoid sharing the
@@ -448,22 +467,22 @@ CCU_GATE_DEFINE(CLK_RTC, rtc_clk, rtc_clk, "clock-32k", APBC_RTC_CLK_RST,
 
 CCU_MUX_GATE_DEFINE(CLK_TWSI0, twsi0_clk, twsi0_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI0_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI1, twsi1_clk, twsi1_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI1_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI4, twsi4_clk, twsi4_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI4_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI5, twsi5_clk, twsi5_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI5_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI6, twsi6_clk, twsi6_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI6_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 CCU_MUX_GATE_DEFINE(CLK_TWSI7, twsi7_clk, twsi7_clk, twsi_parents,
 		    ARRAY_SIZE(twsi_parents), APBC_TWSI7_CLK_RST,
-		    4, 3, BIT(1) | BIT(0), 0);
+		    4, 3, BIT(1), 0);
 
 static const char * const timer_parents[] = {
 	"pll1_d192_12p8",
@@ -1232,8 +1251,12 @@ static struct clk *k1_ccu_mpmu_clks[] = {
 	&pll1_d4_614p4.common.clk,
 	&pll1_d6_409p6.common.clk,
 	&pll1_d8_307p2.common.clk,
+	&pll1_d24_102p4.common.clk,
+	&pll1_d48_51p2.common.clk,
+	&pll1_d96_25p6.common.clk,
 	&pll1_d78_31p5.common.clk,
 	&slow_uart2_48.common.clk,
+	&apb_clk.common.clk,
 };
 #else
 static struct clk *k1_ccu_mpmu_clks[] = {
@@ -1288,6 +1311,8 @@ static struct clk *k1_ccu_apbc_clks[] = {
 	&uart0_clk.common.clk,
 	&twsi2_clk.common.clk,
 	&twsi8_clk.common.clk,
+	&twsi2_bus_clk.common.clk,
+	&twsi8_bus_clk.common.clk,
 };
 #else
 static struct clk *k1_ccu_apbc_clks[] = {
diff --git a/drivers/i2c/k1_i2c.c b/drivers/i2c/k1_i2c.c
index 2c7a1e0d3775..b11f73959a08 100644
--- a/drivers/i2c/k1_i2c.c
+++ b/drivers/i2c/k1_i2c.c
@@ -51,7 +51,7 @@ struct k1_i2c {
 struct k1_i2c_priv {
 	int id;
 	void __iomem *base;
-	struct clk clk;
+	struct clk_bulk clks;
 };
 
 /*
@@ -487,15 +487,13 @@ static int k1_i2c_probe(struct udevice *bus)
 		return ret;
 	}
 
-	ret = clk_get_by_index(bus, 0, &priv->clk);
+	ret = clk_get_bulk(bus, &priv->clks);
 	if (ret)
 		return ret;
 
-	ret = clk_enable(&priv->clk);
-	if (ret && ret != -ENOSYS && ret != -EOPNOTSUPP) {
-		debug("%s: failed to enable clock\n", __func__);
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret)
 		return ret;
-	}
 
 	priv->base = (void *)devfdt_get_addr_ptr(bus);
 

-- 
2.55.0

