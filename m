Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D61D148AF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 06:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F0283BA1;
	Thu,  8 Jan 2026 07:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N4AR/Tvf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iiJABp83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3C083BA1; Thu,  8 Jan 2026 07:50:06 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EACA783C04
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 07:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6084RaQW2453884
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 06:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t2zXM/Y9GUZ
 NAxwIpqZ4jxN45uyzEyNVU5v1HSmaxOE=; b=N4AR/TvfN/L7yPZimUtat6GZWG1
 cVHnzGlEP8BXjxvdzYyMOQziGW5DPFrwt0pjhTi2oOIkoTbLIKxN8Vu9Tlh4Ff6X
 9xYdWLkRckyQOkQ+CLXTJIowjHU6iRQ6thxdK/MvPvqNLra/DsGRcv4kl9Bk6Om6
 pNA6CrKk5gcSnUaDeMFotKgLhEPlDSKCNpmm1TpH7CipVUA9uhMHuSCE7Hws1p6g
 3BuVr2UPJn1iLF4tZykC32SpRHcN2q3mzGKccdZhGRB6bzxmINoHv7/rWsqLtmjA
 baARKWiXfhNdjw5kpmAya5bWvx6vsHqCnclWKkhIPGTGbDoxIOh3gV67IzA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhmnbkpdp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:50:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b9b9e8b0812so4886659a12.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 22:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767855001; x=1768459801; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t2zXM/Y9GUZNAxwIpqZ4jxN45uyzEyNVU5v1HSmaxOE=;
 b=iiJABp83ODHbC+l+oweTBB6NEDhIix8lQLX2XYF/HQ3f8zcLRZDGX1EqVB/mSM81mA
 Yq+22psYiDkOdeFrQilgVylT1P6wcro/WhSzZsEcvC5B/0wM4XUjSWbcMXVMqqgCeVsW
 8ODIi1pxZqapyGmiTqK2fgjuuoG0jUN6y7CAhA8wYT0Qe/y53p72mQlVj3iHaekTxudh
 0uYvPRimMbSnoea65ZfeWC+Me3Da3UFrI8GaZkvWw9m44f3mUrZPWyf22tW92wcqkpow
 DpM1M5giHfclkZM8fgdbgQUsmqFUireVw709VfLAQqVWPNf69KZJ4wAb/dTXpGZrsU0T
 NIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767855001; x=1768459801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t2zXM/Y9GUZNAxwIpqZ4jxN45uyzEyNVU5v1HSmaxOE=;
 b=hMnZCwecaTE6vzhiSFKar6YRh+7892XzO5IOvPaCCNthl95oucntYh/RJ/TeXLZ7BT
 TdDQH0u/oFMXf8fL88F8Fa2j+YLr4AhSoAP3ntnooE6gkrMtqF1AqsEE47wT7B2HB2OI
 tP+1hyPxeYWdBLJwv6lFjK91yCrbX//QVWIZUJ7sc5V3QPpqadlglbiI3SDyvRbjPxoz
 LtTsVRoamk3ky449bTE3HcehwBV0lg4MoS31odSSYRoliAohP8sqVXE/9VE+gVW81Jk2
 oXJ5KpW6KMPZFk3yH47bJE/bkHVPbB83eYfeD/WtyMdR03ucmBPiU92xgAJ6jx+JDBXM
 I/+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtf8po2F4XRdEf1Ps4A3yHwGR++YvyeH80JQvPCsjvjhqA16a7WpixexXgCQP0dIlD/T/to8w=@lists.denx.de
X-Gm-Message-State: AOJu0YyBSYmw+Gjy8VSEBwY1ILndlQYCwyNoVJOaO7TlZiruOhs2wZIo
 H/6Nho7ggdtjb9QJK6q1F8IGIebz5omQ3u2J/HhjMcsuCsPOrfWeVp+f+RXNX3XFmTMMTlnKFGd
 NM46cRmG6DB456jh3gyUK+MNl+zWjEYFBcne8bXIgMr7hxV/bZKI+R5it
X-Gm-Gg: AY/fxX6vuM2+9TFrUduAf/3FyE/jnZ5xE+/FS219rroooEldi9yUm7X2n3ampbTTUUZ
 Q3gmK83UwPchNJsiOX5EJ6m0hGlfbLiiQA37gPGNA5sitGJ9zodA071q8+syd5xUI1IpvPSMqD/
 fjgy6Cs6GPenraafF+Mj2WU3oiAZUUI2MI9sRrPb3ft3EA5+jOwlcgXkjaP3zImA0FHAG0JpqeM
 JUzPBTa65guc1LtXCZgCmbr1agHid2XUbCUvI4IkFFB9g5HFa7IyZ1limv5JYsPeLLjo5DchZoa
 IYz0vsmCHiB9k2+hyUmqhTuJQWbkeB/D+ixcpEbcDzRkl02OHeSCwr7ng97zbOuR2pXbs7RKa1t
 cthkDb5+U9zFonsaZNcHDVnxvYukjKrPfpLhx+cV81drevS3RDpr8xdeSKhlAJ2Tq+O8TXMT/jH
 0NwfaaclnMe1jSHxtSjpBfHqSRc+uLVNsTOqyCPw==
X-Received: by 2002:a05:6a20:3956:b0:35d:cc9a:8bbb with SMTP id
 adf61e73a8af0-3898f992296mr4770980637.47.1767855001271; 
 Wed, 07 Jan 2026 22:50:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLjRafBeSy5Xtnec6kIOkIGTBM7EyBc+8Kz+c4m5z46zGpnFcqCbspNRm+OMFEaOeqXPX17Q==
X-Received: by 2002:a05:6a20:3956:b0:35d:cc9a:8bbb with SMTP id
 adf61e73a8af0-3898f992296mr4770944637.47.1767855000723; 
 Wed, 07 Jan 2026 22:50:00 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28faa9sm6918641a12.2.2026.01.07.22.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 22:50:00 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, joe.hershberger@ni.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 quentin.schulz@cherry.de, ravi@prevas.dk, javier.tia@linaro.org,
 quic_varada@quicinc.com, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, ansuelsmth@gmail.com, mwalle@kernel.org,
 anshuld@ti.com, jan.kiszka@siemens.com, javierm@redhat.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 1/4] disk: Add partition lookup by type GUID functionality
Date: Thu,  8 Jan 2026 12:19:44 +0530
Message-Id: <20260108064947.3237361-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0MyBTYWx0ZWRfXz2r5u1lZ/aVL
 ykeT+FLVexFFftZAGYHlCvqgW0dyg2dcKnIStbSRDY/dC32Hrk9gHPw4CbpW+fT+q96sXll63ns
 lS69L2B9xlQXH3+AcMGkz8by0a4dkP8haWDrMst/tRnK7KpVUykmVx+1QcS0Bz4AbAa+6y1KhSe
 SMDAlokQfLyiqj4/1toVKhXrrdXgKwsn9RvhuCeS4NlYz8slgSWEdsfYE95AvT2fAEAvlSfAN4+
 uMS8ZCrbbwyoweFzSx2s5yA3OfBpzzH0+V1DBFEnb64HaeVTuIFf9UAuaijv32aL66qBPtx5QL+
 vrfYLpgXEBRwyvCDMbW/J1FJzZYjeajJGGutl4G90LTUD+XSiUwY+CC5U+0LDUrV5mNGefqP3Qt
 uIaa5VQ9sm5u2OcO0LKR2kJIyyn0/eFxeQse6N+i9AuDkN4x4gaKkDWDzlgGRrF+TiiepZ9vRR1
 odN2PUdIuqLgyDw9thQ==
X-Proofpoint-GUID: 1TXt7ZNVcQQm1o2PAuVhQdQKJ4878cd1
X-Authority-Analysis: v=2.4 cv=eIkeTXp1 c=1 sm=1 tr=0 ts=695f539a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=itu2Iq6Ne14rHqsave4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 1TXt7ZNVcQQm1o2PAuVhQdQKJ4878cd1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080043
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

Introduce part_get_info_by_type_guid() function to enable partition
lookup using partition type GUID. This complements the existing UUID
lookup functionality and provides more flexible partition discovery
mechanisms.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 disk/part.c    | 39 +++++++++++++++++++++++++++++++++++++++
 include/part.h | 21 +++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 49a0fca6b89..2bc21dd66cc 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -731,6 +731,45 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	return -ENOENT;
 }
 
+int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
+			       struct disk_partition *info)
+{
+	struct part_driver *part_drv;
+	int ret;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
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
+		if (!strncasecmp(type_guid, disk_partition_type_guid(info), UUID_STR_LEN)) {
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
index daebbbc2e68..85457618cdf 100644
--- a/include/part.h
+++ b/include/part.h
@@ -327,6 +327,20 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 			  struct disk_partition *info);
 
+/**
+ * part_get_info_by_type_guid() - Search for a partition by type GUID
+ *                                among all available registered partitions
+ *
+ * @desc:	block device descriptor
+ * @type_guid:	the specified partition type GUID
+ * @info:	the disk partition info
+ *
+ * Return: the partition number on match (starting on 1), -ENOENT on no match,
+ * otherwise error
+ */
+int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
+			       struct disk_partition *info);
+
 /**
  * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
  *					    and part name, or dev number and
@@ -404,6 +418,13 @@ static inline int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	return -ENOENT;
 }
 
+static inline int part_get_info_by_type_guid(struct blk_desc *desc,
+					     const char *type_guid,
+					     struct disk_partition *info)
+{
+	return -ENOENT;
+}
+
 static inline int
 part_get_info_by_dev_and_name_or_num(const char *dev_iface,
 				     const char *dev_part_str,
-- 
2.34.1

