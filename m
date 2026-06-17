Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422E5CD98F1
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF27884A0A;
	Wed, 17 Jun 2026 14:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vu8pk5my";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SeKpU/Sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60A41841F2; Wed, 17 Jun 2026 12:19:32 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951CE838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8V7xB2291377
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MsVChbOx0Un
 NsoVJWfwm/RD/naJrDUHKjmTuBdyLRWI=; b=Vu8pk5myUdGjApISr/qk4sjxYoC
 nZDokM8Tv1HglghTC8/3EaGvInYwD1ae95XWqAiLvb2R1YLfvkltgo7mTuyr6bmh
 rAQ+YrfrqRTjUAd2eZEjEzgDXyIFsgy5zMyk4tY95ULtM4kfwrn+SD1zPEJCSoag
 /OmNB4PXjB6diufl5zP4xlQyldHJtiVewL0CkoWdKLu4XpV3n1o3XYzaiNY74dOM
 QUXHd7sn/xhAi/+P8XD9emhfmMFN/IGczESrupzVh5iBEV9YEDRLdROzI5M63YwI
 XIgymIAW+bW07SqlVifsriezEwlAcZ6C8QE/iO714AMu6i1acZCJFX+WnkQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevjpaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:19:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8422f987f2eso8971911b3a.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691567; x=1782296367; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MsVChbOx0UnNsoVJWfwm/RD/naJrDUHKjmTuBdyLRWI=;
 b=SeKpU/SvJymr7mL5qufsmcqg3rrVUedClxDm3i8mVxJ2Sf4iMnteEd99GVgShoyVzS
 H9UGkTFoeyvayYyEzJfaHto+KlbDH1lo/T4DoUvcUtavdwtnMYwDgPLHapESqtrKnRyB
 6lEkdYpRDHyRiQ0IUf8G/i5XDRjQkeeawNo8IwUsjrLBpG3BntxLl2GZ/cGT299GiAqH
 uwRC493qeDOlb+73pi3lFceCbZdYL529m/24fbgBrj+VGDcBJo7xwCyMACIPPK+EA4FJ
 dZzXjF0p3EUr0zf9yCAOcqQU7Mkxx5zX7g+Y6VWhrmUJkFBhPj20lMLA4eZiCUYhp5rH
 Uu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691567; x=1782296367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MsVChbOx0UnNsoVJWfwm/RD/naJrDUHKjmTuBdyLRWI=;
 b=AtwMuXCDVAQHf/3MTp/Phy5qV6tQE3ji23UKrOZ0M/t8mYrA5UpJ9WTJLV//naAORR
 SXme2Oo4bEE2c4dzNZ7kvWir6n/y61ePIT8xQoLDlWuNju8W5uZoEjg+j4YjIIGk5cO2
 PKA4fPPf3GE/ZuZfOWJZG7pFzkiSQ2Rkk63Qa4buQATxr5j/b5B+Ljxr/xR7rQvHIO3g
 MmwgdIV9ec247AbMU4uQ3uIZdzWsA/KTzpgwaBqAHGkNOOUZgUxPw37ivUb0g4qykkzO
 DPsBDK3DNgdql1qgcfV52TB2YzE6okfuAUThqFQJvY4r8hmkdO9cyt5sGVaPfhxS+Vwg
 dehQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yevS80gGqGJpFjveA45IOrDZeUOS4IEEZHZN0PZL4DOJy9r8znUbqZa4SF5tUuiZzmvuEJws=@lists.denx.de
X-Gm-Message-State: AOJu0YzlucKcMA9gYZHr3WVka6d9XdQDKncABLi08e8YP17pMGVB9NWp
 4NgjWtIkb+E+PLjjU/Ly57HmEIoB5B4SFUFsXSIhgvmfifgcRYUJp03lOWpL6zVDMB8d1JHaD9X
 +TSOmXPrWm9gnpfdXwbGdahbF0VDWUlhGQGfxjvk7VBHTVNAOCOy/AtME
X-Gm-Gg: Acq92OE7CQqk8lt0Vpjw8N1ULNEwQOIriXImvYfzfQSwZDOrNXv09NPftA6JXaJK0pf
 a2Ry16CTvcaPyGMpCYzbWzerdI+OCfg1DYYUCcxk/zRRY2y7I5kHKWFo1x+a5QZjBFnfGJClGCH
 ecTjsS1eUV936LZYOGCckWmhkaJG0i5S5EPkN+Jo8Jkinp/LDXCG8ate0Q6Xgd6YwBB3uYUErK1
 lZpBZOgr6pkGMGI4GOvRxo4G1J4Rl3lba9rCzim7KpLESWJJ1bJesfDfvgGbYKopVNQu8pfItfP
 Jm5I/DJbVvPJ2iEAHWmH6mGSoCFeNyNAnxggAPURpqGwXJQE1TuWfHkkqnAjWGxjMvxYFQB2wNF
 GrFD2JI/D6U3ZlMDR9l/G7LeQglak7YJD5SkGL3X+8SW75kiuawA83OPtarjbK9u+y5DiDzRxfH
 tZQPqoHH9ZHOVEyTdTGvHpGaNx7pCX6YZiDGmsv91E
X-Received: by 2002:a05:6a00:138f:b0:842:7867:430b with SMTP id
 d2e1a72fcca58-84524556180mr3350651b3a.29.1781691566704; 
 Wed, 17 Jun 2026 03:19:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:138f:b0:842:7867:430b with SMTP id
 d2e1a72fcca58-84524556180mr3350589b3a.29.1781691566091; 
 Wed, 17 Jun 2026 03:19:26 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:19:25 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 05/13] pinctrl: qcom: Add ipq5210 pinctrl driver
Date: Wed, 17 Jun 2026 15:48:04 +0530
Message-Id: <20260617101812.299586-6-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX9SV/KEA+1PWX
 sUJ7HcgQB1TSdEf3/ogF+V8jPt0R3Pf2oAI1hb6Bhq22Bs73khapICQiD8vF/r5wHR2u0f98+Up
 PoNMLTOFXOrIiyA68BUBRruw5Sd4GBqX16lYOEBbz0caS5h4nXffnaQfeb3dOwSBUfMYkSDGCXY
 ZjZ6LsnlsTp5hoYpfsYmiQIg1i3fXvKFmPFFjqyu/rw4AVBM7D6j5lxdxMqLbGLwT4VCnfkQK3Z
 nIcjgVmmetq2OZAzQ8iVDrhvTkUGuSYATDpHevnR215toBwLrX0WXuvD2sZIDUpco5BuTExGH71
 whzNhpQWgFso4w8wIUne4P5iXWrAeQqq7gjdRror+/iTempWhF7jRINdGRP51w1Ed1k1JMXzWA5
 Xtk/+LPWYXxJi4muylKDB09q60fCxzh9SG/scIAPDpf2TLFDZy8NSMU5y3VtjBolTZ44uhj0H2S
 jGlqNpkvR32PysPWvSw==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a3274af cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=NzvCGKM8m0lGn9t9IsgA:9 a=O8hF6Hzn-FEA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: UxqW-rZi1KcShowQA0-vBVwlLQkqn5rJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX03ZW058BShSN
 3WGlYNvQ+UHsTMybAvQR1Ujw4pmfsCY/qHbLUCSUF7LIeTqJgdCaRmsUKNxf7TNB/Hj3Fq+KN4o
 W6HdTu2++AvdnHkMGIh2JNu/uCKhmqQ=
X-Proofpoint-ORIG-GUID: UxqW-rZi1KcShowQA0-vBVwlLQkqn5rJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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

Add pinctrl driver for the TLMM block found in the ipq5210 SoC.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v4: Fix pin count
    Remove duplicate 'pin' in message
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c | 349 +++++++++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5210.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 11e6763b5f3..6cfa9564399 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -38,6 +38,14 @@ config PINCTRL_QCOM_IPQ4019
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ5210 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 4096c1aa491..4083906852e 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ5210) += pinctrl-ipq5210.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq5210.c b/drivers/pinctrl/qcom/pinctrl-ipq5210.c
new file mode 100644
index 00000000000..a9b435ad543
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq5210.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm IPQ5210 pinctrl
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum ipq5210_functions {
+	msm_mux_atest_char_start,
+	msm_mux_atest_char_status0,
+	msm_mux_atest_char_status1,
+	msm_mux_atest_char_status2,
+	msm_mux_atest_char_status3,
+	msm_mux_atest_tic_en,
+	msm_mux_audio_pri,
+	msm_mux_audio_pri_mclk_out0,
+	msm_mux_audio_pri_mclk_in0,
+	msm_mux_audio_pri_mclk_out1,
+	msm_mux_audio_pri_mclk_in1,
+	msm_mux_audio_pri_mclk_out2,
+	msm_mux_audio_pri_mclk_in2,
+	msm_mux_audio_pri_mclk_out3,
+	msm_mux_audio_pri_mclk_in3,
+	msm_mux_audio_sec,
+	msm_mux_audio_sec_mclk_out0,
+	msm_mux_audio_sec_mclk_in0,
+	msm_mux_audio_sec_mclk_out1,
+	msm_mux_audio_sec_mclk_in1,
+	msm_mux_audio_sec_mclk_out2,
+	msm_mux_audio_sec_mclk_in2,
+	msm_mux_audio_sec_mclk_out3,
+	msm_mux_audio_sec_mclk_in3,
+	msm_mux_core_voltage_0,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_cri_trng2,
+	msm_mux_cri_trng3,
+	msm_mux_dbg_out_clk,
+	msm_mux_dg_out,
+	msm_mux_gcc_plltest_bypassnl,
+	msm_mux_gcc_plltest_resetn,
+	msm_mux_gcc_tlmm,
+	msm_mux_gpio,
+	msm_mux_led0,
+	msm_mux_led1,
+	msm_mux_led2,
+	msm_mux_mdc_mst,
+	msm_mux_mdc_slv0,
+	msm_mux_mdc_slv1,
+	msm_mux_mdc_slv2,
+	msm_mux_mdio_mst,
+	msm_mux_mdio_slv0,
+	msm_mux_mdio_slv1,
+	msm_mux_mdio_slv2,
+	msm_mux_mux_tod_out,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk_req_n,
+	msm_mux_pcie1_wake,
+	msm_mux_pll_test,
+	msm_mux_pon_active_led,
+	msm_mux_pon_mux_sel,
+	msm_mux_pon_rx,
+	msm_mux_pon_rx_los,
+	msm_mux_pon_tx,
+	msm_mux_pon_tx_burst,
+	msm_mux_pon_tx_dis,
+	msm_mux_pon_tx_fault,
+	msm_mux_pon_tx_sd,
+	msm_mux_gpn_rx_los,
+	msm_mux_gpn_tx_burst,
+	msm_mux_gpn_tx_dis,
+	msm_mux_gpn_tx_fault,
+	msm_mux_gpn_tx_sd,
+	msm_mux_pps,
+	msm_mux_pwm0,
+	msm_mux_pwm1,
+	msm_mux_pwm2,
+	msm_mux_pwm3,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qrng_rosc0,
+	msm_mux_qrng_rosc1,
+	msm_mux_qrng_rosc2,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs_n,
+	msm_mux_qup_se0,
+	msm_mux_qup_se1,
+	msm_mux_qup_se2,
+	msm_mux_qup_se3,
+	msm_mux_qup_se4,
+	msm_mux_qup_se5,
+	msm_mux_qup_se5_l1,
+	msm_mux_resout,
+	msm_mux_rx_los0,
+	msm_mux_rx_los1,
+	msm_mux_rx_los2,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_sdc_data,
+	msm_mux_tsens_max,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(atest_char_start),
+	MSM_PIN_FUNCTION(atest_char_status0),
+	MSM_PIN_FUNCTION(atest_char_status1),
+	MSM_PIN_FUNCTION(atest_char_status2),
+	MSM_PIN_FUNCTION(atest_char_status3),
+	MSM_PIN_FUNCTION(atest_tic_en),
+	MSM_PIN_FUNCTION(audio_pri),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out0),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in0),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out1),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in1),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out2),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in2),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out3),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in3),
+	MSM_PIN_FUNCTION(audio_sec),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out0),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in0),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out1),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in1),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out2),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in2),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out3),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in3),
+	MSM_PIN_FUNCTION(core_voltage_0),
+	MSM_PIN_FUNCTION(cri_trng0),
+	MSM_PIN_FUNCTION(cri_trng1),
+	MSM_PIN_FUNCTION(cri_trng2),
+	MSM_PIN_FUNCTION(cri_trng3),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(dg_out),
+	MSM_PIN_FUNCTION(gcc_plltest_bypassnl),
+	MSM_PIN_FUNCTION(gcc_plltest_resetn),
+	MSM_PIN_FUNCTION(gcc_tlmm),
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(led0),
+	MSM_PIN_FUNCTION(led1),
+	MSM_PIN_FUNCTION(led2),
+	MSM_PIN_FUNCTION(mdc_mst),
+	MSM_PIN_FUNCTION(mdc_slv0),
+	MSM_PIN_FUNCTION(mdc_slv1),
+	MSM_PIN_FUNCTION(mdc_slv2),
+	MSM_PIN_FUNCTION(mdio_mst),
+	MSM_PIN_FUNCTION(mdio_slv0),
+	MSM_PIN_FUNCTION(mdio_slv1),
+	MSM_PIN_FUNCTION(mdio_slv2),
+	MSM_PIN_FUNCTION(mux_tod_out),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(pcie0_wake),
+	MSM_PIN_FUNCTION(pcie1_clk_req_n),
+	MSM_PIN_FUNCTION(pcie1_wake),
+	MSM_PIN_FUNCTION(pll_test),
+	MSM_PIN_FUNCTION(pon_active_led),
+	MSM_PIN_FUNCTION(pon_mux_sel),
+	MSM_PIN_FUNCTION(pon_rx),
+	MSM_PIN_FUNCTION(pon_rx_los),
+	MSM_PIN_FUNCTION(pon_tx),
+	MSM_PIN_FUNCTION(pon_tx_burst),
+	MSM_PIN_FUNCTION(pon_tx_dis),
+	MSM_PIN_FUNCTION(pon_tx_fault),
+	MSM_PIN_FUNCTION(pon_tx_sd),
+	MSM_PIN_FUNCTION(gpn_rx_los),
+	MSM_PIN_FUNCTION(gpn_tx_burst),
+	MSM_PIN_FUNCTION(gpn_tx_dis),
+	MSM_PIN_FUNCTION(gpn_tx_fault),
+	MSM_PIN_FUNCTION(gpn_tx_sd),
+	MSM_PIN_FUNCTION(pps),
+	MSM_PIN_FUNCTION(pwm0),
+	MSM_PIN_FUNCTION(pwm1),
+	MSM_PIN_FUNCTION(pwm2),
+	MSM_PIN_FUNCTION(pwm3),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b1),
+	MSM_PIN_FUNCTION(qdss_traceclk_a),
+	MSM_PIN_FUNCTION(qdss_tracectl_a),
+	MSM_PIN_FUNCTION(qdss_tracedata_a),
+	MSM_PIN_FUNCTION(qrng_rosc0),
+	MSM_PIN_FUNCTION(qrng_rosc1),
+	MSM_PIN_FUNCTION(qrng_rosc2),
+	MSM_PIN_FUNCTION(qspi_data),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs_n),
+	MSM_PIN_FUNCTION(qup_se0),
+	MSM_PIN_FUNCTION(qup_se1),
+	MSM_PIN_FUNCTION(qup_se2),
+	MSM_PIN_FUNCTION(qup_se3),
+	MSM_PIN_FUNCTION(qup_se4),
+	MSM_PIN_FUNCTION(qup_se5),
+	MSM_PIN_FUNCTION(qup_se5_l1),
+	MSM_PIN_FUNCTION(resout),
+	MSM_PIN_FUNCTION(rx_los0),
+	MSM_PIN_FUNCTION(rx_los1),
+	MSM_PIN_FUNCTION(rx_los2),
+	MSM_PIN_FUNCTION(sdc_clk),
+	MSM_PIN_FUNCTION(sdc_cmd),
+	MSM_PIN_FUNCTION(sdc_data),
+	MSM_PIN_FUNCTION(tsens_max),
+};
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9) \
+	[id] = {        msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9,			\
+	}
+
+static const msm_pin_function ipq5210_pin_functions[] = {
+	PINGROUP(0, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(1, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(2, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(3, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(4, sdc_cmd, qspi_cs_n, _, _, _, _, _, _, _),
+	PINGROUP(5, sdc_clk, qspi_clk, _, _, _, _, _, _, _),
+	PINGROUP(6, qup_se0, led0, pwm1, _, cri_trng0, qdss_tracedata_a, _, _, _),
+	PINGROUP(7, qup_se0, led1, pwm1, _, cri_trng1, qdss_tracedata_a, _, _, _),
+	PINGROUP(8, qup_se0, pwm1, audio_pri_mclk_out2, audio_pri_mclk_in2, _, cri_trng2, qdss_tracedata_a, _, _),
+	PINGROUP(9, qup_se0, led2, pwm1, _, cri_trng3, qdss_tracedata_a, _, _, _),
+	PINGROUP(10, pon_rx_los, qup_se3, pwm0, _, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(11, pon_active_led, qup_se3, pwm0, _, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(12, pon_tx_dis, qup_se2, pwm0, audio_pri_mclk_out0, audio_pri_mclk_in0, _, qrng_rosc0, qdss_tracedata_a, _),
+	PINGROUP(13, gpn_tx_dis, qup_se2, pwm0, audio_pri_mclk_out3, audio_pri_mclk_in3, _, qrng_rosc1, qdss_tracedata_a, _),
+	PINGROUP(14, pon_tx_burst, qup_se0, _, qrng_rosc2, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(15, pon_tx, qup_se0, _, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(16, pon_tx_sd, audio_sec_mclk_out1, audio_sec_mclk_in1, qdss_cti_trig_out_b0, _, _, _, _, _),
+	PINGROUP(17, pon_tx_fault, audio_sec_mclk_out0, audio_sec_mclk_in0, _, _, _, _, _, _),
+	PINGROUP(18, pps, pll_test, _, _, _, _, _, _, _),
+	PINGROUP(19, mux_tod_out, audio_pri_mclk_out1, audio_pri_mclk_in1, _, _, _, _, _, _),
+	PINGROUP(20, qup_se2, mdc_slv1, tsens_max, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(21, qup_se2, mdio_slv1, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(22, core_voltage_0, qup_se3, pwm3, _, _, _, _, _, _),
+	PINGROUP(23, led0, qup_se3, dbg_out_clk, qdss_traceclk_a, _, _, _, _, _),
+	PINGROUP(24, _, _, _, _, _, _, _, _, _),
+	PINGROUP(25, _, _, _, _, _, _, _, _, _),
+	PINGROUP(26, mdc_mst, led2, _, qdss_tracectl_a, _, _, _, _, _),
+	PINGROUP(27, mdio_mst, led1, _, _, _, _, _, _, _),
+	PINGROUP(28, pcie1_clk_req_n, qup_se1, _, _, qdss_cti_trig_out_a0, _, _, _, _),
+	PINGROUP(29, _, _, _, _, _, _, _, _, _),
+	PINGROUP(30, pcie1_wake, qup_se1, _, _, qdss_cti_trig_in_a0, _, _, _, _),
+	PINGROUP(31, pcie0_clk_req_n, mdc_slv0, _, qdss_cti_trig_out_a1, _, _, _, _, _),
+	PINGROUP(32, _, _, _, _, _, _, _, _, _),
+	PINGROUP(33, pcie0_wake, mdio_slv0, qdss_cti_trig_in_a1, _, _, _, _, _, _),
+	PINGROUP(34, audio_pri, atest_char_status0, qdss_cti_trig_in_b0, _, _, _, _, _, _),
+	PINGROUP(35, audio_pri, rx_los2, atest_char_status1, qdss_cti_trig_out_b1, _, _, _, _, _),
+	PINGROUP(36, audio_pri, _, rx_los1, atest_char_status2, _, _, _, _, _),
+	PINGROUP(37, audio_pri, rx_los0, atest_char_status3, _, qdss_cti_trig_in_b1, _, _, _, _),
+	PINGROUP(38, qup_se1, led2, gcc_plltest_bypassnl, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(39, qup_se1, led1, led0, gcc_tlmm, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(40, qup_se4, rx_los2, audio_sec, gcc_plltest_resetn, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(41, qup_se4, rx_los1, audio_sec, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(42, qup_se4, rx_los0, audio_sec, atest_tic_en, _, _, _, _, _),
+	PINGROUP(43, qup_se4, audio_sec, _, _, _, _, _, _, _),
+	PINGROUP(44, resout, _, _, _, _, _, _, _, _),
+	PINGROUP(45, pon_mux_sel, _, _, _, _, _, _, _, _),
+	PINGROUP(46, dg_out, atest_char_start, _, _, _, _, _, _, _),
+	PINGROUP(47, gpn_rx_los, mdc_slv2, qup_se5, _, _, _, _, _, _),
+	PINGROUP(48, pon_rx, qup_se5, _, _, _, _, _, _, _),
+	PINGROUP(49, gpn_tx_fault, mdio_slv2, qup_se5, audio_sec_mclk_out2, audio_sec_mclk_in2, _, _, _, _),
+	PINGROUP(50, gpn_tx_sd, qup_se5, audio_sec_mclk_out3, audio_sec_mclk_in3, _, _, _, _, _),
+	PINGROUP(51, gpn_tx_burst, qup_se5, _, _, _, _, _, _, _),
+	PINGROUP(52, qup_se2, qup_se5, qup_se4, qup_se5_l1, _, _, _, _, _),
+	PINGROUP(53, qup_se2, qup_se4, qup_se5_l1, _, _, _, _, _, _),
+};
+
+static const char *ipq5210_get_function_name(struct udevice *dev, uint selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *ipq5210_get_pin_name(struct udevice *dev, uint selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int ipq5210_get_function_mux(unsigned int pin, uint selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = ipq5210_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u\n", pin);
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data ipq5210_data = {
+	.pin_data = {
+		.pin_count = 54,
+		.special_pins_start = 54, /* There are no special pins */
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq5210_get_function_name,
+	.get_function_mux = ipq5210_get_function_mux,
+	.get_pin_name = ipq5210_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq5210-tlmm", .data = (ulong)&ipq5210_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq5210) = {
+	.name		= "pinctrl_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

