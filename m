Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BAEC3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 11:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D968216C;
	Wed,  7 May 2025 13:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="PJ/BDqvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704938059D; Wed,  7 May 2025 13:29:12 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25EF98215B
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5479iu4U002391;
 Wed, 7 May 2025 11:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nb+vmDeUOHc4qH6AYKJdPue1fNHwdJWkpSsRHClAw5Q=; b=PJ/BDqvyrakX8Urw
 WdWhoq8bsgs6SxMRvqTKYfKvOsJIBYYgr14zignXyCzy+wdWGJpGYvSwfHAltrdt
 fJlBbqJFmuu2XCM17mCO94+2N4sNew9+Mt9e25jqMCd/SSVWtND69kFaK9oUaya8
 0BRK+I4Ldge031NL326vsdRhJBm0PAt6HCjk5p6mgv19zhtubQf5uFVmsXDkpx8X
 X4tYGP+JlnyKyNN1vHicYkMvvTPb5wz18YmlQzRKdcK2rt9/mmTJo0Txt0UqtKNP
 3WukWSCxdLvw2XXG2HCUmYgEedJtp5SZcWdq69NY5hu/PSJeulhUxlk50u0XtCKn
 nG/lww==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fsmt2202-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 11:28:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 547BShhT016752
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 11:28:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 04:28:38 -0700
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
Subject: [PATCH v3 1/4] disk: part: implement generic function
 part_get_info_by_uuid()
Date: Wed, 7 May 2025 16:58:09 +0530
Message-ID: <20250507112812.3066301-2-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=U9KSDfru c=1 sm=1 tr=0 ts=681b43ec cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=qZvHFhWwEWTLZn7k4qkA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: i13YeOPQcLl8uthBrYG2087--vqadDX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwNyBTYWx0ZWRfX3McgAUqkQLex
 +0jYS6wIv8yb6L7uYd4pGPXi5t8BlzN0cdB7EX1EtbAd4XPUOD+YNw1MW07bT+gRkL2ve/kdgjL
 nyAixnmS85Q1zdQBteo0/rRYn+mdyjxqW+UTbs05+ZtbftyeePGfywEZ21w+p+kybIAfaJ8Yq/t
 w2KZ1wVLcQxF1rq8LwctkDqBdSt4gW9VSmv0j50DcXQMi8STUhV4diuM+hqiyxaI1W+jaGN6fWJ
 MCoK3bqpKhQtUgf8ngyr8jDDqKMmc04FqO+olN6v+Nn92k6KvbLhlh4cBS/rq+30neS08T7MdQw
 Ajn5S9fGIAEz/n6ddUzqAoOMsvapx5DvySmPwdIwyZN+5Yd1kOtbbXdIvLO/jqapXnBqUrSefcL
 HnEfJ0ZnGarE85DjlTGa4mNQNSeXpYiS+g5avGVFCuPmyELUFVnnoveUVAP95ATmBwLUF/cu
X-Proofpoint-ORIG-GUID: i13YeOPQcLl8uthBrYG2087--vqadDX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070107
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

