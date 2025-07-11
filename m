Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5536C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE79982AF6;
	Fri, 11 Jul 2025 16:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuWxWPLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4E9800D7; Fri, 11 Jul 2025 16:39:16 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5912782AE9
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB3JN2031220
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0lvWKNpWcuD
 SpjvmuHu7CEDoGnRK/fU72v3CpAozDaw=; b=YuWxWPLmCLus4mw/IjNiw27t3T2
 FwKlfRWsS7yud6ddqQGVqOW4MWiUKxBgmGOBt8J7pPS+0Pnno0c4kNP97CvbsBlK
 kWT+vD6coC6nozhHlWhRMrIk/I4GiCIwJH79vLLUQXLLu5eF700csd87+bVqQso+
 TG9+arpMkXAGRDpGqhShbeear8xpzXmDZDADt7FXz8q5gOVemEc55DrOO8Yy7N00
 LRonqiZqYytupkCIcUKDg0HwGH7htkk0z6Hz0ueVrQFHnA6j7DCNtYSWwssEW0BP
 6TOD9nm9ul522htpcx86ou8k7oXdGwW+gF9wlTrawjn9TdoZOQZ3mvoWFdg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbery6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2369261224bso23480595ad.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752244750; x=1752849550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lvWKNpWcuDSpjvmuHu7CEDoGnRK/fU72v3CpAozDaw=;
 b=Mg0+iW1T0JjBLM/HYvH9Y8445G7FithinR/9xK+gJb6BaZdW0cILlltFoALRyLTjf7
 T+KUha1w9BpXLs0K7ONNr0g+3aczKpoLWTEpaI3RY72Yf2yiy0MIBN5bhMmBdzSrAzJ1
 AiRelQG7yzVjaD5oUvJ1/bpzEFQGzd4Rb5J6wHrXDvxIsrBKJYNALsDAG2EExyaWKcRa
 nr6TZ5maUt+dTWsbYYTpDoharkJzu8SOZVhw74JDDve5fRW+H9K5tpjZUypdtYcOpN7O
 Tk2xojshFhTvKCZoECJO3VyRY3cikVkifRyekwZK3yMEkwQbBukHXs5g9XlGo24rS73r
 +Y9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6k1q80RhejJSQWq6VHNKdszNTR/qrSn9O13uh0J87iKlXdJeO17Xe/a4gHnZ1dAowTLgch+o=@lists.denx.de
X-Gm-Message-State: AOJu0YwR2FgEbAMStkarVk4FpqjLckSUlFg9FpFJDuTIToahzChGgS+1
 6/oLFF89pY2pbmhwpm+FYOAUS1+Jqjq/6Hp6kR46ayR92qe9NGviP7G3jptsm9W22CGdUlLPZee
 3SbE8ZBQAJ18eNFv87K/KjdF25ckEt4Au5NOTuWy8UgziiZHnrpnTERXzE6Ab0IPi
X-Gm-Gg: ASbGncs6jRRRtpvWBjE8iq1J6aOxEKATk1EArbwMOs9+23nIDFmL+WLMYFV+aWWrmEK
 ayoPTeA0r7c1b6goSLfoAs9Pbhn2W8NO+hIlzKkwbZjLhu5XOEIqYfB1C3HVL0sLt6LpT3HRwDp
 O+xen0db++HcSMschXSh8dV5q7g08z3IqhIitVHi931TpN3at3fnlsdNe9csLmkXmXmv2iEOsmW
 TAsZU+ti7HeZ1FqBIdtVyJFPJdtRV1u+u4kzgBdp8kVbBQodR6VnM1WuWL8kPZk5glYS0A4hmU/
 ugvohokMQgq1F0EHXHA6M/3JGYvTokmNby5BMsW5WGhlKLS8F56bEX5nPBi8rqfzPYmqKayViES
 1ilfaStFLp4574xxP3iVFvFk8TLBDGvo450eR0/Y7pEwUcGLZsQ1G5kiGVNM=
X-Received: by 2002:a17:903:8c5:b0:23c:8f12:3f90 with SMTP id
 d9443c01a7336-23dee262fc7mr51841155ad.41.1752244750212; 
 Fri, 11 Jul 2025 07:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5C/yyqfouI55ZA1uHi029+SatCIpx1csEKgsJOJMaGQfXdFUB2qEN47bjtfmGR8vg9xA0/Q==
X-Received: by 2002:a17:903:8c5:b0:23c:8f12:3f90 with SMTP id
 d9443c01a7336-23dee262fc7mr51840475ad.41.1752244749416; 
 Fri, 11 Jul 2025 07:39:09 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de42ad948sm54234675ad.61.2025.07.11.07.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:39:09 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 me@samcday.com, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 2/4] power-domain: Add QCOM RPMH Power Domain Driver Support
Date: Fri, 11 Jul 2025 20:08:49 +0530
Message-Id: <20250711143851.1490617-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
References: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwNCBTYWx0ZWRfX168DC/ebR07n
 n5bLbiewvrWnS+9x9NiSSMHE3SynqRpHt8bEUSpPEcEoS2hf/zyof3bdl4/A3UAqlAPWNUG2eSF
 CbHKu8VIMJpMs2tFZ5c6Nb3mXw5W8orOZ+8zpSdFo12IHhU4oL3UL9+ePkuFvmHMs9Nru4u0K9L
 OEqO78plp08vljmaDOcms2HDIco+UAWRyueCUer+vZeE9EQFzd9j49T4/79D7lrDRftVTNAc/5g
 rO/+guaIqJFIAoUOjhghKKVxMm4DPhri4OfUPiolcx/JMErI3fAII08gYkphORecKrKQ5DJYSkH
 amWg1NCDaBIZVK1iLwQUP5QKwJFsjv0WGd2dt+8A9DkUKV+ziaSFD4TO9hpJU62b8whz0r0eTJY
 kRI7QPLCkSZt4/wsUcmVh3hZayhJu81fIX9HPg9NjT32xaO6bH/kE9WYDAINM/OvyhX/14dC
X-Proofpoint-GUID: ivp79OZQBbok4niS3OqlbUlMN1ywkPmR
X-Proofpoint-ORIG-GUID: ivp79OZQBbok4niS3OqlbUlMN1ywkPmR
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=6871220f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lCplmyEgRo2gNveOVkcA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110104
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

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
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
index 5f5218bd8b5..1456df96cd1 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -82,6 +82,14 @@ config MESON_SECURE_POWER_DOMAIN
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
index 4d20c97d26c..950f83972dc 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
 obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
 obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
 obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
+obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
new file mode 100644
index 00000000000..906af2aa0ba
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
+	{ .compatible = "qcom,qcs615-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sar2130p-rpmhpd", .data = &stub_desc},
+	{ .compatible = "qcom,sc7180-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sc7280-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sdm670-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sdm845-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sdx55-rpmhpd", .data = &stub_desc},
+	{ .compatible = "qcom,sdx65-rpmhpd", .data = &stub_desc},
+	{ .compatible = "qcom,sdx75-rpmhpd", .data = &stub_desc},
+	{ .compatible = "qcom,sm4450-rpmhpd", .data = &stub_desc},
+	{ .compatible = "qcom,sm6350-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sm7150-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sm8150-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sm8250-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sm8350-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sm8450-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sm8550-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sm8650-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,sm8750-rpmhpd", .data = &stub_desc },
+	{ .compatible = "qcom,x1e80100-rpmhpd", .data = &stub_desc },
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
+	return rpmh_write(pd->dev->parent, state, &cmd, 1);
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
+		log_warning("Power domain id (%d) not supported\n",
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
+		log_warning("Power domain id (%d) not supported\n",
+			    pd->id, 0);
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

