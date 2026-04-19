Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00DDEA7194
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 10:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0CA8425F;
	Sun, 19 Apr 2026 12:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iof7hAHH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qfe+4nh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834ED839D9; Sun, 19 Apr 2026 12:24:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C09839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 12:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63J9BFYb666626
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9lQlSzvzaw6yYePnqyIjySYiO3pwTvtRCF3nzG2qG9U=; b=Iof7hAHHOIdawqYA
 CGBuvi97hT4eQ0A5OKt9ysJesh5qn48daXK3QewGO7KdgKRfFrgHhkGXdNHaF5XE
 5Zia1FqA4N3aYY7JFLY2PrQXTB70lvR9SANZI+S8cndVDveG2F9byKNymWHiD8uR
 drK8/FdkHpYbspImZXW82odX/SQ+iLzHs7K5xGyEIp7aWilOx9YjiNv0fpVqOtxX
 kfPvkBdYOvZ1ErKjeqea9b/bz/mVq3pykYSTJmYMzJZaBS81F/W3ihvxiNY+LIVS
 miY/UPDhY3Mts29DTKDWOYoJgiYkFgrGfwq3rFZ4wUcWPYNpBfG9JT9czV0Qz3v7
 Vgjbew==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm21ujb3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 10:24:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24308165dso33089485ad.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776594264; x=1777199064; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9lQlSzvzaw6yYePnqyIjySYiO3pwTvtRCF3nzG2qG9U=;
 b=Qfe+4nh6p1Ni+8gebXNRAbT2KgiPAQ1QxYioIsrWpqTK+3G7/CFoNPpJu72jts38XD
 1w+swN8fxdc6Jsq9iEYQvYkI8x8IEwHyYaD+1GUx624ZhjjML+KQFv9gutcARALLohfa
 KqcC44gvxdVvPzydtxCJ2WP6PDrh4wfQd3wUZ04XLy/VIbhdG/UmZJYJKdfG+tskGTCK
 LVEvrAgan5TG6KoSN66sYjXwRU2SqskOQgHRoujluxYBlnWdLUKGzNBdgR6hWSomw7+4
 5SDlSjgSlKgVj1/lekPFwx9r1fWbgEiZgCicXzbzxH3FnBo+DjJnJ3kbJFPBzuk09C4W
 WONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776594264; x=1777199064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9lQlSzvzaw6yYePnqyIjySYiO3pwTvtRCF3nzG2qG9U=;
 b=kCA2+opkHBUcVLarXC0jIMrPqqaZkfh8LaXNItAvUVHX44VDOMM0Rc/71xbYnHiICK
 DzW7VH+w6AvooYQE2wnOh9I5fC2FsuOenWsKW/rr64NrTmR2esg/wF+CMnig+JIREnOw
 BWFYLoNbI0G12fIaOodSO1TN6CvcA1q/wqaWwR00oQ1XV52aHRMtJY3Tn4TmKToL90KL
 y79udcPjaPtS2CCai4p6lDMiBoNaqWKfxcMbGFBxioOXfG/5MnuD+NG/N/2idMf6m4KM
 dcWiVi2fGCnNDplDdMN4B0Q15CgW5gxBqDspGJgPiRfyaE7nfrAqK8bzXDzA6wFBRZl1
 YmIA==
X-Gm-Message-State: AOJu0YxhchXcYL+l9Pf2fnX6hDH64WbYvptNllDNrMz5MVXD3GtLyunA
 MFXoJVLB5ydV3aVTuHlrdWBa/41fjHYVzhp1J1BeBORtNISXrrc3+C4+JHTvJXI2EHS3hrFl3k3
 yPZ3q5bECsFmXvTqqz0LjlQaHBlKba92ITXD/tVwkaLkDxtJ4yrRAst/W
X-Gm-Gg: AeBDievCqEX7T+rBxdG7i+3q4DXi1CofIrn5xkJzqHniZY9TayQb57d9KFe3QUjvpL+
 V6snS8+6JYo24EfD6M03KGdqsQD/pZ+C6I5xNBkTb63Gr0a/c2LxSbWyMK3muI0I1IkLVcmzfEI
 aQo7T/S6UDJgKtxiDZ6UsI6PARvubxxfDINBvPS12c2cZJ2Bs8mgWmMoJ/fYCOeY7BD4+rnLY1w
 /N7NlHtNqBwTXHqac9IKBA1XGLIpIlepUmtiVFv7hwWl0Y8/smdXoBsIMwinmmpD692X0fIz+Li
 sdVWM6h6vWaOFjhTzrSiJeRMgsisXMxZ/Rm9r6jyeVzoCKFXQjkPln3H0Q/i+ho7kC1Bykyvq04
 LUOqS9GMky82AKj/01+ReG20pUTmY9wyjaeShBavPcJ4El5gzlGUNFRIpqwq+UJth6e1c4ZlyuV
 MWnQ9RO1747d0DIzAwtxlf5GX3ccmQx/YkiNbMZXWf6bgOZtXcangn03MrlJhd
X-Received: by 2002:a17:903:3c67:b0:2ae:8272:deb0 with SMTP id
 d9443c01a7336-2b5f9ebd04amr105024795ad.15.1776594263628; 
 Sun, 19 Apr 2026 03:24:23 -0700 (PDT)
X-Received: by 2002:a17:903:3c67:b0:2ae:8272:deb0 with SMTP id
 d9443c01a7336-2b5f9ebd04amr105024395ad.15.1776594263179; 
 Sun, 19 Apr 2026 03:24:23 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0caf1sm72754675ad.42.2026.04.19.03.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 03:24:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 19 Apr 2026 15:54:03 +0530
Subject: [PATCH v3 1/5] disk: Add partition lookup by type GUID functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-type-v3-1-ec49acd6870e@oss.qualcomm.com>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
In-Reply-To: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776594245; l=3158;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=K9Uz5A/dYsbW+QAAZG1CQ9/P/LbNVklDc8Xx1zR9kD8=;
 b=8+4TdvKt4Ks+E2JLf/G7wiRzhou9dJVVh7QxRVlNtmCWOE9hbmz8Nm4SBtyEe51MXZB3UIYq2
 HLGLz3ODMSTA4aPg/TgoKmUyKj8o6KONHemAn5Dg700eBDOQ2zCjJfC
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDEwOCBTYWx0ZWRfXxwoOdYvX5gpa
 25WCfI8f86S0dS93u3KBPuntwVhb5rmcmvO3R6SDOI/laGYIZRlFFVPDodGG/KAFitC9jxvPOPk
 WtFQLxJhllavVroV5mNfqp7Xs90/uLHb9xJsQ0/LH5tQM9z1hTo7QGNopng3Z5bw+Ovpyj7snCx
 6V1gLSXsYjpOujD1e5l3p9zQo94IwpuYZoDVH9GVbjBCd0Ox5NuIKPAx1PUxQTJi473mvwbSj3p
 Ipe7aMXb5uXr3tHTb80WgSqSRaO0AbvJ8fXmHfZPGQY0TNBnmXsXmGffT1krVvVNwmYWJfXbvqZ
 Soq2EEzz9s+WupGZ3TzpWqHzInKHSFnRQviLa22jcj1qkK1wt493QeeIYvX6cKjgqMuJfzbtL5C
 cRhz6QK21kLkNNK/+pXKm3KwLE+wTFD43R7JycEe+W8+EVWDYeUx+UUAetFzZBwW1yaolb8RpEv
 2bOVCR6BoJnYzTddVgg==
X-Proofpoint-GUID: f6QxD8EOxtNe0jLUcHN97tWipxkKNK3T
X-Proofpoint-ORIG-GUID: f6QxD8EOxtNe0jLUcHN97tWipxkKNK3T
X-Authority-Analysis: v=2.4 cv=WK1PmHsR c=1 sm=1 tr=0 ts=69e4ad58 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=CY1rhmfJiPzWGrbW8pEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190108
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
Changes in v3:
- Addressed minor corrections in part_get_info_by_type_guid function

Changes in v2:
- No changes
---
 disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/part.h | 21 +++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 4923dc44593..4cb3204ac6e 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -731,6 +731,43 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	return -ENOENT;
 }
 
+int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
+			       struct disk_partition *info)
+{
+	struct part_driver *part_drv;
+	int ret;
+	int i;
+
+	if (!CONFIG_IS_ENABLED(PARTITION_TYPE_GUID))
+		return -ENOENT;
+
+	part_drv = part_driver_lookup_type(desc);
+	if (!part_drv)
+		return -ENOENT;
+
+	for (i = 1; i <= part_drv->max_entries; i++) {
+		ret = part_driver_get_info(part_drv, desc, i, info);
+		if (ret) {
+			/* -ENOSYS means no ->get_info method. */
+			if (ret == -ENOSYS)
+				return ret;
+			/*
+			 * Partition with this index can't be obtained, but
+			 * further partitions might be, so keep checking.
+			 */
+			continue;
+		}
+
+		if (!strncasecmp(type_guid, disk_partition_type_guid(info),
+				 UUID_STR_LEN)) {
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
index 15daacd7faa..32614bd085b 100644
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

