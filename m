Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CC0C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 11:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2382D88736;
	Wed, 22 May 2024 13:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sNOjzViT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F30888736; Wed, 22 May 2024 13:37:36 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3EE8845C
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 13:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MBbTf0099672;
 Wed, 22 May 2024 06:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716377849;
 bh=h1f3nL/UeRULbVzMv9wMMMwSaq4VZEic5nejC7fSlZk=;
 h=From:To:CC:Subject:Date;
 b=sNOjzViTCJqumvcgbUqvoguI4UXBLNCCyqR64UDJbZxD12HXxFyCiFavRljhBphIm
 wGKe6g+ZDaub5/lZRafyqzs7iCUdybdG8L8EShJSaw8Pvb5uadsB3NFmNTZo100ALw
 lGLOYQpgi9ux+6b8bMK8Q8I3eV5vHK7KYXGAOm4o=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MBbTSV119525
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 06:37:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 06:37:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 06:37:28 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.6])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MBbR3l078399;
 Wed, 22 May 2024 06:37:28 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <j-choudhary@ti.com>
CC: <a-bhatia1@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <joao.goncalves@toradex.com>, <afd@ti.com>, <j-humphreys@ti.com>,
 <d.haller@phytec.de>, <hnagalla@ti.com>, <bb@ti.com>,
 <seanga2@gmail.com>, <sjg@chromium.org>, <clamor95@gmail.com>,
 <martyn.welch@collabora.com>, <m-chawdhry@ti.com>, <a-limaye@ti.com>
Subject: [PATCH 0/7] Enable QoS for DSS on J7 family of TI SoCs
Date: Wed, 22 May 2024 17:07:19 +0530
Message-ID: <20240522113726.302908-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
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

Hello All,
This series adds the QoS for DSS on J721E, J721S2 and J784S4 family of
SoCs.

Before adding the support, cleanup is done for AM62A QoS support[0]
and common bit mask defines are moved to the common file so that they
are not defined every time we add QoS support for a new K3 platform.

Before adding QoS support, we need to map the ORDERID to the traffic
type (RT/NRT).
On J721E, ORDERID 0-7 and 8-15 are two groups which needs to be mapped.
We are mapping 0-7 to NRT and 8-15 ORDERID as RT for both NAVSS0_NBSS_NB0
and NAVSS0_NBSS_NB1
On J721S2 and J784S4, we have 3 groups, 0-3, 4-9, 10-15. Here we are
mapping first two groups as NRT and 10-15 as RT for both NAVSS0_NBSS_NB0
and NAVSS0_NBSS_NB1.

[0]: https://lore.kernel.org/all/20230414072725.8802-1-a-bhatia1@ti.com/

Jayesh Choudhary (7):
  arm: mach-k3: am62a_qos: Move common bit MACROS to k3_qos header file
  arm: mach-k3: j721e: Enable QoS for DSS
  arm: mach-k3: j721s2: Enable QoS for DSS
  arm: mach-k3: j784s4: Enable QoS for DSS
  configs: j721e_evm_r5_defconfig: Enable CONFIG_K3_QOS
  configs: j721s2_evm_r5_defconfig: Enable CONFIG_K3_QOS
  configs: j784s4_evm_r5_defconfig: Enable CONFIG_K3_QOS

 arch/arm/mach-k3/include/mach/k3-qos.h        |  74 +++++++++++
 arch/arm/mach-k3/j721e/j721e_init.c           |  28 ++++
 arch/arm/mach-k3/j721s2/j721s2_init.c         |  30 +++++
 arch/arm/mach-k3/j784s4/j784s4_init.c         |  30 +++++
 arch/arm/mach-k3/r5/am62ax/am62a_qos.h        |  74 -----------
 arch/arm/mach-k3/r5/j721e/Makefile            |   1 +
 arch/arm/mach-k3/r5/j721e/j721e_qos.h         |  96 ++++++++++++++
 arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c   | 125 ++++++++++++++++++
 arch/arm/mach-k3/r5/j721s2/Makefile           |   1 +
 arch/arm/mach-k3/r5/j721s2/j721s2_qos.h       |  79 +++++++++++
 arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c | 109 +++++++++++++++
 arch/arm/mach-k3/r5/j784s4/Makefile           |   1 +
 arch/arm/mach-k3/r5/j784s4/j784s4_qos.h       |  83 ++++++++++++
 arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c | 109 +++++++++++++++
 configs/j721e_evm_r5_defconfig                |   1 +
 configs/j721s2_evm_r5_defconfig               |   1 +
 configs/j784s4_evm_r5_defconfig               |   1 +
 17 files changed, 769 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm/mach-k3/r5/j721e/j721e_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c
 create mode 100644 arch/arm/mach-k3/r5/j721s2/j721s2_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c
 create mode 100644 arch/arm/mach-k3/r5/j784s4/j784s4_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c

-- 
2.25.1

