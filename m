Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7354C5DF67
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 03:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF1708136D;
	Sat, 15 Aug 2026 03:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5p_43Mk7a7wy; Sat, 15 Aug 2026 03:42:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90D3181354
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786765332;
	bh=IzsIkDTSzmyNS6leFC6bGSwIztv77Df7upCwhcjHU0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wS+Dy6+uBpAPi52bQo85AWdVErd4Mib9euu/RumbrHmPMzAPxw/mmOEorXUN8zQ+8
	 PL5uddNWzvXl6Ha+elfpc2yy3gDGglYAERS3rjPsbphja+oVIC/1M7FLtY+W5L+bZw
	 JdOPRu8r8IzKAz4FsBVbs4SbZL9UGaNygh+Uo8jIQ+uNk4IYZdZ0qasvdquMfZPzxw
	 Y4RVWkl8zSDpbbme52n3qZi6Ct9W7DmBwmqrcFzbk0uw9MQZCUnqtmcB8j0wGQSEDi
	 CYTQU4yGBJFiFWlm2KJmP6tpTEZIlZvWwgfO0f+7GqfpH6+r5F1iwmvrZRbKF82RdA
	 26k1KwXgDcIcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90D3181354;
	Sat, 15 Aug 2026 03:42:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D8053139A
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B42AF60B29
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1SpUtgHvNDR for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 03:42:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B72F160B1E
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B72F160B1E
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=Om/onuDK
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B72F160B1E
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786765299; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mgtpIJd8o7WzL/l+8EuboNdqB4aVMc8nQFlEW2/EwPt9u6sVzmLeyOvfPxn0dGTCT2VdRdv6I+nwYTtppyawXszyGfHMGHCF7hS/xrcLvTv9WisKPWGLr6oHCFAzo++CxrnKCtvr3r4hcD6n27Amw77TY/Y4Lj/d/0Rpps+t7qE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786765299;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IzsIkDTSzmyNS6leFC6bGSwIztv77Df7upCwhcjHU0c=; 
 b=nNUPSD+01M9tYhR1HGHhxuPR8bV/S7FX+6eEXWjKNL2Mj/OJZiaStpsqyHNXWLWokpzHgZocSUm4e0JiW4HkJLoyCTFRdalfG01Rj9XGt6DDz7grx8h7MGWzUupeE1demuM185oievscgXFhIma5+X9GracZNuxzcNURtoNStMw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786765299; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=IzsIkDTSzmyNS6leFC6bGSwIztv77Df7upCwhcjHU0c=;
 b=Om/onuDKSF04VG7Jea6yRP2igeBjCBcu96/IzOvRztGhRITpUhlBf6dj9udzpZbP
 Sxk5wX+IhbFLEX1JAE0h8QdjFQVGVOFn9995lJc2Y0aClcJNMzgOFn4iLvfh2PiwMr3
 MByGRpVq7RI8jqNS0Qm8jcfMbdmNQd2nnMziydsk=
Received: by mx.zohomail.com with SMTPS id 1786765297838360.9041464678844;
 Fri, 14 Aug 2026 20:41:37 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 15 Aug 2026 11:40:22 +0800
Subject: [PATCH v2 2/4] clk: spacemit: k1: add TWSI bus clocks to SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-k1-i2c-fix-v2-2-7d2a48607233@pigmoral.tech>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
In-Reply-To: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
To: Heiko Schocher <hs@nabladev.com>, u-boot-spacemit@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>, 
 Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3198;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=WpdOrO2ySP6YNmrG5hSZd7bYFHDm+sFsEKkTiYaNFuk=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLq71/hOv9ugfet+SytEZUBps+2Tmu0iRDp0hZ+aBpz+
 XOQXoJrRykLgxgXg6yYIguXv/g/ax2eb0cEWu/DzGFlAhnCwMUpABPhaGL4n3Bg77GGVPtHS7J/
 JMiHFldcVl627UDYZ9v3M/4tmv/ZpZuR4coD/WsGQX5nE1bsdTkU75OcU2NRxCb7vch396+gnCM
 enAA=
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

The K1 device tree describes separate functional and bus clocks for TWSI
controllers, but the SPL clock tree currently only provides their
functional clocks.

Add the bus clocks for TWSI2 and TWSI8, which are the TWSI controllers
currently used in SPL, along with their required parent clock chain.

TWSI8 uses a fixed-factor bus clock because its write-only clock control
register requires the functional and bus gate bits to remain combined in
a single clock instance.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/spacemit/clk-k1.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
index 07adc126ee39..e239ffe6ba0d 100644
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
@@ -306,6 +322,9 @@ CCU_MUX_GATE_DEFINE(CLK_TWSI2, twsi2_clk, twsi2_clk, twsi_parents,
  */
 CCU_GATE_DEFINE(CLK_TWSI8, twsi8_clk, twsi8_clk, "pll1_d78_31p5",
 		APBC_TWSI8_CLK_RST, BIT(1) | BIT(0), 0);
+CCU_GATE_DEFINE(CLK_TWSI2_BUS, twsi2_bus_clk, twsi2_bus_clk, "apb_clk",
+		APBC_TWSI2_CLK_RST, BIT(0), 0);
+CCU_FACTOR_DEFINE(CLK_TWSI8_BUS, twsi8_bus_clk, twsi8_bus_clk, "apb_clk", 1, 1);
 
 #else
 static const char * const uart_clk_parents[] = {
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

-- 
2.55.0

