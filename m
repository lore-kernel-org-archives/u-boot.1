Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C07EC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 18:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2A982EB8;
	Wed,  2 Jul 2025 20:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WE50P+4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464B882103; Wed,  2 Jul 2025 20:02:06 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2DD82F4E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 20:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5629ZhC2026748
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 18:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/hr3wvPP2e3
 U8VkY4xqvcDvbwCh9ZrYAO+2J0sEu6e8=; b=WE50P+4e+uh9Ftu3B71WjcQ9gVC
 UQPwonjTVGyvq9v+DVd2tPBuyppkSGsqfvmRrzTBzANgPEcG76a3uUQuI0q76I84
 kHvyRrYItBuqT1FQXi0sTiBIA2YEAeMyAZivBCctio0jG6VJU/xsPXPmUzLm7VYu
 XJYMZfphXd3E6BMFt/VRa8yXR5Rt5h7asaU5KeHLZjX8PdoRwzleEXgLL7JYiWP/
 Ue4/TO5+y6siy1IF8754zqXIJBKy6QTxzlzD8e1/A/9hiBt2w80Rf/TEWfr/8AS0
 8L+vlmDONTsyiNhRfpEf4Ya1AV47of73441CPLcEvwjECQqB/t67TXy7hzQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8025cnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 18:02:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-236725af87fso90573985ad.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 11:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751479321; x=1752084121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hr3wvPP2e3U8VkY4xqvcDvbwCh9ZrYAO+2J0sEu6e8=;
 b=mr1bKLcZp8ymxjzLGphk5pIwZWTP8gsJEYvSfBQ4MqVZmNOIX7G5E05HwapCvSMWQF
 x9pCFd01NYPQVUACtueDhUbbtJIlCgO2nslSdyv/rRj6cLOHwDUIa2WL29lsC+clYZUh
 50U4Z5ngpTkBsQp8flhtPn4eewUp/g6bwTnrzeWSZ/Zc+UzG1UQwW5lIDI7gXTrL2uZk
 KsRrQTX2xTLJtqosaaz7ZvqNbEJ7oqI5f/UeI0t58tyMtaB7sVISsDihbOi43wgtj0+j
 UN3McFhyNBqZ3veheJUt8zwKxO7NLrTTUZa+po9v3nKaTCckRsKygBk3mub/Ut1/S/EP
 11pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtkH2WcREVnDIsctH4mTetSnjptvS8vjEp0w2Iv0EftJa9H5iE0DWPTng8bS3xf4/0dlodefA=@lists.denx.de
X-Gm-Message-State: AOJu0YyOvcaAfiv1h+U7QJlSPjqfP8oW6xuQD3e6NKYgzyzcc0NCpaqw
 zweqbRrWve7639lWPmJnTH/lqEOj1js9NVGDVMG/6qKfpwQDMKyHp4CV112bh08W/vLjxu6ScfO
 pJ3SRYc3gyIvsoKjAe65MWqskl0lJiRUTMcEqi8cH7oUXbAkULWyEAcmX
X-Gm-Gg: ASbGnctC1xmVd3EthkKb7i+JyNYsXO2SwZvQJOltt3zlZ9IiFrnU4bGnfqvHla04JOD
 BWYabK232qGo0LdqweVoPk53mSPCL6jAA9SE+J6Qv45hPgZT28ERztsAi/Jz75pKGaI92pPTZlR
 xA90jPqNdi1WMAZAmpcCO0see3T6K7hMbE5L/6Bn3bpoyIkI8Q3SWIVGZ62Qnfjbx3qh4A+wsZS
 nI6FrxgoSGatTz48IKK2i+s4s+wEUbjOTrzwd5f8V37TC5OfbsWeIrVHhXxX/6iAcJEy5xrqGLo
 fltkQXPIHqfXvd/ezYatJQMo1UKW6Ugbd6c6/FJlaCCUGPgV/5fMGUW5mpW4m8Vz+3nPM8ucJRv
 SZYQZICPZf+Xb9dPGqkxarkyTaBnDLq5WS7cIKGdLiA==
X-Received: by 2002:a17:902:c943:b0:224:24d3:6103 with SMTP id
 d9443c01a7336-23c6e5b72e9mr58271325ad.35.1751479321262; 
 Wed, 02 Jul 2025 11:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfqlz9HA4cflM/TODx1dLEqxbKYJotIMe9VrOtc32ebWBpBluH9sC19OEZA+qoCx03l7nQ+Q==
X-Received: by 2002:a17:902:c943:b0:224:24d3:6103 with SMTP id
 d9443c01a7336-23c6e5b72e9mr58270905ad.35.1751479320828; 
 Wed, 02 Jul 2025 11:02:00 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e39besm143315345ad.13.2025.07.02.11.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 11:02:00 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 4/4] configs: qcom: Add OF_LIVE_SA8775P & QCOM_POWER_DOMAIN
 config
Date: Wed,  2 Jul 2025 23:31:33 +0530
Message-Id: <20250702180133.1889709-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
References: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RmNgjHbQoncmsp8rfgM0RCucGTy36Cy1
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=6865741a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=FewLElwZLWEMPa2W824A:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: RmNgjHbQoncmsp8rfgM0RCucGTy36Cy1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0OSBTYWx0ZWRfX/xW6HvbnSm4m
 j9340+ACVw2PoYcwu96xiYbfEe0QIXfchRREkeWHigvWhGxS4qWNTah2PJhHW4NPnwNaoqrIGri
 teEsjVW2mFpVHlbrOOYrVAByt8O0UIscv985klUoshoYnitsTw2PxbQRZXEnQ0ylnpjgF75suMT
 2jhQN8rRt4y6R5Xg3r9UtQujZQfeX9g6QozESoFSTrlJhYzil0zmLAS5fP20ZcLmSNq6nm0l2z2
 tlogOVu3TRn3A3AA8Nh2Bb5rRkNHtVfgnenxDeLEIt+ziZhIA4eCryJuKlVszpkJWHNFJEV67z5
 9m67+gLPCUeoC7OgGMJfsnFTOIz1xukEnn1BbuBM8OQPERqUI99Az6JUPO1rEAkkL9uIG95flf8
 PJtmqHJc4BeB7z4DHf/8klMsV8w0vitH/WBlYG5JpOf3CP/bnPSDFhW4UykIMzzdNNPhob3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=911 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020149
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

Enable QCOM_POWER_DOMAIN & OF_LIVE_SA8775P config for qcs9100

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v3:
- Removed OF_LIVE_SA8775P config, since there is no SA8775p specific fixups are done

v2:
- No changes to this patch in v2
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da0..f7780c06454 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -123,6 +123,7 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_POWER_DOMAIN=y
 CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
-- 
2.34.1

