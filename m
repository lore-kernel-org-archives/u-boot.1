Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2241CC44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 10:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEC1A405E2;
	Wed, 22 Jul 2026 10:46:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtpI82iGrsty; Wed, 22 Jul 2026 10:46:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C97CA40783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784717208;
	bh=9SomNAP7bfF2Sp1jLGSWSZqqTHrkVIh6Uqes2pzqH6s=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ou0uqA5u/s6BMihIdXTIJ6ZtUvTbRXOyepSMZ6v/8iyEGCUcaqNcaRY9X6yf3HOKz
	 TaPs+Txu0Ji+gQ4UqRY3dFVuqV9oGJcbKgzfQBkx7Y9HFQ+8qeK0Ew4xS/wo4vqByH
	 uX5Gu4slMyk2sCizvozxlgXZw7GB2zsObu5f/BqFV1oIzquGxMxCmE4zyniLYfG/EG
	 59T4g7cmuL9qKIQ1puNJMZ8cd3FTYYt6mUiBCiLvHqWfsvRewifWxBBzh9epsjQ+vC
	 6AJy2xg3ebmeluNj1ezjp8U/L9n2z8APRRb5g4nWL1IIfEFAbIGqDgZnsIPES8TGCr
	 VgmMjyZHnU2dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C97CA40783;
	Wed, 22 Jul 2026 10:46:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35377EB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13468407B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VPVu55numVrp for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 10:46:46 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=badhrinath.s@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B7AF1405E2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7AF1405E2
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7AF1405E2
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 10:46:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F515848BA; Wed, 22 Jul 2026 12:46:42 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60F5803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:46:39 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8x7I3401186
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:46:38 GMT
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt798kpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:46:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so236878575ad.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 03:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717197; x=1785321997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9SomNAP7bfF2Sp1jLGSWSZqqTHrkVIh6Uqes2pzqH6s=;
 b=PIjFM5m9DoWdf5up39VkXaZ7EAUN/Qq4cIr79FDe/aiDKctggk1E0JHG8TXvVeSmAK
 pRO69VxTTGVZ/V6exy17HDr/83RrzIKBtnhTwDmHVt/xJBQW59/MfcpEnADTm8CeraeL
 bZifXjVeoLBNJeFuMGVMmqkHZiXV+8kfzdHWvMdgKP2Kg7/Fp2UG30Fc8XKxvRZ6ln/K
 9nFgTpZWcwD4FhGwJSToPm6fFCEz2qK8bl9JFxPGqXBAPIaZ39tUKnmbLalP4HWGl1ou
 xIdvYs36lejd36gARDaT93RciivcheICs5omKzKrF26fnUhGujw1+sXSAcjHwnjBTitL
 3TFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBDUveXLVeGHT7wVyMPxssnXOCZkkEr6iugdQqG0pwKugUNue9sSymX0j8vCMyhs6zvqJf0Hw=@lists.denx.de
X-Gm-Message-State: AOJu0YyQfwU8bvQeY2zg0vmUVt/Cbkan7wrFVXF219ZGNCpTDHN36OUI
 w7nxPS6UrofV/LRm3W8yjhEt9QCk//BJeMafjfuCVQzc5JmjHqfEDcyjDwdH4YZkbG96WeB+fgQ
 q+c5OD9xJvWnQFqOu8++JH0hSc7yVAPorMJwS4JIUAVOZZvs8shv4RKlQ
X-Gm-Gg: AR+sD10tISRai1BSQV1fJlCU2aHJI22ryq6qcNp0rpqROiURVbTHh6/6qBk4wNcMXVK
 UiuGhYnTav4c19UbWHyethvrqt5QmrZ91wJecHegU5U187PnsBTBMqK4hAOocjeOiwqrjvopYx5
 w6ukjz2aD2/m438955r6aNf4INX/4c3c8dlLyuhLbNIi7awmFpF2zLsMFkDktfv0V3PWdD6zAtm
 RB9k1tvBLu5zuzTqPOJK4D79Bx9ye59Y6vMuFLqKl/W5onO/yLatPKfjEHTIiHmdNKRm/35iaOE
 USaGB3Y8euINUzh9BFx574iLIP9JPddDaqGq+JrSShls74T3vYFzT6/+M9H9mdRCVNffHxG8n5h
 /HwWwNoX67W+ACQodZ7sNedSA/kbqUsnhXVVwRx8Ag8yuT5m7vsw459NyQazoJVCV7RbE/+HK72
 WJRVI/7I6gqpKVpTQ1W++A
X-Received: by 2002:a05:6a21:a87:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3c3ad95882bmr24299815637.46.1784717196859; 
 Wed, 22 Jul 2026 03:46:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:a87:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3c3ad95882bmr24299778637.46.1784717196430; 
 Wed, 22 Jul 2026 03:46:36 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d1300401fsm7581425c88.3.2026.07.22.03.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:46:35 -0700 (PDT)
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, badhrinath.s@oss.qualcomm.com, michal.simek@amd.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com, adrian@mainlining.org,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC
Date: Wed, 22 Jul 2026 16:16:20 +0530
Message-Id: <20260722104624.3842833-1-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a609f8d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=AckDw2-rnu9HBJosMKEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 7qmAn6QQEoz8fWlBOopvYuKFHSWZ78TD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfX7e7JIkCijow6
 QNcXbQKkjilJ1uJoIad5vC9iHE00+zSuN9IEpo0sIgdgKaealBlm7nP11nXtI3ej6pG8qXWMn3T
 rU8TeXv9dmUs8LwmZU3jpTDa4uSF8G350KuZexsg66puz14rOvGdOg+AJrN1PhTLDTPTvycSnhu
 C5q0dGzWhN+iibvObaJkDv5IxVwD5BTf1e24dGKkG0TA/Lw/Mq1Ti3rhd9L89a9bIZqJMFDuhZC
 +LQ4G7LplTR4135TZhcswE4QcyeROtACFpnzJOidz9pjOvmVk4mVspcvthCuYS9CfpbI1Zdk9bK
 SY4h+ed6/ST23/SjajOmvlgP3lbroJcVU8a7NLMsIz5/C0W3IqdMSflFI1Xp5buIvGxwjzNB87Q
 7HdSPMtVvhOmvsHDCb0feUYmTFa0CbEKzDv9pAnRir6obGVs1cN9w7JOgArza9GaK6wMljC/9tJ
 H4zttUqek2MzbmvKXsg==
X-Proofpoint-GUID: 7qmAn6QQEoz8fWlBOopvYuKFHSWZ78TD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNCBTYWx0ZWRfXzyaC0EF/eurw
 +CLBpfM28gmVkRdH0oixYq2ir+kXSCszRr1l9oUq2bJL+ylP+srG7PQ8PGw2315MKpLYuW19lSF
 YUn99wiyhM/StZDOcM4d5sSo/W4u7Rk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220104
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9SomNAP7bfF2Sp1jLGSWSZqqTHrkVIh6Uqe
 s2pzqH6s=; b=FGk5dJEfw2VAM3oUH3itBtig8Oq9OY3z4bqfD64LuWqMZtZhz9f
 DFM2kPlB1gfjt13hAP/VuD2J8kv6egulSxMCD1ygk2ElKMK0x5B8L7oSLk/xLXCP
 K8S8vCBtU/aIPyHOdZhUBUBrKIiivY3iollb6FE/4kRhvSRwc2W5L3ee5DGbXWDE
 TT7/J3n1Gsrtpuq7Q3iKqtu6gk4K0IXRjcAmmKDVYBGtdF+1BN0S1m8a/X4CGQKw
 7xNhrR2tvm5FBiLX11ap/aQdGEDwKkcep2oM1aUpv37Zi6/GIa55r0OowISrUqee
 AA/G8InAwydixyzPhnjpvQ8gnNY/jJiadKw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784717197; x=1785321997; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9SomNAP7bfF2Sp1jLGSWSZqqTHrkVIh6Uqes2pzqH6s=;
 b=e58yTL646QY7cR5DVbeDPlHUuR39xEIWYgnbwjhXDXXyvh/diI8aoPxLEpR+nstt8u
 BDQZt02lYdTrj970iVTJWaUVVjcreA/wJWpD1SaLfSlNmv3HVPqpAi1N4yCAEKuQTaJH
 ca+ba8S9uVIp+0yntB9WHHPIc+hhQ6DpaPhNx1BSXBRaVNUe8hn4hF/Gxj+/gZnO2OdI
 FP4zytuFLvOazlHl9xNRqiQZlMTknpuV1QpniD9Y06G56Qu1dxx0BpVerxj0AWAKeWks
 QYiAsb7C/i4bNrh4VuT3fgoUJY+KbCOtPvYH56NCl0yQ315T8gPVzL1FFMbMZ0YLLVDD
 KIXw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=FGk5dJEf; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=e58yTL64
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FGk5dJEf";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="e58yTL64"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Badhrinath S via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

Changes in v4:
- Renamed qcom_ipqdefconfig to qcom_ipq.config
- Removed optional DEBUG_UART configs
- Link to v3 https://lore.kernel.org/u-boot/20260716062318.4121929-1-badhrina@qti.qualcomm.com/

Badhrinath S (4):
  clk: qcom: Add initial Clock driver for ipq9650
  pinctrl: qcom: Add ipq9650 pinctrl driver
  arm: dts: ipq9650: Add override dtsi
  configs: Add defconfig for ipq9650 RDP488

 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi |  15 +
 configs/qcom_ipq.config                 |  37 ++
 configs/qcom_ipq9650_mmc_defconfig      |  17 +
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-ipq9650.c        |  95 ++++++
 drivers/pinctrl/qcom/Kconfig            |   8 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c  | 430 ++++++++++++++++++++++++
 9 files changed, 612 insertions(+)
 create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
 create mode 100644 configs/qcom_ipq.config
 create mode 100644 configs/qcom_ipq9650_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9650.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

-- 
2.34.1

