Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E6AC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9689C84BC3;
	Thu,  9 Jul 2026 15:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="LWcVQ++N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E918284B2C; Thu,  9 Jul 2026 14:58:31 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D8B84A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so17449995e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601909; x=1784206709; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V8I2ZkPBm/LbbUZNLJ7So3FT3q7th2a8++d5CkB0Mdg=;
 b=LWcVQ++NU3ZfgtsHoIQnxAMlrr+kbyc8FqdW/VLJ6UIo2W1zW/qKNKmP9HFf5pbXwP
 qWwXw1RTLqICUmIaTOnJH1B8dNmftSNlgDfzky5lG1EBD4HbuQa9+nk6cSZG4s9D9KzU
 bP5JAdSr8u6VjkA6tK0wCZFHV3nUGs0p6ql0A9Ui4Qi3JLtPPkDdk7AjycaeTZxjiH72
 2tIa61XuSFwU7I2m1nIQ8cGXVMnUipFTQC75JyruvJqDL/gT/qjdEujHKApl3IUGWwNM
 2JflVs8r112zmSkAafLKdZlLP1p3FG8vFBMrk0MUA5iMrQKBMC6dK18mev8IUoYoCifg
 ZM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601909; x=1784206709;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V8I2ZkPBm/LbbUZNLJ7So3FT3q7th2a8++d5CkB0Mdg=;
 b=XRjQy0j4iSaOJ95asJn1Ha/UAWf+c+gFDY64arrIT+7LctSLqZPEL7Ks2PSsqZV29T
 lL6+xb0GK6rzPKY0GnyTBAzdNW8lT79PmhhVA6FLwqYGqwyxxufbtyyy/vxI786x1tJ1
 g8hB/aJUP4wc7BvOsNfESQ4b82Zxczk3pq8SSGM7x5LlaDydzzs5BRjB/QiMQIbXtomu
 ymNZbsfOYd9FUvzhbGbxPnE2s19Jfy/aUaQWlmNxOX2YEXJjC4zbzGf8aXVDn2q+bb8a
 PBPp+C8aacypemq+kzux5ANpyT6no59ftwvzESPSDScgtgWsu1AVMfHfAAFGlNatdcNC
 zbZg==
X-Gm-Message-State: AOJu0Yy0ggm6eGsIOZ99STbAt1KgFFZdELYjMV84m2xz4HVtS0hiE7gn
 gLLPp0r3rq4DOhGXAFfxThtYwOhAeIxLZ1QPQZKdl1lL9v97/7cEfc4bjkngUJxtMzHrr73J3R6
 rtwQ/2Do=
X-Gm-Gg: AfdE7ck4KV3bVCNXN2imSK1uQ6/0YhiBy/W3cRcFR8F3O7IRIZTk8LlNcjQFW4yF81y
 vClxjpEilUzmzdHiysoT1XJHXbkt66B3zJERE1Kav/d/VdZwAzRKxnzf/ZRgaw53ArCd8NT/QCs
 sbrhWlZT7lnT00GfcD2nGemIdsSOidDKZ1eVXmhE+5iWkGJs4/JS3k28F5eh9qDEhFV8wYZIopo
 Qhes48E6hH7MxtyG1sTgRWRqPeokp1gmTZaAg2nnVFQjJ7NAi53owqDEK9m7xO6eqyboGGC1H/s
 qkk2MOjqAeYs2HgR8FOMOcibKMr48ZdtLYcbSk8nfQGTjUuCMo3ucluIb38KMANgzhUSyPcYq8n
 hT1yrLL/TrjI3ZCm3HGASKf1UyisvyPCHx+0tk47K2Jts2Y5FbQcQDbkCyNuUmFB9g6xRaaTnrU
 u5d9QF31sK8E4X8VFncAkztWNIL8OeHFX8Nnns/+ZR7Qb7Bne7yQXgfiStvkXvjpCC+zJP5VS/s
 GlDICrg89R+yyfdzTLLFrihKjvnt3DNASxvX/0dZdWPUryw7sDdglNwI/z8vFULj4nwye8=
X-Received: by 2002:a05:600c:a0d:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-493e6841006mr74393875e9.13.1783601908905; 
 Thu, 09 Jul 2026 05:58:28 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:28 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:19 +0200
Subject: [PATCH v2 13/14] power: domain: mediatek: add MT8188 power domain
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-13-589ace7d30e2@baylibre.com>
References: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
In-Reply-To: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
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

Add the power domain driver for the MediaTek MT8188 SoC. It describes
the SoC's power domains (MFG, display, camera, codec, ADSP, PCIe, ...)
as a table of mtk_scp_domain_data entries and reuses the shared scpsys
core through the power-controller probe, including the per-domain power
status offsets and the ordered infracfg bus-protection steps.

The domain tables and ordered bus-protection sequences mirror the
Linux mt8188-pm-domains.h data.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/Kconfig               |  10 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8188-power-domain.c | 665 +++++++++++++++++++++++++++++
 3 files changed, 676 insertions(+)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 0cadd9b93a9..12b0e2c9914 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -103,6 +103,16 @@ config MT7622_POWER_DOMAIN
 	  the SoC power domains on and off and handles the associated bus
 	  protection bits. It is also used on MT7629.
 
+config MT8188_POWER_DOMAIN
+	bool "Enable the MediaTek power domain driver for MT8188 compatible SoC"
+	depends on POWER_DOMAIN && ARCH_MEDIATEK
+	select MTK_POWER_DOMAIN
+	help
+	  Enable support for manipulating MediaTek power domains via MMIO
+	  mapped registers for MT8188 compatible SoC. The driver powers
+	  the SoC power domains on and off and handles the associated bus
+	  protection steps, per-domain clocks and parent domains.
+
 config MTK_POWER_DOMAIN
 	bool
 	depends on POWER_DOMAIN && ARCH_MEDIATEK
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 66772b5d346..e6fe71c374a 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
 obj-$(CONFIG_MT2701_POWER_DOMAIN) += mt2701-power-domain.o
 obj-$(CONFIG_MT7622_POWER_DOMAIN) += mt7622-power-domain.o
+obj-$(CONFIG_MT8188_POWER_DOMAIN) += mt8188-power-domain.o
 obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
 obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
diff --git a/drivers/power/domain/mt8188-power-domain.c b/drivers/power/domain/mt8188-power-domain.c
new file mode 100644
index 00000000000..265d222f17a
--- /dev/null
+++ b/drivers/power/domain/mt8188-power-domain.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS.
+ * Authors: Chris-QJ Chen <chris-qj.chen@mediatek.com>
+ *          Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dt-bindings/power/mediatek,mt8188-power.h>
+#include <linux/bitops.h>
+
+#include "mtk-power-domain.h"
+
+/* Infra bus protection register offsets */
+#define MT8188_TOP_AXI_PROT_EN_SET			0x2A0
+#define MT8188_TOP_AXI_PROT_EN_CLR			0x2A4
+#define MT8188_TOP_AXI_PROT_EN_STA			0x228
+#define MT8188_TOP_AXI_PROT_EN_1_SET			0x2A8
+#define MT8188_TOP_AXI_PROT_EN_1_CLR			0x2AC
+#define MT8188_TOP_AXI_PROT_EN_1_STA			0x258
+#define MT8188_TOP_AXI_PROT_EN_2_SET			0x714
+#define MT8188_TOP_AXI_PROT_EN_2_CLR			0x718
+#define MT8188_TOP_AXI_PROT_EN_2_STA			0x724
+#define MT8188_TOP_AXI_PROT_EN_MM_SET			0x2D4
+#define MT8188_TOP_AXI_PROT_EN_MM_CLR			0x2D8
+#define MT8188_TOP_AXI_PROT_EN_MM_STA			0x2EC
+#define MT8188_TOP_AXI_PROT_EN_MM_2_SET			0xDCC
+#define MT8188_TOP_AXI_PROT_EN_MM_2_CLR			0xDD0
+#define MT8188_TOP_AXI_PROT_EN_MM_2_STA			0xDD8
+#define MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET		0xB84
+#define MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR		0xB88
+#define MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA		0xB90
+#define MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET	0xBCC
+#define MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR	0xBD0
+#define MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA	0xBD8
+
+/* MFG1 bus protection bits */
+#define MT8188_TOP_AXI_PROT_EN_MFG1_STEP1			BIT(11)
+#define MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2			BIT(7)
+#define MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3			BIT(19)
+#define MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4			BIT(5)
+#define MT8188_TOP_AXI_PROT_EN_MFG1_STEP5			GENMASK(22, 21)
+#define MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6	BIT(17)
+
+/* PCIe bus protection bits */
+#define MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1		BIT(2)
+#define MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2	(BIT(8) | BIT(18) | BIT(30))
+
+/* Ethernet / HDMI / DP / eDP bus protection bits */
+#define MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1		BIT(24)
+#define MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1		BIT(20)
+#define MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1		BIT(23)
+#define MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1		BIT(22)
+
+/* ADSP bus protection bits */
+#define MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1			GENMASK(31, 29)
+#define MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2			(GENMASK(4, 3) | BIT(28))
+#define MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1		(GENMASK(16, 14) | BIT(23) | BIT(27))
+#define MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2		(GENMASK(19, 17) | GENMASK(26, 25))
+#define MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1			GENMASK(11, 8)
+#define MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2			GENMASK(22, 21)
+
+/* Audio bus protection bits */
+#define MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1			BIT(20)
+#define MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2			BIT(12)
+#define MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1		BIT(24)
+#define MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2		BIT(13)
+
+/* Video / display bus protection bits */
+#define MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1			BIT(10)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2		GENMASK(9, 8)
+#define MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3			BIT(23)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4		(BIT(1) | BIT(4) | BIT(11))
+#define MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5	BIT(20)
+#define MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1			(GENMASK(18, 17) | GENMASK(21, 20))
+#define MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2			BIT(6)
+#define MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3	BIT(21)
+#define MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1			GENMASK(31, 30)
+#define MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2			BIT(22)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3		BIT(10)
+#define MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1			GENMASK(6, 5)
+#define MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2			BIT(23)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3		BIT(18)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1			BIT(23)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2			BIT(21)
+#define MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1			BIT(13)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2			BIT(13)
+#define MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1			BIT(14)
+#define MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2			BIT(29)
+#define MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1			(BIT(9) | BIT(11))
+#define MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2			BIT(26)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3			BIT(2)
+#define MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1		(BIT(1) | BIT(3))
+#define MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2		BIT(25)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3		BIT(16)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1		GENMASK(27, 26)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2		GENMASK(25, 24)
+#define MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1		(BIT(2) | BIT(4))
+#define MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2		BIT(0)
+#define MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3		BIT(22)
+#define MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4		BIT(24)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5		BIT(17)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1		GENMASK(31, 30)
+#define MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2			BIT(2)
+#define MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3		GENMASK(29, 28)
+#define MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4			BIT(1)
+
+static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
+	[MT8188_POWER_DOMAIN_MFG0] = {
+		.sta_mask = BIT(1),
+		.ctl_offs = 0x300,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8188_POWER_DOMAIN_MFG1] = {
+		.sta_mask = BIT(2),
+		.ctl_offs = 0x304,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_SET,
+				    MT8188_TOP_AXI_PROT_EN_CLR,
+				    MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_1_SET,
+				    MT8188_TOP_AXI_PROT_EN_1_CLR,
+				    MT8188_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
+				    MT8188_TOP_AXI_PROT_EN_SET,
+				    MT8188_TOP_AXI_PROT_EN_CLR,
+				    MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_MFG2] = {
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x308,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8188_POWER_DOMAIN_MFG3] = {
+		.sta_mask = BIT(4),
+		.ctl_offs = 0x30C,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8188_POWER_DOMAIN_MFG4] = {
+		.sta_mask = BIT(5),
+		.ctl_offs = 0x310,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8188_POWER_DOMAIN_PEXTP_MAC_P0] = {
+		.sta_mask = BIT(10),
+		.ctl_offs = 0x324,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_SET,
+				    MT8188_TOP_AXI_PROT_EN_CLR,
+				    MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_PEXTP_PHY_TOP] = {
+		.sta_mask = BIT(12),
+		.ctl_offs = 0x328,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+	},
+	[MT8188_POWER_DOMAIN_CSIRX_TOP] = {
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x3C4,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+	},
+	[MT8188_POWER_DOMAIN_ETHER] = {
+		.sta_mask = BIT(1),
+		.ctl_offs = 0x338,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_HDMI_TX] = {
+		.sta_mask = BIT(18),
+		.ctl_offs = 0x37C,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_ADSP_AO] = {
+		.sta_mask = BIT(10),
+		.ctl_offs = 0x35C,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_ADSP_INFRA] = {
+		.sta_mask = BIT(9),
+		.ctl_offs = 0x358,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_ADSP] = {
+		.sta_mask = BIT(8),
+		.ctl_offs = 0x354,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_AUDIO] = {
+		.sta_mask = BIT(6),
+		.ctl_offs = 0x34C,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_AUDIO_ASRC] = {
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x350,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_VPPSYS0] = {
+		.sta_mask = BIT(11),
+		.ctl_offs = 0x360,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_SET,
+				    MT8188_TOP_AXI_PROT_EN_CLR,
+				    MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_SET,
+				    MT8188_TOP_AXI_PROT_EN_CLR,
+				    MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_VDOSYS0] = {
+		.sta_mask = BIT(13),
+		.ctl_offs = 0x368,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_SET,
+				    MT8188_TOP_AXI_PROT_EN_CLR,
+				    MT8188_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_VDOSYS1] = {
+		.sta_mask = BIT(14),
+		.ctl_offs = 0x36C,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_DP_TX] = {
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x374,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_EDP_TX] = {
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x378,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
+				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_VPPSYS1] = {
+		.sta_mask = BIT(12),
+		.ctl_offs = 0x364,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_WPE] = {
+		.sta_mask = BIT(15),
+		.ctl_offs = 0x370,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_VDEC0] = {
+		.sta_mask = BIT(19),
+		.ctl_offs = 0x380,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_VDEC1] = {
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x384,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_VENC] = {
+		.sta_mask = BIT(22),
+		.ctl_offs = 0x38C,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_IMG_VCORE] = {
+		.sta_mask = BIT(28),
+		.ctl_offs = 0x3A4,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_IMG_MAIN] = {
+		.sta_mask = BIT(29),
+		.ctl_offs = 0x3A8,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_DIP] = {
+		.sta_mask = BIT(30),
+		.ctl_offs = 0x3AC,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8188_POWER_DOMAIN_IPE] = {
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x3B0,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8188_POWER_DOMAIN_CAM_VCORE] = {
+		.sta_mask = BIT(27),
+		.ctl_offs = 0x3A0,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_1_SET,
+				    MT8188_TOP_AXI_PROT_EN_1_CLR,
+				    MT8188_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
+				    MT8188_TOP_AXI_PROT_EN_MM_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_CAM_MAIN] = {
+		.sta_mask = BIT(24),
+		.ctl_offs = 0x394,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
+			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
+				    MT8188_TOP_AXI_PROT_EN_2_SET,
+				    MT8188_TOP_AXI_PROT_EN_2_CLR,
+				    MT8188_TOP_AXI_PROT_EN_2_STA),
+		},
+	},
+	[MT8188_POWER_DOMAIN_CAM_SUBA] = {
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x398,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8188_POWER_DOMAIN_CAM_SUBB] = {
+		.sta_mask = BIT(26),
+		.ctl_offs = 0x39C,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+};
+
+MTK_SCP_SOC_DATA(mt8188, mt8188_scp_domain);
+
+static const struct udevice_id mt8188_power_domain_ids[] = {
+	{
+		.compatible = "mediatek,mt8188-power-controller",
+		.data = (ulong)&mt8188_scp_soc_data,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mt8188_power_domain) = {
+	.name = "mt8188_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &mtk_power_domain_ops,
+	.probe = mtk_power_controller_probe,
+	.of_match = mt8188_power_domain_ids,
+	.priv_auto = sizeof(struct mtk_scpsys),
+};

-- 
2.54.0

