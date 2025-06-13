Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42235C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 05:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 963F182AA7;
	Fri, 13 Jun 2025 07:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="hGLvlEqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5097982B97; Fri, 13 Jun 2025 07:20:31 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9CA828A2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 07:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CJOWaf002604;
 Fri, 13 Jun 2025 05:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bYTt0XC364Hl5m9F8Y5YO4
 92fpUBm6T04RTosdL1S8s=; b=hGLvlEqgfinGDAzYOgkDQlAtLH5AbgoBjl0vuI
 U+HS0NGmn/jBAyK5Sm80BpIPBwwIBrqwzOhcZJBhfcNvYrTNX8pKnbDK/82/pN5W
 VMcObiWFY0AmMzMp03ru0IvVAqmXBfffMZG5M0fX1Qa+xL130rJLaWoCx5BYu2I/
 P2/TOk9vqOmoMHhP/YBc4nIKlphVUbnYMLHC0V7SWvXTsUPIGV0+r3JaIGUAPeXL
 Sgeym6V+HHo2Bdwj+Sg52FZYQW9q3Z1bT/oYAueL87vQxXMd6iq3b8D/d+uuNO18
 InKlUZCFRlsSoxfBTIFib4GTG9LU5JKwS62hV3Kb/+nsWi8g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jbpm4tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:21 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55D5KKS1025029
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 05:20:20 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 22:20:15 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <jerome.forissier@linaro.org>,
 <sjg@chromium.org>, <patrick.rudolph@9elements.com>,
 <clamor95@gmail.com>, <me@samcday.com>, <robert.marko@sartura.hr>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v4 0/5] Implement reset to EDL for qcs9100
Date: Fri, 13 Jun 2025 10:49:52 +0530
Message-ID: <20250613051957.3159564-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: NmVfaj_PJNLPnlGhA9zd_ZBOcjtMmnNf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAzOCBTYWx0ZWRfX0U5Uaol0ou5C
 M4vCAU5yCjvUYu2El6FZaffgIxjiLsBxipLXUM8idBhAgV/mtTrgcm8MD0zOJ8vz/upaq6NveEv
 aCWJtDI2gMgXHftswvuqYXo/uoZD9UCFCiIH3pHiDbCQbgTPDmrkB4Lf2F0hDpJ+hiGFAwZF4uq
 LvhnHhqWvmYBo0bngTk8i9hh7b6eZn+euKo7UaGImcJvDg3KIk+oa23gXmpqq6oxyqUZl9saboW
 gp49e8ToEBnu5hyVb2UztxjdnPn1RgoccPyiyQbOf47LiQFPS00CHTYsOXsdXEHqQMEVBi+mqPF
 zb7nhqYU1lvJyclyXeIbxqD6RBQVO6hNI/jS1wuqRQJ4MTm2b0yVzOORgw9dAtrEKwU7UQR3Ona
 Fwql5CH488RnutcXZ/MSBIL63klEkve2Gss7WYMDqwV579qPDN0/T5DcamnpCPAgyu37qX0a
X-Proofpoint-ORIG-GUID: NmVfaj_PJNLPnlGhA9zd_ZBOcjtMmnNf
X-Authority-Analysis: v=2.4 cv=OLgn3TaB c=1 sm=1 tr=0 ts=684bb515 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=wsBOlPFGP9gUABGrlvMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 mlxlogscore=821 suspectscore=0 adultscore=0
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

Using the 'reboot edl' command in Linux, the platform can reboot to the
Emergency Download mode. Implement the same for U-Boot.

v4: * Update documentation about '-edl' option
    * Add API to check for support of PSCI functions
    * Check if RESET2 is supported before issuing the command
    * Fix compiler warnings

v3: * Introduce a sysreset op that will pass down the 'reset' command
      arguments to registered handlers
    * Handle 'reset to edl' alone in qcom-psci driver

v2: * Rebased to recent sources
    * Dropped the first patch as it is not applicable anymore
    * Bind the new driver from psci driver

Varadarajan Narayanan (5):
  arm: psci: Add API to check for support of specific PSCI function
  drivers: sysreset: Add sysreset op that can take arguments
  sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
  cmd: boot: Add '-edl' option to reset command documentation
  configs: qcs9100_defconfig: Enable SYSRESET

 arch/arm/cpu/armv8/fwcall.c           | 15 +++++++++
 arch/arm/include/asm/system.h         |  1 +
 cmd/boot.c                            |  3 ++
 configs/qcs9100_defconfig             |  2 ++
 doc/usage/cmd/reset.rst               |  2 ++
 drivers/firmware/psci.c               |  4 +++
 drivers/sysreset/Kconfig              |  6 ++++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset-uclass.c    | 32 +++++++++++++++++++
 drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
 include/sysreset.h                    | 18 +++++++++++
 11 files changed, 129 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_qcom-psci.c


base-commit: b62e422d6e6878e9bca1d20fe372ffdd7db294fa
-- 
2.34.1

