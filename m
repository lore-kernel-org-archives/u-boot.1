Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2773C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7A1829A1;
	Mon,  5 May 2025 17:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="jhBZeeq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E51E0828C2; Mon,  5 May 2025 17:03:47 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8CB8212B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7220064b2c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545B3IAF025904;
 Mon, 5 May 2025 17:03:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=ugb5uRV94xfPzNQN0O3spC
 W+mqbGb6cg7ZzoBcsgpD8=; b=jhBZeeq63POVYB4U6wkzPlZlXof5J9ui8vc7X0
 O8f6A4ZmUf0bpMPvOaafcCSWA21iM0epnzlgY3/1XwHNrEvPypjuTt/79l3HLvw3
 AOA3Gq2ceSVS3ZYg91FAoPrREZSNvUSwfRKFTJOOYVTYGnINc1p8U/kpqPXqZ+fg
 AEXjFf1ZQlc1m74BaWxqNDjHmDUTW1aLR1eFkDdX+prd/i+SaFoH4knWy2NTcS5d
 7V/LOj3YvsxaUumHF8RxQthMLzpYyzzYL1akaKRNQi562PveVaDxabSk6tpoMWDM
 HBBix6eAyOxZG/guu6xWJMk/LTOhjkOaINKk89olQPv0F0aQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dvq3w6qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 17:03:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9E9DC40048;
 Mon,  5 May 2025 17:02:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F279FB33BD1;
 Mon,  5 May 2025 17:01:24 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 17:01:24 +0200
Message-ID: <d348e7e7-5969-40d9-93ef-ca7f318ebadd@foss.st.com>
Date: Mon, 5 May 2025 17:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2025.07 =
 u-boot-stm32-20250505
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Pascal Zimmermann <pzimmermann@dh-electronics.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Christophe Roullier
 <christophe.roullier@st.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_06,2025-05-05_01,2025-02-21_01
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

Please pull the STM32 related patches for u-boot/master, v2025.07 = u-boot-stm32-20250505

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26081

The following changes since commit 9dbe8d889546efd6c1a3470092588b9b6820158f:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-05-04 13:44:01 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250505

for you to fetch changes up to 9b74f86b683ef7ef86e19a0ab63d6a7346baf42a:

  configs: stm32746-eval: Fix console cmdline (2025-05-05 15:51:47 +0200)

----------------------------------------------------------------
- STM32 MCUs:
   - Fix console cmdline
   - Add support NT35510 panel controller on stm32f769i-disco board
- Fix dfu alt buffer clearing
- Enable scan and start for AB schema on STM32MP15 DHSOM
- Add stm32mp2 support for dwc_eth_qos

----------------------------------------------------------------
Christophe Roullier (1):
      net: dwc_eth_qos: add support of stm32mp2 platform

Dario Binacchi (4):
      ARM: dts: stm32: add bootph-all for dsi node in stm32f769-disco-u-boot
      ARM: dts: add stm32f769-disco-mb1166-reva09
      video: support FRIDA FRD400B25025-A-CTK
      configs: stm32f769-disco: support FRD400B25025-A-CTK display

Pascal Zimmermann (2):
      config_distro_bootcmd: make possible to substitute 'part list' in distro_bootcmd
      ARM: stm32: env: Enable scan and start for AB schema on STM32MP15 DHSOM

Patrice Chotard (6):
      configs: stm32f769-disco_spl: Fix console cmdline
      configs: stm32f746-disco_spl: Fix console cmdline
      configs: stm32f769-disco: Fix console cmdline
      configs: stm32f729-discovery: Fix console cmdline
      configs: stm32746-eval_spl: Fix console cmdline
      configs: stm32746-eval: Fix console cmdline

Vincent Stehlé (1):
      board: st: common: fix dfu alt buffer clearing

 arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi |    6 +
 arch/arm/dts/stm32f769-disco-u-boot.dtsi               |    1 +
 board/st/common/stm32mp_dfu.c                          |    2 +-
 configs/stm32746g-eval_defconfig                       |    2 +-
 configs/stm32746g-eval_spl_defconfig                   |    2 +-
 configs/stm32f429-discovery_defconfig                  |    2 +-
 configs/stm32f746-disco_defconfig                      |    2 +-
 configs/stm32f746-disco_spl_defconfig                  |    2 +-
 configs/stm32f769-disco_defconfig                      |    1 +
 configs/stm32f769-disco_spl_defconfig                  |    3 +-
 configs/stm32mp15_dhsom.config                         |    3 +
 drivers/net/dwc_eth_qos.c                              |    4 +
 drivers/net/dwc_eth_qos.h                              |    1 +
 drivers/net/dwc_eth_qos_stm32.c                        |   11 ++
 drivers/video/Kconfig                                  |    7 +
 drivers/video/Makefile                                 |    1 +
 drivers/video/novatek-nt35510.c                        | 1253 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/config_distro_bootcmd.h                        |    7 +-
 include/configs/stm32mp15_dh_dhsom.h                   |   33 +++++
 19 files changed, 1335 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/stm32f769-disco-mb1166-reva09-u-boot.dtsi
 create mode 100644 drivers/video/novatek-nt35510.c
