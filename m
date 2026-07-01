Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EEFC44500
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 12:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE6B84B92;
	Wed,  1 Jul 2026 14:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z34Eiws8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QqPCvpsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF3584BC1; Wed,  1 Jul 2026 14:22:41 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850DB84B62
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 14:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8wsc753572
 for <u-boot@lists.denx.de>; Wed, 1 Jul 2026 12:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1SJQRLE3+r8JV4j54OJBiGJTBgfx/sGkPek
 9s8KHjXw=; b=Z34Eiws8D8HfbecQtO7+xe69jALD2FOTAZ5kC5vbS/SjgUE3I1G
 gaSegrDaCrWk3e44ff8k4W9nS9bRcKhHKsivrB6LGejKZx8MH7V+X5XWg5bmBgbK
 WCum8LoFt3ycbd7nOsidutKKg395Jc8bL8UhJgVJBD9jtXGxkS9nl7XozIEahsWq
 lRp2p6k7VtgExsKVfrOCKrRvdxfNjwOfYSkrq8LXK2kdQCPSOo5yjyc3ws67kAPu
 DGnz1lM5WGSDrRmOEekCSaJpbX72/GLv+X8nNEnxuV4vNemCdAYU6AqAA5QuNl1+
 edaOHkTiv2mud7kBQSDFgOFjna2ob2nfdyA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy2nxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 12:22:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so2246809eec.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782908557; x=1783513357; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1SJQRLE3+r8JV4j54OJBiGJTBgfx/sGkPek9s8KHjXw=;
 b=QqPCvpsY99Dy+qP6KVaRyUMpN0170EiMLnI5xTq04Kohk1KS+FtUvuAvfkp8Kp7cLR
 kKtCOL/xaX/d0Iz5zcPMVi8EQkrpWazpSBcEoNFgQC3691sLDWRzbM9ZqYl5+wwyHtM0
 rNrV5Z7xLobUf/nabmLEwsUAY+Qm+ZZ06PkvTivDZuoHSPNhxjQQ1P6OK3isyiHDhiGB
 YAwlltwF06CdWAplgnWsHS23njj9XGSFsgcCka+Qwwc0885NSC+tIactRDcqvsMfAnFc
 bCVht5MVgnzrqACbw0dNmywUppYqzUPEj6p4gKLlk3HfMR3iX8wB+3wrI57nbsHyI/HL
 QrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782908557; x=1783513357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SJQRLE3+r8JV4j54OJBiGJTBgfx/sGkPek9s8KHjXw=;
 b=iLKNK8TSk+1haJDewIlG5FWCsFWdfd8mS2Cv/imGt5I5T9uIDLCGVVu61UsAXtDKy/
 Xt+3isGvzO8HzNuUeV6LhlpSmIe4h9O9VZKRUiwidPegWoadj+vU/UkD0dPRempzbYRC
 YkKYl3ccpwt20H75Jy3ZyZYuiCcDVHaQGFWVa56t/cXVgw6vzBK6vYaW96yRK3u423Pk
 CFXkSl474x/hICJhTG/TUKz2A7n9rIN/aE8eWzrmbbhylZp7U7y2CRpwkJiyNEvKhWWC
 f3yogpAjn823aRLWFsmRbGqyXcfpQP2ez7UW9e3C3dOPaz2l7d3wi6oV6DlfVBPIOVMx
 OIGQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsIjuOwBPXi5AemtkQ7Qp2DW2Kd4a43LSc6h98vMqoYOE5GqvJXVP/Lr0rvSjs4hFN9q3KK4s=@lists.denx.de
X-Gm-Message-State: AOJu0YwHv0yG/XrazbGWIeGbB/oS5XVi8YwyWrayKxDmdgXsllZC6AGf
 0SQp5J4me7fJZBKxoaKXqbn/HfAqLny8Z9uHPlT53eYNjZUxCzdXRzhc5NSC6a7XdbjFHnEVlYb
 6r89ZEa3pj8vQsrMKlRhBbh6DUuPdlHdVALW+RC/smNnSeykCdWovAOct
X-Gm-Gg: AfdE7clgU05u6QEFPi4H7v4EEgpbjPKDvFYfyoLcECWfWG0h3fsx2mrjLIUmOzB4H8w
 k10YtwT/Yw79/KAOiN7B+Ohf/pBJG2BumtEtFMtcqN+w1oPb1hIZLO24UJkWuwA0Ff5wuJU0qbc
 M3QHEdT9Zq5ufQCDH18LzW0xnXPRvJ9IbYDq8q9EZ4b4c+SGwaZpw2GwpawCypEN12DNDY2bZ6P
 I5sSoJF+AORVUiuQQb277HtYsOiHdUcBkpi6qTL4VyocFGmvuIJicWa9OigIxh7rbmUWDrJ3YSz
 JVP4/fMaY+LOxc2BGeD06NQgTcG60cgcx/XdAOP9ELcQ6hi2qY5Cikfh6w6dneYqAHtaaFZ7R7J
 mzqYAkaoiJOcXUQoDqULL4yCihX19HPmiw8Hfzy8GUsa5fUGlgaa/3BYJpiHcZ1oDmPKwBNJC+4
 kKIRvUM9jC0JlOVaIioSRopJtydubWsg==
X-Received: by 2002:a05:7300:2d2c:b0:30c:52c5:6e52 with SMTP id
 5a478bee46e88-30f053f3850mr565992eec.22.1782908556973; 
 Wed, 01 Jul 2026 05:22:36 -0700 (PDT)
X-Received: by 2002:a05:7300:2d2c:b0:30c:52c5:6e52 with SMTP id
 5a478bee46e88-30f053f3850mr565942eec.22.1782908556293; 
 Wed, 01 Jul 2026 05:22:36 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3170ef9sm33074376eec.16.2026.07.01.05.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:22:35 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] configs: qualcomm: Add secure boot config fragment
Date: Wed,  1 Jul 2026 17:52:25 +0530
Message-Id: <20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AvO7JzLAcNQ2tL9GLHImonJ1Cn-F80ZJ
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a45068d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=xTSDdHutD4yRob8Hd9AA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDEzMSBTYWx0ZWRfXznk7OlesQTmn
 URFSkf0IzvpF+HbvSmEx10gWmackbnraOmVUfns1UtmYWx9lvQ/9xVvAjgSp5q9TPLOUOs3uOWr
 jBRctjb063PkhRlh7333XNz885+hqlyDEL7yRcuU4vOkMWKlcvxAey/AjEZc6HTVpP3wEfb67Qj
 fGCwH0VI1G9/Cam81pObWQrF9QTEjFqtrAvuQ800DJDCkvGoQetfPjqtoRKk4rjEuOeNzsEjPH3
 BHYdtPKGe15dAEuDRjxrANC4Y3rmjx2uCXak404AJSdxDg4r+d3RZaTP/bqZqe9dtw8NlrlnNyI
 OeFbMjDc32r3xcTQ9EmMWdLxi+03wozM9L8XwFMl6xSPkFzQlOYzwlYkxRAV38eGqxpv2lKdLmq
 PoCJ1tRvXMzfKHZ22KMJFJf09YmypCQyDZ7DIZo2NSD9geEhs2qL7nAzYLakWKY6phEleRHfYPu
 GsdE+pjTJ2lRT8+995w==
X-Proofpoint-ORIG-GUID: AvO7JzLAcNQ2tL9GLHImonJ1Cn-F80ZJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDEzMSBTYWx0ZWRfX/nHTyPpTRvQK
 REpbQmPUhrKlLzd7Iveov+TiFXJrmHt/ylTLnVDzZJLNd/RMeRqq/OxsLUd8UXa3IDq5dIFwdH5
 5LMNjJg9kXG6Rf/n8Hs9E3dfnVVCbcw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010131
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

Add a common configuration fragment for EFI Secure Boot and the
required hash algorithm configs to reuse across Qualcomm boards.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/secure-boot.config | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 board/qualcomm/secure-boot.config

diff --git a/board/qualcomm/secure-boot.config b/board/qualcomm/secure-boot.config
new file mode 100644
index 00000000000..21f567e1a45
--- /dev/null
+++ b/board/qualcomm/secure-boot.config
@@ -0,0 +1,6 @@
+# Enables EFI Secure Boot support
+CONFIG_EFI_VARIABLES_PRESEED=y
+CONFIG_EFI_SECURE_BOOT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_SHA512=y
+CONFIG_SHA384=y
-- 
2.34.1

