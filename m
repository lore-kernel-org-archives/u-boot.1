Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AB8E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 07:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B5B800C2;
	Fri, 10 Jan 2025 08:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="H8An9q3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9736801F5; Fri, 10 Jan 2025 08:43:30 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8453A80017
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A0rSbQ006374;
 Fri, 10 Jan 2025 07:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=PxwdafiPSHLToJYQvDQcR3
 4dCWHwdQwws/nX4eC+KU0=; b=H8An9q3/63+vUWjoCJI1uk0yaXYMoosKU9vt5F
 RXlxC2B+qRLx1hvazpVwPbpWNkT4h+XYhwIXiR11aMTcBlg21uIft9ASc/0K3UId
 LDJgHw5n/PVXUZhjG08UxF7+yH3eDx57gtcCmkdmTIxFB2SVLLSjeCdMaOLSKaT/
 6qwJaN/24SOM+pyYdvkcUWmz1Q1yF6MAdoEfIwaLlC9QTqcMTGyKnWKd1EQBR5NS
 r6r6d/q0Mn687HdZxx6xRZlObDRmhxBUO6VbCU1xfODr0Mh8zQJPhXc8F5sZAIaQ
 noNcWKuXQkSmt7IarIhqWbRGqalxjzfPwjoXsMPW7s5txRuQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442sd90t89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 07:43:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A7hMPb022645
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 07:43:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 23:43:19 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <marex@denx.de>, <trini@konsulko.com>, <mkorpershoek@baylibre.com>,
 <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1] usb: dwc3: core: Fix timeout check
Date: Fri, 10 Jan 2025 13:13:06 +0530
Message-ID: <20250110074306.3897847-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: yj5DwZ24WK_b3VWxWSJl3_y0f4MYLacg
X-Proofpoint-ORIG-GUID: yj5DwZ24WK_b3VWxWSJl3_y0f4MYLacg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=931 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100062
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

dwc3_core_init loops 'timeout' times to check if the IP block is out
of reset using 'while (timeout--)'. If there is some issue and
the block doesn't come out of reset, the loop will run till
'timeout' becomes zero and the post decrement operator would set
timeout to 0xffffffff. Though the IP block is not out reset, the
subsequent if check 'if !timeout' would fail as timeout is not
equal to zero and the function proceeds with the initialization.

Make this a pre decrement to address this.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a35b8c2f64..8f58e4ea2d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -612,7 +612,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* issue device SoftReset too */
 	timeout = 5000;
 	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	while (timeout--) {
+	while (--timeout) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		if (!(reg & DWC3_DCTL_CSFTRST))
 			break;
-- 
2.34.1

