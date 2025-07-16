Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8818C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 06:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10DC083164;
	Wed, 16 Jul 2025 08:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="irbCjbJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E96118315B; Wed, 16 Jul 2025 08:22:06 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D058A8313B
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 08:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G6M2XR185235;
 Wed, 16 Jul 2025 01:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752646922;
 bh=ytjAHQWH8bBiy51MigNyzYc3EzhVpo6SZt3dB9Tw/XE=;
 h=From:To:CC:Subject:Date;
 b=irbCjbJ+PwFNG94NUr5pkc684XnQqj5hwwcdln3FtFjG/Zk/92h3yTzkPDfZkbECM
 4pFIdQfqn9k54PdAks/UW4gWBwuz+VTESV3XL0zgdwuzu5WLoDsiB23WcQXBOedUIV
 ztvSc6Ed6EiKekWdHBhyHBaz6OdY1g1bFTOHcW2o=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G6M25C1804703
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 16 Jul 2025 01:22:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 01:22:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 01:22:01 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G6Lvk94174146;
 Wed, 16 Jul 2025 01:21:57 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v4 RESEND 0/2] Add support for K3 BIST
Date: Wed, 16 Jul 2025 11:51:54 +0530
Message-ID: <20250716062156.2564297-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This series implements a driver for the BIST (Built-In Self Test) module
for K3 devices. The BIST driver must ideally support triggering of BIST
tests, both PBIST (Memory BIST) and LBIST (Logic BIST) on a core. Both
tests are destructive in nature. Please see links [1] and [2] for
further information regarding the two.

At boot up, BIST is executed by hardware for the MCU domain
automatically as part of HW POST. So BIST has been checked only for the
MCU domain when U-Boot comes up in the usual U-Boot to Linux boot flow.
To facilitate the use-case where some safe firmware is intended to be
run on a safe core, it is best to have triggered the BIST tests on that
core. As an example, we take triggering the BIST tests on the MAIN R52_x
cores. The triggering patch is kept as DONOTMERGE.

The general procedure for triggering BIST on a core is:
	1. Power on the core under test following a sequence
	2. Trigger the BIST test
	3. Reset the core under test following a sequence

BIST tests are triggered from A72 SPL where the DM (Device Manager
firmware that handles power management) is already up and can perform
these power sequences for us.

Boot logs (with LOG_DEBUG and CONFIG_K3_BIST enabled) and DT node kept (already
merged to ti-k3-dts-next [3]):
https://gist.github.com/nehamalcom/3fed504d038b54e3e05ba3874d73d603

Changes since v4 (resent):
--------------------------
https://lore.kernel.org/all/20250609102706.2434495-2-n-francis@ti.com/
- rebased on master
- removed DONOTMERGE DT patch

Changes since v3:
-----------------
https://lore.kernel.org/all/20250328123127.497971-1-n-francis@ti.com/
- Krzysztof (from dt-binding mailing list)
    - use existing common definition (ti,sci-dev-id) from grabbing
      the device ID instead of a new property
- Udit
    - add support for J742S2
- changes from v2 as well since v3 was kept on hold for ack on
  dt-binding first
- modified small code of LBIST MISR check to grab expected value of MISR
  from the appropriate register instead of hard coding the value

Changes since v2:
-----------------
https://lore.kernel.org/all/20250204123147.939917-1-n-francis@ti.com/
- Udit
    - code cleanup and minor optimizations
    - reorder patch with DONOTMERGE at the end
- Manorit
    - move MCU4_O BIST code into a separate function

Changes since v1:
-----------------
https://lore.kernel.org/all/20241127145346.2609868-1-n-francis@ti.com/
- Udit
	- alignment and macro naming corrections
	- move debug prints to printf for errors
	- split to separate SoC BIST header file
	- drop enabling CONFIG_K3_BIST by default (patch 3/4)
	- unmark triggering of BIST as a DONOTMERGE patch

RFC:
----
https://lore.kernel.org/all/20240903114402.2155740-1-n-francis@ti.com/

[1] https://software-dl.ti.com/jacinto7/esd/processor-sdk-rtos-jacinto7/latest/exports/docs/sdl/sdl_docs/userguide/j721e/modules/pbist.html#introduction
[2] https://software-dl.ti.com/jacinto7/esd/processor-sdk-rtos-jacinto7/latest/exports/docs/sdl/sdl_docs/userguide/j721e/modules/lbist.html#introduction
[3] https://lore.kernel.org/all/175205725858.918402.3771835070085533874.b4-ty@ti.com/

Neha Malcom Francis (2):
  drivers: misc: k3_bist: Add K3 BIST driver
  arm: mach-k3: j784s4_init: Trigger LBIST and PBIST on MAIN R5 2_0

 arch/arm/mach-k3/j784s4/j784s4_init.c     |  52 ++
 drivers/misc/Kconfig                      |   8 +
 drivers/misc/Makefile                     |   1 +
 drivers/misc/k3_bist.c                    | 807 ++++++++++++++++++++++
 drivers/misc/k3_bist_static_data.h        | 673 ++++++++++++++++++
 drivers/misc/k3_j784s4_bist_static_data.h | 370 ++++++++++
 include/k3_bist.h                         |  44 ++
 7 files changed, 1955 insertions(+)
 create mode 100644 drivers/misc/k3_bist.c
 create mode 100644 drivers/misc/k3_bist_static_data.h
 create mode 100644 drivers/misc/k3_j784s4_bist_static_data.h
 create mode 100644 include/k3_bist.h

-- 
2.34.1

