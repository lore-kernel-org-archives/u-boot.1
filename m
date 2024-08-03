Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B166C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B67A88CBF;
	Sat,  3 Aug 2024 13:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+0ZeGsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4DCE88C89; Sat,  3 Aug 2024 13:13:10 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1C488C6D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso113670091fa.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683588; x=1723288388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3lIRnAjdTao3YSkLCOvkKSbCs6hrDofoqspPWHdjbr0=;
 b=E+0ZeGsb5XwqJZSUdM7L7HOUkY8RjJqky+nkaGz8qbM0UIgxlDvyHJImo708z5Nd0b
 apHUIDhEPZh3MeZjrhLfpLYEZX+/cu8w5Lz/ajh0OYTJ1Zb7hCPH4NjR/L4PBWLiIWWD
 9sUuncEqMA+JLoSokPyMRTqiAL/kzGXYyvMnrbuvOTwCHXVYt05KI2N6XHkmmAQJiRNY
 Hw8s6mAGUcrnVUtg1CJKQ1b8aArFrU3Gj6MQN4dUExS6w45FODSCggyXRSkBGvVASiw4
 oFL7q/fFic0HV3gEG9TCgvxX1CzUp0hSEaIDL7k4b3o+8AsrO0e5SpzIrmHrLkOLmTzX
 RG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683588; x=1723288388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lIRnAjdTao3YSkLCOvkKSbCs6hrDofoqspPWHdjbr0=;
 b=aPf/B84KKIEyX7alDd9nGZNpECJUkBrsOj79Wk1VrmdsvQyWK8udEyQOM8LrpuNvRN
 ypKN4DMwom4gTt5A5ELtW2J79uEE9gE9IvdEu3GAqhgGb94VqhcrfoEYI+4X9knN0leL
 wWpt29K+/WRA7Zxu8iXnOeOc6CwUrc/9Xr1taQKnpQi3AdeLtzUHA2jwvc+28cU3FYMn
 YD/fmzZCvv2d+LRnY1OWSS1E16sLx1ANP2JO/l/lGSFXGNApERTCQe/aRIsZsSAAjmiP
 hOAfPU7ahSCNBJ880NllnY1NEFWHrul+ufCGBaQZThMZbTglT1e8wzLeEzu1v5EbIjE9
 zHxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmxDMW/MNZvfZMiePSyuUokIG2Cw94pFGq4QfXTXEiMZqWheXNPGOiDHw0wIheerfdWm4tgq/jPDfsnjJIf3l/35FYBg==
X-Gm-Message-State: AOJu0YxBD/kThzCZcxgVimjbvc26RaHmeGE/kTaRjusTfWQLf/x9PF/n
 /7qWNfpyGABtTJTUfChdCCucZ6lve2IifDDRqq3u3/U/omHi3WZEV+9l7g==
X-Google-Smtp-Source: AGHT+IHRVlLn9PeSoMpHZqyE9qm9a3xbQ5AeAQOYwp+0N5e/rqvKhIfXiwuC/MmX3fE9cx4DKK8tvA==
X-Received: by 2002:a2e:720a:0:b0:2ee:7dfe:d99c with SMTP id
 38308e7fff4ca-2f15ab0c434mr46080281fa.31.1722683587449; 
 Sat, 03 Aug 2024 04:13:07 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6d648a0sm63835655e9.10.2024.08.03.04.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:13:07 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 5/8] clk: mediatek: mt7622: add missing clock MUX1_SEL
Date: Sat,  3 Aug 2024 10:43:23 +0200
Message-ID: <20240803084329.1688-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084329.1688-1-ansuelsmth@gmail.com>
References: <20240803084329.1688-1-ansuelsmth@gmail.com>
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

