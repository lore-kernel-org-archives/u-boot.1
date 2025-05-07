Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30B4C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 11:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 647F681F32;
	Wed,  7 May 2025 13:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Mn40RiEw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364AB820EB; Wed,  7 May 2025 13:29:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D49E88059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547Awvp4020079;
 Wed, 7 May 2025 11:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=y31GW9HOy5UhWbA4iftoGi
 6CrFp5c6NA045POtUMJTg=; b=Mn40RiEwtk1r0ybACnOCTRCeII+UrCIxFtEvy8
 /dx88veS2t2/G/6OAY5VVciU9xRci/ieXUmcPDkXQrotqn7ZIvcQynvjgFqajGUs
 aP27Zl+t0UkV3oBHgvEd9DYjgSkKQl0ZXreEsbvFdxnF9Qovudos8driFMDlUsTb
 /jLyTBPfr6F0hP/V05n9xE4cXT2bgfoPdDRGJtnFV28ILmxX35Nb/FxqS9hVVp57
 DrEm6yEEvp71n4XAiwNM3zqnCIcL42KaTt8y3bYPOXmi1VzJHiQ/azr1lBDpPtWe
 TMsqwliDWBLbx/yaUPT6ssCf7cZWj+tG2VQBxjMqwkzq+qdQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46d9epb0hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 11:28:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 547BScOa011950
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 11:28:38 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 04:28:33 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>,
 <hs@denx.de>, <sjg@chromium.org>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <xypron.glpk@gmx.de>,
 <cniedermaier@dh-electronics.com>, <ansuelsmth@gmail.com>,
 <venkatesh.abbarapu@amd.com>, <ilias.apalodimas@linaro.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v3 0/4] Enable env in SCSI
Date: Wed, 7 May 2025 16:58:08 +0530
Message-ID: <20250507112812.3066301-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=681b43e7 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=mQL1Am-uhmc7ytFfhkwA:9
X-Proofpoint-ORIG-GUID: A1vhml8_4eVpfelRPtsc8LHdk9uGjQjf
X-Proofpoint-GUID: A1vhml8_4eVpfelRPtsc8LHdk9uGjQjf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwNyBTYWx0ZWRfX5c3go6tdrsYQ
 jq8SKktjdb7MpMzeQc2Ra1o9VA4YJESsx9W5E/36tVNqabq2X5OhegEn1CASkepMFM7r2M8VoqB
 sIkq/M8F83WBOG174Zj4wY7EoG/6m0fXkdNO7LnJbIY9u4OeD+leW3kvLB+vcGvan2CoMnlq+O4
 N//RCY8OqmllxBh9yxjYt1HRJ5ZN9yYgqi+mjmPevtgDVreAlkHaCQ6gmTp2/vAXswDRLlZu8D8
 jhohXaqkJUWp4toRcu8jDgCekkOUHWQKpY6ms+b4U28F85E1Ew4kv/e1vcOx4wDUv/9eTTF7zHi
 A5XKEYHEc/dS3AuzeeTrpVqKA6CX4JJWTGCgMKByOnPycvRK5T3EKQQLepsLwrbMvM0ssI3vt1Z
 fMxKnADuNH9su1iL2DrCGxGO+QC7czOFxVNTz8XILcRohLRSjNAOWZOsKhIvC0fIpbQ4skix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=908 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070107
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

v3: s/scsi_get_blk/scsi_get_blk_by_uuid
    Fix argument name in scsi_get_blk_by_uuid

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
 include/scsi.h             |  10 ++++
 10 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 env/scsi.c

-- 
2.34.1

