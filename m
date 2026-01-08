Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7A2D1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C318415E;
	Thu,  8 Jan 2026 20:50:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OM4XpYGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC0418422D; Thu,  8 Jan 2026 20:50:47 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF44484150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7cee045187so402716966b.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767901845; x=1768506645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fVFZuawwBMVetxYrrY4oTe4EDWuqsFlr1kdEq/sujtY=;
 b=OM4XpYGqnjfbgI3JiPpOO5wBFol6Uq9lIW6GhN0lXF4VIbcTAsXJkR24gsEzI6h33n
 +ejEyRq8Y1htoCAGk+W3xmDfNb5jx2bq/6kdjStSOO3RyN2Ri3UxeOIBKGsy6WobYkFq
 90lbsA5Ngrp++OogBaAMyn8Ucya1FCLEG2yL3U2xdJ3uH62fYVGmSfgAzjiYvxQzasYy
 bPiiR8wdVD2Ka2oDCFPa2YOY7cyczQQQx516G5ovB2yzYqgIZwCvxGuEMGDi6HCNddo1
 NggGYwU8BAx7meUxuOJtzdV7chUChyGgvRiQvTDWdqCmia1A65UvDMOJtOdFx2DaO/xh
 J6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767901845; x=1768506645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVFZuawwBMVetxYrrY4oTe4EDWuqsFlr1kdEq/sujtY=;
 b=RCyb9GtFSWHWT3B0yuV8TM1NxhFmjcvV7HMT+9CH1JqWRNECr5GjLu1jpufyOGkD0U
 suac8izDL6KE2PBDb9uB3zTvG2BzCR6rniVXWOptCkVjy8g9xN1ybyhae1EN1LTG9Bgv
 VznjTPwaBIHT2syHvSXqn5PFsdlz8IvhTTdISYAtHfbeHA5qe/2+LOSxvWhob7olUVgF
 85Oo/I98iReYNOtwt2OYhoFkGvwWgGRSM1qaKmMmGGCDgH3WreYPqIMTbYqNBqEN9pIT
 KTC8KddfzHZZKr+A8vZXsk4NyUUF9I5HY8dGrnRPYJtfUF5gIEPnpGEIUGR6Njup0riZ
 iYiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHiut2S0lsvKZ+HFHYsw8s79TmnWljeesp2YitBgZbzIcvnUD3nRJ+KkrbPs6b5tsS3akD7YA=@lists.denx.de
X-Gm-Message-State: AOJu0YzO9basWio024t/SlVGdOrNYcn3r8DEHlgISTbhHGjRchrMo339
 0iAdf+5LT0ZMtnTGVI7O0xUFN3DUzQOTVm6m9vzmuonq/P0O+R2afdopou5ItBdWxxc=
X-Gm-Gg: AY/fxX7M00yRHS7Eg2cZCmUcKNhFgZNyyELpaDNkoyTJJnW1vzwBlsp99VXHUCA9Lqn
 RFsZrvxtzR8F1GFuVCsE0JN4HHUPPZDxEr6+qQEWyAQd3PawYIdFm5ybq+YJR0pEhOH4d7UnlXH
 JH2yTRwtJ3kghfZEw24uV9E4YHCNvIHklo9paEHpcOUDaoKQ6du5e+2Il6Lnu7mH8KLOkG0B8uC
 teBE+OpDVCtA3jCNAcxu7j8wyDv0OaRr2RXSLz6s5M1QfVGPQfRTg1D+cXJeJt92M3swYJnFZge
 9BgIXfPG0gEut4Z2wLzHavhkc+FYTxg9zDgkDdP4L0+0+4Gbmy4aE8T3HqCCp4dryII44VCavx1
 6NRgZo4K0Rxq97xtmg4cTe+/LgOmeh3TOqre94m7VYSNlXGblA2+0HS4rp4p7LW5xQg33zLHvC+
 TPw7RIgfDdXCVmAVCYoMTjJK0NUuVJhzTyLx9B5F+cQUc/+iNPB+CbCi3MBSrXSH6TRcY3BVUd
X-Google-Smtp-Source: AGHT+IHvSwsy2vkuhehEU4WjNf8vXqIhkJLNSgVQGq1JvJYu4i8PFp2PProJ3jMC8e8LOAitHv4ytA==
X-Received: by 2002:a17:907:6d1a:b0:b71:60a3:a8b9 with SMTP id
 a640c23a62f3a-b8444fd0ae6mr791590266b.29.1767901845107; 
 Thu, 08 Jan 2026 11:50:45 -0800 (PST)
Received: from lion.tail248178.ts.net (p5b29e30b.dip0.t-ipconnect.de.
 [91.41.227.11]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4cfe76sm875780866b.40.2026.01.08.11.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 11:50:44 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 u-boot@lists.denx.de
Subject: [PATCH] clk/qcom: sc7280: add more QUP clocks
Date: Thu,  8 Jan 2026 20:49:55 +0100
Message-ID: <20260108195007.3156604-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add more clocks for UART2, i2c9 and a few others. This is enough to get
the rubikpi 3 working.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 55a233df3945..7b6ed8260236 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -62,8 +62,13 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
 
 	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S2_CLK: /* UART2 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x17270,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
 	case GCC_QUPV3_WRAP0_S5_CLK: /* UART5 */
 		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, 0x17600,
 				     freq->pre_div, freq->m, freq->n, freq->src, 16);
@@ -131,11 +136,15 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_AGGRE_NOC_PCIE_1_AXI_CLK, 0x52000, BIT(11)),
 	GATE_CLK(GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK, 0x52008, BIT(28)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x52008, BIT(12)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x52008, BIT(14)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, BIT(15)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK, 0x52008, BIT(16)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, BIT(17)),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x52008, BIT(23)),
 	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),
@@ -189,8 +198,11 @@ static int sc7280_enable(struct clk *clk)
 		break;
 	case GCC_QUPV3_WRAP0_S3_CLK:
 		clk_rcg_set_rate_mnd(priv->base, 0x173a0, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
 		break;
+	case GCC_QUPV3_WRAP1_S1_CLK:
+		clk_rcg_set_rate_mnd(priv->base, 0x18140, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
+		break;
 	}
 
 	return qcom_gate_clk_en(priv, clk->id);
 }
-- 
2.51.0

