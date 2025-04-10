Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C2CC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9DF83BCE;
	Thu, 10 Apr 2025 14:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="n/Di4Z75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9C283BCC; Thu, 10 Apr 2025 14:03:05 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 688E2839F3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75gJv030616;
 Thu, 10 Apr 2025 12:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IQTY7KLNxPAbKsjwl8hVAu4O5wCDHu+J8HXrh8OCEqo=; b=n/Di4Z757q0ieHvz
 mRfgav9whfwobJbgmPgNrmXcentbD4BsOHYkzlbjD7Enp5sgI7DBXM1HeXo6p0jr
 Ro9KSvkhI0iyUFphNHXbw+KQPu5gGw82KWGGHpI2l4L6ABVsQf+JZQiF7oVfsXdV
 X8mqoN+1RslhjIeyEx6tuvSXJMLjOf5sogTH0BgDUamJMTrq584qlxQ5hsa3hX1E
 BhzPn3l9MEQQpN8JBBNaW+wUHqQjfxmg5ipGMILrGvuFzBBXbEDLgSjMpLu+m+Qo
 lB6byXXYxYEnh1Lo85lqTHyTv//w0DrxsE7sMbRvysu0MmfkMpvgzvMsY6LPYsox
 XJv8GA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twftpmdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 12:02:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AC2m01001490
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 12:02:48 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 05:02:43 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <sjg@chromium.org>, <ilias.apalodimas@linaro.org>,
 <sughosh.ganu@linaro.org>, <me@samcday.com>, <marex@denx.de>,
 <quic_varada@quicinc.com>, <robert.marko@sartura.hr>,
 <seashell11234455@gmail.com>, <ycliang@andestech.com>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v1 1/3] mach-snapdragon: Do not define reset_cpu() if SYSRESET
 is enabled
Date: Thu, 10 Apr 2025 17:32:06 +0530
Message-ID: <20250410120208.4142087-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410120208.4142087-1-quic_varada@quicinc.com>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=B5+50PtM c=1 sm=1 tr=0 ts=67f7b368 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=bfm6ot8TQTG4Y_NhkA8A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mP-DFrk-w7XD9Z4-dyV3ky1IwZaPShl8
X-Proofpoint-ORIG-GUID: mP-DFrk-w7XD9Z4-dyV3ky1IwZaPShl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100088
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

If CONFIG_SYSRESET is enabled, the reset_cpu() function defined in
arch/arm/mach-snapdragon/board.c conflicts with the definition of
reset_cpu() in drivers/sysreset/sysreset-uclass.c resulting in duplicate
symbol error while compiling. So, do not include it if CONFIG_SYSRESET
is enabled.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm/mach-snapdragon/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2ef936aab75..2254e0b55a1 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -187,10 +187,12 @@ int board_fdt_blob_setup(void **fdtp)
 	return ret;
 }
 
+#if !IS_ENABLED(CONFIG_SYSRESET)
 void reset_cpu(void)
 {
 	psci_system_reset();
 }
+#endif
 
 /*
  * Some Qualcomm boards require GPIO configuration when switching USB modes.
-- 
2.34.1

