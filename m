Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A04BC54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A772F82D6C;
	Wed, 21 May 2025 11:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OdaK+Otu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A5D82DE7; Wed, 21 May 2025 11:44:57 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE01182D59
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XUZ4016660
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=yw5xXvs+Tio8eKePNJBkpE+snq4caB1N0eo
 uJ+de4i0=; b=OdaK+OtukHHYvfbvFXSmO8re3p2x+wQP6pURkyWTIS0zh7xyal2
 pJOEzTn0qz4JVkoHvB6cBbAnvoBPinkEjPu3PV24/OgJFyyR1ZU5xjYwFtCDUdl8
 GGX8DFlY7svsKOtGj4Tp0hwaPlKJAOaQk6Ip9/gIBC2g4uVC6ddwHP8hPCLpgzX8
 6LB7bYyY2aZVXbHRs8Z3cCpWpj5/5hblcrWE9ayghYyXaqx739iybDS+rvJV2WtR
 S11wAcr7js3aRjcusFVr4Qb3nOtfqFVzR/Ozr7BNIyljapMjATQcrZifrFimd6z6
 I3Smyv4n/+UVcl4hLXzPZFLuDUENDCH4Ccw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9ter5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:44:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30e8346b49cso5312575a91.0
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820692; x=1748425492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yw5xXvs+Tio8eKePNJBkpE+snq4caB1N0eouJ+de4i0=;
 b=IICTEYjNNcoOpPMKUdQ4KGZodEdfHLZ7/DMm4ZFGUIvcQjykVhV2HEHmmWz09G3sH8
 XRTgKts0F+vl1KgQ8QW7b0/ejmGk/795xS+iUhcXGTwVfXWQuaJftMOoiXufEhFXibf5
 J5mxiNhOsUjmU1cciqy+ICC7ZsLzqvFxcGcObZ+hhIKNKB0iC5KkXZVgBwuV1PnS1gQ7
 hoZb52n3Bq+whrtahGxifqA/nnm0Sd6105pGrCnsJUroIY68vE1YCHKVvmHibf59swyx
 sOjK/OXlkSdj2BCXqgJiFtWlZ/kYuJXrNGmEjanTxXmRNt259u9n9ZqjmUzpZm8jPtJZ
 PV3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSLnU+2FpDF2yEDcKYzzz/r/ub5Byz586APdJpE7jVMdVUv2fXOg5uIjTf+W9kc4I0WdSavyY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6XXx5vB+/EY4k99nZPJdUOVmp65h1m/2GIpt4jTv+uNWTkavE
 aYv+TyBanqFhua+fNd6S5XSkwnLCP4NAo0kprLL5NybD/mRv1Z8VJktfKUOZZKsIw2s2J1NZyBf
 QRzTJrUgHuLaZv9dGbIRQZpn9J2kHsMWijOvw41AHB5DTG0vnLZ3hoJM0
X-Gm-Gg: ASbGnctEPgubiPWgEvmQ31u9fhkRyjEe6zNP0RPvkmqxl7M6lgx3D+RD6rWew7VoGyT
 KX+KUYf3+dt08ysLTyvpKfTC/5pXsZ1UpqhoFB/G2AV+1MFTlE2x3NM4pF2BKw6C+FSKw39nveI
 OE5WzPmozGsWmA4LmfUKmJ/bEKZHmXfFpeCya0jZKVWgshMi8tyMZ2IGpixLqLbEXj2q582VB1I
 VIJCO45j1iiXKO5yEcFK1C7ZOFYVv0HCO1zROhW76l6HNcJl5qz4Z008DO/JAg2iLpDkXrERMq/
 b/D5to9UCe/bAhtCrcY+YgLuUBbj6GSXSNnKEds8jtNNIQ0t0q76JueKtWWR8s1Al/AaFvjSaRS
 JVrUOJvC5GU+wxYwXFCD1MKZarnsy+yFOx95fMAWO
X-Received: by 2002:a17:90b:52c8:b0:30e:382f:8b86 with SMTP id
 98e67ed59e1d1-30e8312dc73mr33829628a91.15.1747820691795; 
 Wed, 21 May 2025 02:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEChEj7nXAB8v8cdyVYctNqhHwdgq9iabw2TUKQ9tpJWPEXzbdsAV9qLgJqVsviKoZwFRCpmQ==
X-Received: by 2002:a17:90b:52c8:b0:30e:382f:8b86 with SMTP id
 98e67ed59e1d1-30e8312dc73mr33829595a91.15.1747820691355; 
 Wed, 21 May 2025 02:44:51 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650000csm3226367a91.37.2025.05.21.02.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:44:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 0/6] Introduce support for QCS8300 SoC based IQ8 Series
 Platform
Date: Wed, 21 May 2025 15:14:36 +0530
Message-Id: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682da095 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=plaP86i05TW429YolQ4A:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Feemu-kxcU3dy3hC25MJ0oE8ghi5kGr0
X-Proofpoint-GUID: Feemu-kxcU3dy3hC25MJ0oE8ghi5kGr0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NiBTYWx0ZWRfX/dt/2yPOCSrs
 Xs9v1WlQeT2bBzjFWSqNwMcmqgFzNUhGh9GSF+hvqxX0c/hyBxxxIQGwSUnQif+UkupUUIafRWa
 mp7RghYdqrwrdsB/LsKI36YiUTuZrXkA27+dhEwT1LCJxIyk2hjsCvVmWTQmBr0sW4+Z9Mn//NP
 Jy2O/XkVmjYM5vag6L9YqBhtzio1gA5FR46AS21xCo4BOF5jqcB3DTtP/8ExdwRBcWhc3lNLrnL
 ciZSvqtSc/fbH1OHEtqKYS3MHyeO92ve1i16SF/q/HEXCH2yEcL+jsIbzWNzSYYzF1YadcT3iiS
 0HAw7o9ujmRo3WwlUtgUeZmmeRyg2tHfDwRXzuJTYrsMy2RPMSMscuOz8+h8fK0brSfswIGIUFB
 Svyjct2iYfEOiUkdpGuL3VEMMLrohrbBj4+hZB1juYBptm6C/uayhPT6XZVzveXrsWm9XTON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210096
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
  configs: add qcs8300_defconfig

 arch/arm/dts/qcs8300-ride-u-boot.dtsi |  19 ++++
 configs/qcom_defconfig                |   1 +
 configs/qcom_qcs8300_defconfig        |  21 ++++
 doc/board/qualcomm/dragonwing.rst     |  41 ++++++++
 drivers/clk/qcom/Kconfig              |   8 ++
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clock-qcs8300.c      | 146 ++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c   |   1 +
 8 files changed, 238 insertions(+)
 create mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
 create mode 100644 configs/qcom_qcs8300_defconfig
 create mode 100644 doc/board/qualcomm/dragonwing.rst
 create mode 100644 drivers/clk/qcom/clock-qcs8300.c

-- 
2.34.1

