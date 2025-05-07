Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D3C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 11:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC3F822D7;
	Wed,  7 May 2025 13:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Y0GPgoBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B478288D; Wed,  7 May 2025 13:29:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E928291D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ARnhJ009547;
 Wed, 7 May 2025 11:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3odDkCKvEoXRxpN8QhVGQklhazALHDpYFVJe4egpqUc=; b=Y0GPgoBC1AcnGxM8
 L4XleehsExaTswYhfKtPlFNIApA1NUlBBs5Tz7YlGKQzMqTVabA1sHP4wJj4mbeB
 5ayn7cwnl21Lff7lL4Pp2Gfd8IbIdVrq49MqL/AUW36CGnR+zljpfj9013CBQvEU
 xgVXIyvJrIis3zbuMJGLo9RLuNJjetU6BImYfrtFXHMo2s/AquUplW45uwxCFST3
 2Do09rg4Y2j6qH9Yd07WL9P65zL80SwpZrz5Vl6/LmjmobiBj6sC5kDeb94XttV/
 l0X4Zp4lKzdGIiDvIEqs44+K+FKmAbVWA4g5uiz207uJpt1piuRqhSvG0mTIKEbB
 DVWnOA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fnm1jq2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 11:28:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 547BSrft016855
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 11:28:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 04:28:48 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>,
 <hs@denx.de>, <sjg@chromium.org>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <xypron.glpk@gmx.de>,
 <cniedermaier@dh-electronics.com>, <ansuelsmth@gmail.com>,
 <venkatesh.abbarapu@amd.com>, <ilias.apalodimas@linaro.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v3 3/4] env: Add support for storing env variables in SCSI
 devices
Date: Wed, 7 May 2025 16:58:11 +0530
Message-ID: <20250507112812.3066301-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507112812.3066301-1-quic_varada@quicinc.com>
References: <20250507112812.3066301-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: kTEMXbJdBX8So7EmuqHZFFu43q3TFeBO
X-Proofpoint-ORIG-GUID: kTEMXbJdBX8So7EmuqHZFFu43q3TFeBO
X-Authority-Analysis: v=2.4 cv=bLkWIO+Z c=1 sm=1 tr=0 ts=681b43f6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=XyhusxJ8NkhsuqipcxUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwNyBTYWx0ZWRfX+X8yqeqliE7g
 /t4Yyx+NRRaLCMO2PF14Yhgs/Mmm8dxCgeBxbJ+zJ6QymoerqkOwTB7AQYMrRFwPhchkPuDTbyf
 wK7r93h813AUEF+itmvKyG2QYosVpfKeTof7QvZcdSblGrJWOl3krzO1r9058+xE+N/1S4Subf7
 uTUXsVwS8xeup6g8bov1FP6n5xxwSLYSWLzjAXAgtUt3KjRMBxJ7ZM2AD8VRX6gqLjwa3Z8Urrz
 OkWGurF/WL+ZCZ7w/hEZJzRSmBbZP12iGMmhE4BMACOT6BIRvq+qupKsmNCHtvm7BHUgXLVqsZ0
 lO4uDd2W/iZfov7oNB0SelV5/ds3J1FOAwbUds3rxAeiwoFZNmYd+JS3XOqYYVom3nenKh2o8Hj
 +zb3mxwt/tRb/jD9jOFztf4u49FnYC4L1SzBjJMWJAuiD5gaLib8S1y7vJhhwkcImVKF3Cky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070107
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

Allow SCSI to be able to store environment variables.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: s/SCSI_ENV_PART/SCSI_ENV_PART_UUID
---
 env/Kconfig            |  15 +++++-
 env/Makefile           |   1 +
 env/env.c              |   3 ++
 env/scsi.c             | 115 +++++++++++++++++++++++++++++++++++++++++
 include/env_internal.h |   1 +
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 env/scsi.c

diff --git a/env/Kconfig b/env/Kconfig
index 9f5ec44601e..9081f7099b7 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -74,7 +74,7 @@ config ENV_IS_DEFAULT
 		     !ENV_IS_IN_MMC && !ENV_IS_IN_NAND && \
 		     !ENV_IS_IN_NVRAM && !ENV_IS_IN_ONENAND && \
 		     !ENV_IS_IN_REMOTE && !ENV_IS_IN_SPI_FLASH && \
-		     !ENV_IS_IN_UBI && !ENV_IS_IN_MTD
+		     !ENV_IS_IN_UBI && !ENV_IS_IN_MTD && !ENV_IS_IN_SCSI
 	select ENV_IS_NOWHERE
 
 config ENV_IS_NOWHERE
@@ -297,6 +297,13 @@ config ENV_IS_IN_NAND
 	  Currently, CONFIG_ENV_OFFSET_REDUND is not supported when
 	  using CONFIG_ENV_OFFSET_OOB.
 
+config ENV_IS_IN_SCSI
+	bool "Environment in an SCSI device"
+	depends on SCSI
+	help
+	  Define this if you have an SCSI device which you want to use for the
+	  environment.
+
 config ENV_RANGE
 	hex "Length of the region in which the environment can be written"
 	depends on ENV_IS_IN_NAND
@@ -731,6 +738,12 @@ config ENV_MMC_USE_DT
 	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
 	  are not used as fallback.
 
+config SCSI_ENV_PART_UUID
+	string "SCSI partition UUID for saving environment"
+	depends on ENV_IS_IN_SCSI
+	help
+	  UUID of the SCSI partition that you want to store the environment in.
+
 config USE_DEFAULT_ENV_FILE
 	bool "Create default environment from file"
 	help
diff --git a/env/Makefile b/env/Makefile
index 3b9c71d5681..d11b87702c1 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -28,5 +28,6 @@ obj-$(CONFIG_$(PHASE_)ENV_IS_IN_NAND) += nand.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SPI_FLASH) += sf.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_MTD) += mtd.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FLASH) += flash.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SCSI) += scsi.o
 
 CFLAGS_embedded.o := -Wa,--no-warn -DENV_CRC=$(shell tools/envcrc 2>/dev/null)
diff --git a/env/env.c b/env/env.c
index dbaeedc3c3b..7a9c96b4078 100644
--- a/env/env.c
+++ b/env/env.c
@@ -46,6 +46,9 @@ static enum env_location env_locations[] = {
 #ifdef CONFIG_ENV_IS_IN_MMC
 	ENVL_MMC,
 #endif
+#ifdef CONFIG_ENV_IS_IN_SCSI
+	ENVL_SCSI,
+#endif
 #ifdef CONFIG_ENV_IS_IN_NAND
 	ENVL_NAND,
 #endif
diff --git a/env/scsi.c b/env/scsi.c
new file mode 100644
index 00000000000..207717e17b1
--- /dev/null
+++ b/env/scsi.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2008-2011 Freescale Semiconductor, Inc.
+ */
+
+/* #define DEBUG */
+
+#include <asm/global_data.h>
+
+#include <command.h>
+#include <env.h>
+#include <env_internal.h>
+#include <fdtdec.h>
+#include <linux/stddef.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <part.h>
+#include <search.h>
+#include <scsi.h>
+#include <errno.h>
+#include <dm/ofnode.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+static env_t envbuf;
+
+struct env_scsi_info {
+	struct blk_desc *blk;
+	struct disk_partition part;
+	int count;
+};
+
+static struct env_scsi_info env_part;
+
+static inline struct env_scsi_info *env_scsi_get_part(void)
+{
+	struct env_scsi_info *ep = &env_part;
+
+	if (scsi_get_blk_by_uuid(CONFIG_SCSI_ENV_PART_UUID, &ep->blk, &ep->part))
+		return NULL;
+
+	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
+
+	return ep;
+}
+
+static int env_scsi_save(void)
+{
+	struct env_scsi_info *ep = env_scsi_get_part();
+	int ret;
+
+	if (!ep)
+		return -ENOENT;
+
+	ret = env_export(&envbuf);
+	if (ret)
+		return ret;
+
+	if (blk_dwrite(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count)
+		return -EIO;
+
+	return 0;
+}
+
+static int env_scsi_erase(void)
+{
+	struct env_scsi_info *ep = env_scsi_get_part();
+
+	if (!ep)
+		return -ENOENT;
+
+	return (int)blk_derase(ep->blk, ep->part.start, ep->count);
+}
+
+#if defined(ENV_IS_EMBEDDED)
+static int env_scsi_load(void)
+{
+	return 0;
+}
+#else
+static int env_scsi_load(void)
+{
+	struct env_scsi_info *ep = env_scsi_get_part();
+	int ret;
+
+	if (!ep) {
+		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition not found", 0);
+		return -ENOENT;
+	}
+
+	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
+		env_set_default(CONFIG_SCSI_ENV_PART_UUID " partition read failed", 0);
+		return -EIO;
+	}
+
+	ret = env_import((char *)&envbuf, 1, H_EXTERNAL);
+	if (ret) {
+		debug("ENV import failed\n");
+		env_set_default("Cannot load environment", 0);
+	} else {
+		gd->env_addr = (ulong)envbuf.data;
+	}
+
+	return ret;
+}
+#endif
+
+U_BOOT_ENV_LOCATION(scsi) = {
+	.location	= ENVL_SCSI,
+	ENV_NAME("SCSI")
+	.load		= env_scsi_load,
+#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_XPL_BUILD)
+	.save		= env_save_ptr(env_scsi_save),
+	.erase		= ENV_ERASE_PTR(env_scsi_erase),
+#endif
+};
diff --git a/include/env_internal.h b/include/env_internal.h
index ee939ba4293..75b46d0bcb0 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -115,6 +115,7 @@ enum env_location {
 	ENVL_SPI_FLASH,
 	ENVL_MTD,
 	ENVL_UBI,
+	ENVL_SCSI,
 	ENVL_NOWHERE,
 
 	ENVL_COUNT,
-- 
2.34.1

