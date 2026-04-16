Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAD4F8A16F
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE3784242;
	Thu, 16 Apr 2026 15:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZruC8v0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VjZ92Qob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F666841D5; Thu, 16 Apr 2026 07:40:37 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B70883C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G3b7Up506780
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GuRDVMskJ1f
 Bs7TEZuTsXxYASMTDM9rRYKuclFXKyws=; b=mZruC8v0g8xMQiq9q2MtHP4clj1
 gQ4gw24P42P3OpclWWle8jIEKNVclGWojU7xRfSZchZ8LsOVcmCxb0X/l8e+RNIX
 g13UktaVcPw+wcO778Mw0FFZjGZ5YYkJELylQ9bGa7tyx40Wtwt0dDeDD4peFfNf
 HU5IqJFaFc/nQtIKn6xRnuzGkV7DUbjRtPjUiWP+B8RVA6ALbN59K5fu3r+22C6I
 ovXjUBuRlheNzqywqOa2i5jWkR+gc4pCAWwMP18c2nnsb92ZMHb3xm8+Tlqkfxj3
 wpFl5v8zwU3MjjHPUWw4FoEIFxFjBN/3IaWoji323KyonmGg/BKa4NXyjYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dje1e25hv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:40:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c769b25315eso9615798a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318031; x=1776922831; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GuRDVMskJ1fBs7TEZuTsXxYASMTDM9rRYKuclFXKyws=;
 b=VjZ92QobomQGBdVaFdYixyVe8i2xIir5HbHfMqS7/7kaRjmHAnDlNLawAEtCNaLV4b
 q/8p6TQdcStNie2d9CbwntCGn6S/35bwalmXDB13CGg6WQP+PRfYGiT4pn5Y0EzH6+XH
 m7Olw1V6VV1flCFXBgM6Ey/I9NK1vZxWKNEDChTKFsIvYNvgc8oN953JtWkKe/9obXmt
 SQqvnhPrym05yqCfT5WrkdLxMR3hKXCsAkHyl3tAEBDOaecr1CUlp4Vr8sJ8qst4sQFD
 xaxl2G3GKyOQJ6RL6XKykFaAUIy0bdPJP8lcS1i+CIBUFxtEkcwdPPkZvwONRKb5SC12
 idvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318031; x=1776922831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GuRDVMskJ1fBs7TEZuTsXxYASMTDM9rRYKuclFXKyws=;
 b=aRQtia4c9F6i/7Bn0I7vTN3Rt7kS3sW1bHQzMttjPnWcqiC+wpGmpKbONvc+5Y45KB
 NBTTXF7NY7eYj9bxfi2xqYarTIq5sa4+Pfg+Jc0UNL1ixQLdJbR0xBabVwsm0BNuFs5z
 4KYg8u5+kh68kL2cE34d6tKJbW4AkecfRXFFqZWOMhKVONBzr7+KavIGvIaO1Lez0OOY
 UWAC8s/qt/oCVGjc3jNN5ysWuVgetAiFodCq2jbti+QNfcVPugQe1sOHMI6o1iYDdvKe
 n1F8NiU3BS1mJrx/joZC6j929dhwAqJNUt2L52fMeX/dgNJZJNAFPM0jrVXQtbYAeos3
 Zm5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8w1pubC5/JAxvo7k1pev27V3+icZ4R7Q8I9mN2iCic5E8kQD7OOo/N6Ff3i1fo2fgLu+ywFnw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywjbnlt48SuM4/bniWNbfSVqhv+YXjVi/hY6wzYk0/M9Ry4MAAW
 fYyAE461vJjxSXZcTkGGr0oL7sqwQU/NJiSd2scflz3R5JN9HzJkSm3eC3GH9JTQ+M0hd9fw8Rj
 SSHDtoo3L2nso9UJOj38YD+jDx51c0esX+THmgAgfL3HPkWHgHzaB65OU
X-Gm-Gg: AeBDievG16JU1EgKy3lMxXZcfoRrApoMRHlPMG+afg5lfFI+6SfMzuqHz8luC4x9C2Y
 emEnRlgK4TlEY52kWCOqiVmeCEkstyHj6CVRKjpVm+Ve8yrRqMTb302pQCS19Jzm2O76txDZ+31
 PffDnFgxlbd/4itzzmo8SIsVMAffsaC+YzCsVMztpFgpewaZMLnSwrqg0OjrHlxQF9BxXaR0t2i
 8D+7Sah7AqYIfaOrqig1B9kFxsZrs2XgT4sansEzAuZGtYQ070mS+rtyw7kIBrJgVzfGtM4QkD/
 DsT/3viWYQ4BFIKS03J68PJviPOqiCFFY0Q/G5zDMY5fAzi2GKZ2YMHE44iPengzsIEYVmRp4sT
 25Jl6qzNiQmWz3MTw4ADEwHKwBgUnmU0A044Vfm4Kxkp77nBixL5IKw00/1UN4zVbFctyUmueUP
 l5p4za1GzN6DZmfGzUCX67kN8Kc+0q3ahPVA5Y2uTbKni32jKNgoM=
X-Received: by 2002:a05:6a00:a589:b0:82a:805a:7e2 with SMTP id
 d2e1a72fcca58-82f0c269247mr25187643b3a.9.1776318030831; 
 Wed, 15 Apr 2026 22:40:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:a589:b0:82a:805a:7e2 with SMTP id
 d2e1a72fcca58-82f0c269247mr25187588b3a.9.1776318030046; 
 Wed, 15 Apr 2026 22:40:30 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:40:29 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 04/10] misc: qcom_geni: Add minicore support
Date: Thu, 16 Apr 2026 11:09:22 +0530
Message-Id: <20260416053928.2834699-5-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZwkiCE8 c=1 sm=1 tr=0 ts=69e0764f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=r3BCeo_rRLq3iIjAy_cA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX2ezrcQWxARzx
 9C6UUedKiWpxDlv7b/MGfB76c30Nv+6+XIOcYXuzEV/cdsUoY2ZF7MeCr3jGO+1cpJsosC1kFUX
 fBCNrYMrUpnD1A8shJKk1Df8sVfEzKSCpS7zYeA5tchJZB3fowjnPithC7hu5iQXVhV2Fxszhvl
 XIjuEnkQH/4sXR2Azn+Pw2oipJFP/+bcfTfIt9Q0MErXy2229h+AM3ctRLodP4kV5Ys8yv3yvxI
 ov27ZB6ap1rWbrcSILgtrSBZrr3BOcw9Lsk9olTeiY3NWaEJXEkwp4Qxp7S2NeCYOLmqnNGfoy+
 iTsy8TpYkGJzpi4sKRUuaebLf/6f2LWIrIntrxQdsTyyObrx1knz57j4Qmt35v1tgD45V7TTxhB
 qFAQSfiXZcNF8KoLjoPPkbrFIXUJnJEEhZoxTe6w+APW4o2nw3BZz6MPd6NdTJkYU7woq+Fm5HR
 FEI65GwqivIaYHQcPtA==
X-Proofpoint-ORIG-GUID: qyBRbYVuCbdgtuL0l9PaaouuRH0-7MMX
X-Proofpoint-GUID: qyBRbYVuCbdgtuL0l9PaaouuRH0-7MMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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

The qcom_geni driver reads an ELF from storage and configures a set of
registers and programs the firmware to the GENI Serial Engine (GENI-SE)
wrapper device for the expected functionality.

Unlike the GENI-SE wrapper found in MSM SoCs, the IPQ5210's GENI-SE
wrapper is pre-configured for one of the functions defined in 'enum
geni_se_protocol_type'. Hence, the firmware download is not needed.
Only the register configuration part is needed.

Earlier, the boot stages before U-Boot would configure the GENI-SE (to
access UART/SPI etc). Since for IPQ5210 U-Boot SPL, the previous stage
(i.e. boot ROM) doesn't do that modify the driver to do the register
configuration part alone without reading an ELF from the storage.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v3: Use wrapper probe fn to call qcom_geni_fw_initialise() for SPL
    Return error if ELF is not found and it is not a minicore

v2: * Add CONFIG_QCOM_GENI_MINICORE option
    * Move register settings to separate file and include if
      CONFIG_QCOM_GENI_MINICORE is defined
    * Remove duplicate definition of GEN_USE_MINICORES
    * s/GEN_USE_MINICORES/GENI_USE_MINICORES
    * Skip find_qupfw_part() if it is a minicore
---
 drivers/misc/Kconfig              |   6 ++
 drivers/misc/Makefile             |   1 +
 drivers/misc/qcom_geni-minicore.c | 102 ++++++++++++++++++++++++++++++
 drivers/misc/qcom_geni.c          |  94 +++++++++++++++++++++++----
 include/soc/qcom/geni-se.h        |   2 +
 include/soc/qcom/qup-fw-load.h    |  15 +++++
 6 files changed, 208 insertions(+), 12 deletions(-)
 create mode 100644 drivers/misc/qcom_geni-minicore.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ea785793d18..4bf75ecf5c7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,12 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_GENI_MINICORE
+	bool "Support minicores in Qualcomm Generic Interface (GENI) driver"
+	depends on QCOM_GENI
+	help
+	  Enable support for minicores in Qualcomm GENI and it's peripherals.
+
 config ROCKCHIP_EFUSE
         bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..2daccbba74d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_QCOM_GENI_MINICORE) += qcom_geni-minicore.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom_geni-minicore.c b/drivers/misc/qcom_geni-minicore.c
new file mode 100644
index 00000000000..33bc61ddf35
--- /dev/null
+++ b/drivers/misc/qcom_geni-minicore.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
+
+/*
+ * Register configuration for the QUP minicores to setup the corresponding
+ * functionality of SPI/I2C/UART.
+ */
+static u8 cfg_reg_idx[] = {
+	/* 0 to 18 */
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
+	/* 64 to 113 */
+	64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
+	81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
+	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111,
+	112, 113,
+};
+
+static u32 spi_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000000, 0x00000400, 0x00000000, 0x00000000, 0x00240E78, 0x00011088,
+	0x00240007, 0x00000000, 0x00000000, 0x0001000A, 0x00000300, 0x00000000,
+	0x00000000, 0x00000000, 0x00154400, 0x001483A0, 0x00AA8128, 0x00641002,
+	0x00004000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FE05, 0x0002C2E7, 0x0A435C00, 0x0010011A, 0x08800000,
+	0x00000000, 0x100CAC00, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x000018E4, 0x00000000,
+	0x00000003, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F807, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00000004, 0x00000009, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C0033F, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 uart_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000024, 0x00000000, 0x00000024, 0x00000000, 0x00019A00, 0x00400000,
+	0x00E00000, 0x00010020, 0x00000000, 0x00000000, 0x00000300, 0x00000700,
+	0x00000400, 0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00C00024,
+	0x00000B00,
+	/* 64 to 113 */
+	0x00020231, 0x0000CE05, 0x000360E7, 0x0941E6A8, 0x00100510, 0x42C01E51,
+	0x00000401, 0x002E8400, 0x1694581A, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x0000031C, 0x00000000,
+	0x0000000F, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00081C06, 0x00004010, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000000D, 0x00000000, 0x00081C06, 0x00004010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00C02415, 0x0000000E, 0x00000001,
+	0x00000001, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+static u32 i2c_cfg_val[] = {
+	/* 0 to 18 */
+	0x00000090, 0x00000000, 0x00000090, 0x00000000, 0x00038028, 0x00084080,
+	0x00000343, 0x00010000, 0x00000000, 0x00001A00, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00808008, 0x001C0020, 0x00000000, 0x00020000,
+	0x00000000,
+	/* 64 to 113 */
+	0x00000201, 0x0001FC01, 0x00036222, 0x09C01FFC, 0x00100120, 0x02C00000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000409, 0x00000003,
+	0x00000002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0007F8FE, 0x000FFEFE, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000001, 0x0007F807, 0x000FFEFE, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00C00000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000055,
+};
+
+struct qup_mini_core_info qup_mini_cores[] = {
+	{
+		.serial_protocol = GENI_SE_SPI,
+		.fw_version = 0xb02,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(spi_cfg_val),
+		.cfg_val = spi_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_UART,
+		.fw_version = 0x405,
+		.cfg_version = 0xa,
+		.cfg_count = ARRAY_SIZE(uart_cfg_val),
+		.cfg_val = uart_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_I2C,
+		.fw_version = 0x204,
+		.cfg_version = 0x9,
+		.cfg_count = ARRAY_SIZE(i2c_cfg_val),
+		.cfg_val = i2c_cfg_val,
+		.cfg_idx = cfg_reg_idx,
+	}, {
+		.serial_protocol = GENI_SE_INVALID_PROTO,
+	},
+};
diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..829228f37ec 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -34,8 +34,15 @@ struct qup_se_rsc {
 
 struct geni_se_plat {
 	bool need_firmware_load;
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+	bool is_mini_core;
+#endif
 };
 
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+extern struct qup_mini_core_info qup_mini_cores[];
+#endif
+
 /**
  * geni_enable_interrupts() Enable interrupts.
  * @rsc: Pointer to a structure representing SE-related resources.
@@ -163,16 +170,47 @@ static void geni_config_common_control(struct qup_se_rsc *rsc)
 		       COMMON_CSR_SLV_CLK_CGC_ON_BMASK);
 }
 
-static int load_se_firmware(struct qup_se_rsc *rsc, struct elf_se_hdr *hdr)
+static int load_se_firmware(struct qup_se_rsc *rsc, bool elf, void *info)
 {
+	struct elf_se_hdr *hdr, tmp_hdr;
 	const u32 *fw_val_arr, *cfg_val_arr;
 	const u8 *cfg_idx_arr;
 	u32 i, reg_value, mask, ramn_cnt;
 	int ret;
 
-	fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
-	cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
-	cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	if (elf) {
+		hdr = info;
+		fw_val_arr = (const u32 *)((u8 *)hdr + hdr->fw_offset);
+		cfg_idx_arr = (const u8 *)hdr + hdr->cfg_idx_offset;
+		cfg_val_arr = (const u32 *)((u8 *)hdr + hdr->cfg_val_offset);
+	} else if (IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
+		/*
+		 * Minicore controllers come with pre-configured functionality
+		 * and don't need a firmware download and just need the register
+		 * configuration. Hence, skipping the firmware part and setting
+		 * up just the register configuration related information.
+		 */
+		struct qup_mini_core_info *qmc = info;
+
+		for (; qmc->serial_protocol != GENI_SE_INVALID_PROTO; qmc++)
+			if (qmc->serial_protocol == rsc->protocol)
+				break;
+
+		tmp_hdr.magic = MAGIC_NUM_SE;
+		tmp_hdr.version = 1;
+		tmp_hdr.serial_protocol = rsc->protocol;
+		tmp_hdr.fw_version = qmc->fw_version;
+		tmp_hdr.cfg_version = qmc->cfg_version;
+		tmp_hdr.fw_size_in_items = qmc->cfg_ram_count;
+		tmp_hdr.cfg_size_in_items = qmc->cfg_count;
+		hdr = &tmp_hdr;
+		fw_val_arr = (const u32 *)qmc->cfg_ram;
+		cfg_idx_arr = (const u8 *)qmc->cfg_idx;
+		cfg_val_arr = (const u32 *)qmc->cfg_val;
+	} else {
+		dev_err(rsc->dev, "Neither fw nor register settings found\n");
+		return -EINVAL;
+	}
 
 	geni_config_common_control(rsc);
 
@@ -350,8 +388,9 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 {
 	struct qup_se_rsc rsc;
 	struct elf_se_hdr *hdr;
+	bool elf;
 	int ret;
-	void *fw;
+	void *fw, *info;
 
 	rsc.dev = dev;
 	rsc.base = qup_base;
@@ -377,15 +416,22 @@ int qcom_geni_load_firmware(phys_addr_t qup_base,
 	/* The firmware blob is the private data of the GENI wrapper (parent) */
 	fw = dev_get_priv(dev->parent);
 
-	ret = read_elf(&rsc, fw, &hdr);
-	if (ret) {
-		dev_err(dev, "Failed to read ELF: %d\n", ret);
-		return ret;
+	if (IS_ELF(*(Elf32_Ehdr *)fw)) {
+		ret = read_elf(&rsc, fw, &hdr);
+		if (ret) {
+			dev_err(dev, "Failed to read ELF: %d\n", ret);
+			return ret;
+		}
+		elf = true;
+		info = hdr;
+	} else {
+		elf = false;
+		info = fw;
 	}
 
 	dev_info(dev, "Loading QUP firmware...\n");
 
-	return load_se_firmware(&rsc, hdr);
+	return load_se_firmware(&rsc, elf, info);
 }
 
 /*
@@ -414,6 +460,11 @@ static int geni_se_of_to_plat(struct udevice *dev)
 
 		if (proto == GENI_SE_INVALID_PROTO)
 			plat->need_firmware_load = true;
+
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+		if (readl(res.start + QUPV3_SE_HW_PARAM_2) & GENI_USE_MINICORES)
+			plat->is_mini_core = true;
+#endif
 	}
 
 	return 0;
@@ -473,7 +524,7 @@ static int probe_children_load_firmware(struct udevice *dev)
 		ret = 0;
 		/* Find the device for this ofnode, or bind it */
 		if (device_find_global_by_ofnode(child, &child_dev))
-			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);	
+			ret = lists_bind_fdt(dev, child, &child_dev, NULL, false);
 		if (ret) {
 			/* Skip nodes that don't have drivers */
 			debug("Failed to probe child %s: %d\n", ofnode_get_name(child), ret);
@@ -492,7 +543,7 @@ static int probe_children_load_firmware(struct udevice *dev)
  * Load firmware for QCOM GENI peripherals from the dedicated partition on storage and bind/probe
  * all the peripheral devices that need firmware to be loaded.
  */
-static int qcom_geni_fw_initialise(void)
+int qcom_geni_fw_initialise(void)
 {
 	debug("Loading firmware for QCOM GENI SE\n");
 	struct udevice *geni_wrapper, *blk_dev;
@@ -518,6 +569,12 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+	if (plat->is_mini_core) {
+		fw_buf = qup_mini_cores;
+		goto mini_core;
+	}
+#endif
 	ret = find_qupfw_part(&blk_dev, &part_info);
 	if (ret) {
 		pr_err("QUP firmware partition not found\n");
@@ -544,6 +601,9 @@ static int qcom_geni_fw_initialise(void)
 		return 0;
 	}
 
+#if IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)
+mini_core:
+#endif
 	/*
 	 * OK! Firmware is loaded, now bind and probe remaining children. They will attempt to load
 	 * firmware during probe. Do this for each GENI SE wrapper that needs firmware loading.
@@ -563,7 +623,14 @@ static int qcom_geni_fw_initialise(void)
 	return 0;
 }
 
+#if CONFIG_XPL_BUILD
+int qcom_geni_fw_probe(struct udevice *dev)
+{
+	return qcom_geni_fw_initialise();
+}
+#else
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
+#endif
 
 static const struct udevice_id geni_ids[] = {
 	{ .compatible = "qcom,geni-se-qup" },
@@ -577,4 +644,7 @@ U_BOOT_DRIVER(geni_se_qup) = {
 	.of_to_plat = geni_se_of_to_plat,
 	.plat_auto = sizeof(struct geni_se_plat),
 	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
+#if CONFIG_XPL_BUILD
+	.probe = qcom_geni_fw_probe,
+#endif
 };
diff --git a/include/soc/qcom/geni-se.h b/include/soc/qcom/geni-se.h
index fc9a8e82cd8..94f3e5c8c7e 100644
--- a/include/soc/qcom/geni-se.h
+++ b/include/soc/qcom/geni-se.h
@@ -77,6 +77,7 @@ enum geni_se_protocol_type {
 #define SE_IRQ_EN			0xe1c
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define SE_HW_PARAM_2			0xe2c
 #define SE_DMA_GENERAL_CFG		0xe30
 
 /* GENI_DFS_IF_CFG fields */
@@ -248,6 +249,7 @@ enum geni_se_protocol_type {
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
+
 /*
  * For QUP HW Version >= 3.10 Tx fifo depth support is increased
  * to 256bytes and corresponding bits are 16 to 23
diff --git a/include/soc/qcom/qup-fw-load.h b/include/soc/qcom/qup-fw-load.h
index a67a93c72a4..4e876e650a2 100644
--- a/include/soc/qcom/qup-fw-load.h
+++ b/include/soc/qcom/qup-fw-load.h
@@ -14,6 +14,7 @@
 #define GENI_INIT_CFG_REVISION		0x0
 #define GENI_S_INIT_CFG_REVISION	0x4
 #define GENI_FORCE_DEFAULT_REG		0x20
+#define GENI_OUTPUT_CTRL		0x24
 #define GENI_CGC_CTRL			0x28
 #define GENI_CFG_REG0			0x100
 
@@ -21,6 +22,9 @@
 #define RX_FIFO_WIDTH_BIT		24
 #define RX_FIFO_WIDTH_MASK		0x3F
 
+#define QUPV3_SE_HW_PARAM_2		0xe2c
+#define GENI_USE_MINICORES		BIT(12)
+
 /*Same registers as GENI_DMA_MODE_EN*/
 #define QUPV3_SE_GENI_DMA_MODE_EN	0x258
 #define GENI_M_IRQ_ENABLE		0x614
@@ -173,6 +177,17 @@ struct elf_se_hdr {
 
 struct udevice;
 
+struct qup_mini_core_info {
+	u16 serial_protocol;
+	u16 fw_version;
+	u16 cfg_version;
+	u16 cfg_count;
+	u32 *cfg_val;
+	u8 *cfg_idx;
+	u32 *cfg_ram;
+	u32 cfg_ram_count;
+};
+
 int qcom_geni_load_firmware(phys_addr_t qup_base, struct udevice *dev);
 
 #endif /* _LINUX_QCOM_QUP_FW_LOAD */
-- 
2.34.1

