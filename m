Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D63C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F9088C42;
	Fri,  2 Aug 2024 21:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YnA5KOhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9412F88C0F; Fri,  2 Aug 2024 21:52:04 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9500688C2F
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso56069065e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628322; x=1723233122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3lIRnAjdTao3YSkLCOvkKSbCs6hrDofoqspPWHdjbr0=;
 b=YnA5KOheQzuyBbrhlWJNvuj0bCAjahrJkwCAiJKvpJeBW+0dtXh/RiwitIEnqPT6ir
 A58pNylQPV4yp+MhLiBQ5WVM6O0+Pdvn3mUFfobYMcUfeTvv7e7O1D0q4zQE3UM80eri
 vcQG62KotctDJrIljSS0UWnMyTFzJNQm9gvu2kPYwpkut6/fghqqwdNrimNW/xQ86ese
 ECu38jYK531lDal4LGSiNfW8em9CDGfV8pmQD8MJeBOanKzyeEx/CaivYWL6EE2w6xrT
 xaV51RbF6E7kelNZiqAr0xX/RgxoivdG1AVKtqm5XgE6CIljNHM/Gz5RGtRz2w+II5cX
 3jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628322; x=1723233122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lIRnAjdTao3YSkLCOvkKSbCs6hrDofoqspPWHdjbr0=;
 b=CG8LyM9SBDOGg+cZSJXW5MFlHvASOIG9c670qxSi1pH+InXV9IlLxQN3uBbb/0Dv3w
 ej/Pcn3qoOQQ7XRjM4o1RqFtjDtmrV5Lq1OYUIfJ1dudM9ZUOSbzSntM+WeLPgessLPs
 cl7kcl3y84AJN575/0hVFrHDrrHmy/1g5lyxK2oPLuJo/pgUO75J357Ygm8Qsdgfwkw1
 AjtzYkkMnC/c2F+/8/e3XcyrZAUzwjuig7gzy/suJT3ASJpAGA7fQYJTnJizMPUQ9JOL
 6cXrEenh+eqkbd6uMifLHdp1QqckYiOqaDANh4jbRjW9X8YQNQyf2fRU2IBcYF52rZ4O
 1Psg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoS0EiPTSCesCny2jbSNeGWDOqZJ6rBGYlqoOxfWNMk8TiBXTCqV3i61rhh+ONqlc0UfTy4am6ItlznzM/OfLB7FdmeA==
X-Gm-Message-State: AOJu0YwwYuFLcfXw+3duNoHh+j7aQbOXp/5IHT2tbdUUvGIrwTDE1tFp
 UXfeP2g4yYl3ihZF9B1zOOmYaIHJEf6S8Vruh1gAkCAvl7drxO8T
X-Google-Smtp-Source: AGHT+IHXIxxaWc7GCNT5eScjFypELxN+7yoPmEsArVwugVAj2MqM8tXO1sRjTYDncH4hl/02fXjzyw==
X-Received: by 2002:a5d:4108:0:b0:367:95d2:4ec0 with SMTP id
 ffacd0b85a97d-36bbc182896mr2374890f8f.62.1722628321966; 
 Fri, 02 Aug 2024 12:52:01 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbd06d03fsm2643344f8f.91.2024.08.02.12.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:52:01 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 5/8] clk: mediatek: mt7622: add missing clock MUX1_SEL
Date: Fri,  2 Aug 2024 15:48:29 +0200
Message-ID: <20240802134835.24006-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802134835.24006-1-ansuelsmth@gmail.com>
References: <20240802134835.24006-1-ansuelsmth@gmail.com>
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

Add missing infra clock MUX1_SEL needed for CPU clock. This is needed to
match the upstream clk ID order in preparation for OF_UPSTREAM.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622.c      | 24 +++++++++++++++++++++++-
 include/dt-bindings/clock/mt7622-clk.h | 13 +++++++------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 49adffb3b43..0da7a848163 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -384,6 +384,20 @@ static const struct mtk_composite top_muxes[] = {
 };
 
 /* infracfg */
+#define APMIXED_PARENT(_id) PARENT(_id, CLK_PARENT_APMIXED)
+#define XTAL_PARENT(_id) PARENT(_id, CLK_PARENT_XTAL)
+
+static const struct mtk_parent infra_mux1_parents[] = {
+	XTAL_PARENT(CLK_XTAL),
+	APMIXED_PARENT(CLK_APMIXED_MAINPLL),
+	APMIXED_PARENT(CLK_APMIXED_MAIN_CORE_EN),
+	APMIXED_PARENT(CLK_APMIXED_MAINPLL),
+};
+
+static const struct mtk_composite infra_muxes[] = {
+	MUX_MIXED(CLK_INFRA_MUX1_SEL, infra_mux1_parents, 0x000, 2, 2),
+};
+
 static const struct mtk_gate_regs infra_cg_regs = {
 	.set_ofs = 0x40,
 	.clr_ofs = 0x44,
@@ -579,6 +593,14 @@ static const struct mtk_clk_tree mt7622_apmixed_clk_tree = {
 	.gates = apmixed_cgs,
 };
 
+static const struct mtk_clk_tree mt7622_infra_clk_tree = {
+	.xtal_rate = 25 * MHZ,
+	.muxes_offs = CLK_INFRA_MUX1_SEL,
+	.gates_offs = CLK_INFRA_DBGCLK_PD,
+	.muxes = infra_muxes,
+	.gates = infra_cgs,
+};
+
 static const struct mtk_clk_tree mt7622_clk_tree = {
 	.xtal_rate = 25 * MHZ,
 	.fdivs_offs = CLK_TOP_TO_USB3_SYS,
@@ -630,7 +652,7 @@ static int mt7622_topckgen_probe(struct udevice *dev)
 
 static int mt7622_infracfg_probe(struct udevice *dev)
 {
-	return mtk_common_clk_gate_init(dev, &mt7622_clk_tree, infra_cgs);
+	return mtk_common_clk_infrasys_init(dev, &mt7622_infra_clk_tree);
 }
 
 static int mt7622_pericfg_probe(struct udevice *dev)
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 569bfce0d05..0820fab0a22 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -120,12 +120,13 @@
 
 /* INFRACFG */
 
-#define CLK_INFRA_DBGCLK_PD		0
-#define CLK_INFRA_AUDIO_PD		1
-#define CLK_INFRA_IRRX_PD		2
-#define CLK_INFRA_APXGPT_PD		3
-#define CLK_INFRA_PMIC_PD		4
-#define CLK_INFRA_TRNG			5
+#define CLK_INFRA_MUX1_SEL		0
+#define CLK_INFRA_DBGCLK_PD		1
+#define CLK_INFRA_AUDIO_PD		2
+#define CLK_INFRA_IRRX_PD		3
+#define CLK_INFRA_APXGPT_PD		4
+#define CLK_INFRA_PMIC_PD		5
+#define CLK_INFRA_TRNG			6
 
 /* PERICFG */
 
-- 
2.45.2

