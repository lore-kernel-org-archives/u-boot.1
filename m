Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239FBC3ABB6
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 07:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8354482163;
	Wed,  7 May 2025 09:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="LDhmEblV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 125B48210D; Wed,  7 May 2025 09:08:11 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CD18269F
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 09:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471HKdw025209;
 Wed, 7 May 2025 07:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TZI6/LYE8haFZQEK50wMAlonBLnPAolVCj9CJXujS7A=; b=LDhmEblVIoycNoLc
 u+asCRwhj2ggEC84k79frLOFTPMSUNsOeL0Pi1HL2jdfo+1dz3ZSwJRNVXHXfu7F
 HgR/eVJKXJFcx5nqE0o5ja532EIZy9NxkkOkzc/xGoahkkZUWziuIDbq7OOSdh03
 am9KZuDlKc6f98qnRqcTSHbSpqTu5uHx+ukvHbTQI5/vP56PA8CbJ1L2hN0sMGnJ
 5VROFe6RRt8N//YKj1AaJlLww61jtu08U0g1AHRrmsQcrRZL97rOJio0lshQAaYS
 fmJ1aySQbBRIn98pjtK+4u9fF7A1pZT9eThnzaZBNdZ+uvdws5BjsgkDNNnNcjAG
 MccmBA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5w3crkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 07:08:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54777xm2006944
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 07:07:59 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 00:07:55 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <clamor95@gmail.com>, <robert.marko@sartura.hr>, <me@samcday.com>,
 <sjg@chromium.org>, <marek.vasut+renesas@mailbox.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v3 2/3] sysreset: Implement PSCI based reset to EDL mode for
 QCOM SoCs
Date: Wed, 7 May 2025 12:37:32 +0530
Message-ID: <20250507070733.2871986-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507070733.2871986-1-quic_varada@quicinc.com>
References: <20250507070733.2871986-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA2NSBTYWx0ZWRfXx3sV7Ipwi96D
 GnS2F2jqtVXWYe6IEBw0iRCDIRiClMAwJ381gxqX4zlbsLWLbiCRXvdFkLendCjPladBxyen+6+
 wI3AheKrNOxOlBtNlasiiOLVPJ2mzWO7pUjOBnoblQWdC3qdoA0pStBC6Ng3+OqJ+NPCLPFvqaP
 V8O98X6/+12GHVvCxj0OK0qOqVTv1Xj4bXwlLMNiAsfeaEwuuKqJEWefUnYx6lgH1gY1CxNDaLx
 /nYQCC3rc7Yk45umwnH4MjQK/qRqKLs8cjL3Up7++znJ6fVQmx5oDivNTN+HywKJ0oyVGB6dTAC
 L+yTWM3NhSUN7s4dtvlDYnK1HGWY/CtwduCg2EhXN9ywMgstTIn/D28fvIKGFYHRZU5uzQ1hCAF
 Bixcc2u8/kpA65vFb7suqYKKXXTDgK2xuVq2dZk4jqLpL39stxv186u6E1Ad52phs2BMNnW4
X-Proofpoint-GUID: 1v7MN2zAfXWZbgTnR-EsSy0zrJIe7TlL
X-Proofpoint-ORIG-GUID: 1v7MN2zAfXWZbgTnR-EsSy0zrJIe7TlL
X-Authority-Analysis: v=2.4 cv=W+s4VQWk c=1 sm=1 tr=0 ts=681b06d0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=c-n4J4-pAAAA:8
 a=0KnW_0dzedP63jqwKnwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070065
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

Implement request_arg() sysreset_op for QCOM SoCs that use
PSCI to reset to EDL (Emergency Download) mode.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: * Move argument handling to a separate function and pass the
      arguments to the actual handler to process
    * Drop Qcom specific SYSRESET_EDL from the common enum

v2: * Update commit message
    * Elaborate Kconfig help text
    * Use '-edl' instead of 'edl' for consistency with other arguments of reset
      command
    * Remove 'weak' for qcom_psci_sysreset_get_status() and make it static
    * Mention 'SYSRESET_EDL' is Qcom specific in the enum's comments
---
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              |  6 ++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset_qcom-psci.c | 40 +++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 2e3223e1c32..b6838a244d2 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
 					 NULL);
 		if (ret)
 			pr_debug("PSCI System Reset was not bound.\n");
+		if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
+		    device_bind_driver(dev, "qcom_psci-sysreset",
+				       "qcom_psci-sysreset", NULL))
+			pr_debug("QCOM PSCI System Reset was not bound.\n");
 	}
 
 	/* From PSCI v1.0 onward we can discover services through ARM_SMCCC_FEATURE */
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 4972905482a..8e8e66fd342 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -285,6 +285,12 @@ config SYSRESET_RAA215300
 	help
 	  Add support for the system reboot via the Renesas RAA215300 PMIC.
 
+config SYSRESET_QCOM_PSCI
+	bool "Support reset to EDL for Qualcomm SoCs via PSCI"
+	help
+	  Add support for the reset to EDL (Emergency Download) on Qualcomm
+	  SoCs via PSCI.
+
 config SYSRESET_QCOM_PSHOLD
 	bool "Support sysreset for Qualcomm SoCs via PSHOLD"
 	help
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index ded91a4d325..58eb0e356e1 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
+obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
new file mode 100644
index 00000000000..a15a4b1f13d
--- /dev/null
+++ b/drivers/sysreset/sysreset_qcom-psci.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+#include <sysreset.h>
+#include <asm/system.h>
+#include <linux/errno.h>
+#include <linux/psci.h>
+
+static int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int qcom_psci_sysreset_request_arg(struct udevice *dev, int argc,
+					  const char *argv[])
+{
+	if (!strncasecmp(argv[1], "-edl", 4)) {
+		/* Supported in qcs9100, qcs8300, sc7280, qcs615 */
+		psci_system_reset2(0, 1);
+		return -EINPROGRESS;
+	}
+
+	return -EPROTONOSUPPORT;
+}
+
+static struct sysreset_ops qcom_psci_sysreset_ops = {
+	.request_arg = qcom_psci_sysreset_request_arg,
+	.get_status = qcom_psci_sysreset_get_status,
+};
+
+U_BOOT_DRIVER(qcom_psci_sysreset) = {
+	.name = "qcom_psci-sysreset",
+	.id = UCLASS_SYSRESET,
+	.ops = &qcom_psci_sysreset_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

