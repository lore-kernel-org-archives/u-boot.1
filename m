Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBFBC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 135A487F0C;
	Mon, 26 Feb 2024 13:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="dUC50GK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B89B87EB0; Mon, 26 Feb 2024 11:09:28 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DDE87CED
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q9NWit018621; Mon, 26 Feb 2024 10:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=qLFEzhEqdU4z7Y1zy+AVFLCiXSBM5ysX2ZI3657888U=; b=dU
 C50GK7dwnR1O1Edv3KzZoobvVKJjxoYI5lQXDH6ocIzEYkV7uh1NOu2TtwdXweeS
 wpTWfY62Nc+wKiXAMZZXjxzVsY80PD6jgf6OYnUanqLvzJrJpXgftTgocV78WigK
 cmaUkbvifLOmmglkTlPtEjIiev3TWSsVCF0QuMN8DDFY5qduk+SZhyD64QpYcEQ9
 p6znF6YH89U0Zmdd0OsdanBxtBbWwgDCdD8iYHjpVwqZlEO9LWMjp+9pYp5DfsaI
 RO8Gy3zj50BZ7DsmMoay38aEcMedHfZ9fsYYma4rmN9MQF50zvFvOzL8lQeMrUsJ
 pk+EODPYS1An6DF0ELRg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxp8jqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA9JIe017336
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:19 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:09:16 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, "Sean
 Anderson" <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 08/10] mmc: msm_sdhci: Handle different vendor cap register
 offsets
Date: Mon, 26 Feb 2024 15:38:05 +0530
Message-ID: <20240226100807.1095607-9-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WlXfrksgnKMFwDTjLKDMmZvx_nmk1iY1
X-Proofpoint-GUID: WlXfrksgnKMFwDTjLKDMmZvx_nmk1iY1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

In the IPQ9574, the vendor capabilities register is at a
different offset than in other SoCs. Hence add a vendor_cap
field to msm_sdhc_variant_info structure to get the correct
register offset.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---

 drivers/mmc/msm_sdhci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index fe1e754bfd..9285d412fe 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -48,6 +48,7 @@ struct msm_sdhc {
 
 struct msm_sdhc_variant_info {
 	bool mci_removed;
+	u32  vendor_cap;	/* Non standard (?) SDHCI register */
 };
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -158,7 +159,7 @@ static int msm_sdc_probe(struct udevice *dev)
 	if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
 		caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
 		caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
-		writel(caps, host->ioaddr + SDHCI_VENDOR_SPEC_CAPABILITIES0);
+		writel(caps, host->ioaddr + var_info->vendor_cap);
 	}
 
 	ret = mmc_of_parse(dev, &plat->cfg);
@@ -219,15 +220,23 @@ static int msm_sdc_bind(struct udevice *dev)
 
 static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.mci_removed = false,
+	.vendor_cap = SDHCI_VENDOR_SPEC_CAPABILITIES0,
 };
 
 static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.mci_removed = true,
+	.vendor_cap = SDHCI_VENDOR_SPEC_CAPABILITIES0,
+};
+
+static const struct msm_sdhc_variant_info msm_sdhc_v5_ipq_var = {
+	.mci_removed = true,
+	.vendor_cap = 0x21c,
 };
 
 static const struct udevice_id msm_mmc_ids[] = {
 	{ .compatible = "qcom,sdhci-msm-v4", .data = (ulong)&msm_sdhc_mci_var },
 	{ .compatible = "qcom,sdhci-msm-v5", .data = (ulong)&msm_sdhc_v5_var },
+	{ .compatible = "qti,sdhci-msm-v5", .data = (ulong)&msm_sdhc_v5_ipq_var },
 	{ }
 };
 
-- 
2.34.1

