Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1C7C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD70182162;
	Tue,  6 May 2025 09:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="nT1C22oG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E3F8214F; Tue,  6 May 2025 09:25:35 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53126820E8
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545M8O3a026063;
 Tue, 6 May 2025 07:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nb+vmDeUOHc4qH6AYKJdPue1fNHwdJWkpSsRHClAw5Q=; b=nT1C22oGf9Pq2rT0
 V+7+6qg7qbYYFxBJZ1zt2dL4KhmhBCeSBTEWb5jxzS3SDrNUeEPsmct7xIxkn50T
 bqBY0pEP5Om4RqfxMr3jri6bg7K5umXlkf6d+vk8jqxlrQPdK5rAhv3bFqUnugan
 s0xQ25wWKz2xewudxWPifjUk7sozbr3Tu29Lhk6PiYPpirTRSTo2CabX7Dufuxqq
 e/zcyD7LlLFU1O8HE1jBmFb01Xh602izsDpydMhmcTWMbzzAMjPiLAyztnrJqzPI
 maaXUhxM6MOhGcTTGM6EWcM7yhDrXjdnSf9b+xv+j6aXX6OC1WisXgAjQdNcnCBv
 zdVEoQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5uusa6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 07:25:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5467P8I1009369
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 6 May 2025 07:25:08 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 May 2025 00:24:59 -0700
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
Subject: [PATCH v2 1/4] disk: part: implement generic function
 part_get_info_by_uuid()
Date: Tue, 6 May 2025 12:54:12 +0530
Message-ID: <20250506072415.1970069-2-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=6819b955 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=qZvHFhWwEWTLZn7k4qkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -wpTwdHljuaaB-wKMNzpH3NLpq0XReGs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2OSBTYWx0ZWRfXzxwZBSPDrb0E
 eARPGtNZXBiNDUTtcZpsdeMgao8F9CxmytpQiYBJ8S7EWRgTEuZzcVU9K9A3yketSF/Lfjb4ctP
 KWUxU7ZiwWVB0YDgquh/f/tsh+d2PZDQWAB2vFWERtZSkWquUiXpPji0pqqgEYIwpUdsy8gpFK0
 ab0baPaCBMmy/pZiWzuSosxBYYY1HoJYvONKsefGGXLcXhCSzbMOOGKHO9bVulkuaW/lDKuxYbq
 gJ+D0xbPhXlibeLwublPnk4c+aK5kifhFu5qhNKEeU0/P8R+zIOFg+hDFy1zNmdDgsAGhyl0SPs
 O+bo6r/1gTtN5IogEJL+B0fTbc8tFXILxF3adZs6s78rCQmrtg/7rPxmIDVOhJpN4NmjFqFq71L
 XoLGvi6E8CFb+YfL0+wWrh2r4QB4QqRUGaFA2KheqdDviNI+ZWBlgsseJfmxhg3u9msnXepL
X-Proofpoint-ORIG-GUID: -wpTwdHljuaaB-wKMNzpH3NLpq0XReGs
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

Add function to search for a partition by UUID as partition
names may not be unique.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/part.h | 20 ++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 303178161c0..abae79a55a7 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -698,6 +698,43 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 	return -ENOENT;
 }
 
+int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
+			  struct disk_partition *info)
+{
+#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
+	struct part_driver *part_drv;
+	int ret;
+	int i;
+
+	part_drv = part_driver_lookup_type(desc);
+	if (!part_drv)
+		return -1;
+
+	if (!part_drv->get_info) {
+		log_debug("## Driver %s does not have the get_info() method\n",
+			  part_drv->name);
+		return -ENOSYS;
+	}
+
+	for (i = 1; i < part_drv->max_entries; i++) {
+		ret = part_drv->get_info(desc, i, info);
+		if (ret != 0) {
+			/*
+			 * Partition with this index can't be obtained, but
+			 * further partitions might be, so keep checking.
+			 */
+			continue;
+		}
+
+		if (!strncasecmp(uuid, disk_partition_uuid(info), UUID_STR_LEN)) {
+			/* matched */
+			return i;
+		}
+	}
+#endif
+	return -ENOENT;
+}
+
 /**
  * Get partition info from device number and partition name.
  *
diff --git a/include/part.h b/include/part.h
index fcb3c13dea4..3e6eb0ec33f 100644
--- a/include/part.h
+++ b/include/part.h
@@ -315,6 +315,20 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 int part_get_info_by_name(struct blk_desc *desc, const char *name,
 			  struct disk_partition *info);
 
+/**
+ * part_get_info_by_uuid() - Search for a partition by uuid
+ *                           among all available registered partitions
+ *
+ * @desc:	block device descriptor
+ * @uuid:	the specified table entry uuid
+ * @info:	the disk partition info
+ *
+ * Return: the partition number on match (starting on 1), -ENOENT on no match,
+ * otherwise error
+ */
+int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
+			  struct disk_partition *info);
+
 /**
  * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
  *					    and part name, or dev number and
@@ -386,6 +400,12 @@ static inline int part_get_info_by_name(struct blk_desc *desc, const char *name,
 	return -ENOENT;
 }
 
+static inline int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
+					struct disk_partition *info)
+{
+	return -ENOENT;
+}
+
 static inline int
 part_get_info_by_dev_and_name_or_num(const char *dev_iface,
 				     const char *dev_part_str,
-- 
2.34.1

