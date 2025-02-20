Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C79CC021B0
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 07:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8528680F53;
	Thu, 20 Feb 2025 08:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="RPjHV28N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B1980F5C; Thu, 20 Feb 2025 08:40:39 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5401680FB1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6n7pM008355;
 Thu, 20 Feb 2025 07:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H650EhtER5qHbdF5BekqDH3I8YRA4vPRTtYiAB8x4zA=; b=RPjHV28NFDm90pyW
 cvr30i6pKxU98C8HAQltRtQX685mmkfw6NK2LogmpiViaRf3HrmzUnjfunfDQvlr
 6thGPxhnUj1jOFkisDhy/5nvy5Q/ZAH1/OY640NYalVmXZL3WuvQY9LdNWUkMSUK
 qrpGgm+dL8vsKS0yNvideXsG1DK6bSN/PKOfYNlDpKZi1An7nZQpWbV9JB5Th+iL
 Nd2pXMmYFqTrMPlIfbCF4JsL5HGSI+J3yWUpN1RGXmVuDRwsSdwl467wMX55z++B
 VQBLIll+OW3bQzZQfwPQOXkEkfBCa9WJpjMgZqe6hM9NBouyE4VTG5RVdYlJ13f0
 0LG1zw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3dbes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 07:40:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K7eP0Z032717
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 07:40:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Feb 2025 23:40:20 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <Volodymyr_Babchuk@epam.com>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <pbrobinson@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v4 6/7] mmc: msm_sdhci: Reset clocks before reconfiguration
Date: Thu, 20 Feb 2025 13:09:36 +0530
Message-ID: <20250220073937.133687-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220073937.133687-1-quic_varada@quicinc.com>
References: <20250220073937.133687-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: d6O_gWclYgtka2tocMbLePD9geQktHFF
X-Proofpoint-GUID: d6O_gWclYgtka2tocMbLePD9geQktHFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200054
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

U-Boot has to reconfigure the clocks that were set in the boot
loaders. However, in IPQ9574, the clocks have to be reset before
they can be reconfigured. Hence add code to do the relevant
resets.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/mmc/msm_sdhci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 27bb7052fc..ac77fb06bf 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -10,6 +10,7 @@
 #include <clk.h>
 #include <dm.h>
 #include <malloc.h>
+#include <reset.h>
 #include <sdhci.h>
 #include <wait_bit.h>
 #include <asm/global_data.h>
@@ -153,9 +154,18 @@ static int msm_sdc_probe(struct udevice *dev)
 	const struct msm_sdhc_variant_info *var_info;
 	struct sdhci_host *host = &prv->host;
 	u32 core_version, core_minor, core_major;
+	struct reset_ctl bcr_rst;
 	u32 caps;
 	int ret;
 
+	ret = reset_get_by_index(dev, 0, &bcr_rst);
+	if (!ret) {
+		reset_assert(&bcr_rst);
+		udelay(200);
+		reset_deassert(&bcr_rst);
+		udelay(200);
+	}
+
 	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD | SDHCI_QUIRK_BROKEN_R1B;
 
 	host->max_clk = 0;
-- 
2.34.1

