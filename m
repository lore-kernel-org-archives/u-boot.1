Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE1CFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3BF8845D0;
	Tue, 28 Apr 2026 09:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXSvksbS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P2cnma6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6244284605; Tue, 28 Apr 2026 09:32:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2787E845E3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S4QuQK429010
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EMHs9dGo7q50WHTfnSkOil5H9d0gyQWGiE3Jy7YG/NY=; b=WXSvksbSOnTGeHen
 oG7RRhr7QkdGmVYeTqk3wdDr4261/rBjL7lSvfWiDOBOrhQUiuOliuSw0GB1qvkI
 aoFl115K7XKzQYRcu46JpekBtgsAQXWAWiclBhAkRlfqFCt3Mc3jY8zANjtvpVlb
 zYkPtS7Y7qBHF5pMlyqKpmMOdWp12dVkbsb0c+MSnf++T7sCxBXDiKJXPfdTJYOq
 eSZASAtThUpSVbE1d38MA53wcXnncx+NWT+YK+RhmDJCSI0LEsFYteGPlGi2vCCi
 JLvypsiq4TAvBnzUVosC9yxZurPvqeAsP7PRXRDGsBF456JhHVZf/tXo4tNrAmTX
 p8Pypg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7x33wxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:32:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c0234c1fso12283040a91.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361527; x=1777966327; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EMHs9dGo7q50WHTfnSkOil5H9d0gyQWGiE3Jy7YG/NY=;
 b=P2cnma6x70nchgrZ7l6kNHnLIitv8wMT0bN2kC4VbiO+TRwkxM3ZjihQbzFccYkLR6
 4q5Pbj43i5l/Mf9nAB5iMj4B8qvqZXAFZ18cdU2+gYjhoymOIbG/W7W9USg84DabNSis
 YJW+XLZ9iMhlCxsjkm3m3vENDJ5tshdiRT8d3IKmhMlItonmQkX7Kcxlb1ip0WRUR+pM
 VfYSSlWvjVOlKzzqm4vAzosaXIdgkYl3RZekiC/VF/jB6rXB4kjzXGxVSTlJary+Fp63
 iVkEQw6ciVKUavMjFEzU8JGBiup2RirE6Nc2A6oUdpvJ/YlUEfLIIZ2yBnwdOd1/LB0B
 th+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361527; x=1777966327;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EMHs9dGo7q50WHTfnSkOil5H9d0gyQWGiE3Jy7YG/NY=;
 b=WfeihZOSqU6Whk85yqg8WgwZHEBbUeeyBd1anFDVCm3vhkz3W0OLRWsUnS5Rg8Yukc
 DIlNO8iqVZiTZvu718/mhJCec0QqiNpVSPSvvIYOfMcDUETLlbY2d3kkl+/M+gKbt/QQ
 nUME03efBX+iRGQYhyVA7/vXr9jaNjmibYi2ArhA0wJU0wF00r9/SDOBNRb1d1dFpS3a
 q1n/jdlYVMgbcGJM35m020hpqBfSl6smTmzVGYRoVSB18rSVIOkPZ8GBS8Tb4+dkEs6l
 9XFtmmoKC1WIPVl+FQalgUY4iB/4MI6wUDM0mTOYil0wEs95UZqBmBzref4D1b65bpKg
 LaWw==
X-Gm-Message-State: AOJu0YxLzhQkVhdS3j6JWIYWCfcz9aj3hapc5Zhpk7c9qLuIWjx+FRmj
 9Ebd2mSnAv8AxdecXUeSYtR91JJNwwXXPol98tZs+zIJwHXA62oo/C6PtPY1oXv7GKfWa8z1SZH
 q96DTQhS5pihKBF3xnIBFiwsDElCOscF62GG8715HfY9Xby2Cn8LU4Gwq
X-Gm-Gg: AeBDievgYBHMT/FBA7CcZlJI7/YEHBZJvY584mykip2HybVGbxTYh0IMq7GCtvtnla5
 P+DyR4m4UfQSUdjd2Jt7zgRDtM05G+//Ewk5oUqQoAOOwx+J6P9kNxStnlGWbZ+APS8A35ymIsp
 WUFgP5mrocfWn+XDMOwF/m3s8EirH82RRP46XqaL2xvgXxQzwP0w6onX48o2alBIgNhWdoEPAso
 J/cTepY6e2lbg+Ks/+BDQIisGiGfBW0lFlVunz16/2JuFPW3ki5caxYjd1ZKqKb8p/WHV1IJkG7
 XZuOIrkx4KGXu42EEUbmtOFd6U8Kq9qh7dMIt0dsFAgmHdvl+ZfzHDY6Ctppe8rrIKQWMAMGtAK
 BoK5sP64O2XqxcQJFD3Cp3hB2LCC/S+wu5D7dEAiP8kdeIvpAC2iEVds1s61xQrWlsvUK26rMUw
 CQQlSnb8UvrvJ07l+RIPXBwPyVm5mmQBHNPI9ekADh/n3uOuydMruoOe+gdKvr
X-Received: by 2002:a17:90b:4fc8:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-36492011566mr2141057a91.18.1777361526490; 
 Tue, 28 Apr 2026 00:32:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc8:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-36492011566mr2141029a91.18.1777361525945; 
 Tue, 28 Apr 2026 00:32:05 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97aabaecfsm16054405ad.36.2026.04.28.00.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:32:05 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 13:01:43 +0530
Subject: [PATCH v4 1/8] disk: Add partition lookup by type GUID functionality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-type-v4-1-b7051dc45a88@oss.qualcomm.com>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
In-Reply-To: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777361510; l=3240;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Ml3/BpKYzZl7IrkwxBoCMg0MM0BfLTUaOJixh8OGOFM=;
 b=UkPKs3c8EyEtB85ROLO5Y14szsJ+XR7NG9wPSnOoYMrUqCfEJuxVsuK5pu3ZfW16SKzwpNh38
 GCDtkx0CafDCdC3VY0w3oe1LzIgu2lXbc9ahNJRF8P1pwzkSmfT+c2I
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfXze9WaKWTEDIh
 vHRE2fGDgLXff3IlFTZpifL8+r9MbHTJp5nTz7psu0cmuTkg8/bNHVQiSOa4f1YGt/dQeytszAm
 5jMHXEiAMPEkGm8r7Pm10Hnimd6XZdQObghed/uSfbXkg6KsprnwSBjnX0rylDxqSMpnfnzTMSo
 /3PG72xB7+5wimpYwillzmwHYVMknCH4Zm6d2jXzXfQhCjsdo1kwz8KUdo9fo1McpnaKZqC2Xh6
 0/KWEYLyLtFngmkZfulm4X3gQfd6HkL/ZUOHW4sLzaKvoqnQCUg9o76MPyu21TXyvMwWkEzj8b6
 O/dH39eTzfOSBWq/Ey/qIWuLPq2hRlV/BOlX9XpJbaygbKo5rzClVdwGfzq7c+WtSQ+DHka9bkN
 jpMYfvfw4v/R28L4btiS/LP2UF7NoBHVObWcabLD8IX5Hwn27w47nS98hqO5ITSKF5JcSNeeL2g
 wSXTWx6NYM5eb5MKeAQ==
X-Proofpoint-ORIG-GUID: aPwV-ZHQKUyH7zlOL-8zSg3b-Y4z1dc-
X-Authority-Analysis: v=2.4 cv=AJEsYPsu c=1 sm=1 tr=0 ts=69f06277 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=njE6j2fD9wNKUyOOxzIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: aPwV-ZHQKUyH7zlOL-8zSg3b-Y4z1dc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280069
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes

Changes in v3:
- Addressed minor corrections in part_get_info_by_type_guid function

Changes in v2:
- No changes
---
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

