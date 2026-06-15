Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAECCD98C7
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7810B846A4;
	Mon, 15 Jun 2026 14:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zjpd4dRw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+gMl4VK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427C684869; Mon, 15 Jun 2026 14:18:55 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C6D283FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FApNF1136474
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ZLA11eFQmzCHJHGnbwGBxh8v8lgPvFrlECO
 4S87yLvw=; b=Zjpd4dRw1Twc5i4eOfoLQwz64p6+LnerzgH2oEnXlbLTuy0Xj4z
 wK7GCYqogrKBrRdxAZVQVDQUc7uJ1kHDgyjvrZLUPCwzPGiVIZHkNIZtPfE8lWkl
 7G+bn4r3UMZp8zFG3zKfv2CpUxUTMkbJlC8QmvJcuxccBbuzY1MPN06wGV0A9CR8
 4r/wM88fA/zzscu8aHQ1rJSwCWWgnPW3WpHTvZa10WWvtYL9D6vp77kYZRkDZNwq
 IDN5seq50ypHtC6K9xm3nTjyBCLm8P0sYl41y/lhsruw6WjJBQWtcPh7l3RRVs54
 mT7BEB8T1aD9EBzJlYJaUR+CvC1w3m3B50g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx0k4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:18:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-842446a3851so1812281b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781525931; x=1782130731; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLA11eFQmzCHJHGnbwGBxh8v8lgPvFrlECO4S87yLvw=;
 b=f+gMl4VKmlrgWuW534zYEnrxMr6hmpHBrcKhuP2bZq7rgUy23j6OZ4CQWrJy7tlP3a
 VCaNW+v8EtTFsy5WzAQdVvLvcwuYtFAr4aq50gRwV6vqTE9AyzXPcP/j5IHFA6G3foEV
 4jSopAKrAmzmIXrRO2UepByfIh9i/bfqp+rADFA00ueZNSCRsq+WfrChrWEp2Nkvv+cG
 +YCUgvrPE2oqwtxAwXHH84aaZmDhAu89j5Ze0wGEAxnDVSolrFYkT/3ZT5Cw1lrZc/uY
 Ss/aTK3snI8HsBHQv6YCVxa1byKn5zVjA2sC4EzUEoJif35Efes83pkJpB8QHXM1TrUT
 Q2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525931; x=1782130731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZLA11eFQmzCHJHGnbwGBxh8v8lgPvFrlECO4S87yLvw=;
 b=CT3xC2o7j4D7HJVyErgxVVIDgObeuyak7GYV0XpyeTK8uoOyR5NHbl/EbdD67m+Heu
 ynubkkiAs8yjvmAJfek4rXcdMo+omURgWLfD1Iqw3bMCVyCh2TU/ygYCIKJ6A+x5D1be
 uN47eALFNvnJDFliNHdGURGh312x7QQkIkc0noQLT9oHddDepgoNH5Ruob9af6f/OJdT
 H+UAGQ1jTWUASdmZ68O/Wh/G9swVMGyE+8syMSDc7D76yTWdXGv1zSm1+Cn75WUWvtsL
 NTBZUwZTRoTVQlCPL2bXzEEMS5IDwjWDy86yvpvLeSN1/muLwhwToSSY+j4/pFYUroxc
 0rAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vOl172u7IyIS83ZYflpovZe5bKTD9YnHRKMuvn2wHPuG/oqk6QeLc38a+MUxI1BEqDIaqAvU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg7YTtFhmb0H7hF0cnq43FUijQpK04qYCVhRwuwwue5qv9T7bd
 y+SGb3waq+rEXY22QKH+8qZrRYLSWDwg10KOftv18tp26VmKD6GCDjJrvTgfNAeWxKfemdj/THn
 oaYFqoT0jVE0LnVGdy15KXmyemqnOl2INUlr1R1CmS4fFO3oTQvP8tm4b
X-Gm-Gg: Acq92OGGFwsqsSCtJuNqX32x1t+x+j3IIaiZPcBMCJWfjk8SPDNAtmIgqKLP6B3ortu
 x7+G8Lrvhpr7qpJDUoXEH7ZL22HVcUiGewizMKcd10tkqDt7LpGE9sWrac10VplfrLkULXIpnJG
 1sdGhtY0euUGjXCKiGHOZvxoA/Stq+51R/4AssIwtLizFJnqLo2Xgotpx58n3fEVjoLNvfrgvWm
 18qfAzbD9ZW9C4a4UmV8rqYEEX2rJNx7TKtxBVuykB/zO+VFcX8im0Ejqd4aQ6wXJWwVcc5cuN5
 OhKk9ox85Fr7tO6vVdB7SsPmUXWOjhoebSjKFFmr5imjpGUmxoqsc5544YHcdtYd7/y/iBarZSH
 dtiJ0Skba/oOPoJRXMilbd7RNMILoNk0vwPdUH6XFxMVbXymzBch5/giYIJQc0+irNCR6ZhcX2u
 6UQSciU5W9/toFeLBg6PYE4mU4Zzws1TDRG33Ugy9H
X-Received: by 2002:a05:6a00:1256:b0:842:68d3:e29f with SMTP id
 d2e1a72fcca58-844e193a464mr11117962b3a.3.1781525930542; 
 Mon, 15 Jun 2026 05:18:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:1256:b0:842:68d3:e29f with SMTP id
 d2e1a72fcca58-844e193a464mr11117913b3a.3.1781525930015; 
 Mon, 15 Jun 2026 05:18:50 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm10434823b3a.17.2026.06.15.05.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:18:49 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 kever.yang@rock-chips.com, tien.fong.chee@altera.com,
 clamor95@gmail.com, jbx6244@gmail.com, frieder.schrempf@kontron.de,
 briansune@gmail.com, andre.przywara@arm.com, hai.pham.ud@renesas.com,
 dlechner@baylibre.com, emanuele.ghidoli@toradex.com,
 nguyen.tran.pz@bp.renesas.com, j@jannau.net, contact@paulk.fr,
 balaji.selvanathan@oss.qualcomm.com, quic_varada@quicinc.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 david.wronek@mainlining.org, peng.fan@nxp.com, me@ziyao.cc,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 0/8] arm64: qcom: Add initial support for Shikra SoC
Date: Mon, 15 Jun 2026 17:48:20 +0530
Message-Id: <20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UWplHTz7Axee58D1Id4ICiuEQ4cIdhNH
X-Proofpoint-GUID: UWplHTz7Axee58D1Id4ICiuEQ4cIdhNH
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a2fedab cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=ph7SjtdMOIMzVkNSdvwA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXytdnOTKg1/m0
 yjDN0wWfFnNPTIczVTXeLSKM4OWdu75H0C5606VfiQZyrcDFfTLws4h8bk5eHgc0aGRRGI96JGZ
 aV2Yr9cYg4h405RblLb4hQNYulQusZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX11pWAQrgXhKc
 SkzkiSA1vKY5Q6zR7e+mMWYZja/8cYcOSCpUb1fp8JNA4GZtTkfvgEPdOPXA91ZR+I15wgSqsY7
 h7269LcS90w6iN26r7/CzONGmeS8pAwtJ2F9gg3HjkiIFVtZYXcil3fiai74T9ooCZY/ED4S042
 ocUksDiFY+WED+NTWExhdqpRvub5OyvIzGfJwXq1oOe48YmWulidYBZjRp9nsy28n8qPhraVBY3
 A2NACKe1qTonbt6ZvaTCgXQUHL03iYtuHnUzeYC5UiCY34mFvn5xdrflq/onNGxNPeUp/BYwXue
 EI0Ko4JEwNolSq1sd2bY+l493UjMamPOZxIIq9SBToCaNEHO4341RjlTNiT806APSwEC+Y6bNft
 lt8yslmLLN9Yrljjr7G9YKWC0oAKs5rM0sOUiNzzGcZEEgKYYcqXqWa5T0+NFNFud/8nfBUiika
 JwV1MFzScaO633LEg9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130
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

This series adds initial support for the Qualcomm Shikra SoC in U-Boot,
including device tree, clock, pinctrl, SMEM updates, and configuration
changes required to enable early boot on Shikra-based platforms.

The device tree support is ported from a corresponding series submitted
to the Linux kernel, which is not yet upstreamed.

The series includes:
  - Initial Shikra device tree support (SoC, SoM, and EVK)
  - Memory node required for boot
  - GCC clock driver support
  - Pinctrl driver for Shikra TLMM
  - SMEM update to support higher host count required by Shikra
  - Defconfig updates and Shikra-specific defconfig
  - MAINTAINERS entry for Shikra platforms

Thanks,
Aswin

Aswin Murugan (8):
  arm64: dts: qcom: add initial Shikra device tree support
  dts: shikra-cqs-evk-u-boot.dtsi: add memory node for boot
  clk: qcom: add GCC clock driver support for Shikra SoC
  qcom_defconfig: Enable Shikra clock driver
  configs: add qcom_shikra_defconfig
  pinctrl: qcom: add driver for Shikra SoC
  qcom: smem: increase SMEM_HOST_COUNT for newer SMEM versions
  board: qualcomm: add MAINTAINERS entries for Shikra platforms

 arch/arm/dts/Makefile                         |   5 +
 arch/arm/dts/shikra-cqm-evk.dts               |  40 +
 arch/arm/dts/shikra-cqm-som.dtsi              | 156 +++
 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi       |  15 +
 arch/arm/dts/shikra-cqs-evk.dts               |  40 +
 arch/arm/dts/shikra-evk.dtsi                  |  14 +
 arch/arm/dts/shikra-iqs-evk.dts               |  40 +
 arch/arm/dts/shikra-iqs-som.dtsi              | 170 ++++
 arch/arm/dts/shikra.dtsi                      | 842 ++++++++++++++++
 board/qualcomm/MAINTAINERS                    |   5 +
 configs/qcom_defconfig                        |   1 +
 configs/qcom_shikra_defconfig                 |  29 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-shikra.c               | 319 ++++++
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-shikra.c         | 931 ++++++++++++++++++
 drivers/smem/msm_smem.c                       |   2 +-
 include/dt-bindings/clock/qcom,shikra-gcc.h   | 262 +++++
 .../dt-bindings/interconnect/qcom,shikra.h    | 121 +++
 21 files changed, 3009 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/shikra-cqm-evk.dts
 create mode 100644 arch/arm/dts/shikra-cqm-som.dtsi
 create mode 100644 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/shikra-cqs-evk.dts
 create mode 100644 arch/arm/dts/shikra-evk.dtsi
 create mode 100644 arch/arm/dts/shikra-iqs-evk.dts
 create mode 100644 arch/arm/dts/shikra-iqs-som.dtsi
 create mode 100644 arch/arm/dts/shikra.dtsi
 create mode 100644 configs/qcom_shikra_defconfig
 create mode 100644 drivers/clk/qcom/clock-shikra.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-shikra.c
 create mode 100644 include/dt-bindings/clock/qcom,shikra-gcc.h
 create mode 100644 include/dt-bindings/interconnect/qcom,shikra.h

-- 
2.34.1

