Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FA8C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 15:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346BD88145;
	Tue,  9 Apr 2024 17:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="X2xOZqyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E838809E; Tue,  9 Apr 2024 17:03:14 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBD7880D6
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 17:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=482956ac1a=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 439BWhXB021039; Tue, 9 Apr 2024 17:03:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=Djx8PTK
 iQSMF6D06rm/sCzpETmwFg4asN44Mr1uPlkU=; b=X2xOZqyS3BSnaUMjgatF/9o
 WxzsZty/K27WdVw4xOOoIV1pqzTOxym7r18G4qi/klsVWvuFplEJ2Yb9bm3pm/9E
 NTzqtWVC20NAOUvAqYUL3xYjkUkNY8sAiiinInbEzyThoWLWLS03PAskz+ZI0b7d
 dlVNDDAf7W+MJwxolhGc6Z1HNNuLMi5rtJCe0dRUDuX7bRXiRV/GSDTnj/9/I0iz
 MQ1brWqgwxoGcg5TzFTSvFpKEKyNh4/t++wNv9QGTxS9fiC2HNh1oUrbwk/TLPrZ
 cLVVPVN3yiy3NXCHi6qmDWIzpu0YJRAShk6XDK3+3v/CdmMnSJKr+EEc9XZefHA=
 =
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xauh53wc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:03:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C337240044;
 Tue,  9 Apr 2024 17:03:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8D3592207AB;
 Tue,  9 Apr 2024 17:02:19 +0200 (CEST)
Received: from localhost (10.48.86.98) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Apr
 2024 17:02:19 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Grzegorz Szymaszek <gszymaszek@short.pl>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 00/25] stm32mp: Fix keys & leds management
Date: Tue, 9 Apr 2024 17:01:50 +0200
Message-ID: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_10,2024-04-09_01,2023-05-22_02
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


Adding FASTBOOT support for stm32mp13 shows issues when entering
in fastboot mode using a dedicated key.
On several STM32MP boards, same gpio is shared between key and led.
Restore the fastboot/stm32prog activation using a dedicated key.
Restore the led-blue which indicates U-Boot entering / exit.
Make usage of BUTTON-UCLASS for key management on STM32MP1.



Patrice Chotard (25):
  configs: stm32mp13: Enable FASTBOOT
  configs: stm32mp1: Enable BUTTON_GPIO flag for stm32mp15_defconfig
  configs: stm32mp1: Enable BUTTON_GPIO flag for
    stm32mp15_basic_defconfig
  configs: stm32mp1: Enable BUTTON_GPIO flag for
    stm32mp15_trusted_defconfig
  configs: stm32mp1: Enable BUTTON_GPIO flag for stm32mp13_defconfig
  board: st: stmp32mp1: Use BUTTON UCLASS in board_key_check()
  ARM: dts: stm32: Add gpio-keys for stm32mp135f-dk-u-boot
  ARM: dts: stm32: Don't probe led-red/led-blue at boot for
    stm32mp135f-dk-u-boot
  ARM: dts: stm32: Clean led-red node for stm32mp135f-dk-u-boot
  ARM: dts: stm32: Add gpio-keys for stm32mp157a-dk1-scmi-u-boot
  ARM: dts: stm32: Don't probe red led at boot for
    stm32mp157a-dk1-scmi-u-boot
  ARM: dts: stm32: Update red led node for stm32mp157a-dk1-scmi-u-boot
  ARM: dts: stm32: Add led-blue for stm32mp157a-dk1-scmi-u-boot
  ARM: dts: stm32: Add gpio-keys for stm32mp157a-dk1-u-boot
  ARM: dts: stm32: Don't probe red led at boot for
    stm32mp157a-dk1-u-boot
  ARM: dts: stm32: Update red led node for stm32mp157a-dk1-u-boot
  ARM: dts: stm32: Update u-boot,boot-led for stm32mp157a-dk1-u-boot
  ARM: dts: stm32: Add gpio-keys for stm32mp157c-ed1-u-boot
  ARM: dts: stm32: Don't probe red led at boot for
    stm32mp157c-ed1-u-boot
  ARM: dts: stm32: Update red led node for stm32mp157c-ed1-u-boot
  ARM: dts: stm32: Add led-blue for stm32mp157c-ed1-u-boot
  ARM: dts: stm32: Add gpio-keys for stm32mp157c-ed1-scmi-u-boot
  ARM: dts: stm32: Don't probe red led at boot for
    stm32mp157c-ed1-scmi-u-boot
  ARM: dts: stm32: Update red led node for stm32mp157c-ed1-scmi-u-boot
  ARM: dts: stm32: Add led-blue for stm32mp157c-ed1-scmi-u-boot

 arch/arm/dts/stm32mp135f-dk-u-boot.dtsi       | 19 +++++-
 arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi | 32 ++++++---
 arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi      | 32 ++++++---
 arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi | 34 +++++++---
 arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi      | 34 +++++++---
 board/st/stm32mp1/stm32mp1.c                  | 68 +++++++++++--------
 configs/stm32mp13_defconfig                   | 11 ++-
 configs/stm32mp15_basic_defconfig             |  2 +
 configs/stm32mp15_defconfig                   |  2 +
 configs/stm32mp15_trusted_defconfig           |  2 +
 10 files changed, 173 insertions(+), 63 deletions(-)

-- 
2.25.1

