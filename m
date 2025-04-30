Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F303C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 08:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAB48216C;
	Wed, 30 Apr 2025 10:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Q4uq4uVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CB682B07; Wed, 30 Apr 2025 10:55:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66D58215E
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TLb4dr003467;
 Wed, 30 Apr 2025 08:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=B1pFUlTXnrBjXynSf6spne
 LoNlXdCyb/o0jO27AkNeA=; b=Q4uq4uVzPvom1id9cWxZUeOtPdvo0xKnyGg9MU
 JInSQZbGepGnMi4hVZHxjOaOHaCpNho663L8fY2IVcecafCputVIZSrAuQfg9Dhc
 9tE/hjlKSUq2FtnWwiyD9o/7CTIbtg8ArKfjG0K/djoT1XvXq+/e9jh9silkrtfQ
 W9zS0nYQL6dZzMZm32jc+vX8EBLRLWhIGqJj+t2k14yQUpWWImEAiQ9FwzPl4G85
 bOQGkofLROHoFC2HKr77WtJlMigiNzEeHmyR1RqfugQePJtdTtt7DEGrPEJquQlL
 izku62VYuEzdS0Qo1eqdiL+CdKdVbGw0GaX2ADDQSqHERGvQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u89erj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 08:54:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53U8skBG024361
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 08:54:46 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Apr 2025 01:54:42 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <seashell11234455@gmail.com>, <clamor95@gmail.com>,
 <ycliang@andestech.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <sjg@chromium.org>, <marek.vasut+renesas@mailbox.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v2 0/2] Implement reset to EDL for qcs9100
Date: Wed, 30 Apr 2025 14:24:26 +0530
Message-ID: <20250430085428.1090801-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=B7i50PtM c=1 sm=1 tr=0 ts=6811e557 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=bjHXrqQkaGKjFDGHEn0A:9
X-Proofpoint-GUID: bihEu_R-lzcifhslPIOOIvnzy6LGbD-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA2MSBTYWx0ZWRfXzWzk/vKyBQRW
 mqDdE6LEw9E6HzUKKQapAAZthVo4Gp5tQoeW1G3xj4p0Y5qlI8upz0Jaa4lLETOjBea6DVSG7tw
 XX1mLeZu9/ednqSyVUQYgGICwMeUnviN9E2qhHu9caRmFCMLfU8PiWpmzJjeuABn4ieW0jxcMtk
 bBoI+9+ufjqyKR1c57jCFhJfFl5QQyLTlIaU9RRZcrlTkab7jbOVEaZ19gcuoSHXaRX78ycZqS5
 NDbnAkAu1LFuIcyCl/WG3c1f2LLW+Ji/dRoJcKlqXSlvygh2Mo7WTFAzVOKMVfXzc6QWu+Q3eee
 qIQnwpLd6gt/WIq7N7i8pxZSJ+qH2bNOzj22/ByUZh5DM0tZscO30KMrf1gwt/qzdK8UcQoYx8f
 OJNUgAN0qiBGdGw4tglpbNjkMruphmE9OoJDRMbHMcIcMokgJqQYY0hOjQ/pzvFJi8z02gk4
X-Proofpoint-ORIG-GUID: bihEu_R-lzcifhslPIOOIvnzy6LGbD-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 mlxlogscore=755 lowpriorityscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300061
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

v2: * Rebased to recent sources
    * Dropped the first patch as it is not applicable anymore
    * Bind the new driver from psci driver

Varadarajan Narayanan (2):
  sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
  configs: qcs9100_defconfig: Enable SYSRESET

 configs/qcs9100_defconfig             |  2 ++
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              |  7 ++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    |  7 ++--
 drivers/sysreset/sysreset_qcom-psci.c | 48 +++++++++++++++++++++++++++
 include/sysreset.h                    |  7 ++++
 7 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

--
2.34.1

