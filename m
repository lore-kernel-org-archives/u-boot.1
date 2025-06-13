Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19910C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 05:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C55382C4D;
	Fri, 13 Jun 2025 07:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="fMR5Hee7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E6082C65; Fri, 13 Jun 2025 07:20:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA1582C44
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CJtw6O002672;
 Fri, 13 Jun 2025 05:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y1nZRhsVCGwTw1rZQircj8n5uSqbWK/zlijU1vsNXkg=; b=fMR5Hee7rLCn0htY
 oCzds5aN7HCVN3oK7eICZ1jeDn2ZvArEA/yw7iKOmap0Y27m4iYMXTACND8gRLCQ
 lh8Dm9vH/TOFcRNGEgZpNAi2GcOs5L51gLOdcoWzHyVAt+MEsjABm+t48GF6s7eH
 L3EU6jzksTyZMbXfQnj+JgwRn6nRDWrDbxThajvKE3sITA+WlpqduxKavXnvQJuS
 HAMklxpYKEs1nFcwHQNozoFVTW8uoI3pgR/aPLojmNLPxX8e9t3I/yv6wCdaoNK8
 R74gFbcE7H3Eaak5bZys4l/t1omEb9SAxhFQ3Hsu7QtKHhnew/wF5pQ01XXDjnFf
 xENoTQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jbpm4tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55D5KOQo025252
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 22:20:20 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <jerome.forissier@linaro.org>,
 <sjg@chromium.org>, <patrick.rudolph@9elements.com>,
 <clamor95@gmail.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v4 1/5] arm: psci: Add API to check for support of specific
 PSCI function
Date: Fri, 13 Jun 2025 10:49:53 +0530
Message-ID: <20250613051957.3159564-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613051957.3159564-1-quic_varada@quicinc.com>
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: m0XUDmwpmm2k5SY51HPCBXWvU5DLXF5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAzOCBTYWx0ZWRfXwQOQiPBmx3Rd
 OEtgX9YhyX3e8KUtS0r7xJ2Qayi3crBozTKdSBOv6T+Fjjk0cM3eG1pXT3vuOX5CrzH0q0AxIg9
 fb8xCX/jkOrDmZVOifCdKR2YvRzNaEeFTSr8bjzFA1b4QKKcLPtNs/TPmZNu7+7cHvygaFqmUo9
 U5FfdhqCbRfCEU967HspnAlwAzfyi9NDg6gMkRll+VHuJFUyXD5C0HzKnoFjacaArdeZvafmYSx
 /5toh4L9fyLQxburfbWEuBkPW37lDDu7OF7osGz58h0+3KfSHTRFLUFDTWLagH6u8kTim7dZwKq
 mu56IJUUGwPwEXH5w5mi78O9NKzTQbiTgpLcaV8lJ7dGnq6P7nCiVc9olvE6g+D8pFf4OG3dh2t
 Z5bfhDdbH3HaP05CU/AA2NoB8UOxOjVcmXpoCChjEqbo+Vcat2h02KKpS3ZcavDVTrsfuFry
X-Proofpoint-ORIG-GUID: m0XUDmwpmm2k5SY51HPCBXWvU5DLXF5r
X-Authority-Analysis: v=2.4 cv=OLgn3TaB c=1 sm=1 tr=0 ts=684bb519 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=B_h1StgqK4FeiTQRNJUA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130038
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

Add an API to check if a specific PSCI function is supported or not.
This is based on the psci_features() function present in Linux kernel
(drivers/firmware/psci/psci.c).

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm/cpu/armv8/fwcall.c   | 15 +++++++++++++++
 arch/arm/include/asm/system.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/cpu/armv8/fwcall.c b/arch/arm/cpu/armv8/fwcall.c
index 87de09979b1..f834d770dd6 100644
--- a/arch/arm/cpu/armv8/fwcall.c
+++ b/arch/arm/cpu/armv8/fwcall.c
@@ -129,3 +129,18 @@ void __noreturn psci_system_off(void)
 	while (1)
 		;
 }
+
+int psci_features(u32 psci_func_id)
+{
+	struct pt_regs regs;
+
+	regs.regs[0] = ARM_PSCI_1_0_FN_PSCI_FEATURES;
+	regs.regs[1] = psci_func_id;
+
+	if (use_smc_for_psci)
+		smc_call(&regs);
+	else
+		hvc_call(&regs);
+
+	return regs.regs[0];
+}
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 4c1b81483c9..0b788bcf0e5 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -336,6 +336,7 @@ void smc_call(struct pt_regs *args);
 void __noreturn psci_system_reset(void);
 void __noreturn psci_system_reset2(u32 reset_level, u32 cookie);
 void __noreturn psci_system_off(void);
+int psci_features(u32 psci_func_id);
 
 #ifdef CONFIG_ARMV8_PSCI
 extern char __secure_start[];
-- 
2.34.1

