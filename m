Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A794DC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B01B82045;
	Tue,  1 Apr 2025 10:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="aKa6goBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592AE81FE6; Tue,  1 Apr 2025 10:01:22 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0862981F44
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5317Mf44024534;
 Tue, 1 Apr 2025 08:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gmaw4iKVU3cOAcwm/xHrRj0Qz9+KmBoyjNvozqM0DYU=; b=aKa6goBv+P8PktNf
 LviA3bPU3YxFJxjAqU6F7U+ZyDczykxw8qCrS26EMgJBX9zS5keVTO9HBrX+IdKS
 Ow+AtiAwjDdhUaaodjkhXhakN7StpmcdhCC3rkYegsz4FCcsXvnnsmLMnIhjzzDb
 MEzgMHMOJlxbbgJAKMQQ46EqziQr6S5BdsCNaphfw63v/Li0qFBGyGcT72jtXt+k
 30Z0rY42cMurEo9Z7BENuq0s6puJ02lntEgbWxsF88vlLWw6mdxmsoToozP4PYcT
 1HJmwI5FlSk9wdQQirdzYI0Qzbfw0J7gW/e2E03N+nCkfRH1akM+727LazJW7I/g
 lxBttw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpyr3mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 08:00:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53180qKx026865
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Apr 2025 08:00:52 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Apr 2025 01:00:48 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <cniedermaier@dh-electronics.com>, <xypron.glpk@gmx.de>,
 <sjg@chromium.org>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v1 3/3] configs: qcs9100: Enable env in UFS
Date: Tue, 1 Apr 2025 13:30:15 +0530
Message-ID: <20250401080015.1470999-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401080015.1470999-1-quic_varada@quicinc.com>
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: n97sCJbLwEbtgZmLYniizJHkHoNv_97x
X-Proofpoint-ORIG-GUID: n97sCJbLwEbtgZmLYniizJHkHoNv_97x
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67eb9d37 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=1vbZ9Er4auZhERsSQ9EA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 adultscore=0 mlxlogscore=949
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010052
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

Enable CONFIG_ENV_IS_IN_UFS to store environment variables in UFS.
Set env variables partition name as 'ubootenv'.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 configs/qcs9100_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
index 10ff4d25398..d56f08f0ad0 100644
--- a/configs/qcs9100_defconfig
+++ b/configs/qcs9100_defconfig
@@ -14,5 +14,9 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
 CONFIG_REMAKE_ELF=y
+CONFIG_ENV_IS_IN_UFS=y
+CONFIG_SYS_UFS_ENV_PART="ubootenv"
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
+# CONFIG_ENV_IS_DEFAULT is not set
+# CONFIG_ENV_IS_NOWHERE is not set
-- 
2.34.1

