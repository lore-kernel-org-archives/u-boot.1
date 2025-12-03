Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF7FD1269D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F279583C01;
	Wed,  3 Dec 2025 12:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcEEOl9K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ego1pwAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4165C83EDE; Wed,  3 Dec 2025 12:07:53 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8400B83BFE
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3B3DCN1374603
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=PdkVPE0j5DoJ0lwvOkYudtYLKk9RQ5NOja4
 NGhWT+c8=; b=lcEEOl9KEIcXzAoFvKe/ROa1vCtXyMwEfOgwUxlfMVrSw6s6SqB
 3qBdgPN8bmydwdNlN9N7hRkYGpxxnHPDwyYaa8B3oOklZZMDk285n12AqflieYjF
 t7ajq2VwhLUSInjvzdEOgCs6InCUj/Ke7AdBEAwbt92u5K8vJ28/9FxV/jRkqqZh
 4Ta1fqWHUQO09USU6rPY+WY80Z/fCp/ngCuIKj9r2WNP++h2czrQbNqd/vvvNpzs
 kRNELY35eguvJEteVTZVMuAkzCWPS72MPYxHLkyG+Ypi0NAL21U6+exd9Fj1vpoN
 CIW2WPRFT8KILMlpsazJ230LXUYdtnUJoFQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm0b80g0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:07:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-297e1cf9aedso113973425ad.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764760068; x=1765364868; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PdkVPE0j5DoJ0lwvOkYudtYLKk9RQ5NOja4NGhWT+c8=;
 b=ego1pwAEdG7OJKJxSKoAfC39oM2EKI0jlZpYkS0RBSrPWlSA6Lqv1OYVtomunIvAaI
 92JlOLkcvpK3DjeLJuVKchYAHC05ECzSX6juUcE2sOegv2rA7xtyxSERSPzZJn6Hw/WR
 G70bxJAobxDugWKOZsZ0uf50izEDFFv1YvQNFY7Pm2fsfk/zqqGMxgT4S+USsXqdLBRN
 0qbxXthY5NnVwyyMlHHWgIwgaV87+Pgnu1pg64M1u9ZFmmiohmuHB47MY7FaCijYFZn1
 zwLNv6/AUPb9v+ft+OPhMmj6HgYlq9tqNqtb9EryDTIJdXm4J6K6XtvyoUYl8hNwFToc
 z4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764760068; x=1765364868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PdkVPE0j5DoJ0lwvOkYudtYLKk9RQ5NOja4NGhWT+c8=;
 b=ZaMPMWbZt2ODXCQ565NfTKcHxc3NnxcSV9I67YFErQ0DOh82BjGafu8nwfMQX5dA51
 4WmcA6h5tQK8edERbyrlbJsVhoZ7LJK90Bhn/AMioR1WqQRFKUb8jC9FjzTxjlY7K7xw
 Yc02S/tdWhppfwLgwz4oEAx/IRrc54voFxaSuYA3mWr+W4xj5/t6SD3hlA3qFvXRy7pl
 1FmqRN7YWZWmSn3vNwjSwhhhvu3fkCitTCozzsqo/ZV+zVeNp6NHmIgGg8hwBih73PdS
 45LXRpmuBX21wGbRF4AMohCO2Gi/PmxnZu0v0fIJBGvohOoDwUqGh2PObVZH59LPFQGU
 OPuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBHvVIBajhd1a75F89PPwRyrJrqyb9rqnyTHdO73GxBpWOUdk4mzZFW6nXABQ3yZ782QrzEk4=@lists.denx.de
X-Gm-Message-State: AOJu0YwfW34QqLB47ns9V36tNk6bZ8K4xORGbX9fNszgOcVcuKP3n3wZ
 UMMpCJpeZcMa8+m8FchZARBYpzXAZDiCEa2/Rh2O2ygW0jVFLUpZ1ohEtllonm2Xc3v3JfaTQd5
 iMHrvR9XtVVu2mxG7Bk/SQcreDad9gF7L3cZInm8U/Byk0AwKgpFuP83r
X-Gm-Gg: ASbGncv/gI2dau/rBIvH60U8WJ6LY0MGYJ8l3S5GwQKLDNKMb/cGeKY/VRYDtohGVuD
 BzIYw0IFQXP7E6xCNMWfNX1vOFq/YgElCnT/LgAHjiuPBpEM1GeWwE36qD7a9WmeuE2AZ+ml4y9
 4ye15k7oqWlN+KyP9njQS7JXVlwDTT+NQYFVRiFQBzoVtwCXwE1pzY+wUffpw+slIpjhM4aCXv0
 7H/qUyECMDVBwK2vsvGmoez2+3skaOnOOUzNJe68GRIFiTep73Al53S2eKcKDcXbMtId1TofKYB
 xC6+oy96YXx3at86T0fGQSrD3g3eD0K417GaMSLt2uSRuDVht/ZbosZS+BxIs/Pzhzyttu8yG4S
 SVm5Ehq8d5Ui+2Viwt2inchvTLfjLesZGLkhXxWfT4wCc2hZ8CpLHQ9P07puPAWynRfOZATx9ac
 FfXw/UeXOqQDwdxA072uKhO6J3CPChIy/CJflJYA==
X-Received: by 2002:a17:903:1b45:b0:295:20b8:e104 with SMTP id
 d9443c01a7336-29d684afae5mr25443315ad.58.1764760067716; 
 Wed, 03 Dec 2025 03:07:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJTuY2G3FbjHC2NkLJsMM847Dqhz5rGq6Y4/yGqmvdiLpOoG5m2XHZRwJ3Gqig399D4T8poQ==
X-Received: by 2002:a17:903:1b45:b0:295:20b8:e104 with SMTP id
 d9443c01a7336-29d684afae5mr25442845ad.58.1764760067104; 
 Wed, 03 Dec 2025 03:07:47 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29d7b6ba774sm10132925ad.83.2025.12.03.03.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 03:07:46 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 0/6] Enable USB3 Super-Speed support for QCM6490/SC7280
Date: Wed,  3 Dec 2025 16:37:29 +0530
Message-Id: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GMMF0+NK c=1 sm=1 tr=0 ts=69301a04 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=V6pe9Ag7if0Pk3vUvJMA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: YSM8SatqHh9Hz6qdCCQQ3hewZB5LlIps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4NyBTYWx0ZWRfX74feQZibD0BB
 AESHbrT3kpl55HFtgVLfSfZGrktiLPTjVEJC1O9o2mMOKxkRtHkd0c24y7VJuaCbjrXnIkEwVGJ
 By3kzs2cSQm6SGtalbrtqiby+zR7Rd8m1XswWt80MdjScQmxgmCKGzXybn/DgDqm7/YPSgLvMSx
 YicIDqL5QNLPQiNkTBMagEWUFuCq9qRHhBWqKPL1tX8ANolXQexctpaVXvcF+l5s0aRQYuqWKCk
 6aKS4ELV5C8Xdr95+35cxp9HXroseQlzRso103ir0aU1Qes2U65kaPN/pwwoACQhvUes/0UuzAP
 PtEogzmnc59Lx4wFInJ2yBrtXYjiyzeWarIhszORNjj+zbUyE9LmmhEKZYXQZTyaSMHDNuUj3tV
 brZguSBFC9ijJ9NUNPVx8XhyEVhAlQ==
X-Proofpoint-GUID: YSM8SatqHh9Hz6qdCCQQ3hewZB5LlIps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030087
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

This series enables USB3 Super-Speed functionality on QCM6490 and SC7280
platforms by adding support for the QMP USB3-DP Combo PHY. The combo PHY
is a dual-mode PHY that can operate in either USB3 or DisplayPort mode,
and this implementation focuses on USB3 mode to enable Super-Speed USB
support.

The series adds the necessary clock support, implements the
QMP Combo PHY driver ported from upstream Linux, and automates USB speed
fixup.
---
Changes in v3:
- Corrected regulator names in drivers/phy/qcom/phy-qcom-qmp-combo.c
- Made regulators mandatory in phy probe;
  if regulator not present, now probe fails
- Removed support to manually disable the USB HS fixup via Kconfig.
- Instead added code to automatically detect if
  SSPHY driver is available and do HS fixup only if SSPHY driver is
  not available.
- Link to v2: https://lore.kernel.org/u-boot/20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com/

Changes in v2:
- Gave correct commit id for reference linux implementation for
  adding mdelay in drivers/usb/dwc3/core.c
- In drivers/phy/qcom/phy-qcom-qmp-combo.c:
	- Added pipe clock disable in qmp_combo_power_off sequence
	- Added all required clocks except pipe clock
          in qmp_combo_phy_clk_l
	- All clocks except pipe clock are enabled and disabled
	  seperate from pipe clock
	- Added support for regulator power supplies
	- Added a minimal xlate to only return the USB3 phy
- Added "drivers/phy/qcom" to ARM SNAPDRAGON section in MAINTAINERS file
- Link to v1: https://lore.kernel.org/u-boot/20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com/
--- 
Balaji Selvanathan (6):
  drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
  drivers: usb: dwc3: Add delay after core soft reset
  drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
  arch: arm: mach-snapdragon: Auto-detect USB SSPHY driver support
  configs: qcm6490: Enable super-speed USB support
  MAINTAINERS: Add entry for Qualcomm PHY drivers

 MAINTAINERS                                |   1 +
 arch/arm/mach-snapdragon/of_fixup.c        | 130 ++++-
 configs/qcm6490_defconfig                  |   2 +
 drivers/clk/qcom/clock-sc7280.c            |   1 +
 drivers/phy/qcom/Kconfig                   |   8 +
 drivers/phy/qcom/Makefile                  |   1 +
 drivers/phy/qcom/phy-qcom-qmp-combo.c      | 644 +++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 ++
 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
 drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
 drivers/usb/dwc3/core.c                    |   2 +
 12 files changed, 902 insertions(+), 18 deletions(-)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h

-- 
2.34.1

