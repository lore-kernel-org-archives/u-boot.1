Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6E2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946C48497A;
	Wed,  8 Jul 2026 19:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="SnrnRsOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D15084A04; Wed,  8 Jul 2026 15:07:07 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 234C8849F0
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 15:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so404531f8f.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783516024; x=1784120824; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cGZdG3SJfy9h9i6nQxJ6piCZBWq5f0YpdyA/BmigpSo=;
 b=SnrnRsOdAG6iogTqFbA8y5X9rkhMx2Ho1ELw9k4iDSkxZ62/kXJcithi/fA/jxhrCl
 XZAmFQUCpAIAurAvJw3Rc0dSKcnxvnzR+rrQI8vRPuCgLHcAGRSRAq0siPJ5S5X7h8OS
 Ll0DxR4BczokV7beUsH7O+kjr1VXLMxugg3vvZIGhqooQhooxR1+FQNM8oOG1D8IzDQ9
 vpJCOaOnvbVSl5UXtI56XYeGZHCvPC514IutZ/et9LrVQrntGiHWFYGfqxk+RUeywjhH
 qOAvFsRFkSY/awWhnbBm3VD5zrIT8PSjh8rYExiUH5oCFWeyvZjrvnrH3WdJwbT5L73x
 Jj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783516024; x=1784120824;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cGZdG3SJfy9h9i6nQxJ6piCZBWq5f0YpdyA/BmigpSo=;
 b=tAh85Q5mgZj8KhABc9XwLSgamQzm5zVca5dDFXqQNj7x3h7Wi4ewlx/ejLICkFnYla
 Dfv9OceiuEZvIEpe4vio4c0+Z+kXgiARtvV6Alt22bLX52dz/UvgOIRosBz9rL4oTTRR
 DZ7Fj5dKDxUzfVmTZwZrv9QlvArn+wKoHEtSgb58YkZ8TUmwM/5vohtz8lotnBfQ0YVc
 vt8Z4gKuM2ccrYxIrnRuXub3vQ8htSAmZ6KBfYXH0XOntqUrEqcgxg2Sxw/IJbbbKiPt
 iV2LOZd1CK21fPw5paX1LMQMkevJm0N/PesjgBZWvhsrZ2jLFtFLc8mF3TVLoAHmcoTU
 ETPg==
X-Gm-Message-State: AOJu0YyZ3XQ5cZNe/qTSqehOh0oBgdQu5o8loMe4/x2IQk2MNEfRoDGi
 TYaiJZ9uMBsdAbC857lOFw8gtC/PxAo95dNBwQiSTR/aJipg/1E1CQoE4T9ohT4pj1A=
X-Gm-Gg: AfdE7cmYd7xQ/d2ZCQkme6qALqecDTFfgZLv+wGf2XbAZV7sVH41guHRt8kMyBoWnbF
 ZrtdOisHZoT6KJSENgau7o5W+ItHFBVL3AkQecyWcrfL/QYJEh0G2UqFvLSTtJDWPssmFq2fNis
 NhPgtgF98C5n0iT4NVE6jE9YkwBw73C27ui9M0gvk/lVCwpAo1fk4efTMM1uNA2aii5BdG4zk3e
 dhfV2pwINjoZtqkQ0qufjpgv+fSXhfOh4lX70L5LQuakjCFIGd4o2Ndlp+oABdH49kVPO/hs2mq
 rwbzM9D/JA6ittEZ565jYdeGwoYFm+4+e6AFiDzz3adFqVLl9WhvsZI1i+cyuNayboDy8oBmx72
 Z9R4ogvF7b6NTiuSBZqW1yrgMT3TPupPooMp/NX345zFa579qgExwvQAHaDy9IUCj/ae/acjioK
 kkShB+eyy3XTmnsx56/xFd0Tm7yxYGg8Za2V5CdwGAP7oQxjz6C6nYPkF2RYENW1YLK5MJGxABo
 wHToY7wf9no1FzdPCYFsVxopolpynwQdOrifC921JNH1DeH6818LGm+JrP8/m1Xp7UmvX8=
X-Received: by 2002:a05:6000:25c7:b0:47d:ec60:657e with SMTP id
 ffacd0b85a97d-47df076f100mr2644485f8f.39.1783516024447; 
 Wed, 08 Jul 2026 06:07:04 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039af67sm49000664f8f.17.2026.07.08.06.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 06:07:03 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jul 2026 15:07:07 +0200
Subject: [PATCH 01/12] power: domain: keep Makefile and Kconfig sorted
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mt8188-add-power-domain-v1-1-0e930b4f714e@baylibre.com>
References: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
In-Reply-To: <20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com>
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
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:37 +0200
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

Sort the Makefile and Kconfig alphabetically.

No functional change.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/Kconfig  | 62 +++++++++++++++++++++----------------------
 drivers/power/domain/Makefile | 12 ++++-----
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index bb9c52155d2..a96c3fb979c 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -9,6 +9,14 @@ config POWER_DOMAIN
 	  domains). This may be used to save power. This API provides the
 	  means to control such power management hardware.
 
+config AGILEX5_PMGR_POWER_DOMAIN
+	bool "Enable the Agilex5 PMGR power domain driver"
+	depends on SPL_POWER_DOMAIN && ARCH_SOCFPGA_SOC64
+	help
+	  Enable support for power gating peripherals' SRAM specified in
+	  the handoff data values obtained from the bitstream to reduce
+	  power consumption.
+
 config APPLE_PMGR_POWER_DOMAIN
 	bool "Enable the Apple PMGR power domain driver"
 	depends on POWER_DOMAIN
@@ -18,14 +26,6 @@ config APPLE_PMGR_POWER_DOMAIN
 	  This driver is needed to power on parts of the SoC that have
 	  not been powered on by previous boot stages.
 
-config AGILEX5_PMGR_POWER_DOMAIN
-	bool "Enable the Agilex5 PMGR power domain driver"
-	depends on SPL_POWER_DOMAIN && ARCH_SOCFPGA_SOC64
-	help
-	  Enable support for power gating peripherals' SRAM specified in
-	  the handoff data values obtained from the bitstream to reduce
-	  power consumption.
-
 config BCM6328_POWER_DOMAIN
 	bool "Enable the BCM6328 power domain driver"
 	depends on POWER_DOMAIN && ARCH_BMIPS
@@ -62,12 +62,12 @@ config IMX8MP_MEDIAMIX_BLKCTRL
 	help
 	  Enable support for manipulating NXP i.MX8MP on-SoC MEDIAMIX block controller.
 
-config MTK_POWER_DOMAIN
-	bool "Enable the MediaTek power domain driver"
-	depends on POWER_DOMAIN && ARCH_MEDIATEK
+config MESON_EE_POWER_DOMAIN
+	bool "Enable Amlogic Everything-Else power domain driver"
+	depends on POWER_DOMAIN && ARCH_MESON
 	help
-	  Enable support for manipulating MediaTek power domains via MMIO
-	  mapped registers.
+	  Enable support for manipulating Amlogic Meson Everything-Else power
+	  domains.
 
 config MESON_GX_VPU_POWER_DOMAIN
 	bool "Enable Amlogic Meson GX VPU power domain driver"
@@ -76,13 +76,6 @@ config MESON_GX_VPU_POWER_DOMAIN
 	  Enable support for manipulating Amlogic Meson GX Video Processing
 	  Unit power domain.
 
-config MESON_EE_POWER_DOMAIN
-	bool "Enable Amlogic Everything-Else power domain driver"
-	depends on POWER_DOMAIN && ARCH_MESON
-	help
-	  Enable support for manipulating Amlogic Meson Everything-Else power
-	  domains.
-
 config MESON_SECURE_POWER_DOMAIN
 	bool "Enable Amlogic Secure power domain driver"
 	depends on POWER_DOMAIN && ARCH_MESON && MESON_A1
@@ -90,6 +83,13 @@ config MESON_SECURE_POWER_DOMAIN
 	  Enable support for manipulating Amlogic Meson Secure power domains.
 	  Support for Amlogic A1 series.
 
+config MTK_POWER_DOMAIN
+	bool "Enable the MediaTek power domain driver"
+	depends on POWER_DOMAIN && ARCH_MEDIATEK
+	help
+	  Enable support for manipulating MediaTek power domains via MMIO
+	  mapped registers.
+
 config QCOM_RPMH_POWER_DOMAIN
 	bool "Enable the QCOM RPMH Power domain driver"
 	depends on POWER_DOMAIN && ARCH_SNAPDRAGON
@@ -128,12 +128,13 @@ config TEGRA186_POWER_DOMAIN
 	  Enable support for manipulating Tegra's on-SoC power domains via IPC
 	  requests to the BPMP (Boot and Power Management Processor).
 
-config TI_SCI_POWER_DOMAIN
-	bool "Enable the TI SCI-based power domain driver"
-	depends on POWER_DOMAIN && TI_SCI_PROTOCOL
+config TI_OMAP_PRM_POWER_DOMAIN
+	bool "Enable the TI OMAP PRM power domain driver"
+	depends on POWER_DOMAIN && ARCH_OMAP2PLUS
 	help
-	  Generic power domain implementation for TI devices implementing the
-	  TI SCI protocol.
+	  Enable support for TI OMAP Power and Reset Manager (PRM) power domains.
+	  The driver is currently a stub to be able to probe devices that
+	  require this type of power domain device.
 
 config TI_POWER_DOMAIN
 	bool "Enable the TI K3 Power domain driver"
@@ -141,13 +142,12 @@ config TI_POWER_DOMAIN
 	help
 	  Generic power domain implementation for TI K3 devices.
 
-config TI_OMAP_PRM_POWER_DOMAIN
-	bool "Enable the TI OMAP PRM power domain driver"
-	depends on POWER_DOMAIN && ARCH_OMAP2PLUS
+config TI_SCI_POWER_DOMAIN
+	bool "Enable the TI SCI-based power domain driver"
+	depends on POWER_DOMAIN && TI_SCI_PROTOCOL
 	help
-	  Enable support for TI OMAP Power and Reset Manager (PRM) power domains.
-	  The driver is currently a stub to be able to probe devices that
-	  require this type of power domain device.
+	  Generic power domain implementation for TI devices implementing the
+	  TI SCI protocol.
 
 config ZYNQMP_POWER_DOMAIN
 	bool "Enable the Xilinx ZynqMP Power domain driver"
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 110153d5cf8..f3cce2b104e 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -4,24 +4,24 @@
 #
 
 obj-$(CONFIG_$(PHASE_)POWER_DOMAIN) += power-domain-uclass.o
-obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
 obj-$(CONFIG_AGILEX5_PMGR_POWER_DOMAIN) += altr-pmgr-agilex5.o
+obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
 obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
 obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
 obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
 obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) += imx8mp-mediamix.o
-obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
-obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
+obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
+obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
+obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o
 obj-$(CONFIG_RENESAS_R8A78000_POWER_DOMAIN) += renesas-r8a78000-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain-test.o
 obj-$(CONFIG_SCMI_POWER_DOMAIN) += scmi-power-domain.o
 obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
-obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
-obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
 obj-$(CONFIG_TI_OMAP_PRM_POWER_DOMAIN) += ti-omap-prm.o
+obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
+obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
 obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
-obj-$(CONFIG_QCOM_RPMH_POWER_DOMAIN) += qcom-rpmhpd.o

-- 
2.54.0

