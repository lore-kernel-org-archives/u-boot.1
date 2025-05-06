Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D46C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8381F8007D;
	Tue,  6 May 2025 09:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="XBsyNLR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71318007D; Tue,  6 May 2025 09:25:30 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5699080050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5461Ac7K008829;
 Tue, 6 May 2025 07:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pEgbGUoRpepoRrRxp7u8v0
 H4LP6MtdYFJ0n25pqnRMQ=; b=XBsyNLR4hCcNsRzpznuEpXI/a12S/WbITA+wem
 9Nt/BgpX2R6LDLYJXWDtywalsZc8AIFzGOnfGuBDjfY30i98UmTs3yFgHAQYOQzm
 8UxtOadT4F4HsCsCij/NDVvs6KEEqtTO6n8huZ3dZEjduFvsjjr4iFhBNw7Hywyx
 xZRhoKqaA9yybVXIH6TwhNjBhrCXL1haO+OvaSzl+fLpzujWusvwtNABF5sZqY9W
 yVe9FymmBXFnmeW4a8LlZrotpF54Xz+p9VJTN3Jh+/Xl58RHI+99KgxSPIx0k+P6
 +269GcKy71hRFZgt933egIIIiq5oeD+sov/s1S9r0L8kcAwg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f8gw0xbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 07:25:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5467Ox6J008857
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 6 May 2025 07:24:59 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 May 2025 00:24:54 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <michael@amarulasolutions.com>, <avromanov@salutedevices.com>,
 <sjg@chromium.org>, <hs@denx.de>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <cniedermaier@dh-electronics.com>,
 <xypron.glpk@gmx.de>, <venkatesh.abbarapu@amd.com>,
 <ansuelsmth@gmail.com>, <ilias.apalodimas@linaro.org>,
 <mkorpershoek@kernel.org>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v2 0/4] Enable env in SCSI
Date: Tue, 6 May 2025 12:54:11 +0530
Message-ID: <20250506072415.1970069-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: PMb2mAiStatcH7TBG37ty2TzIpH5-wus
X-Authority-Analysis: v=2.4 cv=fdSty1QF c=1 sm=1 tr=0 ts=6819b94c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=mQL1Am-uhmc7ytFfhkwA:9
X-Proofpoint-ORIG-GUID: PMb2mAiStatcH7TBG37ty2TzIpH5-wus
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2OSBTYWx0ZWRfX8tE0qaLki+4t
 WpLfioZEc14SFO0wLi4aTkqNpYzKBhw9og+fyPVbZDBD9y3p+doH8Hyuky2PQzWtgef9pB8E0It
 IDmaWAEZbnCmhDmS5U/OJwfK6W894Gty2Xas/WOVKNjeFepXz2VlRLfc9F68+nIcMZohauElbYz
 +8fVMC4v3C2TtY92IpUHj/8mpjpRCXcUvXb2hwwQbjGD6rHZ8WlwClUm0Gz+051wvLRPzcYjEwe
 OJDO4VoCSOLM91Xb9u+Wz+vU0ymrnNqqJcEWGOSV8JJCFHZQPfEumKBZ82KJFCQ9KT25j5DjKP/
 ZEkzl4YYQDeQ8ChrSXFSDzjcfbgiHze0SVPg9V/6HzSEmw7IZH2I4J5FNIhp3ke+ZTqUrepIbq5
 0zETCTrTx4uFGcUMFGLgECu2vIJtr0CI6cHlefzoWp2mTZXAR9KEdhUPj0Qc5yL7I3419MuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=798 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060069
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
CONFIG_SCSI_ENV_PART.

Also add an API to convert partition UUID string to block device
descriptor for UFS. This API will be used to get the block device
descriptor for the partition specified in CONFIG_SCSI_ENV_PART.

v2: Add part_get_info_by_uuid() similar to part_get_info_by_name()
    Use SCSI instead of UFS
    Use UUID for SCSI_ENV_PART instead of name

Varadarajan Narayanan (4):
  disk: part: implement generic function part_get_info_by_uuid()
  scsi: Implement get_blk() function
  env: Add support for storing env variables in SCSI devices
  configs: qcs9100: Enable env in SCSI

 configs/qcs9100_defconfig  |   5 +-
 disk/part.c                |  37 ++++++++++++
 drivers/scsi/scsi-uclass.c |  30 ++++++++++
 env/Kconfig                |  15 ++++-
 env/Makefile               |   1 +
 env/env.c                  |   3 +
 env/scsi.c                 | 115 +++++++++++++++++++++++++++++++++++++
 include/env_internal.h     |   1 +
 include/part.h             |  20 +++++++
 include/scsi.h             |  11 ++++
 10 files changed, 236 insertions(+), 2 deletions(-)
 create mode 100644 env/scsi.c

-- 
2.34.1

