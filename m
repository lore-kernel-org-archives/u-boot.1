Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB9FD232E8
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 07:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9088419D;
	Fri,  9 Jan 2026 08:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pVu28F02";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aC+5fKH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7CE8423D; Fri,  9 Jan 2026 08:09:33 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507D58419D
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 08:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6096ETPw3019530
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 07:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6zzL/hsJm0f
 E9YDtvFQmiQCE5551HQL4pmTi5p4Tx68=; b=pVu28F02H/XGNcQRerjWaxoFc1B
 W7FSoZCFIyY2c548gwbmhQze+JkjgYTEd1nZK/31YZJMrOpEnVsnSFrBnXMx4BW2
 2Qq8eLmFWEbx+Y6e8r0ex6QPKBG65+QsOIgTRWGtUFn0zLfsNWbyOm86nzwjj8Wa
 c7y4Q7tbP5hVaSji7PWj4Z/MiLVZ+HCwRCvGfaRzNhMClFXMMy6M2U4tJpkuqSD7
 x8CaiyhRIzv3ipdnX9QTzaGBfL5YxKqC3vA/5WNyEDorOiLIazGhhrebG/e1zS/y
 2fLeEahNj/HSFqBtxsI7yJWyzQpaYrnrRYi8LAh8L3EZxAksJr4TJrUMGwg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjk3hpfx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:09:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7b6b194cf71so4471695b3a.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 23:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767942568; x=1768547368; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6zzL/hsJm0fE9YDtvFQmiQCE5551HQL4pmTi5p4Tx68=;
 b=aC+5fKH1aww+8PS0DIByNnDCrqDArBZvwvJkcJi/A5AsoCmLErqzGtYCcw8GDaIvoI
 Bf03p2L/f3dBTcMv9zQfKL1N0kJPb3bd9E0h6jfngQbcVjx2on2Uv48pbVSCSmh2/XmB
 XszUCQ8MVml81nHgI41WRbhVziuRM+cna7lAyfDEthTqYphhFeJ9euaY4OsBd0OiZ3OE
 7mgFAHQy+RFLX/yNDZ/dWX6uk32dkwFea35hXa3aikRMSuySy1Vh6tY58Dtv2oZCnmmA
 DmxWPnbdDOc4csaQ/wBERv9KFZFtOhuhnlu4cWG01IPE94wshHDrWkObGJ4DeBT/wvN0
 qQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767942568; x=1768547368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6zzL/hsJm0fE9YDtvFQmiQCE5551HQL4pmTi5p4Tx68=;
 b=asL1DOopKqCu+J9zOcRi7HBJZAGOjo/L8ZBLpUhGnzKFjRwmSMuFymemCCDOTGxGso
 UhuL9TBMsTiFmkC0p2f4KzE3Yis5C4HyTgJisXoEURxeGTRjsLM/l3Z7/rpBFvZ0aGzZ
 f/YIGkxhUL59iiKt6plpCteOd1g+vpXJS4UJDHOxhnGecAsOVTnpYn26NhGgeTvPkYxy
 1ciGNU3vrfZVQIzIBSJSV/fXcJctmLuMEERLAVm2Anfj39ZJ8D91KuyowzBHw6Uk5K3b
 eLpUMxXGsfeAEdO9yooGzzZesqz7RQqz0bGx9AwNoo+lPmL6PGe0Zi8nPOLVQNRfPyYZ
 a0XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUQKjmipHfSgP7mfonutunmzRhCcpSke6xolXufT+EnLu4P62Yvplc7mSoe0n6WPPzlp9vxNs=@lists.denx.de
X-Gm-Message-State: AOJu0YxgjizyMY+j6XdqqZ4K8KssyQpRSLk8uHTlPy8yrREx1GVGC3U3
 Fs32mP8Wt/mhrxtvj4ou57ScjuXDL9nn6aWt5tEZ7CRvb62xnrBO3VF+qmORPj60br6TfgBdyWp
 6WJYJq47K3fee/xW6Ipm0f63fu8uy6IWBOlRgGs7kJyzQ05HwWejv4Vpt
X-Gm-Gg: AY/fxX4yiskzrU2cdl6IcDpiWfNooi/8lsaS16V5BUixS7Td0SBm3GEafZ5Mk3X1gMd
 vX2Gh7opvTQ4pmxNXT4kqrA6hg6TmeLZHAweO4XYov6Hj1RjY0lgJ4i6bYR+jc9fVAQBdnx20HX
 kF8/uNqI8UQ+s4psdgyu6RkKH7N0y5KcDKNLfDpre9K1Y73PjnJi4dFHUe1kvk2WGpl+ONjmYxs
 5+U9bSu3JIamQ8+fcfLRGnw7PyLx8Y3MFMsvVszC7Av3SnkNK0Z5+wTPssOG/h4DshZG+tSdrIm
 qvi0dlJkA9KwdqLzVyCB9GfXBJPZwZpKAf/Sic0iCEVpb+QOaYr1tCONW6XZvwGinfMadaguGoz
 fbXFcJSXoxESFMHCYAxn5YPbeiK89efsGk21JMhSQNX0DfEasAz8gM5eLQphjBVA7zoyuXBaSbZ
 jEmeQ37TLE8v/Yxfmye4mV2+s+QbuKfJYrq0cK7g==
X-Received: by 2002:a05:6a00:f9a:b0:7ff:c265:32e7 with SMTP id
 d2e1a72fcca58-81b7e1585a0mr7827656b3a.30.1767942567651; 
 Thu, 08 Jan 2026 23:09:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk96P1Z5q2K1ym1WJ+7iyjEqAQCZ42BlcgBsZto5fH1YnXorBJgldBrc3tmonfe5yASC8ltA==
X-Received: by 2002:a05:6a00:f9a:b0:7ff:c265:32e7 with SMTP id
 d2e1a72fcca58-81b7e1585a0mr7827630b3a.30.1767942567106; 
 Thu, 08 Jan 2026 23:09:27 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bb4c85bfsm9471943b3a.30.2026.01.08.23.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:09:26 -0800 (PST)
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
Subject: [PATCH v2 1/4] disk: Add partition lookup by type GUID functionality
Date: Fri,  9 Jan 2026 12:39:09 +0530
Message-Id: <20260109070912.4106466-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3kdLkgwpoeTk7gZGrN8yTl0gHaMkumoo
X-Authority-Analysis: v=2.4 cv=EazFgfmC c=1 sm=1 tr=0 ts=6960a9a8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=CY1rhmfJiPzWGrbW8pEA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 3kdLkgwpoeTk7gZGrN8yTl0gHaMkumoo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA0NyBTYWx0ZWRfX6RkTI2/99gXu
 1BcYqE5wlx5Sv2WhYNyT5Gy+nMBX+jfSKV6IDYBm+NaEof8pdRWz+qmvAwVlDNogvRlr/7A6S/h
 npJGX1FDWPweGSXZ52Ve+Rsrz6KYSSGv0zw2/966MYqerA/5dI8jjBtQGcrfl+361bQuZn+O8h1
 JXEwbHAyzHeMRnxDH3v8fYDAqXYqRkm73w5ngSwj4zD1d1naPMslIgaOa+u5exDV3pcVQFiNdLA
 nAynRHAHtA+sSpdi8GJ5kM2YKEg4sDYsJK2Ppk2AEBrWe3Sus+rS4OKAnn4WQCX5gyeSc6/Pq8Z
 e+UWbwsulGa+Wj3jFUlXH2VCYxuSwj3nzw/1N5QcjfY+nlRG1otTxkd+29IZTgn3qNeobR6dKG/
 45S8yQ6NHXGZqpjlRTibzGsc5peFiXQVkP/Vg+OZ2RjBNp4RjO+eCUddx0sXy2TYD7exoIMpJ5P
 VP3kMjd0q2DXf8yzGPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090047
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
Changes in v2:
- No changes

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

