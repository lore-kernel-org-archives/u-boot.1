Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DA9C44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 07:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2D4E4078E;
	Wed, 22 Jul 2026 07:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xygEv5c-14px; Wed, 22 Jul 2026 07:42:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14AF840756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784706141;
	bh=gVba1C0gTFg0SzLPjgkePNZQtZ3oc5SNmz5TYpyYX5Q=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tlAwmXtQhyzdwqNBU0Se2tVgy5XjTGsYisiIdeLh0y9qY1ADyMV8/mbQ+iAmuP4vF
	 1m139ZJ47kk+9qWu+YFGyb+ShxFuDRttO50QgPmTrwI59WVNyYSlZ/j15wPphEUSsC
	 dk4SLuidv7yvRufTSvIAA8hcGrJDSWrOncLeN+emBIScVgEhz9GQcO3bHZLVmQScZ2
	 PtW/K3JIveYsmxhQhDAjLPZaSuBKrwgpiq8qx4X6lz2/SpZvoq7H2wKlJUA3HPpj4N
	 UNm5frpEvuqYMxudOZOvIUhoD+tXlkjKsA0yCcUGEp+PFgYH/1re5maTzD4/PzYya9
	 7NZJyEb/K34UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14AF840756;
	Wed, 22 Jul 2026 07:42:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AED6DB4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 003F760746
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MELXTfI-9R92 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 07:42:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DA4DC60740
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA4DC60740
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA4DC60740
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:18 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53g7D3917546
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:17 GMT
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6aathf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 07:42:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cae455cf6dso175501495ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 00:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706136; x=1785310936;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gVba1C0gTFg0SzLPjgkePNZQtZ3oc5SNmz5TYpyYX5Q=;
 b=IvQbPllUld7NIf6NYMtzuOaRYgQEPV1o1EPQ2BHSQ5lVD8iR+SgTyVPpukNw56+wW2
 YnGHhHq0XLoAbNMRykr9I8O7B7vTuDKa2kYceJCr+86+0TjZwOzMNysgxshSOXN9uCAa
 82uXLPbER55UfMiyw0XHIZ44d1harHr7HwfnyIZTWbFu5v0aCRK4AfreOkpqtARsVffJ
 6dvB/ZM2MgQ0piu0XBucq3EucsXIVZmvF7ml8nT0GDBTdwOGZ+wk2BC8aUIaW9fArDP5
 mxlVUIxNIUq/F172hYATae9V6MPsZQcjL2GycPKwtVPCx/MPH/cjuQJgCex8a2RpXWmS
 WLhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpA0gDNEnscpjrc6sznaXQ1ApP/I32FLk9q3Xj/mcN+7ogBSbz5+ga0RgGixauqIP9ZzSw3Nkw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzGT4mefB2q8AY/KBGBWPus5S+clQ36fWbHB1H3e5d6hV1+ZMPW
 Qsp7ekBaWRl9SbC09vBXo14DRnAhguC3r6QlikkZdi6tfB3TndWukebYWKvgMRm+z8qSz1l3QUs
 8+4GoSXDMVe7Ta2P/XPLrTWcRCJIHgOjrIMIAhFqkaas4OZAx2l7tKWdBwBMIFtO66Rmrpog=
X-Gm-Gg: AR+sD139ml5mL6UThIcTFKn5hBkVg19km2/Bc2CY179SbKL7MiEaUD1tCjFaWnKrunj
 HQtJ5E+kKbvoiTpCC3cUd/TD/LYQJpmWb4koX6MhKmFJy/DKh8xZHGCUzzPdTGTeaplBW+vjGUC
 O5TNyvrumO4lKPKG498WliyVExRnxO+4K3uZLSQxnIXxTUwSvClwEEw34U/7BIKvCo0NRTHxxHi
 +4SweF7eObMstZjGGN3EsiULlUuX4MJWBPN6TRSd0iNiFk5DHWIAIFLq/i2dQ35OtoKl7qZsfzt
 HiQpnP1lFuNkbaVNpiWyyqJ9pqXQX8ZCyTlL6hRh7ZdLmm7VuHkLrPpKvf2Zf5XFswxRWUbUMz7
 a5XEB/WoIvsWHmsamP8seBYq/KBPiRwbrQqVJJMge2+h0wmQIWuc3saf13RsGWDV03jfNBGyvpn
 057VEw5pX1hFsKJBV5uJGQLExzJS8SzQ==
X-Received: by 2002:a17:902:fdae:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2cf3466a93fmr239616075ad.0.1784706136174; 
 Wed, 22 Jul 2026 00:42:16 -0700 (PDT)
X-Received: by 2002:a17:902:fdae:b0:2ca:ecf6:910e with SMTP id
 d9443c01a7336-2cf3466a93fmr239615615ad.0.1784706135704; 
 Wed, 22 Jul 2026 00:42:15 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df09ac0sm5572577eec.16.2026.07.22.00.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:42:15 -0700 (PDT)
Date: Wed, 22 Jul 2026 13:11:16 +0530
Subject: [PATCH v8 05/15] mach-snapdragon: spl: Add support for MMC booting
 in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-spl-v8-v8-5-cbfa79e85a9d@oss.qualcomm.com>
References: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
In-Reply-To: <20260722-spl-v8-v8-0-cbfa79e85a9d@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Johan Jonker <jbx6244@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Erikas Bitovtas <xerikasxx@gmail.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX3TVl/GIdmV0F
 OqP2pax8F72ga5W9ih3EXV+avwiqraarX7axGkhf/43UOL7lk7Fu5eQCIiyggO0SkE0dKmMDsiV
 +k6lHFv91IcMYQxGhhzhIXiQIGfQXaarmYouyPtAAruH+HUnjRdIDC/STcQOu/+tgzWgiUMFESx
 YR+mtV97Lq0NMFz5pmOJe0v9ZhwQqrIF6hUmd+qMlNvYgu/0ggxdw6hJ/wSaMplNzyrO3+cOqfl
 jHBxSqeMukhmvTzRHUnDMTQ2ltIdTvRZJegtucJNf7sHIw0j8IAK+B2Xfpp4VuqcaqJMEQ7FvgY
 qddAPZtPDDFPh18BEe3f9DDmwO30wf5nXVFnH7qgHgrH/Sg7BdQITRojOQ9svBdiUnO0F159b/S
 qYmNFmVi9HK1bShGMtneLHxARKg6VljfaeVZS24DoD08Tg5KVr9+GA3XHji1ELCbN94Q3Mx1UjJ
 MfaMaS/OT+k06EufpjA==
X-Proofpoint-GUID: S0yXIj8zmyMJ3EKAnltIf5BEYp0YHk0X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX6GRDru2+nvv+
 oi+cFiMmDxGYe2wG3jLFXRMXKepZ3su6qpCGMHynYDLKZhnceQTt/wgLJV2rrJvDv63RLVg9gMh
 8Am1YF8dD3C6knzdpsiSiw1rXRQNDIE=
X-Authority-Analysis: v=2.4 cv=HvJG3UTS c=1 sm=1 tr=0 ts=6a607459 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=b3y_eNWQE9c3FeycJBQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: S0yXIj8zmyMJ3EKAnltIf5BEYp0YHk0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gVba1C0gTFg0SzLPjgkePNZQtZ3oc5SNmz5TYpyYX5Q=; b=b51aNbFmoo0jzTgf
 xvwmiXh+au6pDSzmJLfERCT9CL1oKxwarcdthghSiO8UUUfCo+9ZZvErjTvY7zMW
 rxYOCi/92rW0WA8/4GJKeOxDSE68PIkCZq02Mlr/KupSIWv0JKP3wvjMLmgdS2Br
 DBmxFpfnAA/NpaMjg8bBH496leWd6dMBcmCWsQPpjo38LbNUUclYDqbZPolD7kXR
 fMJucpiuQ67pZiaR1vk/t4ddTVEhg4BQsgbzmyjeew+X0M1LYuGdiRfKHlSJsazx
 Y4Y0LoMNOD8nD/UrzOKmyoFxbOk/9CxlEEbDKJxzXj1uh7dbsyhZmNNQzZdZt8jF
 GFApCg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706136; x=1785310936;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gVba1C0gTFg0SzLPjgkePNZQtZ3oc5SNmz5TYpyYX5Q=;
 b=K36QNOEmIN/G6/HYH52gnRzf0asOT6GiDufS34ocUHZW4sYE4eiFeOSV+HUbqwP5X7
 crakjzZEjZ34Cr7LHkYdRXnH6At1tWEsOeDCz2zHHriDs7lwF4kWNRfAyCZwp5WxgnCK
 fVEdyOEhhP6Jy9YUdXSjIGY9xkrt+kfvTcDFSV3A2EeIyxTaY2ELgUIgN13h3OCLwUuu
 FC6qfDTY9FyinIlRJJ8Pnot1uJT/dv1d3C77tVNdv+7tFwlcbl5CduMHYomediam3MBZ
 Jko14uJPh+xeAD8/nppx+07z3hobXYBMfnNcX82NBx1gOYu6uvpBBIp2LWeH90VX9Ts6
 9IXw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=b51aNbFm; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=K36QNOEm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Varadarajan Narayanan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add routines to enable U-Boot SPL to be able to proceed with the boot from
MMC partitions.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c | 107 +++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 69a32e5d8cf..c5e86458616 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -131,3 +131,110 @@ static int qcom_spl_populate_smem(void *ctx)
 	return -ENOENT;
 }
 #endif /* IS_ENABLED(CONFIG_SPL_SMEM) */
+
+#if CONFIG_IS_ENABLED(MMC)
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"0:BOOTLDR"
+
+/**
+ * spl_find_partition_info() - Find partition information by name
+ * @uclass_id: Device class ID (UCLASS_MMC)
+ * @device_num: Device number within the class
+ * @part_name: Name of the partition to find
+ * @info: Pointer to store partition information
+ *
+ * This function provides partition lookup logic for MMC.
+ * Return: Partition number on success, negative error code on failure
+ */
+static int spl_find_partition_info(enum uclass_id uclass_id, int device_num,
+				   const char *part_name,
+				   struct disk_partition *info)
+{
+	int ret;
+	struct blk_desc *desc;
+
+	if (!part_name || !info) {
+		printf("Invalid parameters for partition lookup\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get block device descriptor
+	 */
+	desc = blk_get_devnum_by_uclass_id(uclass_id, device_num);
+	if (!desc) {
+		printf("Block device not found for class %d, device %d\n",
+		       uclass_id, device_num);
+		return -ENODEV;
+	}
+
+	/*
+	 * Initialize partition table if needed
+	 */
+	if (desc->part_type == PART_TYPE_UNKNOWN) {
+		printf("Initializing partition table\n");
+		/*
+		 * Prefer EFI/GPT
+		 */
+		desc->part_type = PART_TYPE_EFI;
+	}
+
+	/*
+	 * Find partition by name
+	 */
+	ret = part_get_info_by_name(desc, part_name, info);
+	if (ret < 0) {
+		printf("Partition '%s' not found\n", part_name);
+		return -ENOENT;
+	}
+
+	printf("Found partition '%s' at partition number %d\n", part_name, ret);
+	return ret;
+}
+
+/**
+ * spl_mmc_boot_mode() - Determine the boot mode for MMC
+ * @mmc:	Pointer to the MMC device
+ * @boot_device:	Boot device ID
+ *
+ * Return: MMCSD_MODE_RAW to use raw partition access
+ */
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	return MMCSD_MODE_RAW;
+}
+
+/**
+ * spl_mmc_boot_partition() - Determine which partition to boot from
+ * @boot_device:	Boot device ID
+ *
+ * Return: Partition number to boot from, or default partition on error
+ */
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	int ret;
+	struct disk_partition info;
+
+	ret = spl_find_partition_info(UCLASS_MMC, 0, QCOM_SPL_FIT_IMG_PARTITION, &info);
+#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION)
+	if (ret < 0) {
+		printf("Using default MMC partition %d\n",
+		       CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION);
+		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
+	}
+#endif
+	return ret;
+}
+
+/**
+ * spl_mmc_get_uboot_raw_sector() - Find the raw sector offset
+ * @mmc:	Pointer to the MMC device
+ * @raw_sect:	Sector
+ *
+ * Return: 0 if the image is at the starting of the partition without any offset.
+ */
+unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
+{
+	return 0;
+}
+#endif /* CONFIG_IS_ENABLED(MMC) */

-- 
2.34.1

