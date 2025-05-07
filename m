Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC5CC369DC
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 07:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9878210D;
	Wed,  7 May 2025 09:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="A66LcA4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E50598210D; Wed,  7 May 2025 09:08:13 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F6B8007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 09:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471Gt5N021533;
 Wed, 7 May 2025 07:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nFDgnVsiPP04XRhe13PmjBU4gQpXRS0LJuyYikXjmUc=; b=A66LcA4c2lE9Ll+e
 e0GHXxc8PL1tkM1nKg2Qs2krYdqfRcuIpLRCM8/vFsNw/dzNhabAxMxCU0BuSnXg
 MzDklEjD/OX4HyUjtEYGjYvu/ibbba/Dwk9S7j0VtJwTT1y7KYVapHlTenVLIZUd
 Jes94udxIWkyq4LQ9pdyVpGpmdEeUepaWkmvg7jIGl5AyfswjMPj3QlQTJXrpwvN
 sUHeZ5dtvk9Z0UNkmRLUAZ97CRytNrxTxnU5HaEOVrHwFCUIpKIrIT0aqKZEVEmy
 pWNB3sjBCNvgX8V765U+FThQ8PnQWNONg6ITjNCpHNHI4LMnd53t8uRaSQ4rOdLu
 5P1nUw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fdwtuhmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 07:08:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 547784C4007173
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 07:08:04 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 00:07:59 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <clamor95@gmail.com>, <robert.marko@sartura.hr>, <me@samcday.com>,
 <sjg@chromium.org>, <marek.vasut+renesas@mailbox.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
CC: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v3 3/3] configs: qcs9100_defconfig: Enable SYSRESET
Date: Wed, 7 May 2025 12:37:33 +0530
Message-ID: <20250507070733.2871986-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507070733.2871986-1-quic_varada@quicinc.com>
References: <20250507070733.2871986-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=VPPdn8PX c=1 sm=1 tr=0 ts=681b06d4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gmEqoM0KDesFiAEcSG0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0e5zsV4R3ITOPFarBpNTYrHPklOqLvxL
X-Proofpoint-ORIG-GUID: 0e5zsV4R3ITOPFarBpNTYrHPklOqLvxL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA2NSBTYWx0ZWRfX1UcE1U/4T74P
 b22zoImQLk/ZToHXOC8LYdIdCEyVwFp1RB7eBPns3GeG9jAqoI9COPS9LJQLFtJaEGzC3NuJjOT
 zB9BUlfQxGNygAFc0oZMj0OpqOQVlQf0d2yN7vm4VZY9OssMIdNliscu6vfBWBvdl769DaOmcxc
 A1Iq8JYYHWZXXoHDUygvxdkLrW7CU9AoG+veDMJSlULDiGZrBezTSEExNWUwexdZRF02f9pvKnA
 1XfOaUxEFGYxeOwAeLvva39qRYMGdYVapQJNPHC5ix19z61Md85PilsEfP+NBCE8fmzS1BVfmve
 nsQaxpUbdlk2IxbRqV/cBXlMG8Q0ABC0G1qxZnP54oK4x7d/Pkp/RJZCe1J3fqg6b60m+u7rW8y
 M47gZRLy8gQGFFh88yCNWHWdhe5th9qPpxyAjczD1y31E1vpXJe/AXYNQpUcsoUFnrIBdq+5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=856 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070065
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

Move to SYSRESET for implementing the reset command.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add 'Reviewed-by: Sumit Garg'
---
 configs/qcs9100_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 10ff4d25398..1fb621b27ce 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -16,3 +16,5 @@ CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_QCOM_PSCI=y
-- 
2.34.1

