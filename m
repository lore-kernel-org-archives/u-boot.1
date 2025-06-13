Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93107C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 05:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB91182C65;
	Fri, 13 Jun 2025 07:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="pLF8x1rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE2E82C44; Fri, 13 Jun 2025 07:20:43 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1BD82CB6
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CKUKc0002507;
 Fri, 13 Jun 2025 05:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sY4Vvwe6c+Qd3l/4EG4kaoNjHvYGguwxSOijZp8R7s4=; b=pLF8x1rgV4oFqvkz
 Uf6AqwMCePApymE6E+j1m6toEaiS7afPeyjS1gZfNsDYNPhfQnaWDSSdgO5LzDnr
 Lg1tf0slrh+YUvsqNb97kZV+06DuPWeDGnxYTJtx0K+PgXftEwiLz0Q9koMONcNH
 0kVK6HOkrmdNzfZ5LMQZHFdtG2pIoezgqIRaS3HBNS3aznvSDHam+v2c21rqigzL
 kulC+jlGPvR55p6GtM/aBjNuS7v3ydVtpXaxxhuj7K0lr8ebGUhUiEBihqeWkL3O
 RjaNdjhrNLLL9QlyH7BzRfu+Lmsf5JcoBK1rhUEfBeXwiej13S/6w+jVgIBTNMxL
 I80/4Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jbpm4u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55D5KWZi020500
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:33 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 22:20:28 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <jerome.forissier@linaro.org>,
 <sjg@chromium.org>, <patrick.rudolph@9elements.com>,
 <clamor95@gmail.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v4 3/5] sysreset: Implement PSCI based reset to EDL mode for
 QCOM SoCs
Date: Fri, 13 Jun 2025 10:49:55 +0530
Message-ID: <20250613051957.3159564-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613051957.3159564-1-quic_varada@quicinc.com>
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: II8jnZ9scml-eDngXCaI7DOVKLAn01z-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAzOCBTYWx0ZWRfX1vnwsRnHfpUz
 hTimWdKex6i+LOH+a1lUfEbUXOGRJBljM0ifawZSznTbiCKwAfdEIRr3IDmH+gUs7k6Zj06oREG
 9kx+wKDw3U7iUYp7MiObN20eikolvYvaB7Smt1xbBFni4M7JqcShdSObuuq6vzCT8fH0arfMfvj
 fVrCgcKwLUJ6qjWAZn/dlX152Xd20zQpvRGvQokdYtNwzZHCGhdUQcpfj3lVlfdTRwMphF6gT+L
 VzAbWhsVZzmWhrclXUPnZ960akqtagvJLu8d6hv1VEyJtjamSlc+zcQ4ZQ5XMKLMV0vAqLjApqk
 gQW4KooZdZYmxjGZxHlrPpkH1P3tux6wyNWig0wepiedSKa9mngIeLH1UkmhktyHbFDOr9WBKCb
 jWc/rdcODv8wpFzyZuA+7c1VLUJsivhVgzQmoB0jrsKxCkpMjKtSvvm5hRrWb8t7XAdToTFt
X-Proofpoint-ORIG-GUID: II8jnZ9scml-eDngXCaI7DOVKLAn01z-
X-Authority-Analysis: v=2.4 cv=OLgn3TaB c=1 sm=1 tr=0 ts=684bb522 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=c-n4J4-pAAAA:8
 a=KMrddx77dZ4Wm-S9ziwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130038
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
v4: * Check if ARM_PSCI_1_1_FN64_SYSTEM_RESET2 is supported before
      issuing it

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
 drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)
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
index aa83073c96a..894c3d38b26 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -292,6 +292,12 @@ config SYSRESET_RAA215300
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
index f5c78b25896..8bb1eabd48e 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -30,5 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
 obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
+obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
 obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
new file mode 100644
index 00000000000..3627bbf5c82
--- /dev/null
+++ b/drivers/sysreset/sysreset_qcom-psci.c
@@ -0,0 +1,45 @@
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
+#include <asm/psci.h>
+
+static int qcom_psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int qcom_psci_sysreset_request_arg(struct udevice *dev, int argc,
+					  char * const argv[])
+{
+	if (!strncasecmp(argv[1], "-edl", 4)) {
+		/* Supported in qcs9100, qcs8300, sc7280, qcs615 */
+		if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) ==
+							ARM_PSCI_RET_SUCCESS) {
+			psci_system_reset2(0, 1);
+			return -EINPROGRESS;
+		}
+		printf("PSCI SYSTEM_RESET2 not supported\n");
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

