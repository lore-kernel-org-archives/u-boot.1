Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA64CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB2D83F7B;
	Fri, 10 Oct 2025 16:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aKxwMbUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE6B083FCF; Fri, 10 Oct 2025 07:12:19 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0B183FC1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qti.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=venkyada@qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A1xrnh012475;
 Fri, 10 Oct 2025 05:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=KON6nVOhlmvXQsh7Q8No6+OwewAWrV/Af2u
 E4gD0AWM=; b=aKxwMbUx/0HJnfFT2gyXVrjzdtQieZl6JL6BvG35fPBvsrnVWz2
 aW1OphAEqSGFMNV3vYS7/Smhfso49nZ2Ojb9M5P5T/mbEViiEjOZ+tStvFTrP4tw
 27RQ04apmaG/zjWUSGbji8ko5p/IsZUlZChXaNIU78eFYqLzBwne6pizIxVvvg+Q
 /id3l9c/voDjMj2nssw+sS1WbHKNjE9rbglBYfQprTnu/Uf5NKzdMn6bR8E6iedG
 LPvDaTxJkhR6uTqSLP2bZsLrLekKcINVwA7Wm/9blpxecb2/b+0dM5Ek1Hvwzj6u
 3qGZHkpqnYAHN2CfrfaLif+tp8X3URnoYdg==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4kn5xf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 05:12:09 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59A5C6W1025354; 
 Fri, 10 Oct 2025 05:12:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 49jvnmhhwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 05:12:06 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59A5C6Zt025349;
 Fri, 10 Oct 2025 05:12:06 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-venkyada-hyd.qualcomm.com
 [10.147.253.48])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 59A5C6bZ025348
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 05:12:06 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4799199)
 id A25A45CD; Fri, 10 Oct 2025 10:42:05 +0530 (+0530)
From: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
To: u-boot@lists.denx.de, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org
Cc: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
Subject: [PATCH] qcom_defconfig: Enable meminfo command with mapping
Date: Fri, 10 Oct 2025 10:42:00 +0530
Message-Id: <20251010051200.2313081-1-venkyada@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e895aa cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=I2Hi_JKZDb_k5NqPZYcA:9
X-Proofpoint-GUID: 1CPShELU3kxPZlRtQ_vtqd3DuNYVXtrN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX/vaLInYU5Bw5
 TRqTII71AqzYf2RsG0RGhg4yVoTPWc1YP56PQ4tc96u3ExQ16QL+6MkIDBdv2bbrlNNrTtqvozd
 lqhx6MPh8wkEMtp7TyhCB6EoD4u4BCoE5mGqZL4kkgyLAdBAvAo/WGPCwrxs+neKfOOlOfCDfz0
 daCOZhryL+mygBWi1RiWR3nJapXBA9dT5DxbJAgW+NSfXLk4PaMmFQjEPjYQVVrfOGYUp7rFvH2
 JpwijsBMsSXruwRZr5jB+ie7UblfiEoYQfPtcK7SQgLeF76UsOKukrHIdB/ghq2Fpk6uAXvmA6G
 9ZnZbyH8EwQosE+3IipvjlmRTRRdEREa697ICmmTD2RD8I6D5agIuNbpCj6dc68kBesv5mSiwkR
 UZXNAT1mi9IRV+70WI/0LNawkZJRjg==
X-Proofpoint-ORIG-GUID: 1CPShELU3kxPZlRtQ_vtqd3DuNYVXtrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
X-Mailman-Approved-At: Fri, 10 Oct 2025 16:15:51 +0200
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

Enable meminfo command to be able to see where things are mapped.

Signed-off-by: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 8d1269b4634..4c00cf91166 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -29,6 +29,8 @@ CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_BUS=2
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
 # CONFIG_CMD_BIND is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
-- 
2.34.1

