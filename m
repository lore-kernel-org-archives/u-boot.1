Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3294CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 11:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2823D83700;
	Mon, 27 Oct 2025 12:34:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a0Ohdsi2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E4C83837; Mon, 27 Oct 2025 12:34:07 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461A280107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59R86rNV841854
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2O4Xwe38+Xb
 DUM4UmmsXySN8jcDSvG6mY575+ALKLhw=; b=a0Ohdsi2GoGz+kd27FaXCYKxLka
 C3QqtF7QBtJEbYMxr6pRrOTMpUoJnfjhJDqDekQuNnaaF7ZZm6I7rRfQgDbKjNhq
 RS7vh/lCmi8LpEfTji/ddovO1imUcVoTo+5R10Fm+FmwC+w3vZpURPoZmq3OvtLn
 xRSj41bxJKkkRf8epI5mss76nhdNH8jqBvoGqdjHpItzKKVwu6xd3pFUamWt/mzt
 sEXU9tPVkHxefcHo6WzrQDUOlbNgkdEPah6Md9JrC2SA/cGRhEIx8tlvkIYbZvzj
 eqFjbkszp2j4FZKRUDeuQyZgq2jN9a24OEg4UA2GEyzwt/ebVt/NvJMnOYg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1uc59rq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:34:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32eb864fe90so8126816a91.3
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 04:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761564841; x=1762169641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2O4Xwe38+XbDUM4UmmsXySN8jcDSvG6mY575+ALKLhw=;
 b=cKjRZ14Nk4Cr/5UlfNmOw/aRMM22XxBM+B8n0eHqlVTc0Q/ahadD2e3cvIzNaaxInQ
 kVF/ZNyWy71LZ2YpIBDKcPaVIQfOco+dGB5GgJAGI09ZubMIzZmkisOhkoCgyYsBqPeg
 gltUf+uWQtj7zT5hij0ri7dWBZ4YJ5RAoHz/2AxBk/HB6hCLsg5GzGT1msqePqD4EVwl
 RnMJN2OrS/d43sy/EujYGo/e/1Og8Yy/pafj31OdvpobNpzT/SRiNYMDdVgIhXwRNT8E
 c9Z8DIpulS+BBlWW7BH26Lt8LffBE/9OkFYpb54tp81sZ7ek/nUJTx3UuZmQwgDwwScC
 A+dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViI5C6Cv/Py3ku4iHXe6maZNL746bJdohIG/Kbm0e5ydTqQz7+SBpPPBt6UZT7nhK/yax7teg=@lists.denx.de
X-Gm-Message-State: AOJu0YznsHJsGOSybqvwo60FbyEQbOz+W+ercKrFLdRaXheuV45YbVAu
 SvM/vXrEoc93Ddhxiw7qWSnx4/TUyPCRAOzyY6WUHGCdMvw9WjGaCzvFFXIRNLaw3WIvR2YldJg
 /irEA8+qUA8pFlyU+9m1lL7N0gb4R4lGh3Axt3hCCvoRB8iljv8xT6b3K
X-Gm-Gg: ASbGnctRw+gDVLwY7UMSGUvFIoEAZJq1Y9J//Ml1u8jm03WIIxUTcQ1vwjIXU4VEciM
 b/8ABsdIZHfFdgBNday/FapIwdAo7X0cxXuyosYPa/PuI3FpRCJ3+ghianOh61R8SgWubmq9FsK
 ogsWUDPCv+dCvutEK3GYNznpdgqNWElSDN5gBv74OwehvauvMu0Nk+1DL4Jey5xfWJ3QqPDyvFs
 BarWb+V5pxScJNeGSBXZDuOLvGY3i4KHq0ZCzVrwAOKhIQ3bXwr1dAI5hwSWak3KhVOTzr7RcpA
 6hwPujM92ggpiJMifF/hmiy/7D3gvq8iR31lmIAdzzKN48v0rBuQo5MMztOOJPT55NiWY9nTuuL
 9pjbm8XSikJUuzS9Wo/BGUzG8VZoMMnwVPDabe813frpiorLsXnsBmMc59Iu4ttaPTWuHfDHXZC
 2NHeCVNnqh
X-Received: by 2002:a17:902:e889:b0:274:746c:b09 with SMTP id
 d9443c01a7336-290cba491admr455544305ad.55.1761564841359; 
 Mon, 27 Oct 2025 04:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMbL1Mu/z4s09VzDF9BTMcvHMDbA2s3z6vpjotU1ZFg1mGuRvJo68aBPSp92/5V295ynm/nQ==
X-Received: by 2002:a17:902:e889:b0:274:746c:b09 with SMTP id
 d9443c01a7336-290cba491admr455543825ad.55.1761564840668; 
 Mon, 27 Oct 2025 04:34:00 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf4aa5sm78497825ad.13.2025.10.27.04.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:34:00 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Google-Original-From: Aswin Murugan <aswinm@qti.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v5 2/4] power-domain: Add QCOM RPMH Power Domain Driver Support
Date: Mon, 27 Oct 2025 17:03:10 +0530
Message-Id: <20251027113312.3815169-3-aswinm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m9QSlm-cAQ92a29fICdJVcaGjjsEq0QO
X-Proofpoint-ORIG-GUID: m9QSlm-cAQ92a29fICdJVcaGjjsEq0QO
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=68ff58aa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mxzJDyrKheeO0MTuWfoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwOCBTYWx0ZWRfX9jMZgZCXud0j
 YzOrFqUZAYiPtCzl1drbMSDI9JmltZl5PI8hb23ZNsX/QPu9Qcyed+5rIr+Qx6R/Z2+G6bK+mvc
 VEMzMsBLOLExgqdu7SKJGLQ6AW3O3c2h+e9gihQg5c4dpMnKtun3FPQPNbGvUwfq5Hoq5cArDvi
 eDlS7agpyVskhpwUj8bYuenaUQjo5ebzRS0PX6UlGaOOTJznoyuOsHfIaSAO26m1m/ebaGTgpj0
 NBqV5yWcQoM1BwWaySTfl9zIhw4IOH3lxxFJA5eGX60bsgV1UCBukzijtt5YiwoL6MLZ3/RiGVg
 8NAdeR0B5pY5PUWTT4ykM3VSGuif9ekOFs7LP5NSKUXQLKOwJf4IrZbOE5ARzlBcl6uLeaDi3Pg
 JE8e9lBJry6nhNuGun9+tRaWjpJsNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270108
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Added support for Qualcomm RPMH power domain driver, responsible
for managing power domains on Qualcomm SoCs. This is a port of
the Linux RPMHPD driver [1] and sa8775p related changes. The
power domain driver currently has support to power on and off
MMCX power domain of sa8775p; support for other soc entries power
domains are stubbed, in future, the required soc support can be
added.

[1]:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
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
index 00000000000..14e93f87005
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
+	int i, ret;
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

