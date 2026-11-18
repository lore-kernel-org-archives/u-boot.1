Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA77606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hkqjrswE;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=S8N+ZiLd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC24540A24;
	Wed, 18 Nov 2026 13:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NmN59IHmBTar; Wed, 18 Nov 2026 13:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 121CA40A13
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007945;
	b=SJIVxSgYAqZkzT3mkrYWimudN+QyqDrvKxfx9oRKrsRgQ6c2eS52Tci+GiqoO67tXzSN
	 zY+0BWsXMqhqiCrIW55Ale3WYWWApySlcFXPrItRij1h6D9e8qV1zLoNV+kPeZu8JQCwv
	 Fdd8kNmI3vhW/0uk1FGNK8fze9IzykuCaXJ7TMPzVhMegq5sGMuRaS+OLj6RZZP2msmNi
	 Vug4ZCyujANWVhcT1AtoWka5x8xFtk+GafQ5694TCLVvMPyYy/aswEkKRY+XeDZ1zHJOV
	 BEwfnJL6oiphd2reUFOV6GcaF++ntEozW0UE8XoB3xlQd2yIsEG8Y14+NaOMw211lgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007945;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JTnlrGqNEOah0jOMs7qjqRUcmy6nMdodcSH5/UQWusE=;
	b=KzRIQeElrC1rb8o/CzZpVIg1Bod4P3hIridkDh5FGdNWZiM3hneQw0anIlauglUzqY4L
	 KEs+wP0YUdufvwFFGLzzn8pmhZFq8pdf3HgKlIgilBKAXkbex0Sye9Au0wLN1AO6/MptZ
	 nI04BEwEDg/iJHn/BWFYOXwuMM2hDdkYNx2nMD3CvhV2kJFsk/VCohSP+eHqnBh0KVcvs
	 gWIelUGkCqR+DqAGpCqJeDis178DPPFwhbjFn1PqU1bkkmlqfFFcJl9QsIjwy2kGVfLK4
	 7fXMzLaZsiLaoV6EFHEKsdBdiQX9erCWGEmHrzfH2/ddL93hRm9YEDRsyIHAmo2JEFw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007945;
	bh=JTnlrGqNEOah0jOMs7qjqRUcmy6nMdodcSH5/UQWusE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hkqjrswEq7Ek/cO+VhTreiYvgZjUmFHnIscTLcRZh1maFlOmeP3APnUHvd978kazl
	 q7pnwYz/qYlc28MBzcZLxAqUzHlOVRH6MrscHfuwpPqqApcVKPqj68KkkVjPXVmq9B
	 sHkwQjs/Pbaam3TsxwLZAAwwOXN9lbcj0xhEfKP13/EALhOph00K9+k8oYmWquPIdF
	 WJJIW2oj234TmziesB/gDSYePOFw5/0WN+zD7G5WP6b0J1lUjaDM9GhyKeZlbgcq5u
	 /vcLffglOIzpj3a9En4g8B3ig8QgFcfFml+6sYP2eWuItaVixIfxn/RdYqVjV0taX4
	 sP/pJckP2kwKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 121CA40A13;
	Wed, 18 Nov 2026 13:19:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2114B61
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06AA881240
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GrGnW0_gPz4 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A519881275
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=S8N+ZiLd
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A519881275
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:18:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 5632C4E41627;
 Wed, 18 Nov 2026 13:18:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1DA395FE9B;
 Wed, 18 Nov 2026 13:18:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF63411BC1FAC; Wed, 18 Nov 2026 14:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007934; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=JTnlrGqNEOah0jOMs7qjqRUcmy6nMdodcSH5/UQWusE=;
 b=S8N+ZiLdaUSUVOirz9CHFYVRCi/lLdGhWQeKfCby0RfDEoAI18HGOMGXVoeEI636ntjC8D
 5HPiI5IW/iFmS1+vWsPBl140ydZZR/38A44AeBBTA9OlRZW+4wV6JvfTLiHeOuhAYu41EW
 fabjQRQiDcCq8ymSOsAZYB8yqmObaoi9RrttI8Z2V9Jo/E4mVNAuOLPedoz/jEu24CBQXm
 Mj5UlkpMcyH7IYS9kNDCEakh497QLBQWTo473y8Mh7E3IT5YB4GJYXpwQqjo925m2eL/vb
 SFI/OxBFn8U0ijxp0+L7Axm7BEfQ2pAXqS4V1r+HpIldzrF5bAJDV6zd7/kVZQ==
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
Subject: [PATCH v7 10/20] ram: k3-ddrss: Add exit retention support
Date: Wed, 18 Nov 2026 14:17:57 +0100
Message-ID: <20261118131807.135859-11-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>

Add functions that implements retention exit sequence of DDR.

Typical DDR resume sequence is:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power

We have to separate each action in order to de-assert the DDR_RET pins
at the right time, because the DDR_RET pins are all tied together
in hardware.
Additional interleaving to be taken care and configuring of PMIC differs
device to device depending on number of PMIC.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/include/mach/k3-ddr.h |  16 ++
 drivers/ram/k3-ddrss/k3-ddrss.c        | 253 +++++++++++++++++++++++++
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h   |  94 +++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h

diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 6ac7f682fb80..5dd4025bdbb7 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -7,6 +7,7 @@
 #define _K3_DDR_H_
 
 #include <spl.h>
+#include <compiler.h>
 
 /* We need 4 extra entries for:
  * 1. SoC peripherals
@@ -17,10 +18,25 @@
 #define K3_MEM_MAP_LEN			((CONFIG_NR_DRAM_BANKS) + 4)
 #define K3_MEM_MAP_FIRST_BANK_IDX	3
 
+struct k3_ddrss_regs {
+	u32 ctl_141;
+	u32 phy_1305;
+	u32 ctl_88;
+	u32 pi_134;
+	u32 pi_7;
+	u32 ctl_20;
+	u32 wdqlvl_f1;
+	u32 wdqlvl_f2;
+};
+
 int dram_init(void);
 int dram_init_banksize(void);
 
 void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
 void fixup_memory_node(struct spl_image_info *spl_image);
 
+/* LPDDR4 power management functions */
+void k3_ddrss_lpddr4_exit_retention(struct udevice *dev, struct k3_ddrss_regs *regs);
+void k3_ddrss_lpddr4_change_freq(struct udevice *dev);
+void k3_ddrss_lpddr4_exit_low_power(struct udevice *dev, struct k3_ddrss_regs *regs);
 #endif /* _K3_DDR_H_ */
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 9a239e93c123..bf917194160e 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -19,12 +19,14 @@
 #include <power-domain.h>
 #include <wait_bit.h>
 #include <power/regulator.h>
+#include <mach/k3-ddr.h>
 
 #include "k3-ddrss-lpm.h"
 #include "lpddr4_obj_if.h"
 #include "lpddr4_if.h"
 #include "lpddr4_structs_if.h"
 #include "lpddr4_ctl_regs.h"
+#include "lpddr4_k3_reg.h"
 
 #define SRAM_MAX 512
 
@@ -442,6 +444,257 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
 	return ret;
 }
 
+#if defined(CONFIG_K3_J721E_DDRSS)
+
+void k3_ddrss_lpddr4_exit_retention(struct udevice *dev,
+				    struct k3_ddrss_regs *regs)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval;
+	unsigned int pll_ctrl;
+	unsigned int val;
+
+	/*
+	 * Saving registers
+	 */
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_141, &regs->ctl_141);
+	lpddr4_k3_readreg_phy(ddrss, DENALI_PHY_1305, &regs->phy_1305);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_88, &regs->ctl_88);
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_134, &regs->pi_134);
+	/* PI_139 cannot be restored */
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_7, &regs->pi_7);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_20, &regs->ctl_20);
+
+	/* disable auto entry / exit */
+	lpddr4_k3_clr_ctl(ddrss, DENALI_CTL_141, (0xF << 24) | (0xF << 16));
+
+	/* Configure DFI Interface, DDR retention exit occurs through PHY */
+	lpddr4_k3_readreg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, &regval);
+	regval &= ~0xF0F; /* Set DFI_Input_1 = 0 */
+	regval |= 0x01;   /* Set DFI Input_0 = 1 */
+	lpddr4_k3_writereg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, regval);
+
+	/* PWRUP_SREFRESH_EXIT = 1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__PWRUP_SREFRESH_EXIT__REG, 0x1);
+
+	/* PI_PWRUP_SREFRESH_EXIT = 0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_PWRUP_SREFRESH_EXIT__REG, 0x1 << 16);
+
+	/* PI_DRAM_INIT_EN = 0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_DRAM_INIT_EN__REG, 0x1 << 8);
+
+	/* PI_DFI_PHYMSTR_STATE_SEL_R = 1  (force memory into self-refresh) */
+	lpddr4_k3_set_pi(ddrss, LPDDR4__PI_DFI_PHYMSTR_STATE_SEL_R__REG, (1 << 24));
+
+	/*  PHY_INDEP_INIT_MODE = 0 */
+	lpddr4_k3_clr_ctl(ddrss, LPDDR4__PHY_INDEP_INIT_MODE__REG, (0x1 << 16));
+
+	/* PHY_INDEP_TRAIN_MODE = 1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__PHY_INDEP_TRAIN_MODE__REG, 0x1);
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F1__REG, &regs->wdqlvl_f1);
+	regs->wdqlvl_f1 &= LPDDR4__DENALI_PI_214__PI_WDQLVL_EN_F1_MASK;
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F2__REG, &regs->wdqlvl_f2);
+	regs->wdqlvl_f2 &= LPDDR4__DENALI_PI_217__PI_WDQLVL_EN_F2_MASK;
+
+	/* clear periodic WDQLVL for F0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F0__REG,
+			 0x2 << LPDDR4__DENALI_PI_212__PI_WDQLVL_EN_F0_SHIFT);
+
+	/* clear periodic WDQLVL for F1 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F1__REG,
+			 0x2 << LPDDR4__DENALI_PI_214__PI_WDQLVL_EN_F1_SHIFT);
+
+	/* clear periodic WDQLVL for F2 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F2__REG,
+			 0x2 << LPDDR4__DENALI_PI_217__PI_WDQLVL_EN_F2_SHIFT);
+
+#define PLL_CTRL_OFF 0x20
+#define PLL_CFG 0x00680000
+	switch (ddrss->instance) {
+	case 0:
+		pll_ctrl = PLL_CFG + 12 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 1:
+		pll_ctrl = PLL_CFG + 26 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 2:
+		pll_ctrl = PLL_CFG + 27 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 3:
+		pll_ctrl = PLL_CFG + 28 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	}
+
+	*(unsigned int *)pll_ctrl |= 0x80000000;
+	val = *(unsigned int *)pll_ctrl;
+	if ((val & 0x80000000) != 0x80000000)
+		val = *(unsigned int *)pll_ctrl;
+}
+
+void k3_ddrss_lpddr4_change_freq(struct udevice *dev)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval;
+	unsigned long tmo;
+
+	/* PI_START=1 */
+	lpddr4_k3_set_pi(ddrss, LPDDR4__PI_START__REG, 0x01);
+	/* START=1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__START__REG, 0x01);
+
+	k3_lpddr4_freq_update(ddrss);
+
+	tmo = timer_get_us() + 100000;
+	do {
+		lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (1 << 0)) == 0x00);
+
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (1 << 9)) == 0x00);
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
+	debug("%s: PI interrupt status: 0x%08x\n", __func__, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+	debug("%s: Controller interrupt status: 0x%08x\n", __func__, regval);
+
+	debug("%s: Successfully exited Retention\n", __func__);
+}
+
+void k3_ddrss_lpddr4_exit_low_power(struct udevice *dev,
+				    struct k3_ddrss_regs *regs)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval, fspop, fspwr;
+	unsigned long tmo;
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/* make sure that LP flag is clear before going through this process */
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, &regval);
+	regval &= ~(0x7F << 24);
+	regval |= (0x2 << 24); /* set low power mode exit */
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/* wait until low power operation has been completed */
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (0x1 << 10)) == 0);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
+
+	/*
+	 * bit 6 / 14 -- lp_state valid
+	 * bits 13:8 / 5:0 0x0F SRPD Long with Mem and Controller Clk Gating
+	 */
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & 0x4F4F) != 0x4040);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/*
+	 * MR13 data within the PI is based upon CS but NOT based upon
+	 * frequency set point.
+	 * MR13 is the current MR13 value
+	 */
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_MR13_DATA_0__REG, &regval);
+	fspop = (regval & ((u32)1 << 31)) >> 31;
+	fspwr = (regval & ((u32)1 << 30)) >> 30;
+
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_OP_CURRENT__REG,
+			  fspop << LPDDR4__DENALI_CTL_192__FSP_OP_CURRENT_SHIFT);
+
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_WR_CURRENT__REG,
+			  fspwr << LPDDR4__DENALI_CTL_192__FSP_WR_CURRENT_SHIFT);
+
+	/* do not allow CTL to update MR */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_PHY_UPDATE_MRW__REG,
+			  1 << LPDDR4__DENALI_CTL_191__FSP_PHY_UPDATE_MRW_SHIFT);
+
+	/* do not allow PI to update MR */
+	lpddr4_k3_clr_pi(ddrss, DENALI_PI_64, 1 << 0);
+
+	/* PI_FREQ_MAP defines supported working frequencies */
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_FREQ_MAP__REG, &regval);
+	if (regval & (0x1 << 1)) {
+		/* define FSP0 and FSP1 as trained */
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F0__REG,
+				  LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F0_MASK);
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F1__REG,
+				  LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F1_MASK);
+	}
+	if (regval & (0x1 << 2)) {
+		/* define FSP0 and FSP2 as trained */
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F0__REG,
+				  LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F0_MASK);
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F2__REG,
+				  LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F2_MASK);
+	}
+
+	/*
+	 * Restore registers
+	 */
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_141, regs->ctl_141);
+	lpddr4_k3_writereg_phy(ddrss, DENALI_PHY_1305, regs->phy_1305);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_88, regs->ctl_88);
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_134, regs->pi_134);
+	/* PI_139 cannot be restored */
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_7, regs->pi_7);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_20, regs->ctl_20);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_141, &regs->ctl_141);
+	lpddr4_k3_readreg_phy(ddrss, DENALI_PHY_1305, &regs->phy_1305);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_88, &regs->ctl_88);
+	/* PI_139 cannot be restored */
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_7, &regs->pi_7);
+
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_79, &regval);
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_80, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_293, &regval);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_295, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_294, &regval);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_296, regval);
+
+	lpddr4_k3_set_pi(ddrss, DENALI_PI_214, regs->wdqlvl_f1);
+	lpddr4_k3_set_pi(ddrss, DENALI_PI_217, regs->wdqlvl_f2);
+}
+#endif /* CONFIG_K3_J721E_DDRSS */
+
 void k3_lpddr4_probe(struct k3_ddrss_desc *ddrss)
 {
 	u32 status = 0U;
diff --git a/drivers/ram/k3-ddrss/lpddr4_k3_reg.h b/drivers/ram/k3-ddrss/lpddr4_k3_reg.h
new file mode 100644
index 000000000000..aca56200a96b
--- /dev/null
+++ b/drivers/ram/k3-ddrss/lpddr4_k3_reg.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef LPDDR4_K3_REG
+#define LPDDR4_K3_REG
+
+#define _lpddr4_k3_readreg(_shift, _fnct, _ddrss, _reg, _p) do {	\
+	u16 offset = 0U;						\
+	u32 result = 0U;						\
+	TH_OFFSET_FROM_REG(_reg, _shift, offset);			\
+	result = (_fnct)(&(_ddrss)->pd, _p, (u16 *)(&offset), 1);	\
+	if (result > 0U) {						\
+		printf("%s: Failed to read %s\n", __func__, xstr(_reg));\
+		hang();							\
+	}								\
+} while (0)
+
+#define _lpddr4_k3_writereg(_shift, _fnct, _ddrss, _reg, _val)  do {	\
+	u16 offset = 0U;						\
+	u32 result = 0U;						\
+	u32 writeval = _val;						\
+	TH_OFFSET_FROM_REG(_reg, _shift, offset);			\
+	result = (_fnct)(&(_ddrss)->pd,	&writeval, (u16 *)(&offset), 1);\
+	if (result > 0U) {						\
+		printf("%s: Failed to write %s\n", __func__, xstr(_reg));\
+		hang();							\
+	}								\
+} while (0)
+
+#define lpddr4_k3_readreg_ctl(_ddrss, _reg, _pt)		\
+	_lpddr4_k3_readreg(CTL_SHIFT,				\
+			   (_ddrss)->driverdt->readctlconfig,	\
+			   _ddrss, _reg, _pt)
+
+#define lpddr4_k3_readreg_pi(_ddrss, _reg, _pt)				\
+	_lpddr4_k3_readreg(PI_SHIFT,					\
+			   (_ddrss)->driverdt->readphyindepconfig,	\
+			   _ddrss, _reg, _pt)
+
+#define lpddr4_k3_readreg_phy(_ddrss, _reg, _pt)		\
+	_lpddr4_k3_readreg(PHY_SHIFT,				\
+			   (_ddrss)->driverdt->readphyconfig,	\
+			   _ddrss, _reg, _pt)
+
+#define lpddr4_k3_writereg_ctl(_ddrss, _reg, _val)		\
+	_lpddr4_k3_writereg(CTL_SHIFT,				\
+			    (_ddrss)->driverdt->writectlconfig,	\
+			    _ddrss, _reg, _val)
+
+#define lpddr4_k3_writereg_pi(_ddrss, _reg, _val)			\
+	_lpddr4_k3_writereg(PI_SHIFT,					\
+			    (_ddrss)->driverdt->writephyindepconfig,	\
+			    _ddrss, _reg, _val)
+
+#define lpddr4_k3_writereg_phy(_ddrss, _reg, _val)		\
+	_lpddr4_k3_writereg(PHY_SHIFT,				\
+			    (_ddrss)->driverdt->writephyconfig,	\
+			    _ddrss, _reg, _val)
+
+#define _lpddr4_k3_set(_type, _ddrss, _reg, _mask) do {	\
+	u32 _val;					\
+	lpddr4_k3_readreg_##_type(_ddrss, _reg, &_val);	\
+	_val |= _mask;					\
+	lpddr4_k3_writereg_##_type(_ddrss, _reg, _val);	\
+} while (0)
+
+#define _lpddr4_k3_clr(_type, _ddrss, _reg, _mask) do {	\
+	u32 _val;					\
+	lpddr4_k3_readreg_##_type(_ddrss, _reg, &_val);	\
+	_val &= ~(_mask);				\
+	lpddr4_k3_writereg_##_type(_ddrss, _reg, _val);	\
+} while (0)
+
+#define lpddr4_k3_set_ctl(_ddrss, _reg, _mask)	\
+	_lpddr4_k3_set(ctl, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_clr_ctl(_ddrss, _reg, _mask) \
+	_lpddr4_k3_clr(ctl, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_set_pi(_ddrss, _reg, _mask) \
+	_lpddr4_k3_set(pi, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_clr_pi(_ddrss, _reg, _mask) \
+	_lpddr4_k3_clr(pi, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_set_phy(_ddrss, _reg, _mask) \
+	_lpddr4_k3_set(phy, _ddrss, _reg, _mask)
+
+#define lpddr4_k3_clr_phy(_ddrss, _reg, _mask) \
+	_lpddr4_k3_clr(phy, _ddrss, _reg, _mask)
+
+#endif  /* LPDDR4_K3_REG */
