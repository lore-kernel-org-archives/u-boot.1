Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F279CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 05:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78E7080087;
	Wed, 10 Jun 2026 07:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSgTzJcY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MdJtNGLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96477807C4; Wed, 10 Jun 2026 07:37:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2543A80086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A2efL2241014
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=O6Sy9YgWFuaVU//Mo0TAgt/fIAjk1VVelgt
 p75s5Kzc=; b=VSgTzJcYsdHhZKdeTWIgUk2PHE3D3A7vQ5vUjWNr2Mi3qH1iYgK
 YCc/hLS1whXhcnwFivZFkgbPZ70DFC96kPg59oD5s/DrOuJKAOUkuOp7qrvb9w/N
 a1yVyltzv6S2uuMLc4v5ZNARCkcLIT5dvmrncv6bXobHyxVhvBPLWPbM8++6o5/6
 6w4nciXEDcBmam/5VwFu3YmayUqVdUOgbplAEqpE1zNBH3sHryyxpH/kxawToYhz
 JO2X1JIuJyETMuk0sXhLw3Oj3Kp0gOwv/MlsjmlPmXAQgj/cPl6KxAsZeNsugwx/
 T1JBUPtnaRpHVDTbb41ru5AfFXsK8XqxXxA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epukesd6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 05:37:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36ba98cc003so4429725a91.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781069826; x=1781674626; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=O6Sy9YgWFuaVU//Mo0TAgt/fIAjk1VVelgtp75s5Kzc=;
 b=MdJtNGLXyYdWUpcWa7TZUy6yfnG0PcOdDS8pC1I0PKWkaGdiIrU4v49h9dABJhsN/3
 rMfCZAr+4+raqabmIWa62m3JoH8b+mCkZYGQQQvEUom9419c8a5A8hsNOTYS9cOBU86T
 czdt4UfehUh3AAaut+Nd/cpJrjnu1jogUNdp2sxSdl9ajV47+XXVarHzUCI5rTonAplL
 PUBAH5jKWF2//zI0+Tjgue6d6myzmwM3WafsFxadaSz/SG/fnOsklPYQqoZHHLUSxMeM
 7eA3sNk//2RXCMexUvrJQ8TjARISt0xG5ZTE+aEjIspUhrepEZrvvGa0xOn0W4Mxmsr/
 rCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781069826; x=1781674626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6Sy9YgWFuaVU//Mo0TAgt/fIAjk1VVelgtp75s5Kzc=;
 b=NgJ1c67J6ck7poOzruRR+qhWCdLcXirPHaBIs5f0TVv5qM4Vuts4MUKcaTK7cgdRVg
 Wwu2U0xKWUx4RBrA7YF8YrOrtoNU3V7fi7g7g3vSsENz0r6BGHYGm1JfQmX0zJb0pIOQ
 oIdHzLeN9TNCANk68KWX6TdRj4pR/pNajPH6qb/CqxHyN3GhCkDNwx9l7WJkM+5u2ASs
 YY5xPeODmPDBoo+xG5opHTn17EQL3RlCiLl5+8isF4kKRxUYcN5aJnXswj8inJwg2jXP
 M0MHur6muRGJdZB3FC+t8GpGSd3uSadzg37NY+mHwL8pwFADULbV+au1l3RxwlG7mMGA
 NfBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NIU4rSJfgOrTNiHg1bwDIH1X//fXgoa3A36czbaYQLdkszk+EZ9yHbNfSaV7TbtWnpBMugJg=@lists.denx.de
X-Gm-Message-State: AOJu0YwLbW+AS5PczCIRei8CI0WXQg84R6An3lY9yXDCbVtV73ogYoFo
 nBgSYw5lvfbrF8XAnm9+l46r+J5RhDF/qSo+2v3vrralbnTFT9RuYC4WWP6IBNWmoKflSmgqWQE
 kfbZlAjWv5M8XwmL3exVz2IbR9uuarPuPm7UEmMFjAPu+pu1bOc969eM9
X-Gm-Gg: Acq92OFHNdRDK32cSi7av24U4nq/vsCaxcAc3JP7ksEx3xUHGdOSl/ieguq/8Q4bsk6
 aw9arWZhX3iYY3bkEu+Z+mwa6B/lkkahiMilH+GeQ0D1BFKNiCaAHNhUhPKu+Z48h0KlexvvVCC
 gHY2wUBKkHJEp+1bN7kv1qiguS6PoKIw30MIZe2VxUPsatR34pfC0bkC9wOUTaI4wgnh4N5c0Sk
 KnrSqK4QeRD5TBlMIwMPcM50O8xAJhH18NePrAGFoUGY4/65ohfPI4l+Izf0fCnU6OxO0dBDN6V
 uPz4Azti4jAjQXfH+nJml/0FhuZC0MqziLh4m/gqrpohjaJESkELFboFwxCWEW7WSQeE8d5rJ/I
 GQ+uHT0gch2lp+Zq8s5AflFDeta5Vl/KXmUaQDEt2D8iHVKz3+Oopx+VBjyGkeUzJjUQEGoqwbX
 f5qDk8mXIU5D/TZ5JeyYXrOCz6dlLYbupz6/+EPWpXkzzD0Hwk9emH
X-Received: by 2002:a17:90b:28cb:b0:369:7433:2fe with SMTP id
 98e67ed59e1d1-3751f843395mr7027792a91.6.1781069826321; 
 Tue, 09 Jun 2026 22:37:06 -0700 (PDT)
X-Received: by 2002:a17:90b:28cb:b0:369:7433:2fe with SMTP id
 98e67ed59e1d1-3751f843395mr7027764a91.6.1781069825912; 
 Tue, 09 Jun 2026 22:37:05 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-376467bab00sm831918a91.2.2026.06.09.22.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 22:37:05 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 quic_varada@quicinc.com, luca.weiss@fairphone.com, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrian@mainlining.org, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC
Date: Wed, 10 Jun 2026 11:06:51 +0530
Message-Id: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA1MCBTYWx0ZWRfX4qSn6tSbbEcr
 3Z7501ZcV5vy//RipTqSdb8VdA81GB5KZ3fqpPYpeEednL3MBGsU4b5Jm7zC/0QjxCY/pmaLrex
 FmKidAjAB3N2kzessnWgPDFCXpY8i97lnx0XADxD2vcUHKTvpxaGR1kU2OeOjP9gJdI7UmzRkia
 YJtPiWk7Oq4ZL70TodUfv2wH0eECk/khup97LXAcJ8XcTp3cpJSoofPlGr8ZC77kwGAqH86GB0m
 9cei7XjpIXi0pW7DFesbXDsI2B4sb2OG6gcGqVwodkMQRFbw1UaxiaaZab8BcuGV4gQWtm2c6+u
 mPGueowgkK8mpqzgVFwmtM0R+2klgSmn5EvmNbyEa4WnK54g5Vd9r5LL+ejsttmA4o4sdBBRNnh
 hgicTbC8t2cBJNP0ENFgBGVU+KKaZ9h50dQdCkSxtpWaho0e7shu8AnQcISkwt33v7u5R5lEEsD
 IOvjWMmF7GnL/UbHX0Q==
X-Proofpoint-ORIG-GUID: aEt4MefItb21IYy9Iw8WO7pYr1H2kKeH
X-Proofpoint-GUID: aEt4MefItb21IYy9Iw8WO7pYr1H2kKeH
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a28f803 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=AckDw2-rnu9HBJosMKEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100050
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


Badhrinath S (4):
  clk: qcom: Add initial Clock driver for ipq9650
  pinctrl: qcom: Add ipq9650 pinctrl driver
  arm: dts: ipq9650: Add override dtsi
  configs: Add defconfig for ipq9650 RDP488

 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi |  29 ++
 configs/qcom_ipq9650_mmc_defconfig      |  57 ++++
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-ipq9650.c        |  95 ++++++
 drivers/pinctrl/qcom/Kconfig            |   8 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c  | 430 ++++++++++++++++++++++++
 8 files changed, 629 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

-- 
2.34.1

