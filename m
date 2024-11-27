Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41667D6ACE4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 14:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2B6895E2;
	Wed, 27 Nov 2024 15:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KB2xJ4Y8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE8F8895E2; Wed, 27 Nov 2024 15:53:56 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED172895A0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 15:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ARErpEd075092;
 Wed, 27 Nov 2024 08:53:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732719232;
 bh=CxLzryrAdSmcFm5lQjOwi5kRPKodMOHAR/DOf4JITzI=;
 h=From:To:CC:Subject:Date;
 b=KB2xJ4Y8Uf0/LVY/32C1V2vFdtjjnV3MVmphHRdgCPCy2qfFs1wEmcGFLZhj1PsTl
 j205ZCaWbBLb2bvw9FP/84SfMAKmVhNeDFLvQCb8tZEMUOax6fZtv2AYC+q9f979wF
 kbNguWo7MJBfM0seEpeDa5zECzZ/zuZPux/IuXOg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ARErpbx056234
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Nov 2024 08:53:51 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 08:53:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 08:53:51 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ARErlpC051687;
 Wed, 27 Nov 2024 08:53:48 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/4] Add support for K3 BIST
Date: Wed, 27 Nov 2024 20:23:42 +0530
Message-ID: <20241127145346.2609868-1-n-francis@ti.com>
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

An RFC was posted earlier with an incomplete version of the driver along
with a bug as mentioned in the cover-letter. The workaround to this was
to trigger the BIST tests from A72 SPL where the DM (Device Manager
firmware that handles power management) is already up and can perform
the power sequences for us.

Boot logs (with LOG_DEBUG enabled):
https://gist.github.com/nehamalcom/b6831be41b35023be33c566e6d2e4820

Link to RFC:
https://patchwork.ozlabs.org/project/uboot/cover/20240903114402.2155740-1-n-francis@ti.com

[1] https://software-dl.ti.com/jacinto7/esd/processor-sdk-rtos-jacinto7/latest/exports/docs/sdl/sdl_docs/userguide/j721e/modules/pbist.html#introduction
[2] https://software-dl.ti.com/jacinto7/esd/processor-sdk-rtos-jacinto7/latest/exports/docs/sdl/sdl_docs/userguide/j721e/modules/lbist.html#introduction

Neha Malcom Francis (4):
  arm: dts: k3-j784s4-main: Add PBIST_14 node
  drivers: misc: k3_bist: Add K3 BIST driver
  configs: j784s4_evm_a72_defconfig: Enable BIST
  DONOTMERGE: arm: mach-k3: j784s4_init: Trigger LBIST and PBIST on MAIN
    R5 2_0

 arch/arm/mach-k3/j784s4/j784s4_init.c         |  48 +
 configs/j784s4_evm_a72_defconfig              |   1 +
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/k3_bist.c                        | 856 ++++++++++++++++++
 drivers/misc/k3_bist_static_data.h            | 576 ++++++++++++
 drivers/misc/k3_lbist_static_data.h           | 460 ++++++++++
 dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi |  12 +
 include/k3_bist.h                             |  44 +
 9 files changed, 2006 insertions(+)
 create mode 100644 drivers/misc/k3_bist.c
 create mode 100644 drivers/misc/k3_bist_static_data.h
 create mode 100644 drivers/misc/k3_lbist_static_data.h
 create mode 100644 include/k3_bist.h

-- 
2.34.1

