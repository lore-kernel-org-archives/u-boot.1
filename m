Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231C4C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 13:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33A6988507;
	Mon,  6 May 2024 15:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FyvsaUFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF25688500; Mon,  6 May 2024 15:49:05 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737B288507
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 15:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 446Dmxjx024415;
 Mon, 6 May 2024 08:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715003339;
 bh=rHSFbvbx6qxwUkyfhFTee3u3eGEppvK2V9l0oWPT5wc=;
 h=From:To:CC:Subject:Date;
 b=FyvsaUFOSaPvSQakB0pvYuADM3evtdfWoQcMaRz+1mq9XfjhawENXfWFbuLoXs3sU
 nWzAYm4vVFq1tBbVPsPhaLw6TfPw9g/jlaEzagimXzWx3rLxRUmCvHWbXWJmVamDdC
 twwq6vqVAdGS/7Gi4VIbMXHLYdQjsko9aXzU0VUw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 446DmxFq017778
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 May 2024 08:48:59 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 May 2024 08:48:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 May 2024 08:48:59 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 446DmuA4003569;
 Mon, 6 May 2024 08:48:56 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <sumit.garg@linaro.org>, <n-francis@ti.com>,
 <m-chawdhry@ti.com>, <nm@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 0/1] Move j7200-evm to OF_UPSTREAM
Date: Mon, 6 May 2024 19:18:33 +0530
Message-ID: <20240506134834.353252-1-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

This patch moves the J7200 config to use the devicetree-rebasing subtree, and consequently makes
the necessary updates to the u-boot devicetree.

This patch depends on series [1] which cleans up k3 binman with some templating.

[1]: https://lore.kernel.org/u-boot/20240322131011.1029620-1-n-francis@ti.com/

Boot logs:
https://gist.github.com/aniket-l/5ae460224307ed7bf47f20488e1d3457


Aniket Limaye (1):
  arm: dts: k3-j7200: Move to OF_UPSTREAM

 arch/arm/dts/Makefile                         |    1 -
 .../k3-j7200-common-proc-board-u-boot.dtsi    |   16 +-
 arch/arm/dts/k3-j7200-common-proc-board.dts   |  396 -----
 arch/arm/dts/k3-j7200-main.dtsi               | 1284 -----------------
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         |  647 ---------
 arch/arm/dts/k3-j7200-som-p0.dtsi             |  327 -----
 arch/arm/dts/k3-j7200-thermal.dtsi            |   47 -
 arch/arm/dts/k3-j7200.dtsi                    |  164 ---
 configs/j7200_evm_a72_defconfig               |    3 +-
 9 files changed, 8 insertions(+), 2877 deletions(-)
 delete mode 100644 arch/arm/dts/k3-j7200-common-proc-board.dts
 delete mode 100644 arch/arm/dts/k3-j7200-main.dtsi
 delete mode 100644 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
 delete mode 100644 arch/arm/dts/k3-j7200-som-p0.dtsi
 delete mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi
 delete mode 100644 arch/arm/dts/k3-j7200.dtsi

-- 
2.34.1

