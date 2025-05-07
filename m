Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2606AC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 11:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC718214B;
	Wed,  7 May 2025 13:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="foqMmZ4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11488219D; Wed,  7 May 2025 13:29:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 261968283E
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5474XhT3013075;
 Wed, 7 May 2025 11:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LMCLV1THVUw3wgAzrEVnfngwijvqZN/PQv2YsST3Y1Y=; b=foqMmZ4YCD3A4qh1
 Jki1rCK4EzfHHPqdpU9GKFPUTb1GkTcC5V0dgi94RoDna83JvqDCcfvQNKIci3ek
 nEVMQdBVOxnfIWBXWx8oXwfYGLOJU5Cfth3tA/DiDQrIpZRsudfUPGn9gIId9bIP
 mMXTBm8qSEA8gJkh4oydimWwOM63BZIhtCPXwdWsCEqCgcrWbUO8Po57kBGag6J2
 UQUzvr99TH9C5ESlxYlj5N0LIdfxIDeHePnCwU6myePGgQ5IPTgfmlSszUBPGqQ+
 umRFTSHCDdUb3u3lhIUAlm9E0/lgl1zk4WFSBQq23Hiy3rzNYtQfj9HrX1dNs9vp
 uH1toQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46g0kh13ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 11:28:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 547BSmPT012077
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 11:28:48 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 04:28:43 -0700
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
Subject: [PATCH v3 2/4] scsi: Implement get_blk() function
Date: Wed, 7 May 2025 16:58:10 +0530
Message-ID: <20250507112812.3066301-3-quic_varada@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwNyBTYWx0ZWRfXwXtDNPMf2Y8f
 GpN6nWDskNK46AXD56I/rrsB/qIRGKE3HIdDgZRSJv722NrldXldojZAVT+SRqlPYrlVeFJKMo/
 ued4QhwhxhhT6t+AziOqSG16/5u1JaakuzCHMLpoooL8iMux6Fm97bb/egPVKphJz7nJXc4+pP7
 cTOPa64b0PmlTY6ZPz89ilnNOQg71o+6smyNGQHm2m66Kptbo5HBL60NZiSJfwchD2F7MGp5p9W
 y2zCAif460lEwTzfFMtGC9KP3cYywOtgDk3YquNnaZ57mLdkWBb05IgkLGrswNfgNTa2jhuKGSr
 iXWfqMQUPuhRnqmbooU91EVrFI3VOWgNJgpxEnAQtZP6ZxKtOhK00QYnKqcc33J031lj08OLrJi
 yvDc0O9QYC3LuB+Z+yulsRSFvaGWsiRwHa47SOPmHeJvQFcbKwp8lcsUXt54P1CsV4uuf1sq
X-Authority-Analysis: v=2.4 cv=PNUP+eqC c=1 sm=1 tr=0 ts=681b43f1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=KeAuS3ePNnYHWw_nrfAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: G_SFHBp_HEZO6XrUjx6KcybCPAzNiMWv
X-Proofpoint-GUID: G_SFHBp_HEZO6XrUjx6KcybCPAzNiMWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
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

