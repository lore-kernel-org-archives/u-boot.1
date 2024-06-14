Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02993C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6563E889DB;
	Fri, 14 Jun 2024 14:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UgQemgDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A472B889DF; Fri, 14 Jun 2024 14:44:52 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A66A889D8
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ECiiZp125643;
 Fri, 14 Jun 2024 07:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718369084;
 bh=2i03Ocg5klrmqfHO6dpvXGSbjONKfcL94OqEQi6eAFk=;
 h=From:To:CC:Subject:Date;
 b=UgQemgDD3t8gAq3ZGge1mFgQ1gJEbv6jCsYT6amA6qJ8mzC5CRWovezm+NNX8Ae4K
 zlYx/Y5czAQhpzGmtlfF9tXfJuaAAFDSpPy0gZMPcUHHlfJOuH85PNtB+YJ/k7qB19
 xSOprSVCli2CPZlplAkJLAG6zj0yphiI4ro9HqZA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ECiirK054618
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 07:44:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 07:44:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 07:44:44 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.55])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ECih7h047237;
 Fri, 14 Jun 2024 07:44:43 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <a-bhatia1@ti.com>, <afd@ti.com>, <j-choudhary@ti.com>
CC: <n-francis@ti.com>, <nm@ti.com>, <joao.goncalves@toradex.com>,
 <j-humphreys@ti.com>, <d.haller@phytec.de>, <hnagalla@ti.com>,
 <bb@ti.com>, <seanga2@gmail.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <martyn.welch@collabora.com>,
 <m-chawdhry@ti.com>, <a-limaye@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 0/8] Enable QoS for DSS on J7 family of TI SoCs
Date: Fri, 14 Jun 2024 18:14:34 +0530
Message-ID: <20240614124442.178280-1-j-choudhary@ti.com>
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

Further, to simplify the logic, macros are used to populate the value
of registers and values as suggested by Andrew[1]

Before adding QoS support, we need to map the ORDERID to the traffic
type (RT/NRT) in J7 platforms.
On J721E, ORDERID 0-7 and 8-15 are two groups which needs to be mapped.
We are mapping 0-7 to NRT and 8-15 ORDERID as RT for both NAVSS0_NBSS_NB0
and NAVSS0_NBSS_NB1
On J721S2 and J784S4, we have 3 groups, 0-3, 4-9, 10-15. Here we are
mapping first two groups as NRT and 10-15 as RT for both NAVSS0_NBSS_NB0
and NAVSS0_NBSS_NB1.

Changelog v1->v2:
- Simplify the logic to populate values[1]
- Remove ASEL type which is to be taken up separately as suggested in [2]

v1 patch link:
<https://patchwork.ozlabs.org/project/uboot/list/?series=407729&state=%2A&archive=both>

[0]: https://lore.kernel.org/all/20230414072725.8802-1-a-bhatia1@ti.com/
[1]: https://patchwork.ozlabs.org/project/uboot/patch/20240522113726.302908-2-j-choudhary@ti.com/#3315446
[2]: https://patchwork.ozlabs.org/project/uboot/patch/20240522113726.302908-3-j-choudhary@ti.com/#3315467


Jayesh Choudhary (8):
  arm: mach-k3: am62a_qos: Move common bit MACROS to k3_qos header file
  arm: mach-k3: am62a: Simplify the logic for QOS reg and val
    propagation
  arm: mach-k3: j721e: Enable QoS for DSS
  arm: mach-k3: j721s2: Enable QoS for DSS
  arm: mach-k3: j784s4: Enable QoS for DSS
  configs: j721e_evm_r5_defconfig: Enable CONFIG_K3_QOS
  configs: j721s2_evm_r5_defconfig: Enable CONFIG_K3_QOS
  configs: j784s4_evm_r5_defconfig: Enable CONFIG_K3_QOS

 arch/arm/mach-k3/include/mach/k3-qos.h        |  20 +++
 arch/arm/mach-k3/j721e/j721e_init.c           |  28 ++++
 arch/arm/mach-k3/j721s2/j721s2_init.c         |  30 +++++
 arch/arm/mach-k3/j784s4/j784s4_init.c         |  30 +++++
 arch/arm/mach-k3/r5/am62ax/am62a_qos.h        |  74 ----------
 arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c  |  24 ++--
 arch/arm/mach-k3/r5/j721e/Makefile            |   1 +
 arch/arm/mach-k3/r5/j721e/j721e_qos.h         |  96 +++++++++++++
 arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c   | 126 ++++++++++++++++++
 arch/arm/mach-k3/r5/j721s2/Makefile           |   1 +
 arch/arm/mach-k3/r5/j721s2/j721s2_qos.h       |  79 +++++++++++
 arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c | 110 +++++++++++++++
 arch/arm/mach-k3/r5/j784s4/Makefile           |   1 +
 arch/arm/mach-k3/r5/j784s4/j784s4_qos.h       |  83 ++++++++++++
 arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c | 110 +++++++++++++++
 configs/j721e_evm_r5_defconfig                |   1 +
 configs/j721s2_evm_r5_defconfig               |   1 +
 configs/j784s4_evm_r5_defconfig               |   1 +
 18 files changed, 730 insertions(+), 86 deletions(-)
 create mode 100644 arch/arm/mach-k3/r5/j721e/j721e_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c
 create mode 100644 arch/arm/mach-k3/r5/j721s2/j721s2_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j721s2/j721s2_qos_uboot.c
 create mode 100644 arch/arm/mach-k3/r5/j784s4/j784s4_qos.h
 create mode 100644 arch/arm/mach-k3/r5/j784s4/j784s4_qos_uboot.c

-- 
2.25.1

