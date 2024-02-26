Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B9C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD91987E69;
	Mon, 26 Feb 2024 13:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="L4hmYSy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9CD087E9F; Mon, 26 Feb 2024 11:09:09 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4B787D6F
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q5dhWK013271; Mon, 26 Feb 2024 10:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=CjIDhc9lYhn7drd1hBYIazV3YttX70juX7ldyJ27P2s=; b=L4
 hmYSy+RRUZSb1LoGzaRZKgcnkkb9AddDXKpcScSmB/0am4s1uoaDXaXzJDxeuTCV
 Jz1TNPBUwwTukibEcndinIZ8/2KtpHGGlmWlR8kwgTE/bCL3nDp7jICPwRax+OmU
 DWnARfgrkmPUqnU9WcI9WckWCweMfDAIQhCSaduZ8uvRo2nnLhcRXbU/Ad4NRZOi
 XiroRif6GQB2wTlwibkvPee7iI9Lc/F1sFAseskWImUSHAVlthe51Opv4EmrsW91
 iT3aFTgkbrZccehbigKXYsKARvAaWUssuolWL9YCwm0AbB/m5rmarwD3KyrVKO+Z
 RV9upvoTuSynL1x8Wg+A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxkrjug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA92Vs017034
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:02 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:09:00 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 02/10] mach-snapdragon: ipq9574: Add SMEM defines needed for
 IPQ9574
Date: Mon, 26 Feb 2024 15:37:59 +0530
Message-ID: <20240226100807.1095607-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226100807.1095607-1-quic_varada@quicinc.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: ktjBVJm1NPfxS4ulmQe87bqB3I5TExWQ
X-Proofpoint-GUID: ktjBVJm1NPfxS4ulmQe87bqB3I5TExWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=771 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260076
X-Mailman-Approved-At: Mon, 26 Feb 2024 13:01:24 +0100
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

Add few SMEM related defines that will be used for
IPQ9574 based boards.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---

 include/smem.h | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/include/smem.h b/include/smem.h
index b19c534ebc..f305354996 100644
--- a/include/smem.h
+++ b/include/smem.h
@@ -16,6 +16,84 @@
 #ifndef _smemh_
 #define _smemh_
 
+enum {
+	SMEM_SPINLOCK_ARRAY		= 7,
+	SMEM_AARM_PARTITION_TABLE	= 9,
+	SMEM_HW_SW_BUILD_ID		= 137,
+	SMEM_USABLE_RAM_PARTITION_TABLE	= 402,
+	SMEM_POWER_ON_STATUS_INFO	= 403,
+	SMEM_MACHID_INFO_LOCATION	= 425,
+	SMEM_IMAGE_VERSION_TABLE	= 469,
+	SMEM_BOOT_FLASH_TYPE		= 498,
+	SMEM_BOOT_FLASH_INDEX		= 499,
+	SMEM_BOOT_FLASH_CHIP_SELECT	= 500,
+	SMEM_BOOT_FLASH_BLOCK_SIZE	= 501,
+	SMEM_BOOT_FLASH_DENSITY		= 502,
+	SMEM_BOOT_DUALPARTINFO		= 503,
+	SMEM_PARTITION_TABLE_OFFSET	= 504,
+	SMEM_SPI_FLASH_ADDR_LEN		= 505,
+	SMEM_FIRST_VALID_TYPE		= SMEM_SPINLOCK_ARRAY,
+	SMEM_LAST_VALID_TYPE		= SMEM_SPI_FLASH_ADDR_LEN,
+	SMEM_MAX_SIZE			= SMEM_SPI_FLASH_ADDR_LEN + 1,
+};
+
+enum {
+	SMEM_BOOT_NO_FLASH		= 0,
+	SMEM_BOOT_NOR_FLASH		= 1,
+	SMEM_BOOT_NAND_FLASH		= 2,
+	SMEM_BOOT_ONENAND_FLASH		= 3,
+	SMEM_BOOT_SDC_FLASH		= 4,
+	SMEM_BOOT_MMC_FLASH		= 5,
+	SMEM_BOOT_SPI_FLASH		= 6,
+	SMEM_BOOT_NORPLUSNAND		= 7,
+	SMEM_BOOT_NORPLUSEMMC		= 8,
+	SMEM_BOOT_QSPI_NAND_FLASH	= 11,
+};
+
+#define BUILD_ID_LEN			32
+#define SOCINFO_VERSION_MAJOR(ver)	(((ver) & 0xffff0000) >> 16)
+#define SOCINFO_VERSION_MINOR(ver)	((ver) & 0x0000ffff)
+
+struct smem_pmic_type {
+	unsigned int pmic_model;
+	unsigned int pmic_die_revision;
+};
+
+struct ipq_platform_v1 {
+	unsigned int	format;
+	unsigned int	id;
+	unsigned int	version;
+	char		build_id[BUILD_ID_LEN];
+	unsigned int	raw_id;
+	unsigned int	raw_version;
+	unsigned int	hw_platform;
+	unsigned int	platform_version;
+	unsigned int	accessory_chip;
+	unsigned int	hw_platform_subtype;
+};
+
+struct ipq_platform_v2 {
+	struct ipq_platform_v1	v1;
+	struct smem_pmic_type	pmic_info[3];
+	unsigned int		foundry_id;
+};
+
+struct ipq_platform_v3 {
+	struct ipq_platform_v2	v2;
+	unsigned int		chip_serial;
+};
+
+union ipq_platform {
+	struct ipq_platform_v1	v1;
+	struct ipq_platform_v2	v2;
+	struct ipq_platform_v3	v3;
+};
+
+struct smem_machid_info {
+	unsigned int format;
+	unsigned int machid;
+};
+
 /* struct smem_ops: Operations for the SMEM uclass */
 struct smem_ops {
 	/**
-- 
2.34.1

