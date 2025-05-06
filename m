Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98545C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C7F820E8;
	Tue,  6 May 2025 09:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="l5kWq5cg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD3A8214B; Tue,  6 May 2025 09:25:46 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F65182161
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545MBrv8007586;
 Tue, 6 May 2025 07:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E+D0rHAvokv9WyyZ26e+6YxnAA5BznuLuMSpNGEnyE4=; b=l5kWq5cgy47hmMgO
 ql6TV8QdiMg4/wRwfQOXztuDKenMOQzkGJ9obta58SKfX8+1cmxqiaM4sDEky4Tj
 kVM4PfMZwqwnx/2FB77NnHW/3Xdf7HZoZFj9q43vaEE/Cvz0TnUewbh3+a9HsRUu
 sTSn1be8BKWTZpEd5Fl/lNO1fZ/rgbDTI6m/O894fBiXzeFf8XLZEE22/bPRjeHi
 ZumZdAS6dYT8IevVFtPeB2cm0yLbmDL4Ndg6Fb2p9dxidlG/J5T3aryGHUy89aG2
 KXRJ8bWpHCVi8inLUbHX9yrob2aGALCrGIY869wFVb0LTLVNKiiX07Ta6uKUh6wo
 pDk/oQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5wg19uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 07:25:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5467PMRU023081
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 6 May 2025 07:25:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 May 2025 00:25:05 -0700
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
Subject: [PATCH v2 2/4] scsi: Implement get_blk() function
Date: Tue, 6 May 2025 12:54:13 +0530
Message-ID: <20250506072415.1970069-3-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8vU7_2jWPMT9oUVbYQzna8zqo_5i3FhT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2OSBTYWx0ZWRfX8i1itZJm0CMi
 e4Mkikhbkcnj891StKqJL88M0aT7zsvz1p2tAog+gzO9sK0DGZaG+YGuGgDUCCHPED7FLtjmpSq
 CCWZj5ZUk3rTFHVcGgXG+u/VJAGlHl+v2BnBSxt0ocKrI5big4ifSEeQyWBs4BWUMq/FKaZHP9k
 lvuo80kjpCSrVG0jUO9kvFa7piHEFemnEFAVL2cesHizs8onbe9MKynHZRNdHbIg6mEjQiwm9Lb
 MSs1igtsI7i8Ayxk04Xit6amSQnKE3u7btFLrS15yJIcNVbtIS10wjDTiTPPtZS78Wu44hTpJ9u
 BR1Al69vsgxtQ/7GPxiXowEMFjzPUi5x4ARwX5HalnHZ2Z8TP5eZopA8k2MOdkpjJrR9WezbrIE
 WeVZUCga7uEGHgPpks5tg0KsH3SVXhPD3Z5xN4BTM5rW9HIMKrMKqxG7Z9gFM6+l8KRMlpvE
X-Authority-Analysis: v=2.4 cv=dPemmPZb c=1 sm=1 tr=0 ts=6819b963 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=L4j60iIUqzj5HXxPrhYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8vU7_2jWPMT9oUVbYQzna8zqo_5i3FhT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
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

Add a function to obtain the block device for SCSI.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/scsi/scsi-uclass.c | 30 ++++++++++++++++++++++++++++++
 include/scsi.h             | 11 +++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
index 1ee8236c05c..aa037c8e353 100644
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
 
+int scsi_get_blk(const char *uuid,
+		 struct blk_desc **blk_desc_ptr,
+		 struct disk_partition *part_info_ptr)
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
index ab53b47b58f..d6b6e6b665f 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -351,6 +351,17 @@ int scsi_scan(bool verbose);
  */
 int scsi_scan_dev(struct udevice *dev, bool verbose);
 
+/**
+ * scsi_get_blk() - Provides SCSI partition information.
+ *
+ * @partition_name: Partition name for fetching its info
+ * @blk_desc_ptr:   Provides the blk descriptor
+ * @part_info_ptr:  Provides partition info
+ */
+int scsi_get_blk(const char *partition_name,
+		 struct blk_desc **blk_desc_ptr,
+		 struct disk_partition *part_info_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */
-- 
2.34.1

