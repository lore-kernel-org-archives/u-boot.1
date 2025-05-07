Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E13C3ABB6
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 07:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E182481F66;
	Wed,  7 May 2025 09:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="BnSmBvUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E28482102; Wed,  7 May 2025 09:08:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B288007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 09:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471H2Se004250;
 Wed, 7 May 2025 07:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6V/H3LpfyXiYG/jFgUnJQG
 sz+zE9YS6cNNyextgwQ/E=; b=BnSmBvUHuEY43xh/N8Vg7GdnXm07w10r33ADeo
 ORwE6uBAmpjHaFirpfqwmQYB+V29UN/oDi126iSo4VQ4nT74Bd7L1zRlxcW2/rpH
 ghkKxEXlA+1jjh9DGF79k/mWZeSw3EHYQJPid3si6Tfa077RrdIIeDuDekQ7Tx4r
 mluGZh8TkMx+F8PdZraWbx0bYcpAL4UsFCIXLqyBbglwh+Kx23rsLtr7PhMsXoif
 Fu9fF9w3t7W7iH+RoncgqVqNmpfye5zF8g4mUBI1nNoJoKPtczuBBN35yeSQAHHS
 R29wh36CKfGvoJXLxhAbDT/MwydvPCt7WQGFSJ2keZGLkb4w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fsmt18w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 07:07:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54777ps8002933
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 7 May 2025 07:07:51 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 00:07:46 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <casey.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <clamor95@gmail.com>, <robert.marko@sartura.hr>, <me@samcday.com>,
 <sjg@chromium.org>, <marek.vasut+renesas@mailbox.org>,
 <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: [PATCH v3 0/3] Implement reset to EDL for qcs9100
Date: Wed, 7 May 2025 12:37:30 +0530
Message-ID: <20250507070733.2871986-1-quic_varada@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=U9KSDfru c=1 sm=1 tr=0 ts=681b06c7 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=wsBOlPFGP9gUABGrlvMA:9
X-Proofpoint-GUID: k1LYh0fmMrgrKWlQqENJpuTAQWnriuAA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA2NSBTYWx0ZWRfX1UOTGRfQj946
 mauDjw9IHyOMKu8Qt4hOBv4y0L4QWQTqB1I8OkRJd92U9P0dCh5FA3h3qZTlgUuo2A/KtPsdgqN
 I5mRVGf8zaGU6PlQ9uYMTJkd8zDQBj7H0DmgQxTt2kEl7dk4l2+YZLdwR+l+dJbwYK3opgEgCAY
 9GI3BcYWq/YUJ2tbks7ydvepkrj7Tk5V76iVDGsH1adPTo1EjyVsDdCYyAoLblxnIQMXTpzoTD1
 5dRrXrHHKipFQ7zdEyH63YKl4s9hNPatJWLh2tVbzYAFrMNvfCfFcarQvXNQZKnU5y1s1DZ0+/A
 4VHpTsRUeWneNdJ7bFP1M1nfDM0VJ0OOBf+YRuZmj0pAtwSdd7gM2HmxLwmQBKBVcTWpvuQnMlR
 384Z/9elYgCHqr4dxgaeKQSojeHMjrqtx9waLPAHjxin+hCOh/geQOjdEkw46sT9/Yb3Syj5
X-Proofpoint-ORIG-GUID: k1LYh0fmMrgrKWlQqENJpuTAQWnriuAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=768 phishscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505070065
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

v3: * Introduce a sysreset op that will pass down the 'reset' command
      arguments to registered handlers
    * Handle 'reset to edl' alone in qcom-psci driver

v2: * Rebased to recent sources
    * Dropped the first patch as it is not applicable anymore
    * Bind the new driver from psci driver


Varadarajan Narayanan (3):
  drivers: sysreset: Add sysreset op that can take arguments
  sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
  configs: qcs9100_defconfig: Enable SYSRESET

 configs/qcs9100_defconfig             |  2 ++
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              |  6 ++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    | 32 +++++++++++++++++++++
 drivers/sysreset/sysreset_qcom-psci.c | 40 +++++++++++++++++++++++++++
 include/sysreset.h                    | 18 ++++++++++++
 7 files changed, 103 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c

-- 
2.34.1

