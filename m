Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CBEC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 11:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB04988048;
	Wed, 28 Feb 2024 12:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GC6StMPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4341787F95; Wed, 28 Feb 2024 12:20:58 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B28087FEB
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 12:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SBKlZf005771;
 Wed, 28 Feb 2024 05:20:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709119247;
 bh=DQxABsF0QZyLt4qvlwaWrsdyFD/8ZHEcroO+cQCxP3c=;
 h=From:To:CC:Subject:Date;
 b=GC6StMPCgWGLRpT3BguLf6nlEO1poVVJG9VEuukKAFM4z6EimC8Q2hw75Hwgf9a6k
 8xN75Gvl3d7MhhFaeVQMA40Nh3R8AjTwx6Ig8iS9q2jIQ0hfoD8Oz+rh22iiaVo2Yu
 Vkw5+Jcd/Pjqtxf98//Orf6ZME+X+YaY6QysQfYQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SBKlLI014500
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 05:20:47 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 05:20:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 05:20:47 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SBKgNf027918;
 Wed, 28 Feb 2024 05:20:43 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [RFC PATCH 0/4] Cleanup J721E EVM and SK
Date: Wed, 28 Feb 2024 16:50:38 +0530
Message-ID: <20240228112042.3437691-1-n-francis@ti.com>
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

This series does primarily three things:
	1. Split out the common J721E defconfig for both EVM and SK
	2. Cleanup k3-j721e-binman.dtsi to be SoC specific binman nodes
	   and -u-boot.dtsi files of the respective boards can pick and
	   edit according to their board. This is based on the
	   discussion [1]
	3. Move J721E EVM and SK to using OF_UPSTREAM

This series depends on series [2] and patch [3] which implement
OF_UPSTREAM. Hopefully we get an idea of whether this is what we want to
see across all K3 SoCs by the next release.

[1] https://lore.kernel.org/u-boot/20240123205255.i7eynu6vdpoxwybf@irregular/
[2] https://lore.kernel.org/u-boot/20240222093607.3085545-1-sumit.garg@linaro.org/
[3] https://lore.kernel.org/u-boot/20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com/

Boot logs:
https://gist.github.com/nehamalcom/3b578dfa1ef83b59f3c309557606ed63

Neha Malcom Francis (4):
  configs: j721e_sk: Move to separate defconfig for J721E SK board
  tools: binman: control.py: Delete template nodes after parsing
  arm: dts: k3-j721e: Separate boot binary build
  arm: dts: k3-j721e: Move to OF_UPSTREAM

 arch/arm/dts/Makefile                         |    4 +-
 arch/arm/dts/k3-j721e-binman.dtsi             |  178 +-
 .../k3-j721e-common-proc-board-u-boot.dtsi    |  138 +
 arch/arm/dts/k3-j721e-common-proc-board.dts   |  976 ------
 arch/arm/dts/k3-j721e-main.dtsi               | 2741 -----------------
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  681 ----
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |  104 +
 arch/arm/dts/k3-j721e-sk.dts                  | 1074 -------
 arch/arm/dts/k3-j721e-som-p0.dtsi             |  446 ---
 arch/arm/dts/k3-j721e-thermal.dtsi            |   75 -
 arch/arm/dts/k3-j721e.dtsi                    |  176 --
 board/ti/j721e/MAINTAINERS                    |    2 +
 configs/j721e_evm_a72_defconfig               |    5 +-
 configs/j721e_evm_r5_defconfig                |    2 +-
 configs/j721e_sk_a72_defconfig                |    4 +
 configs/j721e_sk_r5_defconfig                 |    5 +
 tools/binman/control.py                       |    6 +-
 17 files changed, 305 insertions(+), 6312 deletions(-)
 delete mode 100644 arch/arm/dts/k3-j721e-common-proc-board.dts
 delete mode 100644 arch/arm/dts/k3-j721e-main.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-sk.dts
 delete mode 100644 arch/arm/dts/k3-j721e-som-p0.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e.dtsi
 create mode 100644 configs/j721e_sk_a72_defconfig
 create mode 100644 configs/j721e_sk_r5_defconfig

-- 
2.34.1

