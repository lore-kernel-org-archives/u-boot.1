Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB325E6749C
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C80FA83EE4;
	Mon, 22 Dec 2025 12:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CcbDFbkd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a5v0hIxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323D383C28; Mon, 22 Dec 2025 12:49:10 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5E383EDF
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM824nY3586371
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WE87i7jZy4V
 zH9J8SKTMObSspxXmod+n8dkZYu+LyCE=; b=CcbDFbkdBFiiJysyEYUOtfiq9qz
 Tgzex2ZmVhBdDR8K5KXSEViaJK5W9pY/gyoYYVUc0ltFCGlig3b9Jbl40LUoLb3A
 8RBJmSPxdhb1IgNVvO3wce+/CGeFKweHPNhRFgp7dx8xfCQeEJSb7FEI6lt+7RBK
 cTX1Mt8UD2wEpjh6CmFFwPzXR78idJU1NFWE2X16tTn8rU7sxKk3PSvy36gC4XTZ
 ePcBZh2rkPlCj/yOS2cE6abLYajFQoaXS6auBxFvn+PuLZQl/piI0FUhXF8bYGlz
 zUjZHMfCTq/Szs0rRqKRvMY8o0qRLSJnHmMFY0Ux49ETp/Skx31K7t7E31w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b69ahk629-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:49:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a0fe4ade9eso40967285ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766404144; x=1767008944; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WE87i7jZy4VzH9J8SKTMObSspxXmod+n8dkZYu+LyCE=;
 b=a5v0hIxZYhMCoQVGbfwBrtoGNWtWqdGtLFPeZA3I0uGl/uPrYqwnvVWqfY3Y5JaHdV
 SajWndO/SWGdB/4uu7v5jL8xBgb4gZr7ov6kEJs5AVDZ50FDDqMlxaysfA7zfCvE/YGN
 qLMuSP+rSKaS9vEvayHLbhdnCmxRLeaFLa5yBT3Rh8dAWnb9AuQtEWu2Xq5mVH/x4qCs
 fiTRTWZq1SKBFKdScwrP7JPYevAfhibXGoLljZRWjGD8faCzuy7QtMni2NAoCZBuBxnY
 YnS1U+G1z6srYp/Bf5i7QHdjzLSk/HT8x7wylC5gJI9rC5fwKnYVeA36X31xyWeG0EfE
 aoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766404144; x=1767008944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WE87i7jZy4VzH9J8SKTMObSspxXmod+n8dkZYu+LyCE=;
 b=lv60Ry17S6y6mb5y7nt3lhabDjd3OeK8FXQwgnrjPipuFbZukGEYAo/E+F80Q2dvcQ
 9VL+6tAagEJ8ahVXH/wFnnEG/P6p29Lg6tKNmfsxwts9R0zI+IOGYmLya6l9/4RsVleY
 AeJKxrs4f7q2+3WyuKmty8xxCiQ6tcBByuMB6x4soXdn/RgJUQjxrmRexVSFwcVadNaf
 PZeIk1CBC72+JgG7NcYbatnHv1RMEqDb4nqDb9WrxfFGlFbxC3VycgEJbqGifumlJePr
 C+Ws0mhvdNL8fsd6i7rSfrXWQ22Iisyd0ZAxnJfCPPllyL5v6LAO/jwn3UKlkWpLt371
 X9aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU4S1VSdUxzP/NKALZxUfbM4xxBlro9uVt81SsfNlJQJh72FSB3bN7OdzDOGVg4sJnxSvqkDg=@lists.denx.de
X-Gm-Message-State: AOJu0YxWl1QCcR8H5FzCEhSWpOGJBMEf+qZGtKvXzhAsTv1XxyqE1NuN
 CxaWwTNnkcWMX0bli9U41EFMgtXAx6Mt8sCJ8wL8JfwEELwqKiQNppsJEx3D883cBSMAyUUsx66
 bZkWk2zQLxvF2g/aycKKjxH1RmgXZTkDLDPAbYLZ1s/lOQEfwL01Cz5e5
X-Gm-Gg: AY/fxX4Cq9fnSp7DM390VlmLq9tu1f7E9/mcTWWB+p0kjIXE185MD/xLbR73HtNCegG
 7gqwyCIRJp2SvaVmzmQa23gYmR6aWGCHM1XmI0scm7He1VuzyUWF1CPUtnhZZcljInq66sjCdbl
 tDJnm1RalgqYNryJk3IUUj9l3ZhPEyT7JFmyneNtdp/F5LlhpGoabpVX1VcnO/3n4oXyXMqfI1n
 qzik9zkm+9C/1dHqcp0cGe4ZRYvAHB37LjFQiNrlt4Ll2tjHUNQ3SOprkr7qzVcSfPzpvED331K
 tI7wK+bUsLLXINf9LpxgBzLNbc6i3NvFm6fStZna6lqi3JWh7GyqfeZZu5oT2jM4Q+/kTNLOVCH
 u1DsdJnOiJnYuVzKHYwlAUg2revppyrTcEKM5c4eetZOneB+8Scu6TE4oSGNoAd47ijrQq33Vpg
 sQ2iZVUXTNBZ3TXe9sBWw3fDhaciHq
X-Received: by 2002:a17:903:1986:b0:2a1:5d5:78a7 with SMTP id
 d9443c01a7336-2a2f2426c41mr97894025ad.24.1766404142880; 
 Mon, 22 Dec 2025 03:49:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPzSt4p21DTU1fAu321wztSOw/2ZERw/VhCl/5us4gWhc4dqnRKOtdxnxrNANwa8W9wpBVyA==
X-Received: by 2002:a17:903:1986:b0:2a1:5d5:78a7 with SMTP id
 d9443c01a7336-2a2f2426c41mr97893815ad.24.1766404142312; 
 Mon, 22 Dec 2025 03:49:02 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d658sm94875935ad.78.2025.12.22.03.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 03:49:01 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v7 1/4] power-domain: Add QCOM RPMH Power Domain Driver Support
Date: Mon, 22 Dec 2025 17:18:20 +0530
Message-Id: <20251222114823.2146775-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JuH8bc4C c=1 sm=1 tr=0 ts=69493030 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=mxzJDyrKheeO0MTuWfoA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: U2K8ulcihucnZqbMpC0rVh-x-hxoE2-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNiBTYWx0ZWRfX+ya9llp/aLoQ
 glnrewjIcuyKosINqN2QBQZpOtGv6Wc8Br2ZpM2FDAgjpIcIXajpxDIh2ZFJZABEiC7HVgcLCaA
 x2FS4hN+Wi3OShAGboCcszLKet5JMjenW3GHptzsaRJWME7w9uI+vNgSY8ybji+vPiA35bbfpC9
 2Cp53TXCi7iIgNQnqSdAvcWNyoTAa3glqbuhqZ/ANU7fTIdOn77FSNFY0Jtv2ZDUr47v6Pk6yXo
 ZBPjD4kXVthMtnPzaX2ctTXNLzwBBjzM+xUOXAH8PMhKgTOvKZI7Re2tF8MuzNY/ypz9JMaJkty
 zfglpxaRbwP/7Q9a7Pi0qLF//L2ZLnPddxy70eVbtnpkpY/hZVnLawjYwWoaADMuKoManSj0dma
 UYhWmLSIrJi78Vvix6PvOqwTcwEZqMoYp3yyBuAic6y52IRKACS6TsGVFqKyLoou0P7F/q0rgcb
 dnwvfzgVHGxnPy5rQJw==
X-Proofpoint-GUID: U2K8ulcihucnZqbMpC0rVh-x-hxoE2-W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220106
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

Added support for Qualcomm RPMH power domain driver, responsible
for managing power domains on Qualcomm SoCs. This is a port of
the Linux RPMHPD driver [1] and sa8775p related changes. The
power domain driver currently has support to power on and off
MMCX power domain of sa8775p; support for other soc entries power
domains are stubbed, in future, the required soc support can be
added.

[1]:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v7:
- No changes to this patch in v7

v6:
- Initialized ret with 0 in rpmhpd_probe()

v5:
- Changed the first argument passed to rpmh_write as pd->dev
- Added (ulong) casting in rpmhpd_match_table to address the warning.

v4:
- Added all SoC entries from the Linux driver and stubbed it
- Removed "qcom_rpmhpd" driver
- Removed unused members in struct rpmhpd

v3:
- No changes to this patch in v3

v2:
- Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN Kconfig
- In qcom-rpmhpd driver, the un-supported power domains are handled with warning
  in rpmhpd_power_on() & rpmhpd_power_off()
---
 drivers/power/domain/Kconfig       |   8 +
 drivers/power/domain/Makefile      |   1 +
 drivers/power/domain/qcom-rpmhpd.c | 278 +++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 0ad885c9e8b..48e841c638e 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -90,6 +90,14 @@ config MESON_SECURE_POWER_DOMAIN
 	  Enable support for manipulating Amlogic Meson Secure power domains.
 	  Support for Amlogic A1 series.
 
+config QCOM_POWER_DOMAIN
+	bool "Enable the QCOM RPMH Power domain driver"
+	depends on POWER_DOMAIN && ARCH_SNAPDRAGON
+	help
+	  Generic RPMH power domain implementation for QCOM devices.
+	  The RPMH power domain driver is responsible for managing power
+	  domains on Qualcomm SoCs.
+
 config SANDBOX_POWER_DOMAIN
 	bool "Enable the sandbox power domain test driver"
 	depends on POWER_DOMAIN && SANDBOX
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 8e03f620437..1c2c64b0964 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
 obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
 obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
 obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
+obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
new file mode 100644
index 00000000000..f51bc9a4bbb
--- /dev/null
+++ b/drivers/power/domain/qcom-rpmhpd.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+// Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+
+#include <dm.h>
+#include <dm/lists.h>
+#include <power-domain.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+
+#include <power-domain-uclass.h>
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dm/device_compat.h>
+
+#define RPMH_ARC_MAX_LEVELS	16
+
+/**
+ * struct rpmhpd - top level RPMh power domain resource data structure
+ * @dev:                rpmh power domain controller device
+ * @pd:                 generic_pm_domain corresponding to the power domain
+ * @parent:             generic_pm_domain corresponding to the parent's power domain
+ * @enable_corner:      lowest non-zero corner
+ * @level:              An array of level (vlvl) to corner (hlvl) mappings
+ *                      derived from cmd-db
+ * @level_count:        Number of levels supported by the power domain. max
+ *                      being 16 (0 - 15)
+ * @enabled:            true if the power domain is enabled
+ * @res_name:           Resource name used for cmd-db lookup
+ * @addr:               Resource address as looped up using resource name from
+ * @skip_retention_level: Indicate that retention level should not be used for the power domain
+ */
+struct rpmhpd {
+	struct udevice	*dev;
+	struct power_domain pd;
+	struct power_domain *parent;
+	unsigned int	enable_corner;
+	u32		level[RPMH_ARC_MAX_LEVELS];
+	size_t		level_count;
+	bool		enabled;
+	const char	*res_name;
+	u32		addr;
+	bool		skip_retention_level;
+};
+
+struct rpmhpd_desc {
+	struct rpmhpd **rpmhpds;
+	size_t num_pds;
+};
+
+/* RPMH powerdomains */
+static struct rpmhpd mmcx_ao;
+static struct rpmhpd mmcx = {
+	.res_name = "mmcx.lvl",
+};
+
+static struct rpmhpd mmcx_ao = {
+	.res_name = "mmcx.lvl",
+};
+
+/* SA8775P RPMH power domains */
+static struct rpmhpd *sa8775p_rpmhpds[] = {
+	[SA8775P_MMCX] = &mmcx,
+	[SA8775P_MMCX_AO] = &mmcx_ao,
+};
+
+static const struct rpmhpd_desc sa8775p_desc = {
+	.rpmhpds = sa8775p_rpmhpds,
+	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
+};
+
+/* stub RPMH power domains mapped for unsupported platforms */
+static struct rpmhpd *stub_rpmhpds[] = {};
+
+static const struct rpmhpd_desc stub_desc = {
+	.rpmhpds = stub_rpmhpds,
+	.num_pds = ARRAY_SIZE(stub_rpmhpds),
+};
+
+static const struct udevice_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,sa8775p-rpmhpd", .data = (ulong)&sa8775p_desc },
+	{ .compatible = "qcom,qcs615-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,qcs8300-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,qdu1000-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sa8155p-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sa8540p-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sar2130p-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sc7180-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sc7280-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sc8180x-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sdm670-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sdm845-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sdx55-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sdx65-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sdx75-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sm4450-rpmhpd", .data = (ulong)&stub_desc},
+	{ .compatible = "qcom,sm6350-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm7150-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8150-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8250-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8350-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8450-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8550-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8650-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,sm8750-rpmhpd", .data = (ulong)&stub_desc },
+	{ .compatible = "qcom,x1e80100-rpmhpd", .data = (ulong)&stub_desc },
+	{ }
+};
+
+static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
+			      unsigned int corner, bool sync)
+{
+	struct tcs_cmd cmd = {
+		.addr = pd->addr,
+		.data = corner,
+	};
+
+	return rpmh_write(pd->dev, state, &cmd, 1);
+}
+
+static int rpmhpd_power_on(struct power_domain *pd)
+{
+	int ret;
+	unsigned int corner;
+	struct rpmhpd **rpmhpds;
+	const struct rpmhpd_desc *desc;
+	struct rpmhpd *curr_rpmhpd;
+
+	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmhpds = desc->rpmhpds;
+	curr_rpmhpd = rpmhpds[pd->id];
+
+	/* Do nothing for undefined power domains */
+	if (!curr_rpmhpd) {
+		log_warning("Power domain id (%ld) not supported\n",
+			    pd->id);
+		return 0;
+	}
+
+	corner = curr_rpmhpd->enable_corner;
+
+	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
+				 false);
+	if (!ret)
+		curr_rpmhpd->enabled = true;
+
+	return ret;
+}
+
+static int rpmhpd_power_off(struct power_domain *pd)
+{
+	int ret;
+	unsigned int corner;
+	struct rpmhpd **rpmhpds;
+	const struct rpmhpd_desc *desc;
+	struct rpmhpd *curr_rpmhpd;
+
+	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmhpds = desc->rpmhpds;
+	curr_rpmhpd = rpmhpds[pd->id];
+
+	/* Do nothing for undefined power domains */
+	if (!curr_rpmhpd) {
+		log_warning("Power domain id (%ld) not supported\n",
+			    pd->id);
+		return 0;
+	}
+
+	corner = 0;
+
+	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
+				 false);
+	if (!ret)
+		curr_rpmhpd->enabled = false;
+
+	return ret;
+}
+
+static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
+{
+	int i;
+	const u16 *buf;
+
+	buf = cmd_db_read_aux_data(rpmhpd->res_name, &rpmhpd->level_count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	/* 2 bytes used for each command DB aux data entry */
+	rpmhpd->level_count >>= 1;
+
+	if (rpmhpd->level_count > RPMH_ARC_MAX_LEVELS)
+		return -EINVAL;
+
+	for (i = 0; i < rpmhpd->level_count; i++) {
+		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
+			continue;
+
+		rpmhpd->level[i] = buf[i];
+
+		/* Remember the first corner with non-zero level */
+		if (!rpmhpd->level[rpmhpd->enable_corner] && rpmhpd->level[i])
+			rpmhpd->enable_corner = i;
+
+		/*
+		 * The AUX data may be zero padded. These 0 valued entries at
+		 * the end of the map must be ignored.
+		 */
+		if (i > 0 && rpmhpd->level[i] == 0) {
+			rpmhpd->level_count = i;
+			break;
+		}
+		debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
+		      rpmhpd->level[i]);
+	}
+
+	return 0;
+}
+
+static int rpmhpd_probe(struct udevice *dev)
+{
+	int i, ret = 0;
+	struct rpmhpd **rpmhpds;
+	struct rpmhpd *priv;
+	const struct rpmhpd_desc *desc;
+
+	desc = (const struct rpmhpd_desc *)dev_get_driver_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmhpds = desc->rpmhpds;
+
+	for (i = 0; i < desc->num_pds; i++) {
+		if (!rpmhpds[i])
+			continue;
+
+		priv = rpmhpds[i];
+		priv->dev = dev;
+		priv->addr = cmd_db_read_addr(priv->res_name);
+		if (!priv->addr) {
+			dev_err(dev, "Could not find RPMh address for resource %s\n",
+				priv->res_name);
+			return -ENODEV;
+		}
+
+		ret = cmd_db_read_slave_id(priv->res_name);
+		if (ret != CMD_DB_HW_ARC) {
+			dev_err(dev, "RPMh slave ID mismatch\n");
+			return -EINVAL;
+		}
+
+		ret = rpmhpd_update_level_mapping(priv);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static const struct power_domain_ops qcom_rpmhpd_power_ops = {
+	.on = rpmhpd_power_on,
+	.off = rpmhpd_power_off,
+};
+
+U_BOOT_DRIVER(qcom_rpmhpd_drv) = {
+	.name = "qcom_rpmhpd_drv",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = rpmhpd_match_table,
+	.probe = rpmhpd_probe,
+	.ops = &qcom_rpmhpd_power_ops,
+};
-- 
2.34.1

