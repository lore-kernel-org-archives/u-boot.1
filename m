Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83893C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 06:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 634C684C7B;
	Thu, 16 Jul 2026 08:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uolcpoew";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ca+mzZjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A71F84C83; Thu, 16 Jul 2026 08:23:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E0184C5A
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wWIG1689720
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Xt77J75zWE2UbLt2pj4LVdDg+F3Wq6Z3DPD
 8k5ngGm8=; b=UolcpoewZBvox/vDGc7BnulaODrXvATBljBeEh4nn3cvySdqwyp
 7ExY5AEvNFSWTGYBKyzrLnQ6+hK+2K0djuY8oReDPNi+bAifadZgCvcm4O7X+LiI
 CywDENuOwCD6w5IHZGZoR7QquljQTwPSkfcBUwFNtzQiotAt+M6X/PgzSb0DnroR
 7FRjZsd0z7R4QFHk9cBQtjWffEAJ0WgHD2vsoYlWUoJRPUjl5AFIjmuRx0rB4MXY
 rT2v+taoxM0erd2xNvmMo25OofNiJYEZwOYSHCeixLWieWS9XKbUGlSoNLEk9ehi
 YPEa4Xg3OiEeUwFX1hY1HSXltdfsK/DYDZQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7nmmb69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:23:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so5334800a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 23:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784183013; x=1784787813; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xt77J75zWE2UbLt2pj4LVdDg+F3Wq6Z3DPD8k5ngGm8=;
 b=Ca+mzZjFQpc4UYbcnTjeV/a4LkqE4LO3zx/XFJgvxdizH54k4wxeCxmku+YMI1O1NF
 E/aPWLhfX2+o5ZE56QC6NzEvWRWLMUQsW3H58x6B0kP1q6bVZUAiJZk1AZeuGOUhRGdI
 j1UqoU6ypKC8MJedotcm2l8PC6iTrUcda7qpjTBo22NJzNUavPDxpxLupO6UYHiZyOOJ
 VHzTbVeIZ8nh7qnoIpjg1wT7HMTINok4dZ3tgWkWbmfjfRpCxzXJmjIKIzH/JZ2nibMt
 hnNZoP1Dc+VYgGuM97mtOCCy/fOlV2a7FLEdCATY1uU0hgegEXWMUMliR3Rmoy0VTLJe
 SCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784183013; x=1784787813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xt77J75zWE2UbLt2pj4LVdDg+F3Wq6Z3DPD8k5ngGm8=;
 b=rS18lCURXEd42rCpGfWry0S+tb3q/iW7Umsb6m1yFLhhRdcAl5YlumhAYNWOUxch/K
 DcFzPx7WSmzPQQzc9X4xnGhFCjAXSq3Vs+eGcpKaC5CDZCsMVnXEI9C7baEyugKc7Yfi
 jcyU1O1O5uLVgW9Fi7g1u/xRf0PM3TecpXJB0ZSKIFd4zgt8pgYl3UzJhV0gWpBiddZ/
 W49jPvi9irkyY3lhODfPvIl6rdDx/RY5DyDrdeNb2hWrR9Tfa194SFek3qFVIc+Ui4lg
 xyG3XEonnlXnXVPffptjC2wSLl2pmEl3cNIHNyxn2IzOLhanElYhmgj9DvMxTlc3VkjD
 eB3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyUf23GK/DcGPDIZN/wVFUq2EucL3kXs/9Wl6yxt6Y7IK7aNK12QIgo2F7ncQtWztWSaZ80jo=@lists.denx.de
X-Gm-Message-State: AOJu0YwwQrYzzCjaIvvgHDM7BahlEDWrHviVUXki4NyII5OsWqkKpw30
 BY/7ihC4ztOXfmymXxtfHL4IKvd2cMw/soVaACwNPG3KCTh0hpux++HwvT3vbfn7MzlJ5il8e4/
 thy6/4nQCQ8KBQjWtOSEOGQkJE1ih7znJkZMCIQCDy2ia6nYOGzvOV1Dh
X-Gm-Gg: AfdE7clz3UxlCUELYP2CNUbjqPk/K3GjV4hhwvwLJkdHk3+cRZ8rWxsyR9Pfb3PC40/
 /xZ/mMqt4ZIKBQBspW8ytrU9TEkuLf+HqIks4IVYRCI+nAhhtLOrJ5W8OHkQ9uWVp7wAq64Ermt
 dm/eH3r1RRtS98isyP2hwsce/WCihICsGEsx4DLY8KCkTzkIS3SSltmTSFY1luJS8wMUdE+qnXs
 RfJB4DHR+gfG0RQ3f9nLko17cNh//rSzsNoC/Pbkbrw+9rxzFmkzUvAQx+UbmC4d/1q6TYHlbYs
 Ogoec2UsoI8TXEf402n6kvEc5G2A66bAVzCSTSHM6wIdsbOSvnzT03w6k55ZLqlPSKxVO8MUSus
 4755+PnSd8Oci2rhVe+TnRgop2xR1RqCK6pUg+nY9wQnBBD7onaoq32szQIT+hD2Tsbduz885SE
 dLpTYDmnjkAHqA4ak=
X-Received: by 2002:a05:6a21:114c:b0:3bf:b68f:4682 with SMTP id
 adf61e73a8af0-3c36c0e281cmr7257240637.7.1784183013406; 
 Wed, 15 Jul 2026 23:23:33 -0700 (PDT)
X-Received: by 2002:a05:6a21:114c:b0:3bf:b68f:4682 with SMTP id
 adf61e73a8af0-3c36c0e281cmr7257202637.7.1784183012830; 
 Wed, 15 Jul 2026 23:23:32 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c08eesm9895966eec.21.2026.07.15.23.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 23:23:32 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
X-Google-Original-From: Badhrinath S <badhrina@qti.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 david.wronek@mainlining.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Badhrinath S <badhrina@qti.qualcomm.com>
Subject: [PATCH v3 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC
Date: Thu, 16 Jul 2026 11:53:14 +0530
Message-Id: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2NCBTYWx0ZWRfXytNe7H8lWSi2
 S+luFwHQ/YxOnjO0t9r1b5cUepkf2eRzQcOb9Bgjj9WZBOAmHduFt8m4HnGMl51w5l8SBIqr8Xl
 zCBDPY0ZbMIzBsHm8dENE0zEK/nmxyM=
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a5878e6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=AckDw2-rnu9HBJosMKEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: JT6oXOCU3CbssbtFUa_8r9kRWL_WeguE
X-Proofpoint-GUID: JT6oXOCU3CbssbtFUa_8r9kRWL_WeguE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2NCBTYWx0ZWRfX24VPv4uCiT05
 pFdIn85r6W/GP9ccLFoPSkIzCbMMCNnKcmndkBF5qCG4QdwzzXeI/p3no+kYCoLprObTN6h0DTu
 KYR34pkbjzKar2iRDGnskxMNhdcS2pVdZIAdQLe1unq2XEsftEMsCSxRINI2jtugJJm5Kxz/htU
 R4K6DpP3xXi+0iFC0C/4PA1rSMbfiqC4ezMXSKzd5ETutiQTgNMwhqJZTbrHIX/IVs5ZwnC/vqM
 ON2MdBtAWy24p2xPkxYgSBBQhSVe0lUPqo2IDTrI3PWM+nlm8BkyK1jjlBulFYTYWGRLMIiXKeT
 ZKEsgWes6wiRrzd0ycVRa2L2sYapdkNmotcHq1/7U/41VVJQGMk48aa8Xox9hSgxaXpL8iaADSf
 7J5Z4y5B9ZktysL2gXNojJBnMUysJY3YzHMQDg4tRt+Fyj0ZfxgCExvUrxF7ZzlwAo+kghokyvr
 AnEP+IeWxFqxyMhh1vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160064
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

This patch series adds U-Boot support for the Qualcomm IPQ9650 SoC

This series enables:
- Clock control via GCC
- Pin multiplexing via TLMM
- eMMC boot support via SDHCI
- Serial console via GENI UART

The relevant DT files are available in linux-next [1].

Testing:
- Successfully boots to U-Boot prompt on IPQ9650 RDP488 board
- Serial console functional at 115200 baud
- eMMC detection and read/write operations verified

1 - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650.dtsi
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/ipq9650-rdp488.dts
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/clock/qcom,ipq9650-gcc.h
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/dt-bindings/reset/qcom,ipq9650-gcc.h

Changes in v2:
- Fix SPDX license identifiers to GPL-2.0-only across multiple patches
- Address review comment from Ferass
- Link to v1 https://lore.kernel.org/u-boot/20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com/

Changes in v3:
- Removed the sdhc node from this patch as requested. The SDHC-related changes will be upstreamed
  separately by the kernel team.
- For the defconfigs, the common IPQ settings have been moved to qcom_ipqdefconfig, while 
  qcom_ipq9650_mmc_defconfig contains only board-specific options.
- Link to v2 https://lore.kernel.org/u-boot/20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com/

Badhrinath S (4):
  clk: qcom: Add initial Clock driver for ipq9650
  pinctrl: qcom: Add ipq9650 pinctrl driver
  arm: dts: ipq9650: Add override dtsi
  configs: Add defconfig for ipq9650 RDP488

 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi |  15 +
 configs/qcom_ipq9650_mmc_defconfig      |  21 ++
 configs/qcom_ipqdefconfig               |  37 ++
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-ipq9650.c        |  95 ++++++
 drivers/pinctrl/qcom/Kconfig            |   8 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c  | 430 ++++++++++++++++++++++++
 9 files changed, 616 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig
 create mode 100644 configs/qcom_ipqdefconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

-- 
2.34.1

