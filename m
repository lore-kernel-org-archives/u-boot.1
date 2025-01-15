Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19D6C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 06:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D2880040;
	Wed, 15 Jan 2025 07:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Yy3go+3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10FB780214; Wed, 15 Jan 2025 07:21:30 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CDF580027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 07:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EMObMl016715;
 Wed, 15 Jan 2025 06:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iKKKzYG58VsfYxr1KBZ+Nh
 e5MtqQ7a+6b7hVrgsWrcU=; b=Yy3go+3DDxYnNtjrNZgzOb+ocmhiVnI5AZJ/e4
 45iCFHcBEvrGfatBeJ6Gl8sXe0Nk5ft4NYXcMRDpHw3SHlaTlrNwcxyTeIIUIiPH
 Vda9ZGBbAYl5S5pOVQn7Dj6KdI7WAyHQ1bygpht/O+1cuUTVAb4gC3R9c+/EaADd
 0P7M6bFlKdRA68QBdNIJaBdeKli34qy+Tj5RiP8D0YJmIPP8TW0A+opzyE7/KU9k
 SwCOcz2fXWLMt468Y50It/jm+a1Byp2XQVh/E1iTKGfqVRnY0NoBnHzWDy6iE8nn
 U7ZJmlwIRxAK7MfHQt2ZxGKgPeFe0aiYmmct5Q5kLljBxNhQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4460ps0wc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 06:21:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6LDFO032459
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 06:21:13 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 22:21:10 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <ni@konsulko.com>, <mkorpershoek@baylibre.com>,
 <caleb.connolly@linaro.org>, <quic_varada@quicinc.com>,
 <neil.armstrong@linaro.org>, <u-boot@lists.denx.de>
Subject: [PATCH v2] usb: dwc3: core: Fix timeout check
Date: Wed, 15 Jan 2025 11:50:44 +0530
Message-ID: <20250115062044.3834433-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3tMBNQ4dVKxNNgiQ-3Ftp9p5IsXYM4PK
X-Proofpoint-GUID: 3tMBNQ4dVKxNNgiQ-3Ftp9p5IsXYM4PK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150045
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

Use poll API instead to resolve this.

Tested-By: Varadarajan Narayanan <quic_varada@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: * Use poll API and remove the timeout variable based loop as
      suggested by 'Marek Vasut'
    * Drop 'Reviewed-by: Neil Armstrong' as the patch has taken
      a very different shape
---
 drivers/usb/dwc3/core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a35b8c2f64..847fa1f82c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/iopoll.h>
 #include <linux/ioport.h>
 #include <dm.h>
 #include <generic-phy.h>
@@ -587,7 +588,6 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
  */
 static int dwc3_core_init(struct dwc3 *dwc)
 {
-	unsigned long		timeout;
 	u32			hwparams4 = dwc->hwparams.hwparams4;
 	u32			reg;
 	int			ret;
@@ -610,15 +610,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	}
 
 	/* issue device SoftReset too */
-	timeout = 5000;
 	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	while (timeout--) {
-		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-		if (!(reg & DWC3_DCTL_CSFTRST))
-			break;
-	};
-
-	if (!timeout) {
+	ret = read_poll_timeout(dwc3_readl, reg,
+				!(reg & DWC3_DCTL_CSFTRST),
+				1, 5000, dwc->regs, DWC3_DCTL);
+	if (ret) {
 		dev_err(dwc->dev, "Reset Timed Out\n");
 		ret = -ETIMEDOUT;
 		goto err0;
-- 
2.34.1

