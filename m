Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408ACC369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 08:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF7A82B37;
	Wed, 30 Apr 2025 10:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Jsm0MyE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167A682B53; Wed, 30 Apr 2025 10:55:07 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EF782B2F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLaLo6020908;
 Wed, 30 Apr 2025 08:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nFDgnVsiPP04XRhe13PmjBU4gQpXRS0LJuyYikXjmUc=; b=Jsm0MyE1xR2kHEz+
 bGJvIp2agIxbsU3FAMCs/OoCE+nY4fe/NA9kG+0w4t972HCKcCeuUOUoSaUTMm+8
 BXaGqS/EAyDQUmlLPGpXBnbABH0Jfy2KjAXAMaDp/btz+DLeYosOUwYkGoa686Xu
 BXX3u5MZoT0JAwxT9SqeOW1unwZiE+He5BH+DQJoBSlelU03AVs8rICaw+jXgpRa
 /hG15pKXa5iUGH/iuYrz3HlaudyN9/MH14H+8N4djbaE3AbuETOwS0O9avqiuXa3
 zx8lZflm2i5I23SYy/5g549CIlOOEpsAP/6i9bsWkPKEPoC0DowVwizFg4LXRhg4
 5JF4sw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u1sf8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 08:54:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53U8stW8019941
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 08:54:55 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Apr 2025 01:54:50 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <seashell11234455@gmail.com>, <clamor95@gmail.com>,
 <ycliang@andestech.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <sjg@chromium.org>, <marek.vasut+renesas@mailbox.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
CC: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 2/2] configs: qcs9100_defconfig: Enable SYSRESET
Date: Wed, 30 Apr 2025 14:24:28 +0530
Message-ID: <20250430085428.1090801-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085428.1090801-1-quic_varada@quicinc.com>
References: <20250430085428.1090801-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=G5AcE8k5 c=1 sm=1 tr=0 ts=6811e560 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gmEqoM0KDesFiAEcSG0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2MSBTYWx0ZWRfX9w6LQ57LTsx3
 EWSPRluKkzBski/6F2YdI1CTBwcpJPBlM8+5uO9gC3Abz87NssXH9PcMmv3VdlqJ79cJt1bgGki
 eG+posI9Siia6ggDULmVXb9t604k4UBlWQo1X8dV44GnadvdoZozM0qPjdTNqxxi52r2IMTjqWA
 LXEFgxzKA32Bj0klmzd5wocakZ17wRV51F7Tap4oREmmxykd6AK4u/m6VhNsewWbK/aSvNFn42a
 NuSQciQGrNaWnPc+qCUNjrMZznQeXW78b19ZAdpB5JPzzIS3S7cCprnxmo9V8016NbHHxnFI3pi
 6UkSJvtF3LaNCDvylyPkcDzR3FLYr5i1bCHg1sqrgOkMpaYoFSpgeWw/9RaXPYWYTIIShaGybBs
 3Udx2VPO73BzWyGESgI+JkAmn/pvlXZ8+9Qaj0UgwJh3dzX2LVGRYdiTDmZDH/JRcOaTg7u9
X-Proofpoint-GUID: 9I__6xjNZD6D4v8_-Bi4NNdTb2n3Bplv
X-Proofpoint-ORIG-GUID: 9I__6xjNZD6D4v8_-Bi4NNdTb2n3Bplv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=858
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300061
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

