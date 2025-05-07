Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC420C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 11:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915A582952;
	Wed,  7 May 2025 13:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="jE1A/IqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2E98059D; Wed,  7 May 2025 13:29:23 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA6C828B3
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471H9l2018448;
 Wed, 7 May 2025 11:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6dZJX0/oV+WQiq6e7CGUJ9KrddPfvsAIqRd2/rJ5FRY=; b=jE1A/IqW0Kx/AEZQ
 fM0wtKQ6KO8V64sY3WiIxVLLU8ov+dlECorS8vZACXc8zv6mSvNFgGMFxPWpPGKr
 JBhi8T1FKiwnLV+aUjffwa+JEie5bVFArdSmNyisLurDow7plbnJJwtpEktYdafa
 8Bo5+gsuuzuOSS3Yp+ShiRqnHO3DiBjabphEEraiaxovh7ieUelY7639nw4H+gCH
 fvgcAF6nFstVIWr0Nlzoeyyuzo654gbWtYJfDxm5xgnVqLkOYnfh68XNPRNGCYSs
 7XR1mCvgJ1pQ0MTHM7Z2mYsibrSVkTyT5rN5Kjb0LJDlyiwB9+4QGNHAQqcAff7m
 qul8uw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5tbdgae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 11:29:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 547BSxYv017896
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 11:28:59 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 04:28:54 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>,
 <hs@denx.de>, <sjg@chromium.org>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <xypron.glpk@gmx.de>,
 <cniedermaier@dh-electronics.com>, <ansuelsmth@gmail.com>,
 <venkatesh.abbarapu@amd.com>, <ilias.apalodimas@linaro.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v3 4/4] configs: qcs9100: Enable env in SCSI
Date: Wed, 7 May 2025 16:58:12 +0530
Message-ID: <20250507112812.3066301-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507112812.3066301-1-quic_varada@quicinc.com>
References: <20250507112812.3066301-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: UqLwF2prtjJW8L4yP2hjJveWF6EO7XL8
X-Proofpoint-GUID: UqLwF2prtjJW8L4yP2hjJveWF6EO7XL8
X-Authority-Analysis: v=2.4 cv=doXbC0g4 c=1 sm=1 tr=0 ts=681b43fc cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=1vbZ9Er4auZhERsSQ9EA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwNyBTYWx0ZWRfXzic3vl4e+djh
 flHAVYDfPf6qIV42TqbQZjAzYgU5jVZRPGmZo2WHwly+qGn1CcAdCqklhOPy2SHE04UZgzYIwAH
 hyBFDXX8q9VXp0kzvs+v9+bV/R2anJx/DimApkVMGTkzSulBdNqqEfPIoXaRAY3PU74tlIbX6qu
 qYurfEKLrfPZPr0lzjQk9vW3W8GL7Kkcdft93XP3tvV29r5bFmF52N4GQCszx9/QhlTMgF3e2dP
 pEu2T3vOUNZQ6CgIP7fZh9t5XlRgC+o1sFyZa45ijK5Sm2MuFujBUVs31EkdNqdPxiAAXWX1rPc
 932RvULAQjsm7ROtxjgZkVC+MqhBWj5VmJTHXJe3mqeyhNvjksSUSSFlsZcdAczAQxsGxYglena
 /tAoi1ZitV65Z/TDzVqszaLIwtQJdqUJH9qqLKzl1c7dTokNLifqERgyp6syvEZSTzHfpGyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=797 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070107
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

Enable CONFIG_ENV_IS_IN_SCSI to store environment variables in SCSI.
Set env variables partition UUID as seen in qcs9100 based boards.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: s/CONFIG_SCSI_ENV_PART/CONFIG_SCSI_ENV_PART_UUID
---
 configs/qcs9100_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 10ff4d25398..cd48973599b 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -14,5 +14,8 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
-
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
+CONFIG_ENV_IS_IN_SCSI=y
+CONFIG_SCSI_ENV_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
+# CONFIG_ENV_IS_DEFAULT is not set
+# CONFIG_ENV_IS_NOWHERE is not set
-- 
2.34.1

