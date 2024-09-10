Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1FCECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EC788FF1;
	Tue, 10 Sep 2024 11:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dmQOPuX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF50F88FED; Tue, 10 Sep 2024 11:50:28 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EBF88C1B
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso27929495e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725961817; x=1726566617; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EBVr1gp8cWiI8BGGhyadTyRRwJUuq+JLeEerwAG45nk=;
 b=dmQOPuX7pcHZYK3SQqU7vUMmWO+rgq0JtsG2W+rmGSguMyOyzMGBW6ly64pqyVtaPf
 gvbr6FCahV/+0vMt2H8FHsgvm4CO4wmf6TnY7MZ3gsfaabmuElRVf4pmvs/J3tXd+JQq
 NtyzyoLePnSd58nJJ80U0YKap3nZENmUPKuOq9Fm/k6r/ZfKE0nLBFTynn1pY5sUf+5B
 LwxAZ90pneTLG32d7JoAd+05GqbdwdoARwnDUGnTvfLmWDv3beNLVCIfhTKP3gdSv+Ha
 l1G+S6D9J+qPdYIqYuZLx5tgpb5+MNUDLnxT89INk87fANxfMQBJfu/HTyKSni5kpQ+z
 Az2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725961817; x=1726566617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBVr1gp8cWiI8BGGhyadTyRRwJUuq+JLeEerwAG45nk=;
 b=hJIwzkaTrDPpH+h3mitZMRnSVB4L7gq3DKSVlTQMNqJZBETsjsjIMQBYX/Ap7bSQGl
 8ax7fGafkWq5AJD21NDWimg/5yS6mAAPnzLiBhz4/t5sJOoWdr2xOxL/e/O9J3oMkA69
 boKLBzW98DWumcIlbiR0bNKrbEaGf2kQodxpgjhMwmISP89v/jb/BtkitVC1ko0FZySv
 bvf3H9Fko+9YYHDK/nbFVFpRHlXcVjnvU/EF0D4CaA4z5V/5OrDSwbKtWj01lLUFagHJ
 h/ItpTmQZ0XvLkd/B0U6clCZCud0wnwmIZXY+FkZqxDSrk0caMsiLitm9GzAX4FqQxe1
 qHIQ==
X-Gm-Message-State: AOJu0YzcN8HGEX+ToP2XbuJBoHxYWSmD7kKUveLgkz/dOifiALbh4b+2
 jFIBQgh9v0/owEmrRJZZlnWyg+02UpwE3TT7YToKx3E1vRlN6xzY6VXsLlubdd4=
X-Google-Smtp-Source: AGHT+IGWK/Is5atLBg3jCImwEgBQXkh2HlZem4855Hn+8pgoiaP01cfAITbhszfhxi0tNgbhWNFTXg==
X-Received: by 2002:a5d:460c:0:b0:374:c35e:de72 with SMTP id
 ffacd0b85a97d-378895c53e2mr8346166f8f.2.1725961817191; 
 Tue, 10 Sep 2024 02:50:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d3738sm8364030f8f.69.2024.09.10.02.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:50:16 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:50:13 +0200
Subject: [PATCH 4/4] ufs: Add Support for Qualcomm UFS HC driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-qcom-controller-v1-4-54c0d2231b10@linaro.org>
References: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
In-Reply-To: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=24941;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6X/NL+DXN+dt9OiHnzbIF//F9e4gtOOQ2zQoXk8/mtg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4BZU3rLtyWmPA2bXRnjACp7WNFsl9Kooe81QK4Zs
 rcolKiGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAWVAAKCRB33NvayMhJ0XpiD/
 9VUODrl9JarD1PwCOvs62T7b1Ps4+EKIoARzmGKkaiirn/uIyoPysjgg+MxWu9QzLx3y1Z39LHdrL1
 2h7BfR5+wKwivarF9yKTokbc5aGrBlvQCp1yOIXZ5s+C7zdIVpV70BGzwyW7MMe5CD5F44BxvNaMEf
 8v+4+HiGKK2IuPfUNQdn42GYTYcJfgqHSeXls4q9IJnStbUcpLDeMzTQLVITA95Zrwfp4/v2xOBjv5
 800AQg8nfHd78YejLxah2m6/0j+UyGCU9l15hLiEQecD9hJGjFzXOIJ78lVmeKr9SffnWBw7na1L+8
 3FKRlBgushcPDPleFnObMJM41tMAVwTDKTtrn9ZYIEvueE90UwNWcdarwixvy7tQZIDT1IgNPZ3+FZ
 j2Nhvx1V8YA3Sx4aJ4/MGg/Jb5Jh0WBD3sXLyWseudnOhG0SnkUopaNzKSFqBQMZOYfLlmndNHFUzS
 stUGkAXanQ9qSHAMcG2/Pw2eri2j3XB2JeB2r11zDjYTytEimGDnID7PfjnzimuFkJUakGejP+gGAv
 naNXr3vv3zD1MpcN3P/pCirr5sgjRJsF3aLRfu8AxsGQMkEwC4c5JuR4geYRuBTyOkY3HzzHYygGZH
 4sJ4y6Gn4pBi77gMAP7vg49f1F6ATykceygMtJr+j90l8kHQbOPEzTJj7j+Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

Add Support for the Host Controller driver for UFS HC
present on Qualcomm Snapdragon SoCs.

It has been successfully tested on SDM845, SM8250,
SM8550 ant SM8650 SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/Kconfig    |   7 +
 drivers/ufs/Makefile   |   1 +
 drivers/ufs/ufs-qcom.c | 670 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-qcom.h | 147 +++++++++++
 drivers/ufs/unipro.h   |   6 +
 5 files changed, 831 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 7da46faed6b..0ca1f2ae7dc 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -26,6 +26,13 @@ config UFS_PCI
 
 	  If unsure, say N.
 
+config QCOM_UFS
+	bool "Qualcomm Host Controller driver for UFS"
+	depends on UFS && ARCH_SNAPDRAGON
+        help
+	  This selects the platform driver for the UFS host
+	  controller present on Qualcomm Snapdragon SoCs.
+
 config TI_J721E_UFS
 	bool "Glue Layer driver for UFS on TI J721E devices"
 	help
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 67c42621aba..024382cd2ce 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
+obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
new file mode 100644
index 00000000000..843585726c7
--- /dev/null
+++ b/drivers/ufs/ufs-qcom.c
@@ -0,0 +1,670 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2013-2016, Linux Foundation. All rights reserved.
+ * Copyright (C) 2023-2024 Linaro Limited
+ * Authors:
+ * - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+ * - Neil Armstrong <neil.armstrong@linaro.org>
+ *
+ * Based on Linux driver
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <ufs.h>
+#include <asm/gpio.h>
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+#include "ufs.h"
+#include "ufs-qcom.h"
+
+#define ceil(freq, div) ((freq) % (div) == 0 ? ((freq) / (div)) : ((freq) / (div) + 1))
+
+static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
+
+static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
+{
+	int err;
+
+	if (priv->is_clks_enabled)
+		return 0;
+
+	err = clk_enable_bulk(&priv->clks);
+	if (err)
+		return err;
+
+	priv->is_clks_enabled = true;
+
+	return 0;
+}
+
+static int ufs_qcom_init_clks(struct ufs_qcom_priv *priv)
+{
+	int err;
+	struct udevice *dev = priv->hba->dev;
+
+	err = clk_get_bulk(dev, &priv->clks);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
+{
+	int err, retry_count = 50;
+	u32 tx_fsm_val = 0;
+
+	do {
+		err = ufshcd_dme_get(hba,
+				UIC_ARG_MIB_SEL(MPHY_TX_FSM_STATE,
+					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(0)),
+				&tx_fsm_val);
+		if (err || tx_fsm_val == TX_FSM_HIBERN8)
+			break;
+
+		/* max. 200us */
+		udelay(200);
+		retry_count--;
+	} while (retry_count != 0);
+
+	/* Check the state again */
+	err = ufshcd_dme_get(hba,
+			UIC_ARG_MIB_SEL(MPHY_TX_FSM_STATE,
+				UIC_ARG_MPHY_TX_GEN_SEL_INDEX(0)),
+				&tx_fsm_val);
+
+	if (err) {
+		dev_err(hba->dev, "%s: unable to get TX_FSM_STATE, err %d\n",
+			__func__, err);
+	} else if (tx_fsm_val != TX_FSM_HIBERN8) {
+		err = tx_fsm_val;
+		dev_err(hba->dev, "%s: invalid TX_FSM_STATE = %d\n",
+			__func__, err);
+	}
+
+	return err;
+}
+
+static void ufs_qcom_select_unipro_mode(struct ufs_qcom_priv *priv)
+{
+	ufshcd_rmwl(priv->hba, QUNIPRO_SEL, QUNIPRO_SEL, REG_UFS_CFG1);
+
+	if (priv->hw_ver.major >= 0x05)
+		ufshcd_rmwl(priv->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
+}
+
+/*
+ * ufs_qcom_reset - reset host controller and PHY
+ */
+static int ufs_qcom_reset(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	int ret;
+
+	ret = reset_assert(&priv->core_reset);
+	if (ret) {
+		dev_err(hba->dev, "%s: core_reset assert failed, err = %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/*
+	 * The hardware requirement for delay between assert/deassert
+	 * is at least 3-4 sleep clock (32.7KHz) cycles, which comes to
+	 * ~125us (4/32768). To be on the safe side add 200us delay.
+	 */
+	udelay(210);
+
+	ret = reset_deassert(&priv->core_reset);
+	if (ret)
+		dev_err(hba->dev, "%s: core_reset deassert failed, err = %d\n",
+			__func__, ret);
+
+	udelay(1100);
+
+	return 0;
+}
+
+/**
+ * ufs_qcom_advertise_quirks - advertise the known QCOM UFS controller quirks
+ * @hba: host controller instance
+ *
+ * QCOM UFS host controller might have some non standard behaviours (quirks)
+ * than what is specified by UFSHCI specification. Advertise all such
+ * quirks to standard UFS host controller driver so standard takes them into
+ * account.
+ */
+static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+
+	if (priv->hw_ver.major == 0x2)
+		hba->quirks |= UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION;
+
+	if (priv->hw_ver.major > 0x3)
+		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
+}
+
+/**
+ * ufs_qcom_setup_clocks - enables/disable clocks
+ * @hba: host controller instance
+ * @on: If true, enable clocks else disable them.
+ * @status: PRE_CHANGE or POST_CHANGE notify
+ *
+ * Returns 0 on success, non-zero on failure.
+ */
+static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
+				 enum ufs_notify_change_status status)
+{
+	switch (status) {
+	case PRE_CHANGE:
+		if (!on)
+			/* disable device ref_clk */
+			ufs_qcom_dev_ref_clk_ctrl(hba, false);
+		break;
+	case POST_CHANGE:
+		if (on)
+			/* enable the device ref clock for HS mode*/
+			ufs_qcom_dev_ref_clk_ctrl(hba, true);
+		break;
+	}
+
+	return 0;
+}
+
+static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+
+	/*
+	 * TOFIX: v4 controllers *should* be able to support HS Gear 4
+	 * but so far pwr_mode switch is failing on v4 controllers and HS Gear 4.
+	 * only enable HS Gear > 3 for Controlers major version 5 and later.
+	 */
+	if (priv->hw_ver.major > 0x4)
+		return UFS_QCOM_MAX_GEAR(ufshcd_readl(hba, REG_UFS_PARAM0));
+
+	/* Default is HS-G3 */
+	return UFS_HS_G3;
+}
+
+static int ufs_get_max_pwr_mode(struct ufs_hba *hba,
+				struct ufs_pwr_mode_info *max_pwr_info)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	u32 max_gear = ufs_qcom_get_hs_gear(hba);
+
+	max_pwr_info->info.gear_rx = min(max_pwr_info->info.gear_rx, max_gear);
+	/* Qualcomm UFS only support symmetric Gear */
+	max_pwr_info->info.gear_tx = max_pwr_info->info.gear_rx;
+
+	if (priv->hw_ver.major >= 0x4 && max_pwr_info->info.gear_rx > UFS_HS_G3)
+		ufshcd_dme_set(hba,
+			       UIC_ARG_MIB(PA_TXHSADAPTTYPE),
+			       PA_INITIAL_ADAPT);
+
+	dev_info(hba->dev, "Max HS Gear: %d\n", max_pwr_info->info.gear_rx);
+
+	return 0;
+}
+
+static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	struct phy phy;
+	int ret;
+
+	/* Reset UFS Host Controller and PHY */
+	ret = ufs_qcom_reset(hba);
+	if (ret)
+		dev_warn(hba->dev, "%s: host reset returned %d\n",
+			 __func__, ret);
+
+	/* get phy */
+	ret = generic_phy_get_by_name(hba->dev, "ufsphy", &phy);
+	if (ret) {
+		dev_warn(hba->dev, "%s: Unable to get QMP ufs phy, ret = %d\n",
+			 __func__, ret);
+		return ret;
+	}
+
+	/* phy initialization */
+	ret = generic_phy_init(&phy);
+	if (ret) {
+		dev_err(hba->dev, "%s: phy init failed, ret = %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* power on phy */
+	ret = generic_phy_power_on(&phy);
+	if (ret) {
+		dev_err(hba->dev, "%s: phy power on failed, ret = %d\n",
+			__func__, ret);
+		goto out_disable_phy;
+	}
+
+	ufs_qcom_select_unipro_mode(priv);
+
+	return 0;
+
+out_disable_phy:
+	generic_phy_exit(&phy);
+
+	return ret;
+}
+
+/*
+ * The UTP controller has a number of internal clock gating cells (CGCs).
+ * Internal hardware sub-modules within the UTP controller control the CGCs.
+ * Hardware CGCs disable the clock to inactivate UTP sub-modules not involved
+ * in a specific operation, UTP controller CGCs are by default disabled and
+ * this function enables them (after every UFS link startup) to save some power
+ * leakage.
+ */
+static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
+{
+	ufshcd_rmwl(hba, REG_UFS_CFG2_CGC_EN_ALL, REG_UFS_CFG2_CGC_EN_ALL,
+		    REG_UFS_CFG2);
+
+	/* Ensure that HW clock gating is enabled before next operations */
+	ufshcd_readl(hba, REG_UFS_CFG2);
+}
+
+static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
+				      enum ufs_notify_change_status status)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	int err;
+
+	switch (status) {
+	case PRE_CHANGE:
+		ufs_qcom_power_up_sequence(hba);
+		/*
+		 * The PHY PLL output is the source of tx/rx lane symbol
+		 * clocks, hence, enable the lane clocks only after PHY
+		 * is initialized.
+		 */
+		err = ufs_qcom_enable_clks(priv);
+		break;
+	case POST_CHANGE:
+		/* check if UFS PHY moved from DISABLED to HIBERN8 */
+		err = ufs_qcom_check_hibern8(hba);
+		ufs_qcom_enable_hw_clk_gating(hba);
+		break;
+	default:
+		dev_err(hba->dev, "%s: invalid status %d\n", __func__, status);
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+/* Look for the maximum core_clk_unipro clock value */
+static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	ofnode node = dev_ofnode(priv->hba->dev);
+	struct ofnode_phandle_args opp_table;
+	int pos, ret;
+	u32 clk = 0;
+
+	/* Get core_clk_unipro clock index */
+	pos = ofnode_stringlist_search(node, "clock-names", "core_clk_unipro");
+	if (pos < 0)
+		goto fallback;
+
+	/* Try parsing the opps */
+	if (!ofnode_parse_phandle_with_args(node, "required-opps",
+					    NULL, 0, 0, &opp_table) &&
+	    ofnode_device_is_compatible(opp_table.node, "operating-points-v2")) {
+		ofnode opp_node;
+
+		ofnode_for_each_subnode(opp_node, opp_table.node) {
+			u64 opp_clk;
+			/* opp-hw contains the OPP frequency */
+			ret = ofnode_read_u64_index(opp_node, "opp-hz", pos, &opp_clk);
+			if (ret)
+				continue;
+
+			/* We don't handle larger clock values, ignore */
+			if (opp_clk > U32_MAX)
+				continue;
+
+			/* Only keep the largest value */
+			if (opp_clk > clk)
+				clk = opp_clk;
+		}
+
+		/* If we get a valid clock, return it or check legacy*/
+		if (clk)
+			return clk;
+	}
+
+	/* Legacy freq-table-hz has a pair of u32 per clocks entry, min then max */
+	if (!ofnode_read_u32_index(node, "freq-table-hz", pos * 2 + 1, &clk) &&
+	    clk > 0)
+		return clk;
+
+fallback:
+	/* default for backwards compatibility */
+	return UNIPRO_CORE_CLK_FREQ_150_MHZ * 1000 * 1000;
+};
+
+static int ufs_qcom_set_clk_40ns_cycles(struct ufs_hba *hba,
+					u32 cycles_in_1us)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	u32 cycles_in_40ns;
+	int err;
+	u32 reg;
+
+	/*
+	 * UFS host controller V4.0.0 onwards needs to program
+	 * PA_VS_CORE_CLK_40NS_CYCLES attribute per programmed
+	 * frequency of unipro core clk of UFS host controller.
+	 */
+	if (priv->hw_ver.major < 4)
+		return 0;
+
+	/*
+	 * Generic formulae for cycles_in_40ns = (freq_unipro/25) is not
+	 * applicable for all frequencies. For ex: ceil(37.5 MHz/25) will
+	 * be 2 and ceil(403 MHZ/25) will be 17 whereas Hardware
+	 * specification expect to be 16. Hence use exact hardware spec
+	 * mandated value for cycles_in_40ns instead of calculating using
+	 * generic formulae.
+	 */
+	switch (cycles_in_1us) {
+	case UNIPRO_CORE_CLK_FREQ_403_MHZ:
+		cycles_in_40ns = 16;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_300_MHZ:
+		cycles_in_40ns = 12;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_201_5_MHZ:
+		cycles_in_40ns = 8;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_150_MHZ:
+		cycles_in_40ns = 6;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_100_MHZ:
+		cycles_in_40ns = 4;
+		break;
+	case  UNIPRO_CORE_CLK_FREQ_75_MHZ:
+		cycles_in_40ns = 3;
+		break;
+	case UNIPRO_CORE_CLK_FREQ_37_5_MHZ:
+		cycles_in_40ns = 2;
+		break;
+	default:
+		dev_err(hba->dev, "UNIPRO clk freq %u MHz not supported\n",
+			cycles_in_1us);
+		return -EINVAL;
+	}
+
+	err = ufshcd_dme_get(hba, UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES), &reg);
+	if (err)
+		return err;
+
+	reg &= ~PA_VS_CORE_CLK_40NS_CYCLES_MASK;
+	reg |= cycles_in_40ns;
+
+	return ufshcd_dme_set(hba, UIC_ARG_MIB(PA_VS_CORE_CLK_40NS_CYCLES), reg);
+}
+
+static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	u32 core_clk_ctrl_reg;
+	u32 cycles_in_1us;
+	int err;
+
+	cycles_in_1us = ceil(ufs_qcom_get_core_clk_unipro_max_freq(hba),
+			     (1000 * 1000));
+	err = ufshcd_dme_get(hba,
+			     UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
+			     &core_clk_ctrl_reg);
+	if (err)
+		return err;
+
+	/* Bit mask is different for UFS host controller V4.0.0 onwards */
+	if (priv->hw_ver.major >= 4) {
+		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK_V4;
+		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK_V4, cycles_in_1us);
+	} else {
+		core_clk_ctrl_reg &= ~CLK_1US_CYCLES_MASK;
+		core_clk_ctrl_reg |= FIELD_PREP(CLK_1US_CYCLES_MASK, cycles_in_1us);
+	}
+
+	/* Clear CORE_CLK_DIV_EN */
+	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
+
+	err = ufshcd_dme_set(hba,
+			     UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
+			     core_clk_ctrl_reg);
+	if (err)
+		return err;
+
+	/* Configure unipro core clk 40ns attribute */
+	return ufs_qcom_set_clk_40ns_cycles(hba, cycles_in_1us);
+}
+
+static u32 ufs_qcom_get_local_unipro_ver(struct ufs_hba *hba)
+{
+	/* HCI version 1.0 and 1.1 supports UniPro 1.41 */
+	switch (hba->version) {
+	case UFSHCI_VERSION_10:
+	case UFSHCI_VERSION_11:
+		return UFS_UNIPRO_VER_1_41;
+
+	case UFSHCI_VERSION_20:
+	case UFSHCI_VERSION_21:
+	default:
+		return UFS_UNIPRO_VER_1_6;
+	}
+}
+
+static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
+					enum ufs_notify_change_status status)
+{
+	int err = 0;
+
+	switch (status) {
+	case PRE_CHANGE:
+		err = ufs_qcom_set_core_clk_ctrl(hba);
+		if (err)
+			dev_err(hba->dev, "cfg core clk ctrl failed\n");
+		/*
+		 * Some UFS devices (and may be host) have issues if LCC is
+		 * enabled. So we are setting PA_Local_TX_LCC_Enable to 0
+		 * before link startup which will make sure that both host
+		 * and device TX LCC are disabled once link startup is
+		 * completed.
+		 */
+		if (ufs_qcom_get_local_unipro_ver(hba) != UFS_UNIPRO_VER_1_41)
+			err = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0);
+
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+
+	if (enable ^ priv->is_dev_ref_clk_enabled) {
+		u32 temp = readl_relaxed(hba->mmio_base + REG_UFS_CFG1);
+
+		if (enable)
+			temp |= BIT(26);
+		else
+			temp &= ~BIT(26);
+
+		/*
+		 * If we are here to disable this clock it might be immediately
+		 * after entering into hibern8 in which case we need to make
+		 * sure that device ref_clk is active for specific time after
+		 * hibern8 enter.
+		 */
+		if (!enable)
+			udelay(10);
+
+		writel_relaxed(temp, hba->mmio_base + REG_UFS_CFG1);
+
+		/*
+		 * Make sure the write to ref_clk reaches the destination and
+		 * not stored in a Write Buffer (WB).
+		 */
+		readl(hba->mmio_base + REG_UFS_CFG1);
+
+		/*
+		 * If we call hibern8 exit after this, we need to make sure that
+		 * device ref_clk is stable for at least 1us before the hibern8
+		 * exit command.
+		 */
+		if (enable)
+			udelay(1);
+
+		priv->is_dev_ref_clk_enabled = enable;
+	}
+}
+
+/**
+ * ufs_qcom_init - bind phy with controller
+ * @hba: host controller instance
+ *
+ * Powers up PHY enabling clocks and regulators.
+ *
+ * Returns -EPROBE_DEFER if binding fails, returns negative error
+ * on phy power up failure and returns zero on success.
+ */
+static int ufs_qcom_init(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	int err;
+
+	priv->hba = hba;
+
+	/* setup clocks */
+	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
+
+	if (priv->hw_ver.major >= 0x4)
+		ufshcd_dme_set(hba,
+			       UIC_ARG_MIB(PA_TXHSADAPTTYPE),
+			       PA_NO_ADAPT);
+
+	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
+
+	ufs_qcom_get_controller_revision(hba, &priv->hw_ver.major,
+					 &priv->hw_ver.minor,
+					 &priv->hw_ver.step);
+	dev_info(hba->dev, "Qcom UFS HC version: %d.%d.%d\n",
+		 priv->hw_ver.major,
+		 priv->hw_ver.minor,
+		 priv->hw_ver.step);
+
+	err = ufs_qcom_init_clks(priv);
+	if (err) {
+		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
+		return err;
+	}
+
+	ufs_qcom_advertise_quirks(hba);
+	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
+
+	return 0;
+}
+
+/**
+ * ufs_qcom_device_reset() - toggle the (optional) device reset line
+ * @hba: per-adapter instance
+ *
+ * Toggles the (optional) reset line to reset the attached device.
+ */
+static int ufs_qcom_device_reset(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+
+	if (!dm_gpio_is_valid(&priv->reset))
+		return 0;
+
+	/*
+	 * The UFS device shall detect reset pulses of 1us, sleep for 10us to
+	 * be on the safe side.
+	 */
+	dm_gpio_set_value(&priv->reset, true);
+	udelay(10);
+
+	dm_gpio_set_value(&priv->reset, false);
+	udelay(10);
+
+	return 0;
+}
+
+static struct ufs_hba_ops ufs_qcom_hba_ops = {
+	.init			= ufs_qcom_init,
+	.get_max_pwr_mode	= ufs_get_max_pwr_mode,
+	.hce_enable_notify	= ufs_qcom_hce_enable_notify,
+	.link_startup_notify	= ufs_qcom_link_startup_notify,
+	.device_reset		= ufs_qcom_device_reset,
+};
+
+static int ufs_qcom_probe(struct udevice *dev)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/* get resets */
+	ret = reset_get_by_name(dev, "rst", &priv->core_reset);
+	if (ret) {
+		dev_err(dev, "failed to get reset, ret:%d\n", ret);
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset, GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "Warning: cannot get reset GPIO\n");
+	}
+
+	ret = ufshcd_probe(dev, &ufs_qcom_hba_ops);
+	if (ret) {
+		dev_err(dev, "ufshcd_probe() failed, ret:%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ufs_qcom_bind(struct udevice *dev)
+{
+	struct udevice *scsi_dev;
+
+	return ufs_scsi_bind(dev, &scsi_dev);
+}
+
+static const struct udevice_id ufs_qcom_ids[] = {
+	{ .compatible = "qcom,ufshc" },
+	{},
+};
+
+U_BOOT_DRIVER(qcom_ufshcd) = {
+	.name		= "qcom-ufshcd",
+	.id		= UCLASS_UFS,
+	.of_match	= ufs_qcom_ids,
+	.probe		= ufs_qcom_probe,
+	.bind		= ufs_qcom_bind,
+	.priv_auto	= sizeof(struct ufs_qcom_priv),
+};
diff --git a/drivers/ufs/ufs-qcom.h b/drivers/ufs/ufs-qcom.h
new file mode 100644
index 00000000000..de957ae60f3
--- /dev/null
+++ b/drivers/ufs/ufs-qcom.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef UFS_QCOM_H_
+#define UFS_QCOM_H_
+
+#include <reset.h>
+#include <linux/bitfield.h>
+
+#define MPHY_TX_FSM_STATE       0x41
+#define TX_FSM_HIBERN8          0x1
+#define DEFAULT_CLK_RATE_HZ     1000000
+
+#define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
+#define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
+#define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
+
+/* QCOM UFS host controller vendor specific registers */
+enum {
+	REG_UFS_SYS1CLK_1US                 = 0xC0,
+	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
+	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
+	REG_UFS_PA_ERR_CODE                 = 0xCC,
+	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
+	REG_UFS_PARAM0                      = 0xD0,
+	/* On older UFS revisions, this register is called "REG_UFS_PA_LINK_STARTUP_TIMER" */
+	REG_UFS_CFG0                        = 0xD8,
+	REG_UFS_CFG1                        = 0xDC,
+	REG_UFS_CFG2                        = 0xE0,
+	REG_UFS_HW_VERSION                  = 0xE4,
+
+	UFS_TEST_BUS				= 0xE8,
+	UFS_TEST_BUS_CTRL_0			= 0xEC,
+	UFS_TEST_BUS_CTRL_1			= 0xF0,
+	UFS_TEST_BUS_CTRL_2			= 0xF4,
+	UFS_UNIPRO_CFG				= 0xF8,
+
+	/*
+	 * QCOM UFS host controller vendor specific registers
+	 * added in HW Version 3.0.0
+	 */
+	UFS_AH8_CFG				= 0xFC,
+
+	REG_UFS_CFG3				= 0x271C,
+};
+
+/* bit definitions for REG_UFS_CFG0 register */
+#define QUNIPRO_G4_SEL		BIT(5)
+
+/* bit definitions for REG_UFS_CFG1 register */
+#define QUNIPRO_SEL		BIT(0)
+#define UFS_PHY_SOFT_RESET	BIT(1)
+#define UTP_DBG_RAMS_EN		BIT(17)
+#define TEST_BUS_EN		BIT(18)
+#define TEST_BUS_SEL		GENMASK(22, 19)
+#define UFS_REG_TEST_BUS_EN	BIT(30)
+
+#define UFS_PHY_RESET_ENABLE	1
+#define UFS_PHY_RESET_DISABLE	0
+
+/* bit definitions for REG_UFS_CFG2 register */
+#define UAWM_HW_CGC_EN		BIT(0)
+#define UARM_HW_CGC_EN		BIT(1)
+#define TXUC_HW_CGC_EN		BIT(2)
+#define RXUC_HW_CGC_EN		BIT(3)
+#define DFC_HW_CGC_EN		BIT(4)
+#define TRLUT_HW_CGC_EN		BIT(5)
+#define TMRLUT_HW_CGC_EN	BIT(6)
+#define OCSC_HW_CGC_EN		BIT(7)
+
+/* bit definitions for REG_UFS_PARAM0 */
+#define MAX_HS_GEAR_MASK	GENMASK(6, 4)
+#define UFS_QCOM_MAX_GEAR(x)	FIELD_GET(MAX_HS_GEAR_MASK, (x))
+
+/* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
+#define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
+
+#define REG_UFS_CFG2_CGC_EN_ALL (UAWM_HW_CGC_EN | UARM_HW_CGC_EN |\
+				 TXUC_HW_CGC_EN | RXUC_HW_CGC_EN |\
+				 DFC_HW_CGC_EN | TRLUT_HW_CGC_EN |\
+				 TMRLUT_HW_CGC_EN | OCSC_HW_CGC_EN)
+
+/* bit offset */
+#define OFFSET_CLK_NS_REG		0xa
+
+/* bit masks */
+#define MASK_TX_SYMBOL_CLK_1US_REG	GENMASK(9, 0)
+#define MASK_CLK_NS_REG			GENMASK(23, 10)
+
+/* QUniPro Vendor specific attributes */
+#define PA_VS_CONFIG_REG1	0x9000
+#define DME_VS_CORE_CLK_CTRL	0xD002
+/* bit and mask definitions for DME_VS_CORE_CLK_CTRL attribute */
+#define CLK_1US_CYCLES_MASK_V4				GENMASK(27, 16)
+#define CLK_1US_CYCLES_MASK				GENMASK(7, 0)
+#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT	BIT(8)
+#define PA_VS_CORE_CLK_40NS_CYCLES			0x9007
+#define PA_VS_CORE_CLK_40NS_CYCLES_MASK			GENMASK(6, 0)
+
+/* QCOM UFS host controller core clk frequencies */
+#define UNIPRO_CORE_CLK_FREQ_37_5_MHZ          38
+#define UNIPRO_CORE_CLK_FREQ_75_MHZ            75
+#define UNIPRO_CORE_CLK_FREQ_100_MHZ           100
+#define UNIPRO_CORE_CLK_FREQ_150_MHZ           150
+#define UNIPRO_CORE_CLK_FREQ_300_MHZ           300
+#define UNIPRO_CORE_CLK_FREQ_201_5_MHZ         202
+#define UNIPRO_CORE_CLK_FREQ_403_MHZ           403
+
+static inline void
+ufs_qcom_get_controller_revision(struct ufs_hba *hba,
+				 u8 *major, u16 *minor, u16 *step)
+{
+	u32 ver = ufshcd_readl(hba, REG_UFS_HW_VERSION);
+
+	*major = FIELD_GET(UFS_HW_VER_MAJOR_MASK, ver);
+	*minor = FIELD_GET(UFS_HW_VER_MINOR_MASK, ver);
+	*step = FIELD_GET(UFS_HW_VER_STEP_MASK, ver);
+};
+
+/* Host controller hardware version: major.minor.step */
+struct ufs_hw_version {
+	u16 step;
+	u16 minor;
+	u8 major;
+};
+
+struct gpio_desc;
+
+struct ufs_qcom_priv {
+	struct phy *generic_phy;
+	struct ufs_hba *hba;
+
+	struct clk_bulk clks;
+	bool is_clks_enabled;
+
+	struct ufs_hw_version hw_ver;
+
+	/* Reset control of HCI */
+	struct reset_ctl core_reset;
+
+	struct gpio_desc reset;
+
+	bool is_dev_ref_clk_enabled;
+};
+
+#endif /* UFS_QCOM_H_ */
diff --git a/drivers/ufs/unipro.h b/drivers/ufs/unipro.h
index b30b17fa5ad..52db6324b4a 100644
--- a/drivers/ufs/unipro.h
+++ b/drivers/ufs/unipro.h
@@ -140,6 +140,12 @@
 #define PA_SLEEPNOCONFIGTIME	0x15A2
 #define PA_STALLNOCONFIGTIME	0x15A3
 #define PA_SAVECONFIGTIME	0x15A4
+#define PA_TXHSADAPTTYPE	0x15D4
+
+/* Adapt type for PA_TXHSADAPTTYPE attribute */
+#define PA_REFRESH_ADAPT       0x00
+#define PA_INITIAL_ADAPT       0x01
+#define PA_NO_ADAPT            0x03
 
 #define PA_TACTIVATE_TIME_UNIT_US	10
 #define PA_HIBERN8_TIME_UNIT_US		100

-- 
2.34.1

