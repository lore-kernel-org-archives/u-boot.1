Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CAAE7E648
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 15:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB69C86D6C;
	Tue, 26 Sep 2023 17:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Bi0oKy7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF2486DD0; Tue, 26 Sep 2023 17:09:34 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA01786D44
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 17:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38QBpIqo007872; Tue, 26 Sep 2023 17:09:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=wvccWvt
 6ZbqH8FeOGIGB/CnySJCiH6dmxXyGOF9v/L4=; b=Bi0oKy7o6lVMXMJNO5LJxFu
 4oQ7gPieRc/5EBXr5boIiR53pChEOBUbo77Mq/fT3IEzMDdwSVjh8zM4IP1kZkD9
 RLOpnovtSjyhSXBgLVKvwWhnfRVBMiubTE6g3ltJe4IhFvEW2dMnDnu6M+5opzvt
 ArifxX5s/AuyUIksoIVOAy/1B06/Ph4ea2ES905eE95W4vA2IGmIfTg5TIqqFrPx
 dhVatfZW2Ump3PX4BwIgWhBDPztNDbPRO1mly8W7wWJtokDhFJmDgmlRU5OX8bOh
 oVX0kDZROEN6kveZIJt/UdubvMp8HHqXacDPkaVpFBZjlTT2iIOlJ0xNSlQwwtg=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9qbww02x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 17:09:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB0C810005A;
 Tue, 26 Sep 2023 17:09:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D11D62C41E8;
 Tue, 26 Sep 2023 17:09:27 +0200 (CEST)
Received: from localhost (10.201.20.38) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 17:09:27 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v1 0/6] stm32mp: DT and config update
Date: Tue, 26 Sep 2023 17:09:17 +0200
Message-ID: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_12,2023-09-26_01,2023-05-22_02
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

DT synchronization with kernel v6.6-rc1 for stm32mp
Enable USB support for stm32mp13
Enable command stm32prog for stm32mp13
Enable USB boot support for stm32mp13
Force b-session-valid for otg on stm32mp135f-dk board
Cleanup dfu support for stm32mp

Fabrice Gasnier (1):
  ARM: dts: stm32: force b-session-valid for otg on stm32mp135f-dk board

Patrice Chotard (2):
  ARM: dts: stm32mp: alignment with v6.6-rc1
  configs: stm32mp13: Enable USB related flags

Patrick Delaunay (3):
  configs: stm32mp13: activate command stm32prog
  configs: stm32mp13: add support of usb boot
  board: st: common: cleanup dfu support

 arch/arm/dts/stm32mp131.dtsi                  |  52 +--
 arch/arm/dts/stm32mp135f-dk-u-boot.dtsi       |   4 +
 arch/arm/dts/stm32mp135f-dk.dts               |  68 ++--
 arch/arm/dts/stm32mp15-pinctrl.dtsi           | 364 +++++++++++++++++-
 arch/arm/dts/stm32mp15-scmi.dtsi              |   7 +-
 arch/arm/dts/stm32mp151.dtsi                  |  34 +-
 arch/arm/dts/stm32mp157.dtsi                  |  15 +-
 arch/arm/dts/stm32mp157a-dk1-scmi.dts         |   7 +-
 ...157a-microgea-stm32mp1-microdev2.0-of7.dts |   3 +
 arch/arm/dts/stm32mp157c-dk2-scmi.dts         |   7 +-
 arch/arm/dts/stm32mp157c-dk2.dts              |  30 +-
 arch/arm/dts/stm32mp157c-ed1-scmi.dts         |   7 +-
 arch/arm/dts/stm32mp157c-ed1.dts              |  24 +-
 arch/arm/dts/stm32mp157c-ev1-scmi.dts         |   7 +-
 arch/arm/dts/stm32mp157c-ev1.dts              |  34 +-
 arch/arm/dts/stm32mp15xx-dkx.dtsi             |  42 +-
 board/st/common/Makefile                      |   1 +
 board/st/common/stm32mp_dfu.c                 | 103 +----
 board/st/common/stm32mp_dfu_virt.c            |  99 +++++
 configs/stm32mp13_defconfig                   |  20 +
 include/configs/stm32mp13_common.h            |  13 +-
 include/dt-bindings/clock/stm32mp1-clks.h     |   2 +-
 include/dt-bindings/clock/stm32mp13-clks.h    |   2 +-
 .../regulator/st,stm32mp13-regulator.h        |  42 ++
 include/dt-bindings/reset/stm32mp1-resets.h   |   2 +-
 include/dt-bindings/reset/stm32mp13-resets.h  |   2 +-
 26 files changed, 725 insertions(+), 266 deletions(-)
 create mode 100644 board/st/common/stm32mp_dfu_virt.c
 create mode 100644 include/dt-bindings/regulator/st,stm32mp13-regulator.h

-- 
2.25.1

