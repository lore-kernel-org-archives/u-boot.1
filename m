Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D734C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE3A82D88;
	Thu, 26 Jun 2025 13:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKlQkYRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 101F182977; Thu, 26 Jun 2025 13:25:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE31D801BE
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9IHE4003766
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s/z0hcRa5en
 phzQKm/XaE05Y6qf+DbN3AdVCbHjdfLE=; b=OKlQkYRiCpp7E476dsAw+47dWQm
 Y+v4nCLZ3re/lv+DAsz//PaMAMuV5OfreXy+pv5kBN58T+IcJllLczvsK0Uwflfi
 sIYm7rTIBJ5pjW/Iv6bMtPB29gnkZV4oNVn3b9hPu4OvNoIBszGCk4J1r/SwxZoz
 WsrxLkUGa+Dt8vemXubNqAMS5IRC0kR9p0/iBlNFYpa5aasaJhutXlpXLorV9PJE
 y5bRk8sC2EOnBWzdRpx13baWpf12Qghk0nZhjMaVaRtBc4Tr2XzXYJPaU7wh/1Zt
 v+CiCMx6lz015m1xMiwbX4J1tbpduJcjdSxiiEmhnNNRaAFnh4gxUaJASRA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmvtvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b32010b3cc0so521736a12.2
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 04:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750937104; x=1751541904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/z0hcRa5enphzQKm/XaE05Y6qf+DbN3AdVCbHjdfLE=;
 b=InCGLbnaTz2TyHlndB1Duq531ONytG5oVJa9F1qdxdzPyhuKG0z6LPevJWpgGCob8l
 p7XWkYKWTSbeT+19zjrRYe+87Gj8UxnouMW3SHEdL1s4UX0MB7MXxnjneLbCFj/45gRL
 79PDRWDCsjVH3UziKaJknPvri7Rnb5pI8laggNn+9gJTifhoT4Pc/R3R0ChOSMtOI6tg
 NjH/g/cQ4ZUx+JwtMxg/RkaWny1GeKVJIhuJIe8ZkyoiqkFnj6pkw0ypQziSC044zNac
 lv8azDAM9UCcQb6V1TlNSNsibkBHct6rBHVoo3ircOd4j3K1Sk/addD8A8qT8gK4xOuI
 zPTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJvqMs8uehEQQHWMt6IvFXbD7CflZW3QsVp5JKDcAihixTqjCoFq0PGpAJyDluHC0SXtZ49po=@lists.denx.de
X-Gm-Message-State: AOJu0Yzspz6xJsmG+lW0GkKb8PT+73UE7U8FlhG92Q/Nf9JPwX3sj4x7
 ANLwPMgUQnsEhWIVTZYMcaMb2q8PUVrEIOvOaOut191E9gq0sVeDKzRiVDiz+QMrQ7iT+HFXhTw
 ysTYlqPM+DBesQDRRvp7Y1PH9QUrlWNicGkTdr4tO3n6ps7ObgRxYJMRr
X-Gm-Gg: ASbGncu5iuX0k7kUaG+vjjIYBV+zJzYCC4Zr3n8/nM2lVfhvO4VAgFIklXtXt7yfpUl
 3k+PiarWpKWgVlo5Cp0IEbIvz3tVallKXP+NVjScWlpH4KKEtY4qIlI5fgeKbc3GHFplAtRnpxR
 KWddCsmg8xiFr1KBit98inYvauhvRGcFzv6KZs1d+Iz4hSK5ajCbcFSjhGOHxMjnGxy6bBDiJL4
 mQ0xCskOfgBphvKGkgx0UeCGLDN9q8FnpsMccwFkfGCAi3VHAjMnic1W1U48PjYIGp++kzrYzRg
 mQf/oAdzDrgAw5iGtSnKhOfCcumQbNPtTI3Yt2Z7Bx45WeEQcEonEEP9x4jM+nqQuBV3KVnGcYn
 UkI9qMTMcfOK4zcCHQUIGY9TrcQFjO85I9hzh10ofig==
X-Received: by 2002:a17:902:f64f:b0:236:7050:74af with SMTP id
 d9443c01a7336-2382409dffcmr98651725ad.9.1750937104359; 
 Thu, 26 Jun 2025 04:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh6fB2vw+Q8aCMAuimu6Y2UfqqRGwUiBRCL6OhmanTl0dLP7pPE9m3gZ47z0Qz+B2XxrtBwQ==
X-Received: by 2002:a17:902:f64f:b0:236:7050:74af with SMTP id
 d9443c01a7336-2382409dffcmr98651245ad.9.1750937103875; 
 Thu, 26 Jun 2025 04:25:03 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d867b438sm154528185ad.176.2025.06.26.04.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 04:25:03 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, me@samcday.com, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/4] power-domain: Add QCOM RPMH Power Domain Driver Support
Date: Thu, 26 Jun 2025 16:54:38 +0530
Message-Id: <20250626112441.143064-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
References: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: haOAn_64NmIP07Y9OmuvNmLWBuFt9Pw4
X-Proofpoint-ORIG-GUID: haOAn_64NmIP07Y9OmuvNmLWBuFt9Pw4
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685d2e1a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8sXTP5f4cthhAvqS-G0A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5NiBTYWx0ZWRfX6qJ5kjlXNdcQ
 U6N8xH+DyQ59+XoJ1ws/44bqc/mrL+0AEjA9ImVbvUI72Vjd/Fcun9WiSy25vP7EKFAzN14THjX
 iLr+tWIIKVG3NUgUo70wC6iruwzMVypdl17Relcy8dEA4fO5jPswpiYGHkLApXA/7fmYItaRzTv
 zC4DsWrAg6+Qk+CCb/8lxQwnZewxYIJ7f3GtKm1jH1NGx5yiEdIPr6E11LTOzWDtTB2xTOETnkN
 /Qm6x5Luj0Z1xHQGkW7s97/JeDykH41jHQzmNz3WC/viKO/2O/j4l549pJenDr6ko3nY9oUUQV3
 nWVYzRJd3l4I8KAjNkJyYZsVp1YNMUubHkn5gcbjKnwQCZVyASoO2y4nP36tJTLS/BelR0aXTAS
 PIYkyLpgN8W2AWPod+vaTViOr/Wy9rXyEMianr2WdHkmBzQNINNgs7OhUARoWVCqEu0/G4LQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260096
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
 drivers/power/domain/Kconfig       |   8 +
 drivers/power/domain/Makefile      |   1 +
 drivers/power/domain/qcom-rpmhpd.c | 271 +++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 5f5218bd8b5..2e246c5bb73 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -82,6 +82,14 @@ config MESON_SECURE_POWER_DOMAIN
 	  Enable support for manipulating Amlogic Meson Secure power domains.
 	  Support for Amlogic A1 series.
 
+config QCOM_POWER_DOMAIN
+	bool "Enable the QCOM RPMH Power domain driver"
+	depends on POWER_DOMAIN
+	help
+	  Generic RPMH power domain implementation for QCOM devices.
+	  The RPMH power domain driver is responsible for managing power
+	  domains on Qualcomm SoCs.
+
 config SANDBOX_POWER_DOMAIN
 	bool "Enable the sandbox power domain test driver"
 	depends on POWER_DOMAIN && SANDBOX
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 4d20c97d26c..ad355f88479 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
 obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
 obj-$(CONFIG_MESON_SECURE_POWER_DOMAIN) += meson-secure-pwrc.o
+obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain.o
 obj-$(CONFIG_SANDBOX_POWER_DOMAIN) += sandbox-power-domain-test.o
 obj-$(CONFIG_SCMI_POWER_DOMAIN) += scmi-power-domain.o
diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
new file mode 100644
index 00000000000..6653995f5ed
--- /dev/null
+++ b/drivers/power/domain/qcom-rpmhpd.c
@@ -0,0 +1,271 @@
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

