Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6258CD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE2E83E0F;
	Thu, 13 Nov 2025 12:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oofDZ3cf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ba+Cg9Ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A36B083E0E; Thu, 13 Nov 2025 12:35:00 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F370383DFA
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ADAHbrg4097398
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y75bXyjnT8M
 F5XHxDfQgSfTvaVMtb+i3zUQHhfuf8G0=; b=oofDZ3cfuax0eS14MP1LaRxHJ/b
 /EEPU9eKbms7l4aw5KLzE4dlWWrxKt2RF6lUJmKkixJ2OBQ2D51NcIEZgZtwM3At
 H+u7TgwPYyAiHr41MMHxzL1DXHD8va0S7jWcWQPupnyQM/imzarNuJsOSVttmPYa
 C5RFghG2lQBXEY4HGlEjb/ncjRirWeOtBIXPys6i5z7Rv/FIfJXExGyfQOtopoSd
 uhUCiEBihE+BvfgJYHYCrkLhp/43TcicW3CuUUjEnl67Z+WxJHz7y0uPe1/w34fE
 HT6OY+aX91jFY8tR0AQAP4/YqZ8FhDAR0bX2ozjbC71VNQjKcvsjQRYe7gA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4addetr6bb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:34:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-297dde580c8so20695835ad.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 03:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763033695; x=1763638495; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y75bXyjnT8MF5XHxDfQgSfTvaVMtb+i3zUQHhfuf8G0=;
 b=Ba+Cg9EiI+iKMCSE3+/nEwnbnnekk5ryifutgeK4EBEjwwaT2e9O7nlKG5dvlnE0Uq
 XSGYRawjyBw6I03IRrm3sm+V2KdZ5bVy0Np8aC4MwOezh/uF3HjwZX54Kpw7kvPVWCmZ
 TzvcDKYGrJgoMzsjVAOyxSW84uFSy/jmU/HTP2uIbvxSFdRSpmpeCX2AemE9Okg5VavD
 MCbflJ0wNSBzBKpf3FCPRZ+0T0pcPCHR9IIWEasX7YAdetCSjgsJjSm4ysjMNRfLDaDI
 W2b528BX3bi6Ah1Dp4aRsmcBNwP5s9wEcptRDIw9HrhXZedNC6f3ARoBi4p5ak8Qb+xW
 Qtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033695; x=1763638495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y75bXyjnT8MF5XHxDfQgSfTvaVMtb+i3zUQHhfuf8G0=;
 b=VUQ1v0OJrmOyH/cVKiVnZu9sRAuq8dz+F6BsbUbWkhxUvPyMZqTo75RC/jhb5PSBSd
 YcIIZC6bld7MJhLq9rWG8dhgDJH1AqW77sRM/3xl7DqE/9wJID00Eg7qK/QNb/zXw0w6
 9y2/rhMVPbH0P6HLTulLOEiP8Iecvq2lSPHFFOGOoiOiJ21/jNZDK1z+zI1mDrkLPV1k
 wJf52L3yDJDZEjlxsM8GgYbFPKP81rev+pvkUTse6+iEjH8LBzoRnfWPARkZu1XZVWsg
 Wx2ypox9WRUXy+N4Xr2+W682PafSU5ZFP63UawH7oZwPi+IK21E+GFwSsNeoHTYaEk7x
 YQVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3+D9a45+VZxGrIE7iC1t5vEY/a22aoVlhecdUiOT1SM5ap7mlXub8xMEsXUZtw7O61d2wi6c=@lists.denx.de
X-Gm-Message-State: AOJu0YzxUk7xU2NdeYkhenzdIJXr8w6q9oiloBYxjpP/HkZ3pwnkA0za
 LqhvrgsQ/fxau4VDfWP1T6j82H0btiCwHbJHdz3eGlIy6D1J024w6oeX/Zp9iz2mZ82ER/Wbq5G
 5mO5k6FJkVfZmNC2Xnkp0JaonGsu8+lbhUC9FZv5q6GVL08jxdRmAb/r6
X-Gm-Gg: ASbGnctPEc986rKe9MF0gLWgawfJOgM/nAvpjxF7Hfk+ar2k1+IcW0/ghjw57nDkB6T
 PCwKjU5oOz7g0yXX5EusYbamXvS/bWqy+gJbDVf5HM7CRc6OKmvQ+FGdQlwTW9UQpe3NNqv66RP
 posKIqo6tUA7xwQYnbz0bKavHh+xk/P/BRtPRacZO3H2t3rk4YltpJY1glkkT3GcLmZBQuifhNR
 g1XIKwgCHCDUw/gKmx8WzUOy5/mZKfpJEesgsirBX4DCyFz18cKEady/pQ32qdfkpHKFRtxYI1d
 CpeAt3rRKmvpI9lV+Z1rJwMUcvU77vh4TY2oP1TLuuifOGpop05fZdkYlvYPsoXabqyDoBz7Z2D
 aBiG2aDFLVH//jDwZvjP5O+r6f6SvkgjytsXs+h2b8/flqNC02tjtK1+Y0smXxbitxzhMHIjEZr
 Xiwvxxg64Gp0kiA2gZdg==
X-Received: by 2002:a17:903:3b8e:b0:295:586d:677f with SMTP id
 d9443c01a7336-2984ed34290mr89025635ad.10.1763033694963; 
 Thu, 13 Nov 2025 03:34:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiB4aBqvSXv/V5dCC8vPOVM8m14HpXzpxHmWM2e1aqAi+8kKjWsYKdOwMZ8nwHcvj9Akmy4g==
X-Received: by 2002:a17:903:3b8e:b0:295:586d:677f with SMTP id
 d9443c01a7336-2984ed34290mr89025285ad.10.1763033694465; 
 Thu, 13 Nov 2025 03:34:54 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2346e6sm22573885ad.22.2025.11.13.03.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 03:34:54 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alif.zakuan.yuslaimi@altera.com,
 tien.fong.chee@altera.com, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v6 2/5] power-domain: Add QCOM RPMH Power Domain Driver Support
Date: Thu, 13 Nov 2025 17:04:24 +0530
Message-Id: <20251113113427.2218045-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
References: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Yir5uGRLlwD2t2tHxA9lB4TlcY-UzTzG
X-Proofpoint-ORIG-GUID: Yir5uGRLlwD2t2tHxA9lB4TlcY-UzTzG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4NiBTYWx0ZWRfX61FXvjFzm9MH
 Ft6LAMs0GWvyER6UkX+m51m95j/vpEMzsP6Vd7qTh+bszTcFYVieMLfNWOs7l9QQ8juLcZc7bjo
 NTJKndAKH4NttKutCqif2UtHh+dp/Zk+3r0ySwjj52I06xDv3CPgorZunxvnxCzjwTVY8VromGp
 nd8cF5Ndb4bv3mbZHo7Q+ez3VeLM5EaofXLJvg3JJ9UHjA9M5FrXamY+tEfGn0l8Q9i9AXGepFi
 8JQt6vrXuM0Fkqaswew8BEEzQWXkuSsfjYJ8F3WytUXPz1+nLrmZ16es7KQZpyGa53oOZ3mhjcp
 VWX7OHl9OGdYR7REHEE93Vq/IVdivArTKuIpc8goONVYynykfuO9O3CyZxLlyS37vWP0ER0Lw7T
 pMM8IWhX1DqtwxJPvPWEXRDqck0kdg==
X-Authority-Analysis: v=2.4 cv=QZNrf8bv c=1 sm=1 tr=0 ts=6915c260 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=mxzJDyrKheeO0MTuWfoA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130086
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
index 00000000000..12d934acd2d
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

