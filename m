Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCD7C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F7E82054;
	Tue,  1 Apr 2025 10:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="ZNfAUWIe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A0982045; Tue,  1 Apr 2025 10:01:16 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1526781F44
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5315oMWX026709;
 Tue, 1 Apr 2025 08:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VqL9K/0JWl8p90iWyOjp0073KBl5us+8ZK9WWQujtQ4=; b=ZNfAUWIe0zG4kLvT
 u/XmB9pupN9lzVDO/f8mVoBZaN+kzq+kYRZ68VM1SkHX3qoC7Tnc6ZDr5+kTn6KO
 wl9J3/MGON4WGjgd7b39YZAIr/WGXfbXjTPrVsWx0wyVEyQtPzoIinYMoeBgem+d
 vRES0vtJLiw5IKabqZJHXDLOux2oojGNWidfxZ96mQMBC9rrH2XNXpIzqmi2WK7r
 mEQSv2cvOzKlHDl9ryVHczTA1Lxw0kPFoA035NWOhthoAd3HvwmpiHuj9MfK+GW1
 6YyyepjNNa6Z18h4x7MalPhF5XiKba2NiVEGly/jeyUuGmGFNtTjqKQzTi+ZCcsi
 iUFcdg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7v8f4hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 08:00:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53180mpu017766
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Apr 2025 08:00:48 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Apr 2025 01:00:45 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <cniedermaier@dh-electronics.com>, <xypron.glpk@gmx.de>,
 <sjg@chromium.org>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v1 2/3] env: Add support for storing env variables in UFS
Date: Tue, 1 Apr 2025 13:30:14 +0530
Message-ID: <20250401080015.1470999-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401080015.1470999-1-quic_varada@quicinc.com>
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 3XVh1d3zDueN-TvJOVu_11ApzXDzQe7L
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=67eb9d31 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=RrAhlm_WmiKcpbq5iYYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3XVh1d3zDueN-TvJOVu_11ApzXDzQe7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010051
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

Allow UFS to be able to store environment variables.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 env/Kconfig            |  15 +++++-
 env/Makefile           |   1 +
 env/env.c              |   3 ++
 env/ufs.c              | 115 +++++++++++++++++++++++++++++++++++++++++
 include/env_internal.h |   1 +
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 env/ufs.c

diff --git a/env/Kconfig b/env/Kconfig
index 4438f0b392c..8ea1f87cb18 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -74,7 +74,7 @@ config ENV_IS_DEFAULT
 		     !ENV_IS_IN_MMC && !ENV_IS_IN_NAND && \
 		     !ENV_IS_IN_NVRAM && !ENV_IS_IN_ONENAND && \
 		     !ENV_IS_IN_REMOTE && !ENV_IS_IN_SPI_FLASH && \
-		     !ENV_IS_IN_UBI
+		     !ENV_IS_IN_UBI && !ENV_IS_IN_UFS
 	select ENV_IS_NOWHERE
 
 config ENV_IS_NOWHERE
@@ -297,6 +297,13 @@ config ENV_IS_IN_NAND
 	  Currently, CONFIG_ENV_OFFSET_REDUND is not supported when
 	  using CONFIG_ENV_OFFSET_OOB.
 
+config ENV_IS_IN_UFS
+	bool "Environment in an UFS device"
+	depends on UFS
+	help
+	  Define this if you have an UFS device which you want to use for the
+	  environment.
+
 config ENV_RANGE
 	hex "Length of the region in which the environment can be written"
 	depends on ENV_IS_IN_NAND
@@ -706,6 +713,12 @@ config ENV_MMC_USE_DT
 	  The 2 defines CONFIG_ENV_OFFSET, CONFIG_ENV_OFFSET_REDUND
 	  are not used as fallback.
 
+config SYS_UFS_ENV_PART
+	string "UFS partition name for saving environment"
+	depends on ENV_IS_IN_UFS
+	help
+	  Name of the UFS partition that you want to store the environment in.
+
 config USE_DEFAULT_ENV_FILE
 	bool "Create default environment from file"
 	help
diff --git a/env/Makefile b/env/Makefile
index a54e924d419..4a5de0dea1d 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_$(PHASE_)ENV_IS_IN_EXT4) += ext4.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_NAND) += nand.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SPI_FLASH) += sf.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FLASH) += flash.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_UFS) += ufs.o
 
 CFLAGS_embedded.o := -Wa,--no-warn -DENV_CRC=$(shell tools/envcrc 2>/dev/null)
diff --git a/env/env.c b/env/env.c
index bcc189e14db..4535af92ba9 100644
--- a/env/env.c
+++ b/env/env.c
@@ -46,6 +46,9 @@ static enum env_location env_locations[] = {
 #ifdef CONFIG_ENV_IS_IN_MMC
 	ENVL_MMC,
 #endif
+#ifdef CONFIG_ENV_IS_IN_UFS
+	ENVL_UFS,
+#endif
 #ifdef CONFIG_ENV_IS_IN_NAND
 	ENVL_NAND,
 #endif
diff --git a/env/ufs.c b/env/ufs.c
new file mode 100644
index 00000000000..d44053d3551
--- /dev/null
+++ b/env/ufs.c
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
+struct env_ufs_info {
+	struct blk_desc *blk;
+	struct disk_partition part;
+	int count;
+};
+
+static struct env_ufs_info env_part;
+
+static inline struct env_ufs_info *env_ufs_get_part(void)
+{
+	struct env_ufs_info *ep = &env_part;
+
+	if (scsi_get_blk(CONFIG_SYS_UFS_ENV_PART, &ep->blk, &ep->part))
+		return NULL;
+
+	ep->count = CONFIG_ENV_SIZE / ep->part.blksz;
+
+	return ep;
+}
+
+static int env_ufs_save(void)
+{
+	struct env_ufs_info *ep = env_ufs_get_part();
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
+static int env_ufs_erase(void)
+{
+	struct env_ufs_info *ep = env_ufs_get_part();
+
+	if (!ep)
+		return -ENOENT;
+
+	return (int)blk_derase(ep->blk, ep->part.start, ep->count);
+}
+
+#if defined(ENV_IS_EMBEDDED)
+static int env_ufs_load(void)
+{
+	return 0;
+}
+#else
+static int env_ufs_load(void)
+{
+	struct env_ufs_info *ep = env_ufs_get_part();
+	int ret;
+
+	if (!ep) {
+		env_set_default(CONFIG_SYS_UFS_ENV_PART " partition not found", 0);
+		return -ENOENT;
+	}
+
+	if (blk_dread(ep->blk, ep->part.start, ep->count, &envbuf) != ep->count) {
+		env_set_default(CONFIG_SYS_UFS_ENV_PART " partition read failed", 0);
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
+U_BOOT_ENV_LOCATION(ufs) = {
+	.location	= ENVL_UFS,
+	ENV_NAME("UFS")
+	.load		= env_ufs_load,
+#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_XPL_BUILD)
+	.save		= env_save_ptr(env_ufs_save),
+	.erase		= ENV_ERASE_PTR(env_ufs_erase),
+#endif
+};
diff --git a/include/env_internal.h b/include/env_internal.h
index c1c0727e4d0..acc2ba19e86 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -114,6 +114,7 @@ enum env_location {
 	ENVL_REMOTE,
 	ENVL_SPI_FLASH,
 	ENVL_UBI,
+	ENVL_UFS,
 	ENVL_NOWHERE,
 
 	ENVL_COUNT,
-- 
2.34.1

