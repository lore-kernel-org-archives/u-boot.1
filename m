Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29599C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 05:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B9F808B6;
	Wed, 26 Mar 2025 06:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="dlpgiOWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD84809D0; Wed, 26 Mar 2025 06:47:18 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02BB8070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 06:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q5hPs3028896;
 Wed, 26 Mar 2025 05:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=E+qShZ/AX8Imx0WGkW5uvR
 Jq/Ejt8mGq+pbVUjvjrjA=; b=dlpgiOWKtJNFKajTGISoo/Uc3sWpv8EC72/3Qg
 yhXthmrLqYUSyDLyfhOrgXaGMGpTl5dLlI2TlEVBTDimGwfnbVy4XDoKusKQ9DXz
 Oqk+g6eaA0H+cyAzeBkIA6gaN/kBAB5OcxrL/l4ibO5FCLBJiEmCmEphH0k29COK
 HQd4XLe+fAuTCfpWedSmWKOvHOn2sm90EjXDRY2pAR/EtQN2n4GsBDsph2GYkKZV
 vrAFpSVLOPlzz7eyGMBEoAtWxDuZAPDTa+cErQl9fIPmxeYXg9nMPROu4P6X4+DW
 6AcxKt59UMwS2qlIAuWqKF/whyMXZ95KrYSCKsgsWr/4TZcA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hmhka24t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 05:47:10 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52Q5l9Lf001927
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 05:47:09 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Mar 2025 22:47:06 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <ilias.apalodimas@linaro.org>,
 <EABachinin@salutedevices.com>, <jerome.forissier@linaro.org>,
 <rasmus.villemoes@prevas.dk>, <ansuelsmth@gmail.com>,
 <sughosh.ganu@linaro.org>, <michal.simek@amd.com>, <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
Date: Wed, 26 Mar 2025 11:16:53 +0530
Message-ID: <20250326054653.273906-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=C4PpyRP+ c=1 sm=1 tr=0 ts=67e394de cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=D2C4Bs5ayCVkSRN6XJwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DETQSpwcN4xIF0S23kNIO-xKzdRbAo6-
X-Proofpoint-ORIG-GUID: DETQSpwcN4xIF0S23kNIO-xKzdRbAo6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=609 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260032
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

If the EFI runtime services pointers are relocated even though
relocation is skipped, it corrupts some other data resulting in some
unexpected behaviour.

In this specific case, it overwrote some page table entries resulting in
the device memory address range's mappings getting removed. Eventually,
after the completion of efi_runtime_relocate(), when a driver tries to
access its device's registers it crashes since the mappings are absent.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 common/board_r.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/board_r.c b/common/board_r.c
index 179259b00de..1dd3b96c2de 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
 	 */
 	efi_save_gd();
 
-	efi_runtime_relocate(gd->relocaddr, NULL);
+	if (!(gd->flags & GD_FLG_SKIP_RELOC))
+		efi_runtime_relocate(gd->relocaddr, NULL);
 #endif
 
 	return 0;

base-commit: 244e61fbb7f5045e4e187024f7ae80434c952145
-- 
2.34.1

