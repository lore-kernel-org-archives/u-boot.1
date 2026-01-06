Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49ECCDC18E
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 12:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5959183F6A;
	Tue,  6 Jan 2026 13:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8zrqH0M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Awdbndqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4B283F75; Tue,  6 Jan 2026 13:22:34 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D01583F66
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 13:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 606BfMWD307825
 for <u-boot@lists.denx.de>; Tue, 6 Jan 2026 12:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wbfM3DwmrFE
 9TZUTsqxa1kGzQiuDnCL5iAN3fgw4X9U=; b=h8zrqH0McB/mjVVhj4SZn651joJ
 dYO8J4WoAxkjYs4PMk0TWccSwi4IP3bjxiVq52I9xS/90mpSuMx3e/fftr7PEpfq
 FiF4tR9jXLcTM4q9+fP/rq1x9rk4sICFaUpxYvMm6O7QLaM583e9gbzjKFufk9Aq
 Z4AQWBu6EwF9lOnlIlD/n1GVMF77kubv6Rc2Ls+TrKh2F849heb51Cj4A1kt2cvJ
 1CRdL/7JqkE4IUjc9ZDG8R98ydSUO5apWuRrK8NzhFWlJ+92okYmzFcTDv7p0mNe
 +B9WjShOHMhJpUE4y2PLjuLZ0VSuUO/Rk5ratQCWS2R1rg9y9xYqDWApUlA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh1r6g3gp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 12:22:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c38781efcso1891842a91.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 04:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767702139; x=1768306939; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wbfM3DwmrFE9TZUTsqxa1kGzQiuDnCL5iAN3fgw4X9U=;
 b=Awdbndqb6QrABWPz+3ZVdIu75TPj+b22qPUhDAnSnltEeceT1U9X4DG5xdZtVhYlN2
 rLGVY79JO8yUQtGKWsJDvPqRglV7r4uPESP1RStBfst2UJmTfwd6zkXb2uk/5Lt54JL5
 cF/TDXOOE7eL8pCex6HYjIFKyGcD/m5L66f7K+RSkXux6rSkoqKGoZgNFh4itB0fEuQw
 q4giQmunklRxcH2q+HB6m8iyVxk+2cjccMlheNgZUqZxxDoGhIbQqTsiYkJrnsBikg0F
 CDQJ/5Xntnb4bSo8DYKivKUGk5C31KqtgqBqguO4cbnwkMusLPRkRWivp4eCSevqQllJ
 C8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767702139; x=1768306939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wbfM3DwmrFE9TZUTsqxa1kGzQiuDnCL5iAN3fgw4X9U=;
 b=Z4qGJUK3JkdRbvP2NxH25CkvL5hrFwIkSVEzGCHJbalIcTfE+cl4g+oR8XjH7pDUrZ
 Kh+L2RWualBBCXmdKarRs+5cI8NylXQM/Km+Qc2Wp9YbGnPx6BH2WyZmVy5GG5L/mjcJ
 OovDTgWyUg0DIzEKQ0W2D2JfxRVCVxWKlVx6dNPGXNyC/xt4OTXsaVysx+/m0F2CePdI
 Kr3fy9EbKwhEJdu8RqxgEtw53EHd0zMseydpE2ISGSy+4uneW2T4lI2erv2yVlJ/NHSm
 HnNmniysSXrQtzDo1FlXwXg26//dZZN8cLsQFpLSgYoSEWMEjdCBpOOg96HkmeFLv7F4
 sILg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRsjdyRSIG+RX0csxlGmTSvnLInPKD0sYAr/0MiGsBHsfhoswj60MlwtBF3/QdtN3RX0kkoRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyUVrsya5iGzPWr8K/CZ9oClqXvKJnAoGsTN8k7HR8DFrLMMV/b
 dieTkaCKnIAV7RKIHaFOy0/8arRBUUNVV9QWDOzmuJiinRztphEVCzJqYg/FSRFpn+65vGclwyO
 ccyabN1lqlaj2FDoLTJT3NyfBo62l//4IzKd05nx87MZkRrS/X8jH9QAj
X-Gm-Gg: AY/fxX6QXmzkJqulfhbkGU6dVr0E3ApOOaAqDkcAkVDDXmU2IApiJzU52NBTh6DZwfL
 hqJK5BGDaXkk0feBfvIypCPcpZ/ouq09LsDe8uGqUQkU0WIOoVtGMwHMci4D86+AwdChJpchRgY
 jwqy8Q76DqqFHSHNXxm58JwUWmvU/IPRI7FIER50Gk8gXnnLjVyWny9lYkYqx1zAFG0sUCJjSA7
 5ywVzgKgp1LKb2CiKqRclqDRiZB3fQ76ocf/GJl4iugdlReUxUkNJK9p+b8FKhupbwdz6zu4WWj
 fssj0/wcTbqYLPfmJY219ePkPI6j5ynXcst437tBVidb3LK7CI4uvsNwO6J84kt7rhe4Ozx4uW/
 OfpnWMIKbgHOWlF+J7iwH/e8JI8HNvvyD1g+hIDX5YpW0KR+f2WPPJ2kTe7ED68NDlt8aGP+bVD
 2JK/DyEyqFWDWoNRVFDRJ0oD0Us26T
X-Received: by 2002:a17:90b:3c06:b0:341:194:5e7c with SMTP id
 98e67ed59e1d1-34f5f3071a8mr2341477a91.24.1767702138591; 
 Tue, 06 Jan 2026 04:22:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnaEhzlZ2+vOnpRrMUgLboqiQvc4lSSBc/KiIBxlmgNMvAhuub7q3PyNh2TaYOaXm3M0MZ8w==
X-Received: by 2002:a17:90b:3c06:b0:341:194:5e7c with SMTP id
 98e67ed59e1d1-34f5f3071a8mr2341460a91.24.1767702138001; 
 Tue, 06 Jan 2026 04:22:18 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88efb5sm2231509a91.10.2026.01.06.04.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 04:22:17 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrianox@gmail.com, paul.liu@linaro.org, sjg@chromium.org,
 wolfgang.wallner@at.abb.com, javier.tia@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 3/3] mach-snapdragon: Implement Qualcomm multi-DTB selection
Date: Tue,  6 Jan 2026 17:51:34 +0530
Message-Id: <20260106122134.2047864-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
References: <20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X_1ZEJ47UOTzJWLLu7F2VU-fY31666QA
X-Proofpoint-ORIG-GUID: X_1ZEJ47UOTzJWLLu7F2VU-fY31666QA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwNyBTYWx0ZWRfX5x4gwMMgFxoK
 kEiPriAwIDMPVcRoxEQrXAdURMeKEv0X0w+aMvZs8vmRUhfaqh6ydDTN4NudE7g/phWNLZONFEt
 ZN2BpRQM8yOQ93rU8fCOtji1Tz+SJ38JsJ/asbeQquYjvA/l88bz+YjhV1BhR1Bs8Gmry519PzL
 YDKCBQrTUrzEsR8mv5LiGxvfceV+x2Iye3yMDW4C5Q6jxvnbWNwA/RTHvmejPcR2n+GIscmNS5N
 AcSAi3Pswun0pCpEJ3quF0O+tdes3daNvWoZ71pIz9HYWHpXSXIDw2rrOB3JAU8y63TzFBvE+OX
 M87dlGUPBgQjL7qxbQuVB3/96fzcvOXKe4h2JRagBwzBbcokAkZxigDicCpeEyNpGhSzLQxpQJp
 FzRiJvwe/pipcrdwEtx6pO8dgPyq0W265Q7qAa7JwmJ5wNwnCN4baCIJgNH5PW9Gog3afqVxSsC
 tY7agi5Hxp+wOm4NOFg==
X-Authority-Analysis: v=2.4 cv=Ctuys34D c=1 sm=1 tr=0 ts=695cfe7b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-Xm46jwX109l7zpqCeUA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060107
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

Add Qualcomm-specific implementation of multi-DTB selection by
overriding the weak efi_load_platform_fdt() function. This enables
automatic device tree selection based on SoC information read from
SMEM (Shared Memory).

The implementation:
- Reads combined-dtb.dtb from the boot partition
- Parses qcom,msm-id, qcom,board-id, and qcom,pmic-id properties
- Matches against runtime SoC info (platform ID, board variant, PMIC)
- Selects the appropriate DTB for the current hardware configuration

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile       |   1 +
 arch/arm/mach-snapdragon/efi_fdt_qcom.c | 337 ++++++++++++++++++++++++
 2 files changed, 338 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/efi_fdt_qcom.c

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 343e825c6fd..70f36c8ec19 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -5,3 +5,4 @@
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
+obj-$(CONFIG_EFI_LOADER) += efi_fdt_qcom.o
diff --git a/arch/arm/mach-snapdragon/efi_fdt_qcom.c b/arch/arm/mach-snapdragon/efi_fdt_qcom.c
new file mode 100644
index 00000000000..f465fea71d8
--- /dev/null
+++ b/arch/arm/mach-snapdragon/efi_fdt_qcom.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm multi-DTB selection for EFI boot
+ *
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc.
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_device_path.h>
+#include <efi_loader.h>
+#include <log.h>
+#include <string.h>
+#include <fdt_support.h>
+#include <smem.h>
+#include <dm.h>
+#include <soc/qcom/socinfo.h>
+
+struct qcom_board_id {
+	u32 variant;
+	u32 sub_type;
+};
+
+struct qcom_pmic_id {
+	u32 pmic_ver[4];
+};
+
+struct qcom_plat_id {
+	u32 plat_id;
+	u32 soc_rev;
+};
+
+struct qcom_smem_pmic_info {
+	u32 model;
+	u32 version;
+};
+
+struct qcom_dt_entry {
+	u32 plat_id;
+	u32 variant;
+	u32 sub_type;
+	u32 soc_rev;
+	u32 pmic_ver[4];
+	void *fdt;
+	u32 size;
+	u32 idx;
+};
+
+struct qcom_dt_entry qcom_dt_entries[64];
+
+#define PLAT_ID_SIZE    sizeof(struct qcom_plat_id)
+#define BOARD_ID_SIZE   sizeof(struct qcom_board_id)
+#define PMIC_ID_SIZE    sizeof(struct qcom_pmic_id)
+#define DEV_TREE_VERSION_V1 1
+#define DEV_TREE_VERSION_V2 2
+#define DEV_TREE_VERSION_V3 3
+#define DT_ENTRY_V1_SIZE 0xC
+#define PMIC_EXT_VERSION 0x0000000000010003
+
+#define fdt_board_variant(_b, _i)	\
+	(fdt32_to_cpu(((struct qcom_board_id *)_b)[_i].variant) & 0xff)
+#define fdt_board_sub_type(_b, _i)	\
+	(fdt32_to_cpu(((struct qcom_board_id *)_b)[_i].sub_type) & 0xff)
+#define fdt_plat_plat_id(_b, _i)	\
+	(fdt32_to_cpu(((struct qcom_plat_id *)_b)[_i].plat_id) & 0xffff)
+#define fdt_plat_soc_rev(_b, _i)	\
+	fdt32_to_cpu(((struct qcom_plat_id *)_b)[_i].soc_rev)
+#define fdt_pmic_pmic_ver(_b, _i, _x)	\
+	fdt32_to_cpu(((struct qcom_pmic_id *)_b)[_i].pmic_ver[_x])
+
+static int qcom_parse_one_dtb(void *fdt, struct socinfo *socinfo, void **match)
+{
+	const char *model, *pmic, *board, *plat;
+	int pmiclen, boardlen, platlen, minplatlen;
+	struct qcom_smem_pmic_info *smem_pmic_info;
+	int dtbver, i, j, k;
+
+	*match = NULL;
+
+	model = fdt_getprop(fdt, 0, "model", NULL);
+	pmic = fdt_getprop(fdt, 0, "qcom,pmic-id", &pmiclen);
+	board = fdt_getprop(fdt, 0, "qcom,board-id", &boardlen);
+	plat = fdt_getprop(fdt, 0, "qcom,msm-id", &platlen);
+
+	if (pmic && pmiclen > 0 && board && boardlen > 0) {
+		if ((pmiclen % PMIC_ID_SIZE) || (boardlen % BOARD_ID_SIZE)) {
+			log_err("qcom,pmic-id (%d) or qcom,board-id (%d) not a multiple of (%lu, %lu)\n",
+				pmiclen, boardlen, PMIC_ID_SIZE, BOARD_ID_SIZE);
+			return -1;
+		}
+		dtbver = DEV_TREE_VERSION_V3;
+		minplatlen = PLAT_ID_SIZE;
+	} else if (board && boardlen > 0) {
+		if (boardlen % BOARD_ID_SIZE) {
+			log_err("qcom,board-id (%d) not a multiple of %lu\n",
+				boardlen, BOARD_ID_SIZE);
+			return -1;
+		}
+		dtbver = DEV_TREE_VERSION_V2;
+		minplatlen = PLAT_ID_SIZE;
+	} else {
+		dtbver = DEV_TREE_VERSION_V1;
+		minplatlen = DT_ENTRY_V1_SIZE;
+	}
+
+	if (!plat || platlen < 0) {
+		log_err("qcom,msm-id not found\n");
+		return -1;
+	} else if (platlen % minplatlen) {
+		log_err("qcom,msm-id (%d) not a multiple of %d\n",
+			platlen, minplatlen);
+		return -1;
+	}
+
+	smem_pmic_info = ((void *)socinfo) + socinfo->pmic_array_offset;
+
+	for (i = 0; i < (boardlen / BOARD_ID_SIZE); i++)
+		for (j = 0; j < (platlen / PLAT_ID_SIZE); j++)
+			if (pmic) {
+				for (k = 0; k < (pmiclen / PMIC_ID_SIZE); k++) {
+					if ((socinfo->id & 0x0000ffff) ==
+					    fdt_plat_plat_id(plat, j) &&
+					    socinfo->hw_plat ==
+					    fdt_board_variant(board, i) &&
+					    socinfo->hw_plat_subtype ==
+					    fdt_board_sub_type(board, i) &&
+					    socinfo->plat_ver ==
+					    fdt_plat_soc_rev(plat, j) &&
+					    smem_pmic_info[0].model ==
+					    fdt_pmic_pmic_ver(pmic, k, 0) &&
+					    smem_pmic_info[1].model ==
+					    fdt_pmic_pmic_ver(pmic, k, 1) &&
+					    smem_pmic_info[2].model ==
+					    fdt_pmic_pmic_ver(pmic, k, 2) &&
+					    smem_pmic_info[3].model ==
+					    fdt_pmic_pmic_ver(pmic, k, 3)) {
+						*match = fdt;
+						log_info("%8x| %8x| %8x| %4d.%03d| %8x| %8x| %8x| %8x| %s\n",
+							 fdt_board_variant(board, i),
+							 fdt_board_sub_type(board, i),
+							 fdt_plat_plat_id(plat, j),
+							 SOCINFO_MAJOR(fdt_plat_soc_rev(plat, j)),
+							 SOCINFO_MINOR(fdt_plat_soc_rev(plat, j)),
+							 fdt_pmic_pmic_ver(pmic, k, 0),
+							 fdt_pmic_pmic_ver(pmic, k, 1),
+							 fdt_pmic_pmic_ver(pmic, k, 2),
+							 fdt_pmic_pmic_ver(pmic, k, 3), model);
+						return 0;
+					}
+				}
+			} else {
+				if ((socinfo->id & 0x0000ffff) ==
+				    fdt_plat_plat_id(plat, j) &&
+				    socinfo->hw_plat ==
+				    fdt_board_variant(board, i) &&
+				    socinfo->hw_plat_subtype ==
+				    fdt_board_sub_type(board, i) &&
+				    socinfo->plat_ver ==
+				    fdt_plat_soc_rev(plat, j)) {
+					*match = fdt;
+					log_info("%8x| %8x| %8x| %4d.%03d| %8s| %8s| %8s| %8s| %s\n",
+						 fdt_board_variant(board, i),
+						 fdt_board_sub_type(board, i),
+						 fdt_plat_plat_id(plat, j),
+						 SOCINFO_MAJOR(fdt_plat_soc_rev(plat, j)),
+						 SOCINFO_MINOR(fdt_plat_soc_rev(plat, j)),
+						 "--", "--", "--", "--", model);
+					return 0;
+				}
+			}
+
+	return 0;
+}
+
+static struct fdt_header *qcom_parse_combined_dtb(struct fdt_header *fdt)
+{
+	int fdt_count = 0;
+	struct udevice *dev;
+	size_t size;
+	struct socinfo *socinfo;
+	void *match;
+	struct fdt_header *fdt_blob = fdt;
+
+	if (!fdt_valid(&fdt)) {
+		log_err("%s: fdt not valid!\n", __func__);
+		return NULL;
+	}
+
+	uclass_get_device(UCLASS_SMEM, 0, &dev);
+
+	socinfo = smem_get(dev, 0, SMEM_HW_SW_BUILD_ID, &size);
+	log_debug("%s: socinfo: %p\n", __func__, socinfo);
+
+	log_info("%-8s| %-8s| %-8s| %-8s| %-8s| %-8s| %-8s| %-8s| %s\n"
+		 "--------+---------+---------+---------+---------+---------+---------+---------+------\n",
+		 "Variant", "Sub Type", "Plat Id", "SoC Rev.",
+		 "pmic[0]", "pmic[1]", "pmic[2]", "pmic[3]", "Model");
+
+	while (fdt_valid(&fdt)) {
+		qcom_parse_one_dtb(fdt, socinfo, &match);
+
+		if (match)
+			return match;
+
+		fdt = ((void *)fdt) + fdt_totalsize(fdt);
+		fdt_count++;
+	}
+
+	if (fdt_count == 1)
+		return fdt_blob;
+
+	return NULL;
+}
+
+static void efi_load_qcom_fdt(efi_handle_t handle, void **_fdt,
+			      efi_uintn_t *_fdt_size)
+{
+	u32 i;
+	efi_uintn_t count;
+	u64 fdt_addr, tmp_addr;
+	efi_status_t ret;
+	u16 *fdt_name = u"/combined-dtb.dtb";
+	struct efi_handler *handler;
+	efi_handle_t *volume_handles = NULL;
+	struct efi_simple_file_system_protocol *v;
+	struct efi_file_handle *f = NULL;
+	void *match;
+
+	*_fdt = NULL;
+	*_fdt_size = 0;
+
+	ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
+					   &efi_simple_file_system_protocol_guid,
+					   NULL, &count,
+					   (efi_handle_t **)&volume_handles);
+	if (ret != EFI_SUCCESS) {
+		log_err("%s: No block device found! (0x%lx)\n", __func__, ret);
+		return;
+	}
+
+	log_info("Using device tree: %ls\n", fdt_name);
+
+	/* Try to find combined-dtb.dtb on available volumes */
+	for (i = 0; i < count; i++) {
+		struct efi_file_handle *root;
+
+		ret = efi_search_protocol(volume_handles[i],
+					  &efi_simple_file_system_protocol_guid,
+					  &handler);
+		if (ret != EFI_SUCCESS)
+			continue;
+		ret = efi_protocol_open(handler, (void **)&v, efi_root, NULL,
+					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+		if (ret != EFI_SUCCESS)
+			continue;
+
+		ret = EFI_CALL(v->open_volume(v, &root));
+		if (ret != EFI_SUCCESS)
+			goto out;
+
+		ret = EFI_CALL(root->open(root, &f, fdt_name,
+					  EFI_FILE_MODE_READ, 0));
+		if (ret != EFI_SUCCESS) {
+			log_warning("%s: Reading volume failed! (0x%lx)\n",
+				    __func__, ret);
+			continue;
+		} else {
+			log_debug("%s: %ls found!\n", __func__, fdt_name);
+			break;
+		}
+	}
+
+	if (!f)
+		goto out;
+
+	ret = efi_file_size(f, &count);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				 EFI_BOOT_SERVICES_DATA,
+				 efi_size_in_pages(count), &fdt_addr);
+	if (ret != EFI_SUCCESS) {
+		log_err("%s: Out of memory! (0x%lx bytes) (0x%lx)\n",
+			__func__, count, ret);
+		goto out;
+	}
+	ret = EFI_CALL(f->read(f, &count, (void *)(uintptr_t)fdt_addr));
+	if (ret != EFI_SUCCESS) {
+		log_err("%s: Can't read fdt! (0x%lx)\n", __func__, ret);
+		goto out;
+	}
+
+	match = qcom_parse_combined_dtb((void *)(uintptr_t)fdt_addr);
+	if (match) {
+		*_fdt_size = fdt_totalsize(match);
+
+		ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+					 EFI_BOOT_SERVICES_DATA,
+					 efi_size_in_pages(*_fdt_size), &tmp_addr);
+		if (ret != EFI_SUCCESS) {
+			log_err("%s: Out of memory! (0x%lx bytes) (0x%lx)\n",
+				__func__, *_fdt_size, ret);
+			goto out;
+		}
+		/*
+		 * The memory allocated for reading the fdt is eventually freed
+		 * by the caller using the address we return. Hence copy it out
+		 */
+		memcpy((void *)(uintptr_t)tmp_addr, match, *_fdt_size);
+		*_fdt = (void *)(uintptr_t)tmp_addr;
+
+		log_debug("%s: fdt@0x%p %lu\n", __func__, *_fdt, *_fdt_size);
+	} else {
+		log_warning("%s: No FDT matched!!\n", __func__);
+	}
+out:
+	efi_free_pages(fdt_addr, efi_size_in_pages(count));
+
+	efi_free_pool(volume_handles);
+}
+
+/**
+ * efi_load_platform_fdt() - Platform-specific FDT loading (Qualcomm override)
+ *
+ * @handle:	handle of loaded image
+ * @fdt:	on return device-tree, must be freed via efi_free_pages()
+ * @fdt_size:	buffer size
+ *
+ * This function overrides the weak function in lib/efi_loader/efi_fdt.c
+ * to provide Qualcomm-specific multi-DTB selection based on SoC info.
+ */
+void efi_load_platform_fdt(efi_handle_t handle, void **fdt,
+			   efi_uintn_t *fdt_size)
+{
+	efi_load_qcom_fdt(handle, fdt, fdt_size);
+}
-- 
2.34.1

