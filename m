Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23937E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94F48021D;
	Wed, 18 Dec 2024 13:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="O0ApuM1E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21ADC80243; Wed, 18 Dec 2024 13:15:22 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF52A80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082afbf55=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIBIQpW011155;
 Wed, 18 Dec 2024 13:15:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=U20eKcujskJy/6c2uEp5Nu
 tYtKrFGDIk8mlboer3XlQ=; b=O0ApuM1EaoXYKxAp3W79oKe59Zk1S3WtFJ4lvL
 WjRnkt2IiByqRWfW2XUBZxhAFCLrf7ZKdTpFobXuWRx5oB0XOYMAtsG+OmvVlrU2
 h05FwHZJNI0Ux0XzOxPHsXFqdHgM8X+Vm60aCyy7dk0AYaH8wZ27c8WpM3Xk8qsy
 05Jh3K4ArTvmklvm6M2gjof2KK6Dx8Ig6t+F8HX2cWXEcD4W8e9tneGzF0qiVvaq
 JOhXdeKymOUp3tQhUmelNN0IrIUmEjbRzkiHK3dqUnIMFXDbVyu0qY8FafTJdNDv
 V3a4VPIppkXVn6mkWS1LHzEQ9qJtClsQaNHR/1V7hSAI0+xQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43krrcshvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 13:15:17 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A258C40061;
 Wed, 18 Dec 2024 13:14:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ECB50270F0F;
 Wed, 18 Dec 2024 13:11:56 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 13:11:56 +0100
Message-ID: <b8bcc71b-f390-49bc-9202-0c3746683f7e@foss.st.com>
Date: Wed, 18 Dec 2024 13:11:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2025.01 =
 u-boot-stm32-20241218
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Hi Tom

Please pull the STM32 related patches for u-boot/master, v2025.01: u-boot-stm32-20241218

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/23931

The following changes since commit 25fb58e88aba0c4af0af554d7b141be3f2e5e0b5:

  ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located above ram_top (2024-12-17 09:14:01 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20241218

for you to fetch changes up to 06a8063ec95c127a8efea5274955bea6a38fc057:

  configs: stm32mp1: Restore boot SPL from sdcard for Engicam i.Core STM32MP1 C.TOUCH 2.0 (2024-12-18 11:34:10 +0100)

----------------------------------------------------------------
Restore SPL boot from sdcard for STM32MP1 platforms
Fix STACK_SIZE for STM32 MCU's board

----------------------------------------------------------------
Marek Vasut (5):
      ARM: dts: stm32: Reinstate missing root oscillators on STM32MP15xx
      ARM: dts: stm32: Reinstate missing root oscillators on DH STM32MP15xx DHCOR
      ARM: dts: stm32: Reinstate SPL_SYS_MMCSD_RAW_MODE on DH STM32MP15xx DHSOM
      ARM: dts: stm32: Drop access-controllers from SPL DT on DH STM32MP15xx DHSOM
      ARM: dts: stm32: Deduplicate CONFIG_OF_SPL_REMOVE_PROPS on DH STM32MP15xx DHSOM

Patrice Chotard (6):
      Kconfig: Set STACK_SIZE to 16KB for STM32 MCUs
      configs: stm32mp1: Restore boot SPL from sdcard for stm32mp15
      configs: stm32mp1: Restore boot SPL from sdcard for Engicam i.Core STM32MP1 C.TOUCH 2.0
      configs: stm32mp1: Restore boot SPL from sdcard for Engicam i.Core STM32MP1 EDIMM2.2
      configs: stm32mp1: Restore boot SPL from sdcard for Engicam MicroGEA STM32MP1 MicroDev 2.0 7" OF
      configs: stm32mp1: Restore boot SPL from sdcard for Engicam i.Core STM32MP1 C.TOUCH 2.0

 Kconfig                                                     | 1 +
 arch/arm/dts/stm32mp15-u-boot.dtsi                          | 3 +++
 arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi                  | 4 ++++
 configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig          | 3 +++
 configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig         | 3 +++
 configs/stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig | 3 +++
 configs/stm32mp15-microgea-stm32mp1-microdev2_defconfig     | 3 +++
 configs/stm32mp15_basic_defconfig                           | 3 +++
 configs/stm32mp15_dhcom_basic_defconfig                     | 1 -
 configs/stm32mp15_dhcor_basic_defconfig                     | 1 -
 configs/stm32mp15_dhsom.config                              | 4 ++++
 11 files changed, 27 insertions(+), 2 deletions(-)
