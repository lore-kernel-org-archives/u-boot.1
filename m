Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1AFC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4FF86989;
	Mon, 14 Aug 2023 23:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C0QvKA6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC3F869B5; Mon, 14 Aug 2023 23:56:08 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4658086993
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso19536915ad.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050162; x=1692654962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aSajnqbX3WDsT8WQkNy5K1voHGzBm1yc0a5S/FNzLc=;
 b=C0QvKA6aoyoNZkapYjm4IM9Bc3CLcT9kgyja6tgYANkBoijZl8LzSkmy3qjN6abAmv
 BywLuQCwKE+oz7i5qFwfKDeuEwG/ecoS7PLHt7GzFJh/E1/L4sWD6CVmyOj7kAROLkts
 Ak6B4asGscFdRygi4DZhf4zZOSpNNDbGoxGfN8lbOG2E26w4XwbknqGyRjmN/CN047sL
 t1Zt3gytPYAkQiGpzpAMNwTrzBSvnTEJvA+ObryWor+zlqI8yOivVpc9CuEC6t1NX0gy
 Qb9xDEWEqeJmxHZGR1FpYlXWua6OxiyO3egvksj5PDU/O41nV63oWoie7Oh1gq1ljXx8
 5WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050162; x=1692654962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5aSajnqbX3WDsT8WQkNy5K1voHGzBm1yc0a5S/FNzLc=;
 b=bEvbMl/XlAVbv6Y5Y8uVoYYTE8Oaa3Zy3O+F7fGpSdtwAFNHeRCTNtcFSMJDSC5PZc
 CEJoHieZuZfX59fzTpoJhMcJNshrmEfZxKM3XFLU05sQBYwfsNIP6hhdoLoBdmfsFSwB
 W05xv8Dme3bMVhLxlTMtNbCNL63bruHsUYf990wUk3seWl8avidiqqQ5/8kf1HYBw1kd
 h9DXojjov3fjUONHs7L6hbwx3C6flkoHRpxl4Mo+BwvJMvrJQFfkNV/MPU8X+L+1YkZS
 GHDZ7U2S2xGtpYnX7msJHp613MOfJKq+gafGnUocW4mgyX/Oh0XXgC+xmeja9iYvB4Dx
 K2sQ==
X-Gm-Message-State: AOJu0YydTEeREovQgP4vQ4YIp8JfncSE34vYvvsshb0n/9WwjBt+HOtB
 5Mjve0SGnSNQksZ2sOel1GxjoMoyKlhkUzIYHaQ=
X-Google-Smtp-Source: AGHT+IHCbNmgj4v9hnBYgrDZhiYuKUZRRbALJHyILdY40Z/S3QAtuOYUT6EBIJd+iqUilH6a/FFCsQ==
X-Received: by 2002:a17:902:d4cf:b0:1b8:9b1b:ae8e with SMTP id
 o15-20020a170902d4cf00b001b89b1bae8emr10260353plg.59.1692050161913; 
 Mon, 14 Aug 2023 14:56:01 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:56:01 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 12/17] ufs: Add Support for Qualcomm UFS HC driver
Date: Tue, 15 Aug 2023 03:24:52 +0530
Message-Id: <20230814215457.4075025-13-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

Add Support for the Host Controller driver for UFS HC
present on Qualcomm Snapdragon SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/Kconfig       |   7 +
 drivers/ufs/Makefile      |   1 +
 drivers/ufs/qcom-ufshcd.c | 880 ++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-qcom.h    | 275 ++++++++++++
 4 files changed, 1163 insertions(+)
 create mode 100644 drivers/ufs/qcom-ufshcd.c
 create mode 100644 drivers/ufs/ufs-qcom.h

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 69ea18edf8..5dfe8048a8 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -15,6 +15,13 @@ config CADENCE_UFS
 	  This selects the platform driver for the Cadence UFS host
 	  controller present on present TI's J721e devices.
 
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
index 62ed016608..87944b1a7a 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
+obj-$(CONFIG_QCOM_UFS) += qcom-ufshcd.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
diff --git a/drivers/ufs/qcom-ufshcd.c b/drivers/ufs/qcom-ufshcd.c
new file mode 100644
index 0000000000..ca55c3e8f5
--- /dev/null
+++ b/drivers/ufs/qcom-ufshcd.c
@@ -0,0 +1,880 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Bhupesh Sharma <bhupesh.sharma@linaro.org>
+ *
+ * Based on Linux driver
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <common.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <ufs.h>
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+#include "ufs.h"
+#include "ufs-qcom.h"
+
+#define MSEC_PER_SEC	(1000L)
+#define USEC_PER_SEC	(1000000L)
+#define NSEC_PER_SEC	(1000000000L)
+
+static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
+						       u32 clk_cycles);
+
+static int ufs_qcom_clk_get(struct udevice *dev,
+		const char *name, struct clk **clk_out, bool optional)
+{
+	struct clk *clk;
+	int err = 0;
+
+	clk = devm_clk_get(dev, name);
+	if (!IS_ERR(clk)) {
+		*clk_out = clk;
+		return 0;
+	}
+
+	err = PTR_ERR(clk);
+
+	if (optional && err == -ENOENT) {
+		*clk_out = NULL;
+		return 0;
+	}
+
+	if (err != -EPROBE_DEFER)
+		dev_err(dev, "failed to get %s err %d\n", name, err);
+
+	return err;
+}
+
+static int ufs_qcom_clk_enable(struct udevice *dev,
+		const char *name, struct clk *clk)
+{
+	int err = 0;
+
+	err = clk_prepare_enable(clk);
+	if (err)
+		dev_err(dev, "%s: %s enable failed %d\n", __func__, name, err);
+
+	return err;
+}
+
+static int ufs_qcom_enable_lane_clks(struct ufs_qcom_priv *priv)
+{
+	int err;
+	struct udevice *dev = priv->hba->dev;
+
+	if (priv->is_lane_clks_enabled)
+		return 0;
+
+	err = ufs_qcom_clk_enable(dev, "rx_lane0_sync_clk",
+		priv->rx_l0_sync_clk);
+	if (err)
+		return err;
+
+	err = ufs_qcom_clk_enable(dev, "tx_lane0_sync_clk",
+		priv->tx_l0_sync_clk);
+	if (err)
+		goto disable_rx_l0;
+
+	err = ufs_qcom_clk_enable(dev, "rx_lane1_sync_clk",
+		priv->rx_l1_sync_clk);
+	if (err)
+		goto disable_tx_l0;
+
+	priv->is_lane_clks_enabled = true;
+
+	return 0;
+
+disable_tx_l0:
+	clk_disable_unprepare(priv->tx_l0_sync_clk);
+disable_rx_l0:
+	clk_disable_unprepare(priv->rx_l0_sync_clk);
+
+	return err;
+}
+
+static int ufs_qcom_init_lane_clks(struct ufs_qcom_priv *priv)
+{
+	int err = 0;
+	struct udevice *dev = priv->hba->dev;
+
+	err = ufs_qcom_clk_get(dev, "rx_lane0_sync_clk",
+					&priv->rx_l0_sync_clk, false);
+	if (err)
+		return err;
+
+	err = ufs_qcom_clk_get(dev, "tx_lane0_sync_clk",
+					&priv->tx_l0_sync_clk, false);
+	if (err)
+		return err;
+
+	err = ufs_qcom_clk_get(dev, "rx_lane1_sync_clk",
+					&priv->rx_l1_sync_clk, false);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int ufs_qcom_enable_core_clks(struct ufs_qcom_priv *priv)
+{
+	int err;
+	struct udevice *dev = priv->hba->dev;
+
+	if (priv->is_core_clks_enabled)
+		return 0;
+
+	err = ufs_qcom_clk_enable(dev, "core_clk", priv->core_clk);
+	if (err)
+		return err;
+
+	err = ufs_qcom_clk_enable(dev, "bus_aggr_clk", priv->bus_aggr_clk);
+	if (err)
+		goto disable_core_clk;
+
+	err = ufs_qcom_clk_enable(dev, "iface_clk", priv->iface_clk);
+	if (err)
+		goto disable_bus_aggr_clk;
+
+	err = ufs_qcom_clk_enable(dev, "core_clk_unipro", priv->core_clk_unipro);
+	if (err)
+		goto disable_iface_clk;
+
+	priv->is_core_clks_enabled = true;
+
+	return 0;
+
+disable_iface_clk:
+	clk_disable_unprepare(priv->iface_clk);
+disable_bus_aggr_clk:
+	clk_disable_unprepare(priv->bus_aggr_clk);
+disable_core_clk:
+	clk_disable_unprepare(priv->core_clk);
+
+	return err;
+}
+
+static int ufs_qcom_init_core_clks(struct ufs_qcom_priv *priv)
+{
+	int err = 0;
+	struct udevice *dev = priv->hba->dev;
+
+	err = ufs_qcom_clk_get(dev, "core_clk",
+					&priv->core_clk, false);
+	if (err)
+		return err;
+
+	err = ufs_qcom_clk_get(dev, "bus_aggr_clk",
+					&priv->bus_aggr_clk, false);
+	if (err)
+		return err;
+
+	err = ufs_qcom_clk_get(dev, "iface_clk", &priv->iface_clk, false);
+	if (err)
+		return err;
+
+	err = ufs_qcom_clk_get(dev, "core_clk_unipro", &priv->core_clk_unipro, false);
+	if (err)
+		return err;
+
+	/* ref_clk is optional */
+
+	return 0;
+}
+
+static void ufs_qcom_select_unipro_mode(struct ufs_qcom_priv *priv)
+{
+	ufshcd_rmwl(priv->hba, QUNIPRO_SEL,
+		   ufs_qcom_cap_qunipro(priv) ? QUNIPRO_SEL : 0,
+		   REG_UFS_CFG1);
+
+	if (priv->hw_ver.major == 0x05)
+		ufshcd_rmwl(priv->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
+
+	/* make sure above configuration is applied before we return */
+	mb();
+}
+
+/*
+ * ufs_qcom_reset - reset host controller and PHY
+ */
+static int ufs_qcom_reset(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	int ret = 0;
+
+	ret = reset_assert(&priv->core_reset);
+	if (ret) {
+		dev_err(hba->dev, "%s: core_reset assert failed, err = %d\n",
+				 __func__, ret);
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
+				 __func__, ret);
+
+	udelay(1100);
+
+	return 0;
+}
+
+static void ufs_qcom_set_caps(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+
+	if (priv->hw_ver.major >= 0x2) {
+		priv->caps = UFS_QCOM_CAP_QUNIPRO |
+			     UFS_QCOM_CAP_RETAIN_SEC_CFG_AFTER_PWR_COLLAPSE;
+	}
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
+	if (priv->hw_ver.major == 0x01) {
+		hba->quirks |= UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS
+			    | UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP
+			    | UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE;
+
+		if (priv->hw_ver.minor == 0x0001 && priv->hw_ver.step == 0x0001)
+			hba->quirks |= UFSHCD_QUIRK_BROKEN_INTR_AGGR;
+
+		hba->quirks |= UFSHCD_QUIRK_BROKEN_LCC;
+	}
+
+	if (priv->hw_ver.major == 0x2) {
+		hba->quirks |= UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION;
+
+		if (!ufs_qcom_cap_qunipro(priv))
+			/* Legacy UniPro mode still need following quirks */
+			hba->quirks |= (UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS
+				| UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE
+				| UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP);
+	}
+
+	if (priv->hw_ver.major > 0x3)
+		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
+}
+
+static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+
+	if (priv->dev_ref_clk_ctrl_mmio &&
+	    (enable ^ priv->is_dev_ref_clk_enabled)) {
+		u32 temp = readl_relaxed(priv->dev_ref_clk_ctrl_mmio);
+
+		if (enable)
+			temp |= priv->dev_ref_clk_en_mask;
+		else
+			temp &= ~priv->dev_ref_clk_en_mask;
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
+		writel_relaxed(temp, priv->dev_ref_clk_ctrl_mmio);
+
+		/*
+		 * Make sure the write to ref_clk reaches the destination and
+		 * not stored in a Write Buffer (WB).
+		 */
+		readl(priv->dev_ref_clk_ctrl_mmio);
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
+		if (!on) {
+			/* disable device ref_clk */
+			ufs_qcom_dev_ref_clk_ctrl(hba, false);
+		}
+		break;
+	case POST_CHANGE:
+		if (on) {
+			/* enable the device ref clock for HS mode*/
+			ufs_qcom_dev_ref_clk_ctrl(hba, true);
+		}
+		break;
+	}
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
+				  __func__, ret);
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
+	/*
+	 * check the state again.
+	 */
+	err = ufshcd_dme_get(hba,
+			UIC_ARG_MIB_SEL(MPHY_TX_FSM_STATE,
+				UIC_ARG_MPHY_TX_GEN_SEL_INDEX(0)),
+				&tx_fsm_val);
+
+	if (err) {
+		dev_err(hba->dev, "%s: unable to get TX_FSM_STATE, err %d\n",
+				__func__, err);
+	} else if (tx_fsm_val != TX_FSM_HIBERN8) {
+		err = tx_fsm_val;
+		dev_err(hba->dev, "%s: invalid TX_FSM_STATE = %d\n",
+				__func__, err);
+	}
+
+	return err;
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
+	ufshcd_writel(hba,
+		ufshcd_readl(hba, REG_UFS_CFG2) | REG_UFS_CFG2_CGC_EN_ALL,
+		REG_UFS_CFG2);
+
+	/* Ensure that HW clock gating is enabled before next operations */
+	mb();
+}
+
+static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
+				      enum ufs_notify_change_status status)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	int err = 0;
+
+	switch (status) {
+	case PRE_CHANGE:
+		ufs_qcom_power_up_sequence(hba);
+		/*
+		 * The PHY PLL output is the source of tx/rx lane symbol
+		 * clocks, hence, enable the lane clocks only after PHY
+		 * is initialized.
+		 */
+		err = ufs_qcom_enable_core_clks(priv);
+		if (err < 0)
+			return err;
+
+		err = ufs_qcom_enable_lane_clks(priv);
+		if (err < 0)
+			return err;
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
+/*
+ * Returns zero for success and non-zero in case of a failure
+ */
+static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
+			       u32 hs, u32 rate, bool update_link_startup_timer)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	u32 core_clk_period_in_ns;
+	u32 tx_clk_cycles_per_us = 0;
+	unsigned long core_clk_rate = 0;
+	u32 core_clk_cycles_per_us = 0;
+
+	static u32 pwm_fr_table[][2] = {
+		{UFS_PWM_G1, 0x1},
+		{UFS_PWM_G2, 0x1},
+		{UFS_PWM_G3, 0x1},
+		{UFS_PWM_G4, 0x1},
+	};
+
+	static u32 hs_fr_table_rA[][2] = {
+		{UFS_HS_G1, 0x1F},
+		{UFS_HS_G2, 0x3e},
+		{UFS_HS_G3, 0x7D},
+	};
+
+	static u32 hs_fr_table_rB[][2] = {
+		{UFS_HS_G1, 0x24},
+		{UFS_HS_G2, 0x49},
+		{UFS_HS_G3, 0x92},
+	};
+
+	/*
+	 * The Qunipro controller does not use following registers:
+	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
+	 * UFS_REG_PA_LINK_STARTUP_TIMER
+	 * But UTP controller uses SYS1CLK_1US_REG register for Interrupt
+	 * Aggregation logic.
+	*/
+	if (ufs_qcom_cap_qunipro(priv))
+		return 0;
+
+	if (gear == 0) {
+		dev_err(hba->dev, "%s: invalid gear = %d\n", __func__, gear);
+		return -EINVAL;
+	}
+
+	core_clk_rate = clk_get_rate(priv->core_clk);
+
+	/* If frequency is smaller than 1MHz, set to 1MHz */
+	if (core_clk_rate < DEFAULT_CLK_RATE_HZ)
+		core_clk_rate = DEFAULT_CLK_RATE_HZ;
+
+	core_clk_cycles_per_us = core_clk_rate / USEC_PER_SEC;
+	if (ufshcd_readl(hba, REG_UFS_SYS1CLK_1US) != core_clk_cycles_per_us) {
+		ufshcd_writel(hba, core_clk_cycles_per_us, REG_UFS_SYS1CLK_1US);
+		/*
+		 * make sure above write gets applied before we return from
+		 * this function.
+		 */
+		mb();
+	}
+
+	if (ufs_qcom_cap_qunipro(priv))
+		return 0;
+
+	core_clk_period_in_ns = NSEC_PER_SEC / core_clk_rate;
+	core_clk_period_in_ns <<= OFFSET_CLK_NS_REG;
+	core_clk_period_in_ns &= MASK_CLK_NS_REG;
+
+	switch (hs) {
+	case FASTAUTO_MODE:
+	case FAST_MODE:
+		if (rate == PA_HS_MODE_A) {
+			if (gear > ARRAY_SIZE(hs_fr_table_rA)) {
+				dev_err(hba->dev,
+					"%s: index %d exceeds table size %zu\n",
+					__func__, gear,
+					ARRAY_SIZE(hs_fr_table_rA));
+				return -EINVAL;
+			}
+			tx_clk_cycles_per_us = hs_fr_table_rA[gear-1][1];
+		} else if (rate == PA_HS_MODE_B) {
+			if (gear > ARRAY_SIZE(hs_fr_table_rB)) {
+				dev_err(hba->dev,
+					"%s: index %d exceeds table size %zu\n",
+					__func__, gear,
+					ARRAY_SIZE(hs_fr_table_rB));
+				return -EINVAL;
+			}
+			tx_clk_cycles_per_us = hs_fr_table_rB[gear-1][1];
+		} else {
+			dev_err(hba->dev, "%s: invalid rate = %d\n",
+				__func__, rate);
+			return -EINVAL;
+		}
+		break;
+	case SLOWAUTO_MODE:
+	case SLOW_MODE:
+		if (gear > ARRAY_SIZE(pwm_fr_table)) {
+			dev_err(hba->dev,
+					"%s: index %d exceeds table size %zu\n",
+					__func__, gear,
+					ARRAY_SIZE(pwm_fr_table));
+			return -EINVAL;
+		}
+		tx_clk_cycles_per_us = pwm_fr_table[gear-1][1];
+		break;
+	case UNCHANGED:
+	default:
+		dev_err(hba->dev, "%s: invalid mode = %d\n", __func__, hs);
+		return -EINVAL;
+	}
+
+	if (ufshcd_readl(hba, REG_UFS_TX_SYMBOL_CLK_NS_US) !=
+	    (core_clk_period_in_ns | tx_clk_cycles_per_us)) {
+		/* this register 2 fields shall be written at once */
+		ufshcd_writel(hba, core_clk_period_in_ns | tx_clk_cycles_per_us,
+			      REG_UFS_TX_SYMBOL_CLK_NS_US);
+		/*
+		 * make sure above write gets applied before we return from
+		 * this function.
+		 */
+		mb();
+	}
+
+	if (update_link_startup_timer && priv->hw_ver.major != 0x5) {
+		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
+			      REG_UFS_CFG0);
+		/*
+		 * make sure that this configuration is applied before
+		 * we return
+		 */
+		mb();
+	}
+
+	return 0;
+}
+
+static int ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(struct ufs_hba *hba,
+						       u32 clk_cycles)
+{
+	int err;
+	u32 core_clk_ctrl_reg;
+
+	if (clk_cycles > DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK)
+		return -EINVAL;
+
+	err = ufshcd_dme_get(hba,
+			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
+			    &core_clk_ctrl_reg);
+	if (err)
+		return err;
+
+	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK;
+	core_clk_ctrl_reg |= clk_cycles;
+
+	/* Clear CORE_CLK_DIV_EN */
+	core_clk_ctrl_reg &= ~DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT;
+
+	return ufshcd_dme_set(hba,
+			    UIC_ARG_MIB(DME_VS_CORE_CLK_CTRL),
+			    core_clk_ctrl_reg);
+}
+
+/* TBD: Move this to common framework layer */
+u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
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
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+	int err = 0;
+
+	switch (status) {
+	case PRE_CHANGE:
+		if (ufs_qcom_cfg_timers(hba, UFS_PWM_G1, SLOWAUTO_MODE,
+					0, true)) {
+			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
+				__func__);
+			return -EINVAL;
+		}
+
+		if (ufs_qcom_cap_qunipro(priv))
+			/*
+			 * set unipro core clock cycles to 150 & clear clock
+			 * divider
+			 */
+			err = ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div(hba,
+									  150);
+
+		/*
+		 * Some UFS devices (and may be host) have issues if LCC is
+		 * enabled. So we are setting PA_Local_TX_LCC_Enable to 0
+		 * before link startup which will make sure that both host
+		 * and device TX LCC are disabled once link startup is
+		 * completed.
+		 */
+		if (ufshcd_get_local_unipro_ver(hba) != UFS_UNIPRO_VER_1_41)
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
+	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
+
+	ufs_qcom_get_controller_revision(hba, &priv->hw_ver.major,
+		&priv->hw_ver.minor, &priv->hw_ver.step);
+	dev_info(hba->dev, "Qcom UFS HC version: %d.%d.%d\n", priv->hw_ver.major,
+		priv->hw_ver.minor, priv->hw_ver.step);
+
+	/*
+	 * for newer controllers, device reference clock control bit has
+	 * moved inside UFS controller register address space itself.
+	 */
+	if (priv->hw_ver.major >= 0x02) {
+		priv->dev_ref_clk_ctrl_mmio = hba->mmio_base + REG_UFS_CFG1;
+		priv->dev_ref_clk_en_mask = BIT(26);
+	}
+
+	err = ufs_qcom_init_core_clks(priv);
+	if (err) {
+		dev_err(hba->dev, "failed to initialize core clocks, err:%d\n", err);
+		return err;
+	}
+
+	err = ufs_qcom_init_lane_clks(priv);
+	if (err) {
+		dev_err(hba->dev, "failed to initialize lane clocks, err:%d\n", err);
+		return err;
+	}
+
+	ufs_qcom_set_caps(hba);
+	ufs_qcom_advertise_quirks(hba);
+	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
+
+	/* Power up the PHY using UFS_HS_G3. */
+	priv->hs_gear = UFS_HS_G3;
+
+	return 0;
+}
+
+static void ufshcd_print_clk_freqs(struct ufs_hba *hba)
+{
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+
+	dev_info(hba->dev, "clk: %s, rate: %lu\n", "bus_aggr_clk",
+		       clk_get_rate(priv->bus_aggr_clk));
+	dev_info(hba->dev, "clk: %s, rate: %lu\n", "iface_clk",
+		       clk_get_rate(priv->iface_clk));
+	dev_info(hba->dev, "clk: %s, rate: %lu\n", "core_clk_unipro",
+		       clk_get_rate(priv->core_clk_unipro));
+}
+
+static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
+{
+	u32 reg;
+	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
+
+	ufshcd_dump_regs(hba, REG_UFS_SYS1CLK_1US, 16 * 4,
+			 "HCI Vendor Specific Registers ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_UFS_DBG_RD_REG_OCSC);
+	ufshcd_dump_regs(hba, reg, 44 * 4, "UFS_UFS_DBG_RD_REG_OCSC ");
+
+	reg = ufshcd_readl(hba, REG_UFS_CFG1);
+	reg |= UTP_DBG_RAMS_EN;
+	ufshcd_writel(hba, reg, REG_UFS_CFG1);
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_UFS_DBG_RD_EDTL_RAM);
+	ufshcd_dump_regs(hba, reg, 32 * 4, "UFS_UFS_DBG_RD_EDTL_RAM ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_UFS_DBG_RD_DESC_RAM);
+	ufshcd_dump_regs(hba, reg, 128 * 4, "UFS_UFS_DBG_RD_DESC_RAM ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_UFS_DBG_RD_PRDT_RAM);
+	ufshcd_dump_regs(hba, reg, 64 * 4, "UFS_UFS_DBG_RD_PRDT_RAM ");
+
+	/* clear bit 17 - UTP_DBG_RAMS_EN */
+	ufshcd_rmwl(hba, UTP_DBG_RAMS_EN, 0, REG_UFS_CFG1);
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_DBG_RD_REG_UAWM);
+	ufshcd_dump_regs(hba, reg, 4 * 4, "UFS_DBG_RD_REG_UAWM ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_DBG_RD_REG_UARM);
+	ufshcd_dump_regs(hba, reg, 4 * 4, "UFS_DBG_RD_REG_UARM ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_DBG_RD_REG_TXUC);
+	ufshcd_dump_regs(hba, reg, 48 * 4, "UFS_DBG_RD_REG_TXUC ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_DBG_RD_REG_RXUC);
+	ufshcd_dump_regs(hba, reg, 27 * 4, "UFS_DBG_RD_REG_RXUC ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_DBG_RD_REG_DFC);
+	ufshcd_dump_regs(hba, reg, 19 * 4, "UFS_DBG_RD_REG_DFC ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_DBG_RD_REG_TRLUT);
+	ufshcd_dump_regs(hba, reg, 34 * 4, "UFS_DBG_RD_REG_TRLUT ");
+
+	reg = ufs_qcom_get_debug_reg_offset(priv, UFS_DBG_RD_REG_TMRLUT);
+	ufshcd_dump_regs(hba, reg, 9 * 4, "UFS_DBG_RD_REG_TMRLUT ");
+
+	ufshcd_print_clk_freqs(hba);
+}
+
+static struct ufs_hba_ops ufs_qcom_hba_ops = {
+	.init			= ufs_qcom_init,
+	.dbg_register_dump	= ufs_qcom_dump_dbg_regs,
+	.hce_enable_notify	= ufs_qcom_hce_enable_notify,
+	.link_startup_notify	= ufs_qcom_link_startup_notify,
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
index 0000000000..be5f558aef
--- /dev/null
+++ b/drivers/ufs/ufs-qcom.h
@@ -0,0 +1,275 @@
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
+#define MAX_UFS_QCOM_HOSTS	1
+#define MAX_U32                 (~(u32)0)
+#define MPHY_TX_FSM_STATE       0x41
+#define TX_FSM_HIBERN8          0x1
+#define HBRN8_POLL_TOUT_MS      100
+#define DEFAULT_CLK_RATE_HZ     1000000
+#define BUS_VECTOR_NAME_LEN     32
+#define MAX_SUPP_MAC		64
+
+#define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
+#define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
+#define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
+
+/* vendor specific pre-defined parameters */
+#define SLOW 1
+#define FAST 2
+
+#define UFS_QCOM_LIMIT_HS_RATE		PA_HS_MODE_B
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
+/* QCOM UFS host controller vendor specific debug registers */
+enum {
+	UFS_DBG_RD_REG_UAWM			= 0x100,
+	UFS_DBG_RD_REG_UARM			= 0x200,
+	UFS_DBG_RD_REG_TXUC			= 0x300,
+	UFS_DBG_RD_REG_RXUC			= 0x400,
+	UFS_DBG_RD_REG_DFC			= 0x500,
+	UFS_DBG_RD_REG_TRLUT			= 0x600,
+	UFS_DBG_RD_REG_TMRLUT			= 0x700,
+	UFS_UFS_DBG_RD_REG_OCSC			= 0x800,
+
+	UFS_UFS_DBG_RD_DESC_RAM			= 0x1500,
+	UFS_UFS_DBG_RD_PRDT_RAM			= 0x1700,
+	UFS_UFS_DBG_RD_RESP_RAM			= 0x1800,
+	UFS_UFS_DBG_RD_EDTL_RAM			= 0x1900,
+};
+
+enum {
+	UFS_MEM_CQIS_VS		= 0x8,
+};
+
+#define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
+#define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
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
+#define DME_VS_CORE_CLK_CTRL_CORE_CLK_DIV_EN_BIT		BIT(8)
+#define DME_VS_CORE_CLK_CTRL_MAX_CORE_CLK_1US_CYCLES_MASK	0xFF
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
+static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
+{
+	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, FIELD_PREP(UFS_PHY_SOFT_RESET, UFS_PHY_RESET_ENABLE),
+		    REG_UFS_CFG1);
+
+	/*
+	 * Make sure assertion of ufs phy reset is written to
+	 * register before returning
+	 */
+	mb();
+}
+
+static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
+{
+	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, FIELD_PREP(UFS_PHY_SOFT_RESET, UFS_PHY_RESET_DISABLE),
+		    REG_UFS_CFG1);
+
+	/*
+	 * Make sure de-assertion of ufs phy reset is written to
+	 * register before returning
+	 */
+	mb();
+}
+
+/* Host controller hardware version: major.minor.step */
+struct ufs_hw_version {
+	u16 step;
+	u16 minor;
+	u8 major;
+};
+
+struct ufs_qcom_testbus {
+	u8 select_major;
+	u8 select_minor;
+};
+
+struct gpio_desc;
+
+struct ufs_qcom_priv {
+	/*
+	 * Set this capability if host controller supports the QUniPro mode
+	 * and if driver wants the Host controller to operate in QUniPro mode.
+	 * Note: By default this capability will be kept enabled if host
+	 * controller supports the QUniPro mode.
+	 */
+	#define UFS_QCOM_CAP_QUNIPRO	0x1
+
+	/*
+	 * Set this capability if host controller can retain the secure
+	 * configuration even after UFS controller core power collapse.
+	 */
+	#define UFS_QCOM_CAP_RETAIN_SEC_CFG_AFTER_PWR_COLLAPSE	0x2
+	u32 caps;
+
+	struct phy *generic_phy;
+	struct ufs_hba *hba;
+	struct ufs_pa_layer_attr dev_req_params;
+
+	struct clk *core_clk;
+	struct clk *bus_aggr_clk;
+	struct clk *iface_clk;
+	struct clk *core_clk_unipro;
+	struct clk *ref_clk;
+	bool is_core_clks_enabled;
+
+	struct clk *rx_l0_sync_clk;
+	struct clk *tx_l0_sync_clk;
+	struct clk *rx_l1_sync_clk;
+	struct clk *tx_l1_sync_clk;
+	bool is_lane_clks_enabled;
+
+	struct ufs_hw_version hw_ver;
+
+	/* Reset control of HCI */
+	struct reset_ctl core_reset;
+
+	u32 hs_gear;
+
+	int esi_base;
+	bool esi_enabled;
+
+	void __iomem *dev_ref_clk_ctrl_mmio;
+	bool is_dev_ref_clk_enabled;
+
+	u32 dev_ref_clk_en_mask;
+};
+
+static inline u32
+ufs_qcom_get_debug_reg_offset(struct ufs_qcom_priv *host, u32 reg)
+{
+	if (host->hw_ver.major <= 0x02)
+		return UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(reg);
+
+	return UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(reg);
+};
+
+#define ufs_qcom_is_link_off(hba) ufshcd_is_link_off(hba)
+#define ufs_qcom_is_link_active(hba) ufshcd_is_link_active(hba)
+#define ufs_qcom_is_link_hibern8(hba) ufshcd_is_link_hibern8(hba)
+
+int ufs_qcom_testbus_config(struct ufs_qcom_priv *host);
+
+static inline bool ufs_qcom_cap_qunipro(struct ufs_qcom_priv *host)
+{
+	return host->caps & UFS_QCOM_CAP_QUNIPRO;
+}
+
+/* ufs-qcom-ice.c */
+
+#ifdef CONFIG_SCSI_UFS_CRYPTO
+int ufs_qcom_ice_init(struct ufs_qcom_priv *host);
+int ufs_qcom_ice_enable(struct ufs_qcom_priv *host);
+int ufs_qcom_ice_resume(struct ufs_qcom_priv *host);
+int ufs_qcom_ice_program_key(struct ufs_hba *hba,
+			     const union ufs_crypto_cfg_entry *cfg, int slot);
+#else
+static inline int ufs_qcom_ice_init(struct ufs_qcom_priv *host)
+{
+	return 0;
+}
+static inline int ufs_qcom_ice_enable(struct ufs_qcom_priv *host)
+{
+	return 0;
+}
+static inline int ufs_qcom_ice_resume(struct ufs_qcom_priv *host)
+{
+	return 0;
+}
+#define ufs_qcom_ice_program_key NULL
+#endif /* !CONFIG_SCSI_UFS_CRYPTO */
+
+#endif /* UFS_QCOM_H_ */
-- 
2.38.1

