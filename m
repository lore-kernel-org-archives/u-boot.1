Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD60CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2427839CA;
	Mon, 27 Oct 2025 18:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T2cTiRJf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HodQgxjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4BF839DE; Mon, 27 Oct 2025 18:07:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138368384E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwKgp5LGRz9tVG;
 Mon, 27 Oct 2025 18:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8KIZERXheCIG3g+OpRLqyLV3EqzzRL+NQcrtBqyWh0=;
 b=T2cTiRJfM3rDD6HatAbNUaxMYZooUnvAX6b3+AxCiji8TCJz+oxFPjtnzUCq/zEd4Y0P4r
 PFzevj4LFakBUAc2KRTwYY3ha/RfXIOrS3best6zFuhBcRMvw+VcaxBx1ZdwJJvljoerJy
 EQQNXTbnjvrQV9161WSt6O1bXMD5HCkXuCbDVMrEHLVX1km3EvTYfqzIVN88P1kRaoeoZX
 CTHyACQjbk8H/gaM4ool0sYh+YNFIXebTOmCJlHKReEes1nM2G4qZYQIiLwTR67dA7ET+C
 SKvmvpwcqiod5/M9CfkVizvEwiX5Qdw0SqkNe4ZVmsNDRvvxz6SXCDVgCCR7ww==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8KIZERXheCIG3g+OpRLqyLV3EqzzRL+NQcrtBqyWh0=;
 b=HodQgxjvVgWPcEJU0eL5vopPfDvDJ7jhW+MgEoXgz9ign8WVnnvJDqQVra/UORflYeh4E9
 WkneqRvEnKAzlPpVLXiYCI5puDn/eRv8Z6G2T0E36sV7PdFz2UuJg86iARTKEfsuuIiBPU
 mtBj6enmHGp6CYfr1ZSmi+HeBLPt9ClTtT5eEt2mr7Rafawbx8MuwzQVKbARYGrCkanP6B
 fqy+5R1+1vYQZWyQTVZlT/4iDqM9xPBS0kH9WGgC8ITGrRagigl4zyGQTRMvPhgDGVeFnY
 tBWh6jVAjaXPXOog8p/ZWBGn7QjRSYfkdf/Y47ei1KK+Zq1tvbp6hH4n7pX1UQ==
To: u-boot@lists.denx.de
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 6/6] ufs: Add UFS driver for Renesas R-Car X5H
Date: Mon, 27 Oct 2025 18:06:27 +0100
Message-ID: <20251027170706.29302-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
References: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5b148mpaqu5jf1ywtffbz75eqgdtoqtc
X-MBO-RS-ID: a666a9746a66fe19af8
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

From: Tuyen Dang <tuyen.dang.xa@renesas.com>

Add UFS driver for UFS controller present on Renesas R-Car X5H R8A78000.
The controller uses different initialization code compared to previous
generation UFS controller present in Renesas R-Car S4 R8A779F0, and the
majority of the driver is the initialization, hence a new driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Tuyen Dang <tuyen.dang.xa@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[Marek: Clean driver up, add SCMI reset handling, use read_poll_timeout(),
        pass error values out of ufs_renesas_pre_init(), change the
	compatible string to "renesas,r8a78000-ufs" to align with
	previous generation "renesas,r8a779f0-ufs"]
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/ufs/Kconfig                 |   9 +
 drivers/ufs/Makefile                |   1 +
 drivers/ufs/ufs-renesas-rcar-gen5.c | 268 ++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 drivers/ufs/ufs-renesas-rcar-gen5.c

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 4c6b08ad31c..363f53a6792 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -56,4 +56,13 @@ config UFS_RENESAS
 	  platform driver. UFS host on Renesas needs some vendor
 	  specific configuration before accessing the hardware.
 
+config UFS_RENESAS_GEN5
+	bool "Renesas R-Car X5H UFS Controller support"
+	depends on UFS
+	select BOUNCE_BUFFER
+	help
+	  This selects the Renesas X5H specific additions to UFSHCD
+	  platform driver. UFS host on Renesas needs some vendor
+	  specific configuration before accessing the hardware.
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 2ac410cf7c3..46866260b7b 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
+obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
diff --git a/drivers/ufs/ufs-renesas-rcar-gen5.c b/drivers/ufs/ufs-renesas-rcar-gen5.c
new file mode 100644
index 00000000000..3c66022579f
--- /dev/null
+++ b/drivers/ufs/ufs-renesas-rcar-gen5.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Renesas UFS host controller driver
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <ufs.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+#include <linux/iopoll.h>
+#include <reset.h>
+
+#include "ufs.h"
+
+#define UFS_RENESAS_TIMEOUT_US		100000
+
+struct ufs_renesas_priv {
+	struct clk_bulk		clks;
+	struct reset_ctl_bulk	resets;
+	fdt_addr_t		phy_base;
+	/* The hardware needs initialization once */
+	bool			initialized;
+};
+
+static void ufs_dme_command(struct ufs_hba *hba, u32 cmd,
+			    u32 arg1, u32 arg2, u32 arg3)
+{
+	ufshcd_writel(hba, arg1, REG_UIC_COMMAND_ARG_1);
+	ufshcd_writel(hba, arg2, REG_UIC_COMMAND_ARG_2);
+	ufshcd_writel(hba, arg3, REG_UIC_COMMAND_ARG_3);
+	ufshcd_writel(hba, cmd, REG_UIC_COMMAND);
+}
+
+static int ufs_renesas_pre_init(struct ufs_hba *hba)
+{
+	struct ufs_renesas_priv *priv = dev_get_priv(hba->dev);
+	u32 val32;
+	u16 val16;
+	int ret;
+
+	writew(0x0001, priv->phy_base + 0x20000);
+	writew(0x005c, priv->phy_base + 0x20212);
+	writew(0x005c, priv->phy_base + 0x20214);
+	writew(0x005c, priv->phy_base + 0x20216);
+	writew(0x005c, priv->phy_base + 0x20218);
+	writew(0x036a, priv->phy_base + 0x201d0);
+	writew(0x0102, priv->phy_base + 0x201d2);
+	writew(0x001f, priv->phy_base + 0x20082);
+	writew(0x000b, priv->phy_base + 0x20084);
+	writew(0x0126, priv->phy_base + 0x201d2);
+	writew(0x01dc, priv->phy_base + 0x20214);
+	writew(0x01dc, priv->phy_base + 0x20218);
+	writew(0x0000, priv->phy_base + 0x201cc);
+	writew(0x0200, priv->phy_base + 0x201ce);
+	writew(0x0000, priv->phy_base + 0x20212);
+	writew(0x0000, priv->phy_base + 0x20216);
+
+	ret = readw_poll_timeout(priv->phy_base + 0x201ec, val16,
+				 !(val16 & BIT(12)), UFS_RENESAS_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = readw_poll_timeout(priv->phy_base + 0x201e4, val16,
+				 !(val16 & BIT(12)), UFS_RENESAS_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = readw_poll_timeout(priv->phy_base + 0x201f0, val16,
+				 !(val16 & BIT(12)), UFS_RENESAS_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	writew(0x0000, priv->phy_base + 0x20000);
+
+	ufshcd_writel(hba, BIT(0), REG_CONTROLLER_ENABLE);
+
+	ret = read_poll_timeout(ufshcd_readl, val32, (val32 & BIT(0)),
+				1, UFS_RENESAS_TIMEOUT_US,
+				hba, REG_CONTROLLER_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = read_poll_timeout(ufshcd_readl, val32, (val32 & BIT(3)),
+				1, UFS_RENESAS_TIMEOUT_US,
+				hba, REG_CONTROLLER_STATUS);
+	if (ret)
+		return ret;
+
+	/* Skip IE because we cannot handle interrupts here */
+	ufs_dme_command(hba, 0x00000002, 0x81010000, 0x00000000, 0x00000005);
+	ufs_dme_command(hba, 0x00000002, 0x81150000, 0x00000000, 0x00000001);
+	ufs_dme_command(hba, 0x00000002, 0x81180000, 0x00000000, 0x00000001);
+	ufs_dme_command(hba, 0x00000002, 0x80090000, 0x00000000, 0x00000000);
+	ufs_dme_command(hba, 0x00000002, 0x800a0000, 0x00000000, 0x000000c8);
+	ufs_dme_command(hba, 0x00000002, 0x80090001, 0x00000000, 0x00000000);
+	ufs_dme_command(hba, 0x00000002, 0x800a0001, 0x00000000, 0x000000c8);
+	ufs_dme_command(hba, 0x00000002, 0x800a0004, 0x00000000, 0x00000000);
+	ufs_dme_command(hba, 0x00000002, 0x800b0004, 0x00000000, 0x00000064);
+	ufs_dme_command(hba, 0x00000002, 0x800a0005, 0x00000000, 0x00000000);
+	ufs_dme_command(hba, 0x00000002, 0x800b0005, 0x00000000, 0x00000064);
+	ufs_dme_command(hba, 0x00000002, 0xd0850000, 0x00000000, 0x00000001);
+
+	writew(0x0001, priv->phy_base + 0x20000);
+
+	clrbits_le16(priv->phy_base + 0x20022, BIT(0));
+
+	ret = readw_poll_timeout(priv->phy_base + (0x00198 << 1), val16,
+				 (val16 & BIT(0)), UFS_RENESAS_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	writew(0x0368, priv->phy_base + 0x201d0);
+
+	ret = readw_poll_timeout(priv->phy_base + 0x201e4, val16,
+				 !(val16 & BIT(11)), UFS_RENESAS_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = readw_poll_timeout(priv->phy_base + 0x201e8, val16,
+				 !(val16 & BIT(11)), UFS_RENESAS_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = readw_poll_timeout(priv->phy_base + 0x201ec, val16,
+				 !(val16 & BIT(11)), UFS_RENESAS_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	ret = readw_poll_timeout(priv->phy_base + 0x201f0, val16,
+				 !(val16 & BIT(11)), UFS_RENESAS_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	priv->initialized = true;
+
+	return 0;
+}
+
+static int ufs_renesas_init(struct ufs_hba *hba)
+{
+	hba->quirks |= UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS | UFSHCD_QUIRK_HIBERN_FASTAUTO |
+		       UFSHCD_QUIRK_BROKEN_LCC;
+
+	return 0;
+}
+
+static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
+					 enum ufs_notify_change_status status)
+{
+	struct ufs_renesas_priv *priv = dev_get_priv(hba->dev);
+	int ret;
+
+	if (priv->initialized)
+		return 0;
+
+	if (status == PRE_CHANGE) {
+		ret = ufs_renesas_pre_init(hba);
+		if (ret)
+			return ret;
+	}
+
+	priv->initialized = true;
+
+	return 0;
+}
+
+static int ufs_renesas_link_startup_notify(struct ufs_hba *hba,
+					   enum ufs_notify_change_status status)
+{
+	if (status == PRE_CHANGE)
+		return ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0);
+
+	return 0;
+}
+
+static int ufs_renesas_get_max_pwr_mode(struct ufs_hba *hba,
+					struct ufs_pwr_mode_info *max_pwr_info)
+{
+	max_pwr_info->info.gear_rx = UFS_HS_G5;
+	max_pwr_info->info.gear_tx = UFS_HS_G5;
+	max_pwr_info->info.pwr_tx = FASTAUTO_MODE;
+	max_pwr_info->info.pwr_rx = FASTAUTO_MODE;
+	max_pwr_info->info.hs_rate = PA_HS_MODE_A;
+
+	max_pwr_info->info.lane_rx = 1;
+	max_pwr_info->info.lane_tx = 1;
+
+	dev_info(hba->dev, "Max HS Gear: %d\n", max_pwr_info->info.gear_rx);
+
+	return 0;
+}
+
+static struct ufs_hba_ops ufs_renesas_vops = {
+	.init			= ufs_renesas_init,
+	.hce_enable_notify	= ufs_renesas_hce_enable_notify,
+	.link_startup_notify	= ufs_renesas_link_startup_notify,
+	.get_max_pwr_mode	= ufs_renesas_get_max_pwr_mode,
+};
+
+static int ufs_renesas_pltfm_probe(struct udevice *dev)
+{
+	struct ufs_renesas_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->phy_base = dev_read_addr_name(dev, "phy");
+	if (priv->phy_base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret < 0)
+		goto err_clk_get;
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret)
+		goto err_clk_enable;
+
+	reset_assert_bulk(&priv->resets);
+	reset_deassert_bulk(&priv->resets);
+
+	ret = ufshcd_probe(dev, &ufs_renesas_vops);
+	if (ret) {
+		dev_err(dev, "ufshcd_probe() failed %d\n", ret);
+		goto err_ufshcd_probe;
+	}
+
+	return 0;
+
+err_ufshcd_probe:
+	reset_assert_bulk(&priv->resets);
+	clk_disable_bulk(&priv->clks);
+err_clk_enable:
+	clk_release_bulk(&priv->clks);
+err_clk_get:
+	reset_release_bulk(&priv->resets);
+	return ret;
+}
+
+static int ufs_renesas_pltfm_remove(struct udevice *dev)
+{
+	struct ufs_renesas_priv *priv = dev_get_priv(dev);
+
+	reset_release_bulk(&priv->resets);
+	clk_disable_bulk(&priv->clks);
+	clk_release_bulk(&priv->clks);
+
+	return 0;
+}
+
+static const struct udevice_id ufs_renesas_pltfm_ids[] = {
+	{ .compatible = "renesas,r8a78000-ufs" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(ufs_renesas) = {
+	.name		= "ufs-renesas-gen5",
+	.id		= UCLASS_UFS,
+	.of_match	= ufs_renesas_pltfm_ids,
+	.probe		= ufs_renesas_pltfm_probe,
+	.remove		= ufs_renesas_pltfm_remove,
+	.priv_auto	= sizeof(struct ufs_renesas_priv),
+};
-- 
2.51.0

