Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33626C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 05:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926A282C8D;
	Fri, 13 Jun 2025 07:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="DK5GvHOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0096482CD2; Fri, 13 Jun 2025 07:20:53 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA8C782CA6
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CJq214031474;
 Fri, 13 Jun 2025 05:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nFDgnVsiPP04XRhe13PmjBU4gQpXRS0LJuyYikXjmUc=; b=DK5GvHOgftzJsOeB
 lktneY1J0sf5EgE5JxH7EG29uC//Lz/0AD0FJEo0g5iDVWFpwf033OLKx4nHkKk2
 vTupKjvtB1lIshnL4ZCMA54ZChrIFUXzecDqsGTLo0MT1Kavfa8v/Ls3Hf/7Y1iL
 SmxwmitovB19S8z8CoZ2eA22j9F2+jdN/RU40vShvKjazKee5/yHl7hhHVBIG+B8
 5H1+9npM+93CHDmnPfUUm1IVGgDYSVQCmNdxFGlOb9F0HA7uvfLYUeGfTnBCy0sK
 lboCpSR5OK5jR1TWT1rXbYoKKWGQMpL6RNLhG3hWF9IEiwW4ZPtuSlCWkLaViGQv
 cHrJMA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jdwv630-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55D5KgKf002565
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:42 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 22:20:37 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <jerome.forissier@linaro.org>,
 <sjg@chromium.org>, <patrick.rudolph@9elements.com>,
 <clamor95@gmail.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
CC: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v4 5/5] configs: qcs9100_defconfig: Enable SYSRESET
Date: Fri, 13 Jun 2025 10:49:57 +0530
Message-ID: <20250613051957.3159564-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613051957.3159564-1-quic_varada@quicinc.com>
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAzOCBTYWx0ZWRfX5oetfFv6qFXZ
 04YyMJ2Cba/mB4e89jbcNb5R2Dip0oCGWIKRi2QFv2BcrEl7ry3NXLj22ti8sTo+EmK7jYh3oLy
 +gOHi23c+mlH7ZKyNz1jjH5ZwZOoDMTel99yrtJA8qWFCp47TNkhzr3y0Xdi79GkggTSSg5ax+Y
 s8lDYFtDnxupl/viwbIrMNjYC1MW1ebdb49d4zxYx53NvZJElpJC0dz72GcumU4taj1FNh9XiJP
 x1qdM2ZghgYJTGFuvtClmtW1Za8ige8qK77FhWqdC2WR2v+b7LBEumOrflyfoUF5E2+JN7cLhBA
 H5sLQPjZXD+P7cIx5ohTXSRse055WsC7ZZ8l0VsBdbf+C8eZaBkoehz1k7HFczuxrDXNs/9lkfS
 343EdrX8PP+PEl/hVoZ/jXyZqvua2Ey62SI7aa0GqKAmgQpbyC4qkh3ZVsJjV5n4qD+hjDNB
X-Proofpoint-ORIG-GUID: QzC_KPAYJDyyPHNPWI3RY7tRrQcXfoc1
X-Proofpoint-GUID: QzC_KPAYJDyyPHNPWI3RY7tRrQcXfoc1
X-Authority-Analysis: v=2.4 cv=Jce8rVKV c=1 sm=1 tr=0 ts=684bb52b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=gmEqoM0KDesFiAEcSG0A:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxlogscore=860 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130038
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

