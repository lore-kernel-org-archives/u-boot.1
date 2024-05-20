Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632ECC04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 09:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B5B886A8;
	Mon, 20 May 2024 11:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U1Sd6Ocn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633D5882F1; Mon, 20 May 2024 11:59:34 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5F2886A7
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 11:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44K9xM70091599;
 Mon, 20 May 2024 04:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716199162;
 bh=1LiX03ApXzuI4SrNtl55XhIt855Xu97Ozj43nsHmzeg=;
 h=From:To:CC:Subject:Date;
 b=U1Sd6Ocnv1bRzzwNJXqoSqXIpZLWbBWoe3OFn1U4MCSqQqJ68KCUYqEstXrLLGu6L
 krFCPJ6aLPkLz6cHZK4GkJxoz8PzuXcLaPZDCuUp4c7AYCqAKIQ9SpqfStsi1qnKAT
 g+/boQwmZxKBdPndLVZyR3xRN4tIVRbz4oJ5jtFM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44K9xMt4012829
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 20 May 2024 04:59:22 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 04:59:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 04:59:22 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44K9xHHf047124;
 Mon, 20 May 2024 04:59:17 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <bb@ti.com>, <nm@ti.com>,
 <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <afd@ti.com>, <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 0/3] k3-j721e: Enable OF_UPSTREAM for J721E
Date: Mon, 20 May 2024 15:29:13 +0530
Message-ID: <20240520095916.1809962-1-n-francis@ti.com>
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

This series was plucked out from the larger series [1] that did some
templating reformatting and also enabled OF_UPSTREAM for J721E. The
former has been kept aside till all the platforms affected have moved to
using OF_UPSTREAM to have less conflicts while merging.

Patches split J721E EVM and J721E SK to using separate builds, as well
as enable OF_UPSTREAM for both the platforms.

Boot logs:
https://gist.github.com/nehamalcom/8f326376b6c6b1196084721405159bb9

[1] https://lore.kernel.org/all/20240322131011.1029620-1-n-francis@ti.com/

Neha Malcom Francis (3):
  arm: dts: k3-j721e-r5*: Introduce k3-j721e-r5.dtsi
  configs: j721e_sk: Move to separate defconfig for J721E SK board
  arm: dts: k3-j721e: Move to OF_UPSTREAM

 arch/arm/dts/Makefile                         |    4 +-
 arch/arm/dts/k3-j721e-binman.dtsi             |  101 +-
 .../k3-j721e-common-proc-board-u-boot.dtsi    |   14 +-
 arch/arm/dts/k3-j721e-common-proc-board.dts   |  976 ------
 arch/arm/dts/k3-j721e-main.dtsi               | 2741 -----------------
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         |  681 ----
 arch/arm/dts/k3-j721e-r5-beagleboneai64.dts   |   78 +-
 .../arm/dts/k3-j721e-r5-common-proc-board.dts |   75 +-
 arch/arm/dts/k3-j721e-r5-sk.dts               |   75 +-
 arch/arm/dts/k3-j721e-r5.dtsi                 |   80 +
 arch/arm/dts/k3-j721e-sk-u-boot.dtsi          |   41 +-
 arch/arm/dts/k3-j721e-sk.dts                  | 1074 -------
 arch/arm/dts/k3-j721e-som-p0.dtsi             |  446 ---
 arch/arm/dts/k3-j721e-thermal.dtsi            |   75 -
 arch/arm/dts/k3-j721e.dtsi                    |  176 --
 board/ti/j721e/MAINTAINERS                    |    2 +
 configs/j721e_evm_a72_defconfig               |    5 +-
 configs/j721e_evm_r5_defconfig                |    2 +-
 configs/j721e_sk_a72_defconfig                |    9 +
 configs/j721e_sk_r5_defconfig                 |   10 +
 20 files changed, 147 insertions(+), 6518 deletions(-)
 delete mode 100644 arch/arm/dts/k3-j721e-common-proc-board.dts
 delete mode 100644 arch/arm/dts/k3-j721e-main.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
 create mode 100644 arch/arm/dts/k3-j721e-r5.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-sk.dts
 delete mode 100644 arch/arm/dts/k3-j721e-som-p0.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi
 delete mode 100644 arch/arm/dts/k3-j721e.dtsi
 create mode 100644 configs/j721e_sk_a72_defconfig
 create mode 100644 configs/j721e_sk_r5_defconfig

-- 
2.34.1

