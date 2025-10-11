Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42607CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 19:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492C483A8C;
	Sat, 11 Oct 2025 21:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="Cc5CdP9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E108883AA9; Sat, 11 Oct 2025 21:11:25 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 361B383A97
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 21:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=mentallysanemainliners.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=igor.belwon@mentallysanemainliners.org
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=Cc5CdP9FT71uBJwOaSRDAJxucGg2oqK/+jzy0C26hXg/UHloqDofRvqNLFnjwai1/V/YsaMB5+A8BDouZ8SIbKEmu8hDGKLNZvLyfKGQ6517VVva3t7lEBSMwubkS6P1YfofFOKptYEbUqcfPnJFKQEsjkY7Gaeswri+aa0q8+fsFAkaWrHIz2VswiiyX3xam7qSB5j7gKPO+AZq9fEEam6SJ7mk5qBWLCjRTqf+80+UXB1dWd/b7tAtVVqFTi+xPU7v+rygUIvOb5nHxemA7HOC9+EhVe/zECrC2hskS1QDWPMTLyVXwxh+ujYfnI59VLhrpApdZAW9mEBXf06Q2A==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=Z2RY4VpmNiu2YPh/pe6FFZEUfCirCeW09H0dY9tWGxs=;
 h=Feedback-ID:Received:From:Date:Subject:To; 
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1058243981; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 11 Oct 2025 19:11:03 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Date: Sat, 11 Oct 2025 21:10:06 +0200
Subject: [PATCH 3/4] ufs: Add MediaTek UFS driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-mtk-ufs-uboot-v1-3-a05f991ee150@mentallysanemainliners.org>
References: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
In-Reply-To: <20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Tim Harvey <tharvey@gateworks.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, Simon Glass <sjg@chromium.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 ~postmarketos/upstreaming@lists.sr.ht
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760209846; l=19620;
 i=igor.belwon@mentallysanemainliners.org; s=20250908;
 h=from:subject:message-id; bh=Z2RY4VpmNiu2YPh/pe6FFZEUfCirCeW09H0dY9tWGxs=;
 b=Bu1nwDBLM1tYUnukDjPTnXj6HRXvChPcct+snDT0TTN+1t8OQBvFJIExgJdVbnAznPpvdwmy3
 8LKePQzsgDWA9Xykm1gmF0/vppeChEpw3iveeQI9KwG0alAUpklfMnd
X-Developer-Key: i=igor.belwon@mentallysanemainliners.org; a=ed25519;
 pk=t9Kz6B3jEwJD7YAKcp8XftfEz7SUSlGbrsfFlbrrFwA=
X-Mailman-Approved-At: Sat, 11 Oct 2025 21:17:18 +0200
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

Add the UFS driver for MediaTek platforms.

Loosely based on the Linux driver, this UFS driver can successfully get a
link and R/W access to the UFS chip on the MediaTek MT6878 mobile SoC,
when U-Boot is running as lk, or as the kernel (Secure world access is
not tested)

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 drivers/ufs/Kconfig            |  14 ++
 drivers/ufs/Makefile           |   1 +
 drivers/ufs/ufs-mediatek-sip.h |  56 ++++++
 drivers/ufs/ufs-mediatek.c     | 403 +++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-mediatek.h     | 210 +++++++++++++++++++++
 5 files changed, 684 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index b08ca08b07c0ae6c3288a84769203f52ab58b3b0..19d29bfb83dff8fe319ac2f4478db90502e38f76 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -15,6 +15,20 @@ config CADENCE_UFS
 	  This selects the platform driver for the Cadence UFS host
 	  controller present on present TI's J721e devices.
 
+config UFS_MEDIATEK
+	tristate "MediaTek UFS Host Controller Driver"
+	depends on UFS && ARCH_MEDIATEK
+	select PHY_MTK_UFS
+	help
+	  This selects the MediaTek specific additions to UFSHCD platform driver.
+	  UFS host on Mediatek needs some vendor specific configuration before
+	  accessing the hardware which includes PHY configuration and vendor
+	  specific registers.
+
+	  Select this if you have UFS controller on MediaTek chipset.
+
+	  If unsure, say N.
+
 config UFS_PCI
 	bool "PCI bus based UFS Controller support"
 	depends on PCI && UFS
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 2a378e45111968b09b3194094f679f6c2fb9ded5..b32a3576c59e4b4941cd435071b38aad4da14d98 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
+obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
diff --git a/drivers/ufs/ufs-mediatek-sip.h b/drivers/ufs/ufs-mediatek-sip.h
new file mode 100644
index 0000000000000000000000000000000000000000..6a61f7bac69d65d8b08ca2edce791c38b6406107
--- /dev/null
+++ b/drivers/ufs/ufs-mediatek-sip.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ * Copyright (c) 2025, Igor Belwon <igor.belwon@mentallysanemainliners.org>
+ *
+ * Slimmed down header from Linux: drivers/ufs/host/ufs-mediatek-sip.h
+ */
+
+#ifndef _UFS_MEDIATEK_SIP_H
+#define _UFS_MEDIATEK_SIP_H
+
+#include <linux/arm-smccc.h>
+
+/*
+ * SiP (Slicon Partner) commands
+ */
+#define MTK_SIP_UFS_CONTROL			ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
+								   ARM_SMCCC_SMC_64, \
+								   ARM_SMCCC_OWNER_SIP, 0x276)
+#define UFS_MTK_SIP_DEVICE_RESET		BIT(1)
+#define UFS_MTK_SIP_REF_CLK_NOTIFICATION	BIT(3)
+
+/*
+ * SMC call wrapper function
+ */
+struct ufs_mtk_smc_arg {
+	unsigned long cmd;
+	struct arm_smccc_res *res;
+	unsigned long v1;
+	unsigned long v2;
+	unsigned long v3;
+	unsigned long v4;
+	unsigned long v5;
+	unsigned long v6;
+	unsigned long v7;
+};
+
+static inline void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
+{
+	arm_smccc_smc(MTK_SIP_UFS_CONTROL,
+		      s.cmd,
+		      s.v1, s.v2, s.v3, s.v4, s.v5, s.v6, s.res);
+}
+
+#define ufs_mtk_smc(...) \
+	_ufs_mtk_smc((struct ufs_mtk_smc_arg) {__VA_ARGS__})
+
+/* SIP interface */
+
+#define ufs_mtk_ref_clk_notify(on, stage, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_REF_CLK_NOTIFICATION, &(res), on, stage)
+
+#define ufs_mtk_device_reset_ctrl(high, res) \
+	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, &(res), high)
+
+#endif /* !_UFS_MEDIATEK_SIP_H */
diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
new file mode 100644
index 0000000000000000000000000000000000000000..10e7990d6bbb54fe54b192d2ccaf7a44faeffd05
--- /dev/null
+++ b/drivers/ufs/ufs-mediatek.c
@@ -0,0 +1,403 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, Igor Belwon <igor.belwon@mentallysanemainliners.org>
+ *
+ * Loosely based on Linux driver: drivers/ufs/host/ufs-mediatek.c
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <ufs.h>
+#include <asm/gpio.h>
+#include <reset.h>
+
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+#include "ufs.h"
+#include "ufs-mediatek.h"
+#include "ufs-mediatek-sip.h"
+
+static void ufs_mtk_advertise_quirks(struct ufs_hba *hba)
+{
+	hba->quirks |= UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL |
+				   UFSHCD_QUIRK_MCQ_BROKEN_INTR |
+				   UFSHCD_QUIRK_BROKEN_LSDBS_CAP;
+}
+
+static int ufs_mtk_hce_enable_notify(struct ufs_hba *hba,
+				     enum ufs_notify_change_status status)
+{
+	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
+
+	if (status == PRE_CHANGE) {
+		if (host->caps & UFS_MTK_CAP_DISABLE_AH8) {
+			ufshcd_writel(hba, 0,
+				      REG_AUTO_HIBERNATE_IDLE_TIMER);
+			hba->capabilities &= ~MASK_AUTO_HIBERN8_SUPPORT;
+		}
+
+		/*
+		 * Turn on CLK_CG early to bypass abnormal ERR_CHK signal
+		 * to prevent host hang issue
+		 */
+		ufshcd_writel(hba,
+			      ufshcd_readl(hba, REG_UFS_XOUFS_CTRL) | 0x80,
+			      REG_UFS_XOUFS_CTRL);
+
+		/* DDR_EN setting */
+		if (host->ip_ver >= IP_VER_MT6989) {
+			ufshcd_rmwl(hba, UFS_MASK(0x7FFF, 8),
+				    0x453000, REG_UFS_MMIO_OPT_CTRL_0);
+		}
+	}
+
+	return 0;
+}
+
+static int ufs_mtk_unipro_set_lpm(struct ufs_hba *hba, bool lpm)
+{
+	int ret;
+	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
+
+	ret = ufshcd_dme_set(hba,
+			     UIC_ARG_MIB_SEL(VS_UNIPROPOWERDOWNCONTROL, 0),
+			     lpm ? 1 : 0);
+	if (!ret || !lpm) {
+		/*
+		 * Forcibly set as non-LPM mode if UIC commands is failed
+		 * to use default hba_enable_delay_us value for re-enabling
+		 * the host.
+		 */
+		host->unipro_lpm = lpm;
+	}
+
+	return ret;
+}
+
+static int ufs_mtk_pre_link(struct ufs_hba *hba)
+{
+	int ret;
+	u32 tmp;
+
+	ret = ufs_mtk_unipro_set_lpm(hba, false);
+	if (ret)
+		return ret;
+
+	/*
+	 * Setting PA_Local_TX_LCC_Enable to 0 before link startup
+	 * to make sure that both host and device TX LCC are disabled
+	 * once link startup is completed.
+	 */
+	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0);
+	if (ret)
+		return ret;
+
+	/* disable deep stall */
+	ret = ufshcd_dme_get(hba, UIC_ARG_MIB(VS_SAVEPOWERCONTROL), &tmp);
+	if (ret)
+		return ret;
+
+	tmp &= ~(1 << 6);
+
+	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(VS_SAVEPOWERCONTROL), tmp);
+	if (ret)
+		return ret;
+
+	ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_SCRAMBLING), tmp);
+
+	return ret;
+}
+
+static void ufs_mtk_cfg_unipro_cg(struct ufs_hba *hba, bool enable)
+{
+	u32 tmp;
+
+	if (enable) {
+		ufshcd_dme_get(hba,
+			       UIC_ARG_MIB(VS_SAVEPOWERCONTROL), &tmp);
+		tmp = tmp |
+		      (1 << RX_SYMBOL_CLK_GATE_EN) |
+		      (1 << SYS_CLK_GATE_EN) |
+		      (1 << TX_CLK_GATE_EN);
+		ufshcd_dme_set(hba,
+			       UIC_ARG_MIB(VS_SAVEPOWERCONTROL), tmp);
+
+		ufshcd_dme_get(hba,
+			       UIC_ARG_MIB(VS_DEBUGCLOCKENABLE), &tmp);
+		tmp = tmp & ~(1 << TX_SYMBOL_CLK_REQ_FORCE);
+		ufshcd_dme_set(hba,
+			       UIC_ARG_MIB(VS_DEBUGCLOCKENABLE), tmp);
+	} else {
+		ufshcd_dme_get(hba,
+			       UIC_ARG_MIB(VS_SAVEPOWERCONTROL), &tmp);
+		tmp = tmp & ~((1 << RX_SYMBOL_CLK_GATE_EN) |
+			     (1 << SYS_CLK_GATE_EN) |
+			     (1 << TX_CLK_GATE_EN));
+		ufshcd_dme_set(hba,
+			       UIC_ARG_MIB(VS_SAVEPOWERCONTROL), tmp);
+
+		ufshcd_dme_get(hba,
+			       UIC_ARG_MIB(VS_DEBUGCLOCKENABLE), &tmp);
+		tmp = tmp | (1 << TX_SYMBOL_CLK_REQ_FORCE);
+		ufshcd_dme_set(hba,
+			       UIC_ARG_MIB(VS_DEBUGCLOCKENABLE), tmp);
+	}
+}
+
+static void ufs_mtk_post_link(struct ufs_hba *hba)
+{
+	/* enable unipro clock gating feature */
+	ufs_mtk_cfg_unipro_cg(hba, true);
+}
+
+static int ufs_mtk_link_startup_notify(struct ufs_hba *hba,
+				       enum ufs_notify_change_status status)
+{
+	int ret = 0;
+
+	switch (status) {
+	case PRE_CHANGE:
+			ret = ufs_mtk_pre_link(hba);
+			break;
+	case POST_CHANGE:
+			ufs_mtk_post_link(hba);
+			break;
+	default:
+			ret = -EINVAL;
+			break;
+	}
+
+	return ret;
+}
+
+static int ufs_mtk_bind_mphy(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
+	int err = 0;
+
+	err = generic_phy_get_by_index(hba->dev, 0, host->mphy);
+
+	if (IS_ERR(host->mphy)) {
+		err = PTR_ERR(host->mphy);
+		if (err != -ENODEV) {
+			dev_info(hba->dev, "%s: Could NOT get a valid PHY %d\n", __func__,
+				 err);
+		}
+	}
+
+	if (err)
+		host->mphy = NULL;
+
+	return err;
+}
+
+static void ufs_mtk_init_reset_control(struct ufs_hba *hba,
+				       struct reset_ctl **rc,
+				       char *str)
+{
+	*rc = devm_reset_control_get(hba->dev, str);
+	if (IS_ERR(*rc)) {
+		dev_info(hba->dev, "Failed to get reset control %s: %ld\n",
+			 str, PTR_ERR(*rc));
+		*rc = NULL;
+	}
+}
+
+static void ufs_mtk_init_reset(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
+
+	ufs_mtk_init_reset_control(hba, &host->hci_reset,
+				   "hci_rst");
+	ufs_mtk_init_reset_control(hba, &host->unipro_reset,
+				   "unipro_rst");
+	ufs_mtk_init_reset_control(hba, &host->crypto_reset,
+				   "crypto_rst");
+}
+
+static void ufs_mtk_get_hw_ip_version(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
+	u32 hw_ip_ver;
+
+	hw_ip_ver = ufshcd_readl(hba, REG_UFS_MTK_IP_VER);
+
+	if (((hw_ip_ver & (0xFF << 24)) == (0x1 << 24)) ||
+	    ((hw_ip_ver & (0xFF << 24)) == 0)) {
+		hw_ip_ver &= ~(0xFF << 24);
+		hw_ip_ver |= (0x1 << 28);
+	}
+
+	host->ip_ver = hw_ip_ver;
+
+	dev_info(hba->dev, "MediaTek UFS IP Version: 0x%x\n", hw_ip_ver);
+}
+
+static int ufs_mtk_setup_ref_clk(struct ufs_hba *hba, bool on)
+{
+	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
+	struct arm_smccc_res res;
+	int timeout, time_checked = 0;
+	u32 value;
+
+	if (host->ref_clk_enabled == on)
+		return 0;
+
+	ufs_mtk_ref_clk_notify(on, PRE_CHANGE, res);
+
+	if (on) {
+		ufshcd_writel(hba, REFCLK_REQUEST, REG_UFS_REFCLK_CTRL);
+	} else {
+		udelay(10);
+		ufshcd_writel(hba, REFCLK_RELEASE, REG_UFS_REFCLK_CTRL);
+	}
+
+	/* Wait for ack */
+	timeout = REFCLK_REQ_TIMEOUT_US;
+	do {
+		value = ufshcd_readl(hba, REG_UFS_REFCLK_CTRL);
+
+		/* Wait until ack bit equals to req bit */
+		if (((value & REFCLK_ACK) >> 1) == (value & REFCLK_REQUEST))
+			goto out;
+
+		udelay(200);
+		time_checked += 200;
+	} while (time_checked != timeout);
+
+	dev_err(hba->dev, "missing ack of refclk req, reg: 0x%x\n", value);
+
+	/*
+	 * If clock on timeout, assume clock is off, notify tfa do clock
+	 * off setting.(keep DIFN disable, release resource)
+	 * If clock off timeout, assume clock will off finally,
+	 * set ref_clk_enabled directly.(keep DIFN disable, keep resource)
+	 */
+	if (on)
+		ufs_mtk_ref_clk_notify(false, POST_CHANGE, res);
+	else
+		host->ref_clk_enabled = false;
+
+	return -ETIMEDOUT;
+
+out:
+	host->ref_clk_enabled = on;
+	if (on)
+		udelay(10);
+
+	ufs_mtk_ref_clk_notify(on, POST_CHANGE, res);
+
+	return 0;
+}
+
+/**
+ * ufs_mtk_init - bind phy with controller
+ * @hba: host controller instance
+ *
+ * Powers up PHY enabling clocks and regulators.
+ *
+ * Returns -ENODEV if binding fails, returns negative error
+ * on phy power up failure and returns zero on success.
+ */
+static int ufs_mtk_init(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *priv = dev_get_priv(hba->dev);
+	int err;
+
+	priv->hba = hba;
+
+	err = ufs_mtk_bind_mphy(hba);
+	if (err)
+		return -ENODEV;
+
+	ufs_mtk_advertise_quirks(hba);
+
+	ufs_mtk_init_reset(hba);
+
+	// TODO: Clocking
+
+	err = generic_phy_power_on(priv->mphy);
+	if (err) {
+		dev_err(hba->dev, "%s: phy init failed, err = %d\n",
+			__func__, err);
+		return err;
+	}
+
+	ufs_mtk_setup_ref_clk(hba, true);
+	ufs_mtk_get_hw_ip_version(hba);
+
+	return 0;
+}
+
+static int ufs_mtk_device_reset(struct ufs_hba *hba)
+{
+	struct arm_smccc_res res;
+
+	ufs_mtk_device_reset_ctrl(0, res);
+
+	/*
+	 * The reset signal is active low. UFS devices shall detect
+	 * more than or equal to 1us of positive or negative RST_n
+	 * pulse width.
+	 *
+	 * To be on safe side, keep the reset low for at least 10us.
+	 */
+	udelay(13);
+
+	ufs_mtk_device_reset_ctrl(1, res);
+
+	/* Some devices may need time to respond to rst_n */
+	mdelay(13);
+
+	dev_dbg(hba->dev, "device reset done\n");
+
+	return 0;
+}
+
+static struct ufs_hba_ops ufs_mtk_hba_ops = {
+	.init			= ufs_mtk_init,
+	.hce_enable_notify	= ufs_mtk_hce_enable_notify,
+	.link_startup_notify	= ufs_mtk_link_startup_notify,
+	.device_reset		= ufs_mtk_device_reset,
+};
+
+static int ufs_mtk_probe(struct udevice *dev)
+{
+	int ret;
+
+	ret = ufshcd_probe(dev, &ufs_mtk_hba_ops);
+	if (ret) {
+		dev_err(dev, "ufshcd_probe() failed, ret:%d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ufs_mtk_bind(struct udevice *dev)
+{
+	struct udevice *scsi_dev;
+
+	return ufs_scsi_bind(dev, &scsi_dev);
+}
+
+static const struct udevice_id ufs_mtk_ids[] = {
+	{ .compatible = "mediatek,mt6878-ufshci" },
+	{},
+};
+
+U_BOOT_DRIVER(mediatek_ufshci) = {
+	.name		= "mediatek-ufshci",
+	.id		= UCLASS_UFS,
+	.of_match	= ufs_mtk_ids,
+	.probe		= ufs_mtk_probe,
+	.bind		= ufs_mtk_bind,
+	.priv_auto	= sizeof(struct ufs_mtk_host),
+};
diff --git a/drivers/ufs/ufs-mediatek.h b/drivers/ufs/ufs-mediatek.h
new file mode 100644
index 0000000000000000000000000000000000000000..11a83d34c5b93ce173575eb8bee895f6f70af2d6
--- /dev/null
+++ b/drivers/ufs/ufs-mediatek.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 MediaTek Inc.
+ * Copyright (c) 2025, Igor Belwon <igor.belwon@mentallysanemainliners.org>
+ *
+ * Slimmed down header from Linux: drivers/ufs/host/ufs-mediatek.h
+ */
+
+#ifndef _UFS_MEDIATEK_H
+#define _UFS_MEDIATEK_H
+
+#include <clk.h>
+#include <linux/bitops.h>
+
+/*
+ * MCQ define and struct
+ */
+#define UFSHCD_MAX_Q_NR 8
+#define MTK_MCQ_INVALID_IRQ	0xFFFF
+
+/* REG_UFS_MMIO_OPT_CTRL_0 160h */
+#define EHS_EN                  BIT(0)
+#define PFM_IMPV                BIT(1)
+#define MCQ_MULTI_INTR_EN       BIT(2)
+#define MCQ_CMB_INTR_EN         BIT(3)
+#define MCQ_AH8                 BIT(4)
+
+#define MCQ_INTR_EN_MSK         (MCQ_MULTI_INTR_EN | MCQ_CMB_INTR_EN)
+
+/*
+ * Vendor specific UFSHCI Registers
+ */
+#define REG_UFS_XOUFS_CTRL          0x140
+#define REG_UFS_REFCLK_CTRL         0x144
+#define REG_UFS_MMIO_OPT_CTRL_0     0x160
+#define REG_UFS_EXTREG              0x2100
+#define REG_UFS_MPHYCTRL            0x2200
+#define REG_UFS_MTK_IP_VER          0x2240
+#define REG_UFS_REJECT_MON          0x22AC
+#define REG_UFS_DEBUG_SEL           0x22C0
+#define REG_UFS_PROBE               0x22C8
+#define REG_UFS_DEBUG_SEL_B0        0x22D0
+#define REG_UFS_DEBUG_SEL_B1        0x22D4
+#define REG_UFS_DEBUG_SEL_B2        0x22D8
+#define REG_UFS_DEBUG_SEL_B3        0x22DC
+
+#define REG_UFS_MTK_SQD             0x2800
+#define REG_UFS_MTK_SQIS            0x2814
+#define REG_UFS_MTK_CQD             0x281C
+#define REG_UFS_MTK_CQIS            0x2824
+
+#define REG_UFS_MCQ_STRIDE          0x30
+
+/*
+ * Ref-clk control
+ *
+ * Values for register REG_UFS_REFCLK_CTRL
+ */
+#define REFCLK_RELEASE              0x0
+#define REFCLK_REQUEST              BIT(0)
+#define REFCLK_ACK                  BIT(1)
+
+#define REFCLK_REQ_TIMEOUT_US       3000
+#define REFCLK_DEFAULT_WAIT_US      32
+
+/*
+ * Other attributes
+ */
+#define VS_DEBUGCLOCKENABLE         0xD0A1
+#define VS_SAVEPOWERCONTROL         0xD0A6
+#define VS_UNIPROPOWERDOWNCONTROL   0xD0A8
+
+/*
+ * Vendor specific link state
+ */
+enum {
+	VS_LINK_DISABLED            = 0,
+	VS_LINK_DOWN                = 1,
+	VS_LINK_UP                  = 2,
+	VS_LINK_HIBERN8             = 3,
+	VS_LINK_LOST                = 4,
+	VS_LINK_CFG                 = 5,
+};
+
+/*
+ * Vendor specific host controller state
+ */
+enum {
+	VS_HCE_RESET                = 0,
+	VS_HCE_BASE                 = 1,
+	VS_HCE_OOCPR_WAIT           = 2,
+	VS_HCE_DME_RESET            = 3,
+	VS_HCE_MIDDLE               = 4,
+	VS_HCE_DME_ENABLE           = 5,
+	VS_HCE_DEFAULTS             = 6,
+	VS_HIB_IDLEEN               = 7,
+	VS_HIB_ENTER                = 8,
+	VS_HIB_ENTER_CONF           = 9,
+	VS_HIB_MIDDLE               = 10,
+	VS_HIB_WAITTIMER            = 11,
+	VS_HIB_EXIT_CONF            = 12,
+	VS_HIB_EXIT                 = 13,
+};
+
+/*
+ * VS_DEBUGCLOCKENABLE
+ */
+enum {
+	TX_SYMBOL_CLK_REQ_FORCE = 5,
+};
+
+/*
+ * VS_SAVEPOWERCONTROL
+ */
+enum {
+	RX_SYMBOL_CLK_GATE_EN   = 0,
+	SYS_CLK_GATE_EN         = 2,
+	TX_CLK_GATE_EN          = 3,
+};
+
+/*
+ * Host capability
+ */
+enum ufs_mtk_host_caps {
+	UFS_MTK_CAP_BOOST_CRYPT_ENGINE         = 1 << 0,
+	UFS_MTK_CAP_VA09_PWR_CTRL              = 1 << 1,
+	UFS_MTK_CAP_DISABLE_AH8                = 1 << 2,
+	UFS_MTK_CAP_BROKEN_VCC                 = 1 << 3,
+
+	/*
+	 * Override UFS_MTK_CAP_BROKEN_VCC's behavior to
+	 * allow vccqx upstream to enter LPM
+	 */
+	UFS_MTK_CAP_ALLOW_VCCQX_LPM            = 1 << 5,
+	UFS_MTK_CAP_PMC_VIA_FASTAUTO           = 1 << 6,
+	UFS_MTK_CAP_TX_SKEW_FIX                = 1 << 7,
+	UFS_MTK_CAP_DISABLE_MCQ                = 1 << 8,
+	/* Control MTCMOS with RTFF */
+	UFS_MTK_CAP_RTFF_MTCMOS                = 1 << 9,
+
+	UFS_MTK_CAP_MCQ_BROKEN_RTC             = 1 << 10,
+};
+
+struct ufs_mtk_hw_ver {
+	u8 step;
+	u8 minor;
+	u8 major;
+};
+
+struct ufs_mtk_mcq_intr_info {
+	struct ufs_hba *hba;
+	u32 irq;
+	u8 qid;
+};
+
+struct ufs_mtk_host {
+	struct phy *mphy;
+	struct reset_ctl *unipro_reset;
+	struct reset_ctl *crypto_reset;
+	struct reset_ctl *hci_reset;
+	struct ufs_hba *hba;
+	struct ufs_mtk_crypt_cfg *crypt;
+	struct clk_bulk clks;
+	struct ufs_mtk_hw_ver hw_ver;
+	enum ufs_mtk_host_caps caps;
+	bool mphy_powered_on;
+	bool unipro_lpm;
+	bool ref_clk_enabled;
+	bool is_clks_enabled;
+	u16 ref_clk_ungating_wait_us;
+	u16 ref_clk_gating_wait_us;
+	u32 ip_ver;
+	bool legacy_ip_ver;
+
+	bool mcq_set_intr;
+	bool is_mcq_intr_enabled;
+	int mcq_nr_intr;
+	struct ufs_mtk_mcq_intr_info mcq_intr_info[UFSHCD_MAX_Q_NR];
+};
+
+/* MTK delay of autosuspend: 500 ms */
+#define MTK_RPM_AUTOSUSPEND_DELAY_MS 500
+
+/* MTK RTT support number */
+#define MTK_MAX_NUM_RTT 2
+
+/* UFSHCI MTK ip version value */
+enum {
+	/* UFSHCI 3.1 */
+	IP_VER_MT6983    = 0x10360000,
+	IP_VER_MT6878    = 0x10420200,
+
+	/* UFSHCI 4.0 */
+	IP_VER_MT6897    = 0x10440000,
+	IP_VER_MT6989    = 0x10450000,
+	IP_VER_MT6899    = 0x10450100,
+	IP_VER_MT6991_A0 = 0x10460000,
+	IP_VER_MT6991_B0 = 0x10470000,
+	IP_VER_MT6993    = 0x10480000,
+
+	IP_VER_NONE      = 0xFFFFFFFF
+};
+
+enum ip_ver_legacy {
+	IP_LEGACY_VER_MT6781 = 0x10380000,
+	IP_LEGACY_VER_MT6879 = 0x10360000,
+	IP_LEGACY_VER_MT6893 = 0x20160706
+};
+
+#endif /* !_UFS_MEDIATEK_H */

-- 
2.51.0

