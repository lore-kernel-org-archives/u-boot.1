Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EEFC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3FAB80F5F;
	Tue, 18 Feb 2025 09:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="TWqsx8XU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE1B8043C; Tue, 18 Feb 2025 09:55:49 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF01280BA8
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HLkR2q010352;
 Tue, 18 Feb 2025 08:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6yHdLYlOLnskluNDmfBKOKagJuTOGlclyOkVnApEQ1s=; b=TWqsx8XUlEnS3tKy
 S5VA1T5zDF5Myufxy1t0nH9nRhQsE5tlYmM7dWpuTlEw9WA2EY1q17Dfqu2vCK3z
 VS3lAhUuh4Qf+2jsVdrK8ewqvh4DSivuBsUFQtyXA0Emk1iFRJ7a9f6wu8ctvUFL
 VVBHUmjiFpAxSFE5YjVa8Rp/5x5oTeK+PaJnYWwM/UCR5DrjIl8liwSL6thPA67W
 wPc6ItyvkuCX2iaiR3woLd4Hj5dQ418vqx63dr/DxsnnMC8atlzHg/eRoSJaXskd
 rDX6w+rlNzeWIKbCDvpLHa6X9AVjoStickGSxdXaCJJm0PLQWh11c5Xn/Tt93/3u
 HFbQGw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7uc6ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 08:55:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51I8tTh7029748
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 08:55:29 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Feb 2025 00:55:23 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <Volodymyr_Babchuk@epam.com>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v3 7/8] qcom_defconfig: enable ipq9574 clock & pinctrl driver
Date: Tue, 18 Feb 2025 14:24:29 +0530
Message-ID: <20250218085430.2422287-8-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218085430.2422287-1-quic_varada@quicinc.com>
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 1qJKURP92KODQ1yWTusuvyZW_v8GQOyV
X-Proofpoint-ORIG-GUID: 1qJKURP92KODQ1yWTusuvyZW_v8GQOyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=626 spamscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180068
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

Enable the IPQ9574 clock & pinctrl driver in the Qualcomm defconfig.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e4abfdf16b..865381f75d 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -47,6 +47,7 @@ CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
+CONFIG_CLK_QCOM_IPQ9574=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SA8775P=y
@@ -94,6 +95,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_PINCTRL_QCOM_APQ8016=y
 CONFIG_PINCTRL_QCOM_APQ8096=y
+CONFIG_PINCTRL_QCOM_IPQ9574=y
 CONFIG_PINCTRL_QCOM_QCM2290=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SDM845=y
-- 
2.34.1

