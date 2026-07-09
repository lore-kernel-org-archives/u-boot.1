Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A904C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E9784B5D;
	Thu,  9 Jul 2026 15:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="L5jG1Xr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28FE384A3E; Thu,  9 Jul 2026 14:58:05 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11BEC84AFF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-475417f010dso832492f8f.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601882; x=1784206682; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cGZdG3SJfy9h9i6nQxJ6piCZBWq5f0YpdyA/BmigpSo=;
 b=L5jG1Xr5Dr7Y4jP3s4F6fra6vvecmklyBEjNMle3sVySm1po/cTbvcn3PjBniDX6E0
 Yri7q5Redb+dZEG2ZPHg4BnX7D1UcNLjj5SjmLLYgDSZVVbV3bqWG0s+h1f47Ht0dWrn
 qZO4z0eRHe+qILu55QRgGfbOXMUOmtnMNTtloOLKjGl53lO18rVQjyfesuHNegXvKGkl
 iRjUPF2k35hNr41abBily7zHRR/mGCYsBJl2RO7lhuo8WlUR3rSMj0bO0J5KXtpIZ1LK
 vE344/YjvlyxWTDw38SvK5sgjxbgsaZq3tq45+C7tcHEbqbO6j1Dz6pPA8DwjicdgAmr
 6awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601882; x=1784206682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cGZdG3SJfy9h9i6nQxJ6piCZBWq5f0YpdyA/BmigpSo=;
 b=HmAAs8L35SKZGNM61/ghy2VA/DWeCzpdWcsBVVhIPSgjeHR7Jo9H+3TFZSR7fefL9N
 GkMGE86TxijdUeukQRddBmZSE3YEqnlLZ3VZP66hsjnlFf3QaoVNEiUChtaGL608QK+m
 6ptvd3druo4+dlDqWrdaMnJKHj9umbMFkEcxJMaLkfD4AvxCyefghHfwsTTAX2pTq/P5
 MXs/fp15LHhH4xU3ruq/GcLPWm1R6O49gqeV1Rn9pSd84VsYM0hgMmeunp/Quu0Pfr3Z
 I0jnhSxthDBgmNj+YpVXpKy/e1SQjcm/eB17xhrf2E3UKRXOnVQWqipEdTqW9yrtBvaA
 ffTA==
X-Gm-Message-State: AOJu0YzU2UC8IyF7F8pzw3GUYXS+/1W867WudViK0TPlIZVxWJTETDTT
 jCt88Y45mQ5raCdAsFluEZRhPdUjv9f7oIi/CLDXiCRGVIx/JGAepUeurgtdr0Oju3Q=
X-Gm-Gg: AfdE7ckKSqS7btmlVaYgB/zPIDriJ4Qn45g5yWx4eP/k2dJGqn2vAJDn5Sg6lqGSgPg
 R6EKc/+msIHe49d1/tFZmYvtDbyRHeUD5W02ZxvTGbSryLQSm45sOpDCGI/QNiZ1k9Q3y41io+7
 4YeESjX1on/MPslK/SsPpRdXv4/EG1yRxOtnB4Z8vY3XM57scIQqDWvKR3s/qNh2Hl2m8gYiyA2
 sB1zhMmUtITCP3gJGJv8f0CIGF9VZvVITigig9158QVGa77y4Sz8C07hoUAaKtf0/M2DvpPaWIa
 pP6NGqC/QVwg5rgGivUiz1HHR0ioHGz/M9YomTmQ93vfZF6q4Xk0cJL6TY3NQixMAb3Bk0sJRtw
 LgER9wBJPSvG91ADD9kccT/841ObrsNhEZ/vNYJzdNVmstWnCgBo1CQRX9jz5b4liJ44RqWAC93
 dcplz57RCx+wnCOCIIUmKfS1nDt/ovRVEtKXamVbVNfSFoib91ZUnFujRfA6ROt50Vf8gKzNsJ2
 7pSFkSdeNprpoNP7mncHGBnQxxrJohvTSNLC97/LGfUTnMW93FXHZszPAylpHQPtag/IXeIprJ5
 +kHlOA==
X-Received: by 2002:a5d:5f88:0:b0:474:3708:b7 with SMTP id
 ffacd0b85a97d-47df072df4emr7192796f8f.3.1783601882413; 
 Thu, 09 Jul 2026 05:58:02 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:58:02 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 09 Jul 2026 14:58:07 +0200
Subject: [PATCH v2 01/14] power: domain: keep Makefile and Kconfig sorted
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8188-add-power-domain-v2-1-589ace7d30e2@baylibre.com>
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

