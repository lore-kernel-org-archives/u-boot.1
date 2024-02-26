Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6001C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF5987EF6;
	Mon, 26 Feb 2024 13:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="L/Uc97fD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88A587E89; Mon, 26 Feb 2024 11:09:21 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA3387CED
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q5cWVw004729; Mon, 26 Feb 2024 10:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=QSG9V39/9+TkyhfCgM0u2X1QxQTJcwg7i967T40m0H4=; b=L/
 Uc97fDfcaD2lzbFZhtkHCEz4+pCGFLwkuyuuobybhc6ZPq32JT3+6oMPNkj8kiTj
 ixXXyaKwJ3jLNJtMMQcGcd17AwqwkNJ1p47OVwH1B48kFiWEzTnwJXZ7dD9xMc4R
 uw3AAuRFUj0eEfQrv3lrHO4TicI4QeaBhA4H/j4y8DH9WS34+1s7EHp3jFW7kriT
 uK7HUZg6R5gCO1BTUhhGdfdVG1PZvRo0q7Eqz1U4qbHoRKbUICYF1ruJskYLBlWl
 FNzp+o1JP4na74044ekRLH2AEwGQOiKiD0ZUe5gNHBLRhZJVF2kbeREPTB00LYDM
 BK8YDuq13CS0XmCyHUsA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxmgjgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA9EOY032073
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:14 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:09:11 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/10] pinctrl: qcom: Add support for 'pull-down'
Date: Mon, 26 Feb 2024 15:38:03 +0530
Message-ID: <20240226100807.1095607-7-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: zkTmp6Rz9TTGkbPyqEfqoOHtSPezIMS0
X-Proofpoint-ORIG-GUID: zkTmp6Rz9TTGkbPyqEfqoOHtSPezIMS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260076
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

Add support for 'pull-down' needed for IPQ9574.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---

 drivers/pinctrl/qcom/pinctrl-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index dc3d8c4d90..ba53b6f290 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -37,6 +37,7 @@ static const struct pinconf_param msm_conf_params[] = {
 	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 1 },
 };
 
 static int msm_get_functions_count(struct udevice *dev)
@@ -104,6 +105,7 @@ static int msm_pinconf_set(struct udevice *dev, unsigned int pin_selector,
 		clrbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 			     TLMM_GPIO_PULL_MASK);
 		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_PULL_UP:
 		clrsetbits_le32(priv->base + GPIO_CONFIG_REG(priv, pin_selector),
 				TLMM_GPIO_PULL_MASK, argument);
-- 
2.34.1

