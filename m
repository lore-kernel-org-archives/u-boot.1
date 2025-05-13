Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6B6C3ABD7
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBFBD81DD6;
	Tue, 13 May 2025 11:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="jqBYwHI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7698381DD6; Tue, 13 May 2025 11:18:58 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20748800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D91qXA012064;
 Tue, 13 May 2025 09:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rw9zFR2+9Z8OdB5WclhKEVOJcMJOu33vMqp0i98+R9w=; b=jqBYwHI7TeFhU3d3
 4uLLaolRsM+k9FjU3e7slf+H3hXK14meAfUpWgCbCztH8pIfV4HeDcRTN9v83EMs
 9LOuk6+wSoo7Qm4KQE3S2eA9Bs6p+kU+ayOQvBfJ1GNknXIbcfiIl2q91BMV+nvd
 1jccZ69FGFT+5CayJ8OzPutYZKSN0/SOaeMrGDcLg0/GDCDH/CV56aP22qPE3KfU
 6NDwZG65KikpFxDOdmBXiO21iboqQpXep84WgLbQjODfJityvZJyetJNQR/cgM9p
 mg30zpoZjpVK7ywvZwuqv6kYT9PmWvf+Bh76sOvwczTcQXYhhhSs28JtjIEphoB+
 WOKcAg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46kc3mv11y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 09:18:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54D9IScU018548
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 09:18:28 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 13 May 2025 02:18:23 -0700
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
Subject: [PATCH v4 1/5] disk: part: implement generic function
 part_get_info_by_uuid()
Date: Tue, 13 May 2025 14:47:06 +0530
Message-ID: <20250513091710.3719292-2-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -ByvhmfVs1bDK_uxU4lnrz3NDzvMypmw
X-Proofpoint-GUID: -ByvhmfVs1bDK_uxU4lnrz3NDzvMypmw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4OCBTYWx0ZWRfX+FGuS/edV4/r
 G+KcBTRGHzD5nxNyfQE9L0+jBcNgey4rcxX/1nhsD/HiQZcBXRrKHH21lFE1aqp9kjdLhz0DC5L
 AFCsBqCSoHKHS6S1+ElkLdBGF839OCnxU39AhqtHPHQ3jZMS4iaeFFnOhr96BmNZYuNON108OJ9
 Vfk6yOMimFmoHh+YoaWfyHhGmLVYy5tZe8WfTF/0IHSNsV8BuZhdjFh/4onI0wuNKGQZCL8tJud
 4nOv0g/d8A/l9CzHDQYKRI8ulSG1h5VrRwexkKkZIqsZTJa7katkyMjnyxsQY+gV1xCHy5oHW9Z
 N0Ki9k/vH9HgzHXY3m0IRHvZUOiVdIuYr9Sgpuwy9TlKlGBOeNM5DCnV+FOsM/YYm5BtD79YXY8
 5iFlSRYgKQNApG+zy+uy3S6eGmKO1o2uwjWGZ/L7eh2saQEa2P/wLtL12WMVmtiPPQuQptYw
X-Authority-Analysis: v=2.4 cv=afhhnQot c=1 sm=1 tr=0 ts=68230e64 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=E-TnPL4q6OkJPdRbN5YA:9
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

Add function to search for a partition by UUID as partition
names may not be unique.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: Use if (!CONFIG_IS_ENABLED(PARTITION_UUIDS)) instead of '#if'

    Not breaking from the for loop if '->get_info()' returns non-zero
    to have similar behaviour as in part_get_info_by_name().
---
 disk/part.c    | 39 +++++++++++++++++++++++++++++++++++++++
 include/part.h | 20 ++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 303178161c0..8eefda39d7b 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -698,6 +698,45 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 	return -ENOENT;
 }
 
+int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
+			  struct disk_partition *info)
+{
+	struct part_driver *part_drv;
+	int ret;
+	int i;
+
+	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
+		return -ENOENT;
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
+
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

