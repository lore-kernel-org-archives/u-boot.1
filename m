Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13534C369A8
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFB683BE1;
	Thu, 10 Apr 2025 14:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="TlquIIJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C5583BDF; Thu, 10 Apr 2025 14:03:14 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D87D883C02
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75MnM016330;
 Thu, 10 Apr 2025 12:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jrGrTw0g17WzdPwjuZ2m1EmddW6y33MQqwWrHqQpJQk=; b=TlquIIJct4CsMbmK
 deAcNWV09WqeLXyd0ZmnciTTtatV9MJuMcpMpV2ILSLV7VLYNOIRSE8YiYYAOQut
 xQtNIeMGlOHpTce46Jw4pB9C0GaCGi8zXV6EWfjMNIOzJ4ufeFSIguFugxgHlOeN
 gG3T+NduXBgPm5DpW3s9vvXWgQNXErcyqGm/o9FTtMLp+tOEOlogDgh27zIfKRgW
 3IBoYEV8grEHr3JLXqrU9U/dp+UiLOjoDIwv8pmrL0v4jJ9+nBgDZfYSNLteX7yL
 9ZMhWSv/xrUWdUs8dahNiGmnZ0wocGCifCcphVKGJrFag2HsdCpsSFceNhDjUIAF
 U+Mhmg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1pnb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 12:02:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AC2qPJ002961
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 12:02:52 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 05:02:48 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <sjg@chromium.org>, <ilias.apalodimas@linaro.org>,
 <sughosh.ganu@linaro.org>, <me@samcday.com>, <marex@denx.de>,
 <quic_varada@quicinc.com>, <robert.marko@sartura.hr>,
 <seashell11234455@gmail.com>, <ycliang@andestech.com>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v1 2/3] sysreset: Implement PSCI based reset to EDL mode for
 QCOM SoCs
Date: Thu, 10 Apr 2025 17:32:07 +0530
Message-ID: <20250410120208.4142087-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410120208.4142087-1-quic_varada@quicinc.com>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: XKAkT3S_N45MVgFHu3tnHk0NDhD9FPMU
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f7b36d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=c-n4J4-pAAAA:8
 a=jDGgMvfSHH0-W1RxyasA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: XKAkT3S_N45MVgFHu3tnHk0NDhD9FPMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100088
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

Add SYSRESET_EDL to sysreset_t and handle the different SYSRESET_xxx
requests in sysreset_qcom-psci.c.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/sysreset/Kconfig              |  5 +++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    |  7 ++--
 drivers/sysreset/sysreset_qcom-psci.c | 47 +++++++++++++++++++++++++++
 include/sysreset.h                    |  2 ++
 5 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 121194e4418..a6a1e57b603 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -240,6 +240,11 @@ config SYSRESET_RAA215300
 	help
 	  Add support for the system reboot via the Renesas RAA215300 PMIC.
 
+config SYSRESET_QCOM_PSCI
+	bool "Support sysreset for Qualcomm SoCs via PSCI"
+	help
+	  Add support for the system reboot on Qualcomm SoCs via PSCI.
+
 config SYSRESET_QCOM_PSHOLD
 	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
 	depends on ARCH_IPQ40XX
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index 796fc9effa5..12dbad5254a 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
+obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 536ac727142..d06c0a6908a 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -125,8 +125,11 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc > 2)
 		return CMD_RET_USAGE;
 
-	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
-		reset_type = SYSRESET_WARM;
+	if (argc == 2) {
+		if (argv[1][0] == '-' && argv[1][1] == 'w')
+			reset_type = SYSRESET_WARM;
+		else if (!strncmp("edl", argv[1], 3))
+			reset_type = SYSRESET_EDL;
 	}
 
 	printf("resetting ...\n");
diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
new file mode 100644
index 00000000000..3afb79e2d2e
--- /dev/null
+++ b/drivers/sysreset/sysreset_qcom-psci.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
+ */
+
+#include <dm.h>
+#include <sysreset.h>
+#include <asm/system.h>
+#include <linux/errno.h>
+#include <linux/psci.h>
+
+__weak int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int qcom_psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	switch (type) {
+	case SYSRESET_WARM:
+	case SYSRESET_COLD:
+		psci_sys_reset(type);
+		break;
+	case SYSRESET_POWER_OFF:
+		psci_sys_poweroff();
+		break;
+	case SYSRESET_EDL:
+		psci_system_reset2(0, 1);
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops qcom_psci_sysreset_ops = {
+	.request = qcom_psci_sysreset_request,
+	.get_status = qcom_psci_sysreset_get_status,
+};
+
+U_BOOT_DRIVER(qcom_psci_sysreset) = {
+	.name = "qcom_psci-sysreset",
+	.id = UCLASS_SYSRESET,
+	.ops = &qcom_psci_sysreset_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/sysreset.h b/include/sysreset.h
index ff20abdeed3..8bda9703cd9 100644
--- a/include/sysreset.h
+++ b/include/sysreset.h
@@ -21,6 +21,8 @@ enum sysreset_t {
 	SYSRESET_POWER,
 	/** @SYSRESET_POWER_OFF: turn off power */
 	SYSRESET_POWER_OFF,
+	/** @SYSRESET_EDL: reset and boot into Emergency DownLoader */
+	SYSRESET_EDL,
 	/** @SYSRESET_COUNT: number of available reset types */
 	SYSRESET_COUNT,
 };
-- 
2.34.1

