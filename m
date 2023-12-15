Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709FBC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 16:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2993887C16;
	Fri, 15 Dec 2023 17:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="cqb+kvIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FEC87C12; Fri, 15 Dec 2023 17:30:49 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6535C87C0A
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 17:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BFFQa0x018518; Fri, 15 Dec 2023 17:30:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:from:subject:to:cc:content-type
 :content-transfer-encoding; s=selector1; bh=WYOo4BuQYNotETG1zbEx
 7ygd4eCMrSkmuZ/fQBJ9rpg=; b=cqb+kvIZLxq9Yi+/PQZSBvmX3ZEetf36AW3/
 w67kLHa/IPnhL+2mGBI6y1Jb1rb+aFt+us9VEihMG/+icnt1a26MBbG2T8/wK9i4
 jlgx8+8VjtXXUl4SJUyyvFeOZi7eJH5jC+LT/oJ/IhKr2nbcD/OWZtxOqVnTU2ES
 LoB6CbAfudpVNyPG9IAIIobJ3wTIHOHhNLeQmnmpHTFxukWsrXlxyZeEsTErZ8x0
 wLas27hAdzLKwW78PyjAGK0fYpo2zZiAwu9uO2U1ljaCyw2+RModSRfBJ5nN14eG
 89a35Bn4C4AwlzmNBsXE7058ai87ih7zbQ1ejFkIVjosqefO4A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uyb2kak24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 17:30:43 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 378EA100052;
 Fri, 15 Dec 2023 17:30:43 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B294233C92;
 Fri, 15 Dec 2023 17:30:43 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 17:30:42 +0100
Message-ID: <3fc77153-d293-485b-aad3-32757be6ee73@foss.st.com>
Date: Fri, 15 Dec 2023 17:30:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot next / v2024.04 = u-boot-stm32-20231215
To: Tom Rini <trini@konsulko.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.23.141]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
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

Please pull the STM32 related patches for u-boot/next, v2024.04: u-boot-stm32-20231215

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/18947

The following changes since commit fa3f19aa56c519d6345cc774187b7a8fdc053d71:

  Merge tag 'xilinx-for-v2024.04-rc1' of https://source.denx.de/u-boot/custodians/u-boot-microblaze into next (2023-12-14 13:27:11 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20231215

for you to fetch changes up to 395507e50d7137e0bcfce74e1b4122e49d9984cb:

  configs: stm32: Apply savedefconfig (2023-12-15 15:41:23 +0100)

----------------------------------------------------------------
_ run savedefconfig on all STM32 defconfig

STM32 MCU:
_ Sync stm32f469-disco DT with Linux 6.5
_ rework ltdc node for stm32f769-disco
_ clk: stm32f: Fix settings for LCD_CLK
_ Support display on stm32f469-disco board

STM32 MPU:
_ stm32mp_dfu : Fix board_get_alt_info_mtd()
_ stm32mp_dfu : Simplify MTD device parsing

----------------------------------------------------------------
Dario Binacchi (9):
      ARM: dts: stm32f769-disco: rework ltdc node
      clk: stm32f: fix setting of division factor for LCD_CLK
      clk: stm32f: fix setting of LCD clock
      ARM: dts: stm32f469-disco: sync with Linux 6.5
      ARM: dts: stm32: make the LTDC clock usable by the clock driver
      ARM: dts: stm32: make the DSI clock usable by the clock driver
      ARM: dts: stm32: support MIPI DSI on stm32f469-disco board
      board: stm32f469-disco: add support to display
      board: stm32f469-disco: add splash screen with stmicroelectronics logo

Patrice Chotard (3):
      board: st: common: Fix board_get_alt_info_mtd()
      board: st: common: simplify MTD device parsing
      configs: stm32: Apply savedefconfig

 arch/arm/dts/stm32f469-disco-u-boot.dtsi |  13 +++++++++++++
 arch/arm/dts/stm32f469-disco.dts         |   4 ++--
 arch/arm/dts/stm32f769-disco-u-boot.dtsi |  23 +++++++++--------------
 arch/arm/dts/stm32f769-disco.dts         |   4 ++++
 board/st/common/stm32mp_dfu.c            |  28 ++++------------------------
 configs/stm32746g-eval_defconfig         |   4 ++--
 configs/stm32f429-discovery_defconfig    |   2 +-
 configs/stm32f429-evaluation_defconfig   |   4 ++--
 configs/stm32f469-discovery_defconfig    |  19 +++++++++++++++++--
 configs/stm32f746-disco_defconfig        |   4 ++--
 configs/stm32f769-disco_defconfig        |   4 ++--
 configs/stm32h743-disco_defconfig        |   4 ++--
 configs/stm32mp13_defconfig              |   2 +-
 drivers/clk/stm32/clk-stm32f.c           |  25 ++++++++++++++-----------
 drivers/video/stm32/stm32_ltdc.c         |  31 +++++++++++++++++++++++++++++++
 include/configs/stm32f469-discovery.h    |   2 ++
 tools/logos/stm32f469-discovery.bmp      | Bin 0 -> 18532 bytes
 17 files changed, 108 insertions(+), 65 deletions(-)
 create mode 100644 tools/logos/stm32f469-discovery.bmp
