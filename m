Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3AEC9830D
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 01:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B96C860B51;
	Thu, 24 Sep 2026 01:53:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtvfFSy1LN17; Thu, 24 Sep 2026 01:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 47D2460B2C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790214832;
	b=HPT321T+opoycPNey1u/i8O0+KENJ1wK4pEJJqbfF3GhG407PEaExfzD82reHYowUtGZ
	 fKZtJHq0rcqZ4Bpw3fACq5o+MaJMQzQz0R86STBIb5zDy4DMzZnfWx/NSbUUC2dWbQSSV
	 hOYIt7UmxUhwnNYVsatV529VM2JMWoTvw9Vz5/+wtjx4SlVJBoJfjT0Or+VgSI4xGkfl/
	 g16RVarKTEpw+pKx2oScP03Hz2/gBzK5ZmMGANAsmSyq441+3kCA1AUIFZC8GBYv+7hvE
	 2OcGjq6kiE42QXVZXetpcKcpV3sJGWFWnhcvBE07lMANuSqs29DpC9+GDL821VBR34w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790214832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dZlIFEDHPKdL9PJPbZu3FYOCjSt8ctlEv5NHzY+yLoQ=;
	b=Xg2XUXAILNKkXjPSmJ9lJHocrvnsMlm0ReKalrn9LW82XzdeFIMMMrD5QLuURqIVDQ2L
	 jUh4bqZokzgieyJ9klq2nkLXCx/bzOC998YjE49deF8lqBbzHNUoPVsewjPMpSKHQ5dAS
	 a89AoOvG+LdyR/Yr/FoGMzkQP0pBxhhFWvxRaAUAlXbGr/DOf20P/ZNO+wKSeWJW25sb6
	 5OHIoNFf0YH6AnLJ48uwAyT5SZw0MFYuvHZntp4HN8UIpxWqpT03vN1FtIaQVNB8nUYW2
	 Gd8pZ9iQNNp/yo6jXDm/vJE2UE1AuawkCZT/+D3vbHvtlthbUqNCwonwXnp0aqPun3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790214832;
	bh=dZlIFEDHPKdL9PJPbZu3FYOCjSt8ctlEv5NHzY+yLoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PM6lRMqNAmxeeVptfFBdhz7hYqB6sjBLu9tgq96mApIDKP928arH3OAifOcOjEZfP
	 Tk69TZqUFqjOJ09H2Hr5RG7Od+LXa2cHEUXHAt0X+RUM5sgU0gnrPWFrFdGHr0Aeh8
	 evQDuLrS0+O5kyzH09soG+5u5xdvLGE9XipbG84j0vmdLjSW01FNtZSFX1pPEu2mPR
	 xrUXoFC1tPa6IqN26CmL0f/RcottQM5BZprwUqK3TRKjGX417SaU6PbbHoLIY1fj1S
	 P12xoTyod91u2lTLhVzU+FtrLFW3DU8xcA+xKfwfssUEhZyU38PN8RxgBx2dMIx8lm
	 No8dgitWXvDjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47D2460B2C;
	Thu, 24 Sep 2026 01:53:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 34175194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19A16813AC
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sYR8yjsY7AUt for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 01:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 176E181A30
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790214830;
 b=chxYNB8hdXiAHJzHsrp+X/XQgvtz8CUoyEJbDZTImci1Pjqkq2bjy7mBHCXdX5lzT14I
 YGXEkMqenFfA0LXKHq8DEahFEB5aDfTlhN6chg4zNgGYe7Yxj2PO5IKnlMfQrZTJBTuzW
 QDV5Cp5iZxDStbo0KtYynatGxYQMCSquPsBtdgcAfiBnSkgk9nUZczKDGqE1k9ROG4ddY
 4l93pgLwCR6j26zrMTs3nDu8xPWdbm19fyZI2cBhDTj9dWTRdLgGWpIUzOhCrn/ppBq8M
 6WrvSMhTSv5Gks8U1zLSKVR/hFbfwmisr5vtxnzvJ08PHXkjNd7LhHGtB4VQRFD/JkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790214830;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=dZlIFEDHPKdL9PJPbZu3FYOCjSt8ctlEv5NHzY+yLoQ=;
 b=KMYleanQTODSwxqHMTwbSUPf156Dp6VawLeC6VjuFQmAb2RX/LJ8isCPJP2aBhbJ/3Ua
 NbrHDq50VK6V1cYZZPF6MR1QmUTjAy4rFOUtiNNAd8ZtVNk1g3fwICltYjBPo+77qx5sq
 luDIr5GBYlT+74XZgRPA0oTg3DdjG1tRfFEq4VeAVmGW8ULQ/vJyC4Sh8w+9qjqto4IEH
 +Cu8mYFnxnpYM8queozv2YBMfqFa6u7Om/y4cvpdmXbI8Ez4dr3GgFYrDmm4m+vsVs6Et
 ZifDiQI/iwuVZJI3MlgDhXw03JhHOH/1vJP+UqtjS/x1EiQCNP0E+AA9CaWd4QEjDGQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jUL74spD; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jUL74spD
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 176E181A30
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8580B43A38;
 Thu, 24 Sep 2026 01:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550371F00893;
 Thu, 24 Sep 2026 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790214829;
 bh=dZlIFEDHPKdL9PJPbZu3FYOCjSt8ctlEv5NHzY+yLoQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jUL74spDfC052YqJUXsIiCZKFGs5rS+65XBQv0prLGBbBB9WEF9Hycp+45MZRl/vI
 7NMfgMGQaaMqxrR0+vjvf1UIJjOiAf4vkVQIpxCBZjdhB2lFNYuYdLY5daEv8KbUld
 FS4e0LOrt7F3kqLVb8t9UkS2d8rZe7LsXCK2iRw9kBs1OyDSDHHauQ0vVVrU45eB09
 j7LQt1+f4+AWpatF6jsEC2sIuFma3g4AQtFrx2SMjcdWI6NrOLFgB0L66bd7/IgTwE
 wVJyfMaihtyGUHpWAKEt5uSTetIJqx4sH+AQZOjU1WUkyDuereXEpagDI9dkP6jbVf
 KYsG/XX4WYIlw==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 24 Sep 2026 01:53:29 +0000
Subject: [PATCH 1/2] net: dwc_eth_qos: spacemit: add support for K3 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-02-k3-ethernet-support-v1-1-b8e1fafc9249@kernel.org>
References: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
In-Reply-To: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11739; i=dlan@kernel.org;
 h=from:subject:message-id; bh=LGDFvkW95+7VfRssljkfyDkS8QrQBKSmXE3hP9mPmNg=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqtIKhSKMllkXdljbaasJmd3Z/B0AMy2LBcaZ02
 wUP7iNy55+JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarSCoRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3cMBAAjusxLZ7IIVX//dGfjh9h54amglMlDRW9iHoKQ+e5T3H+ARFM5G4B/
 Q2keWhATmT+FIOjkWBeYsMKL3wK8jK2Rc51a8R84Q++Uo9cKIX8bEDZcWQQlMTD+MtNpfvMvwUw
 kAlHVSq/yh4nMP8Kbqn9HYT6Fvngfe4rfEgZH2vik1TMKRt44J/0HWdtOl+hvzkPeLMSLi9c/2j
 82KXYE7KjGwpqUzdp//V1eav2yTcx++9K2HPYdxezR4XwzXXWF2cEzj6VHPPJxzeEKfk3B0i2cw
 S103Z2eYYrJdu3NH+EKwblozBKcBBQPyWbLcz62GMY3hGX745gbAhWSZDXSozvRczR36Nqnik5V
 tOX6ARa134x2gvPIcDZqZCIowVnmtLkz4ysCt9YUkI2GhC+SPKNUGJQiN+EXYjWW5wmls2Nf3hk
 vu1Q4NQf0HxD8z356kwZXXKsMZq5kb++o2hgeMnMmv8xUlxJwYPf1/TgF9SJkqd73c4oZm/iMH5
 uXG0Ik/PSmjYQUov+Djs7WOZcoYvp59CgZnS1BXCusKUpAodZhK+M4QLxnXr7unPiH1UZ7MNILg
 HPwxVOOjpwmVpTXKGE9UEAXViOYh2Z98eCFmcxdV1wUDihl2XGe99NqU9yUNSMu2DueZmA7T2tM
 VfLTo6TVMBVPWkgKifLK7T3aFbg2RY=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

The SpacemiT K3 integrates a Synopsys DWMAC 5.40a Ethernet controller.
Add the platform glue for selecting the MII, RMII or RGMII interface,
configuring the internal RGMII delay lines through the APMU, and
managing the controller clocks and reset.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/net/Kconfig                |   8 +
 drivers/net/Makefile               |   1 +
 drivers/net/dwc_eth_qos.c          |   6 +
 drivers/net/dwc_eth_qos.h          |   1 +
 drivers/net/dwc_eth_qos_spacemit.c | 313 +++++++++++++++++++++++++++++++++++++
 5 files changed, 329 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index faa08e9ebba..300ca761311 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -275,6 +275,14 @@ config DWC_ETH_QOS_STARFIVE
 	  The Synopsys Designware Ethernet QOS IP block with specific
 	  configuration used in STARFIVE  JH7110 soc.
 
+config DWC_ETH_QOS_SPACEMIT
+	bool "Synopsys DWC Ethernet QOS device support for SpacemiT"
+	depends on DWC_ETH_QOS && TARGET_SPACEMIT_K3
+	select DM_ETH_PHY
+	help
+	  The Synopsys Designware Ethernet QOS (DWMAC 5.40a) IP block with
+	  SpacemiT K3 APMU PHY interface and RGMII delay configuration.
+
 config DWC_ETH_QOS_STM32
 	bool "Synopsys DWC Ethernet QOS device support for STM32"
 	depends on DWC_ETH_QOS && ARCH_STM32MP
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4c1f4094ab2..3638d6ff792 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_DWC_ETH_QOS_MTK) += dwc_eth_qos_mtk.o
 obj-$(CONFIG_DWC_ETH_QOS_QCOM) += dwc_eth_qos_qcom.o
 obj-$(CONFIG_DWC_ETH_QOS_ROCKCHIP) += dwc_eth_qos_rockchip.o
 obj-$(CONFIG_DWC_ETH_QOS_STARFIVE) += dwc_eth_qos_starfive.o
+obj-$(CONFIG_DWC_ETH_QOS_SPACEMIT) += dwc_eth_qos_spacemit.o
 obj-$(CONFIG_DWC_ETH_QOS_STM32) += dwc_eth_qos_stm32.o
 obj-$(CONFIG_DWC_ETH_QOS_SUNXI) += dwc_eth_qos_sunxi.o
 obj-$(CONFIG_DWC_ETH_XGMAC) += dwc_eth_xgmac.o
diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index bf590421324..8de7e4686cf 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1674,6 +1674,12 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "allwinner,sun55i-a523-gmac200",
 		.data = (ulong)&eqos_sunxi_config
 	},
+#endif
+#if IS_ENABLED(CONFIG_DWC_ETH_QOS_SPACEMIT)
+	{
+		.compatible = "spacemit,k3-dwmac",
+		.data = (ulong)&eqos_spacemit_config
+	},
 #endif
 	{ }
 };
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index ccb3c3a1453..ef07660a765 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -319,3 +319,4 @@ extern struct eqos_config eqos_jh7110_config;
 extern struct eqos_config eqos_adi_config;
 extern struct eqos_config eqos_mtk_config;
 extern struct eqos_config eqos_sunxi_config;
+extern struct eqos_config eqos_spacemit_config;
diff --git a/drivers/net/dwc_eth_qos_spacemit.c b/drivers/net/dwc_eth_qos_spacemit.c
new file mode 100644
index 00000000000..3003560f638
--- /dev/null
+++ b/drivers/net/dwc_eth_qos_spacemit.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SpacemiT DWMAC / DWC EQOS platform glue
+ *
+ * Based on Linux dwmac-spacemit.c driver:
+ *   Copyright (C) 2026 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <log.h>
+#include <net.h>
+#include <phy.h>
+#include <regmap.h>
+#include <reset.h>
+
+#include "dwc_eth_qos.h"
+
+/* ctrl register bits */
+#define CTRL_PHY_INTF_MODE		GENMASK(4, 3)
+#define CTRL_PHY_INTF_RMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 0)
+#define CTRL_PHY_INTF_RGMII		FIELD_PREP(CTRL_PHY_INTF_MODE, 1)
+#define CTRL_PHY_INTF_MII		FIELD_PREP(CTRL_PHY_INTF_MODE, 3)
+
+/* dline register bits */
+#define RGMII_RX_DLINE_EN		BIT(0)
+#define RGMII_RX_DLINE_STEP		GENMASK(5, 4)
+#define RGMII_RX_DLINE_CODE		GENMASK(15, 8)
+#define RGMII_TX_DLINE_EN		BIT(16)
+#define RGMII_TX_DLINE_STEP		GENMASK(21, 20)
+#define RGMII_TX_DLINE_CODE		GENMASK(31, 24)
+
+#define MAX_WORKED_DELAY		2800
+/* Note: the delay step value is at 0.1ps */
+#define K3_DELAY_STEP			367
+
+struct spacemit_dwmac {
+	struct regmap *apmu;
+	unsigned int ctrl_offset;
+	unsigned int dline_offset;
+	struct clk_bulk clks;
+};
+
+static int spacemit_dwmac_set_delay(struct spacemit_dwmac *dwmac,
+				    unsigned int tx_code, unsigned int rx_code)
+{
+	unsigned int mask, val;
+
+	mask = RGMII_TX_DLINE_STEP | RGMII_TX_DLINE_CODE | RGMII_TX_DLINE_EN |
+	       RGMII_RX_DLINE_STEP | RGMII_RX_DLINE_CODE | RGMII_RX_DLINE_EN;
+
+	/*
+	 * Since the delay step provided by config 0 is small enough, and
+	 * it can cover the range of the valid delay, so there is no needed
+	 * to use other step config.
+	 */
+	val = FIELD_PREP(RGMII_TX_DLINE_STEP, 0) |
+	      FIELD_PREP(RGMII_TX_DLINE_CODE, tx_code) | RGMII_TX_DLINE_EN |
+	      FIELD_PREP(RGMII_RX_DLINE_STEP, 0) |
+	      FIELD_PREP(RGMII_RX_DLINE_CODE, rx_code) | RGMII_RX_DLINE_EN;
+
+	return regmap_update_bits(dwmac->apmu, dwmac->dline_offset, mask, val);
+}
+
+static int spacemit_dwmac_detected_delay_value(unsigned int delay)
+{
+	if (delay == 0)
+		return 0;
+
+	if (delay > MAX_WORKED_DELAY)
+		return -EINVAL;
+
+	/*
+	 * Note K3 require a specific factor for calculate
+	 * the delay, in this scenario it is 0.9. So the
+	 * formula is code * step / 10 * 0.9
+	 */
+	return DIV_ROUND_CLOSEST(delay * 10 * 10, K3_DELAY_STEP * 9);
+}
+
+static int spacemit_dwmac_fix_delay(struct spacemit_dwmac *dwmac,
+				    unsigned int tx_delay,
+				    unsigned int rx_delay)
+{
+	int rx_code;
+	int tx_code;
+
+	rx_code = spacemit_dwmac_detected_delay_value(rx_delay);
+	if (rx_code < 0)
+		return rx_code;
+
+	tx_code = spacemit_dwmac_detected_delay_value(tx_delay);
+	if (tx_code < 0)
+		return tx_code;
+
+	return spacemit_dwmac_set_delay(dwmac, tx_code, rx_code);
+}
+
+static int spacemit_set_phy_intf_sel(struct spacemit_dwmac *dwmac,
+				     phy_interface_t interface)
+{
+	unsigned int mask = CTRL_PHY_INTF_MODE;
+	unsigned int val;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
+		val = CTRL_PHY_INTF_MII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val = CTRL_PHY_INTF_RMII;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = CTRL_PHY_INTF_RGMII;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(dwmac->apmu, dwmac->ctrl_offset, mask, val);
+}
+
+static int eqos_start_clks_spacemit(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct spacemit_dwmac *dwmac = pdata->priv_pdata;
+	ulong rate;
+	int ret;
+
+	ret = clk_enable_bulk(&dwmac->clks);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(&eqos->clk_master_bus);
+	if (!rate) {
+		pr_err("stmmaceth rate is 0 (AXI/bus clock not running?)\n");
+		clk_disable_bulk(&dwmac->clks);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int eqos_stop_clks_spacemit(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct spacemit_dwmac *dwmac = pdata->priv_pdata;
+
+	return clk_disable_bulk(&dwmac->clks);
+}
+
+static int eqos_start_resets_spacemit(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct spacemit_dwmac *dwmac = pdata->priv_pdata;
+	int ret;
+
+	ret = reset_deassert(&eqos->reset_ctl);
+	if (ret)
+		return ret;
+
+	udelay(100);
+
+	return spacemit_set_phy_intf_sel(dwmac, pdata->phy_interface);
+}
+
+static int eqos_stop_resets_spacemit(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	return reset_assert(&eqos->reset_ctl);
+}
+
+static int eqos_remove_resources_spacemit(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct spacemit_dwmac *dwmac = pdata->priv_pdata;
+
+	if (!dwmac)
+		return 0;
+
+	reset_free(&eqos->reset_ctl);
+	if (dwmac->apmu)
+		regmap_uninit(dwmac->apmu);
+	free(dwmac);
+	pdata->priv_pdata = NULL;
+
+	return 0;
+}
+
+static ulong eqos_get_tick_clk_rate_spacemit(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	return clk_get_rate(&eqos->clk_master_bus);
+}
+
+static int eqos_probe_resources_spacemit(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct ofnode_phandle_args args;
+	struct spacemit_dwmac *dwmac;
+	u32 rx_delay = 0;
+	u32 tx_delay = 0;
+	int ret;
+
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		pr_err("eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
+	dwmac = calloc(1, sizeof(*dwmac));
+	if (!dwmac)
+		return -ENOMEM;
+
+	pdata->priv_pdata = dwmac;
+
+	pdata->phy_interface = eqos->config->interface(dev);
+	if (pdata->phy_interface == PHY_INTERFACE_MODE_NA) {
+		pr_err("Invalid PHY interface\n");
+		return -EINVAL;
+	}
+
+	ret = dev_read_phandle_with_args(dev, "spacemit,apmu", NULL, 2, 0,
+					 &args);
+	if (ret) {
+		pr_err("Failed to parse spacemit,apmu: %d\n", ret);
+		return ret;
+	}
+
+	if (args.args_count != 2)
+		return -EINVAL;
+
+	dwmac->ctrl_offset = args.args[0];
+	dwmac->dline_offset = args.args[1];
+
+	ret = regmap_init_mem(args.node, &dwmac->apmu);
+	if (ret) {
+		pr_err("Failed to init apmu regmap: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_get_by_name(dev, "stmmaceth", &eqos->reset_ctl);
+	if (ret) {
+		pr_err("Failed to get stmmaceth reset: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_bulk(dev, &dwmac->clks);
+	if (ret) {
+		pr_err("Failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_by_name(dev, "stmmaceth", &eqos->clk_master_bus);
+	if (ret) {
+		pr_err("clk_get_by_name(stmmaceth) failed: %d\n", ret);
+		return ret;
+	}
+
+	dev_read_u32(dev, "tx-internal-delay-ps", &tx_delay);
+	dev_read_u32(dev, "rx-internal-delay-ps", &rx_delay);
+
+	ret = spacemit_dwmac_fix_delay(dwmac, tx_delay, rx_delay);
+	if (ret) {
+		pr_err("Failed to configure delay: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct eqos_ops eqos_spacemit_ops = {
+	.eqos_inval_desc = eqos_inval_desc_generic,
+	.eqos_flush_desc = eqos_flush_desc_generic,
+	.eqos_inval_buffer = eqos_inval_buffer_generic,
+	.eqos_flush_buffer = eqos_flush_buffer_generic,
+	.eqos_probe_resources = eqos_probe_resources_spacemit,
+	.eqos_remove_resources = eqos_remove_resources_spacemit,
+	.eqos_stop_resets = eqos_stop_resets_spacemit,
+	.eqos_start_resets = eqos_start_resets_spacemit,
+	.eqos_stop_clks = eqos_stop_clks_spacemit,
+	.eqos_start_clks = eqos_start_clks_spacemit,
+	.eqos_calibrate_pads = eqos_null_ops,
+	.eqos_disable_calibration = eqos_null_ops,
+	.eqos_set_tx_clk_speed = eqos_null_ops,
+	.eqos_get_enetaddr = eqos_null_ops,
+	.eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_spacemit,
+};
+
+struct eqos_config eqos_spacemit_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10,
+	.swr_wait = 500,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
+	.axi_bus_width = EQOS_AXI_WIDTH_64,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_spacemit_ops,
+};

-- 
2.55.0

