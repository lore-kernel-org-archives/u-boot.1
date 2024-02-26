Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A541C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7813287F12;
	Mon, 26 Feb 2024 13:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="I6gkqn7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1057387D6F; Mon, 26 Feb 2024 11:09:30 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D665D87A80
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q7Dmns030779; Mon, 26 Feb 2024 10:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=LktHpvrEWkFn8+QhgYOWe97PqSUUPd+IcH3etJKv/FM=; b=I6
 gkqn7JuWnICJ5WgLa7+ETv1JQzjao9o0j5apxhKE8llyWOaMYd9wyDDKrZvJwpS7
 jV7ta3ecf0F7CXjoRiKbXvjTlnVOgXCFcA9WKnsk87+UKczB5C69iN+m2RCHQsM2
 eiRbgDO8iQbDeo7SQApu1gpoihfo5CwXqt4Lgc0+F8xVs683hT9b1rIG4ywX3O/C
 pLrn01nnjgfBXNhS5AKi9+5FCKJQZ0ckbMnh/L8Rr7JsI1d0PyZkRwoRBhr5+QgQ
 TLAU/nDMdBLFMS6YgNR837xpxhwKOmoJLnp4tG2lmsY+qof9B5uSfm6lRfNineZ5
 PbwHIzmuP1LUxd/Xhang==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxm0jeh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:24 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA9NI6032182
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:23 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:09:19 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, "Sean
 Anderson" <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 09/10] mmc: msm_sdhci: Reset clocks before reconfiguration
Date: Mon, 26 Feb 2024 15:38:06 +0530
Message-ID: <20240226100807.1095607-10-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UT1ZhHkk_VusPB98tLdM_sJS5n_0-LSi
X-Proofpoint-GUID: UT1ZhHkk_VusPB98tLdM_sJS5n_0-LSi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

U-Boot has to reconfigure the clocks that were set in the boot
loaders. However, in IPQ9574, the clocks have to be reset before
they can be reconfigured. Hence add code to do the relevant
resets.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---

 drivers/mmc/msm_sdhci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 9285d412fe..2e9d521159 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
+#include <reset.h>
 
 /* Non-standard registers needed for SDHCI startup */
 #define SDCC_MCI_POWER   0x0
@@ -122,10 +123,19 @@ static int msm_sdc_probe(struct udevice *dev)
 	struct msm_sdhc *prv = dev_get_priv(dev);
 	const struct msm_sdhc_variant_info *var_info;
 	struct sdhci_host *host = &prv->host;
+	struct reset_ctl bcr_rst;
 	u32 core_version, core_minor, core_major;
 	u32 caps;
 	int ret;
 
+	ret = reset_get_by_name(dev, "bcr_rst", &bcr_rst);
+	if (!ret) {
+		reset_assert(&bcr_rst);
+		mdelay(10);
+		reset_deassert(&bcr_rst);
+		mdelay(10);
+	}
+
 	host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD | SDHCI_QUIRK_BROKEN_R1B;
 
 	host->max_clk = 0;
-- 
2.34.1

