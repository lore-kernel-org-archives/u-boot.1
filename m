Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F73FC98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CA848193E;
	Thu, 24 Sep 2026 12:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJ5Z2UgJvJ49; Thu, 24 Sep 2026 12:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 874A7813AB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253357;
	b=C54Jl7aqQlKSS6YiaoKUzaetxazDEnzq+CAt+Y6VvechQRp5JZ/F0Tpweqx3a/7ugsvf
	 EHJraUHNqhNCWCiGGHPBraj4evJLZLnN3DWVpAlTa2cbL/LMGz1MWFVoxFdZsl9t3F1K9
	 9YnqCFv0b6KvpUsuNjsx23/4RTR/KwY+eIwNovJ3WPhuo5cW41N6APkyRFBdS179cq2pL
	 xhuafQXPMhCdV4ni+GOSDcvCCoGVR8451XsxnfUBph690CaZgC2jhYuZWQPqRoYdea+B5
	 lkXcFubtL6bilW1+dPt01H5JPDh5l7yqARM3ygtF5VhKAcT2jdNs7bEJUA+nf2rQCsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253357;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DPGZBSGlHEEAenBlOv2mF30YbR6il89TJ9Gnaqr9jP8=;
	b=RrEy4ukaMvziYKBOm0F/GBn+qgXnb7lWoqIVQREbmYAIqroAJElaWU2wZC9gZtGPw8hL
	 3oXHtU6I52rffwihtOt4sP6Impn1spDQynjcrB3w2Z9HzJ31S+zamKVfuU5dBBa9sRiqy
	 PH6H3p+7bIwnr0wTuzPNU41m/9Eeb71lUvqoRNM/F4Fpo7GkwuZV7XUE0bDwGaqvUdpa4
	 tMmAKCY+AcURPvHj3jZtTImm4+JTbRoiD5aoglEcNV7Kesuo18feovGBHp0s9h0NrOCTk
	 IEABiSYVndnxgwZKXZaekZWRoqH+zp7PnKzxVsFlOvMoExQF42wi/O2KwJ2S6ct6HKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253357;
	bh=DPGZBSGlHEEAenBlOv2mF30YbR6il89TJ9Gnaqr9jP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RPwn8irc1OjctB9dKnpa4z+JDckO5N57R726/dhb5dFQoQWbBS9rUMzIWsaPiBueD
	 oAfDJPd60zL5UYoRicpt+ggVQZR8+JRsaKy4R/UwD1cQA5SfEBIik4f5euP7AXqdWa
	 OKBDLDiuLslohz2PfwqlLIHRmqUWBaoFobgHsfgLW7zlx/LrFVPVKqajWVvYA/6MLt
	 9y1cqk5WnWnkbFGUgpUDtwUM6sTyDt7ByXPMYv/xHsJ4zaQpsPmyKjfb2uWfrGVUvJ
	 lLddXwFq0KcH8IBQYUqYA5eZLO9N3swkKqdU81f5KsnEyS0N/NHhzgLajISOkXMSgv
	 z3r6Pf9Cc5AuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 874A7813AB;
	Thu, 24 Sep 2026 12:35:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B01335A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BFFE4074E
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pA4q1vzAtd6y for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:35:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F57B406F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253354;
 b=Qq/NlMAwAWlf8fYqszAiai3w8zTBnSDvIVDxbZPva68RAtyRvn2UfxcRtBWjH4dFleym
 72yVlp276sPVCw8E5m6JpnpMmhjDtZ1igNsJhttI3aowLtBHBhJ+bhSabd9rUsuKehPp0
 5RKwgbDwK6P2lgx7+E7+nbJQtpJrkSS9RfP5EZut71RcUZqD4QpQq8D0g5iJsmavhbhC5
 1Z2L9WbnPcTIGSb9cItcasgWdR/aE9elZqkwbF8vZzPW4phJCJ93W5h6rdyW90Rlcv/B8
 vmbuzJNSrBGbegMLMEMMqlDTvMgEXA32wE17Xb9C1PnDGb03CqY/JIy4/10PzuEYWtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253354;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=DPGZBSGlHEEAenBlOv2mF30YbR6il89TJ9Gnaqr9jP8=;
 b=oZQJpga0l9TbSdzj53+vhbsYH/v8UcIWEVIYGMUwn9rsebOjYcc0xNrxnAx54ZQ7tY5Y
 SnBeEGm2bnXmgabJ8sgADnvRVm9P32fI87dwL9UWkpXR3F42VaA1nZOqzyFqnY3DFHgQ+
 iHLTk4raW84BUIrHckl0O823pjNicX2hoW1BgYZ2O5QC6yLe67Wxnf7XttUqsdgeGjWcg
 ZdLCRycd0PlojLtS57C9YJ9W5iP/0ehwrGWBqSwbAY+Z9ERu4jPysaqijJqw8myzXNr0h
 4jRkpcOlojNwPSgw1/GvWBAhjkQVH68a9QWgAjzo/K9kMSdrRDhKEofFsHeoW4Ckycw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=fbdkB1B0; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=fbdkB1B0
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F57B406F1
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:35:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 222F9C211C1;
 Thu, 24 Sep 2026 12:36:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC37460341;
 Thu, 24 Sep 2026 12:35:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5AB6103284AD; 
 Thu, 24 Sep 2026 14:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253346; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=DPGZBSGlHEEAenBlOv2mF30YbR6il89TJ9Gnaqr9jP8=;
 b=fbdkB1B00TwmKuwWyJkqftXoao/biKcbK2nOFNd4bEC/Kf0I1GNJhWB9+aeslqs3vgvPvy
 gVEqhUD0iDgGMVU3j1qrMZBSq/DiNBjXnGPuG86v8WdV/BWqUEjjb8WotXxcXJuY0ip0Wk
 LdQh/KmOu1s3fXgG0uWVXUKTN/ssQ0YaAtNB+HQVJcjsf72Pld9G3EWos5nJxpoY8XHtb/
 yWpM457SwIto4/ng39L8ccRPDPQE7vKoS0gqbjb111bhaXk6qLRDSeaNhTtJVqaWeoEl3U
 qU0rgjlgpCp40DPFS6RvZ6Pn/GxovHOCocxwbGVAqAy3Kt17OinDg+gEqDVu3g==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 01/22] ram: k3-ddrss: Add support for DDR in self-refresh
Date: Thu, 24 Sep 2026 14:35:12 +0200
Message-ID: <20260924123533.2599438-2-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

In IO+DDR the DDR is kept in self-refresh while the SoC cores are
powered off completely. During boot the normal initialization routine of
DDR is slightly different to exit self-refresh and keep the DDR contents.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/ram/k3-ddrss/Makefile       |   1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 181 ++++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h |  20 +++
 drivers/ram/k3-ddrss/k3-ddrss.c     |  26 +++-
 4 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ram/k3-ddrss/k3-ddrss-lpm.c
 create mode 100644 drivers/ram/k3-ddrss/k3-ddrss-lpm.h

diff --git a/drivers/ram/k3-ddrss/Makefile b/drivers/ram/k3-ddrss/Makefile
index bb7dc05e3d99..a125675a2931 100644
--- a/drivers/ram/k3-ddrss/Makefile
+++ b/drivers/ram/k3-ddrss/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_K3_DDRSS) += k3-ddrss.o
+obj-$(CONFIG_K3_DDRSS) += k3-ddrss-lpm.o
 obj-$(CONFIG_K3_DDRSS) += lpddr4_obj_if.o
 obj-$(CONFIG_K3_DDRSS) += lpddr4.o
 ccflags-$(CONFIG_K3_DDRSS) += -I$(srctree)/drivers/ram/k3-ddrss/
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
new file mode 100644
index 000000000000..20181d0a876d
--- /dev/null
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * K3 DDRSS LPM specific functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#include <asm/io.h>
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+#include <time.h>
+#include <vsprintf.h>
+#include <wait_bit.h>
+
+#include "k3-ddrss-lpm.h"
+
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL				0x430080d0
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD		BIT(31)
+#define AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK	GENMASK(3, 0)
+
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1				0x4301830c
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE		BIT(0)
+
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT			0x43018318
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
+
+#define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
+#define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
+#define K3_DDRSS_CFG_DENALI_CTL_21				0x0054
+#define K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE		BIT(8)
+#define K3_DDRSS_CFG_DENALI_CTL_106				0x01a8
+#define K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT		BIT(16)
+#define K3_DDRSS_CFG_DENALI_CTL_160				0x0280
+#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK			GENMASK(14, 8)
+#define K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY		BIT(9)
+#define K3_DDRSS_CFG_DENALI_CTL_169				0x02a4
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK	GENMASK(27, 24)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK	GENMASK(19, 16)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK		GENMASK(14, 8)
+#define K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT		8
+#define K3_DDRSS_CFG_DENALI_CTL_345				0x0564
+#define K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT	16
+#define K3_DDRSS_CFG_DENALI_CTL_353				0x0584
+#define K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT	16
+#define K3_DDRSS_CFG_DENALI_PI_6				0x2018
+#define K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R	BIT(8)
+#define K3_DDRSS_CFG_DENALI_PI_146				0x2248
+#define K3_DDRSS_CFG_DENALI_PI_150				0x2258
+#define K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN		BIT(8)
+#define K3_DDRSS_CFG_DENALI_PHY_1820				0x5C70
+#define K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT	16
+
+#define AM62XX_WKUP_CTRL_DDRSS_RETENTION_TIMEOUT_MS	5000
+#define K3_DDRSS_LPM_TIMEOUT_MS				5000
+
+static void k3_ddrss_reg_update_bits(void __iomem *addr, u32 offset, u32 mask, u32 set)
+{
+	u32 val = readl(addr + offset);
+
+	val &= ~mask;
+	val |= set;
+	writel(val, addr + offset);
+}
+
+void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg)
+{
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_169,
+				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK |
+				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK,
+				 0x0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PHY_1820,
+				 0,
+				 BIT(2) << K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_106,
+				 0,
+				 K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT);
+	writel(0, ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_PI_146);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PI_150,
+				 K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN,
+				 0x0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_PI_6,
+				 0,
+				 K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_21,
+				 K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE,
+				 0);
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_20,
+				 0,
+				 K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE);
+}
+
+void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg)
+{
+	int ret;
+	unsigned long timeout_start;
+
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_160,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
+				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
+	ret = wait_for_bit_32(ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_345,
+			      (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT),
+			      true, 5000, false);
+	if (ret)
+		panic("Failed waiting for low power command %d\n", ret);
+
+	k3_ddrss_reg_update_bits(ddrss_ctl_cfg,
+				 K3_DDRSS_CFG_DENALI_CTL_353,
+				 0,
+				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
+
+	timeout_start = get_timer(0);
+	while (1) {
+		if (get_timer(timeout_start) > K3_DDRSS_LPM_TIMEOUT_MS)
+			panic("Failed waiting for low power state\n");
+
+		if ((readl(ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
+		     K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) ==
+		    0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
+			break;
+	}
+}
+
+void am62xx_ddrss_deassert_retention(void)
+{
+	int ret;
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
+				 0);
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
+
+	ret = wait_for_bit_32((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+			      AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+			      true, AM62XX_WKUP_CTRL_DDRSS_RETENTION_TIMEOUT_MS, false);
+	if (ret)
+		panic("Failed waiting for latching of retention %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0x0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 0);
+}
+
+static bool am62xx_wkup_conf_canuart_wakeup_active(void)
+{
+	u32 active;
+
+	active = readl((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1);
+
+	return !!(active & AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE);
+}
+
+static bool am62xx_wkup_conf_canuart_magic_word_set(void)
+{
+	u32 magic_word;
+
+	magic_word = readl((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT);
+
+	return magic_word == AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW;
+}
+
+bool am62xx_wkup_conf_boot_is_resume(void)
+{
+	return IS_ENABLED(CONFIG_K3_IODDR) &&
+		am62xx_wkup_conf_canuart_wakeup_active() &&
+		am62xx_wkup_conf_canuart_magic_word_set();
+}
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
new file mode 100644
index 000000000000..742d224327e4
--- /dev/null
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * K3 DDRSS LPM specific functions
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#ifndef _K3_DDRSS_LPM_H_
+#define _K3_DDRSS_LPM_H_
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg);
+void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg);
+void am62xx_ddrss_deassert_retention(void);
+bool am62xx_wkup_conf_boot_is_resume(void);
+
+#endif  /* _K3_DDRSS_LPM_H_ */
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index c406998b20aa..54e191df8de9 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -20,6 +20,7 @@
 #include <wait_bit.h>
 #include <power/regulator.h>
 
+#include "k3-ddrss-lpm.h"
 #include "lpddr4_obj_if.h"
 #include "lpddr4_if.h"
 #include "lpddr4_structs_if.h"
@@ -119,6 +120,8 @@ enum intrlv_size {
 
 struct k3_ddrss_data {
 	u32 flags;
+	bool (*is_lpm_resume)(void);
+	void (*ddrss_deassert_retention)(void);
 };
 
 enum ecc_enable {
@@ -866,6 +869,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 
 static int k3_ddrss_probe(struct udevice *dev)
 {
+	struct k3_ddrss_data *ddrss_data = (struct k3_ddrss_data *)dev_get_driver_data(dev);
 	u64 end, bank0, bank1, bank0_size;
 	int ret;
 	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
@@ -873,6 +877,7 @@ static int k3_ddrss_probe(struct udevice *dev)
 	__maybe_unused u32 inst;
 	__maybe_unused struct k3_ddrss_ecc_region *range = ddrss->ecc_ranges;
 	__maybe_unused struct k3_msmc *msmc_parent = NULL;
+	bool is_lpm_resume;
 
 	debug("%s(dev=%p)\n", __func__, dev);
 
@@ -880,6 +885,10 @@ static int k3_ddrss_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	is_lpm_resume = ddrss_data->is_lpm_resume && ddrss_data->is_lpm_resume();
+	if (is_lpm_resume)
+		dev_info(dev, "Detected IO+DDR resume\n");
+
 	ddrss->dev = dev;
 	ret = k3_ddrss_power_on(ddrss);
 	if (ret)
@@ -895,12 +904,21 @@ static int k3_ddrss_probe(struct udevice *dev)
 	k3_lpddr4_init(ddrss);
 	k3_lpddr4_hardware_reg_init(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_self_refresh_exit(ddrss->ddrss_ctl_cfg);
+
 	ret = k3_ddrss_init_freq(ddrss);
 	if (ret)
 		return ret;
 
+	if (is_lpm_resume && ddrss_data->ddrss_deassert_retention)
+		ddrss_data->ddrss_deassert_retention();
+
 	k3_lpddr4_start(ddrss);
 
+	if (is_lpm_resume)
+		k3_ddrss_lpm_resume(ddrss->ddrss_ctl_cfg);
+
 	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
 		if (!ddrss->ddrss_ss_cfg) {
 			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
@@ -1019,12 +1037,18 @@ static const struct k3_ddrss_data k3_data = {
 	.flags = SINGLE_DDR_SUBSYSTEM,
 };
 
+static const struct k3_ddrss_data am62xx_data = {
+	.flags = SINGLE_DDR_SUBSYSTEM,
+	.is_lpm_resume = am62xx_wkup_conf_boot_is_resume,
+	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
+};
+
 static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
 };
 
 static const struct udevice_id k3_ddrss_ids[] = {
-	{.compatible = "ti,am62a-ddrss", .data = (ulong)&k3_data, },
+	{.compatible = "ti,am62a-ddrss", .data = (ulong)&am62xx_data, },
 	{.compatible = "ti,am64-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721e-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721s2-ddrss", .data = (ulong)&j721s2_data, },
-- 
2.55.0

