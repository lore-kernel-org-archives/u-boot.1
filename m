Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2185DCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E62C848DC;
	Mon, 15 Jun 2026 14:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PpdEDuoc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ak9bMvDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAF384872; Mon, 15 Jun 2026 14:19:47 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 392BB83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FAofAv3984013
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lg7YtaT10KN
 eyS82/ZF/mKKao/3jFc4MfMUHvZxvDn0=; b=PpdEDuoc4ClMRf0BCvaCH+vAMig
 uh63KVq6OH82j3Fjhfv31niurRyf9SAfzZXRVBzOd4BkNwJquKeE3gvpMsuSdNmx
 /LWtxjSBVDgKt7VeiIGEdfjZqlVmo4k+51CJbhwgzPMtLbH9DHHvM+eCSwXO9puO
 0joUGtwxVm05a9U9b4CglvcqJz40vRwgeYG2+RdlZOFBVaCe8Jgk79E+sxWG+kHk
 sxF62O1I83Z7xHt7LyiL8Y0aG8TZoyc4xA3NVw2ulp5M0U8dNbb7bNTJoN8qwRHQ
 d/aEcnSpwQC7tbc2+zDWk8hXODJHjPxxvzeAiroHxMGMqTJbkuNY9fZIKdA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa70g3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:19:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84247fed609so1782270b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781525982; x=1782130782; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lg7YtaT10KNeyS82/ZF/mKKao/3jFc4MfMUHvZxvDn0=;
 b=ak9bMvDGQLa+WiF0OW3Tmcwy+gSgHQNR2mdhYem0mFf9c8rL5LCfpZJv+TQPRz0jMd
 kIAguQZ+2S87plj/aPU0OTHpku/TfaUAQ3HLqio1e4KE+++Yybdo8n06SBAAOsH/JFbz
 ILCi6w+ViRoTjy8J8ZSH5aDxTnzmcfJQfcxRowVQ7WHD1rEJRiwcden1gE5ivDHEVfFn
 fvuD04hkNozQcBa8lXyjvWcFeAZXEc1oK3NgEycR9vwjSvGbiSZYVhv6PpN3ak3XRUKG
 W3rQXv/Jm0nogkTly5VCy5Mo+3dKmIy8uh886MXIcM8GSNqrWlu27CewiVQQFt2ivAbY
 b+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525982; x=1782130782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lg7YtaT10KNeyS82/ZF/mKKao/3jFc4MfMUHvZxvDn0=;
 b=jCaWiwOLYwRg+iEd8URWFffmQDbDbznwVcFFTyum7ysNJeXPKKyN905gJ58EMA72ra
 i+YhKpzlr2mQ3+gh07k3SBNMIgol2tVCH2npEc7GOcwYU/RshNTzna/0CAAx8gFB9sYj
 /40WQUjucDX7AYhBYqBvGP22CmZhIBKECAO1yVCRJdR2dyC7OYJo8U/NN/3HYfZ5iRl7
 bIzAS5saIwCpNYmY7QW5tumUY3qTCQZl5SSGr7Rzh/NYK6OcjZiLPfM8TO34LGMNWcoa
 f7p19JlkNy+eAFnmfZ5KWVrquw2AvZ4JCxC+KucyDhqHjTcPqnwXzpEGU5AD21HTQGBL
 vCtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ98iLJ5fGSBV1fg6DiXfDVv71r6aCWPGH3sbDRoIJeG2KeM4Vz9d4/h8mJIJ2mxW4C4IS+Tjsw=@lists.denx.de
X-Gm-Message-State: AOJu0YypGW3OQhynkRrFpAkrXfw9a7C6vaEYSFhmRFW4IigSVQPuJUYP
 JxdUv72Q1pOlSpEi8EpRKaRKhX1Xl3wRVcfVvfgUHe3bEK67aP4eOD62ni1jfrp0i/GOTdM/fih
 es+2noYgEGKbqkm3c/MZJ98yJK8oaZ2ynMjLD1kmUw8ORuzQ1GhdA2LSB
X-Gm-Gg: Acq92OHEddEtMKyTSxhBiVycrwOJlsw3o+kW33g0IWzPV8Ugqob8L0ye8EflxxpNBfJ
 U4+rlWtQQdO9W+6Hyj76qJi6jMiKIX9QyukwBo4naz21P5a/o8ymxb/zcRuvZZhZj1WxQcAxBIa
 F3hKJx8AI9hwGJgJE3IvJjI7qkOp3BmGt387/vif1IqqUAXi/atUU+4Fu4qbCY79uyYKjHykfdc
 PPyUZrUdGPV73wBKu8eblz+7ilvNIQhqyipRiDLBF3+a33clPTpD3QHA0hjdCvJE7ElLNFOzIqR
 Tla4/QHujXwPxzo74g2RNQim5BtFpjqd0jwyFTNcWwP087krQganmUYnXJslbtSLny/4yoADE00
 Mm4U3E56yYNzwxRS8nsrlziTt10wSWQfcZFUh2db03USgbyMeQO5hyA6+mcPkMaWWcH52LX0Pcm
 DqaBoxg4NmptDqw5FxEllaR9bfZA4rwwLPTKkHT/zP
X-Received: by 2002:a05:6a00:190b:b0:841:edbf:6424 with SMTP id
 d2e1a72fcca58-8434cd42d48mr15500433b3a.13.1781525981206; 
 Mon, 15 Jun 2026 05:19:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:190b:b0:841:edbf:6424 with SMTP id
 d2e1a72fcca58-8434cd42d48mr15500368b3a.13.1781525980503; 
 Mon, 15 Jun 2026 05:19:40 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm10434823b3a.17.2026.06.15.05.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:19:40 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 kever.yang@rock-chips.com, tien.fong.chee@altera.com,
 clamor95@gmail.com, jbx6244@gmail.com, frieder.schrempf@kontron.de,
 briansune@gmail.com, andre.przywara@arm.com, hai.pham.ud@renesas.com,
 dlechner@baylibre.com, emanuele.ghidoli@toradex.com,
 nguyen.tran.pz@bp.renesas.com, j@jannau.net, contact@paulk.fr,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 david.wronek@mainlining.org, peng.fan@nxp.com, me@ziyao.cc,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 6/8] pinctrl: qcom: add driver for Shikra SoC
Date: Mon, 15 Jun 2026 17:48:26 +0530
Message-Id: <20260615121828.1798789-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
References: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rMulm-e6MmAn7L9Ur0UWK148HQafJwlO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX0lIOPT0Pffz4
 RsLrhh/bZNz08kEr4398kERmVD9yBjz9XtrcYCbyddy6HCxqn21/bV4l5ejjnI6ImnKRp0UYOwT
 X+BESI9XdT7BdLGZD3ullh4DHSajP8o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXyNS4i99gkPwe
 43cS+DpvWiB6Sfo09OG3NgAy0r3QXMPt3ourK4noP65EhmvUgd9IQnnZDrK7IAaMIuhtMUer//i
 0xqv4PvIWCFx0KqHOilTwO7hqHeiC7+RElSe+ht1vqxoSe6o1M26RzKi79oSU4gO+KQvNSIF57g
 ab0iYFeKhkUu4+iXbKwV10KGbJb1orq8IMcJR1+JUztOq2D15vbdPasF2nzS9AbNzwLOChZ6IDp
 eZil337dlUMy3/K7tQeKfgLZp3yFff3oOVeRcKZ9HoV+oOjPZ1O8vdWd7I3z7oEjSvLDcZTXVNm
 GGKULwTsYiEs+brS4tYAHtAyJWAEzKucQPUXPrEd3X9HwUOn2A5OZnpY1Jhb9lFdPVe3hh6oKxv
 C9OKgVYHe4bOW15n1lzvxatIMLSYK7r+DVwuiLb/67CqXqmOctbIrLNj6eIBXCcuvpgTdSd2qus
 iLYvCDMpKn0fydykkrw==
X-Proofpoint-GUID: rMulm-e6MmAn7L9Ur0UWK148HQafJwlO
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a2fedde cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=3-JszDDTfVxW2WV5AosA:9 a=O8hF6Hzn-FEA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130
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

Add a Qualcomm TLMM pinctrl driver for the Shikra SoC. This driver
provides pin configuration support required for enabling peripherals
on the platform.

The implementation is based on existing Qualcomm pinctrl drivers in
U-Boot and the Linux kernel, with adaptations for the Shikra pin
layout, functions, and groups.

This enables proper pin configuration during early boot on Shikra-based
boards.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig          |   8 +
 drivers/pinctrl/qcom/Makefile         |   1 +
 drivers/pinctrl/qcom/pinctrl-shikra.c | 931 ++++++++++++++++++++++++++
 3 files changed, 940 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-shikra.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 11e6763b5f3..9a7f2c2b149 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -101,6 +101,14 @@ config PINCTRL_QCOM_SC7280
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
+config PINCTRL_QCOM_SHIKRA
+	bool "Qualcomm Shikra Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Qualcomm Shikra SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 4096c1aa491..4b1aa1b965a 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
 obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
+obj-$(CONFIG_PINCTRL_QCOM_SHIKRA) += pinctrl-shikra.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM660) += pinctrl-sdm660.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM670) += pinctrl-sdm670.o
 obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o
diff --git a/drivers/pinctrl/qcom/pinctrl-shikra.c b/drivers/pinctrl/qcom/pinctrl-shikra.c
new file mode 100644
index 00000000000..1c1603fc70a
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-shikra.c
@@ -0,0 +1,931 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm Shikra pinctrl
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+#define MSM_PIN_FUNCTION_COUNT 12
+
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+typedef unsigned int msm_pin_function[MSM_PIN_FUNCTION_COUNT];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11)\
+	{\
+		msm_mux_gpio, /* gpio mode */\
+		msm_mux_##f1,\
+		msm_mux_##f2,\
+		msm_mux_##f3,\
+		msm_mux_##f4,\
+		msm_mux_##f5,\
+		msm_mux_##f6,\
+		msm_mux_##f7,\
+		msm_mux_##f8,\
+		msm_mux_##f9,\
+		msm_mux_##f10,\
+		msm_mux_##f11 /* egpio mode */\
+	}
+
+#define SDC_PINGROUP(pg_name, ctl, pull, drv)\
+	{\
+		.name = pg_name,\
+		.ctl_reg = ctl,\
+		.io_reg = 0,\
+		.pull_bit = pull,\
+		.drv_bit = drv,\
+		.oe_bit = -1,\
+		.in_bit = -1,\
+		.out_bit = -1,\
+	}
+
+enum shikra_functions {
+	msm_mux_gpio,
+	msm_mux_agera_pll,
+	msm_mux_atest_bbrx0,
+	msm_mux_atest_bbrx1,
+	msm_mux_atest_char0,
+	msm_mux_atest_char1,
+	msm_mux_atest_char2,
+	msm_mux_atest_char3,
+	msm_mux_atest_char_start,
+	msm_mux_atest_gpsadc,
+	msm_mux_atest_tsens,
+	msm_mux_atest_tsens2,
+	msm_mux_atest_usb1,
+	msm_mux_atest_usb10,
+	msm_mux_atest_usb11,
+	msm_mux_atest_usb12,
+	msm_mux_atest_usb13,
+	msm_mux_atest_usb2,
+	msm_mux_atest_usb20,
+	msm_mux_atest_usb21,
+	msm_mux_atest_usb22,
+	msm_mux_atest_usb23,
+	msm_mux_cam_mclk,
+	msm_mux_cci_async_in0,
+	msm_mux_cci_i2c_scl0,
+	msm_mux_cci_i2c_scl1,
+	msm_mux_cci_i2c_sda0,
+	msm_mux_cci_i2c_sda1,
+	msm_mux_cci_timer0,
+	msm_mux_cci_timer1,
+	msm_mux_cci_timer2,
+	msm_mux_cci_timer3,
+	msm_mux_char_exec_pending,
+	msm_mux_char_exec_release,
+	msm_mux_cri_trng,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_dac_calib0,
+	msm_mux_dac_calib1,
+	msm_mux_dac_calib10,
+	msm_mux_dac_calib11,
+	msm_mux_dac_calib12,
+	msm_mux_dac_calib13,
+	msm_mux_dac_calib14,
+	msm_mux_dac_calib15,
+	msm_mux_dac_calib16,
+	msm_mux_dac_calib17,
+	msm_mux_dac_calib18,
+	msm_mux_dac_calib19,
+	msm_mux_dac_calib2,
+	msm_mux_dac_calib20,
+	msm_mux_dac_calib21,
+	msm_mux_dac_calib22,
+	msm_mux_dac_calib23,
+	msm_mux_dac_calib24,
+	msm_mux_dac_calib25,
+	msm_mux_dac_calib3,
+	msm_mux_dac_calib4,
+	msm_mux_dac_calib5,
+	msm_mux_dac_calib6,
+	msm_mux_dac_calib7,
+	msm_mux_dac_calib8,
+	msm_mux_dac_calib9,
+	msm_mux_dbg_out_clk,
+	msm_mux_ddr_bist_complete,
+	msm_mux_ddr_bist_fail,
+	msm_mux_ddr_bist_start,
+	msm_mux_ddr_bist_stop,
+	msm_mux_ddr_pxi0,
+	msm_mux_ddr_pxi1,
+	msm_mux_dmic0_clk,
+	msm_mux_dmic0_data,
+	msm_mux_dmic1_clk,
+	msm_mux_dmic1_data,
+	msm_mux_emac0_dll,
+	msm_mux_emac0_mcg0,
+	msm_mux_emac0_mcg1,
+	msm_mux_emac0_mcg2,
+	msm_mux_emac0_mcg3,
+	msm_mux_emac0_phy,
+	msm_mux_emac0_ptp,
+	msm_mux_emac1_dll,
+	msm_mux_emac1_mcg0,
+	msm_mux_emac1_mcg1,
+	msm_mux_emac1_mcg2,
+	msm_mux_emac1_mcg3,
+	msm_mux_emac1_phy,
+	msm_mux_emac1_ptp,
+	msm_mux_ext_mclk,
+	msm_mux_gcc_gp1,
+	msm_mux_gcc_gp2,
+	msm_mux_gcc_gp3,
+	msm_mux_gsm0_tx,
+	msm_mux_i2s0_clk,
+	msm_mux_i2s0_data0,
+	msm_mux_i2s0_data1,
+	msm_mux_i2s0_data2,
+	msm_mux_i2s0_data3,
+	msm_mux_i2s0_ws,
+	msm_mux_i2s1_clk,
+	msm_mux_i2s1_data0,
+	msm_mux_i2s1_data1,
+	msm_mux_i2s1_ws,
+	msm_mux_i2s2_clk,
+	msm_mux_i2s2_data0,
+	msm_mux_i2s2_data1,
+	msm_mux_i2s2_ws,
+	msm_mux_i2s3_clk,
+	msm_mux_i2s3_data0,
+	msm_mux_i2s3_data1,
+	msm_mux_i2s3_ws,
+	msm_mux_jitter_bist,
+	msm_mux_m_voc,
+	msm_mux_mdp_vsync,
+	msm_mux_mdp_vsync_e,
+	msm_mux_mdp_vsync_p,
+	msm_mux_mdp_vsync_s,
+	msm_mux_mpm_pwr,
+	msm_mux_mss_lte,
+	msm_mux_nav_gpio,
+	msm_mux_pa_indicator_or,
+	msm_mux_pbs_in0,
+	msm_mux_pbs_in1,
+	msm_mux_pbs_in10,
+	msm_mux_pbs_in11,
+	msm_mux_pbs_in12,
+	msm_mux_pbs_in13,
+	msm_mux_pbs_in14,
+	msm_mux_pbs_in15,
+	msm_mux_pbs_in2,
+	msm_mux_pbs_in3,
+	msm_mux_pbs_in4,
+	msm_mux_pbs_in5,
+	msm_mux_pbs_in6,
+	msm_mux_pbs_in7,
+	msm_mux_pbs_in8,
+	msm_mux_pbs_in9,
+	msm_mux_pbs_out_0,
+	msm_mux_pbs_out_1,
+	msm_mux_pbs_out_2,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_phase_flag0,
+	msm_mux_phase_flag1,
+	msm_mux_phase_flag10,
+	msm_mux_phase_flag11,
+	msm_mux_phase_flag12,
+	msm_mux_phase_flag13,
+	msm_mux_phase_flag14,
+	msm_mux_phase_flag15,
+	msm_mux_phase_flag16,
+	msm_mux_phase_flag17,
+	msm_mux_phase_flag18,
+	msm_mux_phase_flag19,
+	msm_mux_phase_flag2,
+	msm_mux_phase_flag20,
+	msm_mux_phase_flag21,
+	msm_mux_phase_flag22,
+	msm_mux_phase_flag23,
+	msm_mux_phase_flag24,
+	msm_mux_phase_flag25,
+	msm_mux_phase_flag26,
+	msm_mux_phase_flag27,
+	msm_mux_phase_flag28,
+	msm_mux_phase_flag29,
+	msm_mux_phase_flag3,
+	msm_mux_phase_flag30,
+	msm_mux_phase_flag31,
+	msm_mux_phase_flag4,
+	msm_mux_phase_flag5,
+	msm_mux_phase_flag6,
+	msm_mux_phase_flag7,
+	msm_mux_phase_flag8,
+	msm_mux_phase_flag9,
+	msm_mux_pll_bist,
+	msm_mux_pll_bypassnl,
+	msm_mux_pll_clk,
+	msm_mux_pll_reset_n,
+	msm_mux_prng_rosc,
+	msm_mux_pwm_0_mira,
+	msm_mux_pwm_0_mirb,
+	msm_mux_pwm_1_mira,
+	msm_mux_pwm_1_mirb,
+	msm_mux_pwm_2_mira,
+	msm_mux_pwm_2_mirb,
+	msm_mux_pwm_3,
+	msm_mux_pwm_4,
+	msm_mux_pwm_5,
+	msm_mux_pwm_6_mira,
+	msm_mux_pwm_6_mirb,
+	msm_mux_pwm_7_mira,
+	msm_mux_pwm_7_mirb,
+	msm_mux_pwm_8_mira,
+	msm_mux_pwm_8_mirb,
+	msm_mux_pwm_9_mira,
+	msm_mux_pwm_9_mirb,
+	msm_mux_qdss_cti,
+	msm_mux_qup0_se0_l0,
+	msm_mux_qup0_se0_l1,
+	msm_mux_qup0_se0_l2,
+	msm_mux_qup0_se0_l3,
+	msm_mux_qup0_se1_l0,
+	msm_mux_qup0_se1_l1,
+	msm_mux_qup0_se1_l2_mira,
+	msm_mux_qup0_se1_l2_mirb,
+	msm_mux_qup0_se1_l3_mira,
+	msm_mux_qup0_se1_l3_mirb,
+	msm_mux_qup0_se2_l0,
+	msm_mux_qup0_se2_l1,
+	msm_mux_qup0_se2_l2,
+	msm_mux_qup0_se2_l3,
+	msm_mux_qup0_se2_l4,
+	msm_mux_qup0_se2_l5,
+	msm_mux_qup0_se3_l0,
+	msm_mux_qup0_se3_l1,
+	msm_mux_qup0_se3_l2,
+	msm_mux_qup0_se3_l3,
+	msm_mux_qup0_se4_l0,
+	msm_mux_qup0_se4_l1,
+	msm_mux_qup0_se4_l2,
+	msm_mux_qup0_se4_l3,
+	msm_mux_qup0_se5_l0,
+	msm_mux_qup0_se5_l1,
+	msm_mux_qup0_se5_l2,
+	msm_mux_qup0_se5_l3,
+	msm_mux_qup0_se6_l0,
+	msm_mux_qup0_se6_l1,
+	msm_mux_qup0_se6_l2,
+	msm_mux_qup0_se6_l3,
+	msm_mux_qup0_se6_l4,
+	msm_mux_qup0_se6_l5,
+	msm_mux_qup0_se7_l0,
+	msm_mux_qup0_se7_l1,
+	msm_mux_qup0_se7_l2,
+	msm_mux_qup0_se7_l3,
+	msm_mux_qup0_se8_l0,
+	msm_mux_qup0_se8_l1,
+	msm_mux_qup0_se8_l2,
+	msm_mux_qup0_se8_l3,
+	msm_mux_qup0_se9_l0_mira,
+	msm_mux_qup0_se9_l0_mirb,
+	msm_mux_qup0_se9_l1_mira,
+	msm_mux_qup0_se9_l1_mirb,
+	msm_mux_qup0_se9_l2_mira,
+	msm_mux_qup0_se9_l2_mirb,
+	msm_mux_qup0_se9_l3_mira,
+	msm_mux_qup0_se9_l3_mirb,
+	msm_mux_rgmii0_mdc,
+	msm_mux_rgmii0_mdio,
+	msm_mux_rgmii0_rx_ctl,
+	msm_mux_rgmii0_rxc,
+	msm_mux_rgmii0_rxd0,
+	msm_mux_rgmii0_rxd1,
+	msm_mux_rgmii0_rxd2,
+	msm_mux_rgmii0_rxd3,
+	msm_mux_rgmii0_tx_ctl,
+	msm_mux_rgmii0_txc,
+	msm_mux_rgmii0_txd0,
+	msm_mux_rgmii0_txd1,
+	msm_mux_rgmii0_txd2,
+	msm_mux_rgmii0_txd3,
+	msm_mux_rgmii1_mdc,
+	msm_mux_rgmii1_mdio,
+	msm_mux_rgmii1_rx_ctl,
+	msm_mux_rgmii1_rxc,
+	msm_mux_rgmii1_rxd0,
+	msm_mux_rgmii1_rxd1,
+	msm_mux_rgmii1_rxd2,
+	msm_mux_rgmii1_rxd3,
+	msm_mux_rgmii1_tx_ctl,
+	msm_mux_rgmii1_txc,
+	msm_mux_rgmii1_txd0,
+	msm_mux_rgmii1_txd1,
+	msm_mux_rgmii1_txd2,
+	msm_mux_rgmii1_txd3,
+	msm_mux_sd_write_protect,
+	msm_mux_sdc1_tb_trig,
+	msm_mux_sdc2_tb_trig,
+	msm_mux_ssbi_wtr0,
+	msm_mux_ssbi_wtr1,
+	msm_mux_ssbi_wtr2,
+	msm_mux_ssbi_wtr3,
+	msm_mux_swr0_rx_clk,
+	msm_mux_swr0_rx_data0,
+	msm_mux_swr0_rx_data1,
+	msm_mux_swr0_tx_clk,
+	msm_mux_swr0_tx_data0,
+	msm_mux_tgu_ch0_trigout,
+	msm_mux_tgu_ch1_trigout,
+	msm_mux_tgu_ch2_trigout,
+	msm_mux_tgu_ch3_trigout,
+	msm_mux_tsc_async,
+	msm_mux_tsense_pwm,
+	msm_mux_uim1_clk,
+	msm_mux_uim1_data,
+	msm_mux_uim1_present,
+	msm_mux_uim1_reset,
+	msm_mux_uim2_clk,
+	msm_mux_uim2_data,
+	msm_mux_uim2_present,
+	msm_mux_uim2_reset,
+	msm_mux_unused_adsp,
+	msm_mux_unused_gsm1,
+	msm_mux_usb0_phy_ps,
+	msm_mux_vfr_1,
+	msm_mux_vsense_trigger_mirnat,
+	msm_mux_wlan1_adc0,
+	msm_mux_wlan1_adc1,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(agera_pll),
+	MSM_PIN_FUNCTION(atest_bbrx0),
+	MSM_PIN_FUNCTION(atest_bbrx1),
+	MSM_PIN_FUNCTION(atest_char0),
+	MSM_PIN_FUNCTION(atest_char1),
+	MSM_PIN_FUNCTION(atest_char2),
+	MSM_PIN_FUNCTION(atest_char3),
+	MSM_PIN_FUNCTION(atest_char_start),
+	MSM_PIN_FUNCTION(atest_gpsadc),
+	MSM_PIN_FUNCTION(atest_tsens),
+	MSM_PIN_FUNCTION(atest_tsens2),
+	MSM_PIN_FUNCTION(atest_usb1),
+	MSM_PIN_FUNCTION(atest_usb10),
+	MSM_PIN_FUNCTION(atest_usb11),
+	MSM_PIN_FUNCTION(atest_usb12),
+	MSM_PIN_FUNCTION(atest_usb13),
+	MSM_PIN_FUNCTION(atest_usb2),
+	MSM_PIN_FUNCTION(atest_usb20),
+	MSM_PIN_FUNCTION(atest_usb21),
+	MSM_PIN_FUNCTION(atest_usb22),
+	MSM_PIN_FUNCTION(atest_usb23),
+	MSM_PIN_FUNCTION(cam_mclk),
+	MSM_PIN_FUNCTION(cci_async_in0),
+	MSM_PIN_FUNCTION(cci_i2c_scl0),
+	MSM_PIN_FUNCTION(cci_i2c_scl1),
+	MSM_PIN_FUNCTION(cci_i2c_sda0),
+	MSM_PIN_FUNCTION(cci_i2c_sda1),
+	MSM_PIN_FUNCTION(cci_timer0),
+	MSM_PIN_FUNCTION(cci_timer1),
+	MSM_PIN_FUNCTION(cci_timer2),
+	MSM_PIN_FUNCTION(cci_timer3),
+	MSM_PIN_FUNCTION(char_exec_pending),
+	MSM_PIN_FUNCTION(char_exec_release),
+	MSM_PIN_FUNCTION(cri_trng),
+	MSM_PIN_FUNCTION(cri_trng0),
+	MSM_PIN_FUNCTION(cri_trng1),
+	MSM_PIN_FUNCTION(dac_calib0),
+	MSM_PIN_FUNCTION(dac_calib1),
+	MSM_PIN_FUNCTION(dac_calib10),
+	MSM_PIN_FUNCTION(dac_calib11),
+	MSM_PIN_FUNCTION(dac_calib12),
+	MSM_PIN_FUNCTION(dac_calib13),
+	MSM_PIN_FUNCTION(dac_calib14),
+	MSM_PIN_FUNCTION(dac_calib15),
+	MSM_PIN_FUNCTION(dac_calib16),
+	MSM_PIN_FUNCTION(dac_calib17),
+	MSM_PIN_FUNCTION(dac_calib18),
+	MSM_PIN_FUNCTION(dac_calib19),
+	MSM_PIN_FUNCTION(dac_calib2),
+	MSM_PIN_FUNCTION(dac_calib20),
+	MSM_PIN_FUNCTION(dac_calib21),
+	MSM_PIN_FUNCTION(dac_calib22),
+	MSM_PIN_FUNCTION(dac_calib23),
+	MSM_PIN_FUNCTION(dac_calib24),
+	MSM_PIN_FUNCTION(dac_calib25),
+	MSM_PIN_FUNCTION(dac_calib3),
+	MSM_PIN_FUNCTION(dac_calib4),
+	MSM_PIN_FUNCTION(dac_calib5),
+	MSM_PIN_FUNCTION(dac_calib6),
+	MSM_PIN_FUNCTION(dac_calib7),
+	MSM_PIN_FUNCTION(dac_calib8),
+	MSM_PIN_FUNCTION(dac_calib9),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(ddr_bist_complete),
+	MSM_PIN_FUNCTION(ddr_bist_fail),
+	MSM_PIN_FUNCTION(ddr_bist_start),
+	MSM_PIN_FUNCTION(ddr_bist_stop),
+	MSM_PIN_FUNCTION(ddr_pxi0),
+	MSM_PIN_FUNCTION(ddr_pxi1),
+	MSM_PIN_FUNCTION(dmic0_clk),
+	MSM_PIN_FUNCTION(dmic0_data),
+	MSM_PIN_FUNCTION(dmic1_clk),
+	MSM_PIN_FUNCTION(dmic1_data),
+	MSM_PIN_FUNCTION(emac0_dll),
+	MSM_PIN_FUNCTION(emac0_mcg0),
+	MSM_PIN_FUNCTION(emac0_mcg1),
+	MSM_PIN_FUNCTION(emac0_mcg2),
+	MSM_PIN_FUNCTION(emac0_mcg3),
+	MSM_PIN_FUNCTION(emac0_phy),
+	MSM_PIN_FUNCTION(emac0_ptp),
+	MSM_PIN_FUNCTION(emac1_dll),
+	MSM_PIN_FUNCTION(emac1_mcg0),
+	MSM_PIN_FUNCTION(emac1_mcg1),
+	MSM_PIN_FUNCTION(emac1_mcg2),
+	MSM_PIN_FUNCTION(emac1_mcg3),
+	MSM_PIN_FUNCTION(emac1_phy),
+	MSM_PIN_FUNCTION(emac1_ptp),
+	MSM_PIN_FUNCTION(ext_mclk),
+	MSM_PIN_FUNCTION(gcc_gp1),
+	MSM_PIN_FUNCTION(gcc_gp2),
+	MSM_PIN_FUNCTION(gcc_gp3),
+	MSM_PIN_FUNCTION(gsm0_tx),
+	MSM_PIN_FUNCTION(i2s0_clk),
+	MSM_PIN_FUNCTION(i2s0_data0),
+	MSM_PIN_FUNCTION(i2s0_data1),
+	MSM_PIN_FUNCTION(i2s0_data2),
+	MSM_PIN_FUNCTION(i2s0_data3),
+	MSM_PIN_FUNCTION(i2s0_ws),
+	MSM_PIN_FUNCTION(i2s1_clk),
+	MSM_PIN_FUNCTION(i2s1_data0),
+	MSM_PIN_FUNCTION(i2s1_data1),
+	MSM_PIN_FUNCTION(i2s1_ws),
+	MSM_PIN_FUNCTION(i2s2_clk),
+	MSM_PIN_FUNCTION(i2s2_data0),
+	MSM_PIN_FUNCTION(i2s2_data1),
+	MSM_PIN_FUNCTION(i2s2_ws),
+	MSM_PIN_FUNCTION(i2s3_clk),
+	MSM_PIN_FUNCTION(i2s3_data0),
+	MSM_PIN_FUNCTION(i2s3_data1),
+	MSM_PIN_FUNCTION(i2s3_ws),
+	MSM_PIN_FUNCTION(jitter_bist),
+	MSM_PIN_FUNCTION(m_voc),
+	MSM_PIN_FUNCTION(mdp_vsync),
+	MSM_PIN_FUNCTION(mdp_vsync_e),
+	MSM_PIN_FUNCTION(mdp_vsync_p),
+	MSM_PIN_FUNCTION(mdp_vsync_s),
+	MSM_PIN_FUNCTION(mpm_pwr),
+	MSM_PIN_FUNCTION(mss_lte),
+	MSM_PIN_FUNCTION(nav_gpio),
+	MSM_PIN_FUNCTION(pa_indicator_or),
+	MSM_PIN_FUNCTION(pbs_in0),
+	MSM_PIN_FUNCTION(pbs_in1),
+	MSM_PIN_FUNCTION(pbs_in10),
+	MSM_PIN_FUNCTION(pbs_in11),
+	MSM_PIN_FUNCTION(pbs_in12),
+	MSM_PIN_FUNCTION(pbs_in13),
+	MSM_PIN_FUNCTION(pbs_in14),
+	MSM_PIN_FUNCTION(pbs_in15),
+	MSM_PIN_FUNCTION(pbs_in2),
+	MSM_PIN_FUNCTION(pbs_in3),
+	MSM_PIN_FUNCTION(pbs_in4),
+	MSM_PIN_FUNCTION(pbs_in5),
+	MSM_PIN_FUNCTION(pbs_in6),
+	MSM_PIN_FUNCTION(pbs_in7),
+	MSM_PIN_FUNCTION(pbs_in8),
+	MSM_PIN_FUNCTION(pbs_in9),
+	MSM_PIN_FUNCTION(pbs_out_0),
+	MSM_PIN_FUNCTION(pbs_out_1),
+	MSM_PIN_FUNCTION(pbs_out_2),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(phase_flag0),
+	MSM_PIN_FUNCTION(phase_flag1),
+	MSM_PIN_FUNCTION(phase_flag10),
+	MSM_PIN_FUNCTION(phase_flag11),
+	MSM_PIN_FUNCTION(phase_flag12),
+	MSM_PIN_FUNCTION(phase_flag13),
+	MSM_PIN_FUNCTION(phase_flag14),
+	MSM_PIN_FUNCTION(phase_flag15),
+	MSM_PIN_FUNCTION(phase_flag16),
+	MSM_PIN_FUNCTION(phase_flag17),
+	MSM_PIN_FUNCTION(phase_flag18),
+	MSM_PIN_FUNCTION(phase_flag19),
+	MSM_PIN_FUNCTION(phase_flag2),
+	MSM_PIN_FUNCTION(phase_flag20),
+	MSM_PIN_FUNCTION(phase_flag21),
+	MSM_PIN_FUNCTION(phase_flag22),
+	MSM_PIN_FUNCTION(phase_flag23),
+	MSM_PIN_FUNCTION(phase_flag24),
+	MSM_PIN_FUNCTION(phase_flag25),
+	MSM_PIN_FUNCTION(phase_flag26),
+	MSM_PIN_FUNCTION(phase_flag27),
+	MSM_PIN_FUNCTION(phase_flag28),
+	MSM_PIN_FUNCTION(phase_flag29),
+	MSM_PIN_FUNCTION(phase_flag3),
+	MSM_PIN_FUNCTION(phase_flag30),
+	MSM_PIN_FUNCTION(phase_flag31),
+	MSM_PIN_FUNCTION(phase_flag4),
+	MSM_PIN_FUNCTION(phase_flag5),
+	MSM_PIN_FUNCTION(phase_flag6),
+	MSM_PIN_FUNCTION(phase_flag7),
+	MSM_PIN_FUNCTION(phase_flag8),
+	MSM_PIN_FUNCTION(phase_flag9),
+	MSM_PIN_FUNCTION(pll_bist),
+	MSM_PIN_FUNCTION(pll_bypassnl),
+	MSM_PIN_FUNCTION(pll_clk),
+	MSM_PIN_FUNCTION(pll_reset_n),
+	MSM_PIN_FUNCTION(prng_rosc),
+	MSM_PIN_FUNCTION(pwm_0_mira),
+	MSM_PIN_FUNCTION(pwm_0_mirb),
+	MSM_PIN_FUNCTION(pwm_1_mira),
+	MSM_PIN_FUNCTION(pwm_1_mirb),
+	MSM_PIN_FUNCTION(pwm_2_mira),
+	MSM_PIN_FUNCTION(pwm_2_mirb),
+	MSM_PIN_FUNCTION(pwm_3),
+	MSM_PIN_FUNCTION(pwm_4),
+	MSM_PIN_FUNCTION(pwm_5),
+	MSM_PIN_FUNCTION(pwm_6_mira),
+	MSM_PIN_FUNCTION(pwm_6_mirb),
+	MSM_PIN_FUNCTION(pwm_7_mira),
+	MSM_PIN_FUNCTION(pwm_7_mirb),
+	MSM_PIN_FUNCTION(pwm_8_mira),
+	MSM_PIN_FUNCTION(pwm_8_mirb),
+	MSM_PIN_FUNCTION(pwm_9_mira),
+	MSM_PIN_FUNCTION(pwm_9_mirb),
+	MSM_PIN_FUNCTION(qdss_cti),
+	MSM_PIN_FUNCTION(qup0_se0_l0),
+	MSM_PIN_FUNCTION(qup0_se0_l1),
+	MSM_PIN_FUNCTION(qup0_se0_l2),
+	MSM_PIN_FUNCTION(qup0_se0_l3),
+	MSM_PIN_FUNCTION(qup0_se1_l0),
+	MSM_PIN_FUNCTION(qup0_se1_l1),
+	MSM_PIN_FUNCTION(qup0_se1_l2_mira),
+	MSM_PIN_FUNCTION(qup0_se1_l2_mirb),
+	MSM_PIN_FUNCTION(qup0_se1_l3_mira),
+	MSM_PIN_FUNCTION(qup0_se1_l3_mirb),
+	MSM_PIN_FUNCTION(qup0_se2_l0),
+	MSM_PIN_FUNCTION(qup0_se2_l1),
+	MSM_PIN_FUNCTION(qup0_se2_l2),
+	MSM_PIN_FUNCTION(qup0_se2_l3),
+	MSM_PIN_FUNCTION(qup0_se2_l4),
+	MSM_PIN_FUNCTION(qup0_se2_l5),
+	MSM_PIN_FUNCTION(qup0_se3_l0),
+	MSM_PIN_FUNCTION(qup0_se3_l1),
+	MSM_PIN_FUNCTION(qup0_se3_l2),
+	MSM_PIN_FUNCTION(qup0_se3_l3),
+	MSM_PIN_FUNCTION(qup0_se4_l0),
+	MSM_PIN_FUNCTION(qup0_se4_l1),
+	MSM_PIN_FUNCTION(qup0_se4_l2),
+	MSM_PIN_FUNCTION(qup0_se4_l3),
+	MSM_PIN_FUNCTION(qup0_se5_l0),
+	MSM_PIN_FUNCTION(qup0_se5_l1),
+	MSM_PIN_FUNCTION(qup0_se5_l2),
+	MSM_PIN_FUNCTION(qup0_se5_l3),
+	MSM_PIN_FUNCTION(qup0_se6_l0),
+	MSM_PIN_FUNCTION(qup0_se6_l1),
+	MSM_PIN_FUNCTION(qup0_se6_l2),
+	MSM_PIN_FUNCTION(qup0_se6_l3),
+	MSM_PIN_FUNCTION(qup0_se6_l4),
+	MSM_PIN_FUNCTION(qup0_se6_l5),
+	MSM_PIN_FUNCTION(qup0_se7_l0),
+	MSM_PIN_FUNCTION(qup0_se7_l1),
+	MSM_PIN_FUNCTION(qup0_se7_l2),
+	MSM_PIN_FUNCTION(qup0_se7_l3),
+	MSM_PIN_FUNCTION(qup0_se8_l0),
+	MSM_PIN_FUNCTION(qup0_se8_l1),
+	MSM_PIN_FUNCTION(qup0_se8_l2),
+	MSM_PIN_FUNCTION(qup0_se8_l3),
+	MSM_PIN_FUNCTION(qup0_se9_l0_mira),
+	MSM_PIN_FUNCTION(qup0_se9_l0_mirb),
+	MSM_PIN_FUNCTION(qup0_se9_l1_mira),
+	MSM_PIN_FUNCTION(qup0_se9_l1_mirb),
+	MSM_PIN_FUNCTION(qup0_se9_l2_mira),
+	MSM_PIN_FUNCTION(qup0_se9_l2_mirb),
+	MSM_PIN_FUNCTION(qup0_se9_l3_mira),
+	MSM_PIN_FUNCTION(qup0_se9_l3_mirb),
+	MSM_PIN_FUNCTION(rgmii0_mdc),
+	MSM_PIN_FUNCTION(rgmii0_mdio),
+	MSM_PIN_FUNCTION(rgmii0_rx_ctl),
+	MSM_PIN_FUNCTION(rgmii0_rxc),
+	MSM_PIN_FUNCTION(rgmii0_rxd0),
+	MSM_PIN_FUNCTION(rgmii0_rxd1),
+	MSM_PIN_FUNCTION(rgmii0_rxd2),
+	MSM_PIN_FUNCTION(rgmii0_rxd3),
+	MSM_PIN_FUNCTION(rgmii0_tx_ctl),
+	MSM_PIN_FUNCTION(rgmii0_txc),
+	MSM_PIN_FUNCTION(rgmii0_txd0),
+	MSM_PIN_FUNCTION(rgmii0_txd1),
+	MSM_PIN_FUNCTION(rgmii0_txd2),
+	MSM_PIN_FUNCTION(rgmii0_txd3),
+	MSM_PIN_FUNCTION(rgmii1_mdc),
+	MSM_PIN_FUNCTION(rgmii1_mdio),
+	MSM_PIN_FUNCTION(rgmii1_rx_ctl),
+	MSM_PIN_FUNCTION(rgmii1_rxc),
+	MSM_PIN_FUNCTION(rgmii1_rxd0),
+	MSM_PIN_FUNCTION(rgmii1_rxd1),
+	MSM_PIN_FUNCTION(rgmii1_rxd2),
+	MSM_PIN_FUNCTION(rgmii1_rxd3),
+	MSM_PIN_FUNCTION(rgmii1_tx_ctl),
+	MSM_PIN_FUNCTION(rgmii1_txc),
+	MSM_PIN_FUNCTION(rgmii1_txd0),
+	MSM_PIN_FUNCTION(rgmii1_txd1),
+	MSM_PIN_FUNCTION(rgmii1_txd2),
+	MSM_PIN_FUNCTION(rgmii1_txd3),
+	MSM_PIN_FUNCTION(sd_write_protect),
+	MSM_PIN_FUNCTION(sdc1_tb_trig),
+	MSM_PIN_FUNCTION(sdc2_tb_trig),
+	MSM_PIN_FUNCTION(ssbi_wtr0),
+	MSM_PIN_FUNCTION(ssbi_wtr1),
+	MSM_PIN_FUNCTION(ssbi_wtr2),
+	MSM_PIN_FUNCTION(ssbi_wtr3),
+	MSM_PIN_FUNCTION(swr0_rx_clk),
+	MSM_PIN_FUNCTION(swr0_rx_data0),
+	MSM_PIN_FUNCTION(swr0_rx_data1),
+	MSM_PIN_FUNCTION(swr0_tx_clk),
+	MSM_PIN_FUNCTION(swr0_tx_data0),
+	MSM_PIN_FUNCTION(tgu_ch0_trigout),
+	MSM_PIN_FUNCTION(tgu_ch1_trigout),
+	MSM_PIN_FUNCTION(tgu_ch2_trigout),
+	MSM_PIN_FUNCTION(tgu_ch3_trigout),
+	MSM_PIN_FUNCTION(tsc_async),
+	MSM_PIN_FUNCTION(tsense_pwm),
+	MSM_PIN_FUNCTION(uim1_clk),
+	MSM_PIN_FUNCTION(uim1_data),
+	MSM_PIN_FUNCTION(uim1_present),
+	MSM_PIN_FUNCTION(uim1_reset),
+	MSM_PIN_FUNCTION(uim2_clk),
+	MSM_PIN_FUNCTION(uim2_data),
+	MSM_PIN_FUNCTION(uim2_present),
+	MSM_PIN_FUNCTION(uim2_reset),
+	MSM_PIN_FUNCTION(unused_adsp),
+	MSM_PIN_FUNCTION(unused_gsm1),
+	MSM_PIN_FUNCTION(usb0_phy_ps),
+	MSM_PIN_FUNCTION(vfr_1),
+	MSM_PIN_FUNCTION(vsense_trigger_mirnat),
+	MSM_PIN_FUNCTION(wlan1_adc0),
+	MSM_PIN_FUNCTION(wlan1_adc1),
+};
+
+static const msm_pin_function shikra_pin_functions[] = {
+	[0] = PINGROUP(0, qup0_se0_l2, m_voc, _, phase_flag6, _, _, _, _, _, _, _),
+	[1] = PINGROUP(1, qup0_se0_l3, mpm_pwr, ddr_bist_fail, _,
+		       phase_flag0, atest_tsens, _, _, _, _, _),
+	[2] = PINGROUP(2, qup0_se0_l0, ddr_bist_start, _, phase_flag1,
+		       atest_tsens2, _, _, _, _, _, _),
+	[3] = PINGROUP(3, qup0_se0_l1, ddr_bist_stop, _, phase_flag2, dac_calib0, _, _, _, _, _, _),
+	[4] = PINGROUP(4, qup0_se1_l2_mira, qup0_se1_l1,
+		       ddr_bist_complete, _, phase_flag22, dac_calib1, _,
+		       _, _, _, _),
+	[5] = PINGROUP(5, qup0_se1_l3_mira, qup0_se1_l0, _,
+		       phase_flag23, dac_calib2, _, _, _, _, _, _),
+	[6] = PINGROUP(6, qup0_se2_l0, cri_trng0, _, phase_flag24, dac_calib3, _, _, _, _, _, _),
+	[7] = PINGROUP(7, qup0_se2_l1, cri_trng1, _, phase_flag25, dac_calib4, _, _, _, _, _, _),
+	[8] = PINGROUP(8, qup0_se2_l2, _, phase_flag26, dac_calib5, _, _, _, _, _, _, _),
+	[9] = PINGROUP(9, qup0_se2_l3, _, phase_flag27, dac_calib6, _, _, _, _, _, _, _),
+	[10] = PINGROUP(10, qup0_se3_l0, qup0_se3_l3, _, _, _, _, _, _, _, _, _),
+	[11] = PINGROUP(11, qup0_se3_l1, qup0_se3_l2, _, phase_flag11, _, _, _, _, _, _, _),
+	[12] = PINGROUP(12, qup0_se4_l0, qup0_se4_l3, char_exec_release, _, _, _, _, _, _, _, _),
+	[13] = PINGROUP(13, qup0_se4_l1, qup0_se4_l2, char_exec_pending, _, _, _, _, _, _, _, _),
+	[14] = PINGROUP(14, qup0_se5_l0, pll_clk, tgu_ch0_trigout,
+			dac_calib7, wlan1_adc0, _, _, _, _, _, _),
+	[15] = PINGROUP(15, qup0_se5_l1, tgu_ch1_trigout, _,
+			dac_calib8, wlan1_adc1, _, _, _, _, _, _),
+	[16] = PINGROUP(16, qup0_se5_l2, tgu_ch2_trigout, _,
+			phase_flag30, dac_calib9, _, _, _, _, _, _),
+	[17] = PINGROUP(17, qup0_se5_l3, tgu_ch3_trigout, _,
+			phase_flag31, dac_calib10, _, _, _, _, _, _),
+	[18] = PINGROUP(18, qup0_se6_l0, dac_calib11, _, _, _, _, _, _, _, _, _),
+	[19] = PINGROUP(19, qup0_se6_l1, dac_calib12, _, _, _, _, _, _, _, _, _),
+	[20] = PINGROUP(20, qup0_se7_l0, qup0_se7_l3, cri_trng, _, _, _, _, _, _, _, _),
+	[21] = PINGROUP(21, qup0_se7_l1, qup0_se7_l2, tsense_pwm, _, _, _, _, _, _, _, _),
+	[22] = PINGROUP(22, qup0_se8_l0, pll_clk, agera_pll, pbs_out_1, _, _, _, _, _, _, _),
+	[23] = PINGROUP(23, qup0_se8_l1, agera_pll, pbs_out_2, _, _, _, _, _, _, _, _),
+	[24] = PINGROUP(24, qup0_se8_l2, pbs_out_0, _, _, _, _, _, _, _, _, _),
+	[25] = PINGROUP(25, qup0_se8_l3, _, _, _, _, _, _, _, _, _, _),
+	[26] = PINGROUP(26, qup0_se9_l2_mira, qup0_se9_l1_mira, _, _, _, _, _, _, _, _, _),
+	[27] = PINGROUP(27, qup0_se9_l3_mira, qup0_se9_l0_mira, prng_rosc, _, _, _, _, _, _, _, _),
+	[28] = PINGROUP(28, qup0_se1_l2_mirb, qup0_se6_l2, emac1_mcg1,
+			prng_rosc, _, phase_flag14, qdss_cti, _, _, _, _),
+	[29] = PINGROUP(29, qup0_se1_l3_mirb, qup0_se6_l3, emac1_mcg0,
+			_, phase_flag28, qdss_cti, _, _, _, _, _),
+	[30] = PINGROUP(30, qup0_se2_l4, qup0_se6_l4, _, phase_flag29, qdss_cti, _, _, _, _, _, _),
+	[31] = PINGROUP(31, qup0_se2_l5, qup0_se6_l5, emac1_ptp,
+			emac1_ptp, _, phase_flag21, qdss_cti, _, _, _, _),
+	[32] = PINGROUP(32, pwm_0_mira, sdc2_tb_trig, _, _, _, _, _, _, _, _, _),
+	[33] = PINGROUP(33, emac1_ptp, emac1_ptp, sdc1_tb_trig, _, _, _, _, _, _, _, _),
+	[34] = PINGROUP(34, cam_mclk, _, _, _, _, _, _, _, _, _, _),
+	[35] = PINGROUP(35, cam_mclk, unused_adsp, _, _, _, _, _, _, _, _, _),
+	[36] = PINGROUP(36, cci_i2c_sda0, _, _, _, _, _, _, _, _, _, _),
+	[37] = PINGROUP(37, cci_i2c_scl0, _, _, _, _, _, _, _, _, _, _),
+	[38] = PINGROUP(38, cci_timer0, _, _, _, _, _, _, _, _, _, _),
+	[39] = PINGROUP(39, cci_async_in0, _, _, _, _, _, _, _, _, _, _),
+	[40] = PINGROUP(40, cci_timer2, emac1_mcg2, pwm_1_mira, _, _, _, _, _, _, _, _),
+	[41] = PINGROUP(41, cci_i2c_sda1, _, _, _, _, _, _, _, _, _, _),
+	[42] = PINGROUP(42, cci_i2c_scl1, _, _, _, _, _, _, _, _, _, _),
+	[43] = PINGROUP(43, cci_timer3, emac0_mcg3, pll_bist, _, _, _, _, _, _, _, _),
+	[44] = PINGROUP(44, emac0_mcg2, pll_bist, _, _, _, _, _, _, _, _, _),
+	[45] = PINGROUP(45, tsc_async, emac0_mcg1, pwm_7_mira, gcc_gp1, _, _, _, _, _, _, _),
+	[46] = PINGROUP(46, tsc_async, emac0_mcg0, _, _, _, _, _, _, _, _, _),
+	[47] = PINGROUP(47, cci_timer1, emac1_mcg3, _, _, _, _, _, _, _, _, _),
+	[48] = PINGROUP(48, _, qup0_se9_l0_mirb, _, _, pbs_in2, phase_flag7, _, _, _, _, _),
+	[49] = PINGROUP(49, _, qup0_se9_l1_mirb, _, _, pbs_in0, phase_flag8, _, _, _, _, _),
+	[50] = PINGROUP(50, _, qup0_se9_l2_mirb, _, _, pbs_in1, phase_flag9, _, _, _, _, _),
+	[51] = PINGROUP(51, _, qup0_se9_l3_mirb, pbs_in15, _, _, _, _, _, _, _, _),
+	[52] = PINGROUP(52, _, _, _, _, _, _, _, _, _, _, _),
+	[53] = PINGROUP(53, _, nav_gpio, gcc_gp3, pwm_7_mirb, _, pbs_in4, atest_usb21, _, _, _, _),
+	[54] = PINGROUP(54, _, pwm_1_mirb, _, pbs_in5, phase_flag3, atest_char2, _, _, _, _, _),
+	[55] = PINGROUP(55, _, pwm_0_mirb, _, pbs_in6, phase_flag5, atest_char3, _, _, _, _, _),
+	[56] = PINGROUP(56, _, pwm_6_mirb, _, pbs_in7, phase_flag10, atest_char0, _, _, _, _, _),
+	[57] = PINGROUP(57, _, pwm_2_mirb, _, pbs_in8, phase_flag20, atest_char1, _, _, _, _, _),
+	[58] = PINGROUP(58, _, nav_gpio, pwm_8_mirb, _, pbs_in9,
+			atest_bbrx0, atest_usb22, vsense_trigger_mirnat,
+			emac1_dll, _, _),
+	[59] = PINGROUP(59, _, vfr_1, _, pbs_in10, atest_bbrx1, atest_usb23, emac1_dll, _, _, _, _),
+	[60] = PINGROUP(60, _, emac1_ptp, emac1_ptp, emac0_ptp,
+			emac0_ptp, _, pbs_in11, atest_gpsadc, atest_usb2,
+			emac0_dll, _),
+	[61] = PINGROUP(61, _, pwm_9_mira, gcc_gp2, pa_indicator_or,
+			dbg_out_clk, pbs_in12, atest_usb20, emac0_dll, _,
+			_, _),
+	[62] = PINGROUP(62, _, pwm_2_mira, _, pbs_in13, phase_flag12,
+			atest_char_start, _, _, _, _, _),
+	[63] = PINGROUP(63, _, nav_gpio, emac0_ptp, emac0_ptp, _,
+			pbs_in14, phase_flag13, dac_calib15, _, _, _),
+	[64] = PINGROUP(64, _, unused_gsm1, dac_calib13, _, _, _, _, _, _, _, _),
+	[65] = PINGROUP(65, _, _, _, _, _, _, _, _, _, _, _),
+	[66] = PINGROUP(66, _, dac_calib14, _, _, _, _, _, _, _, _, _),
+	[67] = PINGROUP(67, _, _, _, _, _, _, _, _, _, _, _),
+	[68] = PINGROUP(68, _, ssbi_wtr2, emac1_ptp, emac1_ptp,
+			pwm_9_mirb, dac_calib16, _, _, _, _, _),
+	[69] = PINGROUP(69, _, ssbi_wtr3, emac0_ptp, emac0_ptp, _,
+			phase_flag15, dac_calib17, _, _, _, _),
+	[70] = PINGROUP(70, _, ssbi_wtr0, _, phase_flag16, dac_calib18, _, _, _, _, _, _),
+	[71] = PINGROUP(71, _, ssbi_wtr1, nav_gpio, _, phase_flag17, _, _, _, _, _, _),
+	[72] = PINGROUP(72, _, _, phase_flag18, _, _, _, _, _, _, _, _),
+	[73] = PINGROUP(73, _, _, _, _, _, _, _, _, _, _, _),
+	[74] = PINGROUP(74, pll_reset_n, _, pbs_in3, phase_flag19, _, _, _, _, _, _, _),
+	[75] = PINGROUP(75, gsm0_tx, _, _, _, _, _, _, _, _, _, _),
+	[76] = PINGROUP(76, pll_bypassnl, _, _, _, _, _, _, _, _, _, _),
+	[77] = PINGROUP(77, uim2_data, pwm_3, _, _, _, _, _, _, _, _, _),
+	[78] = PINGROUP(78, uim2_clk, _, _, _, _, _, _, _, _, _, _),
+	[79] = PINGROUP(79, uim2_reset, pwm_4, _, _, _, _, _, _, _, _, _),
+	[80] = PINGROUP(80, uim2_present, pwm_5, _, _, _, _, _, _, _, _, _),
+	[81] = PINGROUP(81, uim1_data, _, _, _, _, _, _, _, _, _, _),
+	[82] = PINGROUP(82, uim1_clk, _, _, _, _, _, _, _, _, _, _),
+	[83] = PINGROUP(83, uim1_reset, _, _, _, _, _, _, _, _, _, _),
+	[84] = PINGROUP(84, uim1_present, _, _, _, _, _, _, _, _, _, _),
+	[85] = PINGROUP(85, emac0_ptp, emac0_ptp, _, _, _, _, _, _, _, _, _),
+	[86] = PINGROUP(86, mdp_vsync_p, mdp_vsync, mdp_vsync, _, _, _, _, _, _, _, _),
+	[87] = PINGROUP(87, _, pwm_6_mira, _, _, _, _, _, _, _, _, _),
+	[88] = PINGROUP(88, gcc_gp2, _, dac_calib21, _, _, _, _, _, _, _, _),
+	[89] = PINGROUP(89, gcc_gp3, _, dac_calib19, _, _, _, _, _, _, _, _),
+	[90] = PINGROUP(90, usb0_phy_ps, _, dac_calib20, _, _, _, _, _, _, _, _),
+	[91] = PINGROUP(91, nav_gpio, _, _, _, _, _, _, _, _, _, _),
+	[92] = PINGROUP(92, nav_gpio, _, _, _, _, _, _, _, _, _, _),
+	[93] = PINGROUP(93, _, _, _, _, _, _, _, _, _, _, _),
+	[94] = PINGROUP(94, mdp_vsync_e, qdss_cti, qdss_cti, _, _, _, _, _, _, _, _),
+	[95] = PINGROUP(95, nav_gpio, mdp_vsync_s, qdss_cti, qdss_cti, _, _, _, _, _, _, _),
+	[96] = PINGROUP(96, dmic0_clk, cam_mclk, i2s1_clk, jitter_bist,
+			atest_gpsadc, atest_usb1, _, _, _, _, _),
+	[97] = PINGROUP(97, dmic0_data, i2s1_ws, dac_calib23, _, _, _, _, _, _, _, _),
+	[98] = PINGROUP(98, dmic1_clk, cam_mclk, i2s1_data0, _, _,
+			atest_usb10, ddr_pxi0, _, _, _, _),
+	[99] = PINGROUP(99, dmic1_data, i2s1_data1, jitter_bist, _,
+			atest_usb11, ddr_pxi0, _, _, _, _, _),
+	[100] = PINGROUP(100, i2s2_clk, nav_gpio, _, _, atest_usb12, ddr_pxi1, _, _, _, _, _),
+	[101] = PINGROUP(101, i2s2_ws, nav_gpio, _, _, atest_usb13, ddr_pxi1, _, _, _, _, _),
+	[102] = PINGROUP(102, i2s2_data0, pwm_8_mira, _, phase_flag4, _, _, _, _, _, _, _),
+	[103] = PINGROUP(103, ext_mclk, i2s2_data1, _, _, _, _, _, _, _, _, _),
+	[104] = PINGROUP(104, ext_mclk, nav_gpio, _, _, _, _, _, _, _, _, _),
+	[105] = PINGROUP(105, swr0_tx_clk, i2s0_clk, _, _, _, _, _, _, _, _, _),
+	[106] = PINGROUP(106, swr0_tx_data0, i2s0_ws, _, _, _, _, _, _, _, _, _),
+	[107] = PINGROUP(107, swr0_rx_clk, i2s0_data0, _, _, _, _, _, _, _, _, _),
+	[108] = PINGROUP(108, swr0_rx_data0, i2s0_data1, _, _, _, _, _, _, _, _, _),
+	[109] = PINGROUP(109, swr0_rx_data1, i2s0_data2, sd_write_protect, _, _, _, _, _, _, _, _),
+	[110] = PINGROUP(110, ext_mclk, i2s0_data3, _, gcc_gp1, _, _, _, _, _, _, _),
+	[111] = PINGROUP(111, i2s3_clk, _, _, _, _, _, _, _, _, _, _),
+	[112] = PINGROUP(112, i2s3_ws, _, _, _, _, _, _, _, _, _, _),
+	[113] = PINGROUP(113, i2s3_data0, _, _, _, _, _, _, _, _, _, _),
+	[114] = PINGROUP(114, ext_mclk, i2s3_data1, _, _, _, _, _, _, _, _, _),
+	[115] = PINGROUP(115, mss_lte, _, _, _, _, _, _, _, _, _, _),
+	[116] = PINGROUP(116, mss_lte, _, dac_calib25, _, _, _, _, _, _, _, _),
+	[117] = PINGROUP(117, pcie0_clk_req_n, _, dac_calib22, _, _, _, _, _, _, _, _),
+	[118] = PINGROUP(118, _, dac_calib24, _, _, _, _, _, _, _, _, _),
+	[119] = PINGROUP(119, _, _, _, _, _, _, _, _, _, _, _),
+	[120] = PINGROUP(120, emac0_phy, _, _, _, _, _, _, _, _, _, _),
+	[121] = PINGROUP(121, rgmii0_rxc, _, _, _, _, _, _, _, _, _, _),
+	[122] = PINGROUP(122, rgmii0_rx_ctl, _, _, _, _, _, _, _, _, _, _),
+	[123] = PINGROUP(123, rgmii0_rxd0, _, _, _, _, _, _, _, _, _, _),
+	[124] = PINGROUP(124, rgmii0_rxd1, _, _, _, _, _, _, _, _, _, _),
+	[125] = PINGROUP(125, rgmii0_rxd2, _, _, _, _, _, _, _, _, _, _),
+	[126] = PINGROUP(126, rgmii0_rxd3, _, _, _, _, _, _, _, _, _, _),
+	[127] = PINGROUP(127, rgmii0_txc, _, _, _, _, _, _, _, _, _, _),
+	[128] = PINGROUP(128, rgmii0_tx_ctl, _, _, _, _, _, _, _, _, _, _),
+	[129] = PINGROUP(129, rgmii0_txd0, _, _, _, _, _, _, _, _, _, _),
+	[130] = PINGROUP(130, rgmii0_txd1, _, _, _, _, _, _, _, _, _, _),
+	[131] = PINGROUP(131, rgmii0_txd2, _, _, _, _, _, _, _, _, _, _),
+	[132] = PINGROUP(132, rgmii0_txd3, _, _, _, _, _, _, _, _, _, _),
+	[133] = PINGROUP(133, rgmii0_mdio, _, _, _, _, _, _, _, _, _, _),
+	[134] = PINGROUP(134, rgmii0_mdc, _, _, _, _, _, _, _, _, _, _),
+	[135] = PINGROUP(135, _, _, _, _, _, _, _, _, _, _, _),
+	[136] = PINGROUP(136, emac1_phy, _, _, _, _, _, _, _, _, _, _),
+	[137] = PINGROUP(137, rgmii1_rxc, _, _, _, _, _, _, _, _, _, _),
+	[138] = PINGROUP(138, rgmii1_rx_ctl, _, _, _, _, _, _, _, _, _, _),
+	[139] = PINGROUP(139, rgmii1_rxd0, _, _, _, _, _, _, _, _, _, _),
+	[140] = PINGROUP(140, rgmii1_rxd1, _, _, _, _, _, _, _, _, _, _),
+	[141] = PINGROUP(141, rgmii1_rxd2, _, _, _, _, _, _, _, _, _, _),
+	[142] = PINGROUP(142, rgmii1_rxd3, _, _, _, _, _, _, _, _, _, _),
+	[143] = PINGROUP(143, rgmii1_txc, _, _, _, _, _, _, _, _, _, _),
+	[144] = PINGROUP(144, rgmii1_tx_ctl, _, _, _, _, _, _, _, _, _, _),
+	[145] = PINGROUP(145, rgmii1_txd0, _, _, _, _, _, _, _, _, _, _),
+	[146] = PINGROUP(146, rgmii1_txd1, _, _, _, _, _, _, _, _, _, _),
+	[147] = PINGROUP(147, rgmii1_txd2, _, _, _, _, _, _, _, _, _, _),
+	[148] = PINGROUP(148, rgmii1_txd3, _, _, _, _, _, _, _, _, _, _),
+	[149] = PINGROUP(149, rgmii1_mdio, _, _, _, _, _, _, _, _, _, _),
+	[150] = PINGROUP(150, rgmii1_mdc, _, _, _, _, _, _, _, _, _, _),
+	[151] = PINGROUP(151, _, _, _, _, _, _, _, _, _, _, _),
+	[152] = PINGROUP(152, _, _, _, _, _, _, _, _, _, _, _),
+	[153] = PINGROUP(153, _, _, _, _, _, _, _, _, _, _, _),
+	[154] = PINGROUP(154, _, _, _, _, _, _, _, _, _, _, _),
+	[155] = PINGROUP(155, _, _, _, _, _, _, _, _, _, _, _),
+	[156] = PINGROUP(156, _, _, _, _, _, _, _, _, _, _, _),
+	[157] = PINGROUP(157, _, _, _, _, _, _, _, _, _, _, _),
+	[158] = PINGROUP(158, _, _, _, _, _, _, _, _, _, _, _),
+	[159] = PINGROUP(159, _, _, _, _, _, _, _, _, _, _, _),
+	[160] = PINGROUP(160, _, _, _, _, _, _, _, _, _, _, _),
+	[161] = PINGROUP(161, _, _, _, _, _, _, _, _, _, _, _),
+};
+
+static const struct msm_special_pin_data shikra_special_pins_data[] = {
+	[0] = SDC_PINGROUP("sdc1_data", 0x1AC000, 9, 0),
+	[1] = SDC_PINGROUP("sdc1_rclk", 0x1AC004, 0, 0),
+	[2] = SDC_PINGROUP("sdc1_cmd", 0x1AC000, 11, 3),
+	[3] = SDC_PINGROUP("sdc1_clk", 0x1AC000, 13, 6),
+	[4] = SDC_PINGROUP("sdc2_clk", 0x1AA000, 14, 6),
+	[5] = SDC_PINGROUP("sdc2_cmd", 0x1AA000, 11, 3),
+	[6] = SDC_PINGROUP("sdc2_data", 0x1AA000, 9, 0),
+};
+
+static const char *shikra_get_function_name(struct udevice *dev,
+					    unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *shikra_get_pin_name(struct udevice *dev,
+				       unsigned int selector)
+{
+	if (selector >= 162 && selector <= 168)
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 shikra_special_pins_data[selector - 162].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int shikra_get_function_mux(__maybe_unused unsigned int pin,
+				   unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = shikra_pin_functions + pin;
+
+	for (i = 0; i < MSM_PIN_FUNCTION_COUNT; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u\n", pin);
+
+	return -EINVAL;
+}
+
+static struct msm_pinctrl_data shikra_data = {
+	.pin_data = {
+		.pin_count = 169,
+		.special_pins_start = 162,
+		.special_pins_data = shikra_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = shikra_get_function_name,
+	.get_function_mux = shikra_get_function_mux,
+	.get_pin_name = shikra_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,shikra-tlmm",
+		.data = (ulong)&shikra_data
+	},
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_shikra) = {
+	.name		= "pinctrl_shikra",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+};
-- 
2.34.1

