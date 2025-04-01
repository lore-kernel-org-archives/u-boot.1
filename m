Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5826EC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 10:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3ACF81FE8;
	Tue,  1 Apr 2025 12:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="YmWvbsFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10ADF82040; Tue,  1 Apr 2025 12:10:26 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26AB8006D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5317MmEr024628;
 Tue, 1 Apr 2025 10:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Fpb3PLUTOe2tanvwTaOhdj
 Ndi/jIGwJwEAU7hE+nNG4=; b=YmWvbsFeZAHZciOGMrhY+rWoJY4D07wk/2bJsS
 nuZDbwgBVvA6Zw/peQzx1mfO7l9a1/Fr6Gxhm3+s16J8//eIRiPKjqjveWO6jTxQ
 xJo6QBw7FP4I3PBaCBvnRcBHY+Lpnc6PpQ4C1i5e4ZxaQM7O6GcU9N+dw5lLPpPV
 MfQ8lxlMe+pALe8qDzylj0k2z4G95CgkKjxyzwk0X4pH3uLOwdFvcUICFonyA1Wj
 +807qmAxgmqPk7jvkDLzGV6R/U1VcaTdrAQMZ0uqcihGSWXtRKcUpUQrtl7DRNvk
 uXTCTdoXUHvtqocdy885ZyxOXyJCj+bqD4hjLyKZFEwZYKuA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpyrns3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 10:10:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 531AAFac016480
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Apr 2025 10:10:15 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Apr 2025 03:10:12 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <quic_varada@quicinc.com>,
 <marek.vasut+renesas@mailbox.org>, <neil.armstrong@linaro.org>,
 <lehmanju@devpi.de>, <u-boot@lists.denx.de>
Subject: [PATCH v2 1/2] dm: blk: Add 'erase' generic block device commands
Date: Tue, 1 Apr 2025 15:39:58 +0530
Message-ID: <20250401100959.1571297-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: G1sMa4z2lSidV_eK72YrP-6w6B4CCpY9
X-Proofpoint-ORIG-GUID: G1sMa4z2lSidV_eK72YrP-6w6B4CCpY9
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ebbb88 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=io0mJjz8_dNIwVIYenAA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010065
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

Add support for doing 'erase' using the generic block commands
framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 cmd/blk_common.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/cmd/blk_common.c b/cmd/blk_common.c
index 4c05a4e0610..56529702a47 100644
--- a/cmd/blk_common.c
+++ b/cmd/blk_common.c
@@ -107,6 +107,23 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 			printf("%ld blocks written: %s\n", n,
 			       n == cnt ? "OK" : "ERROR");
 			return n == cnt ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
+		} else if (strcmp(argv[1], "erase") == 0) {
+			lbaint_t blk = hextoul(argv[2], NULL);
+			ulong cnt = hextoul(argv[3], NULL);
+			struct blk_desc *desc;
+			ulong n;
+
+			printf("\n%s erase: device %d block # "LBAFU", count %lu ... ",
+			       if_name, *cur_devnump, blk, cnt);
+
+			if (blk_get_desc(uclass_id, *cur_devnump, &desc))
+				return CMD_RET_FAILURE;
+
+			n = blk_derase(desc, blk, cnt);
+
+			printf("%ld blocks erased: %s\n", n,
+			       n == cnt ? "OK" : "ERROR");
+			return n == cnt ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
 		} else {
 			return CMD_RET_USAGE;
 		}

base-commit: c17f03a7e93dfbbe5d32f5738274187065d9493f
-- 
2.34.1

