Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16555C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 11:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4490F80AE0;
	Tue, 13 May 2025 13:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nN7biOrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 914468129F; Tue, 13 May 2025 13:02:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0808091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DAlrR4026485
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=5T74c1OwkIePMNPjDpP1jQPxgHMivUkGFU1
 32kViBfI=; b=nN7biOrhdLNNPiQ/H/kx7N/+P0eXt3GBeLf9y7Cvj05p7pziJbt
 XfR4PvsdFAAc7ahOXNAmTlFIOgNZ9kIzm2rPx8tOxJLm1ziaT5o7SG9HEagbamA0
 8hI2BrDFyIBmF2gUwJEWxqymO+5kS12WJsxWDRs1aR02CwUORcLImPVzh92rXasL
 DwXi+J/1eZKwZguplR5XYaMDw1Wz/P70LRcHO3lft17xTMas6IzxGPQDrRcmIMTW
 ZX5USH4UZ0n34Znemq9xLhe+SycY9or3z/ZPf7mtbIvCDQHLn1d5iJuPJed0hQLo
 NDoBwMq1eoOL1DHeVWxvFHZBtm09NZBZE4A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hv5qfsec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:02:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22fd34d248eso34991155ad.1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 04:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747134149; x=1747738949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5T74c1OwkIePMNPjDpP1jQPxgHMivUkGFU132kViBfI=;
 b=ZD7H/7tnnBpE6cOLFTK8R2fpZ2NbT/opEiJhAkvNKJ4Wk0jm2riIFB5CGvGqIRaBlm
 VB6ijsfpIkpK1ZHsey1/63CwzgW/ARChgydTctAVL61pb+cdk3DP5KmdDg0oNGSYq0Fm
 KPrCcK0VA/Rl455h9LAsQlesqdU05HirGeBaEmfiAgv8XXj/q2CC+Zemgp3eXQhNQX7p
 JwxXqdmhZg7bA6o5R6zkn0RGKC8/GYY+vYW7ZPcdTgCpPDZx7yFGr83Pvh1ErIKiZf66
 lYGh2OzN8+4qtyPKrzQIuwM20MD8qJ04H/lOD4RTGcw32pYt4mkV8iX9iUBMGKdFYCt+
 Pjqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNvk/xUzJTCGjwcd3itK5rK3GYnMCCtdbj/EdZPygI5oe3IxMmLJPpM/jRr2u9nMVm3ZHoghw=@lists.denx.de
X-Gm-Message-State: AOJu0YyuRJK3J/IHN0BlRJGC+5pbwOxhzxFw5oIQiluJbcvLmHbNe1s4
 9DHt+nuJzjiTseLW2uztvCnSBsJro0kvplQcrzzhWeMzaNpzYDmvQFOuUXS8ObGHbL6D3aPhz+Z
 Ir27Xh4BjGg1VUY0IMizcfMf5ddyLXkT3Cw2Ilg3oMkkDLVrOCJh4
X-Gm-Gg: ASbGncuoeXjG6huol0XDJN6MB8DvfP4YgdRRQrVfwNVcLz2SS+qxXwUXEFjFrmB4XeO
 fiLDmuK3zvbIwVhHIARCXkj6MbpLHU5vrUNWZS/TnWv3n4xce7nvMYwwLpNkI1s+2pQklRWl4vi
 i42BUs4F2ji5PX2iEGGuMyYkPGk1x7ym7DLQmRTag0bDJph7p8I2qaKcOEzAcz/QD0vb5Vhhd7M
 4z6SXeb10pq9djqFKJMjoATbZDm9tZkIa03ryUEC1bHEaEU6pc2MdUUyiWHQsJXErYqNXpQ4YT8
 Hae1JbG53TpD4hexxBzWQamuLM2XkdkZR4AO+QIr/UZsLdXtRwYMwzhlx277ICJ8kK3+dGRgg+4
 ceADEMWkrwxzRl4wjxO8cxtL17quD92o=
X-Received: by 2002:a17:903:3bce:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22fc918ff27mr271035655ad.38.1747134149134; 
 Tue, 13 May 2025 04:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoTwa2h3cal8HXtTcAAcbE9vPxC074PfsSMwxN3sePYaRjFHkXOB05RpaDjZncpkgjpiufRA==
X-Received: by 2002:a17:903:3bce:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22fc918ff27mr271035155ad.38.1747134148716; 
 Tue, 13 May 2025 04:02:28 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82bfa11sm78362135ad.254.2025.05.13.04.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 04:02:26 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 0/5] Introduce support for QCS615 SoC based Platform
Date: Tue, 13 May 2025 16:32:08 +0530
Message-Id: <20250513110213.330495-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqtW+H/+ c=1 sm=1 tr=0 ts=682326c6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=LCl8aBTIaau4ZeAHJBsA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: i_LMEX1Z7AOd7_q1xudM0FKhPkdaEg4G
X-Proofpoint-GUID: i_LMEX1Z7AOd7_q1xudM0FKhPkdaEg4G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEwNSBTYWx0ZWRfX9mnAq+d0uaY1
 F1OZFP740X9r9fytAHm3HDc2xqEtLYEmqZmTW1T1EHGwoJ/v2G+wEjhLGyJ7NvxD+GYoXif+Y6x
 uuMB08bwnLsWnDWeyLQFBhWQ+GbW7IV+YZZimfnlAtB/7V8zI9ztjYbIgzDWK7aroC6qyOp++BW
 ZbdVmX9OECEmyeuoItHHorGJiiYSbw2JOqKz55Yu9HD9Vl2ZvY2AoM5fQJLgGn38K6UdeWZQA4e
 81Romd2qbLMmXDMFqb0q1neHVcG4OW+IGiIR5LvZfkAAOGG2W+Q3fLv0ha97cxZ2dxX1Dmp76Bd
 7l/cLeToE8eKTgX0ZmXFvPInY+ScZqHSmJ5PebIPMM/bRQntZtxNyqJrq0O21tzJMrT1ZDyhDIz
 4MY0BQNSMhyryNK9Bhz3j1SGo7drdKy4jh97LeREl7dpiC9o5pmtAdODZpBJ546nbV5pSZ4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130105
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
for the Qualcomm QCS615 SoC IQ6 based Platform.

Please see [1] for SoC related details

Thanks
Aswin

1 - https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf

Aswin Murugan (5):
  dts: qcs615-ride-u-boot.dtsi: Add memory entry to bootup
  phy: qcom: Enable QMP UFS PHY driver for QCS615
  clk/qcom: qcs615: Add GCC clock driver for QCS615
  qcom_defconfig: Enable QCS615 clock driver
  configs: add qcs615_defconfig

 arch/arm/dts/qcs615-ride-u-boot.dtsi |  14 +++
 configs/qcom_defconfig               |   1 +
 configs/qcom_qcs615_defconfig        |  22 ++++
 drivers/clk/qcom/Kconfig             |   8 ++
 drivers/clk/qcom/Makefile            |   1 +
 drivers/clk/qcom/clock-qcs615.c      | 163 +++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c  | 127 +++++++++++++++++++++
 7 files changed, 336 insertions(+)
 create mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi
 create mode 100644 configs/qcom_qcs615_defconfig
 create mode 100644 drivers/clk/qcom/clock-qcs615.c

-- 
2.34.1

