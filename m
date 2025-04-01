Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286C0C3601A
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1430D81F6B;
	Tue,  1 Apr 2025 10:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="O7UhFqvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2FB881F7B; Tue,  1 Apr 2025 10:01:06 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E9681F44
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5315oIbd031690;
 Tue, 1 Apr 2025 08:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=jvSTqc2cwyNSS+iVcEfItO
 mF0mW8SyVEjNPAsP7Ogog=; b=O7UhFqvu4T0fuckEnEZwQ5YtMdR6nmU1gVHkaG
 15sKfFC4sUG3scGlRfQEaH1DeP8V+JK1RBgn/X7XlkBnBYnz73PE8XitcfykxWmK
 f572Bug1cCrKBxwaCuvNfxzs8URzOyG+HVcCwfRU5U5vAJW8hkdjQQy0goMYhNfm
 QBkYip79uu8d2IrY/dUM/yXsco3+MXYGTvcxwvaP9UOrkELKgiyPv3ZZpQFqRxcX
 4u6Mn0Es6qVwmnrTg4HgYvo39wAsBYwbxR1UiUdXt73wVZ+hUGwO+piB1glP/wYi
 agsBDIM434J/ovc8D1Hi+E7AjluRLBdDoNVu6e4AXiqo9JNQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45qxa7t2aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 08:00:41 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53180f49007798
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Apr 2025 08:00:41 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Apr 2025 01:00:37 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <cniedermaier@dh-electronics.com>, <xypron.glpk@gmx.de>,
 <sjg@chromium.org>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v1 0/3] Enable env in UFS
Date: Tue, 1 Apr 2025 13:30:12 +0530
Message-ID: <20250401080015.1470999-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0eiPQUeaiKnzflzcZEgjADtJIcVF6LR8
X-Proofpoint-GUID: 0eiPQUeaiKnzflzcZEgjADtJIcVF6LR8
X-Authority-Analysis: v=2.4 cv=J9Oq7BnS c=1 sm=1 tr=0 ts=67eb9d29 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=mQL1Am-uhmc7ytFfhkwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=684 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010052
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

The qcs9100 based Ride platforms have UFS as their primary storage.
Hence add support to U-Boot env framework to be able to save and
retrieve the environment from UFS. The environment will be
saved/retrieved from the partition specified in the config option
CONFIG_SYS_UFS_ENV_PART.

Also add an API to convert partition name string to block device
descriptor for UFS. This API will be used to get the block device
descriptor for the partition specified in CONFIG_SYS_UFS_ENV_PART.

Varadarajan Narayanan (3):
  scsi: Implement get_blk() function
  env: Add support for storing env variables in UFS
  configs: qcs9100: Enable env in UFS

 configs/qcs9100_defconfig  |   4 ++
 drivers/scsi/scsi-uclass.c |  30 ++++++++++
 env/Kconfig                |  15 ++++-
 env/Makefile               |   1 +
 env/env.c                  |   3 +
 env/ufs.c                  | 115 +++++++++++++++++++++++++++++++++++++
 include/env_internal.h     |   1 +
 include/scsi.h             |  12 ++++
 8 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 env/ufs.c


base-commit: 244e61fbb7f5045e4e187024f7ae80434c952145
-- 
2.34.1

