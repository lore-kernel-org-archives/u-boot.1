Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075DCC54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D1287EFA;
	Mon, 26 Feb 2024 13:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="izONCuCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE16087EAC; Mon, 26 Feb 2024 11:09:19 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E2787E9C
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q5etvh005466; Mon, 26 Feb 2024 10:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=6sja+KdV5NU3kO3EgsE3rpIDIp1yoX9k9BuPbEJwx/k=; b=iz
 ONCuCZL0gyBojHtGZwQ07OT+iXPMvdzZqsHE7QbdapgoQfzdHeZf8RWt25TyBZMo
 upCUVtv0BONn4N+wWpfiLJAShCRuU8QkfPnnZifLMS940BAWlCW1H9TRZpzAv4Pe
 AcZP73H8DiZ8cnrBH1gzrIOhvZr5MgwLMGvHyCbrm1ge1IpZeInWiq0C2+sKusay
 rXE6p6OZnWFBOGWHFlDdTIVN0tdOMXfXJPYDnKjQtYzUP5mRTcRuI4eT7byclGlS
 pcMZut/ZCHEqokh7GCTIhQSye/o2PZCgpa5OqEE7GBAvavXbCY7ARCI3mZN8MY/M
 TWgiolMGLuFjyxRN5xFQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxprjs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA9Bk5028529
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:11 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:09:08 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/10] mach-snapdragon: Update gd->ram_size in msm_fixup_memory
Date: Mon, 26 Feb 2024 15:38:02 +0530
Message-ID: <20240226100807.1095607-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226100807.1095607-1-quic_varada@quicinc.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: H0LIC2VHixHlI6-PJGE-l-IsVLCdw7Jp
X-Proofpoint-ORIG-GUID: H0LIC2VHixHlI6-PJGE-l-IsVLCdw7Jp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=699
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260076
X-Mailman-Approved-At: Mon, 26 Feb 2024 13:01:24 +0100
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

* gd->ram_size: msm_fixup_memory calculates the amount of memory
  present in the system. Update 'gd->ram_size' with the computed
  value.

* Update FDT only if 'blob' is not null

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---

 arch/arm/mach-snapdragon/dram.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index 499dfdf0da..08d681555d 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -74,10 +74,12 @@ int msm_fixup_memory(void *blob)
 		return -ENODEV;
 	}
 
+	gd->ram_size = 0;
 	/* Check validy of RAM */
 	for (i = 0; i < RAM_NUM_PART_ENTRIES; i++) {
 		p = &ram_ptable->parts[i];
 		if (p->category == CATEGORY_SDRAM && p->type == TYPE_SYSMEM) {
+			gd->ram_size += p->size;
 			bank_start[count] = p->start;
 			bank_size[count] = p->size;
 			debug("Detected memory bank %u: start: 0x%llx size: 0x%llx\n",
@@ -91,9 +93,9 @@ int msm_fixup_memory(void *blob)
 		return -ENODEV;
 	}
 
-	ret = fdt_fixup_memory_banks(blob, bank_start, bank_size, count);
-	if (ret)
-		return ret;
+	if (blob)
+		return fdt_fixup_memory_banks(blob, bank_start,
+					      bank_size, count);
 
-	return 0;
+	return ret;
 }
-- 
2.34.1

