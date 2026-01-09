Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347BFD232E8
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 07:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2331284314;
	Fri,  9 Jan 2026 08:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvmyTKWS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hq0WHw0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E369C84248; Fri,  9 Jan 2026 08:09:37 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB638430C
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 08:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 608MplZP3220044
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 07:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9dpxhfBYyws
 j0whQC0lL+mP6l2gvpmCu+KxYXrhIgDc=; b=JvmyTKWSy86rrbpdu6txBcvCRY3
 EIddolwY68XTezaPlxL0V4tT68Zg2CpvLuqI7K7C5+XioLvdHXYS4on0bSn0GxtC
 gYEvwIEwuCi+Hb93sDZuSsCfONMQ5a1QrqpZwMzq+ocSn+n6NhdPIRJLqZYKzyNG
 PBZz9tvxVqLhh73rgmdDLTfvLfptbkl9K4Sxkp9Vqat+wx2dZZUQ3mQS2/V/CDM+
 ad+1VQlTu/xtiXs1ioAB6izySZ1/FPgAQTrflmkY7lf56RZf4vmot0bsOHPkyu+d
 1TJAGE7cPwyPPd9uhaUO+P2L5JOWtAngLSBQcvxQfrokhJxAXmmt04m2Uew==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjt0hj9j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:09:33 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7f21951c317so2958091b3a.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 23:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767942573; x=1768547373; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9dpxhfBYywsj0whQC0lL+mP6l2gvpmCu+KxYXrhIgDc=;
 b=Hq0WHw0KLn/Syi0CqBSXUwO+Ea1TwihuwgBdLk59lf+1lWVxKq5tFKmo0Rhtl49RSv
 /+iokr4/7YVrRcSEPv0Suy4pD5XAuMZTn6cSM/raX0slpJ/GD9i21oXOtNc/1fl2zRZA
 p/lyq/D9EK345XmE2mP/YAA4zALIJf3caFYjauDHWHE4gbSeCGm5tnh1Coby8J7bIvuP
 uRzXoLjYUEX18mE7bfsyxgGF1pEVTFDv9bXhwAJ444U6s0OjDGiIzY64/JdSnTpOvDD9
 dDn3c2Qu0aLZlTxKrp/n41kmCZH+5wUOgJU5Y7MZ6/rBVC5rZr2hrO9taItb5aojXfhe
 CcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942573; x=1768547373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9dpxhfBYywsj0whQC0lL+mP6l2gvpmCu+KxYXrhIgDc=;
 b=vNp/wbi5xEKUmMr0DfG++zSNYLuwXUOt7tDfpwyW1E8kyl5xKJI79yVOFqjpnEKYLJ
 ATipDLs1LdG8GhoJj4jefb+zTOcJycWwGH+DXlN0BRKKUgSZ5TKENRUTxGyK28O+A+GD
 ngO4a9UHEe6Pf3nJnUYX2ylf8yZQQzEGFVVF6WzCZ6KFS9vLJ3RZTl1gZik39u0WshDF
 Hjrr+8NeFbo7a6gp8AELJdcYf/hso1CqdABDYI150rPCYJdOSsnfSd6sbUzX+lrE3xBY
 x9r7sVOWrELcNURdpVyNUYKDiwbI7p1HN4QrB9sfJFxl4lvMSLlij/lWtVRYUGb7nuz+
 zHQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu37Hf1S+0UiBc3svJZC+Zd5zQN2lngWbTkYG+mgTQnl34NQTLt0N/WMLSuo9X9VVbkUXvnfg=@lists.denx.de
X-Gm-Message-State: AOJu0YwY2GUlxfOJ79ET6ruQiFdPcgVkFVr1+/TLnDQTna+vbUXxEUWJ
 uHuemKwMAk0jG5SZvekZxfmCSwRZXSSI3MJY6vpsmXPvCYjTupsAY0je9owZ9WIllcB3O7oCFsk
 JOxWIiKfGGs5SsEvl0h2o7uULvUFAs4QVc2ubQoQQojCF+OvZ1tOE87mi
X-Gm-Gg: AY/fxX5DeDF0Fd6sjpWnoqLfrIV36zwDq4f8wNGiqjZs70sRiWmnrwiQEwajxrcAytJ
 mKOfd/5Ye3dBsgDiFTaUBPmJ2oDtBKgxvBH/1IvQ2EY//iD8VlGBEuVXjN0SnVu2IPXKvx8aDJw
 CKMElmshGnbaH65pTOEsetIVyIdpkpGLd+GR5TeOkcwSWcJsi57mtT4zty6h2OdvG7tf2NGgpb8
 33ueF9XlFaAjgMqR/6hbAxgspObly+CVKuTgifHZLbsUmdx3DzbI14hONcTKu4zz/9PEOXBaQat
 12VZRGm/NRwK0zcfVnMkyE4m0s+lmii2BCC8Qv8L+CbJzDlWg9pvlk6nynPxqLB7qIs+ChiXs/l
 cD1Tq3wx/rIRHulumpCyE7iWE9DRiwxAhKGtTiYRlubDViODQFf4l8HBEUkDyxaeKCjJVGN1/PJ
 wz181dQgd7tZYp5ZexYbwjWLJhWibvW91O2YKtNQ==
X-Received: by 2002:a05:6a00:340a:b0:7f7:26fe:c92f with SMTP id
 d2e1a72fcca58-81b7dd5f1d9mr8338270b3a.29.1767942572936; 
 Thu, 08 Jan 2026 23:09:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+VZr3sfu+RHm42HDCcOD9SXm+FyvBxSLOXByIZyHJoucbKzInFb6kc382P7ZYzhWW0AG0EQ==
X-Received: by 2002:a05:6a00:340a:b0:7f7:26fe:c92f with SMTP id
 d2e1a72fcca58-81b7dd5f1d9mr8338234b3a.29.1767942572387; 
 Thu, 08 Jan 2026 23:09:32 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bb4c85bfsm9471943b3a.30.2026.01.08.23.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:09:32 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 ravi@prevas.dk, quic_varada@quicinc.com, quentin.schulz@cherry.de,
 javier.tia@linaro.org, simon.glass@canonical.com,
 marek.vasut+renesas@mailbox.org, ansuelsmth@gmail.com,
 michal.simek@amd.com, mwalle@kernel.org, jan.kiszka@siemens.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 2/4] scsi: Add partition lookup by type GUID for SCSI
 devices
Date: Fri,  9 Jan 2026 12:39:10 +0530
Message-Id: <20260109070912.4106466-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W9O2trA6WMhwTKBkRIIc0h0yvTGMXyxr
X-Authority-Analysis: v=2.4 cv=VJzQXtPX c=1 sm=1 tr=0 ts=6960a9ad cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8 a=4Z9OGKtuVjyKH-hDXNMA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: W9O2trA6WMhwTKBkRIIc0h0yvTGMXyxr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0NyBTYWx0ZWRfX2VzzZoKv9Tlk
 TDu6be7we1EtGRfm7fawOi8Ujeo6FlBFSuS+mTKhrJp8LXY5eQuh4PhhqBCGxC6qBFO2eysjKDr
 gJgqJ0DKfjdGKcL+FWf2FtuOCgi8Gh8afmIZOk1FCmHMZlFhGOnDCexKwqPj+L2gtA1qFJsvMDC
 a5NY6nEMnpk63TfKa/yxQE7OmGa7svLKzHKnXBd6fthjO3pKrB35bXKTuoU8C88+NItouIkpYVL
 31giZQhNDBeBzgjdD4IGWYKVLzCmT9RbnuKdeK3P7MX/Z+IL5mwFEEaC0pI9lROubfqExeLIqLx
 lD4w5UtAcbSUg+sJu/uuZQg+dCmlwhREJSdObWrcchnsyUZqX35GenF8xbYY21/depZLpU0Lx1V
 a3X2eZE/fK2cVZo+nUiVq+J3+v8QVASHoJxNH90cAflBta6xRCuvuv1ibe+aTwFIRY8UA/PPs19
 iurugxLU2xw/ba/SOMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090047
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

Introduce scsi_get_blk_by_type_guid() function to enable SCSI
partition discovery using partition type GUID. This function scans
all available SCSI devices and searches for a partition matching the
specified type GUID.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
Changes in v2:
- Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()

 drivers/scsi/scsi-uclass.c | 34 ++++++++++++++++++++++++++++++++--
 include/scsi.h             | 11 +++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 3eb6069649f..2a8ee3b045a 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -31,14 +31,15 @@ int scsi_get_blk_by_uuid(const char *uuid,
 {
 	static int is_scsi_scanned;
 	struct blk_desc *blk;
-	int i, ret;
+	int i, ret, max;
 
 	if (!is_scsi_scanned) {
 		scsi_scan(false /* no verbose */);
 		is_scsi_scanned = 1;
 	}
 
-	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
+	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
+	for (i = 0; i < max; i++) {
 		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
 		if (ret)
 			continue;
@@ -53,6 +54,35 @@ int scsi_get_blk_by_uuid(const char *uuid,
 	return -1;
 }
 
+int scsi_get_blk_by_type_guid(const char *type_guid,
+			      struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr)
+{
+	static int is_scsi_scanned;
+	struct blk_desc *blk;
+	int i, ret, max;
+
+	if (!is_scsi_scanned) {
+		scsi_scan(false /* no verbose */);
+		is_scsi_scanned = 1;
+	}
+
+	max = blk_find_max_devnum(UCLASS_SCSI) + 1;
+	for (i = 0; i < max; i++) {
+		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
+		if (ret)
+			continue;
+
+		ret = part_get_info_by_type_guid(blk, type_guid, part_info_ptr);
+		if (ret > 0) {
+			*blk_desc_ptr = blk;
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
 int scsi_bus_reset(struct udevice *dev)
 {
 	struct scsi_ops *ops = scsi_get_ops(dev);
diff --git a/include/scsi.h b/include/scsi.h
index 8d6c5116419..e0b2f869057 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -361,6 +361,17 @@ int scsi_scan_dev(struct udevice *dev, bool verbose);
 int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
 			 struct disk_partition *part_info_ptr);
 
+
+/**
+ * scsi_get_blk_by_type_guid() - Provides SCSI partition information by type GUID.
+ *
+ * @type_guid:		Type GUID of the partition for fetching its info
+ * @blk_desc_ptr:	Provides the blk descriptor
+ * @part_info_ptr:	Provides partition info
+ */
+int scsi_get_blk_by_type_guid(const char *type_guid, struct blk_desc **blk_desc_ptr,
+			      struct disk_partition *part_info_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */
-- 
2.34.1

