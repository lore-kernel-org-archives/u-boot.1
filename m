Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD245C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9119D6076B;
	Thu, 27 Aug 2026 07:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NdRTIFgJ-ZNP; Thu, 27 Aug 2026 07:33:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816036;
	bh=TWS1d9QB1JolW9sCDIqRJ7jjRIINa1kJ1pm8dwkzY+s=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJxA4bc2By1uRMiFdY8qmjIwmn375zdfURXTQtkZZK8dxiv8I+vGXGZxRIDLcwE3m
	 KK0N63XOWHCwGlFrKJ/lq6SdeqLqb1CmHeOKbOSlw/4CUNyuBsTPcQ45IZVEQ9KJQK
	 nt5rVZqUqNXmDW8gAEgsWKpL3rcn+dpYNSKp7HL+Dq3k7ljtdFqA1pm9BrUZgCv5Cx
	 2NtlynugXeMD4HRkvX/148cDVVd8xYkln4tWokFno2P8XeyBV5ReziUxyQUhwxCO6G
	 qKPJhAA4uZSYwRqU+QKIk3foAmbXmbt3YIcYSqpkt953/7+VWuIEcRby7qx91GCgCL
	 MQIsr57GatRPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B86A36073D;
	Thu, 27 Aug 2026 07:33:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D04D81DB1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B008E80D1C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p1WRZ9F4MbSS for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:33:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=OiX9v/kX; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=c6IuTlmV
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC61180D09
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RJL32075189
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TWS1d9QB1Jo
 lW9sCDIqRJ7jjRIINa1kJ1pm8dwkzY+s=; b=OiX9v/kXEqAkUdnHgrgZsIr23RQ
 xRM+00i/u+r11Nm8KknW+venX1G6bRbwTAMQhPhniE54jWnW9Kg8/fhs8KqW2Pif
 hv9nnR1nSKVGDDet8/RIzou96+cBsxpyECu3P6Vtx5DwP157ZPFbTtRSzp65eAha
 ZTLKKW3pLGNDel17kL09Krnv9w8dXc9DSB4u4stdEKyUMbDeZ/PbqYiAwGEsszqu
 W9vsvhDWvYzORaCggFdrn9DwfRDTAQgSlvP/hecngGtzh4iiNJQsymxu5o27jh8/
 a1aDQKCLULjIS1wICTo+Ys18JYYua7d2JEcDUyVgWsFl1EjaFkbcNJ0MFEw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bhd84-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:33:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso2220429a91.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787816031; x=1788420831;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TWS1d9QB1JolW9sCDIqRJ7jjRIINa1kJ1pm8dwkzY+s=;
 b=c6IuTlmVbq2GfpBAOXpAc++07dpDOJxfG0aZkXBZuKAY+4bSFvJ0UD0G+tZoIQxFVF
 iWUvpzMl/7J6bg6als2b714RiIDct32oWi/m39WzCahaMTpufDjeu3ST7ayb2BGHkm4c
 4TkVxq8vvy4YlU9bmbVISL7CY0wd6jnt+uNiW8wpGykVLbLY0KaXAoZWiC1tcDBY84Qg
 edJKFZQUAzFAPFlTZnoTqWq1AYCxNwBAbJMePlTAGwoah3x+NRTozASx/brtsEmtQ0Rr
 8vGheTaGODBFrplXLSzWVO1kkLTecYSIb/Q+2b7W3ikgSVUJ4lyeEXS2qrDlGkPlHT97
 +k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816031; x=1788420831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TWS1d9QB1JolW9sCDIqRJ7jjRIINa1kJ1pm8dwkzY+s=;
 b=tSuOI7dLP5jwqUqSit/0Vtr125l3K1Ug6+0T+1QimOp0UOOZchflKrjym5pGpYGTNA
 0lZlXGy1zea+yJi0+ghkA6cwcDXyDcefMKzQ3rpDQWeBVU7VIoJeaGfP0FfQ0+Hpt6Iq
 YaTX4JYh9Tjit71Xt26gh+CB6/n/zm3Jz7EjjxXpmqX5HTUfCIqhLJOZLKpxPdLPQvq6
 Lpq06xx0nD45Xo5fUDKwc/wc4j7ymaDrKIOm1pRwZ5q4+mdf4qHq0dBSarKXere7PoWc
 ZBZ7o7T6cIF6pFsRbhedvxv2wmImWYK+HsTltlgqEqN0bkY7A4Mdu0c7cNeU/i/h8+sD
 WDAA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpq5HJ2LzQcERDLYCCDPAmHLBj5BORzx1hV8oU/5AO9wOfFihMqhMhNBb9AHTx+q6eB2IN1EDM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k0wVAbFC0elNQMf4Eak1MVV3Ruotx45+YPdbqt83L3QQpSXNXT
 sKq6ZlH9HMev7HFUGoy32gYB7ZhKc3r0YJmTsOkggK0w7hqW3MnHOyEp5/U5J9phF6NdwXRSAun
 tLoaGvk6C2O3/exrF/C6y2nIlrk8Gc8lIXaI40p1zga9co1xe2D8wO7vYbcg0yjf+BtKl+bg=
X-Gm-Gg: AR+sD10XuFRjthYsgRAX+EokYHJVIQCyPKIiGxEmElnZUB1B3qFWTnwi9RqZd2kTQ4G
 zNw76mzE6BmHxRbOzTmg5asQLkm1Iuswa0KlK2rRM9GaOue/oH73F6apgstaJMkXyi4fxjRWbcU
 m8wDBB7/KCS1TgN0610QFoGKfpXc2cvZ3jL5Ce00xJ4Y5vPaa+GN+crYm9Am30MUZN7pHnjxJRB
 dzljtxOKzIrxkDHSAqzbjSPo4/HlFSKn/xludE8OPsqyU8nnuwjqf02FIpQDjNlafqHxv4DpHbv
 2pfA1ODrdXu2UnnQwb/se6F3tduU+fuOQSTd1ZxOPDzcYRhfumOF07nTrNGzqWV8Fzezgh7kk4a
 EsHyKwaNgTWjfnxoCL7vcYvQc4piEPE9SS68U7fuqSxmClyqYO4JdTSX8FFEkdyPuInzgf/IYqU
 F6ovgwQQ1WQi2WGyrILWw=
X-Received: by 2002:a17:90b:3f83:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-3966d497d0fmr28446808a91.15.1787816030657; 
 Thu, 27 Aug 2026 00:33:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3f83:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-3966d497d0fmr28446670a91.15.1787816030119; 
 Thu, 27 Aug 2026 00:33:50 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d8dc465sm15146713eec.24.2026.08.27.00.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:33:49 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, quentin.schulz@cherry.de,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/3] mmc: msm_sdhci: fix max-frequency read into
 wrong-sized variable
Date: Thu, 27 Aug 2026 13:03:23 +0530
Message-Id: <20260827073325.4113071-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
References: <20260827073325.4113071-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfXwOfPNUA4RQHd
 cjuC2a62pVV2BwfdycqovA6aL8SX9U7tBj8IFYlEeePRToEjkIz++6g4Y+UfwXUfWYf4DvWrz6C
 Mv7ABW6sFkiow28G6jszmD34YGnaOtSzJCCaXPurGIxETHs1xWIED9+v1N9WddVrYCvT7+O3M3L
 moUhI31FhwhwA2SM+da2YNWt8HVOuMD+5db8fWmWDC3Yahvjnmjq3t03EFE8/d3ibTu6h5UnZcN
 IYHwteZu1sguPAsRfXqDKiL8mVj2MnAFpux/KWuHKZLyxM05WZpBAQGUz05aBTQ8BqI6uvS4Eet
 TVcZke6yAShRD3EL72aVtAiWe/Jq6TJnB4IBmlNKmQKsgGWmsnTFlv5uRrMnzELtY1U1js9EskJ
 botBDmJZgpVr+e8WjzfTG7oE5yrgmJwaBaLt6GLGxlp5sHViepE7uAu74c2SI6EGcKXGlVlelfq
 m54knbr16DDEcaK2hvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX3SYym91ejQnc
 ynqW2CwxaeU+3g5rf+4I28S5xlI1mZy6R9VMXkfDT6i2z77WSGXLoIg+pwG6EQHeT0Jiw9lcFoB
 lLvWfyEa9TjPiK1dT8WTpEb9xnFOKd0=
X-Proofpoint-ORIG-GUID: 3vB2HMDyyNe0SLkbZHslcPjsWn8dCyNA
X-Proofpoint-GUID: 3vB2HMDyyNe0SLkbZHslcPjsWn8dCyNA
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a8fe85f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CR5NVIcrUhAq_oVNnQQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270061
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

msm_sdc_clk_init() reads the "max-frequency" DT property with
dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)), writing
only 4 bytes into clk_rate, an 8-byte ulong. The upper 4 bytes are
left uninitialized whenever the property is present. Read into a
u32 local instead, then assign it to clk_rate.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/mmc/msm_sdhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 7bdb02142a2..cbf565be426 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -65,12 +65,15 @@ static int msm_sdc_clk_init(struct udevice *dev)
 	struct msm_sdhc *prv = dev_get_priv(dev);
 	const struct msm_sdhc_variant_info *var_info;
 	ulong clk_rate;
+	u32 max_frequency;
 	int ret, i = 0, n_clks;
 	const char *clk_name;
 
 	var_info = (void *)dev_get_driver_data(dev);
 
-	if (dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)))
+	if (!dev_read_u32(node, "max-frequency", &max_frequency))
+		clk_rate = max_frequency;
+	else
 		clk_rate = 201500000;
 
 	ret = clk_get_bulk(dev, &prv->clks);
-- 
2.34.1

