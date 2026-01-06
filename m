Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FA4CDC18E
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 12:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A59C83F7F;
	Tue,  6 Jan 2026 13:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZjNnvJ/M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CsIkD6xL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E634683F6C; Tue,  6 Jan 2026 13:22:34 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B502783F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 13:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 606BVccj2253955
 for <u-boot@lists.denx.de>; Tue, 6 Jan 2026 12:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zlgQ3u4e4kZ
 lVfrCz52XjOHh07j+W5tRBa3suIGx4Zo=; b=ZjNnvJ/M5ghNnBZJoobwz2vMAVe
 oO3B74sjQ1Y2023q99tQvH0DlpTnYGpN8DHthMFo8c+YQcHVQ9c2U994raEqPUoR
 UWkkbu1Jh54uIdXeaHY+3IMUw6xBDsBC/HwF3hGZCjG6Galg82LZILfHTMIY0TYK
 P2llIezBMOGlvKQSiI8RL8cLXluC5lj6onESktlXShj2AiIYvH2KUdKQqZYCDNGe
 o32fL0kNFXIF6twkzDBAZ4cgf0fzDETx0YR2NG5QkVSpYsLig0SjfauaOB68LZzd
 t97Yc4whTcvfMIaRn4zafpdN1ddPo6ssgFIK2vnVldSpnlrQGySAGuN3YyQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu421av5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:22:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c6e05af6fso1208539a91.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 04:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767702134; x=1768306934; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zlgQ3u4e4kZlVfrCz52XjOHh07j+W5tRBa3suIGx4Zo=;
 b=CsIkD6xLKDV3AiIBfe7bianRO4iYt4OcysQl/3kdaEU29qOReJu+wUMz+S0M2mYC/J
 XzkiS9rmee8JomaOkj/b4wVZS9vfWypg47TLt+QNeyZyj7cogubaUqFtU4HBjzpG6ar4
 DmsgdHJ/Y6TbL1zcRajHEr5OIpB78zyYENTcEZ/mKeEuRn0AfxvRqnDw6ff1/lviDQ5e
 OtgxICunk91OArJunrzfx8AI/F7nsSzPvShpYVzsEgB/KQYKuOpixAwGRD1zWfn3v+Dx
 iJ9MVC4XT4MJzQyeyVZn5ef8K5Xzh09aDNugauCkWAWIMdX2ShDpGMEeBAgQcrqKqLrp
 rtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767702134; x=1768306934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zlgQ3u4e4kZlVfrCz52XjOHh07j+W5tRBa3suIGx4Zo=;
 b=mqCpIqSzVci3S4hZmirktnAqQYoZpQjmHiBB9H1zFcSCkuHs9/PpVFEkn/I9qOXQNI
 aWa67Y1qFtkUiFGuiGkNzLvx94qY3hJ/MROUQfuWNdPkZc1w9/Tl2soVd6esadm2jFJI
 Qnk5X2r9jmZusI4A/JJK2m5TMpqWJxskUwJu2XSd3jVzLWJg6CnP6KAZaq8pgpnj9y98
 w6zPUELE+AfqYm+FXpHCV61pqgnNuKhNdPLaq89heENJLeD3991j6Zl8JKkbd3T4VTwG
 nXZKjinJImBg4hworUPTRnxnN1+qgcN4nZ/OkBmNfddPyf1g+2QTpt0Ay66DVmiBVGzq
 8LvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjsmX7/f7IRU/tDd06OH7rsA9dfo9XsJqvk3IRSbJUYVwffEcJ4PPahzsHlgB85xH0CwCxRfw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzeeecmk4/lcAI8t/y5Qduo8Gf/eXI8kAbfbs1eNFG6fB+P5oVz
 /SPPFYGsRIGlzjAfiL47Tj7gSsXrBT5mvq15IzJbP2KhgROqMSBUmFr/lPG88NVKygOxPhBDjVl
 dY57W/scV1GdkXBFbjRSOPen/2xKI6JI4Kit8eHl0WyhwFV8F44K7S9zx
X-Gm-Gg: AY/fxX7xB/t4XHpAG9I7xYZKtcx8j3xtVZ8xottFNMbbnlZ+7SBS2qqD0YBdhfVzFUR
 K2BLW/sZod21UAIqaJ8oFXAtnY55vtkRMBd+bYNrYDDAA1FehdwEPGl87OC1tCqTdBUCQ41uj/4
 FNkwgWpPnsFHAWoAogI0r1DzSqqs6OqEwCahcTX8sNpfxxoEvQic3YJZnxXlxFANzsqv+pjpPjS
 /va2bRGblgy3RY17lRfqSx/yXEec9/KZ4khsGUm+AYMBDgohp7cUtlIWxidpGLK137/vlYacUx/
 lHO+SihlRUhNgh6wOhbrYL5ShnvPbjRfPCRTLH1K2D4QyQsEw/OzuGZZwbiFgBBee9VuqsAVJDb
 gfMfRSN0UPb9QrXBJxq26ycU4fx5zmL6dR7rVFE/zyBQLmGXwjSfjMVbK2J4ijx/u1Ix6oI7zoX
 UriOeYlbzJCrq0mJKy3I4EFE3L3p3t
X-Received: by 2002:a17:90b:544c:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-34f5f26c758mr2297061a91.4.1767702134052; 
 Tue, 06 Jan 2026 04:22:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+YrwDs4iDF0eD2jRAb7U4jeIjIVWW4Fw78da2WMP8+qa5Q1IRr4z18zu+fX7GD42wq7sEAg==
X-Received: by 2002:a17:90b:544c:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-34f5f26c758mr2297034a91.4.1767702133555; 
 Tue, 06 Jan 2026 04:22:13 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88efb5sm2231509a91.10.2026.01.06.04.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 04:22:13 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrianox@gmail.com, paul.liu@linaro.org, sjg@chromium.org,
 wolfgang.wallner@at.abb.com, javier.tia@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/3] soc: qcom: smem: Added socinfo header file
Date: Tue,  6 Jan 2026 17:51:33 +0530
Message-Id: <20260106122134.2047864-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695cfe77 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aA-AARzxIrW8pTn3BOsA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ach-EbdqtIx7N6vk65vz8BzKDoGi8rvM
X-Proofpoint-ORIG-GUID: ach-EbdqtIx7N6vk65vz8BzKDoGi8rvM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNyBTYWx0ZWRfX1T98M0hXuHQt
 27fZDZQhUi1FtEsqbldHNAhAWO1bkeCTYTxkDGW7OmEGQPA+w25KVrWA+Zl1SKrnDKhZ7L7nHOL
 qVX1OeYB7EURMGZTJUbDQmJl8Ft7OW3qXhmd4Ys76joeHyGaOpZ/3FaKjAjK9Mbh3rtWi+ISSlo
 EEckm6PnTiQoiMuyJcXGnih+Nle95NsPI8Jl1yjP33zgdI2/ytfmRAJ1XdnGqaEzfkMeSj9bvjZ
 5hQpK3jqbOlPqg6EHwq5dU+RKsh4CJvzA568/tqGBSTtdzzHA3/pZRcfIlrN2PkdYEpq3y1lXSd
 FJMEoxXXuzJLoi7bYPUET+tPLLkf7sPFLxhm9O7dZMQFMHNC+2z6t51+sjOaiG2mxdEOodDjdWA
 L87cewYkbKjzeMOVyFsinLbU1XH543ODBsifsgjBSKoQmGLfw4L6BU+Bj8PbzBnG6yfCpx4Q9+5
 FzNXEsjSDO2HsP1Jvdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060107
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

From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

Added socinfo header file from linux [1]. This header
defines SoC ID constants, version macros, and helper APIs for querying
SoC details such as ID, revision, and features at runtime. It enables
platform-specific initialization and feature gating based on SoC info.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/soc/qcom/socinfo.h?id=7dcc1dfaa3d1cd3aafed2beb7086ed34fdb22303

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 include/soc/qcom/socinfo.h | 114 +++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 include/soc/qcom/socinfo.h

diff --git a/include/soc/qcom/socinfo.h b/include/soc/qcom/socinfo.h
new file mode 100644
index 00000000000..1bb6e200e1f
--- /dev/null
+++ b/include/soc/qcom/socinfo.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QCOM_SOCINFO_H__
+#define __QCOM_SOCINFO_H__
+
+#include <linux/types.h>
+
+/*
+ * SMEM item id, used to acquire handles to respective
+ * SMEM region.
+ */
+#define SMEM_HW_SW_BUILD_ID		137
+
+#define SMEM_SOCINFO_BUILD_ID_LENGTH	32
+#define SMEM_SOCINFO_CHIP_ID_LENGTH	32
+
+/*
+ * SoC version type with major number in the upper 16 bits and minor
+ * number in the lower 16 bits.
+ */
+#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
+#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
+#define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16) | ((min) & 0xffff))
+
+/* Socinfo SMEM item structure */
+struct socinfo {
+	__le32 fmt;
+	__le32 id;
+	__le32 ver;
+	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
+	/* Version 2 */
+	__le32 raw_id;
+	__le32 raw_ver;
+	/* Version 3 */
+	__le32 hw_plat;
+	/* Version 4 */
+	__le32 plat_ver;
+	/* Version 5 */
+	__le32 accessory_chip;
+	/* Version 6 */
+	__le32 hw_plat_subtype;
+	/* Version 7 */
+	__le32 pmic_model;
+	__le32 pmic_die_rev;
+	/* Version 8 */
+	__le32 pmic_model_1;
+	__le32 pmic_die_rev_1;
+	__le32 pmic_model_2;
+	__le32 pmic_die_rev_2;
+	/* Version 9 */
+	__le32 foundry_id;
+	/* Version 10 */
+	__le32 serial_num;
+	/* Version 11 */
+	__le32 num_pmics;
+	__le32 pmic_array_offset;
+	/* Version 12 */
+	__le32 chip_family;
+	__le32 raw_device_family;
+	__le32 raw_device_num;
+	/* Version 13 */
+	__le32 nproduct_id;
+	char chip_id[SMEM_SOCINFO_CHIP_ID_LENGTH];
+	/* Version 14 */
+	__le32 num_clusters;
+	__le32 ncluster_array_offset;
+	__le32 num_subset_parts;
+	__le32 nsubset_parts_array_offset;
+	/* Version 15 */
+	__le32 nmodem_supported;
+	/* Version 16 */
+	__le32  feature_code;
+	__le32  pcode;
+	__le32  npartnamemap_offset;
+	__le32  nnum_partname_mapping;
+	/* Version 17 */
+	__le32 oem_variant;
+	/* Version 18 */
+	__le32 num_kvps;
+	__le32 kvps_offset;
+	/* Version 19 */
+	__le32 num_func_clusters;
+	__le32 boot_cluster;
+	__le32 boot_core;
+};
+
+/* Internal feature codes */
+enum qcom_socinfo_feature_code {
+	/* External feature codes */
+	SOCINFO_FC_UNKNOWN = 0x0,
+	SOCINFO_FC_AA,
+	SOCINFO_FC_AB,
+	SOCINFO_FC_AC,
+	SOCINFO_FC_AD,
+	SOCINFO_FC_AE,
+	SOCINFO_FC_AF,
+	SOCINFO_FC_AG,
+	SOCINFO_FC_AH,
+};
+
+/* Internal feature codes */
+/* Valid values: 0 <= n <= 0xf */
+#define SOCINFO_FC_Yn(n)		(0xf1 + (n))
+#define SOCINFO_FC_INT_MAX		SOCINFO_FC_Yn(0xf)
+
+/* Product codes */
+#define SOCINFO_PC_UNKNOWN		0
+#define SOCINFO_PCn(n)			((n) + 1)
+#define SOCINFO_PC_RESERVE		(BIT(31) - 1)
+
+#endif
-- 
2.34.1

