Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56004E85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 20:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7A184020;
	Fri,  3 Apr 2026 22:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YycbnwfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B28840AB; Fri,  3 Apr 2026 18:01:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A1B83CF5
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 18:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lobanokivan11@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so2967055e9.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775232092; x=1775836892; darn=lists.denx.de;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NOXgV/k4knn0d3n5hWmjPXJ6lr6HZn/LfNf76oR3C6I=;
 b=YycbnwfIVic70wx9mKYLVl08ODZWxgmd0gSuvlMXhjaBh+ROSWNC5YX8tb5h9TjkLv
 1P9QbycFZO54R+RHa0lDO2BQd+nejv5pRICXOnqmkG1mSSM+WEXGlchvYE2mCwNsP/q9
 PIej7pboBmH9BPvI0DgZREEIG2bEp4+EQvHkjHiw5yU5NWZE12MaRykzs+Vma4hACSl8
 ue72VT8TQeHv7LsUnvgMX5R6Hft1X+Ehyt+25kOL+GQ50lXMZ07q3KVU2eH1GRke/DO6
 ZoMaZ5ydTDJRmb9tyy1pnDvW0OT+5Nh6NgNHBNkGpmbNOoGV7SCKKGMTtAEOTBHduAdY
 Y14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775232092; x=1775836892;
 h=content-transfer-encoding:signed-off-by:mime-version:message-id
 :date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOXgV/k4knn0d3n5hWmjPXJ6lr6HZn/LfNf76oR3C6I=;
 b=CdJMMq1ddKWv8vfNiSQedN0Bdo3y3Yg/Z+W1izf+xRaKZ5lGHQzGYjWzCcEybK7vfU
 QBkiGBeTLJ+gJhHkDsX/GhK69rCfiIxZVUTaKIxa+DZEoScTDgeNNtiZn33ddXELOrgY
 mAPODg7d8bsNwLgMtPDHUnbd95X1K7UFKsJe1/6RnTtifSQF5h/hUxJKIFwS/UWnY6dN
 ngxX2IFinpmJRuOkGBUMcS5pox6qfgG1XFl4Na8m23npOQCYRZDn7SFE8zryStwi29Ca
 VK1PsGyL2ZuqpCeSPY2oOkoVU0Nj/48qfcr3JQZQUjtHxp0Hnx8K0oI0ifGm6AEXGBcf
 zyhA==
X-Gm-Message-State: AOJu0YwTCxQoTiRSNFPZS6/9fzbXjN6hCTXTkqDxlSXhDZCApiaAINA/
 7iaN3maaUeD0eLrsd/Yjmy0IIvQ8C9oUEqlAOgueXq0BUoVXUGt/M11zqrR9mvQQ5VSIizwU
X-Gm-Gg: ATEYQzzQxqvp+Oi5xopOmF/RawpoCG5gH7kcTYJqJb8B/wD7vpRKDBqXK0aL9yq4/gp
 rW1KAASzzTqSe7nwLZTgwpXm03U+44kY96i9+HmUEbm4ncBeC9upDZvRUy0BB/vGGE68ENFAIr3
 StsNIasZdiAGw1wLN62skNraGMI/Heu6v2krfwViBMKsS8oSIzb+iJ8bYAa8fIcwU44a1A4FHO9
 nxcp9+lVvr4jZQYIDLUwUZin+o+a9aU6eSIw0eY96quWYYY0/q/EF17ecj/fPDVif0DEmGkX3iX
 T3q0BxgqO/7gB/pZov2+0nzXRuYgqiOUbSx+4+UHg7VD64KdOtZYV3+hotW2jrbIG1Z+LWQcyW+
 FkZcIh3vmOmiAkPjoP0mSX8t3isHutc1MyNCwVgKjRs+0CRkIsTb0kBRt1f4jVwMs082dX6qzcW
 F8yfZpiiv+aCIht9fNuKrrvxhvvz7s4cOtfCCa2mFYGhSoQsYMHwtFPniPSE5/7iJLZmHZ1on/t
 75mHRSfrUKg
X-Received: by 2002:a05:600c:3e87:b0:486:f8d6:5dea with SMTP id
 5b1f17b1804b1-488997c273dmr61530595e9.19.1775232091177; 
 Fri, 03 Apr 2026 09:01:31 -0700 (PDT)
Received: from nixos (mm-138-12-215-37.mfilial.dynamic.pppoe.byfly.by.
 [37.215.12.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e967badsm365081515e9.14.2026.04.03.09.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 09:01:30 -0700 (PDT)
From: Lobanokivan11 <lobanokivan11@gmail.com>
To: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 Lobanokivan11 <lobanokivan11@gmail.com>
Subject: [PATCH] xiaomi pad 5 support
Date: Fri,  3 Apr 2026 19:01:26 +0300
Message-ID: <20260403160127.10605-1-lobanokivan11@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Signed-off-by: Lobanokivan11 <lobanokivan11@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 22:11:58 +0200
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

---
 board/qualcomm/xiaomi-nabu.env                |   11 +
 configs/xiaomi-nabu_defconfig                 |    6 +
 dts/upstream/src/arm64/qcom/pm8150.dtsi       |   10 +-
 dts/upstream/src/arm64/qcom/pm8150b.dtsi      |    8 +
 .../src/arm64/qcom/sm8150-oneplus-common.dtsi |  545 ++++++++
 .../arm64/qcom/sm8150-oneplus-guacamole.dts   |   70 +
 .../src/arm64/qcom/sm8150-oneplus-hotdogb.dts |   65 +
 .../src/arm64/qcom/sm8150-wcd9340.dtsi        |   86 ++
 .../src/arm64/qcom/sm8150-xiaomi-cepheus.dts  |  575 ++++++++
 .../src/arm64/qcom/sm8150-xiaomi-nabu.dts     | 1175 +++++++++++++++++
 dts/upstream/src/arm64/qcom/sm8150.dtsi       |  102 ++
 11 files changed, 2652 insertions(+), 1 deletion(-)
 create mode 100644 board/qualcomm/xiaomi-nabu.env
 create mode 100644 configs/xiaomi-nabu_defconfig
 create mode 100644 dts/upstream/src/arm64/qcom/sm8150-oneplus-common.dtsi
 create mode 100644 dts/upstream/src/arm64/qcom/sm8150-oneplus-guacamole.dts
 create mode 100644 dts/upstream/src/arm64/qcom/sm8150-oneplus-hotdogb.dts
 create mode 100644 dts/upstream/src/arm64/qcom/sm8150-wcd9340.dtsi
 create mode 100644 dts/upstream/src/arm64/qcom/sm8150-xiaomi-cepheus.dts
 create mode 100644 dts/upstream/src/arm64/qcom/sm8150-xiaomi-nabu.dts

diff --git a/board/qualcomm/xiaomi-nabu.env b/board/qualcomm/xiaomi-nabu.env
new file mode 100644
index 00000000000..ffa49ea9885
--- /dev/null
+++ b/board/qualcomm/xiaomi-nabu.env
@@ -0,0 +1,11 @@
+stdin=serial,button-kbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+preboot=scsi scan; bootefi bootmgr
+fastboot=fastboot -l $fastboot_addr_r usb 0
+do_boot=bootefi bootmgr
+bootmenu_0=Boot first available device=run do_boot
+bootmenu_1=Enable fastboot mode=run fastboot
+bootmenu_2=Reset device=reset
+menucmd=bootmenu
+bootcmd=run do_boot
diff --git a/configs/xiaomi-nabu_defconfig b/configs/xiaomi-nabu_defconfig
new file mode 100644
index 00000000000..9554b6b88e8
--- /dev/null
+++ b/configs/xiaomi-nabu_defconfig
@@ -0,0 +1,6 @@
+# Configuration for building U-Boot for Xiaomi Pad 5
+
+#include "qcom_defconfig"
+
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8150-xiaomi-nabu"
+CONFIG_DEFAULT_ENV_FILE="board/qualcomm/xiaomi-nabu.env"
diff --git a/dts/upstream/src/arm64/qcom/pm8150.dtsi b/dts/upstream/src/arm64/qcom/pm8150.dtsi
index d2568686a09..c3411b308e3 100644
--- a/dts/upstream/src/arm64/qcom/pm8150.dtsi
+++ b/dts/upstream/src/arm64/qcom/pm8150.dtsi
@@ -116,13 +116,21 @@
 			status = "disabled";
 		};
 
-		rtc@6000 {
+		pm8150_rtc: rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 		};
 
+		pm8150_sdam_2: sdam@b100 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0xb100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+		};
+
 		pm8150_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
diff --git a/dts/upstream/src/arm64/qcom/pm8150b.dtsi b/dts/upstream/src/arm64/qcom/pm8150b.dtsi
index 3f7b0b6a1d1..97361a586be 100644
--- a/dts/upstream/src/arm64/qcom/pm8150b.dtsi
+++ b/dts/upstream/src/arm64/qcom/pm8150b.dtsi
@@ -150,6 +150,14 @@
 			status = "disabled";
 		};
 
+		pm8150b_fg: fuel-gauge@4000 {
+			compatible = "qcom,pm8150b-fg";
+			reg = <0x4000>;
+			interrupts = <0x2 0x40 0x3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "soc-delta";
+			status = "disabled";
+		};
+
 		pm8150b_gpios: gpio@c000 {
 			compatible = "qcom,pm8150b-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
diff --git a/dts/upstream/src/arm64/qcom/sm8150-oneplus-common.dtsi b/dts/upstream/src/arm64/qcom/sm8150-oneplus-common.dtsi
new file mode 100644
index 00000000000..e9118defdd3
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/sm8150-oneplus-common.dtsi
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Caleb Connolly <caleb@connolly.tech>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "sm8150.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+
+/delete-node/ &rmtfs_mem;
+
+/ {
+	compatible = "qcom,sm8150-mtp", "qcom,sm8150";
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	/*
+	 * Apparently RPMh does not provide support for PM8150 S4 because it
+	 * is always-on; model it as a fixed regulator.
+	 */
+	vreg_s4a_1p8: pm8150-s4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+	reserved-memory {
+		/* The rmtfs_mem needs to be guarded due to "XPU limitations"
+		 * it is otherwise possible for an allocation adjacent to the
+		 * rmtfs_mem region to trigger an XPU violation, causing a crash.
+		 */
+		// rmtfs_lower_guard: memory@f2900000 {
+		//	no-map;
+		//	reg = <0 0xf2900000 0 0x1000>;
+		// };
+		/*
+		 * The rmtfs memory region in downstream is 'dynamically allocated'
+		 * but given the same address every time. Hard code it as this address is
+		 * where the modem firmware expects it to be.
+		 */
+		rmtfs_mem: memory@f2901000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xf2901000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+		// rmtfs_upper: memory@f2902000 {
+		//	no-map;
+		//	reg = <0 0xf2902000 0 0x1000>;
+		// };
+	};
+};
+
+&adsp_mem {
+	reg = <0x0 0x8be00000 0x0 0x1e00000>;
+};
+
+&mpss_mem {
+	reg = <0x0 0x8dc00000 0x0 0x9600000>;
+};
+
+&venus_mem {
+	reg = <0x0 0x97200000 0x0 0x500000>;
+};
+
+&slpi_mem {
+	reg = <0x0 0x97700000 0x0 0x1400000>;
+};
+
+&ipa_fw_mem {
+	reg = <0x0 0x98b00000 0x0 0x10000>;
+};
+
+&ipa_gsi_mem {
+	reg = <0x0 0x98b10000 0x0 0x5000>;
+};
+
+&gpu_mem {
+	reg = <0x0 0x98b15000 0x0 0x2000>;
+};
+
+&spss_mem {
+	reg = <0x0 0x98c00000 0x0 0x100000>;
+};
+
+&cdsp_mem {
+	reg = <0x0 0x98d00000 0x0 0x1400000>;
+};
+
+// Just like the OnePlus 6, the OnePlus 7 puts this in a weird spot
+// Again it's left up to the driver to allocate this, it always allocates
+// it here.
+&rmtfs_mem {
+	reg = <0x0 0xf2901000 0x0 0x200000>;
+};
+
+&gpu {
+	status = "disabled";
+};
+
+&apps_rsc {
+	pm8150-rpmh-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p9>;
+		vdd-l6-l9-supply = <&vreg_s8c_1p3>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p0>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s5a_2p0: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vdda_wcss_pll:
+		vreg_l1a_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_pdphy:
+		vdda_usb_hs_3p1:
+		vreg_l2a_3p1: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <932000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_usb_hs_core:
+		vdda_csi_0_0p9:
+		vdda_csi_1_0p9:
+		vdda_csi_2_0p9:
+		vdda_csi_3_0p9:
+		vdda_dsi_0_0p9:
+		vdda_dsi_1_0p9:
+		vdda_dsi_0_pll_0p9:
+		vdda_dsi_1_pll_0p9:
+		vdda_pcie_1ln_core:
+		vdda_pcie_2ln_core:
+		vdda_pll_hv_cc_ebi01:
+		vdda_pll_hv_cc_ebi23:
+		vdda_qrefs_0p875_5:
+		vdda_sp_sensor:
+		vdda_ufs_2ln_core_1:
+		vdda_ufs_2ln_core_2:
+		vdda_usb_ss_dp_core_1:
+		vdda_usb_ss_dp_core_2:
+		vdda_qlink_lv:
+		vdda_qlink_lv_ck:
+		vreg_l5a_0p875: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_10:
+		vreg_l9a_1p2: ldo9 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10a_2p5: ldo10 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_qfprom:
+		vdd_qfprom_sp:
+		vdda_apc_cs_1p8:
+		vdda_gfx_cs_1p8:
+		vdda_usb_hs_1p8:
+		vdda_qrefs_vref_1p8:
+		vddpx_10_a:
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p7: ldo13 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pm8150l-rpmh-regulators {
+		compatible = "qcom,pm8150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s8c_1p3>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+		vdd-flash-supply = <&vreg_bob>;
+		vdd-rgb-supply = <&vreg_bob>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <4000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+		};
+
+		vreg_s8c_1p3: smps8 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_wcss_adcdac_1:
+		vdda_wcss_adcdac_22:
+		vreg_l2c_1p3: ldo2 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_hv_ebi0:
+		vdda_hv_ebi1:
+		vdda_hv_ebi2:
+		vdda_hv_ebi3:
+		vdda_hv_refgen0:
+		vdda_qlink_hv_ck:
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_5:
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_6:
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_2:
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pm8009-rpmh-regulators {
+		compatible = "qcom,pm8009-rpmh-regulators";
+		qcom,pmic-id = "f";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vreg_bob>;
+
+		vdd-l2-supply = <&vreg_s8c_1p3>;
+		vdd-l5-l6-supply = <&vreg_bob>;
+
+		vreg_l2f_1p2: ldo2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5f_2p85: ldo5 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6f_2p85: ldo6 {
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <2856000>;
+		};
+	};
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&pon {
+	pwrkey {
+		status = "okay";
+	};
+
+	resin {
+		compatible = "qcom,pm8941-resin";
+		interrupts = <0x0 0x8 0x1 IRQ_TYPE_EDGE_BOTH>;
+		debounce = <15625>;
+		bias-pull-up;
+		linux,code = <KEY_VOLUMEDOWN>;
+	};
+};
+
+&remoteproc_adsp {
+	status = "disabled";
+};
+
+&remoteproc_cdsp {
+	status = "disabled";
+};
+
+&remoteproc_slpi {
+	status = "disabled";
+};
+
+&remoteproc_mpss {
+	status = "okay";
+	firmware-name = "qcom/sm8150/oneplus7/modem.mdt";
+};
+
+// Some of these might be guacamole specific
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <126 4>;
+
+	tp_irq_active: tp-irq-active {
+		mux {
+			pins = "gpio122";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio122";
+			drive-strength = <0x08>;
+			bias-disable;
+			input-enable;
+		};
+	};
+
+	tp_rst_active: tp-rst-active {
+		mux {
+			pins = "gpio54";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio54";
+			drive-strength = <0x08>;
+			bias-disable;
+		};
+	};
+
+	tp_1v8_active: tp-1v8-active {
+		mux {
+			pins = "gpio119";
+			function = "gpio";
+		};
+
+		config {
+			pins = "gpio119";
+			drive-strength = <0x08>;
+			bias-pull-up;
+		};
+	};
+};
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l10a_2p5>;
+	vcc-max-microamp = <750000>;
+	vccq-supply = <&vreg_l9a_1p2>;
+	vccq-max-microamp = <700000>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vccq2-max-microamp = <750000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_ufs_2ln_core_1>;
+	vdda-max-microamp = <90200>;
+	vdda-pll-supply = <&vreg_l3c_1p2>;
+	vdda-pll-max-microamp = <19000>;
+};
+
+&usb_1_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vdd_usb_hs_core>;
+	vdda33-supply = <&vdda_usb_hs_3p1>;
+	vdda18-supply = <&vdda_usb_hs_1p8>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&wifi {
+	status = "okay";
+};
diff --git a/dts/upstream/src/arm64/qcom/sm8150-oneplus-guacamole.dts b/dts/upstream/src/arm64/qcom/sm8150-oneplus-guacamole.dts
new file mode 100644
index 00000000000..bf4b540d36a
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/sm8150-oneplus-guacamole.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Devicetree for the OnePlus 7 Pro. This device uses a samsung touch driver
+ * and has a 1440p panel but is otherwise similar to the rest of the series.
+ *
+ * Copyright (c) 2021, Caleb Connolly <caleb@connolly.tech>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "sm8150-oneplus-common.dtsi"
+
+/ {
+	model = "OnePlus 7 Pro";
+	compatible = "oneplus,guacamole", "oneplus,oneplus7", "qcom,sm8150";
+
+	aliases {
+		display0 = &framebuffer0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		stdout-path = "display0";
+
+		/*
+		 * hack: Use framebuffer setup by the bootloader for simplefb.
+		 * the address is taken from the bootloader config (strings xbl.img | grep "Display Reserved")
+		 */
+		framebuffer0: framebuffer@9C000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x9C000000 0 (1440 * 3120 * 4)>;
+			width = <1440>;
+			height = <3120>;
+			stride = <(1440 * 4)>;
+			format = "a8r8g8b8";
+			status = "okay";
+
+		};
+	};
+
+	reserved-memory {
+	// hack: Bootloader framebuffer memory region
+		fb_mem: memory@a1a10000 {
+			compatible = "removed-dma-pool";
+			no-map;
+			reg = <0 0x9C000000 0 (1440 * 3120 * 4)>;
+		};
+	};
+};
+
+&i2c17 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		status = "okay";
+		reg = <0x48>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <122 0x2008>;
+		vdd-supply = <&vreg_l17a_3p0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_irq_active &tp_rst_active &tp_1v8_active>;
+	};
+};
diff --git a/dts/upstream/src/arm64/qcom/sm8150-oneplus-hotdogb.dts b/dts/upstream/src/arm64/qcom/sm8150-oneplus-hotdogb.dts
new file mode 100644
index 00000000000..7ba966a838c
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/sm8150-oneplus-hotdogb.dts
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "sm8150-oneplus-common.dtsi"
+
+/ {
+	model = "OnePlus 7T";
+	compatible = "oneplus,hotdobg", "oneplus,oneplus7", "qcom,sm8150";
+
+	aliases {
+		display0 = &framebuffer0;
+	};
+
+	chosen {
+		#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+		stdout-path = "display0";
+
+		/*
+	 * hack: Use framebuffer setup by the bootloader for simplefb.
+	 * the address is taken from the bootloader config (strings xbl.img | grep "Display Reserved")
+	 */
+	framebuffer0: framebuffer@9C000000 {
+	    compatible = "simple-framebuffer";
+	    reg = <0 0x9C000000 0 (1080 * 2400 * 4)>;
+	    width = <1080>;
+	    height = <2400>;
+	    stride = <(1080 * 4)>;
+	    format = "a8r8g8b8";
+	    status = "okay";
+
+	};
+	};
+
+	reserved-memory {
+	// hack: Bootloader framebuffer memory region
+	fb_mem: memory@a1a10000 {
+	    compatible = "removed-dma-pool";
+	    no-map;
+	    reg = <0 0x9C000000 0 (1080 * 2400 * 4)>;
+	};
+
+		removed_region: removed-region@89d00000 {
+			reg = <0x0 0x89d00000 0x0 0x1a00000>;
+			no-map;
+		};
+		ramoops: ramoops@0xA9800000 {
+			compatible = "ramoops";
+			reg = <0 0xA9800000 0 0x400000>;
+			record-size = <0x40000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x40000>;
+			pmsg-size = <0x200000>;
+			devinfo-size = <0x1000>;
+			ecc-size = <0x0>;
+		};
+	};
+};
diff --git a/dts/upstream/src/arm64/qcom/sm8150-wcd9340.dtsi b/dts/upstream/src/arm64/qcom/sm8150-wcd9340.dtsi
new file mode 100644
index 00000000000..cde7e55bf84
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/sm8150-wcd9340.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SM8150 SoC device tree source
+ *
+ * Copyright (c) 2023, The Linux Foundation. All rights reserved.
+ */
+
+&slim {
+	status = "okay";
+
+	slim@1 {
+		reg = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		wcd9340_ifd: ifd@0,0 {
+			compatible = "slim217,250";
+			reg = <0 0>;
+		};
+
+		wcd9340: codec@1,0 {
+			compatible = "slim217,250";
+			reg = <1 0>;
+			slim-ifc-dev = <&wcd9340_ifd>;
+
+			#sound-dai-cells = <1>;
+
+			interrupts-extended = <&tlmm 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clock-names = "extclk";
+			clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "mclk";
+
+			pinctrl-0 = <&wcd_intr_default>;
+			pinctrl-names = "default";
+
+			qcom,micbias1-microvolt = <1800000>;
+			qcom,micbias2-microvolt = <1800000>;
+			qcom,micbias3-microvolt = <1800000>;
+			qcom,micbias4-microvolt = <1800000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wcdgpio: gpio-controller@42 {
+				compatible = "qcom,wcd9340-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x42 0x2>;
+			};
+
+			swm: swm@c85 {
+				compatible = "qcom,soundwire-v1.3.0";
+				reg = <0xc85 0x40>;
+				interrupts-extended = <&wcd9340 20>;
+
+				qcom,dout-ports = <6>;
+				qcom,din-ports = <2>;
+				qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
+				qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
+				qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
+
+				#sound-dai-cells = <1>;
+				clocks = <&wcd9340>;
+				clock-names = "iface";
+				#address-cells = <2>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&tlmm {
+	wcd_intr_default: wcd-intr-default-state {
+		pins = "gpio123";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+		input-enable;
+	};
+};
diff --git a/dts/upstream/src/arm64/qcom/sm8150-xiaomi-cepheus.dts b/dts/upstream/src/arm64/qcom/sm8150-xiaomi-cepheus.dts
new file mode 100644
index 00000000000..422119fbd05
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/sm8150-xiaomi-cepheus.dts
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Alexey Minnekhanov <alexeymin@postmarketos.org>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm8150.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+
+/*
+ * Rewrite reserved memory maps inherited from sm8150.dtsi to match the ones
+ * used on xiaomi-cepheus.
+ * Note: this list is ordered by its memory address in sm8150.dtsi.
+ */
+/delete-node/ &tz_mem;      /* same address but larger, no place for rmtfs_mem! */
+/delete-node/ &rmtfs_mem;   /* moved to completely different address */
+/delete-node/ &adsp_mem;    /* same start address, but larger size */
+/delete-node/ &mpss_mem;    /* same size, shifted higher, due to larger adsp_mem */
+/delete-node/ &venus_mem;   /* same size, shifted higher */
+/delete-node/ &slpi_mem;    /* same size, shifted higher */
+/delete-node/ &ipa_fw_mem;  /* same size, shifted higher */
+/delete-node/ &ipa_gsi_mem; /* same size, shifted higher */
+/delete-node/ &gpu_mem;     /* same size, shifted higher */
+/delete-node/ &spss_mem;    /* same size, shifted higher */
+/delete-node/ &cdsp_mem;    /* same size, shifted higher */
+
+/ {
+	model = "Xiaomi Mi 9";
+	compatible = "xiaomi,cepheus", "qcom,sm8150";
+
+	aliases {
+		serial0 = &uart2;
+		display0 = &framebuffer;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0:115200n8";
+
+		framebuffer: framebuffer@9c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x9c000000 0 0x2300000>;
+			width = <1080>;
+			height = <2340>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			/*
+			 * That's (going to be) a lot of clocks, but it's necessary due
+			 * to unused clk cleanup & no panel driver yet (& no dispcc either)..
+			 */
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_SF_AXI_CLK>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ai_key_pin_a &vol_up_pin_a>;
+
+		vol_up {
+			label = "volume_up";
+			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		ai_key {
+			label = "ai_key";
+			gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_HOMEPAGE>; /* no AI key in Linux */
+			wakeup-source;
+			debounce-interval = <39>;
+		};
+	};
+
+	reserved-memory {
+		tz_mem: memory@86200000 {
+			no-map;
+			reg = <0x0 0x86200000 0x0 0x5500000>;
+			phandle = <0x594>;
+		};
+
+		adsp_mem: memory@8be00000 {
+			no-map;
+			reg = <0x0 0x8be00000 0x0 0x2200000>;
+		};
+
+		mpss_mem: memory@8e000000 {
+			no-map;
+			reg = <0x0 0x8e000000 0x0 0x9600000>;
+		};
+
+		venus_mem: memory@97600000 {
+			no-map;
+			reg = <0x0 0x97600000 0x0 0x500000>;
+		};
+
+		slpi_mem: memory@97b00000 {
+			no-map;
+			reg = <0x0 0x97b00000 0x0 0x1400000>;
+		};
+
+		ipa_fw_mem: memory@98f00000 {
+			no-map;
+			reg = <0x0 0x98f00000 0x0 0x10000>;
+		};
+
+		ipa_gsi_mem: memory@98f10000 {
+			no-map;
+			reg = <0x0 0x98f10000 0x0 0x5000>;
+		};
+
+		gpu_mem: memory@98f15000 {
+			no-map;
+			reg = <0x0 0x98f15000 0x0 0x2000>;
+		};
+
+		spss_mem: memory@99000000 {
+			no-map;
+			reg = <0x0 0x99000000 0x0 0x100000>;
+		};
+
+		cdsp_mem: memory@99100000 {
+			no-map;
+			reg = <0x0 0x99100000 0x0 0x1400000>;
+		};
+
+		cont_splash_mem: memory@9c000000 {
+			reg = <0x0 0x9c000000 0x0 0x2400000>;
+			no-map;
+		};
+
+		cdsp_sec_mem: memory@a4c00000 {
+			reg = <0x0 0xa4c00000 0x0 0x3c00000>;
+			no-map;
+		};
+
+		ramoops@b0000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xb0000000 0x0 0x400000>;
+			console-size = <0x200000>;
+			ecc-size = <0>;
+			ftrace-size = <0>;
+			pmsg-size = <0x200000>;
+			record-size = <0>;
+		};
+
+		/* Downstream dynamically allocates rmtfs_mem region using
+		 * dma_alloc_coherent and adds 4k guard pages before and after
+		 * it to workaround some "XPU limitation". */
+		/* rmtfs_lower_guard */
+		memory@f4100000 {
+			no-map;
+			reg = <0x0 0xf4100000 0x0 0x1000>;
+		};
+
+		rmtfs_mem: memory@f4101000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xf4101000 0x0 0x300000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		/* rmtfs_upper_guard */
+		memory@f4401000 {
+			no-map;
+			reg = <0x0 0xf4401000 0x0 0x1000>;
+		};
+	};
+
+	vdd_boost_vreg: vdd-boost-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_boost_vreg";
+		startup-delay-us = <4000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&pm8150b_gpios 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_boost_en_pin>;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	/* S4 is modeled as a fixed regulator in vendor sources */
+	vreg_s4a_1p8: pm8150-s4-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vph_pwr>;
+	};
+};
+
+&apps_rsc {
+	pm8150-rpmh-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p9>;
+		vdd-l6-l9-supply = <&vreg_s8c_1p3>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_1p9>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s2a_0p6: smps2 {
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <600000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s2a_0p6";
+		};
+
+		vreg_s5a_1p9: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s5a_0p6";
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s6a_0p9";
+		};
+
+		vreg_l1a_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l1a_0p75";
+		};
+
+		vreg_l2a_3p1: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l2a_3p1";
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <932000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l3a_0p8";
+		};
+
+		vreg_l5a_0p875: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l5a_0p875";
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l6a_1p2";
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l7a_1p8";
+		};
+
+		vreg_l9a_1p2: ldo9 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l9a_1p2";
+		};
+
+		vreg_l10a_2p5: ldo10 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l10a_2p5";
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l11a_0p8";
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l12a_1p8";
+		};
+
+		/* L13 is unused, but min/max are 3000000 for it. */
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l14a_1p8";
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l15a_1p7";
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l16a_2p7";
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l17a_3p0";
+		};
+
+		vreg_l18a_0p8: ldo18 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l18a_0p8";
+		};
+	};
+
+	pm8150l-rpmh-regulators {
+		compatible = "qcom,pm8150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s8c_1p3>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+		vdd-flash-supply = <&vreg_bob>;
+		vdd-rgb-supply = <&vreg_bob>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3350000>;
+			regulator-max-microvolt = <4000000>;
+			/* tavil-slim-pgd will request 3300000 */
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+			regulator-name = "pm8150l_bob";
+		};
+
+		vreg_s1c_1p1: smps1 {
+			regulator-min-microvolt = <1128000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_s1c_1p1";
+		};
+
+		vreg_s8c_1p3: smps8 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_s8c_1p3";
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l1c_1p8";
+		};
+
+		vreg_l2c_1p3: ldo2 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l2c_1p3";
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l3c_1p2";
+		};
+
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l4c_1p8";
+		};
+
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l5c_1p8";
+		};
+
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-name = "pm8150l_l6c_2p9";
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l7c_3p0";
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l8c_1p8";
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-name = "pm8150l_l9c_2p9";
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l10c_3p3";
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l11c_3p3";
+		};
+	};
+};
+
+&pm8150_gpios {
+	vol_up_pin_a: vol-up-active {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
+&pm8150b_gpios {
+	vdd_boost_en_pin: vdd-boost-en-pin {
+		pins = "gpio12";
+		function = "normal";
+		output-low;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+	};
+};
+
+&pon {
+	mode-recovery = <0x1>;
+	mode-bootloader = <0x2>;
+	mode-rtc = <0x3>;
+	mode-normal = <0x20>;
+	mode-panic = <0x21>;
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&tlmm {
+	/* gpios 0..3 are NFC spi, gpios 126..129 are FP spi */
+	gpio-reserved-ranges = <0 4>, <126 4>;
+
+	ai_key_pin_a: ai-key-pin-active {
+		pins = "gpio97";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	snps,has-lpm-erratum;
+	snps,hird-threshold = /bits/ 8 <0x10>;
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vreg_l5a_0p875>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l2a_3p1>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l5a_0p875>;
+};
diff --git a/dts/upstream/src/arm64/qcom/sm8150-xiaomi-nabu.dts b/dts/upstream/src/arm64/qcom/sm8150-xiaomi-nabu.dts
new file mode 100644
index 00000000000..52bdc359f08
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/sm8150-xiaomi-nabu.dts
@@ -0,0 +1,1174 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023-2024, map220v <map220v300@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/usb/pd.h>
+#include "sm8150.dtsi"
+#include "sm8150-wcd9340.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+
+/delete-node/ &tz_mem;
+/delete-node/ &rmtfs_mem;
+/delete-node/ &adsp_mem;
+/delete-node/ &mpss_mem;
+/delete-node/ &venus_mem;
+/delete-node/ &slpi_mem;
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &ipa_gsi_mem;
+/delete-node/ &gpu_mem;
+/delete-node/ &spss_mem;
+/delete-node/ &cdsp_mem;
+
+/ {
+	model = "Xiaomi Pad 5";
+	compatible = "xiaomi,nabu", "qcom,sm8150";
+	chassis-type = "tablet";
+	qcom,msm-id = <QCOM_ID_SM8150 0x20002>; /* SM8150 v2.2 */
+	qcom,board-id = <48 0>;
+
+	aliases {
+		serial0 = &uart2;
+		hsuart0 = &uart13;
+		wifi0 = &wifi;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer: framebuffer@9c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0x0 0x9c000000 0x0 0x02400000>;
+			width = <1600>;
+			height = <2560>;
+			stride = <(1600 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		tz_mem: memory@86200000 {
+			reg = <0x0 0x86200000 0x0 0x5500000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8be00000 {
+			reg = <0x0 0x8be00000 0x0 0x2200000>;
+			no-map;
+		};
+
+		mpss_mem: memory@8e000000 {
+			reg = <0x0 0x8e000000 0x0 0x9600000>;
+			no-map;
+		};
+
+		venus_mem: memory@97600000 {
+			reg = <0x0 0x97600000 0x0 0x500000>;
+			no-map;
+		};
+
+		slpi_mem: memory@97b00000 {
+			reg = <0x0 0x97b00000 0x0 0x1400000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@98f00000 {
+			reg = <0x0 0x98f00000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@98f10000 {
+			reg = <0x0 0x98f10000 0x0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@98f15000 {
+			reg = <0x0 0x98f15000 0x0 0x2000>;
+			no-map;
+		};
+
+		spss_mem: memory@99000000 {
+			reg = <0x0 0x99000000 0x0 0x100000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@99100000 {
+			reg = <0x0 0x99100000 0x0 0x1400000>;
+			no-map;
+		};
+
+		cdsp_sec_mem: memory@a4c00000 {
+			reg = <0x0 0xa4c00000 0x0 0x3c00000>;
+			no-map;
+		};
+
+		ramoops@b0000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xb0000000 0x0 0x400000>;
+			record-size = <0x1000>;
+			console-size = <0x200000>;
+			ecc-size = <16>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@fe101000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xfe101000 0 0x300000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <8720000>;
+		energy-full-design-microwatt-hours = <33600000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4480000>;
+	};
+
+	bl_vddpos_5p5: bl-vddpos-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl_vddpos_5p5";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		regulator-enable-ramp-delay = <233>;
+		gpio = <&tlmm 114 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	bl_vddneg_5p5: bl-vddneg-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "bl_vddneg_5p5";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		regulator-enable-ramp-delay = <233>;
+		gpio = <&tlmm 115 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	/*
+	 * Apparently RPMh does not provide support for PM8150 S4 because it
+	 * is always-on; model it as a fixed regulator.
+	 */
+	vreg_s4a_1p8: pm8150-s4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vph_pwr>;
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_n>;
+
+		key-vol-up {
+			label = "Volume Up";
+			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 9 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+};
+
+&apps_rsc {
+	pm8150-rpmh-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p9>;
+		vdd-l6-l9-supply = <&vreg_s8c_1p3>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p0>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s5a_2p0: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vreg_l1a_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2a_3p1: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <932000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5a_0p8: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9a_1p2: ldo9 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10a_2p5: ldo10 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p7: ldo13 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1880000>;
+			regulator-max-microvolt = <1880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	pm8150l-rpmh-regulators {
+		compatible = "qcom,pm8150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s8c_1p3>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+		vdd-flash-supply = <&vreg_bob>;
+		vdd-rgb-supply = <&vreg_bob>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <4000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+		};
+
+		vreg_s8c_1p3: smps8 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c_1p3: ldo2 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	/* PM8009 is not present on these boards, even if downstream sources suggest so. */
+};
+
+//SD860 additional cpu frequency
+&cpu7_opp_table {
+	cpu7_opp21: opp-2956800000 {
+		opp-hz = /bits/ 64 <2956800000>;
+		opp-peak-kBps = <8368000 51609600>;
+	};
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
+&gmu {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sm8150/xiaomi/nabu/a640_zap.mbn";
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	backlight: backlight@11 {
+		compatible = "kinetic,ktz8866";
+		reg = <0x11>;
+		vddpos-supply = <&bl_vddpos_5p5>;
+		vddneg-supply = <&bl_vddneg_5p5>;
+		enable-gpios = <&tlmm 27 GPIO_ACTIVE_HIGH>;
+		current-num-sinks = <5>;
+		kinetic,current-ramp-delay-ms = <128>;
+		kinetic,led-enable-ramp-delay-ms = <1>;
+		kinetic,enable-lcd-bias;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	typec-mux@43 {
+		compatible = "fcs,fsa4480";
+		reg = <0x43>;
+
+		vcc-supply = <&vreg_bob>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			fsa4480_sbu_mux: endpoint {
+				remote-endpoint = <&pm8150b_sbu_mux_in>;
+			};
+		};
+	};
+
+	ln8000_charger@51 {
+		compatible = "lionsemi,ln8000";
+		reg = <0x51>;
+
+		status = "disabled";
+
+		irq-gpios = <&tlmm 36 0x2002>;
+
+		usb-tcpm = <&pm8150b_typec>;
+
+		ln8000_charger,bat-ovp-threshold = <4560>;
+		ln8000_charger,bat-ovp-alarm-threshold = <4525>;
+		ln8000_charger,bus-ovp-threshold = <13000>;
+		ln8000_charger,bus-ovp-alarm-threshold = <11000>;
+		ln8000_charger,bus-ocp-threshold = <3750>;
+		ln8000_charger,bus-ocp-alarm-threshold = <3500>;
+		ln8000_charger,ntc-alarm-cfg  = <226>;
+
+		ln8000_charger,tdie-prot-disable;
+		ln8000_charger,tbus-mon-disable;
+		ln8000_charger,tbat-mon-disable;
+		ln8000_charger,iin-ocp-disable;
+		ln8000_charger,iin-reg-disable;
+		ln8000_charger,tdie-reg-disable;
+		ln8000_charger,vbat-reg-disable;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	cs35l41_br: cs35l41@40 {
+		compatible = "cirrus,cs35l41";
+		reg = <0x40>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <81 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <1>;
+		sound-name-prefix = "BR";
+		cirrus,boost-peak-milliamp = <4000>;
+		cirrus,boost-ind-nanohenry = <1000>;
+		cirrus,boost-cap-microfarad = <15>;
+		cirrus,asp-sdout-hiz = <3>;
+		cirrus,gpio2-src-select = <4>;
+		cirrus,gpio2-output-enable;
+	};
+
+	cs35l41_tr: cs35l41@41 {
+		compatible = "cirrus,cs35l41";
+		reg = <0x41>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <90 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <1>;
+		sound-name-prefix = "TR";
+		cirrus,boost-peak-milliamp = <4000>;
+		cirrus,boost-ind-nanohenry = <1000>;
+		cirrus,boost-cap-microfarad = <15>;
+		cirrus,asp-sdout-hiz = <3>;
+		cirrus,gpio2-src-select = <4>;
+		cirrus,gpio2-output-enable;
+	};
+
+	cs35l41_bl: cs35l41@42 {
+		compatible = "cirrus,cs35l41";
+		reg = <0x42>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <91 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <1>;
+		sound-name-prefix = "BL";
+		cirrus,boost-peak-milliamp = <4000>;
+		cirrus,boost-ind-nanohenry = <1000>;
+		cirrus,boost-cap-microfarad = <15>;
+		cirrus,asp-sdout-hiz = <3>;
+		cirrus,gpio2-src-select = <4>;
+		cirrus,gpio2-output-enable;
+	};
+
+	cs35l41_tl: cs35l41@43 {
+		compatible = "cirrus,cs35l41";
+		reg = <0x43>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <93 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <1>;
+		sound-name-prefix = "TL";
+		cirrus,boost-peak-milliamp = <4000>;
+		cirrus,boost-ind-nanohenry = <1000>;
+		cirrus,boost-cap-microfarad = <15>;
+		cirrus,asp-sdout-hiz = <3>;
+		cirrus,gpio2-src-select = <4>;
+		cirrus,gpio2-output-enable;
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l3c_1p2>;
+	qcom,dual-dsi-mode;
+	qcom,sync-dual-dsi;
+	qcom,master-dsi;
+	status = "okay";
+
+	display_panel: panel@0 {
+		compatible = "xiaomi,nabu-csot-nt36523", "novatek,nt36523";
+		reg = <0>;
+		vddio-supply = <&vreg_l14a_1p8>;
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+		backlight = <&backlight>;
+		rotation = <90>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				panel_in_0: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@1{
+				reg = <1>;
+
+				panel_in_1: endpoint {
+					remote-endpoint = <&mdss_dsi1_out>;
+				};
+			};
+
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2>;
+	remote-endpoint = <&panel_in_0>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p8>;
+	phy-type = <PHY_TYPE_CPHY>;
+	status = "okay";
+};
+
+&mdss_dsi1 {
+	vdda-supply = <&vreg_l3c_1p2>;
+	qcom,dual-dsi-mode;
+	qcom,sync-dual-dsi;
+	/* DSI1 is slave, so use DSI0 clocks */
+	assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+	status = "okay";
+};
+
+&mdss_dsi1_out {
+	data-lanes = <0 1 2>;
+	remote-endpoint = <&panel_in_1>;
+};
+
+&mdss_dsi1_phy {
+	vdds-supply = <&vreg_l5a_0p8>;
+	phy-type = <PHY_TYPE_CPHY>;
+	status = "okay";
+};
+
+&pm8150_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		input-enable;
+		bias-pull-up;
+	};
+};
+
+&pm8150b_fg {
+	status = "okay";
+	monitored-battery = <&battery>;
+	//power-supplies = <&ln8000_charger>;
+};
+
+&pm8150b_typec {
+	vdd-pdphy-supply = <&vreg_l2a_3p1>;
+	status = "okay";
+
+	connector {
+		compatible = "usb-c-connector";
+
+		power-role = "dual";
+		data-role = "dual";
+		self-powered;
+
+		source-pdos = <PDO_FIXED(5000, 3000,
+					 PDO_FIXED_DUAL_ROLE |
+					 PDO_FIXED_USB_COMM |
+					 PDO_FIXED_DATA_SWAP)>;
+
+		sink-pdos = <PDO_FIXED(5000, 3000,
+					 PDO_FIXED_DUAL_ROLE |
+					 PDO_FIXED_USB_COMM |
+					 PDO_FIXED_DATA_SWAP)
+					 PDO_VAR(5000, 12000, 3000)>;
+
+		op-sink-microwatt = <10000000>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				pm8150b_role_switch_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				pm8150b_sbu_mux_in: endpoint {
+					remote-endpoint = <&fsa4480_sbu_mux>;
+				};
+			};
+		};
+	};
+};
+
+&pm8150b_vbus {
+	status = "okay";
+};
+
+&pm8150l_flash {
+	status = "okay";
+
+	led-0 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>;
+		led-max-microamp = <200000>;
+		flash-max-microamp = <1000000>;
+		flash-max-timeout-us = <1280000>;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&q6afedai {
+	dai@72 {
+		reg = <QUATERNARY_TDM_RX_0>;
+		qcom,tdm-sync-mode = <1>;
+		qcom,tdm-sync-src = <1>;
+		qcom,tdm-data-out = <0>;
+		qcom,tdm-invert-sync = <1>;
+		qcom,tdm-data-delay = <1>;
+		qcom,tdm-data-align = <0>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&qupv3_id_2 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	status = "okay";
+	firmware-name = "qcom/sm8150/xiaomi/nabu/adsp.mbn";
+};
+
+&remoteproc_cdsp {
+	status = "okay";
+	firmware-name = "qcom/sm8150/xiaomi/nabu/cdsp.mbn";
+};
+
+&remoteproc_mpss {
+	status = "okay";
+	firmware-name = "qcom/sm8150/xiaomi/nabu/modem.mbn";
+};
+
+&sound {
+	compatible = "qcom,sm8150-sndcard";
+	pinctrl-0 = <&quat_tdm_active
+		&quat_tdm_sd1_active>;
+	pinctrl-names = "default";
+	model = "Xiaomi Pad 5";
+
+	audio-routing =	"RX_BIAS", "MCLK",
+		"AMIC1", "MIC BIAS3",
+		"AMIC3", "MIC BIAS4",
+		"MultiMedia1 Playback", "BR SPK",
+		"MultiMedia1 Playback", "TR SPK",
+		"MultiMedia1 Playback", "BL SPK",
+		"MultiMedia1 Playback", "TL SPK";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	speaker-dai-link {
+		link-name = "Speaker Playback";
+		cpu {
+			sound-dai = <&q6afedai QUATERNARY_TDM_RX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&cs35l41_br 0>, <&cs35l41_tr 0>,
+				<&cs35l41_bl 0>, <&cs35l41_tl 0>;
+		};
+	};
+
+	//Bottom & Top internal microphones
+	slimcap-dai-link {
+		link-name = "SLIM Capture 1";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 1>; /* AIF1_CAP */
+		};
+	};
+};
+
+&spi18 {
+	status = "okay";
+
+	touchscreen@0 {
+		compatible = "novatek,NVT-ts-spi";
+		reg = <0>;
+
+		spi-max-frequency = <9600000>;
+		novatek,irq-gpio = <&tlmm 39 0x2001>;
+
+		novatek,pen-support;
+		novatek,wgp-stylus;
+
+		/* 523 */
+		novatek,swrst-n8-addr = <0x03F0FE>;
+		novatek,spi-rd-fast-addr = <0x03F310>;
+
+		firmware-name = "novatek/novatek_nt36523_fw.bin";
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <126 4>;
+
+	quat_tdm_active: quat-tdm-active-state {
+		pins = "gpio137", "gpio138";
+		function = "qua_mi2s";
+		drive-strength = <8>;
+		bias-disable;
+		output-high;
+	};
+
+	quat_tdm_sd1_active: quat-tdm-sd1-active-state {
+		pins = "gpio140";
+		function = "qua_mi2s";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	qup_uart13_sleep: qup-uart13-sleep {
+		pinmux {
+			pins = "gpio43", "gpio44",
+			       "gpio45", "gpio46";
+			function = "gpio";
+		};
+
+		pinconf-cts {
+			/*
+			 * Configure a pull-down on CTS to match the pull of
+			 * the Bluetooth module.
+			 */
+			pins = "gpio43";
+			bias-pull-down;
+		};
+
+		pinconf-rts {
+			/*
+			 * Configure pull-down on RTS. As RTS is active low
+			 * signal, pull it low to indicate the BT SoC that it
+			 * can wakeup the system anytime from suspend state by
+			 * pulling RX low (by sending wakeup bytes).
+			 */
+			 pins = "gpio44";
+			 bias-pull-down;
+		};
+
+		pinconf-tx {
+			/*
+			 * Configure pull-up on TX when it isn't actively driven
+			 * to prevent BT SoC from receiving garbage during sleep.
+			 */
+			pins = "gpio45";
+			bias-pull-up;
+		};
+
+		pinconf-rx {
+			/*
+			 * Configure a pull-up on RX. This is needed to avoid
+			 * garbage data when the TX pin of the Bluetooth module
+			 * is floating which may cause spurious wakeups.
+			 */
+			pins = "gpio46";
+			bias-pull-up;
+		};
+	};
+
+	bl_en_state: bl-default-state {
+		bl-en {
+			pins = "gpio27";
+			function = "gpio";
+
+			drive-strength = <16>;
+			output-high;
+			bias-disable;
+		};
+	};
+
+	keyboard_active: keyboard-active-state {
+		sleep-pins {
+			pins = "gpio4";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-up;
+		};
+
+		reset-pins {
+			pins = "gpio49";
+			function = "gpio";
+			drive-strength = <4>;
+			bias-pull-up;
+			output-high;
+		};
+
+		vdd-pins {
+			pins = "gpio82";
+			function = "gpio";
+			drive-strength = <4>;
+			bias-pull-up;
+			output-high;
+		};
+	};
+
+	keyboard_suspend: keyboard-suspend-state {
+		sleep-pins {
+			pins = "gpio4";
+			function = "gpio";
+			drive-strength = <8>;
+			bias-pull-down;
+		};
+
+		reset-pins {
+			pins = "gpio49";
+			function = "gpio";
+			drive-strength = <4>;
+			bias-pull-down;
+		};
+
+		vdd-pins {
+			pins = "gpio82";
+			function = "gpio";
+			drive-strength = <4>;
+			bias-pull-down;
+		};
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart13 {
+	status = "okay";
+
+	/delete-property/interrupts;
+	interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
+				<&tlmm 46 IRQ_TYPE_EDGE_FALLING>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-1 = <&qup_uart13_sleep>;
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn3991-bt";
+		vddio-supply = <&vreg_l1a_0p75>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l2c_1p3>;
+		vddch0-supply = <&vreg_l11c_3p3>;
+		max-speed = <3200000>;
+		local-bd-address = [ 21 00 00 00 5a ad ];
+	};
+};
+
+&ufs_mem_hc {
+	status = "okay";
+
+	vcc-supply = <&vreg_l10a_2p5>;
+	vcc-max-microamp = <750000>;
+	vccq-supply = <&vreg_l9a_1p2>;
+	vccq-max-microamp = <700000>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vccq2-max-microamp = <750000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l5a_0p8>;
+	vdda-phy-max-microamp = <90200>;
+	vdda-pll-supply = <&vreg_l3c_1p2>;
+	vdda-pll-max-microamp = <19000>;
+};
+
+&usb_1 {
+	/* USB 2.0 only */
+	qcom,select-utmi-as-pipe-clk;
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	/* Remove USB3 phy */
+	phys = <&usb_1_hsphy>;
+	phy-names = "usb2-phy";
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pm8150b_role_switch_in>;
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l5a_0p8>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l2a_3p1>;
+	status = "okay";
+};
+
+&usb_2 {
+	/* USB 2.0 only */
+	qcom,select-utmi-as-pipe-clk;
+	status = "okay";
+};
+
+&usb_2_hsphy {
+	vdda-pll-supply = <&vreg_l5a_0p8>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l2a_3p1>;
+	status = "okay";
+	pinctrl-0 = <&keyboard_active>;
+	pinctrl-1 = <&keyboard_suspend>;
+	pinctrl-names = "default", "sleep";
+};
+
+&usb_2_dwc3 {
+	dr_mode = "host";
+	maximum-speed = "high-speed";
+	/* Remove USB3 phy */
+	phys = <&usb_2_hsphy>;
+	phy-names = "usb2-phy";
+};
+
+&wcd9340 {
+	reset-gpios = <&tlmm 143 GPIO_ACTIVE_HIGH>;
+	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+	vdd-buck-supply = <&vreg_s4a_1p8>;
+	vdd-tx-supply = <&vreg_s4a_1p8>;
+	vdd-rx-supply = <&vreg_s4a_1p8>;
+	vdd-io-supply = <&vreg_s4a_1p8>;
+
+	qcom,micbias1-microvolt = <1800000>;
+	qcom,micbias2-microvolt = <2750000>;
+	qcom,micbias3-microvolt = <1800000>;
+	qcom,micbias4-microvolt = <1800000>;
+
+	qcom,hphl-jack-type-normally-open;
+	qcom,ground-jack-type-normally-open;
+	qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+	qcom,mbhc-headset-vthreshold-microvolt = <2600000>;
+	qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+};
+
+&wifi {
+	status = "okay";
+
+	vdd-0.8-cx-mx-supply = <&vreg_l1a_0p75>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l2c_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
+};
+
+&pm8150_rtc {
+       nvmem-cells = <&rtc_offset>;
+       nvmem-cell-names = "offset";
+       status = "okay";
+};
+
+&pm8150_sdam_2 {
+       status = "okay";
+       rtc_offset: rtc-offset@bc {
+	       reg = <0xbc 0x4>;
+       };
+};
diff --git a/dts/upstream/src/arm64/qcom/sm8150.dtsi b/dts/upstream/src/arm64/qcom/sm8150.dtsi
index acdba79612a..264d5b2c5a9 100644
--- a/dts/upstream/src/arm64/qcom/sm8150.dtsi
+++ b/dts/upstream/src/arm64/qcom/sm8150.dtsi
@@ -9,7 +9,9 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,dispcc-sm8150.h>
 #include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
@@ -1693,6 +1695,17 @@
 				status = "disabled";
 			};
 
+			uart13: serial@c8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c8c000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart13_default>;
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c14: i2c@c90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c90000 0 0x4000>;
@@ -2074,6 +2087,8 @@
 			resets = <&gcc GCC_UFS_PHY_BCR>;
 			reset-names = "rst";
 
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
 			iommus = <&apps_smmu 0x300 0>;
 
 			clock-names =
@@ -2159,6 +2174,7 @@
 				 <&apps_smmu 0x512 0x0000>;
 			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 0 &mc_virt SLAVE_EBI_CH0 0>;
 			interconnect-names = "memory";
+			status = "disable";
 		};
 
 		tcsr_mutex: hwlock@1f40000 {
@@ -2594,6 +2610,13 @@
 				bias-disable;
 			};
 
+			qup_uart13_default: qup-uart13-default-state {
+				pins = "gpio43", "gpio44", "gpio45", "gpio46";
+				function = "qup13";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			qup_i2c14_default: qup-i2c14-default-state {
 				pins = "gpio47", "gpio48";
 				function = "qup14";
@@ -4306,6 +4329,32 @@
 			dma-coherent;
 		};
 
+		slimbam: dma-controller@17184000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			qcom,controlled-remotely;
+			reg = <0 0x17184000 0 0x2c000>;
+			num-channels = <31>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x1b46 0x0>;
+		};
+
+		slim: slim-ngd@171c0000 {
+			compatible = "qcom,slim-ngd-v2.1.0";
+			reg = <0 0x171c0000 0 0x2c000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
+
+			iommus = <&apps_smmu 0x1b46 0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		remoteproc_adsp: remoteproc@17300000 {
 			compatible = "qcom,sm8150-adsp-pas";
 			reg = <0x0 0x17300000 0x0 0x4040>;
@@ -4338,6 +4387,56 @@
 				qcom,remote-pid = <2>;
 				mboxes = <&apss_shared 8>;
 
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					apr-service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+					};
+
+					q6afe: apr-service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+
+						q6afecc: cc {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: apr-service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&apps_smmu 0x1b21 0x0>;
+						};
+					};
+
+					q6adm: apr-service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
@@ -4606,6 +4705,9 @@
 		};
 	};
 
+	sound: sound {
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
-- 
2.53.0

