Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDF8C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD9384B96;
	Thu,  9 Jul 2026 15:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GjCzjyQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B3B84B2C; Thu,  9 Jul 2026 14:58:22 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CF484A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so11282065e9.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601899; x=1784206699; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KcqsSmCEvJCBaTX9HZnc2vQ/DZSJS/b6+qTQjfDA3oY=;
 b=GjCzjyQsRxGMHekj6HQj2AWzk3LhwkuVAWZb+AfsqXVTsDmayeJ/7f8tjmXAfN8PNQ
 WeDs5DvPMcTBv1tlfdmG/3CESw75jpBCfEySoma85qBc9/T30Eknrsvg3WFGoKaHsCew
 o/dVaQJmx4H9fT4YUz+BZy/ohrSLS/22kuvHq77FXNnjx7GKfKaI/GEMCgVh24lqhuQy
 Brq8zHXfaLWewd50OGOUuvdCFOLFuMrxvsSkP6Y+fXer+6i7i2YOOd9RR0Pq7yXUsqP0
 6UFMxqK8+xIJx4Tt9YZoY/P2PBL3pos/CRX+9CgAgqjZ3+Tmt+O/i8fYgb+u+gGGFRP4
 xU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601899; x=1784206699;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KcqsSmCEvJCBaTX9HZnc2vQ/DZSJS/b6+qTQjfDA3oY=;
 b=clcQ/mUSuDB39OnubbSNovu3CmmSYYqPGtJygNYP2hq9TuohquT4oVKxp5boB4OBbm
 muKkIApqs9iVuTInynV9L5hbxtq7ulPYuFZa24Bbofv5Zb+pEvEtL0fs32ejztmuORFq
 VbM8Tzn9DQwat8nYGA3H8I7JGJOo6wpmWWntuM9yhhayfYSwmnRSg+Q9H4e7TLA9+ntJ
 ZfNDSumnVMJAS5MfY4zUbjMr5Sm4m4jG4GuNdBZgRfZAeGvFGgkKxC9bO093rn2t4iDG
 qfOnnEDIyFRDXQNTxb40Ncs2rFUI5x+BfWhfOtYME38eASS7GynQZ/Qg7Yk4QAZF71VJ
 OEUw==
X-Gm-Message-State: AOJu0YxFLNK3sdhODFUowIovG4bKFh5kIptSHM8w6M9sOOL98ftTY9hZ
 1rbdDCDGcPluTsjamsUr7FQ+JnbLqdVsv4U9l6VoCNWMv+KVfYoHTONIDsjUHXk7JrQ=
X-Gm-Gg: AfdE7cm4Vjb1OOJSjoAQe8EaeuCjx4Jcj6U2IIGUHat4Idu7aGtrvuUt7HGB6eng7FJ
 4rDeXsJqjcC8fzRgraPxCrlCo1jqThvLFYl6cr2O8vTub3sShtiOJ3iQuQDFgGegy3hatUX2JoP
 pumvxd1el0jb7Hji5prMevMJ8FkXCcyxxoXI/ha+VE3bUkXa+wuJPYX1XzVeLxUaJH7rP3ZVzSG
 4xZcxfbaEx9b1xKDQ/xRl8EGY3jZYI5agpbF5AfcWFtkDf74WgJiKX4TqY4eujyy4q5MvVyMyTe
 OKL8Qkzw9iY7QxEB5bptllOwhyxV2gF+0Gg4bZaNAzsmHybyaQDMK/70YYtcjcmRAtjbCy5MmLu
 aNlAxLrrVyT9cqgfp0TVHyG9btVsW9BlUrnaQC7jIr3XTGB+M0DAqOpD5jiQJy9FFQ2VMGv1skl
 CVcnZ1eocTj7arR6TSZ/G7/4aPE/HMIQ/Hdrco0YddaD5w4P+qEUkUaUi2OSiXMhkSSaWGD8fHm
 c336Rd9emDJAs/PV7q/Ylx763qI1Fb5b3fmrX5IxLUZ2DBiNR76D66B4pVgxmWZorvyvw8=
X-Received: by 2002:a05:6000:4313:b0:473:1e79:87e6 with SMTP id
 ffacd0b85a97d-47df7547efamr3139796f8f.3.1783601898581; 
 Thu, 09 Jul 2026 05:58:18 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:18 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:14 +0200
Subject: [PATCH v2 08/14] power: domain: mediatek: split into per-SoC drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-8-589ace7d30e2@baylibre.com>
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

In order to prepare addition of future SoC, split the current driver
into common shared code and SoC specific drivers:

  - mtk-power-domain.c now only holds the common register access and
    power on/off/request/probe logic plus the shared power_domain_ops.
  - mtk-power-domain.h exposes the register definitions, the mtk_scp_domain
    data structures and the core helpers to the per-SoC drivers.
  - mt7623-power-domain.c and mt7629-power-domain.c each hold their own
    domain table and U_BOOT_DRIVER registration. The mt7629 driver also
    matches the mt7622 compatible, preserving the previous behaviour.

Update the mt7622, mt7623 and mt7629 defconfigs to select the matching
per-SoC driver.

No functional change intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 MAINTAINERS                                |   1 +
 configs/mt7622_rfb_defconfig               |   2 +-
 configs/mt7623a_unielec_u7623_02_defconfig |   2 +-
 configs/mt7623n_bpir2_defconfig            |   2 +-
 configs/mt7629_rfb_defconfig               |   2 +-
 drivers/power/domain/Kconfig               |  23 +++-
 drivers/power/domain/Makefile              |   2 +
 drivers/power/domain/mt2701-power-domain.c |  87 +++++++++++++++
 drivers/power/domain/mt7622-power-domain.c |  54 +++++++++
 drivers/power/domain/mtk-power-domain.c    | 171 +----------------------------
 drivers/power/domain/mtk-power-domain.h    |  81 ++++++++++++++
 11 files changed, 252 insertions(+), 175 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8867921426c..40c3e3bf6b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -418,6 +418,7 @@ R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
 T:	git https://source.denx.de/u-boot/custodians/u-boot-mediatek.git
 S:	Maintained
 F:	arch/arm/dts/mt*
+F:	drivers/power/domain/mt*
 F:	drivers/power/regulator/mt*.c
 F:	drivers/usb/mtu3/
 F:	include/power/mt*.h
diff --git a/configs/mt7622_rfb_defconfig b/configs/mt7622_rfb_defconfig
index b3b688ff825..10df7847a4b 100644
--- a/configs/mt7622_rfb_defconfig
+++ b/configs/mt7622_rfb_defconfig
@@ -51,7 +51,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7622=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_MT7622_POWER_DOMAIN=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
diff --git a/configs/mt7623a_unielec_u7623_02_defconfig b/configs/mt7623a_unielec_u7623_02_defconfig
index 826f49a9626..77473e2731f 100644
--- a/configs/mt7623a_unielec_u7623_02_defconfig
+++ b/configs/mt7623a_unielec_u7623_02_defconfig
@@ -49,7 +49,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7623=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_MT2701_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SYSRESET=y
diff --git a/configs/mt7623n_bpir2_defconfig b/configs/mt7623n_bpir2_defconfig
index aeef3bebe96..aacaf5380fa 100644
--- a/configs/mt7623n_bpir2_defconfig
+++ b/configs/mt7623n_bpir2_defconfig
@@ -51,7 +51,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7623=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_MT2701_POWER_DOMAIN=y
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
 CONFIG_SYSRESET=y
diff --git a/configs/mt7629_rfb_defconfig b/configs/mt7629_rfb_defconfig
index 72b1c83312e..91da684939a 100644
--- a/configs/mt7629_rfb_defconfig
+++ b/configs/mt7629_rfb_defconfig
@@ -83,7 +83,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_MT7629=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_MTK_POWER_DOMAIN=y
+CONFIG_MT7622_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_RAM=y
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index a96c3fb979c..0cadd9b93a9 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -83,12 +83,29 @@ config MESON_SECURE_POWER_DOMAIN
 	  Enable support for manipulating Amlogic Meson Secure power domains.
 	  Support for Amlogic A1 series.
 
-config MTK_POWER_DOMAIN
-	bool "Enable the MediaTek power domain driver"
+config MT2701_POWER_DOMAIN
+	bool "Enable the MediaTek power domain driver for MT2701 compatible SoC"
 	depends on POWER_DOMAIN && ARCH_MEDIATEK
+	select MTK_POWER_DOMAIN
 	help
 	  Enable support for manipulating MediaTek power domains via MMIO
-	  mapped registers.
+	  mapped registers for MT2701 compatible SoC. The driver powers
+	  the SoC power domains on and off and handles the associated bus
+	  protection bits. It is also used on MT7623.
+
+config MT7622_POWER_DOMAIN
+	bool "Enable the MediaTek power domain driver for MT7622 compatible SoC"
+	depends on POWER_DOMAIN && ARCH_MEDIATEK
+	select MTK_POWER_DOMAIN
+	help
+	  Enable support for manipulating MediaTek power domains via MMIO
+	  mapped registers for MT7622 compatible SoC. The driver powers
+	  the SoC power domains on and off and handles the associated bus
+	  protection bits. It is also used on MT7629.
+
+config MTK_POWER_DOMAIN
+	bool
+	depends on POWER_DOMAIN && ARCH_MEDIATEK
 
 config QCOM_RPMH_POWER_DOMAIN
 	bool "Enable the QCOM RPMH Power domain driver"
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index f3cce2b104e..66772b5d346 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -14,6 +14,8 @@ obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) += imx8mp-mediamix.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
 obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
+obj-$(CONFIG_MT2701_POWER_DOMAIN) += mt2701-power-domain.o
+obj-$(CONFIG_MT7622_POWER_DOMAIN) += mt7622-power-domain.o
 obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
 obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
 obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
diff --git a/drivers/power/domain/mt2701-power-domain.c b/drivers/power/domain/mt2701-power-domain.c
new file mode 100644
index 00000000000..5626235360e
--- /dev/null
+++ b/drivers/power/domain/mt2701-power-domain.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dt-bindings/power/mt2701-power.h>
+#include <linux/bitops.h>
+
+#include "mtk-power-domain.h"
+
+static const struct mtk_scp_domain_data mt2701_scp_domain[] = {
+	[MT2701_POWER_DOMAIN_CONN] = {
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = SPM_CONN_PWR_CON,
+		.bus_prot_mask = BIT(8) | BIT(2),
+	},
+	[MT2701_POWER_DOMAIN_DISP] = {
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.bus_prot_mask = BIT(2),
+	},
+	[MT2701_POWER_DOMAIN_MFG] = {
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT2701_POWER_DOMAIN_VDEC] = {
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT2701_POWER_DOMAIN_ISP] = {
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT2701_POWER_DOMAIN_BDP] = {
+		.sta_mask = PWR_STATUS_BDP,
+		.ctl_offs = SPM_BDP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+	},
+	[MT2701_POWER_DOMAIN_ETH] = {
+		.sta_mask = PWR_STATUS_ETH,
+		.ctl_offs = SPM_ETH_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT2701_POWER_DOMAIN_HIF] = {
+		.sta_mask = PWR_STATUS_HIF,
+		.ctl_offs = SPM_HIF_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT2701_POWER_DOMAIN_IFR_MSC] = {
+		.sta_mask = PWR_STATUS_IFR_MSC,
+		.ctl_offs = SPM_IFR_MSC_PWR_CON,
+	},
+};
+
+static const struct udevice_id mt2701_power_domain_ids[] = {
+	{
+		.compatible = "mediatek,mt2701-scpsys",
+		.data = (ulong)&mt2701_scp_domain,
+	},
+	{
+		.compatible = "mediatek,mt7623-scpsys",
+		.data = (ulong)&mt2701_scp_domain,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mt2701_power_domain) = {
+	.name = "mt2701_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &mtk_power_domain_ops,
+	.probe = mtk_power_domain_probe,
+	.of_match = mt2701_power_domain_ids,
+	.priv_auto = sizeof(struct mtk_scp_domain),
+};
diff --git a/drivers/power/domain/mt7622-power-domain.c b/drivers/power/domain/mt7622-power-domain.c
new file mode 100644
index 00000000000..487ae477bb0
--- /dev/null
+++ b/drivers/power/domain/mt7622-power-domain.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm.h>
+#include <dt-bindings/power/mt7622-power.h>
+#include <linux/bitops.h>
+
+#include "mtk-power-domain.h"
+
+static const struct mtk_scp_domain_data mt7622_scp_domain[] = {
+	[MT7622_POWER_DOMAIN_ETHSYS] = {
+		.sta_mask = PWR_STATUS_ETHSYS,
+		.ctl_offs = SPM_ETHSYS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bus_prot_mask = (BIT(3) | BIT(17)),
+	},
+	[MT7622_POWER_DOMAIN_HIF0] = {
+		.sta_mask = PWR_STATUS_HIF0,
+		.ctl_offs = SPM_HIF0_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bus_prot_mask = GENMASK(25, 24),
+	},
+	[MT7622_POWER_DOMAIN_HIF1] = {
+		.sta_mask = PWR_STATUS_HIF1,
+		.ctl_offs = SPM_HIF1_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bus_prot_mask = GENMASK(28, 26),
+	},
+};
+
+static const struct udevice_id mt7622_power_domain_ids[] = {
+	{
+		.compatible = "mediatek,mt7622-scpsys",
+		.data = (ulong)&mt7622_scp_domain,
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(mt7622_power_domain) = {
+	.name = "mt7622_power_domain",
+	.id = UCLASS_POWER_DOMAIN,
+	.ops = &mtk_power_domain_ops,
+	.probe = mtk_power_domain_probe,
+	.of_match = mt7622_power_domain_ids,
+	.priv_auto = sizeof(struct mtk_scp_domain),
+};
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 18a45a131b8..a8045c1f91e 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -6,153 +6,13 @@
 
 #include <clk.h>
 #include <dm.h>
-#include <malloc.h>
-#include <power-domain-uclass.h>
 #include <regmap.h>
 #include <syscon.h>
 #include <asm/io.h>
-#include <asm/processor.h>
-#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/iopoll.h>
 
-#include <dt-bindings/power/mt2701-power.h>
-#include <dt-bindings/power/mt7622-power.h>
-
-#define SPM_EN			(0xb16 << 16 | 0x1)
-#define SPM_VDE_PWR_CON		0x0210
-#define SPM_MFG_PWR_CON		0x0214
-#define SPM_ISP_PWR_CON		0x0238
-#define SPM_DIS_PWR_CON		0x023c
-#define SPM_CONN_PWR_CON	0x0280
-#define SPM_BDP_PWR_CON		0x029c
-#define SPM_ETH_PWR_CON		0x02a0
-#define SPM_HIF_PWR_CON		0x02a4
-#define SPM_IFR_MSC_PWR_CON	0x02a8
-#define SPM_ETHSYS_PWR_CON	0x2e0
-#define SPM_HIF0_PWR_CON	0x2e4
-#define SPM_HIF1_PWR_CON	0x2e8
-#define SPM_PWR_STATUS		0x60c
-#define SPM_PWR_STATUS_2ND	0x610
-
-#define PWR_RST_B_BIT		BIT(0)
-#define PWR_ISO_BIT		BIT(1)
-#define PWR_ON_BIT		BIT(2)
-#define PWR_ON_2ND_BIT		BIT(3)
-#define PWR_CLK_DIS_BIT		BIT(4)
-
-#define PWR_STATUS_CONN		BIT(1)
-#define PWR_STATUS_DISP		BIT(3)
-#define PWR_STATUS_MFG		BIT(4)
-#define PWR_STATUS_ISP		BIT(5)
-#define PWR_STATUS_VDEC		BIT(7)
-#define PWR_STATUS_BDP		BIT(14)
-#define PWR_STATUS_ETH		BIT(15)
-#define PWR_STATUS_HIF		BIT(16)
-#define PWR_STATUS_IFR_MSC	BIT(17)
-#define PWR_STATUS_ETHSYS	BIT(24)
-#define PWR_STATUS_HIF0		BIT(25)
-#define PWR_STATUS_HIF1		BIT(26)
-
-/* Infrasys configuration */
-#define INFRA_TOPDCM_CTRL	0x10
-#define INFRA_TOPAXI_PROT_EN	0x220
-#define INFRA_TOPAXI_PROT_STA1	0x228
-
-#define DCM_TOP_EN		BIT(0)
-
-struct mtk_scp_domain;
-
-struct mtk_scp_domain_data {
-	u32 sta_mask;
-	int ctl_offs;
-	u32 sram_pdn_bits;
-	u32 sram_pdn_ack_bits;
-	u32 bus_prot_mask;
-};
-
-struct mtk_scp_domain {
-	void __iomem *base;
-	void __iomem *infracfg;
-	const struct mtk_scp_domain_data *data;
-};
-
-static const struct mtk_scp_domain_data scp_domain_mt2701[] = {
-	[MT2701_POWER_DOMAIN_CONN] = {
-		.sta_mask = PWR_STATUS_CONN,
-		.ctl_offs = SPM_CONN_PWR_CON,
-		.bus_prot_mask = BIT(8) | BIT(2),
-	},
-	[MT2701_POWER_DOMAIN_DISP] = {
-		.sta_mask = PWR_STATUS_DISP,
-		.ctl_offs = SPM_DIS_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.bus_prot_mask = BIT(2),
-	},
-	[MT2701_POWER_DOMAIN_MFG] = {
-		.sta_mask = PWR_STATUS_MFG,
-		.ctl_offs = SPM_MFG_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(12, 12),
-	},
-	[MT2701_POWER_DOMAIN_VDEC] = {
-		.sta_mask = PWR_STATUS_VDEC,
-		.ctl_offs = SPM_VDE_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(12, 12),
-	},
-	[MT2701_POWER_DOMAIN_ISP] = {
-		.sta_mask = PWR_STATUS_ISP,
-		.ctl_offs = SPM_ISP_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(13, 12),
-	},
-	[MT2701_POWER_DOMAIN_BDP] = {
-		.sta_mask = PWR_STATUS_BDP,
-		.ctl_offs = SPM_BDP_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-	},
-	[MT2701_POWER_DOMAIN_ETH] = {
-		.sta_mask = PWR_STATUS_ETH,
-		.ctl_offs = SPM_ETH_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(15, 12),
-	},
-	[MT2701_POWER_DOMAIN_HIF] = {
-		.sta_mask = PWR_STATUS_HIF,
-		.ctl_offs = SPM_HIF_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(15, 12),
-	},
-	[MT2701_POWER_DOMAIN_IFR_MSC] = {
-		.sta_mask = PWR_STATUS_IFR_MSC,
-		.ctl_offs = SPM_IFR_MSC_PWR_CON,
-	},
-};
-
-static const struct mtk_scp_domain_data scp_domain_mt7622[] = {
-	[MT7622_POWER_DOMAIN_ETHSYS] = {
-		.sta_mask = PWR_STATUS_ETHSYS,
-		.ctl_offs = SPM_ETHSYS_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(15, 12),
-		.bus_prot_mask = (BIT(3) | BIT(17)),
-	},
-	[MT7622_POWER_DOMAIN_HIF0] = {
-		.sta_mask = PWR_STATUS_HIF0,
-		.ctl_offs = SPM_HIF0_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(15, 12),
-		.bus_prot_mask = GENMASK(25, 24),
-	},
-	[MT7622_POWER_DOMAIN_HIF1] = {
-		.sta_mask = PWR_STATUS_HIF1,
-		.ctl_offs = SPM_HIF1_PWR_CON,
-		.sram_pdn_bits = GENMASK(11, 8),
-		.sram_pdn_ack_bits = GENMASK(15, 12),
-		.bus_prot_mask = GENMASK(28, 26),
-	},
-};
+#include "mtk-power-domain.h"
 
 /**
  * This function enables the bus protection bits for disabled power
@@ -298,7 +158,7 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 	return 0;
 }
 
-static int mtk_power_domain_probe(struct udevice *dev)
+int mtk_power_domain_probe(struct udevice *dev)
 {
 	struct ofnode_phandle_args args;
 	struct mtk_scp_domain *scpd = dev_get_priv(dev);
@@ -335,32 +195,7 @@ static int mtk_power_domain_probe(struct udevice *dev)
 	return clk_enable_bulk(&bulk);
 }
 
-static const struct udevice_id mtk_power_domain_ids[] = {
-	{
-		.compatible = "mediatek,mt2701-scpsys",
-		.data = (ulong)&scp_domain_mt2701,
-	},
-	{
-		.compatible = "mediatek,mt7622-scpsys",
-		.data = (ulong)&scp_domain_mt7622,
-	},
-	{
-		.compatible = "mediatek,mt7623-scpsys",
-		.data = (ulong)&scp_domain_mt2701,
-	},
-	{ /* sentinel */ }
-};
-
-static const struct power_domain_ops mtk_power_domain_ops = {
+const struct power_domain_ops mtk_power_domain_ops = {
 	.off = mtk_scpsys_power_off,
 	.on = mtk_scpsys_power_on,
 };
-
-U_BOOT_DRIVER(mtk_power_domain) = {
-	.name = "mtk_power_domain",
-	.id = UCLASS_POWER_DOMAIN,
-	.ops = &mtk_power_domain_ops,
-	.probe = mtk_power_domain_probe,
-	.of_match = mtk_power_domain_ids,
-	.priv_auto	= sizeof(struct mtk_scp_domain),
-};
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
new file mode 100644
index 00000000000..0c2c06a045f
--- /dev/null
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef __MTK_POWER_DOMAIN_H
+#define __MTK_POWER_DOMAIN_H
+
+#include <power-domain-uclass.h>
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct udevice;
+
+#define SPM_EN			(0xb16 << 16 | 0x1)
+#define SPM_VDE_PWR_CON		0x0210
+#define SPM_MFG_PWR_CON		0x0214
+#define SPM_ISP_PWR_CON		0x0238
+#define SPM_DIS_PWR_CON		0x023c
+#define SPM_CONN_PWR_CON	0x0280
+#define SPM_BDP_PWR_CON		0x029c
+#define SPM_ETH_PWR_CON		0x02a0
+#define SPM_HIF_PWR_CON		0x02a4
+#define SPM_IFR_MSC_PWR_CON	0x02a8
+#define SPM_ETHSYS_PWR_CON	0x2e0
+#define SPM_HIF0_PWR_CON	0x2e4
+#define SPM_HIF1_PWR_CON	0x2e8
+#define SPM_PWR_STATUS		0x60c
+#define SPM_PWR_STATUS_2ND	0x610
+
+#define PWR_RST_B_BIT		BIT(0)
+#define PWR_ISO_BIT		BIT(1)
+#define PWR_ON_BIT		BIT(2)
+#define PWR_ON_2ND_BIT		BIT(3)
+#define PWR_CLK_DIS_BIT		BIT(4)
+
+#define PWR_STATUS_CONN		BIT(1)
+#define PWR_STATUS_DISP		BIT(3)
+#define PWR_STATUS_MFG		BIT(4)
+#define PWR_STATUS_ISP		BIT(5)
+#define PWR_STATUS_VDEC		BIT(7)
+#define PWR_STATUS_BDP		BIT(14)
+#define PWR_STATUS_ETH		BIT(15)
+#define PWR_STATUS_HIF		BIT(16)
+#define PWR_STATUS_IFR_MSC	BIT(17)
+#define PWR_STATUS_ETHSYS	BIT(24)
+#define PWR_STATUS_HIF0		BIT(25)
+#define PWR_STATUS_HIF1		BIT(26)
+
+/* Infrasys configuration */
+#define INFRA_TOPDCM_CTRL	0x10
+#define INFRA_TOPAXI_PROT_EN	0x220
+#define INFRA_TOPAXI_PROT_STA1	0x228
+
+#define DCM_TOP_EN		BIT(0)
+
+struct mtk_scp_domain;
+
+struct mtk_scp_domain_data {
+	u32 sta_mask;
+	int ctl_offs;
+	u32 sram_pdn_bits;
+	u32 sram_pdn_ack_bits;
+	u32 bus_prot_mask;
+};
+
+struct mtk_scp_domain {
+	void __iomem *base;
+	void __iomem *infracfg;
+	const struct mtk_scp_domain_data *data;
+};
+
+int mtk_power_domain_probe(struct udevice *dev);
+
+extern const struct power_domain_ops mtk_power_domain_ops;
+
+#endif /* __MTK_POWER_DOMAIN_H */

-- 
2.54.0

