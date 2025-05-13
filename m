Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4800EC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DD9182A0A;
	Tue, 13 May 2025 11:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="mTPKDuY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 100D7800C1; Tue, 13 May 2025 11:18:59 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D311482998
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D9Dena011768;
 Tue, 13 May 2025 09:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LMCLV1THVUw3wgAzrEVnfngwijvqZN/PQv2YsST3Y1Y=; b=mTPKDuY7xp+EmV72
 SmiwnstvsBDU7R1PdzxkunDe4E7Lfw+D9nll8bASbh63Kt85eUvmcc3LFzqeuZ3q
 Ovxl17pjl5k6HAQNCLPoAva9gD5nbLmoWp+gJegfGx5x2pu2cd+XhJ8oNEeuRglt
 h6g4PaY9gRnasF4k5PPNYoYK8x1hFXSjQemnNha+EnB75iAt5ErLoAzC3Uq4W1Zr
 fedzmZz3YNkd2AOCFnu02SMLud7ueGpCBmD9pWLHJfUXLdFppzg59LIXZSzKXVEz
 qHWXQN2T7p1Y3ncyOFqzKKigqat9beRgYezCO5fR36MFdSivmTGLNZN7+LolbXsV
 0jiL5g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46kc3mv129-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 09:18:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54D9IXQt018664
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 09:18:33 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 13 May 2025 02:18:28 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>,
 <sjg@chromium.org>, <hs@denx.de>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <venkatesh.abbarapu@amd.com>,
 <ansuelsmth@gmail.com>, <cniedermaier@dh-electronics.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v4 2/5] scsi: Implement get_blk() function
Date: Tue, 13 May 2025 14:47:07 +0530
Message-ID: <20250513091710.3719292-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513091710.3719292-1-quic_varada@quicinc.com>
References: <20250513091710.3719292-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: STHrIaYK4-C1vByE4r5Zh8JbCl-GP1yY
X-Proofpoint-GUID: STHrIaYK4-C1vByE4r5Zh8JbCl-GP1yY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4OCBTYWx0ZWRfX6SYLrf6/IMOM
 Xt8j3OgYhgwLHFuRqxpeKBGGAXadys4AZYlmhjKVd2Wy+poYKyNdoKSQnTIQg6iom73LmrSW/jS
 Nmfj+GwxPfKoozYXI9n7BPSbkxxSfiG0surchyC/uIwMMHzo/hfRc6oBmZNa7FTfd+Bx9pleoos
 zKxgROoLGY4wr9WM+uaq/rdWkiAvRy3zWLMsv7Xk47NjtNG4swKHLmrgQH9mL2ex26Yu8CxIFOB
 qnRriy7SAo61psB3AIGErn1C25d1wo1fMyeWQ3qQSo/U5+EhIivoI1nkCg6wsc8KoreX3HQ2RBc
 Q7gnPg+5ASkastEBK5jSMD5y9rq6xc1GjYlnBJm7h4UYxO0ZeM0aSypjHSDd3YFI6mgU8GvOHUt
 oUIRKyCMj4o9UOGwddJqSz1iitJ8ZS33GH+dwrL1jSU3Kez5XrHehvAFEndyFao1k76IADev
X-Authority-Analysis: v=2.4 cv=afhhnQot c=1 sm=1 tr=0 ts=68230e69 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=KeAuS3ePNnYHWw_nrfAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130088
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

Add a function to obtain the block device for SCSI.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: * s/scsi_get_blk/scsi_get_blk_by_uuid
    * s/partition_name/uuid
---
 drivers/scsi/scsi-uclass.c | 30 ++++++++++++++++++++++++++++++
 include/scsi.h             | 10 ++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 1ee8236c05c..3eb6069649f 100644
--- a/drivers/scsi/scsi-uclass.c
+++ b/drivers/scsi/scsi-uclass.c
@@ -10,7 +10,9 @@
 
 #define LOG_CATEGORY UCLASS_SCSI
 
+#include <blk.h>
 #include <dm.h>
+#include <part.h>
 #include <scsi.h>
 
 int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
@@ -23,6 +25,34 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
 	return ops->exec(dev, pccb);
 }
 
+int scsi_get_blk_by_uuid(const char *uuid,
+			 struct blk_desc **blk_desc_ptr,
+			 struct disk_partition *part_info_ptr)
+{
+	static int is_scsi_scanned;
+	struct blk_desc *blk;
+	int i, ret;
+
+	if (!is_scsi_scanned) {
+		scsi_scan(false /* no verbose */);
+		is_scsi_scanned = 1;
+	}
+
+	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
+		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
+		if (ret)
+			continue;
+
+		ret = part_get_info_by_uuid(blk, uuid, part_info_ptr);
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
index ab53b47b58f..8d6c5116419 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -351,6 +351,16 @@ int scsi_scan(bool verbose);
  */
 int scsi_scan_dev(struct udevice *dev, bool verbose);
 
+/**
+ * scsi_get_blk_by_uuid() - Provides SCSI partition information.
+ *
+ * @uuid:		UUID of the partition for fetching its info
+ * @blk_desc_ptr:	Provides the blk descriptor
+ * @part_info_ptr:	Provides partition info
+ */
+int scsi_get_blk_by_uuid(const char *uuid, struct blk_desc **blk_desc_ptr,
+			 struct disk_partition *part_info_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */
-- 
2.34.1

