Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95B5C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 13:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AAD3881BE;
	Fri, 22 Mar 2024 14:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U23dKn43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C761881A9; Fri, 22 Mar 2024 14:10:30 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9967D881AC
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 14:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42MDAHNV004770;
 Fri, 22 Mar 2024 08:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711113017;
 bh=HoR0cvEOloUhGi5rgNeSOYKW5HhzpeuaL9LLPL3Xt4Y=;
 h=From:To:CC:Subject:Date;
 b=U23dKn43/cDFNusNfA6edx6/A70IaNWLuk5BkpykQCvura2azwbqEl/x9RYSQuCNQ
 kOjhfgnyorQWwkYpVEHEYaRyNQqEI9BoaMer3kgNiHJpIsK6Fxc2N/j2oO8zq+VUmG
 WRv2O0dUWrVlfQRwzc26BU26SuzDNGEVe7+dtQEo=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42MDAH4h005484
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Mar 2024 08:10:17 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Mar 2024 08:10:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Mar 2024 08:10:16 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42MDABZ7026606;
 Fri, 22 Mar 2024 08:10:12 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 0/4] Cleanup K3 binman templating
Date: Fri, 22 Mar 2024 18:40:07 +0530
Message-ID: <20240322131011.1029620-1-n-francis@ti.com>
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
	   discussion [1] and this is the primary goal of this series
	3. Move J721E EVM and SK to using OF_UPSTREAM

This series depends on series [2] and patch [3] which implement
OF_UPSTREAM.

Also received input from Nishanth to clean up the unnecessary artifacts
in the final build directory (maybe populate them in another directory),
working on that as well but didn't want to delay v1 further considering
I'm modifying a bunch of board builds and would like some friendly build
tests and boot tests for them.

[1] https://lore.kernel.org/u-boot/20240123205255.i7eynu6vdpoxwybf@irregular/
[2] https://lore.kernel.org/u-boot/20240222093607.3085545-1-sumit.garg@linaro.org/
[3] https://lore.kernel.org/u-boot/20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com/

Changes since RFC:
https://lore.kernel.org/all/20240228112042.3437691-1-n-francis@ti.com/
	- cleaned out FDT descriptions and blobs using macros (Manorit)
	- modified J721E defconfigs to include missed out configs
	  (Andrew)

Boot logs:
https://gist.github.com/nehamalcom/07dc7f95173f0bb67a8a26a6b3ab2b00

Neha Malcom Francis (4):
  configs: j721e_sk: Move to separate defconfig for J721E SK board
  tools: binman: control.py: Delete template nodes after parsing
  arm: dts: k3-*-binman.dtsi: Clean up and templatize boot binaries
  arm: dts: k3-j721e: Move to OF_UPSTREAM

 arch/arm/dts/Makefile                         |    4 +-
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  161 +-
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |  291 +-
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |   39 -
 arch/arm/dts/k3-am625-sk-binman.dtsi          |  148 +-
 arch/arm/dts/k3-am625-sk-u-boot.dtsi          |   42 +
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  |  296 +-
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  146 +-
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi         |   42 +
 arch/arm/dts/k3-am642-evm-u-boot.dtsi         |   42 +
 arch/arm/dts/k3-am642-sk-u-boot.dtsi          |   42 +
 arch/arm/dts/k3-am64x-binman.dtsi             |  239 +-
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi  |   49 +
 arch/arm/dts/k3-am65x-binman.dtsi             |  144 +-
 .../arm/dts/k3-am68-sk-base-board-u-boot.dtsi |   26 +
 arch/arm/dts/k3-am69-sk-u-boot.dtsi           |   31 +-
 arch/arm/dts/k3-binman.dtsi                   |   96 +
 arch/arm/dts/k3-j7200-binman.dtsi             |  145 +-
 .../k3-j7200-common-proc-board-u-boot.dtsi    |   40 +
 .../dts/k3-j721e-beagleboneai64-u-boot.dtsi   |  154 +-
 arch/arm/dts/k3-j721e-binman.dtsi             |  262 +-
 .../k3-j721e-common-proc-board-u-boot.dtsi    |   84 +
 arch/arm/dts/k3-j721e-common-proc-board.dts   |  976 ------
 arch/arm/dts/k3-j721e-main.dtsi               | 2741 -----------------
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  681 ----
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |   91 +-
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |   84 +
 arch/arm/dts/k3-j721e-sk.dts                  | 1074 -------
 arch/arm/dts/k3-j721e-som-p0.dtsi             |  446 ---
 arch/arm/dts/k3-j721e-thermal.dtsi            |   75 -
 arch/arm/dts/k3-j721e.dtsi                    |  176 --
 arch/arm/dts/k3-j721s2-binman.dtsi            |  231 +-
 .../k3-j721s2-common-proc-board-u-boot.dtsi   |   42 +
 arch/arm/dts/k3-j784s4-binman.dtsi            |  154 +-
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi        |   42 +
 board/ti/j721e/MAINTAINERS                    |    2 +
 configs/j721e_evm_a72_defconfig               |    5 +-
 configs/j721e_evm_r5_defconfig                |    2 +-
 configs/j721e_sk_a72_defconfig                |    9 +
 configs/j721e_sk_r5_defconfig                 |   10 +
 tools/binman/control.py                       |    6 +-
 41 files changed, 889 insertions(+), 8481 deletions(-)
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

