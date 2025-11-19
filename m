Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8D6CF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73BA83F69;
	Wed, 19 Nov 2025 16:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EMFOzyTg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OQptOqK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF85883F7D; Wed, 19 Nov 2025 16:25:44 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFD383EF9
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJFKkQA971176
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6eA+ZPQQn/2C4bQ6dy79shznqE5+fqZfVh1
 jN3kA2QQ=; b=EMFOzyTgIqrq+WhI4OxZvwEQFNdgBPDrbyeTi1JmwkUp4hmeJCc
 jHpGLkZZdIGVJsy7u0u4pr/9rMzN0Gz77KjW1yMLFyQYwV9yNN8P3WM+ux2tITFl
 g3GINmw1DV7L75ialSVX3HmlnPyH7IbvFAR+4vteW32CpVz5LHnyjAv/Awy6q+K2
 03kNhBQ65GUS7B/zxzNrN7nJ+5RBtqRyPT+04ZLagsdv1NelT1laXsYI+Q6ajwaW
 ZDk1ThbyQb04z/Ly+pBppdgnWqBj4E8gLF263MtxS2ra+/AwVZAlkHCWak7mWZfR
 /EZ3Rm/rGq89HL21EcI5jtaHvSmBiga8/vA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ah9fu9dx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34374bfbcccso6788478a91.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763565940; x=1764170740; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6eA+ZPQQn/2C4bQ6dy79shznqE5+fqZfVh1jN3kA2QQ=;
 b=OQptOqK4xITfaMckT/WCIbNhAVhQRZF10jKvLE4p2uBioBVmVKmCw+VOudbRgXPxjK
 Kdxynq4Z/326suYmpA2Pdzyx/EBjne+wTLBi9tHroEZLFpIC5qTVApovlyGIFClG2fW/
 rm7muYdiliuJGFa/UzHCNfnm6Xa83qSFendwUAV891xk9cLnttrMNWh219okK39QxnHM
 SD+/AyIpPSCheFUIg+1jd9XhVmdFdZJiEvGEVIt5gTsFcOmv+Ei/O2tYr6BeQPcoNT6u
 rZzjWHJwdC943yCsORfHVVl/OstaeaYT783qRNZHF70XtKirWRi/r6zyqh3C42fiqE2X
 sjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565940; x=1764170740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6eA+ZPQQn/2C4bQ6dy79shznqE5+fqZfVh1jN3kA2QQ=;
 b=chxWS6YbzqjK0Y/pRDQFaVZyznY4im5We3YfS9cqEmRY8XjJ2aQrlNwsNLtWA5uGl7
 6hfkdjA2wg17aKnOdovqhRbAz44O0TXzLHLpQL8N8wmj6Luphm9b6T3dE3Qn5VX5rFRq
 o95l6n1f/38JFdVGBgomLxBPBEAPKdKLnZVugbm8l2AmpNn1kQ+3neGVkL2ptkbhvqDE
 jCPbRrBTMfvUL6iJjMaSA42JHSK6heYTT1JLHG3hIAj6ulE08+CWWC1jB3aowNK5N/XN
 aWypScznymS2j0wWE8s+vHpj0Ddj/DI0ekKuvseNzWn+nzB9yyHEbROqGX8FxYiuJk+F
 s6Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkJfpYe82FaQODiIGz+sH7oCBdCtDF2eQHykIeXKH35ZftlgA/WEQaRGdcBKraCRWk8ERUtUE=@lists.denx.de
X-Gm-Message-State: AOJu0YxgoHxIb9P80wDUWRkwaUFnDjyp+XlOuBY6Xe7cPEZrTbOnAgAB
 8M2kPCClz4/bGPUaeIftpV9fYkxZi+TufGlzhHK5IH6qV2MBdKerv1dK2SaL2wrsjC8niwFBP/s
 bnu94m7teF0uiPFqkXWsxDSfoXIZ+olO1gcw4okEDWTpLMa5Sn7yLXhR3
X-Gm-Gg: ASbGncsMzjVsLo/AxXbGV9hkCnpYD7+o4Ib2nDSfviXo+vAg84QbCkRXf7QjtW+wcye
 1X+tljCin1SXQ6hDoEXap1NCvvwiuQF/GZCoIOuXgQYUaYIghtSVVMLx0hcgDB9k89VpaFn4wYt
 Kr+D0ziqBlVc29wc5hTTj0Bd4RiPL+sL3gSFHf8lU/6A0GXqljbcDJ6J9NYPUCjfmvCpKWqq6fT
 UfIWMl4H/M6wz75nqwEVYl9/6BgZZNthxXGS21C+v/qt+lMNh8Y1D9LpqfSEp44PhMcdRV8EGDb
 xlBBZLk5Ggfu5lvwyjccOfP1jwiyaUUmZKbrZfc220XAcrREwhQgGS9CcpfJTrAyBLLDE/WQ4PR
 hOdYv0w0GUW6ftaepCttwuBgGY8lF1enK+bG9cpdBHht/9T7fk/gsLtsMnTNegUGq5Uure07+AQ
 1eCQ/t1D+0zrvBo84Ai6Clow0AxxktSp7pssf9/Q==
X-Received: by 2002:a17:90b:258f:b0:341:124f:4746 with SMTP id
 98e67ed59e1d1-343fa638f09mr21283102a91.31.1763565939948; 
 Wed, 19 Nov 2025 07:25:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHceFFzif3/jocNzztH7thzHI4rOkA2VkpIlfpmAzb9MerauwfBImG219gwrD8RpOLj8K/+mA==
X-Received: by 2002:a17:90b:258f:b0:341:124f:4746 with SMTP id
 98e67ed59e1d1-343fa638f09mr21283081a91.31.1763565939365; 
 Wed, 19 Nov 2025 07:25:39 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-345bbfc8eefsm3083157a91.4.2025.11.19.07.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:25:39 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v1 0/6] Enable USB3 Super-Speed support for QCM6490/SC7280
Date: Wed, 19 Nov 2025 20:55:24 +0530
Message-Id: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMyBTYWx0ZWRfX3RWQNJjnocvl
 uV4DV89aOnpZnQiZNRgDxmO5jhrTabLx/5VskOScnGFxlWXKX/DoaFmfZl1MZSMOtIC61JcwKFV
 Sp0YuAimyCfMDBdAaMS8a2UXg1K0KE7G5gmsctoqRmk0z/jSz7ZwuAhlZIk9OXdV3b1cmlb3qHw
 QOJAPXUh0Rzos/Bb6NGmhWfY6r3UAZVi/bnNzNF2H5uegrH2+VEwLSLJys7pHnCzu5R94ta/BrW
 16W6WGaEdtNGUDC3/Xmr1r9b9vlGAcT2tUrp7q24/jt0ZPkJJq4iUmC5KQmFwpyiLk0eE6dwU3z
 pBXVGcR2EO01JFOc9c5mo0JNvmBQGajBIDUHO/MFw==
X-Authority-Analysis: v=2.4 cv=KZTfcAYD c=1 sm=1 tr=0 ts=691de174 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cbjzZ4ewA4X5m2kAHjcA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: FYhbB9kn2ETVWb-qHqsT5TqcWFKDy0OH
X-Proofpoint-GUID: FYhbB9kn2ETVWb-qHqsT5TqcWFKDy0OH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511190123
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
QMP Combo PHY driver ported from upstream Linux, and makes USB speed
fixup configurable.

Balaji Selvanathan (6):
  drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
  drivers: usb: dwc3: Add delay after core soft reset
  drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
  arch: arm: mach-snapdragon: Make USB speed fixup configurable
  arch: arm: dts: qcs6490-rb3gen2: Override USB3 PHY clocks
  configs: qcm6490: Enable super-speed USB support

 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi   |   8 +
 arch/arm/mach-snapdragon/Kconfig           |  10 +
 arch/arm/mach-snapdragon/of_fixup.c        |   4 +
 configs/qcm6490_defconfig                  |   5 +
 drivers/clk/qcom/clock-sc7280.c            |   1 +
 drivers/phy/qcom/Kconfig                   |   8 +
 drivers/phy/qcom/Makefile                  |   1 +
 drivers/phy/qcom/phy-qcom-qmp-combo.c      | 503 +++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 +++
 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
 drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
 drivers/usb/dwc3/core.c                    |   2 +
 13 files changed, 673 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h

-- 
2.34.1

