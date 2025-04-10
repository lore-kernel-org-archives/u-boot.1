Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C20FC369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E581683BD3;
	Thu, 10 Apr 2025 14:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="fLzWqE5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3C283BD3; Thu, 10 Apr 2025 14:03:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F967839F3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A75Zhx031989;
 Thu, 10 Apr 2025 12:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0BQ41UeaUGFgf8LlnyHn3O
 evg+p5jDceRGZ0hV+eBjE=; b=fLzWqE5hUSmZ0cQuPkLxACx1u5VkQ2hLzRl9Pf
 pxrfRkYNOJ5hoPkg0OwIDqzWc+Inbg6M0az5HR+tFRCkB3PHpE0OPolvcIu1xEto
 C+NOgAzPjhwAqbBxcYtbb16ZRBzD5B7SEwZwBFFHmNpdEgCP/2P5gGVI3Ot/N1CR
 qcxiuDsut66y31bt0JJGTDPzLmzHkO3dzs5D1/AdiYb/zDRZpPsxcGnsSYBAXJV0
 Bqn6qzrJQUktc+a+C52WecCmCtgTVflNdPlkMvy/AsKsEh9ySVJHiJCO+8k/djLo
 BH7AqWuj6g2cp/2GoNc9nFYJCuO1b0lLHcZpF6O4AZLe/1lA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twpmerjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 12:02:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AC2hHt004922
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 12:02:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 10 Apr 2025 05:02:39 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <sjg@chromium.org>, <ilias.apalodimas@linaro.org>,
 <sughosh.ganu@linaro.org>, <me@samcday.com>, <marex@denx.de>,
 <quic_varada@quicinc.com>, <robert.marko@sartura.hr>,
 <seashell11234455@gmail.com>, <ycliang@andestech.com>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v1 0/3] Implement reset to EDL for qcs9100
Date: Thu, 10 Apr 2025 17:32:05 +0530
Message-ID: <20250410120208.4142087-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: bqFjDTOaZxaRgugwxrU7WwrefN9eDEG-
X-Proofpoint-ORIG-GUID: bqFjDTOaZxaRgugwxrU7WwrefN9eDEG-
X-Authority-Analysis: v=2.4 cv=MpRS63ae c=1 sm=1 tr=0 ts=67f7b364 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=_6QXyiwuq422Fm4OzwEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=671 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
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

Using the 'reboot edl' command in Linux, the platform can reboot to the
Emergency Download mode. Implement the same for U-Boot.

Varadarajan Narayanan (3):
  mach-snapdragon: Do not define reset_cpu() if SYSRESET is enabled
  sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
  configs: qcs9100_defconfig: Enable SYSRESET

 arch/arm/mach-snapdragon/board.c      |  2 ++
 configs/qcs9100_defconfig             |  2 ++
 drivers/sysreset/Kconfig              |  5 +++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    |  7 ++--
 drivers/sysreset/sysreset_qcom-psci.c | 47 +++++++++++++++++++++++++++
 include/sysreset.h                    |  2 ++
 7 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

-- 
2.34.1

