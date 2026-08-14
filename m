Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3E5C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96A2440EBD;
	Fri, 14 Aug 2026 14:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1YCP2dAQPwwN; Fri, 14 Aug 2026 14:57:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58F8040CF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786719430;
	bh=cJ8I30opgYTrx8HabGFSPRAKSyFZKd/rnvY7gTeaowk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I81VhWF0eHr6h9xGPuZIWACK/cwJC3vur5+O+3E/3e0/QhPNLyDw54ehDyfqP5xgl
	 EkIeDcPngvQoQXYZoJR9ctAaBaUvXNL2Sziam6kJMBwVaitPSZrPjqFnF7oiz7cJZQ
	 AYzSwmkRmoO61vv1fy0yz+vEOSCjlrzFqT78S2VnR0VFesZgRvh5uwnMvYzjZS8xEe
	 k1aNertu4hi+YBehi9Sm1OdKpfjO4wpqp7q/CpoUXae1I4QiOVPOuyg+T7XED8lqeh
	 sjl3wgqDzhesWciHwq1xuNfSflvoZplH/F0yU5qeQjQMOP5oPgGUtsnu4+IEUdFsQk
	 y4Pd2VCVOAJ5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58F8040CF1;
	Fri, 14 Aug 2026 14:57:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB6763A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9175940CF1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p9qp0LrkHACH for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:57:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9C2BD40CBC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C2BD40CBC
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kjpXPTgT
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C2BD40CBC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:57:04 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so948945a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786719423; x=1787324223;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cJ8I30opgYTrx8HabGFSPRAKSyFZKd/rnvY7gTeaowk=;
 b=kjpXPTgT1lHrYZN5Ki4gXIIEiwCpWH4q/PxYHZAChb3f14EqDneldKmDCEdWuERYfW
 hxjEEfjtXpiN4i6rqEbi1SdX0xQnKcOmAEtHCwmemBhhQNR/LFZDFL7BbzG03ORkMgOM
 KDdOSY3Sduqqxvx6DIBR5ocRPEmhGcCbJ9WZFg3LE1p4LimWxX5udbmD5YgVKK633rWJ
 w+BILkzRpI40bYvkQ0HKKAL5wvXzUUnWIxH69Kb0Zpl4Dv1KPPBHmBJjBCHaTxMJL0/s
 mNdHdakBDuBfSe+JajrS7BaDsJqJ++HGbdviMaNRyoV723g7nMS7WAIg1eoXPcgfl42c
 okUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786719423; x=1787324223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cJ8I30opgYTrx8HabGFSPRAKSyFZKd/rnvY7gTeaowk=;
 b=lDCdxbfmskyuXYrve1ZRXh9lv4uiuX0s7gkvcRMRHnppKMF1V0T17fnV2QpJjpqCqg
 vsCusqiHBraAjlUoAiiOCO21a/9mN6anYGQ9L8M0ckZIAxvea7MxDBUOJVMz7CZD1oAW
 cANdzm1sfCHT5gb4JQ6JeVi21GSCkbI9Ojk0gHsXNDiJwwWNzI+V0LIaD8tfE7c2Rowp
 5WKEb2xwTqzrJZmPXLLeMOxUB5b0wk6c9ZC27IdlTlFhjcHz002/DvuWKji7AX3y9AHm
 XohmlRreI7O2cDiQrUjIhcqv5nvkwdLqEIh3T5XQRvmPGOvZj/wUIcWsd5pIdl4aFa3w
 Iwfg==
X-Gm-Message-State: AOJu0YyF4waxJju1WFOSzJJINP8ZT/+iISQaSjpDtTnD541yQ4v/7iqe
 oZnDgqwSYbiuDf3vxrEHcDfOqaW7XKJkx80NZoLBYgt+INPg1hdAbzDUCE/SXp0vkoM=
X-Gm-Gg: AR+sD13DkCVSIbbBev+GfR/f20tN2ZO1huHaYRWFDhyUelXZxwOxGb/+2TzytthzmVF
 vP8nSfNx4erU0NSc0vNSAVjS+KUAhzf2qJU5+emEQmYVa1UagIwb/IANUsMHDmdw5gVYME0P5Tw
 Uvl7kYSdFXiOVlvZLTO4+X3QwFWtpDOfYnM7N/Jsycwns2i88bI85dWx73d+8PjNUnSRbrFS7eQ
 7jrglc3RrheBZFc17GLfDtjtxXqsp6uV5W4TeMs4rKO6GBWZrQFbIBLsF/rU8R1TLi4EfR/euKE
 OpuJbzQ1bkpbiZx0ma3iGJ3Pc7tL2KvrxxCaj2Skb+zJe2SCKxf7E/eFLfsTrihSjRPdf0TP+ty
 sZi+0vJVPcxuX0rmGyjTwIdbPn/++SY2Zd27BOi5L9J2bSMLSIUbsVeFFmv/oh1hS3X/vtz7FD1
 T1GTLIfXwpT9eJXQnqSJGiOrwr5jwmY9Ptf8GyJwaEfndR1F55DtCztcxBF0d+RR06wYZKPDQ5T
 6Rz
X-Received: by 2002:a05:6830:82f6:b0:7d7:ef0a:1ce5 with SMTP id
 46e09a7af769-7f3de631a8dmr5394729a34.9.1786719423485; 
 Fri, 14 Aug 2026 07:57:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e8668831sm1065949a34.22.2026.08.14.07.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:57:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 14 Aug 2026 09:56:24 -0500
Subject: [PATCH 4/4] power: domain: mtk: add mt8366 power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mtk-power-domain-mt8366-v1-4-6a0bb4a766bb@baylibre.com>
References: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
In-Reply-To: <20260814-mtk-power-domain-mt8366-v1-0-6a0bb4a766bb@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Irving-ch Lin <irving-ch.lin@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12332;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=YSdiwAyWz2cmz07SdiAnKnsrHjZhARJ75dn5buoHpMo=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqfyy0m8JmzitT4u6lJbBWLcAdyXBVnpldS1Md/
 ikQQtLvhomJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan8stBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Am9UH/jB2/iSWbkjVguPAR5bFv0/cjslDl9Z9S5yIazp
 saiKTt5O2NOij34Ukbz/UxSv17ZD259H2kxDaS5XxSq92D9IqxkbymU+BcK6ry+buZyCrBEJ/Np
 HGCblZ7TiVVK3CWSp7OHPXmaBi0UiGiQB18faJyZtu9nIM3xfhZ5LsEqzpDMCQWlHxhIpIB2QNQ
 sCVkly3tg5shjmUsSLlNccrIzXGvihpPqqMHgU+0JF1lkKFdod4gpNCNL0y2A2NZ60cFNKTey/S
 Z1O2vITeVrcGGIRxFXVrDfs8udcLaQx+AU33EWnuInjXlNIU6nPIcC03wnGh09UeY8TANq/qOBA
 AQ9k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Irving-ch Lin <irving-ch.lin@mediatek.com>

Add power domain support for MT8366.

Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com> (Ported from downstream Linux kernel.)
---
 drivers/power/domain/Kconfig               |  10 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/mt8366-power-domain.c | 299 +++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 12b0e2c9914..bd8b1f8cf5b 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -113,6 +113,16 @@ config MT8188_POWER_DOMAIN
 	  the SoC power domains on and off and handles the associated bus
 	  protection steps, per-domain clocks and parent domains.
 
+config MT8366_POWER_DOMAIN
+	bool "Enable the MediaTek power domain driver for MT8366 compatible SoC"
+	depends on POWER_DOMAIN && ARCH_MEDIATEK
+	select MTK_POWER_DOMAIN
+	help
+	  Enable support for manipulating MediaTek power domains via MMIO
+	  mapped registers for MT8366 compatible SoC. The driver powers
+	  the SoC power domains on and off and handles the associated bus
+	  protection steps, per-domain clocks and parent domains.
+
 config MTK_POWER_DOMAIN
 	bool
 	depends on POWER_DOMAIN && ARCH_MEDIATEK
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index e6fe71c374a..74f22d57981 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
 obj-$(CONFIG_MT2701_POWER_DOMAIN) += mt2701-power-domain.o
 obj-$(CONFIG_MT7622_POWER_DOMAIN) += mt7622-power-domain.o
 obj-$(CONFIG_MT8188_POWER_DOMAIN) += mt8188-power-domain.o
+obj-$(CONFIG_MT8366_POWER_DOMAIN) += mt8366-power-domain.o
 obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
 obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
diff --git a/drivers/power/domain/mt8366-power-domain.c b/drivers/power/domain/mt8366-power-domain.c
new file mode 100644
index 00000000000..d40cf1849bd
--- /dev/null
+++ b/drivers/power/domain/mt8366-power-domain.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 MediaTek Inc.
+ * Author: Irving-ch Lin <irving-ch.lin@mediatek.com>
+ */
+
+#include <dm.h>
+#include <dt-bindings/power/mediatek,mt8366-power.h>
+#include <linux/bitops.h>
+
+#include "mtk-power-domain.h"
+
+#define MT8366_SPM_PWR_STATUS			0x16c
+#define MT8366_SPM_PWR_STATUS_2ND		0x170
+
+#define MT8366_TOP_AXI_PROT_EN_STA1		0x0228
+#define MT8366_TOP_AXI_PROT_EN_STA1_1		0x0258
+#define MT8366_TOP_AXI_PROT_EN_SET		0x02a0
+#define MT8366_TOP_AXI_PROT_EN_CLR		0x02a4
+#define MT8366_TOP_AXI_PROT_EN_1_SET		0x02a8
+#define MT8366_TOP_AXI_PROT_EN_1_CLR		0x02ac
+#define MT8366_TOP_AXI_PROT_EN_MM_SET		0x02d4
+#define MT8366_TOP_AXI_PROT_EN_MM_CLR		0x02d8
+#define MT8366_TOP_AXI_PROT_EN_MM_STA1		0x02ec
+#define MT8366_TOP_AXI_PROT_EN_SET_2		0x0714
+#define MT8366_TOP_AXI_PROT_EN_CLR_2		0x0718
+#define MT8366_TOP_AXI_PROT_EN_STA1_2		0x0724
+#define MT8366_TOP_AXI_PROT_EN_ADSP_SET		0x0758
+#define MT8366_TOP_AXI_PROT_EN_ADSP_CLR		0x075c
+#define MT8366_TOP_AXI_PROT_EN_STA1_ADSP	0x0764
+
+#define MT8366_TOP_AXI_PROT_EN_CONN		(BIT(13) | BIT(18))
+#define MT8366_TOP_AXI_PROT_EN_CONN_2ND		(BIT(14))
+#define MT8366_TOP_AXI_PROT_EN_1_CONN		(BIT(10))
+#define MT8366_TOP_AXI_PROT_EN_1_MFG1		(BIT(21))
+#define MT8366_TOP_AXI_PROT_EN_2_MFG1		(BIT(5) | BIT(6))
+#define MT8366_TOP_AXI_PROT_EN_MFG1		(BIT(21) | BIT(22))
+#define MT8366_TOP_AXI_PROT_EN_2_MFG1_2ND	(BIT(7))
+#define MT8366_TOP_AXI_PROT_EN_MM_VDEC		(BIT(24))
+#define MT8366_TOP_AXI_PROT_EN_MM_VDEC_2ND	(BIT(25))
+#define MT8366_TOP_AXI_PROT_EN_MM_VENC		(BIT(26))
+#define MT8366_TOP_AXI_PROT_EN_MM_VENC_2ND	(BIT(27))
+#define MT8366_TOP_AXI_PROT_EN_2_AUDIO		(BIT(3))
+#define MT8366_TOP_AXI_PROT_EN_2_AUDIO_ACK	(BIT(4) | BIT(10) | BIT(13))
+#define MT8366_TOP_AXI_PROT_EN_MM_CAM		(BIT(0) | BIT(2))
+#define MT8366_TOP_AXI_PROT_EN_MM_CAM_2ND	(BIT(1) | BIT(3))
+
+static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
+	[MT8366_POWER_DOMAIN_CONN] = {
+		.sta_mask = BIT(0),
+		.ctl_offs = 0x304,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_CONN,
+					MT8366_TOP_AXI_PROT_EN_SET,
+					MT8366_TOP_AXI_PROT_EN_CLR,
+					MT8366_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_CONN_2ND,
+					MT8366_TOP_AXI_PROT_EN_SET,
+					MT8366_TOP_AXI_PROT_EN_CLR,
+					MT8366_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_1_CONN,
+					MT8366_TOP_AXI_PROT_EN_1_SET,
+					MT8366_TOP_AXI_PROT_EN_1_CLR,
+					MT8366_TOP_AXI_PROT_EN_STA1_1),
+		},
+	},
+	[MT8366_POWER_DOMAIN_MFG0] = {
+		.sta_mask = BIT(1),
+		.ctl_offs = 0x308,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_MFG1] = {
+		.sta_mask = BIT(2),
+		.ctl_offs = 0x30c,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_1_MFG1,
+					MT8366_TOP_AXI_PROT_EN_1_SET,
+					MT8366_TOP_AXI_PROT_EN_1_CLR,
+					MT8366_TOP_AXI_PROT_EN_STA1_1),
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_2_MFG1,
+					MT8366_TOP_AXI_PROT_EN_SET_2,
+					MT8366_TOP_AXI_PROT_EN_CLR_2,
+					MT8366_TOP_AXI_PROT_EN_STA1_2),
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MFG1,
+					MT8366_TOP_AXI_PROT_EN_SET,
+					MT8366_TOP_AXI_PROT_EN_CLR,
+					MT8366_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_2_MFG1_2ND,
+					MT8366_TOP_AXI_PROT_EN_SET_2,
+					MT8366_TOP_AXI_PROT_EN_CLR_2,
+					MT8366_TOP_AXI_PROT_EN_STA1_2),
+		},
+	},
+	[MT8366_POWER_DOMAIN_MFG2] = {
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x310,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_MFG3] = {
+		.sta_mask = BIT(4),
+		.ctl_offs = 0x314,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_VDEC] = {
+		.sta_mask = BIT(23),
+		.ctl_offs = 0x340,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VDEC,
+					MT8366_TOP_AXI_PROT_EN_MM_SET,
+					MT8366_TOP_AXI_PROT_EN_MM_CLR,
+					MT8366_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VDEC_2ND,
+					MT8366_TOP_AXI_PROT_EN_MM_SET,
+					MT8366_TOP_AXI_PROT_EN_MM_CLR,
+					MT8366_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT8366_POWER_DOMAIN_VENC] = {
+		.sta_mask = BIT(24),
+		.ctl_offs = 0x348,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VENC,
+					MT8366_TOP_AXI_PROT_EN_MM_SET,
+					MT8366_TOP_AXI_PROT_EN_MM_CLR,
+					MT8366_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VENC_2ND,
+					MT8366_TOP_AXI_PROT_EN_MM_SET,
+					MT8366_TOP_AXI_PROT_EN_MM_CLR,
+					MT8366_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT8366_POWER_DOMAIN_AUDIO] = {
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x358,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN_STA_MASK(MT8366_TOP_AXI_PROT_EN_2_AUDIO,
+						 MT8366_TOP_AXI_PROT_EN_2_AUDIO_ACK,
+						 MT8366_TOP_AXI_PROT_EN_ADSP_SET,
+						 MT8366_TOP_AXI_PROT_EN_ADSP_CLR,
+						 MT8366_TOP_AXI_PROT_EN_STA1_ADSP),
+		},
+	},
+	[MT8366_POWER_DOMAIN_CAM] = {
+		.sta_mask = BIT(13),
+		.ctl_offs = 0x35c,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_CAM,
+					MT8366_TOP_AXI_PROT_EN_MM_SET,
+					MT8366_TOP_AXI_PROT_EN_MM_CLR,
+					MT8366_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_CAM_2ND,
+					MT8366_TOP_AXI_PROT_EN_MM_SET,
+					MT8366_TOP_AXI_PROT_EN_MM_CLR,
+					MT8366_TOP_AXI_PROT_EN_MM_STA1),
+		},
+	},
+	[MT8366_POWER_DOMAIN_CAM_RAWA] = {
+		.sta_mask = BIT(14),
+		.ctl_offs = 0x360,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_DISP] = {
+		.sta_mask = BIT(19),
+		.ctl_offs = 0x3f0,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_DP_TX] = {
+		.sta_mask = BIT(9),
+		.ctl_offs = 0x3ac,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_PCIE] = {
+		.sta_mask = BIT(12),
+		.ctl_offs = 0x3d4,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_ISP_IMG1] = {
+		.sta_mask = BIT(15),
+		.ctl_offs = 0x3e0,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_ISP_IMG2] = {
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x3e4,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_ISP_IPE] = {
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x3e8,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_MMLSYS_SHUTDOWN] = {
+		.sta_mask = BIT(18),
+		.ctl_offs = 0x3ec,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_EPD] = {
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x3f4,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+	[MT8366_POWER_DOMAIN_CSI_RX] = {
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x408,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+	},
+	[MT8366_POWER_DOMAIN_VADSP_AO] = {
+		.sta_mask = BIT(28),
+		.ctl_offs = 0x414,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+	},
+	[MT8366_POWER_DOMAIN_VADSP_INFRA] = {
+		.sta_mask = BIT(27),
+		.ctl_offs = 0x410,
+		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+	},
+};
+
+MTK_SCP_SOC_DATA(mt8366, mt8366_scp_domain);
+
+static const struct udevice_id mt8366_power_domain_ids[] = {
+	{
+		.compatible = "mediatek,mt8366-power-controller",
+		.data = (ulong)&mt8366_scp_soc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(mt8366_power_domain) = {
+	.name = "mt8366_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &mtk_power_domain_ops,
+	.probe = mtk_power_controller_probe,
+	.of_match = mt8366_power_domain_ids,
+	.priv_auto = sizeof(struct mtk_scpsys),
+};

-- 
2.43.0

