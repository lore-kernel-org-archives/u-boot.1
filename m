Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4A0E64016
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 21:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD6B89763;
	Thu, 21 Nov 2024 22:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l2tuy901";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A99389372; Thu, 21 Nov 2024 22:18:02 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3568C89330
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 22:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ALLHtLt065665;
 Thu, 21 Nov 2024 15:17:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732223875;
 bh=z6r3KH0FzY0WIKr7vFlpLrMS6CBIoUFq31ccZZ1YPUo=;
 h=From:Subject:Date:To:CC;
 b=l2tuy9015pgVdBabH1RbW3R9H7OA6abeYyz9DEyrq/CgQc0YF2wjw9on+ZZQfmjle
 q//CjQKaYwdiAacHAuYWFDQ0TlB3sFv8GBAseKRbdBSU2kbPwk2B3v1uSeo4+iD7k7
 2gAm6vz25D975MojvmSjSxHPJR7Y+WRzNgeGf13E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ALLHtcp097396
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Nov 2024 15:17:55 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Nov 2024 15:17:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Nov 2024 15:17:55 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ALLHt22129111;
 Thu, 21 Nov 2024 15:17:55 -0600
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/3] board: ti: k3-am65: covert last board to OF_UPSTREAM
Date: Thu, 21 Nov 2024 15:17:48 -0600
Message-ID: <20241121-am65x-v1-0-fe87aff1b5fc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHyjP2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0ML3cRcM9MK3dQUk8Qkc5OUJBPDFCWg2oKi1LTMCrA50bG1tQA/3L7
 RVwAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Baocheng Su
 <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, Bryan
 Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello Everyone!

This small series converts TI's AM65x reference board to use 
CONFIG_OF_UPSTREAM and removes the unused device tree files from 
arch/arm/dts. 

Because it's the last board using a AM65x without enabling OF_UPSTREAM 
it allows us to also remove all the SoC FDT files as well and keep a 
single version of the SoC's DT files in the dts/upstream directory going 
forward.

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (3):
      board: ti: am65x: migrate to OF_UPSTREAM
      arm: dts: k3-am654: cleanup unused board files
      arm: dts: k3-am65: remove unsused am65x SoC fdt files

 arch/arm/dts/Makefile                         |    4 +-
 arch/arm/dts/k3-am65-main.dtsi                | 1568 -------------------------
 arch/arm/dts/k3-am65-mcu.dtsi                 |  440 -------
 arch/arm/dts/k3-am65-wakeup.dtsi              |  105 --
 arch/arm/dts/k3-am65.dtsi                     |  110 --
 arch/arm/dts/k3-am654-base-board.dts          |  630 ----------
 arch/arm/dts/k3-am654-icssg2.dtso             |  145 ---
 arch/arm/dts/k3-am654-industrial-thermal.dtsi |   45 -
 arch/arm/dts/k3-am654.dtsi                    |  122 --
 arch/arm/dts/k3-am65x-binman.dtsi             |    4 +-
 arch/arm/mach-k3/am65x/Kconfig                |    1 +
 configs/am65x_evm_a53_defconfig               |    3 +-
 12 files changed, 6 insertions(+), 3171 deletions(-)
---
base-commit: 7fe55182d9263a62e18b450c97bdf0b8031e5667
change-id: 20241118-am65x-ed4ab74db41d

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

