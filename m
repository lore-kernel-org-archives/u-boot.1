Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F260C54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8929382B8E;
	Thu, 29 May 2025 17:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDVQxrAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B6C81FFC; Thu, 29 May 2025 17:49:45 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 234568305C
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1QDa011700
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ZehaovK0q94SwHR2qz7ym+hLwHwj9FI2qB3
 cbixx8JQ=; b=KDVQxrAN9H6R9JB6fvBsVRljAyZ0gklMsujKr7V2fO8PmKMbNyI
 DA6OX9SbMVk//1B8BOFYiMEcRSM4YMVxVEgJqkrVntV5fnfHol93bKXmo1jUtVHo
 ZzughpuGy1Xcb8pMx7VT2fBzPRkmqnjBXh+2mTPJItpDfUmoHae0wPkYrwJ7dTZ8
 sVPrCSFPXm6mIHWQzgCb0STKcuwPTwJwmrQI+BGqoOtxTPDdYndTUmn/hdruyvZO
 X8DB8L6ogXVRoli1giUqt+nkdWQToFLQGYNp/B0eqpHx8/RazgW2WpR+4I5jJtPj
 1ugwcLsT0rRhG4kwZuvmd6S1LsQKn/sbrEQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u6g9681m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:49:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2349498f00eso16291225ad.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 08:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533780; x=1749138580;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZehaovK0q94SwHR2qz7ym+hLwHwj9FI2qB3cbixx8JQ=;
 b=f4NmT3NyFM6jPHlQp1Qs8ChFfG85b0VOLLe+S2xQeKdHC+rYoO757Cmj+oyIUEZYlv
 FpcDL4s0vzrlt28M362TK98yDJYF8sAL5Du+878XeWfaJ+QqScMDntXVOgB72IF2INU8
 hKs3A81/X5j/H2TUwiW6VGzfVQUaD8InsxqsllZF4rfMiNrZ8m79t08NgCmMzbaceNbO
 fFDU6l+AzS3Y2hfNRRb+7HffUjWSbkouY8mb5S/FnD7lWSV3AgKrusYs75kpSz8n+2ZP
 /qxGya/OIHQJCyBGSEMzGyPYw0kBFeVbekXUxwtiWDRAYVQFI6oN2aJG/CjFy1O61U5L
 GUqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ9ITiGuY/3weUgPgCIW/s+STSxU/otFK22QeMVxRyg4SiIvxoV6tr1lnxA+8C2vqJVgd4s2Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yyc+zoRtyjfg/1F+5mVjT5J8VsqCxwML9dHvhrlJIwgs5ukq/nB
 8kIqN7bBtna6gmBOU0utipkcosjvfK8uc/WgNvL7Fptf1CeFOPyDDiXHEH3gLQxjbYkrt7whrlV
 Rqurr980n1gBib3DhevFx3RQ1Ni+Yfgej/I0YApuJWmqk/rtHJNT1ix86
X-Gm-Gg: ASbGncsPDFinc7uveEAEduhl7uPHlL4fmotSLMOCLF7jffEyaz0HL3bDik5Qc/6lqle
 oqWRfcYPSCbU/0olEYo5lgF54YF19LZvUJ+XviyyblfrNXTrWL0/4JIIg7ZETtf5ELInmv22PiJ
 q9Zr2uG1r1Bnx2L8RffEz+VO+l0xzRbY1bVbxaw+BZoOj9cy4CwJAQEeHzzaXFEQevXjQ6/AE9D
 3ZQJ04UwVDWRPeWvQDEpOEgt3l8cJIi9ff6wd8UeLe9zQCC9BXtlP8dGA4KMaOOlpwMDKvmk6CJ
 hIBNk2KQupj31rC3Wbx2qE5gLpDJgAfetZzpacAWxADY3sa5skInyiNzGvwqlWaP8VOTk7S8Syv
 xPIRTh/2pZat1zKS89hKL3Xn5XRQ=
X-Received: by 2002:a17:903:1788:b0:232:557c:2501 with SMTP id
 d9443c01a7336-234f68be83emr55658275ad.10.1748533780471; 
 Thu, 29 May 2025 08:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYm6mZYSMj2mOsnIFPre5WKYL7K0R9gXsPU3hEIzoHJO+Xzqg0rz5kMxC9HqUaCcmeRErc8A==
X-Received: by 2002:a17:903:1788:b0:232:557c:2501 with SMTP id
 d9443c01a7336-234f68be83emr55657915ad.10.1748533780030; 
 Thu, 29 May 2025 08:49:40 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf5448sm13879045ad.185.2025.05.29.08.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:49:39 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Google-Original-From: Balaji Selvanathan <quic_bselvana@quicinc.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Balaji Selvanathan <quic_bselvana@quicinc.com>
Subject: [PATCH v4 0/6] Introduce support for QCS8300 SoC based IQ8 Series
 Platform
Date: Thu, 29 May 2025 21:19:25 +0530
Message-Id: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=68388215 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UGsxJ-dWGZ2si0PSG8IA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 15OgwAsrz3bpejxMUYgz6HIZmHspX6Sf
X-Proofpoint-GUID: 15OgwAsrz3bpejxMUYgz6HIZmHspX6Sf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1NCBTYWx0ZWRfX4YEx359oynXs
 fAruJy8OGpojgo3/AGITlVFyJQjsKaB+JvmxlMAGoQay6Jy5OOqEsVBjsuaEp7ax3zZczoDjMEb
 Iw4V+M75C0sDtI+l3hu9Y6UhTQrlYAh59wmXa7/L0TAgPXB74h0U5T9GJT571hIyLT2e+ROrDef
 UqHuRa4P+cX/cS/feXgxuWFEKAA2XbI0Q1oXSG+Z3bR8QcpqISKgKG6RXAxoj1HQcaHj0y4ds1k
 7lPGi6gNhUFdSbi2st1n8gj3RIfWEgJ+Eu+C2JODZuruUR+RBG3WZBu3Bgqifd1p6iAqvXl1BRQ
 4sA/IEYb5ZR+Hse1iaVsfccGsxJRYrwbd13aawAN4lZsRBDXjN3o1Zk15pEm27jxWIPL60a1qfx
 oi0UrZzdaNIM6mH1UzF43lPosX0etu4WhChXS7cZ+Pthu+KDGNrwZp0xS3vifgPXjZOW7BmC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290154
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

These patches introduce the initial support code needed
for the Qualcomm Dragonwing QCS8300 SoC based IQ8 Series Platform.
For information on supported boards and build instructions please
refer to doc/board/qualcomm/dragonwing.rst file.

Please see [1] for SoC related details

1 - https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Updated the flashing steps in documentation in patch 1/6 
- Corrected the commit title of patch 6/6 to "qcom_qcs8300_defconfig"
- Link to v3: https://lore.kernel.org/u-boot/20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com/ 

Changes in v3:
- In drivers/clk/qcom/clock-qcs8300.c driver file, replaced
  1s with BIT(0)s in the clock definitions
- Link to v2: https://lore.kernel.org/u-boot/20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com/

Changes in v2:
- Added documentation file for Qualcomm Dragonwing
  series (doc/board/qualcomm/dragonwing.rst)
- Removed direct changes done to dts/upstream subtree
  (in dts/upstream/include/dt-bindings/power/qcom-rpmpd.h)
- Took care of alphabetical order in drivers/clk/qcom/Kconfig
  and drivers/clk/qcom/Makefile
- Took care of alphabetical order in configs/qcom_defconfig
- Renamed "configs/qcs8300_defconfig" to"configs/qcom_qcs8300_defconfig"
- Link to v1: https://lore.kernel.org/u-boot/20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com/ 
---

Balaji Selvanathan (6):
  doc: board: qualcomm: document Dragonwing board building/flashing
  dts: qcs8300-ride-u-boot.dtsi: Add memory entry to bootup
  clk/qcom: qcs8300: Add GCC clock driver for QCS8300
  phy: qcom: Enable QMP UFS PHY driver for QCS8300
  qcom_defconfig: Enable QCS8300 clock driver
  configs: add qcom_qcs8300_defconfig

 arch/arm/dts/qcs8300-ride-u-boot.dtsi |  19 ++++
 configs/qcom_defconfig                |   1 +
 configs/qcom_qcs8300_defconfig        |  21 ++++
 doc/board/qualcomm/dragonwing.rst     |  46 ++++++++
 drivers/clk/qcom/Kconfig              |   8 ++
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-qcs8300.c      | 146 ++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c   |   1 +
 8 files changed, 243 insertions(+)
 create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
 create mode 100644 configs/qcom_qcs8300_defconfig
 create mode 100644 doc/board/qualcomm/dragonwing.rst
 create mode 100644 drivers/clk/qcom/clock-qcs8300.c

-- 
2.34.1

