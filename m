Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F31AC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A4B48129F;
	Tue, 13 May 2025 11:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="ULn7bNmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1316F81DD6; Tue, 13 May 2025 11:18:52 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70CA800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6O1uD022669;
 Tue, 13 May 2025 09:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=G9dIWMgMC8obL/dts460RF
 cZqLBs1FF6wUrP3bhg0ME=; b=ULn7bNmUK7rYClsXvIXqEoUAfkRVdKSf/6Gl5Y
 MdPuTTngxVSDD60ViqEG+oQENrFdVlLTpqCLu/BgMSPXINESx1FnP3OsZVkNU+oY
 gtg2iNtpbyI2It7jPk1BSgLJ+5dAVzFV+b5DdJg9aLZ9/4wqaPo7GL2Af43FFxYj
 xsUq1FSvr5a8mfTXKF5lpYawlBwa6/1YO77QUdmyc89Qyrz6yxcw5/nc7tT4M2mV
 iGuEFkKOTzRyLxCFIOxWh9waIdXWY4kHe8WLFPe6zwSiigh+LgPUF5LXAiRLWWNX
 2YDowjuBkWiByfUTHYoTMXBn90MBjceUNlHsNHvJs4d9JqMw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46kdsp3cmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 09:18:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54D9IMiG023598
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 09:18:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 13 May 2025 02:18:17 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <quic_varada@quicinc.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>,
 <sjg@chromium.org>, <hs@denx.de>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <venkatesh.abbarapu@amd.com>,
 <ansuelsmth@gmail.com>, <cniedermaier@dh-electronics.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v4 0/5] Enable env in SCSI
Date: Tue, 13 May 2025 14:47:05 +0530
Message-ID: <20250513091710.3719292-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: ZkyMxPwkO30pIzIaSvnzqpaYava2ZiN-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4OCBTYWx0ZWRfX7oC1Vc1BvLtB
 xwq9jA3+Udx0g+Y4RYiHICYS7HyFmD+QQyguk2LlQyxVcfS/zr/2a2U3Aq6OHyxqfs/WZZj1dsE
 iQxy8biB3AWOs+pZwxFbjDooAwciXgnxATsMvYD2f0X/cSNHlOaf2v28dFy5CLMJKMbh2ptz+UO
 YhNoVZhoPVGc6YTXJHZfowIiIJQ6SUwkYStIZx7q5A2c07EecojjHD1Yq/Jm26xd2a2eOgIDoB2
 WtJ/28wD/BgdZXotFBajZ2mVGTFQVpjJV3uoS3ERcq2oVkAbsPuG+FHUS9UzKM2quCq+0zKKuof
 dpMx10d/HLt8ci1dfUj1R+BSlegESxZLVU4gsrAJKBf8ZMdyiWhSAxpLq7K5ntgOlx/40OEcqG7
 mw/hy8yEonmGezAAfHXkak7gvo3+ph6WW13VfW5UXVSyOvoQjnp/yHqFUZmTXD1dnR2NvQ4I
X-Authority-Analysis: v=2.4 cv=TrfmhCXh c=1 sm=1 tr=0 ts=68230e60 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=mQL1Am-uhmc7ytFfhkwA:9
X-Proofpoint-ORIG-GUID: ZkyMxPwkO30pIzIaSvnzqpaYava2ZiN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 mlxlogscore=921
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130088
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

v4: Use 'if (CONFIG_IS_ENABLED(xxx))' instead of '#if CONFIG_IS_ENABLED(xxx)
    Add documentation about the platform

v3: s/scsi_get_blk/scsi_get_blk_by_uuid
    Fix argument name in scsi_get_blk_by_uuid

v2: Add part_get_info_by_uuid() similar to part_get_info_by_name()
    Use SCSI instead of UFS
    Use UUID for SCSI_ENV_PART instead of name

Varadarajan Narayanan (5):
  disk: part: implement generic function part_get_info_by_uuid()
  scsi: Implement get_blk() function
  env: Add support for storing env variables in SCSI devices
  doc: board/qualcomm: document iq9 building and flashing
  configs: qcs9100: Enable env in SCSI

 configs/qcs9100_defconfig  |   5 +-
 disk/part.c                |  39 +++++++++++++
 doc/board/qualcomm/iq9.rst |  62 ++++++++++++++++++++
 drivers/scsi/scsi-uclass.c |  30 ++++++++++
 env/Kconfig                |  15 ++++-
 env/Makefile               |   1 +
 env/env.c                  |   3 +
 env/scsi.c                 | 115 +++++++++++++++++++++++++++++++++++++
 include/env_internal.h     |   1 +
 include/part.h             |  20 +++++++
 include/scsi.h             |  10 ++++
 11 files changed, 299 insertions(+), 2 deletions(-)
 create mode 100644 doc/board/qualcomm/iq9.rst
 create mode 100644 env/scsi.c


base-commit: 48db49b0977cc1c9c9abf82c0fb704238fcef4fd
-- 
2.34.1

