Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6007C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 08:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0501E82B17;
	Wed, 30 Apr 2025 10:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Yb+ZxHLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800AA82B32; Wed, 30 Apr 2025 10:55:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFED082B17
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLaOW2012217;
 Wed, 30 Apr 2025 08:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xhFq2ZjI65JmY+ZE4XceuKUdXIItOPuSRsOkZ3mWPO8=; b=Yb+ZxHLH1wjVrTeT
 gafgi0Qatuxa44yp4gXXHNfhg2h+6XcVvCKXSvyvJlcnKCafvbgqt1JcU1k6106X
 6IKtztEZDmAmT8/K+RY17HfAVXYfIunE3RV721nz0mQvptpQv+tqjwntE0etDumK
 I0W+NehJiMRt+juw9ylhNq+TdEKIEzFe6UuwxkbZE6A5CxjuZrJOLj2qxCkwDnlj
 XvhDNjm/j9MSzDwpmm4sWPK7ByLZ2wS83kcpLDo1DqFfrvC27Pwrr+4TNdA1tBLX
 o5qBMj4u1Ir33wgtZvqhjRWjclzxTTY1jSGNbAdQDw5xCUcqgyF1R8zeBU0oH18R
 YanO3w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u3sejj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 08:54:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53U8somG024435
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 08:54:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Apr 2025 01:54:46 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <seashell11234455@gmail.com>, <clamor95@gmail.com>,
 <ycliang@andestech.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <sjg@chromium.org>, <marek.vasut+renesas@mailbox.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v2 1/2] sysreset: Implement PSCI based reset to EDL mode for
 QCOM SoCs
Date: Wed, 30 Apr 2025 14:24:27 +0530
Message-ID: <20250430085428.1090801-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085428.1090801-1-quic_varada@quicinc.com>
References: <20250430085428.1090801-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=Bv6dwZX5 c=1 sm=1 tr=0 ts=6811e55b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=c-n4J4-pAAAA:8
 a=RREsC5lppxlaYuQ3OMsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: l132MycfNSUrmrIjcBqmAb_pQKnfuOdb
X-Proofpoint-ORIG-GUID: l132MycfNSUrmrIjcBqmAb_pQKnfuOdb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2MSBTYWx0ZWRfXyrEZU0EhmoSd
 UxkJ8rGBuGhonvsO0LtTm4lhJS2izhiPc14imRUN+8b24sXlILnDLrf1L+WEpnVPwQsrcLpLw5C
 WzvCoYCiGOI2xTkr88HXRg6xGY3MWleGLNJP46U3oCM/3Kl6N48QXLUlHJzrR2nYxDmUjenapYS
 UebygJM0q8qa3/Yyo3MApiwLCr+bn8OW81J9Yil8ymQJQBb2PJze+0fttX6p45c9HMjdLklCHsr
 gSKDanolwNAfSMY02v2rYj5UnJmCZxKBoIOz0ZN5gXkoMX46jrOfJ2C/oBy+4ZQjdBJa3Np7yao
 +AIrQYrOGXGkTu9+n0Ei0YJ7FLYu/PBDQUIdF7aiMHDuH0nHXeMXZBzET9tIEP7m9seooWs2jRY
 Gf6kU5Xnsm4Zb3s+MhVb3IkzhU3LBkAROHfJjcNxc6X6XPVEMPzRaNFJcfURrsRAlrqlYqH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300061
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

The SYSRESET_PSCI interface presently available doesn't support booting
into Emergency DownLoad (EDL) mode. The EDL mode is used to flash the
board with different firmware.

Since EDL is Qcom specific, implement a Qcom specific SYSRESET_PSCI
handler that handles resetting to EDL in addition to the usual cold/warm
reset and poweroff.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: * Update commit message
    * Elaborate Kconfig help text
    * Use '-edl' instead of 'edl' for consistency with other arguments of reset
      command
    * Remove 'weak' for qcom_psci_sysreset_get_status() and make it static
    * Mention 'SYSRESET_EDL' is Qcom specific in the enum's comments
---
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              |  7 ++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    |  7 ++--
 drivers/sysreset/sysreset_qcom-psci.c | 48 +++++++++++++++++++++++++++
 include/sysreset.h                    |  7 ++++
 6 files changed, 72 insertions(+), 2 deletions(-)
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
index 4972905482a..d407c322bdb 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -285,6 +285,13 @@ config SYSRESET_RAA215300
 	help
 	  Add support for the system reboot via the Renesas RAA215300 PMIC.
 
+config SYSRESET_QCOM_PSCI
+	bool "Support sysreset for Qualcomm SoCs via PSCI"
+	help
+	  Add support for the system reboot on Qualcomm SoCs via PSCI.
+	  This allows warm/cold reset, poweroff and reset to EDL (Emergency
+	  Download)
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
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index 536ac727142..ff9bc962ec0 100644
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
+		else if (!strncmp("-edl", argv[1], 4))
+			reset_type = SYSRESET_EDL;
 	}
 
 	printf("resetting ...\n");
diff --git a/drivers/sysreset/sysreset_qcom-psci.c b/drivers/sysreset/sysreset_qcom-psci.c
new file mode 100644
index 00000000000..9d0606c059b
--- /dev/null
+++ b/drivers/sysreset/sysreset_qcom-psci.c
@@ -0,0 +1,48 @@
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
index ff20abdeed3..d0f60ed2456 100644
--- a/include/sysreset.h
+++ b/include/sysreset.h
@@ -21,6 +21,13 @@ enum sysreset_t {
 	SYSRESET_POWER,
 	/** @SYSRESET_POWER_OFF: turn off power */
 	SYSRESET_POWER_OFF,
+#if IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI)
+	/**
+	 * @SYSRESET_EDL: Reset and boot into Emergency DownLoader.
+	 *		  This is supported only in recent Qcom SoCs.
+	 */
+	SYSRESET_EDL,
+#endif
 	/** @SYSRESET_COUNT: number of available reset types */
 	SYSRESET_COUNT,
 };
-- 
2.34.1

