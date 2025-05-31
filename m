Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2979FC5AD49
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C4882B70;
	Sat, 31 May 2025 05:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPXG6EHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4587D82B72; Sat, 31 May 2025 05:20:21 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE7882B6B
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54V0gr7a005256
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7Gda5vbXfniSQoKyuth3MIZkGAgJLpi/KLQ
 i/+N2iWE=; b=cPXG6EHxaWMfi6epa/ziq9WyrZCzQuR1Psc15EBjJTP3YV7HnvA
 BShwBLZQ2QrN1J7sInmHx50RSTBJQu9Q8YnRWnfXbR0iA50J9jxbpZ+4jWPdUmoS
 QSumFtPgts/eEvP3WRUmL7K2Z1ht++Hm6PR7l3iZ++Qduj4CpZlbYZw8gMulrlF5
 hTtXFkpFwK8UvkloxQA6N6Sxe7R87zrJRApElo978baf7cF4Wz/5S+GZNQJ/Tu6W
 V6pRlMzHjvoqi1/IBgREmcsJRd448ZlQxWwZPkVARkoDPbsZvnVSStZqQ1bHscAh
 kGZ7elBM2HX/wsiXy3sjn64Pdc2YnYAMyVQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46yqfj868h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2326a6d667eso24645625ad.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748661616; x=1749266416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Gda5vbXfniSQoKyuth3MIZkGAgJLpi/KLQi/+N2iWE=;
 b=s6APNDfVKOZzCzB7wOJ8AnDRGeDaU5LFtpmm1h3TTb6Ly8b2KycyL5em/U7bS19Kla
 W+yuv2bHzxmbxJ0X+069leDzfnmjXLw5pXxNJ2CErRR1WR4gbKbBEwwdrnoCd2d1mW4c
 IxoeLHWnyvyDgrZdb7/A/c4MshQ62xJmE5KLg13Am1BdKaC+f3cexx6mWiDiNVDYoV9l
 KnsKsNEVQWRU1yLkxnYNz5/zVV121KSIsBpVvgbZUTcD1rsuIiAMJ/nv9RTndA+QDUHZ
 hB9pKkRHnPdB3rxbbJV/Ijw4/UoZAx0PdotayvdXeeOSQ7hJvJQY8Ec0lIo78FXfF+Hs
 vR7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnyVD3otVzFufWRl5YC2wti25gD4wHuEqPvqjDLZwzTHb9CJ5AGLAnH3pCwzTjIZXFNthm5Cs=@lists.denx.de
X-Gm-Message-State: AOJu0YzUp4a2TIm0ZKjfJ0MCaUDv/TJVxm6dOr1eoDiAdm7Zh1lPOrOj
 OQ/wH1mnNTioqPosApbcUNXhK/7a14F+oCG1me+sAToh+hsBynOxRLKjVQKeKgIcMnAZphFVIFz
 3B/f3b+70iG1Ed7sp4IwVf95N64MWJlNrnG2CLSdYO0C3nNEJwPL/+4vZ
X-Gm-Gg: ASbGnctYNC/wjlNbS7ZYaFGiEVWFu2YMCJAhjB9xKElyy7VKLi8bIJYT4SC+koa22Rh
 LOuL6Fz3+gj5nRhJs5Mc8h0LxQalOtME90dFlymWtUAisTzkW3ERZj/ecw0C8jXtVJjVGBcR3Kz
 O7cemSpJIg5CJJH7ySD5mc6sJTm9RiP8uwns4r7JTBDvHvnEeM6KrIn35zJ6yjuNUWsykrTcKEB
 gdDydMnp0WuDXGMOFRGd/zKsrwvkII/ghj2BeYrPTU9GmoVjmLC9Rg16kVFkAGnBVY9h3w0CQed
 wIsyDEOdIzhg6CLHxmHUMsFUrcOD3aFyRCFLqAByZI8Yd7vqVaW6e5tFJ4Mb2C1EI3dv9iRPxKI
 1WGj1K1lFH6wyjdR4P12UsUib8B7P8rD6m3EEodgW
X-Received: by 2002:a17:902:ea08:b0:234:d292:be7f with SMTP id
 d9443c01a7336-235291f9febmr83562845ad.31.1748661615961; 
 Fri, 30 May 2025 20:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6+6x5qttVcsdeBnEs4i5uw3n60QL+DDb5y6BbkrV0WwrVInpyylRdc4jtASL3vyasR9flmg==
X-Received: by 2002:a17:902:ea08:b0:234:d292:be7f with SMTP id
 d9443c01a7336-235291f9febmr83562495ad.31.1748661615527; 
 Fri, 30 May 2025 20:20:15 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2ecebb49d4sm1856794a12.64.2025.05.30.20.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 20:20:14 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 0/6] Introduce support for QCS8300 SoC based IQ8 Series
 Platform
Date: Sat, 31 May 2025 08:50:02 +0530
Message-Id: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDAyNiBTYWx0ZWRfX/Jq3ATP2VPIB
 JYWNLc+mgfK19rRccOV4sj2ugU+4P4U5805fnn4IzTUoHtt5XQoS1s3GCBKA+KI/MsFiEzq5kDW
 8Gv75VX9FsEFgtoo4mT+elgDLeu2Ta+M3dVgRfQHrgZv/7cIwTKqQcaVT356gdoO2MEnhIe8YnO
 UZQ/5CaF8WgqVDH4rFVHOg62RCtZISnuDNct8ZJhj5DMNRg4NyS4Qk9rRdt6RdeJQgFzjMdsYbl
 AzLWMUm10KZK11jhmS1HgREbrJ5v89mT0wTL+V+DEuy3cccBWaqVTrN81jD2GZdo49+QzVObT2p
 8qeMMIbS0blcjkzGIxNY6UpJRQ5q/pxciAykvSdF7gwe3mphVx5PeELeyqp7uebqpSXUD8eRj/x
 F8nIkt9TBKELaT3Xitys/jBLeNIOT+I6IuM/Shc2md3m3YvrXXyxGObYYTY77Xwoj4EfcXSN
X-Proofpoint-ORIG-GUID: qEBnP9JEcXZlckN7fPMyDFqn8ArP-zOA
X-Authority-Analysis: v=2.4 cv=Os1Pyz/t c=1 sm=1 tr=0 ts=683a7570 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=UGsxJ-dWGZ2si0PSG8IA:9 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qEBnP9JEcXZlckN7fPMyDFqn8ArP-zOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505310026
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
Changes in v5:
- Renamed doc/board/qualcomm/dragonwing.rst to 
  doc/board/qualcomm/iq8.rst; made the doc IQ8 specific
- Addressed the feedback in https://lore.kernel.org/u-boot/95052b49-dfdd-4a27-9c63-1f086d3bf23e@linaro.org/
- Link to v4: https://lore.kernel.org/u-boot/20250529154931.1879976-1-quic_bselvana@quicinc.com/

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
  doc: board: qualcomm: document Dragonwing IQ8 board building/flashing
  dts: qcs8300-ride-u-boot.dtsi: Add memory entry to bootup
  clk/qcom: qcs8300: Add GCC clock driver for QCS8300
  phy: qcom: Enable QMP UFS PHY driver for QCS8300
  qcom_defconfig: Enable QCS8300 clock driver
  configs: add qcom_qcs8300_defconfig

 arch/arm/dts/qcs8300-ride-u-boot.dtsi |  19 ++++
 configs/qcom_defconfig                |   1 +
 configs/qcom_qcs8300_defconfig        |  21 ++++
 doc/board/qualcomm/iq8.rst            |  44 ++++++++
 drivers/clk/qcom/Kconfig              |   8 ++
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-qcs8300.c      | 146 ++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c   |   1 +
 8 files changed, 241 insertions(+)
 create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
 create mode 100644 configs/qcom_qcs8300_defconfig
 create mode 100644 doc/board/qualcomm/iq8.rst
 create mode 100644 drivers/clk/qcom/clock-qcs8300.c

-- 
2.34.1

