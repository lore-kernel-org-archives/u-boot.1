Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701ABC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 17:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA1582F03;
	Wed,  2 Jul 2025 19:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ooDKGPkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9807D82EB8; Wed,  2 Jul 2025 19:13:55 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E786282F00
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 19:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562DcdJU028664
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 17:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yIU6S+Zl5l/
 g0Yhkc3mjKAg+xudYtZaFwVqyQFKkrHM=; b=ooDKGPkHNwnkquxlWf1+44KXlmB
 4KkpU0PDApE18gopsHdU6YiFpWLgkkT3O9r5OLrYwPIeACoV8erkMLnO0RE2tRMH
 98T9lDgqPmG1Hl3rjvd4nDzvubAH0EKyhniTeFxqIjU7U2kwAh/U0C0G1Fw4+eda
 ShGK5Rl6GBd8ET93DYZHRTvFw1KQDaFiuSO99vdLnHaaSiX83vUV5oxHNx5jZci2
 wNYCOhrvlWMV+0E5Vg0nbELSL6yWbKFqdstwMvMfyA2d4A1KxmUrb5agNwDzxAY9
 cUhCiqLX8+Ed81kFudI3du/+RNKOFGhJKiu26NBULmlfAi6Sx8WRlKuR/lA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7bvwfvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 17:13:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-748764d84feso7175825b3a.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 10:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751476430; x=1752081230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIU6S+Zl5l/g0Yhkc3mjKAg+xudYtZaFwVqyQFKkrHM=;
 b=OWkcg905ElB6EZBc5yZR7IbJ7kCmkuxuatNtukcPRzuD/Gma9vpoF5SAv4SROs1Nqv
 iXtEKkTuJKuq3E7YzQPDBhu77YdbKqDGUmVGPdycP0NLE0KKcYUs1v/N9vjJgHMgcz/V
 u0hRNpGNdAt6IjgmzJ4RxarXy+//TxU09sq/oiFGoTZkaj9X8uhkUyC6+h5kks7+hEqI
 28bbqPx0X/B/fcENHYxCrdKwEqneF6dqPn60jG9R9UITvy3JIfXcUPWbhjVAojGSq514
 zyNA2PrcOcsg1DkW9OUCo7gdriArNbRjxqZCRDxEqEiailyiFH9+JdNJZ24vKbhxVTcs
 M0mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJvfipyshgnqinu5brIjWC0nKgshJdRcIh+TBX1IyPbctgE9+l6Ae2MWahv39lc7psh3ju9wA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywo1A/69GBTyz5nJ4Lg6+H4MZ5CrYfj4Rfifhp23cvpsydAVqkq
 DFM0sZydff5PorX0v5tJ/1cd9wlUqR20gHPJYjbsWdrx5OT0qug/z5zRemzm3jQawTxuEMMTAgn
 XcwSj8+qjfIpntxNw+hBHF/IFMevkTGO1WfbPpbZU6SVvWRZQySLD7joMjSTLzZTV
X-Gm-Gg: ASbGncs+c9zEbMsjxKt5LOU2aZ8Poj9U47xqVQDqbsqTCSp2FB15uotNtdpTFIwdwYe
 1gKmlYzaKiGJxd+84w52GIK/FLVYXnoYSL7DTLbM0E393doNjXQH1i+F+dtMZt+d2CY5lfxbw2i
 frasHdSmRVUtpbJu/GpoCyd829nIhpvBIN153kKb04r3n3khwqrgCoewkUnY8AhtI+i3J5/Y3TC
 LsbK0CwEGY06NOMMtgz+oDw1ZCQoy/AzKdKEZ+tKufVExLS7/j0v42QBgRCYLN3+ohdmSKKcSAO
 RWZZDi4JI/K0nGxKRMpuPkiOWv6QoQ5NlqpPuV2JE37TX0xfk0Lpe+gx/39W7jfzdlrgcBCmcJr
 3JXirwpwcdqN4TQftFTsRdc0qUBxaxNoks7uiongc6g==
X-Received: by 2002:a05:6a00:4650:b0:748:38fa:89bd with SMTP id
 d2e1a72fcca58-74b51319faamr4678938b3a.9.1751476429883; 
 Wed, 02 Jul 2025 10:13:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKAtsEJ1tQ6Qsy0iPDPFxBKtdJv0bnQPnD3iEfWp7rN9UbKVAH2lDEr51k7ZjNW1k3h9QmHw==
X-Received: by 2002:a05:6a00:4650:b0:748:38fa:89bd with SMTP id
 d2e1a72fcca58-74b51319faamr4678904b3a.9.1751476429377; 
 Wed, 02 Jul 2025 10:13:49 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c5837sm15144873b3a.116.2025.07.02.10.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 10:13:49 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 1/4] power-domain: Add QCOM RPMH Power Domain Driver Support
Date: Wed,  2 Jul 2025 22:43:32 +0530
Message-Id: <20250702171335.1811080-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
References: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gdA5tYmdWZOpdCWpedeo8_-UrUxUfyQW
X-Authority-Analysis: v=2.4 cv=RJCzH5i+ c=1 sm=1 tr=0 ts=686568cf cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dOdPE9zRFeXb9eEKOhMA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: gdA5tYmdWZOpdCWpedeo8_-UrUxUfyQW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MSBTYWx0ZWRfX0++4SOZEukDy
 kX1D/LTGGnAoybkuJDf+rqH5dlJsCiAlLBdIgkq+S1mESqiOeD2nHz8sJG1quADqUVTfRsxhv9+
 kheytG9mEY+MkbDPU3g4ROd553vKVnqnrA6eXEmCWIxb0J5aNL7T0zJrUU3yBt7pkN/3TqOwsvV
 5PYEoQG/1YIUUCZVEZFnd6o3jB4Yjy8jxBOPzGP1rYyT2bwUKIfV7GaNcRQ3skdQKkL1QFAFy6C
 jHTQq9aL8I5cIOy5jUFsoYdiE/gzgDsGKgxF19lMoKawXUrk0tg5h1+SECAIxQHOKrarpZp3vRC
 WhA7GeC05O4sWd6qf0jR5Q1e+GoyAkual2fQtfN6W5a+iBX0hLTALfN+ur7pqj3qoOS9jU98ORw
 pOUIbZk40WiGY3uJWCk5erdvYLruvfbO6MY9o8noS7bAjBT/F82UNqKxHGdEVoNw//5qrxgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020141
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
MMCX power domain; support for other power domains can be added
in this driver.

[1]:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v2:
- Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN Kconfig
- In qcom-rpmhpd driver, the un-supported power domains are handled with warning
---
 drivers/power/domain/Kconfig       |   8 +
 drivers/power/domain/Makefile      |   1 +
 drivers/power/domain/qcom-rpmhpd.c | 285 +++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)
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
index 00000000000..a8eab26bd23
--- /dev/null
+++ b/drivers/power/domain/qcom-rpmhpd.c
@@ -0,0 +1,285 @@
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
+ * @peer:               A peer power domain in case Active only Voting is
+ *                      supported
+ * @active_only:        True if it represents an Active only peer
+ * @corner:             current corner
+ * @active_corner:      current active corner
+ * @enable_corner:      lowest non-zero corner
+ * @level:              An array of level (vlvl) to corner (hlvl) mappings
+ *                      derived from cmd-db
+ * @level_count:        Number of levels supported by the power domain. max
+ *                      being 16 (0 - 15)
+ * @enabled:            true if the power domain is enabled
+ * @res_name:           Resource name used for cmd-db lookup
+ * @addr:               Resource address as looped up using resource name from
+ *                      cmd-db
+ * @state_synced:       Indicator that sync_state has been invoked for the rpmhpd resource
+ * @skip_retention_level: Indicate that retention level should not be used for the power domain
+ */
+struct rpmhpd {
+	struct udevice	*dev;
+	struct power_domain pd;
+	struct power_domain *parent;
+	struct rpmhpd	*peer;
+	const bool	active_only;
+	unsigned int	corner;
+	unsigned int	active_corner;
+	unsigned int	enable_corner;
+	u32		level[RPMH_ARC_MAX_LEVELS];
+	size_t		level_count;
+	bool		enabled;
+	const char	*res_name;
+	u32		addr;
+	bool		state_synced;
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
+	.peer = &mmcx_ao,
+	.res_name = "mmcx.lvl",
+};
+
+static struct rpmhpd mmcx_ao = {
+	.active_only = true,
+	.peer = &mmcx,
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
+static const struct udevice_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,sa8775p-rpmhpd", .data = (ulong)&sa8775p_desc },
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
+	.probe = rpmhpd_probe,
+	.ops = &qcom_rpmhpd_power_ops,
+};
+
+int qcom_rpmhpd_bind(struct udevice *parent)
+{
+	struct rpmhpd_desc *data = (struct rpmhpd_desc *)dev_get_driver_data(parent);
+	struct driver *drv;
+	int ret;
+
+	/* Get a handle to the rpmhpd handler */
+	drv = lists_driver_lookup_name("qcom_rpmhpd_drv");
+	if (!drv)
+		return -ENOENT;
+
+	/* Register the rpmhpd dev */
+	ret = device_bind_with_driver_data(parent, drv, "qcom_rpmhpd_dev", (ulong)data,
+					   dev_ofnode(parent), NULL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+U_BOOT_DRIVER(qcom_rpmhpd) = {
+	.name = "qcom_rpmhpd",
+	.id = UCLASS_NOP,
+	.of_match = rpmhpd_match_table,
+	.bind = qcom_rpmhpd_bind,
+};
-- 
2.34.1

