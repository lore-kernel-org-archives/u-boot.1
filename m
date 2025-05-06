Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D00AC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FE48210D;
	Tue,  6 May 2025 09:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="lMw/HEwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77FC5820E8; Tue,  6 May 2025 09:25:38 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D7C8214F
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545M8M3f026059;
 Tue, 6 May 2025 07:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lyg289Wr1dyrlGD+O7/929WYCoTkN5YZ3xA0aDUBHlg=; b=lMw/HEwz0QmLsLxu
 UI8zaRySAzskpyd1DIB7j2RqizdWejzpnKrQiZl1SY3t5mjqOUmfIrSboVH5Dnvo
 SH6fnwccMrx68wN7DAltfOUe72x2xPdI21aaJVlc3PiH1vIDOWPPRR1XH2MH3WP6
 V4g2hoLM6qXQc5P2WBHLb0wnmz9vzMHc8cV7B0zIZ9De3ERhK8lFR0anciP3TfYG
 V1nPG+8cnzrPSABm8hMOf0YmTv9xKwMX/biyuLfozM2n5H+nsd6rT7TzTSoRInls
 p9vURcTauj1wy2Oi3SC/JW7X8fq6TluXLUdBNGIoffk3gYntYs+s9MQn2EZkFuoV
 D+BvwA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5uusa75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 07:25:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5467PG8M022875
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 6 May 2025 07:25:16 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 May 2025 00:25:10 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <michael@amarulasolutions.com>, <avromanov@salutedevices.com>,
 <sjg@chromium.org>, <hs@denx.de>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <cniedermaier@dh-electronics.com>,
 <xypron.glpk@gmx.de>, <venkatesh.abbarapu@amd.com>,
 <ansuelsmth@gmail.com>, <ilias.apalodimas@linaro.org>,
 <mkorpershoek@kernel.org>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v2 3/4] env: Add support for storing env variables in SCSI
 devices
Date: Tue, 6 May 2025 12:54:14 +0530
Message-ID: <20250506072415.1970069-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506072415.1970069-1-quic_varada@quicinc.com>
References: <20250506072415.1970069-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=6819b95d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=XyhusxJ8NkhsuqipcxUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: EAozUdayHZ3gnN5H8kkc2ds_5OaDZMeA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2OSBTYWx0ZWRfX0rJ9ASbJK8S+
 4orTs/xDXymyOmYR58B2hDN53hcSevyybfvgBy4bIm1LMrH0Ev9fzqlqMs3+4DXXmBprbNM+kMo
 49ff02lfVZa+5bEyzm8OvhQ9rWRXOSsd42y5Lc00sGC51VtYLyrj/LCnyDYOxWqzTkrk8Uckspx
 dNI9ZoPLqrx1Gy+QWQj/4W1vB/NN5ptxXdccPyVH+jDeSUu97n1EWi6q9Q2LsPcsZUcAPG9Z6tr
 a2L0NdWpW7ScJ2GEXEMmuhpbemV9ljBplNilozuKyU+FqxomTxjahUEoB8wrIHm6O/Im8Oh1b2R
 7UkQmPYPJTSRqCId48Jj1JGjzW23SyF9UmjWtcR4mm9nS6CfD6N5np4inJYFoj0IDhvU2r90Uqw
 WvOjeh2bOihe/I5j25SafBOhhjjO/jdB5BXASWlcN5o88s/WVotMtFxjZwYN/OfS3du73iEc
X-Proofpoint-ORIG-GUID: EAozUdayHZ3gnN5H8kkc2ds_5OaDZMeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060069
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
 env/Kconfig            |  15 +++++-
 env/Makefile           |   1 +
 env/env.c              |   3 ++
 env/scsi.c             | 115 +++++++++++++++++++++++++++++++++++++++++
 include/env_internal.h |   1 +
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 env/scsi.c

diff --git a/env/Kconfig b/env/Kconfig
index 9f5ec44601e..9496975f212 100644
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
 
+config SCSI_ENV_PART
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
index 00000000000..4559eb6466e
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
+	if (scsi_get_blk(CONFIG_SCSI_ENV_PART, &ep->blk, &ep->part))
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
+		env_set_default(CONFIG_SCSI_ENV_PART " partition not found", 0);
+		return -ENOENT;
+	}
+
+	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
+		env_set_default(CONFIG_SCSI_ENV_PART " partition read failed", 0);
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

